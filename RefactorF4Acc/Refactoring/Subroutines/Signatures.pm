package RefactorF4Acc::Refactoring::Subroutines::Signatures;
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

use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines );

use Exporter;

@RefactorF4Acc::Refactoring::Subroutines::Signatures::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::Signatures::EXPORT_OK = qw(
    &create_refactored_subroutine_signature
    &refactor_subroutine_signature    
);

=pod
Subroutines
        create_refactored_subroutine_signature() -> Signature
=cut

# --------------------------------------------------------------------------------
# This routine creates the actual refactored source text of the sig. 
sub create_refactored_subroutine_signature {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
    my $Sf        = $stref->{'Subroutines'}{$f};
    
    my $info = $annline->[1];    
    my $args_ref = $Sf->{'RefactoredArgs'}{'List'};
    my $args_str = join( ',', @{$args_ref} );
    print "NEW ARGS: $args_str\n" if $DBG;
    
#    die $args_str if $f eq 'post';
    my $rline = '';
    if ( $Sf->{'Program'} ) {
        $rline = '      program ' . $f;
    } elsif ( $Sf->{'Recursive'} ) { 
    	$rline = $annline->[0];
    	$rline =~s/subroutine.*$//;	
        $rline .= 'subroutine ' . $f . '(' . $args_str . ')';
#        $rline = '      recursive subroutine ' . $f . '(' . $args_str . ')';    
    } elsif ( $Sf->{'Function'} ) {# carp 'FUNCTION! create_refactored_subroutine_signature' . __LINE__ .Dumper($annline);
    	$rline = $annline->[0];
    	$rline =~s/function.*$//;
        $rline .= 'function ' . $f . '(' . $args_str . ')';    
    } else {    
    		$rline = $annline->[0];
    	$rline =~s/(?:subroutine|block\s+data).*$//;	
        $rline .= 'subroutine ' . $f . '(' . $args_str . ')';
    }
    $info->{'Refactored'} = 1;
    $info->{'Ref'} = 1;
#    $info->{'BOOM'} = 1;
    $info->{'Signature'}{'Args'}=$Sf->{'RefactoredArgs'};
    $info->{'Signature'}{'RefactoredArgs'}=$Sf->{'RefactoredArgs'}; # not sure if this is needed
    $Sf->{'HasRefactoredArgs'} = 1;
    
    push @{$rlines}, [ $rline, $info ];

    return $rlines;
}    # END of create_refactored_subroutine_signature()
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

sub refactor_subroutine_signature {
    ( my $stref, my $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    
    if ($V) {
        if ( exists $Sf->{'OrigArgs'} ) {
            print "SUB $f ORIG ARGS:" . join( ',', @{ $Sf->{'OrigArgs'}{'List'} } ), "\n";
        } else {
            print "SUB $f ORIG ARGS: ()\n";
        }
    }

    my @exglobs            = ();
    my @nexglobs           = ();    
    # Loop over all globals and create the list @exglobs by concatenation
    # Also add all vars to $Sf->{'Vars'} unless they were already there    
    
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        print "INFO: INC $inc in $f\n" if $V;
        if ( not exists $stref->{'IncludeFiles'}{$inc}{'Root'} ) {
            die "$inc has no Root in $f";
        }
        if ( $stref->{'IncludeFiles'}{$inc}{'Root'} eq $f ) {
            print "INFO: $f is root for $inc (lookup)\n" if $V;
            next;
        }
        if ( defined $Sf->{'Globals'}{$inc} ) {
            for my $var ( @{ $Sf->{'Globals'}{$inc}{'List'} } ) {
                if ( not exists $Sf->{'Vars'}{$var} ) {
                    $Sf->{'Vars'}{$var} =
                      $stref->{'IncludeFiles'}{$inc}{'Vars'}{$var};
                }
            }
            print "$inc:"
              . join( ',', @{ $Sf->{'Globals'}{$inc}{'List'} } ), "\n"
              if $V;
            @exglobs = ( @exglobs, @{ $Sf->{'Globals'}{$inc}{'List'} } );
        }
    }
    # Loop over @exglobs, rename vars that conflict with parameters
    for my $var (@exglobs) {
        if ( exists $Sf->{'ConflictingParams'}{$var} ) {
            print
"WARNING: CONFLICT in arguments for $f, renamed $var to ${var}_GLOB\n"
              if $W;
            push @nexglobs, $Sf->{'ConflictingParams'}{$var}[0];
            $Sf->{'Vars'}{ $Sf->{'ConflictingParams'}{$var}[0] } = $Sf->{'Vars'}{$var};
        } else {
            push @nexglobs, $var;
        }
    }
    # Now combine the original subroutine arguments with the ex-globals
    # and store in $Sf->{'RefactoredArgs'}{'List'}     
    my $args_ref = (exists $Sf->{'OrigArgs'}) ? ordered_union( $Sf->{'OrigArgs'}{'List'}, \@nexglobs ) : \@nexglobs;
#    my @blanks = grep {$_ eq '' } @{$args_ref};
#    say "RefactoredArgs for $f: ".Dumper($args_ref); 
    $Sf->{'RefactoredArgs'}{'List'} = $args_ref;
    %{ $Sf->{'RefactoredArgs'}{'Set'}} = map {$_ => {'IODir' => 'Unknown'} } @{ $args_ref };    
    $Sf->{'HasRefactoredArgs'} = 1;
    
    return $stref;
}    # END of refactor_subroutine_signature()

# -----------------------------------------------------------------------------
