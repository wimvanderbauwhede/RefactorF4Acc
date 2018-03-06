#!/usr/bin/env perl
use v5.24;
use strict;
use warnings;

my @sources=qw(init.f95
sub.f95
param.f95);

my $ref_dir = '../RefactoredSources';
for my $src (@sources) {
   system("cp $ref_dir/$src .");
}

my @sources2=qw(macros.h
SConstruct.auto
generate_OpenCL_kernel.sh
rf4a_to_C.cfg
array_index_f2c1d.h);

my $ref_dir_2 = '../testDest';
for my $src (@sources2) {
#    system("cp $ref_dir_2/$src . ");
}
