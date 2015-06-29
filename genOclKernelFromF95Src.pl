#!/usr/bin/perl
use 5.012;
use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Data::Dumper;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::State qw( init_state );
use RefactorF4Acc::Inventory qw( find_subroutines_functions_and_includes );
use RefactorF4Acc::Parser qw( parse_fortran_src );
use RefactorF4Acc::CallGraph qw( create_call_graph );
use RefactorF4Acc::Analysis qw( analyse_all );
use RefactorF4Acc::Refactoring qw( refactor_all );
use RefactorF4Acc::Emitter qw( emit_all );
use RefactorF4Acc::OpenCLTranslation qw( translate_to_OpenCL);
#use RefactorF4Acc::Builder qw( create_build_script build_executable );

use Getopt::Std;

our $usage = "
    $0 [-hwvicC] <subroutine name(s) for translation to OpenCL> <header file with macro definitions>
    Typical use: $0 -c ./rf4a.cfg -v -i main   
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
	(my $mod_name, my $kernel_name, my $build) = parse_args();
	#  Initialise the global state.
	my $stateref = init_state($mod_name);
	say "**** INVENTORY ****" if $V;    
	# Find all subroutines in the source code tree
	$stateref = find_subroutines_functions_and_includes($stateref);
#	     map {say $_ } keys %{ $stateref->{'Modules'}{$mod_name} };


    say "**** PARSING ****" if $V;
    # Parse the source
	$stateref = parse_fortran_src( $mod_name, $stateref );
	
	
	if ( $call_tree_only  ) {
		create_call_graph($stateref,$mod_name);		
		exit(0);
	}
    
    # Analyse the source
    say "**** ANALYSIS ****" if $V;
	$stateref = analyse_all($stateref,$mod_name);

    say "**** REFACTORING ****" if $V;
    # Refactor the source
	$stateref = refactor_all($stateref,$mod_name);
   print '=' x 80, "\n" if $V;
#   map {say Dumper($_->[1]) } @{ $stateref->{'Modules'}{'module_press'}{'AnnLines'} };die;
#	say Dumper( $stateref->{'Modules'}{'module_press'} );die;
   $stateref = translate_to_OpenCL($stateref,$mod_name, $kernel_name);
    


#	create_build_script($stateref);
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
	if (@ARGV<2) {die "Please specify the module and subroutine for the kernel, in that order\n"; }
	my $mod_name = $ARGV[0];
	if ($mod_name) {
		$mod_name =~ s/\.f(?:9[05])?$//;
	} elsif (exists $Config{'MODULE'}) {
		$mod_name = $Config{'MODULE'};
	} else {
		die "No default for kernel module (MODULE) in rf4a.cfg, please specify the toplevel module on command line\n"; 
	}
    my $kernel_name = $ARGV[1];
    if (not $kernel_name) {
        if (exists $Config{'KERNEL'}) {
            $kernel_name = $Config{'KERNEL'};
        } else {
            die "No default for kernel subroutine (KERNEL) in rf4a.cfg, please specify the kernel on command line\n";
        }
    }
    
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

	return ($mod_name,$kernel_name, $build);
}

=head1 SYNOPSIS

Generates an OpenCL kernel from an F95 source using F2C_ACC. The actual work is done in RefactorF4Acc::OpenCLTranslation.

=head1 OVERVIEW

=cut


