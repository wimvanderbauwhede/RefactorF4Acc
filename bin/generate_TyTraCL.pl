#!/usr/bin/env perl
use v5.28;
# use RefactorF4Acc::Config qw( read_rf4a_config );
use Getopt::Std;

my %opts = ();
getopts( 'hvmste:', \%opts );

if ($opts{'h'}){
    die "
    $0 -[hvste] 

    -v : verbose
    -e : Fortran source file extension (default is .f95, needs the dot)
    \n";
}
    # -m : generate TyTraCL main routine (default)
    # -s : scalarise only
    # -t : translate only

our $V=0;
if ($opts{'v'}) {
    $V=1;
}
my $gen_tytra_cl_main=1;
if ($opts{'m'}) {
    $gen_tytra_cl_main=1;
}
# my $scalarise=1;
# my $translate=1;
# if ($opts{'s'}) {
#     $translate=0;
# }
# if ($opts{'t'}) {
#     $scalarise=0;
# }
# if ($opts{'s'} and $opts{'t'}) {
#     $scalarise=1;
#     $translate=1;
# }
my $ext = '.f95';
if ($opts{'e'}) {
    $ext = $opts{'e'};
}

# Generate TyTraIR main routine
if ($gen_tytra_cl_main) {
    say "GENERATING TyTraCL main routine" if $V;
    my @kernel_srcs = glob("module_*_superkernel.f95"); 

    if (scalar @kernel_srcs == 1) {
        if (-d './TyTraC' ) {
               if (-e './TyTraC/kernelTop.ll')  {
                    unlink('./TyTraC/kernelTop.ll');
               }
        } else {
            mkdir './TyTraC';
        }
        my $kernel_src = shift @kernel_srcs;
        say "KERNEL MODULE SRC: $kernel_src" if $V;
        my ($kernel_sub_name, $kernel_module_name) = get_kernel_and_module_names($kernel_src,'superkernel');
        if ($kernel_sub_name ne '') {
            my $rf4a_tytra_cl_cfg =  create_rf4a_cfg_tytra_cl($kernel_src,$kernel_sub_name, $kernel_module_name);  
            say "CFG: $rf4a_tytra_cl_cfg" if $V;
            system("refactorF4acc.pl -P emit_TyTraCL -c $rf4a_tytra_cl_cfg > $kernel_sub_name.hll"); 
        }
    } else {
        die "No kernel sources found";
    }
}


# ==================================== AUX ====================================



sub create_rf4a_cfg_tytra_cl {
    my ($kernel_src,$kernel_sub_name, $kernel_module_name) = @_;    

    my $rf4a_cfg = <<"ENDCFG";
MODULE = $kernel_module_name
MODULE_SRC = $kernel_src
TOP = $kernel_sub_name
KERNEL = $kernel_sub_name
PREFIX = .
SRCDIRS = .
NEWSRCPATH = ./Temp
EXCL_SRCS = (module_\\w+_superkernel_init|_host|\\.[^f])
EXCL_DIRS = ./PostCPP,./Temp,./TempC,./Scalarized,./TyTraC
MACRO_SRC = macros.h
EXT = .f95
ENDCFG

    open my $RF4A, '>', "rf4a_${kernel_sub_name}_tytra_cl.cfg" or die $!;
    print $RF4A $rf4a_cfg;
    close $RF4A;

    return "rf4a_${kernel_sub_name}_tytra_cl.cfg";
} # END of create_rf4a_cfg_tytra_cl


sub get_kernel_and_module_names {
    my ($kernel_src, $superkernel) = @_;

    open my $SRC, '<', $kernel_src or die $!;
    my @src_lines = <$SRC>;
    close $SRC;
    my @kernel_sub_names    = map {/^\s*subroutine\s+(\w+)/; $1} grep { /^\s*subroutine\s+\w+/ } @src_lines;
    my $kernel_sub_name='NO_NAME';
    if (defined $superkernel) {
            ($kernel_sub_name) = grep {/superkernel/} @kernel_sub_names;
    } else {
            ($kernel_sub_name) = grep {!/superkernel/} @kernel_sub_names;
    }
    say "KERNEL SUB NAME: <$kernel_sub_name>" if $V;
    my ($kernel_module_name) = map { /^\s*module\s+(\w+)/; $1 } grep {/^\s*module\s+\w+/} @src_lines;
    say "KERNEL MODULE NAME: <$kernel_module_name>" if $V;
    return ($kernel_sub_name, $kernel_module_name);
} # END of get_kernel_and_module_names

