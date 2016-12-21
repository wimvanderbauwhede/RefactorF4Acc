#!/usr/bin/perl
use warnings;
use strict;
my @tests=qw(
F95SrcIO
F95ArgDeclParser
F95OpenACCParser
OpenCLAPIGenerator
EvalExpr
Main
);
if (@ARGV) {
    my $t = $ARGV[0];
    $t=~s/^test_//;
    $t=~s/\..*$//;
    @tests=($t);
}
# ghc --make -i.. test_${1}.hs && ./test_${1}
unlink 'test.log';
#system('touch test.log');
for my $test (@tests) {
#    system("echo '$test' >> test.log");
    system("ghc --make -i.. test_$test.hs > build.log 2>&1 && ./test_$test | grep ' test:' >> test.log || (echo '$test build failed' >> test.log; cat build.log >> test.log; echo 'END BUILD ERROR' >> test.log)") ;
}

