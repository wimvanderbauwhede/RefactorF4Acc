[![DOI](http://joss.theoj.org/papers/10.21105/joss.00865/status.svg)](https://doi.org/10.21105/joss.00865)

# The Glasgow Fortran Source-to-Source Compiler (RefactorF4Acc)

An Automated Fortran Code Refactoring Tool to Make Numerical Simulation Code Acceleration-Ready

(c) Wim Vanderbauwhede 2010-now

School of Computing Science, University of Glasgow, UK

## Note

Please be aware of RefactorF4Acc's [limitations and known issues](LIMITATIONS.md)</a>. 

## Table of Contents
* <a href="#howhelp">How can RefactorF4Acc help you?</a>
* <a href="#inanutshell">RefactorF4Acc in a nutshell</a>
* <a href="#benefits">Benefits of RefactorF4Acc</a>
* <a href="#correctness">Correctness and capability of RefactorF4Acc</a>
    - <a href="#nist">US National Institute of Standards and Technology (NIST) test suite</a>
    - <a href="#physics">Test on four real-word physics simulation models</a>
* <a href="#limitations">Limitations of RefactorF4Acc</a>
* <a href="#underthehood">What RefactorF4Acc does under the hood</a>
* <a href="#installing">Installing RefactorF4Acc</a>
* <a href="#gettingstarted">Getting started</a>
* <a href="#using">Using RefactorF4Acc</a>
    - <a href="#config">Configuration</a>
    - <a href="#commandline">Command line flags</a>
* <a href="#examples">Examples of RefactorF4Acc in action </a>
    - <a href="#refactor">Refactoring code</a>
    - <a href="#translate">Translating refactored code to OpenCL/C</a> 
* <a href="#fulltoolchain">Example of full toolchain from FORTRAN77 to parallel OpenCL</a>
* <a href="#appnist">Appendix: Validation of RefactorF4Acc using the NIST test</a>


<a name="howhelp"></a>
## How can RefactorF4Acc help you?
* Are you using/writing FORTRAN77 code?
* Would you like to make it run faster?
* Would you like to upgrade to Fortran-95, without effort?
* But you don't have the time or the skill?

Then this may be the tool for you!

Most code for numerical simulation of weather/climate models is written in Fortran. In particular the older codebases, written in FORTRAN77, are difficult to maintain or modify. 

With the advent of multicore CPUs, GPGPUs and FPGAs and technologies such as OpenMP and OpenCL, there is a growing interest in acceleration of numerical simulations. With the current state of affairs, this usually requires a considerable manual rewrite of the code.

Our compiler automates this process as much as possible. 

<a name="inanutshell"></a>
## RefactorF4Acc in a nutshell
* RefactorF4Acc  is an automatic refactoring tool to make Fortran code acceleration-ready.
* RefactorF4Acc's main purpose is to make legacy FORTRAN77 acceleration-ready. In the process it converts FORTRAN77 code into Fortran-95.
* In addition, RefactorF4Acc has a backend to translate modules to C/OpenCL.

<a name="benefits"></a>
## Benefits of RefactorF4Acc

* FORTRAN77 to Fortran-95 translation: the resulting Fortran-95 code has
  * Proper Fortran-95 syntax, including types, parameters and operators
  * `MODULE` support with explicit import list (`USE` ... `ONLY:` ...)
  * `INTENT` attributes have been inferred
  * No `IMPLICIT` declarations, all variables are declared explicitly
  * proper `DO` ... `END DO` -loops, removal of redundant `GOTO`
  * All subroutines in the call tree are refactored so that there are no shared global (`COMMON`) variables
  * `EQUIVALENCE` statements are replaced by explicit assignments
  * Preserves comments

* OpenCL/C translation
  * Once refactored, modules can be translated to C or OpenCL kernel code in a separate pass (see [Automatic parallelisation using OpenCL](README.md#automatic-parallelisation-using-opencl))

* Subroutine extraction
    * add an annotation

            !$ACC Subroutine <optional subroutine name>
            ... <code to be extracted as subroutine>
            !$ACC End Subroutine <optional subroutine name>

* Subroutine inlining
    * add an annotation

            !$ACC Begin Inline
            ... <code to be inlined>
            !$ACC Begin Inline

* Call graph generation

* Part of the toolchain for automatic parallelisation using OpenCL: 
Automatic parallelisation and offloading of legacy code to accelerators is the ultimate aim of the project, and already works for many cases.
However, the work flow is more complicated and requires an additional compiler, [AutoParallel-Fortran](https://github.com/wimvanderbauwhede/AutoParallel-Fortran). This compiler is written in Haskell, which is not yet a mainstream programming language. Furthermore, the generated OpenCL code relies on the [OclWrapper Fortran OpenCL API](https://github.com/wimvanderbauwhede/OpenCLIntegration), written in C++, and uses [scons](http://scons.org/), a Python-based build system. For these reasons, it is harder to install this autoparallelising compiler. However, if you have installed it, a test case for the full flow is provided in the `tests` folder, see <a href="#fulltoolchain">Example of full toolchain from FORTRAN77 to parallel OpenCL</a> for more details. 

<a name="correctness"></a>
## Correctness and capability of RefactorF4Acc 

<a name="nist"></a>
###  US National Institute of Standards and Technology (NIST) test suite
To assess the correctness and capability of our refactoring compiler, we used the NIST (US National Institute of Standards and Technology) [FORTRAN78 test suite](http://www.itl.nist.gov/div897/ctg/fortran_form.htm), which aims to validate adherence to the ANSI X3.9-1978 (FORTRAN 77) standard. We used [a version with some minor changes from Arnaud Desitter](http://www.fortran-2000.com/ArnaudRecipes/fcvs21_f95.html): All files are properly formed; a non standard conforming FORMAT statement has been fixed in test file `FM110.f`; Hollerith strings in FORMAT statements have been converted to quoted strings. This test suite comprises about three thousand tests organised into 192 files.

We skipped/modified some tests because they test features that our compiler does not support (see below for more details). After skipping these types of tests, 2899 tests remain, in total 190 files for which refactored code is generated. The testbench driver provided in the archive skips another 8 tests because they relate to features deleted in Fortran 95. In total the test suite contains 72,473 lines of code (excluding comments). Three test files (FM302, FM406 and FM923) contain tests that fail in gfortran (3 tests in total). Our compiler currently fails one additional test, test 13 in FM302, see ["Known issues"](#issues).

Our compiler successfully generates refactored code for _all_ tests, and the refactored code compiles correctly and passes all other tests (2895 tests in total). The tests are available in `tests/NIST_F78_test_suite`, together with a dedicated readme. For full details, please refer to <a href="#appnist">Appendix: Validation of RefactorF4Acc using the NIST test</a> and 
<a href="https://doi.org/10.1016/j.compfluid.2018.06.005">"Domain-specific acceleration and auto-parallelization of legacy scientific code in FORTRAN 77 using source-to-source compilation"</a> (Wim Vanderbauwhede and Gavin Davidson; Computers & Fluids Vol 173, 15 September 2018, Pages 1-5).

<a name="physics"></a>
###  Test on four real-word physics simulation models
We tested the compiler on four real-word physics simulation models:

* The 2-D Shallow Water example from the book "Ocean Modelling for Beginners: Using Open-Source Software" by Jochen Kämpf. (188 loc), available in `tests/ShallowWater2D`.
* The [Large Eddy Simulator](https://github.com/wimvanderbauwhede/LES), a high-resolution turbulent flow model (1,391 loc)
* The shallow water component of [Gmodel](http://www.sciamachy-validation.org/research/CKO/gmodel.html), an ocean model (1,533 loc)
* [Flexpart-WRF](https://github.com/sajinh/flx_wrf2), a version of the Flexpart particle dispersion simulator that takes input data from WRF (13,829 loc)
* The [Linear Baroclinic Model](http://ccsr.aori.u-tokyo.ac.jp/~hiro/sub/lbm.html), an atmospheric climate model (39,336 loc)


Each of these models has a different coding style, specifically in terms of the use of common blocks, include files, etc. that affect the refactoring process. All of these codes are refactored fully automatically without changes to the original code and build and run correctly. The performance of the original and refactored code is the same in all cases. 

Full details of these four real-world examples can be found in 
<a href="https://doi.org/10.1016/j.compfluid.2018.06.005">"Domain-specific acceleration and auto-parallelization of legacy scientific code in FORTRAN 77 using source-to-source compilation"</a> (Wim Vanderbauwhede and Gavin Davidson; Computers & Fluids Vol 173, 15 September 2018, Pages 1-5).

<a name="limitations"></a>
## Limitations of RefactorF4Acc

Limitations and known issues are discussed in detail in [`LIMITATIONS.md`](LIMITATIONS.md). In short:

- This tool was developed for a specific purpose: refactoring FORTRAN77 code into Fortran 95 code _suitable for offloading to GPUs and FPGAs_. The refactorings it includes are there to support that goal. Therefore, many refactorings that you might do to improve code on CPU, e.g. to benefit from SIMD, are _not_ included, for example replacing loops by array operations.
- I have gradually been adding support for more F77, F90 and F95 features, but there is still a lot that is not supported, see [`LIMITATIONS.md`].
- This is a full-source compiler, so it assumes full visibility of the entire source code. That means that external subroutines for which there is no source code will lead to incorrect refactoring, because the compiler needs either know or be able to infer the subroutine signature. You can work around this by adding a stub subroutine.
- To perform static code analysis, the compiler requires all array bounds to be constants at compile time. If your code contains array bounds defined using variables, in particular subroutine arguments, the analysis can't work.
- The resulting code is also _not_ GPU-ready, it is still ordinary, single-threaded Fortran code. For the process to generate fully parallel OpenCL code for GPU, see <a href="#fulltoolchain">Example of full toolchain from FORTRAN77 to parallel OpenCL</a>. 
- This is a research project and because of the limited time I can put into it, it is _definitely not complete or bug free_. Therefore, the chance that it might not work on your particular code is quite high.
- I would like you to get in touch but I can't guarantee a speedy resolution of your issues.

<a name="underthehood"></a>
## What RefactorF4Acc does under the hood

* Inventory of source code by following function/subroutine call tree and include statements across all source files
* Source-to-source compiler
* Line-by-line parse, recursive descent
* Analysis of global (/COMMON/) variables and parameters
* Loop analysis to transform GOTOs and labeled DO into DO ... END DO
* IO direction analysis to determine INTENT

<a name="installing"></a>
## Installing RefactorF4Acc

Please see [`INSTALL.md`](INSTALL.md).

<a name="gettingstarted"></a>
## Getting started
Please see [`GETTING_STARTED.md`](GETTING_STARTED.md) for a demonstration of using RefactorF4Acc to refactor a "Hello, world!" program that uses several legacy Fortran features. The files and readme accompanying the  "Hello, world!" program can be found in the sub-directory `tests`.

To use RefactorF4Acc: 
1. Create a minimal configuration file using the following template:

        # The name of the PROGRAM
        TOP = ...
        # Paths in case you want to run outside the source folder
        PREFIX = ...
        SRCDIRS = ...
        # Path for refactored source
        NEWSRCPATH = ...
 
2. Save this configuration file as `rf4a.cfg`.
3. From the top of your source tree, invoke RefactorF4Acc with the command `refactorF4acc.pl`.

<a name="using"></a>
## Using RefactorF4Acc

<a name="config"></a>
### Configuration

If you run `rf4a` without any flags, it will look in the current directory for a configuration file `rf4a.cfg`.
If that file does not exist, it will present you with a text-based wizard to create the configuration.
The configuration file is a text file containing key-value pairs separated with an '='. Lines starting with '#' are comments.

For a list of the defined option and thier defaults, see [`CONFIGURATION.md`](CONFIGURATION.md).

<a name="commandline"></a>
### Command line flags

    -h: help
    -V: print the version number
    -w <level>: show warnings, levels 0 (none) to 3 (most). default level = 1
    -v: verbose (implies -w)
    -i: show info messages
    -d: show debug messages
    -c <cfg file name>: use this cfg file (default is ./rf4a.cfg, or a global ~/.rf4a)
    -I: Inline all include files. Use this if include files are not self-contained and can't be turned into modules
    -C: Only generate call tree, don't refactor or emit
    -b: Generate SCons build script
    -B: Build the generated code
    -A: Annotate the refactored lines 
    -P: Name of pass to be performed
    -s: Provide a comma-separated list of source files to be refactored. Same as specifying SOURCEFILES in the config file
    -o: Provide a custom output path

<a name="examples"></a>
## Examples of RefactorF4Acc in action 
<a name="refactor"></a>
### Refactoring code  
To refactor code as explained above:

        $ refactorF4acc.pl

This requires a config file `rf4a.cfg` in the directory where `refactorF4Acc.pl` is called, containing:

    # The name of the PROGRAM
    TOP = wave2d
    # Paths in case you want to run outside the source folder
    PREFIX = .
    SRCDIRS = .
    # Path for refactored source
    NEWSRCPATH = ../RefactoredSources

or for another example:    

    # The name of the PROGRAM  
    TOP = main
    PREFIX = .
    SRCDIRS = .
    NEWSRCPATH = RefactoredSources
    EXCL_SRCS = main_screenshot.f, test.f, ^tmp.*
    EXCL_DIRS = GIS, data, RefactoredSources.*,  PostCPP,testDest.*
    NO_ONLY = 0
    SPLIT_LONG_LINES = 1
    # By default the extension is _GLOB, this forces no extension
    RENAME_EXT =  

If the config file does not exists, the script will present you with an interactive menu to create one.      

<a name="translate"></a>
### Translating refactored code to OpenCL/C

The compiler has separate passes to perform a purely syntactic translation from Fortran to C or OpenCL. 

To translate the refactored code to C:

      $ refactorF4acc.pl -P translate_to_C -c rf4a.cfg

or to OpenCL:

      $ refactorF4acc.pl -P translate_to_OpenCL -c rf4a.cfg

The translation expects a subroutine and all its called subroutines and functions inside a single module. An example `rf4a.cfg` configuration file:

    # Name of the module containing the kernel subroutine and its source file
    MODULE = module_les_superkernel
    MODULE_SRC = module_les_superkernel.f95
    TOP = les_superkernel
    # Name of the kernel subroutine (so same as TOP, sorry)
    KERNEL = les_superkernel
    PREFIX = .
    SRCDIRS = .
    NEWSRCPATH = ./Temp
    # Sources to be excluded (regular expression)
    EXCL_SRCS = (module_sub_superkernel_init|_host|\.[^f])
    # Folders to be excluded
    EXCL_DIRS = ./PostCPP,./Temp
    MACRO_SRC = macros.h
    RENAME_EXT = _G   

<a name="fulltoolchain"></a>
## Example of full toolchain from FORTRAN77 to parallel OpenCL

The test `tests/ShallowWater2D` is an example of automatic parallelisation and GPU-acceleration of legacy code.  It is the 2-D Shallow Water example from the book "Ocean Modelling for Beginners: Using Open-Source Software" by Jochen Kämpf. The code is effectively Fortran-77 except that it uses Fortran-90 style modules.

As explained above, to run this test you need to install the [AutoParallel-Fortran](https://github.com/wimvanderbauwhede/AutoParallel-Fortran) compiler and the [OclWrapper Fortran OpenCL API](https://github.com/wimvanderbauwhede/OpenCLIntegration), as well as [scons](http://scons.org/), a Python-based build system.

A more detailed explanation of the steps is available in the file [tests/ShallowWater2D/Auto-acceleration-README.md](tests/ShallowWater2D/Auto-acceleration-README.md).

      $ cd tests/ShallowWater2D/fortran

Please ensure that the environment variable `$FC` is set to the Fortran compiler you want to use. I have tested the code only with `gfortran 4.9` to `gfortran 10.0`.

We start from the original code, where the only change is the addition of a `!$ACC Subroutine` pragma to automatically extract a subroutine from the source code. This demonstrates the subroutine extraction feature of the compiler.
To generate the refactored Fortran-95 code used as starting point for autoparallelisation and OpenCL conversion, run the command `./generate_and_build.sh`:

      $ ./generate_and_build.sh

This will generate (and build) the refactored, accelerator-ready Fortran 95 code in the directory `tests/RefactoredSources`. This code produces exactly the same output as the original code, with the same performance. We can now run the auto-parallelising compiler on this refactored code:	     

	$ cd ../RefactoredSources
	$ ./run_autoparallel_compiler GPU

This step will generate OpenCL-ready parallelised code. The generated kernel is a single source file (`module_shapiro_dyn_update_superkernel .f95`) _in Fortran syntax_ in the directory `tests/Autopar`. To generate the actual kernel in OpenCL C syntax, do:

	$ cd ../Autopar
	$ ./generate_OpenCL_kernel.sh module_shapiro_dyn_update_superkernel   	

This will generate the OpenCL kernel file `module_shapiro_dyn_update_superkernel.cl`.

You can now build the refactored code for GPU as follows:

 - For running on an Intel Iris Pro

	    $ scons -f SConstruct.auto dev=GPU nth=32 nunits=40

 - For running on an NVIDIA GeForce GTX TITAN Black

	    $ scons -f SConstruct.auto dev=GPU nth=512 nunits=15 	

Running the accelerated code on this GPU results in 14x speedup compared to the original code running on the host (Intel Core i7 CPU @ 3.50GHz).

## See also

* [`INSTALL.md`](INSTALL.md)
* [`GETTING_STARTED.md`](GETTING_STARTED.md)

<a name="appnist"></a>
## Appendix: Validation of RefactorF4Acc using the NIST test

We use the [NIST FORTRAN78 test suite](ftp://ftp.fortran-2000.com/fcvs21_f95.tar.bz2) for validation.

      $ cd tests/NIST_F78_test_suite

The original FORTRAN 77 test suite source files are in `fcvs21_f95/`. See [tests/NIST_F78_test_suite/README.md](tests/NIST_F78_test_suite/README.md) for details on the test suite, modifications and failed tests.

Please ensure that the environment varianble `$FC` is set to the Fortran compiler you want to use. I have tested the code only with `gfortran 4.9` to `gfortran 10.0`. 
To generate the refactored Fortran-95 code for the test suite, build it and run it, do:

      $ ./generate_build_and_run_testsuite.sh

Generating, compiling and running the test suites takes a few minutes. The refactored Fortran-95 code is generated in the folder `fcvs21_f95/RefactoredSources/`. 

The final output should look like:

        real	0m59.622s
        user	0m50.761s
        sys	0m7.799s

        # Generation of the refactored test suite code:
        TOTAL TESTS: 197
        TESTS RUN: 192
        SKIPPED: 5
        Generation Failed:
        0
        Generation Succeeded:
        192

        real	0m7.762s
        user	0m4.590s
        sys	0m2.470s


        # Compilation of the refactored test suite:

        Total  : 192
        Passed : 184
        Failed : 0
        Skipped: 8

        real	0m59.369s
        user	0m22.236s
        sys	0m9.107s

        # Running the refactored test suite:
        PASSED: 2769
        FAILED: 10
        REQUIRE INSPECTION: 170
        TOTAL: 2949

To verify the original FORTRAN 77 test suite you can use the original scripts `driver_parse` and `driver_run`. You may have to change the name of the Fortran compiler in `FC` at the start of these scripts.

      $ cd fcvs21_f95
      $ ./driver_parse
      $ ./driver_run

      

