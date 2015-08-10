package RefactorF4Acc::Analysis;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Includes qw( find_root_for_includes );
use RefactorF4Acc::Analysis::Globals qw( resolve_globals );
use RefactorF4Acc::Analysis::Sources qw( analyse_sources );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_end_detect );

# 
#   (c) 2010-2015 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Analysis::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::EXPORT = qw(
    &analyse_all
);

sub analyse_all {
	
	(my $stref, my $subname)=@_;
    # Find the 'root', i.e. the outermost calling subroutine, for each include file
    
	   print "\t** FIND ROOT FOR INCLUDES **\n" if $V;
    $stref = find_root_for_includes( $stref, $subname );    
    
    # Now we can do proper globals handling
    # We need to walk the tree again, find the globals in rec descent.
    print "\t** RESOLVE GLOBALS **\n" if $V;
    $stref = resolve_globals( $subname, $stref );
    print "\t** ANALYSE SOURCES **\n" if $V; # TODO: BETTER NAME
    $stref = analyse_sources($stref); # TODO: LIFTING OF INCLUDES SHOULD HAPPEN *AFTER* THIS
    for my $kernel_wrapper (keys %{$stref->{'KernelWrappers'}}) {
        $stref = outer_loop_end_detect($kernel_wrapper,$stref);
    }
    
    for my $inc (keys %{ $stref->{'IncludeFiles'} }) {
    for my $v (keys %{ $stref->{'IncludeFiles'}{$inc}{'Commons'} }) {
    say $v.' => '.Dumper($stref->{'IncludeFiles'}{$inc}{'Commons'}{$v});
    }
    }
    # So at this point all globals have been resolved and typed.
# NOTE: It turns out that at this point any non-global not explicity declared variables don't have a declaration yet.     
	return $stref;	
} # END of analyse_all()


