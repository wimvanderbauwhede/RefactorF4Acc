package RefactorF4Acc::Analysis;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Includes qw( find_root_for_includes );
use RefactorF4Acc::Analysis::Globals qw( identify_inherited_exglobs_to_rename lift_globals rename_inherited_exglobs );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_end_detect );
use RefactorF4Acc::Refactoring::Common qw( get_f95_var_decl stateful_pass stateless_pass );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

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

@RefactorF4Acc::Analysis::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::EXPORT = qw(
  &analyse_all
  &identify_vars_on_line
);

sub analyse_all {

	( my $stref, my $code_unit_name, my $stage ) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $code_unit_name, $stref );
	
		
	
	if (not defined $stage) {$stage=0}
	
	my $annlines =	_add_BLOCK_DATA_call_after_last_VarDecl($code_unit_name,$stref);
	
	if ($sub_or_func_or_mod eq 'Subroutines') {
		# Find the 'root', i.e. the outermost calling subroutine, for each include file
		print "\t** FIND ROOT FOR INCLUDES **\n" if $V;
		$stref = find_root_for_includes( $stref, $code_unit_name );
	}
	return $stref if $stage == 1;

	# Insert BLOCK DATA calls in the main program
	# if (exists $Sf->{'Program'} and $Sf->{'Program'} == 1)
	# Find the last declaration. Just use a statefull pass or even a conditional splice.
	# Problem is of course comments. The condition is "line is a Decl and next line that is not a comment is not a decl
	# Also, if it's a COMMON or DIMENSION it is effectively a decl

	# In this stage, 'ExGlobArgs' is populated from CommonVars by looking at the common blocks that occur in the call chain
	# Note that this does not cover common blocks in includes so hopefully ExGlobArgs will not be affected for the case with includes.
	if ($sub_or_func_or_mod eq 'Subroutines') {
		_determine_exglobargs_rec($code_unit_name, $stref);
	}
	# First find any additional argument declarations, either in includes or via implicits
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		
		# Includes
		$stref = _lift_param_includes( $stref, $f );
		# ExImplicitArgs, ExInclArgs
		$stref = _find_argument_declarations( $stref, $f );
	}
	
	return $stref if $stage == 2;

#	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
#		next if $f eq '';
#
#		# In this stage, 'ExGlobArgs' is populated
#		$stref = _populate_exglobs_from_commonvars( $stref, $f );
#
#	}

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';	
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
#		say "SUB $f";
#		say "$f USES ", keys %{ $stref->{'Subroutines'}{$f}{'Uses'} };
		$stref = _analyse_variables( $stref, $f );
	}
	return $stref if $stage == 3;


# ConflictingGlobals: ex-common vars conflicting with params, both from include files
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		
		$stref = _resolve_conflicts_with_params( $stref, $f );
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

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		# RefactoredArgs = OrigArgs ++ ExGlobArgs and at this point any necessary renaming has been done
		$stref = _create_refactored_args( $stref, $f );
		if (exists $stref->{'Subroutines'}{$f}{'HasEntries'} ) {
			$stref = _create_refactored_entry_args( $stref, $f );
		}
	}
	return $stref if $stage == 6;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {    # Functions are just special subroutines
		next if $f eq '';		
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}
		$stref = _map_call_args_to_sig_args( $stref, $f );
	}
	return $stref if $stage == 7;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) { # Functions are just special subroutines
		next if $f eq '';
		if (exists $stref->{'Entries'}{$f}) {
			next;
		}

		$stref = _identify_external_proc_args( $stref, $f );
	}
	return $stref if $stage == 8;
	#croak Dumper( $stref->{'Subroutines'}{'gridcheck'}{'UndeclaredOrigLocalVars'} );

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
		
		$stref = _analyse_var_decls_for_params( $stref, $f );
	}
	
	
	return $stref;
}    # END of analyse_all()
# -----------------------------------------------------------------------------
# If the sub has arguments but they were not declared, see if we can find the declarations in include files, otherwise use implicit rules
# This is like _analyse_variables but for arguments
sub _find_argument_declarations {
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
}    # END of _find_argument_declarations

# -----------------------------------------------------------------------------
#2.4 Find all variables in a subroutine and categorise them:
#- IF NOT IN Args:
#	- IF NOT DeclaredVars
#		IF IN Commons for any Incl OR in LOCAL Commons => ExGlobArgs
#		ELSE
#			IF in Vars for any Incl => ExInclLocalVars, LocalVars
#				ELSE => UndeclaredOrigLocalVars, LocalVars
# Then merge the Args and ExGlobArgs
sub _analyse_variables {
	( my $stref, my $f ) = @_;
	
	my $Sf = $stref->{'Subroutines'}{$f};

	#	local $DBG= ;
	say "_analyse_variables($f)" if $DBG;

	my $__analyse_vars_on_line = sub {
		( my $annline, my $state ) = @_;
		( my $line,    my $info )  = @{$annline};
        

		if (   exists $info->{'Assignment'}
			or exists $info->{'SubroutineCall'}
			or exists $info->{'If'} # Control
			or exists $info->{'ElseIf'} # Control
			or exists $info->{'Do'} # Control
			or exists $info->{'WriteCall'}# IO
			or exists $info->{'PrintCall'}# IO
			or exists $info->{'ReadCall'}# IO
			or exists $info->{'InquireCall'}# IO
			or exists $info->{'OpenCall'}# IO
			or exists $info->{'CloseCall'}# IO
			or exists $info->{'ParamDecl'} )
		{
			( my $stref, my $f, my $identified_vars ) = @{$state};

			my $Sf     = $stref->{'Subroutines'}{$f};
		    my $chunks_ref = identify_vars_on_line($annline);	
			my @chunks = @{ $chunks_ref };

			# -------------------------------------------------------------------------------------------------------------------
			
			for my $mvar (@chunks) {
                next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar};    # Means it's a function
				next if $mvar =~ /^\d+$/;
				next if not defined $mvar or $mvar eq '';
# 			say "$f VAR1 $mvar";
				#				my $maybe_orig_arg = in_nested_set( $Sf, 'OrigArgs', $mvar );
				# Means arg was declared
				my $in_vars_subset = in_nested_set( $Sf, 'Vars', $mvar );
#				say "$mvar SUBSET: $in_vars_subset" if $f eq 'read_ncwrfout_gridinfo';
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
				# The same is true I thin for UndeclaredOrigLocalVars: we must type them via implicits

				# So is it actually not simply a case of saying,
				# if it's in not Vars OR
				# it is in Vars  but the decl is 1 ?
				#say "$f LINE: $line " if $mvar eq 'ivcn01';
#				 die $in_vars_subset if $mvar eq 'rvcn01';
#				say "$f VAR1 $mvar: ",exists $identified_vars->{$mvar} ? 1 : 0, $in_vars_subset;
				if (
					not exists $identified_vars->{$mvar} # mvar not yet identified
					and ( 
						not $in_vars_subset
						or ( $in_vars_subset and $Sf->{$in_vars_subset}{'Set'}{$mvar} eq '1' ) 
						)
				  ) {
#				  	say "$f VAR2 $mvar";
					my $in_incl = 0;
					if ( not exists $Sf->{'Commons'}{$mvar} ) {												
						for my $inc ( keys %{ $Sf->{'Includes'} } ) {
							say "LOOKING FOR $mvar from $f in $inc" if $DBG;

							# A variable can be declared in an include file or not and can be listed as common or not
							if ( in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar )
								or exists $stref->{'IncludeFiles'}{$inc}{'Commons'}{$mvar} )
							{
								$in_incl = 1;

								if (not exists $stref->{'IncludeFiles'}{$inc}{'ExtPath'} ) {
									if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
										print "WARNING: $mvar in $f is a PARAMETER from $inc!\n" if $W;
										$Sf->{'Includes'}{$inc}{'Only'}{$mvar} = 1;
									} else {
										if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common' ) {
											print "FOUND COMMON $mvar in INC $inc in $line\n" if $DBG;
											croak "COMMON $mvar for $f" . in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar )
											  if $mvar eq 'kp';
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
												croak "No Subset for $mvar in $inc $subset_for_mvar";
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
												say "INFO: LOCAL VAR FROM $inc, NOT COMMON! " . '_analyse_variables() ' . __LINE__ if $I;
												push @{ $stref->{'Subroutines'}{$f}{'ExInclLocalVars'}{'List'} }, $mvar;
												$stref->{'Subroutines'}{$f}{'ExInclLocalVars'}{'Set'}{$mvar} = $decl;
												croak "INFO: LOCAL VAR FROM $inc, NOT COMMON! " if $mvar eq 'len';
											}
											$identified_vars->{$mvar} = 1;
											last;
										} else {
											croak $mvar ,$inc;
										}
									}
								} else {
									say "INFO: $inc is EXTERNAL, not creating a declaration for $mvar in $f" if $I;
								}
							}
						}						
#						say "$f USES: ".Dumper($Sf->{'Uses'});
						for my $inc (  keys %{ $Sf->{'Uses'} } ) {
							say "LOOKING FOR $mvar from $f in $inc" if $DBG;
#say "$f USES $inc";
							# A variable can be declared in an include file or not and can be listed as common or not
							if ( in_nested_set( $stref->{'Modules'}{$inc}, 'Vars', $mvar )
								or exists $stref->{'Modules'}{$inc}{'Commons'}{$mvar} )
							{
#								say "$f VAR8 $mvar";
								$in_incl = 1;

								if (not exists $stref->{'Modules'}{$inc}{'ExtPath'} ) {
									my $var_rec = get_var_record_from_set( $stref->{'Modules'}{$inc}{'Vars'}, $mvar );
									if (exists $var_rec->{'Parameter'} ) {
										print "WARNING: $mvar in $f is a PARAMETER from $inc!\n" if $W;
										$Sf->{'Uses'}{$inc}{'Only'}{$mvar} = 1;
									} else {
#										say "$f VAR7 $mvar";
											print "FOUND COMMON $mvar in INC $inc in $line\n" if $DBG;
											croak "COMMON $mvar for $f" . in_nested_set( $stref->{'Modules'}{$inc}, 'Vars', $mvar )
											  if $mvar eq 'kp';
											my $decl;
											my $subset_for_mvar = in_nested_set( $stref->{'Modules'}{$inc}, 'Vars', $mvar );
											say "Found $mvar in $subset_for_mvar "
											  if $DBG;
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
												croak "No Subset for $mvar in $inc $subset_for_mvar";
											}
#	
#											if ( 1 or exists $stref->{'Modules'}{$inc}{'Commons'}{$mvar} ) {
#												say "$f VAR6 $mvar";
												say "FOUND argdecl for $mvar via common block in $inc" if $DBG;
												push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'} }, $mvar;
												$decl->{'Inc'}                                          = $inc;    #WV20160406 this is a bit late .
												$stref->{'Subroutines'}{$f}{'CommonIncs'}{$inc}         = $inc;
												$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$mvar} = $decl;
												$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar}  = 1;
#											} elsif ( in_nested_set($stref->{'Subroutines'}{$f},'CommonVars',$mvar) ) { 
#												say "FOUND argdecl for $mvar via common block in $f" if $DBG;
#												push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'} }, $mvar;
#												$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$mvar} = $decl;
#												$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$mvar}  = 1;											
#											} else {
#												say "INFO: LOCAL VAR FROM $inc, NOT COMMON! " . '_analyse_variables() ' . __LINE__ if $I;
#												push @{ $stref->{'Subroutines'}{$f}{'ExInclLocalVars'}{'List'} }, $mvar;
#												$stref->{'Subroutines'}{$f}{'ExInclLocalVars'}{'Set'}{$mvar} = $decl;
#												croak "INFO: LOCAL VAR FROM $inc, NOT COMMON! " if $mvar eq 'len';
#											}
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
#say "$f VAR3 $mvar";
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
							say "INFO: LOCAL VAR <$mvar> in $f via IMPLICIT! " . $line . ' _analyse_variables() ' . __LINE__ if $I;
							my $decl = get_f95_var_decl( $stref, $f, $mvar );

							if ( not $undecl_orig_arg ) {								
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
					say "_analyse_variables($f) " . __LINE__ . " : $mvar ALREADY DECLARED in $in_vars_subset:\n" . Dumper( $Sf->{$in_vars_subset}{'Set'}{$mvar} ) if $I;
					for my $inc ( keys %{ $Sf->{'Includes'} } ) {
							say "LOOKING FOR $mvar from $f in $inc" if $DBG;
							# A variable can be declared in an include file or not and can be listed as common or not
							if ( in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar )) {								
								if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
									print "WARNING: $mvar in $f is a PARAMETER from $inc!\n" if $W;
									 $Sf->{'Includes'}{$inc}{'Only'}{$mvar} =1;
								}
							}
					}
				}
			}			
			return ( [$annline], [ $stref, $f, $identified_vars ] );
#		} elsif (  exists $info->{'VarDecl'} ) {
#				croak Dumper($info);
		} else {
			return ( [$annline], $state );
		}
	};

	my $state = [ $stref, $f, {} ];

	( $stref, $state ) = stateful_pass( $stref, $f, $__analyse_vars_on_line, $state, '_analyse_variables() ' . __LINE__ );
	
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
			if ( $Sf->{$subset}{'Set'}{$var} eq '1' ) {
				say "WARNING: VAR $var from $subset in $f not yet declared, this means the variable was not detected properly!" if $W;
				my $decl = get_f95_var_decl( $stref, $f, $var );
				$Sf->{$subset}{'Set'}{$var} = $decl;
			}
		}
	}
	
	return $stref;
}    # END of _analyse_variables()

sub identify_vars_on_line {
		( my $annline ) = @_;
		( my $line,    my $info )  = @{$annline};

		if (   exists $info->{'Assignment'}
			or exists $info->{'SubroutineCall'}
			or exists $info->{'If'} # Control
			or exists $info->{'ElseIf'} # Control
			or exists $info->{'Do'} # Control
			or exists $info->{'WriteCall'}# IO
			or exists $info->{'PrintCall'}# IO
			or exists $info->{'ReadCall'}# IO
			or exists $info->{'InquireCall'}# IO
			or exists $info->{'OpenCall'}# IO
			or exists $info->{'CloseCall'}# IO
			or exists $info->{'ParamDecl'} )
		{
			
			my @chunks = ();
			if ( exists $info->{'If'} or exists $info->{'ElseIf'} ) {
				@chunks = @{ $info->{'CondVars'}{'List'} };
			}

			if (   exists $info->{'PrintCall'}
				or exists $info->{'WriteCall'}
				or exists $info->{'ReadCall'}
				or exists $info->{'InquireCall'} 
				) {
				@chunks = ( @chunks, @{ $info->{'CallArgs'}{'List'} }, @{ $info->{'ExprVars'}{'List'} }, @{ $info->{'CallAttrs'}{'List'} } );
				
			} elsif ( exists $info->{'SubroutineCall'} ) {
				for my $var_expr ( @{ $info->{'CallArgs'}{'List'} } ) {
					if ( exists $info->{'CallArgs'}{'Set'}{$var_expr}{'Arg'} ) {
						push @chunks, $info->{'CallArgs'}{'Set'}{$var_expr}{'Arg'};
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
				@chunks = ( @chunks, $info->{'Do'}{'Iterator'}, @{ $info->{'Do'}{'Range'}{'Vars'} } );
			} elsif ( exists $info->{'Assignment'} and not exists $info->{'Data'}) {
				@chunks = ( @chunks, $info->{'Lhs'}{'VarName'}, @{ $info->{'Lhs'}{'IndexVars'}{'List'} }, @{ $info->{'Rhs'}{'VarList'}{'List'} } );
			} elsif ( exists $info->{'ParamDecl'} ) {
				@chunks = ( @chunks, keys %{ $info->{'UsedParameters'} } );
			} else {
				my @mchunks = split( /\W+/, $line );
				for my $mvar (@mchunks) {
					next
					  if exists $F95_reserved_words{ $mvar };    # This should be, unless some idiot has assigned to a reserved word somewhere. We assume they only redefine intrinsic functions but who knows?
					next if exists $F95_other_intrinsics{$mvar};
#					next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar};    # Means it's a function
					next if $mvar =~ /^__PH\d+__$/;
					next if $mvar !~ /^[_a-z]\w*$/;
					push @chunks, $mvar;
				}
			}
            return [@chunks];
		} else {
            return [];
        }
} # END of identify_vars_on_line


sub _resolve_conflicts_with_params {
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
}    # END of _resolve_conflicts_with_params

# Create an entry 'RefactoredArgs'
sub _create_refactored_args {
	( my $stref, my $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
#	say "$f ".Dumper $Sf->{'Source'};
#    say Dumper($stref);	    
    return $stref unless defined $Sf->{'Source'};
#	say $f.' ExGlobArgs => '.Dumper $Sf->{'ExGlobArgs'};
#	say $f.' OrigArgs '.Dumper $Sf->{'OrigArgs'};
#	say $f.'DeclaredOrigArgs'.Dumper $Sf->{'DeclaredOrigArgs'}{'Set'};
#	say $f.'UndeclaredOrigArgs'.Dumper $Sf->{'UndeclaredOrigArgs'}{'Set'};
	
	 
	
	if ( exists $Sf->{'ExGlobArgs'}{'List'} and scalar @{$Sf->{'ExGlobArgs'}{'List'}}>0 and scalar @{ $Sf->{'OrigArgs'}{'List'} } >0
	) {

		$Sf->{'RefactoredArgs'}{'List'} = ordered_union( $Sf->{'OrigArgs'}{'List'}, $Sf->{'ExGlobArgs'}{'List'} );
		$Sf->{'RefactoredArgs'}{'Set'} = { %{ $Sf->{'UndeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'DeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'ExGlobArgs'}{'Set'} } };
#		croak Dumper($Sf->{'RefactoredArgs'}) if $f=~/update/;
		$Sf->{'HasRefactoredArgs'} = 1;

	} elsif ( exists $Sf->{'ExGlobArgs'}{'List'} and  scalar @{$Sf->{'ExGlobArgs'}{'List'}}==0
	and scalar @{ $Sf->{'OrigArgs'}{'List'} } >0
	) {

		# No ExGlobArgs, so Refactored = Orig
		$Sf->{'RefactoredArgs'}{'Set'}  = $Sf->{'OrigArgs'}{'Set'};
		$Sf->{'RefactoredArgs'}{'List'} = $Sf->{'OrigArgs'}{'List'};
		$Sf->{'HasRefactoredArgs'}      = 0;
	} elsif (  exists $Sf->{'ExGlobArgs'}{'List'} and  scalar @{$Sf->{'ExGlobArgs'}{'List'}}>0
	and scalar @{ $Sf->{'OrigArgs'}{'List'} } ==0
	) {

		# No ExGlobArgs, so Refactored = Orig
		$Sf->{'RefactoredArgs'}    = $Sf->{'ExGlobArgs'};
		$Sf->{'HasRefactoredArgs'} = 1;
	} else { # No args at all, implies Globals that have not yet been resolved
#		say "$f 4";
		$Sf->{'RefactoredArgs'} = { 'Set' => {}, 'List' => [] };
		$Sf->{'HasRefactoredArgs'} = 0;
	}
	return $stref;
} # END of _create_refactored_args

# Create an entry 'RefactoredArgs'
sub _create_refactored_entry_args {
	( my $stref, my $f ) = @_;
	my $Spf = $stref->{'Subroutines'}{$f};
	
	for my $f ( 	@{ $Spf->{'Entries'}{'List'} } ) {
		my $Sf =  $Spf->{'Entries'}{'Set'}{$f};
				
		if ( exists $Spf->{'ExGlobArgs'} and exists $Sf->{'OrigArgs'}
		and  exists $Spf->{'ExGlobArgs'}{'List'} and exists $Sf->{'OrigArgs'}{'List'}
		) {
	
			$Sf->{'RefactoredArgs'}{'List'} = ordered_union( $Sf->{'OrigArgs'}{'List'}, $Spf->{'ExGlobArgs'}{'List'} );
			$Sf->{'RefactoredArgs'}{'Set'} = { %{ $Sf->{'UndeclaredOrigArgs'}{'Set'} }, %{ $Sf->{'DeclaredOrigArgs'}{'Set'} }, %{ $Spf->{'ExGlobArgs'}{'Set'} } };
#			say "$f 5";
			$Sf->{'HasRefactoredArgs'} = 1;
	
		} elsif ( not exists $Spf->{'ExGlobArgs'} 
		and exists $Sf->{'OrigArgs'}{'List'}
		) {
	
			# No ExGlobArgs, so Refactored = Orig
			$Sf->{'RefactoredArgs'}{'Set'}  = $Sf->{'OrigArgs'}{'Set'};
			$Sf->{'RefactoredArgs'}{'List'} = $Sf->{'OrigArgs'}{'List'};
#			say "$f 6";
			$Sf->{'HasRefactoredArgs'}      = 0;
		} elsif ( not exists $Sf->{'OrigArgs'} 
		and  exists $Spf->{'ExGlobArgs'}{'List'} 
		) {
	
			# No ExGlobArgs, so Refactored = Orig
			$Sf->{'RefactoredArgs'}    = $Spf->{'ExGlobArgs'};
#			say "$f 7";
			$Sf->{'HasRefactoredArgs'} = 1;
		} else {
			$Sf->{'RefactoredArgs'} = { 'Set' => {}, 'List' => [] };
#			say "$f 8";
			$Sf->{'HasRefactoredArgs'} = 0;
		}	
	}
		
	return $stref;
} # END of _create_refactored_entry_args

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

			$info->{'SubroutineCall'}{'ArgMap'} = {};    # A map from the sig arg to the call arg, because there can be duplicate call args but not sig args

			my $call_args = $info->{'SubroutineCall'}{'Args'}{'List'};

			
			for my $call_arg_expr ( @{ $info->{'CallArgs'}{'List'} } ) {

				#					croak Dumper($info->{'CallArgs'}{'Set'}{$call_arg_expr}) if $call_arg_expr =~/float/;
				my $call_arg = $call_arg_expr;
#				croak $f.' => '.$sub."($call_arg_expr)\t".Dumper($info);
				if ( $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Type'} eq 'Array' ) {
					$call_arg = $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Arg'};
				}
				if (   exists $F95_intrinsics{$call_arg}
					or exists $F95_reserved_words{$call_arg} )
				{
					if ( not exists $stref->{'Subroutines'}{$sub}{'MaskedIntrinsics'}{$call_arg} ) {

						# This is an unmasked intrinsic, set to 'Sub'!
						say "INFO: Unmasked intrinsic $call_arg in $f" if $I;
						$info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Type'} = 'Sub';
					} else {
						say "Intrinsic $call_arg is MASKED in $f";
					}
				}
			}
			my $i = 0;
			for my $sig_arg ( @{ $stref->{'Subroutines'}{$sub}{'OrigArgs'}{'List'} } ) {
				my $call_arg_expr = $call_args->[$i];
#croak $line.Dumper($call_args) if not defined $call_arg_expr ;
				$info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} = $call_arg_expr;
				$i++;
			}
		}
		return [$annline];
	};

	my $state = [ $stref, $f, {} ];
	( $stref, $state ) = stateless_pass( $stref, $f, $__map_call_args, '_map_call_args_to_sig_args() ' . __LINE__ );

	return $stref;
}    # END of _map_call_args_to_sig_args()


sub _identify_external_proc_args {
	( my $stref, my $f ) = @_;
	say "_identify_external_proc_args($f)\n" if $DBG;
	
	my $__mark_args_as_external = sub {
		( my $annline ) = @_;
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'SubroutineCall'}
			and not exists $info->{'SubroutineCall'}{'IsExternal'} )
		{
			my $sub = $info->{'SubroutineCall'}{'Name'};
			for my $sig_arg ( @{ $stref->{'Subroutines'}{$sub}{'OrigArgs'}{'List'} } ) {
				
#				say "SUB: $sub" ;
#				say  Dumper($stref->{'Subroutines'}{$sub}).$sub;#{'Source'}; 
#				say " $sub => $sig_arg"; 
#				say Dumper($info->{'SubroutineCall'}{'ArgMap'}) if $line=~/xabort/;			

				my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
				
				if (defined $call_arg) {									
					if (exists $stref->{'Subroutines'}{$f}{'External'}{$call_arg}) {
						my $set = in_nested_set($stref->{'Subroutines'}{$sub},'Vars',$sig_arg);
						say "In proc $f, in call to sub $sub, arg $call_arg is EXTERNAL so setting $sig_arg attr External in set $set";
						
						$stref->{'Subroutines'}{$sub}{$set}{'Set'}{$sig_arg}{'External'}=1;
					}
				}
			}							
		}
		return [$annline];
	};
	
	 $stref = stateless_pass( $stref, $f, $__mark_args_as_external, '__mark_args_as_external() ' . __LINE__ );
#croak Dumper( $stref->{'Subroutines'}{'sn725'}{'OrigArgs'}
	return $stref;
}    # END of _identify_external_proc_args()


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
					croak "SHOULD NOT HAPPEN ".Dumper($var_rec);
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
				if ( in_nested_set( $stref->{'IncludeFiles'}{$inc}, 'Parameters', $par ) ) {

					#					say "FOUND PAR $par decl in $inc";
					$Sf->{'Includes'}{$inc}{'Only'}{$par} = 1;
				}
			}
		}
	}

	return $stref;
}
# This is for param includes inside other includes, and it is not recursive, FIXME!
sub _lift_param_includes {
	( my $stref, my $f ) = @_;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod}{$f};
	for my $inc ( keys %{ $Sf->{'Includes'} } ) {		
		if ( exists $stref->{'IncludeFiles'}{$inc}{'ParamInclude'} ) {
			my $param_include = $stref->{'IncludeFiles'}{$inc}{'ParamInclude'};
			$Sf->{'Includes'}{$param_include} = { 'Only' => {} };
		}
	}
	return $stref;
}

sub _populate_exglobs_from_commonvars { ( my $stref, my $f ) = @_; croak "UNUSED";
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod}{$f};
	my @subsets=();
	if (exists $Sf->{'DeclaredCommonVars'} ) {
		 push @subsets,'DeclaredCommonVars';
	} 
	if (exists $Sf->{'DeclaredCommonVars'} ) {
		push @subsets,'UndeclaredCommonVars';
	}
	for my $subset (@subsets) {
		for my $var (@{$Sf->{$subset}{'List'}}) {
				my $decl; 							
				my $var_rec = dclone( $stref->{'Subroutines'}{$f}{$subset}{'Set'}{ $var} );
				if ( not defined $var_rec ) {
					# This means this var decl in the include has not been declared
					croak "SHOULD NOT HAPPEN: No Decl for $var in $f $subset";
					# So we should type this one via Implicits
					$decl = get_f95_var_decl( $stref, $f, $var );#					say Dumper($decl);
				} else {
					$decl = $var_rec;
				}			
				if (exists $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$var} ) {croak "$var in $f : duplicate exglob"}
				push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'List'} }, $var;
				$stref->{'Subroutines'}{$f}{'ExGlobArgs'}{'Set'}{$var} = $decl;
				$stref->{'Subroutines'}{$f}{'MaskedIntrinsics'}{$var}  = 1;
		}
	}
	return $stref;
}


	
# We do a recusive descent for all called subroutines, and for the leaves we do the analysis.
# TODO: in principle this should also work for called functions ...
sub _determine_exglobargs_rec {
	( my $f, my $stref ) = @_;
	my $c;
	if ($V) {
		$c = ( defined $stref->{Counter} ) ? $stref->{Counter} : 0;
		say "\t" x $c, $f;
	}
	
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
			$stref->{Counter}++ if $V;
			$stref = _determine_exglobargs_rec( $calledsub, $stref );
			$Sf->{'ExGlobArgs'}{'Set'} = { %{ $Sf->{'ExGlobArgs'}{'Set'} }, %{ $stref->{'Subroutines'}{$calledsub}{'ExGlobArgs'}{'Set'} } };			
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
}    # _determine_exglobargs_rec()


# For BLOCK DATA, we create a new argument for every common block variable, by copying ${Var}_ARG into ExGlobArgs. 
# This will automatically create the additional argument declarations.
# We are only renaming (must dclone and change 'Name' though)

sub __determine_exglobargs_core { ( my $stref, my $f ) = @_;
	
	my $Sf = $stref->{'Subroutines'}{$f};
	my $is_block_data = exists $Sf->{'BlockData'} ? 1 : 0;
	
	# Get declarations from CommonVars	
	my $common_decls_current=__get_common_decls($stref,$f);	
	# Determine if this $var occurs in  $common_block_name anywhere up the stack
	# So either I go for every var through all callers or for every caller through all vars
	# Or better: create an intermediate datastructure $var => { $block => {$f =>1, ...} }
	my $common_decls_callers ={};
	for my $caller (@{$stref->{'CallStack'}}) {
		my $common_decls_caller=__get_common_decls($stref,$caller);
		for my $var (keys %{ $common_decls_caller }) {
			if (not exists $common_decls_caller->{$var}{'CommonBlockName'}) {
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

=pod
- start from the top
- recursive descent to leave (no callers), push the path onto a stack
- For every Common in a leave node:
	- go through the stack in order check if this Common var is declared in any of the callers 
if (my $subset=in_nested_sets($Sf,'CommonVars',$var) and $Sf->{$subset}{'Set'}{$var}{'CommonBlockName'} eq $common_block_name) {
# add this $var to ExGlobArgs
}

=cut

sub _add_BLOCK_DATA_call_after_last_VarDecl { 
	( my $f, my $stref ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};	
	my $annlines=$Sf->{'AnnLines'};
	
	my $in_decls=0;
	my $decl=0;
	my $found_hook=0;
	my $new_annlines=[];
	for my $annline (@{$annlines}) {
		(my $line, my $info)=@{$annline};
		
		if (exists $info->{'Comments'} or exists $info->{'Blank'}) {
			push @{$new_annlines}, $annline;
			next;
		}
		
		if (
		(exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'} and $info->{'Signature'}{'Program'} == 1) or
		exists $info->{'Include'} or
		exists $info->{'VarDecl'} or
		exists $info->{'Common'} or
		exists $info->{'Dimension'} or 
		exists $info->{'External'} or
		exists $info->{'Equivalence'} # I guess there might be others ...
		) {
			$decl=1;
		} else {
			$decl=0;
		}
		if ($decl and $in_decls==0) {
			$in_decls=1;
		}
		if ($in_decls and not $decl and $found_hook==0) {
			$found_hook=1;
			# So here we should put in the additional calls to BLOCK DATA
			for my $block_data (keys %{ $stref->{'BlockData'} } ) { 
				my $call_block_data_line = "        call $block_data"; 
				push @{$new_annlines}, [
				$call_block_data_line, 
				{
					'SubroutineCall'=> {
						'Name' => $block_data,
						'Args' => {'List'=>[],'Set'=>{} },
						'ExpressionAST' => [
          					'&',$block_data
        				],
					},
					'ExprVars' => {
        				'List' => [],
        				'Set' => {}
      				},
					'CallArgs' => {
        				'Set' => {},
        				'List' => []
      				},
      				'LineID' => ++$annlines->[-1][1]{'LineID'}
				}
				];
				unshift @{$stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'}}, $block_data;
				$stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$block_data}=1;
			}
		} 
		push @{$new_annlines}, $annline;
	}
	$stref->{'Subroutines'}{$f}{'AnnLines'}=$new_annlines;
	
	return $stref;
} # END of _add_BLOCK_DATA_call_after_last_VarDecl


1;
