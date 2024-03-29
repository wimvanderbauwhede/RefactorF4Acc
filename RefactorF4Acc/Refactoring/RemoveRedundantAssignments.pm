package RefactorF4Acc::Refactoring::RemoveRedundantAssignments;

use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( init last_ foldl null head fst snd union);
use RefactorF4Acc::Refactoring::Helpers qw(
	pass_wrapper_subs_in_module
	get_annotated_sourcelines
	stateful_pass
	);

use RefactorF4Acc::Parser::Expressions qw(
	parse_expression
	get_vars_from_expression
	);

#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.1";

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
	if (not exists $Config{'FIXES'}{'remove_redundant_assignments'}) { return $stref }
	my $Sf = $stref->{'Subroutines'}{$f};
	# If a variable is assigned but is not and arg and does not occur in any RHS or SubroutineCall, it is unused.
	# If a variable is declared but not used in any LHS, RHS  or SubroutineCall, it is unused.
	my $annlines_1 = get_annotated_sourcelines($stref,$f);
    # local $Data::Dumper::Indent = 0;
    # local $Data::Dumper::Terse  = 1;
    # $Data::Dumper::Deepcopy = 1;
	# ----------------------------------------------------------------------------------------------------
=pod
=head1 Step 1 Mark the C<if> blocks in the code unit


The Stack tells us about the nesting of the ifs
The Branches is a list of the blocks (if, elsif, else) in an if-statement
The blocks are numbered using a running counter
I renumber the LineIDs to make sure they are contiguous

The final data structure that matters is:

 	my $state = {
		'IfBlocks'=>{
			$block_id => {
				'Branches'=>[$branch_id,...],
				'Children'=>[$child_block_id,...],
				'StartLineId'=>$start_line_id,
				'EndLineId'=>$end_line_id
			}
		},
	};

=cut
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
			# say 'ENDIF: SEQ:' .Dumper( $seq[$stack[-1]]);
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
	open my $TMP,'>','tmp.txt';
	my $pass_action_show_if_blocks = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $if_block_id = $info->{'IfBlockID'};
		my $start = $state->{'IfBlocks'}{$if_block_id}{'StartLineID'}//'UNKNOWN';
		my $end = $state->{'IfBlocks'}{$if_block_id}{'EndLineID'}//'UNKNOWN';
		my $seq = join(',',@{$state->{'IfBlocks'}{$if_block_id}{'Branches'}});
		my $children = join(',',@{$state->{'IfBlocks'}{$if_block_id}{'Children'}});
		my $fid = substr($info->{'LineID'}.'    ',0,3);
		my $fline = substr($line.( ' ' x 150), 0,100);
		say "LINE: $fid\t$fline\tIfBlockID: ".$info->{'IfBlockID'}
		."\tStart: $start"
		."\tEnd: $end"
		."\tSeq: [$seq]"
		."\tChildren: [$children]";

		say $TMP "$fid\t$line";
		return ([[$line,$info]],$state);
	};

	stateful_pass($annlines_1 ,$pass_action_show_if_blocks, $if_block_state,'_show_if_blocks() ' . __LINE__  ) ;
	close $TMP;
	}


# ----------------------------------------------------------------------------------------------------
	say "\npass_action_find_all_used_vars\n" if $DBG;
=pod
=head1 Step 2 Find all used variables

	Start with all declared variables, put in $state->{'DeclaredVars'}
	Make a list of all variables anywhere in the code via Lhs, Rhs, Args, put in $state->{'ExprVars'}

 	my $state = {
		 'Args' => {
			$var_1 => $decl_1->{'IODir'} ,
			$var_2 => ...
		 }
		 'DeclaredVars' => {
			 $var_1 => 1,
			 $var_2 => ...
		 }
		 'AssignedVars' => {
			$var_1 => {
				'Counter' => $ctr,
				'LineIDs' => [$line_id_1,...]
			},
			$var_2 => ...
		 }
		 'ExprVars' => {
			$var_1 => {
				'Counter' => $ctr,
				'LineIDs' => [$line_id_1,...]
			},
			$var_2 => ...
		 },

				$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$var}{'Counter'}++;
				push @{$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
		'IfBlocks'=>{
			$block_id => {
				'Branches'=>[$branch_id,...],
				'Children'=>[$child_block_id,...],
				'StartLineId'=>$start_line_id,
				'EndLineId'=>$end_line_id,
				'AssignedVars' => {
					$var_1 => {
						'Counter' => $ctr,
						'LineIDs' => [$line_id_1,...]
					},
					$var_2 => ...
				},
				'ExprVars' => {
					$var_1 => {
						'Counter' => $ctr,
						'LineIDs' => [$line_id_1,...]
					},
					$var_2 => ...
				}
			}
		},
	};
=cut
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
 				# $state->{'ExprVars'}{$var}{'Counter'}++;
				# push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				$state = _add_var_to_state($var,$state,$info,'ExprVars');
 			}
			 $done=1;
 		}
		elsif (exists $info->{'CaseVals'})  {
			for my $tval (@{ $info->{'CaseVals'} }) {
				my @vals = ref($tval) eq 'ARRAY' ? @{$tval} : ( $tval ) ;
				for my $val (@vals) {
					if ($val=~/^[a-z]\w*/) {
						$state->{'ExprVars'}{$val}{'Counter'}++;
						push @{$state->{'ExprVars'}{$val}{'LineIDs'}}, $info->{'LineID'};
					} else  {
						my $case_expr_ast=parse_expression($val, $info,{}, '');
						my $vars = get_vars_from_expression($case_expr_ast,{});
						for my $var (keys %{ $vars } ) {
							# $state->{'ExprVars'}{$var}{'Counter'}++;
							# push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
							$state = _add_var_to_state($var,$state,$info,'ExprVars');
						}
					}
				}
			}
			$done=1;
		}
		elsif ( exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'}) {
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
 						# $state->{'ExprVars'}{$var}{'Counter'}++;
						# push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
						$state = _add_var_to_state($var,$state,$info,'ExprVars');
					}
				}
			}
			$done=1;
		}
		elsif ( exists $info->{'ParamDecl'}  ) {
			my $var = $info->{'ParamDecl'}{'Name'};
			say "ADDING $var to AssignedVars (line ".$info->{'LineID'}.")" if $DBG;
			$state = _add_var_to_state($var,$state,$info,'AssignedVars');
			if (exists $info->{'ParsedParDecl'} ) { ;
				if (exists $info->{'ParsedParDecl'}{'Attributes'} and
				exists $info->{'ParsedParDecl'}{'Attributes'}{'Dim'} ) {
					for my $dim_str (@{$info->{'ParsedParDecl'}{'Attributes'}{'Dim'}}) {
						my $dim_expr_ast=parse_expression($dim_str, $info,{}, '');
						my $vars = get_vars_from_expression($dim_expr_ast,{});
						for my $var (keys %{ $vars } ) {
							$state = _add_var_to_state($var,$state,$info,'ExprVars');
						}
					}
				}
				if (exists $info->{'ParsedParDecl'}{'Pars'} and
				exists $info->{'ParsedParDecl'}{'Pars'}{'Val'} ) {
					my $val_str = $info->{'ParsedParDecl'}{'Pars'}{'Val'};
						my $val_expr_ast=parse_expression($val_str, $info,{}, '');
						my $vars = get_vars_from_expression($val_expr_ast,{});
						for my $var (keys %{ $vars } ) {
							$state = _add_var_to_state($var,$state,$info,'ExprVars');
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
				# $state->{'AssignedVars'}{$var}{'Counter'}++;
				# push @{$state->{'AssignedVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				# my $if_block_id = $info->{'IfBlockID'};
				# $state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$var}{'Counter'}++;
				# push @{$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				$state = _add_var_to_state($var,$state,$info,'AssignedVars');
				my %index_vars=();
				if (exists $info->{'Lhs'}{'IndexVars'}) {
					for my $index_var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
						$index_vars{$index_var}=1;
 						# $state->{'ExprVars'}{$index_var}{'Counter'}++;
						# push @{$state->{'ExprVars'}{$index_var}{'LineIDs'}}, $info->{'LineID'};
						$state = _add_var_to_state($index_var,$state,$info,'ExprVars');
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
					# if (not exists $index_vars{$rhs_var}) {
						# $state->{'ExprVars'}{$rhs_var}{'Counter'}++;
						# push @{$state->{'ExprVars'}{$rhs_var}{'LineIDs'}}, $info->{'LineID'};
						$state = _add_var_to_state($rhs_var,$state,$info,'ExprVars');
						say "ADDING RHS $rhs_var to ExprVars (line ".$info->{'LineID'}.")" if $DBG;
					# }
				}
				# }
			# }
			$done=1;
		}
		elsif ( exists $info->{'SubroutineCall'} ) {
			# TODO
			# If the intent is Out or InOut then it is an assignment
			for my $var (keys %{ $info->{'SubroutineCall'}{'Args'}{'Set'} }) {
 				# $state->{'ExprVars'}{$var}{'Counter'}++;
				# push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				$state = _add_var_to_state($var,$state,$info,'ExprVars');
			}
			$done=1;
		}
		elsif ( exists $info->{'Do'} ) {
			my $iter_var = $info->{'Do'}{'Iterator'};
			# $state->{'AssignedVars'}{$iter_var}{'Counter'}++;
			# push @{$state->{'AssignedVars'}{$iter_var}{'LineIDs'}}, $info->{'LineID'};
			# my $if_block_id = $info->{'IfBlockID'};
			# $state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$iter_var}{'Counter'}++;
			# push @{$state->{'IfBlocks'}{$if_block_id}{'AssignedVars'}{$iter_var}{'LineIDs'}}, $info->{'LineID'};
			say "ADDING $iter_var to AssignedVars (line ".$info->{'LineID'}.")" if $DBG;
			$state = _add_var_to_state($iter_var,$state,$info,'AssignedVars');
			my @range_vars = @{$info->{'Do'}{'Range'}{'Vars'}};
			for my $var (@range_vars) {
				say "ADDING $var to ExprVars in DO" if $DBG;
 				# $state->{'ExprVars'}{$var}{'Counter'}++;
				# push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				$state = _add_var_to_state($var,$state,$info,'ExprVars');
			}
			$done=1;
		}
		if ((exists $info->{'If'} or exists $info->{'ElseIf'})
			and not $skip_if) {
			my $cond_expr_ast=$info->{'Cond'}{'AST'};
			for my $var (keys %{ $info->{'Cond'}{'Vars'}{'Set'} }) {
				say "ADDING $var to ExprVars in IF (line ".$info->{'LineID'}.")" if $DBG;
 				# $state->{'ExprVars'}{$var}{'Counter'}++;
				# push @{$state->{'ExprVars'}{$var}{'LineIDs'}}, $info->{'LineID'};
				$state = _add_var_to_state($var,$state,$info,'ExprVars');
			}
			for my $var ( @{ $info->{'Cond'}{'Vars'}{'List'} } ) {
				if (exists  $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'}
				and scalar keys %{ $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'} } > 0
				) {
					for my $index_var (keys %{ $info->{'Cond'}{'Vars'}{'Set'}{$var}{'IndexVars'} }) {
						# $state->{'ExprVars'}{$index_var}{'Counter'}++;
						# push @{$state->{'ExprVars'}{$index_var}{'LineIDs'}}, $info->{'LineID'};
						$state = _add_var_to_state($index_var,$state,$info,'ExprVars');
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
	# die show_annlines( $annlines_3);
# ----------------------------------------------------------------------------------------------------
=pod
=head1 Step 3: Remove variables that are entirely unused, i.e. assigned but never read. This is an iterative pass.
=cut
	say "\npass_action_remove_unused_vars\n" if $DBG;
	my $pass_action_remove_unused_vars = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};

		if ( exists $info->{'Assignment'}  ) {
			my $var = $info->{'Lhs'}{'VarName'};
			if (exists $state->{'UnusedVars'}{$var}
			or not exists $state->{'AssignedVars'}{$var} # If there are several, we need to mark all lines as deleted
			) {
				say "REMOVED ASSIGNMENT $line in $f" if $DBG;
				$annline=['! '.$line, {%{$info},'Deleted'=>1}];
				# delete $state->{'UnusedVars'}{$var};
				# delete $state->{'AssignedVars'}{$var};
				# # Delete in the IfBlocks too!
				# for my $block_id (sort keys %{$state->{'IfBlocks'}}) {
				# 	if (exists $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}) {
				# 		delete $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}
				# 	}
				# }
				$state = __delete_unused_AssignedVar_from_state($var,$state);
				# Remove all vars in the LHS expr from ExprVars
				if (exists $info->{'Lhs'}{'IndexVars'}) {
					for my $idx_var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
 						# $state->{'ExprVars'}{$idx_var}{'Counter'}--;
		 				if ( $state->{'ExprVars'}{$idx_var}{'Counter'} == 1) {
		 					# delete $state->{'ExprVars'}{$idx_var};
							 $state = __delete_unused_ExprVar_from_state($idx_var,$state);
		 					say "DELETE ExprVar $idx_var (LHS index var)"  if $DBG;
		 				} else {
						say "INDEX VAR $idx_var is still in use: ". $state->{'ExprVars'}{$idx_var}{'Counter'} if $DBG;
						# But we should remove that line from the LineIDs!
							$state = __remove_LineID($idx_var, $info->{'LineID'}, $state, 'ExprVars')
						}
 					}
				}
				my $rhs_vars = _get_all_vars_from_assignment_rec($info->{'Rhs'}{'Vars'}{'Set'});
				# say "RHS VARS for $var: ".Dumper($rhs_vars);
				for my $rhs_var (sort keys %{$rhs_vars}) {
					say "CTR for $rhs_var: ". $state->{'ExprVars'}{$rhs_var}{'Counter'};
					if ( $state->{'ExprVars'}{$rhs_var}{'Counter'} == 1) {
						# delete $state->{'ExprVars'}{$rhs_var};
						$state = __delete_unused_ExprVar_from_state($rhs_var,$state);
						say "DELETE ExprVar $rhs_var (RHS VAR line ".$info->{'LineID'}.")" if $DBG;
					} else {
						say "RHS VAR $rhs_var is still in use: ". $state->{'ExprVars'}{$rhs_var}{'Counter'} if $DBG;
						# But we should remove that line from the LineIDs!
						$state = __remove_LineID($rhs_var, $info->{'LineID'}, $state, 'ExprVars')
					}
				}
			}
		}
		elsif ( exists $info->{'ParamDecl'}  ) {
			my $var = $info->{'ParamDecl'}{'Name'};
			if (exists $state->{'UnusedVars'}{$var}) {
				say "REMOVED PARAM DECL $line in $f" if $DBG;
				$annline=['! '.$line, {%{$info},'Deleted'=>1}];
				# delete $state->{'UnusedVars'}{$var};
				# delete $state->{'AssignedVars'}{$var};
				$state = __delete_unused_AssignedVar_from_state($var,$state);
			}
		}
		elsif ( exists $info->{'Do'} ) {
			my $var = $info->{'Do'}{'Iterator'};
			# croak Dumper $state;
			if (exists $state->{'UnusedVars'}{$var}) {
				say "ASSIGNMENT TO DO ITERATOR $var, NOT REMOVING: $line in $f" if $DBG;
				# delete $state->{'UnusedVars'}{$var};
				# delete $state->{'AssignedVars'}{$var};
				$state = __delete_unused_AssignedVar_from_state($var,$state);
			}
			# $state->{'UnusedLines'}{$info->{'LineID'}}=1;
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
 		($annlines_3,$state) = stateful_pass($annlines_3,$pass_action_remove_unused_vars, $state,'_remove_all_unused_variables() ' . __LINE__  ) ;
 		# Check for every AssignedVar if it is used as an ExprVar or as an Arg

	 	for my $var (keys %{ $state->{'AssignedVars'} }) {
	 		if (not exists $state->{'ExprVars'}{$var} and not exists $state->{'Args'}{$var}) {
	 			say "VAR $var is unused in $f" if $DBG;
	 			$state->{'UnusedVars'}{$var}=1;
	 		}
	 	}
		#  say Dumper $state->{'UnusedVars'} if $DBG;
	} until scalar keys %{ $state->{'UnusedVars'} } ==0 or --$dbg_ctr==0;
	# die;# Dumper $state;
	# die show_annlines( $annlines_3);
# ----------------------------------------------------------------------------------------------------
	say "\nMark writes to variables that are not subsequently read for removal\n" if $DBG;
=pod
=head1 Step 4: Mark writes to variables that are not subsequently read for removal
This the most complex part because of the nesting and sequencing of if-statements
=cut
# Step 4a: Change to a more suitable datastructure
    my $if_statements = _convert_if_statement_datastructure($state, 0);
# Step 4b: Change that datastructure so that it becomes a tree, see explanation with the function
    my $if_statements_as_tree = append_subtree_to_children_and_fold( {}, [$if_statements]);
# Step 4c: Get all paths through the if blocks
    my $paths_tup = list_all_paths($if_statements_as_tree->{'branches'}, [],[]);
    my $all_paths = snd($paths_tup);
    # die;
	# die Dumper $all_paths;# $if_statements_as_tree;
=pod
	For every path through a conditional statement, we check which variables can be removed at which lines.
	Only lines that can be removed for all paths actually get removed

	What we need to do is create a list of the LineIDs for all AssignedVars and for all ExprVars
	Then we do _remove_or_keep based on these lists.


=cut
	# Step 4d: Determine assignment lines that can be removed and remove them

	my $ctr=0;
	my $unused_lines = -1;
	do {
		$ctr++;
		say '-' x 100 if $DBG;
		$unused_lines = scalar keys %{$state->{'UnusedLines'}};
		say $unused_lines if $DBG;#Dumper $state->{'UnusedDeclaredVars'};
	for my $var (sort keys %{ $state->{'AssignedVars'} }) {
		say "VAR $var " if $DBG;
		# Determine assignment lines that can be removed
		my $remove =_remove_or_keep_across_paths($var, $state, $all_paths);
		say Dumper $remove if $DBG;
		# We know which lines to remove, now remove them from $state
		$state = __remove_lines_from_state_for_var($var, $remove, $state);
	}
	# As a result of the removal of assignments, some ExprVars are removed too
	# If such a var becomes unused as a result, we can remove any assignments to that var from $state
	$state = __remove_lines_from_state_for_rhs_vars($state);
	# say Dumper ($state->{'UnusedLines'}, $state->{'UnusedDeclaredVars'});
	} until  $unused_lines == scalar keys %{$state->{'UnusedLines'}} ;
	# die ;#Dumper $state;

	# --------------------------------------------------------------------------------------------------------------------------------
	say "\ndelete_unused_lines\n" if $DBG;
=pod
	Step 5. Actually remove the lines from AnnLines
=cut
	# At this point we have a list of all lines to be removed. So now we should mark all these lines as Deleted
	# Then the stateful_pass will eliminate them automatically
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
	say "\nremove_decls\n" if $DBG;
=pod
	Step 5. Remove declarations of unused variables
=cut

 	# So now we have removed all assignments.
 	# Step 5a: Now we need to check which vars are declared but not used and remove those declarations.
 	for my $var (keys %{ $state->{'DeclaredVars'} }) {
 		if (not exists $state->{'ExprVars'}{$var}
 		and not exists $state->{'AssignedVars'}{$var}
		 ) {
 			say "VAR $var is declared but unused in $f" if $DBG;
 			$state->{'UnusedDeclaredVars'}{$var}=1;
 		}
 	}

 	# Step 5b: Now we remove these declarations

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
	# die show_annlines( $annlines_5);
	$stref->{'Subroutines'}{$f}{'RefactoredCode'} = $annlines_5;
	# die Dumper $state;
	return $stref;

} # END of remove_redundant_assignments()
# ================================================================================================================================================
sub __remove_or_keep { my ($var, $state) = @_;
	my $keep={};
	my $remove={};

	my $end_idx = scalar(@{ $state->{'AssignedVars'}{$var}{'LineIDs'} })-1;
	# Loop through the list of all lineIDs for a given $var
	for my $idx (0 .. $end_idx) {
		my $write_line_id = $state->{'AssignedVars'}{$var}{'LineIDs'}[$idx];
		if ($idx < $end_idx ) {
			my $next_write_line_id = $state->{'AssignedVars'}{$var}{'LineIDs'}[$idx+1];
			for my $read_line_id ( @{$state->{'ExprVars'}{$var}{'LineIDs'}} ) {
				if ($read_line_id>$write_line_id and $read_line_id<=$next_write_line_id) {
					say "KEEP assignment to $var at $write_line_id: $read_line_id>$write_line_id and $read_line_id<=$next_write_line_id" if $DBG;
					# $remove=0;
					$keep->{$write_line_id}=1;
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

	# $remove is a set of all LineIDs for $var
	$remove = { map {$_=>1} @{$state->{'AssignedVars'}{$var}{'LineIDs'}} };
	# Now we delete the LineIDs that will be kept
	for my $l_id (sort keys %{$keep}) {
		if (exists $remove->{$l_id}) {
			delete $remove->{$l_id};
		}
	}
	# The result is a set of LineIDs that can be removed for $var
	return ($remove,$keep);
} # END of __remove_or_keep

=pod

1: v=1
2: if
3: v=2
4: else
5: v=3
6: end if

=> paths: 0,1 and 0,2

Lists: 1,3 and 1,5
Result: 1 can be removed in both paths
{1=>0},{1=>0}

1:
2: if
3: v=2
4: else
5: v=3
6: end if
7: v=1

=> paths: 0,1 and 0,2
Lists: 3,7 and 5,7
Result:
In path [0,1] 3 can be removed {3=>1}
In path [0,2] 5 can be removed {5=>2}
The result *should* be that 3 and 5 are removed
The current result will be that nothing is removed

2: if
3: v=2
4: w=v
5: v=3
6: else
7: v=3
8: end if
9: v=1

The paths are [[3,5,9],[4]] and [[7,9],[]]
The first path results in
v=2
w=v
v=3
v=1
so 5 can be removed
The second path results in
7 can be removed

1: w=0
2: if
3: 	v=2
4: 	w=v
5: 	v=3
6: else
7: 	v=3
8: end if
9: v=1
10: z=w

So for w:
[1,4],[10]
[1],[10]
The result is that 1 can be removed in path 1, but not in path 2
which means we'd get
remove = {1} and keep = {1}
So the rule is:
- if a variable occurs in several paths, it must be removed in all of these paths
- in other words, if it is kept in a single path then we must keep it

So I think that we have: if a var line id is in remove for any path and not in keep for any path, it can be removed
So what we do is we go through all line ids and all paths

for my $line_id (@all_line_ids) {
	my $all_removes = fold union list_of_removes
	my $all_keeps = fold union list_of_keeps
	if (exists $all_removes->{$line_id} and not exists $all_keeps->{$line_id} ) {
		# $var can be removed
	}
}

There is still a problem with this:

if
	v1=1
	if
		v1=2
	end
	v1=3
	if
		v1=4
	end
end if

The path is [1,2,3]
But the

=cut


sub _remove_or_keep_across_paths { my ($var, $state, $paths) = @_;
	my $remove_per_path = [];
	my $keep_per_path = [];
	for my $path (@{$paths}) {
		my @assignedVarsLineIDs = ();
		my @exprVarsLineIDs = ();
		for my $block_id (@{$path}) {
			my @assignedVarsLineIDsBlock =
			exists $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}
			? @{$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'}}
			: () ;
			my @exprVarsLineIDsBlock =
			exists $state->{'IfBlocks'}{$block_id}{'ExprVars'}{$var}
			? @{$state->{'IfBlocks'}{$block_id}{'ExprVars'}{$var}{'LineIDs'}}
			: () ;
			@assignedVarsLineIDs = (@assignedVarsLineIDs,@assignedVarsLineIDsBlock);
			@exprVarsLineIDs = (@exprVarsLineIDs,@exprVarsLineIDsBlock);
		}
		# The sort here is necessary because the paths can be interleaved
		# e.g. a path [0,1,2,3] can actually be  [0, 1, 2, 1, 3, 1, 0]
		my $path_state ={
			'AssignedVars'=>{$var => { 'LineIDs' => [sort numeric @assignedVarsLineIDs] }},
			'ExprVars'=>{$var => { 'LineIDs' => [sort numeric @exprVarsLineIDs] }},
			'Args' => $state->{'Args'}
		};
		# say Dumper $path_state ;
		(my $remove, my $keep) = __remove_or_keep($var, $path_state);
		# die Dumper({'REMOVE'=>$remove,'KEEP'=> $keep}) if $var eq 'v1';
		push @{$remove_per_path},$remove;
		push @{$keep_per_path},$keep;
	}
	# die Dumper({'REMOVE'=>$remove_per_path,'KEEP'=> $keep_per_path}) if $var eq 'v1';
	my $remove_across_paths ={};
	if (scalar @{$paths} == 1) {
		$remove_across_paths = $remove_per_path->[0];
	}
	else {

		for my $line_id (@{$state->{'AssignedVars'}{$var}{'LineIDs'}}) {
			my $acc_remove = shift @{$remove_per_path};
			my $all_removes = foldl(\&set_union,$acc_remove, $remove_per_path);
			my $all_keeps =[];
			if (scalar @{$keep_per_path}) {
				my $acc_keep = shift @{$keep_per_path};
				$all_keeps = foldl(\&set_union,$acc_keep, $keep_per_path);
			} else {
				$all_keeps = $keep_per_path->[0]
			}
			# die Dumper({'REMOVE'=>$all_removes,'KEEP'=> $all_keeps}) if $var eq 'v6';
			if (exists $all_removes->{$line_id} and not exists $all_keeps->{$line_id} ) {
				$remove_across_paths->{$line_id}=1;
			}
		}
	}

	return $remove_across_paths
} # END of _remove_or_keep_across_paths

sub set_union { my ($a_set, $b_set) = @_;
	return {%{$a_set}, %{$b_set}}
}



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

sub _add_var_to_state { my ($var, $state, $info,$rwVars)=@_;
	$state->{$rwVars}{$var}{'Counter'}++;
	push @{$state->{$rwVars}{$var}{'LineIDs'}}, $info->{'LineID'};
	my $if_block_id = $info->{'IfBlockID'};
	$state->{'IfBlocks'}{$if_block_id}{$rwVars}{$var}{'Counter'}++;
	push @{$state->{'IfBlocks'}{$if_block_id}{$rwVars}{$var}{'LineIDs'}}, $info->{'LineID'};
	return $state;
}

sub __remove_LineID { my ($var, $l_id, $state, $rwVars)=@_;
	my @line_ids = grep {$_ != $l_id } @{$state->{$rwVars}{$var}{'LineIDs'}};
	$state->{$rwVars}{$var}{'LineIDs'} = [@line_ids];
	for my $block_id (sort keys %{$state->{'IfBlocks'}}) {
		if (exists $state->{'IfBlocks'}{$block_id}{$rwVars}{$var}) {
			my @line_ids = grep {$_ != $l_id } @{$state->{'IfBlocks'}{$block_id}{$rwVars}{$var}{'LineIDs'}};
			$state->{'IfBlocks'}{$block_id}{$rwVars}{$var}{'LineIDs'} = [@line_ids];
		}
	}
	# Decrement the counter
	$state->{$rwVars}{$var}{'Counter'}--;
	return $state;
}

sub __delete_unused_AssignedVar_from_state { my ($var,$state) = @_;
	delete $state->{'UnusedVars'}{$var};
	delete $state->{'AssignedVars'}{$var};
	# Delete in the IfBlocks too!
	for my $block_id (sort keys %{$state->{'IfBlocks'}}) {
		if (exists $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}) {
			delete $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}
		}
	}
	return $state;
}

sub __delete_unused_ExprVar_from_state { my ($var,$state) = @_;
	# delete $state->{'UnusedVars'}{$var};
	delete $state->{'ExprVars'}{$var};
	# Delete in the IfBlocks too!
	for my $block_id (sort keys %{$state->{'IfBlocks'}}) {
		if (exists $state->{'IfBlocks'}{$block_id}{'ExprVars'}{$var}) {
			delete $state->{'IfBlocks'}{$block_id}{'ExprVars'}{$var}
		}
	}
	return $state;
}

# Actually remove the assignment lines from $state
sub __remove_lines_from_state_for_var { my ($var, $remove, $state) =@_;
	my $done=0;
	if (scalar keys %{$remove}>0) {
		for my $l_id (sort keys %{$remove}) {
			say "REMOVING assignment line $l_id for var $var" if $DBG;
			# Remove the LineID  from LineIDs
			$state = __remove_LineID($var, $l_id, $state, 'AssignedVars');
			# my @line_ids = grep {$_ != $l_id } @{$state->{'AssignedVars'}{$var}{'LineIDs'}};
			# $state->{'AssignedVars'}{$var}{'LineIDs'} = [@line_ids];

			# for my $block_id (sort keys %{$state->{'IfBlocks'}}) {
			# 	if (exists $state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}) {
			# 		my @line_ids = grep {$_ != $l_id } @{$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'}};
			# 		$state->{'IfBlocks'}{$block_id}{'AssignedVars'}{$var}{'LineIDs'} = [@line_ids];
			# 	}

			# }

			# # Decrement the counter
			# $state->{'AssignedVars'}{$var}{'Counter'}--;

			if ($state->{'AssignedVars'}{$var}{'Counter'}==0) {
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
					say "REMOVING read line $l_id for RHS var $rhs_var for var $var" if $DBG;
					# Remove the LineID  from LineIDs
					# my @rhs_line_ids = grep {$_ != $l_id } @{$state->{'ExprVars'}{$rhs_var}{'LineIDs'}};
					# $state->{'ExprVars'}{$rhs_var}{'LineIDs'} = [@rhs_line_ids];
					# # Decrement the counter
					# $state->{'ExprVars'}{$rhs_var}{'Counter'}--;
					$state = __remove_LineID($rhs_var, $l_id, $state, 'ExprVars');
				}
			}
			delete $remove->{$l_id}
		}
	} else {
		$done=1;
	}
	return $state;
} # END of __remove_lines_from_state_for_var

# ExprVars with Counter==0 are unused, remove all their assignments too
sub __remove_lines_from_state_for_rhs_vars { my ($state)=@_;
	my $done=1;
	for my $rhs_var (keys %{ $state->{'AssignedVars'} }) {
		# say "RHS VAR: $rhs_var";
		if (exists $state->{'ExprVars'}{$rhs_var} and
			exists $state->{'ExprVars'}{$rhs_var}{'Counter'} and
			$state->{'ExprVars'}{$rhs_var}{'Counter'}==0
		) {
			delete $state->{'ExprVars'}{$rhs_var};
			if (exists $state->{'AssignedVars'}{$rhs_var}
				and exists $state->{'AssignedVars'}{$rhs_var}{'LineIDs'}
				and scalar @{$state->{'AssignedVars'}{$rhs_var}{'LineIDs'}}>0
			) {
				my $rhs_var_assignment_l_id = $state->{'AssignedVars'}{$rhs_var}{'LineIDs'}[0];
				say "REMOVING assignment line $rhs_var_assignment_l_id for RHS var $rhs_var because COUNT=0" if $DBG;
				$done=0;
				if (not exists $state->{'UnusedLines'}{ $rhs_var_assignment_l_id}) {
					$state->{'UnusedLines'}{ $rhs_var_assignment_l_id}++;
				}
				delete $state->{'AssignedVars'}{$rhs_var};
				$state->{'UnusedVars'}{$rhs_var}=1;
				$state->{'UnusedDeclaredVars'}{$rhs_var}=1;
			}
		}
	} # Assigned variables
	# croak Dumper $state;
	return $state;
} # END of __remove_lines_from_state_for_rhs_vars
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
The four routines below are the solution to the key problem:
We turn the nested if statements into a tree and do a path traversal
That way we have every possible path through the code

append_subtree_to_branch, append_subtree_to_child and append_subtree_to_children_and_fold
are the mutually recursive functions that transform the DAG into a tree.

list_all_paths lists all paths through that tree.

So we can construct the sequences of assignments and reads from these paths.
We need to make ExprVars per-block like AssignedVars

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

We accumulate the path to a leaf node by appending all branch ids ('push')
Then we append this to the path list, and continue with the path without the terminal id
to climb back up in the branch of the tree

We call 'init' to pop the entry
=cut
# list_all_paths :: [Branch] -> ([Int],[[Int]]) -> ([Int],[[Int]])
sub list_all_paths { my ($bs, $path, $pathlist) = @_;
    my $p_pl_acc = foldl( sub { my ($p_pl, $b) = @_;
		# say Dumper $p_pl;
		my ($p,$pl) = @{$p_pl};
		my $c = head(   $b->{'children'});
		my $bs_ =  $c->{'branches'}//[];
		my $p_=[@{$p}, $b->{'branchId'} ]; # 'push'
		# die 'PATH:',Dumper $p,$p_;
		if (null($bs_)) {
				return [$p, [@{$pl},$p_]]; # p not p_ because we go back up
		} else {
			my $p__pl_ = list_all_paths( $bs_, $p_,$pl);
			my ($p__,$pl_) =@{$p__pl_};
			return [ init( $p__),$pl_]; # 'pop'
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

=pod
The problem with the above approach is that the structure of the If-blocks is independent of the individual variables.
For example

if cond1 #1
	v1=1
	if cond2 #2
		v2=2
	else #3
		v2=...
	end if
	v1=v2
else #4
	v1=3
end if
v2=...
if cond3 #5
	v3=...
else #6
	v4=...
end if

will currently result in following paths:

#1 #2 #5
#1 #2 #6

#1 #3 #5
#1 #3 #6

#4 #5
#4 #6

But actually, from the perspective of v1 the structure is
if cond1 #1
	v1=1
	v1=v2
else #4
	v1=3
end if
From v2 it is
if cond1 #1
	v1=1
	if cond2 #2
		v2=2
	else #3
		v2=...
	end if
	v1=v2
else #4
	v1=3
end if
v2=...
And from v3 and v4 it is
if cond3 #5
	v3=...
else #6
	v4=...
end if

So any If block that does not contain a given variable can be left out from the path.
Currently I have

 	my $state = {
		'IfBlocks'=>{
			$block_id => {
				'Branches'=>[$branch_id,...],
				'Children'=>[$child_block_id,...],
				'StartLineId'=>$start_line_id,
				'EndLineId'=>$end_line_id
			}
		},
	};

And this should really become

 	my $state = {
		$var => 'IfBlocks'=>{
			$block_id => {
				'Branches'=>[$branch_id,...],
				'Children'=>[$child_block_id,...],
				'StartLineId'=>$start_line_id,
				'EndLineId'=>$end_line_id
			}
		},
	};

So for a given variable, we need to check if it is used in any of the branches or their children
So I guess we do a recursive descent

sub _recurse_if_statement_datastructure {my ($state, $st_id,$var) = @_;
    my $seq = $state->{'IfBlocks'}{$st_id}{'Branches'};
    for my $b_id ( @{$seq}) {
		# $state->{'VarNotInBranch'}{$var}{$b_id};
        my $children = [];
        if (scalar  @{$state->{'IfBlocks'}{$b_id}{'Children'}} > 0 ) {
            for my $ch_id ( @{$state->{'IfBlocks'}{$b_id}{'Children'}}) {
				# $state->{'NotChildForVar'}{$var}{$child_block_id};
                push @{ $children }, _recurse_if_statement_datastructure($state, $ch_id,$var);
				# Maybe do work?
            }
        }
		# Do the work
    }
    return $state;
}



and keep a state

	$state->{'NotChildForVar'}{$var}{$child_block_id}

and we can remove any child that is not used by $var from Children.

I think Branches are actually blocks, so for every branch I van find StartLine and EndLine

If Children is empty and none of the branches contains $var (tracked via $state->{'VarNotInBranch'}{$var}{$branch_id})
then we can remove that block from the IfBlocks for $var.

The complexity of this is the complexity of the recursive descent which is roughly number of branches times number of if-blocks, for each variable

A better way is to build the correct structure from the start, simply by keeping track of occurrences of variables in each branch.

=cut