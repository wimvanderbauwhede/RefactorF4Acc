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
use RefactorF4Acc::Utils qw( get_kernel_and_module_names );
use Data::Dumper;

my %opts = ();
getopts( 'hvmste:', \%opts );

if ($opts{'h'}){
    die "
    $0 -[hvste] 

    -v : verbose
    -c : generate TyTraCL Haskell AST code
    -e : Fortran source file extension (default is .f95, needs the dot)
    \n";
}
our $V=0;
if ($opts{'v'}) {
    $V=1;
}
my $gen_tytra_hs_main=1;
my $ext = '.f95';
if ($opts{'e'}) {
    $ext = $opts{'e'};
}

my $stref={};


# Generate TyTraIR main routine
if ($gen_tytra_hs_main) {
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
            my $rf4a_tytra_hs_cfg =  create_rf4a_cfg_tytra_cl($kernel_src,$kernel_sub_name, $kernel_module_name);  
             say "CFG: ".Dumper($rf4a_tytra_hs_cfg) if $V;
            #            system("refactorF4acc.pl -P emit_TyTraIR -c $rf4a_tytra_hs_cfg > ./TyTraC/kernelTop.ll"); 
            $stref = main({'P' => 'memory_reduction', 'c' => $rf4a_tytra_hs_cfg, 'o'  => './ASTInstance.hs'});

        }
    } else {
        die "No kernel sources found";
    }
}
 


# ==================================== AUX ====================================

sub create_rf4a_cfg_tytra_cl {
    my ($kernel_src,$kernel_sub_name, $kernel_module_name) = @_;    

    my $rf4a_cfg = {
'MODULE' => $kernel_module_name,
'MODULE_SRC' => $kernel_src,
'TOP' => $kernel_sub_name,
'KERNEL' => $kernel_sub_name,
'PREFIX' => '.',
'SRCDIRS' => ['.'],
'NEWSRCPATH' => './Temp',
'EXCL_SRCS' => ['(module_\\w+_superkernel_init|_host|\\.[^f])'],
'EXCL_DIRS' => [ qw( ./PostCPP ./Temp ./TempC ./Scalarized ./TyTraC ) ],
'MACRO_SRC' => 'macros.h',
'EXT' => ['.f95']
};

    return $rf4a_cfg;
} # END of create_rf4a_cfg_tytra_cl




sub VERSION_MESSAGE {	
	if (join(' ',@ARGV)=~/--help/) {
		usage();
	}
	die "Version: $VERSION\n";
}
