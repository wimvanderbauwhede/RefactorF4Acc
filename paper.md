---
title: 'The Glasgow Fortran Source-to-Source Compiler'
tags:
  - FORTRAN77
  - refactoring
  - source-to-source compiler
authors:
 - name: Wim Vanderbauwhede
   orcid: 0000-0001-6768-0037
   affiliation: 1
affiliations:
 - name: University of Glasgow School of Computing Science
   index: 1
date: 1 June 2017
bibliography: paper.bib
---

# Summary

The Glasgow Fortran Source-to-Source Compiler is a source-to-source compiler that automatically refactors legacy FORTRAN77 code into modern and maintainable Fortran-95 code that is ready for acceleration with OpenCL, OpenMP, OpenACC etc. This is the main purpose of the compiler. It also allows to translate code into C and the OpenCL kernel language to further assist with acceleration of code, and is an essential component of our toolchain for automatic parallelization of Fortran code using OpenCL [@Vanderbauwhede:2018].

The compiler is entirely self-contained and written in Perl.

The compiler is intended to work on typical scientific simulation code, but it works on the complete NIST [FORTRAN78 test suite](http://www.itl.nist.gov/div897/ctg/fortran_form.htm).

Our compiler successfully generates refactored code for _all_ tests, and the refactored code compiles correctly and passes all tests (2887 tests in total). The tests are available in the repository under `tests/NIST_F78_test_suite`.

Furthermore, we tested the compiler on four real-word physics simulation models:

* The 2-D Shallow Water example from the book "Ocean Modelling for Beginners: Using Open-Source Software" by Jochen Kämpf. (188 loc), available in `tests/ShallowWater2D`.
* The [Large Eddy Simulator](https://github.com/wimvanderbauwhede/LES), a high-resolution turbulent flow model (1,391 loc)
* The shallow water component of [Gmodel](http://www.sciamachy-validation.org/research/CKO/gmodel.html), an ocean model (1,533 loc)
* [Flexpart-WRF](https://github.com/sajinh/flx_wrf2), a version of the Flexpart particle dispersion simulator that takes input data from WRF (13,829 loc)
* The [Linear Baroclinic Model](http://ccsr.aori.u-tokyo.ac.jp/~hiro/sub/lbm.html), an atmospheric climate model (39,336 loc)

Each of these models has a different coding style, specifically in terms of the use of common blocks, include files, etc that affect the refactoring process. All of these codes are refactored fully automatically without changes to the original code and build and run correctly. The performance of the original and refactored code is the same in all cases.

# References
