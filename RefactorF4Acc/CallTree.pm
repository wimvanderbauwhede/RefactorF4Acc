package RefactorF4Acc::CallTree;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
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

@RefactorF4Acc::CallTree::ISA = qw(Exporter);

@RefactorF4Acc::CallTree::EXPORT_OK = qw(
    &create_call_tree
    &add_to_call_tree
);

# -----------------------------------------------------------------------------

=info_break_cycles
To break cycles, I see only one way: we must keep track of the call chain and
as soon as there is a duplication, we stop.
But we must clear this list when we reach a leaf. Which means that
@{ $stref->{'CallTree'}{ $subname } } has no entries

if (exists $stref->{'CallTree'}{ 'Chain'} {$entry} ) {
	$stref->{'CallTree'}{ 'Chain'}={};
	last;
} else {
$stref->{'CallTree'}{ 'Chain'} {$entry}++
}

=cut

sub create_call_tree { ( my $stref, my $subname ) = @_;	
    push @{ $stref->{'CallStack'} }, $subname;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} }; 
    for my $entry ( @{ $stref->{'CallTree'}{ $subname } } ) {
        if (exists $subs{$entry}) {
        	push @{$stref->{'PPCallTree'}}, "Found LOOP for $entry\n";
    	   last;
        }

	    	my $str = _format_call_tree_line($entry,$stref);
	    	push @{$stref->{'PPCallTree'}}, $str;
	    	
	    	   $stref->{'Indents'} += 4;    	
	    	   create_call_tree ($stref,$entry);
	    	   $stref->{'Indents'} -= 4;
    }
    pop  @{ $stref->{'CallStack'} };
    return $stref;
} # END of create_call_tree()
# -----------------------------------------------------------------------------
sub create_dot_call_tree {
    ( my $stref ) = @_;

    open my $DOT, '>', 'callgraph.dot';
    print $DOT 'digraph FlxWrf {
node [shape=box];
rankdir="LR";
ratio="fill";
';
    for my $pnid ( keys %{ $stref->{'Nodes'} } ) {
        my %seen = ();
        my $i    = 0;
        for my $cnid ( @{ $stref->{'Nodes'}{$pnid}{'Children'} } ) {

            # Repeated calls to subs without children are pruned
            if ( scalar( @{ $stref->{'Nodes'}{$cnid}{'Children'} } ) != 0
                or not exists $seen{ $stref->{'Nodes'}{$cnid}{'Subroutine'} } )
            {
                my $psub = $stref->{'Nodes'}{$pnid}{'Subroutine'};
                my $csub = $stref->{'Nodes'}{$cnid}{'Subroutine'};
                print $DOT "$cnid [label=\"$csub\"];\n";
                if ( $i == 0 ) {
                    print $DOT "$pnid [label=\"$psub\"];\n";
                }
                print $DOT "$pnid -> $cnid ;\n";
            }
            $seen{ $stref->{'Nodes'}{$cnid}{'Subroutine'} }++;
            $i++;
        }
#       my $sub = $stref->{'Nodes'}{$pnid}{'Subroutine'};
#
        #        print $DOT "$pnid [label=\"$sub\"];\n";
    }
    print $DOT "}\n";
    close $DOT;
}

# -----------------------------------------------------------------------------

sub add_to_call_tree {
    ( my $f, my $stref, my $p) = @_;
    push @{ $stref->{'CallTree'}{$p} }, $f;
    return $stref;
}    # END of add_to_call_tree()
# -----------------------------------------------------------------------------
sub _format_call_tree_line {
	(my $f, my $stref ) = @_;
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $src         = $stref->{$sub_or_func}{$f}{'Source'};
    if (not defined $src) {
    	$src='<unknown source>';
    }
    my $nspaces     = 64 - $stref->{'Indents'} - length($f); # -length($src) -2;
    my $incls = join( ',', keys %{ $stref->{$sub_or_func}{$f}{'Includes'} } );
    my $padding = ' ' x ( 32 - length($src) );
    my $src_padded = $src . $padding;
    my $tgt        = uc( substr( $sub_or_func, 0, 3 ) );
    my @strs       = (
        ' ' x $stref->{'Indents'},
        $f, 
        ' ' x $nspaces,
        $tgt, ' ', $src_padded, "\t", $incls, "\n"
    );
    my $str = join( '', @strs );
	
	return $str;
}