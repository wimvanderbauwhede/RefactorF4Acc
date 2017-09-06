# The Glasgow Fortran Source-to-Source Compiler

An Automated Fortran Code Refactoring Tool to Facilitate Acceleration of Numerical Simulations

(c) Wim Vanderbauwhede 2010-now

School of Computing Science, University of Glasgow, UK

## What is this?

* An automatic refactoring tool for Fortran code
* Mainly useful for FORTRAN77, but works for Fortran-95 too
* This tool converts FORTRAN77 into Fortran-95
* It has a backend to translate modules to C/OpenCL

## How could this is help you?

* Are you using/writing FORTRAN77 code?
* Would you like to make it run faster?
* Would you like to upgrade to Fortran-95, without effort?
* But you don't have the time or the skill?
* Then this might be the tool for you!

## Background

* Most code for numerical simulation of weather/climate models is written in Fortran
* In particular the older codebases, written in FORTRAN77, are difficult to maintain or modify
* With the advent of multicore CPUs, GPGPUs and FPGAs and technologies such as OpenMP and OpenCL, there is a growing interest in acceleration of numerical simulations
* With the current state of affairs, this usually requires a considerable manual rewrite of the code.
* Our compiler tries to automate this process as much as possible.

## Features

* F77 to F95 translation: the resulting F95 code has
  * proper F95 syntax, including types, parameters and operators
  * MODULE support with explicit import list (USE ... ONLY: ...)
  * INTENT attributes have been inferred
  * No IMPLICIT declarations, all variables are declared explicitly
  * proper DO ... END DO -loops, removal of redundant GOTO
  * All subroutines in the call tree are refactored so that there are no shared global (COMMON) variables
  * Preserves comments

* OpenCL/C translation
  * Once refactored, modules can be translated to C or OpenCL kernel code in a separate pass

* Subroutine extraction  
    * simply add an annotation
          !$ACC SUBROUTINE <optional subroutine name>  
          ... <code to be extracted as subroutine>
          !$ACC END SUBROUTINE <optional subroutine name>         
* Automatic parallelisation using OpenCL
    * simply add an annotation
          !$ACC KERNEL  <optional kernel name>
          ... < code to be parallelised as OpenCL kernel >
          !$ACC END KERNEL  <optional kernel name>
* Call graph generation

## How it works

* Inventory of source code by following function/subroutine call tree and include statements across all source files
* Source-to-source compiler
* Line-by-line parse, recursive descent
* Analysis of global (/COMMON/) variables and parameters
* Loop analysis to transform GOTOs and labeled DO into DO ... END DO
* IO direction analysis to determine INTENT

## Status

To assess the correctness and capability of our refactoring compiler, we used the NIST (US National Institute of Standards and Technology) [FORTRAN78 test suite](http://www.itl.nist.gov/div897/ctg/fortran_form.htm), which aims to validate adherence to the ANSI X3.9-1978 (FORTRAN 77) standard. We used [a version with some minor changes from Arnaud Desitter](http://www.fortran-2000.com/ArnaudRecipes/fcvs21_f95.html): All files are properly formed; a non standard conforming FORMAT statement has been fixed in test file `FM110.f`; Hollerith strings in FORMAT statements have been converted to quoted strings. This test suite comprises about three thousand tests organised into 192 files.

We skipped/modified some tests because they test features that our compiler does not support (see below for more details). After skipping these types of tests, 2890 tests remain, in total 190 files for which refactored code is generated. The testbench driver provided in the archive skips another 8 tests because they relate to features deleted in Fortran 95. In total the test suite contains 72,473 lines of code (excluding comments). Two test files contain tests that fail in gfortran 4.9 (3 tests in total).

Our compiler successfully generates refactored code for _all_ tests, and the refactored code compiles correctly and passes all tests (2887 tests in total).

Furthermore, we tested the compiler on four real-word physics simulation models:

<!--
* The 2-D Shallow Water example from the book "Ocean Modelling for Beginners: Using Open-Source Software" by Jochen Kämpf. (188 loc)
-->

* The [Large Eddy Simulator](https://github.com/wimvanderbauwhede/LES), a high-resolution turbulent flow model (1,391 loc)
* The shallow water component of [Gmodel](http://www.sciamachy-validation.org/research/CKO/gmodel.html), an ocean model (1,533 loc)
* [Flexpart-WRF](https://github.com/sajinh/flx_wrf2), a version of the Flexpart particle dispersion simulator that takes input data from WRF (13,829 loc)
* The [Linear Baroclinic Model](http://ccsr.aori.u-tokyo.ac.jp/~hiro/sub/lbm.html), an atmospheric climate model (39,336 loc)


Each of these models has a different coding style, specifically in terms of the use of common blocks, include files, etc that affect the refactoring process. All of these codes are refactored fully automatically without changes to the original code and build and run correctly. The performance of the original and refactored code is the same in all cases.

## Installation

The source code for RefactorF4ACC is written in Perl and requires v5.10 or later. There are no dependencies and no compilation is required. I have tested it on Linux and Mac OS X.

To install RefactorF4ACC:

- Put the script `refactorF4ACC.pl` in your `$PATH`
- Put the RefactorF4ACC folder somewhere where Perl will find it (e.g. `/usr/local/share/perl5`) or put it anywhere and append the path to PERL5LIB in your `.bashrc` or similar.

For example, I have `$HOME/bin` in my `$PATH`, so I put `refactorF4ACC.pl` there; and I have `PERL5LIB="$HOME/perl5/lib/perl5"` so I put the RefactorF4ACC folder there.

The directory `warnings` contains a stub for the 'use warnings qw(unused)' pragma. If you have the proper 'warnings::unused' [installed](http://search.cpan.org/dist/warnings-unused/) you can delete this folder.

The code will work with Perl v5.10 and later. To make it work with older Perl (e.g. v5.8) you would have to replace all occurrences of `say` with `print` and add a newline.

## Usage

First create a configuration file, I usually call it `rf4a.cfg`.
Once this is done, the compiler is very easy to use, simply run the script with a few optional command line flags.

### Configuration file format

The configuration file is a text file containing key-value pairs separated with an '='. Lines starting with '#' are comments.
The following keys are defined:

<dl>
<dt>TOP:</dt><dd>The name of the toplevel code unit for the analysis. Typically this is the main program name.</dd>
<dt>PREFIX:</dt><dd>The path to the directory  where the script will run. Typically this is '.'.</dd>

<dt>SRCDIRS:</dt><dd>A comma-separated list of directories (relative to PREFIX) to be searched for source files.</dd>
<dt>EXTSRCDIRS:</dt><dd>A comma-separated list of directories (relative to PREFIX) to be searched for source files.</dd>
<dt>EXCL_SRCS:</dt><dd>A regular expression matching the source files to be excluded from the analysis.</dd>
<dt>EXCL_DIRS:</dt><dd>A comma-separated list of directories (relative to PREFIX) NOT to be searched for source files.</dd>
<dt>MACRO_SRC:</dt><dd>If the sources use the C preprocessor, you can provide a file containing C preprocessor macro definitions</dd>
<dt>NEWSRCPATH:</dt><dd>Path to the directory that will contain the refactored sources</dd>

<dt>KERNEL:</dt><dd>For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP).</dd>
<dt>MODULE_SRC:</dt><dd>For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine.</dd>
<dt>MODULE:</dt><dd>For OpenCL translatation, the name of the module which contains the kernel subroutine</dd>

<dt>NO_MODULE:</dt><dd>List of source files that should not be changed to modules</dd>
<dt>RENAME_EXT:</dt><dd>Extension for variables that need to be renamed because of conflicts (usually you don't need this; the default is _GLOB)</dd>
<dt>NO_ONLY:</dt><dd>Do not use the ONLY qualifier on the USE declaration</dd>
<dt>SPLIT_LONG_LINES:</dt><dd>Split long lines into chunks of no more than 80 characters</dd>
<dt>EXT</dt><dd>Extension of generated source files. Default is `.f95`; must include the dot</dd>
<dt>LIBS</dt><dd>SCons LIBS, comma-separated list</dd>
<dt>LIBPATH</dt><dd>SCons LIBPATH, comma-separated list</dd>
<dt>INCLPATH</dt><dd>SCons F95PATH, comma-separated list</dd>
</dl>

### Command line flags

    -h: help
    -c <cfg file name>: use this cfg file (default is ~/.rf4a)
    -C: Only generate call tree, don't refactor or emit
    -g: refactor globals inside toplevel subroutine
    -b: Generate SCons build script
    -A: Annotate the refactored lines
    -P translate_to_C|translate_to_OpenCL: to translate a module to C or OpenCL
    -w: show warnings
    -v: verbose (implies -w)
    -i: show info messages
    -d: show debug messages

### Examples    

* To refactor code as explained above:

        $ refactorF4acc.pl -c ./rf4a.cfg -g

   with `rf4a.cfg` containing:

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

* To translate the refactored code to OpenCL/C:

      $ refactorF4acc.pl -P translate_to_C -c rf4a.cfg

   with `rf4a.cfg` containing:

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

### To run the NIST test suite

We use the [NIST FORTRAN78 test suite](ftp://ftp.fortran-2000.com/fcvs21_f95.tar.bz2) for validation.

      $ cd tests/NIST_F78_test_suite/fcvs21_f95


- The file `FM046.f` contains a change to TEST 759: the original test (`FM045.f`) has 57 nested parentheses, this was changed to 5 nested parentheses because the current expression parser takes too long to parse this.
- The file `FM090.f` is a modified version of `FM010.f` without spaces in types, variable names, values and labels.
- The file `FM091.f` is a modified version of `FM011.f` without spaces in types, variable names, values and labels.
- The files `FM500.f` and `FM509.f` contain tests for corner cases of common blocks and block data (37+16 tests) which we don't support.

In this folder, there are two subfolders `Test_rf4a` and  `RefactoredSources`. To verify the original test suite you can use the script `driver_parse`; to run it you can use the script `driver_run`; you may have to change the name of the Fortran compiler in `FC` at the start of these scripts.

The refactored Fortran-95 code is generated in the folder `RefactoredSources`. There are three scripts in this folder, `driver_parse`, `driver_run` and `driver_run_single`. You may have to change the name of the Fortran compiler in `FC` at the start of these scripts.

To generate the refactored Fortran-95 code for the test suite, build and run it, do:

      $ cd Test_rf4a
      $ ./generate_and_run.sh

Generating, compiling and running the test suites takes a few minutes.

The final output should look like:

        real	1m13.853s
        user	1m8.707s
        sys	0m4.152s

        # Generation of the refactored test suite code:
        TOTAL TESTS: 196
        TESTS RUN: 190
        SKIPPED: 6
        Generation Failed:
        0
        Generation Succeeded:
        190

        real	0m7.035s
        user	0m4.091s
        sys	0m1.991s

        # Compilation of the refactored test suite:

        Total  : 190
        Passed : 182
        Failed : 0
        Skipped: 8

        real	0m22.753s
        user	0m14.143s
        sys	0m5.500s

        # Running the refactored test suite:
        PASSED: 2726
        FAILED: 3
        REQUIRE INSPECTION: 161
        TOTAL: 2890