package RefactorF4Acc::Translation::TyTra::Staging;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw(
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
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Translation::TyTra::Staging::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::Staging::EXPORT_OK = qw(
&find_dataflow_dependencies
);


# For every kernel, we look at its inputs and make a list of the kernels that provide those inputs, noting if they are vec or scalar and if the kernels are map or fold. We also note non-kernel inputs 
sub find_dataflow_dependencies { my ($stref)=@_;
    my $ast = $stref->{'TyTraCL_AST'};
    $ast->{'Dependencies'}={};
    my $entry_id=0;
    # We use the $ast->{''} AST with StencilAppl 
    for my $entry (@{ $ast->{'Lines'} }) {

        if ($entry->{'NodeType'} eq 'Map'
        or $entry->{'NodeType'} eq 'Fold'
        ) {
            $ast = _find_deps_rec($ast,$entry_id,$entry->{'Rhs'}{'Function'});
        }
        $entry_id++;
    }
    return $stref;
}
sub _find_deps_rec { my ($ast,$entry_id, $f) = @_;
    my @inputs=();
    my $entry = $ast->{'Lines'}[$entry_id];
    my $node_type=$entry->{'NodeType'};
    if ($node_type eq 'Map') {
        
    # Inputs are Rhs NonMapArgs and Rhs MapArgs
    }
    elsif ($node_type eq 'Fold') {
    # Inputs are Rhs NonFoldArgs and Rhs FoldArgs and presumably Rhs AccArgs   
    }
    if (@inputs) {
        for my $input_net_name (@inputs) {
        # In the 'Nets' part of the AST we look up the 'From' field
        # I guess the best way is to make this the index into Lines
            my $dep_entry_id = $ast->{'Nets'}{$input_net_name}{'From'}{'EntryID'};
            my $dep_entry = $ast->{'Lines'}[$dep_entry_id];
            my $dep_node_type=$dep_entry->{'NodeType'};
            my $g = $dep_entry->{'Rhs'}{'Function'};
            $ast->{'Dependencies'}{$f}{$g}=$dep_node_type;
            if ($entry_id>=0) {
                $ast = _find_deps_rec($ast,$entry_id,$f);
            } else {
                return $ast;
            }
        }
    }
}




1;
