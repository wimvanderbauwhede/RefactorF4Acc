# REMAINING ISSUES : Memory Reduction for Scientific Computing on GPUs

## Integration of the scalarised code

This is now done except that I need to modularise it and create a main program 

I think I should test this with an example where I calculate a derivative of the normalised value of a property.

so v-mean(v) stenciled at -1 and +1; for the edge points we have halo. First I do this 1-D, then 2-D, then I do it again in actual Fortran


            subroutine calc_mean(acc_in,v_in,acc_out)
                  acc_out = acc_in+v_in/v_sz
            end subroutine calc_mean

            subroutine calc_norm(mean_v,v_in,v_out)
                  v_out = v_in-mean_v
            end subroutine calc_norm

            subroutine calc_deriv(v_in_1,v_in_2, v_out)
                  v_out = (v_in_2 - v_in_1)/2
            end subroutine calc_deriv


            v_mean = fold calc_mean 0 v
            v_norm = map (calc_norm v_mean) v
            s = [-1,1]
            v_norm_s = stencil s v_norm
            v_norm_deriv = map calc_deriv v_norm_s

            subroutine calc_norm_deriv(v, v_norm_deriv)
                  implicit none
                  real, dimension(VSZ), intent(in) :: v
                  real, dimension(VSZ), intent(out) :: v_norm_deriv
                  real, dimension(VSZ) :: v_norm
                  real :: mean_v
                  integer :: idx
                  mean_v=0
                  do idx=1,VSZ                  
                        mean_v = mean_v+v_in(idx)/VSZ
                  end so

                  do idx=1,VSZ                        
                        v_norm(idx) = v_in(idx)-mean_v
                  end do

                  do idx=1,VSZ                        
                        v_norm(idx) = v_in(idx)-mean_v
                  end do

                  do idx=1,VSZ
                        if (idx==1) then
                              v_norm_deriv(idx) = (v_norm(idx) -v_normn(idx+1)/2
                        elsif (idx==VSZ) then
                              v_norm_deriv(idx) = (v_norm(idx-1) -v_normn(idx)/2
                        else
                              v_norm_deriv(idx) = (v_norm(idx-1) -v_normn(idx+1)/2
                        end if
                  end do

            end subroutine calc_norm_deriv

The final program is something simple like

program main
      implicit none
      real, dimension(VSZ) :: v
      real, dimension(VSZ) :: v_norm_deriv            
      integer :: idx

      ! populate v 
      do idx=1,VSZ
            v(i) = 1+2*idx+idx*idx
      end do

      ! run the calculation
      do idx=1,VSZ
            call stage_kernel_1()
      end do
end program main


## Avoiding double-buffering 

The current approach creates an in and out array for every inout array. The typical problem is that a stencil would use the updated value rather than the old value. But the actual problem is that even if the program used double buffering, then both buffers are turned into two buffers. So I think I should go through the code and identify the following pattern:

            un = f(u)
            u = g(un)

In this case, both u an un are inout but we only need one of them, and it does not really matter which one. So we pick the first read on, i.e. u, and we replace un with u in SSA fashion

How do we find this out? we do per function a deps list for all output vars. This should tell us that un depends on u in f, and u depends on un in g. Then we do a global analysis

      subroutine f(u,un)
            un = f'(u)
      end
      subroutine g(un,u)
            u = g'(un)
      end

      subroutine kernel(u1,un1)
            call f(u1, un1)
            call g(un1, u1)
      end            

un1 is out for f and in for g, so to un1's deps in g I add un1's deps from f, i.e. u. 
u in g depends on un which depends on u in f, so that we have u1 dependingon u1. In short, I think the solution is to say that un must be a local array. I think that should automatically lead to its being eliminated.

That is the key problem: intermediate arrays should not be in, out or inout, but local. But only the scientist can tell which are real ins and outs.

## OpenCLC: Passing array slices and returning scalars into array elements

- We use array slices and also return scalar values into array elements, see

      {test_return_to_array_elt,test_pass_array_slice},{f90,c}

for the conversions, need to add this to

      RefactorF4Acc::Translation::OpenCLC

## The stencil currently is defined for non-constant accesses only, I could generalise this using the algorithm in

      /Users/wim/Desktop/FortranRefactoring/2018-10-30-stencil-algo.txt

## How to deal with iteration?

      (read_only_vs, iter_vs) = map f v_ins
      iter_vs' = iterate test calc_iter read_only_vs iter_vs
      v_out = map f (read_only_vs, iter_vs')

It seems clear that the `iterate`  call must become one or more stages; there is no reason to do this on the device, so we can probably keep the original code.

Essentially, for the SOR we have

      p_s = stencil s1 p
      p = map sor (zipt (p_s,rhs))

and it's a single map so no particular actions

## LES in TyTraCL?

In `/Users/wim/SoC_Research/TyTra/tytra/Type-Transformations-FPGA/TyTraHLL` we have

`/Users/wim/SoC_Research/TyTra/tytra/Type-Transformations-FPGA/TyTraHLL/TytraHLL-LES.hs`

These are Haskell sketches. What I need is a proper TyTraCL version based on the GPU version.
If I would ignore the boundaries, it might be possible ...
