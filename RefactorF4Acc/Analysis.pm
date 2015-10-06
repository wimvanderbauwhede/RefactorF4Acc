package RefactorF4Acc::Analysis;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Includes qw( find_root_for_includes );
use RefactorF4Acc::Analysis::Globals qw( lift_globals );
use RefactorF4Acc::Analysis::Sources qw( analyse_sources );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_end_detect );
use RefactorF4Acc::Refactoring::Common qw( format_f95_var_decl stateful_pass );
# 
#   (c) 2010-2015 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Analysis::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::EXPORT = qw(
    &analyse_all
);

sub analyse_all {
	
	(my $stref, my $subname)=@_;
    # Find the 'root', i.e. the outermost calling subroutine, for each include file
    
	   print "\t** FIND ROOT FOR INCLUDES **\n" if $V;
    $stref = find_root_for_includes( $stref, $subname );    
    
    # First find any additional argument declarations, either in includes or via implicits
    for my $f (keys  %{ $stref->{'Subroutines'} } ){
        next if $f eq '';
        $stref = _find_argument_declarations($stref, $f);
        
        $stref = _analyse_variables($stref, $f);
        
        $stref = _resolve_conflicts_with_params($stref, $f);
    }
    
    $stref = lift_globals($stref,$subname);
    
    for my $f (keys  %{ $stref->{'Subroutines'} } ){
        next if $f eq '';    
        $stref = _create_refactored_args($stref, $f);
    }
        
#    say Dumper($stref->{'Subroutines'}{'getfields'});
#    die 'analyse_all() ' . __LINE__;

    # Now we can do proper globals handling
    # We need to walk the tree again, find the globals in rec descent.
#    print "\t** RESOLVE GLOBALS **\n" if $V;
#    $stref = resolve_globals( $subname, $stref );
#    print "\t** ANALYSE SOURCES **\n" if $V; # TODO: BETTER NAME
#    $stref = analyse_sources($stref); # TODO: LIFTING OF INCLUDES SHOULD HAPPEN *AFTER* THIS
    for my $kernel_wrapper (keys %{$stref->{'KernelWrappers'}}) {
        $stref = outer_loop_end_detect($kernel_wrapper,$stref);
    }
    
#    for my $inc (keys %{ $stref->{'IncludeFiles'} }) {
#    for my $v (keys %{ $stref->{'IncludeFiles'}{$inc}{'Commons'} }) {
#    say $v.' => '.Dumper($stref->{'IncludeFiles'}{$inc}{'Commons'}{$v});
#    }
#    }
    # So at this point all globals have been resolved and typed.
# NOTE: It turns out that at this point any non-global not explicity declared variables don't have a declaration yet.     
	return $stref;	
} # END of analyse_all()

sub _find_argument_declarations { (my  $stref, my  $f) = @_;
   my $once=1; 
   my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
   my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};   
   $Sf->{'ExInclArgDecls'}={ 'List'=>[],'Set'=>{} };
   $Sf->{'ExImplicitArgDecls'}={ 'List'=>[],'Set'=>{} };
       for my $arg (@{ $Sf->{'Args'}{'List'} }  ) {
           if (not exists $Sf->{'DeclaredArgs'}{'Set'}{$arg}) {
               say "MISSING ARG DECLS for '$f'" if $V and $once;$once=0;
               say "ARG: $arg" if $V;
               my $in_incl=0;
               for my $inc ( keys %{ $Sf->{'Includes'} } ) {
                    if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$arg}  ) {
                        say "FOUND DECL for $arg in INC $inc" if $V;
                        my $decl = $stref->{'IncludeFiles'}{$inc}{'Vars'}{$arg}{'Decl'};
                        push @{  $Sf->{'ExInclArgDecls'}{'List'} }, $arg;
                        $Sf->{'ExInclArgDecls'}{'Set'}{$arg}=$decl;
                        $in_incl=1;
                        last; 
                    }    
               }
               if (not $in_incl) {
                   say "TYPING $arg via IMPLICIT rules" if $V;
                   (my $type, my $array_or_scalar, my $attr) = type_via_implicits($stref, $f, $arg);
#                   say "$type $attr";    
                   my $decl = format_f95_var_decl($stref, $f, $arg);
#                   say Dumper($decl);
                    push @{  $Sf->{'ExImplicitArgDecls'}{'List'} }, $arg;
                    $Sf->{'ExImplicitArgDecls'}{'Set'}{$arg}=$decl;                                  
               }
           }
       }      
       
    return $stref;
} # END of _find_argument_declarations




# -----------------------------------------------------------------------------
#2.4 Find variables and test:
#- IF NOT IN Args:
#	- IF NOT DeclaredVars 
#		IF IN Commons for any Incl => ExGlobArgDecls, Globals
#		ELSE 
#			IF in Vars for any Incl => ExInclVarDecls, LocalVars
#				ELSE => ExImplicitVarDecls, LocalVars
# Then merge the Args and ExGlobArgDecls   
sub _analyse_variables {
    ( my $stref, my $f) =@_;
    my $Sf     = $stref->{'Subroutines'}{$f};
           $Sf->{'Globals'}={};
#        $Sf->{'ExGlobArgDecls'}={ 'List'=>[],'Set'=>{} };
    
    my $__analyse_vars_on_line = sub {
            (my $annline, my $state) =@_;
            (my $line, my $info) = @{$annline};
            if( exists $info->{'Assignment'} or exists $info->{'SubroutineCall'} or exists $info->{'If'} or exists $info->{'ElseIf'}) {
              
            
        ( my $stref, my $f, my $identified_vars ) = @{ $state };
        my $Sf     = $stref->{'Subroutines'}{$f};
        
        my @chunks = split( /[^\.\w]/, $line );
        for my $mvar (@chunks) {
            next if exists $F95_reserved_words{$mvar};
            next if exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{$mvar};
#            die Dumper(%F95_reserved_words);
            next if $mvar=~/^__PH\d+__$/;
            next if $mvar!~/^[_a-z]\w*$/;
            
#            die '<'.$mvar.'>;'.$line if $mvar =~/if/;
#            say $line."\t".Dumper($info);
#            say "MAYBE VAR: $mvar";
            if ( not exists $identified_vars->{$mvar} and not exists $Sf->{'Args'}{'Set'}{$mvar}  and not exists $Sf->{'DeclaredVars'}{'Set'}{$mvar} ) {
                my $in_incl = 0;
                for my $inc ( keys %{ $Sf->{'Includes'} } ) {
 
                    if (exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mvar}) {
                        $in_incl=1;
                    if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter'
                        )
                    {
                        print "WARNING: $mvar in $f is a PARAMETER from $inc!\n"
                          if $W;
                    } else {               
                        if ($stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Common') {          
                        print "FOUND COMMON $mvar in INC $inc in $line\n" if $V;
                        my $decl =  $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mvar}{'Decl'};
                       if (exists $stref->{'IncludeFiles'}{$inc}{'Commons'}{$mvar} ) {
                            push @{ $stref->{'Subroutines'}{$f}{'Globals'}{$inc}{'List'} }, $mvar;
                            $stref->{'Subroutines'}{$f}{'Globals'}{$inc}{'Set'}{$mvar} =  $decl;
                            push @{ $stref->{'Subroutines'}{$f}{'ExGlobArgDecls'}{'List'} }, $mvar;
                            $stref->{'Subroutines'}{$f}{'ExGlobArgDecls'}{'Set'}{$mvar} =  $decl;
                       } else {
                           say "INFO: LOCAL VAR FROM $inc, NOT COMMON! " . '_analyse_variables() ' . __LINE__  if $I;
                            push @{ $stref->{'Subroutines'}{$f}{'LocalVars'}{$inc}{'List'} }, $mvar;
                            $stref->{'Subroutines'}{$f}{'LocalVars'}{$inc}{'Set'}{$mvar} =  $decl;
                            push @{ $stref->{'Subroutines'}{$f}{'ExInclVarDecls'}{'List'} }, $mvar;
                            $stref->{'Subroutines'}{$f}{'ExInclVarDecls'}{'Set'}{$mvar} =  $decl;                       
                       }                    
                        $identified_vars->{$mvar}=1;                    
                        last;
                        }
                    }
                }
                }
                if (not $in_incl) {
                    if ($line=~/$mvar\s*\(/) {
                        say "INFO: LOCAL VAR <$mvar> in $f may be an EXTERNAL FUNCTION " if $I;
                    } else {
                    say "INFO: LOCAL VAR <$mvar> in $f via IMPLICIT! " . $line .' _analyse_variables() ' . __LINE__  if $I;
                    my $decl = format_f95_var_decl($stref, $f, $mvar);
                            push @{ $stref->{'Subroutines'}{$f}{'LocalVars'}{'List'} }, $mvar;
                            $stref->{'Subroutines'}{$f}{'LocalVars'}{'Set'}{$mvar} = $decl;
                            push @{ $stref->{'Subroutines'}{$f}{'ExImplicitVarDecls'}{'List'} }, $mvar;
                            $stref->{'Subroutines'}{$f}{'ExImplicitVarDecls'}{'Set'}{$mvar} = $decl;
                    }                     
                    $identified_vars->{$mvar}=1;    
                }
            
        }
        
        }
        return ($annline, [$stref,$f,$identified_vars]);
            } else {
                  return ($annline, $state);
            }
    };
    my $state= [$stref, $f, {}];
    ($stref,$state) = stateful_pass($stref,$f,$__analyse_vars_on_line,  $state, '_analyse_variables() ' . __LINE__  );
    if (defined  $stref->{'Subroutines'}{$f}{'ExGlobArgDecls'} and scalar @{ $stref->{'Subroutines'}{$f}{'ExGlobArgDecls'}{'List'} } > 0 ) {
        $Sf->{'HasCommons'} = 1;
    }
    return $stref;
}    # END of _analyse_variables()


sub _resolve_conflicts_with_params {
    (my $stref, my $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    local $V=1; local $W-=1; local $I=1;
    for my $inc ( keys %{ $Sf->{'Includes'} } ) {
        if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {

            # See if there are any conflicts between parameters and ex-globals
            for my $commoninc ( keys %{ $Sf->{'Globals'} } ) {
                
                for my $mpar ( @{ $Sf->{'Globals'}{$commoninc}{'List'} } ) {
                    if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$mpar} )
                    {
                        print
"WARNING: $mpar from $inc conflicts with $mpar from $commoninc\n"
                          if $W;
                          # So we store the new name, the Common include and the Parameter include in that order
                        $Sf->{'ConflictingGlobals'}{$mpar} = [$mpar . '_GLOB_'.$commoninc,$commoninc,$inc];# In fact, just $commoninc is enough                         
                        $stref->{'IncludeFiles'}{$commoninc}
                          {'ConflictingGlobals'}{$mpar} = [$mpar . '_GLOB_'.$inc,$commoninc,$inc];
                        $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
                          {$mpar} =[ $mpar . '_GLOB_'.$inc,$commoninc,$inc];
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
}    # END of _resolve_conflicts_with_params

sub _create_refactored_args {
       (my $stref, my $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    if (exists $Sf->{'ExGlobArgDecls'} and exists $Sf->{'ExGlobArgDecls'}{'List'}) {
        $Sf->{'RefactoredArgs'}{'List'} = ordered_union( $Sf->{'Args'}{'List'}, $Sf->{'ExGlobArgDecls'}{'List'} );
        $Sf->{'HasRefactoredArgs'} = 1;
    } 
    return $stref;
}



1;    