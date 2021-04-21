package RefactorF4Acc::Analysis;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Includes qw( find_root_for_includes lift_param_includes);
use RefactorF4Acc::Analysis::Variables qw( analyse_variables );
use RefactorF4Acc::Analysis::Arguments qw( 
	determine_ExGlobArgs 
	find_argument_declarations 
	resolve_conflicts_with_params 
	create_RefactoredArgs
	create_RefactoredArgs_for_ENTRY
	map_call_args_to_sig_args
	identify_external_proc_args
	analyse_var_decls_for_params
	);
use RefactorF4Acc::Analysis::Globals qw( identify_inherited_exglobs_to_rename lift_globals rename_inherited_exglobs );
#use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_end_detect );
use RefactorF4Acc::Refactoring::Helpers qw( get_f95_var_decl stateless_pass_inplace );
use RefactorF4Acc::Refactoring::BlockData qw( add_BLOCK_DATA_call_after_last_VarDecl );
use RefactorF4Acc::Refactoring::Functions qw(add_function_var_decls_from_calls );
# WORK IN PROGRESS
use RefactorF4Acc::Analysis::CommonBlocks qw( analyse_common_blocks );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  analyse_all
  identify_vars_on_line
);

sub analyse_all {
	# local $V=1;

	( my $stref, my $code_unit_name, my $stage, my $is_source_file_path  ) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $code_unit_name, $stref );
			
	if ($sub_or_func_or_mod eq 'Modules' and $is_source_file_path) {
	   $code_unit_name = get_module_name_from_source($stref,$code_unit_name);
	}
	if (not defined $stage) {$stage=0}
	
	# Insert BLOCK DATA calls in the main program	
	my $annlines =	add_BLOCK_DATA_call_after_last_VarDecl($code_unit_name,$stref); 
	
	if ($sub_or_func_or_mod eq 'Subroutines') {
		# Find the 'root', i.e. the outermost calling subroutine, for each include file
		print "\t** FIND ROOT FOR INCLUDES **\n" if $V;
		$stref = find_root_for_includes( $stref, $code_unit_name );
	}
	return $stref if $stage == 1;
	
	# I think I need a special case here to find the ExGlobArgs for BLOCK DATA
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';	
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		my $Sf = $stref->{'Subroutines'}{$f};
		if (exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) {
			print "\t** BLOCK DATA: analyse_variables($f) **\n" if $V;
			$stref = analyse_variables( $stref, $f );
		}
	}
	# In this stage, 'ExGlobArgs' is populated from CommonVars by looking at the common blocks that occur in the call chain
	# Note that this does *not* cover common blocks in includes so hopefully ExGlobArgs will not be affected for the case with includes.
	say "\t** EX-GLOB ARGS **" if $V;
	if ($sub_or_func_or_mod eq 'Subroutines') {
		determine_ExGlobArgs($code_unit_name, $stref);
	}
	# First find any additional argument declarations, either in includes or via implicits
	say "\t** ADDITIONAL ARG DECLS **" if $V;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		
		# Includes
		$stref = lift_param_includes( $stref, $f );
		# ExImplicitArgs, ExInclArgs
		$stref = find_argument_declarations( $stref, $f );
	}	
	return $stref if $stage == 2;
	
	say "\t** ANALYSE VARS **" if $V;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';	
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		my $Sf = $stref->{'Subroutines'}{$f};
		if (not exists $Sf->{'BlockData'} or $Sf->{'BlockData'} == 0 ) {	
			print "\t** analyse_variables($f) **\n" if 0;# $V;	
			$stref = analyse_variables( $stref, $f );
		}
	}

    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        next if $f eq '';   
        if (exists $stref->{'Entries'}{$f}) {
            next;
        }	
	    $stref = add_function_var_decls_from_calls( $stref, $f );
    }
	return $stref if $stage == 3;

# ConflictingGlobals: ex-common vars conflicting with params, both from include files
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		
		$stref = resolve_conflicts_with_params( $stref, $f );
	}
	return $stref if $stage == 4;
	
	# The next three routines work on ExGlobArgs and RenamedInheritedExGLobs
	if ($sub_or_func_or_mod eq 'Subroutines') {
	$stref = identify_inherited_exglobs_to_rename( $stref, $code_unit_name );
	# Although this seems duplication, it is actually required!	
	$stref = lift_globals( $stref, $code_unit_name );	
	$stref = rename_inherited_exglobs( $stref, $code_unit_name );
	}
	return $stref if $stage == 5;
	
# croak Dumper keys % {$stref->{'Subroutines'}};
	for my $f ( keys %{ $stref->{'Subroutines'} } ) { 
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		# RefactoredArgs = OrigArgs ++ ExGlobArgs and at this point any necessary renaming has been done
		# This sets HasRefactoredArgs = 1
		$stref = create_RefactoredArgs( $stref, $f );
		if (exists $stref->{'Subroutines'}{$f}{'HasEntries'} ) {
			$stref = create_RefactoredArgs_for_ENTRY( $stref, $f );
		}
	}
	return $stref if $stage == 6;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {    # Functions are just special subroutines
		next if $f eq '';		
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		$stref = map_call_args_to_sig_args( $stref, $f );
	}
	return $stref if $stage == 7;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) { # Functions are just special subroutines
		next if $f eq '';
		next if not exists $stref->{'Subroutines'}{$f}{'Callers'}; 
		
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
        
		$stref = identify_external_proc_args( $stref, $f );
	}
	return $stref if $stage == 8;

#	# This is only for refactoring init out of time loops so very domain specific
#	for my $kernel_wrapper ( keys %{ $stref->{'KernelWrappers'} } ) {
#		$stref = outer_loop_end_detect( $kernel_wrapper, $stref );
#	}

	# So at this point all globals have been resolved and typed.

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}		
		$stref = analyse_var_decls_for_params( $stref, $f );

	}	

# ================================================================================================================================
$stref = analyse_common_blocks($stref);	
# croak Dumper($stref->{'Subroutines'}{'genmap'}{ExGlobArgs});
# carp 'OCC5d:'.$stref->{'Subroutines'}{'genmap'}{DeclaredCommonVars}{Set}{w1}{Type};
# carp 'OCC5e:'.$stref->{'Subroutines'}{'genmap'}{ExGlobArgs}{Set}{w1}{Type};
# carp 'ExGlobArgs:'. Dumper($stref->{'Subroutines'}{'mult_chk'}{ExGlobArgs}{Set}{w4}{Type});
# croak  Dumper($stref->{'Subroutines'}{'comp_gije'}{AnnLines}); 	
	
	return $stref;
}    # END of analyse_all()

1;
