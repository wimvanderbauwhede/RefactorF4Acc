# Configuration options and defaults

For version 2.1.1, generated Mon Oct 16 11:00:37 2023

## RefactorF4Acc configuration support

To configure the refactoring and code generation, `rf4a` has many options.
If you run `rf4a` without any flags, it will look in the current directory for a configuration file `rf4a.cfg`.
If that file does not exist, it will present you with a text-based wizard to create the configuration.
The configuration file is a text file containing key-value pairs separated with an '='. Lines starting with '#' are comments.
The supported options and their defaults are listed below. 
This file is generated from `RefactorF4Acc/Config.pm` using `bin/generate_Markdown_from_Config.pl`

## RefactorF4Acc configuration options and defaults

### Basic

<dl>
<dt>TOP:</dt><dd>Name of the subroutine to start from. If this is the main program, leave blank. []</dd>
<dt>SRCDIRS:</dt><dd>Relative path to the original Fortran source code (comma-separated list) [src]</dd>
<dt>NEWSRCPATH:</dt><dd>Relative path to the refactored Fortran source code [refactored-src]</dd>
<dt>STRICT_COMMONS_CHECKS:</dt><dd>Return ERROR if COMMON blocks are not type-safe? 0/1 [1]</dd>
<dt>STRICT_EQUIVALENCE_CHECKS:</dt><dd>Return ERROR if EQUIVALENCE statements are not type-safe? 0/1 [1]</dd>
<dt>IGNORE_ERRORS:</dt><dd>Ignore errors and continue code generation? 0/1 [0]</dd>
<dt>CONFIG:ADVANCED:</dt><dd>Advanced configuration? y/n [n]</dd>
</dl>

### Advanced

<dl>
<dt>PREFIX:</dt><dd>Prefix for all relative paths [.]</dd>
<dt>EXTSRCDIRS:</dt><dd>Comma-separated list of directories (relative to PREFIX) to be searched for source files (these will not be refactored) []</dd>
<dt>EXT:</dt><dd>Extension of refactored source files [.f90]</dd>
<dt>EXCL_SRCS:</dt><dd>Source files to be excluded (comma-separated list) []</dd>
<dt>EXCLUDE_ALL_SUBDIRS:</dt><dd>Exclude all subfolders in the source folder? 0/1 [0]</dd>
<dt>EXCL_DIRS:</dt><dd>Source folders to be excluded (comma-separated list) []</dd>
<dt>INLINE_INCLUDES:</dt><dd>Inline all include files? 0/1 [0]</dd>
<dt>SPLIT_LONG_LINES:</dt><dd>Split long lines into chunks of no more than 80 characters? 0/1 [1]</dd>
<dt>MAX_LINE_LENGTH:</dt><dd>Maximum line length for fixed-format F77 code [132]</dd>
<dt>ALLOW_SPACES_IN_NUMBERS:</dt><dd>Allow spaces in numeric constants for fixed-format F77 code? 0/1 [0]</dd>
<dt>PRESERVE_CASE:</dt><dd>Treat the source code as if it is case-sensitive? 0/1 [0]</dd>
<dt>NO_SAVE:</dt><dd>Delete SAVE statements? 0/1 [1]</dd>
<dt>CONFIG:SCONS:</dt><dd>SCons-specific configuration? y/n [n]</dd>
<dt>CONFIG:OCL:</dt><dd>OpenCL-specific configuration? y/n [n]</dd>
<dt>CONFIG:CUSTOM:</dt><dd>Custom pass-specific configuration? y/n [n]</dd>
<dt>CONFIG:SUPER_ADVANCED:</dt><dd>Super-dvanced configuration? y/n [n]</dd>
</dl>

### Scons

<dl>
<dt>EXE:</dt><dd>Name of executable to be build (default is program name) []</dd>
<dt>LIBS:</dt><dd>SCons LIBS, comma-separated list []</dd>
<dt>LIBPATHS:</dt><dd>SCons LIBPATH, comma-separated list []</dd>
<dt>INCLPATH:</dt><dd>SCons F90PATH or F95PATH (based on EXT), comma-separated list []</dd>
<dt>HAS_F77_SOURCES:</dt><dd>Tells SCons to add the F77 compiler as well as the F90 compiler? 0/1 [0]</dd>
<dt>FFLAGS:</dt><dd>SCons FFLAGS, comma-separated list ['-cpp','-O3', '-m64', '-ffree-form', '-ffree-line-length-0','-fconvert=little-endian', '-frecord-marker=4']</dd>
<dt>F77FLAGS:</dt><dd>SCons F77FLAGS, comma-separated list ['-cpp','-O3', '-m64', '-fconvert=little-endian', '-frecord-marker=4']</dd>
<dt>F90FLAGS:</dt><dd>SCons F77FLAGS, comma-separated list []</dd>
</dl>

### OpenCL

<dl>
<dt>KERNEL:</dt><dd>For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP) []</dd>
<dt>MODULE_SRC:</dt><dd>For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine []</dd>
<dt>MODULE:</dt><dd>For OpenCL translatation, the name of the module which contains the kernel subroutine []</dd>
<dt>NO_MODULE:</dt><dd>Comma-separated list of source files that should not be changed to modules []</dd>
</dl>

### Custom

<dl>
<dt>CUSTOM_PASS_OUTPUT_PATH:</dt><dd>Output path for custom pass []</dd>
</dl>

### Super advanced

<dl>
<dt>NO_ONLY:</dt><dd>Generate USE without ONLY? 0/1 [0]</dd>
<dt>RENAME_EXT:</dt><dd>Suffix for renaming clashing variables  [_GLOB]</dd>
<dt>EVAL_PARAM_EXPRS:</dt><dd>Evaluate RHS expression of parameter declarations? 0/1 [0]</dd>
<dt>RENAME_PARS_IN_INLINED_SUBS:</dt><dd>Rename parameters in inlined subroutines (to avoid name conflicts)? 0/1 [0]</dd>
<dt>RENAME_VARS_IN_INLINED_SUBS:</dt><dd>Rename variables in inlined subroutines (to avoid name conflicts)? 0/1 [0]</dd>
<dt>FOLD_CONSTANTS:</dt><dd>Fold constants (replace parameters by their values)? 0/1 [0]</dd>
<dt>NO_MODULE:</dt><dd>Comma-separated list of source files that should not be changed to modules []</dd>
<dt>ONE_SUB_PER_MODULE:</dt><dd>Create a module for each subroutine? 0/1 [1]</dd>
<dt>SOURCEFILES:</dt><dd>Comma-separated list of source files to be refactored. Same as specifying -s on command line []</dd>
<dt>MACRO_SRC:</dt><dd>Relative path to C-style header file with macro definitions [macros.h]</dd>
<dt>PURPOSE_CFG:</dt><dd>Relative path to the Purpose configuration [purpose.cfg]</dd>
</dl>

