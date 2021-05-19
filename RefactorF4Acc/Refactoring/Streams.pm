# Rename array accesses to scalars to transform loops into streams
package RefactorF4Acc::Refactoring::Streams;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( 
	pass_wrapper_subs_in_module 
	stateful_pass_inplace 
	stateful_pass_reverse_inplace 
	stateless_pass_inplace  
	emit_f95_var_decl 
	splice_additional_lines_cond_inplace  
	update_arg_var_decl_sourcelines
	);
use RefactorF4Acc::Translation::TyTra::Common qw(
  F3D2C
  F2D2C
  F1D2C
  F4D2C
);	
use RefactorF4Acc::Refactoring::Fixes qw( 
	_declare_undeclared_variables	
	_removed_unused_variables
	_fix_scalar_ptr_args
	_fix_scalar_ptr_args_subcall
	_make_dim_vars_scalar_consts_in_sigs
	remove_redundant_arguments_and_fix_intents	
);
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
use RefactorF4Acc::Refactoring::FoldConstants qw( fold_constants );
# I'm not sure that this is the best place for this routine as it is only used in this pass    
use RefactorF4Acc::Refactoring::Subroutines::Emitters qw( 
	emit_subroutine_sig 
	emit_subroutine_call
	);
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Parser::Expressions qw(
	parse_expression
	emit_expr_from_ast
	get_vars_from_expression
	);

# 
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Streams::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Streams::EXPORT_OK = qw(
	&pass_rename_array_accesses_to_scalars
);

sub pass_rename_array_accesses_to_scalars {(my $stref, my $code_unit_name)=@_;
# croak $code_unit_name;
	$stref = pass_wrapper_subs_in_module($stref,
	'',
	# module-specific passes
	[],
	# subroutine-specific passes
			[
				[ sub { (my $stref, my $f)=@_; 
				
				 alias_ordered_set($stref,$f,'RefactoredArgs','DeclaredOrigArgs');
                       
                    } ],
#				[ \&_fix_scalar_ptr_args ],
#		  		[\&_fix_scalar_ptr_args_subcall],
	            [\&remove_redundant_arguments_and_fix_intents],
				[ sub { (my $stref, my $f)=@_; 
				
				 	($stref, my $annlines) = fold_constants($stref,$f,0);
                       return $stref;
                    } ],				
				# [\&fold_constants],
    	        [\&identify_array_accesses_in_exprs ],
		  		[
			  		\&_declare_undeclared_variables,
					\&_rename_array_accesses_to_scalars,
					\&_removed_unused_variables,
				],
				[
					\&_rename_array_accesses_to_scalars_in_subcalls
				],			
				[
					\&determine_argument_io_direction_rec,
                    \&update_arg_var_decl_sourcelines,
				],
				[
					\&_update_call_args,
					\&_add_assignments_for_called_subs
				],				
				[
					\&_make_dim_vars_scalar_consts_in_sigs
				],
			]
		);		
	# This enables the postprocessing for custom passes
	$stref->{'CustomPassPostProcessing'}=1;
		
	return $stref;
}

# Rename every array access and keep track
=info_AST
{
	'Assignment' => 1,
	'Indent' => '    ',
	'Lhs' => {
		'ArrayOrScalar' => 'Scalar',
		'ExpressionAST' => ['$','g'],
		'VarName' => 'g',
		'IndexVars' => {
			'Set' => {},
			'List' => []
		}
	},
	'Rhs' => {
		'ExpressionAST' => ['@','g_ptr','1'],
		'Vars' => {
			'List' => ['g_ptr'],
			'Set' => {
				'g_ptr' => {'Type' => 'Array','Vars' => {}}				
			}
		}
	},
	'LineID' => 32,
	'Ref' => 0
}



=cut
=info_assumptions_array_access_detection
Assumptions:
- Array accesses use index expressions that are linear `a*idx+b`, where idx is part of IndexVars
- For stencils we _only_ support idx+k where k is a positive or negative constant 
- If an array has a constant index access, that is _not_ part of the stencil

=cut
# ================================================================================================================================================	
=pod  Scalarising array accesses
This composite pass renames array accesses in the called subroutines in a superkernel to scalar accesses

It consists of following sub-passes:
	1. Scalarise array accesses in assignments and conditional expressions of IFs
		$pass_rename_array_accesses_in_exprs 
	2. Create new assignment lines, these go into LiftedScalarAssignments 
	3. Update the subroutine Signature and VarDecl declarations in $info	
		$pass_update_sig_and_decls
	4. Update DeclaredOrigArgs and DeclaredOrigArgs	
	5. Add the missing declarations: in the superkernel we assign the variables to the original array accesses
		$pass_lift_array_index_calculations 
	6. Emit the updated code for the subroutine signature, the variable declarations, assignment expressions and ifthen expressions	
		$pass_emit_updated_code 

WV 2019-11-14 What needs to change: the scalarisation should only happen for stream variables. So we need to determine which variables are stream variables, and which ones are not.
As we first do identify_array_accesses_in_exprs, we should make sure there is a table created, e.g. $Sf->{'StreamVars'}. This is already used, but we could use it to decide on action or not.
=cut

sub _rename_array_accesses_to_scalars { (my $stref, my $f) = @_;

	if ($f ne $Config{'KERNEL'} ) {
		$stref->{'TyTraLlvmArgTuples'}={};

	# 1. This pass performs renaming in assignments and conditional expressions of IFs
	# TODO: It does _not_ rename
	# 	* subroutine call arguments (because there should not be any)
	# 	* SELECT CASE arguments (I'm lazy, FIXME!)
	# 	* DO index range expressions (I'm lazy, FIXME!) 
	my $pass_rename_array_accesses_in_exprs = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		
		if (exists $info->{'Signature'} ) { 			
			$state->{'Args'} = $info->{'Signature'}{'Args'}{'Set'};
		} elsif (exists $info->{'Assignment'} ) {
			if (scalar @{ $info->{'Rhs'}{'Vars'}{'List'} } == 1 and $info->{'Rhs'}{'Vars'}{'List'}[0]=~/_ptr/) {
				warn 'FIXME: What we want is that only array variables with IndexVars are renamed. So constant indices should stay as they are';
				# IGNORE, this is not a true array access: this is an assignment of the shape
				# v = v_ptr(1)
				# and we will remove these later on
			} else {				

				# Rename all array accesses in the RHS AST. This updates $state->{'StreamVars'}
				# Here we should check if the variable is an argument or not!
				# I have $state->{'Args'} for that. But the RHS is an expression which could have many vars				
				(my $ast, $state) = _scalarise_array_accesses_in_ast($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'In');
				 $info->{'Rhs'}{'ExpressionAST'}=$ast;
				 if (ref($ast) ne '') {
				my $vars=get_vars_from_expression($ast,{}) ;
#				croak "CARP:".Dumper($vars);
				$info->{'Rhs'}{'Vars'}{'Set'}=$vars;
				$info->{'Rhs'}{'Vars'}{'List'}= [ grep {$_ ne 'IndexVars' } sort keys %{$vars} ];
				 } else {
				 	$info->{'Rhs'}{'Vars'}={'List'=>[],'Set'=>{}};
				 }
				#  croak Dumper $info->{'Rhs'}{'ExpressionAST'} if $line=~/acc\s+\+\s+v/;
			}
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array') {
				# Rename all array accesses in the LHS AST. This updates $state->{'StreamVars'}
				(my $ast, $state) = _scalarise_array_accesses_in_ast($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'}, 'Out');
				$info->{'Lhs'}{'ExpressionAST'}=$ast;
				my $stream_var = $ast->[1];		
				$info->{'Lhs'}{'VarName'} = $stream_var;
				$info->{'Lhs'}{'ArrayOrScalar'} = 'Scalar';
			}
			$state->{'IndexVars'}={ %{$state->{'IndexVars'} }, %{ $info->{'Lhs'}{'IndexVars'}{'Set'} } };
			for my $var ( @{ $info->{'Rhs'}{'Vars'}{'List'} } ) {
				if ($info->{'Rhs'}{'Vars'}{'Set'}{$var}{'Type'} eq 'Array' and exists $info->{'Rhs'}{'Vars'}{'Set'}{$var}{'IndexVars'}) {					
					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $info->{'Rhs'}{'Vars'}{'Set'}{$var}{'IndexVars'} } }
				}
			}				
		} 
		if (exists $info->{'If'} ) {
			# carp Dumper $info;
			my $cond_expr_ast = $info->{'Cond'}{'AST'};
			# Rename all array accesses in the AST. This updates $state->{'StreamVars'}			
			(my $ast, $state) = _scalarise_array_accesses_in_ast($stref, $f,  $state, $cond_expr_ast, 'In');			
			
			$info->{'Cond'}{'Expr'}=$ast;
			for my $var ( @{ $info->{'Cond'}{'Vars'}{'List'} } ) {
				if (
					$info->{'Cond'}{'Vars'}{'Set'}{$var}{'Type'} eq 'Array' 					
				and exists $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'}) {					
					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'} } }
				}
			}
				 if (ref($ast) ne '') {
				my $vars=get_vars_from_expression($ast,{}) ;

				$info->{'Cond'}{'Vars'}{'Set'}=$vars;
				$info->{'Cond'}{'Vars'}{'List'}= [ grep {$_ ne 'IndexVars' } sort keys %{$vars} ];
				 } else {
				 	$info->{'Cond'}{'Vars'}={'List'=>[],'Set'=>{}};
				 }
		}
		return ([[$line,$info]],$state);
	};
# So I think I should put the arguments in $state, I can do that when I encounter the Signature
	my $state = {'IndexVars'=>{}, 'StreamVars'=>{}, 'Args' =>{}};
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_rename_array_accesses_in_exprs, $state,'pass_rename_array_accesses_in_exprs ' . __LINE__  ) ;
 	
# -------------------------------------------------------------------------------------------------------- 	
 	# 2. Now we create new assignment lines, these go into LiftedScalarAssignments 
 	# v_i_j = v(i,j)
	# The reverse go into LiftedArrayAssignments 
 	# v(i,j) = v_i_j
 	# In principle, we should check the IODir. If it is In or InOut, it needs scalar assignment; if it is Out or InOut, it needs array assignment
 	$stref->{'Subroutines'}{$f}{'LiftedScalarAssignments'}=[];
 	$stref->{'Subroutines'}{$f}{'LiftedArrayAssignments'}=[];
 	# StreamVars has the original array var as key, a list of entries for the renamed scalars as value
 	# Each of these entries has a field ArrayIndexExpr	
	# FIXME the sort below means that the tuple is in lexical order of the var names, which makes no sense. 
	# The only sensible ordering is linear numerically ascending
	# So I need the info to obtain that ordering
	# So I need to put it in StreamVars. 
	# I think that I need to run the analysis from ArrayAccessPatterns and link this to StreamVars.
	# That should not be too hard I suppose.
	$stref->{'TyTraLlvmArgTuples'}{$f}={};
	for my $var (sort keys %{ $state->{'StreamVars'} } ){
		$state->{'StreamVars'}{$var}{'List'}=[];
		# Here is where we have the wrong order
		# carp Dumper $state->{'StreamVars'};
		# So what we need instead of that is the order defined by link_scalarised_vars_to_linear_offsets()

		my $accesses = 
		exists $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{0}{'Arrays'}{$var}{'Read'} ?
		 $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{0}{'Arrays'}{$var}{'Read'}{'Accesses'} :
		$stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{0}{'Arrays'}{$var}{'Write'}{'Accesses'} ;
		
		my $array_dims = $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{0}{'Arrays'}{$var}{'Dims'};
		my ($offsets_for_scalarised_vars,$ordered_stencil_var_tuple) = link_scalarised_vars_to_linear_offsets($var, $accesses, $array_dims);
		$stref->{'TyTraLlvmArgTuples'}{$f}{$var}=$ordered_stencil_var_tuple;
		# if (scalar @{$ordered_stencil_var_tuple}==0) {
		# say $f;
		# say Dumper(
		# 	[sort keys %{ $state->{'StreamVars'}{$var}{'Set'} }],
		# 	$ordered_stencil_var_tuple
		# );
		# }
		# for my $stream_var (sort keys %{ $state->{'StreamVars'}{$var}{'Set'} } ){
			for my $stream_var (@{$ordered_stencil_var_tuple} ) {
				# carp "$f STREAM VAR $stream_var\n";
			push @{$state->{'StreamVars'}{$var}{'List'}},$stream_var;		
			my $scalar_assignment_line= '      '.$stream_var.' = '.$state->{'StreamVars'}{$var}{'Set'}{$stream_var}{'ArrayIndexExpr'};
			my $array_assignment_line= '      '.$state->{'StreamVars'}{$var}{'Set'}{$stream_var}{'ArrayIndexExpr'}.' = '.$stream_var;
			my $scalar_assignment_rhs_ast = parse_expression($state->{'StreamVars'}{$var}{'Set'}{$stream_var}{'ArrayIndexExpr'}, {},$stref, $f);
			my $array_assignment_lhs_ast = $scalar_assignment_rhs_ast; 
			my $scalar_assignment_rhs_vars = get_vars_from_expression($scalar_assignment_rhs_ast ,{});
			my $array_assignment_lhs_vars =$scalar_assignment_rhs_vars; 
			my $scalar_assignment_rhs_vars_list = [ sort keys %{$scalar_assignment_rhs_vars} ];
			my $array_assignment_lhs_vars_list = $scalar_assignment_rhs_vars_list;
			push @{ $stref->{'Subroutines'}{$f}{'LiftedScalarAssignments'} }, 
			[$scalar_assignment_line,
				{
					'Indent' => '      ',
					'Assignment'=> 1,
						'Lhs'=> {   
							'ArrayOrScalar' => 'Scalar','IndexVars' => {'List' => [],'Set' => {}},'ExpressionAST' => ['$',$stream_var],'VarName' => $stream_var
						  },
						'Rhs' => {
							'ExpressionAST' => $scalar_assignment_rhs_ast,
							'Vars' => {'List' => $scalar_assignment_rhs_vars_list,'Set' =>$scalar_assignment_rhs_vars},
						}
					
				}
			];
			
			push @{ $stref->{'Subroutines'}{$f}{'LiftedArrayAssignments'} }, 			
			[$array_assignment_line,
				{
					'Indent' => '      ',
					'Assignment'=> 1,
						'Lhs' => {
							'ArrayOrScalar' => 'Array',
							'ExpressionAST' => $array_assignment_lhs_ast,
							'VarName' => $var,
							'IndexVars' => {
								'List' => [$array_assignment_lhs_vars_list],
								'Set' => $array_assignment_lhs_vars
							}
						},
						'Rhs'=> {   
							'ArrayOrScalar' => 'Scalar',
							'ExpressionAST' => ['$',$stream_var],
							'Vars' => {
								'List' => [$stream_var], 
								'Set' => {$stream_var  => {'Type' => 'Scalar'} }, 									
								}
						  },					
				}
			]; 
		}		
	}
	$stref->{'Subroutines'}{$f}{'StreamVars'}=$state->{'StreamVars'};

# --------------------------------------------------------------------------------------------------------
	# So now we have identified all stream vars ( $state->{'StreamVars'}{$arg}{'List'} ) 
	# 3. In the next pass, update the subroutine Signature and VarDecl declarations in $info
	# We update DeclaredOrigArgs record of $f in a separate pass below
	my $pass_update_sig_and_decls = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Signature'} ) { 			
			# What we do is replace the array args with the "tuple" of scalar args from StreamVars
			my $new_args=[];
			my %orig_arg_names=();
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
				if (exists $state->{'StreamVars'}{$arg} ) {
					$new_args=[@{$new_args},  @{ $state->{'StreamVars'}{$arg}{'List'} }  ];
					my $idx=0;
					# Here we store the stencil index BASE 1 for Fortran
					map { $orig_arg_names{$_}=[$arg, ++$idx] } @{ $state->{'StreamVars'}{$arg}{'List'} };
				} else {
					push @{$new_args}, $arg;
					# Stencil index 0 means it is not a stencil!
					$orig_arg_names{$arg}=[$arg, 0];
				} 
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			# carp $f.' SCALARISED ARGS: ', Dumper $new_args;

			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>$orig_arg_names{$_}  } @{$new_args} };
			
		} elsif (exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'};
			if (exists $state->{'StreamVars'}{$var}) {
				
				my $vars =  $state->{'StreamVars'}{$var}{'List'};
				
				if (exists $info->{'ParsedVarDecl'}) {
					$info->{'ParsedVarDecl'}{'StreamVars'}=$state->{'StreamVars'}{$var}{'Set'}; # Every streamvar derived from var has the same type
					$info->{'ParsedVarDecl'}{'Vars'}=$vars;
					delete $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'};
					# INTENT is deleted, we will run ArgumentIODirs later
					if (exists $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'} ) {
						delete $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'};
					}
					# croak $var.' '.Dumper($info) if $var=~/etan/;#_j_k';
				} else {
					croak "TROUBLE: ".Dumper($annline); 
				}
			}
		}
		return ([[$line,$info]],$state);
	};

 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_update_sig_and_decls, $state,'pass_update_sig_and_decls' . __LINE__  ) ;
 	
# --------------------------------------------------------------------------------------------------------	
	# 4. Here we update DeclaredOrigArgs
 	# At this point the argument list already has the stream vars as args
 	
 	my @updated_args_list=();		
	for my $orig_arg ( @{ $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'} } ) {		
		
		if (exists $state->{'StreamVars'}{$orig_arg}) {
						my $idx=0;
			for my $new_arg (@{ $state->{'StreamVars'}{$orig_arg}{'List'} }) {								
				my $new_decl = dclone( $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg} );
				push @updated_args_list,$new_arg;
				$new_decl->{'ArrayOrScalar'}='Scalar';
				$new_decl->{'Dim'}=[];
				$new_decl->{'IODir'}=$state->{'StreamVars'}{$orig_arg}{'Set'}{$new_arg}{'IODir'};
				# my $new_arg_index_expr = $state->{'StreamVars'}{$orig_arg}{'Set'}{$new_arg}{'ArrayIndexExpr'};
				# $new_decl->{'ArrayIndexExpr'}=++$iii;#$new_arg_index_expr;
				$new_decl->{'ArrayIndexExpr'}=$state->{'StreamVars'}{$orig_arg}{'Set'}{$new_arg}{'ArrayIndexExpr'};
				if (scalar @{ $state->{'StreamVars'}{$orig_arg}{'List'} } > 1) {
				# 	# Only one access, not a stencil!
				# 	# carp "NOT A STENCIL $f $orig_arg $new_arg ";
				# } else {
					$new_decl->{'StencilIndex'}=++$idx;
				}
				$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$new_arg}=$new_decl;					
			}	
			delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg};					
		} else {
			if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg} ) {
				push @updated_args_list, $orig_arg;	
			}
		}
	}
	
	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=[@updated_args_list]; 	
	# croak $f.': '.Dumper( $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'});
# --------------------------------------------------------------------------------------------------------	 	
 	# So at this point we should do the lifting of everything to do with indexing
 	
# 5. Finally, after having updated the calls we can add the missing declarations
# In the superkernel we will assign the variables to the original array accesses
# However, the array indices are computed from the global id on a per-sub basis so i,j,k are different for each sub.
# So  we need to extract the calculations of i,j,k out of the sub

	my  $pass_lift_array_index_calculations = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
	# Every Assignment line that has one of these on the LHS gets removed from AnnLines and stored in LiftedIndexCalcLines, and we take list of all vars on the RHS {'Rhs'}{'Vars'}{'List'} and add these to $index_vars
	# We do this until we have all of them. Basically, if we start from the back and push in reverse, we can do this in a single pass
		
		if (exists $info->{'Assignment'} ) {
			my $lhs_var = $info->{'Lhs'}{'VarName'};
			if (exists $state->{'IndexVars'}{$lhs_var}) {				
				unshift @{ $state->{'LiftedIndexCalcLines'} }, dclone($annline);
				$info->{'Deleted'}=1;
	  			my $rhs_vars = $info->{'Rhs'}{'Vars'}{'Set'};
				$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $rhs_vars } };				  
				return ([["! $line",$info]],$state);
			}
		} elsif (exists $info->{'SubroutineCall'} ) {
			for my $arg ( @{ $info->{'SubroutineCall'}{'Args'}{'List'} } ){
				if (exists $state->{'IndexVars'}{$arg} ) {					
					unshift @{ $state->{'LiftedIndexCalcLines'} }, dclone($annline);
					$info->{'Deleted'}=1;
		  			my $args = $info->{'SubroutineCall'}{'Args'}{'Set'};
		  			# TODO: of course this ignores any indices or function call args
					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $args } };				  
					return ([["! $line",$info]],$state);
				}
			}
		}
		 	# Then we can remove the declarations as well, and store these in LiftedIndexVarDecls
		elsif (exists $info->{'VarDecl'}) {
			my $decl_var = $info->{'VarDecl'}{'Name'};
			if (exists $state->{'IndexVars'}{$decl_var}) {				
				unshift @{ $state->{'LiftedIndexVarDecls'}{'List'} }, dclone($annline);
				$state->{'LiftedIndexVarDecls'}{'Set'}{$decl_var}=dclone($annline);
				$info->{'Deleted'}=1;	  											  
				return ([["! $line",$info]],$state);
			}			
		}
		# Finally we remove the $index_vars from the Args in the Signature
		elsif (exists $info->{'Signature'} ) {
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {				
				if (not exists $state->{'IndexVars'}{$arg} ) {
					push @{$new_args}, $arg;
				} else {
					push @{ $state->{'DeletedArgs'} }, $arg;
					delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg};
					my @updated_args_list = grep {$_ ne $arg } @{ $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'} };
					$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'} = [@updated_args_list];				
				}
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$state->{'RemainingArgs'}=$new_args;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };			
		}
		
		return ([[$line,$info]],$state);
	};
	$state->{'RemainingArgs'}=[];
	$state->{'DeletedArgs'}=[];
	$state->{'LiftedIndexCalcLines'}=[];
	$state->{'LiftedIndexVarDecls'}={'List'=>[],'Set'=>{}};
	$state->{'LiftedStreamVarDecls'}={'List'=>[],'Set'=>{}};
 	($stref,$state) = stateful_pass_reverse_inplace($stref,$f,$pass_lift_array_index_calculations, $state,'_rename_array_accesses_to_scalars_lift() ' . __LINE__  ) ;

	# And then we can update $stref->{$Subroutines}{$f} and add LiftedIndexCalcLines and LiftedIndexVarDecls so that when we find a call we can splice in these lines
	$stref->{'Subroutines'}{$f}{'LiftedIndexCalcLines'}=dclone($state->{'LiftedIndexCalcLines'});
	$stref->{'Subroutines'}{$f}{'LiftedIndexVarDecls'}=dclone($state->{'LiftedIndexVarDecls'});
	
# --------------------------------------------------------------------------------------------------------		
	# 6. Now we emit the updated code for the subroutine signature, the variable declarations, assignment expressions and ifthen expressions
	
	my $pass_emit_updated_code = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		my $rline=$line;
		
		my $rlines=[];
		if (exists $info->{'Signature'} ) {
			($rline, $info) = emit_subroutine_sig( $annline);
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];			
		} elsif (
			exists $info->{'VarDecl'} and exists $info->{'ParsedVarDecl'}{'StreamVars'}
		) {
		
			my $tvar_rec = $info->{'ParsedVarDecl'};
			for my $tvar (sort keys %{  $tvar_rec->{'StreamVars'} }) {
				my $type = $tvar_rec->{'TypeTup'}{'Type'};
				my $kind = exists $tvar_rec->{'TypeTup'}{'Kind'} ? '(kind='.$tvar_rec->{'TypeTup'}{'Kind'} .')' : '';
				# my $intent = $tvar_rec->{'StreamVars'}{$tvar}{'IODir'};
				# croak Dumper $tvar_rec->{'StreamVars'}{$tvar} if $tvar=~/v/;
				# So we should only have IODir if $intent is defined, i.e. if the IODir key exists
				my $rdecl = {
				'Indent' => $info->{'Indent'},
				'Type'   => $type.$kind,
				'Attr'   => '',
				'Dim'    => [],
				'Name'   => $tvar,
				# 'IODir'  => $intent,
				'ArrayOrScalar'=>'Scalar'
				};
				if (exists $tvar_rec->{'StreamVars'}{$tvar}{'IODir'}) {
					$rdecl->{'IODir'}=$tvar_rec->{'StreamVars'}{$tvar}{'IODir'};
				}
				$rline = emit_f95_var_decl($rdecl);
				my $orig_name =$info->{'VarDecl'}{'Name'}; 
                my $rinfo = dclone($info);
				$rinfo->{'VarDecl'}{'Name'}=$tvar;
				$rinfo->{'VarDecl'}{'OrigName'}=$orig_name;
				say $rline if $DBG;
				my $rannline=[$rline,$rinfo];
				$stref->{'Subroutines'}{$f}{'LiftedStreamVarDecls'}{'Set'}{$tvar}=dclone($annline);
				
				if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$tvar}) { 					 
					$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$tvar}=$rdecl;
				} 
				push @{$rlines},$rannline;			
			}	
		} elsif (exists $info->{'Assignment'} ) {
			($rline, $info)=_emit_assignment($annline);
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];
		} elsif (exists $info->{'If'} ) {
			($rline, $info)=_emit_ifthen($annline);
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];			
		} else {
			if ( exists $info->{'PlaceHolders'} ) { 
				while ($rline =~ /(__PH\d+__)/) {
					my $ph=$1;
					my $ph_str = $info->{'PlaceHolders'}{$ph};
					$rline=~s/$ph/$ph_str/;
				}
			}                                    
            $info->{'Ref'}++;
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];
		}
		return ($rlines,[$stref,$f]);
	};
	
	$stref->{'Subroutines'}{$f}{'LiftedStreamVarDecls'}={'Set'=>{},'List'=>[]};
	my $global_state_access=[$stref,$f];
 	($stref,$global_state_access) = stateful_pass_inplace($stref,$f,$pass_emit_updated_code , $global_state_access,'_rename_array_accesses_to_scalars_PASS3() ' . __LINE__  ) ;
	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}= $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'};
	} # IF NOT A KERNEL
	# if ($f =~/f1/) {
	# say Dumper pp_annlines($stref->{'Subroutines'}{$f}{'RefactoredCode'}) ;
	# croak;
	# }
	return $stref;
} # END of _rename_array_accesses_to_scalars()
# ================================================================================================================================================
# After we've renamed all args in the subroutine definitions, we update the calls as well, but ONLY in the kernel 
sub _rename_array_accesses_to_scalars_in_subcalls { (my $stref, my $f) = @_;
# croak 'shapiro_map_16: '.Dumper( $stref->{'Subroutines'}{'shapiro_map_16'}{'DeclaredOrigArgs'});
# croak Dumper $stref->{'Subroutines'}{'f1'}{'DeclaredOrigArgs'};
	if ($f eq $Config{'KERNEL'} ) {
			
	my $pass_action = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		my $rline=$line;
		my $rlines=[];
		if ( exists $info->{'SubroutineCall'} and 
			not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
			){
				my $subname = $info->{'SubroutineCall'}{'Name'};
		
		
	#  croak $subname.': '.Dumper( $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}); # 
	
				# Collect stream and index var declarations for all called subs 
				$stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} = {
					%{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} },
					%{ $stref->{'Subroutines'}{$subname}{'LiftedIndexVarDecls'}{'Set'} },
					%{ $stref->{'Subroutines'}{$subname}{'LiftedStreamVarDecls'}{'Set'} },
				};	
				for my $lifted_var ( sort keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} } ) {		
					# warn 		"$f =>	$subname => $lifted_var "; 
					if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var}
					and not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$lifted_var}					
					) {						
						my $var_rec = get_var_record_from_set( $stref->{'Subroutines'}{$subname}{'Vars'},$lifted_var );
						if (defined $var_rec ) {
							$stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var}= dclone( $var_rec );
						} else {
							warn "No declaration record for $lifted_var in $subname!";
						}
					}
				}
				
				($rline, $info) = _emit_subroutine_call_w_streams( $stref, $f, $annline);
				say $rline if $DBG;
				push @{$rlines},[$rline,$info];
				
				
		} else {
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];
		}		
		return ($rlines,[$stref,$f]);
	};
	
	$stref->{'Subroutines'}{$f}{'LiftedVarDecls'}={'Set'=>{},'List'=>{}};
	my $state=[$stref,$f];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_action, $state,'_rename_array_accesses_to_scalars_called_subs() ' . __LINE__  ) ;	
	@{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'List'} } = sort keys %{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'Set'}};
	
	} # IF KERNEL

	return $stref;
} # END of _rename_array_accesses_to_scalars_called_subs()
# ================================================================================================================================================

sub _update_call_args { (my $stref, my $f) = @_;
	 
	if ($f eq $Config{'KERNEL'} ) {
			
	my $pass_update_call_args = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		my $Sf        = $stref->{'Subroutines'}{$f};
		my $rline=$line;
		my $rlines=[];
		if ( exists $info->{'SubroutineCall'} and 
			not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
			){
				my $subname = $info->{'SubroutineCall'}{'Name'};
				
			# First update the ArgMap 
			# This is to account for the renamed pointers
			
			for my $sig_arg (keys %{$info->{'SubroutineCall'}{'ArgMap'} }) {
				my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
					# This is only correct if the signature arg is a scalar. 
				my $sig_iodir = $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$sig_arg}{'IODir'};
				if ($sig_iodir ne 'in') { # means the sig arg is a pointer anyway
					if ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'} eq $call_arg.'(1)') {
						$info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'} = $call_arg;
					}
				}
			}
		# Then update CallArgs 
	      
			my $indent = $info->{'Indent'} // '      ';
		    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
		    my @new_call_exprs = map  { $info->{'SubroutineCall'}{'Args'}{'Set'}{$_}{'Expr'} } @{$info->{'SubroutineCall'}{'Args'}{'List'}};  
		    my $args_str = join( ',', @new_call_exprs );	    
		    my $rline = "call $subname($args_str)\n";
		    my $updated_expr_ast = parse_expression("$subname($args_str)",$info, $stref,$f);
		    $info->{'SubroutineCall'}{'ExpressionAST'}=$updated_expr_ast;
	
	      $rlines=[[$rline, $info]];
		} else {
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];
		}
				
		return ($rlines,[$stref,$f]);
	};	

	my $state=[$stref,$f];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_update_call_args, $state,'pass_update_call_args() ' . __LINE__  ) ;		
	 	    
	} # IF KERNEL	
	return $stref;
} # END of _update_call_args()
# ================================================================================================================================================
# After we've renamed all args in the subroutine definitions, we update the calls as well, but ONLY in the kernel 
sub _add_assignments_for_called_subs { (my $stref, my $f) = @_;
	if ($f eq $Config{'KERNEL'} ) {
			
	my $pass_action = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		my $rline=$line;
		my $rlines=[];
		if ( exists $info->{'SubroutineCall'} and 
			not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
			){
				my $subname = $info->{'SubroutineCall'}{'Name'};
				if ( exists  $stref->{'Subroutines'}{$subname}{'LiftedIndexCalcLines'} ) {				
					$rlines = [@{$rlines},@{ $stref->{'Subroutines'}{$subname}{'LiftedIndexCalcLines'} }];
				}								
				if ( exists  $stref->{'Subroutines'}{$subname}{'LiftedScalarAssignments'} ) {
					for my $lifted_annline ( @{ $stref->{'Subroutines'}{$subname}{'LiftedScalarAssignments'} } ) {

						my $var = $lifted_annline->[1]{'Lhs'}{'VarName'};
						if (exists $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}) {
						my $iodir =  exists $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'}
						? $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'} : 'Unknown';
						if ($iodir eq 'in' or $iodir eq 'inout') {
							push @{$rlines}, $lifted_annline;
						} 
						}
					}				
				}								
				# The actual subroutine call line				
				push @{$rlines},$annline;
				
				if ( exists  $stref->{'Subroutines'}{$subname}{'LiftedArrayAssignments'} ) {				
					for my $lifted_annline ( @{ $stref->{'Subroutines'}{$subname}{'LiftedArrayAssignments'} } ) {
						my $var = $lifted_annline->[1]{'Rhs'}{'Vars'}{'List'}[0];
						if (exists $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}) {
						my $iodir = exists $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'} 
						? $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'}
						: 'Unknown';
						if ($iodir eq 'out' or $iodir eq 'inout') {
							push @{$rlines}, $lifted_annline;
						} 
						}
					}						
				}						
		} else {
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];
		}		
		return ($rlines,[$stref,$f]);
	};
	
	my $state=[$stref,$f];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_action, $state,'_rename_array_accesses_to_scalars_called_subs() ' . __LINE__  ) ;	
	@{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'List'} } = sort keys %{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'Set'}};
# --------------------------------------------------------------------------------------------------------			
	# Here we add the variable declarations for variables used in the lifted assignments	
	my $pass_add_decls_lifted_vars = sub { (my $annline, my $state)=@_;	
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		
		if ( exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'};
			if (exists $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$var} ) {
			say "VAR $var from LiftedVarDecls already declared in $f"  if $DBG;
			 delete $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$var};
			}
		}				
		return ([$annline],$state);
	};
	
#	my $state=[$stref,$f];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_add_decls_lifted_vars, $state,'pass_add_decls_lifted_vars() ' . __LINE__  ) ;	

	my @lifted_var_decls = map { $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$_} } sort keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} };
#	say "\nSUB: $f\n";say Dumper(\@lifted_var_decls);
	
	# Now we want to splice these after the last var decl 
    my $merged_annlines = splice_additional_lines_cond_inplace( $stref, $f, sub {(my $al)=@_;exists $al->[1]{'VarDecl'} ? 1 : 0 }, $stref->{'Subroutines'}{$f}{'RefactoredCode'}, \@lifted_var_decls,1, 0,1);
    $stref->{'Subroutines'}{$f}{'RefactoredCode'}=$merged_annlines;
# --------------------------------------------------------------------------------------------------------		 	    
	} # IF KERNEL
	return $stref;
} # END of _add_assignments_for_called_subs()


# ================================================================================================================================================
# Finally, after having updated the calls we can add the missing declarations
# I am making the assumption that in the superkernel we will assign the variables to the original array accesses
# However, the array indices are computed from the global id on a per-sub basis.
# Meaning that i,j,k are different for each sub.
# So  we need to extract the calculations of i,j,k out of the sub
# We can do this by analysing which vars are used in the array accesses
# Then for each of these, which vars they use, I guess the best way is to go through the annlines in reverse 
# Then all the expressions and declarations can be removed from the sub and the args from the sig
# Then when we find a call we need to insert the expressions before the call, and then the array assignments
# Then we need to add the missing declarations.
# Clearly, this is a lot of work


	# This function changes functions to arrays

#['@','vn',
#						[
#							'+',['$','j'],['-','1']
#						],
#						['$','k']
#					],

# $state->{'StreamVars'}{$mvar}{'Set'} = {
# 	$var_str => {
# 		'IODir'=>$intent,
# 		'ArrayIndexExpr'=>$expr_str
# 		},
# 	};
# It would be best, I guess, if we simply had Accesses and Dims in here
# $intent can be undefined, because $ast can (of course) be a non-arg variable.
# In that case we should not have the IODir entry. 
sub _scalarise_array_accesses_in_ast { (my $stref, my $f,  my $state, my $ast, my $intent)=@_;
# croak 'HERE';
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {		
			my $entry = $ast->[$idx];
	
			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _scalarise_array_accesses_in_ast($stref,$f, $state,$entry,$intent);
				$ast->[$idx] = $entry;
			} else {
				if ($idx==0 and (($entry & 0xFF) == 10)) {#'@'				
					my $mvar = $ast->[$idx+1];			
							
					say 'Found array access '.$mvar  if $DBG;		
					if (exists $stref->{'Subroutines'}{$f}{'StreamVars'}{$mvar}) {
						# carp 'Found array access '.$mvar  ; 
						my $expr_str = emit_expr_from_ast($ast);
						my $var_str=$expr_str;
						# TODO: I should use tr// here
						$var_str=~s/[\(,]/_/g; 
						$var_str=~s/\)//g; 
						$var_str=~s/\+/p/g;
						$var_str=~s/\-/m/g;
						$var_str=~s/\*/t/g;
						# Taking the IODir from the orig var is not optimal: it leads to many InOut that actually are Out
						# Ideally I should re-run the analysis for the stream vars
						
						if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$mvar}) { 
							if (exists $state->{'StreamVars'}{$mvar}{'Set'}{$var_str}) {
								if ( $state->{'StreamVars'}{$mvar}{'Set'}{$var_str}{'IODir'} ne 'InOut'
									and $state->{'StreamVars'}{$mvar}{'Set'}{$var_str}{'IODir'} ne $intent) {
									$state->{'StreamVars'}{$mvar}{'Set'}{$var_str}{'IODir'} = 'InOut';
								} 
							} else {
								$state->{'StreamVars'}{$mvar}{'Set'}{$var_str}={'IODir'=>$intent,'ArrayIndexExpr'=>$expr_str} ;
							}
						} else {
							$state->{'StreamVars'}{$mvar}{'Set'}{$var_str}={'ArrayIndexExpr'=>$expr_str} ;
						}					
						
						$ast=[0x2+(($entry>>8)<<8),$var_str];#'$'
						last;			
					}  
					# else {
					# 	say "VAR $mvar IS NOT A STREAM VAR in $f" if $DBG;
					# }		
				} 
			}		
		}
	}
	return  ($ast, $state);		
}
# ================================================================================================================================================
sub _emit_assignment { (my $annline)=@_;
	( my $line, my $info ) = @{$annline};
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
	my $lhs = emit_expr_from_ast($lhs_ast);
	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};
	my $rhs = emit_expr_from_ast($rhs_ast);
	my $rline = $info->{'Indent'}.$lhs.' = '.$rhs;
	if (exists $info->{'If'}) {
		(my $if_str, my $if_info) = _emit_ifthen($annline);
		$rline =$if_str.' '.$rline; 
	}	
	return ($rline, $info);
}
# ================================================================================================================================================
sub _emit_ifthen { (my $annline)=@_;
	( my $line, my $info ) = @{$annline};
	my $cond_expr_ast=$info->{'Cond'}{'Expr'};
	my $cond_expr = emit_expr_from_ast($cond_expr_ast);
	my $rline = $info->{'Indent'}.'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? 'then' : '');	
	return ($rline, $info);
}

sub _emit_subroutine_call_w_streams {
    (my $stref, my $f, my $annline) = @_;
	my $Sf   = $stref->{'Subroutines'}{$f};

    (my $line, my $info) = @{$annline};    
    my $name = $info->{'SubroutineCall'}{'Name'};
    my $new_arg_map = $info->{'SubroutineCall'}{'ArgMap'};

    # Then update CallArgs and again the ArgMap
    my $orig_call_args = $info->{'SubroutineCall'}{'Args'}{'List'};
    my $new_call_args  = [];
    for my $call_arg (@{$orig_call_args}) {
        # get the sig_arg
        my $current_sig_arg = $call_arg;
        for my $sig_arg (keys %{$new_arg_map}) {
            if ($new_arg_map->{$sig_arg} eq $call_arg) {
                $current_sig_arg = $sig_arg;
                last;
            }
        }

        if (exists $stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}) {
            $new_call_args = [@{$new_call_args}, @{$stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}{'List'}}];
            delete $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg};
            map { $info->{'SubroutineCall'}{'Args'}{'Set'}{$_} = {'Expr' => $_, 'Type' => 'Scalar'} }
              @{$stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}{'List'}};
            delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
            for my $stream_arg (@{$stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}{'List'}}) {
                $info->{'SubroutineCall'}{'ArgMap'}{$stream_arg} = $stream_arg;
            }
        }
        elsif (exists $stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'}{$current_sig_arg}) {
            push @{$new_call_args}, $call_arg;
        }
        else {
            # This argument was deleted
            delete $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg};
            delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
        }
    }
    $info->{'SubroutineCall'}{'Args'}{'List'} = $new_call_args;
    my $args_ref = $stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'List'};

	(my $rline, my $rinfo) = emit_subroutine_call($stref, $f, [$line, $info]);
    # my $indent = $info->{'Indent'} // '      ';
    # my $maybe_label =
    #   (exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}}) ? $info->{'Label'} . ' ' : '';
    # my @new_call_exprs   = map { $info->{'SubroutineCall'}{'Args'}{'Set'}{$_}{'Expr'} } @{$new_call_args};
    # my $args_str         = join(',', @new_call_exprs);
    # my $rline            = "call $name($args_str)\n";
    # my $updated_expr_ast = parse_expression("$name($args_str)", $info, $stref, $f);
    # $info->{'SubroutineCall'}{'ExpressionAST'} = $updated_expr_ast;

    # if (exists $info->{'PlaceHolders'}) {
    #     while ($rline =~ /(__PH\d+__)/) {
    #         my $ph     = $1;
    #         my $ph_str = $info->{'PlaceHolders'}{$ph};
    #         $rline =~ s/$ph/$ph_str/;
    #     }
    #     $info->{'Ref'}++;
    # }
    # $info->{'Ann'} = [annotate($f, __LINE__)];
    # return ($indent . $maybe_label . $rline, $info);
	return ( $rline, $rinfo)
}    # END of _emit_subroutine_call_w_streams


# This function returns a map linking the names to the linear offsets and also the scalarised args in the correct order
sub link_scalarised_vars_to_linear_offsets { (my $var, my $accesses, my $array_dims)=@_;

    my $offsets_for_scalarised_vars = {};
    my $scalarised_vars_for_offsets = {};
    my $ordered_stencil_var_tuple = [];
# { '0:1' =>  {'j:0' => [1,0],'k:1' => [1,1]}}, 
# [[0,501],[1,500],...]

    for my $offset_str (sort keys %{$accesses}) {
        my $offset_tuple=[split(/:/,$offset_str)];
		# say Dumper($offset_str);
        my $lin_offset = _calc_linear_offset($offset_tuple,$array_dims );
        # Calculate the linear offset
        my $access_map = $accesses->{$offset_str};
        # Generate the scalarised var names
        my @ordered_iter_seq=();
		# say Dumper($offset_str,$accesses->{$offset_str});
        for my $iter_pair (  @{ $accesses->{$offset_str} } ) {
			my ($iter_str,$iter_mult_offset) = each %{$iter_pair};
			
            my ($iter, $iter_idx) = split(/:/,$iter_str);
            my ($mult, $offset) = @{$iter_mult_offset};# @{$accesses->{$offset_str}{$iter_str}};
            $ordered_iter_seq[$iter_idx]=__iter_rec_to_scal_str($iter, $mult, $offset);
        }
        my $scalarised_var_name = join('_',($var,@ordered_iter_seq));
        $offsets_for_scalarised_vars->{$scalarised_var_name}=$lin_offset;
        $scalarised_vars_for_offsets->{$lin_offset}=$scalarised_var_name;
    }
    my @stencil_order =  sort numeric keys %{$scalarised_vars_for_offsets};
    $ordered_stencil_var_tuple = [map { $scalarised_vars_for_offsets->{$_} } @stencil_order];
    return ($offsets_for_scalarised_vars,$ordered_stencil_var_tuple);
} # END of link_scalarised_vars_to_linear_offsets

# This is the same as the regex used to scalarise:
# - if the mult is <0, I emit "m$mult"
# For example,  
#    v[-2*j+3] => m2tjp3
#    v[0*j-3] => m3
# The most common cases are of course
#   v[j+1] => jp1
#   v[k-1] => km1
sub __iter_rec_to_scal_str {
    my ($iter, $mult, $offset) = @_;

    my $mult_str = $mult <0 ? 'm'.(-1*$mult) : $mult;
    my $offset_str = $offset ==0 ? '' : $offset <0 ? 'm'.(-1*$offset) : 'p'.$offset;
    my $mult_prefix = $mult != 1 ? $mult_str.'t' : '';
    my $scal_iter_str = $mult == 0 ? $offset_str : $mult_prefix. $iter . $offset_str;
    return $scal_iter_str;
} # END of __iter_rec_to_scal_str

# Maybe this is for TyTra Common
sub _calc_linear_offset {    my ($index_tuple,$array_dims ) =@_;
        my @ranges       = ();
        my @lower_bounds = ();
        my $n_dims       = scalar @{$array_dims};
        for my $array_dim (@{$array_dims}) {
            push @ranges,       eval($array_dim->[1] . ' - ' . $array_dim->[0] . ' + 1');
            push @lower_bounds, $array_dim->[0];
        }
        if ($n_dims == 1) {
            return F1D2C(@lower_bounds, @{$index_tuple});
        }
        elsif ($n_dims == 2) {
            return F2D2C($ranges[0], @lower_bounds, @{$index_tuple});
        }
        elsif ($n_dims == 3) {
            return F3D2C(@ranges[0 .. 1], @lower_bounds, @{$index_tuple});
        }
        elsif ($n_dims == 4) {
            return F4D2C(@ranges[0 .. 2], @lower_bounds, @{$index_tuple});
        }
        else {
            croak "Sorry, only up to 4 dimensions supported right now!";
        }
}




1;
