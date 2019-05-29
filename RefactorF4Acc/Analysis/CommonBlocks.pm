package RefactorF4Acc::Analysis::CommonBlocks;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( eval_expression_with_parameters );
use RefactorF4Acc::Utils qw( in_nested_set );
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.2.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::CommonBlocks::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::CommonBlocks::EXPORT_OK = qw(
	&collect_common_vars_per_block
	&identify_common_var_mismatch
	&create_common_var_size_tuples
	&match_up_common_vars
);


# This is for Parser, so the result should a list of var names
#
sub collect_common_vars_per_block { my ($stref, $f, $common_decl_str_) = @_;	
	
    my %common_blocks = %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} };
    my $common_decl_str = $common_decl_str_;
    $common_decl_str=~s/common\s*//;
    $common_decl_str=~s/\s+$//;
#    say $common_decl_str;
    if ($common_decl_str!~/^\//) {
        $common_decl_str='BLANK/'.$common_decl_str;
    } else {
        $common_decl_str=~s/^\/\s*//;
    }
    my  @common_chunks = split(/\s*\/\s*/,$common_decl_str);

    while (@common_chunks) {

        my $common_block_name = shift @common_chunks;
        if ( $common_block_name eq '' or $common_block_name=~/^\s+$/) {  $common_block_name = 'BLANK';}

        if (not exists $common_blocks{$common_block_name}) {
            $common_blocks{$common_block_name}=[];
        }
        my $common_vars_str = shift @common_chunks;

        $common_vars_str=~s/,\s*$//;
        my @common_vars_strs = split(/\s*,\s*/,$common_vars_str);
        
        my @common_vars = grep {!/\)$/ } map { s/\(.+$// ;$_} @common_vars_strs ;
		$common_blocks{$common_block_name} =[ @{$common_blocks{$common_block_name}} ,@common_vars ];
    }
    $stref->{'Subroutines'}{$f}{'CommonBlocks'}={  %common_blocks };
    return $stref;
} # END of collect_common_vars_per_block

=pod
We need to identify if there is CommonVarMismatch or not

Given the two lists of common vars, one (the CalledSub one) needs to be a strict subset of the other (CallerSub). And all vars must be the same type and dimension, just the names is not good enough.

If it's the other way round, CallerSub strict subset of CalledSub, then we need to declare the extra vars in the Caller.
=cut

# For every subroutine, see if there is a mismatch with any of the callers.
sub identify_common_var_mismatch {
    my ($stref, $f) = @_;
#    say "CALLED SUB $f";
    if (exists  $stref->{'Subroutines'}{$f}{'Callers'}) {
		my $callers = $stref->{'Subroutines'}{$f}{'Callers'};
		# If there is more than one caller, we must do this for every caller
		for my $caller (sort keys %{ $stref->{'Subroutines'}{$f}{'Callers'} } ) {
#			say "CALLER $caller";	
		    for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} }) {
#		    	say "BLOCK $block";
		    	if (exists $stref->{'Subroutines'}{$caller}{'CommonBlocks'}{$block} ) {
		        my $called_sub_common_vars = $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block};
		        my $caller_sub_common_vars = $stref->{'Subroutines'}{$caller}{'CommonBlocks'}{$block};
#		        $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}{$caller}=0;
		        if (scalar @{$called_sub_common_vars} <= scalar @{$caller_sub_common_vars}) {
		            for my $idx (0 .. scalar @{$called_sub_common_vars} - 1) {
		                my $called_sub_common_var = $called_sub_common_vars->[$idx];
		                my $caller_sub_common_var = $caller_sub_common_vars->[$idx];
#		                say "VARS: $called_sub_common_var $caller_sub_common_var"; 
		                if ($called_sub_common_var eq $caller_sub_common_var) {
		                    my $called_set = in_nested_set($stref->{'Subroutines'}{$f},'CommonVars',$called_sub_common_var);
		                    my $caller_set = in_nested_set($stref->{'Subroutines'}{$caller},'CommonVars',$caller_sub_common_var);
		                    my $called_sub_common_var_decl = $stref->{'Subroutines'}{$f}{$called_set}{'Set'}{$called_sub_common_var};
		                    my $caller_sub_common_var_decl = $stref->{'Subroutines'}{$caller}{$caller_set}{'Set'}{$caller_sub_common_var};
							if (not _compare_decls($stref, $f, $caller, $called_sub_common_var_decl,$caller_sub_common_var_decl) ) {
								$stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}{$caller}=1;
								last;
							}
		                } else {
		                    $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}{$caller}=1;
		                    last;
		                }
		            }
		        } else {
		            $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}{$caller}=1;
		        }
		    	}
		    }
		}
    }
    for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} }) {
    	
    	if (defined $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}) {
    	if (scalar keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block} } > 1 ) {
    		croak "The subroutine $f is called from two differnt callers with mismatched COMMON blocks. Sorry, we're not handling this at the moment.";
    	} else {    	
    		my ( $caller, $one) = each( %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block} });
    		$stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block} = $caller;
    	}
    	}
    }
    return $stref;
} # END of identify_common_var_mismatch

sub _compare_decls { my ($stref, $f1, $f2, $decl1,$decl2,$report) = @_;
#	say Dumper($decl1, $decl2);
	my $names_match = $decl1->{'Name'} eq $decl2->{'Name'};
	return 0 unless $names_match;
	my $types_match = $decl1->{'Type'} eq $decl2->{'Type'};
	return 0 unless $types_match; 
	my $attrs_match = $decl1->{'Attr'} eq $decl2->{'Attr'};
	return 0 unless $attrs_match; 
	my $a_or_s_match = $decl1->{'ArrayOrScalar'} eq $decl2->{'ArrayOrScalar'};
	return 0 unless $a_or_s_match;
	if ($decl1->{'ArrayOrScalar'} eq 'Array') {
		my $dim1= $decl1->{'Dim'}; 
		my $dim2= $decl2->{'Dim'}; 
#		say Dumper($dim1,$dim2);
		my $size1 = __calc_sz($stref,$f1, $dim1);
		my $size2 = __calc_sz($stref,$f2, $dim2);
		my $dims_match = $size1 == $size2;
		return 0 unless $dims_match;
	}		
	return 1;
} # END of _compare_decls

sub __calc_sz {my ($stref, $f, $dim) = @_;
	my @sz_strs=();
	for my $entry ( @{$dim} ) {
		 my $sz_str = '('.$entry->[1].'-'.$entry->[0].'+1)';
		push @sz_strs,$sz_str;		
	}
	my $tot_sz_str = join('*',@sz_strs);
#	say $tot_sz_str ;
	my $size = eval_expression_with_parameters($tot_sz_str,{},$stref,$f);
#	say $size;
	return $size;
} # END of __calc_sz

# Annotate the var with most of the declaration, mostly for type checking while lining up
sub create_common_var_size_tuples {

    my ($stref, $f) = @_;

	for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} } ) {
#		if (exists $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}) {
#			say "MISMATCHED BLOCK $block in $f";
			my @called_sub_common_vars =  @{ $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block} };
			my @common_var_size_tuples = map {
			# This means we will have to match them up, so create the tuples
				my $called_sub_common_var=$_;
				my $called_set = in_nested_set($stref->{'Subroutines'}{$f},'CommonVars',$called_sub_common_var);
				my $called_sub_common_var_decl = $stref->{'Subroutines'}{$f}{$called_set}{'Set'}{$called_sub_common_var};
				my $dim_sz=0;
				my $dim=[];
				if ($called_sub_common_var_decl->{'ArrayOrScalar'} eq 'Array') {
					$dim = $called_sub_common_var_decl->{'Dim'};
					$dim_sz=__calc_sz($stref,$f,$dim), 
				}
				 
				[
					$called_sub_common_var, 
					$called_sub_common_var_decl->{'Type'},
					$called_sub_common_var_decl->{'Attr'},
					$called_sub_common_var_decl->{'ArrayOrScalar'} eq 'Scalar' ? 0 : 1,
					$dim,
					$dim_sz # This is a hack. I should really compare each individual dimension
				];
			} @called_sub_common_vars;
			$stref->{'Subroutines'}{$f}{'CommonBlockSequences'}{$block} = [@common_var_size_tuples];
#		}		
	}

	return $stref;
} # END of create_common_var_size_tuples

sub match_up_common_vars { my ($stref,$f) = @_;
	for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'} }) {
		my $caller = $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block};
		say "MATCHING UP vars in $f and $caller for COMMON block $block"; 
		my @common_var_size_tuples_f = $stref->{'Subroutines'}{$f}{'CommonBlockSequences'}{$block};
		my @common_var_size_tuples_caller = $stref->{'Subroutines'}{$caller}{'CommonBlockSequences'}{$block};
#		say Dumper(@common_var_size_tuples_f,@common_var_size_tuples_caller);
		

	}
	return $stref;
} # END of match_up_common_vars


sub _match_up_common_var_sequences { my ($seq1,$seq2) = @_;
	my @equivalence_pairs=();
	my @common_seq1=@{$seq1};
	my @common_seq2=@{$seq2};
	while (scalar @common_seq1 > 0 and scalar @common_seq2 > 0) { # keep going until one of them is consumed
		my $elt1 = shift  @common_seq1;
		my $elt2 = shift  @common_seq2;
	
			if ($elt1->[1] eq $elt2->[1] and $elt1->[2] eq $elt2->[2]) { # Type and Attr match
					if ($elt1->[0] eq $elt2->[0])  { # same name
						if ($elt1->[3] == $elt2->[3])  { # both array or scalar
							if ($elt1->[3] # both scalars 
							or # arrays with same dims
							$elt1->[5] == $elt2->[5]
							)  {
								# We don't need to create an equivalence for these
							} 
							elsif (!$elt1->[3] and $elt1->[5] != $elt2->[5]) { # arrays of different size
								# we need equivalence but also need to rename the arg one
							}
						}						
					} else { # different names, the easy case. 
						
					}
			} else {
				croak "Type mismatch for ".$elt1->[0].' and '. $elt2->[0];
			}
			# A particular problem arises if the names are the same but the dims are not. I should rename the argument to _ARG
			# It might in fact be better to do this anyway
		
	}
	# Now we need to look at the remainder. If this is in the called sub then it means the common block in the caller must be extended with the size of the remainder.
	# It is not quite clear to me how that could actually be used, but I guess if two subs are called, one extends the common block, then the next one can use this extended common block

	return \@equivalence_pairs;
}

1;