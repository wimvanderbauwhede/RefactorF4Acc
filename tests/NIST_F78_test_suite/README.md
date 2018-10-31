### To run the NIST test suite

We use the [NIST FORTRAN78 test suite](ftp://ftp.fortran-2000.com/fcvs21_f95.tar.bz2) for validation. The original F77 files are in `fcvs21_f95`. There are a few small changes compared to the original test suite:§

      - The file `FM046.f` contains a change to TEST 759: the original test (`FM045.f`) has 57 nested parentheses, this was changed to 5 nested parentheses because the current expression parser takes too long to parse this.
      - The file `FM090.f` is a modified version of `FM010.f` without spaces in types, variable names, values and labels.
      - The file `FM091.f` is a modified version of `FM011.f` without spaces in types, variable names, values and labels.
      - The files `FM500.f` and `FM509.f` contain tests for corner cases of common blocks and block data (37+16 tests) which we don't support.

In the folder `fcvs21_f95`, there are two subfolders `Test_rf4a` and  `RefactoredSources`. To verify the original test suite you can use the script `driver_parse`; to run it you can use the script `driver_run`; you may have to change the name of the Fortran compiler in `FC` at the start of these scripts.

The refactored Fortran-95 code is generated in the folder `RefactoredSources`. There are three scripts in this folder, `driver_parse`, `driver_run` and `driver_run_single`. You may have to change the name of the Fortran compiler in `FC` at the start of these scripts. Please ensure that the environment varianble `$FC` is set to the Fortran compiler you want to use. I have tested the code only with `gfortran 4.9` and `gfortran 7.0`.


To generate the refactored Fortran-95 code for the test suite, build and run it, do:

      $ cd fcvs21_f95/Test_rf4a
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
        PASSED: 2719
        FAILED: 4
        REQUIRE INSPECTION: 161
        TOTAL: 2884 

With the current version (1.1.0), the failing tests are FM406 test 3 and FM923 tests 22 and 23, these tests also fail in the original code with gfortran.
The other failing test is FM308 test 57, this is because the current version does not refactor common blocks in functions, only in subroutines.

