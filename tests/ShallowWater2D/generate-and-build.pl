#!/usr/bin/env perl
use warnings;
use strict;
use v5.10;
use RefactorF4Acc::Main qw( main usage );

chdir 'fortran';
&main({'b'=>1});
chdir '../RefactoredSources';
if ('' ne `which scons`) {
    if (-e 'main.o') {
        system('scons -f SConstruct.rf4a -c');
    }
    system('scons -f SConstruct.rf4a');
} else {
if ('' ne `which make` and
        -e '../RefactoredSources/Makefile') {
    if (-e 'main.o') {
        system('make clean');
    }
    system('make');
} else {
    system('export FFLAGS="-cpp -Ofast -m64 -Wall -ffree-form -fconvert=big-endian -mcmodel=medium";
        $FC $FFLAGS dyn.f95 init.f95 shapiro.f95 sub.f95 update.f95 main.f95 -o shallow_water_2D');
}
}

