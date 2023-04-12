#!/usr/bin/env perl
use warnings;
use strict;

my $nruns = 10;

sub doe_runner { 
    for my $nth (1,2,4,8,16,32) {
        system("OMP_NUM_THREADS=$nth ./prog.exe");
    }
}

chdir 'Build-reference';
system('scons');
chdir '..';
doe_runner();

chdir 'mem_reduced_inlined/Generated/Patched';
system('scons');
doe_runner();


