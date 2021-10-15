This is an example of reducing memory by eliminating intermediate arrays.

The full work flow is as follows:
* Prepare the autoparallellised code
1. In `fortran`:
    - Run  `generate-and-build-with-scons.sh`
    This will generate refactored code in `RefactoredSources`.
    It assumes that `RefactorF4ACC/bin` is in your `$PATH`.
    If you want to run the refactored code, change the fsources in RefactoredSources/SConstruct to:
        `fsources = ['./dyn_shapiro_update.f95','./init.f95','./main.f95']`
2. In `RefactoredSources`:
    - Run `./run_autoparallel_compiler.sh FPGA`
    This requires `AutoParallel-Fortran-exe` to be installed in your `$PATH`.
    Source code and instructions for installing this compiler are [in the AutoParallel-Fortran repo](https://github.com/wimvanderbauwhede/AutoParallel-Fortran)
    The refactored sources will be generated in `Autopar_FPGA`
3. In `Autopar_FPGA`:
    - Copy the file to `GeneratedCodeForMemoryReduction`
        `cp -r ../Autopar_FPGA/* ../GeneratedCodeForMemoryReduction`
* Do the memory reduction
4. In  `GeneratedCodeForMemoryReduction`
    - Run `memory_reduction.pl -C`.
    This assumes that you have [the Haskell tool `stack`](https://docs.haskellstack.org/en/stable/README/) installed.
    This should create the reduced file in `GeneratedCodeForMemoryReduction/MemoryReduction`
5. In `GeneratedCodeForMemoryReduction/MemoryReduction/`:
    - Patch the kernel module, the scalarised functions and the SConstruct file:
        `../aux/patch_memreduced.sh -i`
    - For further inlining, the script takes the option `-i`. Without it, the script produces code and a build script in `Generated`. Run `scons` there to test that code if desired. The executable is  `gen_*_superkernel`.
    - Run the inliner
    `refactorF4Acc.pl -c ./rf4a_inline.cfg`
6. In `GeneratedCodeForMemoryReduction/mem_reduced_inlined/Generated`:
    - Patch the generated files and the SConstruct file:
    `perl ../../aux/patch_inlined_code.pl OpenCL`
    - The patched code is in `Patched`, build using `scons`, the executable is `prog.exe`

The inliner will run if there are !$RF4A Inline pragmas. These are generated by `MemoryReduction-exe` which is compiled and run by `memory_reduction.pl`.
