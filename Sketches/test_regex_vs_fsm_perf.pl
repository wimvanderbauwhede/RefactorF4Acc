#!/usr/bin/env perl
use v5.28;
use Data::Dumper;
my $str='This means we need a stack per type of operation and run until the end of the expression';

my @chrs = split('',$str);

# Still not good: need to substract the time to copy or populate the str/array
#[wim@hackbox Sketches]$ time perl test_regex_vs_fsm_perf.pl 0 (for); overhead 3 = 0.064
#3.5s
#[wim@hackbox Sketches]$ time perl test_regex_vs_fsm_perf.pl 1 (while); overhead 4 = 2.7s, so really only 5.1s
#7.8 s
#[wim@hackbox Sketches]$ time perl test_regex_vs_fsm_perf.pl 2 (regex) overhead 5 = 0.08s
#8.0s


# The regex version is 1.45s, the other version 3.25s (mean over 10 runs)
my $ver=$ARGV[0];
for (1..1_000_000) {
my @words=();
    if ($ver==0) {
        my $word='';
        for my $chr (@chrs)  {
            if ($chr ne ' ') {
                $word.=$chr;
            } else {
                push @words, $word;
                $word='';
            }
        }
        push @words, $word;
    } elsif ($ver==1) {
        my @chrs_ = @chrs;
        my $word='';
        while (@chrs_) {
            my $chr=  shift @chrs_;
            if ($chr ne ' ') {
                $word.=$chr;
            } else {
                push @words, $word;
                $word='';
            }
        }
        push @words, $word;
    } elsif($ver==2) {
    my $str='This means we need a stack per type of operation and run until the end of the expression';

        while(length( $str ) > 0) {
             if(   $str=~s/^(\w+)//) {
                push @words, $1;
            }
            else {
                $str=~s/^\s+//;
            } 
        }
    } elsif ($ver==3) {
        my $word='';
    } elsif ($ver==4) {
        my @chrs_ = @chrs;
        my $word='';
    } else { 
        my $str='This means we need a stack per type of operation and run until the end of the expression';

    }    
    
}
    #say Dumper(@words);    

