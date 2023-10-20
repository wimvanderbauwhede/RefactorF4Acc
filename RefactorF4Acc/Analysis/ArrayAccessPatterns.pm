package RefactorF4Acc::Analysis::ArrayAccessPatterns;
#
#   (c) 2016-now Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( max );
use RefactorF4Acc::Refactoring::Helpers qw(
	pass_wrapper_subs_in_module
	stateful_pass
	stateful_pass_inplace
	stateful_pass_reverse_inplace
	stateless_pass_inplace
	splice_additional_lines_cond_inplace
	);
use RefactorF4Acc::Refactoring::Subroutines::Emitters qw( emit_subroutine_sig );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::ExpressionAST::Evaluate qw(
eval_expression_with_parameters
replace_param_by_val
replace_consts_in_ast
);
use RefactorF4Acc::Parser::Expressions qw(
	parse_expression
	emit_expr_from_ast
	get_vars_from_expression
	);

use vars qw( $VERSION );
$VERSION = "6.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::ArrayAccessPatterns::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::ArrayAccessPatterns::EXPORT_OK = qw(
&pass_identify_stencils
&identify_array_accesses_in_exprs
);

=info
Pass to determine stencils in map/reduce subroutines
Because of their nature we don't even need to analyse loops: the loop variables and bounds have already been determined.
So, for every line we check:
If it is an assignment, a subroutine call or a condition in and If or Case, we go on
But in the kernels we don't have subroutines at the moment. We also don't have Case I think
If assignment, we separate LHS and RHS
If subcall, we separate In/Out/InOut
If cond, it is a read expression

In each of these we get the AST and hunt for arrays. This is easy but would be easier if we had an 'everywhere' or 'everything' function

=cut

sub pass_identify_stencils {(my $stref, my $code_unit_name)=@_;
	$stref = pass_wrapper_subs_in_module($stref,$code_unit_name,
			# module-specific passes
			[],
			# subroutine-specific passes
			[
		  		[
			  		\&identify_array_accesses_in_exprs,
				],
			]
		);

	return $stref;
} # END of pass_identify_stencils()


# As far as I can see, the problem
# my $state = {'CurrentSub'=>'', 'Subroutines'=>{}};

# $stref->{'Subroutines'}{ $f }{'ArrayAccesses'} = $state->{'Subroutines'}{$f}{'Blocks'};

# Array assigments are stored in  $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'ArrayAssignments'}
# and are of the form [ [$lhs_accesses,$rhs_accesses,$annline], ... ]
#  where
    # $lhs_accesses = { 'Arrays' => { $array_var1 => {'Write' => { Exprs => ..., Accesses =>..., Iterators =>...}} }}
    # $rhs_accesses = { 'Arrays' => { $array_var1 => {'Read' => { Exprs => ..., Accesses =>..., Iterators =>...}} }}
# And I think I have now extended this to include Scalars as well

# Array access on the LHS of an Assignment is stored in $info

# Array accesses are stored in $info->...->{'VarAccesses'}

# $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}=
# {
# 	'Exprs' => { $expr_str_1 => '0:1',...},
# 	'Accesses' => { '0:1' =>  {'j:0' => [1,0],'k:1' => [1,1]}},
# 	'Iterators' => ['j:0','k:1']
# };
#
# Array dimensions are stored in
# $stref->{'Subroutines'}{ $f }{'ArrayAccesses'} = 	$state->{'Subroutines'}{ $f }{'Blocks'} =
# { $block_id  => {'Arrays'}{$array_var}{'Dims'} = [[0,501],[1,500],...] }
#
# In this subroutine, ${l|r}hs_accesses is a hash with keys
#					$accesses->{'Arrays'}{$array_var}{$rw}{'Exprs'}{$expr_str}=$offsets_str
#						where
#							my $offsets_str :: String = join(':', @offset_vals);
#							my @offset_vals :: [Int]
#					$accesses->{'Arrays'}{$array_var}{$rw}{'Accesses'}{ $offsets_str } = $iter_val_pairs;
#						where
#							my $iter_val_pairs = [{$iter_str => [$mult,$offset]}, ... ]
#					$accesses->{'Arrays'}{$array_var}{$rw}{'Iterators'} = ['j:0','k:1'];

#					$accesses->{'Arrays'}{$array_var}{$rw}{'HaloAccesses'}{$loop_iter} =
#						{'Bound' =>$b, 'Test' => [$loop_bound, $offset, $array_bound, $array_halo]};
#					$accesses->{'HasHaloAccesses'}=1;

#					$accesses->{'Scalars'}{$scalar_var}{$rw}{'Exprs'}{$expr_str}=$expr_str
# The test is
# Lower: $loop_bound + $offset < $array_bound + $array_halo
# Upper: $loop_bound + $offset > $array_bound - $array_halo

sub identify_array_accesses_in_exprs { (my $stref, my $f) = @_;
	if ($DBG) {
	print "\nIN SUB $f, SRC <"; print $stref->{'Subroutines'}{$f}{'Source'}; say ">";
	}
    if ($f ne $Config{'KERNEL'}) {

		# This of course assumes that we have Lines and that each elt has this structure.
		if (exists $stref->{'EmitAST'} and
		exists $stref->{$stref->{'EmitAST'}} and
		exists $stref->{$stref->{'EmitAST'}}{'Lines'}
		) {
        	push @{ $stref->{$stref->{'EmitAST'}}{'Lines'} }, {'NodeType' => 'Comment', 'CommentStr' => $f };
		}

		if($Config{'KERNEL'} ne '' ) {
			$stref = _get_loop_iters_from_global_id($stref,$f);
		}
		# Loop iters are in $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{'0'}{'LoopIters'}

		my $pass_identify_array_accesses_in_exprs = sub { (my $annline, my $state)=@_;
			(my $line,my $info)=@{$annline};

            my $in_block = exists $info->{'Block'} ? $info->{'Block'}{'LineID'} : -1;
			if ($in_block == -1 ) {
				$state->{'CurrentBlock'} = 0;
			}
			# This is the concat of the line IDs for every DO line in the nest.
            my $block_id = exists $state->{'Subroutines'}{$f}{'LoopNests'}{'List'}
			# and scalar keys %{$state->{'Subroutines'}{$f}{'LoopNests'}} > 0
			? __mkLoopId( $state->{'Subroutines'}{$f}{'LoopNests'}{'List'} ) : 0;
			# carp Dumper $state->{'Subroutines'}{$f}{'LoopNests'};
            #
			# Identify the subroutine
			if ( exists $info->{'Signature'} ) {
				my $subname =$info->{'Signature'}{'Name'} ;
				$state->{'CurrentSub'}= $subname  ;
				croak if $DBG and $subname ne $f;
				if (not exists $state->{'Subroutines'}{$subname }) {
				$state->{'Subroutines'}{$subname }={};
				}
				if (not exists $state->{'Subroutines'}{$subname }{'Blocks'}) {
				$state->{'Subroutines'}{$subname }{'Blocks'}={};
				}
				if (not exists $state->{'Subroutines'}{$subname }{'Blocks'}{$block_id}) {
				$state->{'Subroutines'}{$subname }{'Blocks'}{$block_id}={};
				}
					# 'LoopIters' => {'DUMMY' =>1 }
				# };
                $state->{'Subroutines'}{$f}{'LoopNests'}{'List'}=[ [0,'',{}] ];
                # InOut will be both in In and Out
                # Any scalar arg that is InOut or Out could be an Acc, put it in MaybeAcc

                $state->{'Subroutines'}{$f}{'Args'}={
                	'In'=>[],'Out' =>[], 'MaybeAcc'=>[],'Acc'=>[]
                };

                for my $arg ( @{ $info->{'Signature'}{'Args'}{'List'} } ) {

                	my $arg_decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Args'},$arg);
					my $intent =$arg_decl->{'IODir'}; # can be Unknown
					my $is_scalar = $arg_decl->{'ArrayOrScalar'} eq 'Array' ? 0 : 1;
					if ($is_scalar and $intent eq 'out' or $intent eq 'inout' or $intent eq 'Unknown') {
						push @{ $state->{'Subroutines'}{$f}{'Args'}{'MaybeAcc'} }, $arg;
					}
					if ($intent ne 'out') {
						push @{ $state->{'Subroutines'}{$f}{'Args'}{'In'} }, $arg;
					}
					if ($intent ne 'in') {
						push @{ $state->{'Subroutines'}{$f}{'Args'}{'Out'} }, $arg;
					}
                }
			}
			# For every VarDecl, identify dimension if it is an array
			if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'} and is_array_decl($info)) {
				my $array_var=$info->{'VarDecl'}{'Name'};
				my @dims = @{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} };
				$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'}=[];
				for my $dim (@dims) {
					(my $lo, my $hi)=$dim=~/:/ ? split(/:/,$dim) : (1,$dim);
					my $dim_vals=[];
					for my $bound_expr_str ($lo,$hi) {
						my $dim_val=$bound_expr_str;
						if ($bound_expr_str=~/\W/) {
                            $dim_val=_eval_expression_w_params($bound_expr_str,$info, $stref,$f,$block_id,$state);
						} else {
							# It is either a number or a var
							if (in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$bound_expr_str)) {
                                # Means it's a parameter
				  				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Parameters'},$bound_expr_str);
                                $dim_val = $decl->{'Val'};
							} # otherwise it's a number and we fall through
						}
						push @{$dim_vals},$dim_val;
					}
                    # This is also used to generate the 1-D stencils for TyTraCL
					push @{ $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'} },$dim_vals;
					# croak Dumper $state->{'Subroutines'}{ $f };
				}
				# $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Halos'}=$decl
#				say "{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'}";
#				say Dumper($state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'});
			}
			elsif (exists $info->{'Assignment'} ) {
				# Assignment to scalar *_rel
				# This is ad hoc for the output of the AutoParallelFortran compiler!
				# carp $f. Dumper $info;

				# if ($Config{'KERNEL'} ne '' and # This means we are dealing with an OpenCL kernel
				# 	$info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_rel/) {
				# 	# This case is UNUSED
				# 	my $loop_iter=$1;
				# 	# carp "$f $line $loop_iter".Dumper $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'};
				# 	if (
				# 		$DBG and
				# 		not exists $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{$loop_iter}{'Range'}) {
				# 		croak "This should not happen! " .Dumper($annline);
				# 		$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{$loop_iter}={'Range' => [0,0,0]};
				# 	}

				# }

				# Assignment to scalar *_range
				# This is ad hoc for the output of the AutoParallelFortran compiler!
				# WV 2021-05-20 We already know the iters from get_global_id()
				# but we don't know the range because it is only defined via enqueueNDRange
				# so this is the only way to get it
				# I guess what I should do is set the range to the dimension of the largest array as a "first guess", this will still allow us to detect small arrays
				# We should do that in
				if ($Config{'KERNEL'} ne '' and $info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_range/) {
					my $loop_iter=$1;
					my $expr_ast = $info->{'Rhs'}{'ExpressionAST'};
					my $expr_str = emit_expr_from_ast($expr_ast);
					my $expr_ast2 = replace_param_by_val($stref, $f, 0,$expr_ast, $state);
    				my $evaled_expr_str=emit_expr_from_ast($expr_ast2);
					# Can do this as it should all be constants
					my $loop_range = eval($evaled_expr_str);

					$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{$loop_iter}{'Range'} = [1,$loop_range,1];
				}
				# else {
					# First check if this is maybe an accumulator
				if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' ) {
				# Test if a scalar arg is an accumulator for a fold
				# If the arg occurs on LHS and RHS of an assignment and the RHS has an array arg as well
					my %maybe_accs = map {$_ => 1} @{$state->{'Subroutines'}{$f}{'Args'}{'MaybeAcc'}};
					my %in_arrays  = map {$_ => 1} @{$state->{'Subroutines'}{$f}{'Args'}{'In'}};
					my $acc_var = $info->{'Lhs'}{'VarName'} ;
					if (exists $maybe_accs{$acc_var}) {
						my $vars = get_vars_from_expression($info->{'Rhs'}{'ExpressionAST'});
						if (exists $vars->{$acc_var}) {
							for my $tvar (sort keys %{$vars}) {
								if ($vars->{$tvar}{'Type'} eq 'Array'
								and exists $in_arrays{$tvar}
								) {
									push @{$state->{'Subroutines'}{$f}{'Args'}{'Acc'}}, $acc_var;
									last;
								}
							}
						}
					}
				}

				# This tests for the case of the same array on LHS and RHS, but maybe with a different access location, so a(...) = a(...)
				# This is probably superseded by the new analysis of array assignment expressions
				if (
					ref($info->{'Rhs'}{'ExpressionAST'}) eq 'ARRAY'
				and (($info->{'Rhs'}{'ExpressionAST'}[0] & 0xFF) == 10) #eq '@'
				and ref($info->{'Lhs'}{'ExpressionAST'}) eq 'ARRAY'
				and (($info->{'Lhs'}{'ExpressionAST'}[0] & 0xFF) == 10) #eq '@'
				and $info->{'Lhs'}{'ExpressionAST'}[1] eq $info->{'Rhs'}{'ExpressionAST'}[1]
				) {
					my $var_name = $info->{'Rhs'}{'ExpressionAST'}[1];
					say "IDENTITY OP for $var_name : ",$line . __PACKAGE__ .' '. __LINE__ if $DBG;
					$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'Identity'}{$var_name} = 1;
				}

				# Find all array accesses in the LHS and RHS AST.
				# carp 'BLOCK: '.$block_id.';'.Dumper($state->{'Subroutines'}{ $f }{'Blocks'});#{$block_id});
				# say "LINE: $line";
				(my $lhs_ast, $state, my $lhs_accesses) = _find_var_access_in_ast($stref, $f, $block_id, $state, $info->{'Lhs'}{'ExpressionAST'},'Write',{});
				(my $rhs_ast, $state, my $rhs_accesses) = _find_var_access_in_ast($stref, $f, $block_id, $state, $info->{'Rhs'}{'ExpressionAST'},'Read',{});
				$info->{'Rhs'}{'VarAccesses'}=$rhs_accesses;
				$info->{'Lhs'}{'VarAccesses'}=$lhs_accesses;
				croak Dumper $state if $line=~/c.i.\s+\+\s+acc/;

				if (exists $lhs_accesses->{'Arrays'} and exists $rhs_accesses->{'Arrays'} ) {
					# This is an assignment line with array accesses on both sides
					# Tie the LHS accesses to the RHS ones
					# We simply create a list of these, rather than trying to reuse $state->{'Subroutines'}{ $f }{$block_id}{'Assignments'}
# 'Arrays' => {
#    'v' => {
#      'Write' => {
#        'Exprs' => {
#          'v(j,0)' => 1
#        },
#        'Accesses' => {
#          '0:0' => [
#            {
#              'j:0' => [
#                1,
#                0
#              ]
#            },
#            {
#              '?1' => [
#                0,
#                0
#              ]
#            }
#          ]
#        }
#      }
#    }
#  }

#						say $line. "\nTie the LHS accesses to the RHS ones".Dumper($lhs_accesses,$rhs_accesses). "\n".' __PACKAGE__ '.__LINE__;
					if (not exists $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'ArrayAssignments'}) {
						$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'ArrayAssignments'}=[];
					}
					push @{ $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'ArrayAssignments'} }, [$lhs_accesses,$rhs_accesses,$annline];
				}
				if (exists $lhs_accesses->{'Arrays'} or exists $rhs_accesses->{'Arrays'} ) {
					# This is an assignment line with array accesses.
					# Check the halos!
					($lhs_accesses,$rhs_accesses) = @{ _detect_halo_accesses($line, $lhs_accesses,$rhs_accesses,$state,$block_id,$stref,$f) };
					if (exists $rhs_accesses->{'HasHaloAccesses'}) {
						$info->{'Rhs'}{'VarAccesses'}=$rhs_accesses;
					}
					if (exists $lhs_accesses->{'HasHaloAccesses'}) {
						$info->{'Lhs'}{'VarAccesses'}=$lhs_accesses;
					}

				}

				my $var_name = $info->{'Lhs'}{'VarName'};
				if (not exists $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'Assignments'}{$var_name}) {
					$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'Assignments'}{$var_name}=[];
				}
				push @{$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'Assignments'}{$var_name}}, $info->{'Rhs'}{'ExpressionAST'};
			}
	 		if (exists $info->{'If'} or exists $info->{'ElseIf'}) {
                # FIXME: Surely conditions of if-statements can contain array accesses, so FIX THIS!
                #say "IF statement, TODO: ".Dumper($info->{'Cond'}{'Expr'});
                my $cond_expr_ast = $info->{'Cond'}{'AST'};
                ($cond_expr_ast, $state, my $cond_accesses) = _find_var_access_in_ast($stref, $f, $block_id, $state, $cond_expr_ast,'Read',{});
				$info->{'VarAccesses'}=$cond_accesses;
            }
            elsif ( exists $info->{'Do'} ) {
                    if (exists $info->{'Do'}{'Iterator'} ) {
                # Do => {
                #           Label :: Int
                #           Iterator :: Var
                #           Range => {
                #               Vars => [ Var ],
                #               Expressions => [ $range_start, $range_stop, $range_step ]
                #            }
                #       }
                (my $range_start, my $range_stop, my $range_step) = @{ $info->{'Do'}{'Range'}{'Expressions'} };
                my $range_start_evaled = eval_expression_with_parameters($range_start,$info,$stref,$f);
                my $range_stop_evaled = eval_expression_with_parameters($range_stop,$info,$stref,$f);
				my $range_step_evaled = eval_expression_with_parameters($range_step,$info,$stref,$f);
#                say "RANGE: [ $range_start_evaled , $range_stop_evaled ]";
                my $loop_iter = $info->{'Do'}{'Iterator'};

				# carp Dumper $loop_iter;
                my $loop_range_exprs = [ $range_start_evaled , $range_stop_evaled, $range_step_evaled ];#[$range_start,$range_stop]; # FIXME Maybe we don't need this. But if we do, we should probably eval() it
                my $loop_id = $info->{'LineID'};
                push @{ $state->{'Subroutines'}{$f}{'LoopNests'}{'List'} },[$loop_id, $loop_iter , {'Range' => $loop_range_exprs}];
                my $block_id = __mkLoopId( $state->{'Subroutines'}{$f}{'LoopNests'}{'List'} );
				# $info->{'BlockID'} = $block_id;
				$state->{'CurrentBlock'} = $block_id;
                for my $loop_iter_rec ( @{ $state->{'Subroutines'}{$f}{'LoopNests'}{'List'} } ) {
                    (my $loop_id, my $loop_iter, my $range_rec) = @{$loop_iter_rec};
					next if $loop_iter eq '';
                    $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{$loop_iter}=$range_rec;
                }
            } else {
                die "ERROR: Sorry, a `do` loop without an iterator is not supported\n";
            }
            } elsif ( exists $info->{'EndDo'} ) {
				my $block_id = $state->{'CurrentBlock'};
				# $info->{'BlockID'} = $block_id;
				pop @{ $state->{'Subroutines'}{$f}{'LoopNests'}{'List'} };
				# $state->{'CurrentBlock'} = 0;

            }
			return ([[$line,$info]],$state);
		};

		my $state = {'CurrentSub'=>'', 'CurrentBlock'=>0,'Subroutines'=>{}};
		$state->{'Subroutines'}{$f}{'Blocks'} = $stref->{'Subroutines'}{ $f }{'ArrayAccesses'};

	 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_identify_array_accesses_in_exprs, $state,'pass_identify_array_accesses_in_exprs ' . __LINE__  ) ;
	 	# croak "SUB $f:".Dumper $state->{'Subroutines'}{$f}{'Blocks'};
	 	$stref = _collect_dependencies_for_halo_access($stref,$f);
# croak Dumper $state;
		$state = _link_writes_to_reads( $stref, $f, $state);

		# I guess here is where we put the boundary stencil analysis
#        _identify_boundary_accesss($state, $f);

		$stref = _classify_accesses_and_emit_AST($stref, $f, $state);
        $stref->{'Subroutines'}{ $f }{'ArrayAccesses'} = $state->{'Subroutines'}{$f}{'Blocks'};
	} # if subkernel not superkernel
	else {
		# croak $f.': '.Dumper( $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'});

		$stref = _emit_AST_Main($stref, $f);
	}
# carp $f.': '.Dumper( $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'});

 	return $stref;
} # END of identify_array_accesses_in_exprs()




=info2
#  u(i-1,j+1,1)
#
#  (i+i_off,j+j_off,k+k_off) =>
#  idx = i*use_i + i_range*j*use_j+i_range*k_range*k*use_k
#  idx_off = i_off + i_range*j_off + i_range*k_range*k_off
#
#  if i, j or k is a constant then use_* is set to 0

  $VAR1 = [
  '@',
  'u',
  [
    '+',
    [
      '$',
      'i'
    ],
    [
      '-',
      '1'
    ]
  ],
  [
    '+',
    [
      '$',
      'j'
    ],
    '1'
  ],
  '1'
];

So every stencil is identified by offset &  used for each of its iters
v => { i => {offset, used}, j => ... }

=cut
# ============================================================================================================
# FIXME: I think this does not deal with constant accesses
sub _find_var_access_in_ast { (my $stref, my $f,  my $block_id, my $state, my $ast, my $rw, my $accesses)=@_;
    if (ref($ast) eq 'ARRAY') {
		# carp "AST:".Dumper $ast;
		for my  $idx (0 .. scalar @{$ast}-1) {
			my $entry = $ast->[$idx];

			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _find_var_access_in_ast($stref,$f, $block_id, $state,$entry, $rw,$accesses);
				$ast->[$idx] = $entry;
			} else {
				if ($idx==0 and (($entry & 0xFF)==10)) { #$entry eq '@'
					my $mvar = $ast->[$idx+1];

					my $expr_str = emit_expr_from_ast($ast);
					$state = _find_iters_in_array_idx_expr($stref,$f,$block_id,$ast, $state,$rw);
					my $array_var = $ast->[1];
					# Special case for our OpenCL kernels
					# FIXME!
					if ($Config{'KERNEL'} ne '' and $array_var =~/(?:glob|loc)al_/) { return ($ast,$state); }

					# First we compute the offset
#						say "OFFSET";
					my $ast0 = dclone($ast);

# carp $f,Dumper( $state->{'Subroutines'}{ $f }{'Blocks'}{'0'});
					($ast0, my $retval ) = replace_consts_in_ast($stref,$f,$block_id,$ast0, $state->{'Subroutines'}{ $f }{'Blocks'},0);
					# carp "AST0:".Dumper $ast0;
					my @ast_a0 = @{$ast0};

					my @idx_args0 = @ast_a0[2 .. $#ast_a0];
					# carp "IDX_ARGS:".Dumper @idx_args0;
					my @ast_exprs0 = map { emit_expr_from_ast($_) } @idx_args0;
					# carp Dumper @ast_exprs0;

					my @offset_vals = map { eval($_) } @ast_exprs0;
					# If the accesses were not constants, we need some hack
					# if (scalar @offset_vals == 0) {
					# 	if ($idx_args0[0][0]==27) {
					# 		@offset_vals = map {0} (2 .. scalar @{$idx_args0[0]} );
					# 	} else {
					# 		@offset_vals=(0);
					# 	}
					# }
					# carp "OFFSETS:<".Dumper(@offset_vals).'>';
					# Then we compute the multipliers (for proper stencils these are 1 but for the more general case e.g. copying a plane of a cube it can be different.
#						say "MULT";
					my $ast1 = dclone($ast);
					($ast1, $retval ) = replace_consts_in_ast($stref,$f,$block_id,$ast1, $state->{'Subroutines'}{ $f }{'Blocks'},1);
					my @ast_a1 = @{$ast1};
					my $array_var1 = $ast1->[1];
					my @idx_args1 = @ast_a1[2 .. $#ast_a1];
					my @ast_exprs1 = map { emit_expr_from_ast($_) } @idx_args1;
					my @mult_vals = map { eval($_) } @ast_exprs1;
					# carp 'MULT:'. Dumper(@ast_exprs1);
					# if (scalar @mult_vals == 0) {
					# 	if ($idx_args1[0][0]==27) {
					# 		@mult_vals = map {1} (2 .. scalar @{$idx_args1[0]} );
					# 	} else {
					# 		@mult_vals=(1);
					# 	}
					# }
					my @iters = @{$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}};
					# say "529 OFFSET_VALS", Dumper(@offset_vals);
					my $iter_val_pairs=[];
					for my $idx (0 .. @iters-1) {
						# say "IDX: $idx";
						my $offset_val=$offset_vals[$idx];
						# say $f;
						if (not defined $offset_val) {
							# The problem here is that these variables i_range, i_rel have been removed so can't find any iters!
							# say Dumper pp_annlines($stref->{'Subroutines'}{$f}{'RefactoredCode'});
						croak $f;#."\n".Dumper $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id } ;
						}
						my $mult_val=$mult_vals[$idx]-$offset_val;
						push @{$iter_val_pairs}, {$iters[$idx] => [$mult_val,$offset_val]};
#							say "Boundary access $f $array_var " . __PACKAGE__ . ' '. __LINE__ if substr($iters[$idx],0,1) eq '?';
					}
					my $offsets_str = join(':', @offset_vals);
					# say 'OFFSET STR => ITER-VAL PAIRS: ',Dumper( {$offsets_str =>  $iter_val_pairs } );
					$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Exprs'}{$expr_str}=$offsets_str;
					$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}{ $offsets_str } = $iter_val_pairs;
					$accesses->{'Arrays'}{$array_var}{$rw}{'Exprs'}{$expr_str}=$offsets_str;
					$accesses->{'Arrays'}{$array_var}{$rw}{'Accesses'}{ $offsets_str } = $iter_val_pairs;
					$accesses->{'Arrays'}{$array_var}{$rw}{'Iterators'}=\@iters;
					last;
				}
				elsif ($idx==0 and (($entry & 0xFF)==2)) { #$entry eq '$'
					my $scalar_var = $ast->[1];
					my $expr_str = emit_expr_from_ast($ast);
					$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Scalars'}{$scalar_var}{$rw}{'Exprs'}{$expr_str}=$expr_str;
					last;
				}
			}
		}
	}
	return  ($ast, $state, $accesses);

} # END of _find_var_access_in_ast

=info3

In a first pass we try to get the iter order.
We look at the number of dimensions in the array, purely from the access
We see if there is an occurence of any of the declared iters in the array access
That gives us something like
u(const,j,k) so we know now that 0 => const 1 => j, 2 => k,
p(const, i,j,k)  so we know now that 0 => const 1 => i, 2 => j, 3 => k

Main question is: do we need this? Why not simply set the iters to 0 and evaluate the expression to get the offset?
Answer: because we need to know if this offset is to be added to the iter or not, e.g.

u(0,j,k) and u(1,j,k+1) would give stencils (0,0,0) and (1,0,1) but it is NOT i,j,k and i+1,j,k+1
So I need to be able to distinguish constant access from iterator access. Once that his done we can express the stencil as (Offset,isConst) for every dimension, by index.

But suppose something like u(i,j,k) = u(1,j,k)+u(i,1,k) then thar results in ((1,const),(0,j),(0,k)) and ((0,i),(1,const),(0,k))
That is OK: the necessary information is there.
So in short: per index:
- find iters, if not set to '' => is this per sub or per expr? Let's start per expr.
- replace iter with 0 and consts with their values
- eval the expr and use as offset


=cut


# When we find an iterator access in an array we must check in which loop this array is being accessed
sub _find_iters_in_array_idx_expr { (my $stref, my $f, my $block_id, my $ast, my $state, my $rw)=@_;


# AST: $VAR1 = [
#   10,
#   'vn',
#   [
#     27,
#     [
#       2,
#       'j'
#     ],
#     [
#       2,
#       'k'
#     ]
#   ]
# ];

	# my @ast_a = @{$ast};
	my @args = ();
	# NOT OK: IF this is a 1-D array then we don't have this structure I think
	# So we must check if
	if ($ast->[2][0] == 27) {
	for my $arg_idx (1 .. scalar @{$ast->[2]} -1 ) {
		my $arg = $ast->[2][$arg_idx];
		push @args, $arg;
	}
	} else {
		push @args, $ast->[2];
	}
	my $array_var = $ast->[1]; # OK
	$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}=[];
	for my $idx (0 .. @args-1) {
		$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]='?:' . $idx;
  		my $item = $args[$idx]; # This is an AST!
  		my $vars = get_vars_from_expression($item, {});
  		for my $var (keys %{$vars}) {
  			if (exists $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'LoopIters'}{ $var }) {
  				# OK, I found an iterator in this index expression. I boldly assume there is only one.
  				$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'}[$idx]=$var.':'.$idx;
  			}
  		}
	}
	return $state;
} # END of _find_iters_in_array_idx_expr

=info
The 'Links' table lists all input args on which an output arg depends.
This is done by a dependency analysis of the assignments.
For output args that do not depend on inputs, we add a dummy $var => "!$var!"

So first we need to gather all assignments in the subroutine, i.e. in a separate, trivial pass
We put this in the $state as 'Assignments'}, this happened in identify_array_accesses_in_exprs()

	$assignments = { $var => $assign_expr }

The links table starts out empty:

	$links = {}

* FOLDS

- To be sure it is a fold I will do the following tests:
- a scalar argument that is Out or InOut
- used in an assignment on both LHS and RHS
- I suppose this should also test for an array on the RHS, and all indices used. So I need to do a link analysis until I get to the input args
To keep this tidy I will use a separate links table for scalar outputs

So we don't allow folds over lower-dimensionality arrays, nor folds hidden in a subroutine call
Alternatively I could of course rely on the kernel name, they have 'map' or 'reduce' in them ^_^

=cut

sub _link_writes_to_reads {(my $stref, my $f, my $state)=@_;

    for my $block_id (sort keys %{ $state->{'Subroutines'}{$f}{'Blocks'} }) {
		my $links={};
		my $assignments = $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Assignments'};
		# So we have to establish the link for every variable that is a multi-dim (effectively 3-D) array argument
		for my $some_var ( sort keys %{ $assignments }  ) {
			# WV 2021-05-19 FIXME: should I use the Deps from the LoopIter analysis?
			next if $Config{'KERNEL'} ne '' and $some_var=~/_rel|_range/;
			$links = _link_writes_to_reads_rec($stref, $f, $block_id, $some_var,$assignments,$links,$state);
		}

		$links = _collapse_links($stref,$f,$block_id,$links);
		# Now remove anything that is not an array arg link
		for my $var (keys %{$links} ){

			if (not isArg($stref, $f, $var) ) {
				delete $links->{$var};
			}

			for my $lvar (keys %{$links->{$var}} ){
				if ($links->{$var}{$lvar} > 2 ) {
					delete $links->{$var}{$lvar};
				}
			}
			if (
				scalar keys  %{ $links->{$var}} == 0
			) {
					delete $links->{$var};
			}
		}
		$state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Links'}=$links;
	}
	return $state;
} # END of _link_writes_to_reads()

sub _link_writes_to_reads_rec {my ($stref, $f, $block_id, $some_var, $assignments, $links, $state)=@_;
# warn "$f VAR: $some_var";# . Dumper($stref->{'Subroutines'}{$f}{'Vars'});
		my $subset = in_nested_set($stref->{'Subroutines'}{$f},'Vars',$some_var);
		my $subset_p = in_nested_set($stref->{'Subroutines'}{$f},'Parameters',$some_var);
 		my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{$subset},$some_var);
		 croak "VAR $some_var in $f (block $block_id) : <$subset_p>".Dumper( $links) if not $subset;
		# carp "$some_var DECL:<".Dumper( $decl->{'Dim'}).'>';
		my $lhs_dim = scalar @{ $decl->{'Dim'} };
		if (exists $assignments->{$some_var} ) {
			my $rhs_array = $assignments->{$some_var};
			my $vars = {};
			for my $rhs (@{ $rhs_array }) {
				my %tvars = %{ get_vars_from_expression($rhs,{}) };
				my %avars = _remove_index_vars($stref,$f,$block_id,$state,\%tvars);
				$vars = {%{$vars},%avars };
			}
			# If an array gets assigned to and returned but does not depend on inputs, we need to make sure it is also in links
			if (scalar keys %{$vars} == 0) {
				$links->{$some_var}{'!'.$some_var.'!'}=1;
			}
			for my $var ( keys %{$vars} ) {
				# WV 2021-05-19 FIXME: should I use the Deps from the LoopIter analysis?
				next if $Config{'KERNEL'} ne '' and $var=~/_rel|_range/;
				next if exists $links->{$some_var}{$var};
#				next if $var eq $some_var;
				if (isArg($stref, $f, $var)) {
					# look up Dim for $var
					my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Args'},$var);
					my $dim = scalar @{ $decl->{'Dim'} };
					if ($dim>0 && $dim == $lhs_dim) {
#						die "<$dim>" if $var eq 'pz' or $some_var eq 'pz';
#						say "LINK $some_var => $var";
						$links->{$some_var}{$var}=1;
					} else {
						$links->{$some_var}{$var}=2;
					#	this is an arg but it is not the right Dim, so ignore it
					}
				} else { # var not arg
#					say "VAR $var IS NOT ARG";
					$links->{$some_var}{$var}=4 ;
					if (exists $assignments->{$var} ) {
						my $non_arg_rhs_array = $assignments->{$var};
						my $rhs_vars = {};
						for my $non_arg_rhs (@{ $non_arg_rhs_array }) {
							my %tvars =  %{ get_vars_from_expression($non_arg_rhs,{}) };
							my %avars = _remove_index_vars($stref,$f,$block_id,$state,\%tvars);
							$rhs_vars = {%{$vars},%avars };
						}
#						say Dumper($non_arg_rhs);
#						my $rhs_vars = get_vars_from_expression($non_arg_rhs,{});
						for my $rhs_var (keys %{$rhs_vars}) {
#							say "VAR in RHS of NON-ARG assignment for $var: $rhs_var";
							next if exists $links->{$var}{$rhs_var};
							$links->{$var}{$rhs_var}= isArg($stref, $f, $rhs_var) ? 2 : 3 ;
#							next if $var eq $rhs_var;
			 				$links=_link_writes_to_reads_rec($stref, $f, $block_id, $rhs_var,$assignments,$links,$state);
						}
					}
				}
			}
		}
 		return $links;
} # END of _link_writes_to_reads_rec()

sub isArg { (my $stref, my $f, my $array_var)=@_;

	if ( in_nested_set($stref->{'Subroutines'}{$f},'Args',$array_var)) {
		return 1;
	} else {
		return 0;
	}
}

# TODO I should split out the code generation and emitter
=pod _classify_accesses_and_emit_AST

This routine does not modify $state; it modifies $stref by creating $stref->{UniqueVarCounters}

However, it does perform analysis:
For every $array_var in  $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}} it does the following:
- It populates $stref->{'UniqueVarCounters'}. We use this to keep track of accesses to a variable for the purpose of creating unique names for TyTraCL
- It tests if the access pattern for $array_var is a proper stencil:
	- There is more than one access to an array, this is determined from $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}, see _find_var_access_in_ast()
	- At least one of these accesses has a non-zero offset, this is determined from $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}
	- All points in the array are processed in order, this is determined by checking $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'} for '?', see _find_iters_in_array_idx_expr()
	There outcome is put in %stencils (1 or 0)
- It tests for partial acccesses, to be used for boundary condition processing. This is incomplete.

The routine uses a custom emitter (in practice either for TyTraCL or TyTraIR) passed in via $stref->{$stref->{'EmitAST'}}
This "emitter" creates the AST used for the target
=cut
sub _classify_accesses_and_emit_AST { (my $stref, my $f, my $state ) =@_;
# 	say "SUB $f\n";
    my $block_id=0; # TODO
    my $emit_ast = 0;
    my $ast_to_emit={};
	my $ast_emitter = sub {};
    if (exists $stref->{'EmitAST'}) {
    	$emit_ast = 1;
    	my $ast_name = $stref->{'EmitAST'};
    	$ast_to_emit=$stref->{$ast_name};
    	$ast_emitter = $stref->{$ast_name}{'ASTEmitter'};
    }

	my @selects=(); # These are portions of an array that are selected, we need an `select` primitive
 	my @inserts=(); # This is when a portion of an array is inserted, we need an `insert` primitive
	my %stencils=(); # The `stencil` call
	my %non_map_args=();
	my %portions=();

	$ast_to_emit = $ast_emitter->( $f,  $state,  $ast_to_emit, 'INIT_AST') if $emit_ast;

 	for my $array_var (keys %{$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}}) {
		 # Excluding arrays that are not streams here is OK, that way I get no stencil and they become SVecs in TyTraCL.pm

		# This is specific for reductions done by the AutoParallelFortran compiler
		# But I don't know in which case we analyse the generated files
		# $Config{'KERNEL'} ne '' means OpenCL so in practice it is our OpenCL from the AutoParallelFortran compiler
 		next if $Config{'KERNEL'} ne '' and $array_var =~/^global_|^local_/;
 		next if not defined  $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'} ;
		next unless _is_stream_var($state, $f, $block_id, $array_var);
		# So there the $array_var is certainly (or at least per def) a stream variable
		$stref->{'Subroutines'}{$f}{'StreamVars'}{$array_var}={};
$state->{'Subroutines'}{ $f }{'StreamVars'}{$array_var}={};
		$ast_to_emit = $ast_emitter->( $f,  $state,  $ast_to_emit, 'INIT_COUNTERS',  $block_id,  $array_var) if $emit_ast;
 		for my $rw ('Read','Write') {
 			if (exists  $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw} ) {
 				# because it could be read-only and even write-only: v = u+w
 				my $n_accesses  =scalar keys %{$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'} } ;
 				my @non_zero_offsets = grep { /[^0]/ } keys %{$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'} } ;
 				my $n_nonzeroffsets = scalar  @non_zero_offsets ;
 				my @qms = grep { /\?/ } @{ $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'} };
 				my $all_points = scalar @qms == 0;
				#* It is a "true" stencil if:
				if(
				#- there is more than one access to an array
				$n_accesses > 1 and
				#- at least one of these accesses has a non-zero offset
					$n_nonzeroffsets > 0 and
				#- all points in the array are processed in a certain order
					$all_points
					) {
				 		$ast_to_emit = $ast_emitter->( $f,  $state,  $ast_to_emit, 'STENCIL',  $block_id,  $array_var,  $rw) if $emit_ast;
						$stencils{$array_var}=1;
					}

#					if(  $n_accesses > 0
#				#- there is more than one access to an array =>
#					 and
#				#- at least one of these accesses has a non-zero offset
#					$n_nonzeroffsets == 0 and
#				#- all points in the array are processed in order
#					$all_points
#					) {
##						say "single access for $rw of $array_var (info only)";
#					}

				if (not $all_points) {
					if ($rw eq 'Read') {
#						say "SELECT for $rw of $array_var";
						push @selects,$array_var;
						$ast_to_emit = $ast_emitter->( $f,  $state,  $ast_to_emit, 'SELECT',  $block_id,  $array_var,  $rw) if $emit_ast;

						$portions{$array_var}=1;
					} else {
#						say "INSERT for $rw of $array_var";
						push @inserts, $array_var;
						$ast_to_emit = $ast_emitter->( $f,  $state,  $ast_to_emit, 'INSERT',  $block_id,  $array_var,  $rw) if $emit_ast;
					}
				} else {
					if ($rw eq 'Read') {

					}

				}
			}
		}
	}

	$ast_to_emit = $ast_emitter->( $f,  $state, $ast_to_emit, 'MAP', $block_id) if $emit_ast;
	# carp Dumper $ast_to_emit ;
	return $stref ;
} # END of _classify_accesses_and_emit_AST()

## What we need is the in and out tuples
## i.e. keys %{$links} = OUT
## union of vals is IN
#sub pp_links { (my $links)=@_;
#	my $in_tup_table={};
#	for my $lhs_var (sort keys %{$links}) {
##		print "$lhs_var => ";
#		my @rhs_vars=();
#		for my $lvar (sort keys %{$links->{$lhs_var}} ){
#			push @rhs_vars,$lvar;
#			$in_tup_table->{$lvar}=1;
#		}
##		say join(', ',@rhs_vars);
#	}
#	my $out_tup = [ sort keys  %{$links} ];
#	my $in_tup = [ sort keys  %{$in_tup_table} ];
#	return ($out_tup, $in_tup);
#} # END of pp_links()


sub _eval_expression_w_params { (my $expr_str,my $info, my $stref, my $f, my $block_id, my $state) = @_;
# carp Dumper $expr_str;
    my $expr_ast=parse_expression($expr_str,$info, $stref,$f);
    my $expr_ast2 = replace_param_by_val($stref, $f, $block_id,$expr_ast, $state);
    my $evaled_expr_str=emit_expr_from_ast($expr_ast2);
    my $expr_val=eval($evaled_expr_str);
	return $expr_val;

} # END of _eval_expression_w_params()


sub _collapse_links { (my $stref, my $f, my $block_id, my $links)=@_;

	for my $var (keys %{$links}) {
		if (isArg($stref, $f, $var)) {
			my $deleted_entries={};
			my $again=1;
			do {
					$again=0;
					for my $lvar (keys %{ $links->{$var} } ) {
						next if $lvar eq $var;
						if ($links->{$var}{$lvar} > 2) { # Not an argument
							$again=1;
							delete $links->{$var}{$lvar};
							$deleted_entries->{$lvar}=1;
							for my $nlvar (keys %{ $links->{$lvar} } ) {
								next if $nlvar eq $var;
								next if $nlvar eq $lvar;
								next if exists $deleted_entries->{$nlvar};
								$links->{$var}{$nlvar} = $links->{$lvar}{$nlvar};
							}
						}
					}
			} until $again == 0;
		}
	}
	return $links;
} # END of _collapse_links()

sub _remove_index_vars { (my $stref, my $f, my $block_id, my $state, my $vars_ref)=@_;
	my %vars = %{$vars_ref};
    my %non_idx_vars=();
    my %idx_vars=();
	for my $var (keys %vars ) {
		if ($vars_ref->{$var}{'Type'} eq 'Array') {
			for my $rw ('Read','Write') {
				if (exists $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$var}{$rw} and
				exists $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$var}{$rw}{'Iterators'}
				) {
				my @iters = @{$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$var}{$rw}{'Iterators'}};
				%idx_vars = (%idx_vars, map { $_=~s/:\d//; $_ => 1 } @iters);
				}
		}
	}
	}
	for my $var (keys %vars ) {
		if (not exists $idx_vars{$var}) {
			$non_idx_vars{$var}->{'Type'} = $vars_ref->{$var}{'Type'};
		}
	}
	return %non_idx_vars;
}

sub __mkLoopId { (my $loop_nest_stack ) =@_;
    my $loop_id = join(':', reverse map {$_->[0]} @{$loop_nest_stack});
    croak if $DBG and $loop_id eq '';
    return $loop_id;
}

sub F3D2C { (
         my $i_rng, my $j_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, # lower bounds
        my $ix, my $jx, my $kx
        ) =@_;
    return ($i_rng*$j_rng*($kx-$k_lb)+$i_rng*($jx-$j_lb)+$ix-$i_lb);
}

sub F2D2C { (
         my $i_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, # lower bounds
        my $ix, my $jx
        ) =@_;
    return ($i_rng*($jx-$j_lb)+$ix-$i_lb);
}


sub F1D2C { (
        my $i_lb, #// lower bounds
        my $ix
        ) = @_;
    return $ix-$i_lb;
}

sub F4D2C { (
         my $i_rng, my $j_rng,  my $k_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, my $l_lb, # lower bounds
        my $ix, my $jx, my $kx, my $lx
        ) = @_;
    return ($i_rng*$j_rng*$k_rng*($lx-$l_lb)+
            $i_rng*$j_rng*($kx-$k_lb)+
            $i_rng*($jx-$j_lb)+
            $ix-$i_lb
            );
}

# Halo access detection
# The main purpose is to detect writes to halos, because reads are never a problem
# For the purpose of dividing the domain (e.g. chunking on GPU, or MPI) we need the read accesses to ensure that no read occurs outside the chunk visible to the process.
# So first we must detect if a given access is inside a halo
# Then we need to decide what to do about it.
# Let's first look if an LHS write requires an opposite bound for the RHS read
# So what we need is a record of the array access, we put this in HaloAccesses

sub _detect_halo_accesses {
	(my $line, my $lhs_accesses, my $rhs_accesses, my $state, my $block_id, my $stref, my $f) = @_;
	if (exists $lhs_accesses->{'Arrays'}) {

		for my $array_var (keys %{ $lhs_accesses->{'Arrays'} } ) {
			my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Vars'},$array_var);
			if (exists $decl->{'Halos'}) { # otherwise no point in doing this
				say "SUB $f VAR: $array_var " if $DBG;
				my ($expr_id,$expr_recs ) = %{ $lhs_accesses->{'Arrays'}{$array_var}{'Write'}{'Accesses'} };
				my $idx=0;
				for my $expr_rec (@{$expr_recs}) { # i.e. i,j,k
					my ($loop_iter_pos, $offset_t) = %{$expr_rec};
					my ($loop_iter,$pos) = split(/:/,$loop_iter_pos);
					my $offset=$offset_t->[1];
					for my $b (0,1) { # $b is the bound index
						say "LOOP ITER: $loop_iter" if $DBG;
						say Dumper($state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}) if $DBG;
						# This is the loop bound
						my $loop_bound = $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{$loop_iter}{'Range'}[$b];
						if (substr($loop_iter,0,1) eq '?') {$loop_bound=0;}
						my $expr_loop_bound = $loop_bound+$offset;
						my $array_bound = $state->{'Subroutines'}{ $f }{'Blocks'}{ 0 }{'Arrays'}{$array_var}{'Dims'}[$idx][$b];
						my $array_halo = 0;
						if (exists $decl->{'Halos'}) {
							$array_halo = $decl->{'Halos'}[$idx][$b];
						} else {
							croak "WARNING: NO halo attribute for $array_var" if $W;
						}
						my $in_halo = $b ?
						($expr_loop_bound > $array_bound - $array_halo) ? 1 : 0
						: ($expr_loop_bound < $array_bound + $array_halo) ? 1 : 0;
						if ($in_halo ) {
						my $in_halo_expl = $b ?
						($expr_loop_bound > $array_bound - $array_halo) ? "upper bound and highest access is outside core: $expr_loop_bound > ".($array_bound - $array_halo) : ''
						: ($expr_loop_bound < $array_bound + $array_halo) ? "lower bound and lowest access is outside core: $expr_loop_bound < ".($array_bound + $array_halo) : '';
						if ($DBG) {
						say "SUB $f LINE	$line";
						say "HALO CHECK: Write access to $loop_iter".($offset ?$offset:'')." in $array_var is ". ($in_halo ? '' : 'not ').'a halo access for the '. ($b ? 'upper' : 'lower').' bound: '.$in_halo_expl ;
						}
							# The test is
							# Lower: $loop_bound + $offset < $array_bound + $array_halo
							# Upper: $loop_bound + $offset > $array_bound - $array_halo
							$lhs_accesses->{'Arrays'}{$array_var}{'Write'}{'HaloAccesses'}{$loop_iter}={'Bound' =>$b, 'Test' => [$loop_bound, $offset, $array_bound, $array_halo]};
							$lhs_accesses->{'HasHaloAccesses'}=1;
						}
					}
					$idx++;
				}
			} # if the array has a halo annotation
		}
	}
	# This is for completeness mainly
	if (exists $rhs_accesses->{'Arrays'}) {

		for my $array_var (keys %{ $rhs_accesses->{'Arrays'} } ) {
			my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Vars'},$array_var);
			if (exists $decl->{'Halos'}) { # otherwise no point in doing this
#			say "SUB $f VAR: $array_var ";
				my ($expr_id,$expr_recs ) = %{ $rhs_accesses->{'Arrays'}{$array_var}{'Read'}{'Accesses'} };
				my $idx=0;
				for my $expr_rec (@{$expr_recs}) { # i.e. i,j,k
					my ($loop_iter_pos, $offset_t) = %{$expr_rec};
					my ($loop_iter,$pos) = split(/:/,$loop_iter_pos);
					my $offset=$offset_t->[1];
					for my $b (0,1) { # $b is the bound index
	#			    	say "LOOP ITER: $loop_iter";
	#			    	say Dumper($state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'});
						# This is the loop bound
						my $loop_bound = $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}{$loop_iter}{'Range'}->[$b];
						if (substr($loop_iter,0,1) eq '?') {$loop_bound=0;}
						my $expr_loop_bound = $loop_bound+$offset;
	#			        say "EXPR: $expr_m ";
						my $array_bound = $state->{'Subroutines'}{ $f }{'Blocks'}{ 0 }{'Arrays'}{$array_var}{'Dims'}[$idx][$b];
	#			        say  "BOUND: $array_bound" ;
						my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Vars'},$array_var);
	#			        say Dumper($decl);
	#			        my $decl = $stref->{'Subroutines'}{ $f }{'Vars'}{$array_var}{'Halos'}[$idx][$b];

						my $array_halo = 0;
						if (exists $decl->{'Halos'}) {
							$array_halo = $decl->{'Halos'}[$idx][$b];
						} else {
							say "WARNING: NO halo attribute for $array_var" if $W;
						}

	#			        say "HALO: $array_halo";
						my $in_halo = $b ?
						($expr_loop_bound > $array_bound - $array_halo) ? 1 : 0
						: ($expr_loop_bound < $array_bound + $array_halo) ? 1 : 0;
						if ($in_halo ) {
						my $in_halo_expl = $b ?
						($expr_loop_bound > $array_bound - $array_halo) ? "upper bound and highest access is outside core: $expr_loop_bound > ".($array_bound - $array_halo) : ''
						: ($expr_loop_bound < $array_bound + $array_halo) ? "lower bound and lowest access is outside core: $expr_loop_bound < ".($array_bound + $array_halo) : '';

	#			        say "SUB $f LINE	$line";
	#			        say "HALO CHECK: Read access to $loop_iter".($offset ?$offset:'')." in $array_var is ". ($in_halo ? '' : 'not ').'a halo access for the '. ($b ? 'upper' : 'lower').' bound: '.$in_halo_expl ;

							# The test is
							# Lower: $loop_bound + $offset < $array_bound + $array_halo
							# Upper: $loop_bound + $offset > $array_bound - $array_halo
							$rhs_accesses->{'Arrays'}{$array_var}{'Read'}{'HaloAccesses'}{$loop_iter}={'Bound' =>$b, 'Test' => [$loop_bound, $offset, $array_bound, $array_halo]};
							$rhs_accesses->{'HasHaloAccesses'}=1;
						}
					}
					$idx++;
				}
			} # if the array has a halo annotation
		}
	}
	return [$lhs_accesses, $rhs_accesses];

} # _detect_halo_accesses

# TODO: this is unfinished, it currently returns nothing!
#For every line with Write accesses to the halo, i.e. in $lhs_accesses
#- find all dependencies on that line
#- look at any assignment line before that, and if the LHS is a dep, add it to a list.
#- Somewhere in the end we must then merge all these lists so we'll need to keep them in order
#- So I think tagging the lines is better
#- And do this for downstream as well. So I guess I go through all lines, which means I need the LineID in the accesses as well
sub _collect_dependencies_for_halo_access { (my $stref, my $f) = @_;
	my $annlines = $stref->{'Subroutines'}{$f}{'RefactoredCode'};
	my $annline_ctr=0;
	for my $annline (@{$annlines}) {
		my ($line, $info) = @{$annline};

		if (exists $info->{'Assignment'} and exists $info->{'Lhs'} and exists $info->{'Lhs'}{'VarAccesses'} and exists $info->{'Lhs'}{'VarAccesses'}{'HasHaloAccesses'}) {
			$info->{'HaloAccess'}=1;
			say "HALO "."\t".$line if $DBG;
			# OK, a line with a halo access was found. From here, go up
			# So we must make an inventory of
			# (1) all vars on the RHS
			# (2) all vars that are not the actual array var, on the LHS
			# For each of these we must see if it is assigned to on the LHS of a preceding line.
			# If so, must repeat this do this for that line itself; otherwise we can of course ignore it.
			my ($array_var, $array_var_rec) = %{$info->{'Lhs'}{'VarAccesses'}{'Arrays'}};
			my $rhs_vars = get_vars_from_expression($info->{'Rhs'}{'ExpressionAST'});
			if (not defined $rhs_vars) {
				$rhs_vars={};
			}
			my $lhs_vars = get_vars_from_expression($info->{'Lhs'}{'ExpressionAST'});
			delete $lhs_vars->{$array_var};
			my %halo_deps=( %{$rhs_vars}, %{$lhs_vars} );
			say 'HALO DEPS: '.join(', ',keys %halo_deps) if $DBG;
			for my $annline_idx ( 0 .. $annline_ctr-1 ) {

				my $rev_annline_idx =  $annline_ctr - 1 - $annline_idx;
				my $prec_annline =   $annlines->[$rev_annline_idx];
				my ($prec_line, $prec_info) = @{$prec_annline};

				if (exists $prec_info->{'Assignment'}) {
					say "PREC:".$prec_line if $DBG;
					my $lhs_vars = get_vars_from_expression($prec_info->{'Lhs'}{'ExpressionAST'});

					my $lhs_assigned_var =  $prec_info->{'Lhs'}{'VarName'};
					say "LHS VAR:".$lhs_assigned_var  if $DBG;
					# But really this should not be array indices, only proper assigned vars!
					if (exists $halo_deps{$lhs_assigned_var} ) {
						$prec_info->{'HaloDep'}=1;
						say "Halo access $array_var depends on line $prec_line" if $DBG;
					}
					if (exists $prec_info->{'HaloDep'}) {
						my $rhs_vars = get_vars_from_expression($prec_info->{'Rhs'}{'ExpressionAST'});

						if (not defined $rhs_vars) {
							$rhs_vars={};
						}
						say "RHS VARS: ". join(', ',keys %{$rhs_vars}) if $DBG;
						%halo_deps=( %halo_deps, %{$rhs_vars}, %{$lhs_vars} );
					}
				} # TODO: later we must extend this to subroutine calls as well
				$prec_annline=[$prec_line,$prec_info];
				$annlines->[$rev_annline_idx]=$prec_annline;
			}
		}
		$annline_ctr++;
	}
	return $stref;
}

# This routine will emit the Main for the AST based on ASTEmitter if EmitAST exists
# Otherwise it does nothing.
sub _emit_AST_Main {(my $stref, my $f) =@_;
	my $emit_ast = 0;
    my $ast_to_emit={};
	my $ast_emitter = '';
    if (exists $stref->{'EmitAST'}) {
    	$emit_ast = 1;
    	my $ast_name = $stref->{'EmitAST'};
    	$ast_to_emit=$stref->{$ast_name};
    	$ast_emitter = $stref->{$ast_name}{'ASTEmitter'};
    }

	$ast_to_emit = $ast_emitter->( $f,  $stref,  $ast_to_emit, 'MAIN',  '',  '',  '') if $emit_ast;

	return $stref;
}


#So, for all entries in ArrayAssignments
#
#- Get the information from the LHS, i.e. change the above into [[$m0,$o0],[$m1,$o1]]
#- For the RHS, first make a list of all arrays being accessed, i.e. keys %{$entry->[1]{'Arrays'}}

# 'Arrays' => {
#    'v' => {
#      'Write' => {
#        'Exprs' => {
#          'v(j,0)' => '0:0'
#        },
#        'Accesses' => {
#          '0:0' => [
#            {
#              'j:0' => [
#                1,
#                0
#              ]
#            },
#            {
#              '?1' => [
#                0,
#                0
#              ]
#            }
#          ]
#        }
#      }
#    }
#  }
#

=info boundary_buffers
I think I will test `extract` by making it work for all boundary buffers, even the ones that could in principle be stencils.
So we restrict the array assignments so that
- one of the indices can be a constant, i.e. coded as '?:x'
- LHS and all arrays on RHS must have the same value for x

Then we must create a pattern for the buffer to be extracted, i.e. the non-constant imdices are to be replace by their ranges.
If the boundary is more than one point, then we must create ranges for the constant points as well.
What we want ultimately is a list of all indices to be extracted:

extract :: k<n => SVec k Int -> Vec n a -> Vec k a

but in TyTraCL we only need the total size of the extracted SVec, i.e. `k`

=cut
# In principle $f can contain several blocks (loop nests) with independent array accesses, so I need to iterate over these.
# For the OpenCL used as starting point for TyTraCL, there is always only one block per function anyway.
# What we should record is, for a given block in a given function, the name of the array, the set of index_pos, index_offset for that array, and the range for the non-constant indices
# That means I'd better include the non-constant indices somewhere as well
sub _identify_boundary_accesss { my ($state, $f) = @_;
    my $boundary_accesss={};
    #say Dumper(keys %{ $state->{'Subroutines'}{ $f }{'Blocks'}});

    for my $block_id (keys %{ $state->{'Subroutines'}{ $f }{'Blocks'} }) {
        say "Analysing function $f, block $block_id for boundary accesses";# if $V;
        #say Dumper(keys %{ $state->{'Subroutines'}{ $f }{$block_id}});
        $boundary_accesss->{$block_id}={};

        for my $entry (@{ $state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'ArrayAssignments'} }) {
            my $lhs = $entry->[0];
            #my @lhs_array_var_a = keys %{ $lhs->{'Arrays'} };
            #my $lhs_array_var = shift @lhs_array_var_a;
            #my $lhs_array_var_rec =$lhs->{'Arrays'}{$lhs_array_var};
            my ($lhs_array_var,$lhs_array_var_rec ) = %{ $lhs->{'Arrays'} };
            my $lhs_access_tuples = __get_access_tuples($lhs_array_var_rec->{'Write'}{'Accesses'});
            # There can only be one!
            my $lhs_access_tuple = shift @{$lhs_access_tuples};
            #say "$f ". $entry->[2].Dumper($lhs_access_tuple),' ',__PACKAGE__,' ',__LINE__;
            # Now check if this meets the criterion of only one constant index
            my ($lhs_const_accesses,$lhs_non_const_accesses) = @{ __split_out_const_accesses ($lhs_access_tuple) };
            my $lhs_is_boundary_access=0;
            my $lhs_bounday_index = -1; # i.e. there isn't any
            if (scalar @{$lhs_const_accesses} == 1) {
                $lhs_is_boundary_access=1;
                my ($lhs_bounday_index_pos, $lhs_bounday_index_offset) = @{$lhs_const_accesses->[0]};
                #                say "$f: LHS has boundary access for index $lhs_bounday_index_pos with value $lhs_bounday_index_offset on LINE ".$entry->[2];

                # At this point we know that the LHS is a valid boundary access.
                # Now look at the RHS. This is an expression which can have multiple accesses for multiple arrays.
                my $rhs = $entry->[1];
                my @rhs_array_vars = keys %{$rhs->{'Arrays'}};
                # Check for every array
                for my $rhs_array_var (@rhs_array_vars) {

                    my $rhs_access_tuples = __get_access_tuples($rhs->{'Arrays'}{$rhs_array_var}{'Read'}{'Accesses'});
                    # Now for ever one of these access tuples, I have to do the same check as above but it must match the LHS index position as well
                    for my $rhs_access_tuple (@{ $rhs_access_tuples }) {
                        my ($rhs_const_accesses, $rhs_non_const_accesses) = @{ __split_out_const_accesses ($rhs_access_tuple) };
                        my $rhs_is_boundary_access=0;
                        my $rhs_bounday_index = -1; # i.e. there isn't any
                        if (scalar @{$rhs_const_accesses} == 1) {
                            $rhs_is_boundary_access=1;
                            my ($rhs_bounday_index_pos,$rhs_bounday_index_offset) = @{$rhs_const_accesses->[0]};
                            if ($rhs_bounday_index_pos == $lhs_bounday_index_pos) {
                                if (not exists $boundary_accesss->{$block_id}{$rhs_array_var}) {
                                    $boundary_accesss->{$block_id}{$rhs_array_var}={};
                                }
                                #say "$f: LINE ".$entry->[2]." has ";
                                print "FOUND boundary access for $rhs_array_var for index pos $rhs_bounday_index_pos with offset $rhs_bounday_index_offset; ";
                                my $const_id="$rhs_bounday_index_pos:$rhs_bounday_index_offset";
                                my $const_rec=[$rhs_bounday_index_pos,$rhs_bounday_index_offset];
                                my $ordered_rec=[];
                                $ordered_rec->[$rhs_bounday_index_pos]=[$rhs_bounday_index_offset];
                                #say "The non-constant iterators are:";
                                my $non_const_id='';
                                my $non_const_recs=[];
                               for my $rhs_non_const_access (@{$rhs_non_const_accesses}) {
                                   my ($pos, $mult_offset_iter_pos) = @{ $rhs_non_const_access};
                                   my ($mult,$offset, $iter_pos) = @{$mult_offset_iter_pos};
                                   my ($iter,$pos_) = split(/:/,$iter_pos);
                                  warn "iter $iter at pos $pos with mult $mult and offset $offset";
                                  #$boundary_accesss->{$block_id}{$rhs_array_var}{'NonConst'}{"$iter_pos:$mult:$offset"}=[$iter,$pos,$mult,$offset];
                                   $non_const_id .= "$iter_pos:$mult:$offset";
                                   my $non_const_rec =[$iter,$pos,$mult,$offset];
                                   $ordered_rec->[$pos]=[$iter,$mult,$offset];
                                   push @{$non_const_recs},$non_const_rec;
                               }
                               $boundary_accesss->{$block_id}{$rhs_array_var}{"$const_id:$non_const_id"}=$ordered_rec;#{'Const' => $const_rec,'NonConst'=>$non_const_recs};
                                   # Any offsets are of course to be taken into account when calculating the final range

                            }
                        }
                    }

                    # Here I can do the maths and create the final stencil for each array var, put them in a table and return them
                    #my $current_stencil=[];
                    # As this works on a per-array basis, we need to merge each new stencil into the existing one. The best way I guess is to serialise them
                    #$boundary_accesss->{$block_id}{$rhs_array_var}=__build_boundary_access($boundary_accesss->{$block_id}{$rhs_array_var}, $current_stencil);
                }
            }
        }
        # What remains to be done is merge the constant accesses, e.g. if we have v(0,j) and v(1,j) then the buffer should be 0..1 x range of j
        # Of course if we don't do this we simply get an individual buffer for each access
        # Maybe I should already do that as a first step
        # The next step is to get the actual range for a given iterator.
        # However we can alread emit the required TyTraCL buffers: we create a buffer for every const for every array
        # I wonder if we can't simply do something based on string substitution:
        #  if k == 0 v = v_jp1_1
        #  if k==0 v = v_jp1_0+v_jm1_0
        #  if j==1 u = u_501_k
        #  if j==ny u = u_0_k+u_1_k+un_1_k
        #  it means that for non-0 offset, a non-const pos offset becones p$offset, a neg offset m$offset, consts stay as they are, we join with _
        #
        __generate_buffer_varnames( $boundary_accesss, $block_id );


    }

    say "DONE Analysing function $f for boundary accesses";# if $V;
    #    say Dumper($boundary_accesss);

    return $boundary_accesss;
} # END of _identify_boundary_accesss

=info
 '0:0' => [
    {
      'j:0' => [
        1,
        0
      ]
    },
    {
      '?:1' => [
        0,
        0
      ]
    }
  ]

  '0:0' => [
    {
      '?:0' => [
        0,
        0
      ]
    },
    {
      'k:1' => [
        1,
        0
      ]
    }
  ]
=cut
# This returns a list of (mult, offset) pairs for each access, i.e. [ [ [m11,o11,'i:0'],[m12,o12,'j:1'] ] , [ [m21,o21],[m22,o22] ] ]
sub __get_access_tuples { (my $array_var_rec) = @_;
    #    say Dumper($array_var_rec);
	my $ordered_tuples=[];
	for my $k (keys %{ $array_var_rec } ) { # e.g. '0:0' above
		my $pairs = $array_var_rec->{$k};
		my $ordered_tuple=[];

		for my $pair (@{$pairs}) {
            #my @iter_pos_array =  keys %{$pair};
            #my $iter_pos  = shift @iter_pos_array;
            #my $mult_offset = $pair->{$iter_pos};
            my ( $iter_pos,$mult_offset) = %{$pair};
            #             croak Dumper($iter_pos,$pair, $pairs) if not defined $iter_pos;

             (my $iter, my $pos) = split(/:/,$iter_pos);
             #             say "$iter $pos".' '.$mult_offset->[0].','.$mult_offset->[1],' ',__PACKAGE__,' ',__LINE__;
			 $ordered_tuple->[$pos]=[@{$mult_offset},$iter_pos];
		}
		push @{$ordered_tuples},$ordered_tuple;
	}
	return $ordered_tuples;
}
# [ [mult_i,offset_i, 'i:0'],[mult_j,offset_j,'j:1'],...]
# returns a lists of [idx_pos, offset] for const accesses
sub __split_out_const_accesses { (my $access_tuple ) = @_;
    my $const_accesses=[];
    my $non_const_accesses=[];
    for my $idx_pos (0 .. scalar @{ $access_tuple } - 1) {
            if ($access_tuple->[$idx_pos][0] == 0) {
                push @{$const_accesses}, [$idx_pos,$access_tuple->[$idx_pos][1]];
            } else {
                push @{$non_const_accesses}, [$idx_pos,$access_tuple->[$idx_pos]];
            }
    }
    return [$const_accesses,$non_const_accesses];# ( scalar @const_accesses  == 1) ? 1 : 0;

} # END of __split_out_const_accesses

sub __build_boundary_access { (my $boundary_access, my $partial_stencil);
    # TODO
	return $boundary_access;
}


# This code is rather TyTra-specific. Still, for OpenCL with pipes, if we would use constant buffers, we would be using the same names
# But this is actually already generation, not analysis so maybe in Translation/Common?

# # If we had access to the type decls and ranges here we could generate the types as well
# 'Dims' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'}
# The types are via the var decl records
sub __generate_buffer_varnames { my ( $boundary_accesss, $block_id ) = @_;

    for my $array_var (keys %{ $boundary_accesss->{$block_id} } ) {
        my $buffer_varnames=[];
        for my $access_id (keys %{ $boundary_accesss->{$block_id}{$array_var} } ) {
            my $ordered_rec = $boundary_accesss->{$block_id}{$array_var}{$access_id};
            my @chunks=($array_var);
            for my $entry ( @{$ordered_rec}) {
                    if (scalar @{$entry} == 1) {
                        push @chunks, $entry->[0];
                    } else {
                        (my $iter, my $mult, my $offset) = @{$entry};
                        $iter = $mult == 1 ? $iter : "$mult*$iter";
                        $iter = $offset == 0 ? $iter : $offset < 0 ? "${iter}m".abs($offset) :  "${iter}p$offset";
                        push @chunks,$iter;
                    }
            }

           my  $var_name_str = join('_',@chunks);
            say $var_name_str;
            my $patt = $var_name_str.'_patt';
            say " $var_name_str :: Vec PATT_SZ ORIG_ARRAY_TYPE";
            say " $patt :: SVec PATT_SZ Int";
            say  "$var_name_str = extract $patt $array_var";
        }

    }

}


sub _is_stream_var { my ($state, $f, $block_id, $var_name) =@_;
# carp "$f, $block_id, $var_name";
	if ($Config{'KERNEL'} eq ''
		and
		$block_id == 0) {
			# This is the subroutine block, so in this block there are no loop iterators
			# unless this subroutine is an OpenCL kernel
		return 0;
	}
	  # Get the record for $var_name
	#   carp "$f $block_id $var_name", Dumper $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id };
	  croak "PROBLEM: NO LoopIters for block $block_id in $f" if not exists $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'LoopIters'};
	  my $iters =  $state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'LoopIters'};
	  my $n_iters = scalar keys %{$iters};
	  my $used_iters = __get_used_iters($var_name, $state, $f, $block_id);
	  my $n_used_iters = scalar keys %{$used_iters};
	  my $dims = $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$var_name}{'Dims'} ;
	#   carp $var_name.Dumper($dims,$iters);
	# carp Dumper $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id };
	  if (scalar @{$dims} < scalar keys %{$iters}) {
		  say "$f $var_name dim mismatch" if $V;
		  return 0;
	  }
	  elsif ($n_used_iters<$n_iters) {
		  return 0;
	  }
	  # If an array dim is smaller than the range for iteration, it can't be a stream. But in OpenCL we don't really know the iterange range
	  # Unless we would rely on _range, which is OK for our approach.
	  # If an array only has const accesses, it can't be a stream
	  elsif (__only_const_acccesses($var_name, $state, $f, $block_id) ) {
			return 0;
	  } else {
		  # needs more checking of the sizes but a global size comp should do it I think
		  # Also, this only works if there is one iter per dim
		  my $iter_space=1;
		  my $array_sz=1;
		  my $ok=1;
		  my $ii=0;
		  for my $iter (sort keys %{$iters}) {
			  my $range = $iters->{$iter}{'Range'};
			  my $range_sz = $range->[1] - $range->[0] +1;
			  my $dim = $dims->[$ii];++$ii;
			  my $dim_sz = $dim->[1] - $dim->[0] +1;
				$ok*= ($dim_sz > $range_sz-6) ? 1 : 0; # AD HOC: 6-point halo ought to be rare!
			#   $array_sz*=$dim_sz;
			#   $iter_space*=$range_sz;
		  }
# carp "OK? $ok"; croak if $var_name eq 'w';

		  if ($DBG and not $ok) {
			  	croak  "ARRAY $var_name in $f IS SMALLER than iter space";
		  }
		  return $ok;
	  }
	  return 1;
} # END of _is_stream_var


sub __only_const_acccesses { my ($array_var, $state, $f, $block_id) = @_;
#  carp $array_var;
#  carp Dumper($state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}) if $array_var eq 'w2';
	for my $rw('Read','Write') {
		if (exists
			$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}
		) {
			my $iter_pairs = $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'};
			# croak $array_var.' BOOM!' . Dumper($iter_pairs) if $array_var eq 'w';

			for my $iter_pair (@{$iter_pairs})  {
				my ($iter,$idx) = split(/:/,$iter_pair);
				if ($iter ne '?') {
					return 0;
				}
			}
		}
	}

	return 1;
}

sub __get_used_iters {my ($array_var, $state, $f, $block_id) = @_;
my $used_iters={};
	for my $rw('Read','Write') {
		if (exists
			$state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}
		) {
			my $iter_pairs = $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Iterators'};
			# croak $array_var.' BOOM!' . Dumper($iter_pairs) if $array_var eq 'w';

			for my $iter_pair (@{$iter_pairs})  {
				my ($iter,$idx) = split(/:/,$iter_pair);
				if ($iter ne '?') {
					$used_iters->{$iter}=$idx;
				}
			}
		}
	}
	return $used_iters;
} # END of __get_used_iters
# sub __array_dim_too_small { my ($array_var, $state, $f, $block_id) = @_;

# }

1;


=info20170903
What we have now is for every array used in a subroutine, a set of all stencils (called 'Accesses', sorry!) with an indication if an access is constant or an offset from a given iterator.

    $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}{ join(':', @offset_vals) } = $iter_val_pairs;

Each iter val pair is of the form (String,(Int,Int)), the string is the iterator variable, the first elt in the tuple is the multiplier, the second the offset.

	{$iters[$idx] => [$mult_val,$offset_val]};

For example, and typical access record entry for a 2-D array looks like this:

	 '0:-1' => [
	    {
	      'j' => [
	        1,
	        0
	      ]
	    },
	    {
	      'k' => [
	        1,
	        -1
	      ]
	    }
	  ],


Now we have two use cases, one is OpenCL pipes and the other is TyTraCL
For the stencils where all accesses use an iterator we have

vs = stencil patt v
v' = map f vs

There are two other main use cases

1/ LHS and RHS are both partial, i.e. one or more index is constant.
We can check this by comparing the Read and Write arrays. For TyTraCL I think we want to generate code that will apply the map to the accessed ranges and keep the old values for the rest.
But I think this still means we have to buffer: if e.g. we have

v(0)=v(10)
v(1) .. v(8) unchanged
v(9)=v(1)
v(10) unchanged

then we need to construct a stream which reorders, so we'll have to buffer the stream until in this example we reach 10. That is not hard.
 Furthermore, we need to write the partial ranges out to this stream in order of access.
 As the stream is characterised by offsets, ranges and constants, this should be possible, but it is not trivial!

 For example

              u(ip,j,k) = u(ip,j,k)-dt*uout *(u(ip,j,k)-u(ip-1,j,k))/dxs(ip)
              v(ip+1,j,k) = v(ip+1,j,k)-dt*uout *(v(ip+1,j,k)-v(ip,j,k))/dxs(ip)
              w(ip+1,j,k) = w(ip+1,j,k)-dt*uout *(w(ip+1,j,k)-w(ip,j,k))/dxs(ip)

so we have
u
Write: [?,j,k] => [ip,0,0]
Read: [?,j,k] => [ip,0,0],[ip-1,0,0]

and
i: 0 :(ip + 1)
j: -1:(jp + 1)
k: 0 :(kp + 1)

So
if (i==ip) then
	! apply the old code, but a stream - scalar value of it
	u(ip,j,k) = u(ip,j,k)-dt*uout *(u(ip,j,k)-u(ip-1,j,k))/dxs(ip)
else
	! keep the old value
	u(i,j,k) = u(i,j,k)
end if

So I guess what we do is, we create a tuple:

u_ip_j_k, u_ipm1_j_k, u_i_j_k

To do so, we need to identify the buffer, i.e. points within the range
i: ip, ip-1 => this is a 2-point stencil
j: -1:(jp + 1)
k: 0 :(kp + 1)

Actually, by far the easiest solution would be to create this buffer and access it in non-streaming fashion.
The key problem however is that the rest of the stream can't be buffered in the meanwhile.

2/ LHS is full and RHS is partial, i.e. one or more index is constant on RHS. This means we need to replicate the accesses. But in fact, random access as in case 1/ is probably best.

In both cases, we need to express this someway in TyTraCL, and I think I will use `select` and `replicate` to do this.

The unsolved question here is: if I do a "select"  I get a smaller 1-D list. So in case 1/ I apply this list to a part of the original list, but the question is: which part?
To give a simple example on a 4x4 array I select a column
[0,4,8,12] and I want to apply this to either to the bottom row [12,13,14,15] or the 2nd col [1,5,9,13] of the original list.
We could do this via an operation `insert`

	insert target_pattern small_list target_list

Question is then where we get the target pattern, but I guess a start/stop/step should do:

for i in [0 .. 3]
	v1[i+12] = v_small[i]
	v2[i*4+1] = v_small[i]
end

This means for the select we had the opposite:

for i in [0 .. 3]
	v_small[i] = v[i*4+0]
end


So the question is, how do we express this using `select` ?


for i in 0 .. im-1
	for j in 0 .. jm-1
		for k in 0 .. km-1
			v(i,j,k) = v(a_i*i+b_i, a_j*j_const+b_j,k)

Well, it is very easy:

-- selection can work like this
select patt v = map (\idx -> v !! idx) patt

v' = select [ i*jm*km+j*km+k_const | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v

Key questions of course are (1) if we can parallelise this, and (2) what the generated code looks like.
(1) Translates to: given v :: Vec n a -> v" :: Vec m Vec n/m a
Then what is the definition for select" such that

v"' = select" patt v"

Is this possible in general? It *should* be possible, because what it means is that we only access the data present in each chunk.
The problem is that the index pattern is not localised, for example

v_rhs1 = select [ i*jm*km+j*km+k_const | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v
v_rhs2 = select [ i*jm*km+j_const*km+k | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v
v_rhs3 = select [ i_const*jm*km+j*km+k | i <- [0 .. im-1],  j <- [0 .. jm-1], k <- [0..km-1] ] v

So I guess we need to consider (2), how to generate the most efficient buffer for this.

The most important question to answer is: when is it a stencil, when a select, when both?

#* It is a stencil if:
#- there is more than one access to an array =>
#- at least one of these accesses has a non-zero offset
#- all points in the array are processed in order
* It is a select if:
- not all points in the array are covered, let's say this means we have a '?'
(this ignores the fact that the bounds might not cover the array!)

So if we have a combination, then we can do either
- create a stencil, then select from it
- create multiple select expressions

Crucially, a stencil is only really a stencil if the LHS and the RHS parts have the same number of points. I'm not sure if this really matters.

In any case, what we want to know is:
- is straight scalarisation OK for a given variable in a given subroutine
- which variables should become local arrays
- which variables need stencils
- which variables need select.

=cut



=pod WV 2021-05-18
- Find a call to get_global_id
call get_global_id(global_id,0)'
- Identify global id from the call arg, i.e. the first argument
$state->{'Deps'}{$gid}={};
- Find any Assignment where the LHS is a scalar and the RHS contains any Deps (OK, this is simplifying but I don't care)
- Add the LHS name to the deps
When we have done that, we have all potential candidates for loop iters.
- Find any Assignment where the LHS is an array and check if it uses any of the variables in Deps. If so, these are added to the LoopIters
- Find any Assignment where the RHS has array accesses and check if any use any of the variables in Deps. If so, these are added to the LoopIters

=cut

sub _get_loop_iters_from_global_id { my ($stref,$f) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $annlines = $Sf->{'RefactoredCode'};
	my $pass_get_loop_iters_from_global_id = sub { my ($annline,$state) = @_;
		my ($line, $info) = @{$annline};
		# WV20230426 I added this for OpenMP. It's a shortcut to identify the global iterator.
		# This is not generic! TODO!
		if (exists $info->{'Signature'} and exists $info->{'Signature'}{'Args'}{'Set'}
		and exists $info->{'Signature'}{'Args'}{'Set'}{'global_id'} ) {
				$state->{'Deps'}{'global_id'}=[];
		}
		elsif (exists $info->{'SubroutineCall'} and $info->{'SubroutineCall'}{'Name'} eq 'get_global_id') {
				my $gid_name = $info->{'SubroutineCall'}{'Args'}{'List'}[0];
				$state->{'Deps'}{$gid_name}=[];
		}
		elsif (exists $info->{'Assignment'} ) {
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar') { # Only then we check the RHS
					$state = __add_deps_from_RHS($state,$info);
			} else {
				# Check if the LHS uses any of the vars in Deps, if so it is a Loop Iter
				my $idx_vars = $info->{'Lhs'}{'IndexVars'}{'List'};
				for my $var ( @{$idx_vars} ) {
					if (exists $state->{'Deps'}{ $var }) {
						$state->{'LoopIters'}{$var}={'Range' => [0,0,0]};
					}
				}
			}
			# Check if the RHS uses any of the vars in Deps in array accesses
			$state = __find_loop_iter_access_in_ast($state, $info->{'Rhs'}{'ExpressionAST'});
		}
		return ([[$line,$info]],$state)
	};

	my $state = {'Deps' => {} , 'LoopIters'=> {} };

	(my $new_annlines,$state) = stateful_pass($annlines,$pass_get_loop_iters_from_global_id,$state,"pass_get_loop_iters_from_global_id($f)");

	# Adapt the Range for the LoopIters, this is used to decide if an array is a StreamVar
	# This is not good as it uses just any array, at the very least I should test if the array uses all iters!
	# Better would be not to rely on the size
	# Also see below, what about accesses with multiple iters per dimension?
	$stref = _get_iter_range_from_largest_array($stref,$f);
	# for my $iter (sort keys %{$state->{'LoopIters'}}) {
	# 	for my $array_var (sort keys %{$state->{'LoopIters'}{$iter}{'Arrays'}}) {
	# 		my $idx = $state->{'LoopIters'}{$iter}{'Arrays'}{$array_var};
	# 		my $subset = in_nested_set( $stref->{'Subroutines'}{$f}, 'Vars', $array_var );
	# 		# say "SUBSET <$subset>";
	# 		if ($subset) {
	# 			my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Vars'},$array_var);
	# 			if (exists $decl->{'ConstDim'}) {
	# 			# say Dumper($decl);
	# 			my $const_dim = $decl->{'ConstDim'};
	# 			# carp "$array_var $iter $idx ".Dumper($const_dim->[$idx]);
	# 			$state->{'LoopIters'}{$iter}{'Range'}=[1,$const_dim->[$idx][1]-$const_dim->[$idx][0]+1,1];
	# 			}
	# 		}
	# 	}
	# }
	# Now assign this to LoopIters
	$stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{0}{'LoopIters'} = $state->{'LoopIters'};
	# croak $f.':'.Dumper $state->{'LoopIters'};
	return $stref;
} # END of _get_loop_iters_from_global_id

# WV 2021-05-20
# There is some complication here. If there is one iter per dimension it is all very well, we use the dimension as the range
# But if we have v(i+j*i_sz), then what is the range for i and j?
# The only decent way to do this is to replace this expression by a new variable and define that as the iter.
#
# The purpose is to determine what is a stream var. I reason that an array smaller than the largest but with the same dimension
# can't use the same number of loop iterators because it would mean that the loop iteration range would be capped by the smallest array
# We know the dimensions. If we have e.g. w=10, v=500 and we have v(i+j*i_sz) and w(i+j*i_sz) then that would mean that the global_range can only be 10
# In any case, an array accessed with a subset of iterators can't be a stream
# So we should have the ItersPerDim
# I actually think we get this from the Accesses analysis.
sub _get_iter_range_from_largest_array { my ($stref,$f) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $annlines = $Sf->{'RefactoredCode'};
	my $state = {};
	$state->{'LoopIters'} = $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{0}{'LoopIters'};
	# What we need to do is look at all arrays in {}
	my %arrays_with_iters = ();
	my %iters_per_dim  = ();
	my $n_iters = scalar keys %{$state->{'LoopIters'}};
	for my $iter (sort keys %{$state->{'LoopIters'}}) {
		for my $array_var (sort keys %{$state->{'LoopIters'}{$iter}{'Arrays'}} ) {
			$arrays_with_iters{$array_var}{$iter}=1;
	# For every array var, we look at which iters are used for which dim
			my $idx =$state->{'LoopIters'}{$iter}{'Arrays'}{$array_var};
			$iters_per_dim{$array_var}{$idx}{$iter}=1;
		}
	}


	my $max_range_size = {};
	for my $iter (sort keys %{$state->{'LoopIters'}}) {
		$max_range_size->{$iter}=0;
	}
	for my $array_var ( sort keys %arrays_with_iters ) {
		my $n_iters_used = scalar keys %{$arrays_with_iters{$array_var}};
		if ($n_iters_used == $n_iters) {
			my $subset = in_nested_set( $stref->{'Subroutines'}{$f}, 'Vars', $array_var );
			# say "SUBSET <$subset>";
			if ($subset) {
				my $decl = get_var_record_from_set( $stref->{'Subroutines'}{$f}{'Vars'},$array_var);
				if (exists $decl->{'ConstDim'}) {
					# say Dumper($decl);
					my $const_dim = $decl->{'ConstDim'};
					if (scalar @{$const_dim} == $n_iters) {
						for my $iter (sort keys %{$arrays_with_iters{$array_var}}) {
							my $idx = $state->{'LoopIters'}{$iter}{'Arrays'}{$array_var};
					 		my $entry = $const_dim->[$idx];
							my $sz_str = '((' . $entry->[1] . ') - (' . $entry->[0] . ')+1)';

							my $range_size = eval($sz_str);
							$max_range_size->{$iter} = max($max_range_size->{$iter},$range_size);
						}
					}
				}
			}
		}
	}
	for my $iter (sort keys %{$state->{'LoopIters'}}) {
		$state->{'LoopIters'}{$iter}{'Range'}=[1,$max_range_size->{$iter},1];
	}
	$stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{0}{'LoopIters'} = $state->{'LoopIters'};
	return $stref;
} # END of _get_iter_range_from_largest_array

sub __find_loop_iter_access_in_ast { ( my $state, my $ast)=@_;
    if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {
			my $entry = $ast->[$idx];

			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = __find_loop_iter_access_in_ast($state,$entry);
				$ast->[$idx] = $entry;
			} else {
				if ($idx==0 and (($entry & 0xFF)==10)) { #$entry eq '@'
					$state = __find_loop_iters_in_array_idx_expr($ast, $state);
				}
			}
		}
	}
	return  ($ast, $state);

} # END of __find_loop_iter_access_in_ast


# When we find an iterator access in an array we must check in which loop this array is being accessed
sub __find_loop_iters_in_array_idx_expr { (my $ast, my $state,)=@_;

	my @args = ();
	if ($ast->[2][0] == 27) {
	for my $arg_idx (1 .. scalar @{$ast->[2]} -1 ) {
		my $arg = $ast->[2][$arg_idx];
		push @args, $arg;
	}
	} else {
		push @args, $ast->[2];
	}
	my $array_var = $ast->[1]; # OK

	for my $idx (0 .. @args-1) {
  		my $item = $args[$idx]; # This is an AST!
  		my $vars = get_vars_from_expression($item, {});
  		for my $var (keys %{$vars}) {
  			if (exists $state->{'Deps'}{ $var }) {
				  $state->{'LoopIters'}{$var}{'Range'} = [0,0,0];
				  $state->{'LoopIters'}{$var}{'Arrays'}{$array_var}=$idx;
  			}
  		}
	}
	return $state;
} # END of __find_loop_iters_in_array_idx_expr

# [10,'v',[27,[2,'i'],[2,'j'],[2,'k']]] or
# [10,'v',[2,'i']]
sub __get_ndims_from_array_access_ast { my ($ast) = @_;
	if ($ast->[2][0] == 27) {
		return scalar( @{$ast->[2]} ) - 1;
	} else {
		# it must be a single access, so 1-D
		return 1;
	}
} # END of __get_ndims_from_array_access_ast
sub __add_deps_from_RHS { my ($state,$info) = @_;

	my $ast = $info->{'Rhs'}{'ExpressionAST'};
	my $vars = get_vars_from_expression($ast,{});
	my $lhs_var_name = $info->{'Lhs'}{'VarName'};
	for my $tvar (sort keys %{$state->{'Deps'}}) {
		if (exists $vars->{$tvar}) {
			push @{$state->{'Deps'}{$lhs_var_name}}, $tvar;
		}
	}
	return $state;
} # END of __add_deps_from_RHS