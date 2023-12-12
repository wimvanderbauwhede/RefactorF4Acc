package RefactorF4Acc::Analysis::Arguments;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( ordered_union );
use RefactorF4Acc::Refactoring::Helpers qw( get_f95_var_decl stateless_pass_inplace );
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast );
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

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
	determine_ExGlobArgs
	find_argument_declarations
	resolve_conflicts_with_params
	create_RefactoredArgs
	create_RefactoredArgs_for_ENTRY
	map_call_args_to_sig_args
	identify_external_proc_args
	analyse_var_decls_for_params
);

# -----------------------------------------------------------------------------
# If the sub has arguments but they were not declared, see if we can find the declarations in include files, otherwise use implicit rules
# This is like _analyse_variables but for arguments
sub find_argument_declarations {
	( my $stref, my $f ) = @_;
	my $once               = 1;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};

	for my $arg ( @{ $Sf->{'OrigArgs'}{'List'} } ) {
		if ( not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$arg} ) {
			say "MISSING ORIG ARG DECLS for '$f'" if $V and $once;
			$once = 0;
			say "ARG: $arg" if $DBG;
			my $in_incl = 0;
			for my $inc ( keys %{ $Sf->{'Includes'} } ) {
				my $subset = in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $arg );
				if ( $subset ne '' ) {
					say "FOUND DECL for $arg in INC $inc" if $DBG;
					my $decl = $stref->{'IncludeFiles'}{$inc}{$subset}{'Set'}{$arg};
					push @{ $Sf->{'ExInclArgs'}{'List'} }, $arg;
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
	return $stref;
}    # END of find_argument_declarations


sub resolve_conflicts_with_params {
	( my $stref, my $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};

	#	local $V = 1;
	#	local $W -= 1;
	#	local $I = 1;
	for my $inc ( keys %{ $Sf->{'Includes'} } ) {
		if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {

			# See if there are any conflicts between parameters and ex-globals
			my $maybe_ex_globs = $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'};
			for my $mpar ( @{ $maybe_ex_globs } ) {
				if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{'Set'}{$mpar} ) {
					my $commoninc = $Sf->{'ExGlobArgs'}{'Set'}{$mpar}{'Inc'};    # So we must say $f if there is no inc
					print "WARNING: $mpar from $inc conflicts with $mpar from $commoninc\n"
					  if $W;

					# So we store the new name, the Common include and the Parameter include in that order
					$Sf->{'ConflictingGlobals'}{$mpar}                                = [ $mpar . '_GLOB_' . $commoninc, $commoninc, $inc ];    # In fact, just $commoninc is enough
					$stref->{'IncludeFiles'}{$commoninc}{'ConflictingGlobals'}{$mpar} = [ $mpar . '_GLOB_' . $inc,       $commoninc, $inc ];
					$stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$mpar}       = [ $mpar . '_GLOB_' . $inc,       $commoninc, $inc ];

					#                          print "CONFLICTING GLOBAL PARAMETER: $mpar in $f and $inc\n";
				}
			}

		}
	}

	$Sf->{'ConflictingParams'} = {};
	for my $inc ( keys %{ $Sf->{'Includes'} } ) {
		if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
			if ( exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'} ) {
				%{ $Sf->{'ConflictingParams'} } = ( %{ $Sf->{'ConflictingParams'} }, %{ $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'} } );
			}
		}
	}

	return $stref;
}    # END of resolve_conflicts_with_params

# Create 'RefactoredArgs'
# These are sig args, not call args
sub create_RefactoredArgs {
	( my $stref, my $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
    return $stref unless defined $Sf->{'Source'};

	# So for the Mismatched
	if (not exists $stref->{'Subroutines'}{$f}{'HasCommonVarMismatch'}) {

	if ( exists $Sf->{'ExGlobArgs'}{'List'} and scalar @{$Sf->{'ExGlobArgs'}{'List'}}>0 and scalar @{ $Sf->{'OrigArgs'}{'List'} } >0
	) {
		$Sf->{'RefactoredArgs'}{'List'} = ordered_union( $Sf->{'OrigArgs'}{'List'}, $Sf->{'ExGlobArgs'}{'List'} );
		$Sf->{'RefactoredArgs'}{'Set'} = { %{ $Sf->{'UndeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'DeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'ExGlobArgs'}{'Set'} } };
		$Sf->{'HasRefactoredArgs'} = 1;
# carp 'HERE: RefactoredArgs w4 Type: '. $Sf->{'RefactoredArgs'}{'Set'}{'w4'}{Type} if $f eq 'mult_chk';
	} elsif ( exists $Sf->{'ExGlobArgs'}{'List'} and  scalar @{$Sf->{'ExGlobArgs'}{'List'}}==0
	and scalar @{ $Sf->{'OrigArgs'}{'List'} } >0
	) {

		# No ExGlobArgs, so Refactored = Orig
		for my $arg (  @{$Sf->{'OrigArgs'}{'List'}} ) {
			my $set = in_nested_set($Sf,'OrigArgs',$arg);
			$Sf->{'RefactoredArgs'}{'Set'}{$arg}  = $Sf->{$set}{'Set'}{$arg};
		}
		$Sf->{'RefactoredArgs'}{'List'} = $Sf->{'OrigArgs'}{'List'};
		$Sf->{'HasRefactoredArgs'}      = 0;
		# carp 'HERE1: RefactoredArgs w4 Type: '. $Sf->{'RefactoredArgs'}{'Set'}{'w4'}{Type} if $f eq 'mult_chk';
	} elsif (  exists $Sf->{'ExGlobArgs'}{'List'} and  scalar @{$Sf->{'ExGlobArgs'}{'List'}}>0
	and scalar @{ $Sf->{'OrigArgs'}{'List'} } ==0
	) {
		# No ExGlobArgs, so Refactored = Orig
		$Sf->{'RefactoredArgs'}    = $Sf->{'ExGlobArgs'};
		$Sf->{'HasRefactoredArgs'} = 1;
		# carp 'HERE3: RefactoredArgs w4 Type: '. $Sf->{'RefactoredArgs'}{'Set'}{'w4'}{Type} if $f eq 'mult_chk';
	} else { # No args at all, implies Globals that have not yet been resolved
		$Sf->{'RefactoredArgs'} = { 'Set' => {}, 'List' => [] };
		$Sf->{'HasRefactoredArgs'} = 0;
		# carp 'HERE4: RefactoredArgs w4 Type: '. $Sf->{'RefactoredArgs'}{'Set'}{'w4'}{Type} if $f eq 'mult_chk';
	}

	} else {

	if ( exists $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'}
	and scalar @{$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'}}>0
	and scalar @{ $Sf->{'OrigArgs'}{'List'} } >0
	) {

		$Sf->{'RefactoredArgs'}{'List'} = ordered_union( $Sf->{'OrigArgs'}{'List'}, $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} );
		$Sf->{'RefactoredArgs'}{'Set'} = { %{ $Sf->{'UndeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'DeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'} } };
		$Sf->{'HasRefactoredArgs'} = 1;

	} elsif ( exists $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} and  scalar @{$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'}}==0
	and scalar @{ $Sf->{'OrigArgs'}{'List'} } >0
	) {

		# No ExMismatchedCommonArgs, so Refactored = Orig
		$Sf->{'RefactoredArgs'}{'Set'}  = $Sf->{'OrigArgs'}{'Set'};
		$Sf->{'RefactoredArgs'}{'List'} = $Sf->{'OrigArgs'}{'List'};
		$Sf->{'HasRefactoredArgs'}      = 0;
	} elsif (  exists $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} and  scalar @{$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'}}>0
	and scalar @{ $Sf->{'OrigArgs'}{'List'} } ==0
	) {
		# No OrigArgs, so Refactored = ExMismatchedCommonArgs
		$Sf->{'RefactoredArgs'}    = $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'};
		$Sf->{'HasRefactoredArgs'} = 1;
	} else { # No args at all, implies Globals that have not yet been resolved
		$Sf->{'RefactoredArgs'} = { 'Set' => {}, 'List' => [] };
		$Sf->{'HasRefactoredArgs'} = 0;
	}

	}
	# carp 'HERE2: RefactoredArgs w4 Type: '. $Sf->{'RefactoredArgs'}{'Set'}{'w4'}{Type} if $f eq 'mult_chk';
	return $stref;
} # END of create_RefactoredArgs

# Create 'RefactoredArgs' for Entries
# TODO: make this work with mismatched COMMON vars
sub create_RefactoredArgs_for_ENTRY {
	( my $stref, my $f ) = @_;
	my $Spf = $stref->{'Subroutines'}{$f};

	for my $f ( 	@{ $Spf->{'Entries'}{'List'} } ) {
		my $Sf =  $Spf->{'Entries'}{'Set'}{$f};

		if ( exists $Spf->{'ExGlobArgs'} and exists $Sf->{'OrigArgs'}
		and  exists $Spf->{'ExGlobArgs'}{'List'} and exists $Sf->{'OrigArgs'}{'List'}
		) {

			$Sf->{'RefactoredArgs'}{'List'} = ordered_union( $Sf->{'OrigArgs'}{'List'}, $Spf->{'ExGlobArgs'}{'List'} );
			$Sf->{'RefactoredArgs'}{'Set'} = { %{ $Sf->{'UndeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'DeclaredOrigArgs'}{'Set'} }, %{ $Spf->{'ExGlobArgs'}{'Set'} } };
			$Sf->{'HasRefactoredArgs'} = 1;

		} elsif ( not exists $Spf->{'ExGlobArgs'}
		and exists $Sf->{'OrigArgs'}{'List'}
		) {
			# No ExGlobArgs, so Refactored = Orig
			$Sf->{'RefactoredArgs'}{'Set'}  = $Sf->{'OrigArgs'}{'Set'};
			$Sf->{'RefactoredArgs'}{'List'} = $Sf->{'OrigArgs'}{'List'};
			$Sf->{'HasRefactoredArgs'}      = 0;
		} elsif ( not exists $Sf->{'OrigArgs'}
		and  exists $Spf->{'ExGlobArgs'}{'List'}
		) {
			# No ExGlobArgs, so Refactored = Orig
			$Sf->{'RefactoredArgs'}    = $Spf->{'ExGlobArgs'};
			$Sf->{'HasRefactoredArgs'} = 1;
		} else {
			$Sf->{'RefactoredArgs'} = { 'Set' => {}, 'List' => [] };
			$Sf->{'HasRefactoredArgs'} = 0;
		}
	}

	return $stref;
} # END of create_RefactoredArgs_for_ENTRY

# Here we can finally check if a call arg is an unmasked intrinsic
sub map_call_args_to_sig_args {
	( my $stref, my $f ) = @_;
	say "map_call_args_to_sig_args($f)\n" if $DBG;
	my $__map_call_args = sub {
		( my $annline ) = @_;
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'SubroutineCall'}
			and not exists $info->{'SubroutineCall'}{'IsExternal'} )
		{
			my $sub = $info->{'SubroutineCall'}{'Name'};

			$info->{'SubroutineCall'}{'ArgMap'} = {};    # A map from the sig arg to the call arg, because there can be duplicate call args but not sig args

			my $call_arg_exprs = $info->{'SubroutineCall'}{'Args'}{'List'};

			for my $call_arg_expr ( @{ $call_arg_exprs } ) {
				my $call_arg = $call_arg_expr;
				if ( $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr}{'Type'} eq 'Array' ) {
					$call_arg = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr}{'Arg'};
				}
				if (   exists $F95_intrinsics{$call_arg}
					or exists $F95_reserved_words{$call_arg} )
				{
					if ( not exists $stref->{'Subroutines'}{$sub}{'MaskedIntrinsics'}{$call_arg} ) {

						# This is an unmasked intrinsic, set to 'Sub'!
						say "INFO: Unmasked intrinsic $call_arg in $f" if $I;
						$info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr}{'Type'} = 'Sub';
					} else {
						say "Intrinsic $call_arg is MASKED in $f";
					}
				}
			}

			my $i = 0;
			for my $sig_arg ( @{ $stref->{'Subroutines'}{$sub}{'OrigArgs'}{'List'} } ) {
				my $call_arg_expr = $call_arg_exprs->[$i];
				# This means that to get the type information, we need
				# $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr}
				# Which is OK as long as $call_arg_expr is defined!

				# This is an UGLY HACK, FIXME!!! I should find out why it was blank instead!
				if (not defined $call_arg_expr) {
						my $expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'}[$i+1];
				}

				$info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} = $call_arg_expr;
				$i++;
			}
			# The problem is that at this stage, we don't have the ex-COMMON args in the ArgMap

		}

		if ( exists $info->{'FunctionCalls'} ) {
			for my $fcall_rec (@{$info->{'FunctionCalls'}}) {

				my $sub = $fcall_rec->{'Name'};

				$fcall_rec->{'ArgMap'} = {};    # A map from the sig arg to the call arg, because there can be duplicate call args but not sig args

				my $call_args = $fcall_rec->{'Args'}{'List'};

				for my $call_arg_expr ( @{ $fcall_rec->{'Args'}{'List'} } ) {

					my $call_arg = $call_arg_expr;
					if ( $fcall_rec->{'Args'}{'Set'}{$call_arg_expr}{'Type'} eq 'Array' ) {
						$call_arg = $fcall_rec->{'Args'}{'Set'}{$call_arg_expr}{'Arg'};
					}
					if (   exists $F95_intrinsics{$call_arg}
						or exists $F95_reserved_words{$call_arg} )
					{
						if ( not exists $stref->{'Subroutines'}{$sub}{'MaskedIntrinsics'}{$call_arg} ) {

							# This is an unmasked intrinsic, set to 'Sub'!
							say "INFO: Unmasked intrinsic $call_arg in $f" if $I;
							$fcall_rec->{'Args'}{'Set'}{$call_arg_expr}{'Type'} = 'Sub';
						} else {
							say "Intrinsic $call_arg is MASKED in $f";
						}
					}
				}

				my $i = 0;
				for my $sig_arg ( @{ $stref->{'Subroutines'}{$sub}{'OrigArgs'}{'List'} } ) {
					my $call_arg_expr = $call_args->[$i];
					$fcall_rec->{'ArgMap'}{$sig_arg} = $call_arg_expr;
					$i++;
				}
			}
		}

		return [$annline];
	};

	my $state = [ $stref, $f, {} ];
	( $stref, $state ) = stateless_pass_inplace( $stref, $f, $__map_call_args, 'map_call_args_to_sig_args() ' . __LINE__ );

	return $stref;
}    # END of map_call_args_to_sig_args()


sub identify_external_proc_args {
	( my $stref, my $f ) = @_;
	say "_identify_external_proc_args($f)\n" if $DBG;
	# WV: the following only works if the file containing $f was already read.
	# If not this is likely because $f is never called.

	my $__mark_args_as_external = sub {
		( my $annline ) = @_;
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'SubroutineCall'}
			and not exists $info->{'SubroutineCall'}{'IsExternal'} )
		{
			my $sub = $info->{'SubroutineCall'}{'Name'};
			for my $sig_arg ( @{ $stref->{'Subroutines'}{$sub}{'OrigArgs'}{'List'} } ) {

				my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};

				if (defined $call_arg) {
					if (exists $stref->{'Subroutines'}{$f}{'External'}{$call_arg}) {
						my $set = in_nested_set($stref->{'Subroutines'}{$sub},'Vars',$sig_arg);
						say "WARNING: In proc $f, in call to sub $sub, arg $call_arg is EXTERNAL for signature arg $sig_arg" if $W;
						say "WARNING: In proc $f, in call to sub $sub, arg $call_arg is EXTERNAL so setting signature $sig_arg attr External in set $set" if $DBG;
						$stref->{'Subroutines'}{$sub}{$set}{'Set'}{$sig_arg}{'External'}=1;
					}
				}
			}
		}
		return [$annline];
	};

	 $stref = stateless_pass_inplace( $stref, $f, $__mark_args_as_external, '__mark_args_as_external() ' . __LINE__ );

	return $stref;
}    # END of identify_external_proc_args()


sub analyse_var_decls_for_params {
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
					croak "SHOULD NOT HAPPEN ".Dumper($var_rec) if $DBG;
					next if $dim =~ /^\d+$/;
					my @pars = split( /\W+/, $dim );
					for my $par (@pars) {
						# say "FOUND2 PAR $par in var decl for $var in $f";
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
				if ( in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Parameters', $par ) ) {

					#					say "FOUND PAR $par decl in $inc";
					$Sf->{'Includes'}{$inc}{'Only'}{$par} = 1;

				}
			}
		}
	}

	return $stref;
} # END of analyse_var_decls_for_params

# We do a recusive descent for all called subroutines, and for the leaves we do the analysis.
# TODO: in principle this should also work for called functions ...
# TODO: the new approach for mismatched COMMON vars only works with direct callers, so if f calls g and g calls h then f is not considered a caller
# TODO: So if f has COMMON blocks and it calls h via g, and g does not have COMMON blocks, then we have the situation where g should get the args to be passed on to h
# Currently this will not work: the CallArgs are based on the direct caller
# To make it work correctly, the direct caller must inherit the COMMON vars from the caller, as-is.
sub determine_ExGlobArgs {
	( my $f, my $stref ) = @_;
	# local $I=1;
	my $c;
	if ($V) {
		$c = ( defined $stref->{Counter} ) ? $stref->{Counter} : 0;
		say "\t" x $c, $f;
	}
	# For the Mismatched COMMON vars, we use SigArgs instead of ExGlobArgs
    push @{ $stref->{'CallStack'} }, $f;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} };

	my $Sf = $stref->{'Subroutines'}{$f};
	if ( exists $Sf->{'CalledSubs'}{'List'}
		and scalar @{ $Sf->{'CalledSubs'}{'List'} } > 0 ) {

		# First we must look up the call stack for the 'current' exglobargs, this is quite the same as in the leaf node
		$stref = __determine_exglobargs_core( $stref, $f );
		# Then we must create the union of all exglobargs of all called subroutines
		# There is a possible complication that f1 can have v1 from b1 and f2 v1 from b2
		# But I am going to ignore that and blindly merge all exglobargs
		for my $called_sub_or_entry ( @{ $Sf->{'CalledSubs'}{'List'} } ) {

			my $calledsub = $called_sub_or_entry;
			if (exists  $stref->{'Entries'}{$called_sub_or_entry} ) {
				$calledsub = $stref->{'Entries'}{$called_sub_or_entry};
			}

			next if exists $stref->{'ExternalSubroutines'}{$calledsub}; # Don't descend into external subs
			if (exists $subs{$calledsub}) {
				# say "WARNING: determine_ExGlobArgs: LOOP for $calledsub: ".join(', ', @{ $stref->{'CallStack'} }) if $W;
				warning("CALL LOOP for $calledsub in $f. This does not conform to the ANSI X3.9-1978 standard, proceed at your peril!",1);
				warning( '<'.join(', ', @{ $stref->{'CallStack'} }).'>',2);
				next;
			}
			$stref->{Counter}++ if $V;
			$stref = determine_ExGlobArgs( $calledsub, $stref );
			# This would be fine if the called sub has no overlap with the original sub
			# The problem is that sometimes we have the same name variable with a different type in the called sub and the caller
			# $Sf->{'ExGlobArgs'}{'Set'} = { %{ $Sf->{'ExGlobArgs'}{'Set'} }, %{ $stref->{'Subroutines'}{$calledsub}{'ExGlobArgs'}{'Set'} } };
			for my $called_var (sort keys %{ $stref->{'Subroutines'}{$calledsub}{'ExGlobArgs'}{'Set'} } )  {
				if (not exists $Sf->{'ExGlobArgs'}{'Set'}{$called_var}) {
					$Sf->{'ExGlobArgs'}{'Set'}{$called_var} = $stref->{'Subroutines'}{$calledsub}{'ExGlobArgs'}{'Set'}{$called_var};
				}
				# else {
				# 	carp "$called_var from $calledsub already defined in $f";
				# }
			}

			$stref->{Counter}-- if $V;
		}
		say "\t" x $c, "--------" if $V;
		$Sf->{'ExGlobArgs'}{'List'} =[ sort keys %{ $Sf->{'ExGlobArgs'}{'Set'} } ];
		# When do we come here?

	} else {
		$stref = __determine_exglobargs_core( $stref, $f );
	}
	pop  @{ $stref->{'CallStack'} };


	return $stref;
}    # determine_ExGlobArgs()


# For BLOCK DATA, we create a new argument for every common block variable, by copying ${Var}_ARG into ExGlobArgs.
# This will automatically create the additional argument declarations.
# We are only renaming (must dclone and change 'Name' though)

sub __determine_exglobargs_core { ( my $stref, my $f ) = @_;
# local $I=1;
# local $V=1;
	my $Sf = $stref->{'Subroutines'}{$f};

	my $is_block_data = exists $Sf->{'BlockData'} ? 1 : 0;

	# Get declarations from CommonVars
	my $common_decls_current = __get_common_decls($stref,$f);

	# Determine if this $var occurs in $common_block_name anywhere up the stack
	# So either I go for every var through all callers or for every caller through all vars
	# Or better: create an intermediate datastructure $var => { $block => {$f =>1, ...} }
	my $common_decls_callers ={};
	for my $caller (@{$stref->{'CallStack'}}) {
		my $common_decls_caller=__get_common_decls($stref,$caller);
		for my $var (keys %{ $common_decls_caller }) {
			if ($DBG and not exists $common_decls_caller->{$var}{'CommonBlockName'}) {
				croak "$caller => $var => ".Dumper($common_decls_caller->{$var});
			}
			my $common_block_name = $common_decls_caller->{$var}{'CommonBlockName'};
			$common_decls_callers->{$var}{$common_block_name}{$caller}=1;
		}
	}
	# Now I go through all vars in $common_decls_current and test
	# If a var occurs in any caller, it must become an ExGlobArg
	for my $var (keys %{ $common_decls_current }) {
		my $decl = $common_decls_current->{$var};

		my $common_block_name = $decl->{'CommonBlockName'};
		if (exists	$common_decls_callers->{$var}{$common_block_name} ) {
#			say Dumper( $common_decls_callers->{$var}{$common_block_name} );
			if (not $is_block_data) {
				$Sf->{'ExGlobArgs'}{'Set'}{$var}=$decl;
			} else {
				# BLOCK DATA
				say "INFO: RENAMING ARGS FOR BLOCK DATA" if $I;
				my $mod_decl = dclone($decl);
				$mod_decl->{'Name'}=$var.'_ARG';
				$mod_decl->{'OrigName'}=$var;
				$Sf->{'ExGlobArgs'}{'Set'}{$var.'_ARG'}=$mod_decl ;
			}
		}

	}
	$Sf->{'ExGlobArgs'}{'List'} =[ sort keys %{ $Sf->{'ExGlobArgs'}{'Set'} } ];
	return $stref;
} # END of __determine_exglobargs_core()

# This returns a hash $varname => $common_block_name
sub __get_common_decls { ( my $stref, my $f ) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod}{$f};
	my $common_decls = get_vars_from_set($Sf->{'CommonVars'});
	return $common_decls;
} # END of __get_common_decls()

# This returns a hash $varname => $common_block_name
sub __get_exglobarg_decls { ( my $stref, my $f ) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod}{$f};
	my $exglobarg_decls = get_vars_from_set($Sf->{'ExGlobArgs'});
	return $exglobarg_decls;
} # END of __get_exglobarg_decls()


1;
