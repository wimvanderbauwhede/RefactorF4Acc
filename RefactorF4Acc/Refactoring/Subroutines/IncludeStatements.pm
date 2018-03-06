package RefactorF4Acc::Refactoring::Subroutines::IncludeStatements;
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

@RefactorF4Acc::Refactoring::Subroutines::IncludeStatements::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::IncludeStatements::EXPORT_OK = qw(
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
# There should be no need to do this: all /common/ blocks should have been removed anyway! 
sub skip_common_include_statement {
    ( my $stref, my $f, my $annline ) = @_;
    my $info = $annline->[1];
    my $skip      = 0;
    my $inc       = $info->{'Include'}{'Name'};
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
    
    my $info = $annline->[1];
    for my $inc (@{ $Sf->{'LiftedIncludes'} }) {
            print "INFO: instantiating merged INC $inc in $f\n" if $V;

            my $tinc = $inc;
            
            $tinc=~s/\./_/g;
            	my $rline = "      use $tinc";
            $info->{'Ann'} = [annotate($f, __LINE__  )];
            $info->{'Include'}{'Name'} = $inc;
            $info->{'Ref'}=1;
            if ($info->{'ExGlobArgDecls'} >= $Sf->{'ExGlobVarDeclHook'}) {
                $info->{'ExGlobArgDecls'} = ++$Sf->{'ExGlobVarDeclHook'};
            }            
            push @{$rlines}, [ $rline, $info ];                    
    }
#croak "FIXME: INCLUDE _AFTER_ OTHER INCLUDES!!!";
    return $rlines;
}    # END of create_additional_include_statements()

# --------------------------------------------------------------------------------
# --------------------------------------------------------------------------------
# What this does is:
# IF an include file occurs in $Sf->{'Globals'}
# AND it occurs in $Sf->{'CommonIncludes'}
# AND  $f is the ROOT for this include
# THEN  create a new include statement

# This should only be called if the old one was removed, which I think does not happen anymore.
# We now resolve all globals and locals anyway so the only reason for an include is parameters. So this should be a NOOP
sub create_new_include_statements {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
#    local $V=1;
    my $Sf        = $stref->{'Subroutines'}{$f};
    
    my $nextLineID=scalar @{$rlines};        
    my $info = {%{$annline->[1]}};
    for my $inc ( keys %{ $Sf->{'CommonIncs'} } ) {
        print "INC: $inc, root: $stref->{'IncludeFiles'}{$inc}{'Root'} \n"
          if $V;
          my $params_only = $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter';
          if  ( exists $stref->{'IncludeFiles'}{$inc}{'ParamInclude'} ) {
          	die $stref->{'IncludeFiles'}{$inc}{'ParamInclude'};
          };       
    }

    return $rlines;
}    # END of create_new_include_statements()


# -----------------------------------------------------------------------------
