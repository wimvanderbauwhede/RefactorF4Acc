# Eliminate redundant expressions and blocks
package RefactorF4Acc::Refactoring::EliminateDeadCode;
use v5.30;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw(
  pass_wrapper_subs_in_module
  stateless_pass
  get_annotated_sourcelines
);
use RefactorF4Acc::Refactoring::Fixes qw(
  remove_redundant_arguments_and_fix_intents
);
use RefactorF4Acc::Refactoring::RemoveRedundantAssignments qw(
  remove_redundant_assignments
);
use RefactorF4Acc::Analysis::DeadCodeElimination qw( analyse_for_dead_code );
use RefactorF4Acc::Emitter qw( emit_AnnLines );

#
#   (c) 2021 Wim Vanderbauwhede <wim.vanderbauwhede@glasgow.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

no warnings qw(experimental::signatures);
use feature qw(signatures);

@RefactorF4Acc::Refactoring::EliminateDeadCode::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::EliminateDeadCode::EXPORT_OK = qw(
  &pass_eliminate_dead_code
  &eliminate_if_const_cond
);

sub pass_eliminate_dead_code {
    ( my $stref, my $code_unit_name ) = @_;

    $Config{'FIXES'}{'remove_redundant_arguments_and_fix_intents'} = 1;
    $Config{'FIXES'}{'_remove_unused_variables'}                  = 1;
    $stref = pass_wrapper_subs_in_module(
        $stref,
        '',
        # module-specific passes
        [],
        # subroutine-specific passes
        [
            [
                sub {
                    ( my $stref, my $f ) = @_;
                    alias_ordered_set( $stref, $f, 'RefactoredArgs',
                        'DeclaredOrigArgs' );
                }
            ],

    # This is mostly to work around bugs in the AutoParallelFortran compiler
    # All Fixes are off by default, list them in $Config{'FIXES'} to enable them
            [ \&remove_redundant_arguments_and_fix_intents ],
            [ \&remove_redundant_assignments ],
            [ \&analyse_for_dead_code],
            [ \&_eliminate_dead_code]
        ]
    );

    # This enables the postprocessing for custom passes
    $stref->{'CustomPassPostProcessing'} = 1;

    return $stref;
} # END of pass_eliminate_dead_code

# Removing unused variables can lead to empty if-then and do blocks
# Analysis/DeadCodeElimination/analyse_for_dead_code marks the lines with $info->{'DeadCode'}
# So all we need to do is filter out those lines using a stateless pass.
sub _eliminate_dead_code { (my $stref, my $f)=@_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $pass__eliminate_dead_code = sub {  my ($annline) = @_;
            my ($line, $info) = @{$annline};
            # Not happy about this: why was this comment dead code, but the first one wasn't?
            if (exists $info->{'DeadCode'} ) {#and not exists $info->{'Comments'}
                say "REMOVING dead code: $line" if $DBG;
                $info->{'Deleted'} = 1;
            }
            return [[$line,$info]]
    };
    my $annlines = get_annotated_sourcelines( $stref, $f );
    my $new_annlines = stateless_pass($annlines, $pass__eliminate_dead_code, 'pass__eliminate_dead_code', 0);
    $Sf->{'RefactoredCode'} = $new_annlines;
    return $stref;
} # END of _eliminate_dead_code



sub eliminate_if_const_cond( $stref, $f ) {
    say "\neliminate_if_const_cond($f)\n" if $DBG;
    # local $DBG=1;
    my $refactored_annlines = [];
    my $is_dead_code = 0;
    my $if_stacks=[[]];
    my $if_counter=0;
    my $annlines = get_annotated_sourcelines($stref,$f);
    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};
        if ($DBG) {
            say "\nLINE: $line";
            local $Data::Dumper::Indent = 0;
            say 'BEFORE: ',$is_dead_code,';',Dumper( $if_stacks->[$if_counter]),' ',$if_counter;
        }
        if (exists $info->{'If'} and not exists $info->{'IfThen'}) {
            say "IF without THEN " if $DBG;
            if ($is_dead_code) {
                $info->{'DeadCode'}=1;
            } else {
              my $cond_is_const = $info->{'Cond'}{'AST'}[0] == 31;
              if ($cond_is_const) {
                  if ( $info->{'Cond'}{'AST'}[1] eq '.true.') {
                      delete $info->{'If'}
                  }
                  elsif ( $info->{'Cond'}{'AST'}[1] eq '.false.' ) {
                      #delete IF line
                      $info->{'DeadCode'}=1;
                  }
              }
            }
        }
        elsif (exists $info->{'IfThen'} and not exists $info->{'ElseIf'}) {
            say "IF $if_counter" if $DBG;
            ++$if_counter;
            if ($is_dead_code) {
                $info->{'DeadCode'}=1;
                push @{$if_stacks->[$if_counter]}, 'DeadIf';
            } else {
                my $cond_is_const = $info->{'Cond'}{'AST'}[0] == 31;
                if ($cond_is_const) {
                    if ( $info->{'Cond'}{'AST'}[1] eq '.true.') {
                        #delete IF line
                        $info->{'DeadCode'}=1;
                        push @{$if_stacks->[$if_counter]}, 'IfTrue';
                        $is_dead_code=0;

                    }
                    elsif ( $info->{'Cond'}{'AST'}[1] eq '.false.' ) {
                        #delete IF line
                        $info->{'DeadCode'}=1;
                        push @{$if_stacks->[$if_counter]}, 'IfFalse';
                        $is_dead_code=$if_counter;
                    }
                } else {
                    push @{$if_stacks->[$if_counter]}, 'If';
                }
            }
        }
        elsif (exists $info->{'ElseIf'}) {
            my $case = pop @{$if_stacks->[$if_counter]};
            say "ELSE IF CASE: $case" if $DBG;
            if ($is_dead_code and ($case eq 'If' or $case eq 'DeadIf')) {
                $info->{'DeadCode'}=1;
                push @{$if_stacks->[$if_counter]}, 'DeadIf';
            } else {
                my $change_elseif_to_if=0;
                if ($case eq 'IfTrue') {
                    $info->{'DeadCode'}=1;
                    $is_dead_code=$if_counter;
                }
                elsif ($case eq 'IfFalse') {
                # change ElseIf to If
                    $change_elseif_to_if=1;
                    delete $info->{'ElseIf'};
                    $info->{'If'}=1;
                    $is_dead_code=0;
                }
                else {
                # else push the If back on the stack
                    push @{$if_stacks->[$if_counter]}, 'If';
                    $is_dead_code=0;
                }
                if (!$is_dead_code){
                    my $cond_is_const = $info->{'Cond'}{'AST'}[0] == 31;
                    if ($cond_is_const) {
                        if ( $info->{'Cond'}{'AST'}[1] eq '.true.') {
                            if ($case eq 'If') {
                                delete $info->{'ElseIf'};
                                $info->{'Else'}=1;
                            } else {
                                #delete IF line
                                $info->{'DeadCode'}=1;
                            }
                            push @{$if_stacks->[$if_counter]}, 'IfTrue';
                            $is_dead_code=0;
                        }
                        elsif ( $info->{'Cond'}{'AST'}[1] eq '.false.' ) {
                            if ($case eq 'If') {
                                delete $info->{'ElseIf'};
                                delete $info->{'IfThen'};
                                $info->{'Else'}=1;
                            } else {
                                $info->{'DeadCode'}=1;
                            }
                            push @{$if_stacks->[$if_counter]}, 'IfFalse';
                            $is_dead_code=$if_counter;
                        }
                    } else {
                        push @{$if_stacks->[$if_counter]}, 'If';
                    }
                } else {
                    push @{$if_stacks->[$if_counter]}, 'DeadIf';
                }
            }
        }
        elsif (exists $info->{'Else'}) {
            my $case = pop  @{$if_stacks->[$if_counter]};
            say "ELSE CASE: $case" if $DBG;
            if ($is_dead_code) {
                $info->{'DeadCode'}=1;
                if ($case ne 'IfFalse') {
                    push @{$if_stacks->[$if_counter]}, 'DeadIf';
                } else {
                    $is_dead_code=0;
                    push @{$if_stacks->[$if_counter]}, 'IfTrue';
                }
            } else {
                if ($case eq 'IfTrue') {
                    $info->{'DeadCode'}=1;
                    $is_dead_code=$if_counter;
                }
                elsif ($case eq 'IfFalse') {
                    $info->{'DeadCode'}=1;
                    $is_dead_code=0;
                }
                else {
                    # else push the If back on the stack
                    push @{$if_stacks->[$if_counter]}, 'If';
                }
                push @{$if_stacks->[$if_counter]}, 'IfTrue';
            }
        }
        elsif (exists $info->{'EndIf'}) {
            my $case = pop @{$if_stacks->[$if_counter]};
            say "END IF CASE: $case" if $DBG;
            if ($is_dead_code) {
                say 'STACK: ',Dumper( $if_stacks),' ',$if_counter  if $DBG;
                my $stack_has_if = 0;
                for my $case (@{$if_stacks->[$if_counter]}) {
                  if ($case eq 'If') {
                    $stack_has_if = 1;
                    last;
                  }
                }

                # Dead Code region always extends beyond DeadIf
                # If extends beyond anything else iff $is_dead_code < $if_counter
                if ( $case ne 'DeadIf' or $is_dead_code == $if_counter) {
                    $is_dead_code=0;
                } 
                if (!$stack_has_if) {
                    $info->{'DeadCode'}=1;
                } else {
                    say 'STACK has IF, keep END IF'  if $DBG;
                }
            } else {
                my $stack_has_if=0;
                for my $case (@{$if_stacks->[$if_counter]}) {
                  if ($case eq 'If') {
                    $stack_has_if = 1;
                    last;
                  }
                }
                # for my $st (@{$if_stacks}) {
                #     if (scalar @{$st}>0 and $st->[0] eq 'If') {
                #         $stack_has_if=1;last;
                #     }
                # }
                if ($case ne 'If' and !$stack_has_if) {
                    $info->{'DeadCode'}=1;
                }
                $is_dead_code=0;
            }
            $if_stacks->[$if_counter]=[];
            --$if_counter;
        } elsif ($is_dead_code) {
            $info->{'DeadCode'}=1;
        }

        say 'AFTER: ',$is_dead_code,';',Dumper( $if_stacks->[$if_counter]),' ',$if_counter if $DBG;

        if ( not exists $info->{'DeadCode'}) {
            push @{$refactored_annlines},[$line,$info]
        } elsif ($DBG) {
            say "LINE $line is DEAD CODE";
        }
    }

    my $mod_sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$mod_sub_or_func}{$f};
    $Sf->{'RefactoredCode'} = $refactored_annlines;
	$stref = emit_AnnLines($stref,$f,$Sf->{'RefactoredCode'});
	say "eliminate_if_const_cond: CODE UNIT $f: ", Dumper pp_annlines($Sf->{'RefactoredCode'}) if $DBG;

    return $stref;

} # END of eliminate_if_const_cond

1;
