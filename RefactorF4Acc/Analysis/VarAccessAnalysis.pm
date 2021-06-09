package RefactorF4Acc::Analysis::VarAccessAnalysis;
#
#   (c) 2016-now Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw(
	pass_wrapper_subs_in_module
	stateful_pass
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
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::VarAccessAnalysis::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::VarAccessAnalysis::EXPORT_OK = qw(
&analyseAllVarAccesses
);

=pod info

--    Type used to colate data on variable accesses throughout a program.
--                        All reads     All writes
type VarAccessRecord = ([SrcSpan],     [SrcSpan])

-- WV: this map provides all read and write locations for a local variable
type LocalVarAccessAnalysis = DMap.Map (VarName Anno) VarAccessRecord
-- WV: this map provides the expression(s) defining the local variable, I guess, so this would be assignments and should be args of subcalls with intent Out or InOut
type LocalVarValueAnalysis = DMap.Map (VarName Anno) [(SrcSpan, Expr Anno)]
-- WV: I wonder if instead of [VarName Anno] a declaration would not have been better?
-- WV: The list of LocalVarAccessAnalysis is an extenstion to deal with IO routines: [Kernel, IORoutines]
--                                                                            Subroutine arguments     Declared var names
type VarAccessAnalysis = ([LocalVarAccessAnalysis],    LocalVarValueAnalysis, [VarName Anno],     [VarName Anno])

$stref->{'Subroutines'}{$f}{'VarAccessAnalysis'} = $state->{'VarAccessAnalysis'} =;

{
    'Args' => { 
        'List' => [$arg,...], 
        'Set' =>{$arg => $decl,...},

        'In'=>[],'Out' =>[], 'MaybeAcc'=>[],'Acc'=>[]                	                	
    },
    'LocalVars' => {
        List => [$var,...]
        Set =>{$var => ArrayOrScalar,...}
    },

    'LocalVarAccessAnalysis' => {
        $var => {
        'Write' => [(BlockId,LineId)]
        'Read' => [(BlockId,LineId)]
        }
    }

    'LocalVarValueAnalysis' => {
        $var =>  [[[BlockId,LineId], Lhs.ExpressionAST,Rhs.ExpressionAST]]
        }
    }
    'LoopNests' => { 
        'List' => [ [$block_id,$iterator,{Range => []}],... ],
        'Set' => {
            $block_id => {
                'BlockStart' => LineID,
                'BlockEnd' => LineID,
                'Iterator' => $loopvar,
                'Range' => [...]
                'InBlock' => BlockID,
                'NestLevel' => Int,
                # Added in LoopNature::parallelise_all_Blocks
                'Contains' => {
                    $contained_block_id => LineID,
                    ...
                },
                # Added in LoopNature::paralleliseLoop
                'AnalysisInfo' =>  [$errors :: Anno, 
                                    $reduction_variables :: [Expr Anno],         
                                    $read_variables :: [Expr Anno],         
                                    $written_variables :: [Expr Anno]
                                    ],

                }
            },
        }
    }
    'Blocks' => {
        $block_id => { 'LoopIters' => $iter => {Range => [...]} }}
    }

};                

=cut





# I will assume that the subroutine has no IO accesses for the moment. 
# I will also assume that all subroutine calls in a loop nest have been inlined
# So the only way a variable gets accesses is in an Assignment, If or Case
sub analyseAllVarAccesses { my ($stref, $f, $io_write_subroutines, $annlines) = @_;
	if ($DBG) {
	print "\nIN SUB $f, SRC <"; print $stref->{'VarAccessAnalysis'}{'Source'}; say ">";
	}

		my $pass_analyseAllVarAccesses = sub { (my $annline, my $state)=@_;
			(my $line,my $info)=@{$annline};
			
            my $line_id = $info->{'LineID'};

            my $current_block = $state->{'CurrentBlock'};
            my $block_id = exists $info->{'BlockID'} ? $info->{'BlockID'} : $state->{'CurrentBlock'} ;
            $state->{'CurrentBlock'} = $block_id;
            my $nest_level = scalar split(/:/,$block_id);

			# Identify the subroutine
			if ( exists $info->{'Signature'} ) {
				my $subname =$info->{'Signature'}{'Name'} ;
				croak if $DBG and $subname ne $f;
				$state->{'VarAccessAnalysis' }={};
				$state->{'VarAccessAnalysis' }{'Blocks'}={};
				$state->{'VarAccessAnalysis' }{'Blocks'}{$block_id}={};
                $state->{'VarAccessAnalysis'}{'LoopNests'}{'List'}=[ [0,'',{}] ];
                $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}={
                    0 => {
                        'BlockStart' => $info->{'LineID'},
                        'BlockEnd' => -1,
                        'Iterator' => '',
                        'Range' => [],
                        'InBlock' => -1,
                        'NestLevel' => $nest_level
                    }
                };
                # InOut will be both in In and Out
                # Any scalar arg that is InOut or Out could be an Acc, put it in MaybeAcc
                
                $state->{'VarAccessAnalysis'}{'Args'}={      
                    'List' => $info->{'Signature'}{'Args'}{'List'},
                    'Set' => {},
                	'In'=>[],'Out' =>[], 'MaybeAcc'=>[],'Acc'=>[]                	                	
                };
                
                for my $arg ( @{ $info->{'Signature'}{'Args'}{'List'} } ) {
					
                	my $arg_decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Args'},$arg);
                    $state->{'VarAccessAnalysis'}{'Args'}{$arg}=$arg_decl;
					my $intent =$arg_decl->{'IODir'}; # can be Unknown
					my $is_scalar = $arg_decl->{'ArrayOrScalar'} eq 'Array' ? 0 : 1;
					if ($is_scalar and $intent eq 'out' or $intent eq 'inout' or $intent eq 'Unknown') {
						push @{ $state->{'VarAccessAnalysis'}{'Args'}{'MaybeAcc'} }, $arg;
					}
					if ($intent ne 'out') {
						push @{ $state->{'VarAccessAnalysis'}{'Args'}{'In'} }, $arg;
					}
					if ($intent ne 'in') {
						push @{ $state->{'VarAccessAnalysis'}{'Args'}{'Out'} }, $arg;
					}         
                }
			}
			# For every VarDecl, identify dimension if it is an array
			if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'} ) {
                if (not exists $info->{'ArgDecl'}) {
                    # Find the intent
                    # croak Dumper $info;
                # } else {

				    my $var=$info->{'VarDecl'}{'Name'};
                    push @{$state->{'VarAccessAnalysis'}{'LocalVars'}{'List'}}, $var;
                    $state->{'VarAccessAnalysis'}{'LocalVars'}{'Set'}{$var} = is_array_decl($info) ? 'Array' : 'Scalar';
                }
				 
			}
			if (exists $info->{'Assignment'} ) {
					# First check if this is maybe an accumulator
                my $var = $info->{'Lhs'}{'VarName'};
                if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' ) { 
					
					# Test if a scalar arg is an accumulator for a fold
					# If the arg occurs on LHS and RHS of an assignment and the RHS has an array arg as well			
					my %maybe_accs = map {$_ => 1} @{$state->{'VarAccessAnalysis'}{'Args'}{'MaybeAcc'}};
					my %in_arrays  = map {$_ => 1} @{$state->{'VarAccessAnalysis'}{'Args'}{'In'}};
					my $acc_var = $var ;
					if (exists $maybe_accs{$acc_var}) { 						
						my $vars = get_vars_from_expression($info->{'Rhs'}{'ExpressionAST'});
						if (exists $vars->{$acc_var}) {
							for my $tvar (sort keys %{$vars}) {
								if ($vars->{$tvar}{'Type'} eq 'Array'
								and exists $in_arrays{$tvar}
								) {
									push @{$state->{'VarAccessAnalysis'}{'Args'}{'Acc'}}, $acc_var;
									last;
								}
							}
						}
					}
                }
					
                # Find all array accesses in the LHS and RHS AST.					
                my $lhs_ast = $info->{'Lhs'}{'ExpressionAST'};
                my $rhs_ast = $info->{'Rhs'}{'ExpressionAST'};
                ($lhs_ast, $state) = _find_var_access_in_ast($stref, $f, [$block_id, $line_id], $state, $lhs_ast,'Write');
                ($rhs_ast, $state) = _find_var_access_in_ast($stref, $f, [$block_id,$line_id], $state, $rhs_ast,'Read');
# analyseAllVarValues_fortran :: Fortran Anno -> LocalVarValueAnalysis
# analyseAllVarValues_fortran (Assg _ src expr1 rhs_expr_ast) = foldl (\accum varname -> appendToMap varname (src, rhs_expr_ast) accum) DMap.empty varnames
#   where
#     varnames = extractVarNames expr1
                push @{$state->{'VarAccessAnalysis'}{$var}},[[$block_id,$line_id],$info->{'Lhs'}{'ExpressionAST'},$info->{'Rhs'}{'ExpressionAST'}];

			}
	 		if (exists $info->{'If'} ) {
                #  croak 'ADD a record to LoopNests HERE!';
                    $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id} ={
                            'BlockStart' => $info->{'LineID'},
                            # 'BlockEnd' => -1,
                            'Iterator' => '',
                            'Range' => [],
                            'InBlock' => $current_block,
                            'NestLevel' => $nest_level
                    };                    
                my $cond_expr_ast = $info->{'Cond'}{'AST'};
                ($cond_expr_ast, $state) = _find_var_access_in_ast($stref, $f, [$block_id,$line_id], $state, $cond_expr_ast,'Read');
            }
            elsif ( exists $info->{'Do'} ) {
                if (exists $info->{'Do'}{'Iterator'} ) {       
                    # say Dumper $info->{'Pragmas'};
                    my $loop_nature = (exists $info->{'Pragmas'} and exists $info->{'Pragmas'}{'LoopNature'})
                    ? $info->{'Pragmas'}{'LoopNature'}
                    : ['Undetermined'];
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
    #                say "RANGE: [ $range_start_evaled , $range_stop_evaled ]"; 
                    my $loop_iter = $info->{'Do'}{'Iterator'};
                    
                    #  croak Dumper $info if $loop_iter eq 'l';
                    my $loop_range_exprs = [ $range_start_evaled , $range_stop_evaled ];#[$range_start,$range_stop]; # FIXME Maybe we don't need this. But if we do, we should probably eval() it
                    my $loop_id = $info->{'LineID'};
                    push @{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'List'} },[$loop_id, $loop_iter , {'Range' => $loop_range_exprs}];
                    # $block_id = __mkLoopId( $state->{'VarAccessAnalysis'}{'LoopNests'}{'List'} );
                    # $info->{'BlockID'} = $block_id;
                    # $state->{'VarAccessAnalysis'}{'LoopNests'}{'List'}=[ [0,'',{}] ];
                    # carp $f, ':', $block_id if $f eq 'sor';
                    $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id} ={
                            'BlockStart' => $info->{'LineID'},
                            # 'BlockEnd' => -1,
                            'Iterator' => $loop_iter,
                            'Range' => $loop_range_exprs,
                            'InBlock' => $current_block,
                            'NestLevel' => $nest_level,
                            'LoopNature' => $loop_nature
                    };                
                    $state->{'CurrentBlock'} = $block_id;
                    for my $loop_iter_rec ( @{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'List'} } ) { 
                        (my $loop_id, my $loop_iter, my $range_rec) = @{$loop_iter_rec};		
                        next if $loop_iter eq ''; 			
                        $state->{'VarAccessAnalysis' }{'Blocks'}{$block_id}{'LoopIters'}{$loop_iter}=$range_rec;
                    }
                } else {
                    die "ERROR: Sorry, a `do` loop without an iterator is not supported\n";
                }
            } elsif ( exists $info->{'EndDo'} ) {
                
				my $block_id = $state->{'CurrentBlock'};
				# $info->{'BlockID'} = $block_id;
				pop @{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'List'} };
				# $state->{'CurrentBlock'} = 0;
                $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'BlockEnd'} = $info->{'LineID'};                
            }
			return ([[$line,$info]],$state);
		};

		my $state = { 'CurrentBlock'=>0,'VarAccessAnalysis'=>{}};
			
	 	($annlines,$state) = stateful_pass($annlines,$pass_analyseAllVarAccesses, $state,'pass_analyseAllVarAccesses ' . __LINE__  ) ;
	 	# croak Dumper $state->{'VarAccessAnalysis'} if $f eq 'sub0';
        # $stref->{'Subroutines'}{ $f }{'VarAccessAnalysis'} = $state->{'VarAccessAnalysis'};
    $stref->{'Subroutines'}{$f}{'VarAccessAnalysis'}=$state->{'VarAccessAnalysis'};
 	return ($stref,$state->{'VarAccessAnalysis'});
} # END of analyseAllVarAccesses()




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
sub _find_var_access_in_ast { (my $stref, my $f,  my $block_line_id, my $state, my $ast, my $rw)=@_;
    if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {
			my $entry = $ast->[$idx];

			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _find_var_access_in_ast($stref,$f, $block_line_id, $state, $entry, $rw);
				$ast->[$idx] = $entry;
			} else {
				if ($idx==0 and (($entry & 0xFF)==10)) { #$entry eq '@'					
					my $array_var = $ast->[1];
					push @{$state->{'VarAccessAnalysis' }{'LocalVarAccessAnalysis'}{ $array_var}{$rw}}, $block_line_id;
					last;					
				} 
				elsif ($idx==0 and (($entry & 0xFF)==2)) { #$entry eq '$'
					my $scalar_var = $ast->[1];
					push @{$state->{'VarAccessAnalysis' }{'LocalVarAccessAnalysis'}{ $scalar_var}{$rw}}, $block_line_id;
					last;					
				} 				
			}
		}
	}
	return  ($ast, $state);

} # END of _find_var_access_in_ast



1;
