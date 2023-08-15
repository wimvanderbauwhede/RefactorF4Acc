#!/usr/bin/env perl
use v5.20;
use strict;
use warnings;
die 'Provide the unroll factor as arg'."\n" unless @ARGV;
my $VV=1;
if (@ARGV==2 and $ARGV[1] eq '-s') {$VV=0;}

my $unroll = shift @ARGV;

my $scons = <<"ENDSCONS";
import os

FC=os.environ.get('FC')

fsources = ['sor_routines.f95','sor_params.f95', 'test_sor_unroll.f95']

FFLAGS = ['-Wall','-cpp','-DDYN_ALLOC','-DWITH_OPENMP','-DTIMING','-DCHECKSUM','-DUNROLL=$unroll', '-Ofast','-mcmodel=medium','-m64','-ffree-form','-ffree-line-length-0','-fconvert=little-endian','-frecord-marker=4']

envF=Environment(F95=FC,LINK=FC,F95FLAGS=FFLAGS,F95PATH=['.' ,'/usr/local/include'])

envF.Program('test_sor_unroll_$unroll',fsources,LIBS=['m'],LIBPATH=['.' ,'/usr/lib','/usr/local/lib'])


ENDSCONS

open my $SC, '>', "./src/SConstruct";
say $SC $scons;
close $SC;

say "Generated ./src/SConstruct" if $VV;

my $macros = <<"ENDMACROS";
#define UNROLL $unroll
ENDMACROS

open my $M_H, '>', "./src/macros.h";
say $M_H $macros;
close $M_H;

say "Generated ./src/macros.h" if $VV;


my $cfg = <<"ENDCFG";
# Relative path to the original Fortran source code
SRCDIRS = src_${unroll}_postcpp
# Relative path to the refactored Fortran source code
NEWSRCPATH = refactored-src_$unroll
# Name of the subroutine to start from. If this is the main program, leave blank.
# TOP =
EXT = .f95
# It's our own code, we know this is safe
RENAME_PARS_IN_INLINED_SUBS = 0
RENAME_VARS_IN_INLINED_SUBS = 0
# Need to do this for apf
FOLD_CONSTANTS = 1

ENDCFG

open my $CFG, '>', "./rf4a_$unroll.cfg";
say $CFG $cfg;
close $CFG;

say "Generated ./rf4a_$unroll.cfg" if $VV;