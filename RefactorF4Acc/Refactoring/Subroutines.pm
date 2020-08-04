package RefactorF4Acc::Refactoring::Subroutines;
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
use RefactorF4Acc::Refactoring::Common qw( 
	get_annotated_sourcelines 
	context_free_refactorings 
	emit_f95_var_decl 
	stateful_pass
	splice_additional_lines_cond
	);
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( create_refactored_subroutine_signature refactor_subroutine_signature );
use RefactorF4Acc::Refactoring::Subroutines::IncludeStatements qw( skip_common_include_statement create_new_include_statements create_additional_include_statements );
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast find_args_vars_in_ast find_vars_in_ast );
use RefactorF4Acc::Refactoring::Subroutines::Emitters qw( emit_subroutine_sig );
use RefactorF4Acc::Analysis::Arrays qw(
  calculate_array_size
  get_array_rank
  calculate_multidim_indices_from_linear
  dim_to_str
);
use RefactorF4Acc::Refactoring::Casts qw( create_cast_annlines cast_call_argument );

use vars qw( $VERSION );
$VERSION = "2.1.1";

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  refactor_all_subroutines
);

=pod
Subroutines
    refactor_all_subroutines
    _refactor_subroutine_main
    _refactor_globals
    _refactor_calls_globals 
=cut

# -----------------------------------------------------------------------------

sub refactor_all_subroutines {
	( my $stref ) = @_;

	for my $f ( sort keys %{ $stref->{'Subroutines'} } ) {

		next if ( $f eq '' or $f eq 'UNKNOWN_SRC' or not defined $f );
		next if exists $stref->{'Entries'}{$f};

		my $Sf = $stref->{'Subroutines'}{$f};

		next if ( exists $Sf->{'Entry'} && $Sf->{'Entry'} == 1 );
		if ( not defined $Sf->{'Status'} ) {
			$Sf->{'Status'} = $UNREAD;
			say "INFO: no Status for $f" if $I;
		}

		next if $Sf->{'Status'} == $UNREAD;
		next if $Sf->{'Status'} == $READ;
		next if $Sf->{'Status'} == $FROM_BLOCK;

		$stref = _refactor_subroutine_main( $stref, $f );
	}

	return $stref;
}    # END of refactor_all_subroutines()

# ------------------------------------------------------------------------

=pod

=begin markdown

## Info refactoring `_refactor_subroutine_main()`

Essentially, call `_refactor_globals()` on every sub

for every line:

- check if it needs changing:
- need to mark the insert points for subroutine calls that replace the refactored blocks! 
This is a node called 'RefactoredSubroutineCall'
- we also need the "entry point" for adding the declarations for the localized global variables 'ExGlobArgs'

* Signature: add the globals to the signature
(* VarDecls: keep as is)
* ExGlobArgs: add new var decls
* SubroutineCall: add globals for that subroutine to the call
* RefactoredSubroutineCall: insert a new subroutine call instead of the "begin of block" comment. 
* InBlock: skip; we need to handle the blocks separately
* BeginBlock: insert the new subroutine signature and variable declarations
* EndBlock: insert END
                      
=end markdown
=cut

sub _refactor_subroutine_main {
	( my $stref, my $f ) = @_;

	#    local $V=1;
	#    local $I=1;
	#    local $W=1;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $is_block_data =
	  ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? 1 : 0;
	if ($V) {
		print "\n\n";
		print "#" x 80, "\n";
		print "Refactoring $f\n";
		if ( exists $Sf->{'Function'} and $Sf->{'Function'} == 1 ) {
			print "REFACTORING FUNCTION $f\n";
		} else {
			print "REFACTORING SUBROUTINE $f\n";
		}
		print "#" x 80, "\n";
		say "context_free_refactorings($f)";
	}

	$stref = context_free_refactorings( $stref, $f );    # FIXME maybe do this later	

	say "get_annotated_sourcelines($f)" if $V;
	my $annlines = $Sf->{'RefactoredCode'};

	if ( $Sf->{'HasCommons'} and $Config{'INLINE_INCLUDES'}==0 ) {
		# If there are no COMMON blocks the argument list should not change, so there should be no need to do this		
		$annlines = _group_local_param_decls_at_top( $stref, $f, $annlines );
	}

	if (
		1 or $Sf->{'HasCommons'} or (                    # FIXME
			exists $Sf->{'Contains'} and scalar @{ $Sf->{'Contains'} } > 0
		)
	  )
	{
		print "REFACTORING COMMONS for SUBROUTINE $f\n" if $V; 

		if ( $Sf->{'RefactorGlobals'} == 1 ) {

			$annlines = _refactor_globals_new( $stref, $f, $annlines );

		} elsif ( $DBG and $Sf->{'RefactorGlobals'} == 2 ) {
			croak 'SHOULD BE OBSOLETE!';
		}
	}

	# This eats CPHS entirely!
	$annlines = _fix_end_lines( $stref, $f, $annlines );    # FIXME maybe do this later

	if ($is_block_data) {
		$annlines = _add_extra_assignments_in_block_data( $stref, $f, $annlines );
	}

	$annlines = _add_implicit_none( $stref, $f, $annlines );


	# The assignment lines for the mismatched ex-COMMON vars can go here
	# probably before the first line that is not a SpecificationStatement and not a Comment and not a Blank and not Skip or Deleted
	if ( exists $stref->{'Subroutines'}{$f}{'HasCommonVarMismatch'} ) {
		$annlines = _add_ExMismatchedCommonArg_assignment_lines( $stref, $f, $annlines );
		$Sf->{'RefactoredCode'} = $annlines;

		# Re-parsing to get the Info for the emitted lines
		# FIXME: at this stage the PlaceHolders have already been put back! This breaks the parser in some places!

		#	    $stref = parse_fortran_src($f, $stref);
		#	    $annlines=$Sf->{'AnnLines'};
	}

	$annlines = _change_EQUIVALENCE_to_assignment_lines_for_ExCommonArgs( $stref, $f, $annlines );

	#	$Sf->{'AnnLines'} = $annlines;
	#	$Sf->{'RefactoredCode'} = $annlines; # cargo cult
	$annlines = _move_StatementFunctions_after_SpecificationStatements( $stref, $f, $annlines );

	$annlines = _emit_refactored_signatures( $stref, $f, $annlines );
	$Sf->{'RefactoredCode'} = $annlines;

	#say Dumper(pp_annlines($annlines));
	$Sf->{'AnnLines'} = $annlines;
	return $stref;
}    # END of _refactor_subroutine_main()

# -----------------------------------------------------------------------------
# The code below fixes the end lines of the code by adding 'program $f' or 'subroutine $f' or 'function $f'
# For some reason this is BROKEN elsewhere so FIXME!
sub _fix_end_lines {
	my ( $stref, $f, $rlines ) = @_;

	my $Sf                 = $stref->{'Subroutines'}{$f};
	my $is_block_data      = ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? 1 : 0;
	my $what_is_block_data = 'subroutine';                                                        #'block data'
	my $sub_or_prog =
		( exists $Sf->{'Program'}   and $Sf->{'Program'} == 1 )   ? 'program'
	  : ( exists $Sf->{'Function'}  and $Sf->{'Function'} == 1 )  ? 'function'
	  : ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? $what_is_block_data
	  :                                                             'subroutine';
	say 'fix end ' . $f if $V;
	my $done_fix_end = 0;

	while ( !$done_fix_end and @{$rlines} ) {
		my $annline = pop @{$rlines};

		( my $line, my $info ) = @{$annline};

		#		say "$f REV LINE: $line" if $f eq 'cphs';
		next if ( $line =~ /^\s*$/ );    # Skip comments
		if (   $line =~ /^\s*end\s+$sub_or_prog/
			or $line =~ /^\s*\d+\s+end\s+$sub_or_prog/ )
		{
			push @{$rlines}, $annline;
			$done_fix_end = 1;
			last;
		}

		if (   $line =~ /^\s*end\s*$/
			or $line =~ /^\s*\d+\s+end\s*$/ )
		{
			$line =~ s/\s+$//;
			if ($is_block_data) {
				$info->{'EndBlockData'} = 1;
			}

			push @{$rlines}, [ $line . " $sub_or_prog $f", $info ];
			$done_fix_end = 1;
		}

		if ( $line =~ /^\s*contains\s*$/ ) {
			$line =~ s/\s+$//;
			push @{$rlines}, $annline;
			push @{$rlines}, [ "end $sub_or_prog $f", $info ];
			$done_fix_end = 1;
		}
	}

	return $rlines;
}    # END of _fix_end_lines()

# -----------------------------------------------------------------------------

# The problem with this routine is as follows: the refactoring of the signature happens when it is encountered.
# But any subsequent call to a subroutine can result in new arguments being added to ExGlobArgDecls
# In principle this should have been dealt with by the inheritance algorithm, what goes wrong here?

#- creates a refactored subroutine sig based on RefactoredArgs
#- skips Common include statements, so it only keeps Parameter (I hope)
#- create_new_include_statements, this should be OBSOLETE, except that it takes ParamIncludes out of other Includes and instantiates them, so RENAME
#- creates ex-glob arg declarations, basically we have to look at ExInclArgs, UndeclaredOrigArgs and ExGlobArgs.
#- create_refactored_subroutine_call, I hope we can keep this
sub _refactor_globals_new { 
	( my $stref, my $f, my $annlines ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};

	if ( $Sf->{'RefactorGlobals'} == 2 ) {
		die "This should NEVER happen!";
	}

	# For the case of Contained subroutines
	my @par_decl_lines_from_container = ();
	if ( exists $Sf->{'Container'} ) {
		my $container = $Sf->{'Container'};
		if ( exists $stref->{'Subroutines'}{$container}{'Parameters'} ) {
			$Sf->{'ParametersFromContainer'} = $stref->{'Subroutines'}{$container}{'Parameters'};    # Note this is a nested set
			my $all_pars_in_container = get_vars_from_set( $stref->{'Subroutines'}{$container}{'Parameters'} );
			for my $par ( keys %{$all_pars_in_container} ) {
				my $par_decl      = $all_pars_in_container->{$par};
				my $par_decl_line = [ '      ' . emit_f95_var_decl($par_decl), { 'ParamDecl' => $par_decl, 'Ref' => 1 } ];
				push @par_decl_lines_from_container, $par_decl_line;
			}
		}
	}

	# For the case of subroutines in modules that either have params or USE params via modules
	my @par_decl_lines_from_module = ();
	if ( exists $Sf->{'InModule'} ) {
		my $mod = $Sf->{'InModule'};
		if ( exists $stref->{'Modules'}{$mod}{'Parameters'} ) {
			$Sf->{'ParametersFromModule'} = $stref->{'Modules'}{$mod}{'Parameters'};    # Note this is a nested set
			my $all_pars_in_module =
			  get_vars_from_set( $stref->{'Modules'}{$mod}{'Parameters'} );
			for my $par ( keys %{$all_pars_in_module} ) {
				my $par_decl      = $all_pars_in_module->{$par};
				my $par_decl_line = [
					'      ' . emit_f95_var_decl($par_decl),
					{
						'ParamDecl' => $par_decl,
						'Ref'       => 1,
						'Ann'       => [ annotate( $f, __LINE__ ) ]
					}
				];
				push @par_decl_lines_from_module, $par_decl_line;
			}
		}
	}

	print "REFACTORING GLOBALS in $f\n" if $V;
	my $rlines = [];
	my $s      = $Sf->{'Source'};

	# Create hook
	my $hook_after_last_incl = 0;
	if ( $Sf->{'ExGlobVarDeclHook'} == 0 ) {

		# If ExGlobVarDeclHook was not defined, we define it on the line *after* the last include or 'implicit none'
		$hook_after_last_incl = 1;
	}
	my $inc_counter = scalar keys %{ $Sf->{'Includes'} };

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
				# Do this before the analysis for RefactoredArgs!
				# NOTE: refactor_subroutine_signature() only adds ex-globals that where declared as COMMON in Includes
				$stref = refactor_subroutine_signature( $stref, $f );
			}

			# create_refactored_subroutine_signature() emits the new signature using RefactoredArgs as the args
			$rlines = create_refactored_subroutine_signature( $stref, $f, $annline, $rlines );
			$rlines = [ @{$rlines}, @par_decl_lines_from_container, @par_decl_lines_from_module ];
			$skip   = 1;
		}    #else {
			 # I'm assuming this means a PROGRAM or ENTRY
			 #}

		# There should be no need to do this: all /common/ blocks should have been removed anyway!
		if ( exists $info->{'Include'} ) {

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
				$mod_param_inc =~ s/\./_/g;
				delete $info->{'Includes'};
				push @{ $info->{'Ann'} }, annotate( $f, __LINE__ );
				$annline = [ $line, $info ];
				push @{$rlines}, $annline;
				$skip = 1;
			}
		}

		# We should either inline everything from the module or rewrite the module. I go for the former
		# In principle that is only possible if it's Inlineable
		#
		if ( exists $info->{'Use'} ) {
			if ( exists $info->{'Use'}{'Inlineable'}
				and $info->{'Use'}{'Inlineable'} == 1 )
			{
				--$inc_counter;
				$skip = 1;
			} else {
				warning( "Module " . $info->{'Use'}{'Name'} . " in $f is not Inlineable" ,4);
			}
		}
		# say  $inc_counter , exists $info->{'Include'}, exists $info->{'ImplicitNone'},$hook_after_last_incl ;
		if (    $inc_counter == 0
			and not exists $info->{'Include'}
			and not exists $info->{'ImplicitNone'}
			and $hook_after_last_incl == 1 )
		{

			$info->{'ExGlobVarDeclHook'} = 'AFTER LAST Include via _refactor_globals_new() line ' . __LINE__;
			$hook_after_last_incl = 0;
		}
		if ( exists $info->{'ImplicitNone'} and $info->{'ExGlobVarDeclHook'} eq 'ImplicitNone' ) {

			push @{$rlines}, $annline;
			$skip = 1;
		}

		if ( exists $info->{'ExGlobVarDeclHook'} ) {

			# FIXME: I don't like this, because in the case of a program there should simply be no globals etc.
			# Then generate declarations for ex-globals
			say "HOOK for $f: " . $info->{'ExGlobVarDeclHook'} if $V;

			say "EX-GLOBS for $f" if $V;
			$rlines = _create_extra_arg_and_var_decls( $stref, $f, $annline, $rlines );
		}

		if ( exists $info->{'SubroutineCall'} 
		# and not exists $info->{'ExtractedSubroutine'}
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
	# carp 'TODO: CAST VAR DECLS';
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
			my $rdecl = $Sf->{'CastReshapeVarDecls'}{'Set'}{$cast_reshape_vardecl};
			my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				$info->{'Ann'}       = [ annotate( $f, __LINE__ . ' : Cast/Reshape intermediate variable' ) ];
				$info->{'LineID'}    = $nextLineID++;
				$info->{'Ref'}       = 1;
				$info->{'VarDecl'} = { 'Name' => $cast_reshape_vardecl };
				push @{$cast_reshape_vardecl_annlines}, [ $rline, $info ];
		}

		my $insert_cond_subref = sub { (my $annline)=@_;
			my ($line, $info) = @{$annline};
			if (    not exists $info->{'Signature'}
			and not exists $info->{'VarDecl'}
			and not exists $info->{'ImplicitNone'}
			and not exists $info->{'SpecificationStatement'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Skip'}
			and not exists $info->{'Deleted'}
			) {
				return 1;
			} else {
				return 0;
			}
		};
		# Usage: 
		my $merged_annlines = splice_additional_lines_cond( $stref, $f, $insert_cond_subref, $rlines, $cast_reshape_vardecl_annlines, 1, 0, 1 );
		$rlines = $merged_annlines;
	}
#- Go through the AnnLines
#- Find the hook based on a condition on the $annline (i.e. $insert_cond_subref->($annline) )
#- splice the new lines before/after the hook depending on $insert_before
#- if $once is 0, do this whenever the condition is met. Otherwise do it once
# NOTE that get_annotated_sourcelines will preferentially use RefactoredCode rather than AnnLines 
# If this is unwanted, pass in $old_annlines explicitly	

	return $rlines;
}    # END of _refactor_globals_new()

# ExInclArgs, UndeclaredOrigArgs and ExGlobArgs
# ExInclLocalVars and UndeclaredOrigLocalVars.
# I must make sure that these do not already exists!
sub _create_extra_arg_and_var_decls {

	( my $stref, my $f, my $annline, my $rlines ) = @_;

	my $Sf         = $stref->{'Subroutines'}{$f};
	my $nextLineID = scalar @{$rlines} + 1;

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
				$info->{'Ann'}       = [ annotate( $f, __LINE__ . ' : INHERITED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];
				$info->{'LineID'}    = $nextLineID++;
				$info->{'Ref'}       = 1;
				$info->{'ParamDecl'} = { 'Name' => $par };
				push @{$rlines}, [ $rline, $info ];
			}
		}
		push @{$rlines}, $BLANK_LINE;
	}

	if ( exists $Sf->{'UsedParameters'}{'List'}
		and scalar @{ $Sf->{'UsedParameters'}{'List'} } > 0 )
	{
		print "INFO: UsedParameters in $f\n" if $I;

		for my $par ( @{ $Sf->{'UsedParameters'}{'List'} } ) {
			my $test_par = in_nested_set( $Sf, 'Parameters', $par );
			if ( not $test_par or $test_par eq 'UsedParameters' ) {
				say "INFO PAR in $f: $par " . Dumper( $Sf->{'UsedParameters'}{'Set'}{$par} )
				  if $I;
				my $rdecl = $Sf->{'UsedParameters'}{'Set'}{$par};
				my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				$info->{'Ann'}       = [ annotate( $f, __LINE__ . ' : INCLUDED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];
				$info->{'LineID'}    = $nextLineID++;
				$info->{'Ref'}       = 1;
				$info->{'ParamDecl'} = { 'Name' => $par };
				push @{$rlines}, [ $rline, $info ];
			}
		}
		push @{$rlines}, $BLANK_LINE;
	}

	print "INFO: ExGlobArgs in $f\n" if $I;

	for my $var ( @{ $Sf->{'ExGlobArgs'}{'List'} } ) {

		# Need to check if these were not already declared
		if (
				not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var}
			and not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$var}
			and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$var}
			# and exists $Sf->{'RefactoredArgs'}{'Set'}{$var} # Because otherwise there is no point
			#    	and not exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}
		  )
		{

			say "INFO VAR in $f: IODir for $var: " . $Sf->{'ExGlobArgs'}{'Set'}{$var}{'IODir'}
			  if $I and not $Sf->{'Program'};
			my $rdecl = $Sf->{'ExGlobArgs'}{'Set'}{$var};
			# croak Dumper($rdecl) if $var eq 'nx' and $f eq 'dyn';
			(my $inherited_param_decls, $Sf) = __generate_inherited_param_decls($rdecl, $var, $stref, $f,[]);
            #carp "VAR $var in $f";
			#  map { say 'INHERITED DECL:'. $_->[0] } @{$inherited_param_decls};
			my $rline = emit_f95_var_decl($rdecl);
			# carp $rline if $var eq 'w4' and $f eq 'mult_chk';
			my $info  = {};
			$info->{'Ann'}     = [ annotate( $f, __LINE__ . ' : EX-GLOB ' . $annline->[1]{'ExGlobVarDeclHook'} ) ]; #.' '.$rline
			$info->{'LineID'}  = $nextLineID++;
			$info->{'Ref'}     = 1;
			$info->{'VarDecl'} = { 'Name' => $var };                                                                  #$rdecl;
			$info->{'ArgDecl'} = 1;
			@{$rlines}=(@{$rlines},@{$inherited_param_decls});
			push @{$rlines}, [ $rline, $info ];
			
		}
	}    # for

	print "INFO: ExInclArgs in $f\n" if $I;
	for my $var ( @{ $Sf->{'ExInclArgs'}{'List'} } ) {
		say "INFO VAR: $var" if $I;
		my $rdecl = $Sf->{'ExInclArgs'}{'Set'}{$var};
		my $rline = emit_f95_var_decl($rdecl);
		my $info  = {};
		$info->{'Ann'}     = [ annotate( $f, __LINE__ . ' : EX-INCL' ) ];
		$info->{'LineID'}  = $nextLineID++;
		$info->{'Ref'}     = 1;
		$info->{'VarDecl'} = { 'Name' => $var };                            #$rdecl;
		push @{$rlines}, [ $rline, $info ];
	}    # for

	print "INFO: UndeclaredOrigArgs in $f\n" if $I;
	
	my %unique_ex_impl = ();
	for my $var ( @{ $Sf->{'UndeclaredOrigArgs'}{'List'} } ) {
		if (    not exists $Sf->{'UsedGlobalVars'}{'Set'}{$var}
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
				my $rdecl = $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};

				my $external   = exists $rdecl->{'External'};
				my $undeclared = exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};
				if ( not $external
					or ( $external and $undeclared ) )
				{
					my $rline = emit_f95_var_decl($rdecl);
					my $info  = {};
					$info->{'Ann'} =
					  [ annotate( $f, __LINE__ . ' : EX-IMPLICIT' ) ];
					$info->{'LineID'}  = $nextLineID++;
					$info->{'Ref'}     = 1;
					$info->{'VarDecl'} = { 'Name' => $var };
					push @{$rlines}, [ $rline, $info ];
				}
			}
		}
	}    # for

	print "INFO: ExInclLocalVars in $f\n" if $I;
	for my $var ( @{ $Sf->{'ExInclLocalVars'}{'List'} } ) {
		say "INFO VAR: $var" if $I;
		my $rdecl = $Sf->{'ExInclLocalVars'}{'Set'}{$var};
		my $rline = emit_f95_var_decl($rdecl);
		my $info  = {};
		$info->{'Ann'}     = [ annotate( $f, __LINE__ . ' : EX-INCL VAR' ) ];
		$info->{'LineID'}  = $nextLineID++;
		$info->{'Ref'}     = 1;
		$info->{'VarDecl'} = { 'Name' => $var };                                #$rdecl;
		push @{$rlines}, [ $rline, $info ];
	}    # for

	print "INFO: UndeclaredOrigLocalVars in $f\n" if $I;
	for my $var ( @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} } ) {

		if ( not exists $Sf->{'UsedGlobalVars'}{'Set'}{$var} ) {

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

				#    	exists $Sf->{'Parameters'}{'Set'}{$var} or exists $Sf->{'ParametersFromContainer'}{'Set'}{$var}
			  )
			{
				$is_param = 1;
			}

			# I don't explicitly declare variables that conflict with reserved words or intrinsics.
			my $var_is_sub = 0;

			#    	say $var.' : '. (exists $Sf->{'External'}{$var}).','.().','.(exists $stref->{'Subroutines'}{$var});
			if ( exists $Sf->{'CalledSubs'}{'Set'}{$var}
				and $Sf->{'CalledSubs'}{'Set'}{$var} == 1 )
			{
				$var_is_sub = 1;
			}
			if ( exists $stref->{'Subroutines'}{$var}
				and not exists $stref->{'Subroutines'}{$var}{'Function'} )
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
				
				

				#    		and not ( # an internal subroutine
				#    			exists $Sf->{'CalledSubs'}{'Set'}{$var} and
				#    			not exists $Sf->{'External'}{$var} and
				#    			not exists $stref->{'Subroutines'}{$var}{'Function'}
				#    			)
				#    		and not ( # an external subroutine
				#    			exists $Sf->{'External'}{$var} and
				#    			exists $Sf->{'CalledSubs'}{'Set'}{$var} and
				#    			$Sf->{'CalledSubs'}{'Set'}{$var} == 1)
				and not $var_is_sub
				and not $is_param
				and $var !~ /__PH\d+__/            # FIXME! TOO LATE HERE!
				and $var =~ /^[a-z][a-z0-9_]*$/    # FIXME: rather check if Expr or Sub
				)
			  )
			{
				   			# croak Dumper($Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var}) if $var eq 'len';
				my $rdecl = $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var};
				$rdecl->{'Ann'} = "in $f (implicit declaration)";
				# carp Dumper($stref->{'Subroutines'}{  $var});
				my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				$info->{'Ann'} =
				  [ annotate( $f, __LINE__ . ' : EX-IMPLICIT VAR' ) ];
				$info->{'LineID'}  = $nextLineID++;
				$info->{'Ref'}     = 1;
				$info->{'VarDecl'} = { 'Name' => $var };    #$rdecl;
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
		$info->{'Ann'}     = [ annotate( $f, __LINE__ . ' : EX-IMPLICIT COMMON' ) ];
		$info->{'LineID'}  = $nextLineID++;
		$info->{'Ref'}     = 1;
		$info->{'VarDecl'} = { 'Name' => $var };                                       #$rdecl;
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
sub _create_refactored_subroutine_call {
	( my $stref, my $f, my $annline, my $rlines ) = @_;

	( my $line, my $info ) = @{$annline};
	my $name = $info->{'SubroutineCall'}{'Name'};

	my $Sf   = $stref->{'Subroutines'}{$f};

	if ( exists $stref->{'ExternalSubroutines'}{$name} ) {
		push @{$rlines}, [ $line, $info ];
		return $rlines;
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
# croak $subset, Dumper($call_arg_expr, $call_arg_decl) if $call_arg eq 'fs335';
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
				
				my $cast_reshape_result = _maybe_cast_call_args($stref, $f, $name, $call_arg,$call_arg_decl,$sig_arg, $sig_arg_decl);
				# say Dumper($cast_reshape_result)  if $name =~/mpi_reduce_double_precision/;
				# croak Dumper($sig_arg_decl,$call_arg_decl)  if $name =~/mpi_reduce_double_precision/ and $call_arg eq 'data1';
				$call_arg = $cast_reshape_result->{'CallArg'};
				push @cast_reshape_results, $cast_reshape_result if $cast_reshape_result->{'Status'} == 2;
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
			$info->{'Ann'} = [ annotate( $f, __LINE__ ) ];
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
			$info->{'Ann'} = [ annotate( $f, __LINE__ ) ];

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


			$info->{'SubroutineCall'}{'Args'}{'List'} = $args_ref;

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
			$info->{'Ann'} = [ annotate( $f, __LINE__ ) ];

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

# This is for lines that contain function calls, so in practice either assignments or subroutine calls -- or conditional statements
sub _create_refactored_function_calls {
	( my $stref, my $f, my $annline, my $rlines ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};

	( my $line, my $info ) = @{$annline};

	#    say "$f LINE: $line".Dumper($info) ;
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
		$ast = $info->{'CondExecExprAST'};
	} else {
		croak "TODO: UNSUPPORTED STATEMENT FOR FUNCTION CALL: <$line> ( _create_refactored_function_calls ) "  if $DBG;
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

					#				say "SUB $f CALLING $name:".Dumper($stref->{'Subroutines'}{$name}{'ExGlobArgs'});
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

				# For mismatched COMMON blocks we need to append the call args with 'CallArgs'
				my @maybe_renamed_exglobs = ();
				for my $sig_arg ( @{ $stref->{'Subroutines'}{$name}{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} } ) {
					my $call_arg =
						$stref->{'Subroutines'}{$name}{'ExMismatchedCommonArgs'}{'CallArgs'}{$f}{$sig_arg}[0][0];
					push @maybe_renamed_exglobs, $call_arg;
					croak "$name called in $f => $sig_arg " if $DBG and not defined $call_arg;
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
		# carp(Dumper($ast) );
		my $entry = __update_function_calls_in_AST( $stref, $Sf, $f, $ast->[2] );
		$ast->[2] = $entry;
	} elsif ( ( $ast->[0] & 0xFF ) < 29 and ( $ast->[0] & 0xFF ) != 2 ) {    # other operators
	
		for my $idx ( 1 .. scalar @{$ast} - 1 ) {
			my $entry = __update_function_calls_in_AST( $stref, $Sf, $f, $ast->[$idx] );
			$ast->[$idx] = $entry;
		}
	}

	return $ast;    #($stref,$f, $ast);

}    # END of __update_function_calls_in_AST()

# For every $var in BlockData we need ${var}_ARG = $var
sub _add_extra_assignments_in_block_data {
	( my $stref, my $f, my $annlines ) = @_;
	my $Sf                   = $stref->{'Subroutines'}{$f};
	my $new_annlines         = [];
	my $extra_arg_decl_lines = [];
	for my $arg ( @{ $Sf->{'ExGlobArgs'}{'List'} } ) {
		my $maybe_renamed_arg = $arg;
		my $decl              = $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg};
		if ( not exists $decl->{'OrigName'} ) {

			# This means the ExGlobArgs are the original ones, not the renamed ones
			$maybe_renamed_arg = $arg . '_ARG';
			my $mod_decl = dclone($decl);
			$mod_decl->{'Name'}                         = $maybe_renamed_arg;
			$mod_decl->{'OrigName'}                     = $arg;
			$Sf->{'ExGlobArgs'}{'Set'}{ $arg . '_ARG' } = $mod_decl;
			delete $Sf->{'ExGlobArgs'}{'Set'}{$arg};
			@{ $Sf->{'ExGlobArgs'}{'List'} } = map { $_ eq $arg ? $maybe_renamed_arg : $_ } @{ $Sf->{'ExGlobArgs'}{'List'} };

			# Need to check if these were not already declared
			if (
					not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$maybe_renamed_arg}
				and not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$maybe_renamed_arg}
				and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$maybe_renamed_arg}

				#    	and not exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}
			  )
			{

				say "INFO VAR in $f: IODir for $maybe_renamed_arg: " . $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg}{'IODir'}
				  if $I and not $Sf->{'Program'};
				my $rdecl = $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg};
				my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				$info->{'Ann'}     = [ annotate( $f, __LINE__ . ' : EX-GLOB ' ) ];
				$info->{'LineID'}  = 0;                                              #$nextLineID++;
				$info->{'Ref'}     = 1;
				$info->{'VarDecl'} = { 'Name' => $maybe_renamed_arg };               #$rdecl;
				$info->{'ArgDecl'} = 1;
				push @{$extra_arg_decl_lines}, [ $rline, $info ];
			}
		}
		my $orig_arg_name = $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg}{'OrigName'};
		push @{$new_annlines}, [ "        $maybe_renamed_arg = $orig_arg_name", { 'Extra' => 1 } ];

	}

	#       my $stref,
	#        my $f,
	#        my $insert_cond_subref,
	#        my $old_annlines,
	#        my $new_annlines,
	#        my $insert_before,
	#        my $skip_insert_pos_line,
	#        my $do_once
	#croak Dumper($annlines);
	my $merged_annlines = splice_additional_lines_cond(
		$stref, $f,
		sub {
			( my $annline ) = @_;
			return exists $annline->[1]{'EndBlockData'} ? 1 : 0;
		},
		$annlines,
		$new_annlines,
		1,
		0,
		1
	);
##croak Dumper($extra_arg_decl_lines);
	my $merged_annlines_w_args = splice_additional_lines_cond(
		$stref, $f,
		sub {
			( my $annline ) = @_;
			return exists $annline->[1]{'Data'} ? 1 : 0;
		},
		$merged_annlines,
		$extra_arg_decl_lines,
		1,
		0,
		1
	);

	#croak Dumper(pp_annlines($merged_annlines_w_args));
	return $merged_annlines_w_args;
}    # END of _add_extra_assignments_in_block_data

sub _add_implicit_none {
	my ( $stref, $f, $annlines ) = @_;
	my $Sf            = $stref->{'Subroutines'}{$f};
	my $first_vardecl = 1;
	my $rlines        = [];
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		if ( ( exists $info->{'VarDecl'} or exists $info->{'ParamDecl'} or exists $info->{'Equivalence'} )
			and $first_vardecl )
		{
			$first_vardecl = 0;

			# Here I think I can insert 'implicit none'
			if ( not exists $Sf->{'ImplicitNone'} ) {
				say "Adding 'implicit none' at " . __PACKAGE__ . ' ' . __LINE__
				  if $V;
				my $r_info = {};
				my $indent = ' ' x 6;
				$r_info->{'Indent'}       = $indent;
				$r_info->{'ImplicitNone'} = 1;
				$r_info->{'Ann'}          = [ annotate( $f, __LINE__ ) ];
				push @{$rlines}, [ $indent . 'implicit none', $r_info ];
			}
		}
		push @{$rlines}, $annline;
	}
	return $rlines;
}    # END of _add_implicit_none

# The assignment lines for the mismatched ex-COMMON vars should come
# before the first line that is not a SpecificationStatement and not a Comment and not a Blank and not Skip or Deleted

sub _add_ExMismatchedCommonArg_assignment_lines {
	my ( $stref, $f, $annlines ) = @_;
	my $Sf             = $stref->{'Subroutines'}{$f};
	my $first_vardecl  = 1;
	my $last_statement = 0;
	my $rlines         = [];

	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		if (    not exists $info->{'Signature'}
			and not exists $info->{'VarDecl'}
			and not exists $info->{'ImplicitNone'}
			and not exists $info->{'SpecificationStatement'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Skip'}
			and not exists $info->{'Deleted'}
			and $first_vardecl == 1 )
		{
			$first_vardecl = 0;
			
			for my $rline ( @{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'ArgAssignmentLines'} } ) {				
				# push @{$rlines}, $rline ;
				push @{$rlines}, [$rline->[0].' ! ArgAssignmentLines', $rline->[1]] ;
			}
		}

		# For the reverse assignments:
		# In a subroutine they should come before a RETURN or before the END
		#  In a function they should come before the assignment to the function name, a RETURN or the END, whichever is first
		if ( ( exists $info->{'Return'} or exists $info->{'EndSubroutine'} or ( exists $info->{'Assignment'} and $info->{'Lhs'}{'VarName'} eq $f ) )
			and $last_statement == 0 )
		{
			$last_statement = 1;

			#			carp "Found location for reverse assignments in $f: $line";
			for my $rline ( @{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'ArgRevAssignmentLines'} } ) {
# say 'HERE '.$rline->[0];
						        		# say "ADDING LINE ".$rline->[0]." to $f ";
				# push @{$rlines}, $rline;
				push @{$rlines}, [$rline->[0].' ! ArgRevAssignmentLines', $rline->[1]] ;
			}

		}
		push @{$rlines}, $annline;
	}
	return $rlines;
}    # END of _add_ExMismatchedCommonArg_assignment_lines

=info_equivalence
EQUIVALENCE done right:

v_loc = v_glob

1. v_loc is updated either as LHS or as Out or InOut in a CALL
v_loc = exp()
call f(v_loc::(InOut|Out))
v_glob = v_loc

2. Same but we modify v_loc in a function call. This change gets wiped out as the assignment happens last
v_loc = f(v_loc::(InOut|Out)) 
v_glob = v_loc

3. Same but we modify v_glob in a function call. This change gets wiped out as the assignment happens last, and assigning to v_loc is the same as assigning to v_glob

v_loc = f(v_glob::(InOut|Out)) -- so we modify v_glob, then we modify v_loc
v_glob = v_loc

The opposite case (swap v_loc and v_glob) is the same. 
=cut

sub __insert_assignment_for_ex_EQUIVALENCE_vars {
	my ( $stref, $f, $annline, $rlines, $equiv_pairs ) = @_;
	( my $line, my $info ) = @{$annline};
	my $skip = 0;
	if ( exists $info->{'Assignment'} and not exists $info->{'ExCommonOrEquivalence'}) {
		my $lhs_var = $info->{'Lhs'}{'VarName'};

# But this is not right because we need the variable only I think
# There is no way to infer the array index if it's an array
# Problem is of course that we now can't search by key in equiv_pairs
# because the key is the expression used in the EQUIVALENCE statement 
# carp Dumper( $line, $info);
		my $lhs_ast = $info->{'Lhs'}{'ExpressionAST'};
		my $lhs_v_str = emit_expr_from_ast($lhs_ast);
		
		$lhs_v_str = $lhs_var; # Ugly HACK! FIXME!
		if ( exists $equiv_pairs->{$lhs_v_str} ) {
			# insert the extra line
			push @{$rlines}, $annline;
			say 'INSERTING ' . join( "\n", Dumper(pp_annlines( $equiv_pairs->{$lhs_v_str} ) )) . ' after ' . $line if $DBG;
			$rlines = [ @{$rlines}, @{ $equiv_pairs->{$lhs_v_str} } ];
			$skip   = 1;
		}
		if (exists  $info->{'FunctionCalls'}) {
			# This is a line with a number of function calls
			# Go through every call
			for my $fcall ( @{ $info->{'FunctionCalls'} } ) {
        	   my $fname = $fcall->{'Name'};
				my $ast = $fcall->{'ExpressionAST'};
				# This is the AST of the function call, so f(...) ['&','f',[',',@fargs]]
				# So what I need is @fargs, i.e. $ast->[1]
				my $args_vars = find_args_vars_in_ast($ast);
				my $args = $args_vars->[1]{'List'};
				# carp Dumper($ast);	
				my $arg_asts = @{$ast->[2]} ?  $ast->[2][0] == 27 ? [@{$ast->[2]}] : [ $ast->[2]  ] : []; 
				shift @{$arg_asts} if @{$arg_asts}; 				
				if (scalar @{$args} > 0 ) { # should be same number as $arg_asts
					if ($skip==0) {
						push @{$rlines}, $annline;
						$skip   = 1;
					}		
					# for my $arg (@{$args}) {
					# 	if ( exists $equiv_pairs->{$arg} ) {
					# 		$rlines = [ @{$rlines}, @{ $equiv_pairs->{$arg} } ];
					# 	}
					# }
					for my $arg_ast (@{$arg_asts}) {
						
						my $arg=emit_expr_from_ast($arg_ast);
						
						if ( exists $equiv_pairs->{$arg} ) {
							# say Dumper($equiv_pairs->{$arg});
							$rlines = [ @{$rlines}, @{ $equiv_pairs->{$arg} } ];
						}
					}
				} 	
			}
		# carp 'TODO: process Function calls on RHS! '. Dumper($info->{'FunctionCalls'}) ;
		}
	} elsif ( exists $info->{'ReadCall'} ) {	
		# FIXME: I don't know how to get array accesses from a READ call, so I pretend they're always scalar
		# So in the case of a transitive EQUIVALENCE between real and complex this will go wrong ...
		my @vars =  @{ $info->{'Vars'}{'Written'}{'List'} } ;
#		croak Dumper(@vars);
		if (scalar @vars>0) {
			push @{$rlines}, $annline;
			$skip   = 1;
	
			for my $arg (@{vars}) {
				if ( exists $equiv_pairs->{$arg} ) {
					$rlines = [ @{$rlines}, @{ $equiv_pairs->{$arg} } ];
				}
			}
		}
	} elsif ( exists $info->{'SubroutineCall'} ) {

		# Unfortunately at this point we do not yet know the intent
		# So I will assume any call is an update
		for my $call_arg ( @{ $info->{'SubroutineCall'}{'Args'}{'List'} } ) {
			my $call_arg_name = $call_arg;
			# $call_arg_name =~ s/\(.+$//;
			if ( exists $equiv_pairs->{$call_arg_name} ) {
				# Means the arg is getting modified
				push @{$rlines}, $annline if $skip == 0;
				$rlines = [ @{$rlines}, @{ $equiv_pairs->{$call_arg_name} } ];
				say 'INSERTING ' . join( "\n", pp_annlines( $equiv_pairs->{$call_arg_name} ) ) . ' after ' . $line if $DBG;
				$skip = 1;
			}
		}
	}

	return ( $rlines, $skip );
}    # END of __insert_assignment_for_ex_EQUIVALENCE_vars

sub _change_EQUIVALENCE_to_assignment_lines_for_ExCommonArgs {
	my ( $stref, $f, $annlines ) = @_;
	my $Sf                        = $stref->{'Subroutines'}{$f};
	my $last_statement            = 0;
	my $first_occ                 = 1;
	my $rlines                    = [];
	my $postUpdateAssignmentLines = {};
	my $exEquivAssignmentLines    = [];
	my $equiv_pairs               = {};

	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};
		my $skip = 0;
		if ( exists $info->{'Equivalence'} ) {
			my $rline = $annline;
			my $ast = dclone( $info->{'Ast'} );

			# Two cases: either a list of tuples, or a single tuples
			if ( ( $ast->[0] & 0xFF ) == 0 ) {

				# a single tuple, ['(',[',',@vs]]
				( $rline, $exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs, my $replaced ) =
				  __refactor_EQUIVALENCE_line( $stref, $f, $ast, 
				  $exEquivAssignmentLines, $postUpdateAssignmentLines, $annline, $equiv_pairs );
				  if ($replaced) {
				$info->{'Deleted'} = 1;
				push @{$rlines}, [ '!' . $line, $info ];
				  } else {
					#   croak 'HERE!';
					  push @{$rlines}, $annline;
				  }
			} elsif ( ( ( $ast->[0] & 0xFF ) == 27 )
				&& ( ( $ast->[1][0] & 0xFF ) == 0 ) )
			{
				# a list of tuples
				shift @{$ast};
				for my $pair_ast ( @{$ast} ) {
					( $rline, $exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs ) =
					  __refactor_EQUIVALENCE_line( $stref, $f, $pair_ast, 
					  $exEquivAssignmentLines, $postUpdateAssignmentLines, $annline, $equiv_pairs );
					$info->{'Deleted'} = 1;
					push @{$rlines}, [ '!' . $line, $info ];

				}
			} else {
				croak "INVALID AST : " . Dumper($ast) . ( $ast->[0] & 0xFF ) . ( $ast->[1][0] & 0xFF ) if $DBG;
			}

			if ( $line ne $rline->[0] ) {

				#				say "CHANGING LINE $line TO ".$rline->[0]." in $f ";
			}
			$skip = 1;
		}

		# For the assignments:
		# They should come after the last SpecificationStatement
		elsif ( not exists $info->{'Signature'}
			and not exists $info->{'VarDecl'}
			and not exists $info->{'ImplicitNone'}
			and not exists $info->{'SpecificationStatement'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Skip'}
			and not exists $info->{'Deleted'}
			and $first_occ == 1 )
		{
			$first_occ = 0;
			# say "AFTER LINE $line";
			for my $rline ( @{$exEquivAssignmentLines} ) {
				say 'REPLACED EQUIVALENCE BY ' . Dumper($rline) if $DBG;				
				push @{$rlines}, $rline;
			}
		} else {
			( $rlines, $skip ) = __insert_assignment_for_ex_EQUIVALENCE_vars( $stref, $f, $annline, $rlines, $postUpdateAssignmentLines );
		}

		push @{$rlines}, $annline unless $skip;
	}
	return $rlines;
}    # END of _change_EQUIVALENCE_to_assignment_lines_for_ExCommonArgs

sub __refactor_EQUIVALENCE_line {
	( my $stref, my $f, my $ast, my $exEquivAssignmentLines, my $postUpdateAssignmentLines, my $annline, my $equiv_pairs ) = @_;
	my $Sf    = $stref->{'Subroutines'}{$f};
	my $rline = $annline;
	my ( $line, $info ) = @{$annline};
	
	my $ann=annotate( $f, __LINE__  );
	#EQUIVALENCE can be general tuple, not just two elts. I need to take this apart into pairs!
	# $ast : ['(',[',',@vs]]
	my @asts = @{ $ast->[1] }; # @asts : (',',@vs)
	shift @asts; # @asts : @vs; 
	my @equiv_tuple = map { $_->[1] } @asts; # just the names

	my @pairs = ();

	for my $ast1 (@asts) {
		my $elt1      = $ast1->[1];
		my $found_elt = 0;
		for my $ast2 (@asts) {
			my $elt2 = $ast2->[1];
			if ( $elt1 eq $elt2 ) {
				$found_elt = 1;
			} elsif ($found_elt) {
				push @pairs, [ $ast1, $ast2 ];
			}
		}
	}

	# And perversely, if a line has multiple tuples, this is allowed: (v1,v2),(v2,v3)
	# So I must do some kind of transitivity check, I'll use $equiv_pairs for that
	# now suppose it is (v1,v2,v3),(v3,v4,v5) the this effectively means (v1,v2,v3,v4,v5)
	# So for each v3, v4, v5 I have to check in $equiv_pairs
	# Initially I will find v3 and so v1 and v2, but of course we already have that.
	# But then I should create pairs for v4 and v5 with v1 and v2 as well

	my $transitive = 0;
	my $trans_var;

	for my $ast (@asts) { # $ast : ['$',v] | ['@',v,@idxs]
		my $var_name = $ast->[1]; # the name
		my $indexed_array_expr = $ast->[0] == 10 ? 1 : 0;
		my $var = $indexed_array_expr ? emit_expr_from_ast($ast) : $var_name; 
		
		if ( exists $equiv_pairs->{$var} ) {
			# must check if that one was indexed with the same index
# For proper transitivity, the array expressions must be the same 
# i.e. (v1,v2,v3(1)),(v3(2),v4) is not transitive
# Now, $equiv_pairs contains all pairs that are connected. 
# so v1 =>[v2,v3]
# v3 => [v1,v2,v4]
# I thought I could solve this by adding v3 to this list, but what I really need is
# v3(1) => [v1,v2] and v3(2)=> [v4]
# So I guess I should use the full expression string as key, and then I can use the name as secondary key with the ast
# so  'v3(1)' => {v1 => ast1, v2=>ast2, 'v3(1) => ast31 }
# and 'v3(2)' => {v4 => ast4,  'v3' => ast32, }
# Then a test $equiv_pairs->{$var_expr_str} works I can still get the var name only form $ast->[1]
			# croak if $indexed_array_expr;
			$transitive = 1;
			$trans_var  = $var;
			last;
		}
	}

	if ($transitive) {
#		say "TRANSITIVE!";
		for my $ast1 (@asts) {
			my $var1 = emit_expr_from_ast($ast1);
			if ( $var1 ne $trans_var ) {
				for my $var2 ( keys %{ $equiv_pairs->{$trans_var} } ) {
					my $ast2 = $equiv_pairs->{$trans_var}{$var2};
					push @pairs, [ $ast1, $ast2 ];
#					say "ADDED: ($var1,$var2)";
				}
			}
		}
	}

	# Another utterly perverse feature is this:
	#      DIMENSION RADE11(5), RADE12(5)
	#      EQUIVALENCE (RADE11(4), RADE12(2))
	# Because the arrays start at 1, and they overlap, this actually creates an equivalence between
	#   RADE11(3), RADE12(1)
	# and
	# RADE11(5), RADE12(3)
	# as well
	# So what we should do is equate the overlapping ranges. This is just crazy.
	# if a pair consists of two arrays
	# and at least one of them is indexed
	# then we must check if this caused an overlap, as follows:
	# find the smaller of the two
	# if ($index1 - $offset1 < $index2 - $offset2) {

	# offset it with the starting index,
	#	$trange1 = $index1 - $offset1 + 1
	# and subtract this from the larger of the two
	# $start_index2 = ($index2-$offset2+1)-$trange1+1
	# this is the start index for that array
	# then check if the end index of that array
	# if it is smaller than the end index of the other array,
	# if ($end_index2-$start_index2+$offset1<$end_index1) {
	# $range2=$end_index2-$start_index2+1;
	# $array2 = [$start_index2 ,$end_index2];
	# $array1  = [$offset1 ,$offset1+$range2-1 ];
	# That gives the range for the other array
	# } else {
	# $range1 = $end_index1-offset1+1;
	# $array1 =[$offset1 ,$end_index1];
	# $array2 =[$start_index2,$start_index2 + $range1 - 1];
	# }
	# end_index1 +1 - offset1 = range1, start_index2 +  range1 - offset2 = end_index2
	#     1 2 3 4 5 6 7 8
	# 1 2 3 4 5 6
	#
	#     1 2 3 4
	# 1 2 3 4 5 6 7 8
	# } else reverse the whole thing
	my $replaced=1; # We assume we will replace the EQUIVALENCE 
	for my $pair (@pairs) {
		my $ast1 = $pair->[0];
		my $ast2 = $pair->[1];
		my $var1 = $ast1->[1];
		my $var2 = $ast2->[1];
		
		my $var1_decl = get_var_record_from_set( $Sf->{'Vars'}, $var1 );
		my $var2_decl = get_var_record_from_set( $Sf->{'Vars'}, $var2 );
		my $v1_is_array = ( exists $var1_decl->{'ArrayOrScalar'} and ( $var1_decl->{'ArrayOrScalar'} eq 'Array' ) ) ? 1 : 0;
		my $v2_is_array = ( exists $var2_decl->{'ArrayOrScalar'} and ( $var2_decl->{'ArrayOrScalar'} eq 'Array' ) ) ? 1 : 0;
		my $v1_type = $var1_decl->{'Type'};
		my $v2_type = $var2_decl->{'Type'};
		if (@pairs==1 and $v1_type eq 'character' and $v2_type ne 'character' ) {
			# croak Dumper($pair);
			$replaced=0;
			last;
		}
		my $v1          = $v1_is_array ? emit_expr_from_ast($ast1) : $var1;
		my $v2          = $v2_is_array ? emit_expr_from_ast($ast2) : $var2;
		
		if ( not exists $equiv_pairs->{$v1} ) {
			$equiv_pairs->{$v1} = { $v2 => $ast2, $v1 => $ast1  };
		} else {
			$equiv_pairs->{$v1}{$v2} = $ast2;
		}

		# And the reverse as well
		if ( not exists $equiv_pairs->{$v2} ) {
			$equiv_pairs->{$v2} = { $v1 => $ast1, $v2 => $ast2 };
		} else {
			$equiv_pairs->{$v2}{$v1} = $ast1;
		}

		my $v2_v1_pair = [ $v2, $v1 ];		
		my $v1_v2_pair = [ $v1, $v2 ];
		my $ann=annotate( $f, __LINE__  );
		my $remove_equiv_stmt = 1;

		if ( $v1_is_array and not $v2_is_array ) {

			if ( $v2_type ne 'complex') {
				# v1 is an array, v2 is a scalar. So if v1 is not indexed, we have a mismatch
				if ( $v1 eq $var1 ) {
					my $start_idx1 = join( ',', map { $_->[0] } @{ $var1_decl->{'Dim'} } );
					$v2_v1_pair = [ $v2, "$v1($start_idx1)" ];    #
					$v1_v2_pair = ["$v1($start_idx1)",$v2 ];
					$ann=annotate( $f, __LINE__  );
				} else {
					$ann=annotate( $f, __LINE__  );
				}
			}
			# else it means v1 was already indexed
		} elsif ( not $v1_is_array and $v2_is_array ) {
			
			if ( $v1_type ne 'complex') {
				if ( $v1_type ne 'character') {
				# v2 is an array, v1 is a scalar. So if v2 is not indexed, we have a mismatch
				if ( $v2 eq $var2 ) {
					
					my $start_idx2 = join( ',', map { $_->[0] } @{ $var2_decl->{'Dim'} } );
					$v1_v2_pair = [ $v1, "$v2($start_idx2)" ];    #
					$v2_v1_pair = ["$v2($start_idx2)", $v1];
					# croak 'HERE: '.$v1_type.';'.$v1_v2_pair->[1];
					$ann=annotate( $f, __LINE__  );
				} else {
					$ann=annotate( $f, __LINE__  );
				}
				} else {
				# v2 is an array, v1 is a character string. We need to see if the string size
				# and array size in bytes are the same.
				# The question is what it should become of course
				#       integer fnami (33)
      			#		character*132 fname,re2fle
      			#		equivalence (fname,fnami)
			    # fname = fnami ?!?
				# So how to cast a character string to an array of integers?
				if ( $v2 eq $var2 ) {					
					my $start_idx2 = join( ',', map { $_->[0] } @{ $var2_decl->{'Dim'} } );
					$v1_v2_pair = [ $v1, "$v2($start_idx2)" ];    #
					$v2_v1_pair = ["$v2($start_idx2)", $v1];
					# croak 'HERE: '.$v1_type.';'.$v1_v2_pair->[1];
					$ann=annotate( $f, __LINE__  );
				} else {
					$ann=annotate( $f, __LINE__  );
				}					
				}
			} 			# else it means v2 was already indexed
		} elsif ( $v1_is_array and $v2_is_array ) {
			
			my $overlapping=0;
		
			my $dim1 = $var1_decl->{'Dim'};
			my $dim2 = $var2_decl->{'Dim'};
			# [10 ,'v' ,[ ',',['const' ,$idx]]
			# This is of course wrong because it assumes 1-D arrays only!
			 
			my $index1 = $ast1->[0]==10 ? $ast1->[2][1] : $dim1->[0][0];
			my $index2 = $ast2->[0]==10 ? $ast2->[2][1] : $dim2->[0][0];
			if (
			 (scalar @{$dim1}==1 and scalar @{$dim2}==1) # FIXME! WEAK!  
			 and
			$index1-$dim1->[0][0] != $index2-$dim2->[0][0]) {
				say "OVERLAPPING: ".Dumper($index1, $index2) if $DBG;
				$overlapping=1;			
			}
			if ($overlapping) {
				my ($array1, $array2) = @{__equate_overlapping_ranges( $index1, $dim1, $index2, $dim2 ) };
				my ($offset1, $range1)=@{$array1};
				my ($offset2, $range2)=@{$array2};
				$v2_v1_pair = [ "$var2($offset2:$range2:1)", "$var1($offset1:$range1:1)" ];
				$v1_v2_pair = [ "$var1($offset1:$range1:1)", "$var2($offset2:$range2:1)" ];
				$ann=annotate( $f, __LINE__  );
			} else {
				$ann=annotate( $f, __LINE__  );
				if ( $v1 eq $var1 and $v2 eq $var2 ) {

					# and also assignment is array to array
					my $dim1  = $var1_decl->{'Dim'};
					my $dim2  = $var2_decl->{'Dim'};
					my ($size1, $not_const1) = calculate_array_size( $stref, $f, $dim1 );
					my ($size2, $not_const2) = calculate_array_size( $stref, $f, $dim2 );

					# but the rank we need is the rank of the expression
					# FIXME: I will assume that if the array is indexed, all indices are used, i.e. rank is 0
					my $rank1 = $v1 eq $var1 ? get_array_rank($dim1) : 0;
					my $rank2 = $v2 eq $var2 ? get_array_rank($dim2) : 0;

					# if the same rank and different size
					if ( $size1 == $size2 and $rank1 != $rank2 ) {

						# if different rank and same size
						# reshape
						$v2_v1_pair = [ $var2, "reshape($var1,shape($var2))" ];
						$v1_v2_pair = [ $var1, "reshape($var2,shape($var1))" ];
						$ann=annotate( $f, __LINE__  );
					} elsif ( $size1 != $size2 and $rank1 == $rank2 ) {
						if ( $rank1 == 1 ) {

							# 1:size, 0:size-1, -1:size-2 => $size-1+$offset
							# If the rank is the same, take the overlap, i.e. the smallest dim
							my $size    = $size1 < $size2 ? $size1 : $size2;
							my $offset1 = $var1_decl->{'Dim'}[0][0];
							my $offset2 = $var2_decl->{'Dim'}[0][0];
							my $range1  = $size - 1 + $offset1;
							my $range2  = $size - 1 + $offset2;
							$v2_v1_pair = [ "$var2($offset2:$range2:1)", "$var1($offset1:$range1:1)" ];
							$v1_v2_pair = [ "$var1($offset1:$range1:1)", "$var2($offset2:$range2:1)" ];
							$ann=annotate( $f, __LINE__  );
						} else {
							say 'WARNING: EQUIVALENCE statement not refactored because it is between two arrays of rank > 1 and different size: '."\n$line\n";;
							$remove_equiv_stmt = 0;
						}
					} else {

						# else give up, warn and keep the original line

						say 'WARNING: EQUIVALENCE statement not refactored because it is between two arrays of different rank and size: '."\n$line\n";
						$remove_equiv_stmt = 0;
					}
				} elsif ( $v1 eq $var1 and $v2 ne $var2 ) {

					# v1 is array, v2 is indexed => need to use start index for v1
					my $start_idx1 = join( ',', map { $_->[0] } @{ $var1_decl->{'Dim'} } );
					$v2_v1_pair = [ $v2, "$v1($start_idx1   )" ];    #
					$v1_v2_pair = [ "$v1($start_idx1   )", $v2 ];
					$ann=annotate( $f, __LINE__  );
				} elsif ( $v1 ne $var1 and $v2 eq $var2 ) {

					# v1 is indexed, v2 is array => need to use start index for v2
					my $start_idx2 = join( ',', map { $_->[0] } @{ $var2_decl->{'Dim'} } );
					$v1_v2_pair = [ $v1, "$v2($start_idx2   )" ];    #
					$v2_v1_pair = [ "$v2($start_idx2   )", $v1 ];
					$ann=annotate( $f, __LINE__  );
				}
			}
		}

		# else {
		# Both are scalars, nothing special
		#}
		#	my $indent = $info->{'Indent'};
		if ($remove_equiv_stmt) {
			$rline = [ '!' . $line, { 'Deleted' => 1 } ];
		}
		my $assign_v2_to_v1 = create_cast_annlines( $var1_decl, $v1_v2_pair->[0], $var2_decl, $v1_v2_pair->[1] );
		my $assign_v1_to_v2 = create_cast_annlines( $var2_decl, $v2_v1_pair->[0], $var1_decl, $v2_v1_pair->[1] );
		# add an annotation to the first line
		$assign_v2_to_v1->[0][1]{'Ann'}=[$ann];
		$assign_v1_to_v2->[0][1]{'Ann'}=[$ann];
		
		if ( not exists $postUpdateAssignmentLines->{$var1} ) {
			$postUpdateAssignmentLines->{$var1} = $assign_v1_to_v2;    #[$indent . "$v2 = $v1",{}];
		} else {
			$postUpdateAssignmentLines->{$var1} = [ @{ $postUpdateAssignmentLines->{$var1} }, @{$assign_v1_to_v2} ];
		}

		if ( not exists $postUpdateAssignmentLines->{$var2} ) {
			$postUpdateAssignmentLines->{$var2} = $assign_v2_to_v1;    #[$indent . "$v1 = $v2",{}];
		} else {
			$postUpdateAssignmentLines->{$var2} = [ @{ $postUpdateAssignmentLines->{$var2} }, @{$assign_v2_to_v1} ];
		}
		if ( not( exists $Sf->{'ExGlobArgs'}{'Set'}{$var1} and exists $Sf->{'ExGlobArgs'}{'Set'}{$var2} ) ) {

			# if both are ExGlobArgs, we don't need the initial assignment
			$exEquivAssignmentLines = [ @{$exEquivAssignmentLines}, @{$assign_v1_to_v2} ];    #
		}
	}

	return ( $rline, $exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs, $replaced );
}    # END of __refactor_EQUIVALENCE_line

sub _emit_refactored_signatures {
	my ( $stref, $f, $annlines ) = @_;

	#    my $Sf = $stref->{'Subroutines'}{$f};

	my $rlines = [];
	my $has_return_type = 0;
	my $fname='';
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'Signature'} ) {
			@{$annline} = emit_subroutine_sig($annline);			
			( my $line, my $info ) = @{$annline};
			if (exists $info->{'Signature'}{'ReturnType'}) {
				$has_return_type=1;
				$fname=$info->{'Signature'}{'Name'};
			}
			#            say Dumper($annline);
		}
		if ( $has_return_type 
		and exists $info->{'VarDecl'} 
		and $info->{'VarDecl'}{'Name'} eq $fname
		) {
			$info->{'Deleted'}=1;
			$info->{'Skip'}=1;
			$annline = [ $line, $info ];
		}


		push @{$rlines}, $annline;
	}
	return $rlines;
}    # END of _emit_refactored_signatures

# This only works for 1-D array. It's already bad enough though.
sub __equate_overlapping_ranges {
	my ( $index1, $dim1, $index2, $dim2 ) = @_;
	my $offset1    = $dim1->[0][0];
	my $end_index1 = $dim1->[0][1];
	my $offset2    = $dim2->[0][0];
	my $end_index2 = $dim2->[0][1];
	my $array1 = [$index1];
	my $array2 = [$index2];

	# range is defined as size-1
	if ( $index1 - $offset1 < $index2 - $offset2 ) {

		# offset it with the starting index,
		my $trange1 = $index1 - $offset1;

		# and subtract this from the larger of the two
		my $start_index2 = ( $index2 - $offset2 + 1 ) - $trange1;

		# this is the start index for that array
		# then check if the end index of that array
		# if it is smaller than the end index of the other array,
		if ( $end_index2 - $start_index2 < $end_index1 - $offset1 ) {
			my $range2 = $end_index2 - $start_index2;
			$array2 = [ $start_index2, $end_index2 ];
			$array1 = [ $offset1,      $offset1 + $range2 ];
		} else {
			my $range1 = $end_index1 - $offset1;
			$array1 = [ $offset1,      $end_index1 ];
			$array2 = [ $start_index2, $start_index2 + $range1 ];
		}
	} else { #reverse the whole thing
		my $trange2      = $index2 - $offset2;
		my $start_index1 = ( $index1 - $offset1 + 1 ) - $trange2;
		if ( $end_index1 - $start_index1 < $end_index2 - $offset2 ) {
			my $range1 = $end_index1 - $start_index1;
			$array1 = [ $start_index1, $end_index1 ];
			$array2 = [ $offset2,      $offset2 + $range1 ];
		} else {
			my $range2 = $end_index2 - $offset2;
			$array2 = [ $offset2,      $end_index2 ];
			$array1 = [ $start_index1, $start_index1 + $range2 ];
		}
	}
	return [ $array1, $array2 ];
}    # END of __equate_overlapping_ranges

# TODO: Clearly this is Refactoring and should be put in Refactoring/StatementFunctions.pm 
sub _move_StatementFunctions_after_SpecificationStatements { my ( $stref, $f, $annlines ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	$Sf->{'RefactoredCode'}=$annlines;
# first cut out the StatementFunction lines
	my $pass_cut_out_StatementFunction_lines= sub {
		(my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		#  say "LINE:$line ".Dumper(sort keys %{$info});
		my $new_annlines = [$annline];
		if (exists $info->{'StatementFunction'}) {	
			
					$new_annlines =[ 
					["! Removed statement function ".$info->{'StatementFunction'},{'Comments' => 1}],					
					]; 
					push @{$state},$annline;
		}		
		
		return ($new_annlines,$state);
	};
	
	my $statement_function_annlines = [['! Moved statement functions',{'Comments' => 1}]];
 	($stref,$statement_function_annlines) = stateful_pass($stref,$f,$pass_cut_out_StatementFunction_lines, $statement_function_annlines,'_cut_out_StatementFunctions §' . __LINE__  ) ;	
	#  carp Dumper(pp_annlines($statement_function_annlines));
	 if (scalar @{ $statement_function_annlines } > 1) {
	my $merged_annlines = splice_additional_lines_cond(
		$stref, $f,
		sub {
			( my $annline ) = @_;
			(my $line,my $info)=@{$annline};
			return (
				exists $info->{'HasVars'}
			or exists $info->{'Control'}			
			or exists $info->{'EndControl'}
			) ? 1 : 0;
		},
		[],
		$statement_function_annlines,
		1, # insert before
		0, # skip insertion condition line
		1 # do this only once
	);
	# croak Dumper(pp_annlines($merged_annlines));
	return $merged_annlines;
	 } else {
	return $Sf->{'RefactoredCode'};
	 }
	
}

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
					my $par_decl_line = [ '      ' . emit_f95_var_decl($par_decl), { 'ParamDecl' => $par_decl, 'Ref' => 1, 
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


# We take the parameter declaration lines out of the annlines, and then re-insert them before the first variable declaration 
sub _group_local_param_decls_at_top { my ( $stref, $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $pass_split_out_ParamDecls = sub {
		(my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		#  say "LINE:$line ".Dumper(sort keys %{$info});
		my $new_annlines = [$annline];
		if (exists $info->{'ParamDecl'}) {	
			
					$new_annlines =[ 
					["! Moved param decl for  ".
					(ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY' ? 
					$info->{'ParamDecl'}{'Name'} [0] :
					$info->{'ParamDecl'}{'Name'}
					). ' in '.$f.' to top of code unit'					
					,{'Comments' => 1}],					
					];
					$info->{'Ann'}       = [ annotate( $f, __LINE__ . ' :  _group_local_param_decls_at_top'  ) ];
					push @{$state},[ $line , $info];
		}		
		
		return ($new_annlines,$state);
	};
	my $param_decl_annlines = [['! Grouped Parameter Declarations',{'Comments' => 1}]];
 	($stref,$param_decl_annlines) = stateful_pass($stref,$f,$pass_split_out_ParamDecls, $param_decl_annlines,'_split_out_ParamDecls ' . __LINE__  ) ;	

	 if (scalar @{ $param_decl_annlines } > 1) {
		my $merged_annlines = splice_additional_lines_cond(
			$stref, $f,
			sub {
				( my $annline ) = @_;
				(my $line,my $info)=@{$annline};
				return (
					exists $info->{'VarDecl'}
				) ? 1 : 0;
			},
			[],
			$param_decl_annlines,
			1, # insert before
			0, # skip insertion condition line
			1 # do this only once
		);
		# say "SUBROUTINE $f";
		# say Dumper(pp_annlines($merged_annlines));
		return $merged_annlines;
	 } else {
		return $Sf->{'RefactoredCode'};
	 }
}

# returns  $cast_reshape_result, 
# 	my $cast_reshape_result={
# 		'CallArg' => $call_arg,
# 		'PreAnnLine' => [],
# 		'PostAnnLine' => [],
# 		'CastReshapeVarDecl' => {},
# 		'Status' => 0
# 	};
# where Status =
# 0: no need to cast, $cast_code is $call_arg and can be ignored
# 1: in-place cast, $cast_code is the cast version of $call_arg
# 2: heavyweight cast: needs a new var decl, an pre-assignment line and a post-assignment line

=pod
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

sub _maybe_cast_call_args { my ($stref, $f, $sub_name, $call_arg,$call_arg_decl,$sig_arg, $sig_arg_decl)=@_;
#  carp "CALL ARG $call_arg for call to $sub_name in $f : ".Dumper($call_arg_decl);
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
		# Avoid overwriting the actual Dim field
		my $dim2d = dclone($dim2);
		if (__is_assumed_array($dim2)) {
			$dim2d = __take_upper_bound_from_call_arg($dim1,$dim2);
		}
		# carp "$f ".Dumper($dim1)."\n$sub_name".Dumper($dim2d);
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

		# if the same rank and different size
		if ( $size1 == $size2 and $rank1 != $rank2 ) {
			$needs_reshape=1;			
		} elsif ( $size1 != $size2 and $rank1 == $rank2 ) {
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

	my $sig_kind=4;
	if (exists $sig_arg_decl->{'Attr'} and $sig_arg_decl->{'Attr'} ne '') {
		$sig_kind=$sig_arg_decl->{'Attr'};
		$sig_kind=~s/\w+=//;
		$sig_kind=~s/[\(\)]//g;
	}
	my $call_kind=4;
	if (exists $call_arg_decl->{'Attr'} and $call_arg_decl->{'Attr'} ne '') {
		$call_kind=$call_arg_decl->{'Attr'};
		$call_kind=~s/\w+=//;
		$call_kind=~s/[\(\)]//g;
	}
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

	my $is_out = 0;
	if ($sig_arg_decl->{'IODir'} ne 'In'
		# or $sig_arg_decl->{'IODir'} eq 'InOut'
	) { 
		$is_out = 1;
	}

	my $new_call_arg=undef;

	if ($needs_reshape or ($needs_cast and $is_out)) {
		# carp "$f, $sub_name, $call_arg,$sig_arg, needs_reshape" if $needs_reshape;
		$new_call_arg = $call_arg.'_'.$sub_name;
		my $new_call_arg_decl = dclone($sig_arg_decl);
		$new_call_arg_decl->{'Name'}=$new_call_arg;
		if ($use_arg_sz) {
			$new_call_arg_decl->{'Dim'}=$call_arg_decl->{'Dim'};
		}

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
		my $cast_reshape_pre_line = "$new_call_arg = $reshaped_call_arg";
		my $reshaped_new_call_arg = "reshape($new_call_arg, shape($call_arg))";		
		my $cast_reshape_post_line = "$call_arg = $reshaped_new_call_arg";

		if ($needs_cast) {
			# cast
			my $cast_reshaped_call_arg = cast_call_argument($sig_arg_decl->{'Type'}, $sig_kind , $call_arg_decl->{'Type'}, $reshaped_call_arg);
			$cast_reshape_pre_line = "$new_call_arg = $cast_reshaped_call_arg";
			my $reshaped_new_call_arg = "reshape($new_call_arg, shape($call_arg)";
			my $cast_reshaped_new_call_arg = cast_call_argument($call_arg_decl->{'Type'}, $call_kind , $sig_arg_decl->{'Type'}, $reshaped_new_call_arg);
			$cast_reshape_post_line = "$call_arg = $cast_reshaped_new_call_arg";
		} 
		$cast_reshape_result->{'PreAnnLine'}[0]=$cast_reshape_pre_line;
		$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'VarName'}=$new_call_arg;
		$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'ExpressionAST'}=[2,$new_call_arg];
		$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'IndexVars'}{'List'}=[];
		$cast_reshape_result->{'PreAnnLine'}[1]{'Rhs'}{'VarList'}{'List'}=[$new_call_arg,$call_arg];
		$cast_reshape_result->{'PostAnnLine'}[0]=$cast_reshape_post_line;	
		$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'VarName'}=$call_arg;
		$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'ExpressionAST'}=[2,$call_arg];
		$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'IndexVars'}{'List'}=[];
		$cast_reshape_result->{'PostAnnLine'}[1]{'Rhs'}{'VarList'}{'List'}=[$new_call_arg,$call_arg];
		# warn 	"<$cast_reshape_pre_line>\n<$cast_reshape_post_line>\n";
	} else { # no reshape
		if ($needs_cast) {
			if ($is_out) { # not in place		
			
					my $cast_call_arg = cast_call_argument($sig_arg_decl->{'Type'}, $sig_kind , $call_arg_decl->{'Type'}, $call_arg);		
					my $cast_reshape_pre_line =  "$new_call_arg = $cast_call_arg" ;

					my $cast_new_call_arg = cast_call_argument($call_arg_decl->{'Type'}, $call_kind , $sig_arg_decl->{'Type'}, $new_call_arg);
					my $cast_reshape_post_line =   "$call_arg = $cast_new_call_arg" ;
					# $cast_reshape_result->{'PreAnnLine'}[0]=$cast_reshape_pre_line;
					# $cast_reshape_result->{'PostAnnLine'}[0]=$cast_reshape_post_line;	

					$cast_reshape_result->{'PreAnnLine'}[0]=$cast_reshape_pre_line;
					$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'VarName'}=$new_call_arg;
					$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'ExpressionAST'}=[2,$new_call_arg];
					$cast_reshape_result->{'PreAnnLine'}[1]{'Lhs'}{'IndexVars'}{'List'}=[];
					$cast_reshape_result->{'PreAnnLine'}[1]{'Rhs'}{'VarList'}{'List'}=[$new_call_arg,$call_arg];
					$cast_reshape_result->{'PostAnnLine'}[0]=$cast_reshape_post_line;	
					$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'VarName'}=$call_arg;
					$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'ExpressionAST'}=[2,$call_arg];
					$cast_reshape_result->{'PostAnnLine'}[1]{'Lhs'}{'IndexVars'}{'List'}=[];
					$cast_reshape_result->{'PostAnnLine'}[1]{'Rhs'}{'VarList'}{'List'}=[$new_call_arg,$call_arg];

			} else { # in place
					my $cast_call_arg = cast_call_argument($sig_arg_decl->{'Type'}, $sig_kind , $call_arg_decl->{'Type'}, $call_arg);
					$cast_reshape_result->{'CallArg'}=$cast_call_arg;
			}	
		}
		#  else {
		# 	# no action
		# }
	}

	return $cast_reshape_result;
}

# Dim :: [(Int,IntOrStar)]
# IntOrStar = Int | '*'
sub __is_assumed_array { my ($dims) = @_;
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
			my $dim2_comp= $dim2->[$idx];
			my $upper_bound2=$dim2_comp->[1];
			if ($upper_bound2 eq '*') {
				my $lower_bound1=$dim1_comp->[0];
				my $upper_bound1=$dim1_comp->[1];
				# If we had [1,3] and [-1, *] => -1 -1 = -2; 3+ -2 = 1
				# If we had [-1,3] and [1, *] => 1 - -1 = 2; 3+ 2 = 5
				my $lower_bound2=$dim1_comp->[0];
				my $offset = $lower_bound2 - $lower_bound1;
				$upper_bound2=$dim1_comp->[1] + $offset;
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
1;
