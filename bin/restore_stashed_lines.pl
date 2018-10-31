#!/usr/bin/env perl
use v5.22;
use warnings;
use strict;


use RefactorF4Acc::RestoreStashedLines qw( restore_stashed_lines );

#use Data::Dumper;
#use Cwd;
#our  $wd=cwd();
#our $VV=1;

restore_stashed_lines(@ARGV);

