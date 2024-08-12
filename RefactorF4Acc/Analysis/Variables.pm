package RefactorF4Acc::Analysis::Variables;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::F95SpecWords qw( %F95_reserved_words %F95_intrinsics );
use RefactorF4Acc::Refactoring::Helpers qw( get_f95_var_decl stateful_pass_inplace stateless_pass_inplace );
use RefactorF4Acc::Utils::Functional qw( ordered_union ordered_difference );
use RefactorF4Acc::Parser::Expressions qw(
    get_vars_from_expression
);
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
use Cwd;
use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  &analyse_variables
  &analyse_used_variables
  &identify_vars_on_line
  &get_vars_pars_from_containers_and_modules
  &populate_UsesTransitively
);

# -----------------------------------------------------------------------------
#2.4 Find all variables in a subroutine and categorise them:
#- IF NOT IN Args:
#	- IF NOT DeclaredVars
#		IF IN Commons for any Incl OR in LOCAL Commons => ExGlobArgs
#		ELSE
#			IF in Vars for any Incl => ExInclLocalVars, LocalVars
#				ELSE => UndeclaredOrigLocalVars, LocalVars
# Then merge the Args and ExGlobArgs

# WV 2023-12-13 This needs to handle variables from modules and containers as well.
# I think I will create analyse_used_variables for this.
# WV 2024-01-12 VardDecl and Signature is not included, I assume because these should have been handled already
sub analyse_variables {
	( my $stref, my $f, my $annline ) = @_;

	my $Sf = $stref->{'Subroutines'}{$f};

	# local $DBG=1;
	# local $V=1;
	# local $I=1;
	say "analyse_variables($f)" if $DBG;

	my $__analyse_vars_on_line = sub {
		( my $annline, my $state ) = @_;
		( my $line,    my $info )  = @{$annline};
# TODO: use the grouped labels Control, IO etc
		if (   exists $info->{'Assignment'}
			or exists $info->{'StatementFunction'}
			or exists $info->{'SubroutineCall'}
			or exists $info->{'If'} # Control
			or exists $info->{'ElseIf'} # Control
			or exists $info->{'Do'} # Control
			or exists $info->{'Return'}# Control
			or exists $info->{'WriteCall'}# IO
			or exists $info->{'PrintCall'}# IO
			or exists $info->{'ReadCall'}# IO
			or exists $info->{'InquireCall'}# IO
			or exists $info->{'OpenCall'}# IO
			or exists $info->{'CloseCall'}# IO
			or exists $info->{'RewindCall'}# IO
			or exists $info->{'ParamDecl'}
			or exists $info->{'Equivalence'}
			or (exists $info->{'Data'} and ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ))
			) {
			( my $stref, my $f, my $identified_vars, my $grouped_messages ) = @{$state};

			my $Sf     = $stref->{'Subroutines'}{$f};
		    my $chunks_ref = identify_vars_on_line($annline,$f);
			my @chunks = @{ $chunks_ref };

			# -------------------------------------------------------------------------------------------------------------------

			for my $mvar (@chunks) {
				# croak "<$mvar>".Dumper(@chunks).Dumper($annline) if $mvar eq 'kind';
                next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar};    # Means it's a function
				next if $mvar =~ /^\d+(?:_[1248])?$/;
				next if not defined $mvar or $mvar eq '';
				# Means arg was declared
				my $in_vars_subset = in_nested_set( $Sf, 'Vars', $mvar );
				my $decl_orig_arg = exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$mvar} ? 1 : 0;
				# Means arg has been declared via Implicits
				my $undecl_orig_arg = exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$mvar} ? 1 : 0;
				# Means var was declared
				my $decl_orig_local_var = exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$mvar} ? 1 : 0;
				# Means var has been declared via Implicits
				my $undecl_orig_local_var = exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$mvar} ? 1 : 0;
				my $decl_common_var       = exists $Sf->{'DeclaredCommonVars'}{'Set'}{$mvar}      ? 1 : 0;
				my $undecl_common_var     = exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$mvar}    ? 1 : 0;

				# Here it is still possible that the variables don't have any declarations
				# If that is the case for OrigArgs we must type them via Implicits
				# But should this not have happened already? No, because UndeclaredOrigArgs could be declared via Includes,
				# and that is checked here.
				# So I think we exclude the DeclaredOrigArgs only
				# The same is true I think for UndeclaredOrigLocalVars: we must type them via implicits

				# So is it actually not simply a case of saying,
				# if it's in not Vars OR
				# it is in Vars  but the decl is 1 ?
				if (
					not exists $identified_vars->{$mvar} # mvar not yet identified
					and (
						not $in_vars_subset
						or ( $in_vars_subset and ref($Sf->{$in_vars_subset}{'Set'}{$mvar}) ne 'HASH' )
						)
				  ) {
					my $in_incl = 0;
					if ( not exists $Sf->{'Commons'}{$mvar} ) {
						for my $inc ( sort keys %{ $Sf->{'Includes'} } ) {
							say "LOOKING FOR $mvar from $f in $inc" if $DBG;
							# A variable can be declared in an include file or not and can be listed as common or not
							if ( in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar )
								or exists $stref->{'IncludeFiles'}{$inc}{'Commons'}{$mvar} )
							{
								$in_incl = 1;

								if (not exists $stref->{'IncludeFiles'}{$inc}{'ExtPath'} ) {
									if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {

										$grouped_messages->{'W'}{'PARAM_FROM_INC'}{$mvar} =
										"WARNING: $mvar in $f is a PARAMETER from $inc!" if $WARNING_LEVEL==4;

										$Sf->{'Includes'}{$inc}{'Only'}{$mvar} = 1;
									} else {
										if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common' ) {
											say "FOUND COMMON $mvar in INC $inc in $line" if $DBG;
#											croak "COMMON $mvar for $f" . in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar ) if $mvar eq 'kp';
											my $decl;
											my $subset_for_mvar = in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar );
											say "Found $mvar in $subset_for_mvar "
											  if $DBG;
											if ( $subset_for_mvar ne '' ) {
												my $var_rec = get_var_record_from_set( $stref->{'IncludeFiles'}{$inc}{'Vars'}, $mvar );
												if ( not defined $var_rec ) {
													# This means this var decl in the include has not been declared
													say "No Decl for $mvar in $inc $subset_for_mvar";
													# So we should type this one via Implicits
													$decl = get_f95_var_decl( $stref, $f, $mvar );
												} else {
													$decl = $var_rec;
												}
											} else {
												croak "No Subset for $mvar in $inc $subset_for_mvar" if $DBG;
											}

											if ( exists $stref->{'IncludeFiles'}{$inc}{'Commons'}{$mvar} ) {
												say "FOUND argdecl for $mvar via common block in $inc" if $DBG;
												push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'} }, $mvar;
												$decl->{'Inc'}                                          = $inc;    #WV20160406 this is a bit late .
												$stref->{'Subroutines'}{$f}{'CommonIncs'}{$inc}         = $inc;
												$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$mvar} = $decl;
												$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar}  = 1;
											} elsif ( in_nested_set($stref->{'Subroutines'}{$f},'CommonVars',$mvar) ) {
												say "FOUND argdecl for $mvar via common block in $f" if $DBG;
												push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'} }, $mvar;
												$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$mvar} = $decl;
												$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar}  = 1;
											} else {
												say "INFO: LOCAL VAR FROM $inc, NOT COMMON! " . 'analyse_variables() ' . __LINE__ if $I;
												push @{ $stref->{'Subroutines'}{$f}{'ExInclLocalVars'}{'List'} }, $mvar;
												$stref->{'Subroutines'}{$f}{'ExInclLocalVars'}{'Set'}{$mvar} = $decl;
												croak "INFO: LOCAL VAR FROM $inc, NOT COMMON! " if $DBG and $mvar eq 'len';
											}
											$identified_vars->{$mvar} = 1;
											last;
										} else {
											croak $mvar ,' : ' ,$inc,' ',$stref->{'IncludeFiles'}{$inc}{'InclType'} if $DBG;
										}
									}
								} else {
									say "INFO: $inc is EXTERNAL, not creating a declaration for $mvar in $f" if $I;
								}
							}
						}
						for my $inc (  keys %{ $Sf->{'Uses'} } ) {
							say "LOOKING FOR $mvar from $f in $inc" if $DBG;
							# A variable can be declared in an include file or not and can be listed as common or not
							if ( in_nested_set( $stref->{'Modules'}{$inc}, 'Vars', $mvar )
								or exists $stref->{'Modules'}{$inc}{'Commons'}{$mvar} )
							{
								$in_incl = 1;

								if (not exists $stref->{'Modules'}{$inc}{'ExtPath'} ) {
									my $var_rec = get_var_record_from_set( $stref->{'Modules'}{$inc}{'Vars'}, $mvar );
									if (exists $var_rec->{'Parameter'} ) {
										$grouped_messages->{'W'}{'PARAM_FROM_INC'}{$mvar} =  "WARNING: $mvar in $f is a PARAMETER from $inc!" if $WW;
									} else {
											print "FOUND COMMON $mvar in INC $inc in $line\n" if $DBG;
											my $decl;
											my $subset_for_mvar = in_nested_set( $stref->{'Modules'}{$inc}, 'Vars', $mvar );
											say "Found $mvar in $subset_for_mvar " if $DBG;
											if ( $subset_for_mvar ne '' ) {
												my $var_rec = get_var_record_from_set( $stref->{'Modules'}{$inc}{'Vars'}, $mvar );
												if ( not defined $var_rec ) {
													# This means this var decl in the include has not been declared
													say "No Decl for $mvar in $inc $subset_for_mvar";
													# So we should type this one via Implicits
													$decl = get_f95_var_decl( $stref, $f, $mvar );
												} else {
													$decl = $var_rec;
												}
											} else {
												croak "No Subset for $mvar in $inc $subset_for_mvar" if $DBG;
											}
												say "FOUND argdecl for $mvar via common block in $inc" if $DBG;
												push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'} }, $mvar;
												$decl->{'Inc'}                                          = $inc;    #WV20160406 this is a bit late .
												$stref->{'Subroutines'}{$f}{'CommonIncs'}{$inc}         = $inc;
												$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$mvar} = $decl;
												$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar}  = 1;

											$identified_vars->{$mvar} = 1;
											last;

									}
								} else {
									say "INFO: $inc is EXTERNAL, not creating a declaration for $mvar in $f" if $I;
								}
							}
						}
					} else {
#						say "$f COMMON VAR $mvar";
					}

					if ( not $in_incl ) {
						# Now check if this variable might be accessed via the containing program or module
						$identified_vars->{$mvar} = 0;
						if ( exists $stref->{'Subroutines'}{$f}{'Container'} ) {

							my $container = $stref->{'Subroutines'}{$f}{'Container'};
							my $is_module = exists $stref->{'Modules'}{$container} ? 1 : 0;
							my $srctype = $is_module  ? 'Modules' : 'Subroutines';

							my $subset = in_nested_set( $stref->{$srctype}{$container}, 'Vars', $mvar );
							if ( $subset ne '' ) { say "FOUND VAR $mvar in $subset in CONTAINER $container ($srctype) " if $DBG;

#								say "$f VAR5 $mvar";
								# If so, this is treated as an ExGlob
								# WV20170607 Should I also set the decl in DeclaredCommonVars?

								my $decl = $stref->{$srctype}{$container}{$subset}{'Set'}{$mvar};
								if (not exists $decl->{'Parameter'} ) {
									$decl->{'Container'}                                    = $container;
									$decl->{'Indent'}                                       = '      ';     # ad hoc!
									$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$mvar} = $decl;
									push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'} }, $mvar;
								} else {
									say "INFO: VAR $mvar in $f from container $container is PARAMETER" if $I ;
								}
								$identified_vars->{$mvar}                               = 1;
							}
						}

						if ( $identified_vars->{$mvar} != 1 ) {
							if ( $mvar !~ /\*/ and $line =~ /$mvar\s*\(/ ) {                            # Very ugly HACK because somehow ** got into the var name!
								say "INFO: LOCAL VAR <$mvar> in $f may be an EXTERNAL FUNCTION " if $I;
							}
							say "INFO: LOCAL VAR <$mvar> in $f undeclared, typed via IMPLICIT! " . $line if ($I or $DBG);
							say ' analyse_variables() ' . __LINE__ if $I;
							my $decl = get_f95_var_decl( $stref, $f, $mvar );

							if ( not $undecl_orig_arg ) {
								# carp "$f: $line => $mvar ".Dumper($decl) if $mvar eq 'ff309' ;
								push @{ $stref->{'Subroutines'}{$f}{'UndeclaredOrigLocalVars'}{'List'} }, $mvar;
								$stref->{'Subroutines'}{$f}{'UndeclaredOrigLocalVars'}{'Set'}{$mvar} = $decl;
							} else {
								push @{ $stref->{'Subroutines'}{$f}{'UndeclaredOrigArgs'}{'List'} }, $mvar;
								$stref->{'Subroutines'}{$f}{'UndeclaredOrigArgs'}{'Set'}{$mvar} = $decl;
							}
							$identified_vars->{$mvar} = 1;
						}
					}
				} else {
					say "INFO: $f : $mvar ALREADY DECLARED in $in_vars_subset" if $I ;
#say "analyse_variables($f) " . __LINE__ . " : $mvar ALREADY DECLARED in $in_vars_subset:\n" . Dumper( $Sf->{$in_vars_subset}{'Set'}{$mvar} ) if $DBG;
					for my $inc ( keys %{ $Sf->{'Includes'} } ) {
							say "LOOKING FOR $mvar from $f in $inc" if $DBG;
							# A variable can be declared in an include file or not and can be listed as common or not
							if ( in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar )) {
								if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
									$grouped_messages->{'W'}{'PARAM_FROM_INC'}{$mvar} =  "WARNING: $mvar in $f is a PARAMETER from $inc!" if $WARNING_LEVEL==4;
									 $Sf->{'Includes'}{$inc}{'Only'}{$mvar} =1;

								}
							}
					}
				}
			}
			return ( [$annline], [ $stref, $f, $identified_vars, $grouped_messages ] );
		}
		else {
			return ( [$annline], $state );
		}
	};

	my $state = [ $stref, $f, {}, {} ];
	if (not defined $annline) {
		( $stref, $state ) = stateful_pass_inplace( $stref, $f, $__analyse_vars_on_line, $state, 'analyse_variables() ' . __LINE__ );
	} else {
			 ( my $list_w_annline, $state ) = $__analyse_vars_on_line->($annline, $state );
	}
	my $grouped_messages = $state->[3];
	if ($W) {
		for my $warning_type (sort keys % {$grouped_messages->{'W'}} ) {
			for my $k (sort keys %{$grouped_messages->{'W'}{$warning_type}}) {
				my $line = $grouped_messages->{'W'}{$warning_type}{$k};
				say $line;
			}
		}
    }

    if ($I) {
    for my $info_type (sort keys % {$grouped_messages->{'I'}} ) {
        for my $k (sort keys %{$grouped_messages->{'I'}{$info_type}}) {
            my $line = $grouped_messages->{'I'}{$info_type}{$k};
            say $line
        }
    }
    }

	my $maybe_ex_globs = $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'};
	if ( defined $maybe_ex_globs  and scalar @{ $maybe_ex_globs } > 0 ) {
		$Sf->{'HasCommons'} = 1;
	}

	# Now at this point any variable that was not yet declared will be declared via Implicits.
	# This is a catch-all for lines that are not properly analysed!
	# The possible cases are
	# UndeclaredOrigArgs
	# UndeclaredCommonVars
	# UndeclaredOrigLocalVars
	# Or we could of course just wait and catch them at the point of use. But that is not so neat
	for my $subset (qw(	UndeclaredOrigArgs UndeclaredCommonVars UndeclaredOrigLocalVars )) {
		for my $var ( sort keys %{ $Sf->{$subset}{'Set'} } ) {
			if ( ref($Sf->{$subset}{'Set'}{$var}) ne 'HASH' ) {
				say "WARNING: VAR $var from $subset in $f not yet declared, this means the variable was not detected properly!" if $DBG;
				my $decl = get_f95_var_decl( $stref, $f, $var );
				$Sf->{$subset}{'Set'}{$var} = $decl;
			}
		}
	}

	# Here test function return type
	if (exists $Sf->{'Signature'}{'Function'} and $Sf->{'Signature'}{'Function'}==1) {
		if (not exists $Sf->{'Signature'}{'ReturnType'} ) { # The function does not have an explicit return type
		  my $retvar=$f;
		  if (exists $Sf->{'Signature'}{'ResultVar'} ) { # The function uses RESULT
			 $retvar=$Sf->{'Signature'}{'ResultVar'};
		  }
	       my $subset = in_nested_set($Sf,'Vars',$retvar);
		   
           if ($subset) { # The function variable is declared somewhere in the function. Use this for the return type. If this is the function name we should probably delete it, but I do this later during refactoring
                my $decl =  $Sf->{$subset}{'Set'}{$retvar} ;
                $Sf->{'Signature'}{'ReturnType'}=$decl->{'Type'};
                $Sf->{'Signature'}{'ReturnTypeAttr'}=$decl->{'Attr'};
            } else {
				
                # The function does not contain a declaration for $retvar. Use implicits to type it
                my ($type, $array_or_scalar, $attr) =type_via_implicits( $stref,  $f, $retvar);
                $Sf->{'Signature'}{'ReturnType'}=$type;
                $Sf->{'Signature'}{'ReturnTypeAttr'}=$attr;
            }
		}
	}
	return $stref;
}    # END of analyse_variables()

# The purpose of this routine is to reduce VarsFromContainer and ParametersFromContainer to only those vars that are actually in the code unit
sub analyse_used_variables {
	( my $stref, my $f) = @_;

	my $Sf = $stref->{'Subroutines'}{$f};

	# local $DBG=1;
	# local $V=1;
	# local $I=1;
	say "analyse_used_variables($f)" if $DBG;

	my $__analyse_vars_on_line = sub {
		( my $annline, my $state ) = @_;
		( my $line,    my $info )  = @{$annline};

# TODO: use the grouped labels Control, IO etc
		if (   exists $info->{'Assignment'}
			or exists $info->{'StatementFunction'}
			or exists $info->{'SubroutineCall'}
			or exists $info->{'If'} # Control
			or exists $info->{'ElseIf'} # Control
			or exists $info->{'Select'} # Control
			or exists $info->{'Case'} # Control
			or exists $info->{'Do'} # Control
			or exists $info->{'Return'}# Control
			or exists $info->{'WriteCall'}# IO
			or exists $info->{'PrintCall'}# IO
			or exists $info->{'ReadCall'}# IO
			or exists $info->{'InquireCall'}# IO
			or exists $info->{'OpenCall'}# IO
			or exists $info->{'CloseCall'}# IO
			or exists $info->{'RewindCall'}# IO
			or exists $info->{'ParamDecl'}
			or exists $info->{'VarDecl'}
			or exists $info->{'Signature'}
			or exists $info->{'Equivalence'}
			or (exists $info->{'Data'} and ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ))
			) {
			( my $stref, my $f, my $identified_vars ) = @{$state};
			my $Sf     = $stref->{'Subroutines'}{$f};
		    my $chunks_ref = identify_vars_on_line($annline,$f);

			my @chunks = @{ $chunks_ref };


			# -------------------------------------------------------------------------------------------------------------------

			for my $mvar (@chunks) {
				croak $f.' '.Dumper($mvar) if ref($mvar) eq 'ARRAY' or $mvar=~/ARRAY/;

                next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar};    # Means it's a function
				next if $mvar =~ /^\d+(?:_[1248])?$/;
				next if not defined $mvar or $mvar eq '';

				if (
					not exists $identified_vars->{$mvar} # mvar not yet identified
				  ) {
					$identified_vars->{$mvar}=1;
				}
			}
			return ( [$annline], [ $stref, $f, $identified_vars ] );
		}
		else {
			return ( [$annline], $state );
		}
	};

	my $state = [ $stref, $f, {} ];
	( $stref, $state ) = stateful_pass_inplace( $stref, $f, $__analyse_vars_on_line, $state, 'analyse_used_variables() ' . __LINE__ );

	my $vars_in_code_unit = $state->[2];
	$Sf->{'AllVarsAndPars'}{'Set'}=$vars_in_code_unit;
	# my $decl = get_var_record_from_set($Sf->{'Vars'},'funktalTokensIdx');
	#  if ($f eq 'clearFunktalTokens') {
	#  say $f.Dumper( $Sf);
	# croak;
	#  }
	$Sf->{'AllVarsAndPars'}{'List'}= [sort keys %{$vars_in_code_unit}];
	# So now we simply delete any var that is not in this set
	for my $used_var (@{$Sf->{'ModuleVars'}{'List'}}) {
		if (not exists $vars_in_code_unit->{$used_var}) {
			# say "$f: DELETE $used_var";
			delete $Sf->{'ModuleVars'}{'Set'}{$used_var};
		} 
		# else {
			# say "$f: KEEP $used_var";
		# }
	}
	$Sf->{'ModuleVars'}{'List'} = [sort keys %{$Sf->{'ModuleVars'}{'Set'}}];
	# WV 2023-12-23 this is too aggressive, but WHY?
	for my $used_var (@{$Sf->{'ModuleParameters'}{'List'}}) {
		if (not exists $vars_in_code_unit->{$used_var}) {
			# say "$f: DELETE PAR $used_var";	
			delete $Sf->{'ModuleParameters'}{'Set'}{$used_var};
		} 
		# else {
			# say "$f: KEEP PAR $used_var";
		# }
	}
	$Sf->{'ModuleParameters'}{'List'} = [sort keys %{$Sf->{'ModuleParameters'}{'Set'}}];
	return $stref;
}    # END of analyse_used_variables()

sub identify_vars_on_line {
	( my $annline, my $f ) = @_;
	( my $line,    my $info )  = @{$annline};

	if (   exists $info->{'Assignment'}
		or exists $info->{'StatementFunction'}
		or exists $info->{'SubroutineCall'}
		or exists $info->{'If'} # Control
		or exists $info->{'ElseIf'} # Control
		or exists $info->{'Select'} # Control
		or exists $info->{'Case'} # Control
		or exists $info->{'Do'} # Control
		or exists $info->{'Return'} # Control
		or exists $info->{'WriteCall'}# IO
		or exists $info->{'PrintCall'}# IO
		or exists $info->{'ReadCall'}# IO
		or exists $info->{'InquireCall'}# IO
		or exists $info->{'OpenCall'}# IO
		or exists $info->{'CloseCall'}# IO
		or exists $info->{'RewindCall'}# IO
		or exists $info->{'ParamDecl'}
		or exists $info->{'Data'}
		or exists $info->{'Equivalence'}
	) {

		my @chunks = ();
		if ( exists $info->{'If'} or exists $info->{'ElseIf'} ) {
			@chunks = @{ $info->{'Cond'}{'Vars'}{'List'} };
		}
		if ( exists  $info->{'Select'} ) {
			@chunks = ( $info->{'CaseVar'}[1] );
		}
		elsif ( exists $info->{'Case'} ) {
			my $caseval_ast =  $info->{'CaseVals'};
			my $vars_in_cond_expr =  get_vars_from_expression( $caseval_ast,{});
			@chunks = sort keys %{$vars_in_cond_expr};
		}
		if (   exists $info->{'PrintCall'}
			or exists $info->{'WriteCall'}
			or exists $info->{'ReadCall'}
			or exists $info->{'InquireCall'}
			or exists $info->{'RewindCall'}
			or exists $info->{'Return'}
			) {

			@chunks = ( @chunks, @{ $info->{'Vars'}{'Written'}{'List'} }, @{ $info->{'Vars'}{'Read'}{'List'} } );
			my %unique_index_vars = ();
			my @index_vars = ();
			for my $rw ('Written','Read') {
				for my $var (@{ $info->{'Vars'}{$rw}{'List'} }) {
					# say "LINE $line VAR $rw $var ".Dumper($info->{'Vars'}{$rw});
					if (exists $info->{'Vars'}{$rw}{'Set'}{$var}{'IndexVars'}) { 
						for my $index_var (sort keys %{ $info->{'Vars'}{$rw}{'Set'}{$var}{'IndexVars'} }) {
								if (not exists $unique_index_vars{$index_var}) {
									$unique_index_vars{$index_var}=1;
									push @index_vars,$index_var;
								}
						}
					}
				}
			}
			@chunks = ( @chunks, @index_vars ) unless scalar @index_vars==0;
			if (exists $info->{'CallAttrs'}) {
				@chunks = ( @chunks,@{$info->{'CallAttrs'}{'List'}} );
				for my $var ( @{$info->{'CallAttrs'}{'List'}} ) {
					if (exists $info->{'CallAttrs'}{'Set'}{$var} and exists  $info->{'CallAttrs'}{'Set'}{$var}{'IndexVars'}) {
						@chunks = ( @chunks, sort keys %{$info->{'CallAttrs'}{'Set'}{$var}{'IndexVars'}} );
					}
				}
			}
			if (exists $info->{'ImpliedDoVars'}) {
				@chunks = ( @chunks, @{ $info->{'ImpliedDoVars'}{'List'} } );
			}
			if (exists $info->{'ImpliedDoRangeVars'}) {
				@chunks = ( @chunks, @{ $info->{'ImpliedDoRangeVars'}{'List'} } );
			}

		} elsif ( exists $info->{'SubroutineCall'} ) {
			# croak Dumper $info if $info->{'SubroutineCall'}{'Name'} eq 'tokeniseFunktal';
			for my $var_expr ( @{ $info->{'SubroutineCall'}{'Args'}{'List'} } ) {
				# carp Dumper( $info->{'SubroutineCall'}{'Args'}{'Set'});
				if ( exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$var_expr}{'Arg'} ) {
					push @chunks, $info->{'SubroutineCall'}{'Args'}{'Set'}{$var_expr}{'Arg'};
					# carp Dumper($info->{'SubroutineCall'}{'Args'}{'Set'}{$var_expr});
				} elsif(
					exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$var_expr}{'Vars'}
				) {
					@chunks = (@chunks, sort keys %{$info->{'SubroutineCall'}{'Args'}{'Set'}{$var_expr}{'Vars'}});
				} elsif ($info->{'SubroutineCall'}{'Args'}{'Set'}{$var_expr}{'Type'} ne 'Const' ) {
					push @chunks, $var_expr;
				}
			}
			for my $expr_var ( @{ $info->{'ExprVars'}{'List'} } ) {
				push @chunks, $expr_var;
			}

		} elsif ( exists $info->{'OpenCall'} ) {
			if ( exists $info->{'Vars'} ) {
				@chunks = ( @chunks, @{ $info->{'Vars'}{'List'} } );
				# croak Dumper @chunks;
			}
		} elsif ( exists $info->{'Do'} ) {
			# if ($line=~/do.+int.+len/ ) {
				# say $line;
				# carp Dumper($info->{'Do'});
			# }
			@chunks = exists $info->{'Do'}{'Iterator'} ? ( @chunks, $info->{'Do'}{'Iterator'}, @{ $info->{'Do'}{'Range'}{'Vars'} } ) : ();
		} elsif ( (exists $info->{'Assignment'} and not exists $info->{'Data'}) or exists $info->{'StatementFunction'}) {
			@chunks = ( @chunks, $info->{'Lhs'}{'VarName'}, @{ $info->{'Lhs'}{'IndexVars'}{'List'} }, @{ $info->{'Rhs'}{'Vars'}{'List'} } );
		} elsif ( exists $info->{'ParamDecl'} ) {
			@chunks = ( @chunks, keys %{ $info->{'ModuleParameters'} } );
		} elsif ( exists $info->{'Data'}
		or exists $info->{'Equivalence'} ) {
			@chunks = ( @chunks, @{ $info->{'Vars'}{'List'} } );
		} elsif ( not exists $info->{'IfThen'} ) {
			# carp "HERE FOR IF ... GOTO $line" if $line=~/go\s*to/;
			# $line=~s/go\s+to/goto/; # WV: HACK, should normalise this much earlier!
			my @mchunks = split( /\W+/, $line );
			for my $mvar (@mchunks) {
				next if exists $F95_reserved_words{ $mvar };    # This should be, unless some idiot has assigned to a reserved word somewhere. We assume they only redefine intrinsic functions but who knows?
				# next if exists $F95_other_intrinsics{$mvar};
				next if exists $F95_intrinsics{$mvar};
#					next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar};    # Means it's a function
				next if $mvar =~ /^__PH\d+__$/;
				next if $mvar !~ /^[_a-z]\w*$/;
				# say "VAR: <$mvar>";
				push @chunks, $mvar;
			}
# croak $line if $line=~/iachar/;
		}
		return [@chunks];
	} else {
		return [];
	}
} # END of identify_vars_on_line

## Here we populate VarsFromContainers and ParametersFromContainers, where "Container" is an enclosing unit but NOT a module; for modules we put them in ModuleVars.
## Requires populate_UsesTransitively to be run first
sub get_vars_pars_from_containers_and_modules { my ($stref,$f) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );

	my $Sf = $stref->{$sub_or_func_or_mod}{$f};
	# There should be no needs for this, it's done in initialise_per_code_unit_tables()
	# $Sf->{'VarsFromContainer'}{'List'} = [];
	# $Sf->{'VarsFromContainer'}{'Set'} = {};
	# $Sf->{'ParametersFromContainer'}{'List'} = [];
	# $Sf->{'ParametersFromContainer'}{'Set'} = {};

	# For the case of Contained subroutines

	if (exists $Sf->{'Container'}) {
		my $container = $Sf->{'Container'};
		if (exists $stref->{'Subroutines'}{$container}) {

			my $local_pars = get_vars_from_set($stref->{'Subroutines'}{$container}{'LocalParameters'}); # Because Used and FromContainers should be captured through the rec descent
			my $included_pars = get_vars_from_set($stref->{'Subroutines'}{$container}{'IncludedParameters'});

			# if (exists $pars->{'funktalMaxNTokens'} and $f eq 'clearFunktalTokens') {croak "$module_name $f"}
			$Sf->{'ParametersFromContainer'}{'Set'} = {
				%{$Sf->{'ParametersFromContainer'}{'Set'} },
				%{$local_pars},
				%{$included_pars}
			};
			my $local_vars = get_vars_from_set($stref->{'Subroutines'}{$container}{'LocalVars'});
			# A var in a COMMON block can still be used without reference to the COMMON block in an enclosed code unit
			my $common_vars = get_vars_from_set($stref->{'Subroutines'}{$container}{'CommonVars'});
			$Sf->{'VarsFromContainer'}{'Set'} = {
				%{$Sf->{'VarsFromContainer'}{'Set'} },
				%{$local_vars},
				%{$common_vars}
			};
		}
	}
	$Sf->{'ParametersFromContainer'}{'List'}= [sort keys %{$Sf->{'ParametersFromContainer'}{'Set'}}];
	$Sf->{'VarsFromContainer'}{'List'}= [sort keys %{$Sf->{'VarsFromContainer'}{'Set'}}];

	my @used_modules = sort keys %{$Sf->{'UsesTransitively'}};

	for my $module_name (@used_modules) {
		my $pars = get_vars_from_set($stref->{'Modules'}{$module_name}{'LocalParameters'}); # Because Used and FromContainers should be captured through the rec descent
		$Sf->{'ModuleParameters'}{'Set'} = defined $Sf->{'ModuleParameters'}{'Set'} ?
		{ %{$Sf->{'ModuleParameters'}{'Set'} }, %{$pars} } : $pars;
		my $vars = get_vars_from_set($stref->{'Modules'}{$module_name}{'ModuleVars'}); 
		for my $var (sort keys %{$vars}) {
			if (not exists $vars->{$var}{'ParentModule'}) {
				$vars->{$var}{'ParentModule'}=$module_name;
			}
		}
		$Sf->{'ModuleVars'}{'Set'} = { %{$Sf->{'ModuleVars'}{'Set'} }, %{$vars} };
	}
	$Sf->{'ModuleParameters'}{'List'}= [sort keys %{$Sf->{'ModuleParameters'}{'Set'}}];
	$Sf->{'ModuleVars'}{'List'}= [sort keys %{$Sf->{'ModuleVars'}{'Set'}}];

	return $stref;
}  # END of get_vars_pars_from_containers_and_modules

sub populate_UsesTransitively { my ($stref,$f) = @_;
	my $sub_incl_or_mod = sub_func_incl_mod($f, $stref);
	my $Sf = $stref->{$sub_incl_or_mod}{$f};
	# say "populate_UsesTransitively($f)";
	$stref = _build_UsesTransitively_rec($stref,$f);

	if ($sub_incl_or_mod eq 'Subroutines') {
	# croak "populate_UsesTransitively($f)" if $f eq 'clearFunktalTokens';
		my @mods = ();
		if ( exists $Sf->{'InModule_Blocks'} ) {
			@mods = sort keys %{$Sf->{'InModule_Blocks'}};
		}
		elsif ( exists $Sf->{'InModule'} ) {
			my $mod = $Sf->{'InModule'};
			@mods = ($mod);
		}
		for my $module_name (@mods) {
			if ($stref->{'Modules'}{$module_name}{'Status'} >= $PARSED) {
				$stref = _build_UsesTransitively_rec($stref,$module_name);
				$Sf->{'UsesTransitively'} = { %{$Sf->{'UsesTransitively'}},%{$stref->{'Modules'}{$module_name}{'UsesTransitively'}} }
			} else {
				warning("Module $module_name was not parsed, probably unused?");
			}
		}
	}
	# croak "$sub_incl_or_mod $f: ".Dumper $Sf->{'UsesTransitively'} if $f eq 'clearFunktalTokens';
	return $stref;
} # END of populate_UsesTransitively

# So, we are in $f, and we have $name. What we want is the transitive closure, so assuming we have all the Uses, we should do
# We must do something similar for use via containers
sub _build_UsesTransitively_rec { my ($stref,$f) = @_;
    my $sub_incl_or_mod = sub_func_incl_mod($f, $stref);
    my $Sf = $stref->{$sub_incl_or_mod}{$f};
	if (not exists $stref->{$sub_incl_or_mod}{$f}{'Source'}) {
		my $sm = substr(lc($sub_incl_or_mod),0,-1);
		
		error( "No source for $sm $f",0,'ERROR404');
	} 
	elsif (not exists $Sf->{'UsesTransitively'}) {
		if (not -e $stref->{$sub_incl_or_mod}{$f}{'Source'}) {
			error( "No such module source: ".$stref->{$sub_incl_or_mod}{$f}{'Source'}." for $f",0,'ERROR404');
		} else {
			croak "No UsesTransitively for $sub_incl_or_mod $f:".Dumper( $Sf);
		}
	} 
	# say "$sub_incl_or_mod $f".$Sf->{'UsesTransitively'};
    if (exists $Sf->{'Uses'} and scalar keys %{$Sf->{'Uses'}}>0) {
        $Sf->{'UsesTransitively'} = {%{$Sf->{'UsesTransitively'}},%{$Sf->{'Uses'}}};
        for my $used_module (sort keys %{$Sf->{'Uses'}}) {
            $stref = _build_UsesTransitively_rec($stref,$used_module);
            $Sf->{'UsesTransitively'} = {%{$Sf->{'UsesTransitively'}},%{$stref->{'Modules'}{$used_module}{'UsesTransitively'}} };
        }
    } else {
        # This is a leaf node; but it can still be a sub in a module!
		if (exists $Sf->{'InModule'}) {
			$Sf->{'UsesTransitively'}{$Sf->{'InModule'}}=[];
		}
    }
    return $stref;

} # END of _build_UsesTransitively_rec
1;
