package RefactorF4Acc::Analysis::DeadCodeElimination;

use RefactorF4Acc::Config;
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Analysis::DeadCodeElimination::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::DeadCodeElimination::EXPORT = qw(
    &analyse_for_dead_code
);

=info
I want a flexible way to optimise away dead code. Basically, I go through the code and register when I find e.g. a Do or If, and then and EndDo or EndIf. If in between there are only comments, then all that can be removed. Actually, if there are no assignments or subroutine calls, the code can be removed.
=cut


sub analyse_for_dead_code {
( my $stref, my $f ) = @_; # This could also be a subroutine I guess,
    my $refactored_annlines     = [];
    my $dead_code_regions={};
        my $dead_code_stack=[];
        my $if_block_counter=0;
        my $do_block_counter=0;
        my $maybe_dead_code = 0;
    
    my $mod_sub_or_func = sub_func_incl_mod( $f, $stref );
    for my $annline ( @{ $stref->{$mod_sub_or_func}{$f}{'AnnLines'} } ) {
        ( my $line, my $info ) = @{$annline};
        
        if (exists $info->{'If'} ) {
            $if_block_counter++;    
            if (!$maybe_dead_code) { 
                $maybe_dead_code = 1;
            }    
        }    
        
        if (exists $info->{'Do'} ) {
            $do_block_counter++;    
            if (!$maybe_dead_code) { 
                $maybe_dead_code = 1;
            }    
        }    
        
        if (exists $info->{'EndIf'} ) {
            $if_block_counter--;
            if ($if_block_counter==0) {
                if (@{$dead_code_stack} > 0) {
                    for my $dead_code_info (@{$dead_code_stack}) {
                        $dead_code_regions->{$dead_code_info->{'LineID'}}= $dead_code_info;
                    }
                    $dead_code_stack=[];
                }
            }        
        }    
        
        if (exists $info->{'Do'} ) {
            $do_block_counter--;   
            if ($do_block_counter==0) {
                if (@{$dead_code_stack} > 0) {
                    for my $dead_code_info (@{$dead_code_stack}) {
                        $dead_code_regions->{$dead_code_info->{'LineID'}}= $dead_code_info;
                    }
                    $dead_code_stack=[];
                }
            }             
        }    
        
        if (not exists $info->{'Assignment'} and not exists $info->{'SubroutineCall'}) {
            push @{$dead_code_stack}, $info;
        } else {
            $dead_code_stack=[];
            $maybe_dead_code = 0;
        } 
    }
    
    # So when we encounter a line with LineID in $dead_code_regions, we label it with 'DeadCode' so we can remove it later
    for my $annline ( @{ $stref->{$mod_sub_or_func}{$f}{'AnnLines'} } ) {
        ( my $line, my $info ) = @{$annline};
        if (exists $dead_code_regions->{$info->{'LineID'}}) {
            $info->{'DeadCode'}=1;
        }
        push @{$refactored_annlines},[$line,$info];
    }
#    return $refactored_annlines; # Or maybe we assign this to a slot in $stref
    $stref->{$mod_sub_or_func}{$f}{'AnnLines'} = $refactored_annlines;    
    return $stref;
} 

=info
Furthermore, I want to remove unused variables.
A variable is unused if:
- It's an In argument but it does not get read, i.e. appears on RHS or in subroutine call
- It's an Out or InOut but it does not get assigned (which means I have to look inside any called functions as well)
- It's a local variable that never appears on the RHS or in a subroutine call
- If it does appear in a subroutine call, I need to establish that the corresponding variable in the subroutine is unused
So we must do these checks recursively for all variables in a subroutine.
=cut

sub find_unused_variables {
    
}

=info 
Another nice thing to do is constant detection and then replacing if() by #if 
=cut
1;
