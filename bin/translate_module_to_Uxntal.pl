#!/usr/bin/env perl
use v5.28;
use strict;
use warnings;
use Getopt::Std;


my %opts = ();
getopts( 'hvdi:o:e:w:', \%opts );

my @supported_passes = ( "translate_to_Uxntal" );

if ($opts{'h'}){
    die "
    $0 -[hvioe] module source file

    -v : verbose
    -w : warnings
    -i : module directory (default: .)
    -o : output directory (default: Uxntal)
    -d : debug
    -e : Fortran source file extension (default is .f90, needs the dot)    
    \n";
}
our $V=0;
our $VV='';
if ($opts{'v'}) {
    $V=1;
    $VV = '-v -i -w 4';
}
my $kernels_dir = '.';

if ($opts{'i'}) {
    $kernels_dir=$opts{'i'};
}
my $out_path ='../Uxntal';
if ($opts{'o'}) {
    $out_path=$opts{'o'};
}

my $ext = '.f90';
if ($opts{'e'}) {
    $ext = $opts{'e'};
}
our $DBG='';
my $module_src = $ARGV[0];
if ($opts{'d'}) {
    $DBG = '-d';
}

my $uxn_target = 'translate_to_Uxntal';

chdir $kernels_dir;

my @kernel_srcs = $module_src eq '' ?  glob("*$ext") : ( $module_src );

if (@kernel_srcs) {
    if (-d '../'.$out_path) {
        system ('rm -f ../'.$out_path.'/*.tal');
    }
    for my $kernel_src (@kernel_srcs) {
        my ($kernel_sub_name, $kernel_module_name) = get_kernel_and_module_names($kernel_src);
        say "MODULE SRC: $kernel_src" if $V;
        if ($kernel_sub_name and $kernel_sub_name ne '') {
            my $rf4a_cfg = create_rf4a_cfg($kernel_src,$kernel_sub_name, $kernel_module_name);
            system("refactorF4acc.pl $DBG $VV -P $uxn_target -c $rf4a_cfg $kernel_module_name");
        }
    }
} else {
    die "No kernel sources found in $kernels_dir";
}

sub create_rf4a_cfg {
    my ($kernel_src,$kernel_sub_name, $kernel_module_name) = @_;

    my $rf4a_cfg = <<"ENDCFG";
PRESERVE_CASE = 1
MODULE = $kernel_module_name
MODULE_SRC = $kernel_src
TOP = $kernel_sub_name
KERNEL = $kernel_sub_name
NEWSRCPATH = ../$out_path
ENDCFG

    open my $RF4A, '>', "rf4a_${kernel_sub_name}_to_Uxntal.cfg" or die $!;
    print $RF4A $rf4a_cfg;
    close $RF4A;

    return "rf4a_${kernel_sub_name}_to_Uxntal.cfg";
}

sub get_kernel_and_module_names {
    my ($kernel_src) = @_;

    open my $SRC, '<', $kernel_src or die $!;
    my @src_lines = <$SRC>;
    close $SRC;
    my ($kernel_sub_name)    = map {/^.*subroutine\s+(\w+)/; $1} grep { /^.*subroutine\s+\w+/ } @src_lines;
    say "SUB NAME: <$kernel_sub_name>" if $V;
    my ($kernel_module_name) = map { /^\s*module\s+(\w+)/; $1 } grep {/^\s*module\s+\w+/} @src_lines;
    say "MODULE NAME: <$kernel_module_name>" if $V;
    return ($kernel_sub_name, $kernel_module_name);
}

