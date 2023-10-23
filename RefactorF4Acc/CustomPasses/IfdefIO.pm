# 
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::CustomPasses::IfdefIO;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass_inplace get_annotated_sourcelines );

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Carp;
$Carp::Verbose = 1;
use Data::Dumper; 

use Exporter;
@RefactorF4Acc::CustomPasses::IfdefIO::ISA = qw(Exporter);
@RefactorF4Acc::CustomPasses::IfdefIO::EXPORT_OK = qw(
    &ifdef_io_all
);

sub ifdef_io_all {  # CUSTOM PASS
	(my $stref) = @_;
	
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if exists $stref->{'Entries'}{$f};
#		say "\n! SOURCE $f\n"; 
		$stref = _ifdef_io_per_source($stref,$f); 
	 
	}
#	$stref = _ifdef_io_per_source($stref,'wave1d');
#	die;
	return $stref;	
}


sub _ifdef_io_per_source { (my $stref,my $f) =@_;
#	show_annlines( $stref->{'Subroutines'}{$f}{'RefactoredCode'});
	$stref = _ifdef_io_per_source_PASS1($stref,$f); 	
	$stref = _ifdef_io_per_source_PASS2a($stref,$f);
	$stref = _ifdef_io_per_source_PASS2b($stref,$f);
#	say $f;
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
					(my $next_relevant_statement, my $relevant_annline_idx) = _get_next_relevant_statement($annlines, $idx);
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
					(my $next_relevant_statement, my $relevant_annline_idx) = _get_next_relevant_statement($annlines, $idx);
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
					(my $next_relevant_statement, my $relevant_annline_idx) = _get_next_relevant_statement($annlines, $idx);
					if (exists  $next_relevant_statement->[1]{'EndIf'} or exists $next_relevant_statement->[1]{'Else'} or exists $next_relevant_statement->[1]{'ElseIf'}) {
						#remove the Else and the block but NOT the EndIf/Else
						# croak if $idx == $relevant_annline_idx-1;
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
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_action, $state,'__ifdef_io_PASS2a() ' . __LINE__  ) ;
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
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_action, $state,'__ifdef_io_PASS2b() ' . __LINE__  ) ;
	return $stref
}



sub _get_next_relevant_statement { (my $annlines, my  $idx_start) = @_;
	my $idx_eof = scalar @{$annlines}-1;
	my $relevant_annline=['',{}];
	my $relevant_annline_idx = $idx_start;
	for my $idx ($idx_start+1 .. $idx_eof) {
		my $annline = $annlines->[$idx];
		(my $line, my $info) = @{$annline};
		if ( not exists $info->{'Comments'} and not exists $info->{'Blank'} and not exists $info->{'Removed'}) {
			$relevant_annline = $annline;
			$relevant_annline_idx = $idx;
			last;
		}
	}
	return ($relevant_annline, $relevant_annline_idx);
}



1;
