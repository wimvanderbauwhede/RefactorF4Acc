
# An Automated Fortran Code Refactoring Tool

## To Facilitate Acceleration of Numerical Simulations

Wim Vanderbauwhede

School of Computing Science, University of Glasgow, UK


## Outline

* Background
* This work
* How could this is be useful for you?
* Features
* How it works
* Status
* Practicalities
* Experimental features

## Background

* Most code for numerical simulation of weather/climate models is written in Fortran
* In particular the older codebases, written in FORTRAN77, are difficult to maintain or modify
* With the advent of multicore CPUs and GPGPUs and technologies such as OpenMP and OpenCL, there is a growing interest in acceleration of numerical simulations
* With the current state of affairs, this usually requires a considerable manual rewrite of the code.


## This work

* We have created an automatic refactoring tool for Fortran code
* Mainly useful for F77, but works for F95 too
* This tool converts F77 into F95
* It also supports annotations to extract subroutines and
  translate parts of the code to C/OpenCL

## How could this is help you?

* Are you using F77 code?
* Would you like to make it run faster?
* Would you like to upgrade to F95?
* But you don't have the time or the skill?

## Features

* F77 to F95 translation: the resulting F95 code has
  * proper F95 syntax, including types, parameters and operators
  * MODULE support
  * INTENT attributes have been inferred
  * No IMPLICIT declarations, all variables are declared explicitly
  * proper DO ... END DO -loops, removal of redundant GOTO
  * All subroutines in the call tree are refactored so that there are no shared global (COMMON) variables
  * Preserves comments
* Subroutine extraction  (sorry, I think this is currently broken)
  * simply add an annotation
        !$ACC SUBROUTINE particles_main_loop
* OpenCL/C translation
  * You simply annotate any subroutine or function to be
    translated (sorry, I think this is currently broken):
        !$ACC TRANSLATE C
  * Or you provide the OpenCL/C translation as a pass to the compiler command line (-P translate_to_C/translate_to_OpenCL)
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

• The [Large Eddy Simulator](https://github.com/wimvanderbauwhede/LES), a high-resolution turbulent flow model (1,391 loc)
• The shallow water component of [Gmodel](http://www.sciamachy-validation.org/research/CKO/gmodel.html), an ocean model (1,533 loc)
• [Flexpart-WRF](https://github.com/sajinh/flx_wrf2), a version of the Flexpart particle dispersion simulator that takes input data from WRF (13,829 loc)
• The [Linear Baroclinic Model](http://ccsr.aori.u-tokyo.ac.jp/~hiro/sub/lbm.html), an atmospheric climate model (39,336 loc)


Each of these models has a different coding style, specifically in terms of the use of common blocks, include files, etc that affect the refactoring process. All of these codes are refactored fully automatically without changes to the original code and build and run correctly. The performance of the original and refactored code is the same in all cases.

## Practicalities

* Code is written in Perl (requires v5.16 but easy to adapt down to v5.8), has no dependencies and is very easy to install, no compilation required.
* Works on Linux, OS X and similar systems

The source code for RefactorF4ACC is written in Perl and requires v5.16. There are no dependencies and no compilation is required.
To install RefactorF4ACC:

- Put the script `refactorF4ACC.pl` in your path
- Put the RefactorF4ACC folder somewhere where Perl will find it (e.g. `/usr/local/share/perl5`) or put it anywhere and append the path to PERL5LIB in your `.bashrc` or similar.

For example, I have `/home/wim/bin` in my PATH, so I put `refactorF4ACC.pl` there; and I have `PERL5LIB="/home/wim/perl5/lib/perl5"` so I put the RefactorF4ACC folder there.

The directory 'warnings' contains a stub for the 'use warnings qw(unused)' pragma. If you have the proper 'warnings::unused' [installed](http://search.cpan.org/dist/warnings-unused/) you can delete this folder.

The code will actually work with Perl v5.10 and later, if you don't have v5.16 you can search and replace the version. To make it work with older Perl (e.g. v5.8) you will have to replace all occurrences of `say` with `print` and add a newline.

## Experimental features

TBA

<!--
This compiler is a research project and we are particularly interested in automatic conversion of legacy FORTRAN77 to parallelised OpenCL code.
-->
