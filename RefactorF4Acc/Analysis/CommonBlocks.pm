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
);

# To go in Parser.pm
#$stref->{'Subroutines'}{$f}{'CommonBlocks'} = {};

#if ( $stref->{'Subroutines'}{$f}{'HasLocalCommons'}) {
#    if ($stref->{'Subroutines'}{$f}{'CommonVarMismatch'}) {
#        _match_up_common_vars($stref,$f);
#    }
#}




sub _match_up_common_vars { my ($stref,$f) = @_;
    # Assuming per code unit CommonBlocks has per block a list of pairs  
    # and top-level CommonBlocks has per block a max size
#	my $max_sz=0; #TODO
#    $stref->{'CommonBlocks'}{$common_block_name}=$max_sz;
#    $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$common_block_name}=[[$var,$sz],...];

   return $stref;
}

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

1;