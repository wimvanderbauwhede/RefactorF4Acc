#!/usr/bin/env perl
use warnings;
use strict;
use v5.10;
use RefactorF4Acc::Main qw( main usage );

#chdir 'src';
&main({'b'=>1});
chdir './refactored-source';
if ('' ne `which scons`) {
    system('scons -f SConstruct.rf4a');
} else {
   say "Please install the scons build system to build the generated code."; 
}
if (-e 'cea2') {
system('cp cea2 ..');
}
