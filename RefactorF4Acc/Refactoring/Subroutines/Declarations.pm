package RefactorF4Acc::Refactoring::Subroutines::Declarations;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( 
    get_f95_var_decl 
    get_f95_par_decl 
    emit_f95_var_decl 
    get_annotated_sourcelines
    splice_additional_lines    
);

# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Subroutines::Declarations::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::Declarations::EXPORT = qw(
    &create_exglob_var_declarations
    &create_refactored_vardecls
    &find_and_add_missing_var_decls
);

=pod
Subroutines
        create_exglob_var_declarations() -> Decls 
        create_refactored_vardecls() -> Decls
=cut

# --------------------------------------------------------------------------------
## This routine renames the declarations of local variables that conflict with global variables
#sub create_refactored_vardecls {
#	
#    ( my $stref, my $f, my $annline, my $rlines, my $is_C_target ) = @_; 
##local $V=1;
#    print "create_refactored_vardecls( $f )\n" if $V;
#    
#    croak "create_refactored_vardecls OBSOLETE?";
#    	
##    die "Bug to be fixed: applying context-free refactoring breaks the next stage!";
#    my $Sf        = $stref->{'Subroutines'}{$f};
#    my $line      = $annline->[0] || '';
#    my $info = $annline->[1];
##    my %args      = %{ $Sf->{'OrigArgs'}{'Set'} }; 
#    my %args      = %{ get_vars_from_set($Sf->{'OrigArgs'}) };
#    my $globals = ( get_maybe_args_globs( $stref, $f ) )[1];
#    my $skip=0;
#    
#    my $var      =  $info->{'VarDecl'}{'Name'};
#    my @vars= ($var ); # FIXME, LAZY!
#    my @nvars = (); 
#    my $rline = $line;
#    # Loop over all declared variables and check for conflicts with globals
#    # Also check if none of them is actually a built-in function, these must be skipped for C translation
#    for my $var (@vars) {
#        my $skip_var = 0;
#        if ( exists $stref->{'Subroutines'}{$var}{'Function'} ) {
#            if ($is_C_target) {
#                print "WARNING: $var in $f is a function!\n" if $W;
#                $skip_var = 1;
#            }
#        }
#        if ( not $skip_var ) {
#            if ( exists $globals->{$var} and not exists $args{$var} ) {
#                print
#"WARNING: CONFLICT in $f ($Sf->{'Source'}):  renaming local $var to $var\_LOCAL\n"
#                  if $W;
#                my $nvar = $var . '_LOCAL';
#                $rline =~ s/\b$var\b/$nvar/;
#                push @nvars, $nvar;
#            } else {
#                push @nvars, $var;
#            }
#        }
#    } # @vars
#    
#    $rline =~ s/,\s*$//;
#    my $spaces = $line;
#    $spaces =~ s/[^\s].*$//;
#
#    if ( $line !~ /\(.*?\)/ ) {   
#    # If the line does not contain array decls,
#    # remove the spaces from the original line and use them for the new line
#
#        if (exists $info->{'Ref'} and $info->{'Ref'}==1) {# WAS $line=~/\s+\:\:\s+/ # FIXME: weak test to see if already refactored!
#	       $rline=$line;
#        } else { # FIXME: use formatting function!!!
#            croak "PARAM! $line" if $line=~/parameter/;
#            $rline =
#            $spaces
#          . $Sf->{'Vars'}{ $vars[0] }{'Type'} . ' :: '
#          . join( ',', @nvars ) . "\n";
#        }       
#    } else {    
#        # For arrays, we split the declaration over multiple lines
#        # And we use the declaration from the include
#        for my $tnvar (@nvars) {
#            my $rdecl=[];
#                if (in_nested_set($Sf,'Parameters',$vars[0])  ){
#                    $rdecl = get_f95_par_decl( $stref,$f,$tnvar );
#                } else {
#                	$rdecl = [$stref,$f,$tnvar];# WV: seems this never happens!                	
#                }
#            $info->{'VarDecl'} = $rdecl;#[$tnvar];
#            $info->{'Ref'} = 1; 
#            
#            push @{$rlines}, [ emit_f95_var_decl($rdecl), $info ];
#        }
#        $skip=1;
#    }
##    $info->{'Ref'}++;
#    push @{$rlines}, [ $rline, $info ] unless $skip==1;
#    return $rlines;
#}    # END of create_refactored_vardecls()

# --------------------------------------------------------------------------------
## We need to check if these variables are not still present in any includes of $f!
#sub create_exglob_var_declarations {
#    ( my $stref, my $f, my $annline, my $rlines ) = @_;
#croak "create_exglob_var_declarations OBSOLETE?";	
#
##        local $I=1;
##        local $V=1;
##        local $W=1;
#
#    my $Sf                 = $stref->{'Subroutines'}{$f};
##    my %args               = %{ $Sf->{'OrigArgs'}{'Set'} };
#    my %args      = %{ get_vars_from_set($Sf->{'OrigArgs'}) };
#    my $nextLineID=scalar @{$rlines}+1;
#    
#    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
#        
#        print "INFO: GLOBALS from INC $inc in $f\n" if $I;
#
#        for my $var ( sort @{ $Sf->{'Globals'}{$inc}{'List'} } ) {
#            
#croak "THIS CHECK IS NOT OK: RefactoredArgs can have an entry with a blank IODir here, FIXME!";
##what we should do is check the content, or maybe better, check if there already exists an actual VarDecl line.
##If not, we should create one. If it exists and is complete, we should skip it.
#                if ( exists $Sf->{'Globals'}{$inc} ) { #die $inc;
#                    
## FIXME: we need to remove these declarations from the include file!
#
##                        croak "$f: INC $inc: VAR $var\n" if not exists $stref->{IncludeFiles}{$inc}{'Vars'}{$var};
#say "WARNING: $f:  VAR $var is not declared in INC $inc but is common, will be declared via implicit rules!" if $W;                        
#                        my $rdecl = get_f95_var_decl( $stref,$inc,$var);
##                        croak Dumper($stref->{'IncludeFiles'}{$inc}{Vars}{uprof}) if $var eq 'uprof';
#                        if ( exists $Sf->{'ConflictingParams'}{$var} ) {
#                            my $gvar = $Sf->{'ConflictingParams'}{$var}[0];
#                            print
#"WARNING: CONFLICT in arg decls for $f: renaming $var to ${var}_GLOB\n"
#                              if $W;
#                            $rdecl->[2][0] =~ s/\b$var\b/$gvar/; #FIXME: only works for a single var!
#                        }
#                        my $rline = emit_f95_var_decl($rdecl);
#                        $rline .= " ! EX-GLOB from $inc";   
#                        
#                        my $info={};
#                        $info->{'LineID'}= $nextLineID++;
#                        $info->{'Ref'}=1;
#                        $info->{'VarDecl'}=$rdecl;
#                        push @{$rlines}, [ $rline,  $info ];
#                        
#                    } else {
##                        say
#                    }
##            }
#        }    # for
#    }
#    return $rlines;
#}    # END of create_exglob_var_declarations()

# --------------------------------------------------------------------------------
# We can assume that these variables are not subroutine arguments, so the Intent should be blank
# This should probably go in RefactorF4Acc::Refactoring::Subroutines::Declarations
#sub _add_missing_var_decls { (my $stref,my $f,my $undeclared_vars)=@_; croak "OBSOLETE!";
#    my $extra_annlines=[];
#    for my $var (@{$undeclared_vars}) {
#        next if $var eq ''; # FIXME: WHY?!           
#        say "\tADDING MISSING VAR DECL for <$var> " if $V;
#        my $vd = get_f95_var_decl($stref,$f,$var);
#        my $info = {'VarDecl'=>$vd}; # TODO: need some extra $info here
#        my $line = emit_f95_var_decl($vd).' ! missing';
#        my $annline = [ $line, $info];
#        push @{$extra_annlines}, $annline;
#    }
#    # So here we spice these into the original code.
#    # First find where to splice. As far as I can see we can splice anywhere inside the existing var decls.
#    my $annlines = get_annotated_sourcelines( $stref, $f );  
#    my $insert_pos_lineID = 0;
##    say "HOOK for $f";
#    for my $annline (@{$annlines}) {
#        (my $line, my $info) = @{$annline};
##        say $line."\t".Dumper($info);
#       if (exists $info->{'VarDecl'}) {
#           $insert_pos_lineID = $info->{'LineID'};
##           say "$f VAR DECL LINE ID: $insert_pos_lineID";
#           last;
#       } 
#    }
#    
#    my $merged_annlines = splice_additional_lines($stref,$f,$insert_pos_lineID, $extra_annlines, 0, 0);
#	my $code_unit = sub_func_incl_mod($f,$stref);
#    my $Sf = $stref->{$code_unit}{$f};    
#    $Sf->{'RefactoredCode'} = $merged_annlines;
#    return $stref;
#} # END of _add_missing_var_decls()

#sub find_and_add_missing_var_decls { croak "OBSOLETE!";
#     (my $stref)=@_;
#    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
#        next unless (defined $f and $f ne '');
#        my $undeclared_vars=[];
##     print "NAME: <$f>\n";
##     say '<'.Dumper(keys $stref->{'Subroutines'}{$f}).'>';
##if ($f eq 'f_esl') {
##    say show_annlines( $stref->{'Subroutines'}{$f}{RefactoredCode} );die;
##}
#     if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}) {
#        my %refactored_args =  %{ $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'} };
#    	if (scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} } ) { # or $stref->{'Subroutines'}{$f}{'Program'} )     		
#            # so what I need to do is create the line with intent and replace it in RefactoredCode
#            for my $annline (@{ $stref->{'Subroutines'}{$f}{RefactoredCode} } ) {
#                (my $line, my $info) = @{ $annline };
#                if (not exists $info->{'Deleted'} and not exists $info->{'Comments'}) { 
#              if (exists $info->{'VarDecl'}                 
#              ) {
#                my $varname = $info->{'VarDecl'}{'Name'};
#                # So here I have lost Decl in dsigw2dz in RefactoredArgs but not in Vars
#                # So let's find out where this has gone wrong
##                die Dumper($stref->{'Subroutines'}{$f}{Vars}{$varname}) if $varname eq 'dsigw2dz';
#                if (not exists $info->{'Ref'} or $info->{'Ref'}==0) {
#                my $vardecl = get_f95_var_decl($stref,$f, $varname);
#                $line = emit_f95_var_decl($vardecl).' ! V6';
#                $info->{'Ref'}=1;
#                } else {
#                my $vardecl = get_f95_var_decl($stref,$f, $varname);
#                $line = emit_f95_var_decl($vardecl).' ! V7: intent'; 
#                $info->{'Ref'}=2;
#                    
#                }
#                delete $refactored_args{$varname};
#                
##                say "DELETED $varname from RefactoredArgs in $f";
#              } elsif (exists $info->{'ParamDecl'}
#             
#              ) {      
#                             
#                my $parname = $info->{'ParamDecl'}{'Name'}[0];
#                if (not exists $info->{'Ref'} or $info->{'Ref'}==0) {
#                my $pardecl = get_f95_par_decl($stref,$f, $parname);
#                $line = emit_f95_var_decl($pardecl).' ! V7'; # FIXME: Somehow this is emitted TWICE, I guess because it re-emits the commmented line?
#                $info->{'Ref'}=1;
#                }
#                delete $refactored_args{$parname};
#                
##                say "DELETED PARAMETER $parname from RefactoredArgs in $f";
#              } elsif ($line =~/::/) {
##                  say "VAR DECL NOT MARKED PROPERLY: ".$line. ' => '.Dumper($info->);
#              }
#            } else {
##                say 'SKIPPED: '.$line;
#            }
#            }
#            for my $maybe_var (keys %refactored_args ) {
#               if ($maybe_var  =~/::/) {
#                  say "PARAM DECL! ".$maybe_var
#              } else {
#                  push @{$undeclared_vars}, $maybe_var; 
#              }
#            }
#              
#            if ($V) {                        
#            if (keys %refactored_args) {
#                say "REMAINING in RefactoredArgs in $f:";
#                map {say} (keys %refactored_args);
#                say '';
#            }
#            }
#    	} else {
#    		print "WARNING: SKIPPING <$f>: " if $V;
#			if (defined $f and $f ne '') {
#			    if (defined $stref->{'Subroutines'}{$f}) {
#			    if (not defined $stref->{'Subroutines'}{$f}{'Program'}) {
#			        $stref->{'Subroutines'}{$f}{'Program'}=0;
#			    }
#				print 'Callers: ',scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} },'; Program: ',$stref->{'Subroutines'}{$f}{'Program'},"\n" if $V;
#			    } else { 
#			        print "No Subroutines recorded for $f\n" if $V;
#			    }
#			} else {
#				print "Undefined\n" if $V;
#			}
#    	}
#        # At this point we have identified the missing variable declarations, now we should add them in.
#        # So we need to find the last var decl and add them after that, I guess.
#        # For all these remaining variables we need to type them via implicits
#        $stref=_add_missing_var_decls($stref,$f,$undeclared_vars);
##        die  if $f=~/press/;
##        die Dumper($stref->{'Subroutines'}{$f}{'RefactoredCode'}) if $f=~/press/;
#           
#    }
#    }    
#    return $stref;
#} # END of find_and_add_missing_var_decls()
1;