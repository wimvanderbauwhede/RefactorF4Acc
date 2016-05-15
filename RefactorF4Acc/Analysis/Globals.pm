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
use Storable qw( dclone );
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Analysis::Globals::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Globals::EXPORT = qw(    
    &lift_includes
    &identify_inherited_exglobs_to_rename
    &lift_globals
    &rename_inherited_exglobs
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
#
#sub resolve_globals_OFF {
#    ( my $f, my $stref ) = @_;
#    print '=' x 80, "\nENTER resolve_globals( $f )\n" if $V;
#    if (exists $stref->{'Subroutines'}{$f} ) {
#    my $Sf = $stref->{'Subroutines'}{$f};
#    if ( exists $Sf->{'CalledSubs'}
#        and scalar keys %{ $Sf->{'CalledSubs'} } )
#    {
#        # Globals for $csub have been determined
#        print "GLOBALS for CALLED SUBS in $f have been determined\n" if $V;
#        $stref = _identify_globals_used_in_subroutine( $f, $stref );
#        my @csubs = keys %{ $Sf->{'CalledSubs'} };
#        for my $csub (@csubs) {
#            $stref = resolve_globals( $csub, $stref );
#            my $Scsub = $stref->{'Subroutines'}{$csub};
#            # If $csub has globasl, merge them with globals for $f
#            if (exists $Scsub->{'Globals'} ) {
#            	   if ( exists $Scsub->{'Globals'}{'List'}) {
#                    $Sf->{'Globals'}{'List'} = ordered_union( $Sf->{'Globals'}{'List'},
#                        $Scsub->{'Globals'}{'List'} );
#            	   $Sf->{'Globals'}{'Set'} = { %{ $Sf->{'Globals'}{'Set'} }, %{ $Scsub->{'Globals'}{'Set'} } };
#            	   }            	   
#            }            
#        }
#    } else {
#        # Leaf node, find globals
#        print "SUB $f is LEAF\n" if $V;
#        $stref = _identify_globals_used_in_subroutine( $f, $stref );
#    }
#    # We only come here when the recursion and merge is done.   
#    $stref = _resolve_conflicts_with_params( $f, $stref );
#    }    
#    return $stref;
#}    # END of resolve_globals()

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

# WV20160510: is it possible that here we have an issue with renamed ex-globals? 
sub _identify_globals_used_in_subroutine {
    ( my $f, my $stref ) = @_;

#       local $V=1;# if $f eq 'particles_main_loop';
    my $Sf = $stref->{'Subroutines'}{$f};

    my $srcref = $Sf->{'AnnLines'};
    print "\tGLOBALS ANALYSIS in $f\n" if $V;
	say "LEAF SUB $f:". ("$Sf->{'Globals'}" eq "$Sf->{'ExGlobArgDecls'}") ? 'OK!'. $Sf->{'HasCommons'} : 'NOK!';
    if ( defined $srcref and (not exists $Sf->{'Globals'} or scalar keys %{$Sf->{'Globals'}{'Set'}} == 0) ) { #  
    carp "_identify_globals_used_in_subroutine($f) LINE " . __LINE__ .' : '.Dumper($Sf->{'Globals'});
    
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
            	my $var_rec= $stref->{'IncludeFiles'}{$cinc}{$subset}{'Set'}{$var};
                $Sf->{'Globals'}{'Set'}{$var} = $var_rec ;
            }
            $Sf->{'HasCommons'} = 1;
        }
        croak "_identify_globals_used_in_subroutine($f) LINE " . __LINE__ .' : '.Dumper($Sf->{'Globals'}) if scalar keys %{$Sf->{'Globals'}{'Set'}} > 0;        
    } 
    carp "LEAF SUB $f:".Dumper($Sf->{'Globals'}).'<>'.Dumper($Sf->{'ExGlobArgDecls'}) if $f eq 'advance';
    return $stref;
}    # END of _identify_globals_used_in_subroutine()
# -----------------------------------------------------------------------------

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
    for my $cs (@{ $Sf->{'CalledSubs'}{'List'} }) {             
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

# This is lift_globals without the merge part
sub identify_inherited_exglobs_to_rename {
	  (my $stref, my $f) = @_;
#    local $V=1;
    my $ext = '_GLOB' ;
    say '=' x 80, "\nENTER lift_globals( $f )" if $V;
    if (exists $stref->{'Subroutines'}{$f} ) {
    	my $Sf = $stref->{'Subroutines'}{$f};
#    	croak Dumper($Sf->{'ExGlobArgDecls'}) if $f eq 'interpol_all';
    	if ( exists $Sf->{'CalledSubs'}{'List'}
        and scalar @{ $Sf->{'CalledSubs'}{'List'} }>0 )
	    {
	    	
	    	# This sub is calling other subs	    	
	        my @csubs = @{ $Sf->{'CalledSubs'}{'List'} };
	        $Sf->{'RenamedInheritedExGLobs'}  = { 'List' => [], 'Set' => {}} unless exists $Sf->{'RenamedInheritedExGLobs'};
	        for my $csub (@csubs) {       
	       		say "CALL TO  $csub from $f" if $V;     
	            $stref = identify_inherited_exglobs_to_rename($stref, $csub );
	            say "RETURN TO $f from CALL to $csub" if $V;
	            my $Scsub = $stref->{'Subroutines'}{$csub};
	            # If $f and $csub both have globals, merge them, otherwise inherit them
	            
	            if (exists $Scsub->{'ExGlobArgDecls'} ) {
	            	# Check which inherited ex-globs need to be renamed
	            	for my $exglob (@{  $Scsub->{'ExGlobArgDecls'}{'List'} }) {	            		
	            		if (not exists  $Sf->{'ExGlobArgDecls'}{'Set'}{$exglob}) {
	            			say "OK TO RENAME $exglob TO $exglob$ext in $f" if $V;
	            			$Sf->{'RenamedInheritedExGLobs'}{'Set'}{$exglob}="$exglob$ext";
	            		} else {
	            			say "NOT OK TO RENAME $exglob in $f" if $V;
	            		}
	            	}     	            	  	       
	            }               
	        } 
	    } else {
	        # Leaf node, find globals	        
	        say "SUB $f is LEAF" if $V; 
	    }    
    }    
    return $stref;
} #  END of identify_inherited_exglobs_to_rename()

# So we go through all ExGlobArgDecls and we rename every exglob from RenamedInheritedExGLobs 
sub rename_inherited_exglobs  {
		  (my $stref, my $f) = @_;
#    local $V=1;
    my $ext = '_GLOB' ;
    say '=' x 80, "\nENTER lift_globals( $f )" if $V;
    if (exists $stref->{'Subroutines'}{$f} ) {
    	my $Sf = $stref->{'Subroutines'}{$f};
	            
            if (scalar keys %{$Sf->{'RenamedInheritedExGLobs'}{'Set'}} >0 and  exists $Sf->{'ExGlobArgDecls'} ) {	            	
            	# Check which inherited ex-globs need to be renamed
            	my $renamed_exglob_list = [];
            	my $renamed_exglob_set = dclone( $Sf->{'ExGlobArgDecls'}{'Set'} );
            	for my $exglob (@{  $Sf->{'ExGlobArgDecls'}{'List'} }) {            		
            		if (exists  $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$exglob}) {
            			say "RENAMING $exglob TO $exglob$ext in $f" if $V;
            			my $new_name = $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$exglob};
            			push @{$renamed_exglob_list},$new_name;
            			$renamed_exglob_set->{$new_name}=dclone($renamed_exglob_set->{$exglob} );
						$renamed_exglob_set->{$new_name}{'Name'}=$new_name;
						$renamed_exglob_set->{$new_name}{'OrigName'}=$exglob;
						# Seems to me I should then delete the entry for the old name!
						delete $renamed_exglob_set->{$exglob};
            		} else {
            			say "NOT RENAMING $exglob in $f" if $V;
            			push @{$renamed_exglob_list},$exglob;
            		}
            	}
            	 $Sf->{'ExGlobArgDecls'}{'List'}=$renamed_exglob_list;
            	  $Sf->{'ExGlobArgDecls'}{'Set'}=$renamed_exglob_set;	            	
            }       	
    	
    	
    	if ( exists $Sf->{'CalledSubs'}{'List'}
        and scalar @{ $Sf->{'CalledSubs'}{'List'} }>0 )
	    {
	    	# This sub is calling other subs	    	
	        my @csubs = @{ $Sf->{'CalledSubs'}{'List'} };	        
	        for my $csub (@csubs) {       
	       		say "CALL TO  $csub from $f" if $V;     
	            $stref = rename_inherited_exglobs($stref, $csub );
	            say "RETURN TO $f from CALL to $csub" if $V;
            
	        } 
	    } else {
	        # Leaf node, find globals
	        say "SUB $f is LEAF" if $V; 
	    }    
    }    
    return $stref;
	
} #  END of identify_globals_to_rename()


# The renaming detection should be done in identify_inherited_exglobs_to_rename()
sub lift_globals { 
    (my $stref, my $f) = @_;
    local $V=0;
#    my $ext = '_GLOB' ;
    say '=' x 80, "\nENTER lift_globals( $f )" if $V;
    if (exists $stref->{'Subroutines'}{$f} ) {
    	my $Sf = $stref->{'Subroutines'}{$f};
    	if ( exists $Sf->{'CalledSubs'}{'List'}
        and scalar @{ $Sf->{'CalledSubs'}{'List'} }>0 )
	    {
	    	# This sub is calling other subs	    	
	        my @csubs = @{ $Sf->{'CalledSubs'}{'List'} };
	        $Sf->{'RenamedInheritedExGLobs'}  = { 'List' => [], 'Set' => {}} unless exists $Sf->{'RenamedInheritedExGLobs'};
#			my $dups = find_duplicates_in_list($Sf->{'ExGlobArgDecls'}{'List'});
#	        if (scalar keys %{$dups}>0) {
#	            	croak "$f has DUPS:".Dumper($dups)
#	        } else {
#	        	say "NO DUPS in $f"; 
#			} 
	        for my $csub (@csubs) {       
	       		say "CALL TO  $csub from $f" if $V;     
	            $stref = lift_globals($stref, $csub );
	            say "RETURN TO $f from CALL to $csub" if $V;
	            my $Scsub = $stref->{'Subroutines'}{$csub};
#	            my %tmp = map { $_ => 1 } @{ $Scsub->{'ExGlobArgDecls'}{'List'} };
#	        	for my $k (keys %tmp) {
#	        		croak "$f => $k after $csub: ".Dumper( $Scsub->{'ExGlobArgDecls'}{'List'} ) if $k=~/_GLOB/ and $f eq 'map_set';
#	        	} 
#				my $dups3 = find_duplicates_in_list($Sf->{'ExGlobArgDecls'}{'List'});
#		        if (scalar keys %{$dups3}>0) {
#	    	    	croak "ON RETURN FROM $csub: $f has DUPS:".Dumper($dups3)
#	        	} else {
#	        		say "ON RETURN FROM $csub: NO DUPS in $f"; 
#				} 
# ------------------	            	            
	            # If $f and $csub both have globals, merge them, otherwise inherit them
	            if (exists $Scsub->{'ExGlobArgDecls'} ) {
#	            	if (0) {
#	            	# First find all vars in $csub that are not in $f
#	            	# because if a var is present in $f it should NOT be renamed 
#	            	my $ex_globs_from_csub_only_list = ordered_difference( $Sf->{'ExGlobArgDecls'}{'List'}, $Scsub->{'ExGlobArgDecls'}{'List'} );
#	            	say Dumper($ex_globs_from_csub_only_list);	            	
#	            	my %ex_globs_from_csub_only = map { $_ => 1 } @{$ex_globs_from_csub_only_list};
#	            	# Then rename only these	            	            	
#	            	my $ext = '_GLOB' ;#'_GLOB_from_'.$csub
#	            	my $renamed_inherited_globs = { 'List' => [], 'Set' => {}};
#	            				
##	            	my $dups3 = find_duplicates_in_list($Scsub->{'ExGlobArgDecls'}{'List'});
##	        if (scalar keys %{$dups3}>0) {
##	            	say "$csub has DUPS:".Dumper($dups3)
##	        } else {
##	        	say " NO DUPS in $csub ExGlobArgDecls:\n".Dumper($dups3).Dumper($Scsub->{'ExGlobArgDecls'}{'List'}); 
##			} 
#	            	
#	            	for my $ex_glob ( @{$Scsub->{'ExGlobArgDecls'}{'List'}} ) {
#	            		my $maybe_renamed_ex_glob = $ex_glob;
#	            		if (exists $ex_globs_from_csub_only{$ex_glob} and $ex_glob!~/$ext/) {
#	            			$maybe_renamed_ex_glob .= $ext;
#	            		} 
#	            		push @{ $renamed_inherited_globs->{'List'} }, $maybe_renamed_ex_glob;
#	            	}
##	            	my $dups3 = find_duplicates_in_list($renamed_inherited_globs->{'List'});
##	        if (scalar keys %{$dups3}>0) {
##	            	croak "$csub renamed_inherited_globs has DUPS:\n".Dumper($dups3).Dumper($renamed_inherited_globs->{'List'});
##	        } else {
##	        	say " NO DUPS in $csub"; 
##			} 
#	            	for my $ex_glob (keys %{ $Scsub->{'ExGlobArgDecls'}{'Set'} }) {
#	            		$Sf->{'ExGlobArgDecls'}{'Set'}{$ex_glob}=$Scsub->{'ExGlobArgDecls'}{'Set'}{$ex_glob};
##	            		my $maybe_renamed_ex_glob = $ex_glob;
##	            		if (exists $ex_globs_from_csub_only{$ex_glob} ) {
##	            			$maybe_renamed_ex_glob .= $ext unless $ex_glob=~/$ext/;
##	            			$Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob}=$maybe_renamed_ex_glob;
##	            		} 
##	            		$renamed_inherited_globs->{'Set'}{$maybe_renamed_ex_glob}=dclone($Scsub->{'ExGlobArgDecls'}{'Set'}{$ex_glob});
##	            		$renamed_inherited_globs->{'Set'}{$maybe_renamed_ex_glob}{'Name'}=$maybe_renamed_ex_glob;
#		            	}
#	            	}
	            	
#	            	# Check which inherited ex-globs need to be renamed
#	            	for my $exglob (@{  $Scsub->{'ExGlobArgDecls'}{'List'} }) {
#	            		if (not exists  $Sf->{'ExGlobArgDecls'}{'Set'}{$exglob}) {
#	            			say "OK TO RENAME $exglob TO $exglob$ext in $f";
#	            			$Sf->{'RenamedInheritedExGLobs'}{'Set'}{$exglob}="$exglob$ext";
#	            		} else {
#	            			say "NOT OK TO RENAME $exglob in $f";
#	            		}
#	            	} 
#	            	# Now merge or inherit
#	            	croak "THIS NEEDS TO BE DONE IN A SEPARATE PASS!";
	            	
	                if (exists $Sf->{'ExGlobArgDecls'}{'List'} ) {
	                	# Merge
	                	# The idea is that this merge will only at unique new vars
	                	# But I do find duplicates!
	                    $Sf->{'ExGlobArgDecls'}{'List'} = ordered_union( $Sf->{'ExGlobArgDecls'}{'List'},$Scsub->{'ExGlobArgDecls'}{'List'} );
# ------------------	                    
#	                    			my $dups2 = find_duplicates_in_list($Sf->{'ExGlobArgDecls'}{'List'});
#	        if (scalar keys %{$dups2}>0) {
#	            	croak "AFTER $csub: $f has DUPS:".Dumper($dups2)
#	        } else {
#	        	say "AFTER $csub: NO DUPS in $f"; 
#			} 
	                    
	                } else {
	                	# Inherit
#	                    $Sf->{'ExGlobArgDecls'}{'List'} = [@{$renamed_inherited_globs->{'List'} }];
	                    $Sf->{'ExGlobArgDecls'}{'List'} = [@{$Scsub->{'ExGlobArgDecls'}{'List'} }];
	                } 
	                if ( exists $Sf->{'ExGlobArgDecls'}{'Set'} ) {
	                	# Merge      
#	            	   $Sf->{'ExGlobArgDecls'}{'Set'} = { %{ $Sf->{'ExGlobArgDecls'}{'Set'} }, %{ $renamed_inherited_globs->{'Set'} } };
	            	   $Sf->{'ExGlobArgDecls'}{'Set'} = { %{ $Sf->{'ExGlobArgDecls'}{'Set'} }, %{ dclone( $Scsub->{'ExGlobArgDecls'}{'Set'} ) } };
	                } else {
	                	# Inherit
#	                    $Sf->{'ExGlobArgDecls'}{'Set'} = $renamed_inherited_globs->{'Set'};
	                    $Sf->{'ExGlobArgDecls'}{'Set'} = dclone( $Scsub->{'ExGlobArgDecls'}{'Set'} );
	                    $Sf->{'HasCommons'} = 1;
	                }       
	            	  	       
	            }   
     
#			my $dups2 = find_duplicates_in_list($Sf->{'ExGlobArgDecls'}{'List'});
#	        if (scalar keys %{$dups2}>0) {
#	            	croak "AFTER: $f has DUPS:".Dumper($dups2)
#	        } else {
#	        	say "AFTER: NO DUPS in $f"; 
#			} 
       
	        } 
	    } else {
	        # Leaf node, find globals
	        say "SUB $f is LEAF" if $V; 
#	        $stref = _identify_globals_used_in_subroutine( $f, $stref );
	    }    
	    
	    # We only come here when the recursion and merge is done.   
#	    $stref = _resolve_conflicts_with_params( $f, $stref );
    }
    
    return $stref;
    
} # END of lift_globals()
