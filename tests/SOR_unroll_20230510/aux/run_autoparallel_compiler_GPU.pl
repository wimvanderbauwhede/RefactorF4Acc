#!/usr/bin/env perl
use warnings;
use strict;
use v5.10;
BEGIN {
	push @INC, '../aux';
};
use MacroFileToCmdLine qw( macro_file_to_cmd_line_str );

my $macros_str= macro_file_to_cmd_line_str( './macros.h', '-D');
my $macros_to_skip_str = macro_file_to_cmd_line_str('./macros_to_skip.h','-X');

say("AutoParallel-Fortran-exe ./adam.f95 ./bondv1.f95 ./feedbf.f95 ./les.f95 ./press.f95 ./velFG.f95 ./velnw.f95 -out ../GeneratedCodeV2/ -iowrite anime -main ./main.f95 -plat GPU  $macros_str $macros_to_skip_str -v");
#system('which AutoParallel-Fortran-exe');die;
system("AutoParallel-Fortran-exe ./adam.f95 ./bondv1.f95 ./feedbf.f95 ./les.f95 ./press.f95 ./velFG.f95 ./velnw.f95 -out ../GeneratedCodeV2/ -iowrite anime -main ./main.f95  -plat GPU  $macros_str $macros_to_skip_str -v");


