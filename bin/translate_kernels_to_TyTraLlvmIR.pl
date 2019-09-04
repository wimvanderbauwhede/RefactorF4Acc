#!/usr/bin/env perl
use v5.28;

our $V=0;

my $kernels_dir = 'Scalarized';
if (not -d 'Scalarized') {
    if (!@ARGV) {
        die "Provide the directory with the scalarised Fortran-syntax kernel modules as argument";
    }
    else {
        $kernels_dir = $ARGV[0];
    }
}

chdir $kernels_dir;

my @kernel_srcs = glob("*.f95");    # FIXME: make generic

if (@kernel_srcs) {
    if (-d '../TyTraC') {
        system ('rm -f ../TyTraC/*.c');
    }
    for my $kernel_src (@kernel_srcs) {
        say "KERNEL SRC: $kernel_src" if $V;
        my ($kernel_sub_name, $kernel_module_name) = get_kernel_and_module_names($kernel_src);
        if ($kernel_sub_name ne '') {
            my $rf4a_cfg = create_rf4a_cfg($kernel_src,$kernel_sub_name, $kernel_module_name);
            system("refactorF4acc.pl -P translate_to_TyTraLlvmIR -c $rf4a_cfg");
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
NEWSRCPATH = ../TyTraC
MACRO_SRC = macros.h
EXT = .f95
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

