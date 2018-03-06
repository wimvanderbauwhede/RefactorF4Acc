package RefactorF4Acc::Refactoring::Subroutines::Signatures;
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
    my $args_ref = [];
    if (not exists $info->{'EntrySig'} ) {
    	$args_ref = $Sf->{'RefactoredArgs'}{'List'};
    } else {
    	# ENTRY!
    	my $name = $info->{'Signature'}{'Name'};
    	my $Sname = $Sf->{'Entries'}{'Set'}{$name};
    	$args_ref = $Sname->{'RefactoredArgs'}{'List'};
#    	croak Dumper($info).Dumper($args_ref);
    }
    my $args_str = join( ',', @{$args_ref} );
    my $what_is_block_data = 'subroutine'; #'block data'
    my $block_data_has_args = 1;
    print "NEW ARGS: $args_str\n" if $DBG;
    
    my $rline = '';
    if ( $Sf->{'Program'} ) {
        $rline = '      program ' . $f;
    } elsif ( $Sf->{'Recursive'} ) { 
    	$rline = $annline->[0];
    	$rline =~s/subroutine.*$//;	
        $rline .= 'subroutine ' . $f . '(' . $args_str . ')';
    } elsif ( $Sf->{'Function'} ) {
    	$rline = $annline->[0];
    	$rline =~s/function.*$//;
        $rline .= 'function ' . $f . '(' . $args_str . ')';
    } elsif ( $Sf->{'BlockData'} ) { 
		$rline = $annline->[0];
    	$rline =~s/block\s+data.*$//;	
        $rline .= $what_is_block_data. ' ' . $f . ($block_data_has_args ? '(' . $args_str . ')' : '');
    } elsif ( exists $info->{'EntrySig'} ) {
    	my $name = $info->{'Signature'}{'Name'};
    	$rline = $annline->[0];
    	$rline =~s/entry.*$//;	
        $rline .= 'entry ' . $name . '(' . $args_str . ')';    	                	        
    } else {    
    	$rline = $annline->[0];
    	$rline =~s/subroutine.*$//;	
        $rline .= 'subroutine ' . $f . '(' . $args_str . ')';
    }
    $info->{'Refactored'} = 1;
    $info->{'Ref'} = 1;
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

    # Loop over all globals and create the list @exglobs by concatenation
    # Also add all vars to $Sf->{'Vars'} unless they were already there
    my @exglobs            = ();        
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
    
#            for my $var ( @{ $Sf->{'Globals'}{$inc}{'List'} } ) {
#                if ( not exists $Sf->{'Vars'}{$var} ) {
#                    $Sf->{'Vars'}{$var} =
#                      $stref->{'IncludeFiles'}{$inc}{'Vars'}{$var};
#                }
#            }
#            @exglobs = ( @exglobs, @{ $Sf->{'Globals'}{$inc}{'List'} } );
#    

    print "INFO: UsedGlobalVars in $f\n" if $I;
    
    for my $var ( @{ $Sf->{'UsedGlobalVars'}{'List'} } ) {
    	# Check if this var is used in the subroutine
    	if (exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var}) {
#    		say $var;
    		say "INFO VAR: $var" if $I;
			push @exglobs, $var;
			$Sf->{'HasRefactoredArgs'}=1;                         
    	}             
    	
    }    # for


    
    # Loop over @exglobs, rename vars that conflict with parameters
    my @nexglobs           = ();
    for my $var (@exglobs) {
        if ( exists $Sf->{'ConflictingParams'}{$var} ) {
            print "WARNING: CONFLICT in arguments for $f, renamed $var to ${var}_GLOB\n" if $W;
            push @nexglobs, $Sf->{'ConflictingParams'}{$var}[0];
            $Sf->{'Vars'}{ $Sf->{'ConflictingParams'}{$var}[0] } = $Sf->{'Vars'}{$var};
        } else {
            push @nexglobs, $var;
        }
    }
    
    # Now combine the original subroutine arguments with the ex-globals and store in $Sf->{'RefactoredArgs'}{'List'}     
    my $args_ref = (exists $Sf->{'OrigArgs'}) ? ordered_union( $Sf->{'OrigArgs'}{'List'}, \@nexglobs ) : \@nexglobs;
    $Sf->{'RefactoredArgs'}{'List'} = $args_ref;
    %{ $Sf->{'RefactoredArgs'}{'Set'}} = map {$_ => {'IODir' => 'Unknown'} } @{ $args_ref };    
    $Sf->{'HasRefactoredArgs'} = 1;
    
    return $stref;
}    # END of refactor_subroutine_signature()

# -----------------------------------------------------------------------------
