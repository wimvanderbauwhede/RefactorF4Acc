#!/usr/bin/env perl
use strict;
use warnings;
use v5.30;
use RefactorF4Acc::Config qw( $config_menu );

for my $pair (@{$config_menu}) {

    my $rubric = $pair->[0];
    say '#### '."$rubric\n";
    say '<dl>';
    my $options = $pair->[1];
    for my $option (@{$options}) {
        my ($key, $desc, $default) = @{$option};    
        say "<dt>$key:</dt><dd>$desc [$default]</dd>";
    }
     say '</dl>';
     say '';
}
