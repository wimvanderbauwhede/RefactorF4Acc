# SOR unroll DOE

* Run the script `gen_macros_cfg_SConstruct.pl $UNROLL` to generate `macros.h` and `SConstruct` in `./src` and `rf4a_{UNROLL}` in `.`.
* Start from the code in src/
	* The file `macros.h` defines the UNROLL macro

		test it:

			scons
			./test_sor_unroll_{UNROLL}

	* Run

			run_cpp.pl -o ../src_{UNROLL}_postcpp/

		test it:

			cd ../src_{UNROLL}_postcpp/
			cp ../src/SConstruct .
			scons
			./test_sor_unroll_{UNROLL}

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

	* Running `refactorF4acc.pl -c ./rf4a_{UNROLL}.cfg`  will create an inlined version in `refactored-src_{UNROLL}/src_{UNROLL}_postcpp`

* Generate the `SConstruct` in `refactored-src_{UNROLL}/src_{UNROLL}_postcpp` by running `gen_SConstruct_refactored.pl $UNROLL`.
* In `refactored-src_{UNROLL}/src_{UNROLL}_postcpp`:
	* Build and test

			scons
			./test_sor_unroll_{UNROLL}

	* Run `../../../aux/run_autoparallel_compiler_GPU.sh`. This creates the module in Autopar_GPU
	* In `Autopar_GPU`, patch the module file to change `get_global_id()` calls to `global_id` arguments: run `../../../aux/patch_autopar_superkernel_src.pl`
	* NOTE: this also removes the substring 'superkernel_' because the memory reduction pass relies on a single superkernel.
	* NOTE: it is essential to remove the temp arrays from the superkernel argument list. This is what we should use 'Purpose' for.
	* In `Autopar_GPU/Patched`, run  `memory_reduction.pl -C`, then the inliner etc.
		* In `MemoryReduction/Generated`, test the code:

				scons
				./gen_sor_superkernel

		* Inline the code



