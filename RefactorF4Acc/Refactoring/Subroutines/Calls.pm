package RefactorF4Acc::Refactoring::Subroutines::Calls;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines );
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( refactor_subroutine_signature );
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

# OBSOLETE!

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Subroutines::Calls::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::Calls::EXPORT_OK = qw(
);
