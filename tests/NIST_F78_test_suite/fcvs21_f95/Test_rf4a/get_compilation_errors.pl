#!/usr/bin/env perl
use strict;
use warnings;
use v5.30;

open my $LOG, '<', '../RefactoredSources/parse.log' or die $!;

my @errors=();
my $error_message='';
my $is_error = 0;
my %failing_programs=();
my $program='';
while (my $line = <$LOG>) {

    if ($line=~/^(FM\d+)\.f95:/) {
        $program=$1;
        $error_message=$line;
        $is_error=0;
    } elsif ($line=~/Error/) { $is_error=1; 
        $error_message .= $line;
        push @errors, $error_message;
        $failing_programs{$program}=1;
    } else {
        $error_message .= $line;
    }
}
close $LOG;

for my $error_message (@errors) {
    say $error_message;
}

map {say $_} sort keys %failing_programs;
