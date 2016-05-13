package RefactorF4Acc::Refactoring::Subroutines;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines create_refactored_source context_free_refactorings emit_f95_var_decl);
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( create_refactored_subroutine_signature refactor_subroutine_signature ); 
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
    for my $f ( sort keys %{ $stref->{'Subroutines'} } ) { 
        next if ($f eq '' or not defined $f);
        my $Sf = $stref->{'Subroutines'}{$f};                
        if ( not defined $Sf->{'Status'} ) {
            $Sf->{'Status'} = $UNREAD;
            print "WARNING: no Status for $f\n" if $W;            
        }
        next if $Sf->{'Status'} == $UNREAD;
        next if $Sf->{'Status'} == $READ;
        next if $Sf->{'Status'} == $FROM_BLOCK;
#        next if (exists $Sf->{'Function'} and $Sf->{'Function'} ==1 ); # FIXME: instead, do if/then and use  refactor_called_functions()
#        if (exists $Sf->{'Function'} and $Sf->{'Function'} ==1 ) {
## $stref = refactor_called_functions($stref, $f);
#        } else {
            $stref = _refactor_subroutine_main($stref, $f);
#        }      
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
- we also need the "entry point" for adding the declarations for the localized global variables 'ExGlobArgDecls'

* Signature: add the globals to the signature
(* VarDecls: keep as is)
* ExGlobArgDecls: add new var decls
* SubroutineCall: add globals for that subroutine to the call
* RefactoredSubroutineCall: insert a new subroutine call instead of the "begin of block" comment. 
* InBlock: skip; we need to handle the blocks separately
* BeginBlock: insert the new subroutine signature and variable declarations
* EndBlock: insert END
                      
=end markdown
=cut

sub _refactor_subroutine_main {
    ( my $stref, my $f ) = @_;
#    local $V=1;
#    local $I=1;
#    local $W=1;
	my $Sf = $stref->{'Subroutines'}{$f};
    if ($V) {
        print "\n\n";
        print "#" x 80, "\n";
        print "Refactoring $f\n";
          if (exists $Sf->{'Function'} and $Sf->{'Function'} ==1 ) {
          	print "REFACTORING FUNCTION $f\n";
          } else {
        print "REFACTORING SUBROUTINE $f\n";
          }
        print "#" x 80, "\n";
    }
#    if (in_nested_set($Sf,'Vars','varname') ){
#    say "_refactor_subroutine_main($f):".Dumper(get_var_record_from_set($Sf->{'Vars'},'varname'));
#    }
    say "context_free_refactorings($f)" if $V;
    $stref = context_free_refactorings( $stref, $f ); # FIXME maybe do this later    
	    
    say "get_annotated_sourcelines($f)" if $V;
    my $annlines = $Sf->{'RefactoredCode'};
    
    if ( $Sf->{'HasCommons'} or (
    exists $Sf->{'Contains'} and
    scalar @{$Sf->{'Contains'}}>0)) { 
        print "REFACTORING COMMONS for SUBROUTINE $f\n" if $V;
        
        if ( $Sf->{'RefactorGlobals'} == 1 ) {
            say "_refactor_globals_new($f)" if $V;
          $annlines = _refactor_globals_new( $stref, $f, $annlines );

        } elsif ( $Sf->{'RefactorGlobals'} == 2 ) { 
            croak 'SHOULD BE OBSOLETE!';
#            say "_refactor_calls_globals($f)" if $V;
#            $annlines = _refactor_calls_globals( $stref, $f, $annlines );            
        }
    }
    
    $annlines = _fix_end_lines($stref, $f, $annlines); # FIXME maybe do this later
    
    $Sf->{'RefactoredCode'}=$annlines;    
    $Sf->{'AnnLines'}=$annlines;    
    return $stref;
}    # END of _refactor_subroutine_main()

# -----------------------------------------------------------------------------
# The code below fixes the end lines of the code by adding 'program $f' or 'subroutine $f' or 'function $f'
# For some reason this is BROKEN elsewhere
sub _fix_end_lines {	
    (my $stref, my $f, my $rlines) = @_;
#    croak "FIXME" if $f eq 'vertical';
    my $Sf=$stref->{'Subroutines'}{$f}; 
    my $sub_or_prog = ( exists $Sf->{'Program'} and $Sf->{'Program'} == 1) ? 'program' : 
    (exists $Sf->{'Function'} and $Sf->{'Function'} == 1 ) ? 'function' : 'subroutine';
    say 'fix end '.$f if $V;
    my $done_fix_end=0;
    while (!$done_fix_end and @{$rlines}) {
        my $annline =pop @{$rlines};
        (my $line, my $info )= @{ $annline };
        next if ( $line=~/^\s*$/); # Skip comments
        if ( $line=~/^\s*end\s+$sub_or_prog/) {
            push @{$rlines}, $annline;
            $done_fix_end=1;
            last ;
        }
        
        if ($line=~/^\s*end\s*$/ ) {
            $line=~s/\s+$//;
            push @{$rlines},[ $line." $sub_or_prog $f",$info];
            $done_fix_end=1;
        }
        
        if ($line=~/^\s*contains\s*$/ ) {
            $line=~s/\s+$//;
            push @{$rlines},$annline;
            push @{$rlines},[ "end $sub_or_prog $f",$info];
            $done_fix_end=1; 
        }
    }
    return $rlines;
} # END of _fix_end_lines()
# -----------------------------------------------------------------------------
#_refactor_globals() 
#- creates a refactored subroutine sig based on RefactoredArgs
#- skips Common include statements, so it only keeps Parameter (I hope)
#- create_new_include_statements, this should be OBSOLETE, except that it takes ParamIncludes out of other Includes and instantiates them.
#- creates ex-glob arg declarations, basically we have to look at ExInclArgDecls, ExImplicitArgDecls and ExGlobArgDecls.  
#- create_refactored_vardecls is a misnomer, it renames locals conflicting woth globals. I think that has been sorted now. We should generate decls for ExInclVarDecls and ExImplicitVarDecls.
#- create_refactored_subroutine_call, I hope we can keep this
#- rename_conflicting_locals, I hope we can keep this
#sub _refactor_globals { croak 'OBSOLETE, I HOPE!';
#    ( my $stref, my $f, my $annlines ) = @_;
#    my $Sf = $stref->{'Subroutines'}{$f};
#    
#    if ($Sf->{'RefactorGlobals'}==2) {
#    	die "This should NEVER happen!";
#        warn "FIXME: the caller of a sub with RefactorGlobals ($f) should refactor its globals!";
#        # Which child has RefactorGlobals==1?
#        my @additional_includes=();
#        for my $cs ($Sf->{'CalledSubs'}) {          
#            if ($stref->{'Subroutines'}{$cs}{'RefactorGlobals'}==1) {
#                for my $inc ($stref->{'Subroutines'}{$cs}{'CommonIncludes'}) {
#                    if (not exists $Sf->{'CommonIncludes'}{$inc}) {
#                        push @additional_includes, $inc;
#                        croak "$inc from $cs was missing from $f"; 
#                    } 
#                }
#                
#            }
#        }       
#    }
#    
#    print "REFACTORING GLOBALS in $f\n" if $V; 
#    my $rlines      = [];
#    my $s           = $Sf->{'Source'};
#
#    for my $annline ( @{$annlines} ) {
#        (my $line, my $info) = @{ $annline };
#        
#        print '*** ' . join( ', ', map {"$_ => ".Dumper($info=>{$_})} keys(%{$info}) ) . "\n" if $DBG;
#        print '*** ' . $line . "\n" if $DBG;
#        my $skip = 0;
#
#        if ( exists $info->{'Signature'} ) {
#            if (not exists $Sf->{'HasRefactoredArgs'} ) {
#                 # Do this before the analysis for RefactoredArgs!
#                 $stref = refactor_subroutine_signature( $stref, $f );
#            }
#            $rlines =
#              create_refactored_subroutine_signature( $stref, $f, $annline,
#                $rlines );
#            $skip = 1;
#        } 
#        # There should be no need to do this: all /common/ blocks should have been removed anyway!
#        if ( exists $info->{'Include'} ) {
#            $skip = skip_common_include_statement( $stref, $f, $annline );
##            say "SKIP: $skip";
#        }
#        
#        if ( exists $info->{'ExGlobVarDeclHook'} ) {
#            # First, abuse ExGlobArgDecls as a hook for the addional includes, if any
#            $rlines =
#              create_new_include_statements( $stref, $f, $annline, $rlines );
#              
#           # Then generate declarations for ex-globals
#           say "EX-GLOBS for $f" if $V;
#            $rlines = create_exglob_var_declarations( $stref, $f, $annline, $rlines );
#
#        } 
#        
#        # This is what breaks flexpart, but it's OK for les ...
#        if ( exists $info->{'VarDecl'} and not exists $info->{'Deleted'} and (not exists $info->{Ref} or $info->{Ref}==0)) {
#            $rlines = create_refactored_vardecls( $stref, $f, $annline, $rlines,0 );
#            $skip = 1;
#        }
#
#        if ( exists $info->{'SubroutineCall'} ) {
#            # simply tag the common vars onto the arguments
#            $rlines = create_refactored_subroutine_call( $stref, $f, $annline, $rlines );        
#            $skip = 1;
#        }
#
#        if ( not exists $info->{'Comments'} and not exists $info->{'Deleted'} and $skip == 0 ) {
#            $rlines =
#              rename_conflicting_locals( $stref, $f, $annline, $rlines );
#            $skip = 1;
#        }
##        say "SKIP ULT: $skip";
#        push @{$rlines}, $annline unless $skip;
#        
#    } # loop over all lines
#    
#    return $rlines;
#}    # END of _refactor_globals()

# -----------------------------------------------------------------------------
sub _refactor_calls_globals {
    ( my $stref, my $f, my $annlines ) = @_;
#    my $annlines = get_annotated_sourcelines($stref,$f);
#local $V =1;
#local $I =1;
#local $W =1; 
    print "REFACTORING CALLS WITH GLOBALS in $f\n" if $V;
    my $rlines      = [];
#    local $V=1;
    my $idx         = 0;
    my $firstinc=1;
    for my $annline ( @{$annlines} ) {
        my $line      = $annline->[0] || '';
        my $info = $annline->[1];
        
        print '*** ' . join( ',', map {"$_ => ".$info->{$_}} keys(%{$info}) ) . "\n" if $DBG;
        print '*** ' . $line . "\n" if $DBG;
        my $skip = 0;

# FIXME: rather we should find the line _after_ the last include!
# so we need $prevline in the reader or parser
# Basically I can keep an index counter and increment it every time I find an include
# then the next line, whatever it is, becomes "ExtraIncludesHook"        
#croak "Hook" if $f eq 'timemanager';
        if ( (exists $info->{'ExtraIncludesHook'}) && ($firstinc==1)) {        	   
        	
#        if ( exists $info->{'Include'} && $firstinc ) {
        	$firstinc =0;
            # First, add addional includes if required
            $rlines = create_additional_include_statements( $stref, $f, $annline, $rlines );
            
## While we're here, might as well generate the declarations for remapping and reshaping.
## If the subroutine contains a call to a function that requires this, of course.
## Executive decision: do this only for the routines to be translated to C/OpenCL
#            for my $called_sub ( keys %{ $Sf->{'CalledSubs'}{'Set'} } ) {
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
        if ( exists $info->{'SubroutineCall'} 
        &&  exists $stref->{'Subroutines'}{ $info->{'SubroutineCall'}{'Name'} }{'RefactorGlobals'} 
        &&  $stref->{'Subroutines'}{ $info->{'SubroutineCall'}{'Name'} }{'RefactorGlobals'} ==1
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



#_refactor_globals() 
#- creates a refactored subroutine sig based on RefactoredArgs
#- skips Common include statements, so it only keeps Parameter (I hope)
#- create_new_include_statements, this should be OBSOLETE, except that it takes ParamIncludes out of other Includes and instantiates them, so RENAME
#- creates ex-glob arg declarations, basically we have to look at ExInclArgDecls, ExImplicitArgDecls and ExGlobArgDecls.  
#- create_refactored_vardecls is a misnomer, it renames locals conflicting woth globals. I think that has been sorted now. We should generate decls for ExInclVarDecls and ExImplicitVarDecls.
#- create_refactored_subroutine_call, I hope we can keep this
#- rename_conflicting_locals, I hope we can keep this; or maybe we should not do this!
sub _refactor_globals_new {
    ( my $stref, my $f, my $annlines ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
#    croak Dumper($Sf) if $f eq 'ij_to_latlon';
    if ($Sf->{'RefactorGlobals'}==2) {
    	die "This should NEVER happen!";
#        warn "FIXME: the caller of a sub with RefactorGlobals ($f) should refactor its globals!";
#        # Which child has RefactorGlobals==1?
#        my @additional_includes=();
#        for my $cs ($Sf->{'CalledSubs'}{'Set'}) {          
#            if ($stref->{'Subroutines'}{$cs}{'RefactorGlobals'}==1) {
#                for my $inc ($stref->{'Subroutines'}{$cs}{'CommonIncludes'}) {
#                    if (not exists $Sf->{'CommonIncludes'}{$inc}) {
#                        push @additional_includes, $inc;
#                        croak "$inc from $cs was missing from $f"; 
#                    } 
#                }
#                
#            }
#        }       
    }
    
    # For the case of Contained subroutines
	my @par_decl_lines_from_container=();
	if (exists $Sf->{'Container'}) {
		my $container =$Sf->{'Container'};
		if (exists $stref->{'Subroutines'}{$container}{'Parameters'}) {
			$Sf->{'ParametersFromContainer'}=$stref->{'Subroutines'}{$container}{'Parameters'}; # Note this is a nested set
			my $all_pars_in_container = get_vars_from_set( $stref->{'Subroutines'}{$container}{'Parameters'} );
			for my $par ( keys %{$all_pars_in_container} ) { # @{ $stref->{'Subroutines'}{$container}{'Parameters'}{'List'} } ) {
#				say $par;
#				my $par_decl = $stref->{'Subroutines'}{$container}{'Parameters'}{'Set'}{$par};
				my $par_decl = $all_pars_in_container->{$par};
#					say Dumper($par_decl);
				my $par_decl_line=[ '      '.emit_f95_var_decl($par_decl), {'ParamDecl' => $par_decl,'Ref'=>1}];
				push @par_decl_lines_from_container,$par_decl_line; 
			}			
		}
	}
    
    print "REFACTORING GLOBALS in $f\n" if $V; 
#    croak Dumper($Sf->{'AnnLines'}) if $f eq 'post';
    my $rlines      = [];
    my $s           = $Sf->{'Source'};
    my $hook_after_last_incl=0;
    if ($Sf->{'ExGlobVarDeclHook'}==0 ) {
		# If ExGlobVarDeclHook was not defined, we define it on the line *after* the last include.
		$hook_after_last_incl=1;
	}
    
 	my $inc_counter = scalar keys %{$Sf->{'Includes'}};
    for my $annline ( @{$annlines} ) {
        (my $line, my $info) = @{ $annline };
#        show_annlines([$annline],1);
#        print '*** ' . join( ', ', map {"$_ => ".Dumper($info->{$_})} keys(%{$info}) ) . "\n" if $V;
#        print '*** ' . $line . "\n" if $V;
        my $skip = 0;

        if ( exists $info->{'Signature'} ) { 
            if (not exists $Sf->{'HasRefactoredArgs'} ) {
                # This probably means the subroutine has no arguments at all.
                 # Do this before the analysis for RefactoredArgs!
                 #die 'SHOULD NEVER HAPPEN! ' .'_refactor_globals_new() '. __LINE__ . Dumper($Sf);
                 $stref = refactor_subroutine_signature( $stref, $f );
                warn '_refactor_globals_new() '. __LINE__ . " $f does not have HasRefactoredArgs\n";
                say 'WARNING: _refactor_globals_new() '. __LINE__ . " $f does not have HasRefactoredArgs";
                croak;
            }
            
            $rlines =
              create_refactored_subroutine_signature( $stref, $f, $annline, $rlines );
#              croak Dumper $rlines->[0] if $f eq 'map_set';
			$rlines = [@{$rlines},@par_decl_lines_from_container];              
            $skip = 1;
        } 
        # There should be no need to do this: all /common/ blocks should have been removed anyway!
        if ( exists $info->{'Include'} ) {
        	--$inc_counter;
            $skip = skip_common_include_statement( $stref, $f, $annline );
#            say "SKIP: $skip";
# Now, if this was a Common include to be skipped but it contains a Parameter include, I will simply replace the line:
# TODO: factor out!
			  my $inc       = $info->{'Include'}{'Name'};
			  if  ( exists $stref->{'IncludeFiles'}{$inc}{'ParamInclude'} ) { 
			  	my $param_inc=$stref->{'IncludeFiles'}{$inc}{'ParamInclude'};
			  	$skip=0;
			  	$info->{'Include'}{'Name'}=$param_inc;
			  	my $mod_param_inc=$param_inc;
			  	$mod_param_inc=~s/\./_/g;
			  	delete $info->{'Includes'};
			  	$line=~s/$inc/$mod_param_inc/;			  			  	
			  	$info->{'Ann'}=[  annotate($f, __LINE__) ];                    			  	
			  	$annline=[$line,$info];
			  	push @{$rlines}, $annline ;
			  	$skip=1;
			  }
        }
        
        if ($inc_counter==0 and  not exists $info->{'Include'} and $hook_after_last_incl==1) {
        	$info->{'ExGlobVarDeclHook'} = 'AFTER LAST Include via _refactor_globals_new() line ' . __LINE__; 
        	$hook_after_last_incl=0;
        }
#        if ( 0 and exists $info->{'ExGlobVarDeclHook'} ) { # OBSOLETE 
#            # First, abuse ExGlobArgDecls as a hook for the addional includes, if any
#            $rlines =
#              create_new_include_statements( $stref, $f, $annline, $rlines );
#        }
        if ( exists $info->{'ExGlobVarDeclHook'} ) {
        	# FIXME: I don't like this, because in the case of a program there should simply be no globals etc.
        	#   
           # Then generate declarations for ex-globals
           say "EX-GLOBS for $f" if $V;
            $rlines = _create_extra_arg_and_var_decls( $stref, $f, $annline, $rlines );
        } 

        if ( exists $info->{'SubroutineCall'} ) { 
            # simply tag the common vars onto the arguments            
            $rlines = _create_refactored_subroutine_call( $stref, $f, $annline, $rlines );        
            $skip = 1;
        }
        push @{$rlines}, $annline unless $skip;
        
    } # loop over all lines
    
    return $rlines;
}    # END of _refactor_globals_new()

# ExInclArgDecls, ExImplicitArgDecls and ExGlobArgDecls
# ExInclVarDecls and ExImplicitVarDecls.
# I must make sure that these do not already exists!
sub _create_extra_arg_and_var_decls {

    ( my $stref, my $f, my $annline, my $rlines ) = @_;

    my $Sf                 = $stref->{'Subroutines'}{$f};
    my $nextLineID=scalar @{$rlines}+1;
            
    print "INFO: ExGlobArgDecls in $f\n" if $I;

    for my $var ( @{ $Sf->{'ExGlobArgDecls'}{'List'} } ) {
    	
    	# Need to check if these were not already declared
    	if (not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var}
    	and not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$var}
    	) {
    	say "INFO VAR: $var ".Dumper($Sf->{'ExGlobArgDecls'}{'Set'}{$var}{'IODir'} ) if $I;
                    my $rdecl = $Sf->{'ExGlobArgDecls'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);
                    my $info={};
                    $info->{'Ann'}=[ annotate($f, __LINE__ .' : EX-GLOB ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];                                               
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}=$rdecl;
                    push @{$rlines}, [ $rline,  $info ];
    	}                        
    }    # for
    
    print "INFO: ExInclArgDecls in $f\n" if $I;
    for my $var ( @{ $Sf->{'ExInclArgDecls'}{'List'} } ) {
    	say "INFO VAR: $var" if $I;
                    my $rdecl = $Sf->{'ExInclArgDecls'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);                                                                   
                    my $info={};
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-INCL' ) ];
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}=$rdecl;
                    push @{$rlines}, [ $rline,  $info ];                        
    }    # for

    print "INFO: ExImplicitArgDecls in $f\n" if $I;
    for my $var ( @{ $Sf->{'ExImplicitArgDecls'}{'List'} } ) {
    	say "INFO VAR: $var" if $I;
                    my $rdecl = $Sf->{'ExImplicitArgDecls'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);                                         
                    my $info={};
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT')  ];
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}=$rdecl;
                    push @{$rlines}, [ $rline,  $info ];                        
    }    # for

    print "INFO: ExInclVarDecls in $f\n" if $I;
    for my $var ( @{ $Sf->{'ExInclVarDecls'}{'List'} } ) {
    	say "INFO VAR: $var" if $I;
                    my $rdecl = $Sf->{'ExInclVarDecls'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);
                    my $info={};
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-INCL VAR' ) ];
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}=$rdecl;
                    push @{$rlines}, [ $rline,  $info ];                        
    }    # for
        
    print "INFO: ExImplicitVarDecls in $f\n" if $I;
    for my $var ( @{ $Sf->{'ExImplicitVarDecls'}{'List'} } ) {
    	say "INFO VAR: $var" if $I;    	
    	# Check if it is not a parameter
    	my $is_param=0;
    	if ( in_nested_set($Sf, 'Parameters', $var)
#    	exists $Sf->{'Parameters'}{'Set'}{$var} or exists $Sf->{'ParametersFromContainer'}{'Set'}{$var}
		) {
    		$is_param=1;
    	}
    		# Somehow this is empty, we need to get the Parameters from the includes so we need to either update 'Includes'
    		# when we create the params version, or get ParamInclude from the Include
    		
    		
#    		for my $inc (keys %{$Sf->{Includes}}) {
#    			if (exists $stref->{IncludeFiles}{$inc}{'Parameters'}
#    			and exists $stref->{IncludeFiles}{$inc}{'Parameters'}{'Set'}{$var}
#    			) { # This is possible if it was 'InclType' eq 'Parameter'
#    					$is_param=1;last;
#    			} elsif (exists $stref->{IncludeFiles}{$inc}{'ParamInclude'}) {
#    				my $param_include =$stref->{IncludeFiles}{$inc}{'ParamInclude'};
#    				if (exists $stref->{IncludeFiles}{$param_include}{'Parameters'}{'Set'}{$var}) {
#    					$is_param=1;last;
#    				}
#    			}
#    		}
    	# I don't explicitly declare variables that conflict with reserved words or intrinsics.
    		if (not exists $F95_reserved_words{$var}
    		and not exists $F95_intrinsics{$var}    		
    		and not $is_param
    		and $var!~/__PH\d+__/ # FIXME! TOO LATE HERE!
    		and $var=~/^[a-z][a-z0-9_]*$/ # FIXME: rather check if Expr or Sub
    		) {    			
                    my $rdecl = $Sf->{'ExImplicitVarDecls'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);                                         
                    my $info={};
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT VAR') ];                    
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}=$rdecl;
                    push @{$rlines}, [ $rline,  $info ];
    		} else {
    			say "INFO: $var is a reserverd word" if $I;
    		}   
    	                     
    }    # for        
    return $rlines;
} # END of _create_extra_arg_and_var_decls();

sub _create_refactored_subroutine_call { 
    ( my $stref, my $f, my $annline, my $rlines ) = @_;;
    my $Sf        = $stref->{'Subroutines'}{$f};
    (my $line, my $info) = @{ $annline };

    # simply tag the common vars onto the arguments
    my $name = $info->{'SubroutineCall'}{'Name'};
#    croak Dumper($info) if $f eq 'advance' and $name eq 'interpol_vdep';
#    croak Dumper($info) if $name eq 'interpol_rain' and $f eq 'wetdepo';
    croak $line . Dumper($info) unless defined $info->{'SubroutineCall'}{'Args'}{'List'};# . Dumper(    $stref->{'Subroutines'}{$name});
    my @orig_args =();# @{ $info->{'SubroutineCall'}{'Args'}{'List'} };    
    for my $call_arg (@{ $info->{'SubroutineCall'}{'Args'}{'List'} }) {
    	push @orig_args , $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'};
    }
    my $args_ref = [@orig_args]; # NOT ordered union, if they repeat that should be OK 
    
    if (exists $stref->{'Subroutines'}{$name}{'ExGlobArgDecls'}) {       
        my @globals = @{ $stref->{'Subroutines'}{$name}{'ExGlobArgDecls'}{'List'} };        
        # Problem is that in $f globals from $name may have been renamed. I store the renamed ones in 
        # $Sf->{'RenamedInheritedExGLobs'}
        my @maybe_renamed_exglobs=();
        for my $ex_glob (@globals) {
        	# $ex_glob may be renamed or not. I test this using OrigName. 
        	# This way I am sure I get only original names
        	if (exists $stref->{'Subroutines'}{$name}{'ExGlobArgDecls'}{'Set'}{$ex_glob}{'OrigName'}) {
				$ex_glob = $stref->{'Subroutines'}{$name}{'ExGlobArgDecls'}{'Set'}{$ex_glob}{'OrigName'};		
        	}        	
        	if (exists $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob}) {
        		say "INFO: RENAMED $ex_glob => ".$Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} . ' in call to ' . $name . ' in '. $f if $I;
        		push @maybe_renamed_exglobs, $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob};
        	} else {
        		push @maybe_renamed_exglobs,$ex_glob;
        	}
        }
        $args_ref = [@orig_args, @maybe_renamed_exglobs ]; # NOT ordered union, if they repeat that should be OK
 
        $info->{'SubroutineCall'}{'Args'}{'List'}= $args_ref;
    my $args_str = join( ',', @{$args_ref} );
    $line =~ s/call\s.*$//; # Basically keep the indent
    my $rline = "call $name($args_str)\n";
    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
    push @{$rlines}, [ $line . $rline, $info ];
    } else {
        push @{$rlines}, [ $line , $info ];
    }
    return $rlines;
}    # END of _create_refactored_subroutine_call()
