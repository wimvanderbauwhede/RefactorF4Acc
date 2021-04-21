# Analyse loops in terms of map, fold and iterative as well as for stencils and halos
package RefactorF4Acc::Analysis::LoopNature;
# 
#   (c) 2021 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Analysis::FoldConstants qw( foldConstants );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::LoopNature::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::LoopNature::EXPORT_OK = qw(
    analyseLoopNature
);

# type SubroutineTable = DMap.Map SubNameStr SubRec -- (ProgUnit Anno, String)
# So this corresponds to $stref->{'Subroutines'}
# analyseLoopNature :: SubroutineTable -> (SubroutineTable, [(String, String)]) -> String -> (SubroutineTable, [(String, String)])
sub analyseLoopNature {
    
    my ($stref, $subName) = @_;
    # my ($accumSubTable, $annoListing) =@{$accumSubTable_annoListing};
    
        # where
        # this is $stref->{'Subroutines'}{$subName}
            my $subrec = $stref->{'Subroutines'}{$subName};
            # findWithDefault( sub { die "analyseLoopNature"}, $subName, $originalTable) ;
            my $progUnit =  $subrec->{'AnnLines'}; # subAst
            my $filename =  $subrec->{'Source'}; # subSrcFile
            my $progUnitfoldedConstants = foldConstants( $progUnit);
            my $accessAnalysis = analyseAllVarAccess_progUnit $ioWriteSubroutines, $progUnit;
            my $parallelisedProgUnit = everywhere( mkT(\&paralleliseBlock,$filename,$originalTable,$accessAnalysis), $progUnitfoldedConstants);
            my $parAnno = compileAnnotationListing $parallelisedProgUnit;
            my $newSubTable = insert( $subName, MkSubRec( $parallelisedProgUnit, $filename, []), $accumSubTable);

        return ($newSubTable, [@{$annoListing}, [$filename, $parAnno]]);
}

sub findWithDefault { my ($default, $key, $table) = @_;

    if (not exists $table->{$key}) {
        if (ref($default) eq 'SUB') {
            $default->();
        } else { 
            return $default;
        }
    } else {
        return $table->{$key};
    }
    
}

sub insert { my ($key, $value, $table) = @_;
        $table->{$key}=$value;
        return dclone($table);
}
    
1;