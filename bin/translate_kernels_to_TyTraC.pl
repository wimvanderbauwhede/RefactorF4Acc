#!/usr/bin/env perl
use v5.28;

use Getopt::Std;

my %opts = ();
getopts( 'hvi:o:e:m:', \%opts );

if ($opts{'h'}){
    die "
    $0 -[hvioe] 

    -v : verbose
    -i : directory with scalarized kernel sources (default: Scalarized)
    -o: output directory (default: TyTraC)
    -m : macros file (default: macros.h)
    -e : Fortran source file extension (default is .f95, needs the dot)
    \n";
}
our $V=0;
if ($opts{'v'}) {
    $V=1;
}
my $kernels_dir = 'Scalarized';

if ($opts{'i'}) {
    $kernels_dir=$opts{'i'};
}
my $out_path ='../TyTraC';
if ($opts{'o'}) {
    $out_path=$opts{'o'};
}

my $scalarise=1;
my $translate=1;
if ($opts{'s'}) {
    $translate=0;
}
if ($opts{'t'}) {
    $scalarise=0;
}
if ($opts{'s'} and $opts{'t'}) {
    $scalarise=1;
    $translate=1;
}
my $ext = '.f95';
if ($opts{'e'}) {
    $ext = $opts{'e'};
}

my $macros_src = 'macros.h';
if ($opts{'m'}) {
$macros_src=$opts{'m'};
}

if (not -d 'Scalarized') {
    if (!@ARGV) {
        die "Provide the directory with the scalarised Fortran-syntax kernel modules as argument";
    }
    else {
        $kernels_dir = $ARGV[0];
    }
}

chdir $kernels_dir;

my @kernel_srcs = glob("*$ext");  

if (@kernel_srcs) {
    if (-d '../'.$out_path) {
        system ('rm -f ../'.$out_path.'/*.c');
    }
    for my $kernel_src (@kernel_srcs) {
        say "KERNEL SRC: $kernel_src" if $V;
        my ($kernel_sub_name, $kernel_module_name) = get_kernel_and_module_names($kernel_src);
        if ($kernel_sub_name ne '') {
            my $rf4a_cfg = create_rf4a_cfg($kernel_src,$kernel_sub_name, $kernel_module_name);
            system("refactorF4acc.pl -P translate_to_TyTraC -c $rf4a_cfg");
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
EXT = $ext
ENDCFG

    open my $RF4A, '>', "rf4a_${kernel_sub_name}_to_C.cfg" or die $!;
    print $RF4A $rf4a_cfg;
    close $RF4A;

    return "rf4a_${kernel_sub_name}_to_C.cfg";
}

sub get_kernel_and_module_names {
    my ($kernel_src) = @_;

    open my $SRC, '<', $kernel_src or die $!;
    my @src_lines = <$SRC>;
    close $SRC;
    my ($kernel_sub_name)    = map {/^\s*subroutine\s+(\w+)/; $1} grep { /^\s*subroutine\s+\w+/ } @src_lines;
    say "KERNEL SUB NAME: <$kernel_sub_name>" if $V;
    my ($kernel_module_name) = map { /^\s*module\s+(\w+)/; $1 } grep {/^\s*module\s+\w+/} @src_lines;
    say "KERNEL MODULE NAME: <$kernel_module_name>" if $V;
    return ($kernel_sub_name, $kernel_module_name);
}

