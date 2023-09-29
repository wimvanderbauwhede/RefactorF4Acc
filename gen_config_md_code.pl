#!/usr/bin/env perl
use strict;
use warnings;
use v5.30;
our $config_menu= [
    ['BASIC' => [
        ['SRCDIRS','Relative path to the original Fortran source code','src'],
        ['NEWSRCPATH','Relative path to the refactored Fortran source code','refactored-src'],
        ['TOP', 'Name of the subroutine to start from. If this is the main program, leave blank.',''],
        ['CONFIG:ADVANCED', 'Advanced configuration? y/n','n'],
    ]],
    ['ADVANCED' => [
        ['PREFIX','Prefix for all relative paths','.'],
        ['EXT','Extension of refactored source files','.f90'],
        ['EXCL_SRCS', 'Source files to be excluded (comma-separated list)',''],
        ['EXCLUDE_ALL_SUBDIRS','Exclude all subfolders in the source folder? 0/1','0'],
        ['EXCL_DIRS', 'Source folders to be excluded (comma-separated list)',''],
        ['INLINE_INCLUDES', 'Inline all include files? 0/1','0'],
        ['SPLIT_LONG_LINES', 'Split long lines into chunks of no more than 80 characters? 0/1','1'],
        ['MAX_LINE_LENGTH','Maximum line length for fixed-format F77 code', '132'],
        ['ALLOW_SPACES_IN_NUMBERS','Allow spaces in numeric constants for fixed-format F77 code? 0/1', '0'],
        ['PRESERVE_CASE','Treat the source code as if it is case-sensitive? 0/1','0'],
        ['NO_SAVE','Delete SAVE statements? 0/1','1'],
        ['STRICT_COMMONS_CHECKS','Stop if COMMON blocks are not type-safe? 0/1', '0'],
        ['CONFIG:SCONS', 'SCons-specific configuration? y/n','n'],
        ['CONFIG:OCL', 'OpenCL-specific configuration? y/n','n'],
        ['CONFIG:CUSTOM', 'Custom pass-specific configuration? y/n','n'],
        ['CONFIG:SUPER_ADVANCED', 'Super-dvanced configuration? y/n','n'],
    ]],

    ['SCONS' => [
        ['EXE','Name of executable to be build (default is program name)',''],
        ['LIBS','SCons LIBS, comma-separated list',''],
        ['LIBPATH','SCons LIBPATH, comma-separated list',''],
        ['INCLPATH','SCons F90PATH or F95PATH (based on EXT), comma-separated list',''],
        ['HAS_F77_SOURCES','Tells SCons to add the F77 compiler as well as the F90 compiler? 0/1','0'],
        ['FFLAGS','SCons FFLAGS, comma-separated list',''],
        ['F77FLAGS','SCons F77FLAGS, comma-separated list',''],
        ['F90FLAGS','SCons F77FLAGS, comma-separated list',''],
    ]],

    ['OCL' => [
        ['KERNEL','For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP)',''],
        ['MODULE_SRC','For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine',''],
        ['MODULE','For OpenCL translatation, the name of the module which contains the kernel subroutine',''],
        ['NO_MODULE','Comma-separated list of source files that should not be changed to modules','']
    ]],

    ['CUSTOM' => [
        ['CUSTOM_PASS_OUTPUT_PATH','Output path for custom pass','']
    ]],

    ['SUPER_ADVANCED' => [
        ['NO_ONLY','Generate USE without ONLY? 0/1','0'],
        ['RENAME_EXT', 'Suffix for renaming clashing variables ','_GLOB'],
        ['EVAL_PARAM_EXPRS','Evaluate RHS expression of parameter declarations? 0/1','0'],
        ['RENAME_PARS_IN_INLINED_SUBS','Rename parameters in inlined subroutines (to avoid name conflicts)? 0/1','0'],
        ['RENAME_VARS_IN_INLINED_SUBS','Rename variables in inlined subroutines (to avoid name conflicts)? 0/1','0'],
        ['FOLD_CONSTANTS','Fold constants (replace parameters by their values)? 0/1','0'],
        ['NO_MODULE','Comma-separated list of source files that should not be changed to modules',''],
        ['MACRO_SRC','Relative path to C-style header file with macro definitions','macros.h'],
        ['ONE_SUB_PER_MODULE', 'Create a module for each subroutine? 0/1','1'],
        ['PURPOSE_CFG','Relative path to the Purpose configuration','purpose.cfg']
    ]]
];



for my $pair (@{$config_menu}) {

    my $rubric = $pair->[0];
    say '#### '."$rubric\n";
    say '<dl>';
    my $options = $pair->[1];
    for my $option (@{$options}) {
        my ($key, $desc, $default) = @{$option};    
        say "<dt>$key:</dt><dd>$desc [$default]</dd>";
    }
     say '</dl>';
     say '';
}
