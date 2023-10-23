package RefactorF4Acc::Analysis::Globals;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Storable qw( dclone );
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Analysis::Globals::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Globals::EXPORT_OK = qw(    
    &identify_inherited_exglobs_to_rename
    &lift_globals
    &rename_inherited_exglobs
);

## -----------------------------------------------------------------------------


# Here we start from the top, descend to the leaves, get the Globals in the leaves, and add them to the Globals of the caller.
# And of course we need to update ExGlobVarDecls
# This should be done before we create RefactoredArgs!

# This is lift_globals without the merge part
# RenamedInheritedExGlobs, ExGlobArgs
sub identify_inherited_exglobs_to_rename {
	  (my $stref, my $f) = @_;
#    local $V=1;
 	push @{ $stref->{'CallStack'} }, $f;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} }; 

    my $ext = $Config{RENAME_EXT};
    say '=' x 80, "\nENTER lift_globals( $f )" if $V;
    if (exists $stref->{'Subroutines'}{$f} ) {
    	my $Sf = $stref->{'Subroutines'}{$f};
    	if ( exists $Sf->{'CalledSubs'}{'List'}
        and scalar @{ $Sf->{'CalledSubs'}{'List'} }>0 )
	    {	    	
	        for my $csub ( @{ $Sf->{'CalledSubs'}{'List'} }) {   
				if (exists $subs{$csub}) {
				say "WARNING: LOOP for $csub: ".join(', ', @{ $stref->{'CallStack'} }) if $WW;
				next;
				}    
	       		say "CALL TO  $csub from $f" if $V;     
	            $stref = identify_inherited_exglobs_to_rename($stref, $csub );
	            say "RETURN TO $f from CALL to $csub" if $V;
	            my $Scsub = $stref->{'Subroutines'}{$csub};
	            # If $f and $csub both have globals, merge them, otherwise inherit them
	            
	            if (exists $Scsub->{'ExGlobArgs'} ) {
	            	# Check which inherited ex-globs need to be renamed
	            	for my $exglob (@{  $Scsub->{'ExGlobArgs'}{'List'} }) {	            		
	            		if (not exists  $Sf->{'ExGlobArgs'}{'Set'}{$exglob}) {
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
    pop  @{ $stref->{'CallStack'} };
    return $stref;
} #  END of identify_inherited_exglobs_to_rename()

# So we go through all ExGlobArgs and we rename every exglob from RenamedInheritedExGLobs 
sub rename_inherited_exglobs  {
		  (my $stref, my $f) = @_;
#    local $V=1;

if ($Config{RENAME_EXT} ne '') {
    my $ext = $Config{RENAME_EXT};
    
    say '=' x 80, "\nENTER lift_globals( $f )" if $V;

 	push @{ $stref->{'CallStack'} }, $f;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} }; 

    if (exists $stref->{'Subroutines'}{$f} ) {
    	my $Sf = $stref->{'Subroutines'}{$f};
	            
            if (scalar keys %{$Sf->{'RenamedInheritedExGLobs'}{'Set'}} >0 and  exists $Sf->{'ExGlobArgs'} ) {	            	
            	# Check which inherited ex-globs need to be renamed
            	my $renamed_exglob_list = [];
            	my $renamed_exglob_set = dclone( $Sf->{'ExGlobArgs'}{'Set'} );
            	for my $exglob (@{  $Sf->{'ExGlobArgs'}{'List'} }) {            		
            		if (exists  $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$exglob}) {
            			# Here I can check if this $exglob maybe exists in UsedLocalVars. If so, don't rename
            			if (exists $Sf->{'UsedLocalVars'}{'Set'}{$exglob}) {
            				say "NOT RENAMING $exglob in $f because in UsedLocalVars" if $V;
            			} elsif (exists $Sf->{'IncludedParameters'}{'Set'}{$exglob}) {
            				say "NOT RENAMING $exglob in $f because in IncludedParameters" if $V;    				
            			} else {
            			say "RENAMING $exglob TO $exglob$ext in $f" if $V;
            			my $new_name = $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$exglob};
            			push @{$renamed_exglob_list},$new_name;
            			$renamed_exglob_set->{$new_name}=dclone($renamed_exglob_set->{$exglob} );
						$renamed_exglob_set->{$new_name}{'Name'}=$new_name;
						$renamed_exglob_set->{$new_name}{'OrigName'}=$exglob;
						# Seems to me I should then delete the entry for the old name!
						delete $renamed_exglob_set->{$exglob};
            			}
            		} else {
            			say "NOT RENAMING $exglob in $f" if $V;
            			push @{$renamed_exglob_list},$exglob;
            		}
            	}
            	 $Sf->{'ExGlobArgs'}{'List'}=$renamed_exglob_list;
            	  $Sf->{'ExGlobArgs'}{'Set'}=$renamed_exglob_set;	            	
            }       	
    	
    	
    	if ( exists $Sf->{'CalledSubs'}{'List'}
        and scalar @{ $Sf->{'CalledSubs'}{'List'} }>0 )
	    {
	    	# This sub is calling other subs	    	
	        my @csubs = @{ $Sf->{'CalledSubs'}{'List'} };	        
	        for my $csub (@csubs) {    
				if (exists $subs{$csub}) {
					say "WARNING: LOOP for $csub: ".join(', ', @{ $stref->{'CallStack'} }) if $WW;
					next;
				}    
	       		say "CALL TO  $csub from $f" if $V;     
	            $stref = rename_inherited_exglobs($stref, $csub );
	            say "RETURN TO $f from CALL to $csub" if $V;
            
	        } 
	    } else {
	        # Leaf node, find globals
	        say "SUB $f is LEAF" if $V; 
	    }    
    }    
	pop  @{ $stref->{'CallStack'} };
}
    return $stref;
	
} #  END of rename_inherited_exglobs


# The renaming detection should be done in identify_inherited_exglobs_to_rename()
# What this routine does is:
#

sub lift_globals { 
    (my $stref, my $f) = @_;
    # local $V= 0;
 	push @{ $stref->{'CallStack'} }, $f;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} }; 

#    my $ext = '_GLOB' ;
    say '=' x 80, "\nENTER lift_globals( $f )" if $V; 
    if (exists $stref->{'Subroutines'}{$f} ) {
    	my $Sf = $stref->{'Subroutines'}{$f};
    	if ( exists $Sf->{'CalledSubs'}{'List'}
        and scalar @{ $Sf->{'CalledSubs'}{'List'} }>0 )
        # FIXME: This is also true for called ENTRYs
	    {	    	
	    	# This sub is calling other subs. Go through all called subs in turn	    		     
	        for my $csub ( @{ $Sf->{'CalledSubs'}{'List'} }) {       

				if (exists $subs{$csub}) {
				say "WARNING: LOOP for $csub: ".join(', ', @{ $stref->{'CallStack'} }) if $WW;
				next;
				}    

	       		say "CALL TO  $csub from $f" if $V;   
	       		# Check if it is an entry
	       		if (exists $stref->{'Entries'}{$csub}) {
	       			$csub = $stref->{'Entries'}{$csub};
	       		}  
	       		# This is recursive descent but we do nothing in the leaf node, it's just a way to get to them
	            $stref = lift_globals($stref, $csub );
	            say "RETURN TO $f from CALL to $csub" if $V;
	            my $Scsub = $stref->{'Subroutines'}{$csub};
# ------------------	            	            
	            # If $f and $csub both have globals, merge them, otherwise inherit them
	            
	            if (exists $Scsub->{'ExGlobArgs'} and defined $Scsub->{'ExGlobArgs'}) {
					# say "HERE1";
	                if (exists $Sf->{'ExGlobArgs'}{'List'} ) {
						# say "HERE1a";
	                	# Merge ExGlobArgs of $csub with those of $f  
	                    $Sf->{'ExGlobArgs'}{'List'} = ordered_union( $Sf->{'ExGlobArgs'}{'List'},$Scsub->{'ExGlobArgs'}{'List'} );  	                    
	                } else {
						# say "HERE1b";
	                	# Inherit
	                    $Sf->{'ExGlobArgs'}{'List'} = [@{$Scsub->{'ExGlobArgs'}{'List'} }];
	                } 
	                if ( exists $Sf->{'ExGlobArgs'}{'Set'} ) {
	                	# Merge      
	            	#    $Sf->{'ExGlobArgs'}{'Set'} = { %{ $Sf->{'ExGlobArgs'}{'Set'} }, %{ dclone( $Scsub->{'ExGlobArgs'}{'Set'} ) } };

						for my $called_var (sort keys %{ $Scsub->{'ExGlobArgs'}{'Set'} } )  {
							if (not exists $Sf->{'ExGlobArgs'}{'Set'}{$called_var}) {
								# say "Merging $called_var from $csub into $f";
								$Sf->{'ExGlobArgs'}{'Set'}{$called_var} = dclone($Scsub->{'ExGlobArgs'}{'Set'}{$called_var});
							} 

							# else {
							# 	carp "$called_var from $calledsub already defined in $f";
							# }
						}

	                } else {
	                	# Inherit
	                    $Sf->{'ExGlobArgs'}{'Set'} = dclone( $Scsub->{'ExGlobArgs'}{'Set'} );
	                    $Sf->{'HasCommons'} = 1;
	                }  
	                
	                # Here we deal with parameters used in declarations 
	                # FIXME: the InheritedParams are for ANY new arg, not just ex-glob args!
	                
	                for my $var (@{ $Scsub->{'ExGlobArgs'}{'List'} } ) {
						# carp "$f $var ".Dumper($Scsub->{'ExGlobArgs'}{'Set'}{$var}) if $var eq 'ev';
	                	if (exists $Scsub->{'ExGlobArgs'}{'Set'}{$var}{'InheritedParams'}) {
							
	                		my $all_inherited_parameters = _get_all_inherited_parameters(
	                			$Scsub,
        						$Scsub->{'ExGlobArgs'}{'Set'}{$var}{'InheritedParams'}{'Set'},
        						$Scsub->{'ExGlobArgs'}{'Set'}{$var}{'InheritedParams'}{'Set'} # Initial list
        					);
        					for my $par (keys %{ $all_inherited_parameters } ) {
        						my $subset = in_nested_set($Scsub,'Parameters',$par);
        						# The problem is that a sub from a module can have module globals via that module
        						# So these would have to be shared with the caller I think
        						if (not exists $Scsub->{$subset}{'Set'}{$par}{'Indent'}) {
#        							carp "$par: $f <$csub> <$subset> ".Dumper($Scsub->{$subset}{'Set'}{$par}) ;
        						} else {
        							$Sf->{'InheritedParameters'}{'Set'}{$par}=dclone($Scsub->{$subset}{'Set'}{$par});									
        						}
        					}	
	                	}
	                }     
					$Sf->{'InheritedParameters'}{'List'} = _list_inherited_params_in_order($Sf);
	            }
	            # ------------------	                             
	        } 
	    } else {
	        # Leaf node, do nothing ( used to be find globals)
	        say "SUB $f is LEAF" if $V; 
#	        $stref = _identify_globals_used_in_subroutine( $f, $stref );
	    }    
	    
	    # We only come here when the recursion and merge is done.   
#	    $stref = _resolve_conflicts_with_params( $f, $stref );
    }
    pop  @{ $stref->{'CallStack'} };
    return $stref;
    
} # END of lift_globals()


sub _get_all_inherited_parameters { (my $Sf,my $pars, my $all_inherited_parameters)=@_;

	for my $par (keys %{$pars}) { 
		my $subset = in_nested_set($Sf,'Parameters',$par);
	    if (exists $Sf->{$subset}{'Set'}{$par}{'InheritedParams'}
	    and exists $Sf->{$subset}{'Set'}{$par}{'InheritedParams'}{'Set'}) { 
	        $all_inherited_parameters = { %{$all_inherited_parameters}, %{ $Sf->{$subset}{'Set'}{$par}{'InheritedParams'}{'Set'} } };
	        $all_inherited_parameters = _get_all_inherited_parameters($Sf, $Sf->{$subset}{'Set'}{$par}{'InheritedParams'}{'Set'},$all_inherited_parameters);
			# carp 'EXISTS: '.Dumper($all_inherited_parameters);
	    } else {
			# carp 'NOT EXISTS: '.Dumper($pars->{$par}) ;
	        $all_inherited_parameters->{$par}=$pars->{$par}; #croak 'HERE IS THE PROBLEM!';
	    }
	}
	return $all_inherited_parameters;
}

# What I also need is a way to list the parameters by dependency
# So clearly, we list the ones without inheritance (constant ones) first.
# But then? We keep a list of what we've listed and if a par was not listed but its InheritedParams were listed, we list it.
# We do that until the list is empty.
# So first we create a map $par => InheritedParams
sub _list_inherited_params_in_order { (my $Sf)=@_;
	my %par_map = ();
	my $par_list=[];
	my %listed_pars=();
	for my $par (sort keys %{ $Sf->{'InheritedParameters'}{'Set'} }) {
		if (exists $Sf->{'InheritedParameters'}{'Set'}{$par}{'InheritedParams'}
		and exists $Sf->{'InheritedParameters'}{'Set'}{$par}{'InheritedParams'}{'Set'}
		) {
			$par_map{$par}= { %{ $Sf->{'InheritedParameters'}{'Set'}{$par}{'InheritedParams'}{'Set'} } };
		} else {
			$par_map{$par}= {};
		}
	}
	while (scalar keys %par_map>0) {
		for my $par (sort keys %par_map  ) {
			if (scalar keys %{ $par_map{$par} } == 0) {
				push @{$par_list}, $par;
				$listed_pars{$par}=1;
				delete  $par_map{$par};
			} else {
				for my $ipar (sort keys %{ $par_map{$par} }) {
					if (exists $listed_pars{$ipar}) {
						delete $par_map{$par}{$ipar};
					}
				}
				if (scalar keys %{ $par_map{$par} } == 0 ) {
					push @{$par_list}, $par;
					$listed_pars{$par}=1;
					delete  $par_map{$par};					
				}
			}
		}
	}
	return $par_list;
}
  

1;
