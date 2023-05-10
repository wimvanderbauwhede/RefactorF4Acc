#!/usr/bin/env perl
use warnings;
use strict;

# Run in Build-reference

my $nruns = 10;

sub doe_runner { 
    for my $nth (1,2,4,8,16,32){#,64,128,256) {
        print $nth;
        for my $run (1..$nruns) {
            print ',';
        system("OMP_NUM_THREADS=$nth ./prog-dyn-omp.exe");
        }
        print "\n";
        }
}

for my $WM (1,2) {
    print $WM,"\n";
system("WM=$WM scons -s -f SConstruct.dyn.omp");

doe_runner();
}
