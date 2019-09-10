package RefactorF4Acc::Config;
use v5.10;
# 
#   (c) 2010-2019 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.2.0";

use warnings;
use strict;
use Exporter;

@RefactorF4Acc::Config::ISA = qw(Exporter);
@RefactorF4Acc::Config::EXPORT = qw(
$NEW_PARSER
$V $W $I $DBG $DUMMY $ANN
$NO $YES $GO
$UNREAD $INVENTORIED $READ $PARSED $FROM_BLOCK $C_SOURCE $FILE_NOT_FOUND
$SOURCEFILES
$SPLIT_LONG_LINES
$NO_ONLY
$RENAME_EXT
$EXT
$MAX_LINE_LENGTH
$LIBS $LIBPATHS $INCLPATHS
$noop
$CFG_refactor_toplevel_globals
$call_tree_only
$main_tree
$gen_sub
$translate
$targetdir
%Config
&read_rf4a_config    
&interactive_create_rf4a_cfg
);

our $NEW_PARSER = 1;

our $V = 0;    # Verbose
our $W = 0;    # Warnings
our $I = 0;    # Info
our $DBG = 0;    # Debug
our $ANN = 1; # Annotations
our $DUMMY = 0; # Dummy run, print out code rather than printing to file
our $SPLIT_LONG_LINES = 1;
our $MAX_LINE_LENGTH = 132;
our $NO_ONLY = 0;
our $RENAME_EXT = '_GLOB';
# Instead of FORTRAN's 'continue', we can insert a call to a subroutine noop() that does nothing
our $noop           = 0;
our $CFG_refactor_toplevel_globals = 0;
our $call_tree_only = 0;
our $main_tree      = 0;
our $EXT = '.f90'; # You can set this in rf4a.cfg, changed from .f95 default to .f90 default on suggestion of @rouson

our $SOURCEFILES = [];
our $LIBS = []; 
my @maybe_lib_paths = ('/opt/local/lib','/usr/local/lib');
our $LIBPATHS =  [];
for my $maybe_lib_path ( @maybe_lib_paths ) {
	if (-d $maybe_lib_path) {
		push @{$LIBPATHS}, $maybe_lib_path;
	}
} 
my @maybe_inc_paths = ('/opt/local/include','/usr/local/include');
our $INCLPATHS = [];
for my $maybe_inc_path ( @maybe_inc_paths ) {
    if (-d $maybe_inc_path) {
        push @{$INCLPATHS}, $maybe_inc_path;
    }
}
# Flag used when generating a subroutine from a marked block of code
our $gen_sub = 0;

# States for translation to C etc
( our $NO, our $YES, our $GO ) = ( 0 .. 2 );
our $translate         = $NO;

# The state of each subroutine, function or include
#   FROM_BLOCK indicates a marked block of code factored out into a subroutine
#   C_SOURCE means that this source code will be translated to C
( our $UNREAD, our $INVENTORIED, our $READ, our $PARSED, our $FROM_BLOCK, our $C_SOURCE, our $FILE_NOT_FOUND ) = ( 0 .. 6 ); #  $stref->{$srctype}{$name}{'Status'}

our $targetdir = '../RefactoredSources';
# Config supports the following keys:

#PREFIX = .
#SRCDIRS = .
#EXTSRCDIRS = ../NetCDF 

# Config should support at least the following keys:

#TOP =  flexpart_wrf
#NEWSRCPATH = RefactoredSources
#LIBPATH =
#INCPATH =
#WRF_CPP_FLAGS = NONE

#

our %Config=();

sub read_rf4a_config { 
	(my $cfgrc)=@_;
	open my $CFG, '<', $cfgrc or die $!,': ',$cfgrc;
	say "INFO: CONFIG FILE $cfgrc:" if $I;
	for my $line (<$CFG>) {
#	say "LINE:".$line;
	next if $line=~/^\s*#/;
	next unless $line=~/=/;
	print $line if $V;
	chomp $line;
	$line=~s/\s+$//;
	(my $k, my $v) = split(/\s*\=\s*/,$line);
	say "INFO: $k => $v" if $I;
	if ($v=~/,/) {
		my @vs=split(/\s*,\s*/,$v);
		$Config{$k}=[@vs];
	} elsif ($k !~/TOP\w*|NEWSRCPATH|PREFIX|KERNEL|^MODULE|MODULE_\w*|MACRO_SRC/) { # FIXME: Check this
		# These are keys that take a list but it has only one element
		$Config{$k}=[$v];
	} elsif ($k eq 'TOP') {
		$Config{$k}=lc($v);
	} else {
		$Config{$k}=$v;
	}
}
close $CFG;
}
=pod
TOP: The name of the toplevel code unit for the analysis. Typically this is the main program name.
PREFIX: The path to the directory  where the script will run. Typically this is '.'.

SRCDIRS: A comma-separated list of directories (relative to PREFIX) to be searched for source files.
EXTSRCDIRS: A comma-separated list of directories (relative to PREFIX) to be searched for source files.
EXCL_SRCS: A regular expression matching the source files to be excluded from the analysis.
EXCL_DIRS: A comma-separated list of directories (relative to PREFIX) NOT to be searched for source files.
MACRO_SRC: If the sources use the C preprocessor, you can provide a file containing C preprocessor macro definitions
NEWSRCPATH: Path to the directory that will contain the refactored sources

KERNEL: For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP).
MODULE_SRC: For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine.
MODULE: For OpenCL translatation, the name of the module which contains the kernel subroutine

NO_MODULE: List of source files that should not be changed to modules
RENAME_EXT: Extension for variables that need to be renamed because of conflicts (usually you don't need this; the default is _GLOB)
NO_ONLY: Do not use the ONLY qualifier on the USE declaration
SPLIT_LONG_LINES: Split long lines into chunks of no more than 80 characters
MAX_LINE_LENGTH: Maximum line length for fixed-format F77 code. The default is 132 characters.
EXT Extension of generated source files. Default is `.f90`; must include the dot
LIBS SCons LIBS, comma-separated list
LIBPATH SCons LIBPATH, comma-separated list
INCLPATH SCons F90PATH or F95PATH (based on EXT), comma-separated list

REFACTOR_TOPLEVEL_GLOBALS: like -g

Examples:

TOP = main
PREFIX = .
SRCDIRS = .
NEWSRCPATH = RefactoredSourcesV6
EXCL_SRCS = main_screenshot.f, test.f, ^tmp.*
EXCL_DIRS = GIS, data, RefactoredSources.*,  PostCPP,testDest.*
NO_ONLY = 0
SPLIT_LONG_LINES = 1
RENAME_EXT =  

MODULE = module_adam_bondv1_feedbf_les_press_v_etc_superkernel
MODULE_SRC = module_adam_bondv1_feedbf_les_press_v_etc_superkernel.f95
TOP = adam_bondv1_feedbf_les_press_v_etc_superkernel
KERNEL = adam_bondv1_feedbf_les_press_v_etc_superkernel
PREFIX = .
SRCDIRS = .
NEWSRCPATH = ./Temp
EXCL_SRCS = (module_sub_superkernel_init|_host|\.[^f])
EXCL_DIRS = ./PostCPP,./Temp
MACRO_SRC = macros.h
RENAME_EXT = _G
=cut

our $config_menu= {
    'BASIC' => [
        ['SRCDIRS','Relative path to the original Fortran source code','src'],
        ['NEWSRCPATH','Relative path to the refactored Fortran source code','refactored-src'],
        ['TOP', 'Name of the subroutine to start from. If this is the main program, leave blank.',''],
        ['CONFIG:ADVANCED', 'Advanced configuration? y/n','n'],
    ],
    'ADVANCED' => [
        ['PREFIX','Prefix for all relative paths','.'],
        ['EXT','Extension of refactored source files','.f90'],
        ['EXCL_SRCS', 'Source files to be excluded (comma-separated list)',''],
        ['EXCL_DIRS', 'Source folders to be excluded (comma-separated list)',''],
        ['SPLIT_LONG_LINES', 'Split long lines into chunks of no more than 80 characters? 0/1','1'],
        ['MAX_LINE_LENGTH','Maximum line length for fixed-format F77 code', '132'],
        ['CONFIG:SCONS', 'SCons-specific configuration? y/n','n'],
        ['CONFIG:OCL', 'OpenCL-specific configuration? y/n','n'],
        ['CONFIG:SUPER_ADVANCED', 'Super-dvanced configuration? y/n','n'],
    ],

    'SCONS' => [
        ['EXE','Name of executable to be build (default is program name)',''],
        ['LIBS','SCons LIBS, comma-separated list',''],
        ['LIBPATH','SCons LIBPATH, comma-separated list',''],
        ['INCLPATH','SCons F90PATH or F95PATH (based on EXT), comma-separated list','']
    ],

    'OCL' => [
        ['KERNEL','For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP)',''],
        ['MODULE_SRC','For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine',''],
        ['MODULE','For OpenCL translatation, the name of the module which contains the kernel subroutine',''],
        ['NO_MODULE','Comma-separated list of source files that should not be changed to modules','']
    ],

    'SUPER_ADVANCED' => [
        ['NO_ONLY','Generate USE without ONLY? 0/1','0'],
        ['RENAME_EXT', 'Suffix for renaming clashing variables ','_GLOB'],
        ['EVAL_PARAM_EXPRS','Evaluate RHS expression of parameter declarations? 0/1','0'],
        ['NO_MODULE','Comma-separated list of source files that should not be changed to modules',''],
        ['MACRO_SRC','Relative path to C-style header file with macro definitions','macros.h']
    ]
};

sub interactive_create_rf4a_cfg { #(my $config) = @_;
    my $lines = process_config($config_menu,'BASIC',[]);
    write_config($lines);
}

sub write_config { (my $lines) = @_;
    my $cfg='rf4a.cfg';
    if (-e $cfg) {
        say "Config file $cfg already exists. Overwrite it? y/n [n] ";
        my $value = <STDIN>;
        chomp $value;
        if ($value ne 'y') {
            say "New config file name? ";
            $cfg = <STDIN>;
            chomp $cfg;
        }
   } 
    
   say "Writing configuration to $cfg";
   open my $CFG, '>', $cfg or die $!;
    for my $line (@{$lines}) {
        say $line;
        say $CFG $line;
    }
    close $CFG;
}

sub process_config {
    (my $config, my $class, my $lines) = @_;
    for my $entry (@{$config->{$class}}) {
         (my $key, my $desc, my $default) = @{$entry};
         my $value = get_entry_value($desc, $default);
        if ($key=~/CONFIG:(\w+)/) {  
            my $class=$1;
            if ( $value eq 'y') {
                $lines = process_config($config, $class, $lines);
            }
        } else {
            if ($class eq 'BASIC') {               
                $default = '#'; # so that basic defaults will be entered in the cfg file
            }
            push @{$lines}, write_key($key, $desc, $value, $default);
        }
    }
    return $lines;
}
    
sub get_entry_value { (my $desc, my $default) = @_;
    print "$desc: [$default] ";
    my $value = <STDIN>;
    chomp $value;
    if ($value eq '') {
        $value = $default;
    }
    return $value;
}

sub  write_key { my ($key, $desc, $value, $default) = @_;
    if ($value eq $default or $value eq '') {
        # just print the commented-out key name
        return '# '.$desc."\n"."# $key = ";
    } else {
        return '# '.$desc."\n"."$key = $value";
    }
}

#interactive_create_rf4a_cfg($config);



1;
