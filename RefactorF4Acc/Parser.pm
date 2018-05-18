package RefactorF4Acc::Parser;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::CallTree qw( add_to_call_tree );
use RefactorF4Acc::Refactoring::Common qw( emit_f95_var_decl get_f95_var_decl stateful_pass ); 
use RefactorF4Acc::Parser::SrcReader qw( read_fortran_src );
use RefactorF4Acc::Parser::Expressions qw( get_vars_from_expression parse_expression  get_args_vars_from_expression get_args_vars_from_subcall emit_expression get_consts_from_expression);
use RefactorF4Acc::CTranslation qw( add_to_C_build_sources );    # OBSOLETE
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_start_detect );
use RefactorF4Acc::Analysis::ArgumentIODirs qw(  &conditional_assignment_fsm );
use RefactorF4Acc::Analysis qw( identify_vars_on_line );

use Fortran::F95VarDeclParser qw( parse_F95_var_decl );
use Fortran::ConstructParser qw(
  parse_Fortran_open_call
);  
#  parse_Fortran_do_construct
#  parse_Fortran_if_construct
#);

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>


use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Parser::ISA = qw(Exporter);

@RefactorF4Acc::Parser::EXPORT_OK = qw(
  &parse_fortran_src
  &refactor_marked_blocks_into_subroutines
  &mark_blocks_between_calls
  &build_call_graph
);

# -----------------------------------------------------------------------------
# parse_fortran_src() parses the source but does perform only limited context-free analysis
# This routine is recursive
sub parse_fortran_src {
	( my $f, my $stref ) = @_;  # NOTE $f is not the name of the source but of the sub/func/incl/module. 

	#    local $V=1;
	print "parse_fortran_src(): PARSING $f\n" if $V;

	#say 'INIT PRE:'.Dumper($stref->{'Subroutines'}{'init'}{'AnnLines'}) ; # OK!
## 1. Read the source and do some minimal processsing, unless it's already been done (i.e. for extracted blocks)
	print "parse_fortran_src(): CALL read_fortran_src( $f )\n" if $V;
	$stref = read_fortran_src( $f, $stref );    #
	
	print "DONE read_fortran_src( $f )\n" if $V;	
	
	my $sub_or_incl_or_mod = sub_func_incl_mod( $f, $stref ); # Maybe call this "code_unit()"
	my $is_incl = $sub_or_incl_or_mod eq 'IncludeFiles' ? 1 : 0;
	my $is_mod = $sub_or_incl_or_mod eq 'Modules' ? 1 : 0;
	my $is_external_include =
	  $is_incl ? ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'External' ) : 0;

	print "SRC TYPE for $f: $sub_or_incl_or_mod\n" if $V;
	
#croak Dumper($stref);
	#	say 'INIT:'.Dumper($stref->{'Subroutines'}{'init'}{'AnnLines'}) ;
	#	say 'POST:'.Dumper($stref->{'Subroutines'}{'post'}{'AnnLines'}) ;
	#	die if $f eq 'post';
	# and not $is_external_include 
	if ( 
		$sub_or_incl_or_mod ne 'ExternalSubroutines'
		) {
		my $Sf = $stref->{$sub_or_incl_or_mod}{$f};
		if (not exists $Sf->{'Entry'} or $Sf->{'Entry'} == 0 ) {

		# OK, time to declare all the variable sets and declaration sets		
		$Sf = _initialise_decl_var_tables( $Sf, $stref, $f, $is_incl,$is_mod );
		
# Set 'RefactorGlobals' to 0, we only refactor the globals for subs that are kernel targets and their dependencies
		if ( not exists $Sf->{'RefactorGlobals'} ) {
			$Sf->{'RefactorGlobals'} = 0;
		}
		if ( $CFG_refactor_toplevel_globals == 1 ) {
			print "INFO: set RefactorGlobals=1 for $f\n" if $I;
			$Sf->{'RefactorGlobals'} = 1;
		}

## 2. Parse the type declarations in the source, create a per-target table Vars and a per-line VarDecl list and other context-free stuff
		# NOTE: The Vars set are the *declared* variables, not the *used* ones

		print "ANALYSE LINES of $f\n" if $V;
		$stref = _analyse_lines( $f, $stref );
		print "DONE _analyse_lines( $f )\n" if $V;

		say "ANALYSE LOOPS/BREAKS in $f\n" if $V;
		$stref = _identify_loops_breaks( $f, $stref );
		say "DONE _identify_loops_breaks($f)\n" if $V;
		
## 3. Parse use
		$stref = _parse_use( $f, $stref );
		print "DONE _parse_use( $f )\n" if $V;

## 4. Parse includes
# NOTE: Apart from simply parsing, this routine also causes IMPLICITs from the include file to be inherited by the parent
		$stref = _parse_includes( $f, $stref );

## 5. Parse subroutine and function calls
		if ( not $is_incl and not $is_mod) {

			# Recursive descent via subroutine calls
			$stref = _parse_subroutine_and_function_calls( $f, $stref );
			$stref->{$sub_or_incl_or_mod}{$f}{'Status'} = $PARSED;
			print "DONE PARSING $sub_or_incl_or_mod $f\n" if $V;

		} elsif ($is_incl) {    # includes
			$stref->{'IncludeFiles'}{$f}{'Status'} = $PARSED;
		} else {						
			$stref->{'Modules'}{$f}{'Status'} = $PARSED;			
		}

	   # 7. Split variable declarations with multiple vars into single-var lines
	   # One could say this is "refactoring" but I say it's "preconditioning"
		$stref = _split_multivar_decls( $f, $stref );
		
		$stref = _split_multipar_decls_and_set_type( $f, $stref );
		} else {
			say "INFO: SKIPPING ENTRY $f" if $I;
		}
	} else {
		print "INFO: $f is EXTERNAL\n" if $I;
	}

	print "LEAVING parse_fortran_src( $f ) with Status "
	  . show_status( $stref->{$sub_or_incl_or_mod}{$f}{'Status'} ) . "\n"
	  if $V;
	   if ($f eq 'read_ncwrfout_gridinfo') {
	   }
	   
	   if ($is_mod) { 
	   	for my $sub ( @{ $stref->{'Modules'}{ $f }{'Contains'} } ) {
#	   		say $sub;
	   		$stref = parse_fortran_src($sub, $stref);
	   	}
#		croak $f;
	   }
	   
	return $stref;

}    # END of parse_fortran_src()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# parse_fortran_src() parses the source but does perform only limited context-free analysis
# This routine is recursive
# This should go into Refactoring::Blocks.pm
sub refactor_marked_blocks_into_subroutines {
	( my $stref ) = @_;

#	local $V=1;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if exists $stref->{'Entries'}{$f}; 
		if ( exists $stref->{'Subroutines'}{$f}{'HasBlocks'}
			and $stref->{'Subroutines'}{$f}{'HasBlocks'} == 1 ) {

			say "refactor_marked_blocks_into_subroutines(): PARSING $f" if $V;

			my $sub_or_incl_or_mod = sub_func_incl_mod( $f, $stref );
			my $is_incl = $sub_or_incl_or_mod eq 'IncludeFiles';
			my $is_external_include = $is_incl ? ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'External' ) : 0;

			say "SRC TYPE for $f: $sub_or_incl_or_mod" if $V;
            
			if ( $sub_or_incl_or_mod ne 'ExternalSubroutines'
				and not $is_external_include ) {
				## 5. Parse subroutine and function calls
				if ( not $is_incl ) {
					if ( $stref->{$sub_or_incl_or_mod}{$f}{'HasBlocks'} == 1 ) {
						$stref = _separate_blocks( $f, $stref );
					}
				}
			} else {
				say "INFO: $f is EXTERNAL" if $I;
			}
			say "LEAVING refactor_marked_blocks_into_subroutines( $f ) with Status $stref->{$sub_or_incl_or_mod}{$f}{'Status'}" if $V;
		}
	}
	
	return $stref;
	
}    # END of refactor_marked_blocks_into_subroutines()

# -----------------------------------------------------------------------------
# Here I initialise tables for Variables and Declarations and a few other Subroutine-specific data structures
sub _initialise_decl_var_tables {
	( my $Sf, my $stref, my $f, my $is_incl, my $is_mod ) = @_;
	my $code_unit = $is_incl ? 'include' : $is_mod ? 'module' : 'subroutine';
	say "_initialise_decl_var_tables for $code_unit $f" if $V;	
	
	if ( not exists $Sf->{'ReferencedLabels'}) {
		$Sf->{'ReferencedLabels'}={};
	}
	if ( not exists $Sf->{'MaskedIntrinsics'} ) {
		$Sf->{'MaskedIntrinsics'}={};
	}
	if ( not exists $Sf->{'CalledSubs'} ) {
		$Sf->{'CalledSubs'} = { 'List' => [], 'Set' => {} };
	}
	if ( not exists $Sf->{'CalledEntries'} ) {
		$Sf->{'CalledEntries'} = { 'List' => [], 'Set' => {} };
	}
	if ( not exists $Sf->{'Entries'} ) {
		$Sf->{'Entries'} = { 'List' => [], 'Set' => {} };
		$Sf->{'Entry'}=0;
	}
# WV20151021 what we need here is a check that this function has not been called before for this $Sf
	if ( not exists $Sf->{'DoneInitTables'} ) {
		say "_initialise_decl_var_tables : INIT TABLES for $code_unit $f" if $V;

		$Sf->{'HasCommons'} = 0;

		# WV20151021 maybe need to do that for all subsets of Vars too?
		# WV20151021 the question is if this needs to be hierarchical?
		# Also, I think I wil use 'Subsets'
		$Sf->{'DeclaredOrigLocalVars'}   = { 'Set' => {}, 'List' => [] };
		$Sf->{'UndeclaredOrigLocalVars'} = { 'Set' => {}, 'List' => [] };

		#		$Sf->{'Parameters'} = {};
		$Sf->{'LocalParameters'}    = { 'Set' => {}, 'List' => [] };
		$Sf->{'IncludedParameters'} = { 'Set' => {}, 'List' => [] };
		$Sf->{'UsedParameters'} = { 'Set' => {}, 'List' => [] }; # 
		$Sf->{'InheritedParameters'} = { 'Set' => {}, 'List' => [] }; 
		$Sf->{'ParametersFromContainer'} = { 'Set' => {}, 'List' => [] };

		# Var decls via a 'use' declaration
		$Sf->{'UsedLocalVars'} = { 'Set' => {}, 'List' => [] };
		$Sf->{'UsedGlobalVars'} = { 'Set' => {}, 'List' => [] };		

		# This is only for testing which vars are commons, nothing else.
		$Sf->{'Commons'} = {}; 

# FIXME At the moment we assume automatically that CommonVars become ExGlobArgs 
# WV20170607 I now also assume that any var declared in a USEd module is a global, so will become ExGlobArg   
		$Sf->{'DeclaredCommonVars'}   = { 'Set' => {}, 'List' => [] };						
		$Sf->{'UndeclaredCommonVars'} = { 'Set' => {}, 'List' => [] };
		
		$Sf->{'CommonVars'}           = {
			'Subsets' => {
				'DeclaredCommonVars'   => $Sf->{'DeclaredCommonVars'}, # I overload this to contain UsedGlobalVars
				'UndeclaredCommonVars' => $Sf->{'UndeclaredCommonVars'},
			}
		};

		$Sf->{'OrigLocalVars'} = {
			'Subsets' => {
				'DeclaredOrigLocalVars' => $Sf->{'DeclaredOrigLocalVars'},
				'UndeclaredOrigLocalVars' =>
				  $Sf->{'UndeclaredOrigLocalVars'}
			}
		};
		
		
		if ( not $is_incl and not $is_mod ) {

 # WV: Maybe I should have an additional record 'FromInclude' in the set record!
 # This seemed like a good idea but it requires so many changes. Instead I think I'll just populate ExGlobArgs on the fly
# 			$Sf->{'ExInclGlobArgs'} = { 
#				'Set' => {}, 'List' => [] 
#			};
# 			$Sf->{'ExContainerGlobArgs'} = { 
#				'Set' => {}, 'List' => [] 
#			};
 
			$Sf->{'RenamedInheritedExGlobs'}  = { 'List' => [], 'Set' => {}};
			
			$Sf->{'ExGlobArgs'} = { 
				'Set' => {}, 'List' => [] 
			};
    
			$Sf->{'ExInclArgs'}         = { 'Set' => {}, 'List' => [] };
			$Sf->{'DeclaredOrigArgs'}   = { 'Set' => {}, 'List' => [] };
			$Sf->{'UndeclaredOrigArgs'} = { 'Set' => {}, 'List' => [] };

			$Sf->{'ExInclLocalVars'} = { 'Set' => {}, 'List' => [] };

			$Sf->{'LocalVars'} = {
				'Subsets' => {
					'OrigLocalVars'   => $Sf->{'OrigLocalVars'},
					'ExInclLocalVars' => $Sf->{'ExInclLocalVars'},
					'UsedLocalVars' => $Sf->{'UsedLocalVars'}, # presumably this is always empty					
				}
			};
			
			$Sf->{'OrigArgs'} = {
				'Subsets' => {
					'UndeclaredOrigArgs' => $Sf->{'UndeclaredOrigArgs'},
					'DeclaredOrigArgs'   => $Sf->{'DeclaredOrigArgs'}
				},
				'List' => [],
			};
			
			$Sf->{'Args'} = {
				'Subsets' => {
					'OrigArgs'   => $Sf->{'OrigArgs'},
					'ExGlobArgs' => $Sf->{'ExGlobArgs'},
					'ExInclArgs' => $Sf->{'ExInclArgs'}
				}
			};

			$Sf->{'Parameters'} = {
				'Subsets' => {
					'LocalParameters'    => $Sf->{'LocalParameters'},
					'IncludedParameters' => $Sf->{'IncludedParameters'},
					'UsedParameters' => $Sf->{'UsedParameters'},
					'ParametersFromContainer' =>
					  $Sf->{'ParametersFromContainer'}
				}
			};
			$Sf->{'Vars'} = {
				'Subsets' => {
					'Args'       => $Sf->{'Args'},
					'CommonVars' => $Sf->{'CommonVars'},
					'LocalVars'  => $Sf->{'LocalVars'},
					'Parameters' => $Sf->{'Parameters'}
				}
			};

		} else {    # For includes and modules
 
# 			say "MOD $f";
 			if ($is_mod) { 				
 				for my $sub (sort keys %{ $Sf->{Subroutines} }) {
 					$stref->{'Subroutines'}{$sub} =_initialise_decl_var_tables( $stref->{'Subroutines'}{$sub}, $stref, $sub,0,0);
 				}		
 			}
			# Includes can contain LocalVars, CommonVars or Parameters
			# Commons can't be Args so they will go in ExInclLocalVars?
			# I guess includes can contain other includes that contain all this as well, how do I deal with that?			

			$Sf->{'LocalVars'} =
			  { 'Subsets' => { 
			  	'OrigLocalVars' => $Sf->{'OrigLocalVars'},
			  	'UsedLocalVars' => $Sf->{'UsedLocalVars'} 
			  } 
			  };

			$Sf->{'Parameters'} = {
				'Subsets' => {
					'LocalParameters'    => $Sf->{'LocalParameters'},
					'IncludedParameters' => $Sf->{'IncludedParameters'},
					'UsedParameters' => $Sf->{'UsedParameters'}
				}
			};
			$Sf->{'Vars'} = {
				'Subsets' => {
					'LocalVars'  => $Sf->{'LocalVars'},
					'CommonVars' => $Sf->{'CommonVars'}, # I will overload this to include UsedGlobalVars
					'Parameters' => $Sf->{'Parameters'}
				}
			};
		}

		$Sf->{'DoneInitTables'} = 1;
	}
	return $Sf;
}

# _analyse_lines() parses every line and determines its purpose, the info is added to $info. Furthermore,
# Create a table of all variables declared in the target, and a list of all the var names occuring on each line.
# $Sf->{'Parameters'}
# $Sf->{'Vars'} = \%vars;

# We record the type of the var and whether it's a scalar or array, because we need that information for translation to C.
# Also check if the variable happens to be a function. If that is the case, mark that function as 'Called'; if we have not yet parsed its source, do it now.

# In order to get proper hooks for the ex-globals, I think we need to check signatures, includes and variable declarations here.

#WV20150305 I've added labels to the lines, as identifiers for e.g. start/end of pragmas. I can do this here because here the lines have been normalised but no refactoring has been done yet.
sub _analyse_lines {
	( my $f, my $stref ) = @_;
	my $sub_incl_or_mod = sub_func_incl_mod( $f, $stref );
	
	my $is_incl = $sub_incl_or_mod eq 'IncludeFiles' ? 1 : 0;
	my $Sf = $stref->{$sub_incl_or_mod}{$f};
	$Sf->{'ExGlobVarDeclHook'} = 0;
	my $srcref = $Sf->{'AnnLines'};

	if ( defined $srcref ) {
		
		print "\nINFO: VAR DECLS in $f:\n" if $I;
		my %vars = ();

		my $in_excluded_block	   = 0; # for printing a given block for debug
		my $excluded_block   = -1;
		my $first          = 1;		
		my $type           = 'NONE';
		my $has_commons	= 0;
		my $has_pars	= 0;
		my $varlst         = '';
		my $indent         = '';
		my @do_stack       = ();
		my $do_counter     = 0;
		my $case_counter     = 0;
		my $block_nest_counter = 0;
		my $block_counter = 0;
		my $current_block={};
		my %block_id = ();
		my @blocks_stack=();
		my %extra_lines=(); # $index => [ ... ]

		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $attr = '';
			( my $lline, my $info ) = @{ $srcref->[$index] };
			
#			say $lline;
			# Get indent			
			$lline =~ /^(\s+).*/ && do { $indent = $1; }; # This is not OK for lines with labels of course.
			$info->{'Indent'}=$indent;						
			$info->{'LineID'} = $index;
			

			# Skip comments (we already marked them in SrcReader)
			if ( $lline =~ /^\s*\!/ && $lline !~ /^\!\s*\$(?:ACC|RF4A)\s/i ) {
				next;
			}
			if (exists $info->{'Macro'} and not exists $info->{'Includes'} ) {
				next;
			} 

			# Handle !$ACC
			if ( $lline =~ /^\!\s*\$(?:ACC|RF4A)\s.+$/i ) {				
				( $stref, $info ) = __handle_acc( $stref, $f, $index, $lline );
			}
			if (exists $info->{'AccPragma'}{'BeginKernel'}) {
				$Sf->{'HasKernelRegion'}=1;
			}
			# Here we remove the label if there is one, but we store it in Label so we can re-emit it
			my $line = $lline;
			
			if ($line=~/^\s*(\d+)/) {
				my $label=$1;
				$info->{'Label'}=$label;
				$line=~s/^\s*\d+\s*//;	
			} else {
				# remove any leading spaces
				$line=~s/^\s+//;
			}
			
			# --------------------------------------------------------------------------------
			# BLOCK identification code
			# --------------------------------------------------------------------------------
			# START of BLOCK
			
			$line=~/^(map|structure|union|select)\s+/ && do {
				my $block_type=$1;
				++$block_nest_counter;
				++$block_counter;
				my $block = {'Nest'=>$block_nest_counter, 'Type' => $block_type, 'LineID' => $index, 'InBlock' => $current_block };
				$block_id{$block_counter}=$block;
				$current_block=$block;
				push @blocks_stack,$block_id{$block_counter}; 
				$info->{ucfirst($block_type)}=1;
				say $lline. "\t\tPUSH $block_nest_counter " if $in_excluded_block and $DBG;
			};
			
			$line=~/^if.*?then\s*$/ && do {				
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => 'if', 'LineID' => $index, 'InBlock' => $current_block };
				if ($line=~/if\s*\(\s*0\s*\)/) {
					$in_excluded_block=1;
					$excluded_block=$block_nest_counter;
					$block->{'Type'}='if0';
				}
				
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter" if $in_excluded_block and $DBG;
			};	
			$line=~/^do\s+(\w+)\s+\w+\s*=/ && do {				 
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => 'do', 'Label' => $1, 'LineID' => $index, 'InBlock' => $current_block };
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter" if $in_excluded_block and $DBG;
			};	
			$line=~/^do\s+\w+\s*=/ && do {				 
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => 'do', 'Label' => '', 'LineID' => $index, 'InBlock' => $current_block };
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter DO (NO LABEL)" if $in_excluded_block and $DBG;
			};						
			# SUBROUTINE FUNCTION PROGRAM
			# Procedure block identification				
			$line =~ /^(\w+\s+\w+\s+(?:function|subroutine)|\w+\s+subroutine|[\*\(\)\w]+\s+function|function|subroutine|program|block)\s+(\w+)/ && do {				
				my $full_proc_type=$1;
				my $proc_name=$2;
#				say "PROC NAME in $f: $proc_name" if $f ne $proc_name;			
				my $proc_type = $full_proc_type=~/program/ ? 'program' : 
					$full_proc_type=~/subroutine/ ? 'subroutine' : 
					($full_proc_type eq 'block' and $proc_name eq 'data') ? 'block data' : 
					'function';
				if ($proc_type eq 'block data') {
					$full_proc_type = 'block data';
					$proc_name = 'block_data';
                	$line=~/block\s+data\s+(\w+)/i && do { $proc_name=$1 };
				}
				# If it's a function, create a record for the return value
				if ($proc_type eq 'function') {
					$full_proc_type=~s/\s+$//;
					if ($full_proc_type ne 'function') {
						$full_proc_type=~s/\s+function//;
						$full_proc_type=~s/\s*(?:pure|recursive|elemental)\s*//;
						if ($full_proc_type ne '' and $full_proc_type ne 'block data') {
							$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$proc_name}={
								'Indent'=> $indent,
								'Type'          => $full_proc_type ,
								'ArrayOrScalar' => 'Scalar',
								'Dim'           => [],
								'Attr' => '',
								'IODir' => 'Out',
								'Name'=>$proc_name
							};
							push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} },$proc_name; 
						}
					}
				}								        						
				++$block_nest_counter;
				++$block_counter;
				
				my $block={'Nest'=>$block_nest_counter, 'Type' => $proc_type, 'Name'=>$proc_name, 'LineID' => $index, 'InBlock' => $current_block };
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter" if $in_excluded_block and $DBG;
			};
			
			# END of BLOCK:			
#			$line=~/^end/ && $line!~/^end\s*do/ && do {
			$line=~/^end/  && do { 
				my $block = pop @blocks_stack;
				say $lline. "\t\tPOP $block_nest_counter ".uc($block->{'Type'})  if $in_excluded_block and $DBG;
				$info->{'Block'}= $block;
				$current_block=$block;
				--$block_nest_counter;
#				croak Dumper($block) if $line=~/endif/ and ;
				if (defined $block and exists $block->{'Nest'} and $block->{'Nest'} == $excluded_block and $in_excluded_block==1) {
#					say "ENDIF: $lline";croak;
					$in_excluded_block=2;
					$excluded_block=-1;
				}
			};
			
#    CONTINUE statement. 			
			$line=~/^continue/ && do {
				if (exists $info->{'Label'} ) {
				my $cont_label=$info->{'Label'} ;
				$info->{'Continue'}={'Label' => $cont_label};

				my $block = pop @blocks_stack; 
				say $lline. "\t\tPOP $block_nest_counter continue" if $in_excluded_block and $DBG;
				if (exists $block->{'Label'} ) {
					my $do_label =$block->{'Label'};
					if ($cont_label eq $do_label) {
#						say "\t" x $block_nest_counter,"END for block #$block_counter, NEST:".$block->{'Nest'}.' CONTINUE'." LABEL: ".$do_label;
						$info->{'Block'}= $block;
						$current_block=$block;
						$info->{'EndControl'}= 1;				 
						--$block_nest_counter;
					} else {
						push @blocks_stack, $block;
						say $lline. "\t\tPUSH $block_nest_counter continue (incorrect DO label)" if $in_excluded_block and $DBG;
					}
				} else {
					push @blocks_stack, $block;
					say $lline. "\t\tPUSH $block_nest_counter continue (no DO label)" if $in_excluded_block and $DBG;
				}
				} else {
					$info->{'Continue'}={};
				}
			};
			# --------------------------------------------------------------------------------
			# END of BLOCK identification code			
			# --------------------------------------------------------------------------------
						
if ($in_excluded_block==0) {						
			# --------------------------------------------------------------------------------
			# Declarations, anything not an executable statement. Last one in the chain is the IF/THEN/ELSE			
			# --------------------------------------------------------------------------------

=info non-executable statements
Statements with * are currently ignored
Statements with ** are currently not even recognised

AUTOMATIC*
EQUIVALENCE* => WARNING
EXTERNAL*
INTRINSIC*
STATIC*
MAP/END MAP*
STRUCTURE/END STRUCTURE*
UNION/END UNION*

ENTRY** => WARNING
FORMAT**
NAMELIST**
OPTIONS**
POINTER**
PRAGMA**
RECORD**
SAVE**
VOLATILE**

BLOCK DATA
BYTE
CHARACTER
COMMON
COMPLEX
DATA
DIMENSION
DOUBLE COMPLEX
DOUBLE PRECISION
FUNCTION
IMPLICIT
INCLUDE
INTEGER
LOGICAL
PARAMETER
PROGRAM
REAL
SUBROUTINE
VIRTUAL

=cut
						
						
			if ( $line =~ /implicit\s+none/ ) {
				$info->{'ImplicitNone'} = 1;
				$Sf->{'ImplicitNone'}   = $index;
				$srcref->[$index] = [ $line, $info ];
				next;
			} elsif ( $line =~ /^use\s+(\w+)/ ) {
				my $module = $1;
				$info->{'Use'} = $module;
				$srcref->[$index] = [ $line, $info ];
				next;
				
			} elsif ( $line =~ /implicit\s+/ ) {
				$info->{'Implicit'} = 1;
				$stref = _parse_implicit( $line, $f, $stref );
				$srcref->[$index] = [ $line, $info ];
				next;	
			}			
# END of IF/SELECT/DO						
			elsif ( $line =~ /^end\s*(if|select|do)\s*/ ) {			
				my $keyword = $1;
				my $kw      = ucfirst($keyword);
				$info->{ 'End' . $kw } = {};
				$info->{ 'EndControl' } = 1;
				if ( $kw eq 'Do' ) {
					$do_counter--;
					my $corresponding_do_info = pop @do_stack;
					$info->{'EndDo'} = $corresponding_do_info->{'Do'};					
					delete $info->{'EndDo'}{'Label'};
					my $do_label = $corresponding_do_info->{'Do'}{'Label'};					
					if (defined $do_label and $do_label ne 'LABEL_NOT_DEFINED') {						
						$Sf->{'DoLabelTarget'}{$do_label}='EndDo';
					}					
				}
			}			
# DIMENSION (VIRTUAL)		
		 elsif ( $line =~ /^(?:dimension|virtual)/ ) {			
# Although a Dimension line is not a declaration, I will use it as such, so the var must be in DeclaredLocalVars/DeclaredCommonVars
				$info->{'Dimension'}=1;
				$type   = 'Unknown';
				$varlst = $line;
				$varlst =~s/^(?:dimension|virtual)\s+//;			
#				my $indent =$line;$indent=~s/\S.*$//;	
				my @vars_with_dim = _parse_comma_sep_expr_list($varlst);
# If @vars_with_dim > 1 then we should split this line.
# We currently do $srcref->[$index], with $index = 0 .. scalar( @{$srcref} ) - 1 ) 				
# So in order to splice in lines, what I guess I should do is create these new lines and store them at some index, then
# use that index to break up $annlines and splice them in: [@{$annlines}[0..$index], $extra_lines,@{$annlines}[$index.. $end_index] ]
					
					$extra_lines{$index}=[];
					for my $var_dim (@vars_with_dim ) {
						my $dline = $var_dim;
					my $varname = $var_dim;
					$varname=~s/\s*\(.+//;
					$var_dim=~s/^\w+/dimension/;
					my $type='Unknown';				

					my $subset;
#					my $stmt_count=1;
					my $is_macro = exists $Config{'Macros'}{uc($varname)} ? 1 : 0;
					if (not $is_macro ) {
					if (not in_nested_set( $Sf, 'Vars', $varname ) ) {
						# So this var was not declared before. Declare it and type it, then get the dimension 
						($type, my $array_or_scalar, my $attr)= type_via_implicits($stref, $f,$varname);
							$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}={
								'Indent' => $indent,
								'Type' => $type,
								'ArrayOrScalar'=>$array_or_scalar,
								'Attr' => $attr,
								'Dim'=>[],
								'Name'=>$varname,
								'Names'=>[$varname],
#								'StmtCount' => 1,
							};		
							$subset='DeclaredOrigLocalVars';					
					} else {
						
						my $decl = get_var_record_from_set($Sf->{'Vars'},$varname);
						$subset = in_nested_set( $Sf, 'Vars', $varname );
#						
#						if ($subset eq 'ExGlobArgs' ) {
#							$subset = 'DeclaredCommonVars'; # because in_nested_set() can find either one
#						}
						if ($decl eq '1' and $subset eq 'UndeclaredOrigArgs') {			
							# This is for so far undeclared arguments: they already have an entry
							# We call __parse_f95_decl on them and that will make them DeclaredOrigArgs
							
								($type, my $array_or_scalar, my $attr)= type_via_implicits($stref, $f,$varname);
								$decl={
									'Indent' => $indent,
									'Type' => $type,
									'ArrayOrScalar'=>$array_or_scalar,
									'Attr' => $attr,
									'Dim'=>[],
									'Name'=>$varname,
									'Names'=>[$varname],
									'IODir' => 'Unknown',
#									'StmtCount' => 1,
								};		
								$Sf->{'UndeclaredOrigArgs'}{'Set'}{$varname}=$decl;																				
						} else {
							
							# Means that the variable is either declared via T or undeclared via C. 	
							if ($subset eq 'UndeclaredCommonVars') {
								my $decl = dclone( $Sf->{'UndeclaredCommonVars'}{'Set'}{$varname} );
								$Sf->{'DeclaredCommonVars'}{'Set'}{$varname} = $decl;
								delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$varname};
								@{ $Sf->{'UndeclaredCommonVars'}{'List'} } =  grep { $_ ne $varname } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
								$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$varname] );
								
							}  						
						}
						$type = $decl->{'Type'};
					}
					 my $vline = "$type, $var_dim  :: $varname";
				( $Sf, my $info ) = __parse_f95_decl( $stref, $f, $Sf, $indent, $vline, {'Dimension' => 1});#, "$type, $var_dim", $varname );
				$Sf->{'DeclCount'}{$varname}++;
				$info->{'StmtCount'}{$varname}=$Sf->{'DeclCount'}{$varname};#$stmt_count;#$Sf->{$subset}{'Set'}{$varname}{'StmtCount'};
					push @{ $extra_lines{$index} }, [$indent."dimension $dline",$info];
				} # if it's not a macro
		 }
				next;
		}
			# COMMON block processing for common blocks not in an include file
			# common /name/ x...
			# However, common/name/x is also valid, and even  common x, damn F77!
			# And in fact, so is common /name/ x,y, /name2/ w,z
			# Worse, the spec is COMMON [/[ cb ]/] nlist [[,]/[ cb ] / nlist ]
			# so  x//y is also OK and //x also ... 
		 elsif ( $line =~ /^common\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ or 
				$line =~ /^(common)\s+(.+)$/ 
		 ) {
				my $common_block_name = $1; # means it will be 'common' for a blank block
				my $commonlst         = $2;
				$commonlst=~s/\/\//,/g;
				$commonlst=~s/^,//;        
				$has_commons=1; 				
#				say "COMMON for $f: $commonlst"; 
				( my $parsedvars, my $parsedvars_lst ) = f77_var_decl_parser( $commonlst, 0 );				
				for my $var ( @{$parsedvars_lst} ) {	
#					my $subset;
					$Sf->{'Commons'}{$var} = $var;
					if ( not in_nested_set( $Sf, 'Vars', $var ) ) {    # This means that it is an undeclared common
							print "INFO: common <", $var, "> typed via Implicits for $f\n" if $I;
							my @type_kind_attr =
							  type_via_implicits( $stref, $f, $var );
							( my $type, my $array_or_scalar, my $attr ) =
							  @type_kind_attr;
							my $default_indent = ' ' x 6;
							my $decl   = {
								'IODir'  => 'Unknown',
								'Indent' => $default_indent,
								'Type'   => $type,
								'Attr'   => $attr,
								'Dim'    => [ @{ $parsedvars->{$var}{'Dim'} } ],
								'Name'   => $var,
								'Status' => 1,								
								'ArrayOrScalar' => $parsedvars->{$var}{'ArrayOrScalar'},
								'CommonBlockName' => $common_block_name
							};
							
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$var} = $decl;
							push  @{ $Sf->{'UndeclaredCommonVars'}{'List'} },$var;
							say "INFO: DECLARED COMMON VAR $var from $f, was typed via implicit rules" if $I;							
					} else { # Means the var is already declared. So just use the existing declaration
						# As this is a common it can't be an argument
						if (exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var} ){
							my $decl = $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var};
#							say Dumper($decl).'<>'.Dumper($parsedvars->{$var});
							if (
							(not exists $decl->{'ArrayOrScalar'} or
								$decl->{'ArrayOrScalar'} eq 'Scalar') and 
								$parsedvars->{$var}{'ArrayOrScalar'} eq 'Array'
							) {								
								$decl->{'Dim'} =  [ @{ $parsedvars->{$var}{'Dim'} } ];	
							} elsif (
							exists $decl->{'ArrayOrScalar'} and
								$decl->{'ArrayOrScalar'} eq 'Array' and 
								$parsedvars->{$var}{'ArrayOrScalar'} eq 'Array'							
							) {
								croak "This should be an error: dimension of $var speficied both in VarDecl and Common";
							}
							
							$Sf->{'DeclaredCommonVars'}{'Set'}{$var} = dclone($decl);
							$Sf->{'DeclaredCommonVars'}{'Set'}{$var}{'CommonBlockName'} = $common_block_name;
							delete $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var};
							@{ $Sf->{'DeclaredOrigLocalVars'}{'List'} } = grep { $_ ne $var } @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} };
							push @{ $Sf->{'DeclaredCommonVars'}{'List'} }, $var;
						} else {
							my $subset = in_nested_set( $Sf, 'Vars', $var );
							croak "SHOULD BE IMPOSSIBLE!  $var in $subset in $f: $line".Dumper( $Sf->{$subset}{'Set'}{$var} );
						}						
					}
#					croak Dumper($Sf->{'DeclaredCommonVars'}{'Set'}{'alat'}) if $f eq 'atmos' and $var eq 'alat';
				} # for loop 
				
				$info->{'Common'} = { 'Name' => $common_block_name , 'Vars' => 
					{
						'Set' =>$parsedvars, 'List' => $parsedvars_lst
					}
				};
#				croak Dumper($info);
			}		
# NAMELIST
		elsif (	$line =~ /^namelist\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ 				 
		 ) {
				my $namelist_group_name = $1;
				my $namelist_varlst         = $2;
				$namelist_varlst=~s/\/\//,/g;
				$namelist_varlst=~s/^,//;        
				$info->{'Namelist'}=$namelist_group_name; 				
				 $Sf->{'Namelist'}{$namelist_group_name} = [ split(/\s*,\s*/,$namelist_varlst) ];
				 
		 }
		elsif ( $line =~/^format/) {
			$info->{'Format'}=1;
		}
# DATA
		elsif ($line=~/^data\b/ and $line!~/=/) { 
		 	# DATA
		 	$info->{'Data'} = 1;
		 	
		 		$line.=' ! Parser line '.__LINE__.' : removed spaces from data';
			 	my @chunks = split(/\//,$line);
			 	$chunks[1]=~s/\s+//g;
			 	$line=join('/',@chunks);
#				$line = _expand_repeat_data($line);		
				say "DATA declaration $line" if $V;
#				$extra_lines{$index}=_parse_data_declaration($line,$info, $stref, $f);
#				next;
		} 
		elsif  ($line=~/^data\b/ and $line=~/=/ and $line=~/\/\s*$/ ) {
		    	# This is either a DATA declaration with an implicit DO, or else an assignment to the variable data
		    	# which can be an array with an arbitrary expression ...
		    	# A really ugly, ad-hoc way is like this:
		    	# if the last character is a '/'
		    	# and there is a match on ')/'
		    	# we can split between the ')' and '/'
		    	# However, how about we do just nothing?
		    	say "DATA declaration with IMPLIED DO at $line" if $V;
		}
# INTRINSIC, EXTERNAL, STATIC, AUTOMATIC
		 	elsif ($line=~/^(intrinsic|external|static|automatic)\s+([\w,\s]+)/) {
		 		my $qualifier = $1;
		 		my $external_procs_str = $2;
		 		my @external_procs = split(/\s*,\s*/,$external_procs_str);

		 		$info->{ucfirst($qualifier)} = { map {$_=>1} @external_procs};
		 		$Sf->{ucfirst($qualifier)}={ map {$_=>1} @external_procs };
		 		
		 			say "WARNING: ".uc($qualifier)." IS IGNORED!" if $qualifier ne 'external' and $W;
		 	}
# EQUIVALENCE (IADN14(1), IADN15(1)), (RADN14(2),RADN15(2))		 	 
		 	elsif ($line=~/^equivalence\s+/) {		 	
		 		$info->{'Equivalence'} = 1;
		 		say "WARNING: EQUIVALENCE IS IGNORED!" if $W;
		 		warn "The EQUIVALENCE  statement is not supported, please rewrite your code (or ignore at your peril):\n".
			 		'SOURCE: '.$stref->{'Subroutines'}{$f}{'Source'}.' LINE #'. $info->{'LineID'}."\n".
			 		'CODE UNIT: '.$f."\n".
			 		'LINE: '."'$line'\n";
		 		
		 	}		
# Actual variable declaration line (F77)
# In principle every type can be followed by '*<number>' or *(*) or (<number>)
# F77 VarDecl
			elsif (
				(				
					$line =~
/^(logical|complex|byte|integer|real|double\s*(?:precision|complex)|character)\s+([^\*]?.*)\s*$/
					or $line =~
/^((?:logical|complex|byte|integer|real|double\s*(?:precision|complex)|character)\s*\(\d+\))([^\*]?.*)\s*$/

					or $line =~
/^((?:logical|complex|byte|integer|real|double\s*(?:precision|complex)|character)\s*\*(?:\d+|\((?:\*|\w+)\)))\s+(.+)\s*$/
				)
				and $line !~ /\s+function\s+\w+/
				and $line !~/^.+,.+::\s*.+\s*$/ # What we say here is that a declaration such as real(4) :: v(nx+1,ny) is treated as F77 
			  ) {			  	
				$type   = $1;
				$varlst = $2;
				
				( $Sf, $info ) = __parse_f77_var_decl( $Sf, $stref, $f,$indent, $line, $info, $type, $varlst );
				
		}
# F95 declaration, no need for refactoring		 	
		 elsif ( $line =~ /^(.+)\s*::\s*(.+)\s*$/ ) { 
				( $Sf, $info ) = __parse_f95_decl( $stref, $f, $Sf, $indent, $line, $info);								
				if (exists $info->{'ParamDecl'}) {
					$has_pars=1;
				}		
			} 
# PARAMETER			
# F77-style parameters			
			elsif ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ ) {    
				my $parliststr = $1;
				( $Sf, $info ) = __parse_f77_par_decl( $Sf, $f, $indent, $line, $info, $parliststr );				
				$has_pars=1;
			}    # match var decls, parameter statements F77/F95								
# SIGNATURES SUBROUTINE FUNCTION PROGRAM ENTRY
			 elsif ( $line =~ /\b(subroutine|function|program|entry|block)\b/ and $line !~ /^end\s+/) {
				( $Sf, $line, $info ) =
				  __parse_sub_func_prog_decls( $Sf, $line, $info );
			 }
# END of CODE UNIT
			 elsif (
				$line =~ /^end\s+(subroutine|module|function|block\s+data)\s*(\w+)/ 
				) {
				my $kw   = $1;
				my $name = $2;
				$info->{ 'End' . ucfirst($kw) } = { 'Name' => $name };
# DO statement				
			} elsif ( $line =~ /^do\b/) { 

#WV20150304: We parse the do and store the iterator and the range { 'Iterator' => $i,'Range' =>[$start,$stop]}
				my $do_stmt = $line;
				my $label   = $info->{'Label'} // 'LABEL_NOT_DEFINED';
				if ( $do_stmt =~ /do\s+\d+/ ) {
					$do_stmt =~ s/^do\s+(\d+)\s+//;
					my $label = $1;
				} else {					
					$do_stmt =~ s/^do\s+//;
				}
				# test for while here
				if ($do_stmt=~/while/) {
					$do_stmt=~s/while\s*//;
					# we can parse this as a normal expression I think						
					my $ast = parse_expression($do_stmt,  $info,  $stref,  $f);
					my $mvars = get_vars_from_expression($ast,{});
					my $vars= [ grep {!/_OPEN_PAR_/} keys %{$mvars} ];
					carp 'FIXME: support for WHILE:'.$line.Dumper($vars);
					$info->{'Do'} = {
						'While' =>1,
						'Iterator' => '',
						'Label'    => $label,
						'ExpressionsAst' => $ast,
						'Range'    => {	
							'Vars'        => $vars,
							},
						'LineID' => $info->{'LineID'}
					};
				} else {
					( my $iter, my $range ) = split( /\s*=\s*/, $do_stmt );
					( my $range_start, my $range_stop, my $range_step ) = split( /s*,\s*/, $range );
					if (not defined $range_step) {
						$range_step=1; # the default
					}
					my $mvars = [];
					for my $mchunk ( $range_start, $range_stop,$range_step ) {
						next if not defined $mchunk;
						next if $mchunk =~ /^\d+$/;
						my @mchunks = ();
						if ( $mchunk =~ /\W/ ) {
							@mchunks = split( /\W+/, $mchunk );
						} elsif ( $mchunk =~ /^\w+$/ ) {
							push @mchunks, $mchunk;
						} else {
							croak "Unknown pattern $mchunk in Do Range";
						}
						for my $mvar (@mchunks) {
							next if exists $Config{'Macros'}{uc($mvar)}; # skip macros
							next if exists $F95_reserved_words{$mvar};
							next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar};    # Means it's a function
							next if $mvar =~ /^__PH\d+__$/;
							next if $mvar !~ /^[_a-z]\w*$/;
							push @{$mvars}, $mvar;
						}
					}
					$info->{'Do'} = {
						'Iterator' => $iter,
						'Label'    => $label,
						'Range'    => {
							'Expressions' => [ $range_start, $range_stop, $range_step ],
							'Vars'        => $mvars
						},
						'LineID' => $info->{'LineID'}
					};
				}
				$info->{ 'Control' } = 1;
				$do_counter++;
				push @do_stack, $info;
# SELECT/CASE 
			} elsif ($line=~/select\s+case\s*\((\w+)\)/) {
					$info->{'CaseVar'} = $1;
					$info->{ 'Control' } = 1;
				} elsif ($line=~/case\s*\((.+)\)\s*$/) {
					my $case_vals_str = $1;
					my @case_vals = _parse_comma_sep_expr_list($case_vals_str);
					$info->{'CaseVals'} = [@case_vals];
					$info->{ 'Control' } = 1;
					$info->{ 'Case' } = ++$case_counter;				
				} elsif ($line=~/case\s+\default/) {
					$info->{'CaseDefault'} = 1;
					$info->{ 'Control' } = 1;			
			}
# ELSE			 
			elsif ( $line =~ /^else\s*$/ ) {			 	
					$info->{'Else'} = 1;			
					$info->{ 'Control' } = 1;
					$info->{ 'EndControl' } = 1;		
	
			} else {
# Check for IF and remove it, then check for executable statements that can come after IF				
				my $mline = $line;    # modifiable copy of $line				

				
# Block, Arithmetic and logical IF statements		
# st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
# END IF, END, or another logical IF statement.					
			if ( $line =~ /^(if|else\s+if)\s*\(/ ) {			 	
				my $keyword = $1;				
				if ( $line =~ /^(else\s+if)/ ) {
					$info->{'ElseIf'} = 1;					
					$info->{ 'EndControl' } = 1;
				} else {
					$info->{ ucfirst($keyword) } = 1; # 'If'	
				}
				
			# The following part should be in a separate condition block I think			
			# What I should do is:
			# Detect an IF. If so, detect if it is a THEN or an expression. 
			# Get any variables from the condition. If it's an expression, assign it to $mline and just carry on. 
			
				my $is_cond_assign = 0;
				my $is_cond        = 0;
#				my $cond           = '';
#				my $rest           = '';

				( my $cond, $mline ) = _parse_if_cond($line);
				
				$info->{'CondExecExpr'}=$cond;
				if ($mline=~/(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*$/) {
					# arithmetic IF
					$Sf->{'ReferencedLabels'}{$1}=$1;
					$Sf->{'ReferencedLabels'}{$2}=$2;
					$Sf->{'ReferencedLabels'}{$3}=$3;					
				}
				if ($cond=~/^\d+$/) { $cond.='+0';}
#				say "COND:$cond";  
					my $ast = parse_expression($cond,  $info,  $stref,  $f);
					$info->{'CondExecExprAST'}= $ast;
					my $vars_in_cond_expr =  get_vars_from_expression( $ast,{});
					for my $macro (keys %{$Config{'Macros'}} ) {
						delete $vars_in_cond_expr->{ lc($macro) };
					}
					$info->{'CondVars'}{'Set'} = $vars_in_cond_expr;
					$info->{'CondVars'}{'List'} = [ keys %{$vars_in_cond_expr} ];
					if ($mline eq 'then') {
						$info->{ 'Control' } = 1;	
						$info->{ 'IfThen' } = 1;						
					}
			} 

# So in principle anything after this can come after IF (...) 
			# --------------------------------------------------------------------------------
			# Executable statements, last one is assignment			
			# --------------------------------------------------------------------------------
=info executable statements allowed after IF

st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
END IF, END, or another logical IF statement

Statements with * are currently ignored

ASSIGN*
DECODE*
ENCODE*
ENDFILE*

ACCEPT
Assignment
BACKSPACE
CALL
CLOSE
CONTINUE
GOTO
GOTO (Assigned)*
GOTO (Unconditional)*

INQUIRE
OPEN
PAUSE
PRINT
READ
RETURN
REWIND
STOP
TYPE
WRITE 
=cut

=info other executable statements 
Statements with * are currently ignored
Statements with ** are currently not even recognised
DO
DO WHILE*
ELSE
ELSE IF

IF (Arithmetic)
IF (Block)
IF (Logical)

END
END DO
END FILE**
END IF
=cut 

#    READ, WRITE, and PRINT statements			
			if ( $mline =~ /^(read|accept|inquire|write|type|print)(?:\s*\(|\s+)/ ) {				
				my $keyword = $1;
				$info->{ ucfirst($keyword) . 'Call' } = 1;
				$info->{'IO'}=1;
				$info = _parse_read_write_print( $mline, $info, $stref, $f );
				
			}
#    REWIND, OPEN, CLOSE statements				
			elsif ( $mline =~ /^(open|close|rewind)\s*\(/ ) {				
				my $keyword = $1;
				$info->{ ucfirst($keyword) . 'Call' } = 1;
				$info->{'IO'}=1;
				if ( $keyword eq 'open' ) {
					$mline=~s/\s+$//;
					my $ast = parse_Fortran_open_call($mline);
										
					$info->{'Ast'} = $ast;
#carp "MLINE:$mline".Dumper($ast);
					if ( exists $ast->{'FileName'} ) {						
						if ( exists $ast->{'FileName'}{'Var'} and $ast->{'FileName'}{'Var'} !~ /__PH/ ) {						
							$info->{'FileNameVar'} =
							  $ast->{'FileName'}{'Var'
							  }; # TODO: in principle almost any other field could be a var
							$info->{'Vars'}{'Set'}
							  { $ast->{'FileName'}{'Var'} } = 1;
						} elsif ( exists $ast->{'FileName'}{'Expr'} ) {
							my $expr = $ast->{'FileName'}{'Expr'};
							if ( exists $ast->{'FileName'}{'ExprVar'} ) {
								$expr = $ast->{'FileName'}{'ExprVar'} . $expr;
							}

							my @chunks = split( /\W+/, $expr );
							for my $mvar (@chunks) {
								next if $mvar eq '';
								next if $mvar =~ /^\d+$/;
								next
								  if $mvar =~
									  /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
								next if $mvar =~ /__PH\d+__/;
								next if exists $F95_reserved_words{$mvar};
								next if exists $Config{'Macros'}{uc($mvar)};
								$info->{'Vars'}{'Set'}{$mvar} = 1;
							}
						}
					}
					if ( exists $ast->{'UnitVar'} ) {
						$info->{'Vars'}{'Set'}{ $ast->{'UnitVar'} } = 1;
					}
					if ( exists $ast->{'IOStat'} ) {
						$info->{'Vars'}{'Set'}{ $ast->{'IOStat'} } = 1;
					}
                    if ( exists $ast->{'AttrVal'} and ref($ast->{'AttrVal'}) eq 'ARRAY') {
                        for my $val (@{ $ast->{'AttrVal'} } ) {
                            next if $val=~/__PH\d+__/; 
                            $info->{'Vars'}{'Set'}{ $val } = 1;
                        }
					}
					@{ $info->{'Vars'}{'List'} } = keys %{ $info->{'Vars'}{'Set'} };
				}			
#    BACKSPACE, ENDFILE statements			
			} elsif ($mline=~/(backspace|endfile)/) {
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
				$info->{'IO'}=1;
				warn uc($keyword)." is ignored!" if $W;
#    RETURN, STOP and PAUSE statements		
			} elsif ($mline=~/^(return|stop|pause)/) {	
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
			}
#    ASSIGN ... TO ...				
			 elsif ($mline=~/^assign\s+(\w+)\s+to\s+(\w+)/) {
			 	my $label=$1;
			 	my $var = $2;				
				$info->{'Assign'}={'Label' => $label, 'Var' => $var};
				$Sf->{'ReferencedLabels'}{$label}=$label;
				say 'WARNING: ASSIGN IS IGNORED!' if $W;
			 }													
#    CONTINUE statement. 			
			elsif ($line=~/continue/) {				
				$info->{'Continue'}={};				
			}
#    DECODE/ENCODE statement. 			
			elsif ($line=~/(decode|encode)/) {		
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
				$info->{'IO'}=1;
				say "WARNING: ".uc($keyword).' IS IGNORED!' if $W;					
			}							
# This is an ASSIGNMENT and so can come after IF (...)				
#			elsif ( $mline !~ /::/ && $mline !~ /^\s*\d*\s+data\b/ && $mline !~ /\bparameter\b/ && $mline =~ /[\w\)]\s*=\s*[^=]/ ) 
			elsif ( $mline =~ /[\w\)]\s*=\s*[^=]/ ) {		
					$info->{'Assignment'} = 1;
					my $free_form =  $Sf->{'FreeForm'};							
					$mline = __remove_blanks($mline,$free_form);
#					$line = __remove_blanks($line,$free_form);
#WV20150303: We parse this assignment and return {Lhs => {Varname, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
#croak "$f <$mline>" if $mline=~/^\s*\d*\s*write/ ;

					$info = _parse_assignment( $mline, $info, $stref, $f );
			}
			}
			
			if (not exists $info->{'Block'}) {
				$info->{'Block'}=$current_block;
			}
			$srcref->[$index] = [ $lline, $info ];
} else {
	# Comment out the code shielded with if (0) then ... endif 
	$srcref->[$index] = [ '!0 '.$lline, {'Blank'=>1}];
	if ($in_excluded_block==2) {
		$in_excluded_block=0;
	}
}
			if ($in_excluded_block==1 and not exists $info->{'Block'}) {
				say $lline if $DBG;
			}
		}    # Loop over lines

		# We sort the indices from high to low so that the insertions are at the correct index 
		for my $idx (sort {$b <=> $a} keys %extra_lines) {		
			$srcref = [@{$srcref}[0..$idx-1],@{ $extra_lines{$idx} },@{$srcref}[($idx+1) .. (scalar(@{$srcref})-1)] ]; 
		}
		$Sf->{'AnnLines'}=$srcref;
#		show_annlines($srcref);croak;
		
		if ( $is_incl ) {
			my $inc = $f;
			my $Sincf = $Sf;
			if($has_commons && $has_pars ) {
				print "INFO: The include file $inc contains both parameters and commons, attempting to split out params_$inc.\n"
				  if $I;
				$Sincf->{'InclType'} = 'Both';
				$stref = __split_out_parameters( $inc, $stref );
				$stref = __find_parameter_used_in_inc_and_add_to_Only( $inc, $stref );
				$has_pars = 0;
	
			} elsif ($has_commons) {
				$Sincf->{'InclType'} = 'Common';
			} elsif ($has_pars) {
				$Sincf->{'InclType'} = 'Parameter';
			} else {
				$Sincf->{'InclType'} = 'None';
			}
		}
		
	} else {
		print "WARNING: NO AnnLines for $f ($sub_incl_or_mod)\n";
		if ($Sf->{'Entry'} ==0) {
		croak "SOURCE for $f: " . Dumper($Sf). ' , Source: '.$Sf->{'Source'}.$f.' , Entry: '.$Sf->{'Entry'};
		# FIXME: if we can't find the source, we should search the include path, but not attempt to create a module for that source!
		}
	}


	#           die "FIXME: shapes not correct!";

	return $stref;
}    # END of _analyse_lines()

# -----------------------------------------------------------------------------
# For every 'include' statement in a subroutine
# the filename is entered in 'Includes' and in Info->[$index]{'Include'}
# If the include was not yet read, do it now.
sub _parse_includes {
	( my $f, my $stref ) = @_;

#		local $V=1;

	my $sub_or_func_or_mod_or_inc_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod_or_inc_or_mod}{$f};
	print "PARSING INCLUDES for $f ($sub_or_func_or_mod_or_inc_or_mod)\n" if $V;
	my $srcref       = $Sf->{'AnnLines'};
	my $last_inc_idx = 0;
	if ( defined $srcref ) { 
		
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			
			
			if ( $line =~ /^\!\s/ ) {
				next;
			}
			
			if ( exists $info->{'Includes'} ) { 
				my $name = $info->{'Includes'};
				print "FOUND include $name in $f\n" if $V;
				$Sf->{'Includes'}{$name} = { 'LineID' => $index };

				if (    exists $Sf->{'Translate'}
					and exists $stref->{'IncludeFiles'}{$name}
					and not
					exists $stref->{'IncludeFiles'}{$name}{'Translate'} )
				{
					$stref->{'IncludeFiles'}{$name}{'Translate'} =
					  $Sf->{'Translate'};
					if ( $Sf->{'Translate'} eq 'C' ) {
						$stref = add_to_C_build_sources( $name, $stref );
					} else {
						croak '!$acc translate (' 
						  . $f . ') '
						  . $Sf->{'Translate'}
						  . ": Only C translation through F2C_ACC is currently supported.\n";
					}
				}
				$last_inc_idx = $index;

				$info->{'Include'} = {};
				$info->{'Include'}{'Name'} = $name;

				if ( $stref->{'IncludeFiles'}{$name}{'Status'} == $UNREAD ) {
					print $line, "\n" if $V;

					# Initial guess for Root. OK? FIXME?
					$stref->{'IncludeFiles'}{$name}{'Root'}      = $f;
					$stref->{'IncludeFiles'}{$name}{'HasBlocks'} = 0;
					$stref = parse_fortran_src( $name, $stref );
				} else {
					print $line, " already processed\n" if $V;					
				}
				if (    exists $stref->{'Implicits'}
					and exists $stref->{'Implicits'}{$name} )
				{
					print "INFO: inheriting IMPLICITS from $name in $f\n" if $I;
					if ( not exists $stref->{'Implicits'}{$f} ) {
						$stref->{'Implicits'}{$f} =
						  $stref->{'Implicits'}{$name};
					} else {
						for my $k ( keys %{ $stref->{'Implicits'}{$name} } ) {
							if ( not exists $stref->{'Implicits'}{$f}{$k} ) {
								$stref->{'Implicits'}{$f}{$k} =
								  $stref->{'Implicits'}{$name}{$k};
							} else {
								die
"ERROR: $f and $name have different type for $k";
							}
						}
					}
				}

				# The include has been parsed.
				if ( exists $stref->{'IncludeFiles'}{$name} )
				{    # Otherwise it means it is an external include
					 # 'Parameters' here is OK because the include might contain other includes
					$Sf->{'IncludedParameters'} =
					  &append_to_set( $Sf->{'IncludedParameters'},
						$stref->{'IncludeFiles'}{$name}{'Parameters'} );
						
					if (exists $stref->{'IncludeFiles'}{$name}{'Includes'}) {
						for my $param_inc (keys %{ $stref->{'IncludeFiles'}{$name}{'Includes'} } ) {
					$Sf->{'IncludedParameters'} =
					  &append_to_set( $Sf->{'IncludedParameters'},
						$stref->{'IncludeFiles'}{$param_inc}{'Parameters'} );
							
						}
					}
#						croak $name.Dumper($Sf->{'IncludedParameters'}) if $f eq 'restax' and $name =~/comm/;
				}
			} # If the line contains an 'include' statement
			$srcref->[$index] = [ $line, $info ];
		} # loop over all lines
	} else {
		print "WARNING: NO LOCAL SOURCE for $f\n";
		# FIXME: if we can't find the source, we should search the include path, but
		# not attempt to create a module for that source!
	}

	# tag the next line after the last include
	$last_inc_idx++;
	$srcref->[$last_inc_idx][1]{'ExtraIncludesHook'} = 1;
	return $stref;
}    # END of parse_includes()

# -----------------------------------------------------------------------------
# Parse 'use' declarations 
# the module can contain module-scoped variables etc.
# So we need to parse all the stuff in a module except the subroutines, as that is done elsewhere
# WV20170607 I simply assme that any variable declaration is a global
sub _parse_use {
	( my $f, my $stref ) = @_;

	#	local $V=1;

	my $sub_or_func_or_mod_or_inc_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod_or_inc_or_mod}{$f};
	print "PARSING USE for $f ($sub_or_func_or_mod_or_inc_or_mod)\n" if $V;
	my $srcref       = $Sf->{'AnnLines'};
	my $last_inc_idx = 0;
	if ( defined $srcref ) {
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			if ( $line =~ /^\!\s/ ) {
				next;
			}

			if ( $line =~ /^\s*use\s+(\w+)/ ) { # if exists $info->{'Includes'}
				my $name = $1;
				print "FOUND module $name in $f\n" if $V;
				$Sf->{'Uses'}{$name} = $index;

				if (    exists $Sf->{'Translate'}
					and exists $stref->{'Modules'}{$name}
					and not exists $stref->{'Modules'}{$name}{'Translate'} )
				{
					$stref->{'Modules'}{$name}{'Translate'} =
					  $Sf->{'Translate'};
					if ( $Sf->{'Translate'} eq 'C' ) {
						$stref = add_to_C_build_sources( $name, $stref );
					} else {
						croak '!$acc translate (' 
						  . $f . ') '
						  . $Sf->{'Translate'}
						  . ": Only C translation through F2C_ACC is currently supported.\n";
					}
				}
				$last_inc_idx = $index;

				$info->{'Use'} = {};
				$info->{'Use'}{'Name'} = $name;
				if (exists $stref->{'Modules'}{$name}{'ModType'} and
				$stref->{'Modules'}{$name}{'ModType'} ne 'External') {
				if ( not exists $stref->{'Modules'}{$name}{'Status'}
					or $stref->{'Modules'}{$name}{'Status'} < $READ )
				{
					print $line, "\n" if $V;

					$stref = parse_fortran_src( $name, $stref );
				} else {
					print $line, " already processed\n" if $V;
				}
				if ( exists $stref->{'Modules'}{$name}{'Inlineable'} and $stref->{'Modules'}{$name}{'Inlineable'} ==1) {
					$info->{'Use'}{'Inlineable'} = 1;
				} else {
					$info->{'Use'}{'Inlineable'} = 0;
				}
				if (    exists $stref->{'Implicits'}
					and exists $stref->{'Implicits'}{$name} )
				{
					print "INFO: inheriting IMPLICITS from $name in $f\n" if $I;
					if ( not exists $stref->{'Implicits'}{$f} ) {
						$stref->{'Implicits'}{$f} =
						  $stref->{'Implicits'}{$name};
					} else {
						for my $k ( keys %{ $stref->{'Implicits'}{$name} } ) {
							if ( not exists $stref->{'Implicits'}{$f}{$k} ) {
								$stref->{'Implicits'}{$f}{$k} =
								  $stref->{'Implicits'}{$name}{$k};
							} else {
								die
"ERROR: $f and $name have different type for $k";
							}
						}
					}
				}
				
				# the used module has been parsed
				if ( exists $stref->{'Modules'}{$name} ) {    # Otherwise it means it is an external module
				
					 # 'Parameters' here is OK because the include might contain other includes
					$Sf->{'UsedParameters'} = &append_to_set( $Sf->{'UsedParameters'}, $stref->{'Modules'}{$name}{'Parameters'} );
					# I think here I should 'inherit' UsedLocalVars from this module, i.e. any LocalVars in $name
					# FIXME should this not be UndeclaredCommonVars ???
					$Sf->{'UndeclaredCommonVars'} = append_to_set( $Sf->{'UndeclaredCommonVars'}, $stref->{'Modules'}{$name}{'DeclaredCommonVars'} );
#					if (exists $stref->{'Modules'}{$name}{'IsGlobal'} and $stref->{'Modules'}{$name}{'IsGlobal'}==1) {
#						$Sf->{'UsedGobalVars'} = append_to_set( $Sf->{'UsedGlobalVars'}, $stref->{'Modules'}{$name}{'LocalVars'} );
#					} else {
#						$stref->{'Modules'}{$name}{'IsGlobal'}=0;
#						$Sf->{'UsedLocalVars'} = append_to_set( $Sf->{'UsedLocalVars'}, $stref->{'Modules'}{$name}{'LocalVars'} );
#					} 											
				}
				} else {
					say "WARNING: module $name is EXTERNAL" if $W;
				}
			} # If the line contains a 'use' statement			
			$srcref->[$index] = [ $line, $info ];
		}
	} else {
		print "WARNING: NO LOCAL SOURCE for $f\n";

	# FIXME: if we can't find the source, we should search the include path, but
	# not attempt to create a module for that source!
	}

	# tag the next line after the last include

	$last_inc_idx++;
	$srcref->[$last_inc_idx][1]{'ExtraModulesHook'} = 1;
	return $stref;
}    # END of parse_use()

# -----------------------------------------------------------------------------

# UsedLocalVars is a misnomer, because these variables could be globals 
sub __module_has_globals { (my $stref, my $f, my $mod_name, my $called_sub_name)=@_; 
#	say "TEST: $called_sub_name";
#	say exists $stref->{'Subroutines'}{$called_sub_name}{'Uses'}{$mod} ? 1 :0;
#	say exists $stref->{'Subroutines'}{$called_sub_name}{'InModule'} ? 1:0;
#	say exists $stref->{'Modules'}{  $stref->{'Subroutines'}{$called_sub_name}{'InModule'} }{'Uses'}{$mod} ? 1:0;
		# This depends: for any called function, we should test if it uses the same module or resides in a module that uses the same module
		my $Sf = $stref->{'Subroutines'}{$f};
		if (exists $stref->{'Subroutines'}{$called_sub_name}{'Uses'}{$mod_name} or ( 
			exists $stref->{'Subroutines'}{$called_sub_name}{'InModule'} and
		 	exists $stref->{'Modules'}{  $stref->{'Subroutines'}{$called_sub_name}{'InModule'} }{'Uses'}{$mod_name} )
		) {
			say "INFO: MODULE $mod_name USED in $f is GLOBAL because of $called_sub_name" if $I;
			$stref->{'Modules'}{$mod_name}{'IsGlobal'}=1;
		
			$Sf->{'UsedGlobalVars'} = append_to_set( $Sf->{'UsedGlobalVars'}, $stref->{'Modules'}{$mod_name}{'LocalVars'} );
			
			for my $var (keys %{ get_vars_from_set($stref->{'Modules'}{$mod_name}{'LocalVars'} ) } ) {
#				say "VAR $var";
				$Sf->{'Commons'}{$var}=1;
				$stref->{'Subroutines'}{$called_sub_name}{'Commons'}{$var}=1;				
			}
		}
		return $stref;
}	

sub _check_used_modules_for_globals { (my $stref, my $f,  my $called_sub_name)=@_;
	for my $mod_name (keys %{ $stref->{'Subroutines'}{$f}{'Uses'} } ) {
#		say "MOD: $mod";
		$stref = __module_has_globals($stref, $f, $mod_name, $called_sub_name);
	}				
	return $stref;
}

=pod

=begin markdown

### Factoring out code blocks into subroutines

This is some major refactoring, so should be in Refactoring::Blocks 

=end markdown

=cut

#WV20150701 This routine is very early here and it is BROKEN: common block variables don't get declarations!
sub _separate_blocks {
	( my $f, my $stref ) = @_;

	#    local $V = 1;

	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
	my $srcref             = $Sf->{'AnnLines'};

	$Data::Dumper::Indent = 2;

	# All variables in the parent subroutine
	my $varsref = get_vars_from_set( $Sf->{'Vars'} );

	# Occurence
	my $occsref  = {};
	my $itersref = {};

	# A map of every block in the parent
    # WV20170515 This BEFORE/AFTER is no good: works only for a single subroutine
    # If there are more than 1, there can be many such portions. 
    # So maybe we need an array of OUTER or something
#	my $blocksref_OLD =
#	  { 
#          'OUTER' =>
#		  { 'AnnLines' => [], 
#		  	'CalledSubs' => { 'List' => [], 'Set' => {} } 
#		  },
#          'BEFORE' =>
#		  { 'AnnLines' => [], 
#		  	'CalledSubs' => { 'List' => [], 'Set' => {} } 
#		  },
#          'AFTER' =>
#		  { 'AnnLines' => [], 
#		  	'CalledSubs' => { 'List' => [], 'Set' => {} } 
#		  },
#	  };
    # The records in this array are {'Name' => 'OUTER' or actual name, 'CalledSubs', 'AnnLines'
   	my $blocksref = []; # Just an array 


# 1. Process every line in $f, scan for blocks marked with pragmas.
# What this does is to separate the code into blocks (%blocks) and keep track of the line numbers
# The lines with the pragmas occur both in OUTER and the block

	$blocksref  = __separate_into_blocks( $stref, $blocksref, $f );

# 2. For all non-OUTER blocks, create an entry for the new subroutine in 'Subroutines'
# Based on the content of %blocks

	$stref = __create_new_subroutine_entries( $stref, $blocksref, $f );

# 3. Identify which vars are used
#   - in both => these become function arguments
#   - only in "outer" => do nothing for those
#   - only in "inner" => can be removed from outer variable declarations
#
# Find all vars used in each block, starting with the outer block
# It is best to loop over all vars per line per block, because we can remove the encountered vars

	( $occsref, $itersref ) = @{ __find_vars_in_block( $blocksref, $varsref, $occsref ) };

# 4. Construct the subroutine signatures
# This happens before reparsing so the data structures for the Decls and Args are emtpty! So need to call the init here!
	$stref = __construct_new_subroutine_signatures( $stref, $blocksref, $occsref, $itersref, $varsref, $f );

	$stref = __reparse_extracted_subroutines( $stref, $blocksref );

	$blocksref = __find_called_subs_in_OUTER($blocksref);

	$stref = __update_caller_datastructures( $stref, $f, $blocksref );

	return $stref;
}    # END of _separate_blocks()

# -----------------------------------------------------------------------------

sub __find_called_subs_in_OUTER {
	( my $blocksref ) = @_;
	for my $block_rec ( @{$blocksref}) {
		my $block = $block_rec->{'Name'};
		if ($block eq 'OUTER') {
			for my $annline ( @{ $block_rec->{'AnnLines'} } ) {
				( my $line, my $info ) = @{$annline};
				if ( exists $info->{'SubroutineCall'} ) {
					push @{ $block_rec->{'CalledSubs'}{'List'} }, $info->{'SubroutineCall'}{'Name'};
					$block_rec->{'CalledSubs'}{'Set'}{ $info->{'SubroutineCall'}{'Name'} } = 1;
					# Now test if this is maybe an ENTRY -- UGH! TODO!
				}
			}
		}
	}
	
	return $blocksref;
}

# -----------------------------------------------------------------------------
# CALL
# We need access to the info about the ACC pragma's here.
# As this comes after analyse_lines, I should use $info not regex!
sub _parse_subroutine_and_function_calls {
	( my $f, my $stref ) = @_;
	print "PARSING SUBROUTINE/FUNCTION CALLS in $f\n" if $V;

	my $pnid               = $stref->{'NId'};
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
	my $external_sub       = 0;
	my $entry_call = 0;

	# For C translation and call tree generation
	# TODO: $translate is obsolete!
	if ( $translate == $GO
		|| ( $call_tree_only && ( $gen_sub || $main_tree ) ) )
	{
		if ( $translate == $GO ) {
			$stref = add_to_C_build_sources( $f, $stref );
		}
	}
	if ( exists $Sf->{'Translate'} ) {
		if ( $Sf->{'Translate'} eq 'C' ) {
			$stref = add_to_C_build_sources( $f, $stref );
		} else {
			croak '!$acc translate (' 
			  . $f . ') '
			  . $Sf->{'Translate'}
			  . ": Only C translation through F2C_ACC is currently supported.\n";
		}
	}
	my $srcref = $Sf->{'AnnLines'};

	if ( defined $srcref ) {
		my $in_kernel_wrapper_region = 0;
		my $in_kernel_sub_region     = 0;
		my $kernel_wrapper_name      = '';
		my $current_sub_name         = '';
		
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			(my $line, my $info) = @{$srcref->[$index]};
			
			next if ( $line =~ /^\!\s/ and $line !~ /^\!\s*\$(?:ACC|RF4A)\s/i );
			if ( exists $info->{'AccPragma'} ) {
				if ( exists $info->{'AccPragma'}{'BeginKernelWrapper'} ) {
					$in_kernel_wrapper_region = 1;
					$kernel_wrapper_name =
					  $info->{'AccPragma'}{'BeginKernelWrapper'}[0];
				} elsif ( exists $info->{'AccPragma'}{'EndKernelWrapper'} ) {
					$in_kernel_wrapper_region = 0
					  ; #2; # FIXME: A bit weak, what if there are more than one?
				} elsif ( exists $info->{'AccPragma'}{'BeginKernelSub'} ) {
					$in_kernel_sub_region = 1;
				} elsif ( exists $info->{'AccPragma'}{'EndKernelSub'} ) {
					$in_kernel_sub_region = 0;
				}
			}

			if ( exists $info->{'Signature'} ) {
				$current_sub_name = $info->{'Signature'}{'Name'};
			}
		# CALL
	  # Subroutine calls. Surprisingly, these even occur in functions! *shudder*
			if (   $line =~ /call\s+(\w+)\s*\((.*)\)/
				|| $line =~ /call\s+(\w+)\s*$/ )
			{
				my $name = $1;    # The name of the called subroutine. The caller is $f
				my $argstr = $2;
				 
				if (not defined $argstr) {
					$argstr='';
				}
				if ( $argstr =~ /^\s*$/ ) {
					$argstr = '';
				}
				$info->{'SubroutineCall'}{'Name'} = $name;
				if ( $in_kernel_wrapper_region == 1 ) {
					if ($in_kernel_sub_region) {
						$stref->{'KernelWrappers'}{$kernel_wrapper_name}
						  {'KernelSubs'}{$name} =
						  { 'LineID' =>
							  $info->{'LineID'} };    # slot for the arguments
					} else {
						$stref->{'KernelWrappers'}{$kernel_wrapper_name}
						  {'OtherCalls'}{$name} =
						  { 'LineID' =>
							  $info->{'LineID'} };    # slot for the arguments
					}
				}

				$stref = add_to_call_tree( $name, $stref, $f ); # Calls to ENTRY are treated as ordinary calls.  
				if ( not exists $stref->{'Subroutines'}{$name} and not exists $stref->{'Entries'}{$name} ) {
					$stref->{'ExternalSubroutines'}{$name}{'Called'} = 1;

					# This is wrong, all I need to do is not parse this one.
					# But when I continue it breaks as there is no definition
					# Also check if it is intrinsic.
					#					croak "FIX INTRINSICS!";
					#					return $stref;
					$external_sub = 1;
				
				} else {
					$external_sub = 0;
					if (exists $stref->{'Entries'}{$name}) {						
						$entry_call=1;
					} else {
						$entry_call=0;
					}
				}
				
				my $ast = parse_expression( "$name($argstr)", $info, $stref, $f );
				( my $expr_args, my $expr_other_vars ) = get_args_vars_from_subcall($ast);
				for my $expr_arg(@{$expr_args->{'List'}}) {
					if (substr($expr_arg,0,1) eq '*') {
						my $label=substr($expr_arg,1);
						$Sf->{'ReferencedLabels'}{$label}=$label;		
					}
				}
				$info->{'CallArgs'}               = $expr_args;
				$info->{'ExprVars'}               = $expr_other_vars;
				$info->{'SubroutineCall'}{'Args'} = $info->{'CallArgs'};
				
				$info->{'SubroutineCall'}{'ExpressionAST'} = $ast;
				
				if ( $external_sub == 0 ) {
					# If this is a call to an ENTRY, I will for the time being treat this separately
					# as CalledEntries
					# I think we need this only to determine which modules to use
					# We can do that via the subroutine to which the entry belongs.
#					if ($entry_call==1) {						
#						my $parent_sub_name = $stref->{'Entries'}{$name};
#						my $Sname = $stref->{'Subroutines'}{$parent_sub_name};
#	
#						if ( $Sf->{'RefactorGlobals'} == 1 ) {
#							print "SUB $name NEEDS GLOBALS REFACTORING\n" if $V;
#							$Sname->{'RefactorGlobals'} = 1;
#						}
#	
#						if ( defined $Sname and not exists $Sf->{'CalledEntries'}{'Set'}{$name}						
#							) {													
#							if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
#								$Sf->{'CalledEntries'}{'Set'}{$name} = 1; # mark $name a called sub in $f
#								push @{ $Sf->{'CalledEntries'}{'List'} }, $name;
#							} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
#								# mark $name as a called sub in $current_sub_name 
#								$Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'Set'}{$name} = 1;
#								push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'List'} }, $name;
#							}
#							
#							if (   not exists $Sname->{'Status'}
#								or $Sname->{'Status'} < $PARSED
#								or $gen_sub )
#							{
#								print
#								  "\tFOUND SUBROUTINE CALL $name in $f with STATUS="
#								  . show_status( $Sname->{'Status'} )
#								  . ", PARSING\n"
#								  if $V;
#								$stref = parse_fortran_src( $name, $stref );
#							}
#						}						
						
#					} else {			
	
									
						my $Sname = $entry_call ? $stref->{'Subroutines'}{$stref->{'Entries'}{$name}} : $stref->{'Subroutines'}{$name};
									
						if ( exists $Sf->{'Translate'}
							and not exists $Sname->{'Translate'} ) {
							$Sname->{'Translate'} = $Sf->{'Translate'};
						}
						$Sname->{'Called'} = 1;
	# What I want to know is: where in $f does the call to $name occur?
	# Problem is of course that this is before refactoring, so after refactoring this line might be wrong!
	# But then we probably want to do the analysis before we refactor anyway.
	# The proper way of course is to change the index of the line after refactoring, but then it has to change in any datastructure that uses it as well!
						if ( not exists $Sname->{'Callers'}{$f} ) {
							$Sname->{'Callers'}{$f} = [];
						}						
						push @{ $Sname->{'Callers'}{$f} }, $index;
	
						if ( $Sf->{'RefactorGlobals'} == 1 ) {
							print "SUB $name NEEDS GLOBALS REFACTORING\n" if $V;
							$Sname->{'RefactorGlobals'} = 1;
						}

						if ( defined $Sname and not exists $Sf->{'CalledSubs'}{'Set'}{$name} ) {
							if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
								$Sf->{'CalledSubs'}{'Set'}{$name} = 1; # mark $name a called sub in $f
								push @{ $Sf->{'CalledSubs'}{'List'} }, $name;
							} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
							# mark $name as a called sub in $current_sub_name 
								$Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'Set'}{$name} = 1;
								push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'List'} }, $name;
							}
							
							if (   not exists $Sname->{'Status'}
								or $Sname->{'Status'} < $PARSED
								or $gen_sub )
							{
								print
								  "\tFOUND SUBROUTINE CALL $name in $f with STATUS="
								  . show_status( $Sname->{'Status'} )
								  . ", PARSING\n"
								  if $V;
								$stref = parse_fortran_src( $name, $stref );
							}
						} 
						if ($entry_call==1) {
							if ( defined $Sname and not exists $Sf->{'CalledEntries'}{'Set'}{$name}) {													
								if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
									$Sf->{'CalledEntries'}{'Set'}{$name} = 1; # mark $name a called sub in $f
									push @{ $Sf->{'CalledEntries'}{'List'} }, $name;
								} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
									# mark $name as a called sub in $current_sub_name 
									$Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'Set'}{$name} = 1;
									push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'List'} }, $name;
								}
							}
						}
#					}
				} else {

					# An external sub
					$info->{'SubroutineCall'}{'IsExternal'} = 1;
					# I should add these to CalledSubs I think
					if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
							$Sf->{'CalledSubs'}{'Set'}{$name} = 1; # mark $name a called sub in $f
							push @{ $Sf->{'CalledSubs'}{'List'} }, $name;
						} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
						# mark $name as a called sub in $current_sub_name 
							$Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'Set'}{$name} = 1;
							push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'List'} }, $name;
						}
					
				}
#				$stref = _check_used_modules_for_globals($stref, $f, $name);
				
				
			}

			# Maybe Function calls
			if (   $line !~ /function\s/
				&& $line !~ /subroutine\s/
				&& $line =~ /(\w+)\s*\(/ )
			{
				my @chunks = ();
				my $cline  = $line;
				while ( $cline =~ /(\w+)\(/ ) {
					if ( $line !~ /call\s+$1/ ) {
						push @chunks, $1;
						$cline =~ s/$1\(//;
					} else {
						$cline =~ s/call\s+\w+\(//;
					}
				}
				for my $chunk (@chunks) {
					if (
						    exists $stref->{'Subroutines'}{$chunk}
						and exists $stref->{'Subroutines'}{$chunk}{'Function'}
						) {
					   # This means it's the first call to function $chunk in $f
						if ( not exists $Sf->{'CalledSubs'}{'Set'}{$chunk} ) {
							$Sf->{'CalledSubs'}{'Set'}{$chunk} = 1;
							push @{ $Sf->{'CalledSubs'}{'List'} }, $chunk;
							print "FOUND FUNCTION CALL $chunk in $f\n" if $V;
							if ( $chunk eq $f ) {
								show($srcref);
								die $line;
							}
							$stref->{'Subroutines'}{$chunk}{'Called'} = 1;

# We need to parse the function to detect called functions inside it, unless that has been done
							if (   not exists $stref->{'Subroutines'}{$chunk}
								or not
								exists $stref->{'Subroutines'}{$chunk}{'Status'}
								or $stref->{'Subroutines'}{$chunk}{'Status'} < $PARSED 
								) {
								$stref = parse_fortran_src( $chunk, $stref );
							} else {
								$stref = add_to_call_tree( $chunk, $stref, $f );
							}

							if ( exists $Sf->{'Translate'}
								and not exists $stref->{'Subroutines'}{$chunk}{'Translate'} 
								) {
								$stref->{'Subroutines'}{$chunk}{'Translate'} = $Sf->{'Translate'};
							}
						}
					}					
				}
			# check if one of the args of a function happens to be a function or subroutine (!)
			# We do this the "brute force" way
					my @lchunks = split( /\W+/, $line );
					my %sub_func_as_arg= ();
					for my $mvar (@lchunks) {
						next if $mvar eq '';
						next if $mvar =~ /^\d+$/;
						next
						  if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
						next if exists $F95_reserved_words{$mvar};
						next if exists $Config{'Macros'}{uc($mvar)};
						if (exists $stref->{'Subroutines'}{$mvar}) {
							$sub_func_as_arg{$mvar} = 1;
						}
					}
					for my $sub_or_func (keys %sub_func_as_arg) {
						if (  $sub_or_func ne $f 
								and (not exists $stref->{'Subroutines'}{$sub_or_func}
								or not exists $stref->{'Subroutines'}{$sub_or_func}{'Status'}
								or $stref->{'Subroutines'}{$sub_or_func}{'Status'} < $PARSED) 
								) {
									say "INFO: FOUND $sub_or_func TO BE PARSED on line ".$line." in $f" if $I;
								$stref = parse_fortran_src( $sub_or_func, $stref );
							} 
					}
				
				
			}
			$srcref->[$index] = [ $line, $info ];
		}    # loop over all annlines
		$stref->{$sub_or_func_or_mod}{$f}{'AnnLines'} = [ @{$srcref} ];
	}
	return $stref;
}    # END of parse_subroutine_and_function_calls()

# -----------------------------------------------------------------------------

# This is required for the include analysis, so maybe I should put it there.
# This routine builds a call graph of numbered nodes, each node has the ids of the child nodes and the correponding name of the called sub, plus the id of the parent and the current name

sub build_call_graph {
	( my $f, my $stref ) = @_;
	my $prevnid = $stref->{'NId'};    # previous NId

#	if ( $prevnid == 0 ) {
#		$stref->{'PNIds'} = []; # So why was this not set at the same time as NId? Do this in State.pm!
#	}
	my $pnid =
	  ( $prevnid > 0 )
	  ? $stref->{'PNIds'}[-1]
	  : 0;                            # So take the last node in the PNIds list
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	if ( $sub_or_func_or_mod ne 'ExternalSubroutines' ) {
		my $Sf = $stref->{$sub_or_func_or_mod}{$f};

		$stref->{'NId'}++;
		my $nid = $stref->{'NId'};
		$stref->{'Nodes'}{$nid} = {
			'Children'   => [],
			'Parent'     => $pnid,
			'Subroutine' => $f
		};

		# Add the current node to the list of Children in the parent
		push @{ $stref->{'Nodes'}{$pnid}{'Children'} }, [ $nid, $f ];

		# Now identify calls and recurse
		my $annlines = $Sf->{'AnnLines'};
		if ( defined $annlines ) {
			my $called_sub_name = '';
			for my $annline ( @{$annlines} ) {
				( my $line, my $info ) = @{$annline};
				if (
					    exists $info->{'Deleted'}
					and $info->{'Deleted'} == 1
					and ( not exists $info->{'InBlock'}
						or $info->{'InBlock'}{'Name'} ne $f )
				  ) { 
                      next;
				}
				if ( exists $info->{'SubroutineCall'} ) {
					$called_sub_name = $info->{'SubroutineCall'}{'Name'};
					push @{ $stref->{'PNIds'} }, $nid;
					$stref = build_call_graph( $called_sub_name, $stref );
					pop @{ $stref->{'PNIds'} };
				}
			}    # loop over all annlines
		}
	} else {

		#        say "external $pnid";
	}
	return $stref;
}    # END of build_call_graph()

# -----------------------------------------------------------------------------
# Proper FSM parser for F77 variable declarations (apart from the type)
# So this parses the expressions used for the dimensions, but also length
# For example
# integer*(4) a(3+(2*i),j,-k:k+10)

sub f77_var_decl_parser {
	( my $varlst, my $T ) = @_;

	print "VARLST: <$varlst>\n" if $T;

	# parse varlst into this hash
	my $vars     = {};
	my $vars_lst = [];    # ordered list
	                      #  We need following states:
	my (
		$do_nothing,      # 0
		$read_var,        # 1
		$store_var,       # 2
		$found_len,       # 3
		$read_len,        # 4
		$store_len,       # 5
		$found_shape,     # 6
		$read_shape,      # 7
		$store_shape      # 8
	) = 0 .. 8;

	my @states = qw(
	  do_nothing
	  read_var
	  store_var
	  found_len
	  read_len
	  store_len
	  found_shape
	  read_shape
	  store_shape
	);

	# initial state
	my $st = $do_nothing;

	# inside read_shape, we need a parenthesis counter:
	my $nest_count = 0;

	my $var   = '';
	my $pvar  = '';
	my $shape = '';
	my $len   = '';
	my $pc    = '';

	for my $c ( split( '', $varlst ) ) {

		my $pst = $st;    # previous state, for testing only

#### The transitions are:

		if ( $st == $do_nothing ) {
			if ( $c =~ /[a-z]/ ) { $st = $read_var }
			elsif ( $c eq '*' ) { $st = $read_len; next; }
			elsif ( $c eq '(' ) { $st = $found_shape; $nest_count = 0 }
		} elsif ( $st == $read_var && $c =~ /\W/ ) {
			$st = $store_var;
		} elsif ( $st == $store_var ) {
			if ( $pc eq '*' ) {
				$st = $read_len;
			} elsif ( $pc eq '(' ) {
				$st         = $read_shape;
				$nest_count = 0;
			} elsif ( $c eq '(' ) {
				$st         = $found_shape;
				$nest_count = 0;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $read_len && $c =~ /[\s,]/ ) {
			$st = $store_len;
		} elsif ( $st == $store_len ) {
			if ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $found_len ) {
			$st = $read_len;
		} elsif ( $st == $found_shape ) {
			if ( $c eq ')' ) {
				$st = $store_shape;
			} else {
				$st = $read_shape;
			}
		} elsif ( $st == $read_shape && $nest_count <= 0 && $c eq ')' ) {
			$st = $store_shape;
		} elsif ( $st == $store_shape ) {
			if ( $c eq '*' ) {
				$st = $found_len;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		}
		print
" PC: $pc; C:$c; NC: $nest_count; ST: $states[$st]; PST: $states[$pst]\n"
		  if $T;

##### The actions are:
		if    ( $st == $read_var ) { $var .= $c }
		elsif ( $st == $read_len ) { $len .= $c }

		#    elsif ($st==$found_shape) {$shape.=$c;}
		elsif ( $st == $read_shape ) {
			$shape .= $c;
			if    ( $c eq '(' ) { $nest_count++; }
			elsif ( $c eq ')' ) { $nest_count--; }
		} elsif ( $st == $store_var ) {
			print "VAR:[$var]\n" if $T;
			if ( $var eq '' ) { croak $varlst }
			push @{$vars_lst}, $var;
			$vars->{$var}{'ArrayOrScalar'} = 'Scalar';
			$vars->{$var}{'Dim'}           = [];
			$pvar                          = $var;
			$var                           = '';
		} elsif ( $st == $store_len ) {
			print "LEN: {$len}\n" if $T;
			$vars->{$pvar}{'Attr'} = $len;
			$len = '';
		} elsif ( $st == $store_shape ) {
			print "SHAPE: <$shape>\n" if $T;
			$shape =~ s/^\s+//;
			$shape =~ s/\s+$//;
			my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
			my @tshape = ();
			for my $range (@ranges) {
				if ( $range =~ /:/ ) {
					push @tshape, [ split( /:/, $range ) ];
				} else {
					push @tshape, [ '1', $range ];
				}
			}
			$vars->{$pvar}{'Dim'}           = \@tshape;
			$vars->{$pvar}{'ArrayOrScalar'} = 'Array';
			$shape                          = '';
		}
		$pc = $c;

	}
	if ($T) {
		print "VAR: $var\n";
		print "PVAR: $var\n";
		print "SHAPE: $shape\n";
		print "LEN: $len\n";
		print "STATE: $states[$st]\n";
	}
#### Pending actions on end of string

	if ( $st == $read_var && $var ne '' ) {
		push @{$vars_lst}, $var;
		$vars->{$var} = { 'Dim' => [], 'ArrayOrScalar' => 'Scalar' };
	} elsif ( $st == $read_len && $pvar ne '' ) {
		$vars->{$pvar}{'Attr'} = $len;
	} elsif ( $st == $read_shape && $pvar ne '' ) {
		$shape =~ s/^\s+//;
		$shape =~ s/\s+$//;
		my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
		      # @shape is a list of the ranges, each range is a list
		my @shape = ();
		for my $range (@ranges) {
			if ( $range =~ /:/ ) {
				push @shape, [ split( /:/, $range ) ];
			} else {
				push @shape, [ '1', $range ];
			}
		}
		$vars->{$pvar}{'Dim'}           = [@shape];
		$vars->{$pvar}{'ArrayOrScalar'} = 'Array';
	}

	return ( $vars, $vars_lst );
}    # END of f77_var_decl_parser()

# -----------------------------------------------------------------------------
# TODO: check if this works for F95-style parameters too
sub __split_out_parameters {
	( my $f, my $stref ) = @_;
	my $Sf = $stref->{'IncludeFiles'}{$f};

	my $srcref      = $Sf->{'AnnLines'};	
	my $param_lines = [];
	my $nsrcref     = [];
	my $nindex      = 0;
	my $nidx_offset = 0;
	push @{$nsrcref},
	  [
		"      include 'params_$f'",
		{ 'Include' => { 'Name' => "params_$f", 'InclType' => 'Parameter' } }
	  ];

	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
		$nindex = $index + $nidx_offset;
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];
		if ( exists $info->{'ParamDecl'} ) {
	    # split out parameters from 'Common' include file			
			push @{$param_lines}, [ $line, { 'ParamDecl' => { %{ $info->{'ParamDecl'} } } } ];
			delete $srcref->[$index][1] {'ParamDecl'};  
			$srcref->[$index][1]{'Comments'} = 1;
			$srcref->[$index][0] = '! ' . $srcref->[$index][0];
		}
		push @{$nsrcref}, $srcref->[$index];
	}
	$stref->{'IncludeFiles'}{$f}{'AnnLines'}          = $nsrcref;
	$stref->{'IncludeFiles'}{$f}{'ParamInclude'}      = "params_$f";
	$stref->{'IncludeFiles'}{"params_$f"}             = {};
	$stref->{'IncludeFiles'}{"params_$f"}{'AnnLines'} = $param_lines;
	$stref->{'IncludeFiles'}{"params_$f"}{'InclType'} = 'Parameter';
	$stref->{'IncludeFiles'}{$f}{'InclType'}          = 'Common';

	$stref->{'IncludeFiles'}{"params_$f"}{'LocalParameters'} =
	  dclone( $stref->{'IncludeFiles'}{$f}{'LocalParameters'} );
	$stref->{'IncludeFiles'}{$f}{'LocalParameters'} =
	  { 'Set' => {}, 'List' => [] };

	#    die Dumper( $stref->{'IncludeFiles'}{"$f"}{'RefactorGlobals'} );
	$stref->{'IncludeFiles'}{"params_$f"}{'Root'}   = $f;
	$stref->{'IncludeFiles'}{"params_$f"}{'Source'} = 'Virtual';   #"params_$f";
	$stref->{'IncludeFiles'}{"params_$f"}{'Status'} = $PARSED;
	$stref->{'IncludeFiles'}{"params_$f"}{'RefactorGlobals'} = $NO;
	$stref->{'IncludeFiles'}{"params_$f"}{'HasBlocks'}       = $NO;
	$stref->{'IncludeFiles'}{"params_$f"}{'FStyle'} =
	  $stref->{'IncludeFiles'}{$f}{'FStyle'};
	$stref->{'IncludeFiles'}{"params_$f"}{'FreeForm'} =
	  $stref->{'IncludeFiles'}{$f}{'FreeForm'};

	$stref->{'IncludeFiles'}{$f}{'Includes'}{"params_$f"} = { 'Only' => {} };
	$stref->{'IncludeFiles'}{"params_$f"}{'Parameters'} = dclone( $stref->{'IncludeFiles'}{$f}{'Parameters'} );
	$stref->{'IncludeFiles'}{"params_$f"}{'Vars'}{'Subsets'}{'Parameters'} = $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'};
	delete $stref->{'IncludeFiles'}{$f}{'Parameters'};
	delete $stref->{'IncludeFiles'}{$f}{'Vars'}{'Subsets'}{'Parameters'};
	return $stref;
}    # END of __split_out_parameters
# -----------------------------------------------------------------------------
sub __find_parameter_used_in_inc_and_add_to_Only { (my $inc, my $stref ) = @_;
	
	my $Sinc = $stref->{'IncludeFiles'}{$inc};

	my $srcref      = $Sinc->{'AnnLines'};	
	
	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {		
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];
		if (exists $info->{'Include'} and $info->{'Include'}{'InclType'} eq 'Parameter' ) {
			my $param_inc = 	$info->{'Include'}{'Name'};
		}
		elsif ( exists $info->{'VarDecl'}  ) {
			for my $var ( @{ $info->{'VarDecl'}{'Names'} } ) {
				my $decl=get_var_record_from_set($Sinc->{'Vars'},$var);
				if ($decl->{'ArrayOrScalar'} eq 'Array') {
					my %dim_tmpstr = map { ($_->[0] => 1,$_->[1] => 1) } @{$decl->{'Dim'}};
					my @maybe_parstrs = grep { !/^\-?\d+$/ } keys %dim_tmpstr;
					my $maybe_pars_str = '('.join(',',@maybe_parstrs).')';#Dumper($decl->{'Dim'});# 	
					# So now parse this 
					my $ast=parse_expression($maybe_pars_str, {}, $stref, $inc);
					my $pars = get_vars_from_expression($ast,{});
					delete $pars->{'_OPEN_PAR_'};
					for my $par (keys %{$pars}) {
						$Sinc->{'Includes'}{"params_$inc"}{'Only'}{$par}=1;
					}   		
				}
			}

		}
		elsif ( exists $info->{'Common'} ) {
			for my $var ( @{ $info->{'Common'}{'Vars'}{'List'} } ) {
				
				my $decl=get_var_record_from_set($Sinc->{'Vars'},$var);
				if ($decl->{'ArrayOrScalar'} eq 'Array') {
					my %dim_tmpstr = map { ($_->[0] => 1,$_->[1] => 1) } @{$decl->{'Dim'}};
					my @maybe_parstrs = grep { !/^\-?\d+$/ } keys %dim_tmpstr;
					my $maybe_pars_str = '('.join(',',@maybe_parstrs).')';#Dumper($decl->{'Dim'});# 	
					# So now parse this 
					my $ast=parse_expression($maybe_pars_str, {}, $stref, $inc);
					my $pars = get_vars_from_expression($ast,{});
					delete $pars->{'_OPEN_PAR_'};
					for my $par (keys %{$pars}) {
						$Sinc->{'Includes'}{"params_$inc"}{'Only'}{$par}=1;
					}   		
				}						
			}			
		}
		elsif ( exists $info->{'Dimension'} ) {
			say "DIMENSION $line"; say Dumper($info);
		}
	}
	
	
	return $stref;
}
# -----------------------------------------------------------------------------
sub _parse_implicit {
	( my $line, my $f, my $stref ) = @_;
	my @impl_rules = ($line);
	# 1. test for compound, bail out
	my $tline = $line;
	while ( $tline =~ /\(/ ) {
		$tline =~ s/\(.+?\)//;
	}
	if ( $tline =~ /,/ ) {
		my $mline=$line;
		$mline=~s/implicit\s+//;
		@impl_rules = _parse_comma_sep_expr_list($mline);
		@impl_rules = map { "implicit $_" } @impl_rules;
	}
	
	my %implicit_type_lookup = ();
	if ( exists $stref->{'Implicits'} and exists $stref->{'Implicits'}{$f} ) {
		%implicit_type_lookup = %{ $stref->{'Implicits'}{$f} };
	}
	for my $line (@impl_rules) {
	# 2. Get the spec and turn into a regexp
	my $type = 'Unknown';
	my $array_or_scalar =
	  'Scalar';    # by default. If it is Array, need the size, so need a shape

	my $attr = '';
	my $patt = '.+';

	# IMPLICIT REAL(KIND=8)(d),COMPLEX(8)(z) => this is WEAK!
	if ( $line =~ /implicit\s+(\w.+)\((.+?)\)\((.+?)\)/ ) {
		$type = $1;
		$attr = $2;		
		$patt = $3;
		$patt =~ s/,/|/g;
		$patt =~ s/(\w\-\w)/[$1]/g;
	} elsif ( $line =~ /implicit\s+(\w.+)\((.+?)\)/ ) {
		$type = $1;
		$patt = $2;
		if ( $type =~ /\*/ ) {
			( $type, $attr ) = split( /\*/, $type );    # WEAK!
			if ( $attr eq '(' ) { $attr = '(*)' }
			else {
				if ($type ne 'character') {
					$attr = "(kind=$attr)";
					
				} else {
					$attr = "($attr)";
				}
			}
		}
		$patt =~ s/,/|/g;
		$patt =~ s/(\w\-\w)/[$1]/g;
	}
	
	# 3. Generate the lookup table
	for my $c ( 'a' .. 'z' ) {
		if ( $c =~ /($patt)/ ) {
			$implicit_type_lookup{$c} = [ $type, $array_or_scalar, $attr ];
		}
	}
	
	}
	$stref->{'Implicits'} = {} unless exists $stref->{'Implicits'};
	$stref->{'Implicits'}{$f} = {%implicit_type_lookup};
	return $stref;
}    # END of _parse_implicit()

# -----------------------------------------------------------------------------
sub __separate_into_blocks {
	( my $stref, my $blocksref, my $f ) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );    # This is not a misnomer as it can also be a module.
	my $Sf       = $stref->{$sub_or_func_or_mod}{$f};
	my $srcref   = $Sf->{'AnnLines'};
	my $in_block = 0;

	# Initial settings
    my $block = 'OUTER';
	my $block_rec={};
	$block_rec->{'AnnLines'}=[];
	$block_rec->{'Name'}='OUTER';
	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];

		if ( exists $info->{'AccPragma'}{'BeginSubroutine'} ) { 
			# Push the line with the pragma onto the list of 'OUTER' lines
			push @{ $block_rec->{'AnnLines'} }, [ "! *** Refactored code into $block ***", {} ];
			push @{ $blocksref }, $block_rec;			
			$block_rec={};
			$in_block = 1;
			$block = $info->{'AccPragma'}{'BeginSubroutine'}[0];
			print "FOUND BLOCK $block\n" if $V;

			# Enter the name of the block in the metadata for the line
			$info->{'RefactoredSubroutineCall'}{'Name'} = $block;
			$info->{'SubroutineCall'}{'Name'}           = $block;
			delete $info->{'Comments'};
			$info->{'BeginBlock'}{'Name'} = $block;


		   # Push the line with the pragma onto the list of lines for the block,
		   # to be replaced by function signature
		   $block_rec->{'AnnLines'}=[];
		   $block_rec->{'Name'}=$block;
		   push @{ $block_rec->{'AnnLines'} },
			  [
				"! === Original code from $f starts here ===",
				{ 'RefactoredSubroutineCall' => { 'Name' => $block } }
			  ];

			$block_rec->{'BeginBlockIdx'} = $index;
			next;
		} elsif ( exists $info->{'AccPragma'}{'EndSubroutine'} ) {
			# Push 'end' onto the list of lines for the block			
			push @{ $block_rec->{'AnnLines'} },  [ '      end subroutine ' . $block, dclone($info) ];
			$block_rec->{'EndBlockIdx'} = $index;
			push @{ $blocksref }, $block_rec;
			$block_rec={};
			$in_block = 0;
			$block = $info->{'AccPragma'}{'EndSubroutine'}[0];
			$block_rec->{'Name'} = 'OUTER';
			push @{ $block_rec->{'AnnLines'} }, [ $line, {} ];
			$info->{'EndBlock'}{'Name'} = $block;			
			next;
		}
		
		if ($in_block==1) {
			# Push the line onto the list of lines for the block
			push @{ $block_rec->{'AnnLines'} }, [ $line, dclone($info) ];
			$info->{'InBlock'}{'Name'} = $block;
		} else {
			# Other lines go onto 'OUTER'
			push @{ $block_rec->{'AnnLines'} }, [ $line, $info ];			
		}
		
		$srcref->[$index] = [ $line, $info ];
	}    # loop over annlines
			$block_rec->{'EndBlockIdx'} = scalar( @{$srcref} ) ; 
			push @{ $blocksref }, $block_rec;
	
	
	return $blocksref;
}    # END of __separate_into_blocks()

# -----------------------------------------------------------------------------
sub __create_new_subroutine_entries {
	( my $stref, my $blocksref, my $f ) = @_;

	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod}{$f};

	for my $block_rec ( @{$blocksref} ) {
		
		my $block = $block_rec->{'Name'};
		#        say "\tBLOCK: $block";
		die "EMPTY block name $block" if $block eq '';
		next if $block eq 'OUTER';
		if ( not exists $stref->{'Subroutines'}{$block} ) {
			$stref->{'Subroutines'}{$block} = {};
			$stref->{'Subroutines'}{$block}{'Source'} =
			  "./$block.f95";    #$Sf->{'Source'};
		}

		my $Sblock = $stref->{'Subroutines'}{$block};
		$Sblock->{'AnnLines'} = [ @{ $block_rec->{'AnnLines'} } ];    # a copy
		my $line_id = 0;
		for my $annline ( @{ $Sblock->{'AnnLines'} } ) {
			$annline->[1]{'LineID'} = $line_id++;
		}
        my $src = "./$block.f95";

		$stref->{'SourceContains'}{$src}{'Set'}{$block} = 'Subroutines';
		push @{ $stref->{'SourceContains'}{$src}{'List'} }, $block;		  
        $stref->{'SourceFiles'}{$src}{'SourceType'}='Subroutines';
         $stref->{'BuildSources'}{'F'}{$src}=1;
		$Sblock->{'RefactorGlobals'} = 1;
		$stref->{'Subroutines'}{$block} = $Sblock;
		if ( $Sf->{'RefactorGlobals'} == 0 ) {
			$Sf->{'RefactorGlobals'} = 2;
		} else {
			say "INFO: RefactorGlobals==1 for $f while processing BLOCK $block" if $I;
		}

		$Sblock->{'Program'}     = 0;
		$Sblock->{'FStyle'}      = $Sf->{'FStyle'};
		$Sblock->{'FreeForm'}    = $Sf->{'FreeForm'};
		$Sblock->{'Recursive'}   = 0;
		$Sblock->{'Callers'}{$f} = [ $block_rec->{'BeginBlockIdx'} ];            

	}
	return $stref;
}    # END of __create_new_subroutine_entries()

# -----------------------------------------------------------------------------
#
# So what this does is find occurences of existing variables and also of iterator variables
# The iter variables are declared locally inside the new subroutine, all others are args.
# Of course it should be only the vars that occur outside the block
# The "Iter" approach is incomplete because we should really identify any variable used as a local variable
# If we find a variable in the outer blocks, it could still be a local
#
sub __find_vars_in_block {
    #warn "This should use the same code as RefactorF4Acc::Analysis:: _analyse_variables";
	( my $blocksref, my $varsref, my $occsref ) = @_;
	my $itersref = {};
	for my $block_rec ( @{$blocksref} ) {
		my $block = $block_rec->{'Name'};		
		$itersref->{$block} = [];
		my @annlines = @{ $block_rec->{'AnnLines'} };
		my %tvars = %{$varsref};    # Hurray for pass-by-value!

		print "\nVARS in $block:\n\n" if $V;
		for my $annline (@annlines) {
            ( my $tline, my $info ) = @{$annline};
			if ( exists $info->{'Do'} ) {
				my $iter = $info->{'Do'}{'Iterator'};
				push @{ $itersref->{$block} }, $iter;
				delete $tvars{$iter};

				for my $var_in_do ( @{ $info->{'Do'}{'Range'}{'Vars'} } ) {
					if ( exists $tvars{$var_in_do} ) {
						print "FOUND $var_in_do\n" if $V;
						$occsref->{$block}{$var_in_do} = $var_in_do;
						delete $tvars{$var_in_do};
					}
				}
            } else {
                my $vars_on_line_ref=identify_vars_on_line($annline);
                for my $var_on_line (@{$vars_on_line_ref}) {
                    if  ( exists $tvars{$var_on_line} ) {
                        delete $tvars{$var_on_line};
                        $occsref->{$block}{$var_on_line}=$var_on_line;
                    }
                }
            }
        }
	} # for each block
	
	return [ $occsref, $itersref ];
}    # END of __find_vars_in_block()

# -----------------------------------------------------------------------------
# TODO: see if this can be separated into shorter subs
# FIXME 20170516: need includes for params in decls. Problem is, if we use COMMON blocks in the original subroutine, then there are no args so no decls.
# So I need to check if vars used in the new sub are commons
# As this belongs with _separate_blocks, I see no reason to keep declarations in $info 
sub __construct_new_subroutine_signatures {
	( my $stref, my $blocksref, my $occsref, my $itersref, my $varsref, my $f )
	  = @_;

	#    local $V = 1;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );    # This is not a misnomer as it can also be a module.
	my $Sf     = $stref->{$sub_or_func_or_mod}{$f};
	
	my $srcref = $Sf->{'AnnLines'};

	my %args = ();

	for my $block_rec ( @{$blocksref} ) {
		my $block =$block_rec->{'Name'};
		next if $block eq 'OUTER';

		my $Sblock = $stref->{'Subroutines'}{$block};

		$Sblock = _initialise_decl_var_tables( $Sblock, $stref, $block, 0 );

#		if ( not exists $Sblock->{'OrigArgs'} ) {
#			croak 'BOOM!' . Dumper( $Sblock->{Args} );
#			$Sblock->{'OrigArgs'} = { 'Set' => {}, 'List' => [] };
#		}
#		if ( not exists $Sblock->{'DeclaredOrigArgs'} ) {
#			croak 'BOOM!';
#			$Sblock->{'DeclaredOrigArgs'} = { 'Set' => {}, 'List' => [] };
#		}
#		if ( not exists $Sblock->{'LocalVars'} ) {
#			croak 'BOOM!';
#			$Sblock->{'LocalVars'} = { 'Set' => {}, 'List' => [] };
#		}
#		if ( not exists $Sblock->{'DeclaredOrigLocalVars'} ) {
#			croak 'BOOM!';
#			$Sblock->{'DeclaredOrigLocalVars'} = { 'Set' => {}, 'List' => [] };
#		}
		print "\nARGS for BLOCK $block:\n" if $V;
		$args{$block} = [];

		# Collect args for new subroutine
		# At this stage, if a var is global, it should not become an argument.
		for my $var ( sort keys %{ $occsref->{$block} } ) { ;
			if ( exists $occsref->{'OUTER'}{$var} ) {
				print "$var\n" if $V;
				# Only if this $var is not COMMON!
				if ( not exists $Sf->{'UsedParameters'}{'Set'}{$var}
				and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$var} # FIXME: UndeclaredCommonVars as well?
				and not exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var} 		 
				) {
					 carp "$f: $var is NOT COMMON!";
				push @{ $args{$block} }, $var;
				} 
#				else { 
#					carp "$f: $var is COMMON or PARAM!";
#				}
			}
			$Sblock->{'Vars'}{$var} = $varsref->{ $var }; # FIXME: this is "inheritance, but in principle a re-parse is better?"
		}
		

		# We declare them right away
		$Sblock->{'DeclaredOrigArgs'}{'List'} = $args{$block};

		# Create Signature and corresponding Decls
		my $sixspaces = ' ' x 6;
		my $sig       = $sixspaces . 'subroutine ' . $block . '(';
		my $sigrec    = {};

		$sigrec->{'Args'}{'List'} = $args{$block};
		$sigrec->{'Args'}{'Set'}  = { map { $_ => $Sblock->{'Vars'}{$_} } @{ $args{$block} } };
		
		$sigrec->{'Name'}         = $block;
		$sigrec->{'Function'}     = 0;
		for my $argv ( @{ $args{$block} } ) {
			$sig .= "$argv,";
			my $decl = get_f95_var_decl( $stref, $f, $argv );
			$decl->{'Indent'} .= $sixspaces;

			$Sblock->{'DeclaredOrigArgs'}{'Set'}{$argv} = $decl;
		}
		if ( @{ $args{$block} } ) {
			$sig =~ s/\,$/)/s;
		} else {
			$sig .= ')';
		}		

		# Add variable declarations and info to line
		# Here we know the vardecls have been formatted.
		my $sigline = shift @{ $Sblock->{'AnnLines'} }; # This is the line that says "! === Original code from $f starts here ==="

		for my $iters ( $itersref->{$block} ) {
			for my $iter ( @{$iters} ) {
				my $decl = get_f95_var_decl( $stref, $f, $iter );
				$Sblock->{'LocalVars'}{'Set'}{$iter}             = $decl;    #
				$Sblock->{'DeclaredOrigLocalVars'}{'Set'}{$iter} = $decl;
				push @{ $Sblock->{'DeclaredOrigLocalVars'}{'List'} }, $iter;

				unshift @{ $Sblock->{'AnnLines'} },
				  [
					emit_f95_var_decl($decl),
					{
						'VarDecl' => {'Name' => $decl->{'Name'}},  
						'Ann'     => ['__construct_new_subroutine_signatures '
						  . __LINE__]
					}
				  ];
			}
		}

		for my $argv ( @{ $args{$block} } ) {
			my $decl = get_var_record_from_set( $Sblock->{'OrigArgs'}, $argv );
			if ( not defined $decl ) {
				croak;
				$decl = $Sblock->{'DeclaredOrigArgs'}{'Set'}{$argv};
			}
			
			unshift @{ $Sblock->{'AnnLines'} },
			  [
				emit_f95_var_decl($decl),
				{
					'VarDecl' => {'Name' => $decl->{'Name'}}, 
					'Ann' => [ '__construct_new_subroutine_signatures ' . __LINE__ ]
				}
			  ];
		}
		unshift @{ $Sblock->{'AnnLines'} }, $sigline;

		# Now also add include statements and the actual sig to the line

		$Sblock->{'AnnLines'}[0][1] = {};
		
		for my $inc ( keys %{ $Sf->{'Includes'} } ) { 
			$Sblock->{'Includes'}{$inc} = { 'LineID' => 2 };
			unshift @{ $Sblock->{'AnnLines'} },
			  [ "      include '$inc'", { 'Include' => { 'Name' => $inc } } ];    			
		}
#		unshift @{ $Sblock->{'AnnLines'} }, [ $sig, { 'Signature' => $sigrec } ];
		
		
		for my $mod ( keys %{ $Sf->{'Uses'} } ) {
			
			if (  $stref->{'Modules'}{$mod}{'Inlineable'} == 1 ) {
#				say "$block USES $mod FROM $f"; 
			$Sblock->{'Uses'}{$mod} = { 'LineID' => 2 };
			my $line = "      use $mod";
			my $info = { 'Use' => { 'Name' => $mod, 'Inlineable' => {} }  };						
			unshift @{ $Sblock->{'AnnLines'} }, [$line , $info ];  
		}  			
		}
		unshift @{ $Sblock->{'AnnLines'} }, [ $sig, { 'Signature' => $sigrec } ];		
		
# And finally, in the original source, replace the blocks by calls to the new subs

		#        print "\n-----\n".Dumper($srcref)."\n-----";
		for my $tindex ( 0 .. scalar( @{$srcref} ) - 1 ) {
			if ( $tindex == $block_rec->{'BeginBlockIdx'} ) {
				$sig =~ s/subroutine/call/;
				$srcref->[$tindex][0] = $sig;
				
				$srcref->[$tindex][1]{'SubroutineCall'} = $sigrec;
				$srcref->[$tindex][1]{'CallArgs'}=dclone($sigrec->{'Args'});
				$srcref->[$tindex][1]{'LineID'} = $Sblock->{'Callers'}{$f}[0];
				
			} elsif ( $tindex > $block_rec->{'BeginBlockIdx'}
				and $tindex <= $block_rec->{'EndBlockIdx'} ) 
			{
				$srcref->[$tindex][0] = '';
                $srcref->[$tindex][1]{'Deleted'} = 1;
			}
		}

		if ($V) {
			print 'SIG:' . $sig, "\n";

			#			print join( "\n", @{$decls} ), "\n";
		}
		$Sblock->{'Status'} = $READ;
		$stref->{'Subroutines'}{$block} = $Sblock ;
		
	}
 
	return $stref;
}    # END of __construct_new_subroutine_signatures()

# -----------------------------------------------------------------------------
sub __reparse_extracted_subroutines {
	( my $stref, my $blocksref ) = @_;
	for my $block_rec (@{$blocksref} ) {
		my $block = $block_rec->{'Name'};
		next if $block eq 'OUTER';		
		say "REPARSING $block" if $V;
		$stref = parse_fortran_src( $block, $stref );
	}
	return $stref;
}

# -----------------------------------------------------------------------------
sub __update_caller_datastructures {
	( my $stref, my $f, my $blocksref ) = @_;

	#	delete $blocksref->{'OUTER'};
	# Create new CalledSubs for $f
	
    my @called_subs=();
	for my $block_rec ( @{$blocksref} ) {
		my $block = $block_rec->{'Name'};
		
         if ($block eq 'OUTER' ) {
         	if ( exists $block_rec->{'CalledSubs'} and exists $block_rec->{'CalledSubs'}{'List'}) {
         		@called_subs = ( @called_subs, @{ $block_rec->{'CalledSubs'}{'List'} } );
         	}
         } else {
         	@called_subs = ( @called_subs,$block );
#        next if $block eq 'BEFORE';
#        next if $block eq 'AFTER';
        # Basically, we know that the new subs *must* be called from $f
#		# Problem here is that there is NO caller!
#		say $block,' : ',scalar keys %{ $stref->{'Subroutines'}{$block}{'Callers'} };
#		croak "There can only be one caller for a factored-out subroutine" if scalar keys %{ $stref->{'Subroutines'}{$block}{'Callers'} } != 1;
        
#		for my $f ( keys %{ $stref->{'Subroutines'}{$block}{'Callers'} } )
#		{    # There can only be one caller for $block
#			if ( $block eq 'OUTER' ) {
#				$stref->{'Subroutines'}{$f}{'CalledSubs'} =
#				  $blocksref->{'OUTER'}{'CalledSubs'};
#			} else {

				# Add $block to CalledSubs in $f
#				$stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$block} = 1;                 

# What we need to do is put a marker in CalledSubs when we encounter the pragma, and not register any subcalls in the region!!!
# Not sure I understand, but the situation is:
# before: call f1 , f2, f3, f4, f5, f6, f7 ...
# after: call f1, f2; f_new containing f4, f5; f6, f7, ...
# So in $f, we need to remove the subs called in f_new unless they were called elsewhere. So we decrement a count I guess
# And in $f_new, we need to add f4 and f5 to CalledSubs.
# So actual logic is to go through all blocks. Any call in OUTER + any new block goes to $f; 
# $blocksref->{'OUTER'}{'CalledSubs'}{'Set'}{$called_sub_name}
# any call in (not OUTER) goes to the CalledSubs of $block. But we have reparsed all these so I guess we'll have detected these
#

# This is indeed an issue, but not major. Basically, we need to split the OUTER in before and after and splice.
#                carp "FIXME: Incorrect because there might be subs in $f called after $block";
#				push @{ $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'} }, $block;
#                push @called_subs, $block;
#			}
#		}
		}
	} # for each block
	$stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'}=[@called_subs];
	$stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'} = { map { $_ => 1} @called_subs };
#    $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'} =[ @{ $blocksref->{'BEFORE'}{'CalledSubs'}{'List'} }, @called_subs, @{ $blocksref->{'AFTER'}{'CalledSubs'}{'List'} } ];
#    $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'} = { %{ $blocksref->{'BEFORE'}{'CalledSubs'}{'Set'} }, map { $_ => 1} @called_subs,  %{ $blocksref->{'AFTER'}{'CalledSubs'}{'Set'} } };
    $stref->{'CallTree'}{$f}=[@{$stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'}}];
	return $stref;
}    # END of __update_caller_datastructures()

# -----------------------------------------------------------------------------
# 
sub _split_multivar_decls {
	( my $f, my $stref ) = @_;

	my $sub_incl_or_mod = sub_func_incl_mod( $f, $stref );

	my $Sf           = $stref->{$sub_incl_or_mod}{$f};
	my $annlines     = $Sf->{'AnnLines'};
	my $nextLineID   = scalar @{$annlines} + 1;
	my $new_annlines = [];
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		if ( exists $info->{'VarDecl'} and exists $info->{'VarDecl'}{'Names'} ) {
			my @nvars = @{ $info->{'VarDecl'}{'Names'} };
			push @{ $info->{'Ann'} }, annotate( $f, __LINE__ );
			for my $var ( @{ $info->{'VarDecl'}{'Names'} } ) {
				my $rinfo_c = dclone($info);
				$rinfo_c->{'StmtCount'}={};
				$rinfo_c->{'StmtCount'}{$var}=$info->{'StmtCount'}{$var};

				my %rinfo   = %{$rinfo_c};
				$rinfo{'LineID'} = $nextLineID++;
				my $subset = in_nested_set($Sf,'Vars',$var);
				my $orig_decl =$Sf->{$subset}{'Set'}{$var}; 
#				my $dim = ref( $orig_decl ) eq 'HASH' ?  $orig_decl->{'Dim'} : [];
#				say Dumper($info->{'VarDecl'});
#				say Dumper($orig_decl);
#				croak $info->{'VarDecl'}{'Attr'}.'<>'.$orig_decl->{'Attr'} if $info->{'VarDecl'}{'Attr'} ne $orig_decl->{'Attr'};
#				my $decl = {
#					'Indent' => $info->{'Indent'},
#					'Type'   => $orig_decl->{'Type'},
#					'Attr'   => $orig_decl->{'Attr'}, #$info->{'VarDecl'}{'Attr'},
#					'Dim'    => $dim,
#					'Name'   => $var,			
#					'IODir'  => [],
#					'Status' => 0
#				};
				$rinfo{'VarDecl'} = {'Name' => $var},#$decl;
				my $rline = $line;
#				say $f,':',$line,'=>',$subset,'.',$var,'  ', Dumper($Sf->{$subset}{'Set'}{$var});
#				say( __LINE__,' ',( exists $stref->{'Entries'}{$f} ? 'ENTRY' : 'SUB'),' ',$f);
				$Sf->{$subset}{'Set'}{$var}{'Name'} = $var;
				if ( scalar @{ $info->{'VarDecl'}{'Names'} } > 1 ) {
					for my $nvar (@nvars) {
						if ( $nvar ne $var ) {

							# FIXME: This should use \b not \W !!!
							if ( $rline =~ /\s*,\s*$nvar\([^\(]+\)\W?/ ) {
								$rline =~ s/\s*,\s*$nvar\([^\(]+\)(\W?)/$1/;
							} elsif ( $rline =~ /(\W)$nvar\([^\(]+\)\s*,\s*/ ) {
								$rline =~ s/(\W)$nvar\([^\(]+\)\s*,\s*/$1/;
							} elsif ( $rline =~ /\s*,\s*$nvar\*\d+\W?/ ) {
								$rline =~ s/\s*,\s*$nvar\*\d+(\W?)/$1/;
							} elsif ( $rline =~ /(\W)$nvar\*\d+\s*,\s*/ ) {
								$rline =~ s/(\W)$nvar\*\d+\s*,\s*/$1/;
							} elsif ( $rline =~ /\W$nvar\s*,\s*/ ) {
								$rline =~ s/(\W)$nvar\s*,\s*/$1/;
							} elsif ( $rline =~ /\s*,\s*$nvar\W?/ ) {
								$rline =~ s/\s*,\s*$nvar(\W?)/$1/;
							}
						}
					}
				}
#				say Dumper(%rinfo);
				push @{$new_annlines}, [ $rline, {%rinfo} ];
			} # for each $var
		} else {
			push @{$new_annlines}, $annline;
		}
	}
	$Sf->{'AnnLines'} = $new_annlines;

	return $stref;
}    # END of _split_multivar_decls

# -----------------------------------------------------------------------------
sub _split_multipar_decls_and_set_type {
	( my $f, my $stref ) = @_;

	my $sub_incl_or_mod = sub_func_incl_mod( $f, $stref );

	my $Sf           = $stref->{$sub_incl_or_mod}{$f};
	my $annlines     = $Sf->{'AnnLines'};
	my $nextLineID   = scalar @{$annlines} + 1;
	my $new_annlines = [];
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'ParamDecl'} ) {

			#			say "PARAM INFO:".Dumper( $info->{'ParamDecl'} );

			if ( scalar @{ $info->{'ParamDecl'}{'Names'} } => 1 ) {
				my @nvars_nvals = @{ $info->{'ParamDecl'}{'Names'} };
				for my $var_val ( @{ $info->{'ParamDecl'}{'Names'} } ) {
					my $var = $var_val->[0];
					my $val = $var_val->[1];

	 #					say "PARAM SET: $var => ".Dumper( $Sf->{'Parameters'}{'Set'}{$var} );
					my %rinfo = %{$info};
					$rinfo{'LineID'}    = $nextLineID++;
					$rinfo{'ParamDecl'} = {};

					my $param_decl = {
						'Indent' => $info->{'Indent'},
						'Type' => $Sf->{'LocalParameters'}{'Set'}{$var}{'Type'},
						'Attr' => $Sf->{'LocalParameters'}{'Set'}{$var}{'Attr'},
						'Dim'  => [],
						'Parameter' => 'parameter',
						'Name'      => [ $var, $val ],
						'Val'       => $val,             # backwards comp
						'Var'       => $var,             # backwards comp
						'Status'    => 1,
						'InheritedParams' => $Sf->{'LocalParameters'}{'Set'}{$var}{'InheritedParams'},
					};

					$Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;
					$rinfo{'ParamDecl'} = {'Name'      => [ $var, $val ]}; # $Sf->{'LocalParameters'}{'Set'}{$var};# {'Name' => $var};#
					$rinfo{'VarDecl'}= {'Name' => $var};

					my $rline = $line;
					if ( scalar @{ $info->{'ParamDecl'}{'Names'} } > 1 ) {

						# This is a line with multiple param decls, split it.
						for my $nvar_vals (@nvars_nvals) {
							my $nvar = $nvar_vals->[0];
							if ( $nvar ne $var ) {

 #								say $var, ' <> ',$nvar,'=>',Dumper($Sf->{'Parameters'}{'Set'}{$nvar});
								my $nval =
								  $Sf->{'LocalParameters'}{'Set'}{$nvar}{'Val'};

							  #                    say "NPAR: $nvar = $nval";
							  # TODO: WEAK we only support scalars parnam=parval
							  # FIXME: This should use \b not \W !!!
								if ( $rline =~ /\s*,\s*$nvar\s*=\s*$nval\W?/ ) {
									$rline =~
									  s/\s*,\s*$nvar\s*=\s*$nval(\W?)/$1/;
								} elsif (
									$rline =~ /(\W)$nvar\s*=\s*$nval\s*,\s*/ )
								{
									$rline =~
									  s/(\W)$nvar\s*=\s*$nval\s*,\s*/$1/;
								}
							}
						}

						#                say "\t$rline";
					}

					#                say Dumper($rinfo{ParamDecl});
					#                die if $f eq 'f_esl';
					push @{$new_annlines}, [ $rline, \%rinfo ];
				}
			} else {
				croak "NO Names for parameter in $f: $line";
			}
		} else {
			push @{$new_annlines}, $annline;
		}
	}
	$Sf->{'AnnLines'} = $new_annlines;
	return $stref;
}    # END of _split_multipar_decls_and_set_type

# -----------------------------------------------------------------------------
# So, the problem with VarDecl is that it assumes all vars on a line have the same decl, but this is not true for the shape in F77!
# A quick fix is to extend the $shape to [$shape]
# The function below is for use after the var decl lines have been split so it should be fine.

#[
#  '      ',
#  [
#    'real',
#    '',
#    [
#      '1',
#      'maxspec'
#    ]
#  ],
#  [
#    'drydeposit'
#  ],
#  0
#]

# -----------------------------------------------------------------------------
sub __parse_sub_func_prog_decls {
	( my $Sf, my $line, my $info ) = @_;

	# Determine the subroutine arguments
	my $name = '';
	if (   $line =~ /^\s*subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*recursive\s+subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*(?:\w+\s+)*[\w\(\)\*]+\s+function\s+(\w+)\s*\((.*)\)/		
		or $line =~ /^\s*function\s+(\w+)\s*\((.*)\)/ )
	{
		 $name   = $1;
		my $argstr = $2;

		$argstr =~ s/^\s+//;
		$argstr =~ s/\s+$//;
		my @args = split( /\s*,\s*/, $argstr );
		$info->{'Signature'}{'Args'}{'List'} = [@args];
		$info->{'Signature'}{'Args'}{'Set'}  = { map { $_ => 1 } @args };
		$info->{'Signature'}{'Name'}         = $name;
		$Sf->{'UndeclaredOrigArgs'}{'List'}  = [@args];
		$Sf->{'UndeclaredOrigArgs'}{'Set'} = { map { $_ => 1 } @args };   # UGH!

		$Sf->{'OrigArgs'}{'List'} = [@args];

		#		$Sf->{'OrigArgs'}{'Set'} = { map { $_ => 1 } @args };

		if ( $line =~ /function/ ) {
			$info->{'Signature'}{'Function'} = 1;
		} else {
			$info->{'Signature'}{'Function'} = 0;
		}
#croak $line.Dumper($info) if $line=~/ff029/;
	} elsif ( $line =~ /^\s*subroutine\s+(\w+)[^\(]*$/
		or $line =~ /^\s*recursive\s+subroutine\s+(\w+)[^\(]*$/ )
	{

		# Subroutine without arguments
		 $name = $1;
		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Args'}{'Set'}  = {};
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Function'}     = 0;
	} elsif ( $line =~ /^\s*program\s+(\w+)\s*$/ ) {
		# If it's a program, there are no arguments
		 $name = $1;

		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Program'}      = 1;
	} elsif ( $line =~ /^\s*block\s+data/ ) { 
		 $name = 'block_data';
		if ( $line =~ /^\s*block\s+data\s+(\w+)\s*/ ) {
			$name=$1;
		}
		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'BlockData'}      = 1;				
	}
	elsif (   $line =~ /^entry\s+(\w+)/
	) {
		 $name   = $1;
		 my $argstr ='';
		 if ( $line =~ /^entry\s+\w+\s*\((.*)\)/) {
			$argstr = $1;
		 }
		$argstr =~ s/^\s+//;
		$argstr =~ s/\s+$//;
		my @args = split( /\s*,\s*/, $argstr );
		$info->{'Signature'}{'Args'}{'List'} = [@args];
		$info->{'Signature'}{'Args'}{'Set'}  = { map { $_ => 1 } @args };
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Entry'} = 1;
		$info->{'Entry'}=1; # FIXME
		$info->{'Signature'}{'Function'} = 0;
		
		$Sf->{'HasEntries'} =1;
# The entry arg list is different from the parent sub arg list. 
# Also we already parsed the parent, so there should be no undeclared args in principle
# Anyway, what I need is to have OrigArgs for the ENTRY, not the parent.
# So maybe I can do $Sf->{'Entry'}{$name}, call this $Sname, and take it from there
		$Sf->{'Entries'}{'Set'}{$name} = {};
		push @{ $Sf->{'Entries'}{'List'} },$name;
		my $Sname = $Sf->{'Entries'}{'Set'}{$name};
		# FIXME
		# As all vars are declared (or not) *before* ENTRY, I think we should pretend that 
		# all args are declared. That way I'm sure not extra declarations will be added 
		
		$Sname->{'DeclaredOrigArgs'}{'List'}  = [@args];
		$Sname->{'DeclaredOrigArgs'}{'Set'} = { map { $_ => 1 } @args };   # UGH! 		
		$Sname->{'UndeclaredOrigArgs'}{'List'}  = [];
		$Sname->{'UndeclaredOrigArgs'}{'Set'} = { };
		$Sname-> {'OrigArgs'} = { 			
				'Subsets' => {
					'UndeclaredOrigArgs' => $Sname->{'UndeclaredOrigArgs'},
					'DeclaredOrigArgs'   => $Sname->{'DeclaredOrigArgs'}
				},
				'List' => [@args],
			};				
		
	} else { 
		croak 'BOOM: '.$line;
	}
#	croak Dumper $info if $name eq 'gzwrit';
	return ( $Sf, $line, $info );
}    # END of __parse_sub_func_prog_decls()

# -----------------------------------------------------------------------------
sub __handle_acc {
	( my $stref, my $f, my $index, my $line, my $info ) = @_;
	my $accline = $line;
	
	my $is_accline = ($accline =~ s/^\!\s*\$(?:ACC|RF4A)\s+//i);
	if ($is_accline ) {
		
	my @chunks = split( /\s+/, $accline );
	
	my $pragma_name_prefix = 'Begin';
	if ( $chunks[0] =~ /Begin/i ) {
		shift @chunks;
	}
	if ( $chunks[0] =~ /End/i ) {
		shift @chunks;
		$pragma_name_prefix = 'End';
	}
	
	( my $pragma_name, my @pragma_args ) = @chunks;
	
	if (not @pragma_args) {
		$pragma_args[0]=lc($pragma_name).'_'.$index;
	}
	$info->{'AccPragma'}{ $pragma_name_prefix . ucfirst( lc($pragma_name) ) } = [@pragma_args];
	
	  # WV20170517 I think the following is OBSOLETE
	if (    $pragma_name =~ /KernelWrapper/i
		and $pragma_name_prefix eq 'Begin' )
	{
		$stref->{'KernelWrappers'}{ $pragma_args[0] }
		  { $pragma_name_prefix . ucfirst( lc($pragma_name) ) } =
		  [ $f, $index ];
		$stref = outer_loop_start_detect( $pragma_args[0], $stref );
	}
	}
	return ( $stref, $info );
	
}    # END of __handle_acc()

# -----------------------------------------------------------------------------
	# F95 VarDecl
	# F95 declaration, no need for refactoring
sub __parse_f95_decl {
	(my $stref, my $f,  my $Sf, my $indent, my $line, my $info) = @_;
	
my $is_module = (exists $stref->{'Modules'}{$f}) ? 1 : 0;
	my $pt = parse_F95_var_decl($line);
#croak $line  if $line=~/etan/;	
#croak $line.Dumper($info) if $line=~/local_aaa/;
	# But this could be a parameter declaration, with an assignment ...
	if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+\s*=\s*.+?)\s*$/ ) {    
		# F95-style parameters
		$info->{'ParsedParDecl'} = $pt; #WV20150709 currently used by OpenCLTranslation, TODO: use ParamDecl
		
		my $parliststr = $1;
		my $var        = $pt->{'Pars'}{'Var'};
		my $val        = $pt->{'Pars'}{'Val'};
		my $type       = $pt->{'TypeTup'}{'Type'};

		my $pars_in_val = ___check_par_val_for_pars($val);

		my $param_decl = {
			'Indent'    => $indent,
			'Type'      => $type,
			'Attr'      => '',
			'Dim'       => [],
			'Parameter' => 'parameter',
			'Names'     => [ [ $var, $val ] ],
			'Status'    => 0,
			'ArrayOrScalar' => 'Scalar' # FIXME: Asumption that parameters are always scalars  
		};    # F95-style
		$info->{'ParamDecl'} = $param_decl;
		$info->{'VarDecl'} = {'Name' => $var };
		
		$info->{'UsedParameters'} = $pars_in_val;

		if ( not exists $Sf->{'LocalParameters'}{'List'} ) {
			croak 'BOOM!';
			$Sf->{'LocalParameters'}{'List'} = [];
		}
		if ( not exists $Sf->{'LocalParameters'}{'Set'} ) {
			croak 'BOOM!';
			$Sf->{'LocalParameters'}{'Set'} = {};
		}
		$Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;

		# List is only used in Parser, find out what it does
		@{ $Sf->{'LocalParameters'}{'List'} } =
		  ( @{ $Sf->{'LocalParameters'}{'List'} }, $var )
		  ;    # FIXME: use ordered_union()

	} else { 
		# F95 VarDecl, continued
		if (    not exists $info->{'ParsedVarDecl'}
			and not exists $info->{'VarDecl'} )
		{
			
			if (not exists $pt->{'Attributes'}{'Allocatable'}) {
				# This is a HACK because we changed the structure of Dim in the case of allocatable arrays
				$info->{'ParsedVarDecl'} = $pt;
			} 
			$info->{'VarDecl'} = {
				'Indent' => $indent,
				'Names'  => $pt->{'Vars'},
				'Status' => 0
			};
			my $idx=0;
			for my $tvar ( @{ $pt->{'Vars'} } ) { # corresponds to @{$pvars_lst} in F77
										
				my $decl = {};
				$decl->{'Indent'}        = $indent;
				$decl->{'Type'}          = $pt->{'TypeTup'}{'Type'};
				$decl->{'ArrayOrScalar'} = 'Scalar';
				$decl->{'Dim'}           = [];
				
				my $type =$decl->{'Type'}; 
				if ( exists $pt->{'Attributes'} ) {
					if ( exists $pt->{'Attributes'}{'Dim'} ) {
						if ( $pt->{'Attributes'}{'Dim'}[0] ne '0' ) {
							my @shape = ();
							for my $range ( @{ $pt->{'Attributes'}{'Dim'} } ) {
								if ( $range =~ /:/ ) {
									push @shape, [ split( /:/, $range ) ];
								} else {
									push @shape, [ '1', $range ];
								}
							}
							$decl->{'Dim'}           = \@shape;
							$decl->{'ArrayOrScalar'} = 'Array';
						}
					}
					if ( exists $pt->{'Attributes'}{'Allocatable'}) {
						$decl->{'Allocatable'}='allocatable';
						my $alloc_dim = $pt->{'Attributes'}{'Dim'}[$idx];
						my @dims = map { ['',''] } @{$alloc_dim};
						$decl->{'Dim'}           = \@dims;
					}
				}
				if ( $type =~ /character/ ) {
					if (exists $pt->{TypeTup}{'ArrayOrScalar'} ) {
					$decl->{'Attr'} = '(len=' . $pt->{TypeTup}{'ArrayOrScalar'} . ')';
					} elsif (exists $pt->{'	'}{'Dim'}) {
						$decl->{'Attr'} = '(len=' . $pt->{'Attributes'}{'Dim'}[0] . ')';
					} else {
						say "WARNING: no length for character string $tvar" if $W;
						$decl->{'Attr'} = '(len=*)';
					}
				} elsif ( exists $pt->{'TypeTup'}{'Kind'} ) {
					$decl->{'Attr'} = '(kind=' . $pt->{'TypeTup'}{'Kind'} . ')';
#					croak $decl->{'Attr'};
				} else {
					$decl->{'Attr'} = '';					
				}

				$decl->{'IODir'} = defined $pt->{'Attributes'}{'Intent'} ? $pt->{'Attributes'}{'Intent'} : 'Unknown';
				
				$decl->{'Name'}=$tvar;
				
				my $subset =in_nested_set($Sf,'Vars',$tvar);						
				my $orig_decl = ($subset ne '') ? $Sf->{$subset}{'Set'}{$tvar} : {};
				if (ref($orig_decl) ne 'HASH') {
					$orig_decl  = {};
				}
				if ($decl->{'Type'} eq 'character'  
					and exists $decl->{'Attr'}
					and exists $orig_decl->{'Attr'}
					) {
						$decl->{'Attr'}=$orig_decl->{'Attr'};
				}  		  		
							 
				# It is possible that at this point the variable had not been declared yet and we use implicit rules
				$subset='UNKNOWN';
				# Then we change it to declared.
				if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar} ) {								
					$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} = $decl;
					delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar};
					@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
					$Sf->{'DeclaredOrigArgs'}{'List'} = ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'}, [$tvar] );
					$subset='DeclaredOrigArgs';
					
				} 
				# In principle F95 code can also have COMMON vars
# When we encounter UndeclaredCommonVars we make them DeclaredCommonVars
				elsif ( exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) {
					$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} = $decl;
					delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}; # Regardless of what was there
					@{ $Sf->{'UndeclaredCommonVars'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
					$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$tvar] );
					$subset='DeclaredCommonVars';
				} else { # A var decl must be unique, so it it's not a arg, it's a local or a common
				
				# I added this check so that I can use the parser for variables that are declared using implicit rules 
				# All this does is update the var entry
					if (exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$tvar} ) {
						
						$Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$tvar} = $decl;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} }, $tvar;
						} 
						$subset='UndeclaredOrigLocalVars';
					} elsif	(exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} ) {						
						$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} = $decl;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} }, $tvar;
						} 					
						$subset='DeclaredOrigLocalVars';	
					} elsif (exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) {
						my $common_block_name = $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} = $decl;
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'} = $common_block_name;
							my @test=grep {$_ eq $tvar}  @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
							if ( scalar @test == 0) { 
								push @{ $Sf->{'UndeclaredCommonVars'}{'List'} }, $tvar;
							} 
						$subset='UndeclaredCommonVars';		
					} elsif (exists $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} ) {
						my $common_block_name = $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
						$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} = $decl;
						$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'} = $common_block_name;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'DeclaredCommonVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'DeclaredCommonVars'}{'List'} }, $tvar;
						} 						
						$subset='DeclaredCommonVars';		 
					} else {						
						$subset =in_nested_set($Sf,'Vars',$tvar);
						if ($subset ne '') {
#							carp "LINE $line: $tvar in subset $subset of Vars";
							$Sf->{$subset}{'Set'}{$tvar} = $decl;
						} else {
							say "INFO: <$line>: $tvar does not have a record in Vars" if $I;
							$subset = $is_module ? 'DeclaredCommonVars' : 'DeclaredOrigLocalVars';
							if ($is_module) { $decl->{'CommonBlockName'} = $f; } # overload CommonBlockName with module name 
							$Sf->{$subset}{'Set'}{$tvar}=$decl;
							push @{$Sf->{$subset}{'List'}}, $tvar;
						}
					}					
				}
#				croak Dumper($subset,$decl, $Sf->{'DeclaredOrigArgs'}{'Set'}{'abcd_mask'}) if $line=~/abcd_mask/;
				$idx++;
			}
		}
	}
	
	push @{ $info->{'Ann'} }, annotate( $Sf->{'Source'}, __LINE__ );
	return ( $Sf, $info );

}    # END of __parse_f95_decl()

# -----------------------------------------------------------------------------

sub __parse_f77_par_decl {

	# F77-style parameters
	#                my $parliststr = $1;
	( my $Sf, my $f,my $indent, my $line, my $info, my $parliststr ) = @_;

	
	my $type   = 'Unknown';
	my $attr = '';
	$indent =~ s/\S.*$//;
	my @partups = _parse_comma_sep_expr_list( $parliststr ); 
	
	my %pvars = map { split( /\s*=\s*/, $_ ) } @partups;    # Perl::Critic, EYHO
	my @var_vals = map { ( my $k, my $v ) = split( /\s*=\s*/, $_ ); [ $k, $v ] } @partups; # Perl::Critic, EYHO
	my @pvarl = map { s/\s*=.+//; $_ } @partups;
	my $pars = [];

	my $pars_in_val = {};
	
	for my $var (@pvarl) {
		my $pars_in_val_for_var = {};
		croak if ref($var) eq 'ARRAY';
		if ( not in_nested_set $Sf, 'LocalVars', $var ) { 
			if ( exists $pvars{$var} ) {

				my $val             = $pvars{$var};
				my $pars_in_val_tmp = ___check_par_val_for_pars($val);
				$type = 'Unknown';
				$attr='';
				if ( $val =~ /^\-?\d+$/ ) {
					$type = 'integer';
				} elsif ( $val =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/ ) {
					$type = 'real';
				} elsif ( $val =~/[\*\+\-\/]/ ) { # an expression 
						my $ast = parse_expression($val);
						my $consts = get_consts_from_expression($ast,{});
						for my $const_type (values %{$consts}) {
							if ($const_type eq 'real') {
								$type = 'real';
								last;
							} elsif ($const_type ne 'Unknown') {
								$type=$const_type;
							}
						}
				} elsif ( $val =~ /^[\"\'].+[\'\"]$/ ) {
					my $nchars = length ($val) -2;
					$attr = "(len=$nchars)";
					$type = 'character';					
				} else {
					for my $mpar ( keys %{$pars_in_val_tmp} ) {
						my $mpar_rec = get_var_record_from_set( $Sf->{'Parameters'}, $mpar );
						$type = $mpar_rec->{'Type'};						
					}
				}
				$pars_in_val_for_var = { %{$pars_in_val_for_var}, %{$pars_in_val_tmp} };
				$Sf->{'LocalParameters'}{'Set'}{$var} = {
					'Type' => $type,
					'Var'  => $var,
					'Val'  => $val,
					'Attr' => $attr,
					'DEBUG' => 2
				};
				say "INFO: LOCAL PARAMETER $var infered type: $type $var = $val" if $I;
				push @{$pars}, $var;
			} else {
				say "WARNING: no VAL for VAR $var ($line)" if $W;
			}
		} else {
			my $var_rec = get_var_record_from_set( $Sf->{'LocalVars'}, $var );
			
			$type = $var_rec->{'Type'};
			$attr = $var_rec->{'Attr'};
			$Sf->{'LocalParameters'}{'Set'}{$var} = {
				'Type' => $type,
				'Var'  => $var,
				'Val'  => $pvars{$var},
				'Attr' => $attr,
				'DEBUG' => 1	
			};

			my $val = $pvars{$var};
			$pars_in_val_for_var =
			  { %{$pars_in_val_for_var}, %{ ___check_par_val_for_pars($val) } };
			push @{$pars}, $var;
		}				
		for my $mpar ( keys %{$pars_in_val_for_var} ) {
			my $mpar_rec = get_var_record_from_set( $Sf->{'Parameters'}, $mpar );												
			$Sf->{'LocalParameters'}{'Set'}{$var}{'InheritedParams'}{'Set'}{$mpar}=1;
		}
		$pars_in_val = { %{$pars_in_val}, %{$pars_in_val_for_var} };
		
	}

	$info->{'UsedParameters'} = $pars_in_val;
	$info->{'ParamDecl'}      = {
		'Indent'    => $indent,
		'Type'      => $type,
		'Attr'      => $attr,
		'Dim'       => [],
		'Parameter' => 'parameter',
		'Names'     => [@var_vals],
		'Status'    => 0,
			 
	};
	
	@{ $Sf->{'LocalParameters'}{'List'} } =  ( @{ $Sf->{'LocalParameters'}{'List'} }, @{$pars} );
#	for my $var (@{$pars}) {
#	say $f,$var,$Sf->{'LocalParameters'}{'Set'}{$var}{'Attr'};
#	}
	return ( $Sf, $info );

}    # END of __parse_f77_par_decl()

# -----------------------------------------------------------------------------

sub __parse_f77_var_decl {
	( my $Sf, my $stref, my $f,my $indent,  my $line, my $info, my $type, my $varlst ) = @_;
				my $is_module = (exists $stref->{'Modules'}{$f}) ? 1 : 0;
# Half-baked F95/F77 declarations are threated as F77, so remove the :: here
my $half_baked = ($line=~s/\:://);
	
# Now an ad hoc fix for spaces between the type and the asterisk. FIXME! I should just write a better FSM!
#
# This is ad-hoc character declaration parsing
my $attr='';
my $char_decls={};
my $char_lst=[];
my $is_char = 0;

if ($line=~/^character/) {
	$type = 'character';		
	$is_char=1;
    $line=~s/\s+\*/*/g;
    $line=~s/\*\s+/*/g;
	$line=~s/\(\*\)/_PARENS_STAR_/g;
	
    if ($line=~/^character\*(\w+)\s+([a-z]\w*.*)$/ ){    	
        # CHARACTER*4 V
		# CHARACTER*(*) V(2)
		# But unfortunately also
		# CHARACTER*10 B10VK, C10VK, E11VK*11, G10VK
		
        my $len = $1; 
        my $vars_dims_str = $2;
# split vars on outer commas, we have a function for that
        my @vars_dims = _parse_comma_sep_expr_list($vars_dims_str);
#         say "$f CASE1: $line => len=".$len.", rest=".join(';',@vars_dims);
         
         for my $var_dim (@vars_dims) {
         	my $ast=parse_expression($var_dim, $info, $stref, $f);
#         	say "AST1:".Dumper($ast);
         	my $var = _get_var_from_ast( $ast );
         	my $dim = _get_dim_from_ast( $ast );
         	my $len_override = _get_len_from_ast( $ast );
         	if ($len eq '_PARENS_STAR_') {
         		$len='*';
         	}	
         	$char_decls->{$var}={
         		'Type' => 'character',
         		'Name' => $var,
         		'Dim' => $dim,
         		'Attr' => "len=". ($len_override ? $len_override : $len),
         		'ArrayOrScalar' => scalar @{$dim}==0 ? 'Scalar' : 'Array'
         	};
         	
         	if ($len=~/[a-z]\w*/) {
         		if (in_nested_set($Sf,'Parameters',$len) ) {
         			$char_decls->{$var}{'InheritedParams'}{'Set'}{$len}=1;
         		}
         	}
         	push @{$char_lst},$var;
#         	say "character(len=$len), dimension(".join(',', map { join(':', @{ $_ }) } @{$dim}).") :: $var";

         }         
         
    } elsif ( $line=~/^character\s+([a-z]\w*.*)$/ ) {
    	
		# CHARACTER V*4,W(2)*5
        my $vars_lens_str=$1;
# split $vars_lens on outer commas, we have a function for that
        my @vars_dims_lens = _parse_comma_sep_expr_list($vars_lens_str);
# Then split each of them on the first \*
# as a trick we could do s/\(\*\)/_STAR_/;
#        say "$f CASE2: $line => rest=".join(';',@vars_dims_lens);
        
		for my $var_dim_len (@vars_dims_lens) {
#			say $var_dim_len;
         	my $ast=parse_expression($var_dim_len, $info, $stref, $f);
#         	say "AST2:".Dumper($ast);
         	my $var = _get_var_from_ast( $ast );#$ast->[1][0] eq '@' ? $ast->[1][1] : $ast->[1];         	         	
			my $dim=_get_dim_from_ast( $ast );	
         	my $len = _get_len_from_ast( $ast );
         	if ($len eq '_PARENS_STAR_') {
         		$len='*';
         	}
         	$char_decls->{$var}={
         		'Type' => 'character',
         		'Name' => $var,
         		'Dim' => $dim,
         		'Attr' => $len eq '' ? '' : "len=$len",
         		'ArrayOrScalar' => scalar @{$dim}==0 ? 'Scalar' : 'Array'
         	};
         	if ($len=~/[a-z]\w*/) {
         		if (in_nested_set($Sf,'Parameters',$len) ) {          			
         			$char_decls->{$var}{'InheritedParams'}{'Set'}{$len}=1;
         		}
         	}         	
         	push @{$char_lst},$var;
#         	say "character(len=$len), dimension(".join(',', map { join(':', @{ $_ }) } @{$dim}).") :: $var";
         	         	
         }
         
        
    } elsif ( $line=~/^character\*(\w+)\s*\((.+)\)\s+([a-z]\w*.+)$/) {
    	croak if $line=~/_PARENS_STAR_/;
		# Non-standard, e.g.
		# CHARACTER*(*)(3) V, ...
		# WEAK as I assume no parens inside the parens
        my $len=$1;
        my $dim=$2; # FIXME
        croak 'FIXME!'; 
#        my $ast=parse_expression($var_dim_len, $info, $stref, $f);
        my $vars_str=$3;
        my @vars = _parse_comma_sep_expr_list($vars_str);
#        say "$f CASE3: $line => len=".$len.", dim=".$dim.", vars=".join(';',@vars);
         for my $var (@vars) {
         	my $ast=parse_expression($var, $info, $stref, $f);
#         	say "AST3:".Dumper($ast);
         	my $var = _get_var_from_ast( $ast );
         	if ($len eq '_PARENS_STAR_') {
         		$len='*';
         	}
			$char_decls->{$var}={
         		'Type' => 'character',
         		'Name' => $var,
         		'Dim' => $dim,
         		'Attr' => "len=$len",
         		'ArrayOrScalar' => scalar @{$dim}==0 ? 'Scalar' : 'Array'
         	};
			if ($len=~/[a-z]\w*/) {
         		if (in_nested_set($Sf,'Parameters',$len) ) {
         			$char_decls->{$var}{'InheritedParams'}{'Set'}{$len}=1;
         		}
         	}
         	push @{$char_lst},$var;
         }        
         
    } elsif ( $line=~/^character\s+/ && $line=~/[a-z]\w*\*\d+\s*\(/ ) {
    	croak if $line=~/_PARENS_STAR_/;
		# Non-standard, e.g.
		# CHARACTER A*17, B*17(3,4), V*17(9)	
        my $vars_str=$line;
        $vars_str=~s/character\s+//;
        #split $vars_lens on outer commas, we have a function for that
        my @vars_lens_dims = _parse_comma_sep_expr_list($vars_str);
#        say "$f CASE4: $line => rest=".join(';',@vars_lens_dims);
        for my $var_len_dim (@vars_lens_dims) {
        	$var_len_dim=~/(\w+)\*(\w+)(.+)$/ && do {
        		my $var =$1;
        		my $len = $2;
        		my $dim_str = $3;
        		my $ast=parse_expression($dim_str, $info, $stref, $f);
				my $dim = _get_dim_from_ast( $ast );
				if ($len eq '_PARENS_STAR_') {
         		$len='*';
         		}
         	    $char_decls->{$var}={
         		'Type' => 'character',
         		'Name' => $var,
         		'Dim' => $dim,
         		'Attr' => "len=$len",
         		'ArrayOrScalar' => scalar @{$dim}==0 ? 'Scalar' : 'Array'
         	    };
				if ($len=~/[a-z]\w*/) {
	         		if (in_nested_set($Sf,'Parameters',$len) ) {
	         			$char_decls->{$var}{'InheritedParams'}{'Set'}{$len}=1;
	         		}
	         	}         	
	         	push @{$char_lst},$var;         	
#        		say "AST4:".Dumper($ast);
        	};        	
        }
		croak "TODO!";
    }
    

} elsif ($line=~/^\w+\s*\*\s*(1|2|4|8|16)/) {
	$attr = "kind=$1";
}

# If it was a character, we set $pvars to $char_decls and $pvars_lst to $char_lst
# Otherwise we get these from f77_var_decl_parser
# If the line had a pattern like integer*4, we set $attr 

	my $T = 0;
	( my $pvars, my $pvars_lst ) = $is_char ? ($char_decls, $char_lst) : f77_var_decl_parser( $varlst, $T );
	if ($is_char) {
		$type='character';
	}
	my @varnames = ();
	# Add type information to Vars
	for my $tvar ( @{$pvars_lst} ) {
		
		if ( $tvar eq '' ) { croak "<$line> in $f" }
#		my $tvar = $var;
		if ( ref($tvar) eq 'ARRAY' ) { die __LINE__ . ':' . Dumper($tvar); }
		my $common_block_name='';
		# As the Dim can be defined elsewhere, we need extra checks to get the correct value
		my $dim = $pvars->{$tvar}{'Dim'};		
		# In all the cases below, we get the dimension from the record
		# Because I think it only happens for DIMENSION and COMMON lines.
		if (exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} ) {		
			
			my $tdim =dclone($Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar}{'Dim'});
			if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}			
		} elsif (exists $Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar} ) {
			my $tdim =dclone($Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar}{'Dim'});
						if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
		} elsif (exists $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} ) { 
			my $tdim =dclone($Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'Dim'});
						if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
			$common_block_name = $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
		} elsif (exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) { 
			my $tdim =dclone($Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'Dim'});
						if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
			$common_block_name = $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
		}
		
		my $tvar_rec = {
			'Type'          => $type, # this is passed in as an argument  
			'Dim'           => $dim, # see above
			'ArrayOrScalar' => $pvars->{$tvar}{'ArrayOrScalar'},
			'Attr'			=> $pvars->{$tvar}{'Attr'},
			'IODir'         => 'Unknown',
		};
		# The Attr field depends on if it is a character or not
		if ( not exists $pvars->{$tvar}{'Attr'} ) {
			if ($attr) {
				if ( $type !~ /character/ ) {
					$tvar_rec->{'Attr'} = $attr ;
				}
			} else {
				$tvar_rec->{'Attr'} = '';
			}
		} else {
			if ( $type !~ /character/ ) {
				$tvar_rec->{'Attr'} = '(kind=' . $pvars->{$tvar}{'Attr'} . ')';
			}
		}

		# Take IODir from INTENT if it exists
		# Because F77 has an INTENT declaration
		if ( $type =~ /\bintent\s*\(\s*(\w+)\s*\)/ ) {
			my $iodir = $1;
			$iodir = ucfirst($iodir);
			if ( $iodir eq 'Inout' ) {
				$iodir = 'InOut';
			}
			$tvar_rec->{'IODir'} = $iodir;
		}
		# Create the final declaration
		my $decl = {
			'Indent' => $indent,
			'Type'   => $tvar_rec->{'Type'},
			'Attr'   => $tvar_rec->{'Attr'},
			'Dim'    => $dim,
			'Name'   => $tvar,
			'IODir'  => $tvar_rec->{'IODir'},
			'Status' => 0,
			'StmtCount'	=> $tvar_rec->{'StmtCount'},
			'ArrayOrScalar' => $pvars->{$tvar}{'ArrayOrScalar'},
		};
		# Here $decl->{'Type'} is OK
		
		if ($common_block_name ne '') {
			$decl->{'CommonBlockName'} = $common_block_name;
		}
		if (exists $pvars->{$tvar}{'InheritedParams'}) {
			for my $mpar (keys %{ $pvars->{$tvar}{'InheritedParams'}{'Set'} }) {
				$decl->{'InheritedParams'}{'Set'}{$mpar}=1;
			}
		}
				
		if (scalar @{$dim}>=1) {
			for my $dimpair (@{$dim}) {
				for my $mexpr ( @{$dimpair} ) {
					my @mpars = split(/\W+/, $mexpr);
					for my $mpar (@mpars) {
						if (defined $mpar and in_nested_set($Sf,'Parameters',$mpar) ) {
	         				$decl->{'InheritedParams'}{'Set'}{$mpar}=1;
	         			}				
					}
				}
			}
		} 						

		push @varnames, $tvar;
		
# When we encounter UndeclaredOrigArgs we make them DeclaredOrigArgs
		if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar} ) {
			$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} = $decl;
			delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar}; # Regardless of what was there
			@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
			$Sf->{'DeclaredOrigArgs'}{'List'} = ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'}, [$tvar] );
			$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar}{'StmtCount'}=1;			
		}		
# When we encounter UndeclaredCommonVars we make them DeclaredCommonVars
		elsif ( exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) {
			$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} = $decl;
			delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}; # Regardless of what was there
			@{ $Sf->{'UndeclaredCommonVars'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
			$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$tvar] );
			$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'StmtCount'}=1;
			
		} else { # A var decl must be unique, so if it's not a arg, it's a local or a common
		
		# The var can be either DeclaredOrigLocalVars or DeclaredCommonVars. 
		# In both case we simply update the record
			my $subset = in_nested_set($Sf,'Vars',$tvar);
#			warn 'HERE:',$subset,$line, Dumper($decl) if $line=~/IADN13/i;
			if ($subset eq '') { # Var doesn't exist yet so it becomes DeclaredOrigLocalVars 
				$subset = $is_module ? 'DeclaredCommonVars' : 'DeclaredOrigLocalVars';
				
				if ($is_module) { $decl->{'CommonBlockName'} = $f; } # overload CommonBlockName with module name 
				push @{$Sf->{$subset}{'List'}}, $tvar;
				$Sf->{$subset}{'Set'}{$tvar} = $decl;
			} else {
				# Var was declared but this could be via e.g. Dimension				
				$Sf->{$subset}{'Set'}{$tvar} = $decl;
			}			
		}
		$Sf->{'DeclCount'}{$tvar}++;
		$info->{'StmtCount'}{$tvar} = $Sf->{'DeclCount'}{$tvar};

	}    # loop over all vars declared on a single line

	print "\tINFO: VARS <$line>:\n ", join( ',', sort @varnames ), "\n" if $I;

	$info->{'VarDecl'} = {
		'Indent' => $indent,	
		'Names'  => \@varnames,
		'Status' => 0
	};

	push @{ $info->{'Ann'} }, annotate( $f, __LINE__ );
#	if ($Sf->{'FStyle'} eq 'F95') {
#	$info->{'VarDecl'}{'FStyle'} = 'F77';
#	map {say emit_f95_var_decl( get_var_record_from_set($Sf->{'Vars'},$_)) } @{ $info->{'VarDecl'}{'Names'} };
#	croak $f.$line.Dumper($info) if $line=~/hzero/; 	   
#	}

	return ( $Sf, $info );
}    # END of __parse_f77_var_decl()

# -----------------------------------------------------------------------------
sub _identify_loops_breaks {
	( my $f, my $stref ) = @_;
	my $sub_or_func = sub_func_incl_mod( $f, $stref );
	my $Sf          = $stref->{$sub_or_func}{$f};
	my $srcref      = $Sf->{'AnnLines'};
	if ( defined $srcref ) {
		my %do_loops = ();
		my %gotos    = ();

		#   my %labels=();
		my $nest = 0;
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			next if $line =~ /^\!\s+/;

			# BeginDo: we find a do with a label
			# This can be a 'proper' do .. end do but only if either there is and end do or there is a continue. Otherwise I should keep the label!
			# So I need a check on the labels
			 
			$line =~ /^\s*\d*\s+do\s+(\d+)\s+\w/ && do {
				my $label = $1;
				$info->{'BeginDo'}{'Label'} = $label;
#				if (not exists $info->{'Do'}{'Label'}  or $info->{'Do'}{'Label'} eq 'LABEL_NOT_DEFINED') {
#					$info->{'Do'}{'Label'} = $label;
#				} else {
#					say "Do label already defined: $label <> ". $info->{'Do'}{'Label'};
#				}
				$Sf->{'DoLabelTarget'}{$label}='Unknown';
				if ( not exists $do_loops{$label} ) {
					@{ $do_loops{$label} } = ( [$index], $nest );
					$nest++;
				} else {
					push @{ $do_loops{$label}[0] }, $index;
				}
				next;
			};
#    Unconditional GO TO, assigned GO TO, and computed GO TO statements
			# Goto
			$line =~ /^\s*\d*\s+.*?[\)\ ]\s*go\s?to\s+(\d+)\s*$/ && do {
				my $label = $1;
				$info->{'Goto'}{'Label'} = $label;
				$Sf->{'ReferencedLabels'}{$label}=$label;
				$Sf->{'Gotos'}{$label} = 1;				
				push @{ $gotos{$label} }, [ $index, $nest ];
				next;
			};
#    CONTINUE statement
			# continue can be end of do loop or break target (amongs others?)
			$line =~ /^\s*(\d+)\s+(continue|\w)/ && do {
				my $label = $1;
				if (exists $Sf->{'DoLabelTarget'}{$label} ) {
					$Sf->{'DoLabelTarget'}{$label}='Continue';
				}
				my $is_cont = $2 eq 'continue' ? 1 : 0;
				if ($is_cont) {
					$info->{'Continue'}{'Label'} = $label;
				}
				if ( exists $do_loops{$label} ) {
					if ( $nest == $do_loops{$label}[1] + 1 ) {
						$info->{'EndDo'}{'Label'} = $label;
						$info->{'EndDo'}{'Count'} =
						  scalar @{ $do_loops{$label}[0] };
						delete $do_loops{$label};
						$nest--;
					} else {
						print
"WARNING: $f: Found continue for label $label but nesting level is wrong: $nest<>$do_loops{$label}[1]\n"
						  if $W;
					}
				} elsif ( exists $gotos{$label} ) {
					my $target = 'GotoTarget';
					for my $pair ( @{ $gotos{$label} } ) {
						( my $tindex, my $tnest ) = @{$pair};
						$target = 'GotoTarget';
						if ( $nest <= $tnest )
						{  # What if there are several gotos point to one label?
							if ( $tnest > 0 ) {
								if ($is_cont) {
									$target = 'NoopBreakTarget';
									$srcref->[$tindex][1]{'Break'}{'Label'} =
									  $label;
								} else {
									$target = 'BreakTarget';
									$srcref->[$tindex][1]{'Break'}{'Label'} =
									  $label;

#                       print STDERR "WARNING: $f: Found BREAK target not NOOP for label $label\n";
								}
							} else {
								if ($is_cont) {
									$target = 'NoopTarget';
								}

#                           print "WARNING: goto $label ($tindex) is not in loop ($f)\n" if $translate==$GO;
							}
						} else {
							print
"WARNING: $f: Found GOTO target not BREAK for label $label: wrong nesting $nest<>$gotos{$label}[1]\n"
							  if $W;
						}
					}
					$info->{$target}{'Label'} = $label;
					$Sf->{'Gotos'}{$label} = $target;
					delete $gotos{$label};
				}
				next;
			};

   # When an open() fails, you can pass a label to some place for error handling
   # Some evil code combines such end-of-do-block labels
			$line =~ /^\s+open.*?\,\s*err\s*=\s*(\d+)\s*\)/ && do {
				my $label = $1;
				$Sf->{'Gotos'}{$label} = 1;
				next;
			};
			$srcref->[$index] = [ $line, $info ];
		}
	} else {
		print "WARNING: NO SOURCE (AnnLines) for $f\n" if $W;
	}
	return $stref;
}    # END of _identify_loops_breaks()
# -----------------------------------------------------------------------------
sub _parse_read_write_print {
	( my $line, my $info, my $stref, my $f ) = @_;
	my $sub_or_func = sub_func_incl_mod( $f, $stref );
	my $Sf          = $stref->{$sub_or_func}{$f};
	
	my $call =
	    exists $info->{'ReadCall'}  ? 'read'
	  : exists $info->{'InquireCall'} ? 'inquire'
	  : exists $info->{'WriteCall'} ? 'write'
	  :                               'print';

	$info->{'CallAttrs'} = { 'Set' => {}, 'List' => [] };
	my $tline = $line;
#say "TLINE: $line" if $f eq 'main';
#	# Remove any labels
#	if ( exists $info->{'Label'} ) {
#		my $label = $info->{'Label'};
#		$tline =~ s/^\s*$label\s+//;
#	} elsif ( $tline =~ s/^(\s*)(\d+)(\s+)/$1$3/ ) {
#		$info->{'Label'} = $2;
#	}

	# Parse

	if ( $tline !~ /^\s*print/ ) {

		#	For Open, Write and Read
		( my $matched_str, my $rest ) = _parse_IO_sub_call($tline);

		# Parse the actual call args to see if there are any variables.
		#
		$matched_str =~ s/^\w+\(//;
		$matched_str =~ s/\)$//;
#		say "$line => <$matched_str><$rest>" if $tline=~/read/;
		my @call_attrs = _parse_comma_sep_expr_list($matched_str);

		for my $call_attr (@call_attrs) {
			if ( $call_attr =~ /=/ ) {
				( my $attr_name, $call_attr ) = split( /\s*=\s*/, $call_attr );
			}

			next if $call_attr eq '*';
			next if $call_attr =~ /^\d+$/;
			next if $call_attr =~ /^(?:__PH\d+__)+$/;
			if ( $call_attr !~ /^[a-z][a-z0-9_]*/  and $call_attr !~ /^__PH\d+__/) {
				carp "UNKNOWN CALL ATTR VAL <$call_attr> on LINE <$line>";
			} else {
				my $type = $call_attr =~ /\(/ ? 'Array' : 'Scalar';
				$info->{'CallAttrs'}{'Set'}{$call_attr} = { 'Type' => $type };
				if ( $call_attr =~ /\(/ ) {
					$call_attr =~s/\)//g;
					my @call_attr_chunks=split(/\(/,$call_attr);
					for my $call_attr ( @call_attr_chunks ) {
						push @{ $info->{'CallAttrs'}{'List'} }, $call_attr;
					}
				} else {
				
				push @{ $info->{'CallAttrs'}{'List'} }, $call_attr;
				}
			}
		}
		$tline = $rest;
	} else {

		# For Print, HACK!
		$tline =~ s/print[^\,]+\,\s*//;
	}

	# Parse the rest of the statement

#say "TLINE1: <$tline>" ;
	while ( $tline =~ /[\"\'][^\"\']+[\"\']/ ) {
		croak "STRING CONST $tline";
		$tline =~ s/[\"\'][^\"\']+[\"\']//; # so at this point we could have e.g. var1,\s*,var2 or ^\*,var1 or var1,\s*$
		$tline =~ s/,\s*,//;
		$tline =~ s/^\s*,\s*//;
		$tline =~ s/\s*,\s*$//;
	}

#	say "TLINE2: <$tline>" ;
	my @exprs = _parse_comma_sep_expr_list($tline);

	#croak Dumper(@exprs) if $f eq 'plumetraj' and $tline=~/ireleasestart/;
	$info->{'CallArgs'} = { 'List' => [], 'Set' => {} };
	$info->{'ExprVars'} = { 'List' => [], 'Set' => {} };
	for my $tline (@exprs) {
#		while ( $tline =~ /\/\// ) {
#			$tline =~ s/\/\//+/;
#		}
#		while ( $tline =~ /\)\s*\(/ ) { # )(
#			$tline =~ s/\)\s*\(/,/; # ,
#		}
#		$tline =~ s/\(:/(1,/g;
#		$tline =~ s/,:/(,1,/g;
#		$tline =~ s/:\)/(,0/g; # FIXME: this is WRONG. All it does is fix the parse error!
#		$tline =~ s/:,/(,0,/g; # FIXME: this is WRONG. All it does is fix the parse error!
#		$tline =~ s/:/,/g; #
		$tline =~ s/\(,/(/g; 
		$tline =~ s/,\)/)/g;
		if ( $tline !~ /^\s*$/ ) {
			if ( $tline =~ /^\(/ ) {
				# If an argument is ( ... ) it means we only have Vars
				if ( $tline =~ /=/ ) { # must be an implied do
					 # If it's an implied do, we should identify the arguments
					my @args     = ();
					my @vars     = ();
					my $in_range = 0;
					while ( $tline ne '' ) {
						$tline =~ s/^\(*//;
						$tline =~ s/\)$//;    # This is WEAK!
						last if $tline eq '';
						( my $arg, my $rest ) = _parse_array_access_or_function_call($tline,0);
						if ( $arg =~ /=/ ) {
							( my $lhs, my $rhs ) = split( /=/, $arg );
							push @vars, $lhs;
							push @vars, $rhs;
							$in_range = 1;
						} elsif ($in_range) {
							$arg =~ s/\)$//;    # This is WEAK!
							push @vars, $arg;
						} else {
							push @args, $arg;
						}
						$rest =~ s/,//;
						$tline = $rest;
					}
					my $fake_range_expr = 'range(' . join( ',', @vars ) . ')';
					my $ast = parse_expression( $fake_range_expr, $info, $stref, $f );
					( my $call_args, my $other_vars ) = @{ get_args_vars_from_expression($ast) };
					$info->{'ExprVars'}{'Set'} = {
						%{ $info->{'ExprVars'}{'Set'} },
						%{ $other_vars->{'Set'} }
					};

					for my $mvar (@args) {
						next if $mvar eq '';
						next if $mvar =~ /^\d+$/;
						next if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
						next if exists $F95_reserved_words{$mvar};
						next if exists $Config{'Macros'}{uc($mvar)};
						my $ast = parse_expression( $mvar, $info, $stref, $f );
						( my $call_args, my $other_vars ) = @{ get_args_vars_from_expression($ast) };
						$info->{'CallArgs'}{'Set'} = {
							%{ $info->{'CallArgs'}{'Set'} },
							%{ $call_args->{'Set'} }
						};
						$info->{'ExprVars'}{'Set'} = {
							%{ $info->{'ExprVars'}{'Set'} },
							%{ $other_vars->{'Set'} }
						};
					}
					$info->{'CallArgs'}{'List'} =
					  [ keys %{ $info->{'CallArgs'}{'Set'} } ];
					$info->{'ExprVars'}{'List'} =
					  [ keys %{ $info->{'ExprVars'}{'Set'} } ];
				} else {
	  # This is an expression in parentheses, so it must be treated as Vars-only
					my @chunks = split( /\W+/, $tline );
					my %vars_in_expr = ();
					for my $mvar (@chunks) {
						next if $mvar eq '';
						next if $mvar =~ /^\d+$/;
						next
						  if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
						next if exists $F95_reserved_words{$mvar};
						next if exists $Config{'Macros'}{uc($mvar)};
						$vars_in_expr{$mvar} = { 'Type' => 'Unknown' };
					}
					$info->{'ExprVars'} = {
						'List' => [ keys %vars_in_expr ],
						'Set'  => {%vars_in_expr}
					};
				}
			} else {    # ok, maybe we can parse this
				my $ast =
				  parse_expression( "$call($tline)", $info, $stref, $f );
				( my $args, my $other_vars ) = @{ get_args_vars_from_expression($ast) };
				$info->{'CallArgs'} =
				  append_to_set( $info->{'CallArgs'}, $args );
				$info->{'ExprVars'} =
				  append_to_set( $info->{'ExprVars'}, $other_vars );
			}
		}
	}


	return $info;
}    # END of _parse_read_write_print()

# -----------------------------------------------------------------------------
sub _parse_assignment {
	( my $line, my $info, my $stref, my $f ) = @_;

	my $tline = $line;


	$tline =~ s/^\s*\d+//;    # remove labels
	$tline =~ s/^\s+//;       # remove blanks
	$tline =~ s/\s+$//;       # remove blanks

	# TODO: proper Fortran expression parser.
	# For now we sanitise the lines as follows:
#	# Replace '//' by '+' because the parser does not know '//'
#	while ( $tline =~ /\/\// ) {
#		$tline =~ s/\/\//+/;
#	}

#	# Remove ')(', this I think only occurs for characters strings
#	while ( $tline =~ /\)\s*\(/ ) {
#		$tline =~ s/\)\s*\(/,/;
#	}

#	# Remove ':' because again this only occurs for characters strings
#		$tline =~ s/\(:/(1,/g;
#		$tline =~ s/,:/,1,/g;
#		$tline =~ s/:\)/,0)/g ; # FIXME: this is WRONG. All it does is fix the parse error! What we really need is the end of the array!
#		$tline =~ s/:,/,0,/g; # FIXME: this is WRONG. All it does is fix the parse error!
#		$tline =~ s/:/,/g; #

	#    say "ALINE: $tline";
	( my $lhs, my $rhs ) = split( /\s*=\s*/, $tline );

	#     say "LHS: $lhs, RHS: $rhs";
	my $lhs_ast = parse_expression( $lhs, $info, $stref, $f );

	#	say "LHS:".$line ;
	#	say "LHS_AST:".Dumper($lhs_ast) if $lhs_ast->[1] eq 'len';
	# FIXME: must make sure here that lhs is NOT a reserverd word, dammit!
	( my $lhs_args, my $lhs_vars ) =
	  @{ get_args_vars_from_expression($lhs_ast) };

	#	say 'ARGS: '.Dumper($lhs_args);
	#	say 'VARS:'.Dumper($lhs_vars)  if $lhs_ast->[1] eq 'len';
	if (   exists $F95_reserved_words{ $lhs_ast->[1] }
		or exists $F95_intrinsics{ $lhs_ast->[1] } )
	{
		my $tmp_line = $line;
		$tmp_line =~ s/__PH\d+__/.../g;
		say "WARNING: ASSIGNMENT to reserved word or intrinsic '"
		  . $lhs_ast->[1]
		  . "' at line '"
		  . $tmp_line,
		  "' in subroutine/function '$f' in '"
		  . $stref->{'Subroutines'}{$f}{'Source'}
		  . "'\nThis is DANGEROUS, please fix your code!" if $W;
		$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{ $lhs_ast->[1] } = 1;
		$lhs_ast = parse_expression( $lhs, $info, $stref, $f );
	}
	my $array_constant=0;
	if ($rhs=~/\(\/.+\/\)/) {
		$rhs=~s/\(\//(/;
		$rhs=~s/\/\)/)/;
		$array_constant=1;
	}
	
	my $rhs_ast = parse_expression( $rhs, $info, $stref, $f );
	if ($array_constant==1) {
		$rhs_ast->[1]='_OPEN_CONST_ARRAY_';
#		croak 'RHS_AST:'.Dumper($rhs_ast ).emit_expression($rhs_ast, '');
	}

	#	say 'RHS_AST:'.Dumper($rhs_ast );
	( my $rhs_args, my $rhs_vars ) =
	  @{ get_args_vars_from_expression($rhs_ast) };

	#	say 'RHS_ARGS:'.Dumper($rhs_args);
	my $rhs_all_vars = {
		'Set'  => { %{ $rhs_args->{'Set'} },  %{ $rhs_vars->{'Set'} } },
		'List' => [ @{ $rhs_args->{'List'} }, @{ $rhs_vars->{'List'} } ]
	};

	#{Lhs => {VarName, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
	if ( scalar @{ $lhs_args->{'List'} } > 0 ) {
		my $lhs_varname = $lhs_args->{'List'}[0];

		$info->{'Lhs'} = {
			'VarName'       => $lhs_varname,
			'IndexVars'     => $lhs_vars,
			'ArrayOrScalar' => $lhs_args->{'Set'}{$lhs_varname}{'Type'},
			'ExpressionAST' => $lhs_ast
		};
	} else {
		$info->{'Lhs'} = {
			'ArrayOrScalar' => 'Other',
			'ExpressionAST' => $lhs_ast
		};
	}

	$info->{'Rhs'} = {
		'VarList'       => $rhs_all_vars,
		'ExpressionAST' => $rhs_ast
	};

	return $info;
}    # END of _parse_assignment()

# -----------------------------------------------------------------------------
# This matches anything of the form name ( ..., (...), ... )
sub _parse_array_access_or_function_call {
	( my $str, my $stop_after_outer_parens ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;
	my $outer_paren_closed=0;

	my $matched_str = '';
	for my $ch_idx ( 0 .. $nchars - 1 ) {
		my $ch = shift @chars;
		if ( $ch eq '(' ) {			
			if ( $ch_idx == 0 ) { # first char is a paren, give up
				unshift @chars, $ch;
				last;
			}
			$found_parens = 1; # found '(' not as first char
			++$parens_count;
		} elsif ( $ch eq ')' ) { # found ')'
			--$parens_count;
			if ( $parens_count == 0 ) {
				$found_parens = 0;
				$outer_paren_closed=1; 
			}
		} elsif ( $ch eq ',' and $found_parens == 0 ) { # a ',' outside the parens, give up
			unshift @chars, $ch;
			last;
		}
		$matched_str .= $ch;
		last if $found_parens == 1 and $parens_count == 0;
		last if $outer_paren_closed and $stop_after_outer_parens;
	}
	my $rest = join( '', @chars );
	return ( $matched_str, $rest );
}    # END of _parse_array_access_or_function_call()
# -----------------------------------------------------------------------------
sub _parse_IO_sub_call {
	( my $str ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;

	my $matched_str = '';
	for my $ch_idx ( 0 .. $nchars - 1 ) {		
		my $ch = shift @chars;
		if ( $ch eq ' ' or $ch eq "\t" ) {
			next;
		} elsif ( $ch eq '(' ) {
			if ( $ch_idx < 2 ) {
				unshift @chars, $ch;
				last;
			}
			$found_parens = 1;
			++$parens_count;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
		}
		if ( $found_parens == 1 and $parens_count == 0 ) {
			last;
		}
		$matched_str .= $ch;
	}
	my $rest = join( '', @chars );

	return ( $matched_str, $rest );
}    # END of _parse_IO_sub_call()
# --------------------------------------------------------------------------------
sub _parse_if_cond {
	( my $str ) = @_;

	my $parens_count = 1;
	
	
	my $open_paren_idx=index($str,'(');
	my $close_paren_idx=-1;


	for my $idx ($open_paren_idx+1 .. length($str)-1 ) {
		my $ch = substr($str,$idx,1);
		# skip blanks
		if ( $ch eq ' ' or $ch eq "\t" ) { 
			next;
		} elsif ( $ch eq '(' ) { 			
			++$parens_count;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
			if ($parens_count == 0) {
				$close_paren_idx=$idx;
				last;
			}
		}
	}
	my $cond = substr($str,$open_paren_idx+1, $close_paren_idx-$open_paren_idx-1);
	my $rest = substr($str, $close_paren_idx+1);
#	while(substr($rest,0,1) eq ' ') {
#		$rest = substr($rest,1);
#	}
#say $rest;
	$rest=~s/^\s*//;
	$rest=~s/\s*$//;
	return ($cond,$rest); 
} # END _parse_if_cond()
# --------------------------------------------------------------------------------
sub _parse_if_cond_OLD {
	( my $str ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;

	my $matched_str = '';
	for my $ch_idx ( 0 .. $nchars - 1 ) {
		my $ch = shift @chars;
		# skip blanks
		if ( $ch eq ' ' or $ch eq "\t" ) { 
			next;
		} elsif ( $ch eq '(' ) { 
			if ( $ch_idx < 2 ) { # if the paren occurs in pos 0 or 1, give up, it's not an 'if'
				unshift @chars, $ch;
				last;
			}
			$found_parens = 1;
			++$parens_count;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
		}
		if ( $found_parens == 1 and $parens_count == 0 ) {
			$matched_str .= $ch;
			last;
		}
		$matched_str .= $ch;
	}
	my $rest = join( '', @chars );
	return ( $matched_str, $rest );
} # END of _parse_if_cond_OLD()
# --------------------------------------------------------------------------------
# Takes a string which contains a comma-separated list of expressions, returns a list of the expressions
sub _parse_comma_sep_expr_list {

	( my $str ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;

	my $matched_str  = '';
	my @matched_strs = ();

	for my $ch_idx ( 0 .. $nchars - 1 ) {
		my $ch = shift @chars;
		if ( $ch eq '(' ) {
			$found_parens = 1;
			++$parens_count;
			$matched_str .= $ch;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
			if ( $found_parens == 1 and $parens_count == 0 ) {
				$found_parens = 0;
			}
			$matched_str .= $ch;
		} elsif ( $ch eq ',' and $found_parens == 0 ) {
			push @matched_strs, $matched_str;
			$matched_str = '';
		} elsif ( $ch ne ' ' ) {
			$matched_str .= $ch;
		}
		if ( $ch_idx == $nchars - 1 ) {
			push @matched_strs, $matched_str;
		}
	}
	return @matched_strs;
} # END of _parse_comma_sep_expr_list

# What we do is find the words in the value,
sub ___check_par_val_for_pars {
	( my $val ) = @_;
	return {} if $val =~ /^\d+$/;
	return {} if $val =~ /^[\'\"]/;
	return {} if $val =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;

	my @mpars = split( /\W+/, $val );
	my $pars_in_val = {};
	for my $mpar (@mpars) {
		next if $mpar =~ /^\d+$/;
		next if $mpar =~ /^[\'\"]/;
		next if $mpar =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
		next if exists $F95_reserved_words{$mpar};
		next if exists $Config{'Macros'}{uc($mpar)}; # macros
		$pars_in_val->{$mpar} = 1;
	}

	#	say "PARS IN VAL:".Dumper($pars_in_val);

	return $pars_in_val;
}

sub __remove_blanks { (my $line, my $free_form)=@_;
	
	my $c1to6='';
	if (not $free_form) {
		$c1to6=substr($line,0,5);
		$line= substr($line,length($c1to6));
#		say  "C1TO6:".$c1to6;
	} elsif ($line=~/^(\s*\d+\s+)/  ) {
		$c1to6=$1;
#		say  "C1TO6:".$c1to6;
		$line= substr($line,length($c1to6)); 
	}
	
	
	my $indent = $line;
	$indent =~s/\S.*$//;
	if ($line=~/^do\s+/) {
		$line=~s/^do\s+//;
		$line=~s/\s+//g;
		$line = "do $line";
	} else {
		$line=~s/\s+//g;
	}	
	#FM351 
#	croak "INDENT IS WRONG!";
#	say "ASSIGN:".$c1to6.'|'.$indent.'|'.$line if $line=~/rvon01/;
	return  $c1to6.$indent.$line;
}

sub _parse_data_declaration { (my $line,my $info, my $stref, my $f) = @_;
	my $new_annlines=[];
	my $indent =$line;$indent=~s/data.*$//;
	my $mline=$line;

	$mline=~s/^\s*\d*\s+data\s+//; 
	$mline=~s/\/\s*$//;
	
	(my $lhs, my $rhs) = split (/\s*\/\s*/,$mline);
#croak "$lhs => $rhs" if $mline=~/ivon02/;
if ($lhs=~/,/ or $rhs=~/,/) {
	my @lhs_exprs = _parse_comma_sep_expr_list($lhs);
	# TODO: in principle I must do a full argument and variable analysis here, like in IO calls. Leave that for later.
	# Question is if an implied do can appear on an lhs
	
	for my $lhs_expr (@lhs_exprs) {
		if ($lhs_expr =~/=/) {
				say 'WARNING: Sorry, no support for implied-do in data declarations for now' if $W;
				return [[$line,$info]];			
		}
	}

#	my @lhs_vars =  split (/\s*,\s*/,$lhs);
	my $lhs_expr = 'dummy('.$lhs.')';
	my $lhs_ast = parse_expression($lhs_expr, $info,$stref, $f);		
	
#	if ($rhs =~/\d+\s*\*\s*/) {
#			
#	}
	my $rhs_expr = 'dummy('.$rhs.')';
	my $rhs_ast = parse_expression($rhs_expr, $info,$stref, $f);
	
#	croak Dumper($ast);
#	my @rhs_vals =  ();
	my $rhs_idx=2;
	for my $idx  (2 .. @{$lhs_ast}-3) {
		my $lhs_var_ast = $lhs_ast->[$idx];
		( my $lhs_args, my $lhs_vars ) = @{ get_args_vars_from_expression($lhs_var_ast) };
		
		my $lhs_var = ref($lhs_var_ast) eq 'ARRAY' ? emit_expression($lhs_var_ast) : $lhs_var_ast;
		 
#		say Dumper($lhs_var_ast);
		
	if ( scalar @{ $lhs_args->{'List'} } > 0 ) {
		my $lhs_varname = $lhs_args->{'List'}[0];

		$info->{'Lhs'} = {
			'VarName'       => $lhs_varname,
			'IndexVars'     => $lhs_vars,
			'ArrayOrScalar' => $lhs_args->{'Set'}{$lhs_varname}{'Type'},
			'ExpressionAST' => $lhs_ast
		};
	} else {
		$info->{'Lhs'} = {
			'ArrayOrScalar' => 'Other',
			'ExpressionAST' => $lhs_ast
		};
	}		
		
		
		my $rhs_val_ast = $rhs_ast->[$rhs_idx++];
		
		my $rhs_val = ref($rhs_val_ast) eq 'ARRAY' ? emit_expression($rhs_val_ast) : $rhs_val_ast;
			# I am lazy so I use a regex to substitute the placeholders
			if (not defined $rhs_val) { 
				# FIXME: this means we failed to parse this correctly, just warn and keep the old line.
				say "WARNING: Could not parse this DATA declaration: $line" if $W;
				return [[$line,$info]];
			};  
			while ($rhs_val =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$rhs_val=~s/$ph/$ph_str/;
			}
		
		my $new_line = "$indent$lhs_var = $rhs_val";
		
	my $rinfo = dclone($info);
	$rinfo->{'Assignment'}=1;
$rinfo->{'Data'}=1;
			( my $rhs_args, my $rhs_vars ) =
	  @{ get_args_vars_from_expression($rhs_val_ast) };
	my $rhs_all_vars = {
		'Set'  => { %{ $rhs_args->{'Set'} },  %{ $rhs_vars->{'Set'} } },
		'List' => [ @{ $rhs_args->{'List'} }, @{ $rhs_vars->{'List'} } ]
	};
	$rinfo->{'Rhs'} = {
		'VarList'       => $rhs_all_vars,
		'ExpressionAST' => $rhs_val_ast
	};	
	push @{ $new_annlines }, [$new_line,$rinfo];
	}
} else {
	# No comma in LHS so it must be a single var, easy:
		$info->{'Assignment'}=1;
		$info->{'Data'}=1;
	# But NO! it can be something absurd like 
	#  DATA  LADN1D/.TRUE., .FALSE./ 
	# So let's say, if there is no comma in the RHS either we do that. 
	# Otherwise we count and if it does not match, we give up!
#	croak "$indent$lhs = $rhs";
	return [["$indent$lhs = $rhs",$info]];
}
	return $new_annlines;
	
} # END of _parse_data_declaration()

sub _expand_repeat_data { (my $line)=@_;
	return $line;
}

sub  _get_var_from_ast { (my  $ast ) = @_;
	my $var='';
	# The AST is always an array
	
	# If there is a length, we need the 2nd elt
	if ($ast->[0] eq '*') {
	# That elt can either be a scalar
	# or an array
		if($ast->[1][0] eq '$') {
			$var= $ast->[1][1];
		} elsif ($ast->[1][0] eq '@') {
			$var= $ast->[1][1];
		} else {
			croak Dumper($ast);
		}
	  
	} else {
		if($ast->[0] eq '$') {
			$var= $ast->[1];
		} elsif ($ast->[0] eq '@') {
			$var= $ast->[1];
		} else {
			croak Dumper($ast);
		}
	}
	return $var;
}


sub  _get_dim_from_ast { (my  $ast ) = @_;
		my $dim=[];
		
# If there is a length, we need the 2nd elt
	if ($ast->[0] eq '*') {
	# That elt can either be a scalar
	# or an array
		if($ast->[1][0] eq '@') {
			# It's an array so there is a dim
			for my $pdim_idx (2 .. @{$ast->[1]}-1) {
				my $pdim = $ast->[1][$pdim_idx];
				if (ref($pdim) eq 'ARRAY') {
					if ($pdim->[0] eq ':') {
						my $dim_start = emit_expression($pdim->[1],'');
						my $dim_stop = emit_expression($pdim->[2],'');
						push @{$dim}, [$dim_start ,$dim_stop ]; 
					} else {
						my $dim_start = 1;
						my $dim_stop = emit_expression($pdim,'');
						push @{$dim}, [$dim_start ,$dim_stop ]; 					
					}
				} else { # must be scalar
					my $dim_start = 1;
					my $dim_stop = emit_expression($pdim,'');
					push @{$dim}, [$dim_start ,$dim_stop ];
				}
			}
		} elsif ($ast->[1][0] eq '$') {
			# no dim			
		} else {
			croak Dumper($ast);
		}
	  
	} else {
		if($ast->[0] eq '$') {
			# no dim
		} elsif ($ast->[0] eq '@') {
			for my $pdim_idx (2 .. @{$ast}-1) {
				my $pdim = $ast->[$pdim_idx];
				if (ref($pdim) eq 'ARRAY') {
					if ($pdim->[0] eq ':') {
						my $dim_start = emit_expression($pdim->[1],'');
						my $dim_stop = emit_expression($pdim->[2],'');
						push @{$dim}, [$dim_start ,$dim_stop ]; 
					}
				} else { # must be a scalar
					my $dim_start = 1;
					my $dim_stop = emit_expression($pdim,'');
					push @{$dim}, [$dim_start ,$dim_stop ];					
				}
			}
		} else {
			croak Dumper($ast);
		}	
	}	
	return $dim;	
}


sub  _get_len_from_ast { (my  $ast ) = @_;
	my $len='';
	if ($ast->[0] eq '*') {
		# there is a len
		my $len_expr = $ast->[2];
		if ($len_expr eq '0') {
			$len = '*';	
		} elsif ($len_expr=~/^\d+/) {
			$len = $len_expr;
		} else {
			# could be thart we have to strip parens here
			$len = emit_expression($len_expr);
			if ($len=~/\(([a-z]\w+)\)/) {
				$len=$1;				
			}		
		}
	} 
	return $len;
	
}
# This code runs on any sub that has a Kernel region
# I could of course use this pass to enumerate all the subroutines, put them in KernelSubs 
# Or I can do a separate pass later to do just that task 
# 
sub mark_blocks_between_calls { (my $stref)=@_;
	my $n_kernel_regions=0;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next unless exists $stref->{'Subroutines'}{$f}{'HasKernelRegion'};
		$n_kernel_regions++;
		if ($n_kernel_regions>1) {
			die "Sorry, only one ACC Kernel region is currently supported.\n";
		}
		
		my $in_kernel_region=0;
		my $in_block=0;
		my $nested_block='';
		my $index=0;
		my $extract_subs=0;
		my $called_subs = [];
		
		my $pass_actions = sub { (my $annline, my $state) = @_;
			(my $line, my $info)=@{$annline};
			
			(my $in_kernel_region, my $in_block, my $nested_block, my $index,my $extract_subs, my $called_subs)= @{$state};
			my $skip=0;
			if (exists $info->{'AccPragma'}{'BeginKernel'}) {
				$in_kernel_region=1;
				$skip=1; 		
				$info->{'Removed'}=1;
				$line=~s/\$//g;
				$annline=[$line,$info];
			}
			if (exists $info->{'AccPragma'}{'EndKernel'}) {
				$in_kernel_region=0;
				$skip=1;
				$info->{'Removed'}=1;
				$line=~s/\$//g;
				$annline=[$line,$info];
			}
			
			if ( $skip==0 and $in_kernel_region and not exists $info->{'Comments'} and not exists $info->{'Blank'} and not exists $info->{'Removed'}) {
					# if a line is relevant
			# if not a call, put a begin marker before it
				if (not exists $info->{'SubroutineCall'}) { #say $line."\t".Dumper($info);
					$in_block=1;
					my $begin_marker_line = '!$ACC Subroutine';
					(my $dummy, my $begin_marker_info) = __handle_acc({}, '',$index, $begin_marker_line, {});
					my $begin_marker_annline = [$begin_marker_line,$begin_marker_info];
					my $sub_name = $begin_marker_info->{'AccPragma'}{'BeginSubroutine'}[0];				

					if (exists $info->{'Block'}) {
						if ( not exists $info->{'EndControl'}) {
							push @{$called_subs}, $sub_name;
							$nested_block=$info->{'Block'}{'Type'}.$info->{'Block'}{'Nest'};
							return ([ $begin_marker_annline, $annline ], [$in_kernel_region,$in_block,$nested_block, $index++,$extract_subs, $called_subs] );
						} else {
							$nested_block='';
							return ([  $annline ], [$in_kernel_region,$in_block,$nested_block, $index++,$extract_subs, $called_subs] );
						}
					} else {
						push @{$called_subs}, $sub_name;
						return ([ $begin_marker_annline, $annline ], [$in_kernel_region,$in_block,$nested_block, $index++,$extract_subs, $called_subs] );
					}
					
					
				} else {
					my $sub_name = $info->{'SubroutineCall'}{'Name'};
					
					
					if ($in_block) {
						if ($nested_block eq '') {
							push @{$called_subs}, $sub_name;
							# if a call and $in_block and not nested, put an end marker before it
							$in_block=0;
							my $end_marker_line = '!$ACC End Subroutine';
							$extract_subs=1;
							(my $dummy, my $end_marker_info) = __handle_acc({}, '',$index, $end_marker_line, {});
							my $end_marker_annline = [$end_marker_line , $end_marker_info ];	
							return ( [ $end_marker_annline, $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
						} else {
							return ( [ $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
						}
					} else {
						push @{$called_subs}, $sub_name;
						return ( [ $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
					}	
				}	
			} else {
				return ([ $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
			}
		};
		
		($stref, my $state) = stateful_pass ($stref,  $f,  $pass_actions,  [$in_kernel_region,$in_block, $nested_block, $index,$extract_subs,$called_subs], 'mark_blocks_between_calls' );
		($in_kernel_region,$in_block, $nested_block,$index,$extract_subs,$called_subs)=@{$state};
		
		$stref->{'Subroutines'}{$f}{'HasBlocks'}=$extract_subs;
		if ($extract_subs) {
			$stref->{'Subroutines'}{$f}{'AnnLines'}=$stref->{'Subroutines'}{$f}{'RefactoredCode'};
		}
		$stref->{'KernelSubs'}=$called_subs;		
	}	
	return $stref;
}

1;



=pod

sub new_logic {
	
	
# The problem with this logic is that we need to add some info to see which line should be kept.
# The only way to do this is to annotate the type lines with info passed via the type record
# So we add an entry "Stmts" which starts out as 0 and which we increment and store in $info (after splitting the lines!
# Then the second pass keeps the line with Stmts==1 and marks the others for deletion
# This is actually also the right thing to do for parameters I think.

	
# DIMENSION (D)
if (not in_nested_set( $Sf, 'Vars', $varname ) ) {   
    $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredCommonVars' 
        or in_nested_set( $Sf, 'Vars', $varname ) eq 'ExGlobArgs' 
        ) {
# So it's a Declared Common (i.e. prev. was C, TC, CT
# Get the dimension
# Update Decl 
$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredOrigLocalVars') {
# Means there was a T before
# Update Decl 

} else {
# Should be impossible
}


# COMMON (C)
if (not in_nested_set( $Sf, 'Vars', $varname ) ) {   
    $Sf->{'DeclaredCommonVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredOrigLocalVars' 
        ) {
# So it's a Declared Orig Local (i.e. prev. was D, T, DT or TD
# Update Decl 
# Change from DeclaredOrigLocalVars to DeclaredCommonVars and copy to ExGlobArgs
} else {
# Should be impossible
}

# TYPE DECL (T), actually this is identical to D in terms of the logic
if (not in_nested_set( $Sf, 'Vars', $varname ) ) {   
    $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredCommonVars' 
        or in_nested_set( $Sf, 'Vars', $varname ) eq 'ExGlobArgs' 
        ) {
# So it's a Declared Common (i.e. prev. was C, DC, CD
# Update Decl 

} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredOrigLocalVars') {
# Update Decl 

} else {
# Should be impossible
}
	
	
	
	
}

=cut
