package RefactorF4Acc::Parser;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::CallTree qw( add_to_call_tree );
use RefactorF4Acc::Refactoring::Common qw( emit_f95_var_decl get_f95_var_decl );
use RefactorF4Acc::Parser::SrcReader qw( read_fortran_src );
use RefactorF4Acc::Parser::Expressions qw(  parse_expression  get_args_vars_from_expression get_args_vars_from_subcall );
use RefactorF4Acc::CTranslation qw( add_to_C_build_sources );    # OBSOLETE
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_start_detect );
use RefactorF4Acc::Analysis::ArgumentIODirs qw(  &conditional_assignment_fsm );
  
use F95VarDeclParser qw( parse_F95_var_decl );
use FortranConstructParser  qw(
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
	( my $f, my $stref ) = @_
	  ;  # NOTE $f is not the name of the source but of the sub/func/incl/module

	#    local $V=1;
	print "parse_fortran_src(): PARSING $f\n " if $V;
#say 'INIT PRE:'.Dumper($stref->{'Subroutines'}{'init'}{'AnnLines'}) ; # OK!
## 1. Read the source and do some minimal processsing, unless it's already been done (i.e. for extracted blocks)
	$stref = read_fortran_src( $f, $stref );    #
	print "DONE read_fortran_src( $f )\n" if $V;
	my $sub_or_incl_or_mod = sub_func_incl_mod( $f, $stref );
	my $is_incl = $sub_or_incl_or_mod eq 'IncludeFiles';
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
		$Sf = _initialise_decl_var_tables( $Sf, $f, $is_incl );

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
		if ( not $is_incl ) {
			# Recursive descent via subroutine calls
			$stref = _parse_subroutine_and_function_calls( $f, $stref );
			$stref->{$sub_or_incl_or_mod}{$f}{'Status'} = $PARSED;
			print "DONE PARSING $sub_or_incl_or_mod $f\n" if $V;
#			say "AFTER PARSING $f:".Dumper($stref->{'Subroutines'}{'vertical'}{'AnnLines'}) ; croak if $f eq 'vertical';
		} else {    # includes
## 6. For includes, parse common blocks and parameters, create $stref->{'IncludeFiles'}{$inc}{'Commons'}
			$stref = _get_commons_params_from_includes( $f, $stref );
			$stref->{'IncludeFiles'}{$f}{'Status'} = $PARSED;			
		}

#            say 'parse_fortan_source: '. __LINE__.' : '. Dumper($stref->{'Subroutines'}{$f}{Vars}{indzindicator}) if $f eq 'particles_main_loop';

	   # 7. Split variable declarations with multiple vars into single-var lines
		$stref = _split_multivar_decls( $f, $stref );
		$stref = _split_multipar_decls_and_set_type( $f, $stref );

	} else {
		print "INFO: $f is EXTERNAL\n" if $I;
	}

	#    die 'HERE' if $f eq 'f_esl';
	#

	print
"LEAVING parse_fortran_src( $f ) with Status ".show_status($stref->{$sub_or_incl_or_mod}{$f}{'Status'})."\n"
	  if $V;
#	  say "AFTER $f:".Dumper($stref->{'Subroutines'}{'vertical'}{'AnnLines'}) ;
	return $stref;
	
}    # END of parse_fortran_src()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# parse_fortran_src() parses the source but does perform only limited context-free analysis
# This routine is recursive
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
			my $is_external_include =
			  $is_incl
			  ? ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'External' )
			  : 0;

			print "SRC TYPE for $f: $sub_or_incl_or_mod\n" if $V;
			if ( $sub_or_incl_or_mod ne 'ExternalSubroutines'
				and not $is_external_include )
			{

				## 5. Parse subroutine and function calls
				if ( not $is_incl ) {
					if ( $stref->{$sub_or_incl_or_mod}{$f}{'HasBlocks'} == 1 ) {
						$stref = _separate_blocks( $f, $stref );
					}

				}

			} else {
				print "INFO: $f is EXTERNAL\n" if $I;
			}

			#    die 'HERE' if $f eq 'f_esl';
			#

			print
"LEAVING refactor_marked_blocks_into_subroutines( $f ) with Status $stref->{$sub_or_incl_or_mod}{$f}{'Status'}\n"
			  if $V;
			  
#			  die Dumper($stref->{$sub_or_incl_or_mod}{$f}{'Vars'});
		}
	}
	return $stref;
}    # END of refactor_marked_blocks_into_subroutines()

# -----------------------------------------------------------------------------
# Here I initialise tables for Variables and Declarations and a few other Subroutine-specific data structures
sub _initialise_decl_var_tables { 
	( my $Sf, my $f, my $is_incl ) = @_;
say "_initialise_decl_var_tables for subroutine $f" if $V;

	if ( not exists $Sf->{'CalledSubs'} ) {
		$Sf->{'CalledSubs'} ={'List' => [], 'Set' => {} };
	}
# WV20151021 what we need here is a check that this function has not been called before for this $Sf
	if ( not exists $Sf->{'DoneInitTables'} ) {
say "_initialise_decl_var_tables : INIT TABLES for subroutine $f" if $V;
		# WV20151021 maybe need to do that for all subsets of Vars too?
		# WV20151021 the question is if this needs to be hierarchical?
		# Also, I think I wil use 'Subsets'
		$Sf->{'DeclaredOrigLocalVars'}   = { 'Set' => {}, 'List' => [] };
		$Sf->{'UndeclaredOrigLocalVars'} = { 'Set' => {}, 'List' => [] };
		
#		$Sf->{'Parameters'} = {};
		$Sf->{'LocalParameters'}  = { 'Set' => {}, 'List' => [] }; 
		$Sf->{'IncludedParameters'}  = { 'Set' => {}, 'List' => [] };		
#		if (exists $Sf->{'Container'}) {
			$Sf->{'ParametersFromContainer'}  = { 'Set' => {}, 'List' => [] };		
#		}

		if ( not $is_incl ) {
# WV: Maybe I should have an additional record 'FromInclude' in the set record!
			$Sf->{'ExGlobArgs'} = { 'Set' => {}, 'List' => []}; 
			$Sf->{'Globals'} = $Sf->{'ExGlobArgs'};    # WV: the original Globals is separated per include file
			$Sf->{'ExInclArgs'}         = { 'Set' => {}, 'List' => [] };
			$Sf->{'DeclaredOrigArgs'}   = { 'Set' => {}, 'List' => [] };
			$Sf->{'UndeclaredOrigArgs'} = { 'Set' => {}, 'List' => [] };

			$Sf->{'ExInclLocalVars'} = { 'Set' => {}, 'List' => [] };
			$Sf->{'OrigLocalVars'} = {
				'Subsets' => {
					'DeclaredOrigLocalVars' => $Sf->{'DeclaredOrigLocalVars'},
					'UndeclaredOrigLocalVars' =>
					  $Sf->{'UndeclaredOrigLocalVars'}
				}
			};
			$Sf->{'LocalVars'} = {
				'Subsets' => {
					'OrigLocalVars'   => $Sf->{'OrigLocalVars'},
					'ExInclLocalVars' => $Sf->{'ExInclLocalVars'}
				}
			};
			$Sf->{'OrigArgs'} = {
				'Subset' => {
					'UndeclaredOrigArgs' => $Sf->{'UndeclaredOrigArgs'},
					'DeclaredOrigArgs'   => $Sf->{'DeclaredOrigArgs'}
				},
				'List'=>[],
				'Set'=>{} # Stricty speaking we don't need this 
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
					'LocalParameters' => $Sf->{'LocalParameters'},
					'IncludedParameters' => $Sf->{'IncludedParameters'},
					'ParametersFromContainer' =>$Sf->{'ParametersFromContainer'}
				}
			};			
			$Sf->{'Vars'} = {
				'Subsets' => {
					'Args'      => $Sf->{'Args'},
					'LocalVars' => $Sf->{'LocalVars'},
					'Parameters' => $Sf->{'Parameters'}
				}
			};
			
		} else { # For includes

			# Includes can contain LocalVars, CommonVars or Parameters
			# Commons can't be Args so they will go in ExInclLocalVars?
			$Sf->{'Commons'}       = {};  # This is only for testing which vars are commons, nothing else.
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
					'UndeclaredOrigLocalVars' => $Sf->{'UndeclaredOrigLocalVars'}
				}
			};
			$Sf->{'LocalVars'} =
			  { 'Subsets' => { 
			  	'OrigLocalVars' => $Sf->{'OrigLocalVars'} 
			  } 
			};		
			
			$Sf->{'Parameters'} = {
				'Subsets' => {
					'LocalParameters' => $Sf->{'LocalParameters'},
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

		# While I'm at it, I might as well declare all declarations as well
		if ( not $is_incl ) {
			$Sf->{'ExGlobArgDecls'}     = $Sf->{'ExGlobArgs'};
			$Sf->{'ExInclArgDecls'}     = $Sf->{'ExInclArgs'};
			$Sf->{'ExImplicitArgDecls'} = $Sf->{'UndeclaredOrigArgs'};
			$Sf->{'OrigArgDecls'}       = $Sf->{'DeclaredOrigArgs'};
			
			$Sf->{'ExImplicitVarDecls'} = $Sf->{'UndeclaredOrigLocalVars'};
			$Sf->{'ExInclVarDecls'}     = $Sf->{'ExInclLocalVars'};
			$Sf->{'OrigVarDecls'} = $Sf->{'DeclaredOrigLocalVars'};
			
			# ExtraArgDecls
			$Sf->{'ExtraArgDecls'} = {
				'Subsets' => {
					'ExGlobArgDecls'     => $Sf->{'ExGlobArgDecls'},
					'ExInclArgDecls'     => $Sf->{'ExInclArgDecls'},
					'ExImplicitArgDecls' => $Sf->{'ExImplicitArgDecls'}

				}
			};

			# ArgDecls
			$Sf->{'ArgDecls'} = {
				'Subsets' => {
					'ExtraArgDecls' => $Sf->{'ExtraArgDecls'},
					'OrigArgDecls'  => $Sf->{'OrigArgDecls'}
				}
			};

			$Sf->{'ExtraVarDecls'} = {
				'Subsets' => {
					'ExImplicitVarDecls' => $Sf->{'ExImplicitVarDecls'},
					'ExInclVarDecls'     => $Sf->{'ExInclVarDecls'}
				}
			};

			# LocalVarDecls
			$Sf->{'LocalVarDecls'} = {
				'Subsets' => {
					'OrigVarDecls'  => $Sf->{'OrigVarDecls'},
					'ExtraVarDecls' => $Sf->{'ExtraVarDecls'}
				}
			};

			# Decls
			$Sf->{'Decls'} = {
				'Subsets' => {
					'ArgDecls'      => $Sf->{'ArgDecls'},
					'LocalVarDecls' => $Sf->{'LocalVarDecls'}
				}
			};
		} else {
			$Sf->{'ExtraVarDecls'} = {
				'Subsets' => {
					'ExImplicitVarDecls' => $Sf->{'ExImplicitVarDecls'},
					'ExInclVarDecls'     => $Sf->{'ExInclVarDecls'}
				}
			};

			# LocalVarDecls
			$Sf->{'LocalVarDecls'} = {
				'Subsets' => {
					'OrigVarDecls'  => $Sf->{'OrigVarDecls'},
					'ExtraVarDecls' => $Sf->{'ExtraVarDecls'}
				}
			};

			# Decls
			$Sf->{'Decls'} =
			  { 'Subsets' => { 'LocalVarDecls' => $Sf->{'LocalVarDecls'} } };

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
		print "\nVAR DECLS in $f:\n" if $V;
		my %vars = ();

		my $first          = 1;
		my $is_f77_vardecl = 0;
		my $type           = 'NONE';
		my $varlst         = '';
		my $indent         = '';
		my @do_stack       = ();
		my $do_counter     = 0;

		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $attr = '';
			( my $line, my $info ) = @{ $srcref->[$index] };
			$line =~ /^(\s+).*/ && do { $indent = $1; };
			
			$info->{'LineID'} = $index;

			if ( $line =~ /^\!\s+/ && $line !~ /^\!\s*\$(?:ACC|RF4A)\s/i ) {
				next;
			}
			my $mline = $line; # modifiable copy of $line
#			say "MLINE: $mline" ;
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

			if ( $line =~ /implicit\s+none/ ) {
				$info->{'ImplicitNone'} = 1;
				$Sf->{'ImplicitNone'}   = $index;
			} elsif ( $line =~ /^\s*use\s+(\w+)/ ) {
				my $module = $1;
				$info->{'Use'} = $module;
			} elsif ( $line =~ /implicit\s+/ ) {
				$info->{'Implicit'} = 1;
				$stref = _parse_implicit( $line, $f, $stref );
			} elsif ( $line =~ /^\d*\s+(else\s+if)/ ) {
				$info->{'ElseIf'} = 1;
			} elsif ( $line =~
				/^\d*\s+(if|else|select|case)\s*\(/
				or $line =~ /^\d*\s+(return|stop)\s*/ )
			{
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
				# Must parse at least the if statements here!
#				say $line if $line=~/^\s*if/;
				my $is_cond_assign=0;
				my $is_cond=0;
				my $cond=''; my $rest='';
			if ( $line =~ /^\s*if\s*\(.+=/) {
				(my $if_cond, my $rest)=_parse_if_cond($line);
#				say "IF_COND $if_cond REST $rest";
				(my $maybe_lhs, my $maybe_rhs)=_parse_array_access_or_function_call($rest);
#				say "LHS $maybe_lhs RHS <$maybe_rhs>";
				if ($maybe_rhs=~/=/) { #croak "COND ASSIGN: $maybe_lhs$maybe_rhs" } 
#					( $cond, my $lhs, my $sep, my $rhs ) = conditional_assignment_fsm($line);
					$mline = "$maybe_lhs$maybe_rhs";
					$info->{'CondExecExpr'} = $mline;	
					$is_cond_assign=1;
					$is_cond=1;
				} else {
					$mline=$rest;
				}
			}
			if ( $line =~ /^\s*if\s*\((.+)\)\s*(\w+)/ ) {					
					 $cond = $1;
					$rest = $2;
					$is_cond=1;
			}
			if ($is_cond_assign or $is_cond) {
					$cond =~ s/[\(\)]+/ /g; 
					$cond =~ s/\.(eq|ne|gt|ge|lt|le|and|or|not|eqv|neqv)\./ /g;
#					say "COND: $cond REST: $rest";
					my @chunks = split( /\W+/, $cond );
					my %vars_in_cond_expr=();
					for my $mvar (@chunks) {
						next if $mvar eq '';
						next if $mvar =~ /^\d+$/;
						next if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
						next if exists $F95_reserved_words{$mvar};
						$vars_in_cond_expr{ $mvar}=1;
					}
					$info->{'CondVars'}= { %vars_in_cond_expr };
					next if $rest eq 'then';
					if (not $is_cond_assign) {
					$info->{'CondExecExpr'} = $rest;										
					$mline=~s/if.+?$rest/$rest/;
					}			
#					croak "$line => $mline" if $line=~/=/; 		
# 
#    Arithmetic, logical, statement label (ASSIGN), and character assignment statements
#    Unconditional GO TO, assigned GO TO, and computed GO TO statements
#    Arithmetic IF and logical IF statements
#    CONTINUE statement
#    STOP and PAUSE statements
#    DO statement
#    READ, WRITE, and PRINT statements
#    REWIND, BACKSPACE, ENDFILE, OPEN, CLOSE, and INQUIRE statements
#    CALL and RETURN statements
				}
			}
				
			if ( $mline =~
				/^\d*\s+(read|write|print)\s*\(/
			) {
#				carp "MLINE2: $mline";
				my $keyword = $1;
				$info->{ ucfirst($keyword).'Call' } = 1;				
				$info = parse_read_write_print($mline, $info, $stref, $f);
#				carp "MLINE3: $mline";								
			} elsif ( $mline =~
				/^\d*\s*(open|close)\s*\(/
			) {
				my $keyword = $1;				
				$info->{ ucfirst($keyword).'Call' } = 1;
				if ($keyword eq 'open') {
					my $ast = parse_Fortran_open_call($mline);
					$info->{'Ast'} = $ast;

					if (exists $ast->{'FileName'} ) {
						if( exists $ast->{'FileName'}{'Var'} and $ast->{'FileName'}{'Var'} !~/__PH/) {
							$info->{'FileNameVar'} = $ast->{'FileName'}{'Var'}; # TODO: in principle almost any other field could be a var
							$info->{'Vars'}{'Set'}{$ast->{'FileName'}{'Var'}}=1;
						} elsif (exists $ast->{'FileName'}{'Expr'} ) {
							my $expr=$ast->{'FileName'}{'Expr'};
							if (exists $ast->{'FileName'}{'ExprVar'} ) {
								$expr=$ast->{'FileName'}{'ExprVar'}.$expr;
							}
							
							my @chunks =split(/\W+/,$expr);
							for my $mvar (@chunks) {
								next if $mvar eq '';
								next if $mvar =~ /^\d+$/;
								next if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
								next if $mvar=~/__PH\d+__/;
								next if exists $F95_reserved_words{$mvar};
								$info->{'Vars'}{'Set'}{$mvar}=1;
							}
#							croak "CHECK FOR VARS: $expr => ".Dumper($info->{'FileNameVars'});
						}
					}
					if (exists $ast->{'UnitVar'} ) {
						$info->{'Vars'}{'Set'}{$ast->{'UnitVar'}}=1; 
					}
					@{ $info->{'Vars'}{'List'} }= keys %{ $info->{'Vars'}{'Set'} };
#					say "MLINE AFTER OPEN: $mline";							
				}
										
			} elsif ( $line =~ /^\d*\s+end\s+(if|case|do)\s*/ ) {
				my $keyword = $1;
				my $kw      = ucfirst($keyword);
				$info->{ 'End' . $kw } = {};
				if ( $kw eq 'Do' ) {
					$do_counter--;
					my $corresponding_do_info = pop @do_stack;
					$info->{'EndDo'} = $corresponding_do_info->{'Do'};
					delete $info->{'EndDo'}{'Label'};
				}
			} elsif ( $line =~ /\b(subroutine|function|program)\b/ ){
				( $Sf, $line, $info ) =
				  __parse_sub_func_prog_decls( $Sf, $line );
				  
			} elsif (
				$line =~ /^\d*\s*end\s+(subroutine|module|function)\s*(\w+)/ )
			{
				my $kw   = $1;
				my $name = $2;
				$info->{ 'End' . ucfirst($kw) } = { 'Name' => $name };
			} elsif ( $mline =~ /^\d*\s+do\b/ ) {

#WV20150304: We parse the do and store the iterator and the range { 'Iterator' => $i,'Range' =>[$start,$stop]}
				my $do_stmt = $mline;
				my $label = 'LABEL_NOT_DEFINED';
				if ($do_stmt =~/do\s+\d+/) {
					$do_stmt =~ s/^\d*\s+do\s+(\d*)\s+//;
				my $label = $1;
				} else {
					$do_stmt =~ s/^\d*\s+do\s+//;
				}
				

				( my $iter, my $range ) = split( /\s*=\s*/, $do_stmt );
				( my $range_start, my $range_stop ) = split( /s*,\s*/, $range );
				my $mvars=[];
				for my $mchunk ($range_start, $range_stop ) {
							next if $mchunk =~/^\d+$/; 
							my @mchunks =();
							if ($mchunk=~/\W/) {
								 @mchunks = split( /\W+/, $mchunk );
							} elsif ($mchunk=~/^\w+$/) {
									push @mchunks,$mchunk 
							} else {
								croak "Unknown pattern $mchunk in Do Range";
							}
							for my $mvar (@mchunks) {				
								next if exists $F95_reserved_words{$mvar};
								next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar}; # Means it's a function
								next if $mvar =~ /^__PH\d+__$/;
								next if $mvar !~ /^[_a-z]\w*$/;
								push @{$mvars}, $mvar;
							}
#							carp "DO VARS: $mchunk =>".Dumper($mvars) if scalar(@{$mvars})>1;
						}
				$info->{'Do'} = {
					'Iterator' => $iter,
					'Label'    => $label,
					'Range'    => {'Expressions' => [ $range_start, $range_stop ], 'Vars' => $mvars},
					'LineID'   => $info->{'LineID'}
				};
				$do_counter++;
				push @do_stack, $info;
			} elsif ( $mline !~ /::/
				&& $mline !~ /\bparameter\b/
				&& $mline =~ /[\w\)]\s*=\s*[^=]/ )
			{
				
				$info->{'Assignment'} = 1;
#WV20150303: We parse this assignment and return {Lhs => {Varname, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
#say "WRONG LINE:".$line;
				$info = _parse_assignment($mline, $info, $stref, $f );				
			}

			# Actual variable declaration line (F77)
			# In principle every type can be followed by '*<number>' or *(*)
			# F77 VarDecl
			elsif (
				(
					$line =~
/\b(logical|integer|real|double\s*precision|character)\s+([^\*]?.*)\s*$/
					or $line =~
/\b((?:logical|integer|real|double\s*precision|character)\s*\*(?:\d+|\(\*\)))\s+(.+)\s*$/
				)
				and $line !~ /^\s+\w+\s+function\s+/
			  )
			{
				$type   = $1;
				$varlst = $2;
				
				( $Sf, $info ) =
				  __parse_f77_var_decl( $Sf, $f, $line, $info, $type, $varlst );
				
		#                 $is_f77_vardecl = 1; # Actual parsing happens later on
			} elsif ( $line =~ /^\s*(.*)\s*::\s*(.*?)\s*$/ ) {
# 
				# F95 VarDecl
				# F95 declaration, no need for refactoring
				$type   = $1;
				$varlst = $2;
				( $Sf, $info ) =
				  __parse_f95_decl( $Sf, $line, $info, $type, $varlst );

				$is_f77_vardecl = 0;
			} elsif ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ )
			{    # F77-style parameters
				my $parliststr = $1;
				( $Sf, $info ) =
				  __parse_f77_par_decl( $Sf, $f, $line, $info, $parliststr );
				  my $parname = $info->{'ParamDecl'}{'Names'}[0][0];
				  my $par_record=get_var_record_from_set($Sf->{'Vars'},$parname);
				  if (defined $par_record) {
				  	my $subset=in_nested_set($Sf,'Vars',$parname);# if $parname =~/eps0/;
				  	$info->{'ParamDecl'}{'Type'}=$par_record->{'Type'};
				  	$Sf->{$subset}{'Set'}{$parname}{'Type'}=$par_record->{'Type'};
				  } else {				  	
				  	(my $type,my $array_or_scalar,my $attr) = type_via_implicits( $stref,$f,$parname);
				  	$info->{'ParamDecl'}{'Type'}=$type;
				  	$Sf->{'LocalParameters'}{'Set'}{$parname}=$info->{'ParamDecl'};
#				  	croak 'TYPE VIA IMPLICITS!'.$parname.':'.Dumper($info->{'ParamDecl'});				  	
				  }
				  $Sf->{'LocalParameters'}{'Set'}{$parname}=$info->{'ParamDecl'};
			}    # match var decls, parameter statements F77/F95
			$srcref->[$index] = [ $line, $info ];
			
		}    # Loop over lines

	} else {
		print "WARNING: NO AnnLines for $f\n";
		die "SOURCE for $f: " . Dumper($Sf);

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
			
#			if ( $line =~ /^\s*include\s+\'([\w\.]+)\'/ ) {
			if ( exists $info->{'Includes'}) {	
#				my $name = $1;
				my $name = $info->{'Includes'};
				print "FOUND include $name in $f\n" if $V;
				$Sf->{'Includes'}{$name} = $index;

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
				
				if (exists $stref->{'IncludeFiles'}{$name}) { # Otherwise it means it is an external include
				# 'Parameters' her is OK because the include might contain other includes
				$Sf->{'IncludedParameters'} = &append_to_set($Sf->{'IncludedParameters'},$stref->{'IncludeFiles'}{$name}{'Parameters'});
#					$Sf->{'IncludedParameters'}	= $stref->{'IncludeFiles'}{$name}{'Parameters'};
##					$Sf->{'Parameters'}{'Subsets'}{'IncludedParameters'}=$stref->{'IncludeFiles'}{$name}{'Parameters'};
#					croak 'WHY IS THIS WRONG?'.Dumper($Sf->{'Parameters'}	) if $name eq 'includepar' and $f eq 'readcommand';
				}
			}
			$srcref->[$index] = [ $line, $info ];
		}
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

			if ( $line =~ /^\s*use\s+(\w+)/ ) {
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

					#				# Initial guess for Root. OK? FIXME?
					#				$stref->{'IncludeFiles'}{$name}{'Root'}      = $f;
					#				$stref->{'IncludeFiles'}{$name}{'HasBlocks'} = 0;
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
			}
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

This is some major refactoring, so why is it not in Refactoring/ ? 

=end markdown

=cut

#WV20150701 This routine is very early here and it is BROKEN: common block variables don't get declarations!
sub _separate_blocks {
	( my $f, my $stref ) = @_;

	#    local $V = 1;

#    die "separate_blocks(): FIXME: we need to add in the locals from the parent subroutine as locals in the new subroutine!";
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
	my $srcref             = $Sf->{'AnnLines'};

	#die Dumper($Sf);
	$Data::Dumper::Indent = 2;

	# All local variables in the parent subroutine
	my $varsref = get_vars_from_set( $Sf->{'Vars'} );

	# Occurence
	my $occsref  = {};
	my $itersref = {};

	# A map of every block in the parent
	my $blocksref = { 'OUTER' => { 'AnnLines' => [], 'CalledSubs' =>{'List'=>[], 'Set'=>{}} } };

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
	$stref =
	  __construct_new_subroutine_signatures( $stref, $blocksref, $occsref,
		$itersref, $varsref, $f );

	$stref = __reparse_extracted_subroutines( $stref, $blocksref );
	
	$blocksref = __find_called_subs_in_OUTER( $blocksref );
	
	$stref = __update_caller_datastructures( $stref, $blocksref );

#        my @callinfo = caller(0);
#        my $callinfostr=$callinfo[3];
#        say  $callinfostr .' '. __LINE__ .' : ' .Dumper($stref->{Subroutines}{particles_main_loop}{Vars}{indzindicator});

	#	warn "Vars are CORRECT AT END OF separate_blocks( $f ):\n-----\n";
	#	warn "-----\n";
	#	croak "BOOM!" if $f eq 'timemanager';
	#die Dumper($stref->{'Subroutines'}{'LES_kernel_wrapper'});
	
	return $stref;
}    # END of _separate_blocks()

# -----------------------------------------------------------------------------
sub __find_called_subs_in_OUTER { (my $blocksref)=@_;
	for my $annline ( @{ $blocksref->{'OUTER'}{'AnnLines'} } ) {
		(my $line, my $info) = @{$annline};
		if (exists $info->{'SubroutineCall'}) {
			push @{ $blocksref->{'OUTER'}{'CalledSubs'}{'List'}   },$info->{'SubroutineCall'}{'Name'};
			$blocksref->{'OUTER'}{'CalledSubs'}{'Set'}{$info->{'SubroutineCall'}{'Name'}}=1; 
		}
	} 
	return $blocksref;
}
# -----------------------------------------------------------------------------
# We need access to the info about the ACC pragma's here.
sub _parse_subroutine_and_function_calls {
	( my $f, my $stref ) = @_;
	print "PARSING SUBROUTINE/FUNCTION CALLS in $f\n" if $V;
	
	my $pnid               = $stref->{'NId'};
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
	my $external_sub=0;
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
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
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
					$external_sub=1;
				}
				my $ast= parse_expression("$name($argstr)",$info, $stref, $f);
#				say Dumper($ast);
				(my $expr_args,my $expr_other_vars)= get_args_vars_from_subcall($ast);
#				say Dumper($expr_args);
				$info->{'CallArgs'}=$expr_args;
				$info->{'ExprVars'}=$expr_other_vars;				 
				$info->{'SubroutineCall'}{'Args'}=$info->{'CallArgs'};
#				my $tvarlst = $argstr;
## replace , by ; in array indices and nested function calls FIXME: UGLY! USE PROPER FSM!
#				if ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
#					while ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
#						my $chunk  = $1;
#						my $chunkr = $chunk;
#						$chunkr =~ s/,/;/g;
#						my $pos = index( $tvarlst, $chunk );
#						substr( $tvarlst, $pos, length($chunk), $chunkr );
#					}
#				}
#
#				# now split on , FIXME: UGLY! USE PROPER FSM!
#				my @tvars = split( /\s*\,\s*/, $tvarlst );
#
#				# now replace ; by , FIXME: UGLY! USE PROPER FSM!
#				my @argvars = ();
#				for my $var (@tvars) {
#					$var =~ s/^\s+//;
#					$var =~ s/\s+$//;
#					$var =~ s/;/,/g;
#					push @argvars, $var;
#				}
#
#				$info->{'SubroutineCall'}{'Args'}{'List'} = \@argvars;
#				$info->{'SubroutineCall'}{'Args'}{'Set'} =
#				  { map { $_ => 1 } @argvars };
#				$info->{'SubroutineCall'}{'Name'} = $name;
				
#				die Dumper($info).$f;

			if($external_sub==0) {
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
						push @{ $Sf->{'CalledSubs'}{'List'}},$name;
					} else {
						$Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'Set'}
						  {$name} = 1;
						  push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'List'} },$name;
					}
					if (   not exists $Sname->{'Status'}
						or $Sname->{'Status'} < $PARSED
						or $gen_sub )
					{
						print "\tFOUND SUBROUTINE CALL $name in $f with STATUS=".show_status($Sname->{'Status'}).", PARSING\n" if $V;
#						say "STATE OF init:".Dumper($stref->{'Subroutines'}{'init'}{'AnnLines'}) ;
						$stref = parse_fortran_src( $name, $stref );
					}
				}
				} else {
					# An external sub
					$info->{'SubroutineCall'}{'IsExternal'}=1;
				}
			}

			# Maybe Function calls
			if (   $line !~ /function\s/
				&& $line !~ /subroutine\s/
				&& $line =~ /(\w+)\(/ )
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

					   # This means it's the first call to function $chunk in $f
						and not exists $Sf->{'CalledSubs'}{'Set'}{$chunk}
					  )
					{
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
							or $stref->{'Subroutines'}{$chunk}{'Status'} <
							$PARSED )
						{
							$stref = parse_fortran_src( $chunk, $stref );
						} else {
							$stref = add_to_call_tree( $chunk, $stref, $f );
						}

						if ( exists $Sf->{'Translate'}
							and not exists $stref->{'Subroutines'}{$chunk}
							{'Translate'} )
						{
							$stref->{'Subroutines'}{$chunk}{'Translate'} =
							  $Sf->{'Translate'};
						}

					}
				}
			}

			$srcref->[$index] = [ $line, $info ];
#			say "$index\t$line\t".Dumper($info) if $f eq 'vertical';
		}    # loop over all annlines

		#        $Sf->{'CalledSubs'}{'Set'}=\%called_subs;
		$stref->{$sub_or_func_or_mod}{$f}{'AnnLines'}=[@{$srcref}];
	}
	
#	die Dumper($srcref) if $f eq 'vertical';
#			croak Dumper($stref->{'Subroutines'}{'vertical'}{'AnnLines'}).';'.$sub_or_func_or_mod.' '.$f.' ' if $f eq 'vertical';
	return $stref;
}    # END of parse_subroutine_and_function_calls()

# -----------------------------------------------------------------------------

# This is required for the include analysis, so maybe I should put it there.
sub build_call_graph {
	( my $f, my $stref ) = @_;
	my $prevnid = $stref->{'NId'};    # previous NId
	if ( $prevnid == 0 ) {
		$stref->{'PNIds'} = [];
	}
	my $pnid = ( $prevnid > 0 ) ? $stref->{'PNIds'}[-1] : 0;

	#    print "BUILDING CALL GRAPH: in $f via parent $pnid to child ";# if $V;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	if ( $sub_or_func_or_mod ne 'ExternalSubroutines' ) {
		my $Sf = $stref->{$sub_or_func_or_mod}{$f};
		$stref->{'NId'}++;
		my $nid = $stref->{'NId'};

		#        say $nid;
		#die Dumper(    $stref->{'Nodes'} );
		$stref->{'Nodes'}{$nid} = {
			'Children'   => [],
			'Parent'     => $pnid,
			'Subroutine' => $f
		};
		push @{ $stref->{'Nodes'}{$pnid}{'Children'} }, [ $nid, $f ];

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

		  #                    say "\t".$info->{'LineID'}.':'.$called_sub_name ;
					push @{ $stref->{'PNIds'} }, $nid;
					$stref = build_call_graph( $called_sub_name, $stref );
					pop @{ $stref->{'PNIds'} };

					#                    say "back in $f";
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
			if ( $line =~ /^\s*common\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ ) {
				my $common_block_name = $1;
				my $commonlst         = $2;
				$has_commons = 1;
				( my $parsedvars, my $parsedvars_lst ) =
				  f77_var_decl_parser( $commonlst, 0 );
				for my $var ( @{$parsedvars_lst} ) {
					
					my $subset = in_nested_set( $Sincf, 'Vars', $var );
#					croak $subset if $var eq 'drydepspec' and $inc eq 'includecom';
					if ( $subset eq '' )
					{    # This means that it is an undeclared common
						if (
							exists $stref->{'Implicits'}{$inc}
							{ lc( substr( $var, 0, 1 ) ) } )
						{
							print "INFO: common <", $var,
							  "> typed via Implicits for $inc\n"
							  if $I;
							my @type_kind_attr =
							  type_via_implicits( $stref, $inc, $var );

				  #                              $stref->{'Implicits'}{$inc}
				  #                              { lc( substr( $var, 0, 1 ) ) };
							( my $type, my $array_or_scalar, my $attr ) =
							  @type_kind_attr;
							my $indent = ' ' x 6;
							my $decl   = {
								'IODir' => 'Unknown',
								'Indent' => $indent,
								'Type'   => $type,
								'Attr'   => $attr,
								'Dim'    => [ @{ $parsedvars->{$var}{'Dim'} } ],
								'Name'   => $var,
								'Status' => 1,
								'ArrayOrScalar' =>
								  $parsedvars->{$var}{'ArrayOrScalar'}
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
						if (
							exists $Sincf->{'DeclaredOrigLocalVars'}{'Set'}
							{$var} )
						{
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var} = {
								%{
									$Sincf->{'DeclaredOrigLocalVars'}{'Set'}
									  {$var}
								  }
							};
							delete $Sincf->{'DeclaredOrigLocalVars'}{'Set'}
							  {$var};
							@{ $Sincf->{'DeclaredOrigLocalVars'}{'List'} } =
							  grep { $_ ne $var }
							  @{ $Sincf->{'DeclaredOrigLocalVars'}{'List'} };
							push @{ $Sincf->{'DeclaredCommonVars'}{'List'} },
							  $var;
							my $dim = $Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'Dim'} ; # FIXME GET FROM Set
							my $updated_dim = scalar @{$dim} == 0 ? $parsedvars->{$var}{'Dim'} : $dim;							  
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}{'Dim'} = $updated_dim
							  ;
							$Sincf->{'DeclaredCommonVars'}{'Set'}{$var}
							  {'ArrayOrScalar'} = 'Array';
#							  croak "$inc => ".Dumper($Sincf->{'DeclaredCommonVars'}{'Set'}{$var}) if $var eq 'bdate';
						} else {
							croak "SHOULD BE IMPOSSIBLE!";

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
						and not exists $Sincf->{'LocalParameters'}{'Set'}{$var} )
					{
						print
"WARNING: PARAMETER $var not declared in $inc (Parser::_get_commons_params_from_includes)\n"
						  if $W;
					}
#					if ( $pvars{$var} =~ /^\d*/ ) {
#						$type = 'integer';
#					} elsif ( $pvars{$var} =~ /^[\d\.]+/ ) {    # FIXME: weak
#						$type = 'real';
#					}
					$Sincf->{'LocalParameters'}{'Set'}{$var} = {
						'Type' => $type,
						'Var'  => $Sincf->{'Vars'}{$var},
						'Val'  => $pvars{$var}
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
	my $Sf          = $stref->{'IncludeFiles'}{$f};
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
	$stref->{'IncludeFiles'}{$f}{'LocalParameters'}={'Set'=>{},'List'=>[]};
		
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


	$stref->{'IncludeFiles'}{$f}{'Includes'}{"params_$f"}=1;
	
	return $stref;
}    # END of __split_out_parameters

# -----------------------------------------------------------------------------
sub _parse_implicit {
	( my $line, my $f, my $stref ) = @_;

	# 1. test for compound, bail out
	my $tline = $line;
	while ( $tline =~ /\(/ ) {
		$tline =~ s/\(.+?\)//;
	}
	if ( $tline =~ /,/ ) {
		die
"Sorry, no support for combined implicit declarations, please split them over multiple lines -- or better, use proper typing!\n";
	}

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
				$attr = "(kind=$attr)";
			}
		}
		$patt =~ s/,/|/g;
		$patt =~ s/(\w\-\w)/[$1]/g;
	}

	# 3. Generate the lookup table
	my %implicit_type_lookup = ();
	if ( exists $stref->{'Implicits'} and exists $stref->{'Implicits'}{$f} ) {
		%implicit_type_lookup = %{ $stref->{'Implicits'}{$f} };
	}
	for my $c ( 'a' .. 'z' ) {
		if ( $c =~ /($patt)/ ) {
			$implicit_type_lookup{$c} = [ $type, $array_or_scalar, $attr ];
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

		$stref->{'SourceContains'}{"./$block.f95"}{$block} =
		  'Subroutines';                                # was $Sf->{'Source'}
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
sub __find_vars_in_block { carp "This should use the same code as _analyse_variables"; 
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
				for my $var_in_do (@{ $info->{'Do'}{'Range'}{'Vars'} } ) {
					if (exists $tvars{$var_in_do}) {
						print "FOUND $var_in_do\n" if $V;										
						$occsref->{$block}{$var_in_do} = $var_in_do;
						delete $tvars{$var_in_do};
					}
				}				
			} else {
				$tline =~ s/\'.+?\'//;    # FIXME: looks like a HACK!		
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
		

		if ( not exists $Sblock->{'OrigArgs'} ) { croak 'BOOM!'.Dumper($Sblock->{Args});
			$Sblock->{'OrigArgs'} = { 'Set' => {}, 'List' => [] };
		}
		if ( not exists $Sblock->{'DeclaredOrigArgs'} ) { croak 'BOOM!';
			$Sblock->{'DeclaredOrigArgs'} = { 'Set' => {}, 'List' => [] };
		}
		if ( not exists $Sblock->{'LocalVars'} ) { croak 'BOOM!';
			$Sblock->{'LocalVars'} = { 'Set' => {}, 'List' => [] };
		}
		if ( not exists $Sblock->{'DeclaredOrigLocalVars'} ) { croak 'BOOM!';
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
			$Sblock->{'Vars'}{$var} = $varsref->{$var
			  }; # FIXME: this is "inheritance, but in principle a re-parse is better?"
		}
		$Sblock->{'OrigArgs'}{'List'} = $args{$block};

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
				$Sblock->{'LocalVars'}{'Set'}{$iter}             = $decl;#
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
			my $decl = $Sblock->{'OrigArgs'}{'Set'}{$argv};
			if (not defined $decl) {
				$decl = $Sblock->{'DeclaredOrigArgs'}{'Set'}{$argv};
			}
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
		croak "There can only be one caller for a factored-out subroutine" if scalar keys %{ $stref->{'Subroutines'}{$block}{'Callers'} } != 1;
		
		for my $f ( keys %{ $stref->{'Subroutines'}{$block}{'Callers'} } ) { # There can only be one caller for $block
			if ($block eq 'OUTER') {
				$stref->{'Subroutines'}{$f}{'CalledSubs'}= $blocksref->{'OUTER'}{'CalledSubs'};
			} else {
				# Add $block to CalledSubs in $f
				$stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$block} = 1;
				carp "FIXME: Incorrect because there might be subs in $f called after $block";
				# What we need to do is put a marker in CalledSubs when we encounter the pragma, and not register any subcalls in the region!!!
				push @{$stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'}},$block;
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
#	say Dumper($annlines).$f;
	my $nextLineID   = scalar @{$annlines} + 1;
	my $new_annlines = [];
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		if ( exists $info->{'VarDecl'} and exists $info->{'VarDecl'}{'Names'} )
		{

			my @nvars = @{ $info->{'VarDecl'}{'Names'} };
			push @{$info->{'Ann'}}, '_split_multivar_decls ' . __LINE__ ;
			for my $var ( @{ $info->{'VarDecl'}{'Names'} } ) {
				
				my %rinfo = %{$info};

				$rinfo{'LineID'} = $nextLineID++;
				my $subset = '';
				
				if ($sub_incl_or_mod ne 'IncludeFiles') {
					if ( exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$var} ) {
						$subset = 'DeclaredOrigArgs';
					} elsif ( exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var} ) {
						$subset = 'DeclaredOrigLocalVars';
					} elsif ( exists $Sf->{'ExInclLocalVars'}{'Set'}{$var} ) { 
						$subset = 'ExInclLocalVars';
					} elsif ( exists $Sf->{'ExInclArgs'}{'Set'}{$var} ) {
						$subset = 'ExInclArgs';						
					} else {
						# Problem is that we get 'OrigArgs', not yet known if they are declared or not. 
						croak 'IMPOSSIBLE for Sub/Func/Module! ',$f,' ',$var,' ',$line,"DeclaredOrigArgs:\n",Dumper($Sf->{'DeclaredOrigArgs'}),
						"OrigArgs:\n",Dumper($Sf->{'OrigArgs'});
					}
					
				} else {
#				if ( exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$var} ) {
#					$subset = 'DeclaredOrigArgs';
#				} els
					if ( exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var} ) {
						$subset = 'DeclaredOrigLocalVars';
					} elsif ( exists $Sf->{'DeclaredCommonVars'}{'Set'}{$var} ) {
						$subset = 'DeclaredCommonVars';
					} else {
						die 'IMPOSSIBLE for Include! ',$f,' ',$sub_incl_or_mod;
					}	
#					croak Dumper($info->{'VarDecl'}).$subset if $var eq 'drydepspec';
				}
#				croak $f.':'.Dumper($Sf->{$subset}{'Set'}{$var}) if $var eq 'drydepspec';
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

		 #                die Dumper($rinfo{'VarDecl'}) if $var eq 'drydeposit';
				if ( scalar @{ $info->{'VarDecl'}{'Names'} } > 1 ) {
					for my $nvar (@nvars) {
						if ( $nvar ne $var ) {

							#                    say "NVAR: $nvar";
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

							#                    $rline=~s/,,/,/;
						}
					}

#croak  "\t$rline\n".Dumper(%rinfo) if $rline=~/drydepspec/;
				}

   #                $info->{'VarDecl'} = $decl; #$info->{'VarDecl'}{'Names'}[0];
   #                delete  $info->{'VarDecl'}{'Names'};
				push @{$new_annlines}, [ $rline, {%rinfo} ];
			}
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
					my $var   = $var_val->[0];
					my $val   = $var_val->[1];
#					say "PARAM SET: $var => ".Dumper( $Sf->{'Parameters'}{'Set'}{$var} );
					my %rinfo = %{$info};
					$rinfo{'LineID'}    = $nextLineID++;
					$rinfo{'ParamDecl'} = {};
					my $param_decl = {
						'Indent' => $info->{'ParamDecl'}{'Indent'},
						'Type'   => $Sf->{'LocalParameters'}{'Set'}{$var}{'Type'},
						'Attr'      => '',
						'Dim'       => [],
						'Parameter' => 'parameter',
						'Name'      => [ $var, $val ],
						'Val' 		=> $val, # backwards comp
						'Var' 		=> $var, # backwards comp
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

	if (
		   $line =~ /^\s*subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*recursive\s+subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*\w+\s+function\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*function\s+(\w+)\s*\((.*)\)/
	  )
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
		$Sf->{'UndeclaredOrigArgs'}{'Set'} = { map { $_ => 1 } @args };

		$Sf->{'OrigArgs'}{'List'}  = [@args];
		$Sf->{'OrigArgs'}{'Set'} = { map { $_ => 1 } @args };

		if ( $line =~ /function/ ) {
			$info->{'Signature'}{'Function'} = 1;
		} else {
			$info->{'Signature'}{'Function'} = 0;
		}

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
		;

		# If it's a program, there are no arguments
		my $name = $1;

		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Program'}      = 1;
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
	my $pt = parse_F95_var_decl($line);

	# But this could be a parameter declaration, with an assignment ...
	if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+\s*=\s*.+?)\s*$/ )
	{    # F95-style parameters
		$info->{'ParsedParDecl'} = $pt
		  ; #WV20150709 currently used by OpenCLTranslation, TODO: use ParamDecl


		my $parliststr = $1;
		my $var        = $pt->{'Pars'}{'Var'};
		my $val        = $pt->{'Pars'}{'Val'};
		my $type       = $pt->{'TypeTup'};

		my $param_decl = {
			'Indent'    => $indent,
			'Type'      => $type,
			'Attr'      => '',
			'Dim'       => [],
			'Parameter' => 'parameter',
			'Names'     => [ [ $var, $val ] ],
			'Status'    => 0
		};    # F95-style
		$info->{'ParamDecl'} = $param_decl;
		if ( not exists $Sf->{'LocalParameters'}{'List'} ) {
			$Sf->{'LocalParameters'}{'List'} = [];
		}
		if ( not exists $Sf->{'LocalParameters'}{'Set'} ) {
			$Sf->{'LocalParameters'}{'Set'} = {};
		}
		$Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;

		#                     {
		#                        'Type' => $type,
		#                        'Var'  => $var,
		#                        'Val'  => $val,
		#                        'Decl' => $param_decl
		#                    };
		# List is only used in Parser, find out what it does
		@{ $Sf->{'LocalParameters'}{'List'} } =
		  ( @{ $Sf->{'LocalParameters'}{'List'} }, $var )
		  ;    # FIXME: use ordered_union()

	} else {

		# F95 VarDecl, continued
		if (    not exists $info->{'ParsedVarDecl'}
			and not exists $info->{'VarDecl'} )
		{
			$info->{'ParsedVarDecl'} = $pt
			  ; #WV20150709 currently used by OpenCLTranslation, TODO: use VarDecl
#			  carp "LINE: $line";
#			  carp $line.Dumper($pt);
			$info->{'VarDecl'} = {
				'Indent' => $indent,
				'Names'  => $pt->{'Vars'},
				'Status' => 0
			};
			
			for my $tvar ( @{ $pt->{'Vars'} } ) {

				my $decl = {};
				$decl->{'Indent'}        = $indent;
				$decl->{'Type'}          = $pt->{'TypeTup'}{'Type'};
				$decl->{'ArrayOrScalar'} = 'Scalar';
				$decl->{'Dim'}           = [];
				if ( exists $pt->{'Attributes'} ) {
					if ( exists $pt->{'Attributes'}{'Dim'} ) {

# Dim is a list of ranges as strings, if '0' it's a Scalar. Dim is a list of ranges as 2-elt lists
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


#                    $Sf->{'Vars'}{$tvar}{'ArrayOrScalar'} = $pt->{'TypeTup'}{'ArrayOrScalar'} ;
				if ( $type =~ /character/ ) {
					$decl->{'Attr'} = '(len='
					  . $pt->{TypeTup}{'ArrayOrScalar'} . ')'
					  ; #WV20150709: maybe better ['len',$pt->{TypeTup}{'ArrayOrScalar'}]
					  
				} elsif (exists $pt->{'TypeTup'}{'Kind'}) {
					$decl->{'Attr'} = '(kind=' . $pt->{'TypeTup'}{'Kind'} . ')';
				} else {
					$decl->{'Attr'} = '';
				}

				$decl->{'IODir'} = $pt->{'Attributes'}{'Intent'};
				if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar} ) {
					$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} =
					  $decl;    # $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};
					delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar};
					@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } =
					  grep { $_ ne $tvar }
					  @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
					$Sf->{'DeclaredOrigArgs'}{'List'} =
					  ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'},
						[$tvar] );

				} else { # A var decl must be unique, so it it's not a arg, it's a local
					$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} =
					  $decl;    # $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};
					push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} }, $tvar;
				}
			}
		}
	}

	#                $is_f77_vardecl = 0;
	return ( $Sf, $info );

}    # END of __parse_f95_decl()

# -----------------------------------------------------------------------------

sub __parse_f77_par_decl {

	# F77-style parameters
	#                my $parliststr = $1;
	( my $Sf, my $f, my $line, my $info, my $parliststr ) = @_;
	my $indent = $line;
	my $type   = 'Unknown';
	$indent =~ s/\S.*$//;
	my @partups = split( /\s*,\s*/, $parliststr );
	my %pvars =
	  map { split( /\s*=\s*/, $_ ) } @partups;    # Perl::Critic, EYHO
	my @var_vals =
	  map { ( my $k, my $v ) = split( /\s*=\s*/, $_ ); [ $k, $v ] }
	  @partups;                                   # Perl::Critic, EYHO
	my @pvarl = map { s/\s*=.+//; $_ } @partups;
	my $pars = [];

	if ( not exists $Sf->{'LocalParameters'}{'List'} ) {
		$Sf->{'LocalParameters'}{'List'} = [];
	}
	if ( not exists $Sf->{'LocalParameters'}{'Set'} ) {
		$Sf->{'LocalParameters'}{'Set'} = {};
	}

	for my $var (@pvarl) {
		die if ref($var) eq 'ARRAY';

		if ( not defined $Sf->{'Vars'}{$var} ) {

			if ( exists $pvars{$var} ) {

				my $val = $pvars{$var};
				if ( $val =~ /[0-9eE\.\+\-]/ ) {
					$type = 'Unknown';
					if (   $val =~ /\./
						or $val =~ /e/i
						or $val =~ /\// )
					{
						$type = 'real';    # FIXME: could be double!
					} else {
						$type = 'integer';
					}
					$Sf->{'LocalParameters'}{'Set'}{$var} = {
						'Type' => $type,
						'Var'  => $var,
						'Val'  => $val
					};
					print
					  "INFO: LOCAL PARAMETER $var infered type: $type $var = $val\n"
					  if $I;
					push @{$pars}, $var;

				} else {
					print
"WARNING: LOCAL PARAMETER $var not declared in $f; can't infer type:\n"
					  if $W;
					print
"WARNING: LOCAL PARAMETER $var has NON_NUMERIC val $pvars{$var} in $f  (Parser::_analyse_lines)\n"
					  if $W;
				}
			}
		} else {

			#                        die Dumper( $Sf->{'Vars'}{$var} );
			$type = $Sf->{'Vars'}{$var}{'Type'};
			$Sf->{'LocalParameters'}{'Set'}{$var} = {
				'Type' => $type,
				'Var'  => $Sf->{'Vars'}{$var},
				'Val'  => $pvars{$var}
			};
			push @{$pars}, $var;
		}
	}
	$info->{'ParamDecl'} = {
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

#                die $line .':'.Dumper($varlst) if $line=~/pplev.nuvz..ulev/;
# Now an ad hoc fix for spaces between the type and the asterisk. FIXME! I should just write a better FSM!
	if ( $line =~ /\w+\s+(\*\s*(\d+|\(\s*\*\s*\)))/ )
	{    # FIXME: I assume after the asterisk there MUST be an integer constant
		my $len = $1;
		$type .= $len;
		$varlst =~ s/^\S+\s+//;

	}
	my $attr = '';
	$type =~ /\*/ && do {
		( $type, $attr ) = split( /\*/, $type );
		if ( $attr eq '(' ) { $attr = '*' }
	};
	my $indent = $line;
	$indent =~ s/\S.*$//;

	#                $is_f77_vardecl = 0;
	my $T = 0;

	#                $T = 1 if $f eq 'timemanager' and $line=~/drydeposit/;
	( my $pvars, my $pvars_lst ) = f77_var_decl_parser( $varlst, $T );
#croak Dumper($pvars) if $line=~/drydepspec/ and $f eq 'includecom';
	# I verified that here the dimensions are correct
	my @varnames = ();

	# Add type information to Vars
	for my $var ( @{$pvars_lst} ) {
		if ( $var eq '' ) { croak "<$line> in $f" }
		my $tvar = $var;
		if ( ref($var) eq 'ARRAY' ) { die __LINE__ . ':' . Dumper($var); }
		my $tvar_rec = {
		'Type' => $type,
		'Dim' => $pvars->{$var}{'Dim'},
		'ArrayOrScalar' => $pvars->{$var}{'ArrayOrScalar'},
		'IODir' => 'Unknown'
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
			'Dim'    => [ @{ $pvars->{$var}{'Dim'} } ],
			'Name'   => $tvar,
			'IODir'  => $tvar_rec->{'IODir'},
			'Status' => 0
		};

		push @varnames, $tvar;

		if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var} ) {
			$Sf->{'DeclaredOrigArgs'}{'Set'}{$var} = $decl;
			delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};
			@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } =
			  grep { $_ ne $var } @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
			$Sf->{'DeclaredOrigArgs'}{'List'} =
			  ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'}, [$var] );
		} else { # A var decl must be unique, so it it's not a arg, it's a local
			$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var} = $decl;
			push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} }, $var;
		}

	}    # loop over all vars declared on a single line

	print "\tVARS <$line>:\n ", join( ',', sort @varnames ), "\n"
	  if $V;

	$info->{'VarDecl'} = {
		'Indent' => $indent,
		'Names'  => \@varnames,
		'Status' => 0
	};

	push @{$info->{'Ann'}}, ' _analyse_lines ' . __LINE__ ;
#carp Dumper($Sf->{'DeclaredOrigLocalVars'}{'Set'}{'drydepspec'}) if $line=~/drydepspec/ and $f eq 'includecom';
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

			# BeginDo:
			$line =~ /^\d*\s+do\s+(\d+)\s+\w/ && do {
				my $label = $1;
				$info->{'BeginDo'}{'Label'} = $label;
				if ( not exists $do_loops{$label} ) {
					@{ $do_loops{$label} } = ( [$index], $nest );
					$nest++;
				} else {
					push @{ $do_loops{$label}[0] }, $index;

#               print STDERR "WARNING: $f: Found duplicate label $label at: ".join(',',@{ $do_loops{$label}[0] })."\n";
				}
				next;
			};

			# Goto
			$line =~ /^\d*\s+.*?[\)\ ]\s*go\s?to\s+(\d+)\s*$/ && do {
				my $label = $1;
				$info->{'Goto'}{'Label'} = $label;
				$Sf->{'Gotos'}{$label} = 1;
				push @{ $gotos{$label} }, [ $index, $nest ];
				next;
			};

			# continue can be end of do loop or break target (amongs others?)
			$line =~ /^\s*(\d+)\s+(continue|\w)/ && do {
				my $label = $1;
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

sub parse_read_write_print { ( my $line, my $info, my $stref, my $f)=@_;
	
	my $call =  exists $info->{'ReadCall'} ? 'read' :   exists $info->{'WriteCall'} ? 'write' : 'print';
	
	$info->{'CallAttrs'}={'Set'=>{},'List'=>[]};
				my $tline=$line;
#				my $dbg=0;
# Remove any labels
#say Dumper($info);
	if (exists $info->{'Label'}) {		
		my $label = $info->{'Label'};
#		say "LABEL:$label";
		$tline=~s/^\s*$label\s+//;
	} elsif ($tline=~s/^(\s*)(\d+)(\s+)/$1$3/ ) {
		$info->{'Label'}=$2;
#		say "LABEL:$2";
	}
#	say Dumper($info);
#say "TLINE: $tline";# if $line=~/read\(iunit,\*\)/ and $f eq 'skplin';
# Parse 
	(my $matched_str, my $rest)=_parse_IO_sub_call($tline);
#	say "CALL:$matched_str"; 
	# Parse the actual call args to see if there are any variables.
	$matched_str=~s/\w+\(//;
	$matched_str=~s/\)//;
	my @call_attrs=_parse_comma_sep_expr_list($matched_str);
	
	for my $call_attr (@call_attrs) {
		if ($call_attr=~/=/) {
			(my $attr_name,$call_attr)=split(/\s*=\s*/,$call_attr);			
		}
		
		next if $call_attr eq '*';
		next if $call_attr =~ /^\d+$/; 
		next if $call_attr =~ /^__PH\d+__$/;
		if ($call_attr !~ /^[a-z][a-z0-0_]*/) {
			carp "UNKNOWN CALL ATTR VAL $call_attr on LINE $line"; 
		} else {
			my $type = $call_attr=~/\(/ ? 'Array' : 'Scalar';
			$info->{'CallAttrs'}{'Set'}{$call_attr}={'Type' => $type};
			push @{$info->{'CallAttrs'}{'List'}},$call_attr;
		}
	}
	$tline=$rest;
	
	
#say "CALL ATTRS: ".join(';',@call_attrs);#." REST <$rest>" ;# if $line=~/read\(iunit,\*\)/ and $f eq 'skplin';
				# This only works for read (), not for read*
#				if ($tline=~/(read|write|print)\s*\(/) {
#					while (substr($tline,0,1) ne ')') {
#						$tline=substr $tline,1;
#					}
#					$tline=~s/\)\s*//;
#				} elsif ($tline=~/(read|write|print)\s+\'\(.+\'\)\s*,/) {
#					#READ '(A6,I3)', A, I
#					$tline=~s/(read|write|print)\s+\'\(.+\'\)\s*,//;
#				} elsif ($tline=~/(read|write|print)\s+[^,]+,/) {
#					$tline=~s/^.+?,//;
#				}
								while ($tline=~/[\"\'][^\"\']+[\"\']/) {
					say "STRING CONST $tline";
					$tline=~s/[\"\'][^\"\']+[\"\']//; # so at this point we could have e.g. var1,\s*,var2 or ^\*,var1 or var1,\s*$ 
					$tline=~s/,\s*,//;
					$tline=~s/^\s*,\s*//;
					$tline=~s/\s*,\s*$//;
				} 
#say "TLINE2: <$tline>" ;
	my @exprs=_parse_comma_sep_expr_list($tline);
#croak Dumper(@exprs) if $f eq 'plumetraj' and $tline=~/ireleasestart/;
					$info->{'CallArgs'}={'List'=>[],'Set'=>{}};
					$info->{'ExprVars'}={'List'=>[],'Set'=>{}};
		for my $tline (@exprs) { 
				while ($tline=~/\/\//) {
					$tline=~s/\/\//+/;
				}
				while ($tline=~/\)\s*\(/) {
					$tline=~s/\)\s*\(/,/;
				}
				$tline=~s/:/,/g;
	
#				if ($tline=~/=/) {
#					$tline=~s/\s+//g;
#					my @implied_do_iters = ();
#					# I am fed up so I'm going to assume that the bounds are constants or scalars
#					my $check_inf_loop=10;
#					while ($tline=~/=/) {
#						--$check_inf_loop;
#						if ($tline=~/,(\w+)=(\w+),(\w+)\)/) {
#							my $idx=$1;
#							my $idx_b=$2;
#							my $idx_e=$3;
#							$tline=~s/,(\w+)=(\w+),(\w+)\)/,range($idx,$idx_b,$idx_e))/;
#						}					
#						last if $check_inf_loop==0;	
#					}			
#					if ($check_inf_loop==0) {
#						# The above failed, try something more brutal
#						# (kz,eta_w_wrf(kz),eta_u_wrf(kz),kz=1,nwz-1)
#						$tline=~s/=/,/g;
#					}
#					# replace  ^\(\(\( and ,\s*\(\(\( with do(do(do( 
#					while ($tline=~/^\(/) {					
#						$tline=~s/\(([^\(])/do(${1}/;
#					}
#				}
#				say "TLINE:$tline";
#say "TLINE5: $tline";
				# At this point we should have just the arguments, let's parse this as an expression
				# But the expression parser can only handle numerical expressions so first check if we have strings
				
#
#				say "TLINE STRIPPED: $tline" unless $tline=~/__PH/;				
				if ($tline!~/^\s*$/) {
					if ($tline=~/^\(/) {
						# If an argument is ( ... ) it means we only have Vars
						if ($tline=~/=/) { # must be an implied do, but don't do anything about that for now.
						# If it's an implied do, we should identify the arguments, we can do this actually:
#						say "IMPLIED DO: $tline";
							my @args=();
							my @vars=();
							my $in_range=0;
							while($tline ne '') {
								$tline=~s/^\(*//;
								$tline=~s/\)$//;		# This is WEAK!						
								last if $tline eq '';						
								(my $arg, my $rest)=_parse_array_access_or_function_call($tline);
								
#								say $tline.' => '.Dumper($arg).$rest;croak if $arg eq '';
								if ($arg=~/=/ ) {
									(my $lhs, my $rhs)=split(/=/,$arg);
									push @vars,$lhs;
									push @vars,$rhs;
									$in_range=1;
								} elsif ($in_range) {
#									say "RANGE VAR: $arg";
									$arg=~s/\)$//;		# This is WEAK!
									push @vars,$arg;
								} else {
									push @args,$arg;
								}
								 $rest=~s/,//;
								 $tline=$rest;						 
							}

#							say 'RANGE VARS:'.Dumper(@vars);
							my $fake_range_expr = 'range('.join(',',@vars).')';
							my $ast = parse_expression($fake_range_expr,$info, $stref, $f);
							(my $call_args,my $other_vars)= @{ get_args_vars_from_expression($ast) };
								$info->{'ExprVars'}{'Set'}={ %{ $info->{'ExprVars'}{'Set'} },%{ $other_vars->{'Set'} }};							
#							say Dumper($other_vars);
							for my $mvar (@args) {
								next if $mvar eq '';
								next if $mvar =~ /^\d+$/;
								next if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
								next if exists $F95_reserved_words{$mvar};
								my $ast = parse_expression($mvar,$info, $stref, $f);
								(my $call_args,my $other_vars)= @{ get_args_vars_from_expression($ast) };
#								carp "ARGS_VARS:".Dumper($call_args,$other_vars) ;
	#				croak if $f eq 'ifdata' and $line=~/fghold/;
								$info->{'CallArgs'}{'Set'}={ %{ $info->{'CallArgs'}{'Set'} },%{ $call_args->{'Set'} }};	
								$info->{'ExprVars'}{'Set'}={ %{ $info->{'ExprVars'}{'Set'} },%{ $other_vars->{'Set'} }};								
							}
							$info->{'CallArgs'}{'List'}=[ keys %{ $info->{'CallArgs'}{'Set'} } ];
							$info->{'ExprVars'}{'List'}=[ keys %{ $info->{'ExprVars'}{'Set'} } ];
#							my $fake_range_expr = 'range('.join(',',												
#												say Dumper($info);
#					$info->{'ExprVars'}=$other_vars;
																					
						} else {
							# This is an expression in parentheses, so it must be treated as Vars-only
											my @chunks = split( /\W+/, $tline );
					my %vars_in_expr=();
					for my $mvar (@chunks) {
						next if $mvar eq '';
						next if $mvar =~ /^\d+$/;
						next if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
						next if exists $F95_reserved_words{$mvar};
						$vars_in_expr{ $mvar}={'Type' => 'Unknown'};
					}
						 $info->{'ExprVars'}={'List'=>[keys %vars_in_expr],'Set'=>{%vars_in_expr}};
#						 $info->{'CallArgs'}={'List'=>[],'Set'=>{}};
						}
					} else { # ok, maybe we can parse this
					my $ast = parse_expression("$call($tline)",$info, $stref, $f);
#					carp 'AST:'.Dumper($ast) ;
					(my $args,my $other_vars)= @{ get_args_vars_from_expression($ast) };
#					carp "ARGS_VARS:".Dumper($args,$other_vars) if $f eq 'post' and $line=~/write/;
	#				croak if $f eq 'ifdata' and $line=~/fghold/;
					$info->{'CallArgs'}=append_to_set($info->{'CallArgs'},$args);
					$info->{'ExprVars'}=append_to_set($info->{'ExprVars'},$other_vars);
					}
				}
#					else {
#					$info->{'CallArgs'}={'List'=>[],'Set'=>{}};
#					$info->{'ExprVars'}={'List'=>[],'Set'=>{}};
#						
#				}						
}
#say "INFO: ".Dumper($info); 
#croak  if $line=~/read\(iunit,\*\)/ and $f eq 'skplin'; 
	return $info;		
} # END of parse_read_write_print()

# -----------------------------------------------------------------------------
sub _parse_assignment {
    ( my $line, my $info, my $stref, my $f ) = @_;

    my $tline = $line;
    
#    say "_parse_assignment($line)";
    $tline =~ s/^\s*\d+//;         # remove labels
    $tline =~ s/^\s+//; # remove blanks
    $tline =~ s/\s+$//; # remove blanks
   
   
# TODO: proper Fortran expression parser. 
# For now we sanitise the lines as follows:
# Replace '//' by '+' because the parser does not know '//'
				while ($tline=~/\/\//) {
					$tline=~s/\/\//+/;
				}
# Remove ')(', this I think only occurs for characters strings				
				while ($tline=~/\)\s*\(/) {
					$tline=~s/\)\s*\(/,/;
				}
# Remove ':' because again this only occurs for characters strings
				$tline=~s/:/,/g;    
#    say "ALINE: $tline";
     (my $lhs, my $rhs ) = split( /\s*=\s*/, $tline );
#     say "LHS: $lhs, RHS: $rhs";
	my $lhs_ast = parse_expression($lhs,$info, $stref, $f);
#	say "LHS:".$line ;
#	say "LHS_AST:".Dumper($lhs_ast) if $lhs_ast->[1] eq 'len';
	# FIXME: must make sure here that lhs is NOT a reserverd word, dammit!
	(my $lhs_args,my $lhs_vars)= @{ get_args_vars_from_expression($lhs_ast) };
#	say 'ARGS: '.Dumper($lhs_args);
#	say 'VARS:'.Dumper($lhs_vars)  if $lhs_ast->[1] eq 'len';
	 if (exists $F95_reserved_words{$lhs_ast->[1] }
		 or exists $F95_intrinsics{$lhs_ast->[1] }
	 ) {
	 	my $tmp_line=$line;
	 	$tmp_line=~s/__PH\d+__/.../g;
	 	say "Assignment to reserved word or intrinsic '".$lhs_ast->[1]."' at line '".$tmp_line ,"' in subroutine/function '$f' in '".$stref->{'Subroutines'}{$f}{'Source'}."', this is not allowed, please fix your code!";
	 	$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}={$lhs_ast->[1] => 1};
	 }
	my $rhs_ast = parse_expression($rhs,$info, $stref, $f);
#	say 'RHS_AST:'.Dumper($rhs_ast );
	(my $rhs_args,my $rhs_vars)= @{ get_args_vars_from_expression($rhs_ast) };
#	say 'RHS_ARGS:'.Dumper($rhs_args);
	my $rhs_all_vars = {
		'Set' => { %{$rhs_args->{'Set'}},%{$rhs_vars->{'Set'}} },
		'List' =>[@{$rhs_args->{'List'}},@{$rhs_vars->{'List'}}]
	};
	
	#{Lhs => {VarName, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
	if (scalar @{$lhs_args->{'List'}}>0) {
	my $lhs_varname= $lhs_args->{'List'}[0];
	
	$info->{'Lhs'}={
		'VarName'=>$lhs_varname,
		'IndexVars' =>$lhs_vars,
		'ArrayOrScalar' =>$lhs_args->{'Set'}{$lhs_varname}{'Type'},
		'ExpressionAST'=>$lhs_ast
	};   
	} else { 
		$info->{'Lhs'}={
			'ArrayOrScalar' =>'Other',
		'ExpressionAST'=>$lhs_ast	
		}
	}
	
	$info->{'Rhs'}={
		'VarList'=>$rhs_all_vars,
		'ExpressionAST'=>$rhs_ast
	};
#	my %test = map {$_ => 1}  @{ $info->{'Rhs'}{'VarList'}{'List'}};
#	if (exists $test{'__PH0__'}) {croak Dumper($info)} 
#croak Dumper($info) if $line=~/data10/ and $f eq 'set';

	return $info;
} # END of _parse_assignment()
# -----------------------------------------------------------------------------

sub _parse_array_access_or_function_call {
	(my $str)=@_;
	
	my $parens_count=0;
	my $found_parens=0;
	my @chars=split('',$str);
	my $nchars = scalar @chars;
	
	my $matched_str=''	;
	for my $ch_idx (0 .. $nchars-1) {
		my $ch = shift @chars;
		if ($ch eq '(') { 
			if ($ch_idx==0) {
				unshift @chars, $ch;
				last;
			}
			$found_parens=1;
			++$parens_count;
		} elsif (	$ch eq ')') { 
			--$parens_count;
			if ($parens_count==0) {
				$found_parens=0;
			}
		} elsif ($ch eq ',' and $found_parens==0) {			
			unshift @chars, $ch;
			last;
		} 
		$matched_str.=$ch;
		last if $found_parens==1 and $parens_count==0;		
	}		
	my $rest = join('',@chars);
	return ($matched_str, $rest)
} # END of _parse_array_access_or_function_call()

sub _parse_IO_sub_call {
	(my $str)=@_;
	
	my $parens_count=0;
	my $found_parens=0;
	my @chars=split('',$str);
	my $nchars = scalar @chars;
	
	my $matched_str=''	;
	for my $ch_idx (0 .. $nchars-1) {
		my $ch = shift @chars;
		if ($ch eq ' ' or $ch eq "\t") {			
			next;
		} elsif ($ch eq '(') { 
			if ($ch_idx<2) {
				unshift @chars, $ch;
				last;
			}
			$found_parens=1;
			++$parens_count;
		} elsif ($ch eq ')') { 
			--$parens_count;
		} 
		if ($found_parens==1 and $parens_count==0) {			
#			unshift @chars, $ch;
			last;
		} 
		$matched_str.=$ch;
	}		
	my $rest = join('',@chars);
	return ($matched_str, $rest)
}

sub _parse_if_cond {
	(my $str)=@_;
	
	my $parens_count=0;
	my $found_parens=0;
	my @chars=split('',$str);
	my $nchars = scalar @chars;
	
	my $matched_str=''	;
	for my $ch_idx (0 .. $nchars-1) {
		my $ch = shift @chars;
		if ($ch eq ' ' or $ch eq "\t") {			
			next;
		} elsif ($ch eq '(') { 
			if ($ch_idx<2) {
				unshift @chars, $ch;
				last;
			}
			$found_parens=1;
			++$parens_count;
		} elsif ($ch eq ')') { 
			--$parens_count;
#			if ($parens_count==0) {
#				$found_parens=0;
#			}
		}
		if ($found_parens==1 and $parens_count==0) {			
#			unshift @chars, $ch;	
			last;
		} 
		$matched_str.=$ch;
#		last if $found_parens==1 and $parens_count==0;		
	}		
	my $rest = join('',@chars);
	return ($matched_str, $rest)
}

sub _parse_comma_sep_expr_list {
	
		(my $str)=@_;
	
	my $parens_count=0;
	my $found_parens=0;
	my @chars=split('',$str);
	my $nchars = scalar @chars;
	
	my $matched_str=''	;
	my @matched_strs=();
	
	for my $ch_idx (0 .. $nchars-1) {
		my $ch = shift @chars;
		if ($ch eq '(') { 
			$found_parens=1;
			++$parens_count;
			$matched_str.=$ch;
		} elsif ($ch eq ')') { 
			--$parens_count;
			if ($found_parens==1 and $parens_count==0) {
				$found_parens=0;
			}
			$matched_str.=$ch;
		} elsif ($ch eq ',' and $found_parens==0) {						
			push @matched_strs, $matched_str;
			$matched_str='';
		} elsif ($ch ne ' ') {
		$matched_str.=$ch;
		}		
		if (  $ch_idx==$nchars-1) {
			push @matched_strs, $matched_str;
		}		
	}
	return @matched_strs;
}

1;

