#!/usr/bin/perl

use v5.30;
use strict;
use warnings;
use Cwd;

my $wd=cwd;
if ($wd!~/SOR_unroll/) {
    die "Run this script in '.'\n";
}


for my $unroll (1..4) {

    system("./aux/gen_macros_cfg_SConstruct.pl $unroll -s");
    chdir 'src';
    system('scons -s');
    system("OMP_NUM_THREADS=16 ./test_sor_unroll_$unroll");
    chdir $wd;
}