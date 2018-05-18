package RefactorF4Acc::Refactoring::Streams;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( 
	pass_wrapper_subs_in_module 
	stateful_pass 
	stateful_pass_reverse 
	stateless_pass  
	emit_f95_var_decl 
	splice_additional_lines_cond  
	);
use RefactorF4Acc::Refactoring::Subroutines qw( emit_subroutine_sig );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Parser::Expressions qw(
	parse_expression
	emit_expression
	get_vars_from_expression
	);

# 
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

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
	&_declare_undeclared_variables
	&_removed_unused_variables
	&_fix_scalar_ptr_args
	&_fix_scalar_ptr_args_subcall
	&_make_dim_vars_scalar_consts_in_sigs
);

sub pass_rename_array_accesses_to_scalars {(my $stref)=@_;
	$stref = pass_wrapper_subs_in_module($stref,
			[
				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
#				[ \&_fix_scalar_ptr_args ],
#		  		[\&_fix_scalar_ptr_args_subcall],
		  		[
			  		\&_declare_undeclared_variables,
					\&_rename_array_accesses_to_scalars,
					\&_removed_unused_variables,
				],
				[
					\&_rename_array_accesses_to_scalars_called_subs
				],			
				[
					\&determine_argument_io_direction_rec
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
		'VarList' => {
			'List' => ['g_ptr'],
			'Set' => {
				'g_ptr' => {'Type' => 'Array','Vars' => {}}				
			}
		}
	},
	'LineID' => 32,
	'Ref' => 0
}


# hsn = 0.5*(vn(j-1,k)-abs(vn(j-1,k)))*h(j,k)
{
	'Assignment' => 1,
	'Indent' => '  ',
	'Lhs' => {'ArrayOrScalar' => 'Scalar','IndexVars' => {'List' => [],'Set' => {}},'ExpressionAST' => ['$','hsn'],'VarName' => 'hsn'},'Ref' => 0,'LineID' => 76,
	'Rhs' => {
	'VarList' => {
		'List' => ['h','_OPEN_PAR_','j','k','vn'],
		'Set' => {
			'h' => {
				'Type' => 'Array',
				'Vars' => {'k' => {'Type' => 'Scalar'},'j' => {'Type' => 'Scalar'}}
			},
			'k' => {'Type' => 'Scalar'},
			'vn' => {'Type' => 'Array'},
			'_OPEN_PAR_' => {
				'Vars' => {
					'j' => {'Type' => 'Scalar'},
					'vn' => {'Type' => 'Array'},
					'k' => {'Type' => 'Scalar'}
				},
				'Type' => 'Array'
			},
			'j' => {'Type' => 'Scalar'}
		}
	},
	'ExpressionAST' => [
		'*','0.5',[
			'@','_OPEN_PAR_',[
				'+',['@','vn',
						[
							'+',['$','j'],['-','1']
						],
						['$','k']
					],
					['-',
						['&','abs',['@','vn',['+',['$','j'],['-','1']],['$','k']]]]]],['@','h',['$','j'],['$','k']]]
	}
}
=cut
# ================================================================================================================================================	
# This composite pass renames array accesses in the called subroutines in a superkernel to scalar accesses
sub _rename_array_accesses_to_scalars { (my $stref, my $f) = @_;
	if ($f ne $Config{'KERNEL'} ) {
		
	# This pass performs renaming in assignments and conditional expressions of IFs
	# TODO: It does _not_ rename
	# * subroutine call arguments (because there should not be any)
	# * SELECT CASE arguments
	# * DO index range expressions  
	my $pass_rename_array_accesses_in_exprs = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Assignment'} ) {
#			carp $line;
			if (scalar @{ $info->{'Rhs'}{'VarList'}{'List'} } == 1 and $info->{'Rhs'}{'VarList'}{'List'}[0]=~/_ptr/) {
				croak 'FIXME: What we want is that only array variables with IndexVars are renamed. So constant indices should stay as they are';
				# IGNORE, this is not a true array access: this is an assignment of the shape
				# v = v_ptr(1)
				# and we will remove these later on
			} else {				
				# Rename all array accesses in the RHS AST. This updates $state->{'StreamVars'}
				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'In');
				 $info->{'Rhs'}{'ExpressionAST'}=$ast;
				 if (ref($ast) ne '') {
				my $vars=get_vars_from_expression($ast,{}) ;
#				croak "CARP:".Dumper($vars);
				$info->{'Rhs'}{'VarList'}{'Set'}=$vars;
				$info->{'Rhs'}{'VarList'}{'List'}= [ grep {$_ ne 'IndexVars' and $_ ne '_OPEN_PAR_' } sort keys %{$vars} ];
				 } else {
				 	$info->{'Rhs'}{'VarList'}={'List'=>[],'Set'=>{}};
				 }
			}
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array') {
				# Rename all array accesses in the LHS AST. This updates $state->{'StreamVars'}
				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'}, 'Out');
				$info->{'Lhs'}{'ExpressionAST'}=$ast;
				my $stream_var = $ast->[1];		
				$info->{'Lhs'}{'VarName'} = $stream_var;
				$info->{'Lhs'}{'ArrayOrScalar'} = 'Scalar';
			}
			$state->{'IndexVars'}={ %{$state->{'IndexVars'} }, %{ $info->{'Lhs'}{'IndexVars'}{'Set'} } };
			for my $var ( @{ $info->{'Rhs'}{'VarList'}{'List'} } ) {
				next if $var eq '_OPEN_PAR_';
				if ($info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Type'} eq 'Array' and exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'}) {					
					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'} } }
				}
			}				
		} 
		if (exists $info->{'If'} ) {					
			my $cond_expr_ast = $info->{'CondExecExprAST'};
			# Rename all array accesses in the AST. This updates $state->{'StreamVars'}			
			(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $cond_expr_ast, 'In');			
			$info->{'CondExecExpr'}=$ast;
			for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
				next if $var eq '_OPEN_PAR_';
				if ($info->{'CondVars'}{'Set'}{$var}{'Type'} eq 'Array' and exists $info->{'CondVars'}{'Set'}{$var}{'IndexVars'}) {					
					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} } }
				}
			}
				 if (ref($ast) ne '') {
				my $vars=get_vars_from_expression($ast,{}) ;

				$info->{'CondVars'}{'Set'}=$vars;
				$info->{'CondVars'}{'List'}= [ grep {$_ ne 'IndexVars' and $_ ne '_OPEN_PAR_' } sort keys %{$vars} ];
				 } else {
				 	$info->{'CondVars'}={'List'=>[],'Set'=>{}};
				 }
			
						
		}
		return ([[$line,$info]],$state);
	};

	my $state = {'IndexVars'=>{}, 'StreamVars'=>{}};
 	($stref,$state) = stateful_pass($stref,$f,$pass_rename_array_accesses_in_exprs, $state,'pass_rename_array_accesses_in_exprs ' . __LINE__  ) ;
 	
# 	carp Dumper($state) if $f eq 'sub_map_124';
# -------------------------------------------------------------------------------------------------------- 	
 	# Now we create new assignment lines, these go into LiftedScalarAssignments 
 	# v_i_j = v(i,j)
	# The reverse go into LiftedArrayAssignments 
 	# v(i,j) = v_i_j
 	# In principle, we should check the IODir. If it is In or InOut, it needs scalar assignment; if it is Out or InOut, it needs array assignment
 	$stref->{'Subroutines'}{$f}{'LiftedScalarAssignments'}=[];
 	$stref->{'Subroutines'}{$f}{'LiftedArrayAssignments'}=[];
 	# StreamVars has the original array var as key, a list of entries for the renamed scalars as value
 	# Each of these entries has a field ArrayIndexExpr
	for my $var (sort keys %{ $state->{'StreamVars'} } ){
		$state->{'StreamVars'}{$var}{'List'}=[];
		for my $stream_var (sort keys %{ $state->{'StreamVars'}{$var}{'Set'} } ){
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
							'VarList' => {'List' => $scalar_assignment_rhs_vars_list,'Set' =>$scalar_assignment_rhs_vars},
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
							'VarList' => {
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
	# So now we have identified all stream vars. In the next pass, update the subroutine Signature and VarDecl declarations in $info
	# We update DeclaredOrigArgs record of $f in a separate pass below
	my $pass_update_sig_and_decls = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Signature'} ) { 			
			# What we do is replace the array args with the "tuple" of scalar args from StreamVars
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
				if (exists $state->{'StreamVars'}{$arg} ) {
					$new_args=[@{$new_args},  @{ $state->{'StreamVars'}{$arg}{'List'} }  ];										
				} else {
					push @{$new_args}, $arg;
				} 
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
			
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
				} else {
					croak "TROUBLE: ".Dumper($annline); 
				}
			}
		}
		return ([[$line,$info]],$state);
	};

 	($stref,$state) = stateful_pass($stref,$f,$pass_update_sig_and_decls, $state,'pass_update_sig_and_decls' . __LINE__  ) ;
 	
# --------------------------------------------------------------------------------------------------------	
	# Here we update DeclaredOrigArgs and DeclaredOrigArgs
 	# At this point the argument list already has the stream vars as args
 	
 	my @updated_args_list=();		
	for my $orig_arg ( @{ $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'} } ) {		
		if (exists $state->{'StreamVars'}{$orig_arg}) {
			my $new_decl = dclone( $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg} );
			for my $new_arg (@{ $state->{'StreamVars'}{$orig_arg}{'List'} }) {
				push @updated_args_list,$new_arg;
				$new_decl->{'ArrayOrScalar'}='Scalar';
				$new_decl->{'Dim'}=[];
				$new_decl->{'IODir'}=$state->{'StreamVars'}{$orig_arg}{'Set'}{$new_arg}{'IODir'};
				$new_decl->{'ArrayIndexExpr'}=$state->{'StreamVars'}{$orig_arg}{'Set'}{$new_arg}{'ArrayIndexExpr'};
				$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$new_arg}=$new_decl;
				delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg};				
			}			
		} else {
			if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg} ) {
				push @updated_args_list, $orig_arg;	
			}
		}
	}
	
	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=[@updated_args_list]; 	
	
# --------------------------------------------------------------------------------------------------------	 	
 	# So at this point we should do the lifting of everything to do with indexing
 	
# Finally, after having updated the calls we can add the missing declarations
# In the superkernel we will assign the variables to the original array accesses
# However, the array indices are computed from the global id on a per-sub basis so i,j,k are different for each sub.
# So  we need to extract the calculations of i,j,k out of the sub

	my  $pass_lift_array_index_calculations = sub {(my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
	# Every Assignment line that has one of these on the LHS gets removed from AnnLines and stored in LiftedIndexCalcLines, and we take list of all vars on the RHS {'Rhs'}{'VarList'}{'List'} and add these to $index_vars
	# We do this until we have all of them. Basically, if we start from the back and push in reverse, we can do this in a single pass
		
		if (exists $info->{'Assignment'} ) {
			my $lhs_var = $info->{'Lhs'}{'VarName'};
			if (exists $state->{'IndexVars'}{$lhs_var}) {				
				unshift @{ $state->{'LiftedIndexCalcLines'} }, dclone($annline);
				$info->{'Deleted'}=1;
	  			my $rhs_vars = $info->{'Rhs'}{'VarList'}{'Set'};
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
#			if (exists $state->{'StreamVars'}{$decl_var}) {
#				croak $decl_var.Dumper($annline);
#			}
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
 	($stref,$state) = stateful_pass_reverse($stref,$f,$pass_lift_array_index_calculations, $state,'_rename_array_accesses_to_scalars_lift() ' . __LINE__  ) ;

	# And then we can update $stref->{$Subroutines}{$f} and add LiftedIndexCalcLines and LiftedIndexVarDecls so that when we find a call we can splice in these lines
	$stref->{'Subroutines'}{$f}{'LiftedIndexCalcLines'}=dclone($state->{'LiftedIndexCalcLines'});
	$stref->{'Subroutines'}{$f}{'LiftedIndexVarDecls'}=dclone($state->{'LiftedIndexVarDecls'});
	
## --------------------------------------------------------------------------------------------------------	
#	# Here we update DeclaredOrigArgs and DeclaredOrigArgs
# 	# At this point the argument list already has the stream vars as args
# 	
# 	my @updated_args_list=();		
#	for my $orig_arg ( @{ $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'} } ) {
#		
#		if (exists $state->{'StreamVars'}{$orig_arg}) {
#			my $new_decl = dclone( $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg} );
#			for my $new_arg (@{ $state->{'StreamVars'}{$orig_arg}{'List'} }) {
#				push @updated_args_list,$new_arg;
#				$new_decl->{'ArrayOrScalar'}='Scalar';
#				$new_decl->{'Dim'}=[];
#				$new_decl->{'IODir'}=$state->{'StreamVars'}{$orig_arg}{'Set'}{$new_arg}{'IODir'};
#				$new_decl->{'ArrayIndexExpr'}=$state->{'StreamVars'}{$orig_arg}{'Set'}{$new_arg}{'ArrayIndexExpr'};
#				$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$new_arg}=$new_decl;
#				delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg};				
#			}			
#		} else {
#			if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$orig_arg} ) {
#				push @updated_args_list, $orig_arg;	
#			}
#		}
#	}
#	
#	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=[@updated_args_list];
#	croak Dumper($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}) if $f eq 	'sub_map_124';
	

#	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}=$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'};
#	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'};		
# --------------------------------------------------------------------------------------------------------		
	# Now we emit the updated code for the subroutine signature, the variable declarations, assignment expressions and ifthen expressions
	
	 	
	my $pass_emit_updated_code = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		my $rline=$line;
		
		my $rlines=[];
		if (exists $info->{'Signature'} ) {
#			croak Dumper($info->{'Signature'}{'Args'}{'List'}); 
			($rline, $info) = emit_subroutine_sig( $stref, $f, $annline);
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];			
		} elsif (
			exists $info->{'VarDecl'} and exists $info->{'ParsedVarDecl'}{'StreamVars'}
		) {
		
			my $tvar_rec = $info->{'ParsedVarDecl'};
			for my $tvar (sort keys %{  $tvar_rec->{'StreamVars'} }) {
				my $type = $tvar_rec->{'TypeTup'}{'Type'};
				my $kind = exists $tvar_rec->{'TypeTup'}{'Kind'} ? '(kind='.$tvar_rec->{'TypeTup'}{'Kind'} .')' : '';
				my $intent = $tvar_rec->{'StreamVars'}{$tvar}{'IODir'};
				my $rdecl = {
				'Indent' => $info->{'Indent'},
				'Type'   => $type.$kind,
				'Attr'   => '',
				'Dim'    => [],
				'Name'   => $tvar,
				'IODir'  => $intent,
				'ArrayOrScalar'=>'Scalar'
				};
				$rline = emit_f95_var_decl($rdecl);
				my $orig_name =$info->{'VarDecl'}{'Name'}; 
				$info->{'VarDecl'}{'Name'}=$tvar;
				$info->{'VarDecl'}{'OrigName'}=$orig_name;
				say $rline if $DBG;
				my $rannline=[$rline,$info];
				$stref->{'Subroutines'}{$f}{'LiftedStreamVarDecls'}{'Set'}{$tvar}=dclone($annline);
				
				if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$tvar}) { 					 
					$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$tvar}=$rdecl;
				} 
				
#				if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$tvar}) { 
#					$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$tvar}=$rdecl;
#				}
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
#		croak Dumper($rlines) if $line=~/if.+wet/;
		return ($rlines,[$stref,$f]);
	};
	
	$stref->{'Subroutines'}{$f}{'LiftedStreamVarDecls'}={'Set'=>{},'List'=>[]};
	my $global_state_access=[$stref,$f];
 	($stref,$global_state_access) = stateful_pass($stref,$f,$pass_emit_updated_code , $global_state_access,'_rename_array_accesses_to_scalars_PASS3() ' . __LINE__  ) ;
# 	say $f;	
#	show_annlines($stref->{'Subroutines'}{$f}{'LiftedIndexCalcLines'});

	} # IF NOT A KERNEL
	return $stref;
} # END of _rename_array_accesses_to_scalars()
# ================================================================================================================================================
# After we've renamed all args in the subroutine definitions, we update the calls as well, but ONLY in the kernel 
sub _rename_array_accesses_to_scalars_called_subs { (my $stref, my $f) = @_;
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
				# Collect stream and index var declarations for all called subs 
				$stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} = {
					%{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} },
					%{ $stref->{'Subroutines'}{$subname}{'LiftedIndexVarDecls'}{'Set'} },
					%{ $stref->{'Subroutines'}{$subname}{'LiftedStreamVarDecls'}{'Set'} },
				};	
				for my $lifted_var ( sort keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} } ) {		
#					carp 		"$f =>	$subname => $lifted_var "; 
					if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var}
					and not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$lifted_var}
					) {						
						$stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var}= dclone( get_var_record_from_set( $stref->{'Subroutines'}{$subname}{'Vars'},$lifted_var ) );
					}
				}
				
				($rline, $info) = _emit_subroutine_call( $stref, $f, $annline);
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
 	($stref,$state) = stateful_pass($stref,$f,$pass_action, $state,'_rename_array_accesses_to_scalars_called_subs() ' . __LINE__  ) ;	
	@{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'List'} } = sort keys %{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'Set'}};
	
# --------------------------------------------------------------------------------------------------------			
#	# Here we add the variable declarations for variables used in the lifted assignments	
#	my $pass_add_decls_lifted_vars = sub { (my $annline, my $state)=@_;	
#		(my $line,my $info)=@{$annline};
#		(my $stref, my $f) = @{$state};
#		
#		if ( exists $info->{'VarDecl'} ) {
#			my $var = $info->{'VarDecl'}{'Name'};
#			if (exists $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$var} ) {
#			say "VAR $var from LiftedVarDecls already declared in $f"  if $DBG;
#			 delete $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$var};
#			}
#		}				
#		return ([$annline],$state);
#	};
#	
##	my $state=[$stref,$f];
# 	($stref,$state) = stateful_pass($stref,$f,$pass_add_decls_lifted_vars, $state,'pass_add_decls_lifted_vars() ' . __LINE__  ) ;	
#
#	my @lifted_var_decls = map { $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$_} } sort keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} };
##	say "\nSUB: $f\n";say Dumper(\@lifted_var_decls);
#	
#	# Now we want to splice these after the last var decl 
#    my $merged_annlines = splice_additional_lines_cond( $stref, $f, sub {(my $al)=@_;exists $al->[1]{'VarDecl'} ? 1 : 0 }, $stref->{'Subroutines'}{$f}{'RefactoredCode'}, \@lifted_var_decls,1, 0,1);
#    $stref->{'Subroutines'}{$f}{'RefactoredCode'}=$merged_annlines;
# --------------------------------------------------------------------------------------------------------
		 	    
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
					if ($info->{'CallArgs'}{'Set'}{$call_arg}{'Expr'} eq $call_arg.'(1)') {
						$info->{'CallArgs'}{'Set'}{$call_arg}{'Expr'} = $call_arg;
					}
				}
			}
#		# Then update CallArgs and again the ArgMap
#	      my $orig_call_args = $info->{'CallArgs'}{'List'};
#	      my $new_call_args = [];
#	      for my $call_arg (@{ $orig_call_args } ) {
#	      	# get the sig_arg
#	      	my $current_sig_arg = $call_arg;
#			if (exists $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$current_sig_arg}) {
#	      		push @{$new_call_args}, $call_arg;
#	      	} else {
#	      		# This argument was deleted
#	      		delete $info->{'CallArgs'}{'Set'}{$call_arg};
#	      		delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
#	      	}     	    
#	      }
#	      $info->{'CallArgs'}{'List'}=$new_call_args;
	      
	      	    my $indent = $info->{'Indent'} // '      ';
		    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
		    my @new_call_exprs = map  { $info->{'CallArgs'}{'Set'}{$_}{'Expr'} } @{$info->{'CallArgs'}{'List'}};  
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
 	($stref,$state) = stateful_pass($stref,$f,$pass_update_call_args, $state,'pass_update_call_args() ' . __LINE__  ) ;	
	
	 	    
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
						my $iodir =  $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'};
						if ($iodir eq 'in' or $iodir eq 'inout') {
							push @{$rlines}, $lifted_annline;
						} 
						}
					}				
#					croak;
#					$rlines = [@{$rlines},@{ $stref->{'Subroutines'}{$subname}{'LiftedScalarAssignments'} }];
				}								
#				$stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} = {
#					%{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} },
#					%{ $stref->{'Subroutines'}{$subname}{'LiftedIndexVarDecls'}{'Set'} },
#					%{ $stref->{'Subroutines'}{$subname}{'LiftedStreamVarDecls'}{'Set'} },
#				};	
#				for my $lifted_var ( keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} } ) {					 
#					if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var}
#					and not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$lifted_var}
#					) {						
#						$stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var}= dclone( get_var_record_from_set( $stref->{'Subroutines'}{$subname}{'Vars'},$lifted_var ) );
#					}
#				}
				# The actual subroutine call line				
				push @{$rlines},$annline;
				
				if ( exists  $stref->{'Subroutines'}{$subname}{'LiftedArrayAssignments'} ) {				
					for my $lifted_annline ( @{ $stref->{'Subroutines'}{$subname}{'LiftedArrayAssignments'} } ) {
						my $var = $lifted_annline->[1]{'Rhs'}{'VarList'}{'List'}[0];
						if (exists $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}) {
						my $iodir =  $stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'};						
						if ($iodir eq 'out' or $iodir eq 'inout') {
							push @{$rlines}, $lifted_annline;
						} 
						}
					}						
#					$rlines = [@{$rlines},@{ $stref->{'Subroutines'}{$subname}{'LiftedArrayAssignments'} }];
				}						
#				croak Dumper($stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{'duu'});
		} else {
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];
		}		
		return ($rlines,[$stref,$f]);
	};
	
#	$stref->{'Subroutines'}{$f}{'LiftedVarDecls'}={'Set'=>{},'List'=>{}};
	my $state=[$stref,$f];
 	($stref,$state) = stateful_pass($stref,$f,$pass_action, $state,'_rename_array_accesses_to_scalars_called_subs() ' . __LINE__  ) ;	
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
 	($stref,$state) = stateful_pass($stref,$f,$pass_add_decls_lifted_vars, $state,'pass_add_decls_lifted_vars() ' . __LINE__  ) ;	

	my @lifted_var_decls = map { $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$_} } sort keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} };
#	say "\nSUB: $f\n";say Dumper(\@lifted_var_decls);
	
	# Now we want to splice these after the last var decl 
    my $merged_annlines = splice_additional_lines_cond( $stref, $f, sub {(my $al)=@_;exists $al->[1]{'VarDecl'} ? 1 : 0 }, $stref->{'Subroutines'}{$f}{'RefactoredCode'}, \@lifted_var_decls,1, 0,1);
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

sub _rename_ast_entry { (my $stref, my $f,  my $state, my $ast, my $intent)=@_;
	if (ref($ast) eq 'ARRAY') {
		for my  $idx (0 .. scalar @{$ast}-1) {		
			my $entry = $ast->[$idx];
	
			if (ref($entry) eq 'ARRAY') {
				(my $entry, $state) = _rename_ast_entry($stref,$f, $state,$entry,$intent);
				$ast->[$idx] = $entry;
			} else {
				if ($entry eq '@') {				
					my $mvar = $ast->[$idx+1];
					if ($mvar ne '_OPEN_PAR_') {
						say 'Found array access '.$mvar  if $DBG;
						my $expr_str = emit_expression($ast,'');
						my $var_str=$expr_str;
						$var_str=~s/[\(,]/_/g; 
						$var_str=~s/\)//g; 
						$var_str=~s/\+/p/g;
						$var_str=~s/\-/m/g;
						$var_str=~s/\*/t/g;
#						say 'Found array access '.$mvar.' => '.$expr_str ;
						# Taking the IODir from the orig var is not optimal: it leads to many InOut that actually are Out
						# Ideally I should re-run the analysis for the stream vars
						if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$mvar}) { # DAMN PERL! It creates the entry unless I guard!
							$intent = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$mvar}{'IODir'};
						}
						$state->{'StreamVars'}{$mvar}{'Set'}{$var_str}={'IODir'=>$intent,'ArrayIndexExpr'=>$expr_str} ;
						$ast=['$',$var_str];
						last;
					}
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
	my $lhs = emit_expression($lhs_ast,'');
	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};
	my $rhs = emit_expression($rhs_ast,'');
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
	my $cond_expr_ast=$info->{'CondExecExpr'};
	my $cond_expr = emit_expression($cond_expr_ast);
	my $rline = $info->{'Indent'}.'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? 'then' : '');	
	return ($rline, $info);
}
# ================================================================================================================================================
# This is fairly generic and assumes the updated call args are DeclaredOrigArgs

sub _emit_subroutine_call { (my $stref, my $f, my $annline)=@_;
	    (my $line, my $info) = @{ $annline };
#	    croak Dumper($info);
	    my $Sf        = $stref->{'Subroutines'}{$f};
	    my $name = $info->{'SubroutineCall'}{'Name'};

	my $new_arg_map = $info->{'SubroutineCall'}{'ArgMap'} ;
	
	# Then update CallArgs and again the ArgMap
      my $orig_call_args = $info->{'CallArgs'}{'List'};
      my $new_call_args = [];
      for my $call_arg (@{ $orig_call_args } ) {
      	# get the sig_arg
      	my $current_sig_arg = $call_arg;
      	for my $sig_arg (keys %{$new_arg_map}) {
      		if ($new_arg_map->{$sig_arg} eq $call_arg) {
      			$current_sig_arg=$sig_arg ;
      			last;
      		}
      	}
      	
      	if (exists $stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}) {
      		$new_call_args=[@{$new_call_args},@{$stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}{'List'} }];
      			delete $info->{'CallArgs'}{'Set'}{$call_arg};
      			map { $info->{'CallArgs'}{'Set'}{$_} = {'Expr' => $_,'Type'=>'Scalar'} } @{$stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}{'List'} };
      			delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};      	
      			for my $stream_arg ( @{$stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}{'List'} } ) {
      				$info->{'SubroutineCall'}{'ArgMap'}{$stream_arg}=$stream_arg;
      			}      				
      	} elsif (exists $stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'}{$current_sig_arg}) {
#      		carp "$f => $name => SIG ARG: $current_sig_arg ".Dumper($stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'}{$current_sig_arg});
      		push @{$new_call_args}, $call_arg;
      	} else {
      		# This argument was deleted
#      		carp "$f => $name => DELETED SIG ARG: $current_sig_arg";
      		delete $info->{'CallArgs'}{'Set'}{$call_arg};
      		delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
      	}     	    
      }
      $info->{'CallArgs'}{'List'}=$new_call_args;      
	  my $args_ref = $stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'List'};
#		for my $arg (@{$args_ref}) {
#			say $arg . ' => '.Dumper($stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'}{$arg});
#			
#		}
			    
	    my $indent = $info->{'Indent'} // '      ';
	    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
	    my @new_call_exprs = map  { $info->{'CallArgs'}{'Set'}{$_}{'Expr'} } @{$new_call_args};  
	    my $args_str = join( ',', @new_call_exprs );	    
	    my $rline = "call $name($args_str)\n";
	    my $updated_expr_ast = parse_expression("$name($args_str)",$info, $stref,$f);
	    $info->{'SubroutineCall'}{'ExpressionAST'}=$updated_expr_ast;
#	    $info->{'SubroutineCall'}{'Args'}{'List'}= $args_ref;
#	    $info->{'SubroutineCall'}{'Args'}{'Set'}=  $stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'};
#	    $info->{'CallArgs'}{'Set'}=$info->{'SubroutineCall'}{'Args'}{'Set'};
#	    $info->{'CallArgs'}{'List'}=$info->{'SubroutineCall'}{'Args'}{'List'};
#	    %{ $info->{'SubroutineCall'}{'ArgMap'} } = map {$_ => $_} @{ $info->{'SubroutineCall'}{'Args'}{'List'} }; 
#	    croak Dumper($info);
		if ( exists $info->{'PlaceHolders'} ) { 
			while ($rline =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$rline=~s/$ph/$ph_str/;
			}                                    
            $info->{'Ref'}++;
        }  	    
	    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
		return ( $indent . $maybe_label . $rline, $info );
} # END of 
# ================================================================================================================================================
sub _removed_unused_variables { (my $stref, my $f)=@_;
	# If a variable is assigned but is not and arg and does not occur in any RHS or SubroutineCall, it is unused. 
	# If a variable is declared but not used in any LHS, RHS  or SubroutineCall, it is unused.
	# So start with all declared variables, put in $state->{'DeclaredVars'}
	# Make a list of all variables anywhere in the code via Lhs, Rhs, Args, put in $state->{'ExprVars'}
	
	
	my $pass_action_find_all_used_vars = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		
		my $rline=$line;
		my $rlines=[];
		my $skip_if=0;
		
 		if ( exists $info->{'Signature'} ) {
 			$state->{'Args'} = $info->{'Signature'}{'Args'}{'Set'}; 
 		}
 		elsif (exists $info->{'Select'})  {
 			my $select_expr_str = $info->{'CaseVar'}; 
 			my $select_expr_ast=parse_expression($select_expr_str, $info,{}, '');
 			my $vars = get_vars_from_expression($select_expr_ast,{});
 			for my $var (keys %{ $vars } ) {
 				$state->{'ExprVars'}{$var}++;	
 			}
# 			$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $vars } };
 		} 		
		elsif (exists $info->{'CaseVals'})  {
			for my $val (@{ $info->{'CaseVals'} }) {
				if ($val=~/^[a-z]\w*/) {
 					$state->{'ExprVars'}{$val}++;
 				} else  {
					my $case_expr_ast=parse_expression($val, $info,{}, '');
 					my $vars = get_vars_from_expression($case_expr_ast,{});
 					for my $var (keys %{ $vars } ) {
 				$state->{'ExprVars'}{$var}++;	
 			}
# 					$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $vars } };
 				}		
			}
		}
		elsif ( exists $info->{'VarDecl'} ) {
			$state->{'DeclaredVars'}{ $info->{'VarDecl'}{'Name'}}=1;
		}
		elsif ( exists $info->{'Assignment'}  ) {
#			carp Dumper($info->{'Lhs'});
			my $var = $info->{'Lhs'}{'VarName'};
			if (exists $state->{'UnusedVars'}{$var}) {
				say "REMOVED ASSIGNMENT $line in $f"  if $DBG;
				$annline=['! '.$line, {%{$info},'Deleted'=>1}];
				delete $state->{'UnusedVars'}{$var};
				delete $state->{'AssignedVars'}{$var};	
				# I should now also remove all vars		
				if (exists $info->{'Lhs'}{'IndexVars'}) {
					for my $var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
 						$state->{'ExprVars'}{$var}--;	
		 				if ( $state->{'ExprVars'}{$var} == 0) {
		 					delete $state->{'ExprVars'}{$var};
		 					carp "DELETE ExprVar $var in IF";
		 				}	 						
 					}
				}
				$skip_if=1;							
			} else {
				$state->{'AssignedVars'}{$var}=1;				
				if (exists $info->{'Lhs'}{'IndexVars'}) {
#					$state->{'ExprVars'} ={%{$state->{'ExprVars'}}, };
					for my $var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
 						$state->{'ExprVars'}{$var}++;	
 					}
				}
#				$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, };
				for my $var (keys %{$info->{'Rhs'}{'VarList'}{'Set'} }) {
 						$state->{'ExprVars'}{$var}++;	
 					}
				for my $var (keys %{  $info->{'Rhs'}{'VarList'}{'Set'} } ) {
					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'}) {
#						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'} }};
						for my $var (keys %{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'} }) {
 							$state->{'ExprVars'}{$var}++;	
 						}
					}
					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'}) {
#						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{  }};
						for my $var (keys %{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'} }) {
 							$state->{'ExprVars'}{$var}++;	
 						}						
					}			
				}
			}
		}
		elsif ( exists $info->{'SubroutineCall'} ) {
#			$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ } };
			for my $var (keys %{ $info->{'SubroutineCall'}{'Args'}{'Set'} }) {
 				$state->{'ExprVars'}{$var}++;	
			}			
		}		
		if (exists $info->{'If'} and not $skip_if) {						
				my $cond_expr_ast=$info->{'CondExecExprAST'};#= $ast;parse_expression($info->{'CondExecExpr'}, $info,$stref, $f);
#				$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'} } }; 
			for my $var (keys %{ $info->{'CondVars'}{'Set'} }) {
				say "ADDING $var to ExprVars in IF" if $DBG;
 				$state->{'ExprVars'}{$var}++;
 					
			}						
				for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
					next if $var eq '_OPEN_PAR_';					
					if (exists  $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} ) {								
#						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{  } };
						for my $var (keys %{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} }) {
 							$state->{'ExprVars'}{$var}++;	
						}
					}				
				}
		}
		
		return ([$annline],$state);
	};
		
	my $state= {
		'DeclaredVars'=>{},
		'UndeclaredVars'=>{},
		'ExprVars'=>{},
		'AssignedVars'=>{},
		'Args'=>{},
		'UnusedVars'=>{},
		'UnusedDeclaredVars'=>{}
	};
	do {
		$state->{ExprVars}={};
		$state->{AssignedVars}={};
        # The pass finds ExprVars and AssignedVars
 		($stref,$state) = stateful_pass($stref,$f,$pass_action_find_all_used_vars, $state,'_find_all_unused_variables() ' . __LINE__  ) ;
 	# Once we have these lists, we can now check if there are any variables that occur on an Lhs an are not used anywhere
 	# We simply check for every AssignedVar if it is used as an ExprVar or as an Arg 	
    
	 	for my $var (keys %{ $state->{'AssignedVars'} }) {
	 		if (not exists $state->{'ExprVars'}{$var} and not exists $state->{'Args'}{$var}) {
	 			say "VAR $var is unused in $f" if $DBG;
	 			$state->{'UnusedVars'}{$var}=1;
	 		} 
	 	}
	} until scalar keys %{ $state->{'UnusedVars'} } ==0; 
#	croak Dumper($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'});

	# --------------------------------------------------------------------------------------------------------------------------------
 	# So now we have removed all assignments. 
 	# Now we need to check which vars are declared but not used and remove those declarations. 
 	for my $var (keys %{ $state->{'DeclaredVars'} }) {
 		
 		if (not exists $state->{'ExprVars'}{$var} 
# 		and not exists $state->{'Args'}{$var} 
 		and not exists $state->{'AssignedVars'}{$var}) {
 			
 			say "VAR $var is declared but unused in $f" if $DBG;
 			$state->{'UnusedDeclaredVars'}{$var}=1;
 		} 
 	}
 	
 	# Now we should remove these declarations

	my $pass_action_decls = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};		
		my $rline=$line;
		my $rlines=[];
		if ( exists $info->{'VarDecl'} ) {		
			my $var = $info->{'VarDecl'}{'Name'};
			if (exists $state->{'UnusedDeclaredVars'}{$var}) {
				say "REMOVED DECL $line in $f" if $DBG;
				$annline=['! '.$line, {%{$info},'Deleted'=>1}];
#				delete $state->{'UnusedDeclaredVars'}{$var};
				delete $state->{'DeclaredVars'}{$var};				
			} 
		}
		elsif ( exists $info->{'Signature'} ) {
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
				if (not exists $state->{'UnusedDeclaredVars'}{$arg} ) {
					push @{$new_args}, $arg;
				} else {
					push @{ $state->{'DeletedArgs'} }, $arg;
					say "REMOVED ARG $arg from signature of $f" if $DBG;	
				} 
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$state->{'RemainingArgs'}=$new_args;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };			
		}
		return ([$annline],$state);
	}; 	
	
	$state->{'RemainingArgs'}=[];
	$state->{'DeletedArgs'}=[];
	($stref,$state) = stateful_pass($stref,$f,$pass_action_decls, $state,'_removed_unused_variables() ' . __LINE__  ) ;
	
	# --------------------------------------------------------------------------------------------------------------------------------	
 	# Adapt the Signature in $stref
 	$stref->{'Subroutines'}{$f}{'DeletedArgs'} =$state->{'DeletedArgs'};
 	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=dclone($state->{'RemainingArgs'});
 	map { delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };

	return $stref;
} # END of _removed_unused_variables()
# ================================================================================================================================================

sub _declare_undeclared_variables { (my $stref, my $f)=@_;
	# If a variable is assigned but is not and arg and does not occur in any RHS or SubroutineCall, it is unused. 
	# If a variable is declared but not used in any LHS, RHS  or SubroutineCall, it is unused.
	# So start with all declared variables, put in $state->{'DeclaredVars'}
	# Make a list of all variables anywhere in the code via Lhs, Rhs, Args, put in $state->{'ExprVars'}
#	die Dumper($stref->{'Subroutines'}{'feedbf_map_48'}{'Args'}{'Subsets'}{'OrigArgs'}{'Subsets'}{'DeclaredOrigArgs'}{'Set'}{'abcd_mask'});
	my $pass_action_find_all_used_vars = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
#		say "$f LINE: $line" if $line=~/range/;
		my $rline=$line;
		my $rlines=[];
		
 		if ( exists $info->{'Signature'} ) {
 			$state->{'Args'} = $info->{'Signature'}{'Args'}{'Set'}; 
 		}
 		elsif (exists $info->{'Select'})  {
 			my $select_expr_str = $info->{'CaseVar'}; 
 			my $select_expr_ast=parse_expression($select_expr_str, $info,{}, '');
 			my $vars = get_vars_from_expression($select_expr_ast,{});
 			$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $vars } };
 		} 		
		elsif (exists $info->{'CaseVals'})  {
			for my $val (@{ $info->{'CaseVals'} }) {
				if ($val=~/^[a-z]\w*/) {
 					$state->{'ExprVars'}{$val}=1;
 				} else  {
					my $case_expr_ast=parse_expression($val, $info,{}, '');
 					my $vars = get_vars_from_expression($case_expr_ast,{});
 					$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $vars } };
 				}		
			}
		}
		elsif ( exists $info->{'VarDecl'} ) {
			$state->{'DeclaredVars'}{ $info->{'VarDecl'}{'Name'}}=1;
		}
		elsif ( exists $info->{'Assignment'}  ) {
#			say "$f ASSIGN: $line" if $line=~/range/;
			my $var = $info->{'Lhs'}{'VarName'};
				$state->{'AssignedVars'}{$var}=1;
				
				if (exists $info->{'Lhs'}{'IndexVars'}) {
					$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Lhs'}{'IndexVars'}{'Set'} } };
				}
				$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $info->{'Rhs'}{'VarList'}{'Set'} } };
				for my $var (keys %{  $info->{'Rhs'}{'VarList'}{'Set'} } ) {
					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'}) {
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'} }};
					}
					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'}) {
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'} }};
					}			
				}			
		}
		elsif ( exists $info->{'SubroutineCall'} ) {
			$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{$info->{'SubroutineCall'}{'Args'}{'Set'} } };
		}		
		if (exists $info->{'If'} ) {						
				my $cond_expr_ast=$info->{'CondExecExprAST'};#= $ast;parse_expression($info->{'CondExecExpr'}, $info,$stref, $f);
				$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'} } }; 
				for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
					next if $var eq '_OPEN_PAR_';					
					if (exists  $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} ) {								
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} } };
					}				
				}
		}
		
		return ([$annline],$state);
	};
		
	my $state= {
		'DeclaredVars'=>{},
		'UndeclaredVars'=>{},
		'ExprVars'=>{},
		'AssignedVars'=>{},
		'Args'=>{},
	};
        # The pass finds ExprVars and AssignedVars
 		($stref,$state) = stateful_pass($stref,$f,$pass_action_find_all_used_vars, $state,'_find_all_unused_variables() ' . __LINE__  ) ;



	# --------------------------------------------------------------------------------------------------------------------------------
	# As we are going through the whole code we can also test for undeclared vars 
	# This is very ad-hoc
	for my $expr_var (keys %{ $state->{'ExprVars'} } ) {
		next if exists $Config{'Macros'}{uc($expr_var)};
		if (not exists $state->{'DeclaredVars'}{$expr_var} ) {
			# This is weak so I check the decl the proper way first!
			my $subset = in_nested_set($stref->{'Subroutines'}{$f},'Vars',$expr_var);
			if ($subset eq '') {
				if ($expr_var ne '_OPEN_PAR_' and $expr_var!~/^\d/) {				
					$state->{'UndeclaredVars'}{$expr_var}='real'; # the default
				}
			}
			 
		}
	}
	
	for my $lhs_var (keys %{ $state->{'AssignedVars'} } ) {
		next if exists $Config{'Macros'}{uc($lhs_var)};
		if (not exists $state->{'DeclaredVars'}{$lhs_var} ) {
			# This is weak so I check the decl the proper way first!
			my $subset = in_nested_set($stref->{'Subroutines'}{$f},'Vars',$lhs_var);
			if ($subset eq '') {
			
#			if ($expr_var ne '_OPEN_PAR_' and $expr_var!~/^\d/) {				
				$state->{'UndeclaredVars'}{$lhs_var}='real'; # the default
#			}
			} 
		}
	}	
	
	
	# --------------------------------------------------------------------------------------------------------------------------------	 			
	my $pass_action_type_undeclared = sub { (my $annline, my $state)=@_;
		(my $stref, my $f, my $pass_state)=@{$state};
		(my $line,my $info)=@{$annline};
		
		if (exists $info->{'Assignment'} ) { 
			
			my $var = $info->{'Lhs'}{'VarName'};
			if (exists $pass_state->{'UndeclaredVars'}{$var}) { 
#				say "$f VAR: $var is UNDECLARED" if $var=~/range/;
			# Now from this list via 
				my $var_type = 'integer';
				for my $rhs_var (@{ $info->{'Rhs'}{'VarList'}{'List'} } ) {
					next if exists $Config{'Macros'}{uc($rhs_var)};
					next if $rhs_var  eq '_OPEN_PAR_';
					my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$rhs_var) ;
					if ($decl->{'Type'} eq 'real') {
						$var_type = 'real';last;
					}
				}
				$pass_state->{'UndeclaredVars'}{$var}=$var_type;
			}
		} 
		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $full_state = [$stref,$f,$state];
 	($stref,$full_state) = stateful_pass($stref,$f,$pass_action_type_undeclared, $full_state,'_pass_action_type_undeclared() ' . __LINE__  ) ;
	# --------------------------------------------------------------------------------------------------------------------------------	 	
 	# So at this point we have $pass_state->{'UndeclaredVars'} for $f, so now we need a pass to add the missing decls 
 	# the best way is a reverse pass which adds the decls as soon as it finds a declaration, using a state var "Once"
	my $pass_action_add_undeclared_type_decls = sub { (my $annline, my $state)=@_;
		(my $stref, my $f, my $pass_state)=@{$state};
		(my $line,my $info)=@{$annline};
		my $rlines = [$annline];
		if (exists $info->{'VarDecl'} and $pass_state->{'Once'}==0 ) { 
			$pass_state->{'Once'}=1;
			for my $undecl_var (keys %{$pass_state->{'UndeclaredVars'}}) {
				my $undecl_var_type = $pass_state->{'UndeclaredVars'}{$undecl_var}; 
				my $decl_line = $undecl_var_type.' :: '.$undecl_var;
			
				my $decl = {
				'Indent' => $info->{'Indent'},
				'Type'   => $undecl_var_type,
				'Attr'   => '(kind=4)',
				'Dim'    => [],
				'Name'   => $undecl_var,
				'IODir'  => 'NA',
				};
				# Now I also need $info for this var ...
				my $decl_info={				
				  'VarDecl' => {
				    'Name' => $undecl_var
				  },		  
				  'Indent' => $info->{'Indent'},
				  'Ann' => [  ],
				  'Ref' => 0
				};
				# And we also need to add these variables to DeclaredOrigLocalVars 
				$stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$undecl_var}=$decl;
				push @{$rlines},[$decl_line,$decl_info];
			}
		} 
		return ($rlines,[$stref,$f,$pass_state]);
	};
 	
	$full_state->[2]{'Once'}=0;
 	($stref,$full_state) = stateful_pass_reverse($stref,$f,$pass_action_add_undeclared_type_decls, $full_state,'pass_action_add_undeclared_type_decls() ' . __LINE__  ) ;
	@{ $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'List'} } = sort keys %{ $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'} } ;
		
	return $stref;
} # END of _declare_undeclared_variables()
# ================================================================================================================================================
# Gavin's code has _ptr arrays to pass scalar pointers. This is necessary for actual Fortran code, not for code that is to be translated to OpenCL
sub _fix_scalar_ptr_args { (my $stref, my $f)=@_;
	if ($f ne $Config{'KERNEL'} ) { 
	# TODO:  I must update the $stref->{Subroutines}{$f} records as well
	my $pass_fix_scalar_ptr_args = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref,my $f,my $pass_state)=@{$state};
#		(my $stref,my $f)=@{$state};
		my $rline=$line;
		my $rlines=[$annline];
		
		# Here we simply replace any _ptr name with the name without _ptr
 		if ( exists $info->{'Signature'} ) {
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
				if ($arg=~/_ptr/) {
#					carp "$f ARG: $arg" if $f eq 'sub_map_124';
					my $new_arg=$arg;
					$new_arg=~s/_ptr$//;
					$pass_state->{'ExPtrArgs'}{$arg}=$new_arg;
					push @{$new_args}, $new_arg;
					my $orig_decl = dclone($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg} );
#					$orig_decl->{'ArrayOrScalar'} = 'Scalar';
#					$orig_decl->{'Dim'} = [];
					$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$new_arg} = $orig_decl ; 
					delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg} ;					
				} else {
					push @{$new_args}, $arg;
				}				  
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
			$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=$new_args ;
#			$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}= $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'};
			
			my $sig_str = $line;
			$sig_str=~s/_ptr//g;
			$rlines=[[$sig_str,$info]];			 
 		}
		elsif ( exists $info->{'VarDecl'} ) {
			# So we have e.g. v and v_ptr
			# We want to keep v and delete v_ptr
			
			my $var= $info->{'VarDecl'}{'Name'};
			
			if (exists $pass_state->{'ExPtrArgs'}{$var} ) {
				$rlines=[["!$rline",{ %{$info},'Deleted'=>1 }]];	
			} elsif ($var=~/_ptr$/) {
				my $new_arg=$var;
				$new_arg=~s/_ptr$//;		
				$info->{'VarDecl'}{'Name'}=$new_arg;
  				$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} = [];
    			$info->{'ParsedVarDecl'}{'Attributes'}{'Vars'} = [$new_arg]; 					

				my $decl_str = $line;
				$decl_str =~s/_ptr//g;
				$decl_str =~s/,\s+dimension\(1\)//;
				$rlines=[["$decl_str ",$info]];			 
			}			
		}
		elsif ( exists $info->{'Assignment'}  ) {
			my $var = $info->{'Lhs'}{'VarName'};
			my $rhs_ast = $info->{'Rhs'}{'ExpressionAST'};
			if (
			ref($rhs_ast) eq 'ARRAY' &&
			$rhs_ast->[0] eq '@' && 
			$rhs_ast->[1] eq $var.'_ptr' &&
			$rhs_ast->[2] eq '1' 
			) { 			
				say "REMOVED ASSIGNMENT $line in $f"  if $DBG;
				$annline=['! '.$line, { %{$info},'Deleted'=>1 }];
				$rlines=[$annline];
				# I should now also remove all vars			
			} 
		}

		return ($rlines,[$stref,$f,$pass_state]);
	};
		
	my $pass_state ={
		'ExPtrArgs' => {}
	};
	my $state= [$stref,$f,$pass_state];
	
 	($stref,$state) = stateful_pass($stref,$f,$pass_fix_scalar_ptr_args, $state,'pass_fix_scalar_ptr_args() ' . __LINE__  ) ;
} # IF NOT KERNEL
 	
	return $stref;
} # END of _fix_scalar_ptr_args()
 
# -----------------------------------------------------------------------------
sub _fix_scalar_ptr_args_subcall { (my $stref, my $f)=@_;
	
	
		if ($f eq $Config{'KERNEL'} ) {
	# TODO:  I must update the $stref->{Subroutines}{$f} records as well
	my $pass_fix_scalar_ptr_args_subcall = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref,my $f)=@{$state};		
		my $rlines=[$annline];
		
		if ( exists $info->{'SubroutineCall'} and not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} } ) {
	    	my $Sf        = $stref->{'Subroutines'}{$f};
	    	my $name = $info->{'SubroutineCall'}{'Name'};

			# First update the ArgMap 
			# This is to account for the renamed pointers
			my $new_arg_map = {};	
			
			for my $sig_arg (keys %{$info->{'SubroutineCall'}{'ArgMap'} }) {
				my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
				if ($sig_arg =~/_ptr/) { # duu_ptr			
					my $ren_sig_arg = $sig_arg;
					$ren_sig_arg =~s/_ptr//; # duu
					$new_arg_map->{$ren_sig_arg}=$call_arg; # duu => duu
					# This is only correct if the signature arg of the called sub is a scalar.
#					if ($call_arg eq 'km') {
#						croak $f.Dumper($sig_arg).Dumper($stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'}{$call_arg});
#					} 					
					if ($stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'}{$ren_sig_arg}{'ArrayOrScalar'} eq 'Scalar') {
						$info->{'CallArgs'}{'Set'}{$call_arg} = {'Expr' => $call_arg.'(1)','Type'=>'Scalar'};
					} else {
						$info->{'CallArgs'}{'Set'}{$call_arg} = {'Expr' => $call_arg,'Type'=>'Array'};
					}
				} else {
					$new_arg_map->{$sig_arg}=$call_arg;
				}
			}
			$info->{'SubroutineCall'}{'ArgMap'} = $new_arg_map;	
		
		# Then update CallArgs and again the ArgMap
	      my $orig_call_args = $info->{'CallArgs'}{'List'};
	      my $new_call_args = [];
	      for my $call_arg (@{ $orig_call_args } ) {
	      	# get the sig_arg
	      	my $current_sig_arg = $call_arg;
	      	for my $sig_arg (keys %{$new_arg_map}) {
	      		if ($new_arg_map->{$sig_arg} eq $call_arg) {
	      			$current_sig_arg=$sig_arg ;
	      			last;
	      		}
	      	}
	      	
			if (exists $stref->{'Subroutines'}{$name}{'DeclaredOrigArgs'}{'Set'}{$current_sig_arg}) {
	      		push @{$new_call_args}, $call_arg;
	      	} else {
	      		# This argument was deleted
	      		delete $info->{'CallArgs'}{'Set'}{$call_arg};
	      		delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
	      	}     	    
	      }
	      $info->{'CallArgs'}{'List'}=$new_call_args;
	      
	      	    my $indent = $info->{'Indent'} // '      ';
		    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
		    my @new_call_exprs = map  { $info->{'CallArgs'}{'Set'}{$_}{'Expr'} } @{$new_call_args};  
		    my $args_str = join( ',', @new_call_exprs );	    
		    my $rline = "call $name($args_str)\n";
		    my $updated_expr_ast = parse_expression("$name($args_str)",$info, $stref,$f);
		    $info->{'SubroutineCall'}{'ExpressionAST'}=$updated_expr_ast;
	
	      $rlines=[[$rline, $info]];
      }
		
		
		
		return ($rlines,[$stref,$f]);
	};
		
	my $state= [$stref,$f];
	
 	($stref,$state) = stateful_pass($stref,$f,$pass_fix_scalar_ptr_args_subcall, $state,'pass_fix_scalar_ptr_args_subcall() ' . __LINE__  ) ;
 	
 	 
} 

 	
	return $stref;
      
} # END of _fix_scalar_ptr_args_subcall


# ============================================================================================================
sub _make_dim_vars_scalar_consts_in_sigs { (my $stref, my $f)=@_;
	
	# TODO:  I must update the $stref->{Subroutines}{$f} records as well
	my $pass_make_dim_vars_scalar_consts_in_sigs = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref,my $f,my $pass_state)=@{$state};
#		(my $stref,my $f)=@{$state};
		my $rline=$line;
		my $rlines=[$annline];
		
	if ( exists $info->{'VarDecl'} ) {
			# So we have e.g. v and v_ptr
			# We want to keep v and delete v_ptr
			
			my $var= $info->{'VarDecl'}{'Name'};
			
			# Get variables from DIMENSION attribute
			if (exists $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}
			and scalar @{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} } > 0
			) {
				my $dim_parse_str = '('.join(',',@{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} }).')';
				my $dim_ast=parse_expression($dim_parse_str,$info, $stref,$f);
				my $dim_vars=get_vars_from_expression($dim_ast,{}) ;
				for my $dim_var (keys %{$dim_vars} ){
					if (not exists $pass_state->{'DimVars'}{$dim_var}) {
						$pass_state->{'DimVars'}{$dim_var}=1;
						if (exists  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$dim_var}) {
#							carp "$f => $dim_var => ".Dumper($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$dim_var}) ;
							$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$dim_var}{'ArrayOrScalar'}='Scalar';
							$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$dim_var}{'IODir'}='in';
						}
					}
				}
			}
		
		}


		return ($rlines,[$stref,$f,$pass_state]);
	};
		
	my $pass_state ={
		'DimVars' => {}
	};
	my $state= [$stref,$f,$pass_state];
	
 	($stref,$state) = stateful_pass($stref,$f,$pass_make_dim_vars_scalar_consts_in_sigs, $state,'pass_make_dim_vars_scalar_consts_in_sigs() ' . __LINE__  ) ;

 	
	return $stref;
} # END of _make_dim_vars_scalar_consts_in_sigs()
 

# ============================================================================================================

1;
