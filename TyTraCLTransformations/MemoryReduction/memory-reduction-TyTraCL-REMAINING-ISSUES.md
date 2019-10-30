# REMAINING ISSUES : Memory Reduction for Scientific Computing on GPUs

## Fold and staging

This is high priority: I need to make sure that the stages pass on the accumulators. 



## Better AST

WV-2019-10-30: DONE

I need to get rid of DType and also flatten the arguments when I derive them rather than later on.

      data DType =
          DInteger | DInt
        | DReal | DFloat
        | DDC -- Don't Care ; Int and Integer, Real and Float as I can't make up my mind
          deriving (Show, Typeable, Data, Eq)

      -- I wonder if     data FSig = FSig [Expr] would not be a better approach, or even type FSig = [Expr]
      data FSig =
          MapFSig (Expr,Expr,Expr)
        | FoldFSig (Expr,Expr,Expr,Expr)
        deriving (Show, Typeable, Data, Eq)

      type TyTraCLAST = [(Expr,Expr)]                      

      data Expr =
              -- Left-hand side:
                            Scalar VE DType Name
                          | Const Int
                          | Tuple [Expr]
                          | Vec VE Expr

              -- Right-hand side:
                          | SVec Size Expr
                          | ZipT [Expr]
                          | UnzipT Expr
                          | Elt Int Expr
                          | PElt Int -- partially applied Elt
                          | Map Expr Expr -- map f v
                          | Fold Expr Expr Expr -- fold f acc v
                          | Stencil Expr Expr -- stencil s v
                          | Function Name [Expr] -- 2nd arg is list of non-map/fold args
                          | Id DType -- id
                          | ApplyT [Expr]  -- applyt (f1,f2)
                          | MapS Expr Expr -- maps s f
                          | Comp Expr Expr -- comp f2 f1
                          | FComp Expr Expr -- like comp but to combine a fold and a map, quite a-hoc!
                          | SComb Expr Expr -- scomb s1 s2
                              deriving (Show, Typeable, Data, Eq)

While I'm at it, let's just make

          type FSig = [Expr]                              

## Duplicate arguments

WV-2019-10-30: DONE

I can either make them unique in the subroutine definition, but not in the calls. That means I add a counter and use this throughout. The trivial way is to add a running counter even to the unique ones, i.e. a zip.
Then the question is how to ensure that the counters match.

## Integration of the scalarised code

!!! There is a bug in the scalarisation: the signatures are wrong! 

The remaining issue is: if we have a stencil which is InOut because it updates one point of that stencil

["eta","s",0,VS] In
["eta","",1,] Out

We then have as output a non-stencil arg, but this is actually one of the stencil points.
In Fortran this is fine, but the problem is than in TyTraCL I don't know which point of the stencil is actually the output.

- I need to include all modules with the scalarised kernels 

I need to modularise it and create a main program
WV-2019-10-30: DONE
Essentially, the generated code should become OpenCL code so I need to generate the call get_global_id(idx)
WV-2019-10-30: DONE

The host-side code will have to be manual for now.

A trick to have `get_global_id()` to work is to put idx in a COMMON block. Then we define

            subroutine get_global_id(idx)
              integer, intent(out) :: idx
              integer :: global_id
              common /ocl/ global_id
              idx = global_id
            end subroutine get_global_id  

and we define the main program as

            program main
              integer :: global_id
              common /ocl/ global_id
              ! and then all decls used in the kernels but without intent

              do global_id=1,VSZ
                call stage_kernel(<same>)
              end do
            end program main  



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