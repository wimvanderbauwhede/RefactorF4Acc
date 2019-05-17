package RefactorF4Acc::Refactoring::Subroutines;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines context_free_refactorings emit_f95_var_decl splice_additional_lines_cond);
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( create_refactored_subroutine_signature refactor_subroutine_signature ); 
use RefactorF4Acc::Refactoring::Subroutines::IncludeStatements qw( skip_common_include_statement create_new_include_statements create_additional_include_statements );
use RefactorF4Acc::Parser::Expressions qw( emit_expression emit_expr_from_ast $NEW_PARSER);
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.2.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Subroutines::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::EXPORT_OK = qw(
    &refactor_all_subroutines    
    &emit_subroutine_call
    &emit_subroutine_sig
);

=pod
Subroutines
    refactor_all_subroutines
    _refactor_subroutine_main
    _refactor_globals
    _refactor_calls_globals 
=cut

# -----------------------------------------------------------------------------

sub refactor_all_subroutines {
    ( my $stref ) = @_;
    
    for my $f ( sort keys %{ $stref->{'Subroutines'} } ) {
    	 
        next if ($f eq '' or $f eq 'UNKNOWN_SRC' or not defined $f);
        next if exists $stref->{'Entries'}{$f};
                        
        my $Sf = $stref->{'Subroutines'}{$f};
        
        next if (exists $Sf->{'Entry'} && $Sf->{'Entry'} == 1);                
        if ( not defined $Sf->{'Status'} ) {
            $Sf->{'Status'} = $UNREAD;
            print "WARNING: no Status for $f\n" if $W;            
        }
        
        next if $Sf->{'Status'} == $UNREAD;
        next if $Sf->{'Status'} == $READ;
        next if $Sf->{'Status'} == $FROM_BLOCK;
        	
        $stref = _refactor_subroutine_main($stref, $f);
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
- we also need the "entry point" for adding the declarations for the localized global variables 'ExGlobArgs'

* Signature: add the globals to the signature
(* VarDecls: keep as is)
* ExGlobArgs: add new var decls
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
	my $is_block_data = (exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? 1 : 0;
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
        say "context_free_refactorings($f)" ;
    }
 
    $stref = context_free_refactorings( $stref, $f ); # FIXME maybe do this later
    say "get_annotated_sourcelines($f)" if $V;
    my $annlines = $Sf->{'RefactoredCode'};
    # At this point, call line from annlines for extracted sub has too many args
    
     
    if (1 or $Sf->{'HasCommons'} or ( # FIXME
    exists $Sf->{'Contains'} and
    scalar @{$Sf->{'Contains'}}>0)) { 
        print "REFACTORING COMMONS for SUBROUTINE $f\n" if $V;
        
        if ( $Sf->{'RefactorGlobals'} == 1 ) {         	
          $annlines = _refactor_globals_new( $stref, $f, $annlines );
        } elsif ( $Sf->{'RefactorGlobals'} == 2 ) { 
            croak 'SHOULD BE OBSOLETE!';
        }
    }
# here RefactoredArgs has been doubled!    
#    if ($f eq 'wave2d') {
#    say Dumper($stref); croak;
#    }
    
#    if ($f eq 'wave2d') {
#		show_annlines($annlines);croak ;
#    }
	 
    $annlines = _fix_end_lines($stref, $f, $annlines); # FIXME maybe do this later

    
    if ($is_block_data) { 
    	$annlines = _add_extra_assignments_in_block_data($stref, $f, $annlines);
    }
 
    $annlines = _add_implicit_none($stref, $f, $annlines);
    $annlines = _emit_refactored_signatures($stref, $f, $annlines);
    $Sf->{'RefactoredCode'}=$annlines;
        
    $Sf->{'AnnLines'}=$annlines;
    return $stref;
}    # END of _refactor_subroutine_main()

# -----------------------------------------------------------------------------
# The code below fixes the end lines of the code by adding 'program $f' or 'subroutine $f' or 'function $f'
# For some reason this is BROKEN elsewhere so FIXME!
sub _fix_end_lines {	
    (my $stref, my $f, my $rlines) = @_;
#    croak "FIXME" if $f eq 'vertical';
    my $Sf=$stref->{'Subroutines'}{$f}; 
	my $is_block_data = (exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? 1 : 0;    
    my $what_is_block_data = 'subroutine'; #'block data'
    my $sub_or_prog = 
    (exists $Sf->{'Program'} and $Sf->{'Program'} == 1) ? 'program' : 
    (exists $Sf->{'Function'} and $Sf->{'Function'} == 1 ) ? 'function' :
    (exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? $what_is_block_data : 
    'subroutine';
    say 'fix end '.$f if $V;
    my $done_fix_end=0;
    while (!$done_fix_end and @{$rlines}) {
        my $annline =pop @{$rlines};
        
        (my $line, my $info )= @{ $annline };
#        say "LINE: $line";
        next if ( $line=~/^\s*$/); # Skip comments
        if ( $line=~/^\s*end\s+$sub_or_prog/) {
            push @{$rlines}, $annline;
            $done_fix_end=1;
            last ;
        }
        
        if ($line=~/^\s*end\s*$/ ) {
            $line=~s/\s+$//;
            if ($is_block_data) {
            	$info->{'EndBlockData'}=1;
            }
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
#_refactor_globals_new()
# The problem with this routine is as follows: the refactoring of the signature happens when it is encountered. 
# But any subsequent call to a subroutine can result in new arguments being added to ExGlobArgDecls
# In principle this should have been dealt with by the inheritance algorithm, what goes wrong here? 
 
#- creates a refactored subroutine sig based on RefactoredArgs
#- skips Common include statements, so it only keeps Parameter (I hope)
#- create_new_include_statements, this should be OBSOLETE, except that it takes ParamIncludes out of other Includes and instantiates them, so RENAME
#- creates ex-glob arg declarations, basically we have to look at ExInclArgs, UndeclaredOrigArgs and ExGlobArgs.  
#- create_refactored_subroutine_call, I hope we can keep this
sub _refactor_globals_new {
    ( my $stref, my $f, my $annlines ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};

    if ($Sf->{'RefactorGlobals'}==2) {
    	die "This should NEVER happen!";    
    }
    
    # For the case of Contained subroutines
	my @par_decl_lines_from_container=();
	if (exists $Sf->{'Container'}) {
		my $container =$Sf->{'Container'};
		if (exists $stref->{'Subroutines'}{$container}{'Parameters'}) {
			$Sf->{'ParametersFromContainer'}=$stref->{'Subroutines'}{$container}{'Parameters'}; # Note this is a nested set
			my $all_pars_in_container = get_vars_from_set( $stref->{'Subroutines'}{$container}{'Parameters'} );
			for my $par ( keys %{$all_pars_in_container} ) { 
				my $par_decl = $all_pars_in_container->{$par};
				my $par_decl_line=[ '      '.emit_f95_var_decl($par_decl), {'ParamDecl' => $par_decl,'Ref'=>1}];
				push @par_decl_lines_from_container,$par_decl_line; 
			}			
		}
	}
	
    # For the case of subroutines in modules that either have params or USE params via modules 
	my @par_decl_lines_from_module=();
	if (exists $Sf->{'InModule'}) {
		my $mod =$Sf->{'InModule'};
		if (exists $stref->{'Modules'}{$mod}{'Parameters'}) { 
			$Sf->{'ParametersFromModule'}=$stref->{'Modules'}{$mod}{'Parameters'}; # Note this is a nested set
			my $all_pars_in_module = get_vars_from_set( $stref->{'Modules'}{$mod}{'Parameters'} );
			for my $par ( keys %{$all_pars_in_module} ) {				 
				my $par_decl = $all_pars_in_module->{$par};
				my $par_decl_line=[ '      '.emit_f95_var_decl($par_decl), {'ParamDecl' => $par_decl,'Ref'=>1}];
				push @par_decl_lines_from_module,$par_decl_line; 
			}			
		}
	}	
    
    print "REFACTORING GLOBALS in $f\n" if $V; 
    my $rlines      = [];
    my $s           = $Sf->{'Source'};
    
    # Create hook
    my $hook_after_last_incl=0;
    if ($Sf->{'ExGlobVarDeclHook'}==0 ) {
		# If ExGlobVarDeclHook was not defined, we define it on the line *after* the last include.
		$hook_after_last_incl=1;
	}    
 	my $inc_counter = scalar keys %{$Sf->{'Includes'}};
 	
 	# Loop over all lines in $f
    for my $annline ( @{$annlines} ) {    	
        (my $line, my $info) = @{ $annline };
        
        my $skip = 0;

		# Create the refactored subroutine signature
        if ( exists $info->{'Signature'} ) { 
			if (not exists $Sf->{'HasRefactoredArgs'} or $Sf->{'HasRefactoredArgs'} ==0 ) {            	
                # This probably means the subroutine has no arguments at all.
                 # Do this before the analysis for RefactoredArgs!
                 $stref = refactor_subroutine_signature( $stref, $f );
            }
            
            $rlines = create_refactored_subroutine_signature( $stref, $f, $annline, $rlines );            
			$rlines = [@{$rlines},@par_decl_lines_from_container,@par_decl_lines_from_module];     
            $skip = 1;
        } #else {
        	# I'm assuming this means a PROGRAM or ENTRY
        #}
        
        
        # There should be no need to do this: all /common/ blocks should have been removed anyway!
        if ( exists $info->{'Include'} ) {
        	# TODO: test if this is obsolete
        	--$inc_counter;
            $skip = skip_common_include_statement( $stref, $f, $annline );
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
			  	$info->{'Ann'}=[  annotate($f, __LINE__) ];                    			  	
			  	$annline=[$line,$info];
			  	push @{$rlines}, $annline ;
			  	$skip=1;
			  }
        }
        
        # We should either inline everything from the module or rewrite the module. I go for the former
        # In principle that is only possible if it's Inlineable
        #
        if ( exists $info->{'Use'} ) {
        	if( exists $info->{'Use'}{'Inlineable'} and $info->{'Use'}{'Inlineable'}==1) {
        		--$inc_counter;
              $skip = 1;
        	} else {
        		warn "Module ".$info->{'Use'}{'Name'}." in $f is not Inlineable" if $W; 
        	}       
        }
        
        if ($inc_counter==0 and  not exists $info->{'Include'} and $hook_after_last_incl==1) {
        	$info->{'ExGlobVarDeclHook'} = 'AFTER LAST Include via _refactor_globals_new() line ' . __LINE__; 
        	$hook_after_last_incl=0;
        }
        
        if ( exists $info->{'ExGlobVarDeclHook'} ) {        	
        	# FIXME: I don't like this, because in the case of a program there should simply be no globals etc.
           # Then generate declarations for ex-globals
           say "HOOK for $f: " .$info->{'ExGlobVarDeclHook'} if $V;

           say "EX-GLOBS for $f" if $V;
            $rlines = _create_extra_arg_and_var_decls( $stref, $f, $annline, $rlines );
        } 

        if ( exists $info->{'SubroutineCall'} ) {         	
            # simply tag the common vars onto the arguments                        
            $rlines = _create_refactored_subroutine_call( $stref, $f, $annline, $rlines );            
            $skip = 1;
        }
        
        if ( exists $info->{'FunctionCalls'} ) {        	        	
            # Assignment and Subroutine call lines can contain function calls that also need exglob refactoring!            
            $rlines = _create_refactored_function_calls( $stref, $f, $annline, $rlines );        
            $skip = 1;
        }        
        
        push @{$rlines}, $annline unless $skip;
        
    } # loop over all lines
    
    return $rlines;
}    # END of _refactor_globals_new()

# ExInclArgs, UndeclaredOrigArgs and ExGlobArgs
# ExInclLocalVars and UndeclaredOrigLocalVars.
# I must make sure that these do not already exists!
sub _create_extra_arg_and_var_decls {

    ( my $stref, my $f, my $annline, my $rlines ) = @_;

    my $Sf                 = $stref->{'Subroutines'}{$f};
    my $nextLineID=scalar @{$rlines}+1;
    
    if (exists $Sf->{'InheritedParameters'}{'List'} and
    scalar  @{ $Sf->{'InheritedParameters'}{'List'} } > 0) { 
    print "INFO: InheritedParameters in $f\n" if $I;
            
    for my $par ( @{ $Sf->{'InheritedParameters'}{'List'} } ) {
    	if (not in_nested_set($Sf,'Parameters',$par) ) {
    	say "INFO PAR in $f: $par ".Dumper($Sf->{'InheritedParameters'}{'Set'}{$par} ) if $I;
    	
                    my $rdecl = $Sf->{'InheritedParameters'}{'Set'}{$par}; 
                    my $rline = emit_f95_var_decl($rdecl);
                    my $info={};
                    $info->{'Ann'}=[ annotate($f, __LINE__ .' : INHERITED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];                                               
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'ParamDecl'}={'Name' => $par};
                    push @{$rlines}, [ $rline,  $info ];
    	} 	
    }             
    push @{$rlines},$BLANK_LINE;
    }
    
#croak "NEED TO HANDLE THE CASE OF MODULE WITH PARAMETERS";
    if (exists $Sf->{'UsedParameters'}{'List'} and
    scalar  @{ $Sf->{'UsedParameters'}{'List'} } > 0) { 
    print "INFO: UsedParameters in $f\n" if $I;
            
    for my $par ( @{ $Sf->{'UsedParameters'}{'List'} } ) {
    	
    	my $test_par = in_nested_set($Sf,'Parameters',$par);
#    	say "$f PAR $par $test_par "; 
    	if (not $test_par or $test_par eq 'UsedParameters') {
    	say "INFO PAR in $f: $par ".Dumper($Sf->{'UsedParameters'}{'Set'}{$par} ) if $I; 
                    my $rdecl = $Sf->{'UsedParameters'}{'Set'}{$par};
#                    say Dumper($rdecl); 
                    my $rline = emit_f95_var_decl($rdecl);
                    my $info={};
                    $info->{'Ann'}=[ annotate($f, __LINE__ .' : INCLUDED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];                                               
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'ParamDecl'}={'Name' => $par};
                    push @{$rlines}, [ $rline,  $info ];
    	} 	
    }             
    push @{$rlines},$BLANK_LINE;
    }
    
    
    print "INFO: ExGlobArgs in $f\n" if $I;

    for my $var ( @{ $Sf->{'ExGlobArgs'}{'List'} } ) {
    	
    	# Need to check if these were not already declared
    	if (not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var}
    	and not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$var}
    	and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$var}
#    	and not exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}
    	) {
		
    	say "INFO VAR in $f: IODir for $var: ".$Sf->{'ExGlobArgs'}{'Set'}{$var}{'IODir'}  if $I and not $Sf->{'Program'}; 
                    my $rdecl = $Sf->{'ExGlobArgs'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);
                    my $info={};
                    $info->{'Ann'}=[ annotate($f, __LINE__ .' : EX-GLOB ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];                                               
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
                    $info->{'ArgDecl'}=1;
                    push @{$rlines}, [ $rline,  $info ];
    	}                        
    }    # for
    
    print "INFO: ExInclArgs in $f\n" if $I;
    for my $var ( @{ $Sf->{'ExInclArgs'}{'List'} } ) {
    	say "INFO VAR: $var" if $I;
                    my $rdecl = $Sf->{'ExInclArgs'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);                                                                   
                    my $info={};                    
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-INCL' ) ];
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
                    push @{$rlines}, [ $rline,  $info ];                        
    }    # for

#    print "INFO: UsedGlobalVars in $f\n" if $I;
#    for my $var ( @{ $Sf->{'UsedGlobalVars'}{'List'} } ) {
#    	# Check if this var is used in the subroutine, right?
#    	if (exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var}) {
#    	say "INFO VAR: $var" if $I;
#                    my $rdecl = $Sf->{'UsedGlobalVars'}{'Set'}{$var}; 
#                    my $rline = emit_f95_var_decl($rdecl);                                                                   
#                    my $info={};                    
#                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-MODULE-GLOBAL' ) ];
#                    $info->{'LineID'}= $nextLineID++;
#                    $info->{'Ref'}=1;
#                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
#                    push @{$rlines}, [ $rline,  $info ];      
#                    # So now for convenience I will just add these to ExGlobArgs                    
##                    $Sf->{'ExGlobArgs'}{'Set'}{$var}=$rdecl;
##                    $Sf->{'RefactoredArgs'}{'Set'}{$var}=$rdecl;
##                   push @{$Sf->{'ExGlobArgs'}{'List'}}, $var;    
##                   push @{$Sf->{'RefactoredArgs'}{'List'}}, $var;  
#    	}             
#    }    # for

    print "INFO: UndeclaredOrigArgs in $f\n" if $I;
    my %unique_ex_impl=();
    for my $var ( @{ $Sf->{'UndeclaredOrigArgs'}{'List'} } ) {
    	if (not exists $Sf->{'UsedGlobalVars'}{'Set'}{$var}) {
    	say "INFO VAR: $var" if $I;
    	next if $var eq '*';
    	if (exists $Sf->{'CalledSubs'} and exists $Sf->{'CalledSubs'}{$var} and not exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var}) {    		
    		next;
    	} 
  		if ( exists $stref->{'ExternalSubroutines'}{$var} and not exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var}) {  			
    		next;
    	}
    	if (not exists $unique_ex_impl{$var}) {    		
    			$unique_ex_impl{$var}=$var;
				my $rdecl = $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var};                    
                if (not exists $rdecl->{'External'}
                    or (exists $rdecl->{'External'} and exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$var})
                ) {
                    	  
	                    my $rline = emit_f95_var_decl($rdecl);                                         
	                    my $info={};
	                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT')  ];
	                    $info->{'LineID'}= $nextLineID++;
	                    $info->{'Ref'}=1;
	                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
	                    push @{$rlines}, [ $rline,  $info ];
                }
    	}               
    	}         
    }    # for

    print "INFO: ExInclLocalVars in $f\n" if $I;
    for my $var ( @{ $Sf->{'ExInclLocalVars'}{'List'} } ) {
    	say "INFO VAR: $var" if $I;    	
                    my $rdecl = $Sf->{'ExInclLocalVars'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);
                    my $info={};
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-INCL VAR' ) ];
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
                    push @{$rlines}, [ $rline,  $info ];                        
    }    # for
        
    print "INFO: UndeclaredOrigLocalVars in $f\n" if $I;
    for my $var ( @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} } ) {
    	
    	if (not exists $Sf->{'UsedGlobalVars'}{'Set'}{$var}) {
    		
    	say "INFO VAR: $var" if $I;    	
    	if (exists $Sf->{'CalledSubs'} and exists $Sf->{'CalledSubs'}{$var}) {
    		next;
    	} 
    	
    	if ( exists $stref->{'Subroutines'}{$var} and not exists $stref->{'Subroutines'}{$f}{'Program'}) {
    		next;
    	}
    	
  		if ( exists $stref->{'ExternalSubroutines'}{$var}) {
    		next;
    	}
    	if (in_nested_set($Sf, 'DeclaredOrigLocalVars', $var)) {
    		next;
    	}    	
    	if ($f eq $var) {
    		next;
    	}
    	# Check if it is not a parameter
    	my $is_param=0;
    	if ( in_nested_set($Sf, 'Parameters', $var)
#    	exists $Sf->{'Parameters'}{'Set'}{$var} or exists $Sf->{'ParametersFromContainer'}{'Set'}{$var}
		) {
    		$is_param=1;
    	}
    	# I don't explicitly declare variables that conflict with reserved words or intrinsics.
    		if (not exists $F95_reserved_words{$var}
    		and not exists $F95_intrinsics{$var}
    		and not exists  $Sf->{'Namelist'}{$var}   		
    		and not $is_param
    		and $var!~/__PH\d+__/ # FIXME! TOO LATE HERE!
    		and $var=~/^[a-z][a-z0-9_]*$/ # FIXME: rather check if Expr or Sub
    		) {    		
    				
#    			croak Dumper($Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var}) if $var eq 'ff083';
                    my $rdecl = $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);                                         
                    my $info={};
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT VAR') ];                    
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
                    push @{$rlines}, [ $rline,  $info ];
    		} else {
    			say "INFO: $var is a reserved word" if $I;
    		}       	        
    	}             
    }    # for  

    print "INFO: ExCommonVarDecls in $f\n" if $I;
    for my $var ( @{ $Sf->{'UndeclaredCommonVars'}{'List'} } ) {
    	next if ( exists $Sf->{'ExGlobArgs'}{'Set'}{$var} );
    	say "INFO VAR: $var" if $I;
                    my $rdecl = $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}; 
                    my $rline = emit_f95_var_decl($rdecl);                                         
                    my $info={};
                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT COMMON')  ];
                    $info->{'LineID'}= $nextLineID++;
                    $info->{'Ref'}=1;
                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
                    push @{$rlines}, [ $rline,  $info ];                        
    }    # for    
    
          
    return $rlines;
} # END of _create_extra_arg_and_var_decls();

# AKA refactor_call_args, RefactorCallArgs
# This subroutine adds additional arguments to a call to $name in $f.
# What it does NOT do is update the list of variables in scope in $f. 
# It should update ExGlobArgs 
# Furthermore I notice that sometimes these arguments are not passed on to the containing subroutine. That should be an issue in the subroutine refactoring code   
sub _create_refactored_subroutine_call { 
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
    
    (my $line, my $info) = @{ $annline };

    # simply tag the common vars onto the arguments
    my $name = $info->{'SubroutineCall'}{'Name'};
    
    my $Sf        = $stref->{'Subroutines'}{$f};
    if (exists $stref->{'ExternalSubroutines'}{$name} ) { 
    	push @{$rlines}, [ $line , $info ];
    	return $rlines;
    }
    # Collect original args
    my @orig_args =();    
    for my $call_arg (@{ $info->{'SubroutineCall'}{'Args'}{'List'} }) {
        if (exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'} ) {
        	push @orig_args , $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'};
        } else {
			push @orig_args , $call_arg; # WV20170515: is this correct? Do nothing?
        }
    }
    
    my $args_ref = [@orig_args]; # NOT ordered union, if they repeat that should be OK
    
    my $parent_sub_name =  exists $stref->{'Entries'}{$name} ? $stref->{'Entries'}{$name} : $name;

	# If there are any ex-global args, collect them
    if (exists $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'}) {		    	       
        my @globals = @{ $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'}{'List'} };
        
        # Problem is that in $f globals from $name may have been renamed. I store the renamed ones in $Sf->{'RenamedInheritedExGLobs'}
        # So we check and create @maybe_renamed_exglobs
        my @maybe_renamed_exglobs=();
        for my $ex_glob (@globals) {
        	# WV 20170606 I need to check if maybe the ex-globs have already been added to the args
        	# Because if the Args of the actual Call are the same as ex-globs then they must be ex-globs
        	if (not exists  $info->{'SubroutineCall'}{'Args'}{'Set'}{$ex_glob} ) {
        	# $ex_glob may be renamed or not. I test this using OrigName. 
        	# This way I am sure I get only original names
        	if (exists $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'}) {
				$ex_glob = $stref->{'Subroutines'}{$parent_sub_name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'};		
        	}        	
        	if (exists $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} and not exists $Sf->{'UsedLocalVars'}{'Set'}{$ex_glob} and not exists $Sf->{'IncludedParameters'}{'Set'}{$ex_glob}) {
        		say "INFO: RENAMED $ex_glob => ".$Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} . ' in call to ' . $parent_sub_name . ' in '. $f if $I;
        		push @maybe_renamed_exglobs, $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob};
        	} else {
        		push @maybe_renamed_exglobs,$ex_glob;
        	}
        	}
        }
        # Then we concatenate these arg lists
        $args_ref = [@orig_args, @maybe_renamed_exglobs ]; # NOT ordered union, if they repeat that should be OK
        $info->{'SubroutineCall'}{'Args'}{'List'}= $args_ref;
        
        # WV20180522 I added this to have an ArgMap for the refactored subroutine signatures, not sure it is actually helpful
        if (0) {
        if (not exists $info->{'SubroutineCall'}{'ArgMap'}) {
        	$info->{'SubroutineCall'}{'ArgMap'}={};
        }
        if (not exists $info->{'CallArgs'}) {
        	 $info->{'CallArgs'}={'Set' =>{}};
        } elsif(exists $info->{'CallArgs'} and not exists $info->{'CallArgs'}{'Set'}) {
        	 $info->{'CallArgs'}{'Set'} ={};
        } 
        # for every arg in the signature, map the call arg
        # Now, in  principle they should be identical. I overwrite whatever was present in the original ArgMap
        my $i=0;
        for my $ sig_arg ( @{ $stref->{'Subroutines'}{$name}{'RefactoredArgs'}{'List'}  } ){
        	
        	my $call_arg = $info->{'SubroutineCall'}{'Args'}{'List'}[$i];
        	$info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} = $call_arg;
        	if ($sig_arg eq $call_arg) {
        	if (not exists  $info->{'CallArgs'}{'Set'}{$sig_arg} ) {
        		my $var_rec = get_var_record_from_set($Sf->{'Vars'},$sig_arg);
        		my $var_type = $var_rec->{'ArrayOrScalar'};
        		$info->{'CallArgs'}{'Set'}{$sig_arg}{'Type'} = $var_type;
        		if ($var_type eq 'Array') {
        			$info->{'CallArgs'}{'Set'}{$sig_arg}{'Arg'}=$sig_arg;
        		}
        	}
        	}
        	$i++;
        }
        }
        
        # This is the emitter, maybe that should not be done here but later on? TODO!
	    my $args_str = join( ',', @{$args_ref} );	    
	    my $indent = $info->{'Indent'} // '      ';
	    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
	    my $rline = "call $name($args_str)\n";
	    
		if ( exists $info->{'PlaceHolders'} ) { 
			while ($rline =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$rline=~s/$ph/$ph_str/;
			}                                    
            $info->{'Ref'}++;
        }  	    
	    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
	    push @{$rlines}, [ $indent . $maybe_label . $rline, $info ];
    } else {
        push @{$rlines}, [ $line , $info ];
    }

    return $rlines;
}    # END of _create_refactored_subroutine_call()

sub emit_subroutine_call { (my $stref, my $f, my $annline)=@_;
	    (my $line, my $info) = @{ $annline };
	    my $Sf        = $stref->{'Subroutines'}{$f};
	    my $name = $info->{'SubroutineCall'}{'Name'};
	    
		my $args_ref = $info->{'SubroutineCall'}{'Args'}{'List'};
			    
	    my $indent = $info->{'Indent'} // '      ';
	    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
	    my $args_str = join( ',', @{$args_ref} );	    
	    my $rline = "call $name($args_str)\n";
		if ( exists $info->{'PlaceHolders'} ) { 
			while ($rline =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$rline=~s/$ph/$ph_str/;
			}                                    
            $info->{'Ref'}++;
        }  	    
	    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
		return ( $indent . $maybe_label . $rline, $info );
} # END of emit_subroutine_call

#@ Signature =>
#@    Args =>
#@        List => [...]
#@        Set => {}
#@    Name => $name;
#@    Function  => $bool
#@    Program  => $bool
#@    Entry  => $bool
#@    BlockData  => $bool
#@    ReturnType => integer | real | ...
#@    ResultVar => $result_var
#@    Characteristic => pure | elemental | recursive 

sub emit_subroutine_sig { #(my $stref, my $f, 
        (my $annline)=@_;
	    (my $line, my $info) = @{ $annline };
        #my $Sf        = $stref->{'Subroutines'}{$f};
	    
	    my $name = $info->{'Signature'}{'Name'};
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};	    	    
	    my $args_str = join( ',', @{$args_ref} );	 
	    my $indent = $info->{'Indent'} // '      ';   
	    
	    my $code_unit = (exists $info->{'Signature'}{'Function'} and $info->{'Signature'}{'Function'}==1) ? 'function' 
	    : exists $info->{'Signature'}{'Program'} ? 'program'
	    : exists $info->{'Signature'}{'BlockData'} ? 'block data'
	    : exists $info->{'Signature'}{'Entry'} ? 'entry'
	    : 'subroutine';
	    my $maybe_characteristic = exists $info->{'Signature'}{'Characteristic'} ? $info->{'Signature'}{'Characteristic'}.' ' : '';
	     my $maybe_returntype = exists $info->{'Signature'}{'ReturnType'} ? $info->{'Signature'}{'ReturnType'}.' ' : '';
	     my $maybe_resultvar = exists $info->{'Signature'}{'ResultVar'} ? ' result '.$info->{'Signature'}{'ResultVar'} : '';
	     
#	     my $rline = "subroutine $name($args_str)\n";
	    my $rline =  (exists $info->{'Signature'}{'BlockData'} or exists $info->{'Signature'}{'Program'} ) ?
	     "$code_unit $name"
	    : "$maybe_characteristic$maybe_returntype$code_unit $name($args_str)$maybe_resultvar\n";
	    
		if ( exists $info->{'PlaceHolders'} ) { 
			while ($rline =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$rline=~s/$ph/$ph_str/;
			}                                    
            $info->{'Ref'}++;
        }  	    
	    $info->{'Ann'}=[annotate($name, __LINE__ ) ];
		return ( $indent . $rline, $info );
} # END of emit_subroutine_sig

# This is for lines that contain function calls, so in practice either assignments or subroutine calls
sub _create_refactored_function_calls { 
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
    my $Sf        = $stref->{'Subroutines'}{$f};
    (my $line, my $info) = @{ $annline };
    
		# Get the AST
		my $ast = [];
		my $do_not_update=0;
		if (exists $info->{'Assignment'} ) {
			$ast= $info->{'Rhs'}{'ExpressionAST'};
		} elsif ( exists $info->{'SubroutineCall'} ) {
			$ast = $info->{'SubroutineCall'}{'ExpressionAST'}
		} else {
			carp "UNSUPPORTED STATEMENT FOR FUNCTION CALL: $line ( _create_refactored_function_calls ) ".Dumper($info);
			$do_not_update=1;
		} 	
		# Update the function calls in the AST
		# Basically, whenever we meet a function, we query it for ExGlobArgs and tag these onto te argument list.		
		my $updated_ast = $do_not_update ? $ast : __update_function_calls_in_AST($stref,$Sf,$f,$ast);
#		say Dumper($ast, $updated_ast);
		my $updated_line = $do_not_update ? $line : $NEW_PARSER ? emit_expr_from_ast($updated_ast) : emit_expression($updated_ast);
         
		if ( exists $info->{'PlaceHolders'} ) { 

			while ($updated_line =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$updated_line=~s/$ph/$ph_str/;
			}                                    
            $info->{'Ref'}++;
        }    
		if (exists $info->{'Assignment'} ) {
			# This is a HACK!
			my %F95_ops =(
			    '==' => '.eq.',  
    			'/=' => '.ne.',  
     			'<=' => '.le.',  
     			'>=' => '.ge.',
			    'eq' => '==',
			    'ne' => '/=',
			    'le' => '<=',
			    'ge' => '>=',     			
			);
			for my $op (  '==', '/=', '<=','>=' ) {
				my $rop =  $F95_ops{$op};
				while($line=~/$op/) {
					$line=~s/$op/$rop/;
				}
			}
			$line=~s/=.+$//; 
			for my $op (  'eq', 'ne', 'le','ge' ) {
				my $rop =  $F95_ops{$op};
				while($line=~/\.$op\./) {
					$line=~s/\.$op\./$rop/;
				}
			}			
			$line.=	' = '.$updated_line;
		} elsif (exists $info->{'SubroutineCall'}) {
			$line=~s/call.+$//;
			$line.=	'call '.$updated_line;			
		}
#		say "_create_refactored_function_calls($line) at " . __PACKAGE__ . ' '. __LINE__;
    push @{$rlines}, [ $line , $info ];
    
    return $rlines;
}    # END of _create_refactored_function_calls()

sub __update_function_calls_in_AST { (my $stref, my $Sf,my $f, my $ast) = @_;
#	carp "NEEDS TO BE TESTED FOR NEW PARSER!";
    if ($NEW_PARSER) {
	    if (!@{$ast}) { return $ast; } # an empty AST
        # use the new walker
         if ( ($ast->[0] & 0xFF) == 1 or
       ($ast->[0] & 0xFF) == 10 ) { # array var or function/subroutine call
        # it it's a function call, update the call args
        if ( ($ast->[0] & 0xFF) == 1 ) {
					my $name = $ast->[1];
					
				    if ($name ne $f and exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'}) {
				    	     
				        my @globals = exists  $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'List'} ? @{ $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'List'} } : ();        
				        my @maybe_renamed_exglobs=();
				        for my $ex_glob (@globals) {
				        	# $ex_glob may be renamed or not. I test this using OrigName. 
				        	# This way I am sure I get only original names
				        	if (exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'}) {
								$ex_glob = $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'};		
				        	}        	
				        	if (exists $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob}) {
				        		say "INFO: RENAMED $ex_glob => ".$Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} . ' in call to ' . $name . ' in '. $f if $I;
				        		push @maybe_renamed_exglobs, $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob};
				        	} else {
				        		push @maybe_renamed_exglobs,$ex_glob;
				        	}
				        }
				    
					    if (@maybe_renamed_exglobs) {
                            # Still wrong: we need to check $ast->[2]. If it is empty, create a ',' ; elsif it is not ',', create a ','; else append to the ',' list
                            if (not @{$ast->[2]} ) { # empty list. create [',' ]
                                push @{$ast->[2]}, 27;
                            }
                            elsif ( ($ast->[2][0] && 0xFF) != 27) { # not a list. Wrap in [',', ... ]
                                my $entry = $ast->[2];
                                $ast->[2]=[ 27, $entry ];

                            } #else { # It is already ',' so do nothing
                            #}
                            for my $extra_arg (@maybe_renamed_exglobs) {
    					    	push @{$ast->[2]},[ 2 ,$extra_arg]; #'$'
                            }
					    }
				    }	            
        }
        # but in any case we need to traverse again for the old call args

		my $entry= __update_function_calls_in_AST($stref,$Sf,$f,$ast->[2]);
		$ast->[2] = $entry;

  } elsif ( ($ast->[0] & 0xFF) < 29 and ($ast->[0] & 0xFF) !=2 ) { # other operators
	for my $idx (1 .. scalar @{$ast}-1) {
		my $entry  = __update_function_calls_in_AST($stref,$Sf,$f,$ast->[$idx]);
		$ast->[$idx] = $entry;
	}
  } 

    } else {
	if (ref($ast) eq 'ARRAY') { 
		my $nelts = scalar @{$ast};
		for my  $idx (0 .. $nelts-1) {		
			my $entry = $ast->[$idx];
			if (ref($entry) eq 'ARRAY') {
				my $entry = __update_function_calls_in_AST($stref,$Sf,$f,$entry);
				$ast->[$idx] = $entry;
			} else {
				if ($idx==0 and (($entry & 0xFF) == 1)) {				
					my $name = $ast->[$idx+1];
					
				    if ($name ne $f and exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'}) {
				    	     
				        my @globals = exists  $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'List'} ? @{ $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'List'} } : ();        
				        my @maybe_renamed_exglobs=();
				        for my $ex_glob (@globals) {
				        	# $ex_glob may be renamed or not. I test this using OrigName. 
				        	# This way I am sure I get only original names
				        	if (exists $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'}) {
								$ex_glob = $stref->{'Subroutines'}{$name}{'ExGlobArgs'}{'Set'}{$ex_glob}{'OrigName'};		
				        	}        	
				        	if (exists $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob}) {
				        		say "INFO: RENAMED $ex_glob => ".$Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob} . ' in call to ' . $name . ' in '. $f if $I;
				        		push @maybe_renamed_exglobs, $Sf->{'RenamedInheritedExGLobs'}{'Set'}{$ex_glob};
				        	} else {
				        		push @maybe_renamed_exglobs,$ex_glob;
				        	}
				        }
				    
				    	my $j=0;
					    for my $extra_arg (@maybe_renamed_exglobs) {
					    	$ast->[$nelts+$j]=[
					    	(++$Fortran::Expression::Evaluator::Parser::nodeId<<8)+2
#					    	'$'
					    	,$extra_arg];
					    	$j++;
					    }
				    }						
				} 
			}		
		}
	}
    } # NEW_PARSER
	return  $ast;#($stref,$f, $ast);
	
} # END of __update_function_calls_in_AST()

sub _add_extra_assignments_in_block_data { (my $stref, my $f, my $annlines) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $new_annlines=[];
	for my $arg ( @{ $Sf->{'ExGlobArgs'}{'List'} } ) { 
#		say $arg;
		my $arg_name = $Sf->{'ExGlobArgs'}{'Set'}{$arg}{'OrigName'};
		push @{ $new_annlines }, ["        $arg = $arg_name", {'Extra'=>1}];
	}
     
	my $merged_annlines = splice_additional_lines_cond(
        $stref,$f, 
        sub {(my $annline)=@_; return exists $annline->[1]{'EndBlockData'} ? 1 : 0 ;},
        $annlines,
        $new_annlines,
        1,
        0,
        1
    ) ;	
	 
	return $merged_annlines;
} # END of _add_extra_assignments_in_block_data

sub _add_implicit_none { my ($stref, $f, $annlines) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $first_vardecl=1;
	my $rlines=[];
    for my $annline ( @{$annlines} ) {      
        (my $line, my $info) = @{ $annline };
        
        if (exists $info->{'VarDecl'} and $first_vardecl) {
        	$first_vardecl=0;
                   # Here I think I can insert 'implicit none'
           if (not exists $Sf->{'ImplicitNone'}) {
            say "Adding 'implicit none' at " . __PACKAGE__ . ' '. __LINE__ if $V;
           my $r_info={};
            $r_info->{'ImplicitNone'}=1;
           push @{$rlines}, ['      implicit none', $r_info];
           }
        	
        }
        push @{$rlines},$annline;
        
    }	 
return $rlines;
} # END of _add_implicit_none

sub _emit_refactored_signatures { my ($stref, $f, $annlines) = @_;
#    my $Sf = $stref->{'Subroutines'}{$f};
    
    my $rlines=[];
    for my $annline ( @{$annlines} ) {      
    	 (my $line, my $info) = @{ $annline };        
        if (exists $info->{'Signature'} ) {
            @{$annline} = emit_subroutine_sig($annline);
#            say Dumper($annline);             
        }
        push @{$rlines},$annline;        
    }    
    return $rlines;
} # END of _emit_refactored_signatures

1;
