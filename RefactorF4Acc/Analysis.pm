package RefactorF4Acc::Analysis;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Includes qw( find_root_for_includes );
use RefactorF4Acc::Analysis::Globals
  qw( identify_inherited_exglobs_to_rename lift_globals rename_inherited_exglobs );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_end_detect );
use RefactorF4Acc::Refactoring::Common
  qw( get_f95_var_decl stateful_pass stateless_pass );

#
#   (c) 2010-2015 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Analysis::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::EXPORT = qw(
  &analyse_all
);

sub analyse_all {

	( my $stref, my $subname, my $stage ) = @_;

 # Find the 'root', i.e. the outermost calling subroutine, for each include file

	print "\t** FIND ROOT FOR INCLUDES **\n" if $V;
	$stref = find_root_for_includes( $stref, $subname );
	return $stref if $stage == 1;

# First find any additional argument declarations, either in includes or via implicits
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		$stref = _lift_param_includes( $stref, $f );
		$stref = _find_argument_declarations( $stref, $f );
	}
	return $stref if $stage == 2;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';

		# In this stage, 'Globals' is populated
		$stref = _analyse_variables( $stref, $f );

	}
	return $stref if $stage == 3;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		$stref = _resolve_conflicts_with_params( $stref, $f );

	}
	return $stref if $stage == 4;
	$stref = identify_inherited_exglobs_to_rename( $stref, $subname );
	$stref = lift_globals( $stref, $subname );
	$stref = rename_inherited_exglobs( $stref, $subname );

#	croak Dumper( $stref->{'Subroutines'}{'advance'}{'ExGlobArgDecls'}{'List'} ) ;
	return $stref if $stage == 5;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		$stref = _create_refactored_args( $stref, $f );
	}
	return $stref if $stage == 6;

#croak Dumper( $stref->{'Subroutines'}{'gridcheck'}{'UndeclaredOrigLocalVars'} );
	for my $f ( keys %{ $stref->{'Subroutines'} } )
	{    # Assuming Functions are just special subroutines
		next if $f eq '';

		#		next if exists $stref->{'ExternalSubroutines'}{$f};
		$stref = _map_call_args_to_sig_args( $stref, $f );
	}
	return $stref if $stage == 7;

#croak Dumper( $stref->{'Subroutines'}{'gridcheck'}{'UndeclaredOrigLocalVars'} );

   # This is only for refactoring init out of time loops so very domain specific
	for my $kernel_wrapper ( keys %{ $stref->{'KernelWrappers'} } ) {
		$stref = outer_loop_end_detect( $kernel_wrapper, $stref );
	}

	# So at this point all globals have been resolved and typed.

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		$stref = _analyse_var_decls_for_params( $stref, $f );
	}
	return $stref;
}    # END of analyse_all()

# If the sub has arguments but they were not declared, see if we can find the declarations in include files, otherwise use implicit rules
sub _find_argument_declarations {
	( my $stref, my $f ) = @_;
	my $once               = 1;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};

	#	if (exists $Sf->{'OrigArgs'}{'List'}) {
	for my $arg ( @{ $Sf->{'OrigArgs'}{'List'} } ) {
		if ( not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$arg} ) {
			say "MISSING ORIG ARG DECLS for '$f'" if $V and $once;
			$once = 0;
			say "ARG: $arg" if $DBG;
			my $in_incl = 0;
			for my $inc ( keys %{ $Sf->{'Includes'} } ) {
				my $subset =
				  in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $arg );
				if ( $subset ne '' ) {
					say "FOUND DECL for $arg in INC $inc" if $DBG;
					my $decl =
					  $stref->{'IncludeFiles'}{$inc}{$subset}{'Set'}{$arg};
					push @{ $Sf->{'ExInclArgDecls'}{'List'} }, $arg;
					$Sf->{'ExInclArgs'}{'Set'}{$arg} = $decl;
					$in_incl = 1;
					last;
				}
			}
			if ( not $in_incl ) {
				say "TYPING $arg via IMPLICIT rules" if $DBG;
				my $decl = get_f95_var_decl( $stref, $f, $arg );
				push @{ $Sf->{'ExImplicitArgs'}{'List'} }, $arg;
				$Sf->{'ExImplicitArgs'}{'Set'}{$arg} = $decl;
			}
		}
	}

	#	}
	#	croak Dumper($stref->{'Subroutines'}{$f}{'Args'}) if $f eq 'caldate';
	return $stref;
}    # END of _find_argument_declarations

# -----------------------------------------------------------------------------
#2.4 Find all variables in a subroutine and categorise them:
#- IF NOT IN Args:
#	- IF NOT DeclaredVars
#		IF IN Commons for any Incl => ExGlobArgDecls, Globals
#		ELSE
#			IF in Vars for any Incl => ExInclVarDecls, LocalVars
#				ELSE => ExImplicitVarDecls, LocalVars
# Then merge the Args and ExGlobArgDecls
sub _analyse_variables {
	( my $stref, my $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};

	#	local $DBG=1;
	say "_analyse_variables($f)" if $DBG;

	my $__analyse_vars_on_line = sub {
		( my $annline, my $state ) = @_;
		( my $line,    my $info )  = @{$annline};

		if (   exists $info->{'Assignment'}
			or exists $info->{'SubroutineCall'}
			or exists $info->{'If'}
			or exists $info->{'ElseIf'}
			or exists $info->{'Do'}
			or exists $info->{'WriteCall'}
			or exists $info->{'PrintCall'}
			or exists $info->{'ReadCall'}
			or exists $info->{'InquireCall'}
			or exists $info->{'OpenCall'}
			or exists $info->{'CloseCall'}
			or exists $info->{'ParamDecl'} )
		{
			( my $stref, my $f, my $identified_vars ) = @{$state};

			my $Sf     = $stref->{'Subroutines'}{$f};
			my @chunks = ();
			if ( exists $info->{'If'} ) {
				@chunks = keys %{ $info->{'CondVars'} };
			}

			if (   exists $info->{'PrintCall'}
				or exists $info->{'WriteCall'}
				or exists $info->{'ReadCall'}
				or exists $info->{'InquireCall'} )
			{
				@chunks = (
					@chunks,
					@{ $info->{'CallArgs'}{'List'} },
					@{ $info->{'ExprVars'}{'List'} },
					@{ $info->{'CallAttrs'}{'List'} }
				);
			} elsif ( exists $info->{'SubroutineCall'} ) {
				for my $var_expr ( @{ $info->{'CallArgs'}{'List'} } ) {
					if ( exists $info->{'CallArgs'}{'Set'}{$var_expr}{'Arg'} ) {
						push @chunks,
						  $info->{'CallArgs'}{'Set'}{$var_expr}{'Arg'};
					} else {
						push @chunks, $var_expr;
					}
				}
				for my $expr_var ( @{ $info->{'ExprVars'}{'List'} } ) {
					push @chunks, $expr_var;
				}
			} elsif ( exists $info->{'OpenCall'} ) {
				if ( exists $info->{'Vars'} ) {
					@chunks = ( @chunks, @{ $info->{'Vars'}{'List'} } );
				}
			} elsif ( exists $info->{'Do'} ) {
				@chunks = (
					@chunks,
					$info->{'Do'}{'Iterator'},
					@{ $info->{'Do'}{'Range'}{'Vars'} }
				);
			} elsif ( exists $info->{'Assignment'} ) {
				@chunks = (
					@chunks,
					$info->{'Lhs'}{'VarName'},
					@{ $info->{'Lhs'}{'IndexVars'}{'List'} },
					@{ $info->{'Rhs'}{'VarList'}{'List'} }
				);
			} elsif ( exists $info->{'ParamDecl'} ) {
				@chunks = ( @chunks, keys %{ $info->{'UsedParameters'} } );
			} else {
				my @mchunks = split( /\W+/, $line );
				for my $mvar (@mchunks) {
					next
					  if exists $F95_reserved_words{$mvar
						  }; # This should be, unless some idiot has assigned to a reserved word somewhere. We assume they only redefine intrinsic functions but who knows?
					next if exists $F95_other_intrinsics{$mvar};
					next
					  if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}
						  {$mvar};    # Means it's a function
					next if $mvar =~ /^__PH\d+__$/;
					next if $mvar !~ /^[_a-z]\w*$/;
					push @chunks, $mvar;
				}
			}
			for my $mvar (@chunks) {
				next if $mvar =~ /^\d+$/;
				next if not defined $mvar or $mvar eq '';
				my $maybe_orig_arg = in_nested_set( $Sf, 'OrigArgs', $mvar );
				my $maybe_decl_orig_arg =
				  exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$mvar}
				  ? 'DeclaredOrigArgs'
				  : '';
				my $undecl_orig_arg =
				  exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$mvar} ? 1 : 0;

# Here it is still possible that the variables don't have any declarations
# If that is the case for OrigArgs we must type them via Implicits
# But should this not have happened already? No, because UndeclaredOrigArgs could be declared via Includes,
# and that is checked here.
# So I think we exclude the DeclaredOrigArgs only

				if (
					not exists $identified_vars->{$mvar}
					and ( $maybe_decl_orig_arg eq ''
					)   # means $mvar is not present in the set DeclaredOrigArgs
					and
					( not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$mvar}
						or $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$mvar} == 1 )
					and not exists  $Sf->{'DeclaredCommonVars'}{'Set'}{$mvar} 
				  )

				{
					my $in_incl = 0;
					if ( not exists $Sf->{'Commons'}{$mvar} ) {
						for my $inc ( keys %{ $Sf->{'Includes'} } ) {
							say "LOOKING FOR $mvar from $f in $inc" if $DBG;

#croak Dumper($annline). ' => '. $inc  if $f eq 'anime' and $mvar eq 'a1';
# A variable can be declared in an include file or not and can be listed as common or not
							if (
								in_nested_set(
									$stref->{'IncludeFiles'}{$inc}, 'Vars',
									$mvar
								)

					#							exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mvar}
								or
								exists $stref->{'IncludeFiles'}{$inc}{'Commons'}
								{$mvar}
							  )
							{
								$in_incl = 1;

								if ( $stref->{'IncludeFiles'}{$inc}{'InclType'}
									eq 'Parameter' )
								{
									print
"WARNING: $mvar in $f is a PARAMETER from $inc!\n"
									  if $W;
									$Sf->{'Includes'}{$inc}{'Only'}{$mvar} = 1;

								 #								  	say "PARAM $mvar for $f from $inc";
								} else {
									if ( $stref->{'IncludeFiles'}{$inc}
										{'InclType'} eq 'Common' )
									{
										print
"FOUND COMMON $mvar in INC $inc in $line\n"
										  if $DBG;
										croak "COMMON $mvar for $f"
										  . in_nested_set(
											$stref->{'IncludeFiles'}{$inc},
											'Vars', $mvar )
										  if $mvar eq 'kp';
										my $decl;
										my $subset_for_mvar = in_nested_set(
											$stref->{'IncludeFiles'}{$inc},
											'Vars', $mvar );

				#										croak $subset_for_mvar  if $subset_for_mvar =~/Glob/;
										say "Found $mvar in $subset_for_mvar "
										  if $DBG;
										if ( $subset_for_mvar ne '' ) {
											my $var_rec =
											  get_var_record_from_set(
												$stref->{'IncludeFiles'}{$inc}
												  {'Vars'},
												$mvar
											  );
											if ( not defined $var_rec ) {

				 # This means this var decl in the include has not been declared
												say
"No Decl for $mvar in $inc $subset_for_mvar"
												  ; #.Dumper($stref->{'IncludeFiles'}{$inc}{'Parameters'});
												croak Dumper(
													$stref->{'IncludeFiles'}
													  {$inc}{'Vars'} )
												  if $mvar eq 'data23';

									  # So we should type this one via Implicits
												$decl =
												  get_f95_var_decl( $stref, $f,
													$mvar );
												say Dumper($decl);
											} else {
												$decl = $var_rec;
											}
										} else {
											croak
"No Subset for $mvar in $inc $subset_for_mvar";
										}

										if (
											exists $stref->{'IncludeFiles'}
											{$inc}{'Commons'}{$mvar} )
										{
											say
"FOUND argdecl for $mvar via common block in $inc"
											  if $DBG;
											push @{ $stref->{'Subroutines'}{$f}
												  {'ExGlobArgDecls'}{'List'} },
											  $mvar;
											$decl->{'Inc'} = $inc
											  ; #WV20160406 this is a bit late .
											$stref->{'Subroutines'}{$f}
											  {'CommonIncs'}{$inc} = $inc;
											$stref->{'Subroutines'}{$f}
											  {'ExGlobArgDecls'}{'Set'}{$mvar} =
											  $decl;
											$stref->{'Subroutines'}{$f}
											  {'MaskedIntrinsics'}{$mvar} = 1;

#										  croak "FOUND argdecl for $mvar via common block in $inc" if $mvar eq 'len';
										} else {
											say
"INFO: LOCAL VAR FROM $inc, NOT COMMON! "
											  . '_analyse_variables() '
											  . __LINE__
											  if $I;

											push @{ $stref->{'Subroutines'}{$f}
												  {'ExInclVarDecls'}{'List'} },
											  $mvar;
											$stref->{'Subroutines'}{$f}
											  {'ExInclVarDecls'}{'Set'}{$mvar} =
											  $decl;
											croak
"INFO: LOCAL VAR FROM $inc, NOT COMMON! "
											  if $mvar eq 'len';
										}
										$identified_vars->{$mvar} = 1;

										last;
									}
								}
							}
						}
					}
					if ( not $in_incl ) {
						 # Now check if this variable might be accessed via the containing program
						$identified_vars->{$mvar} = 0;
						if ( exists $stref->{'Subroutines'}{$f}{'Container'} ) {
							my $container =
							  $stref->{'Subroutines'}{$f}{'Container'};
							my $subset = in_nested_set(
								$stref->{'Subroutines'}{$container},
								'Vars', $mvar );
							if ( $subset ne '' ) {
								say "FOUND VAR $mvar in CONTAINER $container"
								  if $DBG;

								# If so, this is treated as an ExGlob
								push @{ $stref->{'Subroutines'}{$f}
									  {'ExGlobArgDecls'}{'List'} },
								  $mvar;
								my $decl =
								  $stref->{'Subroutines'}{$container}{$subset}
								  {'Set'}{$mvar};
								$decl->{'Container'} = $container;
								$decl->{'Indent'}    = '      ';     # ad hoc!
								$stref->{'Subroutines'}{$f}{'ExGlobArgDecls'}
								  {'Set'}{$mvar} = $decl;
								$identified_vars->{$mvar} = 1;
							}
						}
						if ( $identified_vars->{$mvar} != 1 ) {
							if ( $line =~ /$mvar\s*\(/ ) {
								say
"INFO: LOCAL VAR <$mvar> in $f may be an EXTERNAL FUNCTION "
								  if $I;

							}
#							else {
							say "INFO: LOCAL VAR <$mvar> in $f via IMPLICIT! "
							  . $line
							  . ' _analyse_variables() '
							  . __LINE__
							  if $I;
							my $decl = get_f95_var_decl( $stref, $f, $mvar );

							if ( not $undecl_orig_arg ) {
								push @{ $stref->{'Subroutines'}{$f}
									  {'ExImplicitVarDecls'}{'List'} }, $mvar;
								$stref->{'Subroutines'}{$f}
								  {'ExImplicitVarDecls'}{'Set'}{$mvar} = $decl;
							} else {
								push @{ $stref->{'Subroutines'}{$f}
									  {'ExImplicitArgDecls'}{'List'} }, $mvar;
								$stref->{'Subroutines'}{$f}
								  {'ExImplicitArgDecls'}{'Set'}{$mvar} = $decl;

#									die Dumper($stref->{'Subroutines'}{$f}{'UndeclaredOrigArgs'}{'Set'}) if $mvar eq 'a' and $f eq 'gser';
							}

							#							}
							$identified_vars->{$mvar} = 1;
						}
					}
				}
			}
			return ( $annline, [ $stref, $f, $identified_vars ] );
		} else {

			#			say Dumper($annline) if $f=~/bondfg/;
			return ( $annline, $state );
		}
	};

	my $state = [ $stref, $f, {} ];

	( $stref, $state ) =
	  stateful_pass( $stref, $f, $__analyse_vars_on_line, $state,
		'_analyse_variables() ' . __LINE__ );
	if ( defined $stref->{'Subroutines'}{$f}{'ExGlobArgDecls'}
		and scalar @{ $stref->{'Subroutines'}{$f}{'ExGlobArgDecls'}{'List'} } >
		0 )
	{
		$Sf->{'HasCommons'} = 1;
	}

	#	if ($f eq 'ifdata') {croak Dumper($stref->{'Subroutines'}{$f}{'Vars'})};
	return $stref;
}    # END of _analyse_variables()

sub _resolve_conflicts_with_params {
	( my $stref, my $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};

	#	local $V = 1;
	#	local $W -= 1;
	#	local $I = 1;
	for my $inc ( keys %{ $Sf->{'Includes'} } ) {
		if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {

			# See if there are any conflicts between parameters and ex-globals
			for my $mpar ( @{ $Sf->{'Globals'}{'List'} } ) {
				if (
					exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{'Set'}
					{$mpar} )
				{
					my $commoninc = $Sf->{'Globals'}{'Set'}{$mpar}{'Inc'};
					print
"WARNING: $mpar from $inc conflicts with $mpar from $commoninc\n"
					  if $W;

# So we store the new name, the Common include and the Parameter include in that order
					$Sf->{'ConflictingGlobals'}{$mpar} =
					  [ $mpar . '_GLOB_' . $commoninc, $commoninc, $inc ]
					  ;    # In fact, just $commoninc is enough
					$stref->{'IncludeFiles'}{$commoninc}{'ConflictingGlobals'}
					  {$mpar} = [ $mpar . '_GLOB_' . $inc, $commoninc, $inc ];
					$stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
					  {$mpar} = [ $mpar . '_GLOB_' . $inc, $commoninc, $inc ];

#                          print "CONFLICTING GLOBAL PARAMETER: $mpar in $f and $inc\n";
				}
			}

		}
	}

	$Sf->{'ConflictingParams'} = {};
	for my $inc ( keys %{ $Sf->{'Includes'} } ) {
		if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
			if ( exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'} ) {
				%{ $Sf->{'ConflictingParams'} } = (
					%{ $Sf->{'ConflictingParams'} },
					%{ $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'} }
				);
			}
		}
	}

	return $stref;
}    # END of _resolve_conflicts_with_params

# Create an entry 'RefactoredArgs'
sub _create_refactored_args {
	( my $stref, my $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	if ( exists $Sf->{'ExGlobArgDecls'} and exists $Sf->{'OrigArgs'} ) {
		$Sf->{'RefactoredArgs'}{'List'} =
		  ordered_union( $Sf->{'OrigArgs'}{'List'},
			$Sf->{'ExGlobArgDecls'}{'List'} );
		$Sf->{'RefactoredArgs'}{'Set'} = {
			%{ $Sf->{'UndeclaredOrigArgs'}{'Set'} },
			%{ $Sf->{'DeclaredOrigArgs'}{'Set'} },
			%{ $Sf->{'ExGlobArgDecls'}{'Set'} }
		};
		$Sf->{'HasRefactoredArgs'} = 1;

	} elsif ( not exists $Sf->{'ExGlobArgDecls'} ) {

		# No ExGlobArgDecls, so Refactored = Orig
		$Sf->{'RefactoredArgs'}{'Set'}  = $Sf->{'OrigArgs'}{'Set'};
		$Sf->{'RefactoredArgs'}{'List'} = $Sf->{'OrigArgs'}{'List'};
		$Sf->{'HasRefactoredArgs'}      = 0;
	} elsif ( not exists $Sf->{'OrigArgs'} ) {

		# No ExGlobArgDecls, so Refactored = Orig
		$Sf->{'RefactoredArgs'}    = $Sf->{'ExGlobArgDecls'};
		$Sf->{'HasRefactoredArgs'} = 1;
	} else {
		$Sf->{'RefactoredArgs'} = { 'Set' => {}, 'List' => [] };
		$Sf->{'HasRefactoredArgs'} = 0;
	}
	return $stref;
}

# Here we can finally check if a call arg is an unmasked intrinsic
sub _map_call_args_to_sig_args {
	( my $stref, my $f ) = @_;
	say "_map_call_args_to_sig_args($f)\n" if $DBG;
	my $__map_call_args = sub {
		( my $annline ) = @_;
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'SubroutineCall'}
			and not exists $info->{'SubroutineCall'}{'IsExternal'} )
		{
			my $sub = $info->{'SubroutineCall'}{'Name'};

			$info->{'SubroutineCall'}{'ArgMap'} =
			  {}; # A map from the sig arg to the call arg, because there can be duplicate call args but not sig args

			my $call_args = $info->{'SubroutineCall'}{'Args'}{'List'};

		 #				croak Dumper($info) if exists $info->{'CallArgs'}{'Set'}{'float'};
			for my $call_arg_expr ( @{ $info->{'CallArgs'}{'List'} } ) {

#					croak Dumper($info->{'CallArgs'}{'Set'}{$call_arg_expr}) if $call_arg_expr =~/float/;
				my $call_arg = $call_arg_expr;
				if ( $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Type'} eq
					'Array' )
				{
					$call_arg =
					  $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Arg'};
				}
				if (   exists $F95_intrinsics{$call_arg}
					or exists $F95_reserved_words{$call_arg} )
				{
					if (
						not
						exists $stref->{'Subroutines'}{$sub}{'MaskedIntrinsics'}
						{$call_arg} )
					{

						# This is an unmasked intrinsic, set to 'Sub'!
						say "INFO: Unmasked intrinsic $call_arg in $f" if $I;
						$info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Type'} =
						  'Sub';
					} else {
						say "Intrinsic $call_arg is MASKED in $f";
					}
				}
			}
			my $i = 0;
			for my $sig_arg (
				@{ $stref->{'Subroutines'}{$sub}{'OrigArgs'}{'List'} } )
			{
				my $call_arg_expr = $call_args->[$i];

	 #					my $call_arg = $call_arg_expr;
	 #					if ( $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Type'} eq 'Array') {
	 #						$call_arg = $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Arg'};
	 #					}
				$info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} = $call_arg_expr;
				$i++;
			}
		}
		return $annline;
	};

	my $state = [ $stref, $f, {} ];
	( $stref, $state ) = stateless_pass( $stref, $f, $__map_call_args,
		'_map_call_args_to_sig_args() ' . __LINE__ );

	return $stref;
}    # END of _map_call_args_to_sig_args()

sub _analyse_var_decls_for_params {
	( my $stref, my $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};

	# So now I need a list of _all_ variable declarations in the system.
	#	say "Vars";
	my $var_recs   = get_vars_from_set( $Sf->{'Vars'} );
	my %found_pars = ();

	#	if ($f eq 'partdep' ) {
	#		say Dumper($Sf->{'Args'}).Dumper($var_recs->{'density'});croak;
	#		}
	for my $var ( keys %{$var_recs} ) {
		my $var_rec = $var_recs->{$var};

		#		if ($f eq 'partdep' and $var eq 'density') {
		#		say Dumper($var_rec) ;croak;
		#		}
		if (    ref($var_rec) eq 'HASH'
			and exists $var_rec->{'Dim'}
			and @{ $var_rec->{'Dim'} } > 0 )
		{
			for my $dim ( @{ $var_rec->{'Dim'} } ) {
				if ( ref($dim) eq 'ARRAY' ) {
					for my $bound ( @{$dim} ) {
						next if $bound =~ /^\d+$/;
						my @pars = split( /\W+/, $bound );
						for my $par (@pars) {
							next if $par =~ /^\d+$/;

						  #					say "FOUND PAR $par in var decl for $var in $f";
							$found_pars{$par} = $var;

		  #					say Dumper( get_var_record_from_set($Sf->{'Parameters'},$par) );
						}
					}
				} else {
					croak "SHOULD NOT HAPPEN";
					next if $dim =~ /^\d+$/;
					my @pars = split( /\W+/, $dim );
					for my $par (@pars) {
						say "FOUND2 PAR $par in var decl for $var in $f";
						$found_pars{$par} = $var;
					}
				}
			}
		}
	}
	for my $par ( keys %found_pars ) {
		my $var = $found_pars{$par};

		#		say "FOUND PAR $par in var decl for $var in $f";
		for my $inc ( keys %{ $Sf->{'Includes'} } ) {
			if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
				if (
					in_nested_set(
						$stref->{'IncludeFiles'}{$inc},
						'Parameters', $par
					)
				  )
				{

					#					say "FOUND PAR $par decl in $inc";
					$Sf->{'Includes'}{$inc}{'Only'}{$par} = 1;
				}
			}
		}
	}

	return $stref;
}

sub _lift_param_includes {
	( my $stref, my $f ) = @_;

	#	say "PARAM INCL For $f?";
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod}{$f};
	for my $inc ( keys %{ $Sf->{'Includes'} } ) {

		#		say "INC: $inc";
		if ( exists $stref->{'IncludeFiles'}{$inc}{'ParamInclude'} ) {

			my $param_include = $stref->{'IncludeFiles'}{$inc}{'ParamInclude'};

			#			say "FOUND PARAM INCLUDE $param_include FOR $f via $inc!";
			$Sf->{'Includes'}{$param_include} = { 'Only' => {} };
		}
	}
	return $stref;
}

1;
