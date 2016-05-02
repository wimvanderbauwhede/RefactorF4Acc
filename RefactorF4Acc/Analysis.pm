package RefactorF4Acc::Analysis;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Includes qw( find_root_for_includes );
use RefactorF4Acc::Analysis::Globals qw( lift_globals );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_end_detect );
use RefactorF4Acc::Refactoring::Common qw( get_f95_var_decl stateful_pass stateless_pass );

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
	
	$stref = lift_globals( $stref, $subname );
	return $stref if $stage == 5;
	
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';
		$stref = _create_refactored_args( $stref, $f );		
	}	
	return $stref if $stage == 6;

	for my $f ( keys %{ $stref->{'Subroutines'} } ) { # Assuming Functions are just special subroutines
		next if $f eq '';
#		next if exists $stref->{'ExternalSubroutines'}{$f};
		$stref = _map_call_args_to_sig_args( $stref, $f );
	}
	return $stref if $stage == 7;

	
# This is only for refactoring init out of time loops so very domain specific
	for my $kernel_wrapper ( keys %{ $stref->{'KernelWrappers'} } ) {
		$stref = outer_loop_end_detect( $kernel_wrapper, $stref );
	}

	
# So at this point all globals have been resolved and typed.
# NOTE: It turns out that at this point any non-global not explicity declared variables don't have a declaration yet.
	return $stref;
}    # END of analyse_all()

# If the sub has arguments but they were not declared, see if we can find the declarations in include files, otherwise use implicit rules
sub _find_argument_declarations {
	( my $stref, my $f ) = @_;
	my $once               = 1;
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
	
	if (exists $Sf->{'OrigArgs'}{'List'}) {
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
	}
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
	say "_analyse_variables($f)" if $DBG;
#	die Dumper($Sf->{'Vars'}) if $f eq 'post';
	
	
#	my $state = [ $stref, $f, {} ];
#	
#	( $stref, $state ) =
#	  stateful_pass( $stref, $f, $__analyse_vars_on_line, $state, '_analyse_variables() ' . __LINE__ );		
# (my $stref, my $f, my $pass_actions, my $state, my $info ) = @_;
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
			or exists $info->{'OpenCall'}  
			or exists $info->{'CloseCall'} 
			)
		{

		( my $stref, my $f, my $identified_vars ) = @{$state};
		
			
			my $Sf = $stref->{'Subroutines'}{$f};
#			my @chunks = split( /[^\.\w]/, $line );
			my @chunks = ();
			if ( exists $info->{'If'} ) {
#				say Dumper($info);
				@chunks = keys %{ $info->{'CondVars'} } ;
			}			
			
			if (exists $info->{'PrintCall'}
			or exists $info->{'WriteCall'}
			or exists $info->{'ReadCall'}
			or exists $info->{'SubroutineCall'} ) {
#				carp $line.Dumper($info) if exists $info->{'WriteCall'};
				@chunks = (@chunks,@{$info->{'CallArgs'}{'List'}}, @{$info->{'ExprVars'}{'List'}} ) ;				
			} elsif (exists $info->{'OpenCall'}) {
				if (exists $info->{'FileNameVar'} ) {
				push @chunks, $info->{'FileNameVar'};
				}
			} elsif (exists $info->{'Do'}) {
						@chunks = ($info->{'Do'}{'Iterator'}, @{ $info->{'Do'}{'Range'}{'Vars'} } );						
			} elsif (exists $info->{'Assignment'}) {
#				croak $line.Dumper($info) if $line=~/diu1/ and $f eq 'les';
					@chunks = ($info->{'Lhs'}{'VarName'},@{$info->{'Lhs'}{'IndexVars'}{'List'}}, @{$info->{'Rhs'}{'VarList'}{'List'}} ) ;
#					croak Dumper(@chunks) if $line=~/__PH\d+__/ and $f eq 'set';
			} else {
				my @mchunks = split( /\W+/, $line );
				for my $mvar (@mchunks) {				
					next if exists $F95_reserved_words{$mvar};
					next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$mvar}; # Means it's a function
					next if $mvar =~ /^__PH\d+__$/;
					next if $mvar !~ /^[_a-z]\w*$/;
					push @chunks, $mvar;
				}
			}
			for my $mvar (@chunks) {	 			
				my $maybe_orig_arg = in_nested_set( $Sf, 'OrigArgs', $mvar );
				my $maybe_decl_orig_arg = exists  $Sf->{'DeclaredOrigArgs'}{'Set'}{$mvar} ? 'DeclaredOrigArgs' : '';
				my $undecl_orig_arg = exists  $Sf->{'UndeclaredOrigArgs'}{'Set'}{$mvar} ? 1 : 0;
#				
#			say "LINE:\t$line => $mvar:".$maybe_orig_arg if $f eq 'post' ;
			# Here it is still possible that the variables don't have any declarations
			# If that is the case for OrigArgs we must type them via Implicits
			# But should this not have happened already? No, because UndeclaredOrigArgs could be declared vi Includes,
			# and that is checked here.
			# So I think we exclude the DeclaredOrigArgs only
								
#				say 'MVAR: ',$mvar,': <',$maybe_orig_arg,'>' if $f eq 'boundsm';
				if (    not exists $identified_vars->{$mvar}
					and ( $maybe_decl_orig_arg eq '' ) # means $mvar is not present in the set DeclaredOrigArgs
					and 
					(not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$mvar} or $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$mvar}==1))
				{
					my $in_incl = 0;
					
					for my $inc ( keys %{ $Sf->{'Includes'} } ) {
						say "LOOKING FOR $mvar from $f in $inc" if $DBG;
#croak Dumper($annline). ' => '. $inc  if $f eq 'anime' and $mvar eq 'a1';
# A variable can be declared in an include file or not and can be listed as common or not
						if (
						 in_nested_set($stref->{'IncludeFiles'}{$inc}, 'Vars', $mvar)
#							exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mvar}
							or exists $stref->{'IncludeFiles'}{$inc}{'Commons'}
							{$mvar} )
						{
							$in_incl = 1;
					
							if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq
								'Parameter' )
							{
								print "WARNING: $mvar in $f is a PARAMETER from $inc!\n"
								  if $W;
							} else {
								if ( $stref->{'IncludeFiles'}{$inc}{'InclType'}
									eq 'Common' )
								{
									print "FOUND COMMON $mvar in INC $inc in $line\n"
									  if $DBG;
									my $decl;
									my $subset_for_mvar = in_nested_set(
										$stref->{'IncludeFiles'}{$inc},
										'Vars', $mvar );
										die $subset_for_mvar  if $subset_for_mvar =~/Glob/;
									if ( $subset_for_mvar ne '' ) {
										if (
											exists $stref->{'IncludeFiles'}
											{$inc}{$subset_for_mvar}{'Set'}{$mvar} )
										{
											
											$decl =
											  $stref->{'IncludeFiles'}{$inc}
											  {$subset_for_mvar}{'Set'}{$mvar};
											
										} else {
											# This means the var decls in the include have not yet been declared via implicits
											croak "No Decl for $mvar in $inc $subset_for_mvar".Dumper($stref->{'IncludeFiles'}{$inc}{'Decls'});
										}
									} else {										
										croak "No Subset for $mvar in $inc $subset_for_mvar";
									}

									if ( exists $stref->{'IncludeFiles'}{$inc}{'Commons'}{$mvar} ) {
										say "FOUND argdecl for $mvar via common block in $inc" if $DBG;
										push @{ $stref->{'Subroutines'}{$f}
											  {'ExGlobArgDecls'}{'List'} },
										  $mvar;
										  $decl->{'Inc'}=$inc; #WV20160406 this is a bit late .
										  $stref->{'Subroutines'}{$f}{'CommonIncs'}{$inc}=$inc;
										$stref->{'Subroutines'}{$f}
										  {'ExGlobArgDecls'}{'Set'}{$mvar} =
										  $decl;
									} else {
										say "INFO: LOCAL VAR FROM $inc, NOT COMMON! "
										  . '_analyse_variables() '
										  . __LINE__
										  if $I;

										push @{ $stref->{'Subroutines'}{$f}
											  {'ExInclVarDecls'}{'List'} },
										  $mvar;
										$stref->{'Subroutines'}{$f}
										  {'ExInclVarDecls'}{'Set'}{$mvar} =
										  $decl;
									}
									$identified_vars->{$mvar} = 1;
									
									last;
								}
							}
						}
					}
					if ( not $in_incl ) {
						# Now check if this variable might be accessed via the containing program
						$identified_vars->{$mvar} = 0;
#						croak $mvar if $f eq 'kernelb' and $mvar eq 'connv';
						if (exists $stref->{'Subroutines'}{$f}{'Container'}) {
							my $container=$stref->{'Subroutines'}{$f}{'Container'};
											my $subset =
				  in_nested_set( $stref->{'Subroutines'}{$container}, 'Vars', $mvar );
				if ( $subset ne '' ) {
					say "FOUND VAR $mvar in CONTAINER $container" if $DBG; 
					# If so, this is treated as an ExGlob
					push @{ $stref->{'Subroutines'}{$f}
											  {'ExGlobArgDecls'}{'List'} },
										  $mvar;
					my $decl = $stref->{'Subroutines'}{$container}{$subset}{'Set'}{$mvar}; 										  	
										  $decl->{'Container'}=$container; 
										  $decl->{'Indent'}='      '; # ad hoc!
										$stref->{'Subroutines'}{$f}
										  {'ExGlobArgDecls'}{'Set'}{$mvar} =
										  $decl;
					$identified_vars->{$mvar} = 1;
#					croak 'EXGLOBS FROM CONTAINER: '.$mvar;
				} 
						} 
						if ($identified_vars->{$mvar} != 1) {
							
							if ( $line =~ /$mvar\s*\(/ ) {
								say
	"INFO: LOCAL VAR <$mvar> in $f may be an EXTERNAL FUNCTION "
								  if $I;
							} else {
#								die "LINE:\t$line => $mvar:".$maybe_decl_orig_arg if $f eq 'gser' and $mvar eq 'a';
								say "INFO: LOCAL VAR <$mvar> in $f via IMPLICIT! "
								  . $line
								  . ' _analyse_variables() '
								  . __LINE__
								  if $I;
								my $decl = get_f95_var_decl( $stref, $f, $mvar );
#	die "<$undecl_orig_arg>" if $f eq 'gser' and $mvar eq 'a';
	#                            push @{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'List'} }, $mvar;
	#                            $stref->{'Subroutines'}{$f}{'LocalVars'}{'Set'}{$mvar} = $decl;
								if (not $undecl_orig_arg) {
								push @{ $stref->{'Subroutines'}{$f}{'ExImplicitVarDecls'}{'List'} }, $mvar;
								$stref->{'Subroutines'}{$f}{'ExImplicitVarDecls'}
								  {'Set'}{$mvar} = $decl;
								} else { 
								push @{ $stref->{'Subroutines'}{$f}{'ExImplicitArgDecls'}{'List'} }, $mvar;
								$stref->{'Subroutines'}{$f}{'ExImplicitArgDecls'}
								  {'Set'}{$mvar} = $decl;
#									die Dumper($stref->{'Subroutines'}{$f}{'UndeclaredOrigArgs'}{'Set'}) if $mvar eq 'a' and $f eq 'gser';
								}
							}
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
					if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{'Set'}{$mpar} )
					{
						my $commoninc = $Sf->{'Globals'}{'Set'}{$mpar}{'Inc'};
						print
"WARNING: $mpar from $inc conflicts with $mpar from $commoninc\n"
						  if $W;

# So we store the new name, the Common include and the Parameter include in that order
						$Sf->{'ConflictingGlobals'}{$mpar} =
						  [ $mpar . '_GLOB_' . $commoninc, $commoninc, $inc ]
						  ;    # In fact, just $commoninc is enough
						$stref->{'IncludeFiles'}{$commoninc}
						  {'ConflictingGlobals'}{$mpar} =
						  [ $mpar . '_GLOB_' . $inc, $commoninc, $inc ];
						$stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
						  {$mpar} =
						  [ $mpar . '_GLOB_' . $inc, $commoninc, $inc ];

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
	if (exists $Sf->{'ExGlobArgDecls'} and exists $Sf->{'OrigArgs'} ) {
		
#		if ( not exists $Sf->{'ExGlobArgDecls'}{'List'} ) {
#			$Sf->{'ExGlobArgDecls'}{'List'}=[];
#		}
#				
#		if ( not exists $Sf->{'ExGlobArgDecls'}{'Set'} ) {
#			$Sf->{'ExGlobArgDecls'}{'Set'}={};
#		}
#
#		if ( not exists $Sf->{'OrigArgs'}{'List'} ) {  
#			$Sf->{'OrigArgs'}{'List'}=[];
#		}
#		
#		if ( not exists $Sf->{'OrigArgs'}{'Set'} ) {
#			$Sf->{'OrigArgs'}{'Set'}={};
#		}
		$Sf->{'RefactoredArgs'}{'List'} = ordered_union( $Sf->{'OrigArgs'}{'List'}, $Sf->{'ExGlobArgDecls'}{'List'} );
		$Sf->{'RefactoredArgs'}{'Set'} =
		  	{ %{ $Sf->{'UndeclaredOrigArgs'}{'Set'} },
		  		 %{ $Sf->{'DeclaredOrigArgs'}{'Set'} },
				%{ $Sf->{'ExGlobArgDecls'}{'Set'} } };
		$Sf->{'HasRefactoredArgs'} = 1;
		
	} elsif (not exists $Sf->{'ExGlobArgDecls'} ) {
		# No ExGlobArgDecls, so Refactored = Orig
			$Sf->{'RefactoredArgs'} = $Sf->{'OrigArgs'};
			$Sf->{'HasRefactoredArgs'} = 0;
	} elsif (not exists $Sf->{'OrigArgs'} ) {
		# No ExGlobArgDecls, so Refactored = Orig
			$Sf->{'RefactoredArgs'} = $Sf->{'ExGlobArgDecls'};
			$Sf->{'HasRefactoredArgs'} = 1;
	} else {
		$Sf->{'RefactoredArgs'} = { 'Set' => {}, 'List' => []};
		$Sf->{'HasRefactoredArgs'} = 0;
	}
	return $stref;
}

sub _map_call_args_to_sig_args { (my $stref, my $f ) = @_;
	say "_map_call_args_to_sig_args($f)\n" if $DBG;	 
		my $__map_call_args = sub {
			( my $annline) = @_;
			( my $line,    my $info )  = @{$annline};
			if (exists $info->{'SubroutineCall'} and not exists $info->{'SubroutineCall'}{'IsExternal'}) {
				my $sub=$info->{'SubroutineCall'}{'Name'};
				
				$info->{'SubroutineCall'}{'ArgMap'}={};
				my @sig_args=@{$stref->{'Subroutines'}{$sub}{'OrigArgs'}{'List'}};
				my $i=0;
				for my $call_arg (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
					$info->{'SubroutineCall'}{'ArgMap'}{$call_arg}=$sig_args[$i];
					$i++;	
				}
			}
			return $annline; 
		};

	my $state = [ $stref, $f, {} ];
	( $stref, $state ) =
	  stateless_pass( $stref, $f, $__map_call_args,
		'_map_call_args_to_sig_args() ' . __LINE__ );
	
	return $stref ;
}

1;
