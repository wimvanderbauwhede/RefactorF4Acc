# SOR unroll DOE

* Start from the code in src/
	* The file `macros.h` defines the UNROLL macro
	* Run

			run_cpp.pl -o ../src_{UNROLL}_postcpp/


* In the main directory:
	* The `rf4a_{UNROLL}.cfg` file should be generated. It is trivial:

			# Relative path to the original Fortran source code
			SRCDIRS = src_1
			# Relative path to the refactored Fortran source code
			NEWSRCPATH = refactored-src_1
			# Name of the subroutine to start from. If this is the main program, leave blank.
			# TOP = 
			EXT = .f95

		Although maybe we also need

			# It's our own code, we know this is safe
			RENAME_PARS_IN_INLINED_SUBS = 0
			RENAME_VARS_IN_INLINED_SUBS = 0
			# Need to do this for apf
			FOLD_CONSTANTS = 1

	* Running refactorF4acc.pl will create an inlined version in `refactored-src_{UNROLL}/src_{UNROLL}_postcpp`

* In `refactored-src_{UNROLL}/src_{UNROLL}_postcpp`
	* Patch the code: remove `use sor_routines` from `test_sor_unroll.f95` and `use sor_params` from `sor_superkernel.f95`
	* `sor_params.f95` is empty, copy it from `src_{UNROLL}_postcpp`
	* Build and run
	* Run `run_autoparallel_compiler.sh`, I guess with GPU as arg1 and no arg2
	* Create a script `run_autoparallel_compiler.sh` and run it:
			
			AutoParallel-Fortran-exe ./sor_superkernel.f95 -out ./Autopar_$1$2/ -main ./test_sor_unroll.f95 -v -plat $1 -N -X NO_IO -v 

This will create the module in Autopar_GPU 

Then we should run  memory_reduction.pl -C on that file, then the inliner etc.



