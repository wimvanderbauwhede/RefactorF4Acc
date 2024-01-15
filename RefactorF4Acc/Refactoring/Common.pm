# Refactoring of COMMON blocks

package RefactorF4Acc::Refactoring::Common;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Parser qw( parse_fortran_src );
use RefactorF4Acc::Refactoring::Helpers qw(
	emit_f95_var_decl
	splice_additional_lines_cond_inplace
	);
# use RefactorF4Acc::Refactoring::ContextFree qw( context_free_refactorings );
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( create_refactored_subroutine_signature refactor_subroutine_signature );
use RefactorF4Acc::Refactoring::Subroutines::IncludeStatements qw( skip_common_include_statement );
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast  find_vars_in_ast parse_expression_no_context );

use RefactorF4Acc::Analysis::Arrays qw(
  calculate_array_size
  get_array_rank
);
use RefactorF4Acc::Refactoring::Casts qw( cast_call_argument );
use Fortran::F95VarDeclParser qw( parse_F95_var_decl );

use vars qw( $VERSION );
$VERSION = "5.1.0";

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  refactor_COMMON_blocks_and_CONTAINed_subs
);

# -----------------------------------------------------------------------------

# WV 2021-06-08 This is a misnomer because it also inlines parameter decls from modules in which subs are contained
# WV 2023-10-05 Worse, it creates the declarations for ex-implicits as well.

# The problem with this routine is as follows: the refactoring of the signature happens when it is encountered.
# But any subsequent call to a subroutine can result in new arguments being added to ExGlobArgDecls
# In principle this should have been dealt with by the inheritance algorithm, what goes wrong here?

#- creates a refactored subroutine sig based on RefactoredArgs
#- skips Common include statements, so it only keeps Parameter (I hope)
#- creates ex-glob arg declarations, basically we have to look at ExInclArgs, UndeclaredOrigArgs and ExGlobArgs.
#- creates ex-implicit var declarations
#- create_refactored_subroutine_call, I hope we can keep this
sub refactor_COMMON_blocks_and_CONTAINed_subs {  # 218 lines Was _refactor_globals_new
	( my $stref, my $f, my $annlines ) = @_;

	my $Sf = $stref->{'Subroutines'}{$f};

	if ( $Sf->{'RefactorGlobals'} == 2 ) {
		croak "This should NEVER happen!";
	}
	if (not exists $Sf->{'HasCommons'} or not $Sf->{'HasCommons'} ) {
		say "INFO: no COMMON blocks in $f" if $I;
		# return ($stref,$annlines); # This is wrong because this routine does more
	}

	# WV 2023-12-15: The par_decl_lines_from_container and par_decl_lines_from_module should I think be replaced by the ParametersFromContainer approach
	my @par_decl_lines_from_container = ();
	# carp "$f: ".Dumper($Sf->{'ParametersFromContainer'});
	for my $par ( @{$Sf->{'ParametersFromContainer'}{'List'}} ) {
		my $par_decl      = $Sf->{'ParametersFromContainer'}{'Set'}{$par};
		my $par_decl_line = emit_f95_var_decl($par_decl);
		my $pt = parse_F95_var_decl($par_decl_line);
		my $par_decl_annline = [
			'      ' . $par_decl_line,
			{
				'ParamDecl' => $par_decl,
				'ParsedParDecl' => $pt,
				'Ann'       => [ annotate( $f, __LINE__ ) ],
				'SpecificationStatement' => 1,
				'Ref' => 1
			} ];
		push @par_decl_lines_from_container, $par_decl_annline;
	}

	print "REFACTORING GLOBALS in $f\n" if $V;
	my $rlines = [];
	my $s      = $Sf->{'Source'};

	my $inc_counter = scalar keys %{ $Sf->{'Includes'} };
	my $first_non_spec_stmt=1;
	my $first_vardecl = 1;
	# Loop over all lines in $f
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		my $skip = 0;

		# Create the refactored subroutine signature
		if ( exists $info->{'Signature'} ) {
			if ( not exists $Sf->{'HasRefactoredArgs'}
				or $Sf->{'HasRefactoredArgs'} == 0 )
			{
				# This probably means the subroutine has no arguments at all.
				# Do this before the analysis for RefactoredArgs! TODO!
				# NOTE: refactor_subroutine_signature() only adds ex-globals that where declared as COMMON in Includes
				$stref = refactor_subroutine_signature( $stref, $f );
			}

			# create_refactored_subroutine_signature() emits the new signature using RefactoredArgs as the args
			$rlines = create_refactored_subroutine_signature( $stref, $f, $annline, $rlines );
			$rlines = [ @{$rlines}, @par_decl_lines_from_container];#, @par_decl_lines_from_module ];
			$skip   = 1;
		}
		# There should be no need to do this: all /common/ blocks should have been removed anyway!
		# This adds $info->{'Include'}{'Name'} = $param_inc;
		elsif ( exists $info->{'Include'} ) {

			# TODO: test if this is obsolete
			--$inc_counter;
			$skip = skip_common_include_statement( $stref, $f, $annline );

			# Now, if this was a Common include to be skipped but it contains a Parameter include, I will simply replace the line:
			# TODO: factor out!
			my $inc = $info->{'Include'}{'Name'};
			if ( exists $stref->{'IncludeFiles'}{$inc}{'ParamInclude'} ) {
				my $param_inc = $stref->{'IncludeFiles'}{$inc}{'ParamInclude'};
				$skip = 0;
				$info->{'Include'}{'Name'} = $param_inc;
				my $mod_param_inc = $param_inc;
				$mod_param_inc =~ s/\./_/g; # This is UNUSED!
				delete $info->{'Includes'};
				push @{ $info->{'Ann'} }, annotate( $f, __LINE__ );
				$annline = [ $line, $info ];
				push @{$rlines}, $annline;
				$skip = 1;
			}

		}

		# We should either inline everything from the module or rewrite the module. I go for the former
		# In principle that is only possible if it's Inlineable
		elsif ( exists $info->{'Use'} ) {
			if ( exists $info->{'Use'}{'Inlineable'}
				and $info->{'Use'}{'Inlineable'} == 1 )
			{
				--$inc_counter;
				$skip = 1;
			} else {
				warning( "Module " . $info->{'Use'}{'Name'} . " in $f is not Inlineable" ,3);
			}
		}
		# This creates all extra arg and var decls, not just the ones for ex-globals
		elsif (
			(exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'} and $first_vardecl==1)
			or (exists $info->{'NonSpecificationStatement'} and $first_non_spec_stmt == 1)
			) {
			$first_vardecl=0;
			$first_non_spec_stmt = 0;
			say "EX-GLOBS for $f" if $V;
			$info->{'ExGlobVarDeclHook'}='Before';

			$rlines = [
				@{_create_extra_arg_and_var_decls( $stref, $f, $annline, $rlines )},
			['! END new declarations',{'Comments'=>1}],
			['',{'Blank'=>1}],
			];
		}

		if ( exists $info->{'SubroutineCall'}
		) {
			# simply tag the common vars onto the arguments
			($rlines, $stref) = _create_refactored_subroutine_call( $stref, $f, $annline, $rlines );
			$skip   = 1;
		}

		if ( exists $info->{'FunctionCalls'} ) {    #say $line, Dumper($info);
													# Assignment and Subroutine call lines can contain function calls that also need exglob refactoring!

			# If the line is a subroutine call which has function calls, we need to operate on that line
			$annline = pop @{$rlines} if exists $info->{'SubroutineCall'};
			# carp Dumper($annline);
			$rlines  = _create_refactored_function_calls( $stref, $f, $annline, $rlines );
			$skip    = 1;
		}

		push @{$rlines}, $annline unless $skip;

	}    # loop over all lines

	# I think it is best to create the additional decls for casts in a separate loop.
	# We can store them in $Sf->{'CastReshapeVarDecls'}, for convenience we would just create them and emit them
	# To have the full picture I suppose the decls should go into DeclaredLocalVars
	# The can go anywhere but I guess the best place is after all other VarDecls, so before the first non-VarDecl statement
	# We can simply do this using
	if (exists $Sf->{'CastReshapeVarDecls'}
	and exists $Sf->{'CastReshapeVarDecls'}{'List'} and scalar @{$Sf->{'CastReshapeVarDecls'}{'List'}} > 0 ) {
		my $nextLineID = scalar @{$rlines} + 1;
		my $cast_reshape_vardecl_annlines = [];
		for my $cast_reshape_vardecl (@{$Sf->{'CastReshapeVarDecls'}{'List'}}) {
		#  if ($cast_reshape_vardecl eq 'v_s1b'){ # which means inlining was done already!
		#  carp Dumper pp_annlines($Sf->{'RefactoredCode'});
		#  }
		# croak in_nested_set( $Sf, 'Vars', $cast_reshape_vardecl );
			# if (  in_nested_set( $Sf, 'Vars', $cast_reshape_vardecl ) ) {
			# 	croak;
			# }
			my $rdecl = $Sf->{'CastReshapeVarDecls'}{'Set'}{$cast_reshape_vardecl};
			$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$cast_reshape_vardecl}=$rdecl;
			my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : Cast/Reshape intermediate variable' );
				$info->{'LineID'}    = $nextLineID++;
				$info->{'Ref'}       = 1;
				$info->{'VarDecl'} = { 'Name' => $cast_reshape_vardecl };
				$info->{'SpecificationStatement'} = 1;
				push @{$cast_reshape_vardecl_annlines}, [ $rline, $info ];
		}

		my $insert_cond_subref = sub { (my $annline)=@_;
			my ($line, $info) = @{$annline};
			if (    not exists $info->{'Signature'}
			and not exists $info->{'VarDecl'}
			and not exists $info->{'`ImplicitNone`'}
			and not exists $info->{'SpecificationStatement'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Deleted'}
			) {
				return 1;
			} else {
				return 0;
			}
		};
		# Usage:
		my $merged_annlines = splice_additional_lines_cond_inplace( $stref, $f, $insert_cond_subref, $rlines, $cast_reshape_vardecl_annlines, 1, 0, 1 );
		$rlines = $merged_annlines;
	}
#- Go through the AnnLines
#- Find the hook based on a condition on the $annline (i.e. $insert_cond_subref->($annline) )
#- splice the new lines before/after the hook depending on $insert_before
#- if $once is 0, do this whenever the condition is met. Otherwise do it once
# croak Dumper $Sf->{'Parameters'} if $f eq 'dyn';
	return ($stref,$rlines);
}    # END of refactor_COMMON_blocks_and_CONTAINed_subs()


# ExInclArgs, UndeclaredOrigArgs and ExGlobArgs
# ExInclLocalVars and UndeclaredOrigLocalVars.
# I must make sure that these do not already exists!
sub _create_extra_arg_and_var_decls { #272 lines

	( my $stref, my $f, my $annline, my $rlines ) = @_;

	my $Sf         = $stref->{'Subroutines'}{$f};
	
	my $nextLineID = scalar @{$rlines} + 1;
	push @{$rlines}, ['! BEGIN new declarations',{'Comments'=>1}];

	if ( exists $Sf->{'InheritedParameters'}{'List'}
		and scalar @{ $Sf->{'InheritedParameters'}{'List'} } > 0 )
	{
		print "INFO: InheritedParameters in $f\n" if $I;

		for my $par ( @{ $Sf->{'InheritedParameters'}{'List'} } ) {
			if ( not in_nested_set( $Sf, 'Parameters', $par ) ) {
				say "INFO PAR in $f: $par " . Dumper( $Sf->{'InheritedParameters'}{'Set'}{$par} )
				  if $I;

				my $rdecl = $Sf->{'InheritedParameters'}{'Set'}{$par};
				my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : INHERITED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} );
				$info->{'LineID'}    = $nextLineID++;
				$info->{'Ref'}       = 1;
				$info->{'ParamDecl'} = { 'Name' => $par };
				$info->{'SpecificationStatement'} = 1;
				push @{$rlines}, [ $rline, $info ];
			}
		}
		push @{$rlines}, $BLANK_LINE;
	}

	if ( exists $Sf->{'ModuleParameters'}{'List'}
		and scalar @{ $Sf->{'ModuleParameters'}{'List'} } > 0 )
	{
		print "INFO: ModuleParameters in $f\n" if $I;

		for my $par ( @{ $Sf->{'ModuleParameters'}{'List'} } ) {
			# Skip any pars declared in a used module. It's either that or remove the module USE declaration. But that is more complex.
			my $skip=0;
			if (exists $Sf->{'Uses'}) {
				for my $mod (sort keys %{$Sf->{'Uses'}}) {
					if ( in_nested_set( $stref->{'Modules'}{$mod},'Vars',$par ) ) {
						$skip=1;
						last;
					}
				}
			}
			next if $skip;


			my $test_par = in_nested_set( $Sf, 'Parameters', $par );
			if ( not $test_par or $test_par eq 'ModuleParameters' ) {
				say "INFO PAR in $f: $par " . Dumper( $Sf->{'ModuleParameters'}{'Set'}{$par} )
				  if $I;
				my $rdecl = $Sf->{'ModuleParameters'}{'Set'}{$par};
				my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				$info->{'ParsedParDecl'} = {
					'Attributes' => {
						'Dim' => $rdecl->{'Dim'} ,
						'Parameter' => $rdecl->{'Parameter'} ,
					},

					'Pars' => {
						'Val' => $rdecl->{'Val'} ,
						'Var' => $rdecl->{'Var'} ,
						'AST' => $rdecl->{'AST'} ,
					},
					'TypeTup' => {
						'Type' => $rdecl->{'Type'},
					},
					'Vars' => [
						undef
					]
  				};
				push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : INCLUDED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} );
				$info->{'LineID'}    = $nextLineID++;
				$info->{'Ref'}       = 1;
				$info->{'ParamDecl'} = { 'Name' => $par };
				$info->{'SpecificationStatement'} = 1;
				push @{$rlines}, [ $rline, $info ];
			}
		}
		push @{$rlines}, $BLANK_LINE;
	}

	print "INFO: ExGlobArgs in $f\n" if $I;

	for my $var ( @{ $Sf->{'ExGlobArgs'}{'List'} } ) {
		# Skip any vars declared in a used module
		my $skip=0;
		if (exists $Sf->{'Uses'}) { 
			for my $mod (sort keys %{$Sf->{'Uses'}}) {
				if ( in_nested_set( $stref->{'Modules'}{$mod},'Vars',$var ) ) {
					$skip=1;
					last;
				}
			}
		}
		next if $skip;

		# Need to check if these were not already declared
		if (
				not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var}
			and not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$var}
			and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$var}
		  )
		{

			say "INFO VAR in $f: IODir for $var: " . $Sf->{'ExGlobArgs'}{'Set'}{$var}{'IODir'}
			  if $I and not $Sf->{'Program'};
			my $rdecl = dclone($Sf->{'ExGlobArgs'}{'Set'}{$var});
			if (not $Sf->{'Program'} and exists $rdecl->{'InitialValue'} ) { delete $rdecl->{'InitialValue'}}
			(my $inherited_param_decls, $Sf) = __generate_inherited_param_decls($rdecl, $var, $stref, $f,[]);
			my $rline = emit_f95_var_decl($rdecl);
			my $info  = {};
			push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : EX-GLOB ' . $annline->[1]{'ExGlobVarDeclHook'} ); 
			$info->{'LineID'}  = $nextLineID++;
			$info->{'Ref'}     = 1;
			$info->{'VarDecl'} = { 'Name' => $var };
			$info->{'ArgDecl'} = 1;
			$info->{'SpecificationStatement'} = 1;
			@{$rlines}=(@{$rlines},@{$inherited_param_decls});
			push @{$rlines}, [ $rline, $info ];

		}
		
	} # for

	print "INFO: ExInclArgs in $f\n" if $I;
	for my $var ( @{ $Sf->{'ExInclArgs'}{'List'} } ) {
		say "INFO VAR: $var" if $I;
		my $rdecl = $Sf->{'ExInclArgs'}{'Set'}{$var};
		my $rline = emit_f95_var_decl($rdecl);
		my $info  = {};
		push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : EX-INCL' );
		$info->{'LineID'}  = $nextLineID++;
		$info->{'Ref'}     = 1;
		$info->{'VarDecl'} = { 'Name' => $var };                            #$rdecl;
		$info->{'SpecificationStatement'} = 1;
		push @{$rlines}, [ $rline, $info ];
	}    # for

	print "INFO: UndeclaredOrigArgs in $f\n" if $I;
	my %unique_ex_impl = ();
	if (scalar keys %{ $Sf->{'UndeclaredOrigArgs'}{'Set'} } > 0) {
		my $_arg_idx=0;
		for my $var ( @{ $Sf->{'UndeclaredOrigArgs'}{'List'} } ) {

			if (not defined $var) {
				# carp "Undefined arg in position $_arg_idx in UndeclaredOrigArgs for $f";
				# croak Dumper $Sf->{'UndeclaredOrigArgs'}{'List'}, $Sf->{'DeclaredOrigArgs'}{'List'} ;
				my $mvar =  $Sf->{'DeclaredOrigArgs'}{'List'}[$_arg_idx];
				if (exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$mvar} ) {
					$var = $mvar;
				} else {
					$var = '';
				}
			}
			if (    not exists $Sf->{'ModuleGlobalVars'}{'Set'}{$var}
				and not exists $Sf->{'CalledSubs'}{'Set'}{$var} )
			{
				say "INFO VAR: $var" if $I;
				next if $var eq '*';
				if (    exists $Sf->{'CalledSubs'}
					and exists $Sf->{'CalledSubs'}{$var}
					and not exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var} )
				{
					next;
				}
				if ( exists $stref->{'ExternalSubroutines'}{$var}
					and not exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var} )
				{
					next;
				}
				if ( not exists $unique_ex_impl{$var} ) {
					$unique_ex_impl{$var} = $var;
					if (exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var}) {
						my $rdecl = $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};

						my $external   = exists $rdecl->{'External'};
						my $undeclared = exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};
						if ( not $external
							or ( $external and $undeclared ) )
						{
							my $rline = emit_f95_var_decl($rdecl);
							my $info  = {};
							push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : EX-IMPLICIT'  );
							$info->{'LineID'}  = $nextLineID++;
							$info->{'Ref'}     = 1;
							$info->{'VarDecl'} = { 'Name' => $var };
							$info->{'ArgDecl'} = 1;
							$info->{'SpecificationStatement'} = 1;
							push @{$rlines}, [ $rline, $info ];
						}
					}
				}
			}
			++$_arg_idx;
		}    # for
	} # if Set is not empty, to avoid iterating over a list full of undefs
	print "INFO: ExInclLocalVars in $f\n" if $I;
	for my $var ( @{ $Sf->{'ExInclLocalVars'}{'List'} } ) {
		say "INFO VAR: $var" if $I;
		my $rdecl = $Sf->{'ExInclLocalVars'}{'Set'}{$var};
		my $rline = emit_f95_var_decl($rdecl);
		my $info  = {};
		push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : EX-INCL VAR' );
		$info->{'LineID'}  = $nextLineID++;
		$info->{'Ref'}     = 1;
		$info->{'VarDecl'} = { 'Name' => $var };                                #$rdecl;
		$info->{'SpecificationStatement'} = 1;
		push @{$rlines}, [ $rline, $info ];
	} # for

	print "INFO: UndeclaredOrigLocalVars in $f\n" if $I;
	for my $var ( @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} } ) {

		if ( not exists $Sf->{'ModuleGlobalVars'}{'Set'}{$var} ) {

			say "INFO VAR: $var" if $I;
			if (    exists $Sf->{'CalledSubs'}
				and exists $Sf->{'CalledSubs'}{$var} )
			{
				next;
			}

			if ( exists $stref->{'Subroutines'}{$var}
				and not exists $stref->{'Subroutines'}{$f}{'Program'} )
			{
				next;
			}

			if ( exists $stref->{'ExternalSubroutines'}{$var} ) {
				next;
			}
			if ( in_nested_set( $Sf, 'DeclaredOrigLocalVars', $var ) ) {
				next;
			}
			if ( $f eq $var ) {
				next;
			}

			# Check if it is not a parameter
			my $is_param = 0;
			if (
				in_nested_set( $Sf, 'Parameters', $var )
			  )
			{
				$is_param = 1;
			}

			# I don't explicitly declare variables that conflict with reserved words or intrinsics.
			my $var_is_sub = 0;

			#WV20201209: In Parser/Expressions I set the value to 2,
			if ( exists $Sf->{'CalledSubs'}{'Set'}{$var}
				and $Sf->{'CalledSubs'}{'Set'}{$var}[0] == 1 )
			{
				$var_is_sub = 1;
			}
			if ( exists $Sf->{'External'}{$var} or exists $Sf->{'Intrinsic'}{$var}) {
				$var_is_sub = 1;
			}
			if ( exists $Sf->{$var}
				and not exists $Sf->{$var}{'Function'} )
			{
				$var_is_sub = 1;
			}

			# Skip if the variable is a subroutine
			if (

				exists $Sf->{'MaskedIntrinsics'}{$var}
				or
				(
					not exists $F95_reserved_words{$var}
				and not exists $F95_intrinsics{$var}
				and not exists $Sf->{'Namelist'}{$var}
				and not $var_is_sub
				and not $is_param
				and $var !~ /__PH\d+__/            # FIXME! TOO LATE HERE!
				and $var =~ /^[a-z][a-z0-9_]*$/    # FIXME: rather check if Expr or Sub
				)
			  )
			{
				if ( (my $subset = in_nested_set( $Sf, 'DeclaredOrigLocalVars', $var )) and $DBG ) {
					croak $subset;
				}
				# Because otherwise it means this var is declared elsewhere
				# But so then it should be in ExGlobArgs
				my $rdecl = $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var};
				$rdecl->{'Ann'} = "in $f (implicit declaration)";
				my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : EX-IMPLICIT VAR' );
				$info->{'LineID'}  = $nextLineID++;
				$info->{'Ref'}     = 1;
				$info->{'VarDecl'} = { 'Name' => $var };
				$info->{'SpecificationStatement'} = 1;
				push @{$rlines}, [ $rline, $info ];
			} else {
				say "INFO: $var is a reserved word" if $I;
				# croak Dumper($Sf->{'MaskedIntrinsics'}{$var}) if $var eq 'len';
			}
		}
	}    # for

	print "INFO: ExCommonVarDecls in $f\n" if $I;
	for my $var ( @{ $Sf->{'UndeclaredCommonVars'}{'List'} } ) {
		next if ( exists $Sf->{'ExGlobArgs'}{'Set'}{$var} );
		say "INFO VAR: $var" if $I;
		my $rdecl = $Sf->{'UndeclaredCommonVars'}{'Set'}{$var};
		my $rline = emit_f95_var_decl($rdecl);
		my $info  = {};
		push @{$info->{'Ann'}}, annotate( $f, __LINE__ . ' : EX-IMPLICIT COMMON' );
		$info->{'LineID'}  = $nextLineID++;
		$info->{'Ref'}     = 1;
		$info->{'VarDecl'} = { 'Name' => $var };                                       #$rdecl;
		$info->{'SpecificationStatement'} = 1;
		push @{$rlines}, [ $rline, $info ];
	}    # for

	return $rlines;
}    # END of _create_extra_arg_and_var_decls();


# AKA refactor_call_args, RefactorCallArgs
# This subroutine adds additional arguments to a call to $name in $f.
# What it does NOT do is update the list of variables in scope in $f.
# It should update ExGlobArgs
# Furthermore I notice that sometimes these arguments are not passed on to the containing subroutine.
# That should be an issue in the subroutine refactoring code
sub _create_refactored_subroutine_call { # 321 lines
	( my $stref, my $f, my $annline, my $rlines ) = @_;
	( my $line, my $info ) = @{$annline};
	my $name = $info->{'SubroutineCall'}{'Name'};

	my $Sf   = $stref->{'Subroutines'}{$f};

	if ( exists $stref->{'ExternalSubroutines'}{$name} ) {
		push @{$rlines}, [ $line, $info ];
		return ($rlines,$stref);
	}

	# This is in case we need intermediate variables for casting and reshaping of arguments to subroutine calls
	if (not exists $Sf->{'CastReshapeVarDecls'}) {
		$Sf->{'CastReshapeVarDecls'}={'List'=>[], 'Set'=>{}};
	}

	# Collect original args
	my @orig_args = ();
	# a shallow copy
	my $expr_ast = [ @{ $info->{'SubroutineCall'}{'ExpressionAST'} } ];
	if ( @{$expr_ast} and ( $expr_ast->[0] & 0xFF ) != 27 ) {
		$expr_ast = [$expr_ast];
	} else {
		shift @{$expr_ast};
	}
	my @cast_reshape_results=();

	for my $call_arg_expr ( @{$expr_ast} ) {
		# The main purpose is to handle variable names
		# So this is rather weak because e.g. v(i) will not be in Vars.
		# So this only works for plain variable names
		my $call_arg = emit_expr_from_ast($call_arg_expr);
		# carp Dumper($call_arg_expr);
		my $has_vars = scalar keys %{ find_vars_in_ast($call_arg_expr,{}) } > 0;
		if (# skip constants
			$has_vars
			# $call_arg_expr->[0] < 29
			# and not ($call_arg_expr->[0]==4 and $call_arg_expr->[1][0] >= 29) # negative constant
			# This is still weak because for example 1+1 would get through. Maybe better is to check if there are any vars at all!
			and not exists $stref->{'Subroutines'}{$call_arg}
			) {
			my $subset = in_nested_set($stref->{'Subroutines'}{$f}, 'Vars', $call_arg);

			if ($subset) { # otherwise it means this is an expression, including array accesses, or a constant.
				my $call_arg_decl = $stref->{'Subroutines'}{$f}{$subset}{'Set'}{$call_arg};
				
				# Just set $sig_arg to $call_arg as a start
				my $sig_arg = $call_arg;
				# Now see if there is an actual $sig_arg for which the entry in ArgMap
				# matches the $call_arg
				# ArgMap entries are not typed: the type info is in $info->{'SubroutineCall'}{'Args'}
				for my $tsig_arg (keys %{$info->{'SubroutineCall'}{'ArgMap'} }) {
					if ( defined $info->{'SubroutineCall'}{'ArgMap'}{$tsig_arg} and
						$info->{'SubroutineCall'}{'ArgMap'}{$tsig_arg} eq $call_arg) {
						$sig_arg=$tsig_arg;
						last;
					}
				}
				# carp "CALL $name in $f: $call_arg $sig_arg" if $name =~/mpi_reduce_double_precision/;
				my $sig_subset = in_nested_set($stref->{'Subroutines'}{$name}, 'Vars', $sig_arg);
				my $sig_arg_decl = $stref->{'Subroutines'}{$name}{$sig_subset}{'Set'}{$sig_arg};
				# carp $sig_subset .Dumper($sig_arg_decl)  if $call_arg eq 'p2' and $name eq 'sbisect';
				if (not exists $sig_arg_decl->{'Name'}) {
					$sig_arg_decl = $call_arg_decl;
				}

				if ($call_arg_decl->{'Type'} ne 'character') { # we don't do this for character strings
					my $cast_reshape_result = _maybe_cast_call_args($stref, $f, $name, $call_arg,$call_arg_decl,$sig_arg, $sig_arg_decl);
					# say Dumper($cast_reshape_result)  if $name =~/mpi_reduce_double_precision/;
					# croak Dumper($sig_arg_decl,$call_arg_decl)  if $name =~/mpi_reduce_double_precision/ and $call_arg eq 'data1';
					$call_arg = $cast_reshape_result->{'CallArg'};
					push @cast_reshape_results, $cast_reshape_result if $cast_reshape_result->{'Status'} == 2;
				}
			} # in subset
		} # not a PlaceHolder, this is a HACK as it shouldn't be one anyway!

		push @orig_args, $call_arg;
	} # loop over all call args

	map {
		$Sf->{'CastReshapeVarDecls'}{'Set'}{
			$_->{'CallArg'}
		} = $_->{'CastReshapeVarDecl'};
	} @cast_reshape_results;
	$Sf->{'CastReshapeVarDecls'}{'List'} = [sort keys %{ $Sf->{'CastReshapeVarDecls'}{'Set'} }];


	my $args_ref = [@orig_args];               # NOT ordered union, if they repeat that should be OK
# carp Dumper($args_ref) if $name eq 'sn725';

	# This is for the case of ENTRYs. The "parent" is the actual sub which contains the ENTRY statements
	my $parent_sub_name =
	  exists $stref->{'Entries'}{$name} ? $stref->{'Entries'}{$name} : $name;
	# croak Dumper( $annline) if $name eq 'sub0' and $f=~/loop/;
	# If there are any ex-global args, collect them
	# WV2019-06-03 Here we should check.
	if ( exists $stref->{'Subroutines'}{$name}{'RefactoredArgs'}
	and exists $info->{'ExtractedSubroutine'}
	) { # If we have this, surely we can just use them?

		my $args_ref = $stref->{'Subroutines'}{$name}{'RefactoredArgs'}{'List'};
		$info->{'SubroutineCall'}{'Args'}{'List'} = $args_ref; 
		# croak Dumper($args_ref);
 	if (scalar @{ $args_ref } > 0 ) {
		 say "INFO: Using 'RefactoredArgs' as call args for call to $name in $f" if $I;
 			# This is the emitter, maybe that should not be done here but later on? TODO!
			my $args_str = join( ',', @{$args_ref} );
			my $indent   = $info->{'Indent'} // '      ';
			my $maybe_label =
			  ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{ $info->{'Label'} } )
			  ? $info->{'Label'} . ' '
			  : '';
			my $rline = "call $name($args_str)\n";
			if ( exists $info->{'PlaceHolders'} ) {
				while ( $rline =~ /(__PH\d+__)/ ) {
					my $ph     = $1;
					my $ph_str = $info->{'PlaceHolders'}{$ph};
					$rline =~ s/$ph/$ph_str/;
				}
				$info->{'Ref'}++;
			}
			push @{$info->{'Ann'}}, annotate( $f, __LINE__ );
# TODO here we push the pre-and-post cast assignments
# TODO note that this will work with reshapes too
# TODO and similar for the other places where we generate call lines
			if ( @cast_reshape_results) {
				for my $cast_reshape_result ( @cast_reshape_results) {
					my ($cast_reshape_pre_line, $cast_reshape_pre_info) =@{$cast_reshape_result->{'PreAnnLine'}};
					push @{$rlines}, [ $indent . $cast_reshape_pre_line, $cast_reshape_pre_info ];
				}
			}
			# push @{$rlines}, [ $indent . $cast_reshape_pre_line, $cast_reshape_pre_info ];
			push @{$rlines}, [ $indent . $maybe_label . $rline, $info ];
			# push @{$rlines}, [ $indent . $cast_reshape_post_line, $cast_reshape_post_info ];
			if ( @cast_reshape_results) {
				for my $cast_reshape_result ( @cast_reshape_results) {
					my ($cast_reshape_post_line, $cast_reshape_post_info) =@{$cast_reshape_result->{'PostAnnLine'}};
					push @{$rlines}, [ $indent . $cast_reshape_post_line, $cast_reshape_post_info ];
				}
			}
		} else { # no change to original call line
			push @{$rlines}, [ $line, $info ];
		}

	} else {
		if ( not exists $stref->{'Subroutines'}{$name}{'HasCommonVarMismatch'} ) {    # old approach is fine

			if ( exists $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'} ) {

				my @globals = @{ $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'}{'List'} };

				# Problem is that in $f, globals from $name may have been renamed. I store the renamed ones in $Sf->{'RenamedInheritedExGLobs'}
				# So we check and create @maybe_renamed_exglobs
				my @maybe_renamed_exglobs = ();
				for my $ex_glob (@globals) {

					# WV 20170606 I need to check if maybe the ex-globs have already been added to the args
					# Because if the Args of the actual Call are the same as ex-globs then they must be ex-globs
					if ( not exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$ex_glob} ) {

						# $ex_glob may be renamed or not. I test this using OrigName.
						# This way I am sure I get only original names
						if ( exists $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'} ) {
							$ex_glob = $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'};
						}
						if (    exists $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob}
							and not exists $Sf->{'UsedLocalVars'}{'Set'}{$ex_glob}
							and not exists $Sf->{'IncludedParameters'}{'Set'}{$ex_glob} )
						{
							say "INFO: RENAMED $ex_glob => " . $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} . ' in call to ' . $parent_sub_name . ' in ' . $f
							if $I;
							push @maybe_renamed_exglobs, $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob};
						} else {
							push @maybe_renamed_exglobs, $ex_glob;
						}
					} else {

						#        		say "VAR $ex_glob is in Args for SubroutineCall $name";
					}
				}
# croak Dumper( $annline->[1]{'SubroutineCall'}{'Args'}) if $name eq 'sub0' and $f=~/loop/;

				# Then we concatenate these arg lists
				$args_ref = [ @orig_args, @maybe_renamed_exglobs ];    # NOT ordered union, if they repeat that should be OK
				my $expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'};
				if (    @maybe_renamed_exglobs
					and @{$expr_ast}
					and ( $expr_ast->[0] & 0xFF ) != 27 )
				{
					$expr_ast = [ 27, $expr_ast ];
				}
				$expr_ast =
					[ @{$expr_ast}, map { [ '2', $_ ] } @maybe_renamed_exglobs ];
				$info->{'SubroutineCall'}{'ExpressionAST'} = $expr_ast;

				$info->{'SubroutineCall'}{'Args'}{'List'} = $args_ref;
				for my $arg (@{$args_ref}) {
					my $Sf = $stref->{'Subroutines'}{$f};
					my $subset = in_nested_set( $Sf, 'Vars', $arg );
					my $call_arg_decl = get_var_record_from_set($Sf->{$subset},$arg);

					if ( exists $call_arg_decl->{'OrigName'} ) {
						 $annline->[1]{'SubroutineCall'}{'Args'}{'Set'}{$arg}= {
							 'Type' => $annline->[1]{'SubroutineCall'}{'Args'}{'Set'}{ $call_arg_decl->{'OrigName'} }{'Type'},
							 'Expr' => $arg
						 };
					}
				}

# croak Dumper( $annline->[1]{'SubroutineCall'}{'Args'}) if $name eq 'sub0' and $f=~/loop/;
				# This is the emitter, maybe that should not be done here but later on? TODO!
				my $args_str = join( ',', @{$args_ref} );
				my $indent   = $info->{'Indent'} // '      ';
				my $maybe_label =
				( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{ $info->{'Label'} } )
				? $info->{'Label'} . ' '
				: '';
				my $rline = "call $name($args_str)\n";
				if ( exists $info->{'PlaceHolders'} ) {
					while ( $rline =~ /(__PH\d+__)/ ) {
						my $ph     = $1;
						my $ph_str = $info->{'PlaceHolders'}{$ph};
						$rline =~ s/$ph/$ph_str/;
					}
					$info->{'Ref'}++;
				}
				push @{$info->{'Ann'}}, annotate( $f, __LINE__ );

				if ( @cast_reshape_results) {
					for my $cast_reshape_result ( @cast_reshape_results) {
						my ($cast_reshape_pre_line, $cast_reshape_pre_info) =@{$cast_reshape_result->{'PreAnnLine'}};
						push @{$rlines}, [ $indent . $cast_reshape_pre_line, $cast_reshape_pre_info ];
					}
				}

				push @{$rlines}, [ $indent . $maybe_label . $rline, $info ];

				if ( @cast_reshape_results) {
					for my $cast_reshape_result ( @cast_reshape_results) {
						my ($cast_reshape_post_line, $cast_reshape_post_info) =@{$cast_reshape_result->{'PostAnnLine'}};
						push @{$rlines}, [ $indent . $cast_reshape_post_line, $cast_reshape_post_info ];
					}
				}

			} else { # no change to original call line
				push @{$rlines}, [ $line, $info ];
			}


		} else {    # Use new approach

			if ( exists $stref->{'Subroutines'}{$parent_sub_name}{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} ) {

				my @ex_glob_sig_args = @{ $stref->{'Subroutines'}{$parent_sub_name}{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} };

				# Problem is that in $f, globals from $name may have been renamed. I store the renamed ones in $Sf->{'RenamedInheritedExGLobs'}
				# So we check and create @maybe_renamed_exglobs
				my @maybe_renamed_exglobs = ();
				my @cast_reshape_results = ();
				for my $sig_arg (@ex_glob_sig_args) {
					my $call_arg = $stref->{'Subroutines'}{$parent_sub_name}{'ExMismatchedCommonArgs'}{'CallArgs'}{$f}{$sig_arg}[0][0];
					if (defined $call_arg) { # otherwise it is an expression
					my $subset = in_nested_set($stref->{'Subroutines'}{$f}, 'Vars', $call_arg);
					my $call_arg_decl = $stref->{'Subroutines'}{$f}{$subset}{'Set'}{$call_arg};
					my $sig_arg_decl = $stref->{'Subroutines'}{$parent_sub_name}{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$sig_arg};
					# I think it is safe enough not to cast if call arg and sig arg have the same name.
					# But I'll handle that inside _maybe_cast_call_args
					# carp 'CAST?'. Dumper($f, $parent_sub_name, $call_arg,$sig_arg);
					my $cast_reshape_result = _maybe_cast_call_args($stref, $f, $parent_sub_name, $call_arg,$call_arg_decl,$sig_arg, $sig_arg_decl);

					$call_arg = $cast_reshape_result->{'CallArg'};
					push @cast_reshape_results, $cast_reshape_result if $cast_reshape_result->{'Status'} == 2;
					push @maybe_renamed_exglobs, $call_arg;
					}
				}

				$Sf->{'CastReshapeVarDecls'}{'List'} = [map {$_->{'CallArg'}} @cast_reshape_results];
				map {
					$Sf->{'CastReshapeVarDecls'}{'Set'}{
						$_->{'CallArg'}
					} = $_->{'CastReshapeVarDecl'};
				} @cast_reshape_results;


				# Then we concatenate these arg lists
				$args_ref = [ @orig_args, @maybe_renamed_exglobs ];    # NOT ordered union, if they repeat that should be OK

				my $expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'};
				if (    @maybe_renamed_exglobs
					and @{$expr_ast}
					and ( $expr_ast->[0] & 0xFF ) != 27 )
				{
					$expr_ast = [ 27, $expr_ast ];
				}
				$expr_ast =
					[ @{$expr_ast}, map { [ '2', $_ ] } @maybe_renamed_exglobs ];
				$info->{'SubroutineCall'}{'ExpressionAST'} = $expr_ast;

				# croak Dumper $args_ref;
				$info->{'SubroutineCall'}{'Args'}{'List'} = $args_ref;
# croak Dumper( $annline) if $name eq 'sub0' and $f=~/loop/;
				# This is the emitter, maybe that should not be done here but later on? TODO!
				my $args_str = join( ',', @{$args_ref} );
				my $indent   = $info->{'Indent'} // '      ';
				my $maybe_label =
				( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{ $info->{'Label'} } )
				? $info->{'Label'} . ' '
				: '';
				my $rline = "call $name($args_str)\n";
				if ( exists $info->{'PlaceHolders'} ) {
					while ( $rline =~ /(__PH\d+__)/ ) {
						my $ph     = $1;
						my $ph_str = $info->{'PlaceHolders'}{$ph};
						$rline =~ s/$ph/$ph_str/;
					}
					$info->{'Ref'}++;
				}
				push @{$info->{'Ann'}}, annotate( $f, __LINE__ );

				if ( @cast_reshape_results) {
					for my $cast_reshape_result ( @cast_reshape_results) {
						my ($cast_reshape_pre_line, $cast_reshape_pre_info) =@{$cast_reshape_result->{'PreAnnLine'}};
						push @{$rlines}, [ $indent . $cast_reshape_pre_line, $cast_reshape_pre_info ];
					}
				}

				push @{$rlines}, [ $indent . $maybe_label . $rline, $info ];

				if ( @cast_reshape_results) {
					for my $cast_reshape_result ( @cast_reshape_results) {
						my ($cast_reshape_post_line, $cast_reshape_post_info) =@{$cast_reshape_result->{'PostAnnLine'}};
						push @{$rlines}, [ $indent . $cast_reshape_post_line, $cast_reshape_post_info ];
					}
				}

			} else { # no change to original call line
				push @{$rlines}, [ $line, $info ];
			}
		}
	}
	return ($rlines, $stref);
}    # END of _create_refactored_subroutine_call()


sub __generate_inherited_param_decls { my ($rdecl, $var, $stref, $f, $inherited_param_decls) = @_;
    my $Sf         = $stref->{'Subroutines'}{$f};
	if (exists $rdecl->{'InheritedParams'}) {
		for my $inh_par (sort keys %{ $rdecl->{'InheritedParams'}{'Set'} }) {
			# say $inh_par;
			my $subset = in_nested_set( $Sf, 'Parameters', $inh_par );
			my $in_mod=0;
			if ( exists $Sf->{'InModule'} ) {
				my $mod = $Sf->{'InModule'};
				if ( exists $stref->{'Modules'}{$mod}{'Parameters'} ) {
					$in_mod=1;
				}
			}

			if (not $in_mod and not $subset and not exists $Sf->{'InheritedParameters'}{'Set'}{$inh_par}) {
				#carp "PAR $inh_par, INHERITED by $var, NOT in any subset in $f ";
				#carp Dumper( $rdecl->{'InheritedParams'});
				#croak Dumper(pp_annlines($Sf->{'AnnLines'}));
				#croak Dumper($Sf);
				my $par_decl = $rdecl->{'InheritedParams'}{'Set'}{$inh_par};
				my $par_decl_line = [ '      ' . emit_f95_var_decl($par_decl), 
					{ 
						'ParamDecl' => $par_decl, 'Ref' => 1,
						'Ann' => [annotate($f, __LINE__ . " : __generate_inherited_param_decls")]
					} ];
				push @{$inherited_param_decls}, $par_decl_line;

				$Sf->{'LocalParameters'}{'Set'}{$inh_par}=$par_decl;
				if (exists $par_decl->{'InheritedParams'} and scalar keys %{$par_decl->{'InheritedParams'}{'Set'}}> 0) {
					($inherited_param_decls, $Sf) =__generate_inherited_param_decls($par_decl, $inh_par, $stref, $f, $inherited_param_decls);
				}
			}
			#  else {
			# 	say "PAR $inh_par in subset $subset in $f";
			# }
		}
	}
	return ($inherited_param_decls, $Sf);
} # END of __generate_inherited_param_decls


# _maybe_cast_call_args
=pod
returns  $cast_reshape_result,
	my $cast_reshape_result={
		'CallArg' => $call_arg,
		'PreAnnLine' => [],
		'PostAnnLine' => [],
		'CastReshapeVarDecl' => {},
		'Status' => 0
	};
where Status =
0: no need to cast, $cast_code is $call_arg and can be ignored
1: in-place cast, $cast_code is the cast version of $call_arg
2: heavyweight cast: needs a new var decl, an pre-assignment line and a post-assignment line

Casting and reshaping may both be needed. We have four cases
1. Cast only
2. Reshape only
We need to reshape the call arg in the shape of the sig arg. Problem is that in the caller context, there is no sig arg.
So we either need to calculate the shape and insert it as a constant, so that we can do this in-place, or we need to create the new call arg
The latter is easier.
3. Reshape and cast
Casting should take places after reshaping: cast(reshape())
4. No reshape nor cast

cast only
- in-place
- new arg
reshape only (always new arg)
cast and reshape (always new arg)
=cut

sub _maybe_cast_call_args { # 200 lines
	my ($stref, $f, $sub_name, $call_arg, $call_arg_decl, $sig_arg, $sig_arg_decl)=@_;
	my $cast_reshape_result={
		'CallArg' => $call_arg,
		'PreAnnLine' => ['',{'Assignment'=>1}],
		'PostAnnLine' =>  ['',{'Assignment'=>1}],
		'CastReshapeVarDecl' => {},
		'Status' => 0
	};
	if (_compare_decls($stref, $f, $call_arg_decl, $sig_arg_decl))	{
		return $cast_reshape_result;
	}
	# if ($sig_arg eq 'charArray'){
	# 	say 'CHECKa:'.Dumper( $sig_arg_decl);
	# }

	my ($needs_reshape, $use_arg_sz) = __reshape_check($stref, $f, $sub_name, $call_arg_decl,$sig_arg_decl);
	# if ($sig_arg eq 'charArray'){
	# 	say 'CHECKb:'.Dumper( $sig_arg_decl);
	# }
	my $needs_cast = __cast_check( $call_arg_decl,$sig_arg_decl);
	# if ($sig_arg eq 'charArray'){
	# 	say 'CHECKc:'.Dumper($sig_arg_decl,[
	# 		$needs_reshape, $use_arg_sz, $needs_cast
	# 	]);
	# }
	my $sig_kind=__get_kind_from_decl($sig_arg_decl);
	my $call_kind=__get_kind_from_decl($call_arg_decl);
		# carp "$sig_kind <> $call_kind";
	my $is_out = __out_check($sig_arg_decl);

	my $new_call_arg=undef;

	if ($needs_reshape or ($needs_cast and $is_out)) {
		# carp "$f, $sub_name, $call_arg,$sig_arg, needs_reshape" if $needs_reshape;
		$new_call_arg = $call_arg.'_'.$sub_name.'_cr'; # cr for CastReshape
		my $Sf = $stref->{'Subroutines'}{$f};
		my $subset = in_nested_set( $Sf, 'Vars', $call_arg );
		my $call_arg_decl = get_var_record_from_set($Sf->{$subset},$call_arg);
		my $new_call_arg_decl = dclone($sig_arg_decl);
		$new_call_arg_decl->{'Name'}=$new_call_arg;
		$new_call_arg_decl->{'OrigName'}=$call_arg;
		if ($use_arg_sz) {
			$new_call_arg_decl->{'Dim'}=$call_arg_decl->{'Dim'};
		}
		$Sf->{$subset}{'Set'}{$new_call_arg}=$new_call_arg_decl;
		push @{$Sf->{$subset}{'List'}},$new_call_arg;

		# croak Dumper $new_call_arg_decl ;

		$cast_reshape_result->{'CallArg'}=$new_call_arg;
		$cast_reshape_result->{'CastReshapeVarDecl'}=$new_call_arg_decl;
		$cast_reshape_result->{'Status'}=2;
	} elsif ($needs_cast and not $is_out) {
		$cast_reshape_result->{'Status'}=1;
	}
	# my $cast_reshape_info = {'Assignment' => 1};

	if ($needs_reshape) { # never in-place
		# do the reshape, then check for cast

		my $reshaped_call_arg = "reshape($call_arg,shape($new_call_arg))";
		my $reshaped_call_arg_ast = [1,'reshape',[27,$call_arg, [1,'shape',[2,$new_call_arg]]]];
		my $cast_reshape_pre_line = "$new_call_arg = $reshaped_call_arg";
#@ Lhs =>
#@        VarName       => $lhs_varname
#@        IndexVars     => $lhs_vars
#@        ArrayOrScalar => Array | Scalar
#@        ExpressionAST => $lhs_ast
#@ Rhs =>
#@        Vars       => $rhs_all_vars
#@        ExpressionAST => $rhs_ast
		my $cast_reshape_pre_info = {
			'Lhs' => {'ExpressionAST' => [2,$new_call_arg],
				'VarName' => $new_call_arg,
				'IndexVars' => {'List' => [],'Set' =>{}},,
				'ArrayOrScalar' => 'Scalar'
			},
			'Rhs' => {
				'ExpressionAST' => $reshaped_call_arg_ast,
				'Vars' => {
					'List' => [$call_arg, $new_call_arg],
					'Set' => {$call_arg =>{'Type' => 'Scalar'},
							$new_call_arg=>{'Type' => 'Scalar'}
					}
				}
			},
		};
		my $cast_reshape_pre_annline = [$cast_reshape_pre_line,$cast_reshape_pre_info];

		my $reshaped_new_call_arg = "reshape($new_call_arg, shape($call_arg))";
		my $reshaped_new_call_arg_ast = [1,'reshape',[27,$new_call_arg, [1,'shape',[2,$call_arg]]]];
		my $cast_reshape_post_line = "$call_arg = $reshaped_new_call_arg";
		my $cast_reshape_post_info = {
			'Lhs' => {'ExpressionAST' => [2,$call_arg],
				'VarName' => $call_arg,
				'IndexVars' => {'List' => [],'Set' =>{}},,
				'ArrayOrScalar' => 'Scalar'
			},
			'Rhs' => {'ExpressionAST' => $reshaped_new_call_arg_ast,
			'Vars' => {
				'List' => [$call_arg, $new_call_arg],
				'Set' => {$call_arg =>{'Type' => 'Scalar'}, $new_call_arg=>{'Type' => 'Scalar'}}
				}
			},
		};
		my $cast_reshape_post_annline = [$cast_reshape_post_line,$cast_reshape_post_info];


		if ($needs_cast) {
			# cast
			my $cast_reshaped_call_arg = cast_call_argument($sig_arg_decl->{'Type'}, $sig_kind , $call_arg_decl->{'Type'}, $reshaped_call_arg);
			my $cast_reshaped_call_arg_ast = parse_expression($cast_reshaped_call_arg);
			my $cast_reshape_pre_line = "$new_call_arg = $cast_reshaped_call_arg";
		my $cast_reshape_pre_info = {
			'Lhs' => {'ExpressionAST' => [2,$new_call_arg],
				'VarName' => $new_call_arg,
				'IndexVars' => {'List' => [],'Set' =>{}},,
				'ArrayOrScalar' => 'Scalar'
			},
			'Rhs' => {'ExpressionAST' => $cast_reshaped_call_arg_ast,
			'Vars' => {
				'List' => [$call_arg, $new_call_arg],
				'Set' => {$call_arg =>{'Type' => 'Scalar'}, $new_call_arg=>{'Type' => 'Scalar'}}
				}
			},
		};
		 $cast_reshape_post_annline = [$cast_reshape_post_line,$cast_reshape_post_info];
			my $reshaped_new_call_arg = "reshape($new_call_arg, shape($call_arg)";
			my $cast_reshaped_new_call_arg = cast_call_argument($call_arg_decl->{'Type'}, $call_kind , $sig_arg_decl->{'Type'}, $reshaped_new_call_arg);
			$cast_reshape_post_line = "$call_arg = $cast_reshaped_new_call_arg";
		}

		$cast_reshape_result = __update_cast_reshape_result(
			$cast_reshape_result,
			$cast_reshape_pre_annline,
			$cast_reshape_post_annline,
			$call_arg,
			$new_call_arg
		);

	} else { # no reshape. This I guess could be an array access used as argument, so a scalar, I wonder what happens
	# croak Dumper $call_arg;
		if ($needs_cast) {
			if ($is_out) { # not in place

					my $cast_call_arg = cast_call_argument($sig_arg_decl->{'Type'}, $sig_kind , $call_arg_decl->{'Type'}, $call_arg);
					# my $cast_call_arg_ast = parse_expression($cast_call_arg);
					(my $cast_call_arg_ast, my $rest, my $err, my $has_funcs)  = parse_expression_no_context($cast_call_arg);
					my $cast_reshape_pre_line =  "$new_call_arg = $cast_call_arg" ;
					my $cast_reshape_pre_info = {
						'Lhs' => {'ExpressionAST' => [2,$new_call_arg],
							'VarName' => $new_call_arg,
							'IndexVars' => {'List' => [],'Set' =>{}},
							'ArrayOrScalar' => 'Scalar'
						},
						'Rhs' => {'ExpressionAST' => $cast_call_arg_ast,
						'Vars' => {'List' => [$cast_call_arg], 'Set' => {$cast_call_arg=>{'Type' => 'Scalar'}}}
						},
					};
					my $cast_reshape_pre_annline = [$cast_reshape_pre_line,$cast_reshape_pre_info];

					my $cast_new_call_arg = cast_call_argument($call_arg_decl->{'Type'}, $call_kind , $sig_arg_decl->{'Type'}, $new_call_arg);
					# my $cast_new_call_arg_ast = parse_expression($cast_new_call_arg);
					(my $cast_new_call_arg_ast, my $restn, my $errn, my $has_funcsn)  = parse_expression_no_context($cast_new_call_arg);
					my $cast_reshape_post_line =   "$call_arg = $cast_new_call_arg" ;
					my $cast_reshape_post_info = {
						'Lhs' => {'ExpressionAST' => [2,$call_arg],
							'VarName' => $call_arg,
							'IndexVars' => {'List' => [],'Set' =>{}},
							'ArrayOrScalar' => 'Scalar'
						},
						'Rhs' => {'ExpressionAST' => $cast_new_call_arg_ast,
						'Vars' => {'List' => [$cast_new_call_arg], 'Set' => {$cast_new_call_arg=>{'Type' => 'Scalar'}}}
						},
					};
					my $cast_reshape_post_annline = [$cast_reshape_post_line,$cast_reshape_post_info];

					$cast_reshape_result = __update_cast_reshape_result($cast_reshape_result,
						$cast_reshape_pre_annline,
						$cast_reshape_post_annline,
						$call_arg,
						$new_call_arg
					);

			} else { # in place
					my $cast_call_arg = cast_call_argument($sig_arg_decl->{'Type'}, $sig_kind , $call_arg_decl->{'Type'}, $call_arg);
					$cast_reshape_result->{'CallArg'}=$cast_call_arg;
			}
		}
	}

	return $cast_reshape_result;
} # END of _maybe_cast_call_args


sub  __update_cast_reshape_result {
	my (
		$cast_reshape_result, # {'PreAnnLine' => ..., 'PostAnnLine' => ...} ->
		$cast_reshape_pre_annline, # AnnLine
		$cast_reshape_post_annline, # AnnLine
		$call_arg, # Var
		$new_call_arg # Var
	) = @_; # {'PreAnnLine' => ..., 'PostAnnLine' => ...}

	my ($cast_reshape_pre_line,$cast_reshape_pre_info) = @{$cast_reshape_pre_annline};
	my ($cast_reshape_post_line,$cast_reshape_post_info) = @{$cast_reshape_post_annline};
# carp Dumper $cast_reshape_result->{'PreAnnLine'}[1];
	$cast_reshape_result->{'PreAnnLine'}[0]=$cast_reshape_pre_line;
	$cast_reshape_result->{'PreAnnLine'}[1]=$cast_reshape_pre_info;
	$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'VarName'}=$new_call_arg;
	$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'ExpressionAST'}=[2,$new_call_arg];
	$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'IndexVars'}{'List'}=[];
	$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'ArrayOrScalar'}='Scalar';
	$cast_reshape_result->{'PreAnnLine'}[1]{'Rhs'}{'Vars'}{'List'}=[$new_call_arg,$call_arg];
	$cast_reshape_result->{'PreAnnLine'}[1]{'Rhs'}{'ExpressionAST'} = [1,'reshape',[27,[2,$call_arg],[1,'shape',[2,$new_call_arg]]]];
	$cast_reshape_result->{'PostAnnLine'}[0]=$cast_reshape_post_line;
	$cast_reshape_result->{'PostAnnLine'}[1]=$cast_reshape_post_info;
	$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'VarName'}=$call_arg;
	$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'ExpressionAST'}=[2,$call_arg];
	$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'IndexVars'}{'List'}=[];
	$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'ArrayOrScalar'}='Scalar';
	$cast_reshape_result->{'PostAnnLine'}[1]{'Rhs'}{'Vars'}{'List'}=[$new_call_arg,$call_arg];
	$cast_reshape_result->{'PostAnnLine'}[1]{'Rhs'}{'ExpressionAST'} = [1,'reshape',[27,[2,$new_call_arg],[1,'shape',[2,$call_arg]]]];

	return $cast_reshape_result;
}



sub __get_kind_from_decl { my ($decl) = @_;
	my $kind=4;
	if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '') {
		$kind=$decl->{'Attr'};
		$kind=~s/\w+=//;
		$kind=~s/[\(\)]//g;
	}
	return $kind;
}


sub __reshape_check { my ($stref, $f, $sub_name, $call_arg_decl,$sig_arg_decl) = @_;

	my $call_arg = $call_arg_decl->{'Name'};
	my $sig_arg = $sig_arg_decl->{'Name'};

	my $needs_reshape=0;
	my $use_arg_sz=0;
	if (exists $call_arg_decl->{'ArrayOrScalar'} and
		$call_arg_decl->{'ArrayOrScalar'} eq 'Array'
		and $sig_arg_decl->{'ArrayOrScalar'} eq 'Array'
	) { # both are arrays. Let's check size and rank
		# and also assignment is array to array

		my $dim1  = $call_arg_decl->{'Dim'};
		my $dim2  = $sig_arg_decl->{'Dim'};
		# say "ASSUMED? ". __is_assumed_array($dim2);
		# Avoid overwriting the actual Dim field, as it is a reference
		my $dim2d = dclone($dim2);
		if (__is_assumed_array($dim2)) {
			$dim2d = __take_upper_bound_from_call_arg($dim1,$dim2d);
		}
		# say 'AFTER __take_upper_bound_from_call_arg:'.Dumper($sig_arg_decl);
		# say "$f ".Dumper($dim1)."\n$sub_name".Dumper($dim2d);
		my ($size1, $not_const1) = calculate_array_size( $stref, $f, $dim1 );
		my ($size2, $not_const2) = calculate_array_size( $stref, $sub_name, $dim2d );
		croak 'FIXME!'.Dumper($call_arg_decl,$sig_arg_decl) if $DBG and not defined $size1 or not defined $size2;
		if ($not_const1 ne $not_const2) {
			warning("the call to $sub_name in $f might have the wrong dimension for " .
			( $not_const1 ? "$call_arg($not_const1)" : $call_arg) . " with dummy " .
			( $not_const2 ? "$sig_arg($not_const2)" : $sig_arg) ,2);
			# say Dumper($dim1, $dim2d);
		}
		# but the rank we need is the rank of the expression
		# FIXME: I will assume that if the array is indexed, all indices are used, i.e. rank is 0
		my $rank1 = get_array_rank($dim1);
		my $rank2 = get_array_rank($dim2);

		# if the same size and different rank
		if ( $size1 == $size2 and $rank1 != $rank2 ) {
			$needs_reshape=1;
			croak '# if the same size and different rank';
		} elsif ( $size1 != $size2 and $rank1 == $rank2 ) {
			# if the same rank and different size
			# warning("In call to $sub_name in $f: call arg $call_arg and subroutine arg $sig_arg have different sizes $size1<>$size2, type error!\n"
			# .'Using the largest dimension for the reshaped array.' if not $not_const2 and $W ;

			warning("the call to $sub_name in $f might have the wrong dimension for " .
			( $not_const1 ? "$call_arg($not_const1)" : $call_arg) . " with dummy " .
			( $not_const2 ? "$sig_arg($not_const2)" : $sig_arg) . "\n\t" .
			'Using the largest dimension for the reshaped array.',2) if not $not_const2 ;
			# If the dim is for some reason still symbolic, we'll take the non-symbolic one
			if ($size1>$size2) {
				$use_arg_sz=1;
			}
			$needs_reshape=1;
			# croak '# if the same rank and different size: '.$call_arg . ':'. $size1 .'!='. $sig_arg.':'.$size2;
		} elsif ( $size1 != $size2 and $rank1 != $rank2 ) {
			# We take the largest of the two. This can of course lead to run-time errors.
			if ($size1>$size2) {
				$use_arg_sz=1;
			}
			# warning("In call to $sub_name in $f: call arg $call_arg and subroutine arg $sig_arg have different sizes $size1<>$size2, type error in reshape()!\n"
			# .'Using the largest dimension for the reshaped array.',2) if not $not_const2;
			warning("the call to $sub_name in $f might have the wrong dimension for " .
			( $not_const1 ? "$call_arg($not_const1)" : $call_arg) . " with dummy " .
			( $not_const2 ? "$sig_arg($not_const2)" : $sig_arg) . "\n\t" .
			'Using the largest dimension for the reshaped array.',2) if not $not_const2 ;
			$needs_reshape=1;
		}
	}
	return ($needs_reshape, $use_arg_sz) ;
} # END of __reshape_check

sub __cast_check {
	my ($call_arg_decl,$sig_arg_decl) = @_;
	my $sig_kind=__get_kind_from_decl($sig_arg_decl);
	my $call_kind=__get_kind_from_decl($call_arg_decl);
		# carp "$sig_kind <> $call_kind";

	my $needs_cast = 0;
	# HACK for double precision
	$call_arg_decl->{'Type'}=~s/\s+//g;
	$sig_arg_decl->{'Type'}=~s/\s+//g;

	if ($call_arg_decl->{'Type'} ne $sig_arg_decl->{'Type'}) {
		# TODO: if they are the same type but different kinds, we also need to cast.
		$needs_cast = 1;
	} elsif ("$sig_kind" ne "$call_kind"
			and "$sig_kind" ne '*' # Assumed length for character string
			) {
		$needs_cast = 1;
	}
	return $needs_cast;
}

sub __out_check {
	my ($sig_arg_decl) = @_;
	if ($sig_arg_decl->{'IODir'} ne 'In'
		# or $sig_arg_decl->{'IODir'} eq 'InOut'
	) {
		return 1;
	} else {
		return 0;
	}
}

# Dim :: [(Int,IntOrStar)]
# IntOrStar = Int | '*'
sub __is_assumed_array { my ($dims) = @_;
	if (@{$dims}==1 and $dims->[0].'' ne '*') {
		$dims = [[1,$dims->[0]]];
	}

	for my $dim_comp (@{$dims}) {
		my $upper_bound=$dim_comp->[1];
		if ($upper_bound eq '*') {
			return 1;
		}
	}
	return 0;
} # END of __is_assumed_array

# I will at first assume the dimensions are the same, and if not I need to reshape
sub __take_upper_bound_from_call_arg { my ($dim1,$dim2) = @_;
	my $idx=0;
	if (
		scalar @{$dim1} == scalar @{$dim2}
	) {
		for my $dim1_comp (@{$dim1}) {
			my $dim2_comp = $dim2->[$idx];
			my $upper_bound2 = $dim2_comp->[1];
			if ($upper_bound2 eq '*') {
				my $lower_bound1 = $dim1_comp->[0];
				my $upper_bound1 = $dim1_comp->[1];
				# If we had [1,3] and [-1, *] => -1 -1 = -2; 3+ -2 = 1
				# If we had [-1,3] and [1, *] => 1 - -1 = 2; 3+ 2 = 5
				my $lower_bound2 = $dim1_comp->[0];
				my $offset = $lower_bound2 - $lower_bound1;
				$upper_bound2 = $upper_bound1 + $offset;
				$dim2->[$idx][1]=$upper_bound2;
			}
			++$idx;
		}
		return $dim2;
	} else { # This means $dim1 has a different shape from $dim2
	# For example [1,6] and [[1,2],[1,*]]
	# In this case we see that * should be 3.
	# But what if we had
	# For example [1,6] and [[1,*],[1,*]]
	# Then there is no unique solution!
	# If on the contrary we had [[1,2],[1,3]] and [1,*] then it is clear.
	# So:
	# - If there is only one *, the we calculate the linear size of the call arg, and the linear sizes of the non-* sig arg dims
		my $nstars = 0;
		for my $dim_comp2 (@{$dim2}) {
			my $upper_bound2=$dim_comp2->[1];
			if ($upper_bound2 eq '*') {
				++$nstars;
			}
		}
		if ($nstars==1) {
			my $size1 = 1;
			for my $dim1_comp (@{$dim1}) {
				my $upper_bound1=$dim1_comp->[1];
				my $lower_bound1=$dim1_comp->[1];
				$size1 = $size1*($upper_bound1-$lower_bound1+1);
			}
			my $size2 = 1;
			for my $dim2_comp (@{$dim2}) {
				my $upper_bound2=$dim2_comp->[1];
				my $lower_bound2=$dim2_comp->[1];
				if ($upper_bound2 ne '*'){
					$size2 = $size2*($upper_bound2-$lower_bound2+1);
				}
			}
			my $assumed_size = $size1/$size2;
			for my $dim_comp2 (@{$dim2}) {
				my $upper_bound2=$dim_comp2->[1];
				if ($upper_bound2 eq '*') {
					$dim_comp2->[1]=$assumed_size-$dim_comp2->[0]+1;
				}
			}
			return $dim2;
		} else {
			# Not good, better error message needed
			die "Can't handle assumed array with multiple * and mismatched array dimensions.\n";
		}
	}
} # END of __take_upper_bound_from_call_arg


sub _compare_decls{my ($stref, $f, $var1_decl, $var2_decl)=@_;
	my $decls_are_equal = 1;
	for my $k ( qw(Name ArrayOrScalar Type Kind Attr) ) {
		$decls_are_equal *= (
			exists $var1_decl->{$k} and
			exists $var2_decl->{$k} and
			$var1_decl->{$k} eq $var2_decl->{$k}) ? 1 : 0;
	}
	if ($decls_are_equal and
	$var1_decl->{'ArrayOrScalar'} eq 'Array'
	){
		my $dim1  = $var1_decl->{'Dim'};
		my $dim2  = $var2_decl->{'Dim'};
		my ($size1, $not_const1) = calculate_array_size( $stref, $f, $dim1 );
		my ($size2, $not_const2) = calculate_array_size( $stref, $f, $dim2 );

		# but the rank we need is the rank of the expression
		# FIXME: I will assume that if the array is indexed, all indices are used, i.e. rank is 0
		my $rank1 = get_array_rank($dim1);
		my $rank2 = get_array_rank($dim2);

		# if the same rank and different size
		$decls_are_equal *=  ( $size1 == $size2 and $rank1 == $rank2 ) ? 1 : 0;
	}
	return $decls_are_equal;
}


# This is for lines that contain function calls, so in practice either assignments or subroutine calls -- or conditional statements
sub _create_refactored_function_calls {
	( my $stref, my $f, my $annline, my $rlines ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};

	( my $line, my $info ) = @{$annline};

	#    say "_create_refactored_function_calls 1467 $f LINE: $line".Dumper($info) ;
	# Get the AST
	my $ast           = [];
	my $do_not_update = 0;
	if ( exists $info->{'Assignment'} or exists $info->{'StatementFunction'} ) {
		$ast = $info->{'Rhs'}{'ExpressionAST'};
	} elsif ( exists $info->{'SubroutineCall'} ) {
		$ast = $info->{'SubroutineCall'}{'ExpressionAST'};
	} elsif ( exists $info->{'If'}
	or exists $info->{'ElseIf'}
	 ) {
		# an if or if-then-else
		$ast = $info->{'Cond'}{'AST'};
	} else {
		croak "TODO: UNSUPPORTED STATEMENT FOR FUNCTION CALL: <$line> "  if $DBG;
		#. Dumper($info);
		$do_not_update = 1;
	}

	# Update the function calls in the AST
	# Basically, whenever we meet a function, we query it for ExGlobArgs and tag these onto te argument list.

	my $updated_ast =
		$do_not_update
	  ? $ast
	  : __update_function_calls_in_AST( $stref, $Sf, $f, $ast );    # FIXME: $ast gets modified.

	# with NEW_PARSER, these are only the arguments, not the rest of the call.
	my $updated_line =
		$do_not_update ? $line
	  : emit_expr_from_ast($updated_ast);

	if ( exists $info->{'PlaceHolders'} ) {

		while ( $updated_line =~ /(__PH\d+__)/ ) {
			my $ph     = $1;
			my $ph_str = $info->{'PlaceHolders'}{$ph};
			$updated_line =~ s/$ph/$ph_str/;
		}
		$info->{'Ref'}++;
	}

	if ( exists $info->{'Assignment'} ) {

		# This is a HACK!
		my %F95_ops = (
			'==' => '.eq.',
			'/=' => '.ne.',
			'<=' => '.le.',
			'>=' => '.ge.',
			'eq' => '==',
			'ne' => '/=',
			'le' => '<=',
			'ge' => '>=',
		);
		for my $op ( '==', '/=', '<=', '>=' ) {
			my $rop = $F95_ops{$op};
			while ( $line =~ /$op/ ) {
				$line =~ s/$op/$rop/;
			}
		}
		$line =~ s/=.+$//;
		for my $op ( 'eq', 'ne', 'le', 'ge' ) {
			my $rop = $F95_ops{$op};
			while ( $line =~ /\.$op\./ ) {
				$line =~ s/\.$op\./$rop/;
			}
		}
		$line .= ' = ' . $updated_line;
	} elsif ( exists $info->{'SubroutineCall'} ) {
		# if ($NEW_PARSER) {
			my $subname = $info->{'SubroutineCall'}{'Name'};
			$line = $info->{'Indent'} . "call $subname($updated_line)\n";
		# } else {
		# 	$line =~ s/call.+$//;
		# 	$line .= 'call ' . $updated_line;
		# }

		#			croak $line;
	}

	#		say "_create_refactored_function_calls($line) at " . __PACKAGE__ . ' '. __LINE__;
	push @{$rlines}, [ $line, $info ];

	return $rlines;
}    # END of _create_refactored_function_calls()


sub __update_function_calls_in_AST {
	( my $stref, my $Sf, my $f, my $ast ) = @_;

	if ( !@{$ast} ) { return $ast; }    # an empty AST
										# use the new walker
	if (   ( $ast->[0] & 0xFF ) == 1
		or ( $ast->[0] & 0xFF ) == 10 )
	{                                   # array var or function/subroutine call
										# it it's a function call, update the call args
		if ( ( $ast->[0] & 0xFF ) == 1 ) {
			my $name = $ast->[1];
			if ( not exists $stref->{'Subroutines'}{$name}{'HasCommonVarMismatch'} ) {

				if ( $name ne $f and exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'} ) {
					my @globals =
						exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'List'}
						? @{ $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'List'} }
						: ();
					my @maybe_renamed_exglobs = ();
					for my $ex_glob (@globals) {

						# $ex_glob may be renamed or not. I test this using OrigName.
						# This way I am sure I get only original names
						if (    exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob}
							and ref( $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob} ) eq 'HASH'
							and exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'} )
						{
							$ex_glob = $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'};
						}
						if ( exists $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} ) {
							say "INFO: RENAMED $ex_glob => " . $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} . ' in call to ' . $name . ' in ' . $f
								if $I;
							push @maybe_renamed_exglobs, $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob};
						} else {
							push @maybe_renamed_exglobs, $ex_glob;
						}
					}

					if (@maybe_renamed_exglobs) {
						if ( not @{ $ast->[2] } ) {    # empty list. create [',' ]
							push @{ $ast->[2] }, 27;
						} elsif ( ( $ast->[2][0] && 0xFF ) != 27 ) {    # not a list. Wrap in [',', ... ]
							my $entry = $ast->[2];
							$ast->[2] = [ 27, $entry ];
						}
						for my $extra_arg (@maybe_renamed_exglobs) {
							push @{ $ast->[2] }, [ 2, $extra_arg ];     #'$'
						}
					}
				}
			} else {
				# carp "HERE2" if $f eq 'nm_f';
				# For mismatched COMMON blocks we need to append the call args with 'CallArgs'
				my @maybe_renamed_exglobs = ();
				# if (grep {(not defined $_)} @{ $stref->{'Subroutines'}{$name}{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} } ) {
				# 	croak "UNDEF";
				# }
				for my $sig_arg ( @{ $stref->{'Subroutines'}{$name}{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} } ) {
					my $call_arg =
						$stref->{'Subroutines'}{$name}{'ExMismatchedCommonArgs'}{'CallArgs'}{$f}{$sig_arg}[0][0];
						if (not defined $call_arg) {
							error("$name called in $f: binder $sig_arg has undefined call argument, rf4a failed to refactor COMMON vars\n") ;
							$call_arg='ERROR_UNDEFINED_'.$sig_arg;
						}
					push @maybe_renamed_exglobs, $call_arg;
				}
				if (@maybe_renamed_exglobs) {
					if ( not @{ $ast->[2] } ) {    # empty list. create [',' ]
						push @{ $ast->[2] }, 27;
					} elsif ( ( $ast->[2][0] && 0xFF ) != 27 ) {    # not a list. Wrap in [',', ... ]
						my $entry = $ast->[2];
						croak  if $DBG and not defined $entry;
						$ast->[2] = [ 27, $entry ];
					}
					for my $extra_arg (@maybe_renamed_exglobs) {
						croak Dumper(@maybe_renamed_exglobs)  if $DBG and not defined $extra_arg;
						push @{ $ast->[2] }, [ 2, $extra_arg ];     #'$'
					}
				}

			}
		}
		# but in any case we need to traverse again for the old call args
		my $entry = __update_function_calls_in_AST( $stref, $Sf, $f, $ast->[2] );
		$ast->[2] = $entry;
	} elsif ( ( $ast->[0] & 0xFF ) < 29 and ( $ast->[0] & 0xFF ) != 2 ) {    # other operators
# carp 'HERE3' if $f eq 'nm_f';
		for my $idx ( 1 .. scalar @{$ast} - 1 ) {
			my $entry = __update_function_calls_in_AST( $stref, $Sf, $f, $ast->[$idx] );
			$ast->[$idx] = $entry;
		}
	}

	return $ast;    #($stref,$f, $ast);

}    # END of __update_function_calls_in_AST()

1;
