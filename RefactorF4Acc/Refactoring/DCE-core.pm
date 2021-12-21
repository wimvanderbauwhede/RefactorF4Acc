package RefactorF4Acc::Refactoring::DCE::Core;
# Core functionality for Dead Code Elimination
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( init foldl null head );
use RefactorF4Acc::Refactoring::Helpers qw( 
	pass_wrapper_subs_in_module 
	stateful_pass_inplace 
	stateful_pass
	stateful_pass_reverse_inplace 
	stateless_pass_inplace  
	emit_f95_var_decl 
	splice_additional_lines_cond_inplace  
	get_annotated_sourcelines
	);

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
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
);
	
sub _build_paths {my ($state, $st_id, $paths, $path_id) = @_; # 0,{},'0'; 1,{},'0:1'; 2,{},'0:1:2'

		my $seq = $state->{'IfBlocks'}{$st_id}{'Branches'}; 
		# say Dumper $seq;
		for my $b_id ( @{$seq}) { # 1,7,8; 2,3,4
			say "\t" x $path_id,"BRANCH ID $b_id";
			push @{$paths}, $b_id;
			if (scalar @{$state->{'IfBlocks'}{$b_id}{'Children'}} >0 ) {
				for my $ch_id ( @{$state->{'IfBlocks'}{$b_id}{'Children'}}) { # 1; 2,5
				# push @{$paths}, $ch_id;
				say "\t" x ($path_id+1),"CHILD STMT $ch_id";
			
			
			
			
				# my $l_path_id =$path_id.':'.$ch_b_id; #'0:1'; #'0:1:2'
				($paths, my $prev_path_id) = _build_paths($state, $ch_id, $paths, $path_id+2);
				# post action here: 
				# say 'path id: '.$prev_path_id;
				# push @{$paths->{$prev_path_id}{'AssignedVars'}}, 
				# 	$state->{'IfBlocks'}{$ch_b_id}{'AssignedVars'};
				# push @{$paths->{$path_id}{'ExprVars'}}, 
				# 	   	$state->{'IfBlocks'}{$ch_b_id}{'ExprVars'};
			}
		}
		# Here we have to do something as well
		# say "END of for";
	
		else {
			# leaf reached
			# say Dumper $paths;
			# If this leaf is the last in a seq, it is the end of a path
			# $paths->{$path_id}{'AssignedVars'}=[];
			# $paths->{$path_id}{'ExprVars'}=[];	
			# say "LEAF: $path_id";
			
		}
	}
	# Should we return something here?
	return ($paths, $path_id);
}
my $paths = _build_paths($state, 0, [], 0);
		die;
	for my $block_id ( sort keys %{ $state->{'IfBlocks'} } ) {				
		for my $var (sort keys %{ $state->{'IfBlocks'}{$block_id}{'AssignedVars'} }) {
			for my $child_block_id (@{$state->{'IfBlocks'}{$block_id}{'Children'}}) {
				my $if_is_expr_for_var=_if_is_expr_for_var($state, $child_block_id, $var);
			}
=pod		
	So at this point we know which of the child blocks are expressions for which variables.
	How do we include these in the analysis? 
	If the child if statement is an expression for $var, it is equivalent to a single assignment. 
	But how to deal with reads in those blocks?
	Any read before the assignment means the parent assignment can't be removed
	So we should actually use the EndLineID of the statement as the location of the expression assignment
		
=cut			
			say "VAR $var " if $DBG;#.Dumper($state->{'AssignedVars'});
			# This function decides which lines for a given variable can be removed because they are useless assignments
			my $remove = _remove_or_keep($block_id, $var, $state);
			# carp Dumper($remove);
			# This part, which might be in its own function, actually removes the lines from $state
			if (scalar keys %{$remove}>0) {
				for my $l_id (sort keys %{$remove}) {
					say "REMOVING assignment line $l_id for var $var" if $DBG;
					# Remove the LineID  from LineIDs
					my @line_ids = grep {$_ != $l_id } @{$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'}};				
					$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'} = [@line_ids];
					# Decrement the counter
					$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'Counter'}--;
					if ($state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'Counter'}==0) {
						$state->{'UnusedDeclaredVars'}{$var}=1;
					}
					# Add this LineID to UnusedLines
					$state->{'UnusedLines'}{$l_id}++;
					# Now we need to check all vars on the RHS of the assignment
					# and remove the LineID from ExprVars
					for my $rhs_var (keys %{ $state->{'ExprVars'} }) {
						# Check if $rhs_var occurs on that line by grepping $l_id in LineIDs
						my @rhs_var_on_line = grep {$_==$l_id} @{$state->{'ExprVars'}{$rhs_var}{'LineIDs'}};
						# If rhs_var occurs on line $l_id
						if (@rhs_var_on_line) {
							say "REMOVING assignment line $l_id for RHS var $rhs_var" if $DBG;
							# Remove the LineID  from LineIDs
							my @rhs_line_ids = grep {$_ != $l_id } @{$state->{'ExprVars'}{$rhs_var}{'LineIDs'}};
							$state->{'ExprVars'}{$rhs_var}{'LineIDs'} = [@rhs_line_ids];
							# Decrement the counter
							$state->{'ExprVars'}{$rhs_var}{'Counter'}--;							
						}
					}
				}
			}
		}
		# ExprVars with Counter==0 are unused, remove their assignments too
		for my $rhs_var (keys %{ $state->{'IfBlocks'}{$block_id}{'AssignedVars'} }) {
			# say "RHS VAR: $rhs_var";
			if (exists $state->{'ExprVars'}{$rhs_var} and
				exists $state->{'ExprVars'}{$rhs_var}{'Counter'} and  
				$state->{'ExprVars'}{$rhs_var}{'Counter'}==0
			) {					
				delete $state->{'ExprVars'}{$rhs_var};
				if (exists $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$rhs_var}
					and exists $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$rhs_var}{'LineIDs'}
					and scalar @{$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$rhs_var}{'LineIDs'}}>0					
				) {
					my $rhs_var_assignment_l_id = $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$rhs_var}{'LineIDs'}[0];
					say "REMOVING assignment line $rhs_var_assignment_l_id for RHS var $rhs_var" if $DBG;
					if (not exists $state->{'UnusedLines'}{ $rhs_var_assignment_l_id}) {
						$state->{'UnusedLines'}{ $rhs_var_assignment_l_id}++;
					}
					delete $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$rhs_var};
					$state->{'UnusedVars'}{$rhs_var}=1;
					$state->{'UnusedDeclaredVars'}{$rhs_var}=1;
				}
			}
		} # Assigned variables
	# die Dumper $state;
	} # If blocks
	die "\nSTATE:\n".Dumper( $state);
	
	# At this point we have a list of all lines to be removed. So now we should mark all these lines as Deleted
	
	# --------------------------------------------------------------------------------------------------------------------------------
	say "\ndelete_unused_lines\n" if $DBG;
	my $pass_action_delete_unused_lines = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		if (not exists $info->{'LineID'}) {
			say "NO LineID: $line";
		} else {
 			if (exists $state->{'UnusedLines'}{$info->{'LineID'}}) {
				say "DELETED: $line" if $DBG;
				# Control blocks will be eliminated in a later pass
				if (not exists $info->{'Do'} and
					not exists $info->{'IfThen'} and
					not exists $info->{'Select'} 
				){
					$info->{'Deleted'}=1;
				}
		 	}
		}
		return ([[$line,$info]],$state);
	};
	# my $annlines_3 = $Sf->{'RefactoredCode'};
	(my $annlines_4,$state) = stateful_pass($annlines_3 ,$pass_action_delete_unused_lines, $state,'_delete_unused_lines() ' . __LINE__  );

	# die;
	# die "\nSTATE:\n".Dumper( $state);
	# --------------------------------------------------------------------------------------------------------------------------------		
 	# So now we have removed all assignments. 
 	# Now we need to check which vars are declared but not used and remove those declarations. 
 	for my $var (keys %{ $state->{'DeclaredVars'} }) { 		
 		if (not exists $state->{'ExprVars'}{$var} 
 		and not exists $state->{'AssignedVars'}{$var}
		 ) { 			
 			say "VAR $var is declared but unused in $f" if $DBG;
 			$state->{'UnusedDeclaredVars'}{$var}=1;
 		} 
 	}
 	
 	# Now we should remove these declarations

	my $pass_action_remove_decls = sub { (my $annline, my $state)=@_;		
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
	(my $annlines_5,$state) = stateful_pass($annlines_4,$pass_action_remove_decls, $state,'_remove_unused_decls() ' . __LINE__  ) ;
	
	# --------------------------------------------------------------------------------------------------------------------------------	
 	# Adapt the Signature in $stref
 	$stref->{'Subroutines'}{$f}{'DeletedArgs'} =$state->{'DeletedArgs'};
 	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=dclone($state->{'RemainingArgs'});
	
 	map { delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };
	die show_annlines( $annlines_5);
	$stref->{'Subroutines'}{$f}{'RefactoredCode'} = $annlines_5;
	# die;
	return $stref;
	
} # END of _remove_unused_variables()
# ================================================================================================================================================
# This needs to be refined to work with If blocks. 
# ct = 0, []
# This needs to become a stateful_pass
sub _mark_if_blocks { my ($info, $state) = @_;
	my $counter = $state->{'Counter'};# 0;
	my @stack = $state->{'Stack'};#();
	my $blockid;# = $state->{'IfBlockID'}; #0;
	if (exists $info->{'IfThen'}) {
		push @stack, $counter;
		++$counter;
		$blockid=$counter;
	}
	elsif (exists $info->{'ElseIf'}) {
		++$counter;
		$blockid=$counter;	
	}
	elsif (exists $info->{'Else'}) {
		++$counter;
		$blockid=$counter;	
	}
	elsif (exists $info->{'EndIf'}) {
		$blockid = pop @stack;	
	} 
	else { # anything else, label it
		$blockid=$counter;
	}
	$info->{'IfBlockID'}=$blockid;
	$state->{'Counter'} = $counter ;
	$state->{'Stack'} = [@stack];
	# $state->{'IfBlockID'} = $blockid;
	return ($info,$state);
}
# $state->{$ifblockid}{'ExprVars'}

# if push 0;ct++ => 1,[0]
# 	v1 = ct=1 
#	if push 1; ct++ => 2; [1,0]
#		v2 =  ct=2; [1,0]
#		if push ct; ct++ => 3; [2,1,0]
#			v5 = ct=3 => 3; [2,1,0]
#		end if --3  ct=3; pop => 2; [1,0]
#		v3 = --2 => 2; [1,0]
#	else if ct++ => 4; [1,0]
#		v3 = --4 => 4; [1,0]
#	else if --5 ct++ => 5; [1,0]
#		v3 = --5 => 5; [1,0]
#	end if --5 ct=5; pop => 1; [0]
#	v4 = --1
# else ct++ => 6; [0]
# v5 = --6 => 6; [0]
# end if ct=6; pop => 0; []
# v6 = ... => 0,[]
# So essentially we must tag every assignment and do/end do with the if block ID
# But this is not the same ID as BlockID because of the else 

sub _remove_or_keep { my ($block_id, $var, $state) = @_;
	my $keep={};
	my $remove={};
	# for my $block_id ( sort keys %{ $state->{'IfBlocks'} } ) {
		my $start = $state->{'IfBlocks'}{$block_id}{'StartLineID'};
		my $end = $state->{'IfBlocks'}{$block_id}{'EndLineID'};
		say $var . Dumper($state->{'IfBlocks'}{$block_id});
		my $end_idx = scalar(@{$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'}})-1;
		for my $idx (0 .. $end_idx) {
			my $write_line_id = $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'}[$idx];		
			if ($idx < $end_idx ) {
				my $next_write_line_id = $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'}[$idx+1];				
				for my $read_line_id ( @{$state->{'ExprVars'}{$var}{'LineIDs'}} ) {
					if ($read_line_id>=$start and $read_line_id<=$end) {
					if ($read_line_id>$write_line_id and $read_line_id<=$next_write_line_id) {
						say "KEEP assignment to $var at $write_line_id" if $DBG;
						# $remove=0;
						$keep->{$write_line_id}=1;
					} 
					}
				}
			} else {
				# There is no further assignment
				for my $read_line_id ( @{$state->{'ExprVars'}{$var}{'LineIDs'}} ) {
					if ($read_line_id>$write_line_id ) {
						say "KEEP assignment to $var at $write_line_id" if $DBG;
						$keep->{$write_line_id}=1;
					} 
				}	
				if (exists $state->{'Args'}{$var} and $state->{'Args'}{$var} eq 'out') {
						say "KEEP assignment to ARG $var at $write_line_id" if $DBG;
						$keep->{$write_line_id}=1;				
				}
			}
		}
		$remove = {map {$_=>1} @{$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'}}};
		for my $l_id (sort keys %{$keep}) {
			if (exists $remove->{$l_id}) {
				delete $remove->{$l_id};
			} 
		}
	# }
	return $remove;
} # END of _remove_or_keep


sub _get_all_vars_from_assignment_rec { my ($rec) = @_;
# $rec = $info->{'Rhs'|'Lhs'}{'Vars'}{'Set'}
my $vars={};
for my $var (sort keys %{$rec}) {
	$vars->{$var}=$rec->{$var}{'Type'};
	if (exists $rec->{$var}{'IndexVars'}) {
		$vars = {%{$vars},%{ _get_all_vars_from_assignment_rec($rec->{$var}{'IndexVars'})}};
	}
}
return $vars;
}
# 	$VAR1 = {
#   'IndexVars' => {
#     's3' => {
#       'Type' => 'Array',
#       'IndexVars' => {
#         's_idx_2' => {
#           'Type' => 'Scalar'
#         }
#       }
#     },
#     's5' => {
#       'Type' => 'Array',
#       'IndexVars' => {
#         's_idx_1' => {
#           'Type' => 'Scalar'
#         }
#       }
#     },
#     'global_id' => {
#       'Type' => 'Scalar'
#     }
#   },
#   'Type' => 'Array'
# };



# This is a FIX
sub _declare_undeclared_variables { (my $stref, my $f)=@_;
if (not exists $Config{'FIXES'}{'_declare_undeclared_variables'}) { return $stref }
	
	# If a variable is assigned but is not and arg and does not occur in any RHS or SubroutineCall, it is unused. 
	# If a variable is declared but not used in any LHS, RHS  or SubroutineCall, it is unused.
	# So start with all declared variables, put in $state->{'DeclaredVars'}
	# Make a list of all variables anywhere in the code via Lhs, Rhs, Args, put in $state->{'ExprVars'}
	my $pass_action_find_all_used_vars = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		# say "$f LINE: $line" if $line=~/range/;
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
				$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $info->{'Rhs'}{'Vars'}{'Set'} } };
				for my $var (keys %{  $info->{'Rhs'}{'Vars'}{'Set'} } ) {
					if (exists $info->{'Rhs'}{'Vars'}{'Set'}{$var}{'Vars'}) {
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'Vars'}{'Set'}{$var}{'Vars'} }};
					}
					if (exists $info->{'Rhs'}{'Vars'}{'Set'}{$var}{'IndexVars'}) {
						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'Vars'}{'Set'}{$var}{'IndexVars'} }};
					}			
				}			
		}
		elsif ( exists $info->{'SubroutineCall'} ) {
			# This means array index expressions will be included
			$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{$info->{'SubroutineCall'}{'Args'}{'Set'} } };
		}		
		if (exists $info->{'If'} ) {					
			
				my $cond_expr_ast=$info->{'Cond'}{'AST'};
				$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Cond'}{'Vars'}{'Set'} } }; 
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
 		($stref,$state) = stateful_pass_inplace($stref,$f,$pass_action_find_all_used_vars, $state,'_find_all_unused_variables() ' . __LINE__  ) ;

	# --------------------------------------------------------------------------------------------------------------------------------
	# As we are going through the whole code we can also test for undeclared vars 
	# This is very ad-hoc
	for my $expr_var (keys %{ $state->{'ExprVars'} } ) {
		next if exists $Config{'Macros'}{uc($expr_var)};
		if ($expr_var=~/\(/) {
			$expr_var=~s/\(.+$//;
		}
		next if $expr_var=~/^\d/;

		if (not exists $state->{'DeclaredVars'}{$expr_var} ) {			
				$state->{'UndeclaredVars'}{$expr_var}='real'; # the default
		}
	}
	for my $lhs_var (keys %{ $state->{'AssignedVars'} } ) {
		next if exists $Config{'Macros'}{uc($lhs_var)};
		if (not exists $state->{'DeclaredVars'}{$lhs_var} ) {
			$state->{'UndeclaredVars'}{$lhs_var}='real'; # the default
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
				for my $rhs_var (@{ $info->{'Rhs'}{'Vars'}{'List'} } ) {
					next if exists $Config{'Macros'}{uc($rhs_var)};
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
 	($stref,$full_state) = stateful_pass_inplace($stref,$f,$pass_action_type_undeclared, $full_state,'_pass_action_type_undeclared() ' . __LINE__  ) ;
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
 	($stref,$full_state) = stateful_pass_reverse_inplace($stref,$f,$pass_action_add_undeclared_type_decls, $full_state,'pass_action_add_undeclared_type_decls() ' . __LINE__  ) ;
	@{ $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'List'} } = sort keys %{ $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'} } ;
		
	return $stref;
} # END of _declare_undeclared_variables()
# ================================================================================================================================================
# Gavin's code has _ptr arrays to pass scalar pointers. This is necessary for actual Fortran code, not for code that is to be translated to OpenCL
sub _fix_scalar_ptr_args { (my $stref, my $f)=@_;
if (not exists $Config{'FIXES'}{'_fix_scalar_ptr_args'}) { return $stref }
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
				carp "FIXME!!!";
				if ($arg=~/_ptr/) {
					my $new_arg=$arg;
					$new_arg=~s/_ptr$//;
					$pass_state->{'ExPtrArgs'}{$arg}=$new_arg;
					push @{$new_args}, $new_arg;
					my $orig_decl = dclone($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg} );
					$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$new_arg} = $orig_decl ; 
					# croak $arg;
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
	
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_fix_scalar_ptr_args, $state,'pass_fix_scalar_ptr_args() ' . __LINE__  ) ;
} # IF NOT KERNEL
 	
	return $stref;
} # END of _fix_scalar_ptr_args()
 
# -----------------------------------------------------------------------------
# Clearly a FIX!
sub _fix_scalar_ptr_args_subcall { (my $stref, my $f)=@_;
if (not exists $Config{'FIXES'}{'_fix_scalar_ptr_args_subcall'}) { return $stref }		
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
	
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_fix_scalar_ptr_args_subcall, $state,'pass_fix_scalar_ptr_args_subcall() ' . __LINE__  ) ;
 		 
} 

	return $stref;
      
} # END of _fix_scalar_ptr_args_subcall


# ============================================================================================================
# This is a FIX
sub _make_dim_vars_scalar_consts_in_sigs { (my $stref, my $f)=@_;
if (not exists $Config{'FIXES'}{'_make_dim_vars_scalar_consts_in_sigs'}) { return $stref }	
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
	
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_make_dim_vars_scalar_consts_in_sigs, $state,'pass_make_dim_vars_scalar_consts_in_sigs() ' . __LINE__  ) ;
	
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
# A potential problem here is that I think the toplevel kernel routine should be called first, and then all the others.
# Because otherwise $in_args_to_remove will not be known yet.
# So it might actually be better to only run this on the toplevel kernel routine and then process CalledSubs

# There are two changes we want to make. 
# 1. We want to remove redundant arguments
# 2. Some of the called subroutines have arguments that are InOut but should really be Out (or maybe even In?)

sub remove_redundant_arguments_and_fix_intents { (my $stref, my $f)=@_;
	if (not exists $Config{'FIXES'}{'remove_redundant_arguments_and_fix_intents'}) { return $stref }	

	if ($f eq $Config{'KERNEL'}) { 
		my @in_args = grep { 
			if (not exists $stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'Set'}{$_}{'IODir'}) {
				die "The argument $_ of $f does not have a declaration.\n";
			} else {
			$stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'Set'}{$_}{'IODir'} eq 'in'
			}
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
					push @call_sequence, $info->{'SubroutineCall'};
					# push @call_sequence, $csub;
					if ($csub eq $f) {
						$f_idx=$idx;
					}
					++$idx;
				}
		}

		# If an argument of a called subroutine is an input argument of the kernel, we can check if it is actually used as an input
		# If it was written to before it was read, then it is not an input arg and should become a local. 
		my $inout_args_to_change_to_out={};
		my $in_args_to_keep={};		
		for my $in_arg (@in_args) {
			for my $csub_info (@call_sequence) {
				my $csub = $csub_info->{'Name'};
				my $csub_argmap = $csub_info->{'ArgMap'};
				# I use the ArgMap, which is SigArg => CallArg
				# So for a given CallArg, I must find the corresponding SigArg(s); in principle there can me more than one.
				# my $csub_args = $stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'Set'};
				my $sig_args = find_keys_for_value($csub_argmap,$in_arg);
				for my $sig_arg (@{$sig_args}) {
					# if (exists $csub_args->{$sig_arg}) {
						# See if $sig_arg was written to before it was read. 
						# If it was read first, we need to keep it, else we don't need it for this subroutine
						my $written_before_read = __check_written_before_read($sig_arg, $stref, $csub);						
						if (not $written_before_read) {
							$in_args_to_keep->{$in_arg}=1;
							last;
						} 
						# As soon as we need to keep it for one subroutine, we can stop as we can't remove it.
						# However, if the csub arg is inout, and we have a write-before-read, then any subsequent sub call can be ignored
						# This is not the case if the csub arg is just in -- but I think we can't write to an in argument
					# } 
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

	#  Now we should remove these arguments:
	#  - in the superkernel:
	#  	- from the argument list : $annlines, but also Args 	
	#  	- from the call arguments of each kernel : $annlines, but also the ArgMap
	# 	- remove all declarations for these args :  $annlines


		say 'In args to remove: ',Dumper $in_args_to_remove if $DBG;
		$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}  = remove_vars_from_ordered_set($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}, $in_args_to_remove->{'List'});

		say "\nSUB: $f" if $DBG;
# Because this lambda is defined in the scope of the current sub, $stref and $in_args_to_remove are in scope
# All of these are used read-only 
		my $pass_remove_redundant_args_in_superkernel = sub { (my $annline)=@_;
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
				my $csub = $info->{'SubroutineCall'}{'Name'};
				
					$info->{'SubroutineCall'}{'Args'} = remove_vars_from_ordered_set($info->{'SubroutineCall'}{'Args'}, $in_args_to_remove->{'List'});
				
					(my $rline, $info) = emit_subroutine_call($stref, $csub, [$line, $info]);
					for my $call_arg (@{$in_args_to_remove->{'List'}}) {
						delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
					}					
					$annline = [$rline, $info];
			}
			return ([$annline]);
		};
		
 		$stref = stateless_pass_inplace($stref,$f,$pass_remove_redundant_args_in_superkernel,'pass_remove_redundant_args_in_superkernel' . __LINE__  ) ;

	# say "Removed redundant args from superkernel";

	# To remove the redundant args from the called subroutines, all we need to do is
	#   - In every called sub for my $csub (@call_sequence) {}
	#  	- from the  argument list of each kernel : $annlines, but also from Args to DeclaredOrigLocalVars
	#  	- remove the intents from the declarations : $annlines, but also from DeclaredOrigLocalVars
		for my $csub_info (@call_sequence) {
			my $csub = $csub_info->{'Name'};
			# The DeclaredOrigArgs need to be DeclaredOrigLocalVars
			for my $arg (@{$in_args_to_remove->{'List'}}) {
				if (exists $stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{$arg}) {
					# say "$csub $arg becomes local";
					$stref->{'Subroutines'}{$csub}{'DeclaredOrigLocalVars'}{'Set'}{$arg} = dclone($stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{$arg});
					delete $stref->{'Subroutines'}{$csub}{'DeclaredOrigLocalVars'}{'Set'}{$arg}{'IODir'};
				}
			}
			$stref->{'Subroutines'}{$csub}{'DeclaredOrigLocalVars'}{'List'} = [sort keys %{ $stref->{'Subroutines'}{$csub}{'DeclaredOrigLocalVars'}{'Set'} }];
			$stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}  = remove_vars_from_ordered_set($stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}, $in_args_to_remove->{'List'});
			
			# This is a bit inefficient because we redefine the lambda for every $csub, but this way it will capture $csub
			my $pass_remove_redundant_args_in_called_subs = sub { (my $annline)=@_;
				(my $line,my $info)=@{$annline};
				if (exists $info->{'Signature'} ) {
					$info->{'Signature'}{'Args'} = remove_vars_from_ordered_set($info->{'Signature'}{'Args'}, $in_args_to_remove->{'List'});
					(my $rline, $info) = emit_subroutine_sig( [$line, $info]);
					# say "$csub: $rline";
					$annline = [$rline, $info];
				}			
				elsif (exists $info->{'VarDecl'} ) {
					my $var = $info->{'VarDecl'}{'Name'};
					if (exists $in_args_to_remove->{'Set'}{$var}) {
						my $decl=$stref->{'Subroutines'}{$csub}{'DeclaredOrigLocalVars'}{'Set'}{$var};
						my $rline = emit_f95_var_decl($decl);
						# say "$csub: $rline";
						$annline = [$rline, $info];
					}
				}
				return ([$annline]);
			};
				
			$stref = stateless_pass_inplace($stref,$csub,$pass_remove_redundant_args_in_called_subs,'pass_remove_redundant_args_in_called_subs' . __LINE__  ) ;				
		}

		# So at this point we have removed all redundant args.
		# On to fixing IODir 		
		# If an argument of a called subroutine is an In arg of the kernel, it could be used as an InOut in a called sub
		#	If the current sub modifies it (NOT read_only; otherwise it must be In)
		#	AND a later sub uses it as an In or InOut (i.e. read_only OR read_before_written)		

		# If an argument of a called subroutine is an Out argument of the kernel, we can check if it is used as an Out or as an InOut. It could be InOut if a previous sub modified it
		# 	If written_before_read => Out, regardless of what the kernel arg IODir is
		# 	If read_before_written => InOut 
		# 	If read_only => In. If it would be an Out at toplevel, that would be an error, toplevel should then be InOut

		# If an argument of a called subroutine is an InOut argument of the kernel, we can still check: 
		# if it is used as an Out or as an InOut in a called sub (i.e. written to):
		# 	- If it would turn out no called sub uses it as an In, we should make it an Out
		# 	- If it is used as an Out in a called subroutine before being used as an In, then should make it an Out
		#	- If it would turn out no called sub uses it as an Out, we should make it an In
		
# For every argument and every called subroutine, let's see what we can learn
		my $iodir_for_arg_in_called_sub={};
		# First determine the context-free IODir for all arguments in every called subroutine
		for my $csub_info (@call_sequence) {
			my $csub = $csub_info->{'Name'};

			for my $arg ( @{$stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'List'}}) {
				my $_arg_idx=0;
				if (not defined $arg) {
					carp "Undefined arg in position $_arg_idx in DeclaredOrigArgs for $f";
				}					
				$iodir_for_arg_in_called_sub->{$csub}{$arg} = __determine_called_sub_arg_iodir_no_context($arg, $stref, $csub);
				++$_arg_idx;
			}
		}
		# Now that we have the context-free IODir for all args  in every called sub we can refine
		my $top_iodir={};		
		my $changed_iodirs={};		
		
		for my $arg ( @{$stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'List'}} ) {
			my $_arg_idx=0;
			if (not defined $arg) {
				carp "Undefined arg in position $_arg_idx in DeclaredOrigArgs for $f";
			}					

			$top_iodir->{$arg} = $stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
			# First determine the context-free IODir for all arguments in every called subroutine
			my $idx=0;
			my $first_use=0;
			for my $csub_info (@call_sequence) {
				my $csub = $csub_info->{'Name'};
			
				$changed_iodirs->{$csub}={} unless exists $changed_iodirs->{$csub};
				if (exists $stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'Set'}{$arg}) {
					if ($first_use ==0 ) {
						$first_use=1;
						if ($iodir_for_arg_in_called_sub->{$csub}{$arg}  eq 'out' ) {
					# warn "WARNING: Toplevel INTENT for $arg changed from INOUT to OUT because first use is OUT!\n" ;
					say "WARNING: Toplevel INTENT for $arg changed from INOUT to OUT because first use ($csub) is OUT!" if $W;
					$top_iodir->{$arg} = 'out';						
					
					last;
					} 		
					
				}

					($iodir_for_arg_in_called_sub->{$csub}{$arg}, $top_iodir->{$arg}) = __determine_called_sub_arg_iodir_w_context($arg, $stref, $csub, $top_iodir, $iodir_for_arg_in_called_sub,\@call_sequence, $idx);
					if (
						$stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'} ne $iodir_for_arg_in_called_sub->{$csub}{$arg}
					) {
						say "$csub: CHANGED INTENT for $arg: ",$stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'},' to ', $iodir_for_arg_in_called_sub->{$csub}{$arg} if $DBG;
						$changed_iodirs->{$csub}{$arg} = $iodir_for_arg_in_called_sub->{$csub}{$arg};
						$stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'} = $iodir_for_arg_in_called_sub->{$csub}{$arg};
					}
				}
				++$idx;
			}			
			if (
				$stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'} ne $top_iodir->{$arg}	
			){
				$changed_iodirs->{$f}{$arg} = $top_iodir->{$arg};
				say "TOP $f: CHANGED INTENT for $arg: ", $stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'},' to ', $top_iodir->{$arg} if $DBG;
				$stref->{'Subroutines'}{ $f }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'} = $top_iodir->{$arg};
			}
			++$_arg_idx;
		}

		# We don't really need to re-emit the annlines but I guess I'd better?

		for my $csub_info (@call_sequence) {
			my $csub = $csub_info->{'Name'};

			say "SUB: $csub" if $DBG;
			say 'Changed IODirs: ',Dumper $changed_iodirs->{$csub} if $DBG;
			# This is a bit inefficient because we redefine the lambda for every $csub, but this way it will capture $csub
			my $pass_update_iodirs_in_called_subs = sub { (my $annline)=@_;
				(my $line,my $info)=@{$annline};
				if (exists $info->{'VarDecl'} ) {
					my $var = $info->{'VarDecl'}{'Name'};
					if (exists $changed_iodirs->{$csub}{$var}) {
						my $decl=$stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{$var};
						my $rline = emit_f95_var_decl($decl);
						say "$csub: $rline"  if $DBG;
						$annline = [$rline, $info];
					}
				}
				return ([$annline]);
			};
				
			$stref = stateless_pass_inplace($stref,$csub,$pass_update_iodirs_in_called_subs,'pass_update_iodirs_in_called_subs' . __LINE__  ) ;				
		}

	} # if $f is the superkernel
	else {

	}
	
	return $stref;
} # END of remove_redundant_arguments_and_fix_intents

sub __check_written_before_read { my ($in_arg, $stref, $f)=@_;

	my $reads_writes=__check_reads_writes($in_arg, $stref, $f);

	my $written_before_read = 0;
	for my $rw (@{$reads_writes}) {
		if ($rw eq 'w') {
			$written_before_read=1;
		}
		last;
	}
	return $written_before_read;
} # END of __check_written_before_read


sub __check_read_before_written { my ($in_arg, $stref, $f)=@_;

	my $reads_writes=__check_reads_writes($in_arg, $stref, $f);
 	
	my $read_before_written = 0;
	for my $rw (@{$reads_writes}) {
		if ($rw eq 'r') {
			$read_before_written=1;
		}
		last;
	}
	return $read_before_written;
} # END of __check_read_before_written

sub __check_read_only { my ($in_arg, $stref, $f)=@_;

	my $reads_writes=__check_reads_writes($in_arg, $stref, $f);

	my $read_only = 1;
	for my $rw (@{$reads_writes}) {
		if ($rw eq 'w') {
			$read_only=0;
			last;
		}		
	}
	return $read_only;
} # END of __check_read_only


sub __check_reads_writes {  my ($arg, $stref, $f)=@_;

# In practice we will not have IO calls in the kernels
# Nor will we have subroutines calls
# Function calls on RHS are OK 
# So all we need to check is Assignments, If, Do and Case
# As per the F95 spec, CaseVals are constants
my $pass_check_reads_writes = sub { (my $annline, my $reads_writes)=@_;
		(my $line,my $info)=@{$annline};
		
		if (exists $info->{'Assignment'} ) { 			
			
			if (exists $info->{'Rhs'}{'Vars'}{'Set'}{$arg
				}) {
					 # $arg is Read 
					 push @{$reads_writes},'r';
				 }
			if ($info->{'Lhs'}{'VarName'} eq $arg
			) {
					 # $arg is Written 
					 push @{$reads_writes},'w';
			}
		}	
		elsif (exists $info->{'If'} ) { 			
			if (exists $info->{'Cond'}{'Vars'}{'Set'}{$arg
		}) {
				# $arg is Read  
				push @{$reads_writes},'r';
			}
		}			
		elsif (exists $info->{'CaseVar'} ) { 			
			if ($info->{'CaseVar'} eq $arg) {					 
				# $arg is Read  
				push @{$reads_writes},'r';
			}
		}			
		elsif (exists $info->{'Do'} ) { 			
			if (scalar @{$info->{'Do'}{'Range'}{'Vars'}}>0 ) {
				for my $var (@{$info->{'Do'}{'Range'}{'Vars'}}) {
					if ($arg eq $var) {
						# $arg is Read  
						push @{$reads_writes},'r';
					}
				}
			}
		}			

		return ([$annline],$reads_writes);
	};
	
	my $reads_writes=[]; # sequence of 'r' and 'w'. And yes, I could use 0/1
 	($stref,$reads_writes) = stateful_pass_inplace($stref,$f,$pass_check_reads_writes, $reads_writes,'pass_check_reads_writes' . __LINE__  ) ;
	 return $reads_writes;
} # END of __check_reads_writes




# This is the context-free IODir. We store this in	$iodir_for_arg_in_called_sub
# Then we can look at the context (top_iodir and iodirs of other called subs) to refine.
sub __determine_called_sub_arg_iodir_no_context { my ($arg, $stref, $csub)=@_;

	my $iodir='UNKNOWN';
	if (__check_written_before_read($arg, $stref, $csub)) {
		$iodir = 'out';
	}
	elsif ( __check_read_only($arg, $stref, $csub)) {		
		$iodir = 'in';
	}
	elsif (__check_read_before_written($arg, $stref, $csub)) {
		$iodir = 'inout';
	}		
	return $iodir;

} # END of __determine_called_sub_arg_iodir_no_context

sub __determine_called_sub_arg_iodir_w_context { my ($arg, $stref, $csub, $iodir_for_top_arg,$iodir_for_arg_in_called_sub,$call_sequence, $cs_idx)=@_;
	my $iodir=$iodir_for_arg_in_called_sub->{$csub}{$arg};
	my $top_iodir=$iodir_for_top_arg->{$arg};
	# carp "$csub $arg $top_iodir ($iodir) ".Dumper($call_sequence);
	# local $W=1;
	# If an argument of a called subroutine is an In arg of the kernel, it could be used as an InOut in a called sub
	#	If the current sub modifies it (not In; it could be Out)
	#	AND a later sub uses it as an In or InOut (i.e. read_only OR read_before_written)	
	# 	otherwise  (i.e. this is a toplevel In only used in this sub)
	#		if  InOut => In : the modified result is unused (I guess this means we should remove this assignment!)
	#		if  written_before_read => It should be a local, will not happen as that was done in the previous pass

	if ($top_iodir eq 'in') {
		if ($iodir ne 'in' ) {
			# Check if this arg is 'in' or 'inout' in any of the later called subs
			my $arg_is_read_later=0;
			# warn $cs_idx+1 ,'..', scalar @{$call_sequence} - 1;
			for my $idx ($cs_idx+1 .. scalar @{$call_sequence} - 1) {
				
				my $lcsub_info = $call_sequence->[$idx];
				my $lcsub=$lcsub_info->{'Name'};
				
				if (
					exists $iodir_for_arg_in_called_sub->{$lcsub}{$arg} and
					$iodir_for_arg_in_called_sub->{$lcsub}{$arg} ne 'out'
				) {
					# carp "ARG IS READ IN $lcsub";
					$arg_is_read_later=1;
					last;
				}
			}
			if ($arg_is_read_later) {
				$iodir = 'inout';
			} elsif ($iodir eq 'inout') {
				$iodir = 'in';
			}
		} 
	}
	# If an argument of a called subroutine is an Out argument of the kernel, we can check if it is used as an Out or as an InOut. It could be InOut if a previous sub modified it
	# 	If Out, stays Out
	# 	If InOut , stays InOut
	# 	If In => either it was Out or InOut for a previous called sub, else toplevel IODir should then be InOut 
	elsif ($top_iodir eq 'out') {
		if ($iodir eq 'in') {
			my $arg_was_written_earlier=0;
			for my $idx (0 .. $cs_idx-1 ) {
				my $pcsub_info = $call_sequence->[$idx];
				my $pcsub = $pcsub_info->{'Name'};
				if (
					exists $iodir_for_arg_in_called_sub->{$pcsub}{$arg} and
					$iodir_for_arg_in_called_sub->{$pcsub}{$arg} ne 'in'
				) {
					$arg_was_written_earlier=1;
					last;
				}
			}
			if (not $arg_was_written_earlier) {
				say "WARNING: Toplevel INTENT for $arg changed from OUT to INOUT because of use as IN in $csub!" if $W;
				$top_iodir = 'inout';
			}
		}
	}
	# If an argument of a called subroutine is an InOut argument of the kernel, we can still check if it is used as an Out or as an InOut in a called sub
	# 	If it would turn out a called sub uses it as an Out and after that none as In, we should make it an Out => In means read_only
	# 	If it would turn out no called sub uses it as an In, we should make it an Out => In means read_only
	# 	If it would turn out no called sub uses it as an Out, we should make it an In => Out means written_before_read	
	# in in in ... in => In
	# out out out ... out  => Out
	# out ... whatever ... => Out
	# in out ... => InOut
	elsif ($top_iodir eq 'inout') {
		my $used_as_in = 0;
		my $used_as_out = 0;
		for my $ccsub_info (@{$call_sequence}) {
			my $ccsub = $ccsub_info->{'Name'};
			# warn "$ccsub $arg ".Dumper($iodir_for_arg_in_called_sub->{$ccsub}{$arg});
			if (
					exists $iodir_for_arg_in_called_sub->{$ccsub}{$arg} 
			) {
				# warn "ARG: $arg ".$top_iodir ."; $csub: $iodir ; $ccsub: ".$iodir_for_arg_in_called_sub->{$ccsub}{$arg}."\n";
				if ($iodir_for_arg_in_called_sub->{$ccsub}{$arg} eq 'in'
				or $iodir_for_arg_in_called_sub->{$ccsub}{$arg} eq 'inout'
				) {
					$used_as_in=1;
				}
				if ($iodir_for_arg_in_called_sub->{$ccsub}{$arg} eq 'out'
				or $iodir_for_arg_in_called_sub->{$ccsub}{$arg} eq 'inout'
				) {
					$used_as_out=1;
				}					
			}	

		}
		if (not $used_as_in) {
			say "WARNING: Toplevel INTENT for $arg changed from INOUT to OUT because never used as IN!" if $W;
			$top_iodir = 'out';
		}
		elsif (not $used_as_out) {
			say "WARNING: Toplevel INTENT for $arg changed from INOUT to IN because never used as OUT!" if $W;
			$top_iodir = 'in';
		}
	}
# warn "FIXES CONTEXT $csub $arg $iodir ". $iodir_for_arg_in_called_sub->{$csub}{$arg} if $arg=~/avg/;
	return ($iodir, $top_iodir);
} # END of __determine_called_sub_arg_iodir_w_context



1;

