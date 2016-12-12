# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Refactoring;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( stateful_pass stateful_pass_reverse stateless_pass get_annotated_sourcelines emit_f95_var_decl splice_additional_lines_cond  );
use RefactorF4Acc::Refactoring::Subroutines qw( refactor_all_subroutines emit_subroutine_sig );
use RefactorF4Acc::Refactoring::Functions qw( refactor_called_functions remove_vars_masking_functions);
use RefactorF4Acc::Refactoring::IncludeFiles qw( refactor_include_files );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec update_argument_io_direction_all_subs);
use RefactorF4Acc::Refactoring::Modules qw( add_module_decls );
use RefactorF4Acc::OpenCLTranslation qw( translate_to_OpenCL );
use RefactorF4Acc::CTranslation qw( toCType );
use RefactorF4Acc::Parser::Expressions qw(parse_expression emit_expression get_vars_from_expression);

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

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
	if ($pass =~/translate_to_C/) {
		$stref = _translate_sub_to_C_all($stref);
	}
	if ($pass =~/ifdef_io/i) {
		$stref = _ifdef_io_all($stref);		
	}
	if ($pass ne '') {
		if (_top_src_is_module($stref, $subname)) {
			$stref=add_module_decls($stref);
		}
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
		if ( not exists $info->{'Comments'} and not exists $info->{'Blank'} and not exists $info->{'Removed'}) {
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
			say "\n! PASS _removed_unused_variables on $f\n" if $V;
			$stref = _removed_unused_variables($stref, $f);
			$stref= _fix_scalar_ptr_args($stref, $f);
			say "\n! PASS _rename_array_accesses_to_scalars on $f\n" if $V; 
			$stref=_rename_array_accesses_to_scalars($stref, $f);			
			
		}
		# It is possible that the subs with renamed args are called in other subs.
		# In practice, they should be called from a single other sub, the superkernel
		# But there could be more than one kernel etc.
		for my $f ( @subs ) {			
			$stref=_rename_array_accesses_to_scalars_called_subs($stref, $f);
		}
	}
	return $stref;
}


sub _translate_sub_to_C_all { (my $stref) = @_;
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
			$stref=translate_sub_to_C($stref, $f);			
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
	
	my $pass_rename_in_ast = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Assignment'} ) {
			if (scalar @{ $info->{'Rhs'}{'VarList'}{'List'} } ==1 and $info->{'Rhs'}{'VarList'}{'List'}[0]=~/_ptr/) {
				# IGNORE, this is not a true array access
			} else {				
				# Rename all array accesses. But we can only do this in the AST!
#				croak "FIXME: In is only correct if there was no previous Out etc!";
				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'In');
				 $info->{'Rhs'}{'ExpressionAST'}=$ast;
#				 say "$line => AST:".Dumper($ast);
			}
			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array') {
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
			
			my $cond_expr_ast=parse_expression($info->{'CondExecExpr'}, $info,$stref, $f);
			
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
 	($stref,$state) = stateful_pass($stref,$f,$pass_rename_in_ast, $state,'_rename_array_accesses_to_scalars_PASS1() ' . __LINE__  ) ;
 	
 	$stref->{'Subroutines'}{$f}{'LiftedScalarAssignments'}=[];
	for my $var (keys %{ $state->{'StreamVars'} } ){
		for my $stream_var (sort keys %{ $state->{'StreamVars'}{$var} } ){
			
			my $assignment_line= '      '.$stream_var.' = '.$state->{'StreamVars'}{$var}{$stream_var}{'ArrayIndexExpr'};
			my $rhs_ast = parse_expression($state->{'StreamVars'}{$var}{$stream_var}{'ArrayIndexExpr'}, {},$stref, $f);
#			croak Dumper($rhs_ast);
			push @{ $stref->{'Subroutines'}{$f}{'LiftedScalarAssignments'} }, 
			[$assignment_line,
				{
					'Indent' => '      ',
					'Assignment'=> 1,
						'Lhs'=> {   
							'ArrayOrScalar' => 'Scalar','IndexVars' => {'List' => [],'Set' => {}},'ExpressionAST' => ['$',$stream_var],'VarName' => $stream_var
						  },
						'Rhs' => {
							'ExpressionAST' => $rhs_ast
						}
					
				}
			]; 
		}		
	}

# So now we have identified all stream vars. In the next pass, update the subroutine signature and declarations

	my $pass_action_2 = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'Signature'} ) { 
			
			my $new_args=[];
			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
#				say Dumper($state);
				if (exists $state->{'StreamVars'}{$arg} ) {
#					say $arg,Dumper($state);
					$new_args=[@{$new_args},  sort keys %{ $state->{'StreamVars'}{$arg} }  ];										
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
			if (exists $state->{'StreamVars'}{$var}) {
				my @vars = sort keys %{ $state->{'StreamVars'}{$var} };
				if (exists $info->{'ParsedVarDecl'}) {
					$info->{'ParsedVarDecl'}{'StreamVars'}=$state->{'StreamVars'}{$var};
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

 	($stref,$state) = stateful_pass($stref,$f,$pass_action_2, $state,'_rename_array_accesses_to_scalars_PASS2() ' . __LINE__  ) ;
	 	
 	# So at this point we should do the lifting of everything to do with indexing
 	
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
 	($stref,$state) = stateful_pass_reverse($stref,$f,$pass_lift_array_index_calculations, $state,'_rename_array_accesses_to_scalars_lift() ' . __LINE__  ) ;
 	
	# And then we can update $stref->{$Subroutines}{$f} and add LiftedIndexCalcLines and LiftedIndexVarDecls so that when we find a call we can splice in these lines
	$stref->{'Subroutines'}{$f}{'LiftedIndexCalcLines'}=dclone($state->{'LiftedIndexCalcLines'});
	$stref->{'Subroutines'}{$f}{'LiftedIndexVarDecls'}=dclone($state->{'LiftedIndexVarDecls'});
	# Here we update RefactoredArgs List
#
	# Delete the args replaced by streaming args from the Set
	map { delete $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };
	map { delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };
	# We must also create the assignment lines for every newly created stream var and put these in LiftedScalarAssignments	  

 	# At this point the argument list already has the stream vars as args
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
#	show_annlines($stref->{'Subroutines'}{$f}{'RefactoredCode'});
#	say Dumper($stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'})."\n<>\n".Dumper($state->{'RemainingArgs'});	
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
				'Attr'   => '',#$tvar_rec->{'Attributes'},
				'Dim'    => [],
				'Name'   => $tvar,
				'IODir'  => $intent,
				};
				$rline = emit_f95_var_decl($rdecl);
				my $orig_name =$info->{'VarDecl'}{'Name'}; 
				$info->{'VarDecl'}{'Name'}=$tvar;
				$info->{'VarDecl'}{'OrigName'}=$orig_name;
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
					%{ $stref->{'Subroutines'}{$subname}{'LiftedIndexVarDecls'}{'Set'} }
				};	
				for my $lifted_var ( keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} } ) {
					 
					if (not exists $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var} ) {
#						say "LIFTED VAR in $f: $lifted_var";
						$stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var}=dclone( get_var_record_from_set( $stref->{'Subroutines'}{$subname}{'Vars'},$lifted_var ) );
#						say Dumper( $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$lifted_var} );
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
	
	$stref->{'Subroutines'}{$f}{'LiftedVarDecls'}={'Set'=>{}};
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
 	($stref,$state) = stateful_pass($stref,$f,$pass_add_decls_lifted_vars, $state,'_rename_array_accesses_to_scalars_called_subs() ' . __LINE__  ) ;	
	my @lifted_var_decls = map { $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'}{$_} } sort keys %{ $stref->{'Subroutines'}{$f}{'LiftedVarDecls'}{'Set'} };
#	say "\nSUB: $f\n";
	
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
						$var_str=~s/[\(\),]/_/g; #TODO: ) should be nothing
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
	my $pass_action = sub { (my $annline, my $state)=@_;		
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
		
	my $state= {'DeclaredVars'=>{},
		'ExprVars'=>{},
		'AssignedVars'=>{},'Args'=>{},
		'UnusedVars'=>{},
		'UnusedDeclaredVars'=>{}
	};
	do {
		$state->{ExprVars}={};
		$state->{AssignedVars}={};
 		($stref,$state) = stateful_pass_reverse($stref,$f,$pass_action, $state,'_removed_unused_variables() ' . __LINE__  ) ;
 	
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
	($stref,$state) = stateful_pass_reverse($stref,$f,$pass_action_decls, $state,'_removed_unused_variables() ' . __LINE__  ) ;
 	# Adapt the signature in $stref
 	$stref->{'Subroutines'}{$f}{'DeletedArgs'} =$state->{'DeletedArgs'};
 	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'}=dclone($state->{'RemainingArgs'});
 	map { delete $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$_} }  @{ $state->{'DeletedArgs'} };
 	
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
	
 		($stref,$state) = stateful_pass_reverse($stref,$f,$pass_action, $state,'_removed_unused_variables() ' . __LINE__  ) ;

 	
	return $stref;
} # END of _fix_scalar_ptr_args()
 
# -----------------------------------------------------------------------------
sub translate_sub_to_C {  (my $stref, my $f) = @_;
=info	
	# First we collect info. What we need to know is:
	
	- What are the subroutine arguments, and their types?
	- Scalar && IODir eq 'In' => emit a scalar
	- otherwise => emit a pointer
	- make a list/table of all the arguments, of course we already have that in $stref->{'Subroutines'}{$f}{'RefactoredArgs'}
	- Then for every VarDecl we encounter:
		- if it's an Arg, remove it
		- otherwise, convert it to C syntax
		- In any case, if it is an array, we need the dimensions; but that should exists already in $stref->{'Subroutines'}{$f}{'Vars'}
	- If we find a select/case, we need to mark the *first* case to indicate that it should *not* be prefixed with  "}\n break;"
	- so maybe we actually don't need a separate pass after all ...
		 		
=cut
	my $pass_collect_info = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
#		say Dumper($stref->{'Subroutines'}{$f}{'DeletedArgs'});
		my $skip=0;
		if (exists $info->{'Signature'} ) {
			$c_line = _emit_subroutine_sig_C( $stref, $f, $annline);
			}
			elsif (exists $info->{'VarDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};
				if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$var}
				) {
					$c_line='//'.$line;
					$skip=1;
				} else {
					$c_line = _emit_var_decl_C($stref,$f,$var); 
				}
			}
			elsif ( exists $info->{'ParamDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};
				$c_line = _emit_var_decl_C($stref,$f,$var); 
#				croak Dumper($info);
#				
#					my $param_decl = {
#						'Indent' => $info->{'Indent'},
#						'Type' => $Sf->{'LocalParameters'}{'Set'}{$var}{'Type'},
#						'Attr' => $Sf->{'LocalParameters'}{'Set'}{$var}{'Attr'},
#						'Dim'  => [],
#						'Parameter' => 'parameter',
#						'Name'      => [ $var, $val ],
#						'Val'       => $val,             # backwards comp
#						'Var'       => $var,             # backwards comp
#						'Status'    => 1,
#						'InheritedParams' => $Sf->{'LocalParameters'}{'Set'}{$var}{'InheritedParams'},
#					};
#
#					$Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;
#					$rinfo{'ParamDecl'} = {'Name'      => [ $var, $val ]}; # $Sf->{'LocalParameters'}{'Set'}{$var};# {'Name' => $var};#				
			}
			elsif (exists $info->{'Select'} ) {				
				$c_line=$line;
				$c_line=~s/select\s+case/switch/;
				$c_line.='{';
			}
			elsif (exists $info->{'Case'} ) {
			$c_line=$line.': {';#'case';
			if ($info->{'Case'}>1) {
				$c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.$c_line;
			}
#			select case () => switch (...) {
#			case ... => case : { ... } break;
			}
			elsif (exists $info->{'CaseDefault'}) {
				$c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.'default : {';
			}
			elsif (exists $info->{'BeginDo'} ) {
				$c_line='for () {'; 
#			do i=1,n => for (int i = 1; i<=n; i++) { }
			}
		if (exists $info->{'Assignment'} ) {
			# So here we have to make 2 main changes:
			# Arrays need to be changed to the OpenCL C 1-D access syntax
			# Scalars need to be changed to pointer access if they are in the 'Pointers' list

			# This goes both for LHS and RHS  
				$c_line = _emit_assignment_C($stref, $f, $info).';';
		}
		elsif (exists $info->{'SubroutineCall'} ) {
			my $subcall_ast = $info->{'SubroutineCall'}{'ExpressionAST'};
			$subcall_ast->[0] = '&';
			$c_line = _emit_expression_C($subcall_ast,'',$stref,$f).';';
		}			 
		elsif (exists $info->{'If'} ) {		
			$c_line = _emit_ifthen_C($stref, $f, $info);
		}
		elsif (exists $info->{'ElseIf'} ) {		
			$c_line = '} else '._emit_ifthen_C($stref, $f, $info);
		}
		elsif (exists $info->{'Else'} ) {		
			$c_line = ' } else {';
		}
		elsif (exists $info->{'EndDo'} or exists $info->{'EndIf'} or exists $info->{'EndSelect'} or exists $info->{'EndSubroutine'} ) {
				 $c_line = '}';
		}
		elsif (exists $info->{'Comments'} ) {
			$c_line = $line;
			$c_line=~s/\!/\/\//;
		}
		elsif (exists $info->{'Use'} or
		exists $info->{'ImplicitNone'} or
		exists $info->{'Implicit'}		
		) {
			$c_line = '//'.$line; $skip=1;
		}	
		elsif (exists $info->{'Include'} ) {
			$line=~s/^\s*$//;
			$c_line = '#'.$line;
		}
		elsif (exists $info->{'Goto'} ) {
			$c_line = $line.';';
		}
		elsif (exists $info->{'Continue'}) {
			$c_line='';
		}
		if (exists $info->{'Label'} ) {
			$c_line = $info->{'Label'}. ' : '."\n".$info->{'Indent'}.$c_line;
		}
		
		push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line unless $skip;
		
		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f,{'TranslatedCode'=>[]}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_collect_info, $state,'C_translation_collect_info() ' . __LINE__  ) ;
 	map {say $_ } @{$state->[2]{'TranslatedCode'}};
 	return $stref;
	
} # END of translate_sub_to_C()

sub _emit_subroutine_sig_C { (my $stref, my $f, my $annline)=@_;
#	say "//SUB $f";
	    (my $line, my $info) = @{ $annline };
	    my $Sf        = $stref->{'Subroutines'}{$f};
	    
	    my $name = $info->{'Signature'}{'Name'};
#	    say "NAME $name";
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
		my $c_args_ref=[];	    			
		for my $arg (@{ $args_ref }) {
			($stref,my $c_arg_decl) = _emit_arg_decl_C($stref,$f,$arg);
			push @{$c_args_ref},$c_arg_decl;
		}
#g => {'Dim' => [['1','1']],'ArrayOrScalar' => 'Array','Name' => 'g_ptr','IODir' => undef,'Type' => 'real','Indent' => '    ','Attr' => ''}
#eta_j_k_ => {'Dim' => [],'ArrayIndexExpr' => 'eta(j+1,k)','Type' => 'real','IODir' => 'in','Attr' => '','ArrayOrScalar' => 'Scalar','Name' => 'eta','Indent' => '    '}	    
	    my $args_str = join( ',', @{$c_args_ref} );	    
	    my $rline = "void $name($args_str) {\n";
		return  $rline;
}

sub _emit_arg_decl_C { (my $stref,my $f,my $arg)=@_;
	my $decl =	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
	my $array = $decl->{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
	my $const = 1;
	if (not defined $decl->{'IODir'}) {
		$const = 0;
	} else { 
		$const =    $decl->{'IODir'} eq 'In' ? 1 : 0;
	}
	my $ptr = ($array || !$const) ? '*' : '';
	$stref->{'Subroutines'}{$f}{'Pointers'}{$arg}=$ptr;
	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=4};
	my $c_type = toCType($ftype,$fkind);
	my $c_arg_decl = $c_type.' '.$ptr.$arg;
	return ($stref,$c_arg_decl);
}



sub _emit_var_decl_C { (my $stref,my $f,my $var)=@_;
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
#		carp "SUB $f => VAR $var =>".Dumper($decl);
# {'Var' => 'st_sub_map_124','Status' => 1,'Dim' => [],'Attr' => '','Type' => {'Type' => 'integer'},'Val' => '0','Indent' => '  ','Name' => ['st_sub_map_124','0'],'InheritedParams' => undef,'Parameter' => 'parameter'}		
	my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
	my $const = '';
	my $val='';
	if (defined $decl->{'Parameter'}) {
		$const = 'const ';
		$val = ' = '.$decl->{'Val'};
	}
	my $ptr = $array  ? '*' : '';
	$stref->{'Subroutines'}{$f}{'Pointers'}{$var}=$ptr;
	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	if (ref ($ftype) eq 'HASH') {
		
		if (exists $ftype->{'Kind'}) {
			$fkind = $ftype->{'Kind'};
		}
		$ftype = $ftype->{'Type'};
	}
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=4};
	my $c_type = toCType($ftype,$fkind);
	my $c_var_decl = $const.$c_type.' '.$ptr.$var.$val.';';
	return ($stref,$c_var_decl);
}

sub _emit_assignment_C { (my $stref, my $f, my $info)=@_;
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
#	say Dumper($lhs_ast);
	my $lhs = _emit_expression_C($lhs_ast,'',$stref,$f);
	$lhs=~s/\(([^\(\)]+)\)/$1/;
	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};	
#	carp Dumper($rhs_ast) if $lhs=~/k_range/;

	my $rhs = _emit_expression_C($rhs_ast,'',$stref,$f);
#	say $rhs;
	my $rhs_stripped = $rhs;
	$rhs_stripped=~s/\(([^\(\)]+)\)/$1/;
#	$rhs_stripped=~s/^\(// && $rhs_stripped=~s/\)$//;
#	if ( $rhs_stripped=~/[\(\)]/) {
#		# Undo!
#		$rhs_stripped=$rhs;
#	}
#	say $rhs_stripped;
	my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
	if (exists $info->{'If'}) {
		my $if_str = _emit_ifthen_C($stref,$f,$info);
		$rline =$if_str.' '.$rline; 
	}	
	return $rline;
}



sub _emit_ifthen_C { (my $stref, my $f, my $info)=@_;	
	my $cond_expr_ast=$info->{'CondExecExpr'};
	my $cond_expr = _emit_expression_C($cond_expr_ast,'',$stref,$f);
	$cond_expr=_change_operators_to_C($cond_expr);
	my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');
		
	return $rline;
}

sub _emit_expression_C {(my $ast, my $expr_str, my $stref, my $f)=@_;
#	carp Dumper($ast);
	if (ref($ast) ne 'ARRAY') {return $ast;}
	my @expr_chunks=();
	my $skip=0;
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			 my $nest_expr_str = _emit_expression_C( $entry, '',$stref,$f);
#			 say "NEST:$nest_expr_str ";
			push @expr_chunks, $nest_expr_str;
		} else {
			if ($entry =~/#/) {
				$skip=1;
			} elsif ($entry eq '&') {
				my $mvar = $ast->[$idx+1];
				
				$expr_str.=$mvar.'(';
				$skip=1;
			} elsif ($entry eq '$') {
				my $mvar = $ast->[$idx+1];
#				carp $mvar;
				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar} ) {
					my $ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar};
					push @expr_chunks,  $ptr eq '' ? $mvar : '('.$ptr.$mvar.')';
				} else {
					push @expr_chunks,$mvar;
				}
				$skip=1;				
			} elsif ($entry eq '@') {
				
				my $mvar = $ast->[$idx+1];
				if ($mvar eq '_OPEN_PAR_') {
					$expr_str.=$mvar.'(';
				} else {
					my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$mvar);

					my $dims =  $decl->{'Dim'};
					
					my $dim = scalar @{$dims};
#					say $mvar . Dumper( $decl). ' => ' .$dim;
					my @ranges=();
					my @lower_bounds=();
					for my $boundspair (@{$dims}) {
						(my $lb, my $hb)=@{$boundspair };
						push @ranges, "(($hb - $lb )+1)";
						push @lower_bounds, $lb; 
					} 
					
				# For convenience we define a different function, not FTNREF
				 # F3D2C(
#                        unsigned int iz,unsigned int jz, // ranges, i.e. (hb-lb)+1
#                                int i_lb, int j_lb, int k_lb, // lower bounds
#                int ix, int jx, int kx)
					$expr_str.=$mvar.'[F'.$dim.'D2C('.join(',',@ranges).' , '.join(',',@lower_bounds). ' , ';
				}
				$skip=1;
			} elsif (
				$ast->[$idx-1]!~/^[\&\@\$]/ 
			) {
#				say "ENTRY:$entry SKIP: $skip";
				push @expr_chunks,$entry;
				$skip=0;
			}
		}				
	}
	if ($ast->[0] eq '&' ) {
		my @expr_chunks_stripped = map { $_=~s/\(([^\(\)]+)\)/$1/;$_} @expr_chunks; 
		$expr_str.=join(',',@expr_chunks_stripped);
		$expr_str.=')'; 
	} elsif ( $ast->[0] eq '@') {
		my @expr_chunks_stripped =   map {  $_=~s/\(([^\(\)]+)\)/$1/;$_} @expr_chunks;
		$expr_str.=join(',',@expr_chunks_stripped);
		# But here we'd need to know what the var is!
		$expr_str.=')';
		if ($expr_str=~/\[/) {
		$expr_str.=']'; 		
		} 
	} elsif ($ast->[0] ne '$' and $ast->[0] =~ /\W/) {
		my $op = $ast->[0];		
		if (scalar @{$ast} > 2) {
			my @ts=();
			for my $elt (1 .. scalar @{$ast} -1 ) {
				$ts[$elt-1] = (ref($ast->[$elt]) eq 'ARRAY') ? _emit_expression_C( $ast->[$elt], '',$stref,$f) : $ast->[$elt];					
			} 
			if ($op eq '^') {
				$op = '**';
				warn "TODO: should be pow()";
			};
			$expr_str.=join($op,@ts);
		} elsif (defined $ast->[2]) { croak "OBSOLETE!";
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_C( $ast->[1], '',$stref,$f) : $ast->[1];
			my $t2 = (ref($ast->[2]) eq 'ARRAY') ? _emit_expression_C( $ast->[2], '',$stref,$f) : $ast->[2];			
			$expr_str.=$t1.$ast->[0].$t2;
			if ($ast->[0] ne '=') {
				$expr_str="($expr_str)";
			}			
		} else {
			# FIXME! UGLY!
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_C( $ast->[1], '',$stref,$f) : $ast->[1];
			$expr_str=$ast->[0].$t1;
			if ($ast->[0] eq '/') {
				$expr_str='1.0'.$expr_str; 
			}
		}
	} else {
		$expr_str.=join(';',@expr_chunks);
	}	
#	$expr_str=~s/_complex_//g;
	$expr_str=~s/_OPEN_PAR_//g;
	$expr_str=~s/_LABEL_ARG_//g;
	if ($expr_str=~s/^\#dummy\#\(//) {
		$expr_str=~s/\)$//;
	}
	$expr_str=~s/\+\-/-/g;
	# UGLY! HACK to fix boolean operations
	 
	while ($expr_str=~/__[a-z]+__/ or $expr_str=~/\.\w+\.\+/) {
		$expr_str =~s/\+\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/__not__\+/\.not\./g; 
		$expr_str =~s/__not__/\.not\./g; 		
		$expr_str =~s/__false__/\.false\./g;
		$expr_str =~s/__true__/\.true\./g;
		$expr_str =~s/\+__(\w+)__\+/\.${1}\./g;		
		$expr_str =~s/__(\w+)__/\.${1}\./g;
#		  		$expr_str =~s/\.(\w+)\./$F95_ops{$1}/g;
	}	
	return $expr_str;		
} # END of _emit_expression_C()

sub _change_operators_to_C { (my $cond_expr) = @_;
	
my %C_ops =(
	'eq' => '==',
	'ne' => '!=',
	'le' => '<=',
	'ge' => '>=',
	'gt' => '>',
	'lt' => '<',
	'not' => '!',
	'and' => '&&',
	'or' => '||',	     			
);
while ($cond_expr=~/\.(\w+)\./) {	
	$cond_expr=~s/\.(\w+)\./$C_ops{$1}/;
}
	return $cond_expr;
}

1;
