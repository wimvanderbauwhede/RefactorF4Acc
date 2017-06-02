#!/usr/bin/env perl
use strict;
use warnings;
use v5.16;

my $passed_tests=0;
my $failed_tests=0;
my $executed_tests=0;
my $tests_requiring_inspection=0;

open my $PASS, '<', 'PASS.txt';
while (my $line = <$PASS>) {
    next if $line=~/FM001/;
    $line=~/(\d+)\s+TESTS/ && do {
        $passed_tests+=$1;
    };
}
close $PASS;

open my $FAIL, '<', 'FAIL.txt';
while (my $line = <$FAIL>) {
    next if $line=~/FM001/;
     $line=~/(\d+)\s+TESTS/ && do {
        $failed_tests+=$1;
     };
}
close $FAIL;

open my $EXECUTED, '<', 'EXECUTED.txt';
while (my $line = <$EXECUTED>) {
    next if $line=~/FM001/;
     $line=~/(\d+)\s+TESTS/ && do {
        $executed_tests+=$1;

     };
}
close $EXECUTED;

open my $REQUIRE_INSPECTION, '<', 'REQUIRE_INSPECTION.txt';
while (my $line = <$REQUIRE_INSPECTION>) {
    next if $line=~/FM001/;
     $line=~/(\d+)\s+TESTS/ && do {
        $tests_requiring_inspection+=$1;
     };
}
close $REQUIRE_INSPECTION;

say "PASSED: $passed_tests";
say "FAILED: $failed_tests";
say "REQUIRE INSPECTION: $tests_requiring_inspection";
say "TOTAL: ".($passed_tests+$failed_tests+$tests_requiring_inspection);

