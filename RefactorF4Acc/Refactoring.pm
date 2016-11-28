# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Refactoring;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( stateful_pass stateless_pass get_annotated_sourcelines emit_f95_var_decl );
use RefactorF4Acc::Refactoring::Subroutines qw( refactor_all_subroutines emit_subroutine_sig );
use RefactorF4Acc::Refactoring::Functions qw( refactor_called_functions remove_vars_masking_functions);
use RefactorF4Acc::Refactoring::IncludeFiles qw( refactor_include_files );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec update_argument_io_direction_all_subs);
use RefactorF4Acc::Refactoring::Modules qw( add_module_decls );

use RefactorF4Acc::Parser::Expressions qw(parse_expression emit_expression);

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
$Carp::Verbose = 1;
use Data::Dumper; 

use Exporter;
@RefactorF4Acc::Refactoring::ISA = qw(Exporter);
@RefactorF4Acc::Refactoring::EXPORT_OK = qw(
    &refactor_all
);

# -----------------------------------------------------------------------------

sub refactor_all {
	( my $stref, my $subname, my $pass) = @_;

	if ($pass =~/rename_array_accesses_to_scalars/) {
		$stref = _rename_array_accesses_to_scalars_all($stref);		
	}
	if ($pass =~/ifdef_io/i) {
		$stref = _ifdef_io_all($stref);		
	}
	if ($pass ne '') {
		return $stref;
	}
    $stref = refactor_include_files($stref);

    $stref = refactor_called_functions($stref); # Context-free only FIXME: this should be treated just like subs, but if course that requires full parsing of expressions
    
    # Refactor the source, but don't split long lines and keep annotations
    $stref = refactor_all_subroutines($stref);
    
    # This can't go into refactor_all_subroutines() because it is recursive
    # Also, this is actually analysis
    $stref = determine_argument_io_direction_rec( $subname, $stref );    
    say "DONE determine_argument_io_direction_rec()" if $V;

    $stref = update_argument_io_direction_all_subs( $stref );
    
    # So at this point we know everything there is to know about the argument declarations, we can now update them
    say "remove_vars_masking_functions" if $V;    
    $stref = remove_vars_masking_functions($stref);    
    
    # Custom refactoring, must be done before creating final modules
    say "add_module_decls" if $V;
    $stref=add_module_decls($stref);
    
    return $stref;	
} # END of refactor_all()  

# Below are general refactortings that really should go somewhere else!

# This just ifdefs any IO statement, really cheap!
sub _ifdef_io_QD { (my $stref) = @_;
	
	my $__ifdef_io = sub {
		( my $annline ) = @_;
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'IO'}){
			return [
				['#ifndef NO_IO',{'Macro' => 1}],
				$annline,
				['#else',{'Macro' => 1}],
				[$info->{'Indent'}.'continue',{'Continue' => 1}],
				['#endif',{'Macro' => 1}]
			];
		} else {
			return [$annline];
		}
	};	
	
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if exists $stref->{'Entries'}{$f};
		$stref = stateless_pass( $stref, $f, $__ifdef_io, '__ifdef_io() ' . __LINE__ );
	}	
	
	return $stref;	
}


sub _ifdef_io_all { (my $stref) = @_;
	
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if exists $stref->{'Entries'}{$f};
#		say "\n! SOURCE $f\n"; 
		$stref = _ifdef_io_per_source($stref,$f); 
	}	
#	$stref = _ifdef_io_per_source($stref,'wave1d');
#	die;
	return $stref;	
}


sub _ifdef_io_per_source{ (my $stref,my $f) =@_;
	$stref = _ifdef_io_per_source_PASS1($stref,$f); 	
	$stref = _ifdef_io_per_source_PASS2a($stref,$f);
	$stref = _ifdef_io_per_source_PASS2b($stref,$f);
#	show_annlines( $stref->{'Subroutines'}{$f}{'RefactoredCode'});
	return $stref;
}
#Removing IO done right:
#
#PASS 1 (iterative)
sub _ifdef_io_per_source_PASS1 { (my $stref,my $f) =@_; 
	
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    
	my $removed_count=-1; 
	my $iter=0;
	while ($removed_count!=0) {
		$iter++;
		$removed_count=0;
		my $idx=0;
		my $new_annlines=[];
	    for my $annline (@{$annlines}) {
	    	(my $line, my $info) = @{$annline};		
#	    	say "$iter LINE: $line  ".join(';',keys %{$info});	
	    	if (not exists $info->{'Removed'}) {
				if (exists $info->{'IO'}) { 
					$info->{'Removed'}=1;
					$removed_count++;
				} elsif (exists $info->{'Do'}) {
					(my $next_relevant_statement, my $relevant_annline_idx) = get_next_relevant_statement($annlines, $idx);
					if (exists  $next_relevant_statement->[1]{'EndDo'}) {
					 	# remove the whole block 
					 	for my $b_idx ($idx .. $relevant_annline_idx) {
					 		$annlines->[$b_idx][1]{'Removed'}=1;
					 		$removed_count++;
					 	}
					} else {
						# Else it means the block is not empty, so don't do anything
					}
				} elsif (exists $info->{'If'}) { 
				#- If next relevant non-removed statement is EndIf, remove the whole block
#				say "$iter IFTHEN: $line";
					(my $next_relevant_statement, my $relevant_annline_idx) = get_next_relevant_statement($annlines, $idx);
#					say "NEXT:".$next_relevant_statement->[0].Dumper($next_relevant_statement->[1]);
					if (exists  $next_relevant_statement->[1]{'EndIf'}) {
#						croak $line.$next_relevant_statement->[0];
						#remove the whole block
					 	for my $b_idx ($idx .. $relevant_annline_idx) {
					 		$annlines->[$b_idx][1]{'Removed'}=1;
					 		$removed_count++;
					 	}		
					}
				#- If IfThen and next relevant non-removed statement is Else (including Else IfThen),
					elsif (exists $next_relevant_statement->[1]{'Else'} or exists $next_relevant_statement->[1]{'ElseIf'}  ) {				 	
						# 	insert a Continue after the IfThen, do not remove the IfThen
						push @{$new_annlines}, $annline;
						push @{$new_annlines}, [$info->{'Indent'}.'continue' ,{'Continue'=>1}];
						next;					
					}
				} elsif (exists $info->{'Else'} or exists $info->{'ElseIf'}) {
				#- If Else (includeing Else IfThen) and next relevant non-removed statement is EndIf or Else (incl Else IfThen), remove the Else and the block but NOT the EndIf/Else
					(my $next_relevant_statement, my $relevant_annline_idx) = get_next_relevant_statement($annlines, $idx);
					if (exists  $next_relevant_statement->[1]{'EndIf'} or exists $next_relevant_statement->[1]{'Else'} or exists $next_relevant_statement->[1]{'ElseIf'}) {
						#remove the Else and the block but NOT the EndIf/Else
						croak if $idx == $relevant_annline_idx-1;
					 	for my $b_idx ($idx .. $relevant_annline_idx-1) {
					 		$annlines->[$b_idx][1]{'Removed'}=1;
					 		$removed_count++;
					 	}							
					}
				}
	    	}
			push @{$new_annlines}, $annline;
			$idx++;
	    }	    
	    $annlines=$new_annlines;
			#Iterate the above until $removed_count == 0
	} # while
	$stref->{$sub_or_func_or_mod}{$f}{'RefactoredCode'}=$annlines;
	return $stref;
}


# Then

# PASS2a (stateful pass, the state is the previous annline)
sub _ifdef_io_per_source_PASS2a { (my $stref, my $f) =@_; # make this just $annlines?
 

	#If we encounter a Removed line, and the previous line was NOT removed (or there wasn't any)
	my $pass_action = sub { (my $annline, my $prev_annline)=@_;
		(my $line,my $info)=@{$annline};
		(my $prev_line,my $prev_info)=@{$prev_annline};
		my $new_annlines = [$annline];
		if (exists $info->{'Removed'} and not exists $prev_info->{'Removed'}) {
	#  Insert and #ifndef NO_IO before the removed line
					$new_annlines =[ 
					['#ifndef NO_IO',{'Macro' => 1}],
					$annline
					]
		}
		return ($new_annlines,$annline);
	};

	my $state = ['! Start',{'Comments' => 1}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_action, $state,'__ifdef_io_PASS2a() ' . __LINE__  ) ;
	return $stref
}


# PASS2b (stateful pass, the state is the previous annline)
sub _ifdef_io_per_source_PASS2b { (my $stref, my $f) =@_; # make this just $annlines?
 
#If we encounter a non-Removed line (or EOF), and the previous line was Removed 
	my $pass_action = sub { (my $annline, my $prev_annline)=@_;
		(my $line,my $info)=@{$annline};
		(my $prev_line,my $prev_info)=@{$prev_annline};
		my $new_annlines = [$annline];
		if (not exists $info->{'Removed'} and exists $prev_info->{'Removed'}) {
			#  Insert and #endif before the not-removed line	
			$new_annlines =[
				['#endif',{'Macro' => 1}], 					
				$annline					
			]
		}
		return ($new_annlines,$annline);
	};

	my $state = ['! Start',{'Comments' => 1}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_action, $state,'__ifdef_io_PASS2b() ' . __LINE__  ) ;
	return $stref
}



sub get_next_relevant_statement { (my $annlines, my  $idx_start) = @_;
	my $idx_eof = scalar @{$annlines}-1;
	my $relevant_annline=['',{}];
	my $relevant_annline_idx = $idx_start;
	for my $idx ($idx_start+1 .. $idx_eof) {
		my $annline = $annlines->[$idx];
		(my $line, my $info) = @{$annline};
#		say '>>>'.$line.' : '.join(';',keys %{$info});
		if ( not exists $info->{'Deleted'} and not exists $info->{'Comments'} and not exists $info->{'Blank'} and not exists $info->{'Removed'}) {
			$relevant_annline = $annline;
			$relevant_annline_idx = $idx;
			last;
		}
	}
	return ($relevant_annline, $relevant_annline_idx);
}



#sub _ifdef_io_per_source_RUBBISH { (my $stref,my $f) =@_;
#	
#    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
#    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
#    my $annlines           = get_annotated_sourcelines( $stref, $f );
#    my $nextLineID         = scalar @{$annlines} + 1;
#    my $new_annlines=[];
#    my $eof_idx = scalar @{$annlines} -1;
#    my $idx = 0;
#    while ($idx <= $eof_idx ) {
#    	(my $line, my $info) = @{$annlines->[$idx]}; 
#		if (exists $info->{'IO'} ) {
#			# Start at the line before the current IO line and go up
#			my $b_idx = $idx-1;
#			my $b_idx_ctl = $b_idx;
#			(my  $b_line,my $b_info) = @{ $annlines->[$b_idx]};
#			while ( 
#				(
#				exists $b_info->{'Control'} or
#				exists $b_info->{'Blank'} or
#				exists $b_info->{'Comments'} or
#				exists $b_info->{'Deleted'}) 
#				and $b_idx>0 			
#			) {
#				if (exists $b_info->{'Control'} and not exists $b_info->{'Deleted'}) {
#					$b_idx_ctl=$b_idx;
#				} 
#					$b_idx--;					
#				(  $b_line, $b_info) = @{ $annlines->[$b_idx]};
#			
#			}
#			
#			if ($b_idx==0) {
#				# Didn't find any Control before this IO line.
#				# put #ifndef immediately before the current IO line
#				$annlines->[$idx][1]{'Ifdef'}= '#ifndef NO_IO // IO';
#				$b_idx = $idx-1; # because we use $b_idx+1
#			}			
#			# Start at the line after the current IO line and go down
#			my $f_idx = $idx+1;
#			my $f_idx_io_ctl=$f_idx;
#			(my  $f_line,my $f_info) = @{ $annlines->[$f_idx]};
#			while ( 
#				(
#				exists $f_info->{'EndControl'} or
#				exists $f_info->{'Blank'} or
#				exists $f_info->{'Comments'} or
#				exists $f_info->{'Deleted'}) 
#				and $f_idx<$eof_idx		
#			) {
#				if (exists $f_info->{'EndControl'} or exists $f_info->{'IO'} and not exists $f_info->{'Deleted'}) {
#					$f_idx_io_ctl=$f_idx;
#				} 
#				
#				$f_idx++;
#				(  $f_line, $f_info) = @{ $annlines->[$f_idx]};
#				
#			}
#			
#			if ($f_idx>$eof_idx) {
#				# If we hit EOF without finding any Control, 
#				# put #endif immediately after the current IO line
#				$annlines->[$idx][1]{'EndIfdef'}= '#endif // IO';
#				$f_idx=$idx+1;
#			}
#			# Now we need to check if the begin and end is matched in terms of blocks
#			
#			# if Control is a do-block, the EndControl must be the corresponding EndDo, else we need to shift up/down a line
#			if (exists $annlines->[$b_idx+1][1]{'Do'} ) {
#				# Is there an EndDo ?
#				if (exists $annlines->[$f_idx-1][1]{'EndDo'} ) {
#				# is the EndDo correct?
##				say Dumper($annlines->[$b_idx+1][1]).'<>'.Dumper($annlines->[$f_idx-1][1]);					
#					my $b_block_id = $annlines->[$b_idx+1][1]{'Block'}{'Nest'};
#					my $f_block_id = $annlines->[$f_idx-1][1]{'Block'}{'Nest'};
#					if (not defined $f_block_id) {
#						# try via label						
#						$b_block_id = $annlines->[$b_idx+1][1]{'BeginDo'}{'Label'};
#						$f_block_id = $annlines->[$f_idx-1][1]{'EndDo'}{'Label'};
#					}
#					if ($b_block_id == $f_block_id) {
#						# Both OK!
#						$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // OK (Do)';
#						$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // OK (EndDo)';
#					} else {
#						# NOK
#						# See which one is smallest
#						if ($b_block_id<$f_block_id) {
#							# Do is OK
#							$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO  // OK (Do)';
#							# take the line before the EndDo
#							$f_idx--;
#							$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif  // -1 (EndDo)';
#							
#						} else {
#							# take the line after the Do
#							$b_idx++;
#							$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // +1 (Do)';
#							# EndDo is OK
#							$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // OK (EndDo)';
#						}
#					}
#				} else {
#					# NOK, take the line down after the Do
#					$b_idx++;
#					$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // +1 (Do)';
#					# The #endif line should be OK, but to be sure:
#					$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // OK (IO)';
#				}								
#			} elsif (exists $annlines->[$f_idx-1][1]{'EndDo'} ) {
#				# There is no Do
#					# NOK, take the line up before the EndDo
#					$f_idx--;
#					$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // -1 (EndDo)';
#					# the #ifndef line should be OK
#					$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // OK (IO)';
#			}
## For if-blocks I do the same, currently ignoring the complications of else if and else 			
#		elsif (exists $annlines->[$b_idx+1][1]{'If'} ) {
#				# Is there an EndIf ?
#				if (exists $annlines->[$f_idx-1][1]{'EndIf'} ) {
#				# is the EndIf correct?					
#					my $b_block_id = $annlines->[$b_idx+1][1]{'Block'}{'Nest'};
#					my $f_block_id = $annlines->[$f_idx-1][1]{'Block'}{'Nest'};
#					if ($b_block_id == $f_block_id) {
#						# Both OK!
#						$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // OK (If)';
#						$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // OK (EndIf)';
#					} else {
#						# NOK
#						# See which one is smallest
#						if ($b_block_id<$f_block_id) {
#							# If is OK
#							$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // OK (If)';
#							# take the line before the EndIf
#							$f_idx--;
#							$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // -1 (EndIf)';
#							
#						} else {
#							# take the line after the If
#							$b_idx++;
#							$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // +1 (If)';
#							# EndIf is OK
#							$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // OK (EndIf)';
#						}
#					}
#				} else {
#					# NOK, take the line down after the If
#					$b_idx++;
#					$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // +1 (If)';
#					# The #endif line should be OK
#					$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // OK (IO)';
#				}		
#						
#			} elsif (exists $annlines->[$f_idx-1][1]{'EndIf'} ) {
#				# This is an elsif so there is no If
#					# NOK, take the line up before the EndIf
#					$f_idx--;
#					$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // -1 (EndIf)';
#					# the #ifndef line should be OK
#					$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // OK (IO)';
#			} else {
#				# We come here if there are no blocks. This is means it is a Blank or Deleted for the UP case
#				# For the DOWN case it can be IO, Blank or deleted.
#				if (exists $annlines->[$b_idx+1][1]{'IO'}) {
#					$annlines->[$b_idx+1][1]{'Ifdef'}= '#ifndef NO_IO // OK ()';
#				} else {
#					$annlines->[$b_idx_ctl][1]{'Ifdef'}= '#ifndef NO_IO // OK (LastDown)';
#				}
#				if (exists $annlines->[$f_idx-1][1]{'IO'} ) {
#					$annlines->[$f_idx-1][1]{'EndIfdef'}= '#endif // OK ()';
#				} else {
#				$annlines->[$f_idx_io_ctl][1]{'EndIfdef'}= '#endif // OK (LastUp)';
#				}				
#			} 			
#			$idx = $f_idx+1;	
#		} else {
#			$idx++;
#		}               
#    }
#    for my $annline (@{$annlines}) {
#    	(my $line, my $info) = @{$annline};			
#		if (exists $info->{'Ifdef'}) {
#		say $info->{'Ifdef'};
#		}
#		say $line;			
#		if (exists $info->{'EndIfdef'}) {
#		say $info->{'EndIfdef'};
#		}    	 
#    }
#    
##    $Sf->{'RefactoredCode'} = $new_annlines;
#    return $stref;
#}



sub _rename_array_accesses_to_scalars_all { (my $stref) = @_; 
	    my %is_existing_module = ();
    my %existing_module_name = ();
	
for my $src (keys %{ $stref->{'SourceContains'} } ) {
			
		if (exists $stref->{'SourceContains'}{$src}{'Path'}
		and  exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'} ) {	
		# External, SKIP!
			say "SKIPPING $src";			
		} else {		
		# Get the unit name from the list	    		
		    for my $sub_or_func_or_mod ( @{  $stref->{'SourceContains'}{$src}{'List'}   } ) {
#		    	say "SRC: $src => $sub_or_func_or_mod <>".$stref->{'Top'};
		    	# Get its type
		        my $sub_func_type= $stref->{'SourceContains'}{$src}{'Set'}{$sub_or_func_or_mod};
		        if ($sub_func_type eq 'Modules') {
		        	$is_existing_module{$src}=1;
		        	$existing_module_name{$src} = $sub_or_func_or_mod;
		        }		
		    }
		}

	my @subs= $is_existing_module{$src} ? @{ $stref->{'Modules'}{$existing_module_name{$src}}{'Contains'} } :   sort keys %{ $stref->{'Subroutines'} };
	for my $f ( @subs ) {
		say "\n! PASS _rename_array_accesses_to_scalars on $f\n";
		$stref=_rename_array_accesses_to_scalars($stref, $f);
		show_annlines($stref->{'Subroutines'}{$f}{'RefactoredCode'},0);
	}
}	
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
	
	my $pass_action = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Assignment'} ) {
			if (scalar @{ $info->{'Rhs'}{'VarList'}{'List'} } ==1 and $info->{'Rhs'}{'VarList'}{'List'}[0]=~/_ptr/) {
				# IGNORE, this is not a true array access
			} else {				
				# Rename all array accesses. But we can only do this in the AST!
				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'In');
				 $info->{'Rhs'}{'ExpressionAST'}=$ast;
#				 say "$line => AST:".Dumper($ast);
			}
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array') {
				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'}, 'Out');
				$info->{'Lhs'}{'ExpressionAST'}=$ast;				
			}
		} elsif (exists $info->{'If'} ) {		
			
			my $cond_expr_ast=parse_expression($info->{'CondExecExpr'}, $info,$stref, $f);
			
			(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $cond_expr_ast, 'In');
			
			$info->{'CondExecExpr'}=$ast;			
		}
		return ([[$line,$info]],$state);
	};

	my $state = {};
 	($stref,$state) = stateful_pass($stref,$f,$pass_action, $state,'_rename_array_accesses_to_scalars_PASS1() ' . __LINE__  ) ;	
#	say Dumper($state);

# So now we have identified all stream vars. In the next pass, update the subroutine signature and declarations
	
	my $pass_action_2 = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Signature'} ) { 
			
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
#				say Dumper($state);
				if (exists $state->{$arg} ) {
#					say $arg,Dumper($state);
				$new_args=[@{$new_args},  sort keys %{ $state->{$arg} }  ];
				} else {
					push @{$new_args}, $arg;
				} 
			}
			$info->{'Signature'}{'Args'}{'List'}=$new_args;
			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
#			say Dumper($info);
		} elsif (exists $info->{'VarDecl'} ) {
#			say Dumper($info->{'VarDecl'})."\t".
			my $var = $info->{'VarDecl'}{'Name'};
			if (exists $state->{$var}) {
				my @vars = sort keys %{ $state->{$var} };
				if (exists $info->{'ParsedVarDecl'}) {
					$info->{'ParsedVarDecl'}{'StreamVars'}=$state->{$var};
					$info->{'ParsedVarDecl'}{'Vars'}=[@vars];
					delete $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'};
					# In principle I should deal with the INTENT as well but I will just delete it and see
					if (exists $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'} ) {
						delete $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'};
					}
#					say Dumper($info->{'ParsedVarDecl'});
				} else {
					croak "TROUBLE: ".Dumper($annline); 
				}
			}
		}
		return ([[$line,$info]],$state);
	};

#	my $state = {};
 	($stref,$state) = stateful_pass($stref,$f,$pass_action_2, $state,'_rename_array_accesses_to_scalars_PASS2() ' . __LINE__  ) ;		
	
	
# my $rline = emit_f95_var_decl($rdecl);	
	my $pass_action_3 = sub { (my $annline, my $state)=@_;		
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
				my $intent = $tvar_rec->{'StreamVars'}{$tvar};
				my $rdecl = {
				'Indent' => $info->{'Indent'},
				'Type'   => $type.$kind,
				'Attr'   => '',#$tvar_rec->{'Attributes'},
				'Dim'    => [],
				'Name'   => $tvar,
				'IODir'  => $intent,
				};
				$rline = emit_f95_var_decl($rdecl);
				say $rline if $DBG;
				push @{$rlines},[$rline,$info];			
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
		
		return ($rlines,$state);
	};
	
	$state=[$stref,$f];
 	($stref,$state) = stateful_pass($stref,$f,$pass_action_3, $state,'_rename_array_accesses_to_scalars_PASS3() ' . __LINE__  ) ;	
	
	return $stref;
} # END of _rename_array_accesses_to_scalars()



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
						$expr_str=~s/[\(\),]/_/g;
						$expr_str=~s/\+/p/g;
						$expr_str=~s/\-/m/g;
						$expr_str=~s/\*/t/g;
#						say 'Found array access '.$mvar.' => '.$expr_str ;
						$state->{$mvar}{$expr_str}=$intent;
						$ast=['$',$expr_str];
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
	return ($rline, $info);
}

sub _emit_ifthen { (my $annline)=@_;
	( my $line, my $info ) = @{$annline};
	my $cond_expr_ast=$info->{'CondExecExpr'};
	my $cond_expr = emit_expression($cond_expr_ast);
	my $rline = $info->{'Indent'}.'if ('.$cond_expr.') then';	
	return ($rline, $info);
}



1;
