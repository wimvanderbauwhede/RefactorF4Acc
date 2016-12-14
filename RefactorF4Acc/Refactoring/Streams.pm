package RefactorF4Acc::Refactoring::Streams;
use v5.016;
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

use warnings::unused;
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

sub pass_rename_array_accesses_to_scalars {(my $stref)=@_;
	$stref = pass_wrapper_subs_in_module($stref,
			[
				[
					\&_removed_unused_variables,
			  		\&_fix_scalar_ptr_args,
					\&_rename_array_accesses_to_scalars
				],			
				[
					\&_rename_array_accesses_to_scalars_called_subs
				],
				[
					\&determine_argument_io_direction_rec
				]
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
	

sub _rename_array_accesses_to_scalars { (my $stref, my $f) = @_;
	
	# This pass performs renaming in assignments and conditional expressions of IFs
	# TODO: It does _not_ rename
	# * subroutine call arguments (because there should not be any)
	# * SELECT CASE arguments
	# * DO index range expressions  
	my $pass_rename_array_accesses_in_exprs = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Assignment'} ) {
			if (scalar @{ $info->{'Rhs'}{'VarList'}{'List'} } ==1 and $info->{'Rhs'}{'VarList'}{'List'}[0]=~/_ptr/) {
				# IGNORE, this is not a true array access: this is an assignment of the shape
				# v = v_ptr(1)
				# and we will remove these later on
			} else {				
				# Rename all array accesses in the RHS AST. This updates $state->{'StreamVars'}
				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'In');
				 $info->{'Rhs'}{'ExpressionAST'}=$ast;
			}
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array') {
				# Rename all array accesses in the LHS AST. This updates $state->{'StreamVars'}
				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'}, 'Out');
				$info->{'Lhs'}{'ExpressionAST'}=$ast;				
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
		}
		return ([[$line,$info]],$state);
	};

	my $state = {'IndexVars'=>{}, 'StreamVars'=>{}};
 	($stref,$state) = stateful_pass($stref,$f,$pass_rename_array_accesses_in_exprs, $state,'pass_rename_array_accesses_in_exprs ' . __LINE__  ) ;
 	
 	# Now we create new assignment lines, these go into LiftedScalarAssignments
 	# v_i_j = v(i,j)
 	$stref->{'Subroutines'}{$f}{'LiftedScalarAssignments'}=[];
 	# StreamVars has the original array var as key, a list of entries for the renamed scalars as value
 	# Each of these entries has a field ArrayIndexExpr
	for my $var (keys %{ $state->{'StreamVars'} } ){
		for my $stream_var (sort keys %{ $state->{'StreamVars'}{$var} } ){		
			my $assignment_line= '      '.$stream_var.' = '.$state->{'StreamVars'}{$var}{$stream_var}{'ArrayIndexExpr'};
			my $rhs_ast = parse_expression($state->{'StreamVars'}{$var}{$stream_var}{'ArrayIndexExpr'}, {},$stref, $f);
			my $rhs_vars = get_vars_from_expression($rhs_ast ,{});
			my $rhs_vars_list = [ sort keys %{$rhs_vars} ];
			push @{ $stref->{'Subroutines'}{$f}{'LiftedScalarAssignments'} }, 
			[$assignment_line,
				{
					'Indent' => '      ',
					'Assignment'=> 1,
						'Lhs'=> {   
							'ArrayOrScalar' => 'Scalar','IndexVars' => {'List' => [],'Set' => {}},'ExpressionAST' => ['$',$stream_var],'VarName' => $stream_var
						  },
						'Rhs' => {
							'ExpressionAST' => $rhs_ast,
							'VarList' => {'List' => $rhs_vars_list,'Set' =>$rhs_vars},
						}
					
				}
			]; 
		}		
	}

	# So now we have identified all stream vars. In the next pass, update the subroutine signature and declarations
	# We update DeclaredOrigArgs record of $f in a separate pass below
	my $pass_update_sig_and_decls = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Signature'} ) { 			
			# What we do is replace the array args with the "tuple" of scalar args from StreamVars
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
				if (exists $state->{'StreamVars'}{$arg} ) {
					$new_args=[@{$new_args},  sort keys %{ $state->{'StreamVars'}{$arg} }  ];										
				} else {
					push @{$new_args}, $arg;
				} 
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
			carp 'TODO: What is missing here is that the DeclaredOrigArgs record of $f should be updated as well'; 
		} elsif (exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'};
			if (exists $state->{'StreamVars'}{$var}) {
				my @vars = sort keys %{ $state->{'StreamVars'}{$var} };
				if (exists $info->{'ParsedVarDecl'}) {
					$info->{'ParsedVarDecl'}{'StreamVars'}=$state->{'StreamVars'}{$var}; # Every streamvar derived from var has the same type
					$info->{'ParsedVarDecl'}{'Vars'}=[@vars];
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
	
	# Here we update RefactoredArgs and DeclaredOrigArgs
	# Delete the args replaced by streaming args from the Set
	# FIXME: why is this not done in the loop below (347)???
	
#	map { delete $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };
#	map { delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };
#	
#	my @update_args_list = map { if (exists $state->{'StreamVars'}{$_} ) { sort keys %{ $state->{'StreamVars'}{$_} } } else { $_ } }  @{ $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'} };
#	
#	
#	croak '# FIXME: why is this not done in the loop below (347)???'.Dumper(\@update_args_list).Dumper($stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'});
#	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=\@update_args_list;
	# We must also create the assignment lines for every newly created stream var and put these in LiftedScalarAssignments	  

 	# At this point the argument list already has the stream vars as args
 	$stref->{'Subroutines'}{$f}{'LiftedStreamVarDecls'}={'Set'=>{},'List'=>[]};
 	my @updated_args_list=();		
	for my $orig_arg ( @{ $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'} } ) {	
		if (exists $state->{'StreamVars'}{$orig_arg}) {
			my $new_decl = dclone( $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$orig_arg} );
			for my $new_arg (sort keys %{ $state->{'StreamVars'}{$orig_arg} }) {
				push @updated_args_list,$new_arg;
				$new_decl->{'ArrayOrScalar'}='Scalar';
				$new_decl->{'Dim'}=[];
				$new_decl->{'IODir'}=$state->{'StreamVars'}{$orig_arg}{$new_arg}{'IODir'};
				$new_decl->{'ArrayIndexExpr'}=$state->{'StreamVars'}{$orig_arg}{$new_arg}{'ArrayIndexExpr'};
				$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$new_arg}=$new_decl;
				delete $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$orig_arg};				
			}			
		} else {
			if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$orig_arg} ) {
				push @updated_args_list, $orig_arg;	
			}
		}
	}
	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'}=[@updated_args_list];
	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}=$stref->{'Subroutines'}{$f}{'RefactoredArgs'};
	
	
	croak Dumper($stref->{'Subroutines'}{$f}{'RefactoredArgs'});
	# Now we emit the updated code for the subroutine signature, the variable declarations, assignment expressions and ifthen expressions 	
	my $pass_emit_updated_code = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		my $rline=$line;
		
		my $rlines=[];
		if (exists $info->{'Signature'} ) { 
			($rline, $info) = emit_subroutine_sig( $stref, $f, $annline);
			say $rline if $DBG;
			push @{$rlines},[$rline,$info];			
		} elsif (
			exists $info->{'VarDecl'} and exists $info->{'ParsedVarDecl'}{'StreamVars'}
		) {
		
			my $tvar_rec = $info->{'ParsedVarDecl'};
			for my $tvar (keys %{  $tvar_rec->{'StreamVars'} }) {
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
		return ($rlines,$state);
	};
	
	my $global_state_access=[$stref,$f];
 	($stref,$global_state_access) = stateful_pass($stref,$f,$pass_emit_updated_code , $global_state_access,'_rename_array_accesses_to_scalars_PASS3() ' . __LINE__  ) ;
# 	say $f;	
#	show_annlines($stref->{'Subroutines'}{$f}{'LiftedIndexCalcLines'});
	return $stref;
} # END of _rename_array_accesses_to_scalars()

# After we've renamed all args in the subroutine definitions, we update the calls as well 
sub _rename_array_accesses_to_scalars_called_subs { (my $stref, my $f) = @_;

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
					$rlines = [@{$rlines},@{ $stref->{'Subroutines'}{$subname}{'LiftedScalarAssignments'} }];
				}								
				$stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} = {
					%{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} },
					%{ $stref->{'Subroutines'}{$subname}{'LiftedIndexVarDecls'}{'Set'} },
					%{ $stref->{'Subroutines'}{$subname}{'LiftedStreamVarDecls'}{'Set'} },
				};	
				for my $lifted_var ( keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} } ) {					 
					if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var} ) {
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
	
#	die Dumper($stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}) if $f eq 'sub_superkernel';
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
#    show_annlines( $stref->{'Subroutines'}{$f}{'RefactoredCode'},1);
	return $stref;
} # END of _rename_array_accesses_to_scalars_called_subs()

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

sub _lift_array_index_calculations { 
	return 1;
	# Also, we need the original array access expression to be stored, so we have  { 'IODir' => ..., ArrayIndexExpr => '...' }
	# For every array index, identify the variables used. This is easy: we have 'IndexVars'
	# Put these into $index_vars
	# Every Assignment line that has one of these on the LHS gets removed from AnnLines and stored in LiftedIndexCalcLines, and we take list of all vars on the RHS {'Rhs'}{'VarList'}{'List'} and add these to $index_vars
	# We do this until we have all of them. Basically, if we start from the back and push in reverse, we can do this in a single pass
	# Then we can remove the declarations as well, and store these in LiftedIndexVarDecls
	# Finally we remove the $index_vars from the Args in the Signature
	# And then we can update $stref->{$Subroutines}{$f} and add LiftedIndexCalcLines and LiftedIndexVarDecls so that when we find a call we can splice in these lines
	# We must also create the assignment lines for every newly created var and put these in LiftedScalarAssignments	  
}

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
						$intent = $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$mvar}{'IODir'};
						$state->{'StreamVars'}{$mvar}{$var_str}={'IODir'=>$intent,'ArrayIndexExpr'=>$expr_str} ;
						$ast=['$',$var_str];
						last;
					}
				} 
			}		
		}
	}
	return  ($ast, $state);	
	
}
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

sub _emit_ifthen { (my $annline)=@_;
	( my $line, my $info ) = @{$annline};
	my $cond_expr_ast=$info->{'CondExecExpr'};
	my $cond_expr = emit_expression($cond_expr_ast);
	my $rline = $info->{'Indent'}.'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? 'then' : '');	
	return ($rline, $info);
}

# This is fairly generic and assumes the updated call args are RefactoredArgs
sub _emit_subroutine_call { (my $stref, my $f, my $annline)=@_;
	    (my $line, my $info) = @{ $annline };
	    my $Sf        = $stref->{'Subroutines'}{$f};
	    my $name = $info->{'SubroutineCall'}{'Name'};
	    
		my $args_ref = $stref->{'Subroutines'}{$name}{'RefactoredArgs'}{'List'};
			    
	    my $indent = $info->{'Indent'} // '      ';
	    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
	    my $args_str = join( ',', @{$args_ref} );	    
	    my $rline = "call $name($args_str)\n";
	    my $updated_expr_ast = parse_expression("$name($args_str)",$info, $stref,$f);
	    $info->{'SubroutineCall'}{'ExpressionAST'}=$updated_expr_ast;
	    $info->{'SubroutineCall'}{'Args'}{'List'}= $args_ref;
	    $info->{'SubroutineCall'}{'Args'}{'Set'}=  $stref->{'Subroutines'}{$name}{'RefactoredArgs'}{'Set'};
	    $info->{'CallArgs'}{'Set'}=$info->{'SubroutineCall'}{'Args'}{'Set'};
	    $info->{'CallArgs'}{'List'}=$info->{'SubroutineCall'}{'Args'}{'List'};
	    %{ $info->{'SubroutineCall'}{'ArgMap'} } = map {$_ => $_} @{ $info->{'SubroutineCall'}{'Args'}{'List'} }; 
	    # FIXME: I'm not dealing properly with ArgMap!
	    
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
}

sub _top_src_is_module {( my $stref, my $s) = @_;
    my $sub_func_incl = sub_func_incl_mod( $s, $stref ); 
	my $is_incl = exists $stref->{'IncludeFiles'}{$s} ? 1 : 0;
    my $f = $is_incl ? $s : $stref->{$sub_func_incl}{$s}{'Source'};
    if ( defined $f ) {     	
		for my $item ( @{ $stref->{'SourceContains'}{$f}{'List'} } ) {
			# If $s is a subroutine, it could be that the source file is a Module, and then we should set that as the entry source type            
			if ($stref->{'SourceContains'}{$f}{'Set'}{$item} eq 'Modules') {
				my @subs_in_mod= @{ $stref->{'Modules'}{$item}{'Contains'} };
				if (grep {$_ eq $s} @subs_in_mod) {
					return 1;
				}
			}		                
		}
    }	
	return 0;        
}

sub _removed_unused_variables { (my $stref, my $f)=@_;
	# If a variable is assigned but does not occur in any RHS or SubroutineCall, it is unused. 
	# If a variable is declared but not used in any LHS, RHS  or SubroutineCall, it is unused.
	# So start with all declared variables, put in $state->{'ExprVars'}
	# Make a list of all variables anywhere in the code via Lhs, Rhs, Args

	my $pass_action_find_all_used_vars = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		
		my $rline=$line;
		my $rlines=[];
		
 		if ( exists $info->{'Signature'} ) {
 			$state->{'Args'} = $info->{'Signature'}{'Args'}{'Set'}; 
 		}
 		elsif (exists $info->{'Select'})  {
 			# FIXME: what about CaseVar?
# 			croak Dumper($info).$line;
 			my $select_expr_str=$line;
 			$select_expr_str=~s/^.\s*select\s+case\s*\(\s*//;
 			$select_expr_str=~s/\s*\)\s*$//;
 			my $select_expr_ast=parse_expression($select_expr_str, $info,{}, '');
# 			say Dumper($select_expr_ast);die;
 			my $vars = get_vars_from_expression($select_expr_ast,{});
 			$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $vars } };
 		} 		
		elsif (exists $info->{'CaseVals'})  {
# 			croak Dumper($info).$line;
			for my $val (@{ $info->{'CaseVals'} }) {
				if ($val=~/^[a-z]\w*/) {
 					$state->{'ExprVars'}{$val}=1;
 				} 		
			}
		}
		elsif ( exists $info->{'VarDecl'} ) {
			$state->{'DeclaredVars'}{ $info->{'VarDecl'}{'Name'}}=1;
		}
		elsif ( exists $info->{'Assignment'}  ) {
			my $var = $info->{'Lhs'}{'VarName'};
			if (exists $state->{'UnusedVars'}{$var}) {
				say "REMOVED ASSIGNMENT $line in $f"  if $DBG;
				$annline=['! '.$line, {%{$info},'Deleted'=>1}];
				delete $state->{'UnusedVars'}{$var};
				delete $state->{'AssignedVars'}{$var};	
				# I should now also remove all vars			
			} else {
				$state->{'AssignedVars'}{$var}=1;
				
				if (exists $info->{'Lhs'}{'IndexVars'}) {
					$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Lhs'}{'IndexVars'}{'Set'} } };
				}
				$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $info->{'Rhs'}{'VarList'}{'Set'} } };
				# and in principle also Vars, IndexVars for $info->{'Rhs'}{'VarList'}{'Set'}{$var}
				for my $var (keys %{  $info->{'Rhs'}{'VarList'}{'Set'} } ) {
					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'}) {
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'} }};
					}
					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'}) {
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'} }};
					}			
				}
			}
		}
		elsif (exists $info->{'If'} ) {		
				
				my $cond_expr_ast=parse_expression($info->{'CondExecExpr'}, $info,$stref, $f);
				$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'} } }; 
				for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
					next if $var eq '_OPEN_PAR_';					
					if (exists  $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} ) {								
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} } };
					}				
				}
							
		}
		elsif ( exists $info->{'SubroutineCall'} ) {
			$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{$info->{'SubroutineCall'}{'Args'}{'Set'} } };
		}
		
		return ([$annline],$state);
	};
		
	my $state= {'DeclaredVars'=>{},'UndeclaredVars'=>{},
		'ExprVars'=>{},
		'AssignedVars'=>{},'Args'=>{},
		'UnusedVars'=>{},
		'UnusedDeclaredVars'=>{}
	};
	do {
		$state->{ExprVars}={};
		$state->{AssignedVars}={};
 		($stref,$state) = stateful_pass_reverse($stref,$f,$pass_action_find_all_used_vars, $state,'_removed_unused_variables() ' . __LINE__  ) ;
 	
 	# Once we have these lists, we can now check if there are any variables that occur on an Lhs an are not used anywhere
 	# We simply check for every AssignedVar if it is used as an ExprVar 	
	 	for my $var (keys %{ $state->{'AssignedVars'} }) {
	 		if (not exists $state->{'ExprVars'}{$var} and not exists $state->{'Args'}{$var}) {
	 			say "VAR $var is unused in $f" if $DBG;
	 			$state->{'UnusedVars'}{$var}=1;
	 		} 
	 	}
	} until scalar keys %{ $state->{'UnusedVars'} } ==0; 
	

	
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
	# FIXME: should this be _reverse?
	($stref,$state) = stateful_pass_reverse($stref,$f,$pass_action_decls, $state,'_removed_unused_variables() ' . __LINE__  ) ;
 	# Adapt the signature in $stref
 	$stref->{'Subroutines'}{$f}{'DeletedArgs'} =$state->{'DeletedArgs'};
 	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'}=dclone($state->{'RemainingArgs'});
 	map { delete $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };
 	
	# As we are going through the whole code we can also test for undeclared vars	
	for my $expr_var (keys %{ $state->{'ExprVars'} } ) {
		if (not exists $state->{'DeclaredVars'}{$expr_var} ) {
			
#			say "VAR <$expr_var> in $f is UNDECLARED!";
			if ($expr_var ne '_OPEN_PAR_' and $expr_var!~/^\d/) {
				$state->{'UndeclaredVars'}{$expr_var}='MAYBE real'; # the default
				# Now, what is the type of this $expr_var?
				# We can determine the type if they are assigned using an extra pass, by looking at any vars in the RHS or if there aren't the type of the constants in the expression. Sigh. 
				# I guess we start by setting them to real scalars.
#				if (exists $state->{'AssignedVars'}{$expr_var} ) {
##					say "ASSIGNED $expr_var".Dumper($state->{'AssignedVars'}{$expr_var});
#					$state->{'UndeclaredVars'}{$expr_var}=2; # 2 meaning is assigned	
#				}
			} 
		}
	}
	
		my $pass_action_type_undeclared = sub { (my $annline, my $state)=@_;
			(my $stref, my $f, my $pass_state)=@{$state};
		(my $line,my $info)=@{$annline};
		
		if (exists $info->{'Assignment'} ) { 
			
			my $var = $info->{'Lhs'}{'VarName'};
#			say "LINE: $line => <$var>"	;
			
			if (exists $pass_state->{'UndeclaredVars'}{$var}) {
				
#				say "TYPING $var:";				
#			croak Dumper($info->{'Rhs'}{'VarList'}{'Set'});
			# Now from this list via 
				my $var_type = 'integer';
				for my $rhs_var (@{ $info->{'Rhs'}{'VarList'}{'List'} } ) {
					next if $rhs_var  eq '_OPEN_PAR_';
					my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$rhs_var) ;
#					say 'via '.$rhs_var.' : '.$decl->{'Type'};
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
 	
 	# So at this point we have $pass_state->{'UndeclaredVars'} for $f, so now we need a pass to add the missing decls 
 	# the best way is a reverse pass which adds the decls as soon as it finds a declaration, using a state var "Once"
 			my $pass_action_add_undeclared_type_decls = sub { (my $annline, my $state)=@_;
			(my $stref, my $f, my $pass_state)=@{$state};
		(my $line,my $info)=@{$annline};
		my $rlines = [$annline];
		if (exists $info->{'VarDecl'} and $pass_state->{'Once'}==0 ) { 
#			croak $f.Dumper($info);
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
	#			'IODir'  => ,
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
				# And we also need to add these variables to OrigUndeclaredLocalVars or maybe OrigDeclaredLocalVars ???
				$stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$undecl_var}=$decl;
				push @{$rlines},[$decl_line,$decl_info];
			}
		} 
		return ($rlines,[$stref,$f,$pass_state]);
	};
 	
	$full_state->[2]{'Once'}=0;
#	my $annlines           = get_annotated_sourcelines( $stref, $f );
#	say Dumper($annlines );
 	($stref,$full_state) = stateful_pass_reverse($stref,$f,$pass_action_add_undeclared_type_decls, $full_state,'pass_action_add_undeclared_type_decls() ' . __LINE__  ) ;
	@{ $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'List'} } = sort keys %{ $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'} } ; 	
	return $stref;
} # END of _removed_unused_variables()

# Gavin's code has _ptr arrays to pass scalar pointers. This is necessary for actual Fortran code, not for code that is to be translated to OpenCL
sub _fix_scalar_ptr_args { (my $stref, my $f)=@_;
	
	# TODO: In principle I must update the $stref->{Subroutines}{$f} records as well
	my $pass_action = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		
		my $rline=$line;
		my $rlines=[$annline];
		
		# Here we simply replace any _ptr name with the name without _ptr
 		if ( exists $info->{'Signature'} ) {
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
				if ($arg=~/_ptr/) {
					my $new_arg=$arg;
					$new_arg=~s/_ptr$//;
					push @{$new_args}, $new_arg;
					$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$new_arg} = dclone($stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg} );
					delete $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg} ;					
				} else {
					push @{$new_args}, $arg;
				}
				  
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'}=$new_args ;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
			
			my $sig_str = $line;
			$sig_str=~s/_ptr//g;
			$rlines=[[$sig_str,$info]];			 
 		}
		elsif ( exists $info->{'VarDecl'} ) {
			my $var= $info->{'VarDecl'}{'Name'};
			
			if ($var=~/_ptr$/) {
					my $new_arg=$var;
					$new_arg=~s/_ptr$//;		
					$info->{'VarDecl'}{'Name'}=$new_arg;
  					$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} = [];
    				$info->{'ParsedVarDecl'}{'Attributes'}{'Vars'} = [$new_arg]; 					

				my $decl_str = $line;
				$decl_str =~s/_ptr//g;
				$decl_str =~s/,\s+dimension\(1\)//;
				$rlines=[["!$decl_str ",$info]];			 
			}			
		}
		elsif ( exists $info->{'Assignment'}  ) {
			my $var = $info->{'Lhs'}{'VarName'};
			if ($line=~/=\s*\w+_ptr/) {
#				say $line;
				say "REMOVED ASSIGNMENT $line in $f"  if $DBG;
				$annline=['! '.$line, { %{$info},'Deleted'=>1 }];
				$rlines=[$annline];
				# I should now also remove all vars			
			} 
		}
		
		return ($rlines,$state);
	};
		
	my $state= {
	};
	# FIXME: this is a stateless pass!
 		($stref,$state) = stateful_pass_reverse($stref,$f,$pass_action, $state,'_removed_unused_variables() ' . __LINE__  ) ;

 	
	return $stref;
} # END of _fix_scalar_ptr_args()
 
# -----------------------------------------------------------------------------


1;
