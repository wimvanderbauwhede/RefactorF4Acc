#!/usr/bin/env perl
use v5.28;
use strict;
use warnings;
use Getopt::Std;


my %opts = ();
getopts( 'hvi:P:o:e:m:', \%opts );

my @supported_passes = ("translate_to_OpenCL_memory_reduction", 
                        "translate_to_OpenCL", 
                        "translate_to_OpenCL_with_pipes");

if ($opts{'h'}){
    die "
    $0 -[hvioe]

    -v : verbose
    -i : kernel directory (default: .)
    -P : OpenCL translation pass (default: translate_to_OpenCL_memory_reduction)
        @supported_passes
    -o : output directory (default: OpenCLC)
    -m : macros file (default: macros_kernel.h)
    -e : Fortran source file extension (default is .f95, needs the dot)
    \n";
}
our $V=0;
if ($opts{'v'}) {
    $V=1;
}
my $kernels_dir = '.';

if ($opts{'i'}) {
    $kernels_dir=$opts{'i'};
}
my $out_path ='../OpenCLC';
if ($opts{'o'}) {
    $out_path=$opts{'o'};
}

my $ext = '.f95';
if ($opts{'e'}) {
    $ext = $opts{'e'};
}

my $macros_src = 'kernel_macros.h';
if ($opts{'m'}) {
    $macros_src=$opts{'m'};
}

my $ocl_target = 'translate_to_OpenCL_memory_reduction';
if ($opts{'P'}) {
    if (not grep { $_ eq $opts{'P'} } @supported_passes) {
        die "\"$opts{'P'}\" pass not supported\n"
    }
    $ocl_target=$opts{'P'};
}

chdir $kernels_dir;

my @kernel_srcs = glob("*$ext");

if (@kernel_srcs) {
    if (-d '../'.$out_path) {
        system ('rm -f ../'.$out_path.'/*.cl');
    }
    for my $kernel_src (@kernel_srcs) {
        my ($kernel_sub_name, $kernel_module_name) = get_kernel_and_module_names($kernel_src);
        say "KERNEL SRC: $kernel_src" if $V;
        if ($kernel_sub_name and $kernel_sub_name ne '') {
            my $rf4a_cfg = create_rf4a_cfg($kernel_src,$kernel_sub_name, $kernel_module_name);
            system("refactorF4acc.pl -P $ocl_target -c $rf4a_cfg $kernel_module_name");
        }
    }
} else {
    die "No kernel sources found in $kernels_dir";
}

sub create_rf4a_cfg {
    my ($kernel_src,$kernel_sub_name, $kernel_module_name) = @_;

    my $rf4a_cfg = <<"ENDCFG";
MODULE = $kernel_module_name
MODULE_SRC = $kernel_src
TOP = $kernel_sub_name
KERNEL = $kernel_sub_name
NEWSRCPATH = ../$out_path
MACRO_SRC = $macros_src
ENDCFG

    open my $RF4A, '>', "rf4a_${kernel_sub_name}_to_OpenCLC.cfg" or die $!;
    print $RF4A $rf4a_cfg;
    close $RF4A;

    return "rf4a_${kernel_sub_name}_to_OpenCLC.cfg";
}

sub get_kernel_and_module_names {
    my ($kernel_src) = @_;

    open my $SRC, '<', $kernel_src or die $!;
    my @src_lines = <$SRC>;
    close $SRC;
    my ($kernel_sub_name)    = map {/^.*subroutine\s+(\w+)/; $1} grep { /^.*subroutine\s+\w+/ } @src_lines;
    say "KERNEL SUB NAME: <$kernel_sub_name>" if $V;
    my ($kernel_module_name) = map { /^\s*module\s+(\w+)/; $1 } grep {/^\s*module\s+\w+/} @src_lines;
    say "KERNEL MODULE NAME: <$kernel_module_name>" if $V;
    return ($kernel_sub_name, $kernel_module_name);
}

