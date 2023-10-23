package RefactorF4Acc::Translation::TyTra::Staging;
#
#   (c) 2016- Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

# Staging is the idea to run a computation until it hits a fold, then prune the graph and run it again, until the graph is reduced entirely.
# The exported routine identify_array_accesses_in_exprs() is only used in Translation::TyTra::DataFlowGraph which is stand-alone.
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw(
	pass_wrapper_subs_in_module					
	);
use RefactorF4Acc::Translation::TyTra::Common qw(
pp_links  
__isMainInArg 
__isMainOutArg  
F3D2C 
F2D2C 
F1D2C 
F4D2C 
);
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );


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

@RefactorF4Acc::Translation::TyTra::Staging::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::Staging::EXPORT_OK = qw(
&find_dataflow_dependencies
);

=info
We look at all fold kernels. For these, we make a dependency list. 
What we want to do is find the folds that do not depend on folds; then the folds that depend on these; etc.

I can do this elegantly, or brute force, it does not really matter I think.

"elegantly" is probably:

* Find an input node (or edge)
* for every input, follow it (rec descent) until you hit the first fold but not further. 
Store that fold (and the paths?)

Then prune everything leading up to each of these, so the fold outputs will be the new inputs. 

Then repeat the algorithm, and do this until there are no folds left.

The result is the stages: each stage is a set of folds. 
Their dependencies are already known from the first stage. 
When we run such a stage, we need to store the outputs of the folds and use them as inputs for the next stage. 
So the pruned graphs are the stages.

----

When we've finally collected all kernels for all stages, what we need to do is 
annotate the inputs and outputs with the stages in which they should resp. read and write.
I think this only really matters for the outputs
So for every output we need to check if it is connected to a mode in the set for a given stage.
I fnot, it should not be written to. 
The annotation is simply the set of stages where it is OK to write.

----
I realise I also need the StencilDef nodes in Nodes, just so that at the end we can include them via EntryID


=cut


# * Find an input node (or edge)
# * for every input, follow it (rec descent) until you hit the first fold but not further. 
# Store that fold (and the paths?)
sub find_stages { my ($ast) = @_;
    my $graph_has_folds = () = grep { $_->{'NodeType'} eq 'Fold'} sort keys %{$ast->{'Nodes'}};
    my $nodes =dclone($ast->{'Nodes'});
    my $stage=0;
    while($graph_has_folds) {
        my $folds_in_stage={};
        for my $node (sort keys %{$nodes}) {
            my $entry = $nodes->{$node};
            if ($entry->{'NodeType'} eq 'Input') {
                $folds_in_stage = _find_folds_for_stage_rec($folds_in_stage, $ast, $node);
                # I think I should now delete this Input node
                delete $nodes->{$node};
            }            
        }
        $ast->{'Stages'}{$stage}=$folds_in_stage;
        # Now prune the graph
        # What this means is that for every fold in the stage, the output should become an Input edge
        # In this way, the next iteration will start from those inputs
        # So 
        for my $fold (sort keys %{$folds_in_stage}) {
            for my $fold_out_net (@{ $nodes->{$fold}{'Outputs'} } ) {
                $nodes->{$fold_out_net}={
                        'NodeType' => 'Input',
                        'EntryID' => -1,
                        'Inputs' => [],
                        'Outputs' => [$fold_out_net],
                        'Dependencies' => {}
                    };        
            }
        }

        $stage++;
    }
    return $ast;
}


            # We know the node is an edge as well, so we look up its 'To' in 'Nets'
            # There can be more than one
            # This must become a recursive function
sub _find_folds_for_stage_rec { my ($folds_in_stage, $ast, $node) = @_;                        
    for my $entry ( @{ $ast->{'Nets'}{$node}{'To'} }) {
        # {'Name'=>$f,'EntryID'=>$entry_id,'NodeType'=>$node_type};
        my $f = $entry->{'Name'};
        if ($entry->{'NodeType'} eq 'Fold') {                    
            # found a fold, store it
            $folds_in_stage->{$f}={};
        } else {
            # This is either a Map, StencilAppl or Output
            if ($entry->{'NodeType'} ne 'Output') {
                # rec descent
                $folds_in_stage = _find_folds_for_stage_rec($folds_in_stage,$ast, $f);
            }                    
        }
    }
    return $folds_in_stage;
}

1;
