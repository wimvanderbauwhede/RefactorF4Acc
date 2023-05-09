HOW TO RUN THIS:

The domain is configured at build time with WM

     integer, parameter :: ip=150*WM
     integer, parameter :: jp=150*WM
     integer, parameter :: kp=90

This needs to be set manually at compile time. For testing on the laptop, WM=1 is best. On the GPG cluster we can go up to 32; I used 2, 14 and 32.


* Do the memory reduction
6. In  `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/Build-reference`
    - To build the original code, first patch it using `perl aux/patch_superkernel_module_src.pl`.
    - Build it using `scons -f SConstruct.dyn`, the executable is `prog-dyn.exe`.
    - There is also a static version because that is the actual baseline, build it using `scons`, the executable is `prog.exe`.
7. In  `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/`
    - run `memory_reduction.pl -C`. This should create the reduced file in `MemoryReduction/Generated`
8. In `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/MemoryReduction/`
    - patch the kernel module, the scalarised functions and the SConstruct file
        `../aux/patch_memreduced.sh -i` (-i is obsolete)
    - the patch does the following:
        - in `Generated`
            - remove the intent for vars that are not stage kernel args in `module_gen_*_superkernel.f95` (probably does nothing anymore )
        - in `Scalarized`
            - substitute the parameters from the original module (`module_*_superkernel.f95` file)
            - add `pure` to the subroutine declarations
    - for further inlining, the script takes the option `-i`. Without it, the script produces code and a build script in `Generated`. Run `scons` there to test that code if desired. The executable is `gen_velfg_superkernel`. The difference is that the inlined version does not use the `get_global_id` module
    - Run the inliner
        `refactorF4acc.pl -c ./rf4a_inline.cfg`
9. In `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/mem_reduced_inlined/Generated`:
    - Patch the generated files and the SConstruct file:
    `perl ../../aux/patch_inlined_code.pl`
    - The patched code is in `Patched`, build using `scons`, the executable is `prog.exe`
10. In `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/mem_reduced_inlined/Generated/Patched`:
    - Patch the generated files and the SConstruct file for OpenMP
    `perl ../../../aux/patch_openmp_dyn.pl`
    - The patched code is in `gen_velfg_superkernel_omp_dyn.f95`, build using `scons -f SConstruct.omp_dyn`, the executable is `prog-omp_dyn.exe`

BUGS 2023-04-27

The problem with OpenMP is that we need dyn alloc for all the intermediate arrays but in the current version the superkernel does not have them as arguments.

BUGS 2023-04-26

It looks to me like there is some major bug here: scalarisation relies on get_global_id to determine the iterators, and that is used to determine which arrays can become stream vars. So what I've done is accept global_id as a special arg.
There is still a bug in the scalarisation: the global_id is removed in the end, because it is an index var.
=> FIXED

non-map args are missing in the main program; also, some of the cast/reshape are plain wrong, and others are not needed because the dimensions are the same.
=> FIXED

BUGS 2023-04-13
In mem_reduced_inlined/Generated/Patched
* The arguments to the routines are WRONG 

    call velfg_superkernel(u_0,v_0,w_0,f_1,g_1,h_1,state_ptr,global_id)

    subroutine velfg_superkernel(dx1_0,dy1_0,dzn_0,dzs_0,global_id_0,u_0,v_0,w_0,f_1,g_1,h_1, &
    use singleton_module_stage_kernel_1, only: stage_kernel_1
        global_id_0,state_ptr,global_id)

    call stage_kernel_1(dx1_0,dy1_0,dzn_0,dzs_0,global_id_0,u_0,v_0,w_0,f_1,g_1,h_1,global_id)

    subroutine stage_kernel_1(dx1_0,dy1_0,dzn_0,dzs_0,global_id_0,u_0,v_0,w_0,f_1,g_1,h_1,global_id,global_id)

* The line
        use singleton_module_stage_kernel_1, only: stage_kernel_1
    is in the wrong place

* Before patching (in  mem_reduced_inlined/Generated/velfg_superkernel.f95 )

    subroutine velfg_superkernel(dx1_0,dy1_0,dzn_0,dzs_0,global_id_0,u_0,v_0,w_0,f_1,g_1,h_1, &
      global_id_0,state_ptr,global_id)

* Before inlining and patching (in MemoryReduction/Generated), so this has added a `global_id_0`, twice!

    subroutine velfg_superkernel( dx1_0, dy1_0, dzn_0, dzs_0, global_id_0, u_0, v_0, w_0, f_1, g_1, h_1, global_id_0,state_ptr)

    call velfg_superkernel(u_0, v_0, w_0, f_1, g_1, h_1, global_id_0,state_ptr)

* Original:

    subroutine velfg_superkernel(f,g,h,dzn,u,v,w,delx1,dx1,dy1,dzs,state_ptr,global_id)

So the Haskell memory reduction code results in two global_id arguments, which is of course wrong. Could this be because of the redundant delx1 that gets eliminated?

What I see from ASTInstance.hs is that the global_id_0 is an input to three kernels but not an input to main!

- the original code has
    subroutine velfg_superkernel(f,g,h,dzn,u,v,w,delx1,dx1,dy1,dzs,state_ptr,global_id)
- the main has 
    (w_0,v_0,u_0,dx1_0,dy1_0,dzn_0,dzs_0) as inputs and
    (f_1,g_1,h_1) as outputs
- the generated code has 
    subroutine velfg_superkernel(dx1_0, dy1_0, dzn_0, dzs_0, global_id_0, u_0, v_0, w_0, f_1, g_1, h_1, global_id_0,state_ptr)

It is suspicious that the state_ptr is missing in main but present in the generated code.
=> There was a bug that removed state_ptr from the inputs

I note that in the Haskell generator for the call to velfg_superkernel, it is added explicitly.

So one thing to try is rename global_id to something else. 
=> I did that, no joy. The bug is in Haskell. I don't know what is special about th_idx (global_id) but it gets replicated. 
So need to find out how it is different from the other non-map args.
So, is it position, use or type?
Let's add a th_ratio real, and use that as input too, see if it also gets replicated
=> It's not type or position. It is either use or, maybe, that these are scalars? 
=> Yes, it's because it is a scalar.

Questions:
- why are the non-map args in scalarisedArgsList ? the th_idx is one of the only args that is not there.
- could it be that the Nothing on the dimension causes the problem? MkFDecl "integer" Nothing ?

=> OK, this is fixed. The reason was that scalar inputs were treated as input rather than non-map.


The inliner will run if there are !$RF4A Inline pragmas. These are generated by `MemoryReduction-exe`



This is an example of reducing memory by eliminating intermediate arrays.

## Exemplar code and impact of memory reduction

The code is based on one of the key algorithms in the Large Eddy Simulator for Urban Flows.

The simulator performs the following actions at every timestep (the number in parentheses is the number of full-domain 3-D arrays used):
- Set initial boundary conditions for wind velocity and pressure (4)
- Calculate the turbulent flow using the marker-and-cell method: based on the velocity fields u,v,w calculate the convection components and from this calculates the force fields f,g,h. (37)
- Integrate the force fields over time (Adams-Bashfort) (6)
- Solve the Poisson equation for the pressure using successive over-relatation (6)

In the original code, the turbulent flow algorithm uses the following 3-D arrays, 37 in total:

u,v,w
f,g,h
diu 1..9 for partial derivatives of the velocity
nou 1..9 for interpolated values
cov 1..9 for convection components
df{u,v,w}1 for updating the force fields with their derivatives
sm

Of these 37 arrays, only u,v,w are actual inputs to the calculation and f,g,h computed outputs.

Our memory reduction approach eliminates the 31 intermediate arrays entirely. In the other algorithms, there are no redundant arrays.

[[To illustrate the impact: assuming the GPU has 4GB of memory, then the maximum domain  for the original code was 100 MB, which translates to a domain of about 400x400 points.
After removal of the intermediate arrays, the domain can be up to 1000x1000 points.]]
To illustrate the impact: the server used in this work has 62GB of memory. The maximum domain for the original code was 2100x2100x90 points, which corresponds to an array size of 1.5GB
After removal of the intermediate arrays, the domain can be up to 5400x5400x90 points, an array size of 9.8GB.

As all redundant array accesses are replaced by register accesses, the resulting code is not only more memory efficient but also faster, as shown in Section Evaluation

## Evaluation

To evaluate the performance of the memory-reduced code, we used a dual-socket Intel(R) Xeon(R) CPU E5-2640 v2 server which has 8 hyperthreaded cores per socket, so 32 hardware threads in total. The CPU frequency is 2GHz and the cache is 20MB. The server has 62GB or RAM.

model name: Intel(R) Xeon(R) CPU E5-2640 v2 @ 2.00GHz
cpu MHz: 2001.372
cache size: 20480 KB
siblings: 16
cpu cores: 8

We evaluated the performance of the memory-reduced code as a function of the number of threads and compared it to the reference code, i.e. the auto-parallelised code before memory reduction. Fig XXX shows the comparison for the maximum array size supported by the reference code. We observe that the memory-reduced code is twice as fast as the reference code regardless of the number of threads. Fig XXX shows the comparison for a much smaller array size (a domain of 300x300x90 points, or array size 31MB). Even with this low memory utilisation, the memory-reduced code is 50% faster than the reference regardless of the number of threads.

Finally we evaluated the performance as a function of memory size for the optimal number of threads (32). From Fig XXX it is clear that the compute time is linear with the memory size until the memory limit of the system is exceeded.






*** FIXME FIXME FIXME >>> ***

The scalariser has a bug resulting in some non-map args sometimes being removed, and also the i_rel, j_rel, k_rel etc also get removed.
Currently therefore, the files in `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/Scalarized` are hand-patched.

*** <<< FIXME FIXME FIXME ***

The full work flow is as follows:
* Prepare the autoparallellised code
1. In ~/Research/DPRI/LEScode/OriginalSourcesF77: run `refactorF4Acc.pl -c ../rf4a.cfg`
    This will generate refactored code in RefactoredSourcesV11
2. In ~/Git/MPI-LES: run `./copy_refactored_src_from_OriginalSourcesF77.sh`
    This will copy the refactored sources in to src-for_MemoryReduction
3. In ~/Git/MPI-LES: run `perl aux/generate_and_build_OpenCL_version.pl --stage autopar --srcdir src-for_MemoryReduction --refsrcdir generated-src-for_MemoryReduction`
4. In ~/Git/MPI-LES/generated-src-for_MemoryReduction:
    `mkdir Work`
    `cp module_adam_bondv1_feedbf_les_press_v_etc_superkernel.f95 Work`
5. In ~/Git/MPI-LES/generated-src-for_MemoryReduction/Work:
    - Manually edit the file to remove anything that wil not work (in particular the boundary calculations)
    - copy the file to `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/`
* Do the memory reduction
6. In  `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/Build-reference`
    - To build the original code, first patch it using `perl aux/patch_superkernel_module_src.pl`.
    - The build it using `scons`, the executable is `prog.exe`.
7. In  `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/`
    - run `memory_reduction.pl -C`. This should create the reduced file
8. In `~/Git/RefactorF4Acc/tests/velfg_memory_reduction_openmp/MemoryReduction/`
    - patch the kernel module, the scalarised functions and the SConstruct file:
        `../aux/patch_memreduced.sh -i`
    - For further inlining, the script takes the option `-i`. Without it, the script produces code and a build script in `Generated`. Run `scons` there to test that code if desired. The executable is  `gen_velfg_superkernel`.
    - Run the inliner
    `refactorF4Acc.pl -c ./rf4a_inline.cfg`
9. In `~/Git/MPI-LES/generated-src-for_MemoryReduction/Work/mem_reduced_inlined/`:
    - Patch the generated files and the SConstruct file:
    `perl ../../aux/patch_inlined_code.pl`
    - The patched code is in `Patched`, build using `scons`, the executable is `prog.exe`

The inliner will run if there are !$RF4A Inline pragmas. These are generated by `MemoryReduction-exe`


WV 2021-08-24

In summary, for 50 iterations on a arrays of size 150*150*90:
- reference: 5.2s
- memory-reduced version: 6.4s for.

So a slowdown of around 20% to 25%. This is with gfortran v9.3.0, '-flto','-Ofast'. The non-inlined version takes 52.3s.

Sadly,when I try this with OpenMP, I get a slowdown of almost 65%. I verified this, it seems correct: without OpenMP I get
11.5 for the memreduced version, 100 iters; but 12.8 for the reference.
I should repeat this with larger arrays.

However, for larger arrays, the picture is totally inverted: the performance is entirely memory dominated so the memory-reduced version is *faster* than the reference

To be able to test this on the GPG cluster, I had to do two things:
- Make all allocations dynamic. TODO: put this in the compiler
- Use ulimit -s 1000000, which is the max I can set but it is enough
- Append _8 to all integer constants because otherwise I get numeric overflows

Some more FIXMEs:
- the dx1/dy1 etc start from 0 after conversion, but the indexing still uses the original index so sometimes this is -1. I need to adapt the indices to fit the 0 start or the other way round.
- The i,j,k indices calculated via `_rel/_range` should all be integer*8
- The constants in the indices should have the `_8` suffix
Some more TODOs:
- I should generate the OpenMP code automatically. For the memory-reduced case this is easy.
- I need to triple-check the performance for small and large arrays, it is possible that the difference is a result of the dynamic allocation!






