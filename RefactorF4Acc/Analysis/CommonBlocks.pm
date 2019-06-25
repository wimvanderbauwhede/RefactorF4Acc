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
use RefactorF4Acc::ExpressionAST::Evaluate qw( eval_expression_with_parameters );
use RefactorF4Acc::Utils qw( in_nested_set add_var_decl_to_set remove_var_decl_from_set pp_annlines );

use RefactorF4Acc::Parser::Expressions qw( parse_expression_no_context );
use RefactorF4Acc::Analysis::Arguments qw( create_RefactoredArgs );

use vars qw( $VERSION );
$VERSION = "1.2.0";

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
    $stref = identify_common_var_mismatch($stref,$f);
#    say Dumper($stref->{'Subroutines'}{$f}{'CommonVarMismatch'});
	}
	
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if $f eq '';			
		next  if $f eq 'UNKNOWN_SRC';
		next unless exists $stref->{'Subroutines'}{$f}{'HasLocalCommons'};
		create_common_var_size_tuples( $stref, $f );
	}
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {		
		next if $f eq '';			
		next  if $f eq 'UNKNOWN_SRC';
		next unless exists $stref->{'Subroutines'}{$f}{'HasLocalCommons'};
		match_up_common_vars( $stref, $f );
		next unless exists $stref->{'Subroutines'}{$f}{'HasCommonVarMismatch'};
		$stref = create_RefactoredArgs( $stref, $f );
	}
		
	return $stref;
	} # END of analyse_common_blocks


# This is for Parser, so the result should a list of var names
#
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
		 
#		my $args_vars = find_vars_in_ast($ast);
		
#		$common_vars_str =~ s/,\s*$//;
#		my @common_vars_strs = split( /\s*,\s*/, $common_vars_str );
#
#		 my @common_vars_OLD = grep { !/\)$/ }
#		  map { my $str = $_; $str =~ s/\(.+$//; $str } @common_vars_strs;
		$common_blocks{$common_block_name} =
		  [ @{ $common_blocks{$common_block_name} }, @common_vars ];
	}

	$Sf->{'CommonBlocks'} = {%common_blocks};
	return $stref;
}    # END of collect_common_vars_per_block

=pod
We need to identify if there is CommonVarMismatch or not

Given the two lists of common vars, one (the CalledSub one) needs to be a strict subset of the other (CallerSub). And all vars must be the same type and dimension, just the names is not good enough.

If it's the other way round, CallerSub strict subset of CalledSub, then we need to declare the extra vars in the Caller.
=cut

# For every subroutine, see if there is a mismatch with any of the callers.
sub identify_common_var_mismatch {
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
					say "BLOCK $block in $f has CommonVarMismatch with $caller"
					  if $DBG;
					$Sf->{'HasCommonVarMismatch'} = 1;
				} else {
					say "BLOCK $block in $f is matched with $caller: " . join( ',', @{ $Sf->{'CommonBlocks'}{$block} } ) if $DBG;
					$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} =
					  [ @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, @{ $Sf->{'CommonBlocks'}{$block} } ];

					map { $Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$_} = [ $_, $caller, $block ]; } @{ $Sf->{'CommonBlocks'}{$block} };
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
}    # END of identify_common_var_mismatch

sub _compare_decls {
	my ( $stref, $f1, $f2, $decl1, $decl2, $compare_names ) = @_;

	my $names_match = $decl1->{'Name'} eq $decl2->{'Name'};
	return 0 unless ( !$compare_names or $names_match );
	my $types_match = $decl1->{'Type'} eq $decl2->{'Type'};
	return 0 unless $types_match;
	if (   $decl1->{'Attr'} =~ /=/ and $decl2->{'Attr'} !~ /=/
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

		#		say Dumper($dim1,$dim2);
		my $size1 = __calc_sz( $stref, $f1, $dim1 );
		my $size2 = __calc_sz( $stref, $f2, $dim2 );
		my $dims_match = $size1 == $size2;
		return 0 unless $dims_match;
	}
	return 1;
}    # END of _compare_decls

sub __calc_sz {
	my ( $stref, $f, $dim ) = @_;
	my @sz_strs = ();
	for my $entry ( @{$dim} ) {
		my $sz_str = '((' . $entry->[1] . ') - (' . $entry->[0] . ')+1)';
		push @sz_strs, $sz_str;
	}
	my $tot_sz_str = join( '*', @sz_strs );

	#	say $tot_sz_str ;
	my $size = eval_expression_with_parameters( $tot_sz_str, {}, $stref, $f );

	#	say $size;
	return $size;
}    # END of __calc_sz

# Annotate the var with most of the declaration, mostly for type checking while lining up
sub create_common_var_size_tuples {

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
				$dimsz = __calc_sz( $stref, $f, $dim ),;
			}
			my $type        = $called_sub_common_var_decl->{'Type'};
			my $kind_or_len = $type eq 'character' ? 1 : 4;            # default
			if ( $called_sub_common_var_decl->{'Attr'} =~ /\*/ ) {
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
				$called_sub_common_var,         # :: VarName
				$called_sub_common_var_decl,    # VarDeclRec
				$kind_or_len,                   # :: AttrVal
				$dim,                           # :: Dim
				$dimsz,                         # linear size
				1,                              # linear index, starting at 1
				0                               # :: UsedBefore
			];
		} @called_sub_common_vars;
		$Sf->{'CommonBlockSequences'}{$block} = [@common_var_size_tuples];
	}

	return $stref;
}    # END of create_common_var_size_tuples

sub match_up_common_vars {
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
	
#	croak Dumper($Sf->{'ExMismatchedCommonArgs'}) if $f eq 'ff304';
	return $stref;
}    # END of match_up_common_vars

# We create assignments local_var = caller_var
# and if the intent is also Out, also caller_var = local_var before exiting the subroutine.
# This means before either a return or falling off the end
# For arrays, it means we need to provide an array slice of the size of the smalles one to make it work, e.g. ral1 = ra1(2:4)

sub _match_up_common_var_sequences {
	my ( $stref, $f, $caller, $block ) = @_;

	#	say "MATCHING UP BLOCK $block for $f and $caller";
	my $Sf               = $stref->{'Subroutines'}{$f};
	my @common_local_seq = @{ $Sf->{'CommonBlockSequences'}{$block} };
	my @common_caller_seq =
	  @{ $stref->{'Subroutines'}{$caller}{'CommonBlockSequences'}{$block} };

	# @equivalence_pairs ::  [(VarName,Type,ArrayOrScalar,Dim,PrefixStr, TypeDeclRec)]
	my @equivalence_pairs = ();
	while ( scalar @common_local_seq > 0 ) {    # keep going until the local sequence is consumed
		my $elt_local = shift @common_local_seq;

		my ( $name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $lin_idx_local, $used_local ) = @{$elt_local};
		my $type_local = $decl_local->{'Type'};

		#		say "LOCAL: $name_local";
		if (@common_caller_seq) {

			my $elt_caller = shift @common_caller_seq;
			my ( $name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $lin_idx_caller, $used_caller ) = @{$elt_caller};
			my $type_caller = $decl_caller->{'Type'};

			#			say "CALLER: $name_caller";

			# add this caller to ExMismatchedCommonArgs
			my $prefix = $block eq 'BLANK' ? [$caller] : [ $caller, $block ];
			if ( $used_caller == 0 ) {
				$used_caller = 1;
				push @{ $Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'List'} }, $name_caller;
				$Sf->{'ExMismatchedCommonArgs'}{'SigArgs'}{'Set'}{$name_caller} = $decl_caller;
				if ( not exists $decl_caller->{'IODir'} ) {
					$decl_caller->{'IODir'} = 'Unknown';
				}
				$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$name_caller} = [ $name_caller, $caller, $block ];
			}
			my $htype_local  = $decl_local->{'Type'};
			my $htype_caller = $decl_caller->{'Type'};

			if ($DBG) {
				if ( not( $htype_local eq $htype_caller and $kind_local eq $kind_caller ) ) {    # Type / Attr mismatch
					if ( $decl_local->{'ArrayOrScalar'} eq 'Array' ) {
						$htype_local .= ', dimension(' . __dim_to_str( $decl_local->{'Dim'} ) . ')';
					}
					if ( $decl_caller->{'ArrayOrScalar'} eq 'Array' ) {
						$htype_caller .= ', dimension(' . __dim_to_str( $decl_caller->{'Dim'} ) . ')';
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
			if ( $decl_local->{'ArrayOrScalar'} eq 'Scalar' and $decl_caller->{'ArrayOrScalar'} eq 'Scalar' ) {    # both Scalar
			
				if ( $kind_local == $kind_caller ) {                                                               # Same kind
					if ( $name_local ne $name_caller ) {                                                           # Different names
							# Else no need to create an equivalence pair, just use the orginal arg name in the subroutine.
							#							say "S S ".Dumper([[$name_local,0,[],[]],[$name_caller,0,[],[]]]);
						push @equivalence_pairs, [ [ $name_local, $type_local, 0, [], [] ], [ $name_caller, $type_caller, 0, [], [] ] ];
					}

					# If the names are the same then should it still be in ExGlobArgs? I think so
					# We must make sure the caller variable, which becomes a sig arg, has a record in ExGlobArgs
					# This is just a matter of copying, and I think even a by-ref copy is safe
					$Sf = add_var_decl_to_set( $Sf, 'ExGlobArgs', $name_caller, $decl_caller );

				} else {
					croak "Can't match scalars with different kinds: ";
				}
			} elsif ( $decl_local->{'ArrayOrScalar'} eq 'Array'
				  and $decl_caller->{'ArrayOrScalar'} eq 'Array' ) {    # both Array
					# which one is the shortest? This refers the overlapping portions
					# one of them will have a lin_idx of 1, the other can be >=1
					# We compare the total remaining linear size, e.g. if
					# local: lin_idx = 3, dim_sz = 8 then the total remaining linear size is (8-3+1)*kind
					# For the assignment, we must use the coords corresponding to lin_idx for start indices
				if ( $kind_local * ( $dimsz_local - $lin_idx_local + 1 ) == $kind_caller * ( $dimsz_caller - $lin_idx_caller + 1 ) ) {    # Arrays of identical size
					my $dim_local_copy  = dclone($dim_local);
					my $dim_caller_copy = dclone($dim_caller);
					if ( $lin_idx_local != 1 ) {
						my $coords_local = _calc_coords( $stref, $f, $dim_local, $lin_idx_local );
						for my $idx ( 0 .. scalar @{$coords_local} - 1 ) {
							$dim_local_copy->[$idx][0] = $coords_local->[$idx];
						}
					}
					if ( $lin_idx_caller != 1 ) {
						my $coords_caller = _calc_coords( $stref, $caller, $dim_caller, $lin_idx_caller );
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
						my $coords_local_end = _calc_coords( $stref, $f, $dim_local_copy, $lin_idx_local_end );
						for my $idx ( 0 .. scalar @{$coords_local_end} - 1 ) {
							$dim_local_copy->[$idx][1] =
							  $coords_local_end->[$idx];
						}

						if ( $lin_idx_local_start != 1 ) {
							my $coords_local = _calc_coords( $stref, $f, $dim_local_copy, $lin_idx_local_start );
							for my $idx ( 0 .. scalar @{$coords_local} - 1 ) {
								$dim_local_copy->[$idx][0] =
								  $coords_local->[$idx];
							}
						}
						if ( $lin_idx_caller != 1 ) {
							my $coords_caller = _calc_coords( $stref, $caller, $dim_caller_copy, $lin_idx_caller );
							for my $idx ( 0 .. scalar @{$coords_caller} - 1 ) {
								$dim_caller_copy->[$idx][0] =
								  $coords_caller->[$idx];
							}
						}

						#							say "A A ne ".Dumper( [[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]]);
						if ( $name_local eq $name_caller ) {
							# In that case the SigArg should get the prefix as well
							
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
					} else {
						my $lin_idx_caller_end   = $lin_idx_caller + $kind_local * ( $dimsz_local - $lin_idx_local + 1 ) / $kind_caller - 1;
						my $lin_idx_caller_start = $lin_idx_caller;

						# Now increment the index
						my $dim_local_copy    = dclone($dim_local);
						my $dim_caller_copy   = dclone($dim_caller);
						my $coords_caller_end = _calc_coords( $stref, $f, $dim_caller_copy, $lin_idx_caller_end );
						for my $idx ( 0 .. scalar @{$coords_caller_end} - 1 ) {
							$dim_caller_copy->[$idx][1] =
							  $coords_caller_end->[$idx];
						}
						if ( $lin_idx_local != 1 ) {
							my $coords_local = _calc_coords( $stref, $f, $dim_local_copy, $lin_idx_local );
							for my $idx ( 0 .. scalar @{$coords_local} - 1 ) {
								$dim_local_copy->[$idx][0] =
								  $coords_local->[$idx];
							}
						}
						if ( $lin_idx_caller_start != 1 ) {
							my $coords_caller = _calc_coords( $stref, $caller, $dim_caller_copy, $lin_idx_caller_start );
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
				}
			} elsif ( $decl_local->{'ArrayOrScalar'} eq 'Scalar'
				and $decl_caller->{'ArrayOrScalar'} eq 'Array' )
			{    # local is Scalar, caller is Array
				if ( $kind_local == $kind_caller ) {

					# increment dim
					# We support a scalar with a larger kind, simply by having
					my $lin_idx_caller_start = $lin_idx_caller;
					my $lin_idx_caller_end   = $lin_idx_caller_start + $kind_caller / $kind_local - 1;                # so, usually this is 0
					my $coords_start         = _calc_coords( $stref, $caller, $dim_caller, $lin_idx_caller_start );
					my $coords_end           = _calc_coords( $stref, $caller, $dim_caller, $lin_idx_caller_end );
					my $dim_caller_copy      = dclone($dim_caller);
					for my $idx ( 0 .. scalar @{$coords_start} - 1 ) {
						$dim_caller_copy->[$idx][0] = $coords_start->[0];
						$dim_caller_copy->[$idx][1] = $coords_end->[0];
					}

					#						say "S A ".Dumper([[$name_local,0,[],[]],[$name_caller,1,$dim_caller_copy,$prefix]] );
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
					if ( $dimsz_caller - $lin_idx_caller >= 0 ) {
						$elt_caller = [ $name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $lin_idx_caller, $used_caller ];
						unshift @common_caller_seq, $elt_caller;
					}
				} else {
					croak "Can't match a scalar to an array with different kinds!";
				}
			} elsif ( $decl_local->{'ArrayOrScalar'} eq 'Array'
				and $decl_caller->{'ArrayOrScalar'} eq 'Scalar' ) {
					# local is Array, caller is Scalar
				if ( $kind_local == $kind_caller ) {
					my $lin_idx_local_start = $lin_idx_local;
					my $lin_idx_local_end   = $lin_idx_local_start + $kind_local / $kind_caller - 1;          # so, usually this is 0
					my $coords_start        = _calc_coords( $stref, $f, $dim_local, $lin_idx_local_start );
					my $coords_end          = _calc_coords( $stref, $f, $dim_local, $lin_idx_local_end );
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
					croak "Can't match a scalar to an array with different kinds!";
				}
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

			# but in any case, the name must be added to the call args
			$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$name_local} =
			  [ $name_local, $f, $block ];

			# Either way, the local will have been consumed and there is no caller, so no unshifting
		}

	}

	if ( scalar @equivalence_pairs > 0 ) {
		my @arg_assignment_lines = map {
			my $pair = $_;
			@{ _caller_to_local_assignment_annlines($pair) };
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

#sub __get_total_size { my @common_seq = @_;
#	my $total_sz=0;
#	for my $elt (@common_seq) {
#		$total_sz+=$elt->[2]*$elt->[5];
#	}
#	return $total_sz;
#}
# annotate with prefix

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

sub _caller_to_local_assignment_annlines {
	( my $equiv_pair ) = @_;

	my $l        = $equiv_pair->[0];
	my $l_str    = __emit_equiv_var_str($l);
	my $r        = $equiv_pair->[1];
	my $r_str    = __emit_equiv_var_str($r);
	my $annlines = _cast_annlines( $l->[1], $l_str, $r->[1], $r_str );

	# Adding the Indent
	my $indent = ' ' x 6;
	$annlines = [ map { [ $indent . $_, {} ] } @{$annlines} ];
	return $annlines;
} # END of _caller_to_local_assignment_annlines

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
	$annlines = [ map { [ $indent . $_, {} ] } @{$annlines} ];
	return $annlines;
} # END of _caller_to_rev_local_assignment_annlines

# Casting between types but this does assume essentially kind=4
sub _cast_annlines {
	my ( $to_type, $to_var, $from_type, $from_var ) = @_;
	if ( $from_type eq $to_type ) {
		return ["$to_var = $from_var"];    #,{"Assignment"=>1,'Indent'=>' ' x 6}]];
	} elsif ( $from_type eq 'integer' ) {
		if ( $to_type eq 'logical' ) {
			return __cast_integer_to_logical_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'real' ) {
			return __cast_integer_to_real_annlines( $from_var, $to_var );
		}
	} elsif ( $from_type eq 'real' ) {
		if ( $to_type eq 'logical' ) {
			return __cast_real_to_logical_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'integer' ) {
			return __cast_real_to_integer_annlines( $from_var, $to_var );
		}
	} elsif ( $from_type eq 'logical' ) {
		if ( $to_type eq 'real' ) {
			return __cast_logical_to_real_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'integer' ) {
			return __cast_logical_to_integer_annlines( $from_var, $to_var );
		}
	}
} # END of _cast_annlines

sub __cast_logical_to_integer_annlines {
	( my $v_logical, my $v_integer ) = @_;

	return [
		"if ($v_logical) then",
		"    $v_integer=1",
		'else',                #{'Else'=>1, 'Indent'=>' ' x 6}],
		"    $v_integer=0",    #{'Assignment' => 1, 'Indent'=>' ' x 6}],
		'end if'               #,{'EndIf'=>1, 'Indent'=>' ' x 6}]
	];
} # END of __cast_logical_to_integer_annlines

sub __cast_logical_to_real_annlines {
	( my $v_logical, my $v_real ) = @_;

	return [
		"if ($v_logical) then",    #{'If'=>1, 'Indent'=>' ' x 6 }],
		"    $v_real=1.0",         # {'Assignment' => 1, 'Indent'=>' ' x 6}],
		'else',                    #{'Else'=>1, 'Indent'=>' ' x 6}],
		"    $v_real=0.0",         #{'Assignment' => 1, 'Indent'=>' ' x 6}],
		'end if'                   #,{'EndIf'=>1, 'Indent'=>' ' x 6}]
	];
}

sub __cast_integer_to_logical_annlines {
	( my $v_integer, my $v_logical ) = @_;
	return ["$v_logical = ($v_integer /= 0)"];    #,{"Assignment"=>1,'Indent'=>' ' x 6}]];
}

sub __cast_integer_to_real_annlines {
	( my $v_real, my $v_integer ) = @_;
	return ["$v_real = real($v_integer)"];        #,{'Assignment'=>1,'Indent'=>' ' x 6}]];
}

sub __cast_real_to_logical_annlines {
	( my $v_real, my $v_logical ) = @_;
	return ["$v_logical = ($v_real /= 0.0)"];     #,{"Assignment"=>1,'Indent'=>' ' x 6}]];
}

sub __cast_real_to_integer_annlines {
	( my $v_real, my $v_integer ) = @_;
	return ["$v_integer = int($v_real)"];         #,{'Assignment'=>1,'Indent'=>' ' x 6}]];
}

# Given the linear index (starting at 1) in an array
# and its dimensions and offsets
# return the n-dim coordinate for that index
sub _calc_coords {
	my ( $stref, $f, $dim_rec, $lin_sz ) = @_;

	#            integer, intent(In) :: lin_sz, n_dims
	#            integer, dimension(n_dims),intent(In) :: dims, offsets
	#            integer, dimension(n_dims), intent(Out) :: coords
	#            integer, dimension(n_dims-1) :: mm
	#            integer :: ii, jj, p_dims, sz
	( my $dims, my $offsets ) = __calc_dims_offsets( $stref, $f, $dim_rec );
	my $coords   = [];
	my $sz       = $lin_sz;
	my @tmp_dims = @{$dims};
	my $n_dims   = scalar @tmp_dims;
	my $p_dims   = 1;
	map { $p_dims *= $_ } @tmp_dims;

	for my $ii ( 1 .. $n_dims - 1 ) {
		my $div_dim = shift @tmp_dims;
		$p_dims /= $div_dim;
		$coords->[ $ii - 1 ] = int( $sz / $p_dims ) + $offsets->[ $ii - 1 ];
		$sz %= $p_dims;
	}
	$coords->[ $n_dims - 1 ] = $sz + $offsets->[ $n_dims - 1 ] - 1;    # The "-1" is because $lin_sz starts at 1 for the first element, not 0
	return $coords;
}    # END of _calc_coords

# $dims is an array of the sizes of each dimension
# $offsets is an array of the offsets each dimension
sub __calc_dims_offsets {
	my ( $stref, $f, $dim_rec ) = @_;
	my $offsets = [];
	my $dims    = [];
	my @sz_strs = ();
	for my $entry ( @{$dim_rec} ) {
		my $offset_val =
		  eval_expression_with_parameters( $entry->[0], {}, $stref, $f );
		push @{$offsets}, $offset_val;
		my $dim_str = '((' . $entry->[1] . ') - (' . $entry->[0] . ')+1)';
		my $dim_val = eval_expression_with_parameters( $dim_str, {}, $stref, $f );
		push @{$dims}, $dim_val;
	}
	return ( $dims, $offsets );
}    # END of __calc_dims_offsets

sub __dim_to_str {
	( my $dim ) = @_;
	return join( ',', map { $_->[0] . ':' . $_->[1] } @{$dim} );
}

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
	$Sf->{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$prefixed_name_caller} =
	  [ $name_caller, $caller, $block ];
	$Sf = add_var_decl_to_set( $Sf, 'ExGlobArgs', $prefixed_name_caller, $prefixed_name_caller_decl );
	$Sf = remove_var_decl_from_set( $Sf, 'ExGlobArgs', $name_caller);
	return $Sf;
}    # END of __add_prefixed_arg

1;

