package RefactorF4Acc::Refactoring::Equivalence;
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

use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast find_args_vars_in_ast );
use RefactorF4Acc::Analysis::Arrays qw(
  calculate_array_size
  get_array_rank
);
use RefactorF4Acc::Refactoring::Casts qw( create_cast_annlines );

use vars qw( $VERSION );
$VERSION = "2.1.1";

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  change_EQUIVALENCE_to_assignment_lines
);


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

WV2023-10-13
4. v_loc is updated using a DATA statement
DATA v_loc / ... /
v_glob = v_loc

The opposite case (swap v_loc and v_glob) is the same. 
=cut

sub __insert_assignment_for_ex_EQUIVALENCE_vars {
	my ( $stref, $f, $annline, $rlines, $equiv_pairs ) = @_;
	( my $line, my $info ) = @{$annline};
	my $skip = 0;
	
	if ( exists $info->{'Assignment'} and not exists $info->{'ExCommonOrEquivalence'}) {
		my $lhs_var = $info->{'Lhs'}{'VarName'};

# FIXME: This is not right because we need the variable only I think
# There is no way to infer the array index if it's an array
# Problem is of course that we now can't search by key in equiv_pairs
# because the key is the expression used in the EQUIVALENCE statement 
		my $lhs_ast = $info->{'Lhs'}{'ExpressionAST'};
		my $lhs_v_str = emit_expr_from_ast($lhs_ast);
		croak $line,':',Dumper( $info) if not defined $lhs_v_str;
		
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
							$rlines = [ @{$rlines}, @{ $equiv_pairs->{$arg} } ];
							$rlines = __embrace_extend_extinguish($stref, $f, $annline,$rlines, $equiv_pairs,$arg,$arg_asts,$fname);
						}
					}
				} 	
			}
		# carp 'TODO: process Function calls on RHS! '. Dumper($info->{'FunctionCalls'}) ;
		}
	} elsif ( exists $info->{'Data'} and not exists $info->{'ExCommonOrEquivalence'}) {
		
		for my $lhs_v_str ( @{ $info->{'Vars'}{'List'} }) {
			if ( exists $equiv_pairs->{$lhs_v_str} ) {
				# insert the extra line
				push @{$rlines}, $annline;
				say 'INSERTING ' . join( "\n", Dumper(pp_annlines( $equiv_pairs->{$lhs_v_str} ) )) . ' after ' . $line if $DBG;
				$rlines = [ @{$rlines}, @{ $equiv_pairs->{$lhs_v_str} } ];
				$skip   = 1;
			}		
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

sub change_EQUIVALENCE_to_assignment_lines {
	my ( $stref, $f, $annlines ) = @_;
	my $Sf                        = $stref->{'Subroutines'}{$f};
	return $annlines if not exists $Sf->{'HasEquivalence'} ;
	# my $last_statement            = 0;
	my $first_occ                 = 1;
	my $rlines                    = [];
	my $postUpdateAssignmentLines = {};
	my $exEquivAssignmentLines    = [];
	my $equiv_pairs               = {};

	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};
		my $skip = 0;
		# Create the equivalence pairs and remove the EQUIVALENCE statement
		if ( exists $info->{'Equivalence'} ) {
			my $rline = $annline;
			my $ast = dclone( $info->{'AST'} );
			# WV20201105 refactor this if-then into a separate function for clarity
			($rlines,$exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs) = __create_EQUIVALENCE_pairs(
				$stref, $f, $annline, $ast, 
				$rlines, $exEquivAssignmentLines, $postUpdateAssignmentLines,  $equiv_pairs);
			$skip = 1;
		}

		# For the assignments that replace the EQUIVALENCE statement
		# They should come after the last SpecificationStatement
		elsif ( not exists $info->{'Signature'}
			and not exists $info->{'VarDecl'}
			and not exists $info->{'ImplicitNone'}
			and not exists $info->{'SpecificationStatement'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Deleted'}
			and not exists $info->{'Data'} # WV 2023-10-13
			and $first_occ == 1 )
		{
			$first_occ = 0;
			for my $rline ( @{$exEquivAssignmentLines} ) {
				say 'REPLACED EQUIVALENCE BY ' . Dumper($rline) if $DBG;				
				push @{$rlines}, $rline;
			}
		} else { # triggered by $first_occ = 0
			# These are the assignments whenever a var is modified
			( $rlines, $skip ) = __insert_assignment_for_ex_EQUIVALENCE_vars( $stref, $f, $annline, $rlines, $postUpdateAssignmentLines );
		}

		push @{$rlines}, $annline unless $skip;
	}
	return $rlines;
}    # END of change_EQUIVALENCE_to_assignment_lines


sub __create_EQUIVALENCE_pairs { 
	my ($stref, $f, $annline, $ast, 
		$rlines, $exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs
	)=@_;
	( my $line, my $info ) = @{$annline};				  
		if ( ( $ast->[0] & 0xFF ) == 0 ) {
			# a single tuple, ['(',[',',@vs]]
			# $rline is unused
			( my $rline, $exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs, my $replaced ) =
				__refactor_EQUIVALENCE_line( $stref, $f, $ast, 
				$exEquivAssignmentLines, $postUpdateAssignmentLines, $annline, $equiv_pairs );
				if ($replaced) {
					$info->{'Deleted'} = 1;
					push @{$rlines}, [ '!' . $line, $info ];
				} else {
					push @{$rlines}, $annline;
				}
		} elsif ( ( ( $ast->[0] & 0xFF ) == 27 )
			&& ( ( $ast->[1][0] & 0xFF ) == 0 ) )
		{
			# a list of tuples
			shift @{$ast};
			for my $pair_ast ( @{$ast} ) {
				# $rline is unused
				( my $rline, $exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs ) =
					__refactor_EQUIVALENCE_line( $stref, $f, $pair_ast, 
					$exEquivAssignmentLines, $postUpdateAssignmentLines, $annline, $equiv_pairs );
				$info->{'Deleted'} = 1;
				push @{$rlines}, [ '!' . $line, $info ];

			}
		} else {
			croak "INVALID AST : " . Dumper($ast) . ( $ast->[0] & 0xFF ) . ( $ast->[1][0] & 0xFF ) if $DBG;
		}
		return ($rlines,$exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs);
	
} # __create_EQUIVALENCE_pairs

# $ast is the ast of the EQUIVALENCE statement 
# $exEquivAssignmentLines,  $postUpdateAssignmentLines are intially empty 
# $annline has the original AST, $ast is a copy
# $equiv_pairs is initially empty
sub __refactor_EQUIVALENCE_line {
	( my $stref, my $f, my $ast, my $exEquivAssignmentLines, my $postUpdateAssignmentLines, my $annline, my $equiv_pairs ) = @_;
	my $Sf    = $stref->{'Subroutines'}{$f};
	my $rline = $annline;
	my ( $line, $info ) = @{$annline};
	
	my $ann=annotate( $f, __LINE__  );

	# EQUIVALENCE can be a general tuple, not just two elts. 
	# Take it apart into pairs
	# $ast : ['(',[',',@vs]]
	my @asts = @{ $ast->[1] }; # @asts : (',',@vs)
	shift @asts; # @asts : @vs; 
	my @equiv_tuple = map { $_->[1] } @asts; # just the names

	my @pairs = ();

	for my $ast1 (@asts) {  # $ast1 : ['$',v] | ['@',v,@idxs]
		my $elt1      = $ast1->[1];
		my $found_elt = 0;
		for my $ast2 (@asts) { # $ast2 : ['$',v] | ['@',v,@idxs]
			my $elt2 = $ast2->[1];
			if ( $elt1 eq $elt2 ) {
				$found_elt = 1;
			} elsif ($found_elt) {
				push @pairs, [ $ast1, $ast2 ];
			}
		}
	}
	# So now @pairs is a list of pairs (ast1, ast2)

	# And perversely, if a line has multiple tuples, this is allowed: (v1,v2),(v2,v3)
	# So I must do some kind of transitivity check, I'll use $equiv_pairs for that
	# now suppose it is (v1,v2,v3),(v3,v4,v5) then this effectively means (v1,v2,v3,v4,v5)
	# So for each v3, v4, v5 I have to check in $equiv_pairs
	# Initially I will find v3 and so v1 and v2, but of course we already have that.
	# But then I should create pairs for v4 and v5 with v1 and v2 as well

	# 
	# (v1,v2,v3),(v2,v3,v4,v5) is also valid. 
	# But of course it is enough to have one overlap
	# because processing v3 after v2 will not result in new associations:
	# v1 v2, v1 v3, v2 v3
	# via v2: v2 v4, v2 v5, v3 v4, v3 v5, v4 v5; but then of course also v1 v4, v1 v5
	# via v3: quite the same. It is sufficient that one variable occurs in multiple tuples. 

	# Transitivity check
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
			$transitive = 1;
			$trans_var  = $var;
			last;
		}
	}
	
	if ($transitive) {
		# Handle transitive pairs
		for my $ast1 (@asts) {
			my $var1 = emit_expr_from_ast($ast1);
			if ( $var1 ne $trans_var ) {
				for my $var2 ( keys %{ $equiv_pairs->{$trans_var} } ) {
					my $ast2 = $equiv_pairs->{$trans_var}{$var2};
					push @pairs, [ $ast1, $ast2 ];
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

	# If a pair consists of two arrays
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
	# The only exception is character strings, see below

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
			$replaced=0;
			warning('EQUIVALENCE with CHARACTER string is not refactored'."\n$line\n",1);
			last;
		}
		if ( not (
			$v1_type eq $v2_type
		or ($v1_type eq 'logical' and  $v2_type eq 'integer') 
		or ($v1_type eq 'integer' and $v2_type eq 'logical')
		or ($v1_type eq 'real' and $v2_type eq 'complex')
		or ($v1_type eq 'complex' and $v2_type eq 'real')
		)
		) {
			error("'$v1_type' and '$v2_type' are incompatible\n$line",'EQUIVALENCE');
			# say "TYPE ERROR: '$v1_type' and '$v2_type' are incompatible"."\n$line\n";
			# die "\n" if $Config{'STRICT_EQUIVALENCE_CHECKS'};
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
		# FIXME: is this not the same as $replaced above?
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
					$ann=annotate( $f, __LINE__  );
				} else {
					$ann=annotate( $f, __LINE__  );
				}					
				}
			} 			# else it means v2 was already indexed
		} elsif ( $v1_is_array and $v2_is_array ) {
			
			# Check for overlapping ranges
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
				# Handle overlapping ranges
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
							warning('EQUIVALENCE statement not refactored because it is between two arrays of rank > 1 and different size: '."\n$line\n",1);
							$remove_equiv_stmt = 0;
						}
					} else {
						# else give up, warn and keep the original line
						warning('EQUIVALENCE statement not refactored because it is between two arrays of different rank and size: '."\n$line\n",1);
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
			# EQUIVALENCE (v1,v2)
			# if both are ExGlobArgs, we don't need the initial assignment
			# When we encounter EQUIVALENCE, no assignments have happened
			# So if var2 is an ExGlobArg and var1 is a local, then we should assign var2 to var 1
			# WV20201109: I think this should this be $assign_v2_to_v1, but it was $assign_v1_to_v2
			# FIXME: create a test
			$exEquivAssignmentLines = [ @{$exEquivAssignmentLines}, @{$assign_v2_to_v1} ];    #
		}
	} # loop over all pairs

	return ( $rline, $exEquivAssignmentLines, $postUpdateAssignmentLines, $equiv_pairs, $replaced );
} # END of __refactor_EQUIVALENCE_line



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

# This is a kludge to extend the equivalence if it was between a scalar and an array.
# What this does is create an equivalence between the subsequent array elements and the next args
# This is an ugly hack because it assumes that those extra args are ex-globals.
sub __embrace_extend_extinguish { my ($stref, $f, $annline,$rlines,$equiv_pairs,$arg,$arg_asts,$fname) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my ($line, $info) = @{$annline};
	my $take_next_args=0;
	my $arg_decl = get_var_record_from_set( $Sf->{'Vars'}, $arg );
			# carp 'ARG: ', Dumper $arg_decl;
	# carp Dumper($equiv_pairs->{$arg}) if $line=~/ff304/;
	my $extended_equiv_pairs=[];
	for my $equiv_pair (@{$equiv_pairs->{$arg}}) {
		# croak  Dumper $equiv_pair;
		my $lhs_var_expr = $equiv_pair->[1]{'Lhs'}{'VarName'};
		if ( $lhs_var_expr =~/(\w+)\((\d+)\)/ ) {
			my $lhs_var = $1; 
			my $index = $2;
			my $lhs_var_decl = get_var_record_from_set( $Sf->{'Vars'}, $lhs_var );
			# carp 'LHS VAR: ', Dumper $lhs_var_decl;
			if (exists $arg_decl->{'CommonBlockName'}) {
				if ($arg_decl->{'ArrayOrScalar'} eq 'Scalar' 
				and $lhs_var_decl->{'ArrayOrScalar'} eq 'Array') {
					# carp 'LHS VAR: ', Dumper $lhs_var_decl->{'Dim'};
					my ($array_sz, $not_const) = calculate_array_size($stref, $f, $lhs_var_decl->{'Dim'});
					 if ($array_sz>1) {
							warning("Extension of named COMMON block storage by EQUIVALENCE association of a variable and an array. Please don't do this!"
								. "\nArray $lhs_var extends beyond argument $arg of $fname in call in $f"
 							);
							for my $arg_ast (@{$arg_asts}) {
								my $targ=emit_expr_from_ast($arg_ast);
								if ($targ eq $arg) {
									$take_next_args=1;
								}
								elsif ($take_next_args ) {
									++$index;
									# say "$lhs_var($index) = $targ";
									push @{$extended_equiv_pairs} , [
									$equiv_pair->[1]{'Indent'}."$lhs_var($index) = $targ",
									{
										'ExCommonOrEquivalence' => 1,
										'Rhs' => {
										'Vars' => {
											'List' => [
											$targ
											],
											'Set' => {}
										}
										},
										'Ann' => [
										'Refactoring::Equivalence::__refactor_EQUIVALENCE_line(fm302) 448'
										],
										'HasVars' => 1,
										'Indent' => '      ',
										'Assignment' => 1,
										'Lhs' => {
										'VarName' => "$lhs_var($index)",
										'IndexVars' => {
											'List' => []
										}
										}
									}
									];

								}
							}
					 }
				}
			}
		}
	}
	$rlines = [ @{$rlines}, @{ $extended_equiv_pairs } ];
	return $rlines;
}
1;
