#!/usr/bin/env perl
use strict;
use warnings;
use v5.30;
use RefactorF4Acc::Config qw( $config_menu );

my $RR=0;
if (@ARGV and $ARGV[0] eq '-R') {
    warn "Generating section for README.md";
    $RR=1;
} else {
    warn "Generating stand-alone CONFIG.md"
}

if (not $RR) {

say "# Configuration options and defaults\n";

say 'For version '.$RefactorF4Acc::Config::VERSION.', generated '.localtime()."\n";
    say <<'ENDH';
## RefactorF4Acc configuration support

To configure the refactoring and code generation, `rf4a` has many options.
If you run `rf4a` without any flags, it will look in the current directory for a configuration file `rf4a.cfg`.
If that file does not exist, it will present you with a text-based wizard to create the configuration.
The configuration file is a text file containing key-value pairs separated with an '='. Lines starting with '#' are comments.
The supported options and their defaults are listed below. 
This file is generated from `RefactorF4Acc/Config.pm` using `bin/generate_Markdown_from_Config.pl`

## RefactorF4Acc configuration options and defaults
ENDH

}

for my $pair (@{$config_menu}) {

    my $rubric = $pair->[0];
    $rubric=~s/_/ /g;
    $rubric=ucfirst(lc($rubric));
    if ($rubric eq 'Ocl') {
        $rubric = 'OpenCL';
    }
    say ''.( $RR ? '#### ' : '### ')."$rubric\n";
    say '<dl>';
    my $options = $pair->[1];
    for my $option (@{$options}) {
        my ($key, $desc, $default) = @{$option};    
        say "<dt>$key:</dt><dd>$desc [$default]</dd>";
    }
     say '</dl>';
     say '';
}
