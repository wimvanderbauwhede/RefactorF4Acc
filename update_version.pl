#!/usr/bin/env perl
use v5.10;
use strict;
use warnings;
my $NEW_VERSION =$ARGV[0];

my @source_files = glob("bin/refactorF4acc.pl RefactorF4Acc/*.pm RefactorF4Acc/*/*.pm");

for my $source_file (@source_files) {
    say("perl -pi -w -e 's/VERSION = \"\\d\\.\\d\\.\\d+\"/VERSION = \"".$NEW_VERSION."\"/;' $source_file");
    system("perl -pi -w -e 's/VERSION = \"\\d\\.\\d\\.\\d+\"/VERSION = \"".$NEW_VERSION."\"/;' $source_file");
}
