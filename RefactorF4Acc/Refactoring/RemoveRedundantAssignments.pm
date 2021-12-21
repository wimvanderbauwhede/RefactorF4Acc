package RefactorF4Acc::Refactoring::RemoveRedundantAssignments;

use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( init last_ foldl null head fst snd );
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
	&remove_redundant_assignments
);

# ================================================================================================================================================
# Better dead code elimination:

# - AssignedVars and ExprVars keep a list of the line numbers 
# - For every assigned local var, if it is used before the next assignment OR before the end of the code unit, we need to keep the assignment.

# v = 1
# w = v
# v = 2
# => keep all
# write_line_id = 1
# next_write_line_id = 3
# read_line_id = 2

# v = 1
# v = v+1
# w = v
# v = 2
# => keep all
# write_line_id = 1
# next_write_line_id = 2
# read_line_id = 2


# v = 1
# w = v
# v = v+2
# => keep first two if w is used later and last if v is used later or Out/InOut arg
# write_line_id = 1
# next_write_line_id = 3
# read_line_id = 2

# v = 1
# v = 2
# => last if used later or Out/InOut arg so REMOVE
# write_line_id = 1
# next_write_line_id = 2
# read_line_id = -1

# v = v+1
# v = 2
# => last if used later or Out/InOut arg so REMOVE
# write_line_id = 1
# next_write_line_id = 2
# read_line_id = 1

# v = 1
# v = v+2
# => keep all

# write_line_id = 1
# next_write_line_id = 2
# read_line_id = 2



# - We also need to distinguish Args between In, Out and InOut. 
#	- See if we can get this from $info, else look up
# - For In args: only assignments followed by a read before the next assignment OR the end of the code unit are kept. So this is the same as a local variable
# - For Out args: 
#	- any read before an assignment is actually an error; 
#	- any assignment followed by an assignment without a read in between can be removed. 
# - The difference with a local var and In is that a final assignment is kept

sub remove_redundant_assignments { (my $stref, my $f)=@_;
	my $Sf = $stref->{'Subroutines'}{$f};
	# If a variable is assigned but is not and arg and does not occur in any RHS or SubroutineCall, it is unused. 
	# If a variable is declared but not used in any LHS, RHS  or SubroutineCall, it is unused.
	my $annlines_1 = get_annotated_sourcelines($stref,$f);
    # local $Data::Dumper::Indent = 0;
    # local $Data::Dumper::Terse  = 1;
    # $Data::Dumper::Deepcopy = 1;
	# ----------------------------------------------------------------------------------------------------
# The stack tells us about the nesting of the ifs
# The seq is a list of the blocks (if, elsif, else) in an if-statement
# The blocks are numbered using a running counter
# I renumber the LineIDs to make sure they are contiguous
# Seq will be used to identify if statements that are effectively expressions, 
# i.e. they every var is assigned in every branch (TODO)
	say "\nmark_if_blocks\n" if $DBG;

	my $pass_action_mark_if_blocks = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		my $counter = $state->{'Counter'};# 0;
		my @stack = @{$state->{'Stack'}};#();
		my $blockid='UNKNOWN';
		my $current_blockid=$state->{'CurrentBlockID'};# 0;
		my @seq  = @{$state->{'Branches'}};

		$info->{'LineID'} = ++$state->{'LineCounter'};

		if (exists $info->{'IfThen'} and not exists $info->{'ElseIf'}) {
			
			push @stack,  $current_blockid; #$counter;
			# say $line.' PUSH STACK:' .Dumper( \@stack);			
			++$counter;
			push @{$seq[$stack[-1]]}, $counter;
			# say $line.' PUSH SEQ: '.$stack[-1]. ':' .Dumper( $seq[$stack[-1]]);
			$blockid=$counter;
			push @{$state->{'IfBlocks'}{$current_blockid}{'Children'}},$blockid;
			$current_blockid=$counter;
			$state->{'IfBlocks'}{$blockid}{'StartLineID'}=$info->{'LineID'};
			$state->{'IfBlocks'}{$blockid}{'Children'}=[];
		}
		elsif (exists $info->{'Else'} or exists $info->{'ElseIf'}) {
			++$counter;
			$blockid=$counter;	
			$current_blockid=$counter;
			# say ' ELSE: STACK:' .Dumper( \@stack);
			# say ' ELSE: SEQ:' .Dumper( \@seq);	
			my $if_blockid = $seq[$stack[-1]][-1];
			# say "$line PREV BLOCK ID: $if_blockid";
			push @{$seq[$stack[-1]]}, $counter;			
			# say ' ELSE: SEQ:' .Dumper( \@seq);
			# my $if_blockid = $stack[0]+1; # Assuming the stack contains the current blocks as first elt, and its count was incremented after the push
			
			$state->{'IfBlocks'}{$if_blockid}{'EndLineID'}=$info->{'LineID'};
			$state->{'IfBlocks'}{$blockid}{'StartLineID'}=$info->{'LineID'};
			$state->{'IfBlocks'}{$blockid}{'Children'}=[];
		}
		elsif (exists $info->{'EndIf'}) {
			say 'ENDIF: SEQ:' .Dumper( $seq[$stack[-1]]);
			for my $seq_block_id (@{$seq[$stack[-1]]}) {
				$state->{'IfBlocks'}{$seq_block_id}{'Branches'} = dclone($seq[$stack[-1]]);
			}
			# say 'ENDIF: STACK:' .Dumper( \@stack);
			my $cur_blockid = $seq[$stack[-1]][-1];
			my $encl_blockid = pop @stack;
			# say $line.' POP STACK:' .Dumper( \@stack);
			# say 'CURRENT BLOCK:' .$cur_blockid;
			# say 'ENCLOSING BLOCK:' .$encl_blockid;
			$blockid = $cur_blockid;
			$state->{'IfBlocks'}{$cur_blockid}{'EndLineID'}=$info->{'LineID'};
			$seq[$encl_blockid]=[];
			$current_blockid = $encl_blockid;

		} else { # anything else, label it
			$blockid=$current_blockid;
		}
		$state->{'CurrentBlockID'}=$current_blockid;
		$info->{'IfBlockID'}=$blockid;
		$state->{'Counter'} = $counter ;
		$state->{'Stack'} = [@stack];
		$state->{'Branches'} = [@seq];
		# say 'LINE:' .$line.' SEQ:'.Dumper( \@seq);
		# say $line."\tCurrent: $current_blockid".' STACK: [' .join(',',@stack).']';
		return ([[$line,$info]],$state);
	};		

 	my $if_block_state ={
		'Counter'=> 0,
		'LineCounter'=> 0,
		'Stack'=>[],
		'Branches'=>[[]],
		'IfBlocks'=>{
			0=>{
				'Branches'=>[0],
				'Children'=>[],
			}
		},
		'CurrentBlockID'=>0
	};

	$if_block_state->{'IfBlocks'}{0}{'StartLineID'}=1;

	(my $annlines_2,$if_block_state) = stateful_pass($annlines_1 ,$pass_action_mark_if_blocks, $if_block_state,'_mark_if_blocks() ' . __LINE__  ) ;

	$if_block_state->{'IfBlocks'}{0}{'EndLineID'}= $if_block_state->{'LineCounter'};
# ----------------------------------------------------------------------------------------------------
	# All we need to keep from the $if_block_state is IfBlocks

	# This pass is purely for debugging

	if ($DBG) {
	say "\nshow_if_blocks\n";
	my $pass_action_show_if_blocks = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		my $if_block_id = $info->{'IfBlockID'};
		my $start = $state->{'IfBlocks'}{$if_block_id}{'StartLineID'}//'UNKNOWN';
		my $end = $state->{'IfBlocks'}{$if_block_id}{'EndLineID'}//'UNKNOWN';
		my $seq = join(',',@{$state->{'IfBlocks'}{$if_block_id}{'Branches'}});
		my $children = join(',',@{$state->{'IfBlocks'}{$if_block_id}{'Children'}});
		my $fid = substr($info->{'LineID'}.'    ',0,3);
		my $fline = substr($line.( ' ' x 100), 0,50);
		say "LINE: $fid\t$fline\tIfBlockID: ".$info->{'IfBlockID'}
		."\tStart: $start"
		."\tEnd: $end"
		."\tSeq: [$seq]"
		."\tChildren: [$children]";
		return ([[$line,$info]],$state);
	};		
 
	stateful_pass($annlines_1 ,$pass_action_show_if_blocks, $if_block_state,'_show_if_blocks() ' . __LINE__  ) ;	
	}
	# die;
# ----------------------------------------------------------------------------------------------------
	say "\npass_action_find_all_used_vars\n" if $DBG;
	# The algorithm is iterative, see below; but it would be better to have a separate pass for creating the lists

	# Step 1
	# Start with all declared variables, put in $state->{'DeclaredVars'}
	# Make a list of all variables anywhere in the code via Lhs, Rhs, Args, put in $state->{'ExprVars'}	
	my $pass_action_find_all_used_vars = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
		
		my $rline=$line;
		my $rlines=[];
		my $skip_if=0;
		my $done=0;
		
 		if ( exists $info->{'Signature'} ) {			 			 
 			$state->{'Args'} = $info->{'Signature'}{'Args'}{'Set'}; 			 
			$done=1;
 		}
 		elsif (exists $info->{'Select'})  {
 			my $select_expr_str = $info->{'CaseVar'}; 
 			my $select_expr_ast=parse_expression($select_expr_str, $info,{}, '');
 			my $vars = get_vars_from_expression($select_expr_ast,{});
 			for my $var (keys %{ $vars } ) {
 				$state->{'ExprVars'}{$var}{'Counter'}++;	
				push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
 			}
			 $done=1;
 		} 		
		elsif (exists $info->{'CaseVals'})  {
			for my $val (@{ $info->{'CaseVals'} }) {
				if ($val=~/^[a-z]\w*/) {
 					$state->{'ExprVars'}{$val}{'Counter'}++;	
					push @{$state->{'ExprVars'}{$val}{'LineIDs'}}, $info->{'LineID'};
 				} else  {
					my $case_expr_ast=parse_expression($val, $info,{}, '');
 					my $vars = get_vars_from_expression($case_expr_ast,{});
 					for my $var (keys %{ $vars } ) {
 						$state->{'ExprVars'}{$var}{'Counter'}++;	
						push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
 					}
 				}		
			}
			$done=1;
		}
		elsif ( exists $info->{'VarDecl'} ) {
			my $varname = $info->{'VarDecl'}{'Name'};
			# Add intent to Args
			my $subset = in_nested_set( $Sf, 'Args', $varname );
			if ($subset) {
                my $decl = get_var_record_from_set($Sf->{$subset},$varname);				
				$state->{'Args'}{$varname} = $decl->{'IODir'};
			}
			$state->{'DeclaredVars'}{ $varname }=1;
			# Now check also if the declaration does have any ExprVars
			if (exists $info->{'ParsedVarDecl'} and
				exists $info->{'ParsedVarDecl'}{'Attributes'} and
				exists $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} ) {
				for my $dim_str (@{$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}}) {
					my $dim_expr_ast=parse_expression($dim_str, $info,{}, '');
					my $vars = get_vars_from_expression($dim_expr_ast,{});
					for my $var (keys %{ $vars } ) {
 						$state->{'ExprVars'}{$var}{'Counter'}++;	
						push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
					}					
				}
			}										
			$done=1;
		}
		elsif ( exists $info->{'Assignment'}  ) { 
			my $var = $info->{'Lhs'}{'VarName'};
			# if (exists $state->{'UnusedVars'}{$var}) {				
			# 	say "REMOVED ASSIGNMENT $line in $f" if $DBG;
			# 	$annline=['! '.$line, {%{$info},'Deleted'=>1}];
			# 	delete $state->{'UnusedVars'}{$var};
			# 	delete $state->{'AssignedVars'}{$var};	
			# 	# Remove all vars in the LHS expr from ExprVars
			# 	if (exists $info->{'Lhs'}{'IndexVars'}) {
			# 		for my $idx_var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
 			# 			$state->{'ExprVars'}{$idx_var}{'Counter'}--;	
		 	# 			if ( $state->{'ExprVars'}{$idx_var}{'Counter'} == 0) {
		 	# 				delete $state->{'ExprVars'}{$idx_var};
		 	# 				carp "DELETE ExprVar $idx_var (LHS index var)"  if $DBG;
		 	# 			}	 						
 			# 		}
			# 	}
			# 	$skip_if=1;							
			# } else {
				say "ADDING $var to AssignedVars (line ".$info->{'LineID'}.")" if $DBG;
				$state->{'AssignedVars'}{$var}{'Counter'}++;				
				push @{$state->{'AssignedVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				my $if_block_id = $info->{'IfBlockID'};
				$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$var}{'Counter'}++;				
				push @{$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				my %index_vars=();
				if (exists $info->{'Lhs'}{'IndexVars'}) {
					for my $index_var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
						$index_vars{$index_var}=1;
 						$state->{'ExprVars'}{$index_var}{'Counter'}++;
						# say "VAR $index_var Counter ".$state->{'ExprVars'}{$index_var}{'Counter'};
						push @{$state->{'ExprVars'}{$index_var}{'LineIDs'}}, $info->{'LineID'};
 					}
				}

				# for my $var (keys %{$info->{'Rhs'}{'Vars'}{'Set'} }) {
 				# 		$state->{'ExprVars'}{$var}{'Counter'}++;	
				# 		push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				# 		say "ADDING RHS1 $var to ExprVars (line ".$info->{'LineID'}.")" if $DBG;
 				# 	}
					 
				# for my $var (keys %{  $info->{'Rhs'}{'Vars'}{'Set'} } ) {
				my $rhs_vars = _get_all_vars_from_assignment_rec($info->{'Rhs'}{'Vars'}{'Set'});
				for my $rhs_var (sort keys %{$rhs_vars}) {
					if (not exists $index_vars{$rhs_var}) {
						$state->{'ExprVars'}{$rhs_var}{'Counter'}++;	
						push @{$state->{'ExprVars'}{$rhs_var}{'LineIDs'}}, $info->{'LineID'};
						say "ADDING RHS $rhs_var to ExprVars (line ".$info->{'LineID'}.")" if $DBG;
					}
				}
				# }
			# }
			$done=1;
		}
		elsif ( exists $info->{'SubroutineCall'} ) {
			# TODO
			# If the intent is Out or InOut then it is an assignment			
			for my $var (keys %{ $info->{'SubroutineCall'}{'Args'}{'Set'} }) {
 				$state->{'ExprVars'}{$var}{'Counter'}++;	
				push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
			}			
			$done=1;
		}	
		elsif ( exists $info->{'Do'} ) {
			my $iter_var = $info->{'Do'}{'Iterator'};
			$state->{'AssignedVars'}{$iter_var}{'Counter'}++;
			push @{$state->{'AssignedVars'}{$iter_var}{'LineIDs'}}, $info->{'LineID'};
			my $if_block_id = $info->{'IfBlockID'};
			$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$iter_var}{'Counter'}++;
			push @{$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$iter_var}{'LineIDs'}}, $info->{'LineID'};			
			my @range_vars = @{$info->{'Do'}{'Range'}{'Vars'}};
			for my $var (@range_vars) {
				say "ADDING $var to ExprVars in DO" if $DBG;
 				$state->{'ExprVars'}{$var}{'Counter'}++;	
				push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
			}		
			$done=1;				
		}
		if ((exists $info->{'If'} or exists $info->{'ElseIf'})
			and not $skip_if) {						
			my $cond_expr_ast=$info->{'Cond'}{'AST'};
			for my $var (keys %{ $info->{'Cond'}{'Vars'}{'Set'} }) {
				say "ADDING $var to ExprVars in IF (line ".$info->{'LineID'}.")" if $DBG;
 				$state->{'ExprVars'}{$var}{'Counter'}++;	
				push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
			}						
			for my $var ( @{ $info->{'Cond'}{'Vars'}{'List'} } ) {					
				if (exists  $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'}
				and scalar keys %{ $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'} } > 0
				) {								
					for my $index_var (keys %{ $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'} }) {
						$state->{'ExprVars'}{$index_var}{'Counter'}++;	
						push @{$state->{'ExprVars'}{$index_var}{'LineIDs'}}, $info->{'LineID'};
						say "ADDING index var $index_var to ExprVars in IF (line ".$info->{'LineID'}.")" if $DBG;
					}
				}				
			}
			$done=1;
		}
		if (exists $info->{'HasVars'} and $info->{'HasVars'} == 1 and $done==0) {
			if ($DBG) {
				croak "remove_redundant_assignments: Line <$line> NOT ANALYSED! ".Dumper($info) 
			} else {
				warning( "remove_redundant_assignments: Line <$line> NOT ANALYSED! ");
			}
		}
		# say "LINE: $line ".Dumper($state->{'ExprVars'}{'global_id'});
		return ([$annline],$state);
	}; # END of pass_action_find_all_used_vars

# DeclaredVars: from declarations in the code unit
# UndeclaredVars: currently unused. 
# Args: code unit arguments
# AssignedVars: Variables on the LHS (TODO or In/InOut in a function or subroutine)
# UnusedDeclaredVars: declared but unused, used to removed such declarations
# UnusedVars: any var assigned to but not used as arg or in an expression

	my $state= {
		'DeclaredVars'=>{},
		'UndeclaredVars'=>{},
		'ExprVars'=>{},
		'AssignedVars'=>{},
		'Args'=>{},
		'UnusedVars'=>{},
		'UnusedDeclaredVars'=>{},
		'UnusedLines' =>{}
	};

	$state->{'IfBlocks'} = $if_block_state->{'IfBlocks'};
	(my $annlines_3,$state) = stateful_pass($annlines_2,$pass_action_find_all_used_vars, $state,'_find_all_used_variables() ' . __LINE__  ) ;
	# die;
	# die Dumper $state;
# ----------------------------------------------------------------------------------------------------
# This step removes variables that are entirely unused, i.e. assigned but never read	
	say "\npass_action_remove_unused_vars\n" if $DBG;
	my $pass_action_remove_unused_vars = sub { (my $annline, my $state)=@_;		
		(my $line,my $info)=@{$annline};
				
		if ( exists $info->{'Assignment'}  ) { 
			my $var = $info->{'Lhs'}{'VarName'};
			if (exists $state->{'UnusedVars'}{$var}) {				
				say "REMOVED ASSIGNMENT $line in $f" if $DBG;
				$annline=['! '.$line, {%{$info},'Deleted'=>1}];
				delete $state->{'UnusedVars'}{$var};
				delete $state->{'AssignedVars'}{$var};	
				# Remove all vars in the LHS expr from ExprVars
				if (exists $info->{'Lhs'}{'IndexVars'}) {
					for my $idx_var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
 						$state->{'ExprVars'}{$idx_var}{'Counter'}--;	
		 				if ( $state->{'ExprVars'}{$idx_var}{'Counter'} == 0) {
		 					delete $state->{'ExprVars'}{$idx_var};
		 					carp "DELETE ExprVar $idx_var (LHS index var)"  if $DBG;
		 				}	 						
 					}
				}		
			} 
		}
		# elsif ( exists $info->{'SubroutineCall'} ) {
		# 	# TODO
		# 	# If the intent is Out or InOut then it is an assignment			
		# 	for my $var (keys %{ $info->{'SubroutineCall'}{'Args'}{'Set'} }) {
 		# 		$state->{'ExprVars'}{$var}{'Counter'}++;	
		# 		push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
		# 	}			
		# 	$done=1;
		# }	

		return ([$annline],$state);
	}; # END of pass_action_remove_unused_vars

	my $dbg_ctr=-1;
	do {
		# $state->{ExprVars}={};
		# $state->{AssignedVars}={};
        # The pass finds ExprVars and AssignedVars
 		($annlines_3,$state) = stateful_pass($annlines_3,$pass_action_remove_unused_vars, $state,'_remove_all_unused_variables() ' . __LINE__  ) ;
# ----------------------------------------------------------------------------------------------------
	# Step 2
 	# Once we have these lists, we can now check if there are any variables that occur on an Lhs an are not used anywhere
 	# We simply check for every AssignedVar if it is used as an ExprVar or as an Arg 	
		
	 	for my $var (keys %{ $state->{'AssignedVars'} }) {
	 		if (not exists $state->{'ExprVars'}{$var} and not exists $state->{'Args'}{$var}) {
	 			say "VAR $var is unused in $f" if $DBG;
	 			$state->{'UnusedVars'}{$var}=1;
	 		} 
	 	}		 
	} until scalar keys %{ $state->{'UnusedVars'} } ==0 or --$dbg_ctr==0; 
	# die Dumper($state);
# ----------------------------------------------------------------------------------------------------	
	# This step removes writes to variables that are not subsequently read. 
	say "\nremove writes to variables that are not subsequently read\n" if $DBG;

    my $if_statements = _convert_if_statement_datastructure($state, 0);     
    my $if_statements_as_tree = append_subtree_to_children_and_fold( {}, [$if_statements]);
    my $paths_tup = list_all_paths($if_statements_as_tree->{'branches'}, [],[]);
    my $all_paths = snd($paths_tup);
    # die;
	die Dumper $all_paths;# $if_statements_as_tree;

	for my $block_id ( sort keys %{ $state->{'IfBlocks'} } ) {				
		for my $var (sort keys %{ $state->{'IfBlocks'}{$block_id}{'AssignedVars'} }) {
			# for my $child_block_id (@{$state->{'IfBlocks'}{$block_id}{'Children'}}) {
			# 	my $if_is_expr_for_var=_if_is_expr_for_var($state, $child_block_id, $var);
			# }
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
	
} # END of remove_redundant_assignments()
# ================================================================================================================================================

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


# ================================================================================================================================================

=pod
 	my $state ={
		'IfBlocks'=>{
			$block_id => {
				'Branches'=>[$branch_id,...],
				'Children'=>[$child_block_id,...],
			}
		},
	};

To have a structure more like the Haskell one:

my $if_statement = {
    'branches' => 
    [
        {
            'branchId' => $int,        
            'children' => [$if_statement,...]
        }, ...
    ]
}
=cut


	# sub _if_is_expr_for_var { my ($state, $block_id, $var) = @_;
	# 	if (exists $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var} ) {
	# 		for my $seq_id (@{$state->{'IfBlocks'}{$block_id}{'Branches'}} ) {
	# 			next if $seq_id ==  $block_id;
	# 			if (not exists $state->{'IfBlocks'}{$seq_id}{'AssignedVars'}{$var}) {
	# 				return 0
	# 			}
	# 		}			
	# 		say "BLOCK $block_id:".' IF IS EXPR FOR '.$var if $DBG;
	# 		return 1;
	# 	} else {
	# 		return 0
	# 	}
	# }

# sub _traverse_if_statement {my ($state, $st_id) = @_; 
# 	my $seq = $state->{'IfBlocks'}{$st_id}{'Branches'}; 
# 	my $branches = [];
# 	for my $b_id ( @{$seq}) {
# 		my $children = [];
# 		if (scalar  @{$state->{'IfBlocks'}{$b_id}{'Children'}} > 0 ) {
# 			for my $ch_id ( @{$state->{'IfBlocks'}{$b_id}{'Children'}}) {
# 				push @{ $children }, _traverse_if_statement($state, $ch_id);
# 			}
# 		} 
# 		push @{$branches},{
# 			'branchId' => $b_id,
# 			'children' => $children
# 		}            
# 	}
# 	return {
# 		'branches' => $branches
# 	}
# }

sub _convert_if_statement_datastructure {my ($state, $st_id) = @_; 
    my $seq = $state->{'IfBlocks'}{$st_id}{'Branches'}; 
    my $branches = [];
    for my $b_id ( @{$seq}) {
        my $children = [];
        if (scalar  @{$state->{'IfBlocks'}{$b_id}{'Children'}} > 0 ) {
            for my $ch_id ( @{$state->{'IfBlocks'}{$b_id}{'Children'}}) {
                push @{ $children }, _convert_if_statement_datastructure($state, $ch_id);
            }
        } 
        push @{$branches},{
            'branchId' => $b_id,
            'children' => $children
        }            
    }
    return {
        'branches' => $branches
    }
}


=pod
- If there are no children, the subtree becomes the child
- If there is one child, append the subtree to it with append_subtree_to_child
- If there are multiple children, do append the subtree to the last child
    That is the new subtree, append it to the next child etc., using append_subtree_to_children_and_fold
=cut
# append_subtree_to_branch :: IfStatement -> Branch -> Branch
sub append_subtree_to_branch { my ($s, $b) = @_;
    my @children = @{$b->{'children'}};
    if (null(\@children)) {
        $b->{'children'}=[$s];
    } 
    elsif (scalar @children == 1 ) {
            my $c = $children[0];
            my $c_ = append_subtree_to_child( $s, $c);
            $b->{'children'}=[$c_];        
    } else {
            my $c_ = append_subtree_to_children_and_fold($s,\@children);
            $b->{'children'}=[$c_];        
    }
    return $b;
}


# Append s to all terminals of c, just a map over append_subtree_to_branch
# append_subtree_to_child :: IfStatement -> IfStatement -> IfStatement
sub append_subtree_to_child { my ($s,$c) = @_;
        my @branches_ = map {append_subtree_to_branch($s,$_)} @{$c->{'branches'}};
        $c->{'branches'} = \@branches_;
        return $c;
}
=pod
If there is at least one child, call append_subtree_to_child and
call append_subtree_to_children_and_fold recursively
=cut      
# append_subtree_to_children_and_fold :: IfStatement -> [IfStatement] -> IfStatement
sub append_subtree_to_children_and_fold {my ($s,$cs) = @_; 
    if (null($cs)) { return $s
    } else {
            my $c_ = last_($cs);
            my $cs_ = init( $cs);
            my $s_ = append_subtree_to_child( $s, $c_);        
            append_subtree_to_children_and_fold( $s_ ,$cs_);
    }
}

=pod
So now a little traversal to list all paths
This was very tricky and it shouldn't have been
Why does I need init?

We accumulate the path to a leaf node by appending all branch ids
Then we append this to the path list, and continue with the path without the terminal id
to climb back up in the branch of the tree

But that is not enough, if we don't do 'init' of the returned path, we get repetition
=cut
# list_all_paths :: [Branch] -> ([Int],[[Int]]) -> ([Int],[[Int]])
sub list_all_paths { my ($bs, $path, $pathlist) = @_;
    my $p_pl_acc = foldl( sub { my ($p_pl, $b) = @_;
            # say Dumper $p_pl;
            my ($p,$pl) = @{$p_pl};         
            my $c = head(   $b->{'children'});
            my $bs_ =  $c->{'branches'}//[];
            my $p_=[@{$p}, $b->{'branchId'} ];
            # say 'PATH:',Dumper $p,$p_;
            if (null($bs_)) {
                 return [$p, [@{$pl},$p_]]; # p not p_ because we go back up
            } else {                    
                my $p__pl_ = list_all_paths( $bs_, $p_,$pl);
                my ($p__,$pl_) =@{$p__pl_};
                return [ init( $p__),$pl_]; # This 'init' is trial-and-error
            }
     }, [$path,$pathlist], $bs); 
     return $p_pl_acc;
}
=pod

This Haskell code is the solution to the key problem:
We turn the nested if statements into a tree and do a path traversal
That way we have every possible path through the code
So we can construct the sequences of assignments and reads from these paths.
We need to make ExprVars per-block like AssignedVars

module Main where

import Data.List (foldl')

data IfStatement = IfStatement {
    branches :: [Branch]
} deriving Show

data Branch = Branch {
    branchId :: Int,
    children :: [IfStatement]
} deriving Show

{-
- If there are no children, the subtree becomes the child
- If there is one child, append the subtree to it with append_subtree_to_child
- If there are multiple children, do append the subtree to the last child
    That is the new subtree, append it to the next child etc., using append_subtree_to_children_and_fold
-}
append_subtree_to_branch :: IfStatement -> Branch -> Branch
append_subtree_to_branch s b
    | null $ children b = b{children=[s]}
    | length (children b) == 1 = let
            c = head (children b)
            c' = append_subtree_to_child s c
        in
            b{children=[c']}
    | otherwise = let
            c' = append_subtree_to_children_and_fold s (children b) 
        in
            b{children=[c']}

-- Append s to all terminals of c, just a map over append_subtree_to_branch
append_subtree_to_child :: IfStatement -> IfStatement -> IfStatement
append_subtree_to_child s c = let
        branches' = map (append_subtree_to_branch s) (branches c)
    in
        c {
            branches = branches'
        }

{-
If there is at least one child, call append_subtree_to_child and
call append_subtree_to_children_and_fold recursively
-}        
append_subtree_to_children_and_fold :: IfStatement -> [IfStatement] -> IfStatement
append_subtree_to_children_and_fold s cs 
    | null cs = s
    | otherwise = let
            c' = last cs
            cs' = init cs
            s' = append_subtree_to_child s c'
        in
            append_subtree_to_children_and_fold s' cs'
            
{-
So now a little traversal to list all paths
This was very tricky and it shouldn't have been
Why does I need init?

We accumulate the path to a leaf node by appending all branch ids
Then we append this to the path list, and continue with the path without the terminal id
to climb back up in the branch of the tree

But that is not enough, if we don't do 'init' of the returned path, we get repetition

-}
list_all_paths :: [Branch] -> ([Int],[[Int]]) -> ([Int],[[Int]])
list_all_paths bs (path, pathlist) = 
    foldl' (\(p,pl) b -> 
        let
            c = head $ children b
            bs' = branches c
            p'=p++[branchId b]
        in
            if null bs'
                then (p, pl++[p']) -- p not p' because we go back up
                else
                    let
                        ( p'',pl') = list_all_paths bs' (p',pl)
                    in 
                        ( init p'',pl') -- This 'init' is trial-and-error
        ) (path,pathlist) bs        

--nested_if_nodata :: [(Int,[a])]
--This does not work, as we need a mutually recursive type
--but it shows how we could write it in Perl
-- nested_if_nodata = [
--    (0, [
--             [
--                 (1, []),
--                 (2, [ [ (3, []), (4, []) ] ]),
--                 (5, [])
--             ],
--             [
--                 (6, []),
--                 (7, [ [ (8, []) ] ])
--             ]
--        ]
--    )
--  ]

-- 0 1 6 7
-- 0 1 8 9
-- 0 1 8 10
-- 0 1 8 11
-- 0 2 3 6 7
-- 0 2 3 8 9
-- 0 2 3 8 10
-- 0 2 3 8 11
-- 0 2 4 6 7
-- 0 2 4 8 9
-- 0 2 4 8 10
-- 0 2 4 8 11
-- 
nested_if ::IfStatement 
nested_if = IfStatement [
        Branch 0 [
            IfStatement [
                Branch 1 [],
                Branch 2 [
                    IfStatement [
                        Branch 3 [],
                        Branch 4 []                        
                     ]
                 ],
                Branch 5 []
             ],
            IfStatement [
                Branch 6 [
                    IfStatement [
                        Branch 7 [
                            IfStatement [
                                Branch 8 [                                    
                                ]
                            ]        
                        ]
                    ]
                ],
                Branch 9 [
                    IfStatement [
                        Branch 10 [],
                        Branch 11 [],
                        Branch 12 []
                    ]
                ]
             ]
         ]
    ]

                        


main = do
    print nested_if
    let
        tree = append_subtree_to_children_and_fold (IfStatement True []) [nested_if]
        paths_tup = list_all_paths ( branches tree) ([],[])
    print (snd paths_tup)




=cut
1;

