package RefactorF4Acc::State;
use v5.16;
# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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
    ( my $subname ) = @_;

    # Nodes|Subroutines|Includes|NId|BuildSources|Indents
    my $stateref = {
        'Top'          => $subname,
        'IncludeFiles' => {},

        'Subroutines'  => {}, # {$f}{Function} = 1
        'BuildSources' => {}
        ,    # sources to be built, can be C, H (header) or F (Fortran)
        'Indents' => 0,    # bit silly, purely for pretty-printing
        'NId'     => 0,    # running node id for traversal
        'Nodes'   => {     # nodes in call tree
            0 => {
                'Parent'     => 0,
                'Children'   => [],
                'Subroutine' => $subname
            }
        }
    };
    return $stateref;
}