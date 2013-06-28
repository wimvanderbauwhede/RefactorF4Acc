package RefactorF4Acc::Refactoring::Subroutines::Signatures;

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

use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines format_f95_var_decl );

use Exporter;

@RefactorF4Acc::Refactoring::Subroutines::Signatures::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::Signatures::EXPORT_OK = qw(
    &create_refactored_subroutine_signature
    &refactor_subroutine_signature
    &refactor_kernel_signatures
);

=pod
Subroutines
        create_refactored_subroutine_signature() -> Signature
=cut

# --------------------------------------------------------------------------------
# This routine creates the actual refactored source text of the sig
sub create_refactored_subroutine_signature {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
    my $Sf        = $stref->{'Subroutines'}{$f};
    my $tags_lref = $annline->[1];    
    my $args_ref = $Sf->{'RefactoredArgs'}{'List'};
    my $args_str = join( ',', @{$args_ref} );
    print "NEW ARGS: $args_str\n" if $V;
    my $rline = '';
    if ( $Sf->{'Program'} ) {
        $rline = '      program ' . $f;
    } elsif ( $Sf->{'Recursive'} ) {
    	# FIXME: deal with RECURSIVE!
        $rline = '      recursive subroutine ' . $f . '(' . $args_str . ')';    
    } else {    	
        $rline = '      subroutine ' . $f . '(' . $args_str . ')';
    }
    $tags_lref->{'Refactored'} = 1;
    $tags_lref->{'Ref'} = 1;
    $Sf->{'HasRefactoredArgs'} = 1;
    push @{$rlines}, [ $rline, $tags_lref ];

    return $rlines;
}    # END of create_refactored_subroutine_signature()
# -----------------------------------------------------------------------------
# At this point, the IODirs have been resolved, but unfortunately the argument declaration lines
# have already been created as strings. Not good.
# FIXME: IODir needs to be used as INTENT for arguments, rather than just being documentation
# So when we emit the actual subroutine body code, we need to add the information from
#  $Sf->{'RefactoredArgs'}{'Set'}{$arg}{'IODir'} for every $arg
sub refactor_kernel_signatures {
    ( my $stref, my $f ) = @_;
    my $Sf        = $stref->{'Subroutines'}{$f};
    my $args_ref = $Sf->{'RefactoredArgs'}{'List'};
    $Sf->{'HasRefactoredArgs'} = 1;
    # IO direction information
    my @rlines=();# ( [ "!    SUBROUTINE $f IO INFO\n", { 'Comment' => 1, 'Ref'=>1 } ] );
    for my $arg ( @{$args_ref} ) {    	
        if ( exists $Sf->{'RefactoredArgs'}{'Set'}{$arg}{'IODir'} ) {
            my $iodir = $Sf->{'RefactoredArgs'}{'Set'}{$arg}{'IODir'};
            my $kind  = $Sf->{'RefactoredArgs'}{'Set'}{$arg}{'Kind'};
            my $type  = $Sf->{'RefactoredArgs'}{'Set'}{$arg}{'Type'};
#            die $line,"\n",Dumper($Sf->{'RefactoredArgs'}{'Set'}{$arg}) if $arg eq 'gold';
            my $ntabs = ' ' x 8;
            if ( $iodir eq 'In' and $kind eq 'Scalar' ) {
                $ntabs = '';
            } elsif ( $iodir eq 'Out' ) {
                $ntabs = ' ' x 4;
            }
#            my $comment = "!      $ntabs$arg:\t$iodir, $kind, $type";
#            push @rlines, [ $comment, { 'Comment' => 1, 'Ref'=>1 } ];
        } else {
            print "WARNING: No IO info for $arg in $f\n" if $W;
        }
    }

    # Now add $rlines to the refactored signature
	# WV: this just adds the IO info as comments
    my @extra_lines = @rlines;
    
    if ( $Sf->{'Status'} != $PARSED ) {
        croak "NOT PARSED: $f\n".caller()."\n";
    }
    my $annlines = get_annotated_sourcelines( $stref, $f );
    $Sf->{'RefactoredCode'}=[];
    for my $annline ( @{$annlines} ) {    	
        if ( not defined $annline or not defined $annline->[0] ) {
            croak
              "Undefined source code line for $f in refactor_kernel_signatures()";
        }
        my $line = $annline->[0];
        my $info = $annline->[1];
        
        my %tags      = %{$info};
#        warn $line,"\n",Dumper($info) if $f =~/adam/;
#         die $line,"\n",Dumper($Sf->{'RefactoredArgs'}{'Set'}{$arg}) if $arg eq 'gold';
#        print "$line\t".join(',',keys %tags)."\n";
        if ( exists $tags{'Signature'} ) {
            for my $extra_line (@extra_lines) {
#            	print $extra_line->[0],"\n";
                push @{ $Sf->{'RefactoredCode'} }, $extra_line;
            }
        }
    if ( exists $tags{'VarDecl'} ) {
    	my $arg = $info->{VarDecl};
    	 if( exists  $Sf->{'Vars'}{$arg}{Decl} ) {
    	
    	$line = format_f95_var_decl($Sf, $arg);
    	 } else {
    	 	print "WARNING: $arg is not in Vars for $f\n" if $W;
    	 }
    }
        push @{ $Sf->{'RefactoredCode'} }, [ $line, $info ];# if $line ne '';
    }    
#    die 'BOOM' if $f eq 'adam';
#    die Dumper( map {$_->[0] } @{$Sf->{'RefactoredCode'}} ) if $f eq 'adam';

    return $stref;
}    # END of refactor_kernel_signatures()
# -----------------------------------------------------------------------------

sub refactor_subroutine_signature {
    ( my $stref, my $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    if ($V) {
        if ( exists $Sf->{'Args'} ) {
            print "SUB $f ORIG ARGS:" . join( ',', @{ $Sf->{'Args'}{'List'} } ), "\n";
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
            for my $var ( @{ $Sf->{'Globals'}{$inc} } ) {
                if ( not exists $Sf->{'Vars'}{$var} ) {
                    $Sf->{'Vars'}{$var} =
                      $stref->{'IncludeFiles'}{$inc}{'Vars'}{$var};
                }
            }
            print "$inc:"
              . join( ',', @{ $Sf->{'Globals'}{$inc} } ), "\n"
              if $V;
            @exglobs = ( @exglobs, @{ $Sf->{'Globals'}{$inc} } );
        }
    }
    # Loop over @exglobs, rename vars that conflict with parameters
    for my $var (@exglobs) {
        if ( exists $Sf->{'ConflictingParams'}{$var} ) {
            print
"WARNING: CONFLICT in arguments for $f, renamed $var to ${var}_GLOB\n"
              if $W;
            push @nexglobs, $Sf->{'ConflictingParams'}{$var};
            $Sf->{'Vars'}{ $Sf->{'ConflictingParams'}{$var} } = $Sf->{'Vars'}{$var};
        } else {
            push @nexglobs, $var;
        }
    }
    # Now combine the original subroutine arguments with the ex-globals
    # and store in $Sf->{'RefactoredArgs'}{'List'}     
    my $args_ref = (exists $Sf->{'Args'}) ? ordered_union( $Sf->{'Args'}{'List'}, \@nexglobs ) : \@nexglobs;
    $Sf->{'RefactoredArgs'}{'List'} = $args_ref;
    %{ $Sf->{'RefactoredArgs'}{'Set'}} = map {$_ => {'IODir' => 'Unknown'} } @{ $args_ref };
    $Sf->{'HasRefactoredArgs'} = 1;
    return $stref;
}    # END of refactor_subroutine_signature()

# -----------------------------------------------------------------------------
#sub format_f95_arg_decl {
#    ( my $Sf, my $var ) = @_;
#    my $Sv = $Sf->{'RefactoredArgs'}{'Set'}{$var};
#    if ( not exists $Sv->{'Decl'} ) {
#        print "WARNING: VAR $var does not exist in format_f95_var_decl()!\n" if $W;
#        croak $var;
##       $Sv->{'Decl'}='      $var = NULL';
#    } 
#    my $nvar=$var;
#    if (exists $Sf->{'ConflictingLiftedVars'}{$var} ){
#       $nvar=$Sf->{'ConflictingLiftedVars'}{$var};
#    }
#    my $spaces = $Sv->{'Decl'};
#    $spaces =~ s/\S.*$//;
#    my $intent='';
#    if (exists $Sf->{'RefactoredArgs'}{'Set'}{$var}) {
#        $intent = $Sf->{'RefactoredArgs'}{'Set'}{$var}{'IODir'};
##        warn "F95 $var: intent $intent\n";
##        print "F95 format_f95_var_decl() $var: intent $intent\n";
#    } 
#    # FIXME: for multiple vars, we need to split this in multiple statements.
#    # So I guess as soon as the Shape is not empty, need to split.
#    my $shape = $Sv->{'Shape'};
#    die Dumper($shape) if join( '', @{$shape} ) =~ /;/;
#    my $dim = '';
#    if ( @{$shape} ) {
#        my @dims = ();
#        for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
#            my $range =
#              ( $shape->[ 2 * $i ] eq '1' )
#              ? $shape->[ 2 * $i + 1 ]
#              : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
#            push @dims, $range;
#        }
#        $dim = ', dimension(' . join( ',', @dims ) . ') ';
#    }
#    my $decl_line =
#      $spaces . $Sv->{'Type'} .$Sv->{'Attr'}. $dim . ' :: ' . $nvar;
#
#    #    die $decl_line  if $dim;
#    return $decl_line;
#}    # format_f95_var_decl()