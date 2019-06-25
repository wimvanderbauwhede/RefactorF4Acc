#!/usr/bin/env perl
use v5.28;
use Data::Dumper;
my $str='This means we need a stack per type of operation and run until the end of the expression';

my @chrs = split('',$str);

# The regex version is 1.45s, the other version 3.25s (mean over 10 runs)
my $ver=1;
for (1..10_000_000) {
my @words=();
    if ($ver==1) {
        my $word='';
        while (@chrs) {
            my $chr=  shift @chrs;
            if ($chr ne ' ') {
                $word.=$chr;
            } else {
                push @words, $word;
                $word='';
            }
        }
        push @words, $word;
    } else {
        while(length( $str ) > 0) {
             if(   $str=~s/^(\w+)//) {
                push @words, $1;
            }
            else {
                $str=~s/^\s+//;
            } 
        }
    }
}
    #say Dumper(@words);    

