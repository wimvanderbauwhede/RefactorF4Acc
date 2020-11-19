#!/usr/bin/env perl
use v5.28;
use Data::Dumper;
my @strs=(
    'READ( 1, 2, ERR=8, END=9, IOSTAT=N ) X, Y',
    'CLOSE( [ UNIT=] u [, STATUS= sta] [, IOSTAT= ios] [, ERR= s ] )',
    'WRITE( 1, REC=3, IOSTAT=N, ERR=8 ) V'
);
 my @hits=();
for (1..1000_000) {
    @hits=();
    for my $str (@strs) {
    if (0) {
        if (0) {
        # 1.6s
        if ($str=~/(READ|ACCEPT|OPEN|CLOSE|PRINT|WRITE)/) {
            push @hits, $1;
        }
    } else {
        # with (?: ... ) 1.5 s
        # without grouping 1.5 s
        if ($str=~/(?:READ|ACCEPT|OPEN|CLOSE|PRINT|WRITE)/) {
            push @hits, $1;
        }
    }
    } else {
        if (0) {
        # 1.65s
        if (
               $str=~/(READ)/
            || $str=~/(ACCEPT)/
            || $str=~/(OPEN)/
            || $str=~/(CLOSE)/
            || $str=~/(PRINT)/
            || $str=~/(WRITE)/
                ) {
            push @hits, $1;
        }

    } else {
        # 1.191s
        if (
               $str=~/READ/
            || $str=~/ACCEPT/
            || $str=~/OPEN/
            || $str=~/CLOSE/
            || $str=~/PRINT/
            || $str=~/WRITE/
                ) {
            push @hits, $1;
        }
    }
}
}
}
say Dumper(@hits);    

