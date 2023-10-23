### To run the NIST test suite

We use the [NIST FORTRAN78 test suite](ftp://ftp.fortran-2000.com/fcvs21_f95.tar.bz2) for validation. The original F77 files are in `fcvs21_f95`. There are a few small changes compared to the original test suite:§

      - The file `FM046.f` contains a change to TEST 759: the original test (`FM045.f`) has 57 nested parentheses, this was changed to 5 nested parentheses because the current expression parser takes too long to parse this.
      - The file `FM090.f` is a modified version of `FM010.f` without spaces in types, variable names, values and labels.
      - The file `FM091.f` is a modified version of `FM011.f` without spaces in types, variable names, values and labels.
      - The file `FM501.f` is a tiny change to `FM500.f`: in TEST 13, on line 341, the integer NYVI is multiplied by 1.0 to appease the format:
                 WRITE (NWVI,80028) NYVI*1.0
      - The file `FM509.f` is skipped as it no longer compiles.

In the folder `fcvs21_f95`, there are two subfolders `Test_rf4a` and  `RefactoredSources`. To verify the original test suite you can use the script `driver_parse`; to run it you can use the script `driver_run`; you may have to change the name of the Fortran compiler in `FC` at the start of these scripts.

The refactored Fortran-95 code is generated in the folder `RefactoredSources`. There are three scripts in this folder, `driver_parse`, `driver_run` and `driver_run_single`. You may have to change the name of the Fortran compiler in `FC` at the start of these scripts. Please ensure that the environment varianble `$FC` is set to the Fortran compiler you want to use. I have tested the code only with `gfortran 9.4` on Linux and `gfortran 13.1` on MacOS.


To generate the refactored Fortran-95 code for the test suite, build and run it, do:

      $ cd fcvs21_f95/Test_rf4a
      $ ./generate_and_run.sh

Generating, compiling and running the test suites takes a few minutes.

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

With the current version (6.1.0), the failing tests are:

FM406 test 3,
FM923 tests 22 and 23, 
FM302 tests 4 and 14

These tests also fail in the original code with gfortran.

The other failing is FM302 test 13

      C     ****  FCVS PROGRAM 302  -  TEST 013  ****                      
      C                                                                    
      C          TEST 013 IS DESIGNED TO TEST THE EXTENSION OF NAMED COMMON
      C     BLOCK STORAGE BY EQUIVALENCE ASSOCIATION OF A VARIABLE AND AN  
      C     ARRAY.          

And a further 4 tests in FM501 (the minor modification of FM500):

    13     FAIL
                 COMPUTED=  0.00000E+00
                 CORRECT=      34

This is a genuine failure, because the test is

      REAL VARIABLE - EQUIVALENCED INTEGER

and this is a type error because the equivalence is at byte level, whereas rf4a refactors this through casting.
The specified behaviour can't be made type safe, and I am not supporting it. 

The other three failures in FM500 are:

    15     FAIL
                 COMPUTED=  0.3489999872D+10
                 CORRECT=   0.3490000000D+10
    16     FAIL
                 COMPUTED=  0.2122999907D+01
                 CORRECT=   0.2123000000D+01
    17     FAIL
                 COMPUTED=  0.8738400269D+02
                 CORRECT=   0.8738400000D+02

These are simply rounding errors.

