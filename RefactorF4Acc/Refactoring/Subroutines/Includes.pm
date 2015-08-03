package RefactorF4Acc::Refactoring::Subroutines::Includes;
use v5.16;
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
            die $tinc if $tinc =~/params_com/ or $f eq 'main';
            $tinc=~s/\./_/g;
            	my $rline = "      use $tinc ! create_additional_include_statements() line 67";
            $info->{'Include'}{'Name'} = $inc;
            $info->{'Ref'}=1;
            if ($info->{'ExGlobVarDecls'} >= $Sf->{'ExGlobVarDeclHook'}) {
                $info->{'ExGlobVarDecls'} = ++$Sf->{'ExGlobVarDeclHook'};
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
sub create_new_include_statements {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
#    local $V=1;
    my $Sf        = $stref->{'Subroutines'}{$f};
    my $nextLineID=scalar @{$rlines};        
    my $info = {%{$annline->[1]}};
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        print "INC: $inc, root: $stref->{'IncludeFiles'}{$inc}{'Root'} \n"
          if $V;
          my $params_only = $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter';
          my $has_param_include = exists $stref->{'IncludeFiles'}{$inc}{'ParamInclude'};
        if ( exists $Sf->{'CommonIncludes'}{$inc} ) {
            
        
#            die Dumper($stref->{'IncludeFiles'}{$inc});
            my $tinc=$inc;
            my $ok=0;
            if ($f eq $stref->{'IncludeFiles'}{$inc}{'Root'} or $params_only) { 
   
            print "INFO: instantiating merged INC $inc in $f\n" if $V;
            $ok=1;
#            my $rline = "      include '$inc'";
                 
            } elsif ($has_param_include) {
                $tinc = $stref->{'IncludeFiles'}{$inc}{'ParamInclude'};
                $ok=1;
            }         
            if ($ok==1) {           
            $tinc=~s/\./_/g;
            my $rline = "      use $tinc"; 
            $rline .=" ! create_new_include_statements() line 106";# if $V;
            $info->{'Include'}{'Name'} = $inc;
            $info->{'Ref'}=1;
            $info->{'LineID'}=$nextLineID++;
            if (exists $info->{'VarDecl'}) {
#                carp $annline->[0]."\n".Dumper($info->{'VarDecl'}) if $f eq 'hanna'; # this never happens, so the junk is not introduced here
                delete $info->{'VarDecl'};
            }
# Obsolete            
#            if ($info->{'ExGlobVarDecls'} >= $Sf->{'ExGlobVarDeclHook'}) {
#            	$info->{'ExGlobVarDecls'} = ++$Sf->{'ExGlobVarDeclHook'};
#            }
#            say Dumper([ $rline, $info ]);
            push @{$rlines}, [ $rline, $info ];
            }
        } 
    }
#    die Dumper($rlines) if $f eq 'aveflow';
    return $rlines;
}    # END of create_new_include_statements()


# -----------------------------------------------------------------------------
