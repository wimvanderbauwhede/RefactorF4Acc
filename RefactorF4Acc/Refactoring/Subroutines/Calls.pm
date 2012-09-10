package RefactorF4Acc::Refactoring::Subroutines::Calls;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines );
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( refactor_subroutine_signature );
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

@RefactorF4Acc::Refactoring::Subroutines::Calls::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::Calls::EXPORT_OK = qw(
    &create_refactored_subroutine_call
    &refactor_subroutine_call_args
);


# ----------------------------------------------------------------------------------------------------
# Calls to subroutines with refactored globals must be refactored to contain the globals as arguments. 
# Similar to refactor_subroutine_signature()
# The heavy lifting is done by determine_exglob_subroutine_call_args()
# Then we merge the original args, renamed for local/global clashes, with the globals

sub create_refactored_subroutine_call {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;;
    my $Sf        = $stref->{'Subroutines'}{$f};
    my $line      = $annline->[0] || '';
    my $tags_lref = $annline->[1];
    my %tags      = ( defined $tags_lref ) ? %{$tags_lref} : ();

    # simply tag the common vars onto the arguments
    my $name = $tags{'SubroutineCall'}{'Name'};
    my $conflicting_locals = {};
    if ( exists $Sf->{'ConflictingGlobals'} ) {
        $conflicting_locals = $Sf->{'ConflictingGlobals'};
    }
    my $globals = determine_exglob_subroutine_call_args( $stref, $f, $name );
    my $orig_args = [];
    for my $arg ( @{ $tags{'SubroutineCall'}{'Args'} } ) {
        if ( exists $conflicting_locals->{$arg} ) {
            push @{$orig_args}, $conflicting_locals->{$arg};
        } else {
            push @{$orig_args}, $arg;
        }
    }
    my $args_ref = ordered_union( $orig_args, $globals );

    my $args_str = join( ',', @{$args_ref} );
    $line =~ s/call\s.*$//;
    my $rline = "call $name($args_str)\n";
    push @{$rlines}, [ $line . $rline, $tags_lref ];
    return $rlines;
}    # END of create_refactored_subroutine_call()

# ----------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------
sub determine_exglob_subroutine_call_args {
    ( my $stref, my $f, my $name ) = @_;
    my $Sf                 = $stref->{'Subroutines'}{$f};
    my $Sname              = $stref->{'Subroutines'}{$name};
    my %conflicting_locals = ();
    my %conflicting_params = ();
    if ( exists $Sf->{'ConflictingParams'} ) {
        %conflicting_params = %{ $Sf->{'ConflictingParams'} };
    }
    if ( exists $Sf->{'ConflictingGlobals'} ) {
        %conflicting_locals = %{ $Sf->{'ConflictingGlobals'} };
    }
    my %conflicting_exglobs_params = ();
    if (%conflicting_params) {
        %conflicting_exglobs_params =
          ( %conflicting_locals, %conflicting_params );
    }
    my @globals = ();
    for my $inc ( keys %{ $Sname->{'Globals'} } ) {
        next if $stref->{'IncludeFiles'}{$inc}{'Root'} eq $name;
        if ( defined $Sname->{'Globals'}{$inc} ) {
            if (%conflicting_exglobs_params) {
                for my $var ( @{ $Sname->{'Globals'}{$inc} } ) {
                    if ( exists $conflicting_exglobs_params{$var} ) {
                        print
"WARNING: CONFLICT in call to $name in $f:renaming $var with ${var}_GLOB!\n"
                          if $W;
                        push @globals, $conflicting_exglobs_params{$var};
                    } else {
                        push @globals, $var;
                    }
                }
            } else {
                @globals = ( @globals, @{ $Sname->{'Globals'}{$inc} } );
            }
        }
    }
    return \@globals;
}    # END of determine_exglob_subroutine_call_args

# ----------------------------------------------------------------------------------------------------
sub refactor_subroutine_call_args {
    ( my $stref, my $f, my $idx ) = @_;
    my $Sf   = $stref->{'Subroutines'}{$f};
    my $tags = ${get_annotated_sourcelines($stref,$f)}[$idx][1];
    
    # simply tag the common vars onto the arguments
    my $name               = $tags->{'SubroutineCall'}{'Name'};
    my $Sname              = $stref->{'Subroutines'}{$name};
    if (not exists $Sname->{'HasRefactoredArgs'} or $Sname->{'HasRefactoredArgs'}==0) {
    	$stref = refactor_subroutine_signature( $stref, $name );
    }
    my %conflicting_locals = ();
    my %conflicting_params = ();
    if ( exists $Sf->{'ConflictingParams'} ) {
        %conflicting_params = %{ $Sf->{'ConflictingParams'} };
    }
    if ( exists $Sf->{'ConflictingGlobals'} ) {
        %conflicting_locals = %{ $Sf->{'ConflictingGlobals'} };
    }
    my %conflicting_exglobs_params = ();
    if (%conflicting_params) {
        %conflicting_exglobs_params =
          ( %conflicting_locals, %conflicting_params );
    }
    my @globals = ();
    for my $inc ( keys %{ $Sname->{'Globals'} } ) {
        next if $stref->{'IncludeFiles'}{$inc}{'Root'} eq $name;
        if ( defined $Sname->{'Globals'}{$inc} ) {
            if (%conflicting_exglobs_params) {
                for my $var ( @{ $Sname->{'Globals'}{$inc} } ) {
                    if ( exists $conflicting_exglobs_params{$var} ) {
                        print
"WARNING: CONFLICT in call to $name in $f:renaming $var with ${var}_GLOB!\n"
                          if $W;
                        push @globals, $conflicting_exglobs_params{$var};
                    } else {
                        push @globals, $var;
                    }
                }
            } else {
                @globals = ( @globals, @{ $Sname->{'Globals'}{$inc} } );
            }
        }
    }

    my $orig_args = [];
    for my $arg ( @{ $tags->{'SubroutineCall'}{'Args'} } ) {
        if ( exists $conflicting_locals{$arg} ) {
            push @{$orig_args}, $conflicting_locals{$arg};
        } else {
            push @{$orig_args}, $arg;
        }
    }
    my $args_ref = ordered_union( $orig_args, \@globals );
    $tags->{'SubroutineCall'}{'RefactoredArgs'} = $args_ref;
    $Sf->{'AnnLines'}[$idx][1] = $tags;
    return $stref;
}    # END of refactor_subroutine_call_args
# -----------------------------------------------------------------------------
