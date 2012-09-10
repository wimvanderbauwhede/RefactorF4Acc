package RefactorF4Acc::Analysis::Globals;

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

@RefactorF4Acc::Analysis::Globals::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Globals::EXPORT = qw(
    &resolve_globals
    &lift_includes
);




# -----------------------------------------------------------------------------

=pod

=begin markdown

`resolve_globals`:

- Walk the tree from the top. In the leaf nodes, find the globals with `identify_globals_used_in_subroutine()`
- On the return,
    - find globals in the current sub with `identify_globals_used_in_subroutine()`
    - merge the globals for the just-processed sub with the current ones
- Then, check for conflicts with parameter names, and rename the globals

=end markdown

=cut 

sub resolve_globals {
    ( my $f, my $stref ) = @_;
#    warn '=' x 80, "\nENTER resolve_globals( $f )\n" ;
    my $Sf = $stref->{'Subroutines'}{$f};
    if ( exists $Sf->{'CalledSubs'}
        and scalar keys %{ $Sf->{'CalledSubs'} } )
    {
        # Globals for $csub have been determined
        $stref = identify_globals_used_in_subroutine( $f, $stref );
        my @csubs = keys %{ $Sf->{'CalledSubs'} };
        for my $csub (@csubs) {
#        	warn "CALLED $csub from $f\n";
            $stref = resolve_globals( $csub, $stref );
            my $Scsub = $stref->{'Subroutines'}{$csub};
            # If $csub has globasl, merge them with globals for $f
            if (exists $Scsub->{'Globals'} ) {
                for my $inc ( keys %{ $Sf->{'CommonIncludes'} } ) {
            	   if ( exists $Scsub->{'Globals'}{$inc}) {
                    $Sf->{'Globals'}{$inc} = ordered_union( $Sf->{'Globals'}{$inc},
                        $Scsub->{'Globals'}{$inc} );
            	   }                    
                }    
            }            
        }
    } else {
        # Leaf node, find globals
        print "SUB $f is LEAF\n" if $V;
        $stref = identify_globals_used_in_subroutine( $f, $stref );
    }
#    warn '=' x 80, "\nEXIT resolve_globals( $f )\n" ;
#croak Dumper($stref->{'Subroutines'}{'getfields'}{'Globals'}) if $f eq 'getfields';
    # We only come here when the recursion and merge is done.
    $stref = resolve_conflicts_with_params( $f, $stref );
    
    return $stref;
}    # END of resolve_globals()

# ----------------------------------------------------------------------------------------------------

sub resolve_conflicts_with_params {
    ( my $f, my $stref ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};

    for my $inc ( keys %{ $Sf->{'Includes'} } ) {
        if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {

            # See if there are any conflicts between parameters and ex-globals
            for my $commoninc ( keys %{ $Sf->{'Globals'} } ) {
                for my $mpar ( @{ $Sf->{'Globals'}{$commoninc} } ) {
                    if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mpar} )
                    {
                        print
"WARNING: $mpar from $inc conflicts with $mpar from $commoninc\n"
                          if $V;
                        $Sf->{'ConflictingGlobals'}{$mpar} = $mpar . '_GLOB_'.$inc;                         
                        $stref->{'IncludeFiles'}{$commoninc}
                          {'ConflictingGlobals'}{$mpar} = $mpar . '_GLOB_'.$inc;
                        $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
                          {$mpar} = $mpar . '_GLOB_'.$inc;
#                          print "CONFLICTING GLOBAL PARAMETER: $mpar in $f and $inc\n";
                    }
                }
            }
        }
    }

    $Sf->{'ConflictingParams'} = {};
    for my $inc ( keys %{ $Sf->{'Includes'} } ) {
        if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
            if ( exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'} ) {
                %{ $Sf->{'ConflictingParams'} } = (
                    %{ $Sf->{'ConflictingParams'} },
                    %{ $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'} }
                );
            }
        }
    }

    return $stref;
}    # END of resolve_conflicts_with_params

# ----------------------------------------------------------------------------------------------------
# Here we identify which globals from the includes are actually used in the subroutine.
# This is not correct because globals used in called subroutines are not recognised
# So what I should do is find the globals for every called sub recursively.
sub identify_globals_used_in_subroutine {
    ( my $f, my $stref ) = @_;

#       local $V=1 if $f eq 'interpol_all';
    my $Sf = $stref->{'Subroutines'}{$f};

    # First determine subroutine arguments.
    $stref = determine_subroutine_arguments( $f, $stref );

    my %commons = ();
    print "COMMONS ANALYSIS in $f\n" if $V; 
    if ( not exists $Sf->{'Commons'} ) {
        for my $inc ( keys %{ $Sf->{'CommonIncludes'} } ) {
            print "COMMONS from $inc in $f? \n" if $V;
            $commons{$inc} = { %{ $stref->{'IncludeFiles'}{$inc}{'Commons'} } }; # This was a bug: ref insteaf of copy!         
        }

        $Sf->{'Commons'}    = \%commons;
        $Sf->{'HasCommons'} = 1;
    } else {
        print "already done\n" if $V;
        %commons = %{ $Sf->{'Commons'} };
    }

    my $srcref = $Sf->{'AnnLines'};
    print "GLOBALS ANALYSIS in $f\n" if $V; 
    if ( defined $srcref and not exists $Sf->{'Globals'} ) {
        for my $cinc ( keys %{ $Sf->{'CommonIncludes'} } ) {
            print "\nGLOBAL VAR ANALYSIS for $cinc in $f\n" if $V;
            my @globs = ();
            my $tvars = $commons{$cinc};
            for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
                my $line = $srcref->[$index][0];
#                my $info = $srcref->[$index][1];
                if ( $line =~ /^\!\s+/ )                            { next; }
                if ( $line =~ /^\s+end/ )                          { next; }
                if ( $line =~ /^\s+(recursive\s+subroutine|subroutine|program)\s+(\w+)/ ) { next; }

                # We shouldn't look for globals in the declarations, silly!
                if ( $line =~
/(logical|integer|real|double\s*precision|character|character\*?(?:\d+|\(\*\)))\s+(.+)\s*$/
                  )
                {
                    next;
                }

                # For all other lines, look for variables
                @globs =
                  ( @globs, look_for_variables( $stref, $f, $line, $tvars ) );
#                  $srcref->[$index]= [ $line, $info];
            }    # for each line
            
            if ($V) {
                print "\nGLOBAL VARS from $cinc in subroutine $f:\n\n";
                for my $var (@globs) {
                    print "VAR: $var\n".Dumper( $stref->{'IncludeFiles'}{$cinc}{'Commons'}{$var} );                    
                }
                print "\n";
            }
            
            $Sf->{'Globals'}{$cinc} = \@globs;
        }
    }
    return $stref;
}    # END of identify_globals_used_in_subroutine()
# -----------------------------------------------------------------------------

sub determine_subroutine_arguments {
    ( my $f, my $stref ) = @_;

    #   local $V=1 if $f=~/interpol/;
    my $Sf     = $stref->{'Subroutines'}{$f};
    my $srcref = $Sf->{'AnnLines'};
    if ( defined $srcref ) {

        # First determine subroutine arguments. Factor out?
        for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
            my $line = $srcref->[$index][0];
            my $info = $srcref->[$index][1];
#           my $SfI  = $Sf->{'Info'};
            if ( $line =~ /^\!\s/ ) {
                next;
            }

            # Determine the subroutine arguments
            if ( $line =~ /^\s+subroutine\s+(\w+)\s*\((.*)\)/
            or  $line =~ /^\s+recursive\s+subroutine\s+(\w+)\s*\((.*)\)/
            ) {
                my $name   = $1;                
                my $argstr = $2;
                $argstr =~ s/^\s+//;
                $argstr =~ s/\s+$//;
                my @args = split( /\s*,\s*/, $argstr );
                $info->{'Signature'}{'Args'} = [@args];
                $info->{'Signature'}{'Name'} = $name;
#                $srcref->[$index][1]{'Signature'}{'Args'} = [@args];
#                $srcref->[$index][1]{'Signature'}{'Name'} = $name;
                $Sf->{'Args'}                                = [@args];
                last;
            } elsif ( $line =~ /^\s+subroutine\s+(\w+)[^\(]*$/ 
            or $line =~ /^\s+recursive\s+subroutine\s+(\w+)[^\(]*$/ 
            ) {

                # Subroutine without arguments
                my $name = $1;
                $info->{'Signature'}{'Args'} = [];
                my $has_var_decls = scalar %{ $Sf->{'Vars'} };
                if ( not $has_var_decls ) {
                    print "INFO: $f has no arguments and no local var decls\n"
                      if $V;
                    if ( exists $Sf->{'ImplicitNone'} ) {
                        print "INFO: $f has 'implicit none'\n" if $V;
                        my $idx = $Sf->{'ImplicitNone'} + 1;
                        $srcref->[$idx][1]{'ExGlobVarDecls'} = {};                                        
                    } else {
                        $info->{'ExGlobVarDecls'} = {};
                    }
                }
                $info->{'Signature'}{'Name'} = $name;
#                $srcref->[$index][1]{'Signature'}{'Name'} = $name;
                $Sf->{'Args'} = [];
                last;
            } elsif ( $line =~ /^\s+program\s+(\w+)\s*$/ ) {
                # If it's a program, there are no arguments
                my $name = $1;
                $info->{'Signature'}{'Args'} = [];
                $info->{'Signature'}{'Name'} = $name;
#                $srcref->[$index][1]{'Signature'}{'Args'} = [];
#                $srcref->[$index][1]{'Signature'}{'Name'} = $name;
                last;
            }
            $srcref->[$index]=[ $line, $info];
        }    # for each line
    }
    $Sf->{'AnnLines'}=$srcref; # WV: required?
    return $stref;
}    # END of determine_subroutine_arguments()
# -----------------------------------------------------------------------------
sub look_for_variables {
    ( my $stref, my $f, my $line, my $tvars ) = @_;
    my $Sf     = $stref->{'Subroutines'}{$f};
    my @globs  = ();
    my @chunks = split( /\W+/, $line );
    for my $mvar (@chunks) {

#    next if $mvar =~/\b(?:if|then|do|goto|integer|real|call|\d+)\b/; # is slower!
# if a var on a line is declared locally, it is obviously not a global!
        if ( exists $tvars->{$mvar} and not $Sf->{'Vars'}{$mvar} ) {
            my $is_par = 0;
            for my $inc ( keys %{ $Sf->{'Includes'} } ) {
                if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter'
                    and exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mvar} )
                {
                    print "WARNING: $mvar in $f is a PARAMETER from $inc!\n"
                      if $W;
                    $is_par = 1;
                    last;
                }
            }
            if ( not $is_par ) {
                print "FOUND global $mvar in $line\n" if $V;
                push @globs, $mvar;
                delete $tvars->{$mvar};
            }
        }
    }
    return @globs;
}    # END of look_for_variables()

# -----------------------------------------------------------------------------
# Only to be called for subs with RefactorGlobals == 2
sub lift_includes {
    ( my $stref, my $f) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};    
        # Which child has RefactorGlobals==1?    
    $Sf->{'LiftedIncludes'} =[]; # We will use this to create the additional include statements
    for my $cs (keys %{ $Sf->{'CalledSubs'} }) {             
    	croak 'No subroutine name ' if $cs eq '' or not defined $cs;
        if ($stref->{'Subroutines'}{$cs}{'RefactorGlobals'}==1) {
            for my $inc (keys %{ $stref->{'Subroutines'}{$cs}{'CommonIncludes'} }) {
                if (not exists $Sf->{'Includes'}{$inc} and $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common') {
#                	print "LIFTED $inc\n";                	        
                    push @{ $Sf->{'LiftedIncludes'} }, $inc;
                } 
            }
        }
    }            
    # Once we know the includes, we can check for conflicts.
    my @vars = keys %{ $Sf->{'Vars'} };
    for my $var (@vars) {
#    	print "$f: VAR $var\n"; 
        for my $lifted_inc ( @{ $Sf->{'LiftedIncludes'} } ) {
            if (exists $stref->{'IncludeFiles'}{$lifted_inc}{'Vars'}{$var}) {
            	$Sf->{'ConflictingLiftedVars'}{$var}=$var.'_LOCAL_'.$f;
            	print "lift_includes( $f ): $var CONFLICT with $lifted_inc\n" if $V;
            	last;
            }
        }
    }
    return $stref;
}    # END of lift_includes()
