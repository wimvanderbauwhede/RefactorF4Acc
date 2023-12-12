package RefactorF4Acc::Refactoring::ContextFree;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( %f95ops get_annotated_sourcelines emit_f95_var_decl emit_f95_parsed_var_decl format_f95_par_decl);
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp qw(croak carp confess longmess shortmess);
use Data::Dumper;
#$Data::Dumper::Indent = 0;

use Exporter;

@RefactorF4Acc::Refactoring::ContextFree::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::ContextFree::EXPORT_OK = qw(
  &context_free_refactorings  
);

#* BeginDo: just remove the label
#* EndDo: replace label CONTINUE by END DO
#* Break: keep as is; add a comment to identify it as a break
#* Goto: Do nothing
#* GotoTarget: Do nothing
#* NoopBreakTarget: replace CONTINUE with "call noop"
#* BreakTarget: Do nothing

#* PlaceHolders: put the strings back

#* WV20150722: problem is this does too much, should not insert any new code, do that separately! FIXME!
#* WV20150803: I added another pass to insert a proper ExGlobVarDeclHook after the last parameter, if any.
# WV20190403: skip lines marked as Deleted or Skip, what's the point in refactoring those?
sub context_free_refactorings {
    ( my $stref, my $f ) = @_;
    print "CONTEXT-FREE REFACTORINGS for $f CODE\n" if $V ;
    
    my $die_if_one         = ($DBG and $f eq 'BOOM')? 1 : 0;
    my @extra_lines        = ();
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};
  
    if ($DBG and 
        $Sf->{'Status'} != $PARSED 
        and  $Sf->{'Status'}!= $UNUSED
    ) {
        croak "USED BUT NOT PARSED: $f\n" . caller() . "\n" ;
    }
    my $annlines   = get_annotated_sourcelines( $stref, $f );
    my $nextLineID = scalar @{$annlines} + 1;
    my $firstdecl  = 1;
    $Sf->{'RefactoredCode'} = [];
    my @include_use_stack = ();
    # FIXME: This is way too long and quite unclear
#    my $line_ct=0;

    for my $annline ( @{$annlines} ) {
#    	++$line_ct;
        if ( $DBG and not defined $annline or not defined $annline->[0] ) {
            croak
              "Undefined source code line for $f in context_free_refactorings()";
        }
        ( my $line, my $info ) = @{$annline};

        if ( exists $info->{'Comments'}  ) { # I should distinguish between original comments and new comments.
            # Also, maybe a -C flag to suppress comments might be good.
            if ( exists $info->{'OrigComments'}  ) { # I should distinguish between original comments and new comments.
            # Also, maybe a -C flag to suppress comments might be good.
                push @{ $Sf->{'RefactoredCode'} }, [ $line, $info ];   
            }        
            next;
        }
        if ( not exists $info->{'Inlined'} ) {
            if ( exists $info->{'Deleted'} ) {
                next;
            }
        }
        if ( exists $info->{'Save'} ) {
        	if ( $Config{'NO_SAVE'} == 1 or
                exists  $Sf->{'Program'} and $Sf->{'Program'} == 1             
             ) { 
                $line = '! '.$line;
                $info->{'Deleted'}=1;
                push @{$info->{'Ann'}}, annotate($f, __LINE__ .' SAVE statement in Program' );
        	}
        }	
        elsif ( exists $info->{'Implicit'} ) { 
        	$line = '! '.$line;
        	$info->{'Deleted'}=1;
        	push @{$info->{'Ann'}}, annotate($f, __LINE__ .' Original Implicit statement' );
        }	        
        elsif ( exists $info->{'Dimension'} and not exists $info->{'VarDecl'} ) {
        	$line = '! '.$line;
        	$info->{'Deleted'}=1;
        	push @{$info->{'Ann'}}, annotate($f, __LINE__ .' Original Dimension statement' );
        }	
        elsif ( exists $info->{'Common'} ) {
        	$line = '! '.$line unless exists $Sf->{'BlockData'};
        	$info->{'Deleted'}=1;
        	push @{$info->{'Ann'}}, annotate($f, __LINE__ .' Original Common statement' );
        }	
        
        elsif ( exists $info->{'External'} ) {
            # Add the type if it is still Unknown
            # if ( exists $Sf->{'ExternalFunctions'} ) {
                # carp "HERE External $f $line", Dumper $info  if $line=~/ff318/;
                for my $ext_f (sort keys %{ $info->{'External'} } ) {
                    if (exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$ext_f} ) {
                        my $rdecl = $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$ext_f};
                        if ($rdecl->{'Type'} eq 'Unknown') {
                            my ($type, $array_or_scalar, $attr) = type_via_implicits($stref,$f,$ext_f);
                            $rdecl->{'Type'}  = $type;
                            $line = emit_f95_var_decl($rdecl);
                        } else {
                            $line = $info->{'Indent'}.'external :: '. $ext_f;
                        }
                        #  $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$ext_f}{'TRACK'}=1;
                        #  my $test_decl = get_var_record_from_set( $Sf->{'Vars'},$ext_f);
                        #  $test_decl->{'TRACK'}=1;
                        
                    }
                }
            # }
        	push @{$info->{'Ann'}}, annotate($f, __LINE__ .' External statement' );
        }	                
		elsif ( exists $info->{'Data'} ) {
			my @chunks=split(/data\s+/,$line);
			croak if $DBG and  scalar @chunks > 2;
			my $str = $chunks[1];
			$str=~s/\s+//g;
			$str=~s/\// \/ /g;
			$line = $chunks[0].'data '.$str;
		}
			
        elsif ( exists $info->{'Goto'} ) {
            $line =~ s/\bgo\sto\b/goto/;
            $info->{'Ref'}++;
        }

        # BeginDo: just remove the label
        elsif ( exists $info->{'BeginDo'} ) {
        	my $label = $info->{'BeginDo'}{'Label'};
        	# This should have an extra check
        	
        	if ($Sf->{'DoLabelTarget'}{$label} eq 'Continue' or $Sf->{'DoLabelTarget'}{$label} eq 'EndDo')  {         	
            	$line =~ s/do\s+\d+\s+/do /;
            	$info->{'Ref'}++;
        	}
        }

        # EndDo: replace label CONTINUE by END DO;
        # if no continue, remove label & add end do on next line
        if ( exists $info->{'EndDo'} and exists $info->{'EndDo'}{'Label'} ) {

            my $is_goto_target = 0;
            if ( $Sf->{'Gotos'}{ $info->{'EndDo'}{'Label'} } ) {
                # this is an end do which serves as a goto target
                $is_goto_target = 1;
            }
            my $count = $info->{'EndDo'}{'Count'};
            if ( exists $info->{'Continue'} ) {
            	
                if ( $is_goto_target == 0 ) {
                	my $label='';
                	if (exists $info->{'EndDo'}{'Label'}) {
                		$label = $info->{'EndDo'}{'Label'}
                	} elsif (exists $info->{'Continue'}{'Label'}) {
                		$label = $info->{'Continue'}{'Label'}
                	}
	                	if ($label ne '' and exists  $Sf->{'ReferencedLabels'}{$label}) {                		
                    	$line = $info->{'Indent'}. $label.    ' end do'; # END DO can't be a label target I think
					} else {
                    	$line = $info->{'Indent'}.' end do';
					}
                    $count--;
                } elsif ($noop) {
                    $line =~ s/continue/call noop/;
                }
                $info->{'Ref'}++;
            } elsif ( $line =~ /^\d+\s+\w/ ) {
                if ( $is_goto_target == 0 ) {
                    $line =~ s/^\d+//;
                    $info->{'Ref'}++;
                }
            }
            while ( $count > 0 ) {
                push @extra_lines,
                  [
                    '      end do', { 'EndDo' => 1, 'LineID' => $nextLineID++ }
                  ];
                $count--;
            }
        }
        if (
            $noop
            && (   exists $info->{'NoopBreakTarget'}
                || exists $info->{'NoopTarget'} )
          )
        {
            $line =~ s/continue/call noop/;
            $info->{'Ref'}++;
        }
        if ( exists $info->{'Break'} ) {
        	if ($DBG) {
                $line .= '  !Break';
        	}
            $info->{'Ref'}++;
        }

        if ($Config{'ALLOW_SPACES_IN_NUMBERS'}==1  ) { # I make the assumption that there must be 3 digits after a space
        
            while ($line=~/\d\s+\d\d\d+/) {
                $line =~s/(\d)\s+(\d)/$1$2/;
            }
            # croak $line if $line=~/100\s*000/;
        }

        
        if ( exists $info->{'PlaceHolders'} ) { 
# Here we put the strings back in place of the placeholders
			while ($line =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$line=~s/$ph/$ph_str/;
			}
            $info->{'Ref'}++;
        }

# ------------------------------------------------------------------------------
# This section refactors variable and parameter declarations
# ------------------------------------------------------------------------------

        if ( exists $info->{'VarDecl'} ) {
            
        	my $var =  $info->{'VarDecl'}{'Name'};
            
            if (not exists $info->{'ParamDecl'}) {
                if ( in_nested_set($Sf, 'Parameters', $var) ) { 
                    # croak "$f: $line" . Dumper $info if $var =~/alpha/;
	                # Remove this line, because this param should have been declared above
	                $line = '!! Original line VAR !! ' . $line;
	                $info->{'Deleted'} = 1;
	                push @{$info->{'Ann'}}, annotate($f, __LINE__ .' Removed VarDecl for Param '.$var );
	            } 
            }

			my $stmt_count = $info->{'StmtCount'}{$var};
			if (not defined $stmt_count) {$stmt_count=1; };
            if (exists  $info->{'ParsedVarDecl'} ) {

                my $pvd = $info->{'ParsedVarDecl'}; 
                if (scalar @{ $info->{'ParsedVarDecl'}{'Vars'} } == 1) {
                    my $var_decl = get_var_record_from_set( $Sf->{'Vars'},$var);
                    # carp "HERE ParsedVarDecl $f $line", Dumper $var_decl if $line=~/ff318/;

                    $line = emit_f95_var_decl($var_decl);
                    if (exists $info->{'Dimension'}) {
                    	push @{$info->{'Ann'}}, annotate($f, __LINE__ .': Dimension, '.($stmt_count == 1 ? '' : 'SKIP'));
                    } else {
                        add_ann_to_info($info,$f,__LINE__);
                    }
                } else {
                    $line = emit_f95_parsed_var_decl($pvd);                    
                    push @{$info->{'Ann'}}, annotate($f, __LINE__ .': ParsedVarDecl, '.($stmt_count == 1 ? '' : 'SKIP'));                    
                }                
                
            } else { 
	            if ( in_nested_set($Sf, 'Parameters', $var) ) { 
                    # WV 2021-06-08 Although we come here, the action is not done and not reported in Ann ???
	                # Remove this line, because this param should have been declared above
	                $line = '!! Original line PAR:2 !! ' . $line;
	                # $info->{'Deleted'} = 1;
	                push @{$info->{'Ann'}}, annotate($f, __LINE__ .' Removed ParamDecl' );
	            } elsif (not exists $info->{'Ref'} or $info->{'Ref'} == 0 ){
	                my $var_decl = get_var_record_from_set( $Sf->{'Vars'},$var);
	                $line = emit_f95_var_decl($var_decl) ;                
	                delete $info->{'ExGlobArgDecls'};
	                $info->{'Ref'} = 1 unless exists $info->{'Inlined'};                 
	                push @{$info->{'Ann'}}, annotate($f, __LINE__ .': Ref==0, '.$stmt_count );
	            } else {
                    if ($DBG){
	                    croak $f.' : BOOM! ' . 'context_free_refactoring '. __LINE__ ."; ".$line.'    '.Dumper($info)."\n" .
                        Dumper(pp_annlines($Sf->{'AnnLines'})); # if $DBG
                    }
	            }                        
            }
            
            if ($stmt_count != 1) {
            	$line = "! DUP $stmt_count $line";
                $info->{'Deleted'} = 1;
            } else {
            	if ($line=~/^\s*dimension/) {
            		$line = "! $line ! DUP DIM !";
                    $info->{'Deleted'} = 1;
            	}
            }  
        }
# ------------------------------------------------------------------------------
# END of section refactoring variable and parameter declarations
# ------------------------------------------------------------------------------
# If/ElseIf
        if ( exists $info->{'If'} or exists $info->{'ElseIf'} ) {
            while ( $line =~ /\.\s+(?:and|not|or|neqv|eqv)\./ ) {
                $line =~ s/\.\s+(and|not|or|neqv|eqv)\./ .$1. /;
            }
            while ( $line =~ /\.\s+(?:and|not|or|neqv|eqv)\./ ) {
                $line =~ s/\.(and|not|or|neqv|eqv)\s+\./ .$1. /	;
            }
            while ( $line =~ /\.\s*(?:eq|ne|gt|lt|le|ge)\s*\./ ) {
                $line =~ s/\.\s*(eq|ne|gt|lt|le|ge)\s*\./ $f95ops{$1} /;
            }
            $info->{'Ref'}++;
        } 
        
# ------------------------------------------------------------------------------
# This section refactors parameter declarations, this is what generates the parameters in LES params_common
# Problem is that in flexpart, these parameters have already been declared before the variable declarations
# ------------------------------------------------------------------------------
        elsif ( exists $info->{'ParamDecl'} ) {    
            # so this is a parameter declaration "pur sang"
            # WV 20130709: why should I remove this?
            my $par_decl = $info->{'ParamDecl'} ;
            my $parsed_par_decl = $info->{'ParsedParDecl'};
            
            my $info_ref = $info->{'Ref'} // 0;         
            if (exists $info->{'VarDecl'}{'Name'} ) {             		
                my $var = $info->{'VarDecl'}{'Name'};                                               
                $par_decl =  format_f95_par_decl( $stref, $f, $var ) ;
            }
            elsif (exists $info->{'ParamDecl'}{'Name'} ) {                    		
                my $var_val = $info->{'ParamDecl'}{'Name'};
                ( my $var, my $val ) = @{$var_val};                
                $par_decl =  format_f95_par_decl( $stref, $f, $var ) ;
            } elsif (exists $info->{'ParamDecl'}{'Names'} ) { 
                croak 'PROBLEM: multiple parameter decls on a single line!';
            }
                # We must check for string placeholders in parameter decls!
            if ($par_decl->{'Name'}[1]=~/(__PH\d+__)/) {
                my $ph=$1;
                $par_decl->{'Name'}[1]=$info->{'PlaceHolders'}{$ph};
            }
            my $new_line =emit_f95_var_decl($par_decl) ;
            # Here the declaration is complete
            push @extra_lines,
                [
                $new_line,
                {
                    'Extra'     => 1,
                    'ParamDecl' => $par_decl,
                    'ParsedParDecl' => $parsed_par_decl,
                    'Ref'       => $info_ref + 1,
                    'LineID'    => $nextLineID++,
                    'SpecificationStatement' => 1,
                    'Ann' => [annotate($f, __LINE__. ' : ParamDecl') ]                        
                }
                ]
                ; # Create parameter declarations before variable declarations            
            $line = '!! ' . $line;
            push @{$info->{'Ann'}}, annotate($f, __LINE__ .' Original ParamDecl' );
            $info->{'Deleted'} = 1;
        }

# ------------------------------------------------------------------------------
# END of section refactoring parameter declarations
# ------------------------------------------------------------------------------
# Subroutine call
        elsif ( exists $info->{'SubroutineCall'} ) {
            $info->{'Ref'}++;
        } elsif ( exists $info->{'Include'} ) { 
            
        	# I don't think we can have statement labels in front of includes
            my $inc  = $info->{'Include'}{'Name'};
            my $tinc = $inc;
            $tinc =~ s/\./_/g;
            if ( not exists $stref->{'IncludeFiles'}{$inc}{'ExtPath'} ) { # FIXME: this is because 'InclType' => 'External' gets overwritten by 'Parameter' 
            
            	if (exists $Sf->{'Includes'}{$inc}{'Only'} and scalar keys %{ $Sf->{'Includes'}{$inc}{'Only'} }>0) {
                    push @{$stref->{'IncludeFiles'}{$inc}{'UsedBy'}}, $f; 
            		my @used_params = keys %{ $Sf->{'Includes'}{$inc}{'Only'} };
                	$line = "      use $tinc". ($Config{'NO_ONLY'} ?  '!' : '') .', only : '.join(', ', @used_params) ;
                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__. ' Include' );
                  	
            	} elsif (exists $stref->{'IncludeFiles'}{$inc}{'ParamInclude'}) {
            		my $param_include=$stref->{'IncludeFiles'}{$inc}{'ParamInclude'};
            		
                    push @{$stref->{'IncludeFiles'}{$param_include}{'UsedBy'}}, $f; 
            		my $tinc = $param_include;
            		$tinc =~ s/\./_/g;            		
            		if (exists $Sf->{'Includes'}{$param_include}{'Only'} and scalar keys %{ $Sf->{'Includes'}{$param_include}{'Only'} }>0) {            		            	
            			my @used_params = keys %{ $Sf->{'Includes'}{$param_include}{'Only'} };
                		$line = "      use $tinc". ($Config{'NO_ONLY'} ?  '!' : '') .", only : ".join(', ', @used_params);
                        $info->{'Use'} = {'Name' => $tinc, 'Only' => [@used_params]};
                  		push @{ $info->{'Ann'} }, annotate($f, __LINE__. ' Include' );
                        # carp "$f: $param_include";
					} else {
                		$line = "!!      use $tinc ! ONLY LIST EMPTY";
                  		push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';            		            		  		
            		}
				} elsif (exists $stref->{'IncludeFiles'}{$tinc}{'InclType'}
					and $stref->{'IncludeFiles'}{$tinc}{'InclType'} eq 'Parameter'
				) {
					# This is a factored-out parameter module. 
					# No 'Only' , FIXME!
                	$line = "      use $tinc ! context_free_refactorings 409";
                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';									            		  	
            	} else {            		
            		# No 'Only' or 'Only' list is empty, SKIP
                	$line = "!      use $tinc ! ONLY LIST EMPTY";
                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';
                  	$info->{'Deleted'}=1;            		
            	}
                if (not exists $info->{'Use'}) {
                    $info->{'Use'}{'Name'}=$tinc; 
                    $info->{'Use'}{'Only'}=[]; 
                    $info->{'Use'}{'Inlineable'}=1;
                } 
                #carp 'FIXME: USE/ONLY!';
            } else {
#            	say 'WARNING: EXTERNAL INCLUDES ARE COMMENTED OUT!' if $W;
                $line =                
                  "      include '$inc'"; # FIXME
                  push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' External ');
            }
            $info->{'Ref'}++;

            # use must come right after subroutine/function/program
            # or after another use
            # or after the module declaration
            $info->{'LineID'} = $nextLineID++;
            push @include_use_stack, [ $line, $info ];    # if $line ne '';
            next;
        } # exists $info->{'Include'} )
        push @{ $Sf->{'RefactoredCode'} }, [ $line, $info ];   
        if (@extra_lines) {
            for my $extra_line (@extra_lines) {
                push @{ $Sf->{'RefactoredCode'} }, $extra_line;
            }
            @extra_lines = ();
        }
    }    # LOOP over AnnLines

    # now splice the include stack just below the signature
    if (@include_use_stack) {
    	
        my $offset = 0;
        if ( exists $stref->{'IncludeFiles'}{$f} ) {
            $Sf->{'RefactoredCode'} =
              [ @include_use_stack, @{ $Sf->{'RefactoredCode'} } ];
        } else {
        	
            # 1. Look for the signature
            for my $tmpannline ( @{ $Sf->{'RefactoredCode'} } ) {
                if ( exists $tmpannline->[1]{'Signature'} ) {
                    last;
                }
                $offset++;
                if ( exists $tmpannline->[1]{'Include'} ) {
                    die "Hit include without seeing sub or func in $f";
                }
            }

            if ( $offset == 0 ) {
                my $firstline = shift @{ $Sf->{'RefactoredCode'} };
                my @new       = (
                    $firstline, @include_use_stack, @{ $Sf->{'RefactoredCode'} }
                );
                $Sf->{'RefactoredCode'} = [@new];
                
            } else {
                my @part1 = ();
                for ( 0 .. $offset ) {
                    push @part1, shift @{ $Sf->{'RefactoredCode'} };
                }
                my @part2 = @{ $Sf->{'RefactoredCode'} };
                my @new = ( @part1, @include_use_stack, @part2 );
                $Sf->{'RefactoredCode'} = [@new];

            }
        }
    }
        
    my $has_vardecl=0;
    my $has_pars = 0;    
    my $has_includes=0;
    my $has_implicit_none = 0;
    for my $annline ( @{$Sf->{'RefactoredCode'}} ) {
        if ( $DBG and not defined $annline or not defined $annline->[0] ) {
            croak
              "Undefined source code line for $f in context_free_refactorings()" . Dumper($annlines) ;
        }
        ( my $line, my $info ) = @{$annline};
        
        if ( exists $info->{'Deleted'} or exists $info->{'Comments'} or exists $info->{'Blank'}  ) {
            next;
        }
        if (exists $info->{'ParamDecl'}) {
            $has_pars++;
        }
        if (exists $info->{'Include'} ) {
            $has_includes++;
        }
        if (exists $info->{'ImplicitNone'}) {
        	$info->{'ExGlobVarDeclHook'}='ImplicitNone';
        	$Sf->{'ExGlobVarDeclHook'}=1;
        	$has_implicit_none=1;
        	last;
        }
        if (exists $info->{'VarDecl'}) {
            $info->{'ExGlobVarDeclHook'}='VarDecl';
            $Sf->{'ExGlobVarDeclHook'}=1;
            $has_vardecl=1;
            last;
        }        
    }    
    
    if ($has_vardecl==0 and $has_implicit_none==0) {
        my $parlinecount=$has_pars;
        my $incllinecount=$has_includes;
        
        for my $annline ( @{$Sf->{'RefactoredCode'}} ) {
#        	say Dumper($annline);
            if ( $DBG and not defined $annline or not defined $annline->[0] ) {
                croak
                  "Undefined source code line for $f in context_free_refactorings()";
            }
            ( my $line, my $info ) = @{$annline};
            
            if ( exists $info->{'Deleted'} or exists $info->{'Comments'} or exists $info->{'Blank'}  ) {
                next;
            }
            if ($has_pars) {
                if (exists $info->{'ParamDecl'} and --$parlinecount == 0) {
                    $info->{'ExGlobVarDeclHook'}='AFTER LAST ParamDecl';
                    $Sf->{'ExGlobVarDeclHook'}=1;
                    last;
                }
                
            } elsif ($has_includes) {
                if (exists $info->{'Include'} and --$incllinecount == 0) {
                    $info->{'ExGlobVarDeclHook'}='AFTER LAST Include';
                    $Sf->{'ExGlobVarDeclHook'}=1;
                    last;
                }
                
            } elsif (exists $info->{'Signature'}) {
                $info->{'ExGlobVarDeclHook'}='Signature';
                $Sf->{'ExGlobVarDeclHook'}=1;
                
                last;
            }        
        }      
    }
    if ($die_if_one) { croak Dumper( $Sf->{'RefactoredCode'} ); }
    return $stref;
}    # END of context_free_refactorings()


1;
