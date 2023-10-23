#!/usr/bin/env perl
use warnings;
use strict;
use v5.10;
use RefactorF4Acc::Main qw( main usage );

&main({'b'=>1});
chdir './refactored-source';
if ('' ne `which scons`) {
    if (-e 'main.o') {
        system('scons -f SConstruct.rf4a -c');
    }
    system('scons -f SConstruct.rf4a');
} elsif ('' ne `which make` and
        -e '../RefactoredSources/Makefile') {
    if (-e 'main.o') {
        system('make clean');
    }
    system('make');
} else {
    system('export FFLAGS="-Wall -ffree-form -fconvert=big-endian -mcmodel=medium";
        $FC $FFLAGS src/greet_world.f90 src/main.f90 -o hello');
}
system('cp hello ..');

