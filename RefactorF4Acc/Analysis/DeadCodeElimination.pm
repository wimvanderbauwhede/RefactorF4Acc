package RefactorF4Acc::Analysis::DeadCodeElimination;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw( sub_func_incl_mod );
use RefactorF4Acc::Refactoring::Helpers qw(
  get_annotated_sourcelines
);

# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Analysis::DeadCodeElimination::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::DeadCodeElimination::EXPORT_OK = qw(
    &analyse_for_dead_code
);

=info
I want a flexible way to optimise away dead code. 
Basically, I go through the code and register when I find e.g. a Do or If, and then and EndDo or EndIf. 
If in between there are only comments, then all that can be removed. 
Actually, if there are no assignments or subroutine calls, the code can be removed.

WV20211208 This does not go far enough. In a subroutine, any non-arg variable assigned to but not read is redundant
and can be eliminated. So if we find an assignment or a subroutine/function call where the var is Out or InOut,
we check if that var is used further in the code unit. If not, it is redundant.

I have the basic analysis for this in Refactoring/Fixes.pm

We need a better handling of if statements:

* If -> EndIf => remove If; remove Endif
* If -> Else => remove If; the Else should become an If (.not. () )
If -> ElseIf => remove If; ElseIf becomes If
* ElseIf -> Endif => remove ElseIf
* ElseIf -> Else => remove ElsIf
* Else -> EndIf => remove Else
* ElseIf -> ElseIf => remove ElseIf; ElseIf becomes If

So the first one can always be removed

So we need to keep track of the previous keyword in the If statement
And that has to be done across a stack:

If => push on stack: [If]
ElseIf => pop; push: [ElseIf]
    If => push: [If,ElseIf]
    Else => pop; push: [Else,ElseIf]
    Endif => pop: [ElseIf]
Else => pop;push: [Else]

=cut


sub analyse_for_dead_code {
( my $stref, my $f ) = @_; # This could also be a subroutine I guess,
say "\nAnalysis::analyse_for_dead_code($f)\n" if $DBG;
    my $refactored_annlines     = [];
    my $dead_code_regions={};
    my $dead_code_stack=[];
    my $if_block_counter=0;
    my $do_block_counter=0;
    my $maybe_dead_code = 0;
    my $if_keyword_stack = [];    
    
    my $annlines = get_annotated_sourcelines($stref,$f);
    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};
        # say "LINE: $line";
        if (exists $info->{'If'} ) { 
            $if_block_counter++;    
            if (!$maybe_dead_code) { 
                $maybe_dead_code = 1;
            }
            push @{ $if_keyword_stack },['If',$info];
        }    
        if (exists $info->{'Else'} or exists $info->{'ElseIf'}) {
            # say "Else/ElseIf LINE:$line";
             # This should behave as a combination between end if and if
             
            $if_block_counter--;
            if ($if_block_counter==0) {
                if (@{$dead_code_stack} > 0) {
                    # croak Dumper $dead_code_stack;
                    for my $dead_code_annline (@{$dead_code_stack}) {
                        say 'DEAD CODE: ',$dead_code_annline->[0];
                        my $dead_code_info = $dead_code_annline->[1];
                        $dead_code_regions->{$dead_code_info->{'LineID'}}= $dead_code_info;
                    }
                    $dead_code_stack=[];
                }
            }
            $if_block_counter++;    
            if (!$maybe_dead_code) { 
                $maybe_dead_code = 1;
            }
            my $prev_if_keyword = pop @{ $if_keyword_stack };
            if ($prev_if_keyword->[0] ne 'Live' ) {
                $dead_code_regions->{$prev_if_keyword->[1]{'LineID'}} = $prev_if_keyword->[1];
                if  ($prev_if_keyword->[0] eq 'If' and exists $info->{'Else'}) {
                    # If/Else
                    # die 'Else -> If Not: ', Dumper $info;
                    my $line_id = $info->{'LineID'};
                    my $expr = '.not. ( '.  $prev_if_keyword->[1]{'Cond'}{ 'Expr'} .' ) ';
                    $line =~s/else.*$/if/;
                    $line.= ' ( '.$expr.') then';
                    $info = dclone($prev_if_keyword->[1]);
                    $info->{'Cond'}{ 'Expr'} = $expr;
                    $info->{'LineID'} = $line_id;
                    $annline=[$line,$info];
                }
                elsif  ($prev_if_keyword->[0] eq 'ElseIf' and exists $info->{'Else'}) {
                    # do nothing
                }
                elsif  (
                    ($prev_if_keyword->[0] eq 'If' 
                    or $prev_if_keyword->[0] eq 'ElseIf')
                    and exists $info->{'ElseIf'}) {                    
                    delete $info->{'ElseIf'};
                    $info->{'If'}=1;
                    $line=~s/else\s+//;
                    $annline=[$line,$info];
                }
            }
            push @{ $if_keyword_stack }, [(exists $info->{'Else'} ? 'Else' : 'ElseIf'),$info];
         }
        if (exists $info->{'Do'} ) {
            $do_block_counter++;    
            if (!$maybe_dead_code) { 
                $maybe_dead_code = 1;
            }    
            # if ($do_block_counter>1){
            #     say "LINE: $line ".$info->{'LineID'};
            #     push @{$dead_code_stack}, $annline;
            # }
        }    
        
        if (exists $info->{'EndIf'} ) {
            $if_block_counter--;
            if ($if_block_counter==0) {
                if (@{$dead_code_stack} > 0) {
                    for my $dead_code_annline (@{$dead_code_stack}) {
                        my $dead_code_info = $dead_code_annline->[1];                        
                        $dead_code_regions->{$dead_code_info->{'LineID'}}= $dead_code_info;
                    }
                    $dead_code_stack=[];
                }
            }
            my $prev_if_keyword = pop @{ $if_keyword_stack };
            if ($prev_if_keyword->[0] ne 'Live' ) {
                $dead_code_regions->{$prev_if_keyword->[1]{'LineID'}} = $prev_if_keyword->[1];
                if ($prev_if_keyword->[0] eq 'If' ) {
                    $dead_code_regions->{$info->{'LineID'}} = 'EndIf';
                }
            }
        }    
        
        if (exists $info->{'EndDo'} ) {
            $do_block_counter--;   
            if ($do_block_counter==0) {
                say "MAYBE FINAL DEAD LINE: $line ".$info->{'LineID'} if $DBG;
                push @{$dead_code_stack}, $annline;
                if (@{$dead_code_stack} > 1) { # because we just pushed that line
                    for my $dead_code_annline (@{$dead_code_stack}) {
                        say "STACK: ". $dead_code_annline->[0]."\t".$dead_code_annline->[1]{'LineID'} if $DBG;
                        my $dead_code_info = $dead_code_annline->[1];
                        $dead_code_regions->{$dead_code_info->{'LineID'}}= $dead_code_info;
                    }
                    $dead_code_stack=[];
                }
                $maybe_dead_code = 0; # WV: check
            } 
        }    
        
        if (not exists $info->{'Assignment'} and not exists $info->{'SubroutineCall'} 
            and $maybe_dead_code) {
            say "MAYBE DEAD LINE: $line ".$info->{'LineID'} if $DBG;
            push @{$dead_code_stack}, $annline;
        } else {
            say "NOT DEAD CODE: ".$line . ' => clear stack: '.Dumper $dead_code_stack if $DBG;
            $dead_code_stack=[];
            $maybe_dead_code = 0;
            my $prev_if_keyword = pop @{ $if_keyword_stack };
            push @{ $if_keyword_stack }, ['Live',$info];

        } 
    }
    
    # So when we encounter a line with LineID in $dead_code_regions, we label it with 'DeadCode' so we can remove it later
    for my $annline ( @{ $annlines } ) {
        ( my $line, my $info ) = @{$annline};
        if (exists $dead_code_regions->{$info->{'LineID'}}) {
            $info->{'DeadCode'}=1;
            say "DEAD CODE LINE: $line on ".$info->{'LineID'}  if $DBG;
        }
        push @{$refactored_annlines},[$line,$info];
    }

#    return $refactored_annlines; # Or maybe we assign this to a slot in $stref


    my $mod_sub_or_func = sub_func_incl_mod( $f, $stref );
    $stref->{$mod_sub_or_func}{$f}{'AnnLines'} = $refactored_annlines;    
    return $stref;
} 

=info 
Another nice thing to do is constant detection and then replacing if() by #if 
=cut
1;
