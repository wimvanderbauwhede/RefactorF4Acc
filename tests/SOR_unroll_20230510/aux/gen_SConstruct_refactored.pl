#!/usr/bin/env perl
use v5.20;
use strict; 
use warnings;
die 'Provide the unroll factor and WD as arg'."\n" unless @ARGV;
my $unroll = shift @ARGV;
my $wd = shift @ARGV;
my $scons = <<"ENDSCONS";
import os

FC=os.environ.get('FC')

fsources = ['sor_params.f95','sor_kernel.f95','sor.f95','sor_routines.f95','sor_superkernel.f95',
'test_sor_unroll.f95' ]

# no-automatic means no allocation on the stack
FFLAGS = ['-Wall', '-O3','-mcmodel=medium','-fno-automatic', '-ffree-form','-ffree-line-length-0']

envF=Environment(F95=FC,LINK=FC,F95FLAGS=FFLAGS,F95PATH=['.' ,'/usr/local/include'])

envF.Program('test_sor_unroll_${unroll}_$wd',fsources,LIBS=['m'],LIBPATH=['.' ,'/usr/lib','/usr/local/lib'])

ENDSCONS

open my $SC, '>', "./refactored-src_${unroll}_$wd/src_${unroll}_${wd}_postcpp/SConstruct";
say $SC $scons;
close $SC;

say "Generated ./refactored-src_${unroll}_$wd/src_${unroll}_${wd}_postcpp/SConstruct";