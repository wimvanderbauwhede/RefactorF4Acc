package RefactorF4Acc::Config;
use v5.10;
# 
#   (c) 2010-2019 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

use warnings;
use strict;
use Exporter;

@RefactorF4Acc::Config::ISA = qw(Exporter);
@RefactorF4Acc::Config::EXPORT = qw(
$NEW_PARSER
$V $W $WW $I $DBG $DUMMY $ANN
$NO $YES $GO
$UNREAD $INVENTORIED $READ $PARSED $FROM_BLOCK $C_SOURCE $FILE_NOT_FOUND $UNUSED
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
# $SPLIT_LONG_LINES
# $NO_ONLY
# $MAX_LINE_LENGTH

# $SOURCEFILES
# $RENAME_EXT
# $EXT
# 
# $LIBS $LIBPATHS $INCLPATHS
our $NEW_PARSER = 1;


our $V = 0;    # Verbose
our $W = 0;    # Warnings
our $WW = 0; # Extended warnings
our $I = 0;    # Info
our $DBG = 0;    # Debug
our $ANN = 1; # Annotations
our $DUMMY = 0; # Dummy run, print out code rather than printing to file

# Default configuration
my $SPLIT_LONG_LINES = 1;
my $MAX_LINE_LENGTH = 132;
my $NO_ONLY = 0;
my $RENAME_EXT = '_GLOB';
my $EXT = '.f90'; # You can set this in rf4a.cfg, changed from .f95 default to .f90 default on suggestion of @rouson

our $LIBS = []; 
our $LIBPATHS =  [];
our $INCLPATHS = [];

# Instead of FORTRAN's 'continue', we can insert a call to a subroutine noop() that does nothing
our $noop           = 0;
our $CFG_refactor_toplevel_globals = 0;
our $call_tree_only = 0;
our $main_tree      = 0;


# our $SOURCEFILES = [];


# Flag used when generating a subroutine from a marked block of code
our $gen_sub = 0;

# States for translation to C etc
( our $NO, our $YES, our $GO ) = ( 0 .. 2 );
our $translate         = $NO;

# The state of each subroutine, function or include
#   FROM_BLOCK indicates a marked block of code factored out into a subroutine
#   C_SOURCE means that this source code will be translated to C
( our $UNREAD, our $INVENTORIED, our $READ, our $PARSED, our $FROM_BLOCK, our $C_SOURCE, our $FILE_NOT_FOUND , our $UNUSED) = ( 0 .. 7 ); #  $stref->{$srctype}{$name}{'Status'}

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

our %Config=(
'INLINE_INCLUDES' => 0,
'SPLIT_LONG_LINES' => $SPLIT_LONG_LINES,
'MAX_LINE_LENGTH' =>  $MAX_LINE_LENGTH,
'NO_ONLY' => $NO_ONLY,
'RENAME_EXT' => $RENAME_EXT,
'EXT' => $EXT,
'ALLOW_SPACES_IN_NUMBERS' => 0,
'HAS_F77_SOURCES' => 0,
'LIBS' => [], 
'LIBPATHS' => [], 


'TOP' => '',
'PREFIX' => '.',

'SRCDIRS' => [],
'EXTSRCDIRS'  => [],
'EXCL_SRCS' => [],
'EXCL_DIRS'  => [],
'MACRO_SRC' => '',
'NEWSRCPATH' => '',
'SOURCEFILES'  => [],

'KERNEL' => '',
'MODULE_SRC' => '',
'MODULE'  => '',

'NO_MODULE'  => [],

'SUB_SUFFIX'  => '',
'REFACTOR_TOPLEVEL_GLOBALS' => 1,
'EVAL_PARAM_EXPRS'  => 0,

'TEST'   => 0,
'CUSTOM_PASS_OUTPUT_PATH' => '',
'INCLPATH' => [],
'F90PATH'  => [],
'F95PATH' => [],
'F77PATH' => [],
'FFLAGS'  => ['-cpp','-O3', '-m64', '-ffree-form', '-ffree-line-length-0','-fconvert=little-endian', '-frecord-marker=4'],
'F77FLAGS'  => ['-cpp','-O3', '-m64', '-fconvert=little-endian', '-frecord-marker=4'],

);

my @maybe_lib_paths = ('/usr/lib','/opt/local/lib','/usr/local/lib');

for my $maybe_lib_path ( @maybe_lib_paths ) {
	if (-d $maybe_lib_path) {
		push @{ $Config{'LIBPATHS'} }, $maybe_lib_path;
	}
} 
my @maybe_inc_paths = ('/opt/local/include','/usr/local/include');

for my $maybe_inc_path ( @maybe_inc_paths ) {
    if (-d $maybe_inc_path) {
        push @{$Config{'INCLPATH'}}, $maybe_inc_path;
    }
}

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
    if (ref($Config{$k}) eq 'ARRAY') {
		my @vs=split(/\s*,\s*/,$v);
		$Config{$k}=[@vs];
	} elsif ($k eq 'TOP') {
		$Config{$k}=lc($v);
    } else {
        $Config{$k}=$v;
    }


	say "INFO: $k => $v" if $I;

}
close $CFG;
}
=pod
TOP :: String: The name of the toplevel code unit for the analysis. Typically this is the main program name. 
PREFIX :: String: The path to the directory  where the script will run. Typically this is '.'.

SRCDIRS :: [String]: A comma-separated list of directories (relative to PREFIX) to be searched for source files.
EXTSRCDIRS :: [String]: A comma-separated list of directories (relative to PREFIX) to be searched for source files.
EXCL_SRCS :: Regex: A regular expression matching the source files to be excluded from the analysis.
EXCL_DIRS :: [String]: A comma-separated list of directories (relative to PREFIX) NOT to be searched for source files.
MACRO_SRC :: String: If the sources use the C preprocessor, you can provide a file containing C preprocessor macro definitions
NEWSRCPATH :: String: Path to the directory that will contain the refactored sources
SOURCEFILES :: [String]: A comma-separated list of source files to be refactored. Same as specifying -s on command line

KERNEL :: String: For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP).
MODULE_SRC :: String: For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine.
MODULE :: String: For OpenCL translatation, the name of the module which contains the kernel subroutine

NO_MODULE :: [String]: List of source files that should not be changed to modules
RENAME_EXT  :: String: Extension for variables that need to be renamed because of conflicts (usually you don't need this; the default is _GLOB)
NO_ONLY :: 0 | 1: Do not use the ONLY qualifier on the USE declaration
SPLIT_LONG_LINES :: 0 | 1: Split long lines into chunks of no more than 80 characters
MAX_LINE_LENGTH :: Int: Maximum line length for fixed-format F77 code. The default is 132 characters.
ALLOW_SPACES_IN_NUMBERS :: 0 | 1: Allow spaces in numeric constants for fixed-format F77 code. Default 0.

EXT :: String: Extension of generated source files. Default is `.f90`; must include the dot
LIBS :: [String]: SCons LIBS, comma-separated list
LIBPATH :: [String]: SCons LIBPATH, comma-separated list
INCLPATH :: [String]: SCons F90PATH or F95PATH (based on EXT), comma-separated list
SUB_SUFFIX :: [String]: a suffix for all subroutine names. Default is of course blank.
REFACTOR_TOPLEVEL_GLOBALS :: 0 | 1:: like -g
EVAL_PARAM_EXPRS ::  0|1: Evaluate RHS expression of parameter declarations, default is 0.

TEST :: 0|1 : for internal use
CUSTOM_PASS_OUTPUT_PATH :: String: Output path for custom passes
F90PATH, F95PATH: Aliases for INCLPATH

FFLAGS  = '-cpp','-O3', '-m64', '-freal-4-real-8', '-ffree-form', '-ffree-line-length-0','-fconvert=little-endian', '-frecord-marker=4'
F77FLAGS  = '-cpp','-O3', '-m64', '-freal-4-real-8','-std=legacy', '-fconvert=little-endian', '-frecord-marker=4'

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
        ['INLINE_INCLUDES', 'Inline all include files? 0/1','0'],
        ['SPLIT_LONG_LINES', 'Split long lines into chunks of no more than 80 characters? 0/1','1'],
        ['MAX_LINE_LENGTH','Maximum line length for fixed-format F77 code', '132'],
        ['ALLOW_SPACES_IN_NUMBERS','Allow spaces in numeric constants for fixed-format F77 code', '0'],
        ['CONFIG:SCONS', 'SCons-specific configuration? y/n','n'],
        ['CONFIG:OCL', 'OpenCL-specific configuration? y/n','n'],
        ['CONFIG:SUPER_ADVANCED', 'Super-dvanced configuration? y/n','n'],
    ],

    'SCONS' => [
        ['EXE','Name of executable to be build (default is program name)',''],
        ['LIBS','SCons LIBS, comma-separated list',''],
        ['LIBPATH','SCons LIBPATH, comma-separated list',''],
        ['INCLPATH','SCons F90PATH or F95PATH (based on EXT), comma-separated list',''],
        ['HAS_F77_SOURCES','Tells SCons to add the F77 compiler as well as the F90 compiler','0'],
        ['FFLAGS','SCons FFLAGS, comma-separated list',''],
        ['F77FLAGS','SCons F77FLAGS, comma-separated list',''],
        ['F90FLAGS','SCons F77FLAGS, comma-separated list',''],
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
