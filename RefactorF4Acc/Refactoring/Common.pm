package RefactorF4Acc::Refactoring::Common;
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
use Carp qw(croak carp confess longmess shortmess);
use Data::Dumper;
#$Data::Dumper::Indent = 0;

use Exporter;

@RefactorF4Acc::Refactoring::Common::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Common::EXPORT_OK = qw(
  &context_free_refactorings
  &create_refactored_source
  &get_annotated_sourcelines
  &split_long_line
  &format_f95_par_decl
  &get_f95_par_decl
  &get_f95_var_decl
  &emit_f95_var_decl
  &splice_additional_lines
  &splice_additional_lines_cond
  &stateless_pass
  &stateful_pass
  &stateful_pass_reverse
  &top_src_is_module
  &pass_wrapper_subs_in_module
  &update_arg_var_decl_sourcelines
);

our %f95ops = (
    'not'  => '.not.',     #       complement, negation
    'and'  => '.and.',     #       logical and
    'or'   => '.or.',      #       logical or
    'eqv'  => '.eq.',      #       logical equivalence
    'neqv' => '.neqv.',    #      logical not equivalence, exclusive or

    'eq' => '==',          #    equality, old
    'ne' => '/=',          #    not equal. old
    'lt' => '<',           #     less than, old
    'gt' => '>',           #     greater than, old
    'le' => '<=',          #    less than or equal, old
    'ge' => '>=',          #    greater than or equal, old

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
              "Undefined source code line for $f in create_refactored_source()";
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
        if ( exists $info->{'Skip'}  ) {
            next;
        }        
        if ( exists $info->{'Deleted'} ) {
        	# WV20190403: originally the condition included: "and $line eq '' ) {"
            next;
        }
}
#         if ( exists $info->{'ImplicitNone'} ) {
# #            next;
#         }
        if ( exists $info->{'Save'} ) {
        	if ( $Config{'NO_SAVE'} == 1 or
                exists  $Sf->{'Program'} and $Sf->{'Program'} == 1             
             ) { 
        	$line = '! '.$line;
        	$info->{'Deleted'}=1;
        	$info->{'Ann'}=[ annotate($f, __LINE__ .' SAVE statement in Program' ) ];
        		
        	}
        }	
        elsif ( exists $info->{'Implicit'} ) { 
        	$line = '! '.$line;
        	$info->{'Deleted'}=1;
        	$info->{'Ann'}=[ annotate($f, __LINE__ .' Original Implicit statement' ) ];
        }	        
        elsif ( exists $info->{'Dimension'} and not exists $info->{'VarDecl'} ) {
        	$line = '! '.$line;
        	$info->{'Deleted'}=1;
        	$info->{'Ann'}=[ annotate($f, __LINE__ .' Original Dimension statement' ) ];
        }	
        elsif ( exists $info->{'Common'} ) {
        	$line = '! '.$line unless exists $Sf->{'BlockData'};
        	$info->{'Deleted'}=1;
        	$info->{'Ann'}=[ annotate($f, __LINE__ .' Original Common statement' ) ];
        }	
        
        elsif ( exists $info->{'External'} ) {
        	# # if (scalar keys %{ $info->{'External'}} >1) {
        	# # 	say 'WARNING: Cannot handle EXTERNAL with multiple names, IGNORING!' if $W;
            # #     croak $line;
        	# # } else {
            #     for my $maybe_ext (keys %{ $info->{'External'} } ) {
            #         if (exists $stref->{'Subroutines'}{$maybe_ext}
            #         and exists $stref->{'Subroutines'}{$maybe_ext}{'Source'}
            #         and $stref->{'Subroutines'}{$maybe_ext}{'Source'} eq $Sf->{'Source'}) {
            #             # $line = '! '.$line." ! $maybe_ext is defined in this file";
            #             # $info->{'Deleted'}=1;        			
            #         } else {
            #             # Now it is possible that we have identified a source for this func
            #             if (exists $stref->{'Subroutines'}{$maybe_ext}) {
            #                 # $line = '! '.$line." ! $maybe_ext is accessed via 'use'";
            #                 # $info->{'Deleted'}=1;
            #             }
            #         }
            #     }  
        	# # }
        	$info->{'Ann'}=[ annotate($f, __LINE__ .' External statement' ) ];
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
			my $stmt_count = $info->{'StmtCount'}{$var};
			if (not defined $stmt_count) {$stmt_count=1; };
            if (exists  $info->{'ParsedVarDecl'} ) {
                my $pvd = $info->{'ParsedVarDecl'}; 
                if (scalar @{ $info->{'ParsedVarDecl'}{'Vars'} } == 1) {
                    if (exists $info->{'Dimension'}) {
                    	my $var_decl = get_var_record_from_set( $Sf->{'Vars'},$var);
                    	$line = emit_f95_var_decl($var_decl);
                    	push @{$info->{'Ann'}}, annotate($f, __LINE__ .': Dimension, '.($stmt_count == 1 ? '' : 'SKIP'));
                    }
                } else {                    
                    $line = _emit_f95_parsed_var_decl($pvd);
                    push @{$info->{'Ann'}}, annotate($f, __LINE__ .': ParsedVarDecl, '.($stmt_count == 1 ? '' : 'SKIP'));                    
                }
            } else { 
	            if ( in_nested_set($Sf, 'Parameters', $var) ) { 
                    
	                # Remove this line, because this param should have been declared above
	                $line = '!! Original line PAR:2 !! ' . $line;
	                $info->{'Skip'}=1;
	                $info->{'Deleted'} = 1;
	                $info->{'Ann'}=[ annotate($f, __LINE__ .' Removed ParamDecl' ) ];
	            } elsif (not exists $info->{'Ref'} or $info->{'Ref'} == 0 ){
	                my $var_decl = get_var_record_from_set( $Sf->{'Vars'},$var);
	                $line = emit_f95_var_decl($var_decl) ;                
	                delete $info->{'ExGlobArgDecls'};
	                $info->{'Ref'} = 1 unless exists $info->{'Inlined'};                 
	                push @{$info->{'Ann'}}, annotate($f, __LINE__ .': Ref==0, '.$stmt_count );
	            } else {
                    if ($DBG){
	                    croak $f.' : BOOM! ' . 'context_free_refactoring '. __LINE__ ."; ".$line.'    '.Dumper($info)."\n" .
                        Dumper(pp_annlines($Sf->{'AnnLines'}));
                    }
	            }                        
            }
            
            if ($stmt_count != 1) {
            	$line = "! DUP $stmt_count $line";
            	$info->{'Skip'}=1; 
            } else {
            	if ($line=~/^\s*dimension/) {
            		$line = "! $line ! DUP DIM !";
            		$info->{'Skip'}=1;
            	}
            }  
#            if (exists $info->{'Dimension'}) {
#            	croak Dumper($line,$info);
#            }         
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
        elsif ( exists $info->{'ParamDecl'} )
        {    # so this is a parameter declaration "pur sang"
                # WV 20130709: why should I remove this?
                my $par_decls= [ $info->{'ParamDecl'} ];
                
                my $info_ref = $info->{'Ref'} // 0;         
                       	if (exists $info->{'VarDecl'}{'Name'} ) {             		
                             my $var = $info->{'VarDecl'}{'Name'};                                               
                                $par_decls = [ format_f95_par_decl( $stref, $f, $var ) ];
                       	}
                    elsif (exists $info->{'ParamDecl'}{'Name'} ) {                    		
                             my $var_val = $info->{'ParamDecl'}{'Name'};
                                ( my $var, my $val ) = @{$var_val};                
                                $par_decls = [ format_f95_par_decl( $stref, $f, $var ) ];
                    } elsif (exists $info->{'ParamDecl'}{'Names'} ) { 
                        $par_decls = [];
                        for my $var_val (@{  $info->{'ParamDecl'}{'Names'} }) {
                                ( my $var, my $val ) = @{$var_val};                
                                push @{$par_decls}, format_f95_par_decl( $stref, $f, $var );
                        }
                    }
                for my $par_decl (@{ $par_decls }) {
                	# We must check for string placeholders in parameter decls!
                	if ($par_decl->{'Name'}[1]=~/(__PH\d+__)/) {
                		my $ph=$1;
                		$par_decl->{'Name'}[1]=$info->{'PlaceHolders'}{$ph};
                	}
#                	croak Dumper($par_decl) if $line=~/cpn002/;
	                my $new_line =emit_f95_var_decl($par_decl) ;
	                # Here the declaration is complete
	                push @extra_lines,
	                  [
	                    $new_line,
	                    {
	                        'Extra'     => 1,
	                        'ParamDecl' => $par_decl,
	                        'Ref'       => $info_ref + 1,
	                        'LineID'    => $nextLineID++,
	                        'SpecificationStatement' => 1,
	                        'Ann' => [annotate($f, __LINE__. ' : ParamDecl') ]                        
	                    }
	                  ]
	                  ; # Create parameter declarations before variable declarations            
		            $line = '!! ' . $line;
		            $info->{'Ann'}=[ annotate($f, __LINE__ .' Original ParamDecl' ) ];
		            $info->{'Deleted'} = 1;
                }
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
                  		push @{ $info->{'Ann'} }, annotate($f, __LINE__. ' Include' );
					} else {
                		$line = "!!      use $tinc ! ONLY LIST EMPTY";
                  		push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';            		            		  		
            		}
				} elsif (exists $stref->{'IncludeFiles'}{$tinc}{'InclType'}
					and $stref->{'IncludeFiles'}{$tinc}{'InclType'} eq 'Parameter'
				) {
					# This is a factored-out parameter module. 
					# No 'Only' , FIXME!
                	$line = "      use $tinc";
                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';									            		  	
            	} else {            		
            		# No 'Only' or 'Only' list is empty, SKIP
                	$line = "!      use $tinc ! ONLY LIST EMPTY";
                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';
                  	$info->{'Deleted'}=1;            		
            	}
            	$info->{'Use'}{'Name'}=$tinc; 
            	$info->{'Use'}{'Only'}=[]; 
            	$info->{'Use'}{'Inlineable'}=1; 
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
         
        push @{ $Sf->{'RefactoredCode'} }, [ $line, $info ];   # if $line ne '';
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
              "Undefined source code line for $f in create_refactored_source()" . Dumper($annlines) ;
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
                  "Undefined source code line for $f in create_refactored_source()";
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
#        croak $f;
    }

    if ($die_if_one) { croak Dumper( $Sf->{'RefactoredCode'} ); }
    return $stref;
}    # END of context_free_refactorings()

# -----------------------------------------------------------------------------
# This routine essentially discards unused lines and splits long lines
# I think this could actually be part of the emitter
sub create_refactored_source {
    ( my $stref, my $f, my $annlines, ) = @_;
    my $refactored_lines = [];

    for my $annline ( @{$annlines} ) {

       ( my $line , my $info ) = @{ $annline};        

        if ( not exists $info->{'Comments'} and ( exists $info->{'InBlock'} or not exists $info->{'Deleted'} ) ) {
            print $line, "\n" if $DBG;
				if (not exists $info->{'ReadCall'} and not exists $info->{'WriteCall'} and not exists $info->{'PrintCall'} ) {
					
					# Problem is of course that strings can contain comments and comments can contain quotes. 
					# So placeholder strings can in principle occur in comments. That is what we are looking for here, trailing comments	
					# So we must exclude the strings that look like comments, hence the PlaceHolders trick.
					# So in principle I must look for the first ! outside any pair of ' or "
					# say I split a line on ' => pre ' str1 ' sep1 ' str2 ' sep2_maybe_! ' 
					# So I remove pre; then I remove str then look at sep. If sep has ! => OK, found comment.
					
					my $line_without_comment = $line;  
					if ($DBG) {
					my $replace_PHs = 1;
					if ($replace_PHs and exists $info->{'PlaceHolders'} ) {
					 	my $ph_line=$line;
					 	my $phs={};
					 	for my $ph (keys %{$info->{'PlaceHolders'}} ) { 
                            my $ph_str = $info->{'PlaceHolders'}{$ph};
                            $phs->{$ph_str}=$ph;
					 	}
                            while ( $ph_line =~ /(\'.*?\')/ ) {
                                my $strconst = $1;
                                my $ph       = $phs->{$strconst};                               
                                $ph_line =~ s/\'.*?\'/$ph/;
                            }
                            while ( $ph_line =~ /(\".*?\")/ ) {
                                my $strconst = $1;
                                my $ph       = $phs->{$strconst};                               
                                $ph_line =~ s/\".*?\"/$ph/;
                            }
					 	$line_without_comment = $ph_line;
					}
					}				 
				    my $comment = '';
				    if ($DBG) {
					# So after putting the strings back we check for a !	 
					if ($line_without_comment =~/\!(.+)$/) { say "<$line>\n<$line_without_comment>";# if $line_without_comment=~/__PH\d+_/ ;
#					say $info->{'TrailingComment'};
						 	# found a comment, remove it from the line with placeholders (?!)
						 	$comment=$1;  	
						 	$line_without_comment = $line; # This is the line with placeholders
						 	$line_without_comment =~s/\!$comment//; # So this should only work if there were no matched quotes in the comment!
					} else {
						 	$line_without_comment = $line;
					}
				    }
 	           	    my @split_lines = $Config{'SPLIT_LONG_LINES'} ? split_long_line($line_without_comment) : ( $line_without_comment );
    	         	for my $sline (@split_lines) {    	         			
        	            	push @{$refactored_lines}, [ $sline, $info ];
            	    }
            	    if ($DBG) {
            	    if ($comment ne '') {
            	    		$refactored_lines->[-1][0].=' !'.$comment;
            	    }           
            	    } 	    
				} else {
					push @{$refactored_lines}, [ $line, $info ];
				}
        } else {
            push @{$refactored_lines}, [ $line, $info ];
        }
    }
    return $refactored_lines;
}    # END of create_refactored_source()

# -----------------------------------------------------------------------------
# A convenience function to split long lines.
# - count the number of characters, i.e. length()
# - find the last comma before we exceed 64 characters (I guess it's really 72-5?):
# There is a problem with trailing comments 
# So I have to remove these first, then see if the line must be split, then append the comment to the last segment


sub split_long_line {
    my $line = shift;

    my @chunks = @_;

    my $nchars = 64 + 28;
    if ( scalar(@chunks) == 0 ) {
        print "\nLINE: \n<$line>\n" if $DBG;
        $nchars = 72 + 28;
    }
    my $split_on  = ',';
    my $split_on2 = ' ';
    my $split_on3 = '.ro.';
    my $split_on4 = '.dna.';

    # FIXME: add split on ';' and on operators (F95)
    my $smart = 0;
    if ( length($line) > $nchars ) {
        my $patt  = '';
        my $ll    = length($line);
        my $rline = join( '', reverse( split( '', $line ) ) );

        #       print $rline,"\n";
        #       print "$ll - $nchars = ",$ll - $nchars,"\n";
        my $idx  = index( $rline, $split_on,  $ll - $nchars );
        my $idx2 = index( $rline, $split_on2, $ll - $nchars );
        my $idx3 = index( $rline, $split_on3, $ll - $nchars );
        my $idx4 = index( $rline, $split_on4, $ll - $nchars );
        if ( $idx < 0 && $idx2 < 0 && $idx3 < 0 && $idx4 < 0 ) {
            print "WARNING: Can't split line \n$line\n" if $W;
        } elsif ( $idx >= 0 ) {
            print "Split line on ", $ll - $idx, ", '$split_on'\n" if $DBG;
        } elsif ( $idx < 0 && $idx2 >= 0 ) {
            $idx = $idx2;
            print "Split line on ", $ll - $idx2, ", '$split_on2'\n"
              if $DBG;
        } elsif ( $idx < 0 && $idx2 < 0 && $idx3 >= 0 ) {
            $idx = $idx3;
            print "SPLIT line on ", $ll - $idx, ", '$split_on3'\n"
              if $DBG;

            # Need smarter split
            $smart = 1;
            $patt = join( '', reverse( split( '', $split_on3 ) ) );
        } elsif ( $idx < 0 && $idx2 < 0 && $idx4 >= 0 ) {
            $idx = $idx4;
            print "SPLIT line on ", $ll - $idx, ", '$split_on4'\n"
              if $DBG;

            # Need smarter split
            $smart = 1;
            $patt = join( '', reverse( split( '', $split_on4 ) ) );
        }

#       if ($smart==1) {
#           die substr( $line, 0, $ll - $idx3, '' ) if length(substr( $line, 0, $ll - $idx3, '' ))>$nchars;
#       }
        push @chunks, substr( $line, 0, $ll - $idx, '' );
        print "CHUNKS:\n", join( "\n", @chunks ), "\n" if $DBG;
        print "REST:\n", $line, "\n" if $DBG;
        split_long_line( $line, @chunks );
    } else {
        push @chunks, $line;

        my @split_lines = ();
        if ( @chunks > 1 ) {
            my $fst  = 1;
            my $rest = scalar @chunks;
            for my $chunk (@chunks) {
                if ( $rest > 0 ) {
                    $rest--;
                    $chunk .= ' &';    # WARNING: FREE FORM!
                }
                if ($fst) {
                    $fst = 0;
                } else {
                    if ( $chunk =~ /^\s*$/ ) {
                        $chunk = '';
                    } else {

                        #                       $chunk = '     &  ' . $chunk;
                        #                        $chunk = '     &' . $chunk;
                        $chunk = '      '
                          . $chunk;   # WARNING: free form but with 6 spaces ...
                    }
                }
                push @split_lines, $chunk;
            }
        } else {
            @split_lines = @chunks;
        }
        if (   $split_lines[0] !~ /^\!/
            && $split_lines[0] =~ /\t/
            && $split_lines[0] !~ /^\s{6}/
            && $split_lines[0] !~ /^\t/ )
        {

            # problematic tab!
            print "WARNING: Pathological TAB in " . $split_lines[0] . "\n"
              if $W;
            my $sixspaces = ' ' x 6;
            $split_lines[0] =~ s/^\ +\t//;
            if ( length( $split_lines[0] ) > 66 ) {
                $split_lines[0] =~ s/^\s+//;
                $split_lines[0] =~ s/\s+$//;
            }
            if ( length( $split_lines[0] ) > 66 ) {
                print "WARNING: Line still too long: " . $split_lines[0] . "\n"
                  if $W;
            }
            $split_lines[0] = $sixspaces . $split_lines[0]
              unless $split_lines[0] =~ /^\s+\d+/;
        }

        my @fin_lines = ();
        for my $chunk (@split_lines) {
            if ( $chunk =~ /^\s*\&\s*$/ ) {
                $chunk = '';
            } elsif ( $chunk =~ /\n\s*\&\s*$/m ) {
                $chunk =~ s/\n.*$//m;
            }
            push @fin_lines, $chunk;
        }
        if ( $fin_lines[-1] =~ /\&\s*$/ ) {
            $fin_lines[-1] =~ s/\s*\&\s*$//;
        } elsif ( @fin_lines > 1
            && $fin_lines[-1] =~ /^\s*$/
            && $fin_lines[-2] =~ /\&\s*$/ )
        {
            $fin_lines[-2] =~ s/\&\s*$//;
        }
        return @fin_lines;
    }
}    # END of split_long_line()

# -----------------------------------------------------------------------------
sub get_annotated_sourcelines {
    ( my $stref, my $f ) = @_;
        my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
#die Dumper $stref->{Subroutines}{'global'}{Source};

    my $annlines = [];
#	croak "$sub_or_func_or_inc $f:".Dumper ($Sf) if not exists $Sf->{Status};
if (exists  $Sf->{'Status'} ) {
    if ($Sf->{'Status'} == $PARSED ) {
        if ( not exists $Sf->{'RefactoredCode'} ) {
            $Sf->{'RefactoredCode'} = [];
            if ( defined $Sf->{'AnnLines'} ) {
                $annlines = [ @{ $Sf->{'AnnLines'} } ];    # We want a copy!
            } else {
                die 'get_annotated_sourcelines: no AnnLines for ' . $f;
            }
        } else {        	
            $annlines = $Sf->{'RefactoredCode'};           # Here a ref is OK
        }
    } else {    	
        print "WARNING: get_annotated_sourcelines($f) STATUS: "
          . show_status( $Sf->{'Status'} ). shortmess()
          if $DBG;
        if ( $Sf->{'Status'} > $INVENTORIED )
        {    # Means it was READ, and INVENTORIED but not PARSED
            print ", NOT PARSED\n" if $DBG;
        } else {
            print "\n" if $DBG;
        }
    }
} else {
	warn  "$sub_or_func_or_inc $f has no Status";
}
    return $annlines;
}    # END of get_annotated_sourcelines()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
sub get_f95_var_decl {	
    (my $stref, my $f, my $var) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
	my $Sf= $stref->{$sub_or_func_or_inc}{$f};    
    my $spaces = '      ';
    my $intent = 'Unknown';
    my $dim  = [];
    my $attr   = '';
    my $type   = 'Unknown';
    my $nvar   = $var;
    
    my $subset = in_nested_set($Sf, 'Vars', $var); # Should tell us exactly where we are

    if ($subset ne '' and exists $Sf->{$subset}{'Set'}{$var} and ref($Sf->{$subset}{'Set'}{$var}) eq 'HASH') {
    		my $Sv = $Sf->{ $subset }{'Set'}{$var};
        	if ( exists $Sf->{'ConflictingLiftedVars'}{$var} ) {
            	$nvar = $Sf->{'ConflictingLiftedVars'}{$var};
            	say "WARNING: CONFLICT for VAR $var in $subset, setting var name to $nvar in format_f95_var_decl()!" if $WW;
				croak Dumper($Sv) if $DBG;
        	}
	        $spaces =$Sv->{'Indent'};
	        $spaces =~ s/\S.*$//;
	        $dim = $Sv->{'Dim'};
	        $type  = $Sv->{'Type'};
	        $attr  = $Sv->{'Attr'};
	        $intent = $Sv->{'IODir'};                 
    } elsif ( defined $f and defined $stref and defined $var ) {        
        ( $type, my $kind, $attr ) = type_via_implicits( $stref, $f, $var );
    } else {
        croak
"Can't type $var, not in Vars and format_f95_var_decl() called the wrong way for implicits" if $DBG;
    }

    return {
        'Indent' => $spaces,
        'Type' => $type,
        'Attr' => $attr,
        'Dim' => $dim,
        'IODir' => $intent,
        'Names' => [$nvar],
        'Name' => $nvar,
        'Status' => 1
    };

}    # get_f95_var_decl()

# -----------------------------------------------------------------------------


sub format_f95_par_decl {
    ( my $stref, my $f, my $var_rec ) = @_;
    
    if ( ref($var_rec) eq 'HASH' && $var_rec->{'Status'} == 1 ) {
        return $var_rec;
    }
    my $var = do {
        if ( ref($var_rec) eq 'HASH' && $var_rec->{'Status'} == 0 ) {
            $var_rec->{'Name'};
        } else {
            $var_rec;
        }
    };

    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
    my $par_rec = get_var_record_from_set( $Sf->{'Parameters'},$var);
    
    my $val = $par_rec->{'Val'};

	my $type = defined $par_rec->{'Type'} ? $par_rec->{'Type'} : 'Unknown'; 
	my $attr = defined $par_rec->{'Attr'} ? $par_rec->{'Attr'} :  '';
    my $spaces = ' ' x 6;
	my $dim = [];

	if (not defined $par_rec->{'Type'} or $par_rec->{'Type'} eq 'Unknown') {
		
		my $Sv = get_var_record_from_set($Sf->{'LocalVars'},$var);

		if (not defined $Sv) {

        say "WARNING: PARAMETER $var is probably local to $f in format_f95_par_decl(). If $f is a parameter include file, that is OK." if $W;
			
		} else {
			$spaces = $Sv->{'Indent'};
			$dim=$Sv->{'Dim'};
			if (
		 		not defined $Sv->{'Type'} or $Sv->{'Type'} eq 'Unknown'
			) {
				say "WARNINGL: IMPLICIT TYPING OF PARAM $var from $f" if $W;
				($type, my $array_or_scalar, $attr) =type_via_implicits( $stref, $f, $var);
			} else {	
				$type = $Sv->{'Type'};
			}
		}
	}    
#       # Can't trust the type set via implicits! WEAK!
       if ($val=~/^[\+\-\*\d]+$/) {
       	$type = 'integer';
       } elsif ($val=~/^[\.\+\-\*\/\d]+$/) {
       	$type = 'real';
       	} elsif ($val=~/^[\'\"]/) {
       		my $len = length($val) -2;
       		$type = 'character';
       		$attr="(len=$len)";
       	} elsif ($val=~/^__PH\d+__/) {       		
       		$type = 'character';
       		$attr='len=*';
       	}	
#       } else {
#       	#FIXME
#       	# This is an expression, so we should parse it and get the type from the constituents.
##       	$type = 'real'; 
#       }
    
    # Here we should rename for globals? Maybe not: let's just rename the globals instead
#    ( $var, $val ) = _rename_conflicting_global_pars( $stref, $f, $var, $val );
    

    # FIXME: for multiple vars, we need to split this in multiple statements.
    # So I guess as soon as the Dim is not empty, need to split.
    my $shape = $dim;    
    my $dimrec = [];
    if ( @{$shape} ) {
        $dimrec = $shape; #', dimension(' . join( ',', @dims ) . ') ';
    }

    my $final_par_rec=
     {
        'Indent' => $spaces,
        'Type' => $type, 
        'Attr' => $attr, 
        'Dim' => $dimrec, 
        'Parameter' => 'parameter',
        'Name' => [ $var, $val ] ,        
        'Status' => 1
    };
    
     carp "FINAL PAR REC $f:".Dumper($final_par_rec) if $DBG and $type eq 'Unknown';
#     if ($type eq 'Unknown') {
#     	$final_par_rec->{'Type'} = 'real';
#     } 

    return $final_par_rec; 
}    # format_f95_par_decl()


# -----------------------------------------------------------------------------

sub get_f95_par_decl {
    ( my $stref, my $f, my $var ) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
    my $Sv = get_var_record_from_set($Sf->{'Parameters'},$var);
        
    if ( not defined $Sv ) {
        print
"WARNING: PARAMETER $var is probably local to $f in format_f95_par_decl(). If $f is a parameter include file, that is OK.\n"
          if $W;
          my $rec_from_f=get_var
        $Sv->{'Type'}   = 'Unknown';#$Sf->{'Parameters'}{'Set'}{$var}{'Type'};
        $Sv->{'Indent'} = ' ' x 6;
        $Sv->{'Dim'}  = [];
        $Sv->{'Attr'}   = '';
    }
    my $spaces = $Sv->{'Indent'};
    my $dim = $Sv->{'Dim'};
	my $val = $Sv->{'Val'};
    return {
        'Indent' => $spaces,
        'Type' => $Sv->{'Type'}, 
        'Attr' => $Sv->{'Attr'}, 
        'Dim' => $dim, 
        'Parameter' => 'parameter',
        'Name' => [ $var, $val ] ,
        'Var' => $var, 
        'Val' => $val,
        'Status' => 1
    };    
}    # get_f95_par_decl()
# -----------------------------------------------------------------------------

sub _rename_conflicting_global_pars {
    ( my $stref, my $f, my $k, my $rhs_expr ) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
    my @rhs_vals = grep { /[a-z]\w*/ } split( /\W+/, $rhs_expr );
    my @n_rhs_vals = @rhs_vals;
    if (@rhs_vals) {
        my $i = 0;
        for my $rhs_val (@rhs_vals) {
            $n_rhs_vals[$i] = $rhs_val;
            if ( exists $Sf->{'ConflictingGlobals'}{$rhs_val} ) {
                $n_rhs_vals[$i] = $Sf->{'ConflictingGlobals'}{$rhs_val}[0];
            } else {
                for my $inc ( keys %{ $Sf->{'Includes'} } ) {
                    if (
                        exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val} )
                    {
                        $n_rhs_vals[$i] =
                          $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val}[0];
                        last;
                    }
                }
            }
            $i++;
        }
    }
    for my $v (@rhs_vals) { 
        my $nv = shift @n_rhs_vals;
        if ( $nv ne $v ) {            
            $rhs_expr =~ s/\b$v\b/$nv/g;
        }
    }
    my $nk = $k;
    if ( exists $Sf->{'ConflictingGlobals'}{$k} ) {
        $nk = $Sf->{'ConflictingGlobals'}{$k}[0];
    } else {
        for my $inc ( keys %{ $Sf->{'Includes'} } ) {

            #                   print "INC: $inc\n";
            if (
                exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
                {$k} )
            {
                $nk = $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$k}[0];
                last;
            }
        }
    }
    return ( $nk, $rhs_expr );
} # _rename_conflicting_global_pars() 

sub emit_f95_var_decl {
    ( my $var_decl_rec ) = @_;
	if (not defined $var_decl_rec) {
		confess('Argument to emit_f95_var_decl is not defined!')  if $DBG;
	}
    if ( ref($var_decl_rec) ne 'HASH' ) {
        croak "NOT a HASH in emit_f95_var_decl(".$var_decl_rec.")"  if $DBG;
    }
    my $external = exists $var_decl_rec->{'External'} ? 1 : 0;
    my $spaces = $var_decl_rec->{'Indent'};
    croak Dumper($var_decl_rec) if $DBG and not defined $spaces;
    
      my $type = $var_decl_rec->{'Type'}; 
      if (not defined $type) {
      	croak Dumper($var_decl_rec) if $DBG;
        #    Dumper($stref->{'Subroutines'}{  $var_decl_rec->{'Name'});
      } elsif(ref($type) eq 'HASH') {
      	# Contains Type and Kind
      	my $ttype=$type->{'Type'};
      	my $tkind=$type->{'Kind'};
      	$type= $ttype . (defined $tkind ?  "($tkind)" : '');       	
      } 
      my $attr= $var_decl_rec->{'Attr'}; 
      my $dim= $var_decl_rec->{'Dim'}; 
      
      my $is_par = exists $var_decl_rec->{'Parameter'} ? 1 : 0;
      # We seem to have three ways of encoding the (var,val) pairs
      my ($var,$val);
      if ($is_par) {
      if (exists $var_decl_rec->{'Name'}) {
      	if (ref(  $var_decl_rec->{'Name'} ) eq 'ARRAY'  and scalar @{ $var_decl_rec->{'Name'} } == 2 ) {
      	    ($var,$val) = @{	$var_decl_rec->{'Name'} };
      	} elsif (ref(  $var_decl_rec->{'Name'} ) ne 'ARRAY'  and exists $var_decl_rec->{'Val'} ) { 
            $var = $var_decl_rec->{'Name'};
            $val = $var_decl_rec->{'Val'};
      	}
      }
      elsif (exists $var_decl_rec->{'Var'}) {
      	if (ref(  $var_decl_rec->{'Var'} ) eq 'ARRAY'  and scalar @{ $var_decl_rec->{'Var'} } == 2 ) {
      	    ($var,$val) = @{	$var_decl_rec->{'Var'} };
              croak 'SHOULD NEVER HAPPEN!' if $DBG;
      	} elsif (ref(  $var_decl_rec->{'Var'} ) ne 'ARRAY'  and exists $var_decl_rec->{'Val'} ) { 
            $var = $var_decl_rec->{'Var'};
            $val = $var_decl_rec->{'Val'};
      	}          
      } elsif(exists $var_decl_rec->{'Names'}) {
      	if (scalar @{ $var_decl_rec->{'Names'} } == 1 and ref($var_decl_rec->{'Names'}[0]) eq 'ARRAY') {
      		($var,$val) = @{ $var_decl_rec->{'Names'}[0] };
      	} else {
      		croak 'Parameter declaration record is incorrect: '.Dumper($var_decl_rec) if $DBG;
      	}
      	
      }
      } else {
      	$var = $var_decl_rec->{'Name'};
      }
      
    my $dimstr = '';
    if ( ref($dim) eq 'ARRAY' and scalar @{$dim}>0) {
        my @dimpairs = map { $_->[0].':'.$_->[1] } @{ $dim };
        $dimstr = 'dimension(' . join( ',', @dimpairs) . ')';
    }
    my @attrs = ();
    if ($attr) {    	
    	if ( $type eq 'character') {
    	if ($attr=~/len/) {
    		$type.='('.$attr.')';
        } else {
                if ($attr=~/\((.+)\)/) {
                    $attr=$1;
                }
    		$type.='(len='.$attr.')';
        }
    		$attr='';
    	} elsif ($attr=~/kind/ ) {
            if ($attr=~/kind=\d+/ ) {
                $type=~s/\*\d+$//;
                if ($attr!~/\(.+\)/) {
                    $type.='('.$attr.')';$attr='';
                }
            } else {
                $attr='';
            }
    	} else {
            push @attrs, $attr;
    	}
    }
    if (exists $var_decl_rec->{'Allocatable'} ) {
    	push @attrs, 'allocatable';
    }
    if ($dimstr) {
        push @attrs, $dimstr;
    }

    if ( not $is_par ) {
        # Variable
        my $intent    =  $var_decl_rec->{'IODir'};
        
        if (not defined $intent or $intent eq '') {
#        	carp 'Intent not defined for '.Dumper($var_decl_rec) if $W;
        	say 'WARNING: Intent not known for declaration of '.$var if $WWW;#.' '.$var_decl_rec->{'Ann'} if $W;
        	$intent='Unknown'; 
        }
        if (ref($intent) eq 'ARRAY' and scalar @{$intent}==0) {
        	say "INFO: Intent is [] for $var, setting to Unknown" if $I;
        	$intent = 'Unknown';
        }
        my $trailing_comment='';
        my $intentstr = '';
        
        if ( $intent ne 'Unknown' and $intent ne 'Ignore' ) {
        	$intentstr ='intent('.$intent.')'; 
		} 
		elsif ($intent eq 'Ignore' and $DBG) {			
			$trailing_comment=" ! Intent $intent"; 
		}
		
        if (not $external) {
	        if ($intentstr) {
    	        push @attrs, $intentstr;
        	} 
        } else {
        	    push @attrs, 'external';
        }
        
        if ( @attrs && $attrs[0] =~ /^\s*\(/ ) {
            my $decl_line =
                $spaces 
              . $type
              . join( ', ', @attrs ) . ' :: '
              . $var
              . $trailing_comment;
            return $decl_line;
        } else {
        	
            my $decl_line =
                $spaces
              . join( ', ', ( $type, @attrs ) ) . ' :: '
              . $var
              . $trailing_comment;
              #say 'emit_f95_var_decl 2'.$decl_line ;
            return $decl_line;
        }
        
    } else {
        # Parameter        
#        say Dumper($var_decl_rec);
        croak Dumper($var_decl_rec) if $DBG and not defined $val;
        my $var_val = ref($var) eq 'ARRAY' ? $var->[0] . '=' . $var->[1] :  $var.'='.$val;
        my $decl_line =
            $spaces 
          . $type  
          . $attr . ', ' 
          . $dimstr
          . 'parameter' . ' :: '
          . $var_val;

          #say 'emit_f95_var_decl PARAM: '.$decl_line ;
        
        return $decl_line;
    }
} # END of emit_f95_var_decl();

# -----------------------------------------------------------------------------
# This routine take $stref, $f, $insert_pos_lineID, $new_annlines, $insert_before, $skip_insert_pos_line
#- Go through the AnnLines
#- Find the hook based onthe lineID
#- splice the new lines after the hook.

sub splice_additional_lines {
    (
        my $stref, my $f,
        my $insert_pos_lineID,
        my $new_annlines,
        my $insert_before,
        my $skip_insert_pos_line
    ) = @_;
    say "SPLICE @ $insert_pos_lineID for $f" if $V;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    my $nextLineID         = scalar @{$annlines} + 1;
    my $merged_annlines    = [];
    my $once               = 1
      ; # This is needed because some comment/deleted lines have duplicate LineIDs

    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};
        
        if ( $info->{'LineID'} == $insert_pos_lineID and $once ) {
            $once = 0;

            #            say "SPLICE POINT $line";
            if ( not $skip_insert_pos_line and not $insert_before ) {
                say $annline->[0] if $DBG;
                push @{$merged_annlines}, $annline;
            }
            for my $extra_annline ( @{$new_annlines} ) {
                ( my $nline, my $ninfo ) = @{$extra_annline};
                $ninfo->{'LineID'} = $nextLineID++;
                say $nline if $DBG;
                push @{$merged_annlines}, [ $nline, $ninfo ];
            }
            if ( not $skip_insert_pos_line and $insert_before ) {
                say $annline->[0] if $DBG;
                push @{$merged_annlines}, $annline;
            }

        } else {
            say $annline->[0] if $DBG;
            push @{$merged_annlines}, $annline;
        }
    }
    
    return $merged_annlines;

}    # END of splice_additional_lines()

# Usage: 
# $merged_annlines = splice_additional_lines_cond( $stref, $f, $insert_cond_subref, $old_annlines, $new_annlines, $insert_before, $skip_insert_pos_line, $once )
#- Go through the AnnLines
#- Find the hook based on a condition on the $annline (i.e. $insert_cond_subref->($annline) )
#- splice the new lines before/after the hook depending on $insert_before
#- if $once is 0, do this whenever the condition is met. Otherwise do it once
# NOTE that get_annotated_sourcelines will preferentially use RefactoredCode rather than AnnLines 
# If this is unwanted, pass in $old_annlines explicitly
sub splice_additional_lines_cond {
    (
        my $stref, 
        my $f,
        my $insert_cond_subref,
        my $old_annlines,
        my $new_annlines,
        my $insert_before,
        my $skip_insert_pos_line,
        my $do_once
    ) = @_;
    say "SPLICE on condition for $f" if $V;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    
    my $annlines           = scalar @{$old_annlines} ? $old_annlines : get_annotated_sourcelines( $stref, $f );
    croak if $DBG and scalar @{$annlines}==0;
    my $nextLineID         = scalar @{$annlines} + 1;
    my $merged_annlines    = [];
    $do_once = defined $do_once ? $do_once : 1;
    my $once=1;      

    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};
#        say Dumper($info);
        if ( $insert_cond_subref->($annline) and $once ) {
            $once = 0 unless $do_once==0;
            if (not $insert_before ) {
            	say $annline->[0] if $DBG; 
                if ( not $skip_insert_pos_line ) {                
                    push @{$merged_annlines}, $annline;
                } else {
            	   # Skip; but I comment out instead if $DBG is on
            	   $info->{'Skip'}=1;
            	   if ($DBG) {
            	   	 $info->{'Comments'}=1;
            		 push @{$merged_annlines}, ['! SKIP ! '.$line, $info];
            	   }
                }
            }
            for my $extra_annline ( @{$new_annlines} ) {
                ( my $nline, my $ninfo ) = @{$extra_annline};
                $ninfo->{'LineID'} = $nextLineID++;
                say $nline if $DBG;
                push @{$merged_annlines}, [ $nline, $ninfo ];
            }            
            if ($insert_before ) {
                say $annline->[0] if $DBG;
                if ( not $skip_insert_pos_line ) {                
                    push @{$merged_annlines}, $annline;
                } else {
                   # Skip; but I comment out instead if $DBG is on
                   $info->{'Skip'}=1;
                   if ($DBG) {
                     $info->{'Comments'}=1;
                     push @{$merged_annlines}, ['! '.$line, $info];
                   }
                }
            }
        } else {
            say $annline->[0] if $DBG;
            push @{$merged_annlines}, $annline;
        }
    }
    
    return $merged_annlines;

}    # END of splice_additional_lines_cond()

# The passes below go through all lines of code that are not marked as Deleted
# TODO: add some control over this
sub stateless_pass {
    (my $stref, my $f, my $pass_actions, my $pass_info) = @_;
    say "STATELESS PASS ".Dumper($pass_info)." for $f" if $DBG;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {    
    	if (not exists $annline->[1]{'Deleted'}) {
	        my $pass_annlines = $pass_actions->($annline); # returns an ARRAY ref
	        for my $new_annline (@{ $pass_annlines }) { 
	        	push @{$new_annlines}, $new_annline;
	        }
    	} else {
    		push @{$new_annlines}, $annline;
    	}
    }
    $Sf->{'RefactoredCode'} = $new_annlines;
    return $stref;
} # END of stateless_pass() 

# original  annlines are taken from $Sf->{'AnnLines'} or $Sf->{'RefactoredCode'} 
# updated annlines are stored in $Sf->{'RefactoredCode'} 
sub stateful_pass { my ( $stref, $f, $pass_actions, $state, $pass_info ) = @_;
    # return ($stref,$state);
#    local $Data::Dumper::Indent =0;
#    local $Data::Dumper::Terse=1;
    say "STATEFUL PASS ".Dumper($pass_info)." for $f" if $DBG; 
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
     
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};    
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    
    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {    	
    	if (not exists $annline->[1]{'Deleted'}) {    	
	        (my $pass_annlines, $state) = $pass_actions->($annline, $state);
    	    for my $new_annline (@{ $pass_annlines }) { 
        		push @{$new_annlines}, $new_annline;
        	}
    	} else {
    		push @{$new_annlines}, $annline;
    	}        	
    }
    $Sf->{'RefactoredCode'} = $new_annlines;
    
    return ($stref,$state);
} # END of stateful_pass()

sub stateful_pass_reverse {
    (my $stref, my $f, my $pass_actions, my $state, my $pass_info ) = @_;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
     
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};    
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    
    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( reverse @{$annlines} ) {
#    	if (ref(    	$annline->[1] ) ne 'HASH') {croak 'ANNLINE: '. Dumper($annline);}
    	if (not exists $annline->[1]{'Deleted'}) {    	
	        (my $pass_annlines, $state) = $pass_actions->($annline, $state);
    	    for my $new_annline (@{ $pass_annlines }) { 
        		push @{$new_annlines}, $new_annline;
        	}
    	} else {
    		push @{$new_annlines}, $annline;
    	}        	        	
    }
    $new_annlines =[ reverse @{ $new_annlines  } ]; 
    $Sf->{'RefactoredCode'} = $new_annlines;
    
    return ($stref,$state);
} # END of stateful_pass()


sub _emit_f95_parsed_var_decl { (my $pvd) =@_;
    my $type= $pvd->{'TypeTup'}{'Type'} . (exists $pvd->{'TypeTup'}{'Kind'} ?  '( '.$pvd->{'TypeTup'}{'Kind'}.')' : '');
    
         my  @attrs=($type); 
         if (exists $pvd->{'Attributes'}{'Allocatable'}) {
            push @attrs, 'allocatable';
        }
        if (exists $pvd->{'Attributes'}{'Dim'} ) {
        	# croak Dumper($pvd);
            push @attrs,'dimension('.join(', ',@{ $pvd->{'Attributes'}{'Dim'} }).')';
        }
        if (exists $pvd->{'Attributes'}{'Intent'} ) {
            push @attrs,'intent('. $pvd->{'Attributes'}{'Intent'} .')' ;
        }
          my $vars = join(', ',@{  $pvd->{'Vars'} });
       my $line = join(', ', @attrs).' :: '.$vars;    
    return $line;
}

sub top_src_is_module {( my $stref, my $s) = @_;
    my $sub_func_incl = sub_func_incl_mod( $s, $stref ); 
    if ($sub_func_incl eq 'Modules') { return 1};
	my $is_incl = exists $stref->{'IncludeFiles'}{$s} ? 1 : 0;
    my $f = $is_incl ? $s : $stref->{$sub_func_incl}{$s}{'Source'};
    if ( defined $f ) {    	        
		for my $item ( @{ $stref->{'SourceContains'}{$f}{'List'} } ) {
			# If $s is a subroutine, it could be that the source file is a Module, and then we should set that as the entry source type            
			if ($stref->{'SourceContains'}{$f}{'Set'}{$item} eq 'Modules') {
				my @subs_in_mod= @{ $stref->{'Modules'}{$item}{'Contains'} };
				if (grep {$_ eq $s} @subs_in_mod) {
					return 1;
				}
			}		                
		}
    }	
	return 0;        
}

# This is a wrapper to get the subroutines out of a module and then call other passes on these subroutines
# It does this for all sources but in practice it assumes a single source, so it might be better to pass this source name in as an arg instead 
sub pass_wrapper_subs_in_module { (my $stref,my $module_name, my $module_pass_sequences, my $sub_pass_sequences, my @rest) = @_;
	if ($module_name eq '') {
        
		my %is_existing_module = ();
	    my %existing_module_name = ();
		
		for my $src (keys %{ $stref->{'SourceContains'} } ) {		
			
			if (exists $stref->{'SourceContains'}{$src}{'Path'}
			and  exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'} ) {	
			  # External, SKIP! 
				say "SKIPPING $src";			
			} else {		
	    		# Get the unit name from the list	    		
			    for my $sub_or_func_or_mod ( @{  $stref->{'SourceContains'}{$src}{'List'}   } ) {
			    	# Get its type
			        my $sub_func_type= $stref->{'SourceContains'}{$src}{'Set'}{$sub_or_func_or_mod};
			        if ($sub_func_type eq 'Modules') {
			        	$is_existing_module{$src}=1;
			        	$existing_module_name{$src} = $sub_or_func_or_mod;
			        }		
			    }
			}
			my $has_contains = ( $is_existing_module{$src} and exists $stref->{'Modules'}{$existing_module_name{$src}}{'Contains'}  ) ? 1 : 0;
	
			my @subs= $is_existing_module{$src}  ? $has_contains ? @{ $stref->{'Modules'}{$existing_module_name{$src}}{'Contains'} } : ()  :  grep {$_ ne 'UNKNOWN_SRC' } sort keys %{ $stref->{'Subroutines'} };
            # carp $src . Dumper @subs;
			for my $pass_sequence (@{$sub_pass_sequences}) {	
				for my $f ( @subs ) {
					for my $pass_sub_ref (@{$pass_sequence}) {			
						$stref=$pass_sub_ref->($stref, $f, @rest);
					}			
				}
			}
		}
	} else { 
        
		for my $pass_sequence (@{$module_pass_sequences}) {    	
                for my $pass_sub_ref (@{$pass_sequence}) {                	         
                    $stref=$pass_sub_ref->($stref, $module_name, @rest);
                }           
		}		
		
        my $has_contains = exists $stref->{'Modules'}{$module_name}{'Contains'}  ? 1 : 0;
        my @subs=  $has_contains ? @{ $stref->{'Modules'}{$module_name}{'Contains'} } : ()  ;
        for my $pass_sequence (@{$sub_pass_sequences}) {    
            for my $f ( @subs ) {
                for my $pass_sub_ref (@{$pass_sequence}) {          
                    $stref=$pass_sub_ref->($stref, $f, @rest);
                }           
            }
        }
	}
	return $stref;
}

# Emit a new source line based on the variable name in $info and the $decl record in RefactoredArgs
# I might have a flag here to say "use the name from the record"
sub update_arg_var_decl_sourcelines { (my $stref, my $f)=@_;
	my $pass_update_arg_var_decls = sub { (my $annline, my $state)=@_;	
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		if ( exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'}; # May need OrigName?
			if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$var} ) {
                my $decl = $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$var};
				# We store the var name from $decl in $pvar, then replace it temporarily with $var, in case a var had been renamed in $info (for example for scalarisation)
				# to emit the actual F95 code
				# Then we put $pvar back into the $decl, which will put it back into $stref
                my $pvar =$decl->{'Name'};
                $decl->{'Name'}=$var;
			    $line = emit_f95_var_decl($decl);                
                $decl->{'Name'}=$pvar;
			}
		}				
		return ([[$line,$info]],$state);
	};
	
	my $state=[$stref,$f];
 	($stref,$state) = stateful_pass($stref,$f,$pass_update_arg_var_decls, $state,'pass_update_arg_var_decls() ' . __LINE__  ) ;	
    return $stref;
} # END of update_arg_var_decl_sourcelines



1;
