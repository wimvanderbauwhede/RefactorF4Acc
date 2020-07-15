#!/usr/bin/env perl
use warnings;
use strict;
use v5.10;
use RefactorF4Acc::Main qw( main usage );

chdir 'fortran';
&main({'b'=>1});
chdir '../RefactoredSources';
if ('_' ne `which scons`) {
    system('scons -f SConstruct.rf4a');
} else {
if (-e '../RefactoredSources/Makefile') {
    system('make');
} else {
    system('export FFLAGS="-cpp -Ofast -m64 -Wall -ffree-form -fconvert=big-endian -mcmodel=medium";
        $FC $FFLAGS dyn.f95 init.f95 shapiro.f95 sub.f95 update.f95 main.f95 -o shallow_water_2D');
}
}

