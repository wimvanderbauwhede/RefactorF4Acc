package RefactorF4Acc::Analysis::CommonBlocks;
#
#   (c) 2010-now Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
# use RefactorF4Acc::ExpressionAST::Evaluate qw( eval_expression_with_parameters );
use RefactorF4Acc::Utils qw( in_nested_set add_var_decl_to_set remove_var_decl_from_set pp_annlines );

use RefactorF4Acc::Parser::Expressions qw( parse_expression_no_context );
use RefactorF4Acc::Analysis::Arguments qw( create_RefactoredArgs );
use RefactorF4Acc::Analysis::Arrays qw(  
get_array_rank
calculate_array_size
calculate_multidim_indices_from_linear
dim_to_str
);
use RefactorF4Acc::Refactoring::Casts qw( _cast_annlines );

use vars qw( $VERSION );
$VERSION = "2.1.1";

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  analyse_common_blocks
  collect_common_vars_per_block
);

sub analyse_common_blocks { (my $stref) =@_;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';			
		next  if $f eq 'UNKNOWN_SRC';
		next unless exists $stref->{'Subroutines'}{$f}{'HasLocalCommons'};

#	 say "\nCOMMON BLOCK VARS in $f:\n";
#    say Dumper($stref->{'Subroutines'}{$f}{'CommonBlocks'});
#	die if $f eq 'fm302';
		next if  exists $stref->{'Subroutines'}{$f}{'Program'} and $stref->{'Subroutines'}{$f}{'Program'}==1;
		
#	 say "\nCOMMON BLOCK MISMATCHES in $f:\n";
#    say Dumper($stref->{'Subroutines'}{$f}{'CommonBlocks'});
    $stref = _identify_common_var_mismatch($stref,$f);
#    say Dumper($stref->{'Subroutines'}{$f}{'CommonVarMismatch'});
	}

	
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';			
		next  if $f eq 'UNKNOWN_SRC';
		next unless exists $stref->{'Subroutines'}{$f}{'HasLocalCommons'};
		_create_common_var_size_tuples( $stref, $f );
	}

	for my $f ( keys %{ $stref->{'Subroutines'} } ) {		
		next if $f eq '';			
		next  if $f eq 'UNKNOWN_SRC';
		next unless exists $stref->{'Subroutines'}{$f}{'HasLocalCommons'};
		_match_up_common_vars( $stref, $f );
		next unless exists $stref->{'Subroutines'}{$f}{'HasCommonVarMismatch'};
		$stref = create_RefactoredArgs( $stref, $f );
	}
		
	return $stref;
	} # END of analyse_common_blocks



=pod
We need to identify if there is CommonVarMismatch or not

Given the two lists of common vars, one (the CalledSub one) needs to be a strict subset of the other (CallerSub). And all vars must be the same type and dimension, just the names is not good enough.

If it's the other way round, CallerSub strict subset of CalledSub, then we need to declare the extra vars in the Caller.
=cut

# For every subroutine, see if there is a mismatch with any of the callers.
sub _identify_common_var_mismatch {
	my ( $stref, $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	say "CALLED SUB $f" if $DBG;
	if ( exists $Sf->{'Callers'} ) {
		my $callers = $Sf->{'Callers'};

		# If there is more than one caller, we must do this for every caller
		$Sf->{'ExMismatchedCommonArgs'} = { 'SigArgs' => { 'List' => [], 'Set' => {} }, 'CallArgs' => {} };
		for my $caller ( sort keys %{ $Sf->{'Callers'} } ) {
			say "CALLER $caller" if $DBG;
			$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller} = {};
			for my $block ( sort keys %{ $Sf->{'CommonBlocks'} } ) {

				#		    	say "BLOCK $block";
				if ( exists $stref->{'Subroutines'}{$caller}{'CommonBlocks'}{$block} ) {
					my $called_sub_common_vars = $Sf->{'CommonBlocks'}{$block};
					my $caller_sub_common_vars =
					  $stref->{'Subroutines'}{$caller}{'CommonBlocks'}{$block};
					if ( scalar @{$called_sub_common_vars} <= scalar @{$caller_sub_common_vars} ) {
						for my $idx ( 0 .. scalar @{$called_sub_common_vars} - 1 ) {
							my $called_sub_common_var = $called_sub_common_vars->[$idx];
							my $caller_sub_common_var = $caller_sub_common_vars->[$idx];

							#			                say "VARS: $called_sub_common_var $caller_sub_common_var";
							if ( $called_sub_common_var eq $caller_sub_common_var ) {
								my $called_set = in_nested_set( $Sf, 'CommonVars', $called_sub_common_var );
								my $caller_set = in_nested_set( $stref->{'Subroutines'}{$caller}, 'CommonVars', $caller_sub_common_var );
								my $called_sub_common_var_decl = $Sf->{$called_set}{'Set'}{$called_sub_common_var};
								my $caller_sub_common_var_decl = $stref->{'Subroutines'}{$caller}{$caller_set}{'Set'}{$caller_sub_common_var};
								if ( not _compare_decls( $stref, $f, $caller, $called_sub_common_var_decl, $caller_sub_common_var_decl, 1 ) ) {
									$Sf->{'CommonVarMismatch'}{$caller}{$block} = 1;
									last;
								}
							} else {
								$Sf->{'CommonVarMismatch'}{$caller}{$block} = 1;
								last;
							}
						}
					} else {
						$Sf->{'CommonVarMismatch'}{$caller}{$block} = 1;
					}
				}
				if (    exists $Sf->{'CommonVarMismatch'}{$caller}
					and exists $Sf->{'CommonVarMismatch'}{$caller}{$block} )
				{
					say "BLOCK $block in $f has CommonVarMismatch with $caller" if $DBG;
					$Sf->{'HasCommonVarMismatch'} = 1;
				} else {
					say "BLOCK $block in $f is matched with $caller: " . join( ',', @{ $Sf->{'CommonBlocks'}{$block} } ) if $DBG;
					$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} =
					  [ @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, @{ $Sf->{'CommonBlocks'}{$block} } ];

					map { $Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$_} = [ [$_], $caller, $_, $block ]; } @{ $Sf->{'CommonBlocks'}{$block} };
				}

			}    # block
			if ( scalar keys %{ $Sf->{'CommonVarMismatch'}{$caller} } == 0 ) {
				say "All blocks in $f match with $caller, OK to use old approach" if $V;
			}
		}    # caller

		# Add the declarations to the SigArgs Set
		map {
			my $sig_arg = $_;
			my $set     = in_nested_set( $Sf, 'CommonVars', $sig_arg );
			my $decl    = $Sf->{$set}{'Set'}{$sig_arg};
			$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$sig_arg} = $decl;
		} @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} };
	}
	return $stref;
}    # END of _identify_common_var_mismatch

sub _compare_decls {
	my ( $stref, $f1, $f2, $decl1, $decl2, $compare_names ) = @_;

	my $names_match = $decl1->{'Name'} eq $decl2->{'Name'};
	return 0 unless ( !$compare_names or $names_match );
	my $types_match = $decl1->{'Type'} eq $decl2->{'Type'};
	return 0 unless $types_match;
	if ( $DBG and  
		 $decl1->{'Attr'} =~ /=/ and $decl2->{'Attr'} !~ /=/
		or $decl1->{'Attr'} !~ /=/ and $decl2->{'Attr'} =~ /=/ )
	{
		carp "Attributes have different structure: $f1 " . $decl1->{'Attr'} . Dumper($decl1).'<>' . $f2.' '.$decl2->{'Attr'}.Dumper($decl2);		
	}
	my $attrs_match = $decl1->{'Attr'} eq $decl2->{'Attr'};
	return 0 unless $attrs_match;
	my $a_or_s_match = $decl1->{'ArrayOrScalar'} eq $decl2->{'ArrayOrScalar'};
	return 0 unless $a_or_s_match;
	if ( $decl1->{'ArrayOrScalar'} eq 'Array' ) {
		my $dim1 = $decl1->{'Dim'};
		my $dim2 = $decl2->{'Dim'};

				# carp Dumper($dim1,$dim2);
		my ($size1, $not_const1) = calculate_array_size( $stref, $f1, $dim1 );
		my ($size2, $not_const2) = calculate_array_size( $stref, $f2, $dim2 );
		# carp Dumper($size1,$size2);
		my $dims_match = $size1 == $size2;
		return 0 unless $dims_match;
	}
	return 1;
}    # END of _compare_decls



# Annotate the var with most of the declaration, mostly for type checking while lining up
# The tuple has the following type:
# $common_var_size_tuple = [
# 				$called_sub_common_var,         # :: VarName
# 				$called_sub_common_var_decl,    # :: VarDeclRec
# 				$kind_or_len,                   # :: AttrVal
# 				$dim,                           # :: Dim
# 				$dimsz,                         # :: Integer, linear size
# 				$lin_idx,                       # :: Integer, linear index, starting at 1
# 				$used_before                    # :: Bool, UsedBefore
# 			];
# The VarDeclRec is there for convenience

sub _create_common_var_size_tuples {

	my ( $stref, $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	for my $block ( sort keys %{ $Sf->{'CommonBlocks'} } ) {

		#			say "MISMATCHED BLOCK $block in $f";
#		croak Dumper($Sf->{'CommonBlocks'}{$block}) if $f eq 'fm024';
		my @called_sub_common_vars = @{ $Sf->{'CommonBlocks'}{$block} };
		my @common_var_size_tuples = map {

			# This means we will have to match them up, so create the tuples
			my $called_sub_common_var = $_;
			my $called_set            = in_nested_set( $Sf, 'CommonVars', $called_sub_common_var );
			
			my $called_sub_common_var_decl = $Sf->{$called_set}{'Set'}{$called_sub_common_var};
			my $dimsz = 0;
			my $dim   = [];
			
			if ( $called_sub_common_var_decl->{'ArrayOrScalar'} eq 'Array' ) {
				$dim   = dclone( $called_sub_common_var_decl->{'Dim'} );
				($dimsz, my $not_const) = calculate_array_size( $stref, $f, $dim ),;
			}
			my $type        = $called_sub_common_var_decl->{'Type'};
			my $kind_or_len = $type eq 'character' ? 1 : 4;            # default
			if ($DBG and $called_sub_common_var_decl->{'Attr'} =~ /\*/ ) {
				croak "MUST HAVE ACTUAL SIZE!";
			}
			if ( $called_sub_common_var_decl->{'Attr'} ne '' ) {
				$kind_or_len = $called_sub_common_var_decl->{'Attr'};
				$kind_or_len =~ s/\w+\s*=\s*//;
			}

			# I need a field to indicate the first time an element is accessed.
			# I can either make this 0|1 or put the $dim_sz in it
			# Let's start with 0|1
			# I think it might be better to just put the entire Decl in here, with a separate Dim which gets updated
			[
				$called_sub_common_var,         # :: VarName -- String
				$called_sub_common_var_decl,    # :: VarDeclRec
				$kind_or_len,                   # :: AttrVal
				$dim,                           # :: Dim -- [[Integer]]
				$dimsz,                         # :: Integer -- linear size
				1,                              # :: Integer -- linear index, starting at 1
				0                               # :: UsedBefore
			];
		} @called_sub_common_vars;
		$Sf->{'CommonBlockSequences'}{$block} = [@common_var_size_tuples];
	}

	return $stref;
}    # END of _create_common_var_size_tuples

sub _match_up_common_vars {
	my ( $stref, $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	if ( not exists $Sf->{'ExMismatchedCommonArgs'} ) {
		$Sf->{'ExMismatchedCommonArgs'} =
		  { 'SigArgs' => { 'List' => [], 'Set' => {} }, 'CallArgs' => {} };
	}
	for my $caller ( sort keys %{ $Sf->{'CommonVarMismatch'} } ) {
		for my $block ( sort keys %{ $Sf->{'CommonVarMismatch'}{$caller} } ) {
			say "\nMATCHING UP vars in $f and caller $caller for COMMON block $block"
			  if $DBG;
			_match_up_common_var_sequences( $stref, $f, $caller, $block );
		}
	}
	
	return $stref;
}    # END of _match_up_common_vars

# We create assignments local_var = caller_var
# and if the intent is also Out, also caller_var = local_var before exiting the subroutine.
# This means before either a return or falling off the end
# For arrays, it means we need to provide an array slice of the size of the smalles one to make it work, e.g. ral1 = ra1(2:4)

sub _match_up_common_var_sequences {
	my ( $stref, $f, $caller, $block ) = @_;

	# say "MATCHING UP BLOCK $block for $f and $caller";
	# So the problem here is that in some evil code, the caller can have a type mismatch with the local
	# We should use the local if possible I guess. 
	my $Sf               = $stref->{'Subroutines'}{$f};
	my @common_local_seq = @{ $Sf->{'CommonBlockSequences'}{$block} };
	my @common_caller_seq =  @{ $stref->{'Subroutines'}{$caller}{'CommonBlockSequences'}{$block} };

	# @equivalence_pairs ::  [(VarName,Type,ArrayOrScalar,Dim,PrefixStr)]
	#  [ $name, $type, 0|1, [], [] ]
	# type VarName = String
	# type Type = String -- integer | real | character | ...
	# type ArrayOrScalar = Integer -- 1 for Array, 0 for Scalar
	# type Dim is [[Integer]]
	# type PrefixStr = [String]	
	my @equivalence_pairs = ();	
	# croak 'LOCAL:'.Dumper( map {$_->[0].(@{$_->[3]}>0? '('.$_->[4].')':'' )} @common_local_seq).'CALLER:'.Dumper( map {$_->[0].(@{$_->[3]}>0? '('.$_->[4].')':'' )} @common_caller_seq);
	my $well_aligned=1;
	while ( scalar @common_local_seq > 0 ) {    # keep going until the local sequence is consumed
		my $elt_local = shift @common_local_seq;
		
		my ( $name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $lin_idx_local, $used_local ) = @{$elt_local};
		my $type_local = $decl_local->{'Type'};
		# say Dumper($elt_local);
		# say "LOCAL: $name_local :: $type_local";#  if $f eq 'mult_chk' and $name_local eq 'w4';
		if (@common_caller_seq) {

			my $elt_caller = shift @common_caller_seq;
			my ( $name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $lin_idx_caller, $used_caller ) = @{$elt_caller};
			my $type_caller = $decl_caller->{'Type'};
			# carp 'dim_caller: '.Dumper($dim_caller);
			# say "$f $caller: LOCAL: $name_local CALLER: $name_caller " ;#if $f eq 'ff304' and $name_local ne $name_caller;

			# add this caller to ExMismatchedCommonArgs
			# WV 2020-02-04 Is this always the case?
			my $prefix = $block eq 'BLANK' ? [$caller] : [ $caller, $block ];
			# if ( $used_caller == 0 ) {
			# 	$used_caller = 1;
			# 	# For the first arg, well-aligned is always true. Maybe we need to put this right at the end!
			# 	if ($well_aligned)	 {
			# 		say "HERE, WRONG! $name_local $name_caller";
			# 		push @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, $name_local;
			# 		$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$name_local} = $decl_local;
			# 		$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$name_local} = [ [$name_caller], $caller,$name_local, $block ];

			# 	} else {
			# 		say "HERE, OK! $name_local $name_caller";

			# 		if ( not exists $decl_caller->{'IODir'} ) {
			# 			$decl_caller->{'IODir'} = 'Unknown';
			# 		}
			# 		push @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, $name_caller;
			# 		$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$name_caller} = $decl_caller;

			# 		$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$name_caller} = [ [$name_caller], $caller, $name_caller, $block ]; 
			# 	}
			# 	# I think the above is wrong for the case when $name_local ne $name_caller
			# # say "2. $f $caller: LOCAL: $name_local CALLER: $name_caller " if $f eq 'ff304' and $name_local ne $name_caller;
			# }
			my $htype_local  = $decl_local->{'Type'};
			my $htype_caller = $decl_caller->{'Type'};

			if ($DBG ) {
				if ( not( $htype_local eq $htype_caller and $kind_local eq $kind_caller ) ) {    # Type / Attr mismatch
					if ( $decl_local->{'ArrayOrScalar'} eq 'Array' ) {
						$htype_local .= ', dimension(' . dim_to_str( $decl_local->{'Dim'} ) . ')';
					}
					if ( $decl_caller->{'ArrayOrScalar'} eq 'Array' ) {
						$htype_caller .= ', dimension(' . dim_to_str( $decl_caller->{'Dim'} ) . ')';
					}

					say "Type mismatch:";
					say $name_local . ' :: '
					  . $htype_local
					  . (
						$decl_local->{'Attr'}
						? '(' . $decl_local->{'Attr'} . ')'
						: ''
					  );
					say $name_caller . ' :: '
					  . $htype_caller
					  . (
						$decl_caller->{'Attr'}
						? '(' . $decl_caller->{'Attr'} . ')'
						: ''
					  );
				}
			}

			# If the attribute, i.e. the kind or length, is mismatched, we must take this into account
			# The way to do this is by multiplying the length of each variable in the sequence with KIND or LEN
			if ( $decl_local->{'ArrayOrScalar'} eq 'Scalar' and $decl_caller->{'ArrayOrScalar'} eq 'Scalar' ) {    # both Scalar so no mismatch or overlap			
			$well_aligned=1;	
				if ( $kind_local == $kind_caller ) {                                                               # Same kind
					if ( $name_local ne $name_caller ) {                                                           # Different names
							# Else no need to create an equivalence pair, just use the orginal arg name in the subroutine.
							#							say "S S ".Dumper([[$name_local,0,[],[]],[$name_caller,0,[],[]]]);
							# carp "UNCOMMENTED, PROBLEM?";
						# push @equivalence_pairs, [ [ $name_local, $type_local, 0, [], [] ], [ $name_caller, $type_caller, 0, [], [] ] ];
					}

					# If the names are the same then should it still be in ExGlobArgs? I think so
					# We must make sure the caller variable, which becomes a sig arg, has a record in ExGlobArgs
					# This is just a matter of copying, and I think even a by-ref copy is safe
					$Sf = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );

				} else {
					die "ERROR: Can't match scalars with different kinds in call to $f in $caller\n";
				}
			} elsif ( $decl_local->{'ArrayOrScalar'} eq 'Array'
				  and $decl_caller->{'ArrayOrScalar'} eq 'Array' ) {    # both Array
					# which one is the shortest? This refers to the overlapping portions
					# one of them will have a lin_idx of 1, the other can be >=1
					# We compare the total remaining linear size, e.g. if
					# local: lin_idx = 3, dim_sz = 8 then the total remaining linear size is (8-3+1)*kind
					# For the assignment, we must use the coords corresponding to lin_idx for start indices
				if ( $kind_local * ( $dimsz_local - $lin_idx_local + 1 ) == $kind_caller * ( $dimsz_caller - $lin_idx_caller + 1 ) ) {    # Arrays of identical size
				$well_aligned=1;
					my $dim_local_copy  = dclone($dim_local);
					my $dim_caller_copy = dclone($dim_caller);
					if ( $lin_idx_local != 1 ) {
						my $coords_local = calculate_multidim_indices_from_linear( $stref, $f, $dim_local, $lin_idx_local );
						for my $idx ( 0 .. scalar @{$coords_local} - 1 ) {
							$dim_local_copy->[$idx][0] = $coords_local->[$idx];
						}
					}
					if ( $lin_idx_caller != 1 ) {
						my $coords_caller = calculate_multidim_indices_from_linear( $stref, $caller, $dim_caller, $lin_idx_caller );
						for my $idx ( 0 .. scalar @{$coords_caller} - 1 ) {
							$dim_caller_copy->[$idx][0] =
							  $coords_caller->[$idx];
						}
					}
					if ( $name_local eq $name_caller ) {
						if ( $lin_idx_local != $lin_idx_caller ) {
							# If the indices don't match, but same names, then caller needs a prefix, and we need an equiv pair
							$Sf = __add_prefixed_arg( $Sf, $name_caller, $decl_caller, $caller, $block );
							push @equivalence_pairs, [ [ $name_local, $type_local, 1, $dim_local_copy, [] ], [ $name_caller, $type_caller, 1, $dim_caller_copy, $prefix ] ];
						} else {    # we use the same name for caller and local, but it means we have to add the arg to ExGlobArgs
									# But no need for an equiv pair
							$Sf = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );
						}
					} else {    # different names.
								# We must make sure the caller variable, which becomes a sig arg, has a record in ExGlobArgs
						$Sf = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );
						#						say "A A eq ".Dumper([[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]]);
						push @equivalence_pairs, [ [ $name_local, $type_local, 1, $dim_local_copy, [] ], [ $name_caller, $type_caller, 1, $dim_caller_copy, [] ] ];
					}
				} else {    # Arrays of different size		
					$well_aligned=0;
					# if they have the same name I need to prefix the caller name
					if ( $kind_local * ( $dimsz_local - $lin_idx_local + 1 ) > $kind_caller * ( $dimsz_caller - $lin_idx_caller + 1 ) ) {  # local is larger
							# so caller will be shifted entirely, local will have to be put back
							# say caller is size 4 and has local idx 1, so 4
							# local is size 10 and has local idx 3, so 8
							# then I need the points 3,4,5,6 to overlap with 1,2,3,4
							# 3+4-1
							# This is regardless of the kind differences
						my $lin_idx_local_end   = $lin_idx_local + $kind_caller * ( $dimsz_caller - $lin_idx_caller + 1 ) / $kind_local - 1;
						my $lin_idx_local_start = $lin_idx_local;

						# Now increment the index
						my $dim_local_copy   = dclone($dim_local);
						my $dim_caller_copy  = dclone($dim_caller);
						my $coords_local_end = calculate_multidim_indices_from_linear( $stref, $f, $dim_local_copy, $lin_idx_local_end );
						for my $idx ( 0 .. scalar @{$coords_local_end} - 1 ) {
							$dim_local_copy->[$idx][1] =
							  $coords_local_end->[$idx];
						}

						if ( $lin_idx_local_start != 1 ) {
							my $coords_local = calculate_multidim_indices_from_linear( $stref, $f, $dim_local_copy, $lin_idx_local_start );
							for my $idx ( 0 .. scalar @{$coords_local} - 1 ) {
								$dim_local_copy->[$idx][0] =
								  $coords_local->[$idx];
							}
						}
						if ( $lin_idx_caller != 1 ) {
							my $coords_caller = calculate_multidim_indices_from_linear( $stref, $caller, $dim_caller_copy, $lin_idx_caller );
							for my $idx ( 0 .. scalar @{$coords_caller} - 1 ) {
								$dim_caller_copy->[$idx][0] =
								  $coords_caller->[$idx];
							}
						}

						#							say "A A ne ".Dumper( [[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]]);
						if ( $name_local eq $name_caller ) {
							# In that case the SigArg should get the prefix as well							
							# croak Dumper($decl_local , $decl_caller);
							# WV2020-07-20 There is a problem here if the caller has a different size from the local
							# So I think I need to use the local, not the caller
							# $Sf = __add_prefixed_arg( $Sf, $name_local, $decl_local, $caller, $block );
							$Sf = __add_prefixed_arg( $Sf, $name_caller, $decl_caller, $caller, $block );
						} else {
							$prefix = [];							
							$Sf     = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );
						}
						push @equivalence_pairs, [ [ $name_local, $type_local, 1, $dim_local_copy, [] ], [ $name_caller, $type_caller, 1, $dim_caller_copy, $prefix ] ];

						# if the local lin index has not entirely consumed the array, we need to unshift
						$lin_idx_local += $kind_caller * ( $dimsz_caller - $lin_idx_caller + 1 ) / $kind_local;
						if ( $dimsz_local - $lin_idx_local >= 0 ) {
							$elt_local = [ $name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $lin_idx_local, $used_local ];
							unshift @common_local_seq, $elt_local;
						}
					} else { # the opposite 
						my $lin_idx_caller_end   = $lin_idx_caller + $kind_local * ( $dimsz_local - $lin_idx_local + 1 ) / $kind_caller - 1;
						my $lin_idx_caller_start = $lin_idx_caller;

						# Now increment the index
						my $dim_local_copy    = dclone($dim_local);
						my $dim_caller_copy   = dclone($dim_caller);
						my $coords_caller_end = calculate_multidim_indices_from_linear( $stref, $caller, $dim_caller_copy, $lin_idx_caller_end );
						# carp "$f CALLER $caller LOCAL NAME $name_local CALLER NAME $name_caller ;". 'dim_caller_copy (2): '
						# .Dumper($dim_caller_copy)
						# ."\n".Dumper($coords_caller_end)
						# ."\n".Dumper($dim_local_copy);
						
						for my $idx ( 0 .. scalar @{$coords_caller_end} - 1 ) {
							$dim_caller_copy->[$idx][1] =
							  $coords_caller_end->[$idx];
						}
						if ( $lin_idx_local != 1 ) {
							my $coords_local = calculate_multidim_indices_from_linear( $stref, $f, $dim_local_copy, $lin_idx_local );
							for my $idx ( 0 .. scalar @{$coords_local} - 1 ) {
								$dim_local_copy->[$idx][0] =
								  $coords_local->[$idx];
							}
						}
						if ( $lin_idx_caller_start != 1 ) {
							# carp "SOMETHING IS WRONG HERE $f CALLER $caller LOCAL NAME $name_local CALLER NAME $name_caller ;".Dumper($dim_caller_copy).';'. $lin_idx_caller_start;
							my $coords_caller = calculate_multidim_indices_from_linear( $stref, $caller, $dim_caller_copy, $lin_idx_caller_start );
							# carp "\n".Dumper($coords_caller);
							for my $idx ( 0 .. scalar @{$coords_caller} - 1 ) {
								$dim_caller_copy->[$idx][0] =
								  $coords_caller->[$idx];
							}
						}

						#							say "A A ne 2 ".Dumper([[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]] );
						if ( $name_local eq $name_caller ) {
							# In that case the SigArg should get the prefix as well
							$Sf = __add_prefixed_arg( $Sf, $name_caller, $decl_caller, $caller, $block );
						} else {
							$prefix = [];
							# carp  "$f $name_caller";
							$Sf     = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );
						}
						push @equivalence_pairs, [ [ $name_local, $type_local, 1, $dim_local_copy, [] ], [ $name_caller, $type_caller, 1, $dim_caller_copy, $prefix ] ];

						# e.g. local was 4, caller idx was 3 -> new caller idx is 7 unless the caller array is only 6 long
						# if the caller was 6 long, we get 6-7 >= 1-1 => -1 >= 0 ? FALSE!
						# if the caller was 7 long, we get 7-7 >= 1-1 => 0 >= 0 ? TRUE!
						# if the caller was 8 long, we get 7-7 >= 1-1 => 1 >= 0 ? TRUE!
						$lin_idx_caller += $kind_local * ( $dimsz_local - $lin_idx_local + 1 ) / $kind_caller;
						if ( $dimsz_caller - $lin_idx_caller >= 0 ) {
							$elt_caller = [ $name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $lin_idx_caller, $used_caller ];
							unshift @common_caller_seq, $elt_caller;
						}
					}
				} # arrays of different size
			} elsif ( $decl_local->{'ArrayOrScalar'} eq 'Scalar'
				and $decl_caller->{'ArrayOrScalar'} eq 'Array' )
			{    # local is Scalar, caller is Array
				$well_aligned=0;
				if ( $kind_local == $kind_caller ) { 

					# increment dim
					my $lin_idx_caller_start = $lin_idx_caller;
					my $lin_idx_caller_end   = $lin_idx_caller_start;
					my $coords_start         = calculate_multidim_indices_from_linear( $stref, $caller, $dim_caller, $lin_idx_caller_start );
					my $coords_end           = calculate_multidim_indices_from_linear( $stref, $caller, $dim_caller, $lin_idx_caller_end );
					my $dim_caller_copy      = dclone($dim_caller);
					for my $idx ( 0 .. scalar @{$coords_start} - 1 ) {
						$dim_caller_copy->[$idx][0] = $coords_start->[0];
						$dim_caller_copy->[$idx][1] = $coords_end->[0];
					}

					if ( $name_local eq $name_caller ) {
						# In that case the SigArg should get the prefix as well
						$Sf = __add_prefixed_arg( $Sf, $name_caller, $decl_caller, $caller, $block );
					} else {
						$prefix = [];
						$Sf     = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );
					}
					push @equivalence_pairs, [ [ $name_local, $type_local, 0, [], [] ], [ $name_caller, $type_caller, 1, $dim_caller_copy, $prefix ] ];

					# increment lin idx. But if the lin idx is already the dimsz, we should not do this, as it means we're at the last element.
					# e.g. if the caller idx is 3 and the caller array is 4, then 4-3 = 1 > 0
					$lin_idx_caller += $kind_local / $kind_caller;    # currently this of course just means +=1
					# say $kind_local / $kind_caller;
					# $lin_idx_caller += $kind_local * ( $dimsz_local - $lin_idx_local + 1 ) / $kind_caller;
					# croak "$name_caller $dimsz_caller - $lin_idx_caller ". @common_local_seq; 
					if ( $dimsz_caller - $lin_idx_caller >= 0) {
						$elt_caller = [ $name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $lin_idx_caller, $used_caller ];
						unshift @common_caller_seq, $elt_caller;
					}
				} else {
					die "ERROR: Can't match a scalar to an array with different kinds in call to $f in $caller\n";
				}
			} elsif ( $decl_local->{'ArrayOrScalar'} eq 'Array'
				and $decl_caller->{'ArrayOrScalar'} eq 'Scalar' ) {
					# local is Array, caller is Scalar
					$well_aligned=0;
				if ( $kind_local == $kind_caller ) {
					my $lin_idx_local_start = $lin_idx_local;
					my $lin_idx_local_end   = $lin_idx_local_start;
					my $coords_start        = calculate_multidim_indices_from_linear( $stref, $f, $dim_local, $lin_idx_local_start );
					my $coords_end          = calculate_multidim_indices_from_linear( $stref, $f, $dim_local, $lin_idx_local_end );
					my $dim_local_copy      = dclone($dim_local);
					for my $idx ( 0 .. scalar @{$coords_start} - 1 ) {
						$dim_local_copy->[$idx][0] = $coords_start->[0];
						$dim_local_copy->[$idx][1] = $coords_end->[0];
					}
					if ( $name_local eq $name_caller ) {

						# In that case the SigArg should get the prefix as well
						$Sf = __add_prefixed_arg( $Sf, $name_caller, $decl_caller, $caller, $block );
					} else {
						$prefix = [];
						$Sf     = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );
					}

					#						say "A S ".Dumper([[$name_local,1,$dim_local_copy,[]],[$name_caller,0,[],$prefix]] );
					push @equivalence_pairs, [ [ $name_local, $type_local, 1, $dim_local_copy, [] ], [ $name_caller, $type_caller, 0, [], $prefix ] ];

					# increment lin idx. But if the lin idx is already the dimsz, we should not do this, as it means we're at the last element.
					$lin_idx_local += $kind_caller / $kind_local;    # works if the are dividable
					if ( $dimsz_local - $lin_idx_local >= 0 ) {      # 15-14>0 => unshift it
						$elt_local = [ $name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $lin_idx_local, $used_local ];

						unshift @common_local_seq, $elt_local;
					}
				} else {
					die "ERROR: Can't match a scalar to an array with different kinds in call to $f in $caller\n";
				}
			}

			# Used to be at 322
			if ( $used_caller == 0 ) {
				$used_caller = 1;
				# For the first arg, well-aligned is always true. Maybe we need to put this right at the end!
				if ($well_aligned)	 {
					push @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, $name_local;
					$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$name_local} = $decl_local;
					$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$name_local} = [ [$name_caller], $caller,$name_local, $block ];

				} else {
					# say "HERE, OK! $name_local $name_caller";

					if ( not exists $decl_caller->{'IODir'} ) {
						$decl_caller->{'IODir'} = 'Unknown';
					}
					if (
						scalar @{$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'}} == 0 or
						 $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'}[-1] ne $name_caller
					){
						push @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, $name_caller ;
					}
					$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$name_caller} = $decl_caller;

					$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$name_caller} = [ [$name_caller], $caller, $name_caller, $block ]; 
				}
				# I think the above is wrong for the case when $name_local ne $name_caller
				# }
			# say "2. $f $caller: LOCAL: $name_local CALLER: $name_caller " if $f eq 'ff304' and $name_local ne $name_caller;
			}
		} else {    # The local seq is longer than the caller seq
			# It can be that the local seq contains an elt that was already partially matched to the last caller elt.
			# this means that $name_local is already matched;  but we still need to add it to call args
			if ( $used_local == 0 ) {
				$used_local = 1;

				#                	say "USING LOCAL AS CALLER";
				push @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, $name_local;
				if ( not exists $decl_local->{'IODir'} ) {
					$decl_local->{'IODir'} = 'Unknown';
				}
				$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$name_local} = $decl_local;
				$Sf = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_local, $decl_local );
				
			}
			# say "3. $f $caller: LOCAL: $name_local CALLER: $name_local to be added " if $f eq 'ff304' ;

			# but in any case, the name must be added to the call args
			$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$name_local} = [ [$name_local], $f,$name_local, $block ];

			# Either way, the local will have been consumed and there is no caller, so no unshifting
		}
	} # loop to consume the local sequence

	# say 'TYPE:'.$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{'w4'}{'Type'};

	if ( scalar @equivalence_pairs > 0 ) {
		my @arg_assignment_lines = map {
			my $pair = $_;
			# carp 'ADD RESHAPE HERE: '.Dumper($pair);
			# This goes wrong when both elts of the pair are Scalar but also when one is a scalar and the other an array of size 1
			# In both cases there is no need for a reshape. 
			@{__reshape_rhs_if_required($pair, $stref, $f )}; 
		} @equivalence_pairs;
		if ( not exists $Sf->{'ExMismatchedCommonArgs'}{'ArgAssignmentLines'} ) {
			$Sf->{'ExMismatchedCommonArgs'}{'ArgAssignmentLines'} = \@arg_assignment_lines;
		} else {
			$Sf->{'ExMismatchedCommonArgs'}{'ArgAssignmentLines'} =
			  [ @{ $Sf->{'ExMismatchedCommonArgs'}{'ArgAssignmentLines'} }, @arg_assignment_lines ];
		}
		
		my @arg_rev_assignment_lines = map {
			my $pair = $_;
			@{ _caller_to_rev_local_assignment_annlines($pair) };
		} @equivalence_pairs;

		if ( not exists $Sf->{'ExMismatchedCommonArgs'}{'ArgRevAssignmentLines'} ) {
			$Sf->{'ExMismatchedCommonArgs'}{'ArgRevAssignmentLines'} = \@arg_rev_assignment_lines;
		} else {
			$Sf->{'ExMismatchedCommonArgs'}{'ArgRevAssignmentLines'} =
			  [ @{ $Sf->{'ExMismatchedCommonArgs'}{'ArgRevAssignmentLines'} }, @arg_rev_assignment_lines ];
		}		
		
	}

	return $stref;
}    # END of _match_up_common_var_sequences

sub __emit_equiv_var_str {
	( my $tup ) = @_;
	( my $var, my $type, my $is_array, my $m_dim, my $m_prefix ) = @{$tup};
	my $prefix_str = scalar @{$m_prefix} ? join( '_', @{$m_prefix} ) . '_' : '';
	if ($is_array) {
		return $prefix_str . $var . '(' . join( ',', map { $_->[0] ne $_->[1] ? $_->[0] . ':' . $_->[1] : $_->[0] } @{$m_dim} ) . ')';
	} else {
		return $prefix_str . $var;
	}
} # END of __emit_equiv_var_str

# Reshape works on an array or perhaps on a slice. 
# I am not sure how it works with casts
# I will apply this to the finished strings of the assignment
# 
sub __reshape_rhs_if_required { my ($pair, $stref, $f ) = @_; 
	 my $tup_lhs = $pair->[0];
	( my $var1, my $type1, my $is_array1, my $m_dim1, my $m_prefix1 ) = @{$tup_lhs};
	my $tup_rhs = $pair->[1];
	( my $var2, my $type2, my $is_array2, my $m_dim2, my $m_prefix2 ) = @{$tup_rhs};

	my $l        = $tup_lhs;
	my $l_str    = __emit_equiv_var_str($l);
	my $r        = $tup_rhs;
	my $r_str    = __emit_equiv_var_str($r);
	my $annlines = _cast_annlines( $l->[1], $l_str, $r->[1], $r_str );
	# say "$l_str = $r_str OK?";

	if ($is_array1 and $is_array2) {

		my ($size1, $not_const1) = calculate_array_size( $stref, $f, $m_dim1 );
		my ($size2, $not_const2) = calculate_array_size( $stref, $f, $m_dim2 );

		# but the rank we need is the rank of the expression
		# FIXME: I will assume that if the array is indexed, all indices are used, i.e. rank is 0
		my $rank1 =  get_array_rank($m_dim1) ;
		my $rank2 =  get_array_rank($m_dim2) ;

		if ( $size1 == $size2 and $rank1 == $rank2 ) {
			return $annlines;
		}
		# if the same rank and different size
		if ( $size1 == $size2 and $rank1 != $rank2 ) {

			# if different rank and same size
			# reshape			
			if (scalar @{$annlines} == 1) {
			my ($line,$info) = @{$annlines->[0]};
			my $indent = ' ' x 6 ;
			return [
				["$indent$l_str = reshape($r_str,shape($l_str))" , $info]
			];

			} else {
				carp 'MUST RESHAPE BUT CANNOT!' if $DBG;;
			}
		}	
	}
	# return [['',{}]];
	return $annlines;
} # END of __reshape_rhs_if_required


# These are the reverse assignements on exiting the subroutine
sub _caller_to_rev_local_assignment_annlines {
	( my $equiv_pair ) = @_;

	my $l        = $equiv_pair->[0];
	my $l_str    = __emit_equiv_var_str($l);
	my $r        = $equiv_pair->[1];
	my $r_str    = __emit_equiv_var_str($r);
	my $annlines = _cast_annlines(  $r->[1], $r_str, $l->[1], $l_str );

	# Adding the Indent
	my $indent = ' ' x 6;
	$annlines = [ map { [ $indent . $_->[0], $_->[1] ] } @{$annlines} ];
	return $annlines;
} # END of _caller_to_rev_local_assignment_annlines


sub __add_prefixed_arg {
	( my $Sf, my $name_caller, my $decl_caller, my $caller, my $block ) = @_;
	my $prefix               = $block eq 'BLANK' ? [$caller] : [ $caller, $block ];
	my $prefixed_name_caller = join( '_', ( @{$prefix}, $name_caller ) );
	$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'}[-1] = $prefixed_name_caller;
	my $prefixed_name_caller_decl = dclone($decl_caller);
	$prefixed_name_caller_decl->{'Name'}     = $prefixed_name_caller;
	$prefixed_name_caller_decl->{'OrigName'} = $name_caller;
	$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$prefixed_name_caller} =
	  $prefixed_name_caller_decl;
	$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$prefixed_name_caller} = [ [$name_caller], $caller, $prefixed_name_caller, $block ];
	$Sf = add_var_decl_to_set( $Sf, 'ExGlobArgs', $prefixed_name_caller, $prefixed_name_caller_decl );
	$Sf = remove_var_decl_from_set( $Sf, 'ExGlobArgs', $name_caller);
	return $Sf;
}    # END of __add_prefixed_arg


# This is for Parser, so the result should a list of var names.
# It is only used in Parser
sub collect_common_vars_per_block {
	my ( $stref, $f, $common_decl_str_ ) = @_;
	my $Sf              = $stref->{'Subroutines'}{$f};
	my %common_blocks   = %{ $Sf->{'CommonBlocks'} };
	my $common_decl_str = $common_decl_str_;
	$common_decl_str =~ s/common\s*//;
	$common_decl_str =~ s/\s+$//;

	if ( $common_decl_str !~ /^\// ) {
		$common_decl_str = 'BLANK/' . $common_decl_str;
	} else {
		$common_decl_str =~ s/^\/\s*//;
		if ( $common_decl_str =~ /^\s*\// ) {
			$common_decl_str = 'BLANK' . $common_decl_str;
		}
	}

	my @common_chunks = split( /\s*\/\s*/, $common_decl_str );

	while (@common_chunks) {

		my $common_block_name = shift @common_chunks;

		if ( not exists $common_blocks{$common_block_name} ) {
			$common_blocks{$common_block_name} = [];
		}
		my $common_vars_str = shift @common_chunks;
		$common_vars_str =~ s/,\s*$//;
		
		my ($ast, $rest, $err, $has_funcs) = parse_expression_no_context($common_vars_str);
		
		my @common_vars=();
		if ($ast->[0] == 27) {
			for my $idx (1 .. scalar @{$ast}-1) {
				if ($ast->[$idx][0] == 1 or $ast->[$idx][0] == 2 or $ast->[$idx][0] == 10) {
					push @common_vars, $ast->[$idx][1];
				}
			}
		} elsif ($ast->[0] == 1 or $ast->[0] == 2 or $ast->[0] == 10) {
				push @common_vars, $ast->[1];			
		}
		 
		$common_blocks{$common_block_name} =
		  [ @{ $common_blocks{$common_block_name} }, @common_vars ];
	}

	$Sf->{'CommonBlocks'} = {%common_blocks};
	return $stref;
}    # END of collect_common_vars_per_block


1;

