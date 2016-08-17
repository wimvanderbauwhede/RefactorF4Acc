package RefactorF4Acc::Parser;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::CallTree qw( add_to_call_tree );
use RefactorF4Acc::Refactoring::Common qw( emit_f95_var_decl get_f95_var_decl );
use RefactorF4Acc::Parser::SrcReader qw( read_fortran_src );
use RefactorF4Acc::Parser::Expressions
  qw( get_vars_from_expression parse_expression  get_args_vars_from_expression get_args_vars_from_subcall emit_expression);
use RefactorF4Acc::CTranslation qw( add_to_C_build_sources );    # OBSOLETE
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_start_detect );
use RefactorF4Acc::Analysis::ArgumentIODirs qw(  &conditional_assignment_fsm );

use F95VarDeclParser qw( parse_F95_var_decl );
use FortranConstructParser qw(
  parse_Fortran_open_call
  parse_Fortran_do_construct
  parse_Fortran_if_construct
);

#
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
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

	#	say 'INIT:'.Dumper($stref->{'Subroutines'}{'init'}{'AnnLines'}) ;
	#	say 'POST:'.Dumper($stref->{'Subroutines'}{'post'}{'AnnLines'}) ;
	#	die if $f eq 'post';
	if ( $sub_or_incl_or_mod ne 'ExternalSubroutines'
		and not $is_external_include )
	{
		my $Sf = $stref->{$sub_or_incl_or_mod}{$f};

		# OK, time to declare all the variable sets and declaration sets		
		$Sf = _initialise_decl_var_tables( $Sf, $f, $is_incl,$is_mod );
		
# Set 'RefactorGlobals' to 0, we only refactor the globals for subs that are kernel targets and their dependencies
		if ( not exists $Sf->{'RefactorGlobals'} ) {
			$Sf->{'RefactorGlobals'} = 0;
		}
		if ( $refactor_toplevel_globals == 1 ) {
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

#			say "AFTER PARSING $f:".Dumper($stref->{'Subroutines'}{'vertical'}{'AnnLines'}) ; croak if $f eq 'vertical';
		} elsif ($is_incl) {    # includes
## 6. For includes, parse common blocks and parameters, create $stref->{'IncludeFiles'}{$inc}{'Commons'}
			$stref = _get_commons_params_from_includes( $f, $stref );
			$stref->{'IncludeFiles'}{$f}{'Status'} = $PARSED;
		} else {			
			
			$stref->{'Modules'}{$f}{'Status'} = $PARSED;			
		}

	   # 7. Split variable declarations with multiple vars into single-var lines
	   # One could say this is "refactoring" but I say it's "preconditioning"
		$stref = _split_multivar_decls( $f, $stref );
		
		$stref = _split_multipar_decls_and_set_type( $f, $stref );

	} else {
		print "INFO: $f is EXTERNAL\n" if $I;
	}

	print "LEAVING parse_fortran_src( $f ) with Status "
	  . show_status( $stref->{$sub_or_incl_or_mod}{$f}{'Status'} ) . "\n"
	  if $V;

	return $stref;

}    # END of parse_fortran_src()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# parse_fortran_src() parses the source but does perform only limited context-free analysis
# This routine is recursive
# This should go into Refactoring::Blocks.pm
sub refactor_marked_blocks_into_subroutines {
	( my $stref ) = @_;

	#    local $V=1;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {

		if ( exists $stref->{'Subroutines'}{$f}{'HasBlocks'}
			and $stref->{'Subroutines'}{$f}{'HasBlocks'} == 1 )
		{

			print "refactor_marked_blocks_into_subroutines(): PARSING $f\n "
			  if $V;

			my $sub_or_incl_or_mod = sub_func_incl_mod( $f, $stref );
			my $is_incl = $sub_or_incl_or_mod eq 'IncludeFiles';
			my $is_external_include = $is_incl ? ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'External' ) : 0;

			print "SRC TYPE for $f: $sub_or_incl_or_mod\n" if $V;
			if ( $sub_or_incl_or_mod ne 'ExternalSubroutines'
				and not $is_external_include ) {

				## 5. Parse subroutine and function calls
				if ( not $is_incl ) {
					if ( $stref->{$sub_or_incl_or_mod}{$f}{'HasBlocks'} == 1 ) {
						$stref = _separate_blocks( $f, $stref );
					}
				}
			} else {
				say "INFO: $f is EXTERNA" if $I;
			}
			say "LEAVING refactor_marked_blocks_into_subroutines( $f ) with Status $stref->{$sub_or_incl_or_mod}{$f}{'Status'}" if $V;
		}
	}
	return $stref;
}    # END of refactor_marked_blocks_into_subroutines()

# -----------------------------------------------------------------------------
# Here I initialise tables for Variables and Declarations and a few other Subroutine-specific data structures
sub _initialise_decl_var_tables {
	( my $Sf, my $f, my $is_incl, my $is_mod ) = @_;
	say "_initialise_decl_var_tables for subroutine $f" if $V;

	if ( not exists $Sf->{'CalledSubs'} ) {
		$Sf->{'CalledSubs'} = { 'List' => [], 'Set' => {} };
	}

# WV20151021 what we need here is a check that this function has not been called before for this $Sf
	if ( not exists $Sf->{'DoneInitTables'} ) {
		say "_initialise_decl_var_tables : INIT TABLES for subroutine $f" if $V;

		$Sf->{'HasCommons'} = 0;

		# WV20151021 maybe need to do that for all subsets of Vars too?
		# WV20151021 the question is if this needs to be hierarchical?
		# Also, I think I wil use 'Subsets'
		$Sf->{'DeclaredOrigLocalVars'}   = { 'Set' => {}, 'List' => [] };
		$Sf->{'UndeclaredOrigLocalVars'} = { 'Set' => {}, 'List' => [] };

		#		$Sf->{'Parameters'} = {};
		$Sf->{'LocalParameters'}    = { 'Set' => {}, 'List' => [] };
		$Sf->{'IncludedParameters'} = { 'Set' => {}, 'List' => [] }; # I think I will overload this rather than define UsedParameters?

		$Sf->{'ParametersFromContainer'} = { 'Set' => {}, 'List' => [] };

		# This is only for testing which vars are commons, nothing else.
		$Sf->{'Commons'} = {}; 

# FIXME At the moment we assume automatically that CommonVars become ExGlobArgs 
		$Sf->{'DeclaredCommonVars'}   = { 'Set' => {}, 'List' => [] };						
		$Sf->{'UndeclaredCommonVars'} = { 'Set' => {}, 'List' => [] };
		
		$Sf->{'CommonVars'}           = {
			'Subsets' => {
				'DeclaredCommonVars'   => $Sf->{'DeclaredCommonVars'},
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
		
		# Var decls via a 'use' declaration
		$Sf->{'UsedLocalVars'} = { 'Set' => {}, 'List' => [] };		
		
		if ( not $is_incl and not $is_mod ) {

 # WV: Maybe I should have an additional record 'FromInclude' in the set record!
 # This seemed like a good idea but it requires so many changes. Instead I think I'll just populate ExGlobArgs on the fly
# 			$Sf->{'ExInclGlobArgs'} = { 
#				'Set' => {}, 'List' => [] 
#			};
# 			$Sf->{'ExContainerGlobArgs'} = { 
#				'Set' => {}, 'List' => [] 
#			}; 
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
					'UsedLocalVars' => $Sf->{'UsedLocalVars'}
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
					'IncludedParameters' => $Sf->{'IncludedParameters'}
				}
			};
			$Sf->{'Vars'} = {
				'Subsets' => {
					'LocalVars'  => $Sf->{'LocalVars'},
					'CommonVars' => $Sf->{'CommonVars'},
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
	my $Sf = $stref->{$sub_incl_or_mod}{$f};
	$Sf->{'ExGlobVarDeclHook'} = 0;
	my $srcref = $Sf->{'AnnLines'};

	if ( defined $srcref ) {
		print "\nINFO: VAR DECLS in $f:\n" if $I;
		my %vars = ();

		my $first          = 1;
		my $is_f77_vardecl = 0;
		my $type           = 'NONE';
		my $varlst         = '';
		my $indent         = '';
		my @do_stack       = ();
		my $do_counter     = 0;
		my $block_nest_counter = 0;
		my $block_counter = 0;
		my %block_id = ();
		my @blocks_stack=();
		my %extra_lines=(); # $index => [ ... ]

		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $attr = '';
			( my $line, my $info ) = @{ $srcref->[$index] };
			# Get indent			
			$line =~ /^(\s+).*/ && do { $indent = $1; };

			$info->{'LineID'} = $index;
			# Skip comments 
			if ( $line =~ /^\s*\!/ && $line !~ /^\!\s*\$(?:ACC|RF4A)\s/i ) {
				next;
			}
			my $mline = $line;    # modifiable copy of $line

			# Handle !$ACC
			if ( $line =~ /^\!\s*\$(?:ACC|RF4A)\s.+$/i ) {
				( $stref, $info ) = __handle_acc( $stref, $f, $index, $line );
			}

			
			# FIXME Trailing comments are ignored!
			#            if ( $line =~ /^\!\s/ ) {
			#                $stref->{$sub_incl_or_mod}{$f}{'Info'}
			#                  ->[$index]{'TrailingComments'} = {};
			#                next;
			#            }
			
			
			# --------------------------------------------------------------------------------
			# BLOCK identification code
			# --------------------------------------------------------------------------------
			
			$line=~/^\s*\d*\s+(map|structure|union|select)\s+/ && do {
				my $block_type=$1;
				++$block_nest_counter;
				++$block_counter;
				$block_id{$block_counter}={'Nest'=>$block_nest_counter, 'Type' => $block_type};
				push @blocks_stack,$block_id{$block_counter}; 
				$info->{ucfirst($block_type)}=1;
			};
			
			$line=~/^\s*\d*\s+(if).*?then\s+/ && do {
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => $1};
				push @blocks_stack,$block;
#				say "\t" x $block_nest_counter,"BEGIN block #$block_counter IF";
			};	
			$line=~/^\s*\d*\s+(do)\s+(\w+)\s+\w+\s*=/ && do {				 
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => $1, 'Label' => $2};
				push @blocks_stack,$block;
#				say "\t" x $block_nest_counter,"BEGIN block #$block_counter DO LABEL $2";
			};		
			# Procedure block identification				
			$line =~ /^\s*(\w+\s+\w+\s+(?:function|subroutine)|\w+\s+subroutine|[\*\(\)\w]+\s+function|function|subroutine|program|block)\s+(\w+)/ && do {
				my $full_proc_type=$1;
				my $proc_name=$2;			
				my $proc_type = $full_proc_type=~/program/ ? 'program' : 
					$full_proc_type=~/subroutine/ ? 'subroutine' : 
					($full_proc_type eq 'block' and $proc_name eq 'data') ? 'block data' : 
					'function';
				if ($proc_type eq 'block data') {
					$full_proc_type = 'block data';
					$proc_name = 'block_data';
                	$line=~/block\s+data\s+(\w+)/i && do { $proc_name=$1 };
#					carp "FOUND BLOCK DATA $proc_name: $line";
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
				
				my $block={'Nest'=>$block_nest_counter, 'Type' => $proc_type, 'Name'=>$proc_name};
				push @blocks_stack,$block;
#				say "\nLINE <$line>\n","\t" x $block_nest_counter,"BEGIN block #$block_counter, NEST:".$block->{'Nest'}." $proc_type $proc_name ";
			};
			
			# END of BLOCK:			
			$line=~/^\s*\d*\s+end\s+/ && $line!~/^\s*\d*\s+end\s+do/ && do {
				my $block = pop @blocks_stack;
#				print "\t" x $block_nest_counter,"END for block #$block_counter, NEST:".$block->{'Nest'}.' '.$block->{'Type'}. ' ';
#				 if (exists $block->{'Name'} ) {
#				 	say ' '.$block->{'Name'} ;
#				 	$info->{'End'.ucfirst($block->{'Type'}) } =$block->{'Name'};
#				 } else {
#				 	say '';
#				 }
				--$block_nest_counter;
			};
#    CONTINUE statement			
			$line=~/^\s*(\d+)\s+continue/ && do {
				my $cont_label=$1;
				$info->{'Continue'}={'Label' => $cont_label};
				my $block = pop @blocks_stack;
				if (exists $block->{'Label'} ) {
					my $do_label =$block->{'Label'};
					if ($cont_label eq $do_label) {
#						say "\t" x $block_nest_counter,"END for block #$block_counter, NEST:".$block->{'Nest'}.' CONTINUE'." LABEL: ".$do_label;				 
						--$block_nest_counter;
					} else {
						push @blocks_stack, $block;
					}
				} else {
					push @blocks_stack, $block;
				}
			};
			# --------------------------------------------------------------------------------
			# END of BLOCK identification code			
			# --------------------------------------------------------------------------------
						
			if ( $line =~ /implicit\s+none/ ) {
				$info->{'ImplicitNone'} = 1;
				$Sf->{'ImplicitNone'}   = $index;
				$srcref->[$index] = [ $line, $info ];
				next;
			} elsif ( $line =~ /^\s*use\s+(\w+)/ ) {
				my $module = $1;
				$info->{'Use'} = $module;
				$srcref->[$index] = [ $line, $info ];
				next;
				
			} elsif ( $line =~ /implicit\s+/ ) {
				$info->{'Implicit'} = 1;
				$stref = _parse_implicit( $line, $f, $stref );
				$srcref->[$index] = [ $line, $info ];
				next;				
#    Arithmetic, logical, statement label (ASSIGN), and character assignment statements				
			} elsif ($line=~/^\s*\d*\s+assign\s+(\w+)\s+to\s+(\w+)/) {				
				$info->{'Assign'}={'Label' => $1, 'Var' => $2};			
#    BACKSPACE, ENDFILE statements			
			} elsif ($line=~/(backspace|endfile)/) {
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
				warn uc($keyword)." is ignored!" if $W;
#    STOP and PAUSE statements		
			} elsif ($line=~/^\s*\d*\s+(return|stop|pause)/) {	
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
#	 SELECT/CASE 
			} elsif ($line=~/select\s+case\s+\((\w+)\)/) {
					$info->{'CaseVar'} = $1;
				} elsif ($line=~/case\s+\((.+)\)\s*$/) {
					my $case_vals_str = $1;
					my @case_vals = _parse_comma_sep_expr_list($case_vals_str);
					$info->{'CaseVals'} = [@case_vals];				
				} elsif ($line=~/case\s+\default/) {
					$info->{'CaseDefault'} = 1;			
			} elsif ( $line =~ /^\s*\d*\s+else\s*$/ ) {			 	
					$info->{'Else'} = 1;					
#    Block, Arithmetic and logical IF statements		
# st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
# END IF, END, or another logical IF statement.		
			} elsif ( $line =~ /^\s*\d*\s+(if|else\s+if)\s*\(/ ) {			 	
				my $keyword = $1;				
				if ( $line =~ /^\s*\d*\s+(else\s+if)/ ) {
					$info->{'ElseIf'} = 1;
				} else {
					$info->{ ucfirst($keyword) } = 1;	
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
				if ( $mline =~ /=/ ) { # Is this an assignment?
					$is_cond_assign = 1;
				}
				
#				if ( $line =~ /^\s*\d*\s+(?:else\s+)?if\s*\(.+=/ ) { # an IF with an equals sign
#					( my $if_cond, my $rest ) = _parse_if_cond_OLD($line);
#						$cond = $if_cond;
#						$cond=~s/if\s*\(\s*//;
#						$cond=~s/\s*\)\s*$//;
#						
#						
#					# So here we look at the part after the condition expression
#					if ($rest=~/\(/) { # There are parens so it could be a subroutine call
#					( my $maybe_lhs, my $maybe_rhs ) = _parse_array_access_or_function_call($rest,1);
#					if ( $maybe_rhs =~ /=/ ) { # Is this an assignment?
#						$mline                  = $rest;# "$maybe_lhs$maybe_rhs";
#							
#						$info->{'CondExecExpr'} = $mline;
#						$is_cond_assign         = 1;
#						$is_cond                = 1;
#					} else {
#						# Otherwise it is a subroutine call, but I guess it could also just be 'then' 
#						$mline = $rest;
#					}					
#					} elsif ($rest=~/=/) {
#						( my $maybe_lhs, my $maybe_rhs )=split(/\s*=\s*/, $rest);
#						croak "ASSIGN: LINE: $line => LHS <$maybe_lhs> RHS <$maybe_rhs>"  if $f eq 'init_domainfill' and $line=~/ran1.idummy/;	
#						$mline = "$maybe_lhs = $maybe_rhs";
#						$info->{'CondExecExpr'} = $mline;
#						$is_cond_assign         = 1;
#						$is_cond                = 1;					
#					}
#					
#				} elsif ( $line =~ /^(\s*\d*\s+)((?:else\s+)?if\s*\(.+)$/ ) { #  IF with either an executable statement or THEN
#					my $indent=$1;
#					my $rest_of_line=$2;
#					my $has_else=$rest_of_line=~/else\s+if/ ? 1 : 0;
#					$rest_of_line=~s/else\s+if/if/;
#					( my $if_cond, my $rest ) = _parse_if_cond_OLD($rest_of_line);
#					$cond = $if_cond;
#							$cond=~s/if\s*\(\s*//;
#					$cond=~s/\s*\)\s*$//;				
#					# remove spaces from condition							
#					my $conds = $cond;
#					$conds=~s/\s+//g if defined $cond;
#					$cond=$conds;
#					if ($has_else) {
#						$line = $indent.'else if ('.$conds.') '.$rest;
#					} else {
#						$line = $indent.'if ('.$conds.') '.$rest;
#					}
#					$is_cond = 1;
#				}
#				
				
#				if ( $is_cond_assign or $is_cond ) {
					
					# This part looks at the condition to get variables form it
#					$cond =~ s/[\(\)]+/ /g;
					my $ast = parse_expression($cond,  $info,  $stref,  $f);
					my $cond_vars =  get_vars_from_expression( $ast,{});
					$cond =~ s/\.(eq|ne|gt|ge|lt|le|and|or|not|eqv|neqv)\./ /g;
					my @chunks = split( /\W+/, $cond );
					my %vars_in_cond_expr = ();
					for my $mvar (@chunks) {
						next if $mvar eq '';
						next if $mvar =~ /^\d+$/;
						next
						  if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
						next if exists $F95_reserved_words{$mvar};
						$vars_in_cond_expr{$mvar} = 1;
					}
					$info->{'CondVars'} = {%vars_in_cond_expr};
					say Dumper($cond_vars);			
					say Dumper(%vars_in_cond_expr);
					
							
					next if $mline eq 'then';
#					if ( not $is_cond_assign ) {
#						$info->{'CondExecExpr'} = $rest;
#						$mline =~ s/if.+?$rest/$rest/;
#					}
#				}

			} 

# So in principle anything after this can come after IF (...) 

#    READ, WRITE, and PRINT statements			
			if ( $mline =~ /^\s*\d*\s+(read|accept|inquire|write|print)\s*\(/ ) {
				my $keyword = $1;
				$info->{ ucfirst($keyword) . 'Call' } = 1;
				$info->{'IO'}=1;
				$info = parse_read_write_print( $mline, $info, $stref, $f );
			} elsif ( $mline =~ /^\s*\d*\s+print\s+/ ) {
				$info->{'PrintCall'} = 1;
				$info->{'IO'}=1;
				$info = parse_read_write_print( $mline, $info, $stref, $f );
#    REWIND, OPEN, CLOSE statements				
			} elsif ( $mline =~ /^\s*\d*\s*(open|close|rewind)\s*\(/ ) {
				my $keyword = $1;
				$info->{ ucfirst($keyword) . 'Call' } = 1;
				$info->{'IO'}=1;
				if ( $keyword eq 'open' ) {
					my $ast = parse_Fortran_open_call($mline);
#					croak Dumper($ast) if $f eq 'boundcond_domainfill' and $mline=~/unitboundcond/;
					$info->{'Ast'} = $ast;

					if ( exists $ast->{'FileName'} ) {
						if ( exists $ast->{'FileName'}{'Var'}
							and $ast->{'FileName'}{'Var'} !~ /__PH/ )
						{
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
								$info->{'Vars'}{'Set'}{$mvar} = 1;
							}
						}
					}
					if ( exists $ast->{'UnitVar'} ) {
						$info->{'Vars'}{'Set'}{ $ast->{'UnitVar'} } = 1;
					}
					@{ $info->{'Vars'}{'List'} } = keys %{ $info->{'Vars'}{'Set'} };
				}
			
			} elsif ( $line =~ /^\s*\d*\s+end\s+(if|select|do)\s*/ ) {
# CLEARLY THIS CANNOT COME AFTER IF (...) so MOVE to before IF			
				my $keyword = $1;
				my $kw      = ucfirst($keyword);
				$info->{ 'End' . $kw } = {};
				if ( $kw eq 'Do' ) {
					$do_counter--;
					my $corresponding_do_info = pop @do_stack;
					$info->{'EndDo'} = $corresponding_do_info->{'Do'};
					delete $info->{'EndDo'}{'Label'};
#					carp "LINE in $f: $line ".Dumper($corresponding_do_info);
					my $do_label = $corresponding_do_info->{'Do'}{'Label'};					
					if (defined $do_label and $do_label ne 'LABEL_NOT_DEFINED') {						
						$Sf->{'DoLabelTarget'}{$do_label}='EndDo';
					}					
				}
			} elsif ( $line =~ /\b(subroutine|function|program|block)\b/ ) {

				( $Sf, $line, $info ) =
				  __parse_sub_func_prog_decls( $Sf, $line );

			} elsif (
				$line =~ /^\s*\d*\s*end\s+(subroutine|module|function|block\s+data)\s*(\w+)/ )
			{
				my $kw   = $1;
				my $name = $2;
				$info->{ 'End' . ucfirst($kw) } = { 'Name' => $name };
#    DO statement				
			} elsif ( $mline =~ /^\s*\d*\s+do\b/ or $mline =~ /^do\b/) {
#WV20150304: We parse the do and store the iterator and the range { 'Iterator' => $i,'Range' =>[$start,$stop]}
				my $do_stmt = $mline;
				my $label   = 'LABEL_NOT_DEFINED';
				if ( $do_stmt =~ /do\s+\d+/ ) {
					$do_stmt =~ s/^\s*\d*\s+do\s+(\d*)\s+//;
					my $label = $1;
				} else {
					$do_stmt =~ s/^\s*\d*\s+do\s+//;
					$do_stmt =~ s/^do\s+//;
				}

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
						next if exists $F95_reserved_words{$mvar};
						next
						  if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}
							  {'Set'}{$mvar};    # Means it's a function
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
				$do_counter++;
				push @do_stack, $info;
# This is an ASSIGNMENT and so can come after IF (...)				
			} elsif ( $mline !~ /::/
				&& $mline !~ /^\s*\d*\s+data\b/
				&& $mline !~ /\bparameter\b/
				&& $mline =~ /[\w\)]\s*=\s*[^=]/ ) {
					
					$info->{'Assignment'} = 1;
					my $free_form =  $Sf->{'FreeForm'};							
					$mline = __remove_blanks($mline,$free_form);
#					$line = __remove_blanks($line,$free_form);
#WV20150303: We parse this assignment and return {Lhs => {Varname, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
#croak "<$mline>" if $mline=~/data10/ and $f eq 'set';

					$info = _parse_assignment( $mline, $info, $stref, $f );
			}
  # Actual variable declaration line (F77)
  # In principle every type can be followed by '*<number>' or *(*) or (<number>)
  # F77 VarDecl
			elsif (
				(				
					$line =~
/\b(logical|complex|integer|real|double\s*precision|character)\s+([^\*]?.*)\s*$/
					or $line =~
/\b((?:logical|complex|integer|real|double\s*precision|character)\s*\(\d+\))([^\*]?.*)\s*$/

					or $line =~
/\b((?:logical|complex|integer|real|double\s*precision|character)\s*\*(?:\d+|\((?:\*|\w+)\)))\s+(.+)\s*$/
				)
				and $line !~ /^\s+\w+\s+function\s+/
			  ) {
				$type   = $1;
				$varlst = $2;

				( $Sf, $info ) = __parse_f77_var_decl( $Sf, $f, $line, $info, $type, $varlst );

		} elsif ( $line =~ /^\s+dimension/ ) {
			# DIMENSION
# Although a Dimension line is not a declaration, I will use it as such, so the var must be in DeclaredLocalVars/DeclaredCommonVars
				$info->{'Dimension'}=1;
				$type   = 'Unknown';
				$varlst = $line;
				$varlst =~s/^\s+dimension\s+//;			
				my $indent =$line;$indent=~s/\S.*$//;	
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
#							carp "$f => $subset" if $varname eq 'iacn11' and $f eq 'fs055';	 
								my $decl = dclone( $Sf->{'UndeclaredCommonVars'}{'Set'}{$varname} );
								$Sf->{'DeclaredCommonVars'}{'Set'}{$varname} = $decl;
								delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$varname};
								@{ $Sf->{'UndeclaredCommonVars'}{'List'} } =  grep { $_ ne $varname } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
								$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$varname] );
								
							}  						
#								$stmt_count=$Sf->{$subset}{'Set'}{$varname}{'StmtCount'};
#								$stmt_count++;
							
						}
						$type = $decl->{'Type'};
					}
#					say 'STMT COUNT : '.$varname.' : '.$subset.' : '.$Sf->{$subset}{'Set'}{$varname}{'StmtCount'};
					 my $vline = $indent."$type, $var_dim  :: $varname";
#					 if ($var_dim=~/\(2\*ivd003/) {
#					 	die $var_dim;
#					 } 
				( $Sf, my $info ) = __parse_f95_decl( $Sf, $vline, {'Dimension' => 1}, "$type, $var_dim", $varname );
#				say 'STMT COUNT : '.$varname.' : '.$subset.' : '.$stmt_count;#$Sf->{$subset}{'Set'}{$varname}{'StmtCount'};
				$Sf->{'DeclCount'}{$varname}++;
				$info->{'StmtCount'}{$varname}=$Sf->{'DeclCount'}{$varname};#$stmt_count;#$Sf->{$subset}{'Set'}{$varname}{'StmtCount'};
#				carp $info->{'StmtCount'}{$varname} if $varname eq 'ladn1d';
					push @{ $extra_lines{$index} }, [$indent."dimension $dline",$info];
				}
				next;

			# COMMON block processing for common blocks not in an include file
			# common /name/ x...
			# However, common/name/x is also valid, and even  common x, damn F77!
			# And in fact, so is common /name/ x,y, /name2/ w,z
			# Worse, the spec is COMMON [/[ cb ]/] nlist [[,]/[ cb ] / nlist ]
			# so  x//y is also OK and //x also ... 
		} elsif ( $line =~ /^\s*common\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ or 
				$line =~ /^\s*(common)\s+(.+)$/ 
		 ) {
				my $common_block_name = $1; # means it will be 'common' for a blank block
				my $commonlst         = $2;
				$commonlst=~s/\/\//,/g;
				$commonlst=~s/^,//;         				
#				say "COMMON for $f: $commonlst"; 
				( my $parsedvars, my $parsedvars_lst ) = f77_var_decl_parser( $commonlst, 0 );
#				say Dumper($parsedvars);
				for my $var ( @{$parsedvars_lst} ) {	
#					my $subset;
					$Sf->{'Commons'}{$var} = $var;
					if ( not in_nested_set( $Sf, 'Vars', $var ) ) {    # This means that it is an undeclared common
							print "INFO: common <", $var, "> typed via Implicits for $f\n" if $I;
							my @type_kind_attr =
							  type_via_implicits( $stref, $f, $var );
							( my $type, my $array_or_scalar, my $attr ) =
							  @type_kind_attr;
							my $indent = ' ' x 6;
							my $decl   = {
								'IODir'  => 'Unknown',
								'Indent' => $indent,
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
				} # for loop 
				
				$info->{'Common'} = { 'Name' => $common_block_name };
#				croak Dumper($info);
		 } elsif ($line=~/^\s*\d*\s+data\b/) {
		 	# DATA
		 	$info->{'Data'} = 1; 
		 	$line.=' ! Parser line '.__LINE__.' : removed spaces from data';
		 	my @chunks = split(/\//,$line);
		 	$chunks[1]=~s/\s+//g;
		 	$line=join('/',@chunks);
#			$line = _expand_repeat_data($line);		
				say "DATA declaration $line" if $V;
#				$extra_lines{$index}=_parse_data_declaration($line,$info, $stref, $f);
#				next;
		 	} elsif ($line=~/^\s*\d*\s+external\s+([\w,\s]+)/) {
		 		my $external_procs_str = $1;
		 		my @external_procs = split(/\s*,\s*/,$external_procs_str);
		 	# EXTERNAL
		 		$info->{'External'} = [ map {$_=>1} @external_procs];
		 		$Sf->{'External'}={ map {$_=>1} @external_procs };
		 	} elsif ($line=~/^\s*\d*\s+equivalence\s+/) {
		 	# EQUIVALENCE (IADN14(1), IADN15(1)), (RADN14(2),RADN15(2))
		 	$info->{'Equivalence'} = 1;
		} elsif ( $line =~ /^\s*(.*)\s*::\s*(.*?)\s*$/ ) {

				#
				# F95 VarDecl
				# F95 declaration, no need for refactoring
				$type   = $1;
				$varlst = $2;
				( $Sf, $info ) =
				  __parse_f95_decl( $Sf, $line, $info, $type, $varlst );

				$is_f77_vardecl = 0;
			} elsif ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ ) {    # F77-style parameters
				my $parliststr = $1;
				( $Sf, $info ) =
				  __parse_f77_par_decl( $Sf, $f, $line, $info, $parliststr );
				my $parname = $info->{'ParamDecl'}{'Names'}[0][0];
				my $par_record =
				  get_var_record_from_set( $Sf->{'Vars'}, $parname );
				if ( defined $par_record ) {
					my $subset = in_nested_set( $Sf, 'Vars', $parname )
					  ;    # if $parname =~/eps0/;
					$info->{'ParamDecl'}{'Type'} = $par_record->{'Type'};
					$Sf->{$subset}{'Set'}{$parname}{'Type'} =
					  $par_record->{'Type'};
				} else {
					( my $type, my $array_or_scalar, my $attr ) =
					  type_via_implicits( $stref, $f, $parname );
					$info->{'ParamDecl'}{'Type'} = $type;
					$Sf->{'LocalParameters'}{'Set'}{$parname} =
					  $info->{'ParamDecl'};
				}
				$Sf->{'LocalParameters'}{'Set'}{$parname} =
				  $info->{'ParamDecl'};
			}    # match var decls, parameter statements F77/F95

			$srcref->[$index] = [ $line, $info ];

		}    # Loop over lines

		# We sort the indices from high to low so that the insertions are at the correct index 
		for my $idx (sort {$b <=> $a} keys %extra_lines) {		
			$srcref = [@{$srcref}[0..$idx-1],@{ $extra_lines{$idx} },@{$srcref}[($idx+1) .. (scalar(@{$srcref})-1)] ]; 
		}
		$Sf->{'AnnLines'}=$srcref;
	} else {
		print "WARNING: NO AnnLines for $f ($sub_incl_or_mod)\n";
		croak "SOURCE for $f: " . Dumper($Sf);
# FIXME: if we can't find the source, we should search the include path, but not attempt to create a module for that source!
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

	#	local $V=1;

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
# Parse 'use' declarations in case the module is inlineable
#FIXME otherwise we don't? although maybe we should because the module can contain module-scoped variables etc.
# So maybe we need to parse all the stuff in a module except the subroutines, as that is done elsewhere
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
				
				if ( not exists $stref->{'Modules'}{$name}{'Status'}
					or $stref->{'Modules'}{$name}{'Status'} < $READ )
				{
					print $line, "\n" if $V;

					$stref = parse_fortran_src( $name, $stref );
				} else {
					print $line, " already processed\n" if $V;
				}
				if ( exists $stref->{'Modules'}{$name}{'Inlineable'} ) {
					$info->{'Use'}{'Inlineable'} = {};
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
				if ( exists $stref->{'Modules'}{$name} )
				{    # Otherwise it means it is an external module
					 # 'Parameters' here is OK because the include might contain other includes
					$Sf->{'IncludedParameters'} =
					  &append_to_set( $Sf->{'IncludedParameters'},
						$stref->{'Modules'}{$name}{'Parameters'} );
					# I think here I should 'inherit' UsedLocalVars from this module, i.e. any LocalVars in $name
					$Sf->{'UsedLocalVars'} = append_to_set( $Sf->{'UsedLocalVars'}, $stref->{'Modules'}{$name}{'LocalVars'} ); 	
										
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
}    # END of parse_includes()

# -----------------------------------------------------------------------------

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

	# All local variables in the parent subroutine
	my $varsref = get_vars_from_set( $Sf->{'Vars'} );

	# Occurence
	my $occsref  = {};
	my $itersref = {};

	# A map of every block in the parent
	my $blocksref =
	  { 'OUTER' =>
		  { 'AnnLines' => [], 'CalledSubs' => { 'List' => [], 'Set' => {} } } };

# 1. Process every line in $f, scan for blocks marked with pragmas.
# What this does is to separate the code into blocks (%blocks) and keep track of the line numbers
# The lines with the pragmas occur both in OUTER and the block

	( $stref, $blocksref ) = __separate_into_blocks( $stref, $blocksref, $f );

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

	( $occsref, $itersref ) =
	  @{ __find_vars_in_block( $blocksref, $varsref, $occsref ) };

# 4. Construct the subroutine signatures
# This happens before reparsing so the data structures for the Decls and Args are emtpty! So need to call the init here!
	$stref = __construct_new_subroutine_signatures( $stref, $blocksref, $occsref, $itersref, $varsref, $f );

	$stref = __reparse_extracted_subroutines( $stref, $blocksref );

	$blocksref = __find_called_subs_in_OUTER($blocksref);

	$stref = __update_caller_datastructures( $stref, $blocksref );

	return $stref;
}    # END of _separate_blocks()

# -----------------------------------------------------------------------------
sub __find_called_subs_in_OUTER {
	( my $blocksref ) = @_;
	for my $annline ( @{ $blocksref->{'OUTER'}{'AnnLines'} } ) {
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'SubroutineCall'} ) {
			push @{ $blocksref->{'OUTER'}{'CalledSubs'}{'List'} },
			  $info->{'SubroutineCall'}{'Name'};
			$blocksref->{'OUTER'}{'CalledSubs'}{'Set'}
			  { $info->{'SubroutineCall'}{'Name'} } = 1;
		}
	}
	return $blocksref;
}

# -----------------------------------------------------------------------------
# We need access to the info about the ACC pragma's here.
# As this comes after analyse_lines, I should use $info not regex!
sub _parse_subroutine_and_function_calls {
	( my $f, my $stref ) = @_;
	print "PARSING SUBROUTINE/FUNCTION CALLS in $f\n" if $V;

	my $pnid               = $stref->{'NId'};
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
	my $external_sub       = 0;

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

	  # Subroutine calls. Surprisingly, these even occur in functions! *shudder*
			if (   $line =~ /call\s+(\w+)\s*\((.*)\)/
				|| $line =~ /call\s+(\w+)\s*$/ )
			{
				my $name =
				  $1;    # The name of the called subroutine. The caller is $f
				my $argstr = $2 || '';
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

				$stref = add_to_call_tree( $name, $stref, $f );
				if ( not exists $stref->{'Subroutines'}{$name} ) {
					$stref->{'ExternalSubroutines'}{$name}{'Called'} = 1;

					# This is wrong, all I need to do is not parse this one.
					# But when I continue it breaks as there is no definition
					# Also check if it is intrinsic.
					#					croak "FIX INTRINSICS!";
					#					return $stref;
					$external_sub = 1;
				}				
				my $ast = parse_expression( "$name($argstr)", $info, $stref, $f );

				#				say Dumper($ast);
				( my $expr_args, my $expr_other_vars ) = get_args_vars_from_subcall($ast);

				#				say Dumper($expr_args);
				$info->{'CallArgs'}               = $expr_args;
				$info->{'ExprVars'}               = $expr_other_vars;
				$info->{'SubroutineCall'}{'Args'} = $info->{'CallArgs'};
				$info->{'SubroutineCall'}{'ExpressionAST'} = $ast;
				#croak Dumper($info) if $name eq 'getvdep' and $f eq 'calcpar';
				if ( $external_sub == 0 ) {
					my $Sname = $stref->{'Subroutines'}{$name};

					if ( exists $Sf->{'Translate'}
						and not exists $Sname->{'Translate'} )
					{
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

					if ( defined $Sname
						and not exists $Sf->{'CalledSubs'}{'Set'}{$name} )
					{
						if ( $sub_or_func_or_mod eq 'Subroutines' ) {
							$Sf->{'CalledSubs'}{'Set'}{$name} = 1;
							push @{ $Sf->{'CalledSubs'}{'List'} }, $name;
						} else {
							$Sf->{'Subroutines'}{$current_sub_name}
							  {'CalledSubs'}{'Set'}{$name} = 1;
							push @{ $Sf->{'Subroutines'}{$current_sub_name}
								  {'CalledSubs'}{'List'} }, $name;
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

#						say "STATE OF init:".Dumper($stref->{'Subroutines'}{'init'}{'AnnLines'}) ;
							$stref = parse_fortran_src( $name, $stref );
						}
					}
				} else {

					# An external sub
					$info->{'SubroutineCall'}{'IsExternal'} = 1;
				}
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
				  )
				{
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
# Identify the include file as containing params or commons.
# If it contains both, split and call the routine again.
# FIXME: This should be parsed exactly as any other file!
sub _get_commons_params_from_includes {
	( my $inc, my $stref ) = @_;
	my $Sincf  = $stref->{'IncludeFiles'}{$inc};
	my $srcref = $Sincf->{'AnnLines'};
	my $indent = '';

	if ( defined $srcref ) {

		#		$Sincf->{'Parameters'} = {} unless exists $Sincf->{'Parameters'};
		#		$Sincf->{'Parameters'}{'List'} = []
		#		  unless exists $Sincf->{'Parameters'}{'List'};
		#		$Sincf->{'Parameters'}{'Set'} = {}
		#		  unless exists $Sincf->{'Parameters'}{'Set'};

		#        my %vars = %{ $stref->{'IncludeFiles'}{$inc}{'Vars'} };

		if ( exists $Sincf->{'Vars'}{''} ) { croak "EMPTY VAR! in $inc" }
		my $has_pars    = 0;
		my $has_commons = 0;

		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			if ( $line =~ /^\!\s/ ) {
				next;
			}
			$line =~ /^(\s+).*/ && do { $indent = $1; };

			# COMMON block processing
			# common /name/ x...
			# However, common/name/x is also valid, damn F77!
			# And in fact, so is common /name/ x,y, /name2/ w,z 
			# TODO: this is now duplicated in the main parser, factor out and see if this version is not out of date
			if ( $line =~ /^\s*common\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ ) {
				my $common_block_name = $1;
				my $commonlst         = $2;
				$has_commons = 1;
				( my $parsedvars, my $parsedvars_lst ) =
				  f77_var_decl_parser( $commonlst, 0 );
				for my $var ( @{$parsedvars_lst} ) {
					my $subset = in_nested_set( $Sincf, 'Vars', $var );
		   #					croak $subset if $var eq 'drydepspec' and $inc eq 'includecom';
					if ( $subset eq '' ) {    # This means that it is an undeclared common
						if (
							exists $stref->{'Implicits'}{$inc}{ lc( substr( $var, 0, 1 ) ) } ){
							print "INFO: common <", $var,
							  "> typed via Implicits for $inc\n"
							  if $I;
							my @type_kind_attr = type_via_implicits( $stref, $inc, $var );
							( my $type, my $array_or_scalar, my $attr ) =
							  @type_kind_attr;
							my $indent = ' ' x 6;
							my $decl   = {
								'IODir'  => 'Unknown',
								'Indent' => $indent,
								'Type'   => $type,
								'Attr'   => $attr,
								'Dim'    => [ @{ $parsedvars->{$var}{'Dim'} } ],
								'Name'   => $var,
								'Status' => 1,
								'ArrayOrScalar' =>
								  $parsedvars->{$var}{'ArrayOrScalar'},
								  'CommonBlockName' => $common_block_name
							};
							$Sincf->{'Commons'}{$var} = $var;
							if (
								exists $Sincf->{'DeclaredOrigLocalVars'}{'Set'}
								{$var} )
							{

# What this means is that the include file contains declared variables that are in a common block.
# So we move them to DeclaredCommonVars
								$Sincf->{'DeclaredCommonVars'}{'Set'}{$var} =
								  $decl;
								$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{  'CommonBlockName'} = $common_block_name;
								delete $Sincf->{'DeclaredOrigLocalVars'}{'Set'}
								  {$var};
								@{ $Sincf->{'DeclaredOrigLocalVars'}{'List'} } =
								  grep { $_ ne $var }
								  @{ $Sincf->{'DeclaredOrigLocalVars'}
									  {'List'} };
								push
								  @{ $Sincf->{'DeclaredCommonVars'}{'List'} },
								  $var;
							} else {
								$Sincf->{'UndeclaredCommonVars'}{'Set'}{$var} =
								  $decl;
								  $Sincf->{'UndeclaredCommonVars'}{'Set'}{$var}{  'CommonBlockName'} = $common_block_name;
								push
								  @{ $Sincf->{'UndeclaredCommonVars'}{'List'} },
								  $var;
								say
"INFO: UNDECLARED COMMON VAR $var from $inc, was typed via implicit rules"
								  if $I;
							}

						} else {
							print "WARNING: common <", $var,
							  "> is not in {'IncludeFiles'}{$inc}{'Vars'}\n"
							  if $W;
						}
					} else { # Means the var is already declared. So just use the existing declaration
						$Sincf->{'Commons'}{$var} = $var;   # Because we should use 'Commons' only for tests!
						if ( exists $Sincf->{'DeclaredOrigLocalVars'}{'Set'}{$var} ) {
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var} = {
								%{
									$Sincf->{'DeclaredOrigLocalVars'}{'Set'}{$var}
								  }
							};
							
							delete $Sincf->{'DeclaredOrigLocalVars'}{'Set'}{$var};
							@{ $Sincf->{'DeclaredOrigLocalVars'}{'List'} } =
							  grep { $_ ne $var } @{ $Sincf->{'DeclaredOrigLocalVars'}{'List'} };
							push @{ $Sincf->{'DeclaredCommonVars'}{'List'} }, $var;
							my $dim = $Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'Dim'};    # FIXME GET FROM Set
							my $updated_dim =
							  scalar @{$dim} == 0
							  ? $parsedvars->{$var}{'Dim'}
							  : $dim;
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'Dim'} = $updated_dim;
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'ArrayOrScalar'} = 'Array';
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{  'CommonBlockName'} = $common_block_name;
#							  croak "$inc => ".Dumper($Sincf->{'DeclaredCommonVars'}{'Set'}{$var}) if $var eq 'bdate';
						}  elsif (exists $Sincf->{'DeclaredCommonVars'}{'Set'}{$var} ) {
							# The var is declared and is a common var. Update the dim if required
							my $dim =
							  $Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'Dim'};    # FIXME GET FROM Set
							my $updated_dim =
							  scalar @{$dim} == 0
							  ? $parsedvars->{$var}{'Dim'}
							  : $dim;
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'Dim'} = $updated_dim;
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'ArrayOrScalar'} = 'Array';
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{  'CommonBlockName'} = $common_block_name;
						}  elsif (exists $Sincf->{'UndeclaredCommonVars'}{'Set'}{$var} ) {
							# The variable is in UndeclaredCommonVars, means it was actually typed via implicits
							# I guess I just do nothing?
							say "INFO: UndeclaredCommonVars in $inc: $var" if $I;	
						} else {
							croak "SHOULD BE IMPOSSIBLE! $var in $inc ".Dumper(in_nested_set($Sincf,'Vars',$var));

						}
					}
				}
				$srcref->[$index][1]{'Common'} =
				  { 'Name' => $common_block_name };
			}

			# TODO: also, why is this not the same code as above? Refactor!
			#  parameter(ip=150,jp=150,kp=90)
			if ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ ) {

				my $parliststr = $1;
				$has_pars = 1;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) }
				  @partups;    # Perl::Critic, EYHO # s/\s*=.+//; $_
				my @var_vals =
				  map { ( my $k, my $v ) = split( /\s*=\s*/, $_ ); [ $k, $v ] }
				  @partups;    # Perl::Critic, EYHO
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
				my @pars  = ();
				my $type  = 'Unknown';

				for my $var (@pvarl) {

					if (    not defined $Sincf->{'Vars'}{$var}
						and not
						exists $Sincf->{'LocalParameters'}{'Set'}{$var} )
					{
						print
"WARNING: PARAMETER $var not declared in $inc (Parser::_get_commons_params_from_includes)\n"
						  if $W;
					}

	   # These are early-on checks for constants as that is the most common case
					if ( $pvars{$var} =~ /^\-?\d+$/ ) {
						$type = 'integer';
					} elsif ( $pvars{$var} =~
						/^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/ )
					{
						$type = 'real';
					}
					$Sincf->{'LocalParameters'}{'Set'}{$var} = {
						'Type'      => $type,
						'Var'       => $Sincf->{'Vars'}{$var},
						'Val'       => $pvars{$var},
						'Indent'    => $indent,
						'Attr'      => '',
						'Dim'       => [],
						'Parameter' => 'parameter',
						'Name'      => [ $var, $pvars{$var} ],
					};
					push @pars, $var;
				}
				@{ $Sincf->{'LocalParameters'}{'List'} } =
				  ( @{ $Sincf->{'LocalParameters'}{'List'} }, @pars );
				$srcref->[$index][1]{'ParamDecl'} = {
					'Indent'    => $indent,
					'Type'      => $type,
					'Attr'      => '',
					'Dim'       => [],
					'Parameter' => 'parameter',
					'Names'     => [@var_vals],
					'Status'    => 0
				};

				# F77-style parameters in include file
			} elsif ( $line =~ /,\s*parameter\s*.*?::\s*(\w+)\s*=\s*(.+?)\s*$/ )
			{    # F95-style parameters
				    # FIXME: use the combinator-based parser
				my $type = $line;
				$type =~ s/^\s+//;
				$type =~ s/\s*\:\:.*$//;
				my $parliststr = $1;
				$has_pars = 1;
				my @partups = split( /\s*,\s*/, $parliststr );
				my %pvars =
				  map { split( /\s*=\s*/, $_ ) } @partups;  # Perl::Critic, EYHO
				my @pvarl = map { s/\s*=.+//; $_ } @partups;
				my @pars = ();

				for my $var (@pvarl) {
					if ( not defined $Sincf->{'Vars'}{$var} ) {
						print
"WARNING: PARAMETER $var not declared in $inc (F95-style)\n"
						  if $W;
					} else {
						$Sincf->{'LocalParameters'}{'Set'}{$var} = {
							'Type' => $type,
							'Var'  => $Sincf->{'Vars'}{$var},
							'Val'  => $pvars{$var}
						};
						push @pars, $var;
					}
				}
				@{ $Sincf->{'LocalParameters'}{'List'} } =
				  ( @{ $Sincf->{'LocalParameters'}{'List'} }, @pars );
				$srcref->[$index][1]{'ParamDecl'} =
				  [@pars] && die 'BOOM!' . __LINE__;

			}

			$srcref->[$index] = [ $line, $info ];
		}    # loop over annlines

		if ($DBG) {
			print "\nCOMMONS for $inc:\n\n";
			for my $v ( sort keys %{ $Sincf->{'Commons'} } ) {
				print $v, "\n";
			}
		}

		# FIXME!
		# An include file should basically only contain parameters and commons.
		# If it contains commons, we should remove them!
		if ( $has_commons && $has_pars ) {
			print
"INFO: The include file $inc contains both parameters and commons, attempting to split out params_$inc.\n"
			  if $I;
			$Sincf->{'InclType'} = 'Both';
			$stref = __split_out_parameters( $inc, $stref );
			$has_pars = 0;

		# What we should do is split this split out parameters into params_$name
		# and include params_$name in $name
		} elsif ($has_commons) {
			$Sincf->{'InclType'} = 'Common';
		} elsif ($has_pars) {
			$Sincf->{'InclType'} = 'Parameter';
		} else {
			$Sincf->{'InclType'} = 'None';
		}

	}
	return $stref;
}    # END of get_commons_params_from_includes()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

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
			push @{$param_lines},
			  [ $line, { 'ParamDecl' => { %{ $info->{'ParamDecl'} } } } ]
			  ;    # split out parameters from 'Common' include file
			delete $srcref->[$index][1]
			  {'ParamDecl'};   # split out parameters from 'Common' include file
			$srcref->[$index][1]{'Comment'} = 1;
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
	$stref->{'IncludeFiles'}{"params_$f"}{'Parameters'} =
	  dclone( $stref->{'IncludeFiles'}{$f}{'Parameters'} );
	$stref->{'IncludeFiles'}{"params_$f"}{'Vars'}{'Subsets'}{'Parameters'} =
	  $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'};
	delete $stref->{'IncludeFiles'}{$f}{'Parameters'};
	delete $stref->{'IncludeFiles'}{$f}{'Vars'}{'Subsets'}{'Parameters'};

#	croak Dumper($stref->{'IncludeFiles'}{"params_$f"}{'Vars'})."\n\n".Dumper($stref->{'IncludeFiles'}{"$f"}{'Vars'});
#	croak Dumper( $stref->{'IncludeFiles'}{$f}{'Vars'});
	return $stref;
}    # END of __split_out_parameters

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
#		croak "Sorry, no support for combined implicit declarations, please split them over multiple lines -- or better, use proper typing!\n<$tline>";
	}
	
	my %implicit_type_lookup = ();
	if ( exists $stref->{'Implicits'} and exists $stref->{'Implicits'}{$f} ) {
		%implicit_type_lookup = %{ $stref->{'Implicits'}{$f} };
	}
	for my $line (@impl_rules) {
#say "IMPLICIT RULE: $line";
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
#        $array_or_scalar =~ s/\s*kind\s*=\s*//i;    # strip "kind="
#        $shape = [ '1', $array_or_scalar ];         # FIXME only works for 1-D array
#        $array_or_scalar  = 'Array';
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
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref )
	  ;    # This is not a misnomer as it can also be a module.
	my $Sf       = $stref->{$sub_or_func_or_mod}{$f};
	my $srcref   = $Sf->{'AnnLines'};
	my $in_block = 0;

	# Initial settings
	my $block = 'OUTER';

	for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
		my $line = $srcref->[$index][0];
		my $info = $srcref->[$index][1];

		if (   $line =~ /^\!\s+BEGIN\sSUBROUTINE\s(\w+)/
			or $line =~
			/^\!\s*\$(?:ACC|RF4A)\s+(?:Subroutine|KernelWrapper)\s+(\w+)/i )
		{
			$in_block = 1;
			$block    = $1;
			print "FOUND BLOCK $block\n" if $V;

			# Enter the name of the block in the metadata for the line
			$info->{'RefactoredSubroutineCall'}{'Name'} = $block;
			$info->{'SubroutineCall'}{'Name'}           = $block;
			delete $info->{'Comments'};
			$info->{'BeginBlock'}{'Name'} = $block;

			# Push the line with the pragma onto the list of 'OUTER' lines
			push @{ $blocksref->{'OUTER'}{'AnnLines'} },
			  [ "! *** Refactored code into $block ***", {} ];

		   # Push the line with the pragma onto the list of lines for the block,
		   # to be replaced by function signature
			push @{ $blocksref->{$block}{'AnnLines'} },
			  [
				"! *** Original code from $f starts here ***",
				{ 'RefactoredSubroutineCall' => { 'Name' => $block } }
			  ];

			$blocksref->{$block}{'BeginBlockIdx'} = $index;
			next;
		}
		if (   $line =~ /^\!\s+END\sSUBROUTINE\s(\w+)/
			or $line =~
			/^\!\s*\$(?:ACC|RF4A)\s+end\s(?:subroutine|kernelwrapper)\s(\w+)/i )
		{
			$in_block = 0;
			$block    = $1;

			# Push end-of-block pragma onto 'OUTER'
			push @{ $blocksref->{'OUTER'}{'AnnLines'} }, [ $line, {} ];

			# Push 'end' onto the list of lines for the block,
			push @{ $blocksref->{$block}{'AnnLines'} },
			  [ '      end subroutine ' . $block, $info ];

	 # Add info to %blocks.
	 #            push @{ $blocksref->{$block}{'Info'} }, $Sf->{'Info'}[$index];
	 #            $Sf->{'Info'}[$index]{'EndBlock'}{'Name'} = $block;
			$info->{'EndBlock'}{'Name'} = $block;
			$blocksref->{$block}{'EndBlockIdx'} = $index;
			next;
		}
		if ($in_block) {

			# Push the line onto the list of lines for the block
			push @{ $blocksref->{$block}{'AnnLines'} }, [ $line, $info ];

			# and the index onto Info in %blocks and $Sf
			#            push @{ $blocksref->{$block}{'Info'} }, $info;
			$info->{'InBlock'}{'Name'} = $block;
		} else {

			# Other lines go onto 'OUTER'
			push @{ $blocksref->{'OUTER'}{'AnnLines'} }, [ $line, $info ];
		}
		$srcref->[$index] = [ $line, $info ];
	}    # loop over annlines
	return ( $stref, $blocksref );
}    # END of __separate_into_blocks()

# -----------------------------------------------------------------------------
sub __create_new_subroutine_entries {
	( my $stref, my $blocksref, my $f ) = @_;

	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod}{$f};

	for my $block ( keys %{$blocksref} ) {

		#        say "\tBLOCK: $block";
		die "EMPTY block name $block" if $block eq '';
		next if $block eq 'OUTER';
		if ( not exists $stref->{'Subroutines'}{$block} ) {
			$stref->{'Subroutines'}{$block} = {};
			$stref->{'Subroutines'}{$block}{'Source'} =
			  "./$block.f95";    #$Sf->{'Source'};
		}

#        elsif ( exists $stref->{'Subroutines'}{$block}{'Translate'} ) {
#            if ( $stref->{'Subroutines'}{$block}{'Translate'} eq 'C' ) {
#                $stref->{'Subroutines'}{$block}{'Source'} = "./$block.f95";
#                $stref = add_to_C_build_sources( $block, $stref );
#            } else {
#                croak '!$acc translate ('
#                  . $block . ') '
#                  . $stref->{'Subroutines'}{$block}{'Translate'}
#                  . ": Only C translation through F2C_ACC is currently supported.\n";
#            }
#        }
		my $Sblock = $stref->{'Subroutines'}{$block};
		$Sblock->{'AnnLines'} =
		  [ @{ $blocksref->{$block}{'AnnLines'} } ];    # a copy
		my $line_id = 0;
		for my $annline ( @{ $Sblock->{'AnnLines'} } ) {
			$annline->[1]{'LineID'} = $line_id++;
		}

		$stref->{'SourceContains'}{"./$block.f95"}{'Set'}{$block} = 'Subroutines';
		push @{ $stref->{'SourceContains'}{"./$block.f95"}{'List'} }, $block;		  
		$Sblock->{'RefactorGlobals'} = 1;
		$stref->{'Subroutines'}{$block} = $Sblock;
		if ( $Sf->{'RefactorGlobals'} == 0 ) {
			$Sf->{'RefactorGlobals'} = 2;
		} else {

			#			die "$f => $block ".'BOOM!'.Dumper($Sf->{'RefactorGlobals'});
			print
			  "INFO: RefactorGlobals==1 for $f while processing BLOCK $block\n"
			  if $I;
		}

		$Sblock->{'Program'}     = 0;
		$Sblock->{'FStyle'}      = $Sf->{'FStyle'};
		$Sblock->{'FreeForm'}    = $Sf->{'FreeForm'};
		$Sblock->{'Recursive'}   = 0;
		$Sblock->{'Callers'}{$f} = [ $blocksref->{$block}{'BeginBlockIdx'} ];

	}
	return $stref;
}    # END of __create_new_subroutine_entries()

# -----------------------------------------------------------------------------
sub __find_vars_in_block {
	carp "This should use the same code as _analyse_variables";
	( my $blocksref, my $varsref, my $occsref ) = @_;
	my $itersref = {};
	for my $block ( keys %{$blocksref} ) {
		$itersref->{$block} = [];
		my @annlines = @{ $blocksref->{$block}{'AnnLines'} };
		my %tvars = %{$varsref};    # Hurray for pass-by-value!

		print "\nVARS in $block:\n\n" if $V;
		for my $annline (@annlines) {

			( my $tline, my $info ) = @{$annline};
			if ( exists $info->{'Do'} ) {
				my $iter = $info->{'Do'}{'Iterator'};
				push @{ $itersref->{$block} }, $iter;
				delete $tvars{$iter};

				# Bit of a hack: I simply join the range expressions
				#				$tline = join( ',', @{ $info->{'Do'}{'Range'} } );
				for my $var_in_do ( @{ $info->{'Do'}{'Range'}{'Vars'} } ) {
					if ( exists $tvars{$var_in_do} ) {
						print "FOUND $var_in_do\n" if $V;
						$occsref->{$block}{$var_in_do} = $var_in_do;
						delete $tvars{$var_in_do};
					}
				}
			} else {
				$tline =~ s/[\'\"].+?[\'\"]//
				  ; # FIXME: looks like a HACK and should never happen as we have the __PH__ approach in SrcReader
				for my $var ( sort keys %tvars ) {
					if ( $tline =~ /\b$var\b/ ) {
						print "FOUND $var\n" if $V;
						$occsref->{$block}{$var} = $var;
						delete $tvars{$var};
					}
				}
			}
		}
	}
	return [ $occsref, $itersref ];
}    # END of __find_vars_in_block()

# -----------------------------------------------------------------------------
# TODO: see if this can be separated into shorter subs
# FIXME 20150824: When this is called, there is nothing in Args
sub __construct_new_subroutine_signatures {
	( my $stref, my $blocksref, my $occsref, my $itersref, my $varsref, my $f )
	  = @_;

	#carp('__construct_new_subroutine_signatures:');
	#    local $V = 1;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref )
	  ;    # This is not a misnomer as it can also be a module.
	my $Sf     = $stref->{$sub_or_func_or_mod}{$f};
	my $srcref = $Sf->{'AnnLines'};

	my %args = ();

	for my $block ( keys %{$blocksref} ) {
		next if $block eq 'OUTER';

		my $Sblock = $stref->{'Subroutines'}{$block};

		$Sf = _initialise_decl_var_tables( $Sblock, $block, 0 );

		if ( not exists $Sblock->{'OrigArgs'} ) {
			croak 'BOOM!' . Dumper( $Sblock->{Args} );
			$Sblock->{'OrigArgs'} = { 'Set' => {}, 'List' => [] };
		}
		if ( not exists $Sblock->{'DeclaredOrigArgs'} ) {
			croak 'BOOM!';
			$Sblock->{'DeclaredOrigArgs'} = { 'Set' => {}, 'List' => [] };
		}
		if ( not exists $Sblock->{'LocalVars'} ) {
			croak 'BOOM!';
			$Sblock->{'LocalVars'} = { 'Set' => {}, 'List' => [] };
		}
		if ( not exists $Sblock->{'DeclaredOrigLocalVars'} ) {
			croak 'BOOM!';
			$Sblock->{'DeclaredOrigLocalVars'} = { 'Set' => {}, 'List' => [] };
		}
		print "\nARGS for BLOCK $block:\n" if $V;
		$args{$block} = [];

		# Collect args for new subroutine
		for my $var ( sort keys %{ $occsref->{$block} } ) {
			if ( exists $occsref->{'OUTER'}{$var} ) {
				print "$var\n" if $V;
				push @{ $args{$block} }, $var;
			}
			$Sblock->{'Vars'}{$var} = $varsref->{ $var
			  }; # FIXME: this is "inheritance, but in principle a re-parse is better?"
		}

		# We declare them right away
		$Sblock->{'DeclaredOrigArgs'}{'List'} = $args{$block};

		# Create Signature and corresponding Decls
		my $sixspaces = ' ' x 6;
		my $sig       = $sixspaces . 'subroutine ' . $block . '(';
		my $sigrec    = {};

		$sigrec->{'Args'}{'List'} = $args{$block};
		$sigrec->{'Args'}{'Set'}  = { map { $_ => {} } @{ $args{$block} } };
		$sigrec->{'Name'}         = $block;
		$sigrec->{'Function'}     = 0;

		for my $argv ( @{ $args{$block} } ) {
			$sig .= "$argv,";
			my $decl = get_f95_var_decl( $stref, $f, $argv );
			$decl->{'Indent'} .= $sixspaces;

			$Sblock->{'DeclaredOrigArgs'}{'Set'}{$argv} = $decl;
			push @{ $Sblock->{'DeclaredOrigArgs'}{'List'} }, $argv;
		}

		if ( @{ $args{$block} } ) {
			$sig =~ s/\,$/)/s;
		} else {
			$sig .= ')';
		}

		# Add variable declarations and info to line
		# Here we know the vardecls have been formatted.
		my $sigline =
		  shift @{ $Sblock->{'AnnLines'}
		  }; # This is the line that says "! *** Original code from $f starts here ***"

		for my $iters ( $itersref->{$block} ) {
			for my $iter ( @{$iters} ) {
				my $decl = get_f95_var_decl( $stref, $f, $iter );
				$Sblock->{'LocalVars'}{'Set'}{$iter}             = $decl;    #
				$Sblock->{'DeclaredOrigLocalVars'}{'Set'}{$iter} = $decl;
				push @{ $Sblock->{'DeclaredOrigLocalVars'}{'List'} }, $iter;

				#                 say Dumper($decl);
				unshift @{ $Sblock->{'AnnLines'} },
				  [
					emit_f95_var_decl($decl),
					{
						'VarDecl' => $decl,
						'Ann'     => '__construct_new_subroutine_signatures '
						  . __LINE__
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
					'VarDecl' => $decl,
					'Ann' => '__construct_new_subroutine_signatures ' . __LINE__
				}
			  ];
		}
		unshift @{ $Sblock->{'AnnLines'} }, $sigline;

		# Now also add include statements and the actual sig to the line

		$Sblock->{'AnnLines'}[0][1] = {};
		for my $inc ( keys %{ $Sf->{'Includes'} } ) {
			$Sblock->{'Includes'}{$inc} = 1;
			unshift @{ $Sblock->{'AnnLines'} },
			  [ "      include '$inc'", { 'Include' => { 'Name' => $inc } } ]
			  ;    # add new lines at the front

			$Sblock->{'Includes'}{$inc} = 1;
		}
		unshift @{ $Sblock->{'AnnLines'} },
		  [ $sig, { 'Signature' => $sigrec } ];

# And finally, in the original source, replace the blocks by calls to the new subs

		#        print "\n-----\n".Dumper($srcref)."\n-----";
		for my $tindex ( 0 .. scalar( @{$srcref} ) - 1 ) {
			if ( $tindex == $blocksref->{$block}{'BeginBlockIdx'} ) {
				$sig =~ s/subroutine/call/;
				$srcref->[$tindex][0] = $sig;

# Here we also need to update the $info
#                croak Dumper( $sigrec)."\n\n".Dumper($srcref->[$tindex]).$tindex;
				$srcref->[$tindex][1]{'SubroutineCall'} = $sigrec;
				$srcref->[$tindex][1]{'LineID'} = $Sblock->{'Callers'}{$f}[0];
			} elsif ( $tindex > $blocksref->{$block}{'BeginBlockIdx'}
				and $tindex <= $blocksref->{$block}{'EndBlockIdx'} )
			{
				$srcref->[$tindex][0] = '';
				$srcref->[$tindex][1]{'Deleted'} = 1;
			}
		}

#        unshift @{ $Sblock->{'Info'} }, $fl; # put the comment back at the front, no change to the lines

		#        $Sblock->{'AnnLines'}[0][1] = $fal;

		#		print "YES! GENERATED DECLS ARE WRONG!!!\n";die;
		if ($V) {
			print 'SIG:' . $sig, "\n";

			#			print join( "\n", @{$decls} ), "\n";
		}
		$Sblock->{'Status'} = $READ;

		#die 'BOOM:'.Dumper($Sblock->{'AnnLines'});
		#		carp 'DeclaredOrigArgs:'.Dumper($Sblock->{'DeclaredOrigArgs'});
	}

	return $stref;
}    # END of __construct_new_subroutine_signatures()

# -----------------------------------------------------------------------------
sub __reparse_extracted_subroutines {
	( my $stref, my $blocksref ) = @_;
	delete $blocksref->{'OUTER'};
	for my $block ( keys %{$blocksref} ) {
		say "REPARSING $block" if $V;
		$stref = parse_fortran_src( $block, $stref );
	}
	return $stref;
}

# -----------------------------------------------------------------------------
sub __update_caller_datastructures {
	( my $stref, my $blocksref ) = @_;

	#	delete $blocksref->{'OUTER'};
	# Create new CalledSubs for $f

	for my $block ( keys %{$blocksref} ) {
		croak "There can only be one caller for a factored-out subroutine"
		  if scalar keys %{ $stref->{'Subroutines'}{$block}{'Callers'} } != 1;

		for my $f ( keys %{ $stref->{'Subroutines'}{$block}{'Callers'} } )
		{    # There can only be one caller for $block
			if ( $block eq 'OUTER' ) {
				$stref->{'Subroutines'}{$f}{'CalledSubs'} =
				  $blocksref->{'OUTER'}{'CalledSubs'};
			} else {

				# Add $block to CalledSubs in $f
				$stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$block} = 1;
				carp
"FIXME: Incorrect because there might be subs in $f called after $block";

# What we need to do is put a marker in CalledSubs when we encounter the pragma, and not register any subcalls in the region!!!
				push @{ $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'} },
				  $block;
			}
		}
	}
	return $stref;
}    # END of __update_caller_datastructures()

# -----------------------------------------------------------------------------
sub _split_multivar_decls {
	( my $f, my $stref ) = @_;

	my $sub_incl_or_mod = sub_func_incl_mod( $f, $stref );

	my $Sf           = $stref->{$sub_incl_or_mod}{$f};
	my $annlines     = $Sf->{'AnnLines'};
	my $nextLineID   = scalar @{$annlines} + 1;
	my $new_annlines = [];
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		if ( exists $info->{'VarDecl'} and exists $info->{'VarDecl'}{'Names'} )
		{
			my @nvars = @{ $info->{'VarDecl'}{'Names'} };
			push @{ $info->{'Ann'} }, annotate( $f, __LINE__ );
			for my $var ( @{ $info->{'VarDecl'}{'Names'} } ) {
				my $rinfo_c = dclone($info);
				$rinfo_c->{'StmtCount'}={};
				$rinfo_c->{'StmtCount'}{$var}=$info->{'StmtCount'}{$var};
#				say $rinfo_c->{'StmtCount'}{$var};
				my %rinfo   = %{$rinfo_c};
				$rinfo{'LineID'} = $nextLineID++;
				my $subset = in_nested_set($Sf,'Vars',$var);

				my $dim = $Sf->{$subset}{'Set'}{$var}{'Dim'} // [];
				my $decl = {
					'Indent' => $info->{'VarDecl'}{'Indent'},
					'Type'   => $Sf->{$subset}{'Set'}{$var}{'Type'},
					'Attr'   => $info->{'VarDecl'}{'Attr'},
					'Dim'    => $dim,
					'Name'   => $var
					, # This is of course redundant, but it is used in $info->{'VarDecl'}
					'IODir'  => [],
					'Status' => 0
				};
				$rinfo{'VarDecl'} = $decl;
				my $rline = $line;
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
						'Indent' => $info->{'ParamDecl'}{'Indent'},
						'Type' => $Sf->{'LocalParameters'}{'Set'}{$var}{'Type'},
						'Attr' => '',
						'Dim'  => [],
						'Parameter' => 'parameter',
						'Name'      => [ $var, $val ],
						'Val'       => $val,             # backwards comp
						'Var'       => $var,             # backwards comp
						'Status'    => 1,
					};

					$Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;
					$rinfo{'ParamDecl'} = $Sf->{'LocalParameters'}{'Set'}{$var};

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

	#     if ($f eq 'includepar') {
	#         say show_annlines($stref->{$sub_incl_or_mod}{$f}{AnnLines});
	#         die;
	#     }
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

	if (   $line =~ /^\s*subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*recursive\s+subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*(?:\w+\s+)*[\w\(\)\*]+\s+function\s+(\w+)\s*\((.*)\)/		
		or $line =~ /^\s*function\s+(\w+)\s*\((.*)\)/ )
	{
		my $name   = $1;
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
		my $name = $1;
		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Args'}{'Set'}  = {};
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Function'}     = 0;
	} elsif ( $line =~ /^\s*program\s+(\w+)\s*$/ ) {
		# If it's a program, there are no arguments
		my $name = $1;

		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Program'}      = 1;
	} elsif ( $line =~ /^\s*block\s+data/ ) { 
		my $name = 'block_data';
		if ( $line =~ /^\s*block\s+data\s+(\w+)\s*/ ) {
			$name=$1;
		}
		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'BlockData'}      = 1;				
	}
	return ( $Sf, $line, $info );
}    # END of __parse_sub_func_prog_decls()

# -----------------------------------------------------------------------------
sub __handle_acc {
	( my $stref, my $f, my $index, my $line, my $info ) = @_;
	my $accline = $line;
	$accline =~ s/^\!\s*\$(?:ACC|RF4A)\s+//i;
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
	$info->{'AccPragma'}{ $pragma_name_prefix . ucfirst( lc($pragma_name) ) } =
	  [@pragma_args];
	if (    $pragma_name =~ /KernelWrapper/i
		and $pragma_name_prefix eq 'Begin' )
	{
		$stref->{'KernelWrappers'}{ $pragma_args[0] }
		  { $pragma_name_prefix . ucfirst( lc($pragma_name) ) } =
		  [ $f, $index ];
		$stref = outer_loop_start_detect( $pragma_args[0], $stref );
	}
	return ( $stref, $info );
}    # END of __handle_acc()

# -----------------------------------------------------------------------------
sub __parse_f95_decl {
	# F95 VarDecl
	# F95 declaration, no need for refactoring
	#                $type   = $1;
	#                $varlst = $2;
	( my $Sf, my $line, my $info, my $type, my $varlst ) = @_;
	my $indent = $line;
	$indent =~ s/\S.*$//;
#	say "LINE:<$line>";
	my $pt = parse_F95_var_decl($line);

	# But this could be a parameter declaration, with an assignment ...
	if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+\s*=\s*.+?)\s*$/ ) {    
		# F95-style parameters
		$info->{'ParsedParDecl'} = $pt; #WV20150709 currently used by OpenCLTranslation, TODO: use ParamDecl
		
		my $parliststr = $1;
		my $var        = $pt->{'Pars'}{'Var'};
		my $val        = $pt->{'Pars'}{'Val'};
		my $type       = $pt->{'TypeTup'};

		my $pars_in_val = ___check_par_val_for_pars($val);

		my $param_decl = {
			'Indent'    => $indent,
			'Type'      => $type,
			'Attr'      => '',
			'Dim'       => [],
			'Parameter' => 'parameter',
			'Names'     => [ [ $var, $val ] ],
			'Status'    => 0
		};    # F95-style
		$info->{'ParamDecl'}      = $param_decl;
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
			$info->{'ParsedVarDecl'} = $pt;
			$info->{'VarDecl'} = {
				'Indent' => $indent,
				'Names'  => $pt->{'Vars'},
				'Status' => 0
			};
			
			for my $tvar ( @{ $pt->{'Vars'} } ) {
				croak $line.Dumper($pt) unless defined $tvar;								
				my $decl = {};
#				if (exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$tvar} ) {
#					# Basically this means the var has been declared using Implicits. 
#					# This would actually not happen in F95 so I only need to guard against the 
#					# use of this parser for dimension lines. So in that case I don't need to do anything I think.
#				}
				$decl->{'Indent'}        = $indent;
				$decl->{'Type'}          = $pt->{'TypeTup'}{'Type'};
				$decl->{'ArrayOrScalar'} = 'Scalar';
				$decl->{'Dim'}           = [];
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
				}
				if ( $type =~ /character/ ) {
					if (exists $pt->{TypeTup}{'ArrayOrScalar'} ) {
					$decl->{'Attr'} = '(len='
					  . $pt->{TypeTup}{'ArrayOrScalar'} . ')';
					} elsif (exists $pt->{'Attributes'}{'Dim'}) {
						$decl->{'Attr'} = '(len='
					  . $pt->{'Attributes'}{'Dim'}[0] . ')';
					} else {
						say "WARNING: no length for character string $tvar" if $W;
						$decl->{'Attr'} = '(len=*)';
					}
				} elsif ( exists $pt->{'TypeTup'}{'Kind'} ) {
					$decl->{'Attr'} = '(kind=' . $pt->{'TypeTup'}{'Kind'} . ')';
				} else {
					$decl->{'Attr'} = '';
				}

				$decl->{'IODir'} = $pt->{'Attributes'}{'Intent'};
				$decl->{'Name'}=$tvar;
#				say Dumper($decl);
				# It is possible that at this point the variable had not been declared yet and we use implicit rules
				# Then we change it to declared.
				if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar} ) {					
					$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} = $decl;
					delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar};
					@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } =
					  grep { $_ ne $tvar }
					  @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
					$Sf->{'DeclaredOrigArgs'}{'List'} =
					  ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'},
						[$tvar] );
				} else { # A var decl must be unique, so it it's not a arg, it's a local
				
				# I added this check so that I can use the parser for variables that are declared using implicit rules 
				# All this does is update the var entry
					if (exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$tvar} ) {
						$Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$tvar} = $decl;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} }, $tvar;
						} 
					} elsif	(exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} ) {
						$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} = $decl;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} }, $tvar;
						} 						
					} elsif (exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) {
						my $common_block_name = $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} = $decl;
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'} = $common_block_name;
							my @test=grep {$_ eq $tvar}  @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
							if ( scalar @test == 0) { 
								push @{ $Sf->{'UndeclaredCommonVars'}{'List'} }, $tvar;
							} 
					} elsif (exists $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} ) {
						my $common_block_name = $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
						$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} = $decl;
						$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'} = $common_block_name;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'DeclaredCommonVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'DeclaredCommonVars'}{'List'} }, $tvar;
						} 						 
					} else {
						my $subset =in_nested_set($Sf,'Vars',$tvar);
						if ($subset ne '') {
							carp "LINE $line: $tvar in subset $subset of Vars";
						} else {
						say "INFO: $line: $tvar does not have a record in Vars" if $I;
						}
					}
					
				}
			}
		}
	}
	return ( $Sf, $info );

}    # END of __parse_f95_decl()

# -----------------------------------------------------------------------------

sub __parse_f77_par_decl {

	# F77-style parameters
	#                my $parliststr = $1;
	( my $Sf, my $f, my $line, my $info, my $parliststr ) = @_;
#say $line;
	my $indent = $line;
	my $type   = 'Unknown';
	$indent =~ s/\S.*$//;
	my @partups = _parse_comma_sep_expr_list( $parliststr ); 
	
	my %pvars =
	  map { split( /\s*=\s*/, $_ ) } @partups;    # Perl::Critic, EYHO
	my @var_vals =
	  map { ( my $k, my $v ) = split( /\s*=\s*/, $_ ); [ $k, $v ] }
	  @partups;                                   # Perl::Critic, EYHO
	my @pvarl = map { s/\s*=.+//; $_ } @partups;
	my $pars = [];

	if ( not exists $Sf->{'LocalParameters'}{'List'} ) {
		croak 'BOOM!';
		$Sf->{'LocalParameters'}{'List'} = [];
	}
	if ( not exists $Sf->{'LocalParameters'}{'Set'} ) {
		croak 'BOOM!';
		$Sf->{'LocalParameters'}{'Set'} = {};
	}
	my $pars_in_val = {};
	for my $var (@pvarl) {

		croak if ref($var) eq 'ARRAY';
		if ( not in_nested_set $Sf, 'LocalVars', $var ) {
			if ( exists $pvars{$var} ) {

				my $val             = $pvars{$var};
				my $pars_in_val_tmp = ___check_par_val_for_pars($val);
				$type = 'Unknown';
				if ( $val =~ /^\-?\d+$/ ) {
					$type = 'integer';
				} elsif ( $val =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/ ) {
					$type = 'real';
				} else {
					for my $mpar ( keys %{$pars_in_val_tmp} ) {
						my $mpar_rec =
						  get_var_record_from_set( $Sf->{'Parameters'}, $mpar );

						#				 		croak Dumper($mpar_rec);
						$type = $mpar_rec->{'Type'};
					}
				}
				$pars_in_val = { %{$pars_in_val}, %{$pars_in_val_tmp} };
				$Sf->{'LocalParameters'}{'Set'}{$var} = {
					'Type' => $type,
					'Var'  => $var,
					'Val'  => $val,
				};
				print
				  "INFO: LOCAL PARAMETER $var infered type: $type $var = $val\n"
				  if $I;
				push @{$pars}, $var;

				#carp Dumper($Sf->{'LocalParameters'}{'Set'}{$var}) ;
			}
		} else {
			my $var_rec = get_var_record_from_set( $Sf->{'LocalVars'}, $var );
			$type = $var_rec->{'Type'};
			$Sf->{'LocalParameters'}{'Set'}{$var} = {
				'Type' => $type,
				'Var'  => $var,
				'Val'  => $pvars{$var},
			};

			my $val = $pvars{$var};
			$pars_in_val =
			  { %{$pars_in_val}, %{ ___check_par_val_for_pars($val) } };
			push @{$pars}, $var;
		}

#		croak Dumper($Sf->{'LocalParameters'}{'Set'}{$var}) if $var eq 'const' and $f eq 'richardson';
	}
	$info->{'UsedParameters'} = $pars_in_val;
	$info->{'ParamDecl'}      = {
		'Indent'    => $indent,
		'Type'      => $type,
		'Attr'      => '',
		'Dim'       => [],
		'Parameter' => 'parameter',
		'Names'     => [@var_vals],
		'Status'    => 0
	};
	;    # F77-style
	@{ $Sf->{'LocalParameters'}{'List'} } =
	  ( @{ $Sf->{'LocalParameters'}{'List'} }, @{$pars} );
	return ( $Sf, $info );

}    # END of __parse_f77_par_decl()

# -----------------------------------------------------------------------------

sub __parse_f77_var_decl {
	( my $Sf, my $f, my $line, my $info, my $type, my $varlst ) = @_;
# Now an ad hoc fix for spaces between the type and the asterisk. FIXME! I should just write a better FSM!
#croak $line if $line=~/double\s+precision/ and $f eq 'includecom';

	if ( $line =~ /\w+\s+(\*\s*(\d+|\(\s*\*\s*\)))/ )
	{    # FIXME: I assume after the asterisk there MUST be an integer constant
		my $len = $1;
		$type .= $len;
		$varlst =~ s/^\S+\s+//;
	}
	my $attr = '';
#	say "TYPE1: $line => $type;$attr" if $line=~/character.*lpi/;
	$type =~ /\*/ && do {
		( $type, $attr ) = split( /\*/, $type );
		if ( $attr eq '(' ) { $attr = '*' }
	};
#	say "TYPE2: $line => $type;$attr" if $line=~/character.*lpi/;
	$type =~ /\((\d+)\)/ && do {
		$attr = $1;
		( $type, my $rest ) = split( /\(/, $type );
	};
	$attr=~/\((\w+)\)/ && do { # FIXME: WEAK: in principle it can be a complete expression: character*(z+7*w-4)
		$attr = $1;
	};
#	say "TYPE3: $line => $type;$attr" if $line=~/character.*lpi/;
	my $indent = $line;
	$indent =~ s/\S.*$//;
	my $T = 0;
	( my $pvars, my $pvars_lst ) = f77_var_decl_parser( $varlst, $T );
	
	my @varnames = ();
	# Add type information to Vars
	for my $var ( @{$pvars_lst} ) {
		if ( $var eq '' ) { croak "<$line> in $f" }
		my $tvar = $var;
		if ( ref($var) eq 'ARRAY' ) { die __LINE__ . ':' . Dumper($var); }
		my $dim = $pvars->{$var}{'Dim'};
		my $stmt_count = 1;
		my $common_block_name='';
		# In all the cases below, we get the dimension from the record
		# Because I think it only happens for DIMENSION and COMMON lines.
		if (exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} ) {			
			my $tdim =dclone($Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar}{'Dim'});
			if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}			
#			$stmt_count = $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar}{'StmtCount'};
		} elsif (exists $Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar} ) {
			my $tdim =dclone($Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar}{'Dim'});
						if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
#			$stmt_count = $Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar}{'StmtCount'};
		} elsif (exists $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} ) { 
			my $tdim =dclone($Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'Dim'});
						if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
			$common_block_name = $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
#			$stmt_count = $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'StmtCount'};
		} elsif (exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) { 
			my $tdim =dclone($Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'Dim'});
						if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
			$common_block_name = $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
#			$stmt_count = $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'StmtCount'};
			
		}
		my $tvar_rec = {
			'Type'          => $type,
			'Dim'           => $dim,
			'ArrayOrScalar' => $pvars->{$var}{'ArrayOrScalar'},
			'Attr'			=> $pvars->{$var}{'Attr'},
			'IODir'         => 'Unknown',
#			'StmtCount'	=> $stmt_count,
		};
		if ( not exists $pvars->{$var}{'Attr'} ) {

			if ($attr) {
				if ( $type =~ /character/ ) {
					$tvar_rec->{'Attr'} = '(len=' . $attr . ')';
				} else {
					$tvar_rec->{'Attr'} = '(kind=' . $attr . ')';
				}
			} else {
				$tvar_rec->{'Attr'} = '';
			}
		} else {
			if ( $type =~ /character/ ) {
				$tvar_rec->{'Attr'} = '(len=' . $pvars->{$var}{'Attr'} . ')';
			} else {
				$tvar_rec->{'Attr'} = '(kind=' . $pvars->{$var}{'Attr'} . ')';
			}
		}

		# Take IODir from INTENT if it exists
		if ( $type =~ /\bintent\s*\(\s*(\w+)\s*\)/ ) {
			my $iodir = $1;
			$iodir = ucfirst($iodir);
			if ( $iodir eq 'Inout' ) {
				$iodir = 'InOut';
			}
			$tvar_rec->{'IODir'} = $iodir;
		}

		my $decl = {
			'Indent' => $indent,
			'Type'   => $type,
			'Attr'   => $tvar_rec->{'Attr'},
			'Dim'    => $dim,
			'Name'   => $tvar,
			'IODir'  => $tvar_rec->{'IODir'},
			'Status' => 0,
			'StmtCount'	=> $tvar_rec->{'StmtCount'},
		};
		if ($common_block_name ne '') {
			$decl->{'CommonBlockName'} = $common_block_name;
		}
#		carp Dumper($decl) if $var eq 'ladn11';
		push @varnames, $tvar;
		
# This is like before, when we encounter UndeclaredOrigArgs we make them DeclaredOrigArgs
		if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var} ) {
			$Sf->{'DeclaredOrigArgs'}{'Set'}{$var} = $decl;
			delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var}; # Regardless of what was there
			@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } = grep { $_ ne $var } @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
			$Sf->{'DeclaredOrigArgs'}{'List'} = ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'}, [$var] );
			$Sf->{'DeclaredOrigArgs'}{'Set'}{$var}{'StmtCount'}=1;
		} elsif ( exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var} ) {
			$Sf->{'DeclaredCommonVars'}{'Set'}{$var} = $decl;
			delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}; # Regardless of what was there
			@{ $Sf->{'UndeclaredCommonVars'}{'List'} } = grep { $_ ne $var } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
			$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$var] );
			$Sf->{'DeclaredCommonVars'}{'Set'}{$var}{'StmtCount'}=1;
			
		} else { # A var decl must be unique, so if it's not a arg, it's a local or a common
		
		# The var can be either DeclaredOrigLocalVars or DeclaredCommonVars. 
		# In both case we simply update the record
			my $subset = in_nested_set($Sf,'Vars',$var);
			if ($subset eq '') { # Var doesn't exist yet so it becomes DeclaredOrigLocalVars 
				$subset = 'DeclaredOrigLocalVars';
				push @{$Sf->{'DeclaredOrigLocalVars'}{'List'}}, $var;
			}
#			carp Dumper($decl) if $var eq 'ladn11';
			$Sf->{$subset}{'Set'}{$var} = $decl;
#			$info->{'StmtCount'}{$var}=$decl->{'StmtCount'};
=OLD		
		# I think this is not possible: even if we had a DIMENSION it would be DeclaredOrigLocalVars
			if ( exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var} ) {
				$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var} = $decl;
				delete $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var};
				@{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} } =
				  grep { $_ ne $var } @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} };
				$Sf->{'DeclaredOrigLocalVars'}{'List'} =
				  ordered_union( $Sf->{'DeclaredOrigLocalVars'}{'List'}, [$var] );					
			} else {
				# It could be an UndeclaredCommon!
				if (exists  $Sf->{'UndeclaredCommonVars'}{'Set'}{$var} ) {
						$Sf->{'DeclaredCommonVars'}{'Set'}{$var} = $decl;
				delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$var};
				@{ $Sf->{'UndeclaredCommonVars'}{'List'} } =
				  grep { $_ ne $var } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
				$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$var] );
				$Sf->{'ExGlobArgs'}{'Set'}{$var}=$decl;
#							push @{	$Sf->{'ExGlobArgs'}{'List'}},$var;				
				} else {
					$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var} = $decl;
					push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} }, $var;
				}
			}
=cut			
		}
		$Sf->{'DeclCount'}{$var}++;
		$info->{'StmtCount'}{$var} = $Sf->{'DeclCount'}{$var};
#		carp $info->{'StmtCount'}{$var} if $var eq 'ladn1d';
	}    # loop over all vars declared on a single line

	print "\tINFO: VARS <$line>:\n ", join( ',', sort @varnames ), "\n" if $I;

	$info->{'VarDecl'} = {
		'Indent' => $indent,
		'Names'  => \@varnames,
		'Status' => 0
	};

	push @{ $info->{'Ann'} },
	  annotate( $f, __LINE__ );   

#croak $line ." => VAR ff305:".Dumper($Sf->{'DeclaredOrigLocalVars'}{'Set'}{'ff305'}) if $line=~/ff305/ ;
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

sub parse_read_write_print {
	( my $line, my $info, my $stref, my $f ) = @_;

	my $call =
	    exists $info->{'ReadCall'}  ? 'read'
	  : exists $info->{'InquireCall'} ? 'inquire'
	  : exists $info->{'WriteCall'} ? 'write'
	  :                               'print';

	$info->{'CallAttrs'} = { 'Set' => {}, 'List' => [] };
	my $tline = $line;
#say "TLINE: $line";
	# Remove any labels
	if ( exists $info->{'Label'} ) {
		my $label = $info->{'Label'};
		$tline =~ s/^\s*$label\s+//;
	} elsif ( $tline =~ s/^(\s*)(\d+)(\s+)/$1$3/ ) {
		$info->{'Label'} = $2;
	}

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
		say "STRING CONST $tline";
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

	#croak Dumper($info) if $line=~/print/;
	return $info;
}    # END of parse_read_write_print()

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
		  . "' at line\n '"
		  . $tmp_line,
		  "' in subroutine/function '$f' in '"
		  . $stref->{'Subroutines'}{$f}{'Source'}
		  . "'\nThis is DANGEROUS, please fix your code!" if $W;
		$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'} = { $lhs_ast->[1] => 1 };
	}
	
#carp  "_parse_assignment($rhs)" if $line=~/fnamenc=path.+wfname/ and $f eq 'gridcheck';	
	my $rhs_ast = parse_expression( $rhs, $info, $stref, $f );

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

#croak  "_parse_assignment($tline)".Dumper($info) if $line=~/fnamenc=path.+wfname/ and $f eq 'gridcheck';

	#	my %test = map {$_ => 1}  @{ $info->{'Rhs'}{'VarList'}{'List'}};
	#	if (exists $test{'__PH0__'}) {croak Dumper($info)}
#	croak Dumper($line, $info) if $line=~/ff054/ ;

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
#	carp $line;

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
