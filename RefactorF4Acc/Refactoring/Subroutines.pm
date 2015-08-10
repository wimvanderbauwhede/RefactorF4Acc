package RefactorF4Acc::Refactoring::Subroutines;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines create_refactored_source context_free_refactorings );
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( create_refactored_subroutine_signature refactor_subroutine_signature refactor_kernel_signatures ); 
use RefactorF4Acc::Refactoring::Subroutines::Includes qw( skip_common_include_statement create_new_include_statements create_additional_include_statements );
use RefactorF4Acc::Refactoring::Subroutines::Declarations qw( create_exglob_var_declarations create_refactored_vardecls );
use RefactorF4Acc::Refactoring::Subroutines::Calls qw( create_refactored_subroutine_call );

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

@RefactorF4Acc::Refactoring::Subroutines::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::EXPORT_OK = qw(
    &refactor_all_subroutines
    &refactor_kernel_signatures
);

=pod
Subroutines
    refactor_all_subroutines
    _refactor_subroutine_main
    _refactor_globals
        rename_conflicting_locals #WV: not sure about this        
    _refactor_calls_globals 
=cut

# -----------------------------------------------------------------------------

sub refactor_all_subroutines {
    ( my $stref ) = @_;
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
#        say $f;
        next if ($f eq '' or not defined $f);
#    	die "refactor_all_subroutines(): empty subroutine name" if $f eq '';    	
        my $Sf = $stref->{'Subroutines'}{$f};     
           
        if ( not defined $Sf->{'Status'} ) {
            $Sf->{'Status'} = $UNREAD;
            print "WARNING: no Status for $f\n" if $W;            
        }
        next if $Sf->{'Status'} == $UNREAD;
        next if $Sf->{'Status'} == $READ;
        next if $Sf->{'Status'} == $FROM_BLOCK;
        next if (exists $Sf->{'Function'} and $Sf->{'Function'} ==1 ); 
      $stref = _refactor_subroutine_main( $f, $stref );
      
    }

    return $stref;
}    # END of refactor_all_subroutines()
# ------------------------------------------------------------------------
=pod

=begin markdown

## Info refactoring `_refactor_subroutine_main()`

Essentially, call `_refactor_globals()` on every sub

for every line:

- check if it needs changing:
- need to mark the insert points for subroutine calls that replace the refactored blocks! 
This is a node called 'RefactoredSubroutineCall'
- we also need the "entry point" for adding the declarations for the localized global variables 'ExGlobVarDecls'

* Signature: add the globals to the signature
(* VarDecls: keep as is)
* ExGlobVarDecls: add new var decls
* SubroutineCall: add globals for that subroutine to the call
* RefactoredSubroutineCall: insert a new subroutine call instead of the "begin of block" comment. 
* InBlock: skip; we need to handle the blocks separately
* BeginBlock: insert the new subroutine signature and variable declarations
* EndBlock: insert END
                      
=end markdown
=cut

sub _refactor_subroutine_main {
    ( my $f, my $stref ) = @_;
    local $V=1;
    if ($V) {
        print "\n\n";
        print "#" x 80, "\n";
        print "Refactoring $f\n";
        print "REFACTORING SUBROUTINE $f\n";
        print "#" x 80, "\n";
    }
    say "context_free_refactorings($f)" if $V;
    $stref = context_free_refactorings( $stref, $f );    

    my $Sf = $stref->{'Subroutines'}{$f};
    # At this point RefactoredArgs exists but is empty
#    if ($f eq 'LES_kernel_wrapper') { map {say} keys $Sf; die; }
say "get_annotated_sourcelines($f)" if $V;

    my $annlines = get_annotated_sourcelines($stref,$f);

# OK here for convect

    my $rlines = $annlines;
    if ( $Sf->{'HasCommons'} ) {
        print "REFACTORING COMMONS for SUBROUTINE $f\n" if $V;
        if ( $Sf->{'RefactorGlobals'} == 1 ) {
            say "_refactor_globals($f)" if $V;
          $rlines = _refactor_globals( $stref, $f, $annlines );
        } elsif ( $Sf->{'RefactorGlobals'} == 2 ) { 
            say "_refactor_calls_globals($f)" if $V;
            $rlines = _refactor_calls_globals( $stref, $f, $annlines );
        }
    }
    # At this point, commons should have been removed.
    # At this point, RefactoredArgs has a Set with $var => { 'IODir' => 'Unknown' }

    my $sub_or_prog = ( exists $Sf->{'Program'} and $Sf->{'Program'} == 1) ? 'program' : 
    (exists $Sf->{'Function'} and $Sf->{'Function'} == 1 ) ? 'function' : 'subroutine';
    say 'fix end '.$f if $V;
    my $done_fix_end=0;
    while (!$done_fix_end and @{$rlines}) {
        my $line =pop @{$rlines};
        my $info = $line->[1];
        next if ( $line->[0]=~/^\s*$/); # Skip comments
        if ( $line->[0]=~/^\s*end\s+$sub_or_prog/) {
            push @{$rlines}, $line;
            $done_fix_end=1;
            last ;
        }
        
        if ($line->[0]=~/^\s*end\s*$/ ) {
            $line->[0]=~s/\s+$//;
            push @{$rlines},[ $line->[0]." $sub_or_prog $f",$info];
            $done_fix_end=1;
        }
    }
    

    $Sf->{'RefactoredCode'}=$rlines;
    
    if ($f eq 'NONE') {
        for my $rl (@{ $rlines }) {
            print $rl->[0],"\n";
        }
        die;
    }
#    die Dumper($Sf->{RefactoredCode}) if $f=~/LES_kernel_wrapper/;
    # Here we have lost RefactoredCode for LES_kernel_wrapper
    
#   if ( $f eq 'convect' ) {
#       print "REFACTORED LINES ($f):\n";
#
#       for my $tmpline ( @{ $Sf->{'RefactoredCode'} } ) {
#           print $tmpline->[0], "\n";#"\t", join( ';', keys %{ $tmpline->[1] } ),"\n";
#       }
#       print "=================\n";
#       die;
#   }
# OK here for les.f
#if ($f eq 'LES_kernel_wrapper') { map {say} keys $Sf; die Dumper $Sf->{RefactoredArgs}; }
# So at this point the arguments have been refactored, but no declarations have been added
#die if $f=~/LES_kernel_wrapper/;
    return $stref;
}    # END of _refactor_subroutine_main()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------

sub _refactor_globals {
    ( my $stref, my $f, my $annlines ) = @_;
#    local $V=1 if $f =~/LES/;
#    $Data::Dumper::Indent =0;
#    $Data::Dumper::Terse=1;
#   croak "FIXME: the caller of a sub with RefactorGlobals should refactor its globals!";
    my $Sf = $stref->{'Subroutines'}{$f};
#    my $annlines = get_annotated_sourcelines($stref,$f);
    if ($Sf->{'RefactorGlobals'}==2) {
    	die "This should NEVER happen!";
        warn "FIXME: the caller of a sub with RefactorGlobals ($f) should refactor its globals!";
        # Which child has RefactorGlobals==1?
        my @additional_includes=();
        for my $cs ($Sf->{'CalledSubs'}) {          
            if ($stref->{'Subroutines'}{$cs}{'RefactorGlobals'}==1) {
                for my $inc ($stref->{'Subroutines'}{$cs}{'CommonIncludes'}) {
                    if (not exists $Sf->{'CommonIncludes'}{$inc}) {
                        push @additional_includes, $inc;
                        croak "$inc from $cs was missing from $f"; 
                    } 
                }
                
            }
        }       
    }
    print "REFACTORING GLOBALS in $f\n" if $V; 
    my $rlines      = [];
    my $s           = $Sf->{'Source'};
    my $is_C_target = exists $stref->{'BuildSources'}{'C'}{$s} ? 1 : 0;
    my $idx         = 0;
    

    for my $annline ( @{$annlines} ) {
        my $line      = $annline->[0] || '';
        my $info = $annline->[1];
        my %tags      = ( defined $info ) ? %{$info} : ();
        print '*** ' . join( ', ', map {"$_ => ".Dumper($tags{$_})} keys(%tags) ) . "\n" if $V;
        print '*** ' . $line . "\n" if $V;
        my $skip = 0;

        if ( exists $tags{'Signature'} ) {
            if (not exists $Sf->{'HasRefactoredArgs'} ) {
                 # Do this before the analysis for RefactoredArgs!
                 $stref = refactor_subroutine_signature( $stref, $f );
            }
            $rlines =
              create_refactored_subroutine_signature( $stref, $f, $annline,
                $rlines );
            $skip = 1;
        } 
        # There should be no need to do this: all /common/ blocks should have been removed anyway!
        if ( exists $tags{'Include'} ) {
            $skip = skip_common_include_statement( $stref, $f, $annline );
#            say "SKIP: $skip";
        }
if ( exists $tags{'ExGlobVarDeclHook'} ) {
#        if ( exists $tags{'ExGlobVarDecls'} and not exists $tags{'Deleted'} and not exists $tags{'Comments'} ) {
#            if (
#             $tags{'ExGlobVarDecls'} == $Sf->{'ExGlobVarDeclHook'} 
##            and $tags{'ExGlobVarDecls'}>0 # just trying really ...
#        ) {                    	
            # First, abuse ExGlobVarDecls as a hook for the addional includes, if any

            $rlines =
              create_new_include_statements( $stref, $f, $annline, $rlines );
              
           # Then generate declarations for ex-globals
           say "EX-GLOBS for $f" if $V;
            $rlines = create_exglob_var_declarations( $stref, $f, $annline, $rlines );

#        } else {
#            say "EX-GLOB HOOK MISMATCH:".$tags{'ExGlobVarDecls'}.'<>'.$Sf->{'ExGlobVarDeclHook'}; 
#        }
        }
   # This is what breaks flexpart, but it's OK for les ...
        if ( exists $tags{'VarDecl'} and not exists $tags{'Deleted'} and (not exists $tags{Ref} or $tags{Ref}==0)) {
            $rlines = create_refactored_vardecls( $stref, $f, $annline, $rlines,
                $is_C_target );
            $skip = 1;
        }

        if ( exists $tags{'SubroutineCall'} ) {
            # simply tag the common vars onto the arguments
            $rlines = create_refactored_subroutine_call( $stref, $f, $annline, $rlines );        
            $skip = 1;
        }

        if ( not exists $tags{'Comments'} and not exists $tags{'Deleted'} and $skip == 0 ) {
            $rlines =
              rename_conflicting_locals( $stref, $f, $annline, $rlines );
            $skip = 1;
        }
#        say "SKIP ULT: $skip";
        push @{$rlines}, $annline unless $skip;
        $idx++;
    } # loop over all lines
    
#    $Sf->{'RefactoredCode'}=$rlines;
#    return $stref;
#if ($f eq 'convect') {
#       map {print $_->[0]."\n"} @{$rlines}; die;
#   }
# OK here for les.f; but NOT OK for convect from flex_wrf!
    return $rlines;
}    # END of _refactor_globals()

# -----------------------------------------------------------------------------
sub _refactor_calls_globals {
    ( my $stref, my $f, my $annlines ) = @_;
#    my $annlines = get_annotated_sourcelines($stref,$f);
    print "REFACTORING CALLS WITH GLOBALS in $f\n" if $V;
    my $rlines      = [];
#    local $V=1;
    my $idx         = 0;
    my $firstinc=1;
    for my $annline ( @{$annlines} ) {
        my $line      = $annline->[0] || '';
        my $info = $annline->[1];
        my %tags      = ( defined $info ) ? %{$info} : ();
        print '*** ' . join( ',', map {"$_ => ".$tags{$_}} keys(%tags) ) . "\n" if $V;
        print '*** ' . $line . "\n" if $V;
        my $skip = 0;

# FIXME: rather we should find the line _after_ the last include!
# so we need $prevline in the reader or parser
# Basically I can keep an index counter and increment it every time I find an include
# then the next line, whatever it is, becomes "ExtraIncludesHook"        
#croak "Hook" if $f eq 'timemanager';
        if ( (exists $tags{'ExtraIncludesHook'}) && ($firstinc==1)) {        	   
        	
#        if ( exists $tags{'Include'} && $firstinc ) {
        	$firstinc =0;
            # First, add addional includes if required
            $rlines = create_additional_include_statements( $stref, $f, $annline, $rlines );
            
## While we're here, might as well generate the declarations for remapping and reshaping.
## If the subroutine contains a call to a function that requires this, of course.
## Executive decision: do this only for the routines to be translated to C/OpenCL
#            for my $called_sub ( keys %{ $Sf->{'CalledSubs'} } ) {
#                if ( exists $subs_to_translate{$called_sub} ) {
#
#                 # OK, we need to do the remapping, so create the machinery here
#                 # 1. Get the arguments of the called sub
#
## 2. Work out if they need reshaping. If so, create the declarations for the new 1-D arrays
#
## 3. Work out which remapped arrays will be used; create the declarations for these arrays
#
#                }
#            }
#            $skip = 1;
        }
        if ( exists $tags{'SubroutineCall'} 
        &&  exists $stref->{'Subroutines'}{ $tags{'SubroutineCall'}{'Name'} }{'RefactorGlobals'} 
        &&  $stref->{'Subroutines'}{ $tags{'SubroutineCall'}{'Name'} }{'RefactorGlobals'} ==1
        ) {
            # simply tag the common vars onto the arguments
            $rlines = create_refactored_subroutine_call( $stref, $f, $annline,
                $rlines );
                
            $skip = 1;
        }

        push @{$rlines}, $annline unless $skip;
        $idx++;
    }
    return $rlines;    
}    # END of _refactor_calls_globals()

# --------------------------------------------------------------------------------
# This routine renames instances of locals that conflict with globals (using names from ConflictingGlobals )
sub rename_conflicting_locals {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
    my $line               = $annline->[0] || '';
    my $info          = $annline->[1];
    my $Sf                 = $stref->{'Subroutines'}{$f};
    my $rline = $line;
    my $changed=0;
    if ( exists $Sf->{'ConflictingGlobals'} ) {    
        for my $lvar ( keys %{ $Sf->{'ConflictingGlobals'} } ) {
            if ( $rline =~ /\b$lvar\b/ ) {
                warn
    "WARNING: CONFLICT in $f, renaming $lvar with $Sf->{'ConflictingGlobals'}{$lvar}[0]\n"
                  if $W;
                $rline =~ s/\b$lvar\b/$Sf->{'ConflictingGlobals'}{$lvar}[0]/g;
                $changed=1;
            }
        }
    }
    if ($changed==1) {
    	$info->{'Ref'}++;
    }
    push @{$rlines}, [ $rline, $info ];
    return $rlines;
}    # END of rename_conflicting_locals()
