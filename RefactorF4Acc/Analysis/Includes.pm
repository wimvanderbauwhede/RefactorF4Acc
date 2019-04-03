package RefactorF4Acc::Analysis::Includes;
use v5.10;
=info
In Fortran-77, if a file with common blocks is included in a subroutine, the common variables are visible in called subroutines, even if these don't include that file.
To determine which common variables are actually used by a subroutine, we perform the following analysis.
=cut
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
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

use RefactorF4Acc::Parser qw( parse_fortran_src );

use Exporter;

@RefactorF4Acc::Analysis::Includes::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Includes::EXPORT_OK = qw(
    &find_root_for_includes    
);

# This routine is called after the subroutines have been parsed, and the call graph has been created.
# The "root for includes" algorithm intends to find the subroutine where the include should be placed
sub find_root_for_includes {
    ( my $stref, my $f ) = @_;

    $stref = _create_include_chains( $stref, 1 );  # assumes we start at node 1 in the tree. Typically that is the main program.

    # This just goes through all include files. If an include file was inlined and not included on its own anywhere in the source
    # this would of course mean it has no root.
    # As we now inline the nested includes, only includes in subs should be processed here
    # And then even only these that are included in the subs in the SOURCEFILES if that is specified. 
    for my $inc ( keys %{ $stref->{'IncludeFiles'} } ) {
       say "Finding ROOT for $inc starting from $f" if $V;
        next if $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'External';
        if ($stref->{'IncludeFiles'}{$inc}{'Status'}==$UNREAD) {
            croak "TROUBLE: $inc (in $f) not yet parsed, how come? (Hint: likely the tree contains refactored sources)";
                $stref->{'IncludeFiles'}{$inc}{'HasBlocks'} = 0;
                $stref = parse_fortran_src( $inc, $stref );   
        }
        if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common' ) {
            $stref = _find_root_for_include( $stref, $inc, $f );
            print "ROOT for $inc is "
              . $stref->{'IncludeFiles'}{$inc}{'Root'} . "\n"
              if $V; 
        } elsif ($V) {
        	say "$inc not COMMON, skipped";
        }
    }
    
    return $stref;
}    # END of find_root_for_includes()

# -----------------------------------------------------------------------------
=pod

`_find_root_for_include()` is called for every include file in IncludeFiles, after `_create_include_chains()` has created all the chains; 
by 'chain' we mean a path in the call tree where every node contains the include for its child nodes.
The purpose of this routine is to prune the paths, i.e. remove includes from nodes that don't need them.
The algorithm is as follows: 
- compare Includes with CommonIncludes.
    - if an inc is only in CommonIncludes, it is inherited
    - the node needs to keep it either
        - it has more than one child node
        - it contains a call to a refactored subroutine which contains the include  
    - any other case, just remove the include
=cut
sub _find_root_for_include {
    ( my $stref, my $inc, my $sub ) = @_;
     local $V=1;
    my $Ssub = $stref->{'Subroutines'}{$sub};
    
    
    if ( exists $Ssub->{'Includes'}{$inc} ) {
        # Not inherited
        say "_find_root_for_include: $inc not inherited in $sub" if $DBG;
        $stref->{'IncludeFiles'}{$inc}{'Root'} = $sub;
    } else {
        # Inherited
        say "_find_root_for_include: $inc inherited in $sub" if $DBG; 
        # $sub is (currently) not 'Root' for $inc
        my $nchildren   = 0;
        my $singlechild = '';
        for my $called_sub_or_entry ( @{ $Ssub->{'CalledSubs'}{'List'} } ) {
			my $calledsub = $called_sub_or_entry; 
			if (exists  $stref->{'Entries'}{$called_sub_or_entry} ) {
				$calledsub = $stref->{'Entries'}{$called_sub_or_entry};
			}        	
        	next if exists $stref->{'ExternalSubroutines'}{$calledsub}; # Don't descend into external subs   
            if ( exists $stref->{'Subroutines'}{$calledsub}{'CommonIncludes'}{$inc} ) {
                $nchildren++;
                $singlechild = $calledsub;
            }
        }
        if ( $nchildren == 0 ) {
        	# This just means that $inc is not included in any non-external subroutine.
        	print  "_find_root_for_include(): $inc included in <" if $DBG;
        	say join(',',keys %{ $stref->{'IncludeFiles'}{$inc}{'IncludedFrom'}}),'>' if $DBG;
        	# TODO: check if the include is included in any non-external subroutine.
#            die "_find_root_for_include(): Can't find $inc in parent $sub or any children, something's wrong!\n";
            
        } elsif ( $nchildren == 1 and $Ssub->{'RefactorGlobals'}==0) {
            delete $Ssub->{'CommonIncludes'}{$inc};
            _find_root_for_include( $stref, $inc, $singlechild );
                    
        } else {            
            # head node is root
            $stref->{'IncludeFiles'}{$inc}{'Root'} = $sub;
        }
    }
    return $stref;
}    # END of _find_root_for_include()

# -----------------------------------------------------------------------------
# We perform a recursive descent until we hit the include and we log the path in the call graph.
# We do this for the complete graph; then we prune the paths until they differ. The result is the root.
# We also need to add the include to all nodes in the divergent paths
sub _create_include_chains {
    ( my $stref, my $nid ) = @_;
    # If a node has children     
    if ( exists $stref->{'Nodes'}{$nid}{'Children'}
        and scalar @{ $stref->{'Nodes'}{$nid}{'Children'} } > 0 )
    {        
        # Find all children of $nid
        my @children = @{ $stref->{'Nodes'}{$nid}{'Children'} };
        #  Now for each of these children, find their children until the leaf nodes are reached
        for my $child (@children) {
            my $cnid = $child->[0];            
            $stref = _create_include_chains( $stref, $cnid );
        }
    } else {
# We reached a leaf node
# Now we work our way back up via the parent using a separate recursive function
        $stref = __merge_includes( $stref, $nid, $nid, '' );
# The chain is identified by the name of the leaf child
# Check if the chain contains the $inc on the way up
# Note that we can check this for every inc so we need to do this only once if we're clever -- looks like the coffee is working!

        # When all leaf nodes have been processed, we should do the following:
        # Create a list of all chains for each $inc
        # Now find the deepest common node.
    }

    return $stref;
}    # END of _create_include_chains()

# -----------------------------------------------------------------------------
# From each leaf node we follow the path back to the root of the tree
# We combine all includes of all child nodes of a node, and the node's own includes, into CommonIncludes

sub __merge_includes {
    ( my $stref, my $nid, my $cnid, my $chain ) = @_;
     
    # If there are includes with common blocks, merge them into CommonIncludes
    my $pnid = $stref->{'Nodes'}{$nid}{'Parent'};   
    my $sub  = $stref->{'Nodes'}{$nid}{'Subroutine'};
    # If $sub is really a subroutine      
    if (defined $sub and exists $stref->{'Subroutines'}{$sub}) {
        my $Ssub = $stref->{'Subroutines'}{$sub};
        # $f is the parent of $sub    
        my $f=$stref->{'Nodes'}{$pnid}{'Subroutine'} ;
        if ($pnid == 0) {$f = '__TOP__' };
        # I'm not sure about this    
        if ($V) {
            if ($sub ne $f ) {
                if (defined $Ssub->{'RefactorGlobals'} and $Ssub->{'RefactorGlobals'}>0) {
               		$chain .="$sub -> ";
                }
            } else {
                print "__merge_includes(): $chain\n" if $chain=~/->/;
            }
        } # $V
        
        # If a sub has Includes but  CommonIncludes has not been created yet
        if ( exists $Ssub->{'Includes'}
            and not exists $Ssub->{'CommonIncludes'}     
            )
        {
            for my $inc ( keys %{ $Ssub->{'Includes'} } ) {
            	# Be defensive
            	if (not exists $stref->{'IncludeFiles'}{$inc}
            	or not exists $stref->{'IncludeFiles'}{$inc}{'InclType'}
            	) {
            		die "__merge_includes(): INC $inc is not in IncludeFiles\n";
            	}        	
            	
                if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common'
                    and not exists $Ssub->{'CommonIncludes'}{$inc} )
                {
                    say "Adding $inc to CommonIncludes in $sub" if $DBG;
                    $Ssub->{'CommonIncludes'}{$inc} = 1;
                } else {
                	say "NOT adding $inc to CommonIncludes in $sub: " . $stref->{'IncludeFiles'}{$inc}{'InclType'} if $DBG;                	
                }
 
            }
        }

        if ( $nid != $cnid ) {
            my $csub  = $stref->{'Nodes'}{$cnid}{'Subroutine'};
            my $Scsub = $stref->{'Subroutines'}{$csub};
            if ( exists $Scsub->{'CommonIncludes'} ) {
                for my $inc ( keys %{ $Scsub->{'CommonIncludes'} } ) {
                    if ( not exists $Ssub->{'CommonIncludes'}{$inc} ) {
                        $Ssub->{'CommonIncludes'}{$inc} = 1;
                    }
                }
            }
        }
        die 'No subroutine name ' if $sub eq '' or not defined $sub;
        $stref->{'Subroutines'}{$sub}=$Ssub ;
        if ( $nid != 0 ) {
            $stref = __merge_includes( $stref, $pnid, $nid,$chain );
        }
    }
#    say $chain;
    return $stref;
}    # END of __merge_includes

# -----------------------------------------------------------------------------
1;