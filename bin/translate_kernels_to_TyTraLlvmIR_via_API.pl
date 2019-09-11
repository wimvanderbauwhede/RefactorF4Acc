#!/usr/bin/env perl
# 
#   (c) 2019 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   

use 5.010;
use warnings;
use strict;

use vars qw( $VERSION );
$VERSION = "1.2.0";
use Getopt::Std;
use RefactorF4Acc::Main qw( main usage );
use Data::Dumper;

my %opts = ();
getopts( 'hvmste:', \%opts );

if ($opts{'h'}){
    die "
    $0 -[hvste] 

    -v : verbose
    -m : generate TyTraIR main routine
    -s : scalarise only
    -t : translate only
    -e : Fortran source file extension (default is .f95, needs the dot)
    \n";
}
our $V=0;
if ($opts{'v'}) {
    $V=1;
}
my $gen_tytra_ir_main=0;
if ($opts{'m'}) {
    $gen_tytra_ir_main=1;
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

my $stref={};


# Generate TyTraIR main routine
if ($gen_tytra_ir_main) {
    say "GENERATING TyTraIR main routine" if $V;
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
            my $rf4a_tytra_ir_cfg =  create_rf4a_cfg_tytra_ir($kernel_src,$kernel_sub_name, $kernel_module_name);  
            say "CFG: $rf4a_tytra_ir_cfg" if $V;
            #            system("refactorF4acc.pl -P emit_TyTraIR -c $rf4a_tytra_ir_cfg > ./TyTraC/kernelTop.ll"); 
            $stref = main({'P' => 'emit_TyTraIR', 'c' => $rf4a_tytra_ir_cfg, 'o'  => './TyTraC/kernelTop.ll'});

        }
    } else {
        die "No kernel sources found";
    }
}
 

# First scalarise
if ($scalarise) {
    say "SCALARISE" if $V;
    my @kernel_srcs = glob("module_*_superkernel.f95"); 

    if (scalar @kernel_srcs == 1) {
        if (-d './Scalarized') {
            system ('rm -f ./Scalarized/*.f95');
        }
        my $kernel_src = shift @kernel_srcs;
        say "KERNEL MODULE SRC: $kernel_src" if $V;
        my ($kernel_sub_name, $kernel_module_name) = get_kernel_and_module_names($kernel_src,'superkernel');
        if ($kernel_sub_name ne '') {
            my $rf4a_scalarize_cfg =  create_rf4a_cfg_scalarise($kernel_src,$kernel_sub_name, $kernel_module_name);  
            say "CFG: $rf4a_scalarize_cfg" if $V;
            $stref = main({'P' => 'rename_array_accesses_to_scalars','c' => $rf4a_scalarize_cfg});#
            # Just an example, ignore the previous state
            #, $stref, sub { my ($stref, $stref_init)=@_; return $stref });
            #            system("refactorF4acc.pl -P rename_array_accesses_to_scalars -c $rf4a_scalarize_cfg"); 
        }
    } else {
        die "No kernel sources found";
    }
}
# Now convert to C, then to LLVM IR for TyTra
if ($translate) {
say "TRANSLATE" if $V;
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
            #system("refactorF4acc.pl -P translate_to_TyTraLlvmIR -c $rf4a_cfg");
                        $stref = main({'P'=> 'translate_to_TyTraLlvmIR','c'=> $rf4a_cfg});
        }
    }
} else {
    die "No kernel sources found in $kernels_dir";
}
}

# ==================================== AUX ====================================

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
} # END of create_rf4a_cfg

sub create_rf4a_cfg_scalarise {
    my ($kernel_src,$kernel_sub_name, $kernel_module_name) = @_;    

    my $rf4a_cfg = <<"ENDCFG";
MODULE = $kernel_module_name
MODULE_SRC = $kernel_src
TOP = $kernel_sub_name
KERNEL = $kernel_sub_name
PREFIX = .
SRCDIRS = .
NEWSRCPATH = ./Scalarized
EXCL_SRCS = (sub|init|param|module_\\w+_superkernel_init|_host|\\.[^f])
EXCL_DIRS = ./PostCPP,./Scalarized,./TyTraC
MACRO_SRC = macros.h
EXT = .f95
ENDCFG

    open my $RF4A, '>', "rf4a_${kernel_sub_name}_scalarise.cfg" or die $!;
    print $RF4A $rf4a_cfg;
    close $RF4A;

    return "rf4a_${kernel_sub_name}_scalarise.cfg";
} # END of create_rf4a_cfg_scalarise


sub create_rf4a_cfg_tytra_ir {
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

    open my $RF4A, '>', "rf4a_${kernel_sub_name}_tytra_ir.cfg" or die $!;
    print $RF4A $rf4a_cfg;
    close $RF4A;

    return "rf4a_${kernel_sub_name}_tytra_ir.cfg";
} # END of create_rf4a_cfg_tytra_ir


sub get_kernel_and_module_names {
    my ($kernel_src, $superkernel) = @_;
    
    open my $SRC, '<', $kernel_src or die $!;
    my @src_lines = <$SRC>;
    close $SRC;
    say 'NAMES:',Dumper grep {/subroutine/} @src_lines;
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




sub VERSION_MESSAGE {	
	if (join(' ',@ARGV)=~/--help/) {
		usage();
	}
	die "Version: $VERSION\n";
}
