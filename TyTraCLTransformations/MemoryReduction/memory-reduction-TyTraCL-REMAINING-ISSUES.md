# REMAINING ISSUES : Memory Reduction for Scientific Computing on GPUs

## 2021-05-19

Been working on getting actual OpenCL Fortran to generate to ASTInstance.hs
Current status is that a simple fold-map example without stencils seems to work full chain.
Next step is to test a stencil, then two stencils

I think the detection of non-stream arguments still needs to be improved: we should use Accesses etc to see if an array is not using all iterators. If so, it is not a stream.

## 2021-05-17

Trivial tests for map and fold (13, 14, 15) also HANG on Substitute vectors (recursive), which is really silly.


## 2021-05-14

Trying to get TEST 10 to work with `noStencilRewrites = True` has led to additional arguments and declarations to get rid of.

What we need to do is look at the stage AST: all Vec vars that occur both on LHS and RHS can become local scalars. From the remaining ones, those in LHS are Out, those in RHS are In, regardless of their VO/VI because these are for global main. I think a simple way to do this is:
- split the tuples, [(,)] -> ([],[]) so unzip
- get all vecs from LHS and RHS, we do this somewhere already
- do the Data.List.intersect , these are local scalars
- the difference Data.List.(\\) with LHS are Out


Fortran code generation should only be correct for the final stage `DecomposeExpressions` but for both `noStencilRewrites = True` and `noStencilRewrites = False`

* TEST 8 HANGS for noStencilRewrites = True on "Substitute vectors (recursive)" but passes with noStencilRewrites = False

etan_0 :: Vec 500 Float
wet_0 :: Vec 500 Int
un_0 :: Vec 500 Float

h_0 :: Vec 500 Float
u_0 :: Vec 500 Float
wet_1 :: Vec 500 Int

update_map_24 :: (Float,Float) -> (Float,Float,Int)
shapiro_map_16 :: (Int,SVec 3 Float) -> Float

main :: (Vec 500 Float,Vec 500 Int,Vec 500 Float) -> (Vec 500 Float,Vec 500 Float,Vec 500 Int)
main (etan_0,wet_0,un_0) =
  let
    s1 = [-1,0,1]
    etan_s_0 = stencil s1 etan_0
    eta_0 =  map shapiro_map_16 (zipt (wet_0,etan_s_0))
    (h_0,u_0,wet_1) = unzipt $ map update_map_24 (zipt (eta_0,un_0))
  in
    (h_0,u_0,wet_1)

-- Go trough all lines of the ast and do a recursive substitution on the lines with an output vector in the LHS
substituteVectors :: TyTraCLAST -> TyTraCLAST
substituteVectors ast' 
    | noStencilRewrites = map (substitute_vec_rec ast') (filter lhs_is_VO_or_VT_vec ast') 
    | otherwise =  map (substitute_vec_rec ast') (filter lhs_is_output_vec ast')

(Vec VT (Scalar VDC DFloat "eta_0"),
Map (Function "shapiro_map_16" []) 
    (ZipT [
      Vec VI (Scalar VDC DInt "wet_0"),
      Vec VS (SVec 3 (Scalar VDC DFloat "etan_s_0"))
      ]
    )
)
(Vec VO (Scalar VDC DFloat "h_0"),Elt 0 (UnzipT (Map (Function "update_map_24" []) (ZipT [Vec VT (Scalar VDC DFloat "eta_0"),Vec VI (Scalar VDC DFloat "un_0")]))))
(Vec VO (Scalar VDC DFloat "u_0"),Elt 1 (UnzipT (Map (Function "update_map_24" []) (ZipT [Vec VT (Scalar VDC DFloat "eta_0"),Vec VI (Scalar VDC DFloat "un_0")]))))
(Vec VO (Scalar VDC DInt "wet_1"),Elt 2 (UnzipT (Map (Function "update_map_24" []) (ZipT [Vec VT (Scalar VDC DFloat "eta_0"),Vec VI (Scalar VDC DFloat "un_0")]))))

So the reason is the ZipT  that has a Vec VS; without the ZipT (TEST 10) it does not hang but crashes on 

MemoryReduction-exe: (Vec VT (Scalar VT DDC "vec_h_0_1"),Elt 0 (Vec VT (Scalar VT DDC "vec_h_0_0")))
in CodeGeneration.hs:224

## 2019-11-13

I have started processing the LES. I added a number of macros to make the source suitable for conversion:

The existing macros used are

            #define WV_OPENCL
            #define WV_NEW
            #define NO_GLOBAL_SOR 
            #define TWINNED_BUFFER 
            #define NO_IO 
            #undef NO_FILE_IO 
            #define IFBF 1 
            #define IADAM 0 
            #undef I_IFDATA_OUT
            #undef I_AVEFLOW
            #define I_ANIME

The new ones are

            #define NO_BOUNDS_CALCS 
            #define INLINE_VEL2
            #define LES_EXTERNAL_DELX1
            #define SEPARATE_P_ARRAYS

- Boundary calculations are assumed to be done on the host.
- As I want to reduce arrays, I want to use the original `vel2` but we don't have an inliner yet so I did that manually.
- In `les.f95`, a 1-D array `delx1` is computed, I assume this will be done once on the host.
- Instead of a 4-D `p` array I have two 3-D arrays `p0` and `p1`.

The current main issue is that non-map/fold args that are arrays are not passed as arrays but are also scalarised. To avoid this, I must identify the arrays as non-map/fold. 
We could assume that the programmer does this, or we can use the dimension analysis. Identifying these arguments earlier is better anyway, but there does not seem to be a single working criterion.
A good heuristic might be:
- how many dimensions is the problem? `$ndims`
- what is the max size in any dimension? `@max_szs`
- any array of lower dimensionality is automatically not a stream
- any array of the correct dimensionality but much smaller than the `@max_szs` is not a stream
- "much smaller" is based on the assumption that we have a domain and then `$k` points for a halo. Any array where any dimension is smaller than $max_sz - $k should not be a stream

So let's assume we have this in the `rf4a.cfg`:

      NDIMS = 3
      MAX_SZS = 100, 100, 100 
      HALO_EXTENT = 3

The change to the code is in `_classify_accesses_and_emit_AST` (line 708) in `RefactorF4Acc::Analysis::ArrayAccessPatterns`; but I think we need the same analysis in `RefactorF4Acc::Refactoring::Streams` because of `rename_array_accesses_to_scalars` which is needed for the MemoryReduction pass.

BETTER: use 'LoopIters'

!!! unzipt $ fold should just be fold !!!


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

The current (2019-11-06) status is that the slices are now done, I need to verify if return into array elt works.

## More general case for stencils

The stencil currently is defined for non-constant accesses only, I could generalise this using the algorithm in

See `~wim/FortranRefactoring/2018-10-30-stencil-algo.txt`      

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

## Complexity Analysis: Combinatorial explosion

Given a stencil of m points, called k times, we'll have m**k operations.
I don't think we can avoid the actual computations, but we can avoid reading m**k values from main memory:
- The actual number of unique values accessed is much smaller. For example a 4-point stencil +/-1 will after k iterations result in 2*k*k unique values (instead of 4**k). A 2-point stencil would be 2*k (instead of 2**k) values. for a 6-point stencil, we get 8 cube sections, so two cubes, i.e. 2*k*k*k (as opposed to 6**k)
We can create a small memory that has the iterator values and the actual array value at the point, and as this is small, we can search it linearly for the value needed. A kind of very specialised cache.
In this way, the memory BW will not grow. The computation requirement still grows very fast though.

Compared to the original: say that we have k iterations, we have k intermediate arrays, so on the whole order of k*m operations, compared with m**k, 
m**k/k/m

say m=6 and k=5
6**5/5/6 = 6**4/5 = 260x

See CombinatorialExplosion.ods

Looking at e.g. the GeForce GTX TITAN:

threads: 2688
clock 837 MHz
Memory Bandwidth (GB/sec) 288

So per ns, we can read 77 words from the memory, to be divided amongst 2688 threads. So per thread it takes 35 ns for a word (2688/77), i.e. about 30 cycles can be spend on computation before it becomes compute dominated. 

