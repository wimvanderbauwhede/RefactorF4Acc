#!/usr/bin/perl
use 5.012;
use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Data::Dumper;
use Carp;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::State qw( init_state );
use RefactorF4Acc::Inventory qw( find_subroutines_functions_and_includes );
use RefactorF4Acc::Parser qw( parse_fortran_src );
use RefactorF4Acc::CallTree qw( create_call_tree );
use RefactorF4Acc::Analysis qw( analyse_all );
use RefactorF4Acc::Refactoring qw( refactor_all );
use RefactorF4Acc::Emitter qw( emit_all );
use RefactorF4Acc::OpenCLTranslation qw( translate_to_OpenCL);
#use RefactorF4Acc::Builder qw( create_build_script build_executable );

use Getopt::Std;

our $usage = "
This script generates an OpenCL kernel from a Fortran-95 subroutine.

USAGE:
 
The script needs following information from the rf4a config file (rf4a.cfg or ~/.rf4a)

TOP: the name of the toplevel program that calls the kernel subroutine
TOP_SRC: the source file name for TOP
MODULE: the module that contains the kernel subroutine
MODULE_SRC: the source file name for MODULE
KERNEL: the name of the  kernel subroutine
MACRO_SRC: the source file name containing macro definitions if the source code contains macros. 
OPTIONS:

    $0 [-hwvicC] 
    Typical use: $0 -c ./rf4a.cfg -v -i  
    -h: help
    -w: show warnings 
    -v: verbose (implies -w)
    -i: show info messages
    -c <cfg file name>: use this cfg file (default is ~/.rf4a)
    -C: Only generate call tree, don't refactor or emit
    \n";

&main();

# -----------------------------------------------------------------------------

sub main {
	(my $mod_name, my $mod_src,my $kernel_name, my $top_name, my $top_src, my $macro_src, my $build) = parse_args();
	#  Initialise the global state.
	
	my $inits = { 
	    'Modules'=>{ $mod_name=>{'Source' => $mod_src} }, 
	    'Top' => $top_name, 
	    'Subroutines' =>  { 
	        $kernel_name =>{'Source' => $mod_src},
	        $top_name =>{'Source' => $top_src} 
	    },  
	};
	
	my $stref = init_state($top_name);
	
	if (defined $macro_src) {
	    $stref = read_macros($stref,$macro_src);
	}
	
	say "**** INVENTORY ****" if $V;    
	# Find all subroutines in the source code tree
	$stref = find_subroutines_functions_and_includes($stref);
#	croak Dumper($stref);
#	     map {say $_ } keys %{ $stref->{'Modules'}{$mod_name} };
#
#die;
    say "**** PARSING ****" if $V;
    # Parse the source
	$stref = parse_fortran_src( $mod_name, $stref );
	
	
	if ( $call_tree_only  ) {
		create_call_graph($stref,$mod_name);		
		exit(0);
	}
    
    # Analyse the source
    say "**** ANALYSIS ****" if $V;
	$stref = analyse_all($stref,$mod_name);

    say "**** REFACTORING ****" if $V;
    # Refactor the source
	$stref = refactor_all($stref,$mod_name);
   print '=' x 80, "\n" if $V;
#   map {say Dumper($_->[1]) } @{ $stref->{'Modules'}{'module_press'}{'AnnLines'} };die;
#	say Dumper( $stref->{'Modules'}{'module_press'} );die;
   $stref = translate_to_OpenCL($stref,$mod_name, $kernel_name, $macro_src);
    


#	create_build_script($stref);
#	if ($build) {
#		build_executable();
#	}
	exit(0);

}    # END of main()
# -----------------------------------------------------------------------------
sub parse_args {
 	# Argument parsing. Factor out!
	if ( not @ARGV ) {
		die "Please specifiy FORTRAN subroutine or program to refactor\n";
	}
	my %opts = ();
	getopts( 'vwihgc:CNB', \%opts );
	
	my $help = ( $opts{'h'} ) ? 1 : 0;
    if ($help) {
        die $usage;
    }
	
	my $cfgrc= $ENV{HOME}.'/.rf4a';
    if (-e './rf4a.cfg') {
        $cfgrc='./rf4a.cfg';
    }    
    if ($opts{'c'}) {
         $cfgrc= $opts{'c'} ;
    } 
	read_config($cfgrc);
	if (not exists $Config{'MODULE'} or not exists $Config{'KERNEL'}) {
	    die "Sorry, $cfgrc does not contain the necessary information:". $usage; 	
	}
    my $mod_name = $Config{'MODULE'};
    my $mod_src = exists $Config{'MODULE_SRC'} ? $Config{'MODULE_SRC'} : do { say "WARNING: Using DEFAULT module source file name!"; 'module_'.$mod_name.'.f95';};
    my $kernel_name = $Config{'KERNEL'};    
    my $top_name = $Config{'TOP'};
    my $top_src = exists $Config{'TOP_SRC'} ? $Config{'TOP_SRC'} : do { say "WARNING: Using DEFAULT top source file name!"; $top_name.'.f95';};
    my $macro_src =  $Config{'MACRO_SRC'}; 
    if ( exists $Config{'NEWSRCPATH'}) {
        $targetdir =  $Config{'NEWSRCPATH'};
    }   
    
	$V = ( $opts{'v'} ) ? 1 : 0;
	$I = ( $opts{'i'} or $V ) ? 1 : 0;
	$W = ( $opts{'w'} or $V ) ? 1 : 0;
	$refactor_toplevel_globals=( $opts{'g'} ) ? 1 : 0;
	if ( $opts{'C'} ) {
		$call_tree_only = 1;
	}

	my $build = ( $opts{'B'} ) ? 1 : 0;

	return ($mod_name,$mod_src,$kernel_name, $top_name,$top_src, $macro_src, $build);
}

sub read_macros { (my $stref,my $macro_src) = @_;
    $stref->{'Macros'}={};
    open my $MACROS, '<',$macro_src;
    while ( my $line = <$MACROS>) {
        $line=~/\#define\s+(\w+)\s+(\w+)/ && do {
            $stref->{'Macros'}{$1}=$2;        
        }
    }
    return $stref;
}

=head1 SYNOPSIS

Generates an OpenCL kernel from an F95 source using F2C_ACC. The actual work is done in RefactorF4Acc::OpenCLTranslation.

=head1 OVERVIEW

=cut


