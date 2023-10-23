# Eliminate redundant expressions and blocks
package RefactorF4Acc::Refactoring::EliminateDeadCode;
use v5.10;
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

@RefactorF4Acc::Refactoring::EliminateDeadCode::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::EliminateDeadCode::EXPORT_OK = qw(
  &pass_eliminate_dead_code
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

1;
