#!/usr/bin/env perl
use v5.28;
use strict;
use warnings;

my $str = '*';
my $c=42;
my $count=0;
# int: 4.6 string: 5.3
for my $i (1..100_000_000) {
    #if ($str eq '*') {
    if ($c == 42) {
    #    if (1) 3.1
        $count+=$i;
        };
}
say $count;
