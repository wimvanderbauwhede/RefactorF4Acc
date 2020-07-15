#!/usr/bin/env perl
if('' ne `which scons`) {
    if(-e 'src/cea2.o') {
        system('scons -c') ;
    }
    system('scons') ;
} elsif('' ne `which make`) {
    if(-e 'src/cea2.o') {
        system('make clean') ;
    }
    system('make') ;
} else {
    system($ENV{'FC'}.' -Wall src/cea2.f -Isrc -o cea2');
}


