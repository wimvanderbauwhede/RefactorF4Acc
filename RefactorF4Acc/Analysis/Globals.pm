package RefactorF4Acc::Analysis::Globals;
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

@RefactorF4Acc::Analysis::Globals::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Globals::EXPORT = qw(
    &resolve_globals
    &lift_includes
    &lift_globals
);

# -----------------------------------------------------------------------------

=pod

=begin markdown

`resolve_globals`:

- Walk the tree from the top. In the leaf nodes, find the globals with `_identify_globals_used_in_subroutine()`
- On the return,
    - find globals in the current sub with `_identify_globals_used_in_subroutine()`
    - merge the globals for the just-processed sub with the current ones
- Then, check for conflicts with parameter names, and rename the globals

=end markdown

=cut 

sub resolve_globals {
    ( my $f, my $stref ) = @_;
#    say $f;
#    if ($f eq 'main') {
#    local $V=1;
#    }
    print '=' x 80, "\nENTER resolve_globals( $f )\n" if $V;
    if (exists $stref->{'Subroutines'}{$f} ) {
#        die Dumper( $stref->{'Subroutines'}{$f}  ) if $f=~/module_press/;
    my $Sf = $stref->{'Subroutines'}{$f};
    if ( exists $Sf->{'CalledSubs'}
        and scalar keys %{ $Sf->{'CalledSubs'} } )
    {
        # Globals for $csub have been determined
        print "GLOBALS for CALLED SUBS in $f have been determined\n" if $V;
        $stref = _identify_globals_used_in_subroutine( $f, $stref );
        my @csubs = keys %{ $Sf->{'CalledSubs'} };
        for my $csub (@csubs) {
#        	warn "CALLED $csub from $f\n";
            $stref = resolve_globals( $csub, $stref );
            my $Scsub = $stref->{'Subroutines'}{$csub};
            # If $csub has globasl, merge them with globals for $f
            if (exists $Scsub->{'Globals'} ) {
#                for my $inc ( keys %{ $Sf->{'CommonIncludes'} } ) {
            	   if ( exists $Scsub->{'Globals'}{'List'}) {
                    $Sf->{'Globals'}{'List'} = ordered_union( $Sf->{'Globals'}{'List'},
                        $Scsub->{'Globals'}{'List'} );
            	       
#            	   say $f, $csub;                
            	   $Sf->{'Globals'}{'Set'} = { %{ $Sf->{'Globals'}{'Set'} }, %{ $Scsub->{'Globals'}{'Set'} } };
            	   }            	   
#                }    
            }            
        }
    } else {
        # Leaf node, find globals
        print "SUB $f is LEAF\n" if $V;
        $stref = _identify_globals_used_in_subroutine( $f, $stref );
    }

    # We only come here when the recursion and merge is done.   
    $stref = _resolve_conflicts_with_params( $f, $stref );

    }
    
    return $stref;
}    # END of resolve_globals()

# ----------------------------------------------------------------------------------------------------
# I create a table ConflictingGlobals in $f, $inc and $commoninc
# I think the right approach is to rename the common vars, not the parameters.
sub _resolve_conflicts_with_params {
    ( my $f, my $stref ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};

    for my $inc ( keys %{ $Sf->{'Includes'} } ) {
        if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {

            # See if there are any conflicts between parameters and ex-globals
#            for my $commoninc ( keys %{ $Sf->{'Globals'} } ) {
                for my $mpar ( @{ $Sf->{'Globals'}{'List'} } ) {
                    if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mpar} )
                    {
                    	my $commoninc = $Sf->{'Globals'}{'Set'}{$mpar}{'Inc'};
                        print
"WARNING: $mpar from $inc conflicts with $mpar from $commoninc\n"
                          if $V;
                          # So we store the new name, the Common include and the Parameter include in that order
                        $Sf->{'ConflictingGlobals'}{$mpar} = [$mpar . '_GLOB_'.$commoninc,$commoninc,$inc];# In fact, just $commoninc is enough                         
                        $stref->{'IncludeFiles'}{$commoninc}
                          {'ConflictingGlobals'}{$mpar} = [$mpar . '_GLOB_'.$inc,$commoninc,$inc];
                        $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
                          {$mpar} =[ $mpar . '_GLOB_'.$inc,$commoninc,$inc];
#                          print "CONFLICTING GLOBAL PARAMETER: $mpar in $f and $inc\n";
                    }
                }
#            }
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
}    # END of _resolve_conflicts_with_params

# ----------------------------------------------------------------------------------------------------
# Here we identify which globals from the includes are actually used in the subroutine.
# This is not correct because globals used in called subroutines are not recognised
# So what I should do is find the globals for every called sub recursively.
# WV20150806: I should first work out what the includes with commons are in all subroutines and then "lift" them and then call this subroutine. 
sub _identify_globals_used_in_subroutine {
    ( my $f, my $stref ) = @_;

#       local $V=1;# if $f eq 'particles_main_loop';
    my $Sf = $stref->{'Subroutines'}{$f};

    my $srcref = $Sf->{'AnnLines'};
    print "\tGLOBALS ANALYSIS in $f\n" if $V;
#    die Dumper($Sf->{'Globals'}) if $f=~/bondfg/i;
    if ( defined $srcref and (not exists $Sf->{'Globals'} or scalar keys %{$Sf->{'Globals'}{'Set'}} == 0) ) { #  
#    croak '_identify_globals_used_in_subroutine LINE 158!';
    
        for my $cinc ( keys %{ $Sf->{'CommonIncludes'} } ) { 
            print "\n\tGLOBAL VAR ANALYSIS for $cinc in $f\n" if $V; ;
            my @globs = ();
            my $tvars = { %{ $stref->{'IncludeFiles'}{$cinc}{'Commons'} } };
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
                  ( @globs, __look_for_variables( $stref, $f, $line, $tvars ) );
#                  $srcref->[$index]= [ $line, $info];
            }    # for each line
            
            if ($V) {
                print "\nGLOBAL VARS from $cinc in subroutine $f:\n\n";
                for my $var (@globs) {
                    print "VAR: $var\n".Dumper( $stref->{'IncludeFiles'}{$cinc}{'Commons'}{$var} );                    
                }
                print "\n";
            }
            
            $Sf->{'Globals'}{'List'} = \@globs;            
            $Sf->{'Globals'}{'Set'}={};
            
            
            for my $var (@globs) {
            	my $subset=in_nested_set($stref->{'IncludeFiles'}{$cinc}, 'Vars', $var);
#            		say $subset;
#            		say Dumper($stref->{'IncludeFiles'}{$cinc}{$subset}{'Set'});
            	my $var_rec= $stref->{'IncludeFiles'}{$cinc}{$subset}{'Set'}{$var};
#            	say Dumper($var_rec);
                $Sf->{'Globals'}{'Set'}{$var} = $var_rec ;
            }
            $Sf->{'HasCommons'} = 1;
        }
        
    } 
#    else {
#        die "GLOBALS FOR $f:".Dumper($Sf->{'Globals'}); 
#    }
#    die if $f eq 'main';
#    die Dumper($Sf->{'Globals'}) if $f eq 'main';
    return $stref;
}    # END of _identify_globals_used_in_subroutine()
# -----------------------------------------------------------------------------

sub __determine_subroutine_arguments_OFF {
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
            or  $line =~ /^\s+function\s+(\w+)\s*\((.*)\)/
            or  $line =~ /^\s+\w+\s+function\s+(\w+)\s*\((.*)\)/
            
            ) {
#                if (not exists $info->{SubroutineSig}) {say Dumper($info);die;}
                my $name   = $1;                
                my $argstr = $2;
                $argstr =~ s/^\s+//;
                $argstr =~ s/\s+$//;
                my @args = split( /\s*,\s*/, $argstr );
                $info->{'Signature'}{'Args'}{'List'} = [@args];
                $info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @args};
                $info->{'Signature'}{'Name'} = $name;
                $Sf->{'OrigArgs'}{'List'} = [@args];
                $Sf->{'OrigArgs'}{'Set'} = {map {$_=>1} @args};
                last;
            } elsif ( $line =~ /^\s+subroutine\s+(\w+)[^\(]*$/ 
            or $line =~ /^\s+recursive\s+subroutine\s+(\w+)[^\(]*$/ 
            ) {

                # Subroutine without arguments
                my $name = $1;
                $info->{'Signature'}{'Args'}{'List'} = [];
                $info->{'Signature'}{'Args'}{'Set'} = {};
                my $has_var_decls = scalar %{ $Sf->{'Vars'} };
                if ( not $has_var_decls ) {
                    print "INFO: $f has no arguments and no local var decls\n"
                      if $V;
                      
                    if ( exists $Sf->{'ImplicitNone'} ) {
                        print "INFO: $f has 'implicit none'\n" if $V;
                        my $idx = $Sf->{'ImplicitNone'} + 1;
#                        $srcref->[$idx][1]{'ExGlobArgDecls'} =  ++$Sf->{ExGlobVarDeclHook}; #{}; 
#                        print "__determine_subroutine_arguments($f)\t",$srcref->[$idx][0],"\tEX:",$srcref->[$idx][1]{'ExGlobArgDecls'},'<>',$Sf->{ExGlobVarDeclHook},"\n";                                       
                    } else {
#                        $info->{'ExGlobArgDecls'} =  ++$Sf->{ExGlobVarDeclHook};#{}; 
#                        print "__determine_subroutine_arguments($f)\t",$line,"\tEX:",$info->{'ExGlobArgDecls'},'<>',$Sf->{ExGlobVarDeclHook},"\n";
                    }
                }
                $info->{'Signature'}{'Name'} = $name;
                $Sf->{'OrigArgs'}{'List'} = [];
                $Sf->{'OrigArgs'}{'Set'} = {};
                last;
            } elsif ( $line =~ /^\s+program\s+(\w+)\s*$/ ) {;
                # If it's a program, there are no arguments
                my $name = $1;
                
                $info->{'Signature'}{'Args'}{'List'} = [];
                $info->{'Signature'}{'Name'} = $name;
#                $info->{'ExGlobArgDecls'} =  ++$Sf->{ExGlobVarDeclHook};#{}; # FIXME: This is not good: if an include exists, it should be after the include!!! What we need is to track where it should go: after Sig, after last Incl or before first VarDecl
#                print "__determine_subroutine_arguments($f)\t",$line,"\tEX:",$info->{'ExGlobArgDecls'},'<>',$Sf->{ExGlobVarDeclHook},"\n";
                $Sf->{'OrigArgs'}{'List'} = [];
                $Sf->{'OrigArgs'}{'Set'} = {};
                last;
            }
            $srcref->[$index]=[ $line, $info];
        }    # for each line
    }
    $Sf->{'AnnLines'}=$srcref; # WV: required?
    return $stref;
}    # END of __determine_subroutine_arguments_OFF()
# -----------------------------------------------------------------------------
sub __look_for_variables {
    ( my $stref, my $f, my $line, my $tvars ) = @_;
    my $Sf     = $stref->{'Subroutines'}{$f};
    my @globs  = ();
    
    my @chunks = split( /\W+/, $line );
    for my $mvar (@chunks) {
#    next if $mvar =~/\b(?:if|then|do|goto|integer|real|call|\d+)\b/; # is slower!
# if a var on a line is declared locally, it is obviously not a global!
        if ( exists $tvars->{$mvar} and not in_nested_set($Sf,'Vars',$mvar) ) {
            my $is_par = 0;
            for my $inc ( keys %{ $Sf->{'Includes'} } ) {
                if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter'
                    and in_nested_set($stref->{'IncludeFiles'}{$inc},'Vars',$mvar) )
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
}    # END of __look_for_variables()

# -----------------------------------------------------------------------------
# Only to be called for subs with RefactorGlobals == 2
# What this does is lift the includes from child node to parent node, i.e. if a called sub contains an 
# include and the caller doesn't, and if RefactorGlobals == 2 and it is an include with common blocks, then it is lifted.
# I've actually forgotten why this is needed.
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
croak 'lift_includes';        
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
            if (in_nested_set( $stref->{'IncludeFiles'}{$lifted_inc},'Vars',$var)) {
            	$Sf->{'ConflictingLiftedVars'}{$var}=$var.'_LOCAL_'.$f;
            	warn "lift_includes( $f ): $var CONFLICT with $lifted_inc\n" if $V;
            	last;
            }
        }
    }
    return $stref;
}    # END of lift_includes()

# Here we start from the top, descend to the leaves, get the Globals in the leaves, and add them to the Globals of the caller.
# And of course we need to update ExGlobVarDecls
# This should be done before we create RefactoredArgs!
sub lift_globals { ;
    (my $stref, my $f) = @_;
    print '=' x 80, "\nENTER resolve_globals( $f )\n" if $V;
    if (exists $stref->{'Subroutines'}{$f} ) {
    my $Sf = $stref->{'Subroutines'}{$f};
    if ( exists $Sf->{'CalledSubs'}
        and scalar keys %{ $Sf->{'CalledSubs'} } )
    {
        my @csubs = keys %{ $Sf->{'CalledSubs'} };
        for my $csub (@csubs) {            
            $stref = lift_globals($stref, $csub );
            my $Scsub = $stref->{'Subroutines'}{$csub};
            # If $csub has globals, merge them with globals for $f, otherwise inherit them
            if (exists $Scsub->{'ExGlobArgDecls'} ) {
                if (exists $Sf->{'ExGlobArgDecls'}{'List'} ) {
#                	say "MERGE GLOBALS from $csub into $f: ".join(',',@{$Sf->{'ExGlobArgDecls'}{'List'}}). ' AND ' .join(',',@{$Scsub->{'ExGlobArgDecls'}{'List'}}); 
                    $Sf->{'ExGlobArgDecls'}{'List'} = ordered_union( $Sf->{'ExGlobArgDecls'}{'List'},$Scsub->{'ExGlobArgDecls'}{'List'} );
                } else {
                    $Sf->{'ExGlobArgDecls'}{'List'} = $Scsub->{'ExGlobArgDecls'}{'List'} ;
                } 
                if ( exists $Sf->{'ExGlobArgDecls'}{'Set'} ) {      
            	   $Sf->{'ExGlobArgDecls'}{'Set'} = { %{ $Sf->{'ExGlobArgDecls'}{'Set'} }, %{ $Scsub->{'ExGlobArgDecls'}{'Set'} } };
                } else {
                    $Sf->{'ExGlobArgDecls'}{'Set'} = {  %{ $Scsub->{'ExGlobArgDecls'}{'Set'} } };
                    $Sf->{'HasCommons'} = 1;
                }            	       
            }            
        } 
    } else {
        # Leaf node, find globals
        say "SUB $f is LEAF" if $V; 
        $stref = _identify_globals_used_in_subroutine( $f, $stref );
    }    
    
    # We only come here when the recursion and merge is done.   
    $stref = _resolve_conflicts_with_params( $f, $stref );

    }
    
    return $stref;
    
} # END of lift_globals()
