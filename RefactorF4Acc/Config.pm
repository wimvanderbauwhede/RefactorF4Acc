package RefactorF4Acc::Config;
use v5.10;
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use warnings;
use strict;
use Exporter;

@RefactorF4Acc::Config::ISA = qw(Exporter);
@RefactorF4Acc::Config::EXPORT = qw(
$VER
$V $W $I $DBG $DUMMY $ANN
$NO $YES $GO
$UNREAD $INVENTORIED $READ $PARSED $FROM_BLOCK $C_SOURCE
$SPLIT_LONG_LINES
$NO_ONLY
$RENAME_EXT
$EXT
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
);

our $VER = '0.3';

our $V = 0;    # Verbose
our $W = 0;    # Warnings
our $I = 0;    # Info
our $DBG = 0;    # Debug
our $ANN = 1; # Annotations
our $DUMMY = 0; # Dummy run, print out code rather than printing to file
our $SPLIT_LONG_LINES = 1;
our $NO_ONLY = 0;
our $RENAME_EXT = '_GLOB';
# Instead of FORTRAN's 'continue', we can insert a call to a subroutine noop() that does nothing
our $noop           = 0;
our $CFG_refactor_toplevel_globals = 0;
our $call_tree_only = 0;
our $main_tree      = 0;
our $EXT = '.f95'; # TODO: get from rf4a.cfg

our $LIBS = []; 
our $LIBPATHS =  ['/opt/local/lib','/usr/local/lib'];
our $INCLPATHS = ['/opt/local/include','/usr/local/include'];
# Flag used when generating a subroutine from a marked block of code
our $gen_sub = 0;

# States for translation to C etc
( our $NO, our $YES, our $GO ) = ( 0 .. 2 );
our $translate         = $NO;

# The state of each subroutine, function or include
#   FROM_BLOCK indicates a marked block of code factored out into a subroutine
#   C_SOURCE means that this source code will be translated to C
( our $UNREAD, our $INVENTORIED, our $READ, our $PARSED, our $FROM_BLOCK, our $C_SOURCE ) = ( 0 .. 5 ); #  $stref->{$srctype}{$name}{'Status'}

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
	} elsif ($k !~/TOP\w*|NEWSRCPATH|PREFIX|KERNEL|MODULE_\w*|MACRO_SRC/) { # FIXME: Check this
		# These are key that take a list but it has only one element
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
TOP: 			The name of the toplevel code unit for the analysis. Typically this is the main program name.
PREFIX:			The path to the directory  where the script will run. Typically this is '.'
KERNEL:			For OpenCL translatation, the name of the subroutine to become the OpenCL kernel (actually same as TOP) 
MODULE_SRC:		For OpenCL translatation, the name of the source file containing a module which contains the kernel subroutine
SRCDIRS: 		A comma-separated list of directories (relative to PREFIX) to be searched for source files. 
EXTSRCDIRS:		A comma-separated list of directories (relative to PREFIX) to be searched for source files.
EXCL_SRCS:		A regular expression matching the source files to be excluded from the analysis.		
EXCL_DIRS:		A comma-separated list of directories (relative to PREFIX) NOT to be searched for source files.
NO_MODULE
MACRO_SRC:		If the sources use the C preprocessor, you can provide a file containing C preprocessor macro definitions 
NEWSRCPATH:		Path to the directory that will contain the refactored sources
MODULE:
RENAME_EXT:		Extension for variables that need to be renamed because of conflicts (usually you don't need this)
NO_ONLY:		Do not use the ONLY qualifier on the USE declaration
SPLIT_LONG_LINES: Split long lines into chunks of no more than 80 characters
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


1;
