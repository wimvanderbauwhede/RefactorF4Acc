package RefactorF4Acc::Config;
use v5.16;
# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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
$noop
$refactor_toplevel_globals
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
# Instead of FORTRAN's 'continue', we can insert a call to a subroutine noop() that does nothing
our $noop           = 0;
our $refactor_toplevel_globals = 0;
our $call_tree_only = 0;
our $main_tree      = 0;

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
	} elsif ($k !~/TOP\w*|NEWSRCPATH|PREFIX|KERNEL|MODULE\w*|MACRO_SRC/) {
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



1;
