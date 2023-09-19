#!/usr/bin/perl 

use v5.30;
use strict;
use warnings;
use Cwd;

my $wd=cwd;
if ($wd!~/patched_autopar_/) {
    die "Run this script in 'patched_autopar_{UNROLL}'\n";
}

die 'Provide the unroll factor as arg'."\n" unless @ARGV;
my $unroll = shift @ARGV;
# my $wd = shift @ARGV;




my $cfg = <<"ENDCFG";
# Relative path to the original Fortran source code
SRCDIRS = Generated, Scalarized
# Relative path to the refactored Fortran source code
NEWSRCPATH = ../mem_reduced_inlined
# Name of the subroutine to start from. If this is the main program, leave blank.
# TOP =
EXT = .f95
RENAME_PARS_IN_INLINED_SUBS = 1
RENAME_VARS_IN_INLINED_SUBS = 1
ONE_SUB_PER_MODULE = 0

ENDCFG

open my $CFG, '>', "./MemoryReduction/rf4a_inline_${unroll}.cfg";
say $CFG $cfg;
close $CFG;

say "Generated ./MemoryReduction/rf4a_inline_$unroll.cfg";