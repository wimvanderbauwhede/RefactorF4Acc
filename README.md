
# An Automated Fortran Code Refactoring Tool to Facilitate Acceleration of Numerical Simulations

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
  * MODULE support
  * INTENT attributes have been inferred
  * No IMPLICIT declarations, all variables are declared explicitly
  * proper DO ... END DO -loops, removal of redundant GOTO
  * All subroutines in the call tree are refactored so that there are no shared global (COMMON) variables
  * Preserves comments

* OpenCL/C translation
  * You provide the OpenCL/C translation as a pass to the compiler command line (-P translate_to_C/translate_to_OpenCL)
  * Or you simply annotate any subroutine or function to be
    translated (sorry, I think this is currently broken):
        !$ACC TRANSLATE C  
* Subroutine extraction  (sorry, I think this is currently broken)
    * simply add an annotation
          !$ACC SUBROUTINE particles_main_loop  
* Call graph generation

## How it works

* Inventory of source code by following function/subroutine call tree and include statements across all source files
* Source-to-source compiler
* Line-by-line parse, recursive descent
* Analysis of global (/COMMON/) variables and parameters
* Loop analysis to transform GOTOs and labeled DO into DO ... END DO
* IO direction analysis to determine INTENT

## Status

To assess the correctness and capability of our refactoring compiler, we used the NIST (US National Institute of Standards and Technology) [FORTRAN78 test suite](http://www.itl.nist.gov/div897/ctg/fortran_form.htm), which aims to validate adherence to the ANSI X3.9-1978 (FORTRAN 77) standard. We used [a version with some minor changes](http://www.fortran-2000.com/ArnaudRecipes/fcvs21_f95.html): All files are properly formed; a non standard conforming FORMAT statement has been fixed in test file FM110.f; Hollerith strings in FORMAT statements have been converted to quoted strings. This test suite comprises about three thousand tests organised into 192 files.

We skipped some tests because they test features that our compiler does not support. In particular, we skipped tests that use spaces in variable names and keywords (3 files, 23 tests) and tests for corner cases of common blocks and block data (2 files, 37+16 tests). After skipping these types of tests, 2867 tests remain, in total 187 files for which refactored code is generated. The testbench driver provided in the archive skips another 8 tests because they relate to features deleted in Fortran 95. In total the test suite contains 72,473 lines of code (excluding comments). Two test files contain tests that fail in gfortran 4.9 (3 tests in total).

Our compiler successfully generates refactored code for _all_ tests, and the refactored code compiles correctly and passes all tests (2864 tests in total).

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

- Put the script `refactorF4ACC.pl` in your path
- Put the RefactorF4ACC folder somewhere where Perl will find it (e.g. `/usr/local/share/perl5`) or put it anywhere and append the path to PERL5LIB in your `.bashrc` or similar.

For example, I have `/home/wim/bin` in my PATH, so I put `refactorF4ACC.pl` there; and I have `PERL5LIB="/home/wim/perl5/lib/perl5"` so I put the RefactorF4ACC folder there.

The directory 'warnings' contains a stub for the 'use warnings qw(unused)' pragma. If you have the proper 'warnings::unused' [installed](http://search.cpan.org/dist/warnings-unused/) you can delete this folder.

The code will work with Perl v5.10 and later. To make it work with older Perl (e.g. v5.8) you will have to replace all occurrences of `say` with `print` and add a newline.

## Usage

First create a configuration file, I usually call it `rf4a.cfg`.
Once this is done, the compiler is very easy to use, simply run the script with a few optional command line flags.

### Configuration file format

The configuration file is a text file containing key-value pairs separated with an '='. Lines starting with '#' are comments.
The following keys are defined:

<dl>
<dt>TOP:</dt><dd>The name of the toplevel code unit for the analysis. Typically this is the main program name.</dd>
<dt>PREFIX:</dt><dd>The path to the directory  where the script will run. Typically this is '.'.</dd>
<dt>KERNEL:</dt><dd>For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP).</dd> 
<dt>MODULE_SRC:</dt><dd>For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine.</dd>
<dt>SRCDIRS:</dt><dd>A comma-separated list of directories (relative to PREFIX) to be searched for source files.</dd> 
<dt>EXTSRCDIRS:</dt><dd>A comma-separated list of directories (relative to PREFIX) to be searched for source files.</dd>
<dt>EXCL_SRCS:</dt><dd>A regular expression matching the source files to be excluded from the analysis.</dd>		
<dt>EXCL_DIRS:</dt><dd>A comma-separated list of directories (relative to PREFIX) NOT to be searched for source files.</dd>
<dt>MACRO_SRC:</dt><dd>If the sources use the C preprocessor, you can provide a file containing C preprocessor macro definitions</dd> 
<dt>NEWSRCPATH:</dt><dd>Path to the directory that will contain the refactored sources</dd>
<dt>MODULE:</dt><dd>
<dt>NO_MODULE:</dt><dd>
<dt>RENAME_EXT:</dt><dd>Extension for variables that need to be renamed because of conflicts (usually you don't need this; the default is _GLOB)</dd>
<dt>NO_ONLY:</dt><dd>Do not use the ONLY qualifier on the USE declaration</dd>
<dt>SPLIT_LONG_LINES:</dt><dd>Split long lines into chunks of no more than 80 characters</dd>  
</dl>

### Command line flags

    -h: help
    -c <cfg file name>: use this cfg file (default is ~/.rf4a)
    -C: Only generate call tree, don't refactor or emit
    -g: refactor globals inside toplevel subroutine
    -b: Generate SCons build script
    -A: Annotate the refactored lines 
    -P: Name of pass to be performed (currently there are only two built-in passes:  translate_to_C and translate_to_OpenCL)
    -w: show warnings 
    -v: verbose (implies -w)
    -i: show info messages 
    -d: show debug messages
    
### Examples    

* For example, assuming the script is in your `$PATH`, to refactor code:

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

* For example to translate the refactored code toOpenCL/C:

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
      

