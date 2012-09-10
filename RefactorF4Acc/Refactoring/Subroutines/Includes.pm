package RefactorF4Acc::Refactoring::Subroutines::Includes;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Refactoring::Subroutines::Includes::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::Includes::EXPORT_OK = qw(
    &skip_common_include_statement
    &create_new_include_statements
    &create_additional_include_statements
);

=pod
        skip_common_include_statement() -> Includes
        create_new_include_statements() -> Includes        
        create_additional_include_statements() -> Includes
=cut
# --------------------------------------------------------------------------------
sub skip_common_include_statement {
    ( my $stref, my $f, my $annline ) = @_;
    my $tags_lref = $annline->[1];
    my $skip      = 0;
    my $inc       = $tags_lref->{'Include'}{'Name'};
    print "INFO: INC $inc in $f\n" if $V;
    if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common' ) {
        if ($V) {
            print "SKIPPED $inc: Root: ",
              ( $stref->{'IncludeFiles'}{$inc}{'Root'} ne $f ) ? 0 : 1,
              "\tTop:",
              (       ( $stref->{'IncludeFiles'}{$inc}{'Root'} eq $f )
                  and ( $f eq $stref->{'Top'} ) ) ? 1 : 0, "\n";
        }
        $skip = 1;
    }
    return $skip;
}    # END of skip_common_include_statement()
# --------------------------------------------------------------------------------
sub create_additional_include_statements {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
#   local $V=1;
    my $Sf        = $stref->{'Subroutines'}{$f};    
        # Which child has RefactorGlobals==1?
#    my @additional_includes=();
#    $Sf->{'LiftedIncludes'} =[];
#    for my $cs (keys %{ $Sf->{'CalledSubs'} }) {             
#        if ($stref->{'Subroutines'}{$cs}{'RefactorGlobals'}==1) {
#            for my $inc (keys %{ $stref->{'Subroutines'}{$cs}{'CommonIncludes'} }) {
#                if (not exists $Sf->{'Includes'}{$inc} and $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common') {
#                    push @additional_includes, $inc;
#	            push @{ $Sf->{'LiftedIncludes'} }, $inc;
#                } 
#            }
#        }
#    }        
    
    my $tags_lref = $annline->[1];
    for my $inc (@{ $Sf->{'LiftedIncludes'} }) {
            print "INFO: instantiating merged INC $inc in $f\n" if $V;
#            my $rline = "      include '$inc'";
            	my $rline = "      use $inc";
            $tags_lref->{'Include'}{'Name'} = $inc;
            push @{$rlines}, [ $rline, $tags_lref ];                    
    }
#croak "FIXME: INCLUDE _AFTER_ OTHER INCLUDES!!!";
    return $rlines;
}    # END of create_additional_include_statements()

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
sub create_new_include_statements {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
    my $Sf        = $stref->{'Subroutines'}{$f};        
    my $tags_lref = $annline->[1];
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        print "INC: $inc, root: $stref->{'IncludeFiles'}{$inc}{'Root'} \n"
          if $V;
        if ( exists $Sf->{'CommonIncludes'}{$inc}
            and $f eq $stref->{'IncludeFiles'}{$inc}{'Root'} )
        {    
            print "INFO: instantiating merged INC $inc in $f\n" if $V;
            my $rline = "      include '$inc'";
#            my $rline = "      use $inc";
            $tags_lref->{'Include'}{'Name'} = $inc;
            push @{$rlines}, [ $rline, $tags_lref ];
        }
    }
    return $rlines;
}    # END of create_new_include_statements()


# -----------------------------------------------------------------------------
