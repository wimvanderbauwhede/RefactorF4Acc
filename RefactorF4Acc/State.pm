package RefactorF4Acc::State;
use v5.10;
use RefactorF4Acc::Config;
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings;
use strict;

use Exporter;

@RefactorF4Acc::State::ISA = qw(Exporter);

@RefactorF4Acc::State::EXPORT = qw(
    &init_state
);

sub init_state {
    ( my $vref ) = @_;
    my $subname = $vref;
    if (ref($vref) eq 'HASH') {
        $subname =$vref->{'Top'};
    } 

    # Nodes|Subroutines|Includes|NId|BuildSources|Indents
    my $stateref = {
        'Top'          => $subname,
        'IncludeFiles' => {},		
        'Subroutines'  => {}, # {$f}{Function} = 1
        'SourceFiles' => {}, # This is for anything not in a code unit, usually just comments and blank lines 
        'BuildSources' => {}
        ,    # sources to be built, can be C, H (header) or F (Fortran)
        'Indents' => 0,    # bit silly, purely for pretty-printing
        'NId'     => 0,    # running node id for traversal
        'PNids'	=> [],
        'Nodes'   => {     # nodes in call tree
#            0 => {
#                'Parent'     => 0,
#                'Children'   => [],
#                'Subroutine' => $subname
#            }
        },
        'Macros' => {
        	'Define' => {},
        	'Undef' => {},
        	'All' => {}
        }
    };
    
    if (exists $Config{'MACRO_SRC'} ){
    	my $macro_src =$Config{'MACRO_SRC'};
    	if ( -e $macro_src ) {
	        open my $MACROS, '<', $macro_src;
    	    while ( my $line = <$MACROS> ) {
        	    next unless $line =~ /^\s*\#/;
            	$line =~ /\#define\s+(.+)\s*$/ && do {
	                my $pair = $1;
	                $pair=~s/\s+/ /g;
	                $pair=~s/\s/=/;
	                (my $macro, my $val)=split(/=/,$pair);
	                if (not defined $val) {$val = ''};
	                $stateref->{'Macros'}{'Undef'}{$macro}=$val;
	                $stateref->{'Macros'}{'All'}{$macro}=$val;
	                $Config{'Macros'}{$macro}=$val;
	                next;
            	};
            	$line =~ /\#undef\s+(.+)\s*$/ && do {
                	my $macro = $1;
                	$stateref->{'Macros'}{'Undef'}{$macro}=$macro;
                	$stateref->{'Macros'}{'All'}{$macro}=$macro;
                	$Config{'Macros'}{$macro}=$macro;
                	next;
            	};             	           
        	}
        	close $MACROS;
	    }    	
    }
    
    if (ref($vref) eq 'HASH') {
        for my $k (keys %{$vref}) {
            $stateref->{$k} = $vref->{$k};
        }
    }
    return $stateref;
}
