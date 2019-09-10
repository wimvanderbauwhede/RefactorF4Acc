package RefactorF4Acc::Translation::Fixes;
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

# I'm not sure that this is the best place for this routine as it is only used in this pass    
use RefactorF4Acc::Refactoring::Subroutines::Emitters qw( emit_subroutine_sig emit_subroutine_call );
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
$VERSION = "1.2.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Translation::Fixes::ISA = qw(Exporter);

@RefactorF4Acc::Translation::Fixes::EXPORT_OK = qw(
	&_declare_undeclared_variables
	&_removed_unused_variables
	&_fix_scalar_ptr_args
	&_fix_scalar_ptr_args_subcall
	&_make_dim_vars_scalar_consts_in_sigs
	&_remove_redundant_arguments
);

# ================================================================================================================================================
# This is a FIX
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

# This is a FIX
sub _declare_undeclared_variables { (my $stref, my $f)=@_;
	# If a variable is assigned but is not and arg and does not occur in any RHS or SubroutineCall, it is unused. 
	# If a variable is declared but not used in any LHS, RHS  or SubroutineCall, it is unused.
	# So start with all declared variables, put in $state->{'DeclaredVars'}
	# Make a list of all variables anywhere in the code via Lhs, Rhs, Args, put in $state->{'ExprVars'}
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
			
				my $cond_expr_ast=$info->{'CondExecExprAST'};
				$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'} } }; 
				for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
					next if $var eq '_OPEN_PAR_';					
					# We now put the IndexVars in the Set directly so the code below is no longer needed					
					# if (exists  $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} ) {
					# 	$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} } };
					# }				
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
			if ($expr_var ne '_OPEN_PAR_' and $expr_var!~/^\d/) {				
				$state->{'UndeclaredVars'}{$expr_var}='real'; # the default
			} 
		}
	}
	for my $lhs_var (keys %{ $state->{'AssignedVars'} } ) {
		next if exists $Config{'Macros'}{uc($lhs_var)};
		if (not exists $state->{'DeclaredVars'}{$lhs_var} ) {
#			if ($expr_var ne '_OPEN_PAR_' and $expr_var!~/^\d/) {				
				$state->{'UndeclaredVars'}{$lhs_var}='real'; # the default
#			} 
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
					my $new_arg=$arg;
					$new_arg=~s/_ptr$//;
					$pass_state->{'ExPtrArgs'}{$arg}=$new_arg;
					push @{$new_args}, $new_arg;
					my $orig_decl = dclone($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg} );
					$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$new_arg} = $orig_decl ; 
					delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg} ;					
				} else {
					push @{$new_args}, $arg;
				}				  
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
			$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=$new_args ;
			
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
# Clearly a FIX!
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
						$info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg} = {'Expr' => $call_arg.'(1)','Type'=>'Scalar'};
					} else {
						$info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg} = {'Expr' => $call_arg,'Type'=>'Array'};
					}
				} else {
					$new_arg_map->{$sig_arg}=$call_arg;
				}
			}
			$info->{'SubroutineCall'}{'ArgMap'} = $new_arg_map;	
		
		# Then update CallArgs and again the ArgMap
	      my $orig_call_args = $info->{'SubroutineCall'}{'Args'}{'List'};
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
	      		delete $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg};
	      		delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
	      	}     	    
	      }
	      $info->{'SubroutineCall'}{'Args'}{'List'}=$new_call_args;
	      
	      	    my $indent = $info->{'Indent'} // '      ';
		    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
		    my @new_call_exprs = map  { $info->{'SubroutineCall'}{'Args'}{'Set'}{$_}{'Expr'} } @{$new_call_args};  
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
# This is a FIX
sub _make_dim_vars_scalar_consts_in_sigs { (my $stref, my $f)=@_;
	
	# TODO:  I must update the $stref->{Subroutines}{$f} records as well
	my $pass_make_dim_vars_scalar_consts_in_sigs = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		(my $stref,my $f,my $pass_state)=@{$state};
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


 # I'll put this here but we should move all passes that fix the broken output of Gavin's and James's compilers in a separate module, maybe "Translation::Preconditioning"
# WV20190821

# A bug to solve in Gavin's compiler is that it promotes some locals to args. 
# What we need is the definitive algorithm to decide that something is a local. 
# Because we start from nested loops, in principle nothing is local. 
# So we have a pass which checks if an argument is used for write before a given kernel or for read after a given kernel. 
# As all the arguments have their original names this should be easy.

# Sadly this will not work because we can't tell if an argument was added in Gavin's compiler, unless we start parsing the original sources as well.
# So maybe I need to do this in  Gavin's compiler after all. 
# I think actually the main issue is that variables used in IF conditions are not considered.

=pod Redundant args
So, given an arg like duu, with intent In
If I can prove that it was never read before being written to, I can remove it.

So I go through all AnnLines looking for duu. If I find a read before I found a write, I give up. If I find a write (i.e. if duu is in the LHS of an Assignment before that, I can remove it!
So I have a flag $access_status which can be Unknown, Read or Written. Starts out as Unknown in the Signature. 
It can be Read before Written if it is used in an If condition which guards the Assign, or in the bounds of a Do loop

In other words, 
- start from the KERNEL, as before
- get all In args because for an Out arg it is impossible to tell if the user wanted this
- go through all kernel calls in order. If a call has the arg, then check the "read before write" logic

=cut


# This is a FIX
# This routine should also be run on every subroutine as there are quite a few args labeled as inout which are actually out 
# Called in TyTraCL.pm, so should therefore also be called in TyTraIR, and also in OpenCLC
# Clearly, we should have a common "patch_up_output_from_other_compilers" pass.
sub _remove_redundant_arguments { (my $stref, my $f)=@_;

	if ($f eq $Config{'KERNEL'}) {
		my @in_args = grep { 
			$stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'Set'}{$_}{'IODir'} eq 'in'
		}  @{$stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'List'}};

		my @call_sequence=();
		my $f_idx=0;
		my $idx=0;
		for my $annline (
			@{$stref->{'Subroutines'}{ $f }{'RefactoredCode'}}
		) {
				(my $line,my $info)=@{$annline};
			
				if (exists $info->{'SubroutineCall'} ) { 
					my $csub = $info->{'SubroutineCall'}{'Name'};
					push @call_sequence, $csub;
					if ($csub eq $f) {
						$f_idx=$idx;
					}
					++$idx;
				}
		}
		my $in_args_to_keep={};
		for my $in_arg (@in_args) {
			for my $csub (@call_sequence) {
				my $csub_args = $stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'Set'};
				if (exists $csub_args->{$in_arg}) {
					# See if it was written to before it was read. 
					# If it was read first, we need to keep it, else we don't need it for this subroutine
					my $written_before_read = __check_written_before_read($in_arg, $stref, $csub);
					if (not $written_before_read) {
						$in_args_to_keep->{$in_arg}=1;
						last;
					}
					# As soon as we need to keep it for one subroutine, we can stop as we can't remove it.
					# However, if the csub arg is inout, and we have a write-before-read, then any subsequent sub call can be ignored
					# This is not the case if the csub arg is just in -- but I think we can't write to an in argument
				} 
			}
		}
		# so at this point we should know which input args to keep.
		my $in_args_to_remove={'Set'=>{},'List'=>[]};
		for my $arg (@in_args) {
			if (not exists $in_args_to_keep->{$arg}) {
				$in_args_to_remove->{'Set'}{$arg}=1;
				push @{$in_args_to_remove->{'List'}}, $arg;
			}
		}
		
		# croak Dumper $in_args_to_remove;
		$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}  = remove_vars_from_ordered_set($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}, $in_args_to_remove->{'List'});


		my $pass_remove_redundant_args = sub { (my $annline)=@_;
			(my $line,my $info)=@{$annline};
			if (exists $info->{'Signature'} ) {
				$info->{'Signature'}{'Args'} = remove_vars_from_ordered_set($info->{'Signature'}{'Args'}, $in_args_to_remove->{'List'});
				(my $rline, $info) = emit_subroutine_sig( [$line, $info]);
				$annline = [$rline, $info];
			}			
			elsif (exists $info->{'VarDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};
				if (exists $in_args_to_remove->{'Set'}{$var}) {
					$info->{'Deleted'} = 1;
					$annline = ["! $line", $info];
				}
			}
			elsif (exists $info->{'SubroutineCall'} ) {
					$info->{'SubroutineCall'}{'Args'} = remove_vars_from_ordered_set($info->{'SubroutineCall'}{'Args'}, $in_args_to_remove->{'List'});
					(my $rline, $info) = emit_subroutine_call($stref, $f, [$line, $info]);
					$annline = [$rline, $info];
			}
			return ([$annline]);
		};
	
	
 	$stref = stateless_pass($stref,$f,$pass_remove_redundant_args, $in_args_to_remove,'pass_remove_redundant_args' . __LINE__  ) ;



	} else {

	}
=pod	
	 Now we should remove these arguments:
	 - in the superkernel:
	 	- from the argument list : $annlines, but also Args 	
	 	- from the call arguments of each kernel : $annlines, but also the ArgMap
		- remove all declarations for these args :  $annlines
	 - In every called sub for my $csub (@call_sequence) {}
	 	- from the  argument list of each kernel : $annlines, but also from Args to DeclaredOrigLocalVars
	 	- remove the intents from the declarations : $annlines, but also from DeclaredOrigLocalVars

This analysis uses the superkernel sub, not every subroutine in the module. So we need a condition on $f 



=cut

	return $stref;
} # END of _remove_redundant_arguments

sub __check_written_before_read { my ($in_arg, $stref, $f)=@_;

# In practice we will not have IO calls in the kernels
# Nor will we have subroutines calls
# Function calls on RHS are OK 
# So all we need to check is Assignments, If, Do and Case
# I am going to lazily assume that CaseVals are constants
my $pass_check_written_before_read = sub { (my $annline, my $reads_writes)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Assignment'} ) { 			
				 if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$in_arg}) {
					 # $in_arg is Read 
					 push @{$reads_writes},'r';
				 }
				if ($info->{'Lhs'}{'VarName'} eq $in_arg) {
					 # $in_arg is Written 
					 push @{$reads_writes},'w';
				 }
		}	
		elsif (exists $info->{'If'} ) { 			
				 if (exists $info->{'CondVars'}{'Set'}{$in_arg}) {
					 # $in_arg is Read  
					 push @{$reads_writes},'r';
				 }
		}			
		elsif (exists $info->{'CaseVar'} ) { 			
				 if ($info->{'CaseVar'} eq $in_arg) {					 
					 # $in_arg is Read  
					 push @{$reads_writes},'r';
				 }
		}			
		elsif (exists $info->{'Do'} ) { 			
				 if (exists $info->{'Do'}{'Range'}{'Vars'}{$in_arg}) {					 
					 # $in_arg is Read  
					 push @{$reads_writes},'r';
				 }
		}			

		return ([$annline],$reads_writes);
	};
	
	my $reads_writes=[]; # sequence of 'r' and 'w'. And yes, I could use 0/1
 	($stref,$reads_writes) = stateful_pass($stref,$f,$pass_check_written_before_read, $reads_writes,'pass_check_written_before_read' . __LINE__  ) ;
	my $written_before_read = 0;
	for my $rw (@{$reads_writes}) {
		if ($rw eq 'w') {
			$written_before_read=1;
		}
		last;
	}
	return $written_before_read;
}

1;

