# REMAINING ISSUES : Memory Reduction for Scientific Computing on GPUs

## Generate Fortran from the original TyTraCL

Although this might seem obvious, it breaks due to several reasons. 

            call f1(v_0(idx), v_1)

- `v_1` is not recognised as an array because it is not an I/O argument
- It is not declared either            
- So what we should do: if the LHS of a Map is an original Vec, but not VI or VO, we should declare it using vSz

Turns out this is totally wrong, because if we don't eliminate the stencils then every map must be a stage.
So the right way is to have a separate set of rewrite rules that do not touch the stencil. 

It may be enough to not substitute any VT vecs. But that would mean that we can't remove a map in map f map g. 
So probably we should allow substitution of VT but _not_ in Stencil.



## OpenCL Code

The host-side code will have to be manual for now.

## Testing and Examples

### Map-only

I think I should test this with an example where I calculate a derivative of the normalised value of a property.

So v-mean(v) stenciled at -1 and +1; for the edge points we have a condition check. First I do this 1-D, then 2-D, then I do it again in actual Fortran

What I expect here is that the intermediate array v_norm will disappear

            subroutine calc_mean(acc_in,v_in,acc_out)
                  acc_out = acc_in+v_in/v_sz
            end subroutine calc_mean

            subroutine calc_norm(mean_v,v_in,v_out)
                  v_out = v_in-mean_v
            end subroutine calc_norm

            subroutine calc_deriv(v_in_1,v_in_2, v_out)
                  v_out = (v_in_2 - v_in_1)/2
            end subroutine calc_deriv

In TyTraCL we have

            v_mean = fold calc_mean 0 v
            v_norm = map (calc_norm v_mean) v
            s = [-1,1]
            v_norm_s = stencil s v_norm
            v_norm_deriv = map calc_deriv v_norm_s

In Fortran this becomes            

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
            call stage_kernel_1(...)
      end do
end program main




## Avoiding double-buffering

### The problem and some analysis

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
u in g depends on un which depends on u in f, so that we have u1 depending on u1. In short, I think the solution is to say that un must be a local array. I think that should automatically lead to its being eliminated.

### The key insight: local arrays

Intermediate arrays should not be in, out or inout, but _local_.  I verified this and indeed, any array that I make a local disappears. So what I should do is this:

- Combine all subroutines in a time loop (assuming no I/O) into a single subroutine which has no subroutine calls => write that inliner!
- For that subroutine, do the aggressive new IODir analysis
- Then check if the Out and InOut arguments are needed: if they are not used in any code downstream from the kernel subroutine, they are not needed so Out should become local and InOut should become In.

## OpenCLC: Passing array slices and returning scalars into array elements

- We use array slices and also return scalar values into array elements, see

      {test_return_to_array_elt,test_pass_array_slice},{f90,c}

for the conversions.

We need to add this to

      RefactorF4Acc::Translation::OpenCLC

The current (20191106) status is that the slices are now done, I need to verify if return into array elt works.

## More general case for stencils

The stencil currently is defined for non-constant accesses only, I could generalise this using the algorithm in

See `/Users/wim/Desktop/FortranRefactoring/2018-10-30-stencil-algo.txt`      

## How to deal with iteration?

      (read_only_vs, iter_vs) = map f v_ins
      iter_vs' = iterate test calc_iter read_only_vs iter_vs
      v_out = map f (read_only_vs, iter_vs')

It seems clear that the `iterate` call must become one or more stages; there is no reason to do this on the device, so we can probably keep the original code.

Essentially, for the SOR we have

      p_s = stencil s1 p
      p = map sor (zipt (p_s,rhs))

and it's a single map so no particular actions

## LES in TyTraCL?

In `/Users/wim/SoC_Research/TyTra/tytra/Type-Transformations-FPGA/TyTraHLL` we have

`/Users/wim/SoC_Research/TyTra/tytra/Type-Transformations-FPGA/TyTraHLL/TytraHLL-LES.hs`

These are Haskell sketches. What I need is a proper TyTraCL version based on the GPU version.
If I would ignore the boundaries, it might be possible ...

I think the best thing to do is to use velfg/vel2 as example.

## Combinatorial explosion

Given a stencil of m points, called k times, we'll have m**k operations.
I don't think we can avoid the actual computations, but we can avoid reading m**k values from main memory:
- The actual number of unique values accessed is much smaller. For example a 4-point stencil +/-1 will after k iterations result in 2*k*k unique values (instead of 4**k). A 2-point stencil would be 2*k (instead of 2**k) values. for a 6-point stencil, we get 8 cube sections, so two cubes, i.e. 2*k*k*k (as opposed to 6**k)
We can create a small memory that has the iterator values and the actual array value at the point, and as this is small, we can search it linearly for the value needed. A kind of very specialised cache.
In this way, the memory BW will not grow. The computation requirement still grows very fast though.

Compared to the original: say that we have k iterations, we have k intermediate arrays, so on the whole order of k*m operations, compared with m**k, 
m**k/k/m

say m=6 and k=5
6**5/5/6 = 6**4/5 = 260

I should provide a table : 2, 4, 6 point stencils; 1..10 iterations

Looking at e.g. the GeForce GTX TITAN:

threads: 2688
clock 837 MHz
Memory Bandwidth (GB/sec) 288

So per ns, we can read 77 words from the memory, to be divided amongst 2688 threads. So per thread it takes 35 ns for a word, i.e. about 40 cycles can be spend on computation.

