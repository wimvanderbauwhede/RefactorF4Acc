package RefactorF4Acc::Refactoring::Common;
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
$Data::Dumper::Indent = 0;

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
sub context_free_refactorings {
    ( my $stref, my $f ) = @_;
    print "CONTEXT-FREE REFACTORINGS for $f CODE\n" if $V ;
    
    my $die_if_one         = ($f eq 'BOOM')? 1 : 0;
    my @extra_lines        = ();
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};
    if ( $Sf->{'Status'} != $PARSED ) {
        croak "NOT PARSED: $f\n" . caller() . "\n";
    }
    my $annlines   = get_annotated_sourcelines( $stref, $f );
    my $nextLineID = scalar @{$annlines} + 1;
    my $firstdecl  = 1;
    $Sf->{'RefactoredCode'} = [];
    my @include_use_stack = ();

#    my %params_declared_in_file = ();
#    for my $annline ( @{$annlines} ) {
#        ( my $line, my $info ) = @{$annline};
#        if ( exists $info->{'ParamDecl'} ) {
#            my $partup = $info->{'ParamDecl'}{'Name'}  ;
#                ( my $par, my $parval ) = @{$partup};
#                $params_declared_in_file{$par} = 1;
#            
#        }
#    }
    
    # FIXME: This is way too long and quite unclear
    for my $annline ( @{$annlines} ) {
        if ( not defined $annline or not defined $annline->[0] ) {
            croak
              "Undefined source code line for $f in create_refactored_source()";
        }
        ( my $line, my $info ) = @{$annline};
        
        if ( exists $info->{'Deleted'} and $line eq '' ) {
            next;
        }
        if ( exists $info->{'ImplicitNone'} ) {
            next;
        }

        if ( exists $info->{'Goto'} ) {
            $line =~ s/\bgo\sto\b/goto/;
            $info->{'Ref'}++;
        }

        # BeginDo: just remove the label
        if ( exists $info->{'BeginDo'} ) {
            $line =~ s/do\s+\d+\s+/do /;
            $info->{'Ref'}++;
        }

        # EndDo: replace label CONTINUE by END DO;
        # if no continue, remove label & add end do on next line
        if ( exists $info->{'EndDo'} and exists $info->{'EndDo'}{'Label'} ) {

            #warn "$f: END DO $line\n";
            my $is_goto_target = 0;
            if ( $Sf->{'Gotos'}{ $info->{'EndDo'}{'Label'} } ) {

                # this is an end do which serves as a goto target
                $is_goto_target = 1;
            }
            my $count = $info->{'EndDo'}{'Count'};
            if ( exists $info->{'Continue'} ) {
                if ( $is_goto_target == 0 ) {
                    $line = '      end do';
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
            $line .= '  !Break';
            $info->{'Ref'}++;

            # $line=~s/goto\s+(\d+)/call break($1)/;
        }
        if ( exists $info->{'PlaceHolders'} ) {

            for my $ph ( keys %{ $info->{'PlaceHolders'} } ) {
                my $str = $info->{'PlaceHolders'}->{$ph};
                $line =~ s/$ph/$str/;
            }
            $info->{'Ref'}++;
        }

# ------------------------------------------------------------------------------
# This section refactors variable and parameter declarations
# ------------------------------------------------------------------------------

        if ( exists $info->{'VarDecl'} ) {
            if (exists  $info->{'ParsedVarDecl'} ) {
                my $pvd = $info->{'ParsedVarDecl'}; 
                if (scalar @{ $info->{'ParsedVarDecl'}{'Vars'} } == 1) {
#                    die Dumper( $pvd).$line;
                } else {                    
                    $line = _emit_f95_parsed_var_decl($pvd);
                }
            } else { 
            my $var =  $info->{'VarDecl'}{'Name'};
            if ( exists( $Sf->{'Parameters'}{'Set'}{ $var } ) ) {
                # Remove this line, because this param should have been declared above
                $line = '!! Original line PAR:2 !! ' . $line;
                $info->{'Deleted'} = 1;
            } elsif (not exists $info->{'Ref'} or $info->{'Ref'} == 0 ){
#                say Dumper($info);
                # Not refactored  
                my $var_decl =  $info->{'VarDecl'};
#                  format_f95_var_decl( $stref, $f, $var );                  
#                $info->{'VarDecl'} = $var_decl;
                $line = emit_f95_var_decl($var_decl) ;
                delete $info->{'ExGlobArgDecls'};
                $info->{'Ref'} = 1; 
                $info->{'Ann'} .= 'context_free_refactoring '. __LINE__ ."; ";
                $line .= "  !".$info->{'Ann'};
            } else {
                die 'BOOM! ' . 'context_free_refactoring '. __LINE__ ."; ";
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
                $line =~ s/\.(and|not|or|neqv|eqv)\s+\./ .$1. /;
            }
            while ( $line =~ /\.\s*(?:eq|ne|gt|lt|le|ge)\s*\./ ) {
                $line =~ s/\.\s*(eq|ne|gt|lt|le|ge)\s*\./ $f95ops{$1} /;
            }

 # FIXME: it is possible that there is a conflict in the conditional expression!
#            $line = _rename_conflicting_vars( $line, $stref, $f );
            $info->{'Ref'}++;
        } elsif ( exists $info->{'Assignment'} or exists $info->{'Do'} ) {

            # Assignment
            my $kv     = $line;
            my $spaces = $line;
            $spaces =~ s/\S.*$//;
            $kv     =~ s/^\s+//;
            $kv     =~ s/\s+$//;
            if ( exists $info->{'Do'} ) {
                $kv =~ s/do\s+//;
            }
            ( my $k, my $rhs_expr ) = split( /\s*=\s*/, $kv );

#            $rhs_expr = _rename_conflicting_vars( $rhs_expr, $stref, $f );

            if ( exists $info->{'Do'} ) {
                my $nk = $k;#_rename_conflicting_lhs_var( $k, $stref, $f );
                $line = $spaces . 'do ' . $nk . ' = ' . $rhs_expr;
            } else {
                my $nk = $k;#_rename_conflicting_vars( $k, $stref, $f );
                $line = $spaces . $nk . ' = ' . $rhs_expr;
            }
            $info->{'Ref'}++;
        }    # assignment

# ------------------------------------------------------------------------------
# This section refactors parameter declarations, this is what generates the parameters in LES params_common
# Problem is that in flexpart, these parameters have already been declared before the variable declarations
# ------------------------------------------------------------------------------
        elsif ( exists $info->{'ParamDecl'} )
        {    # so this is a parameter declaration "pur sang"
                # WV 20130709: why should I remove this?
#                croak Dumper($info) . __LINE__;                
#            my @par_lines = ();
#say Dumper($annline);
                my $par_decls= [ $info->{'ParamDecl'} ];
                
                 my $info_ref = $info->{'Ref'} // 0;
                if ($info->{'ParamDecl'}{'Status'} == 0 ) {
                    if (exists $info->{'ParamDecl'}{'Name'} ) {

                           
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
                } 
                for my $par_decl (@{ $par_decls }) {
                my $new_line =
                  emit_f95_var_decl($par_decl) . ' ! context-free ParamDecl';
                # Here the declaration is complete
                push @extra_lines,
                  [
                    $new_line,
                    {
                        'Extra'     => 1,
                        'ParamDecl' => $par_decl,
                        'Ref'       => $info_ref + 1,
                        'LineID'    => $nextLineID++                        
                    }
                  ]
                  ; # Create parameter declarations before variable declarations            
            $line = '!! Original line context-free ParamDecl !! ' . $line;
            $info->{'Deleted'} = 1;
                }
        }

# ------------------------------------------------------------------------------
# END of section refactoring parameter declarations
# ------------------------------------------------------------------------------
# Subroutine call
        elsif ( exists $info->{'SubroutineCall'} ) {
#            $line = _rename_conflicting_vars( $line, $stref, $f );
            $info->{'Ref'}++;
        } elsif ( exists $info->{'Include'} ) { 
        	
            my $inc  = $info->{'Include'}{'Name'};
            my $tinc = $inc;
            $tinc =~ s/\./_/g;
            if ( $stref->{IncludeFiles}{$inc}{InclType} ne 'External' ) {
                $line =
                  "      use $tinc ! context_free_refactorings() line " . __LINE__;
            } else {
                $line =
                  "      include '$inc' ! context_free_refactorings() line " . __LINE__;
            }
            $info->{'Ref'}++;

            # use must come right after subroutine/function/program
            # or after another use
            # or after the module declaration
            $info->{'LineID'} = $nextLineID++;
            push @include_use_stack, [ $line, $info ];    # if $line ne '';
            next;
        }
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
    for my $annline ( @{$Sf->{'RefactoredCode'}} ) {
        if ( not defined $annline or not defined $annline->[0] ) {
            croak
              "Undefined source code line for $f in create_refactored_source()";
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
        if (exists $info->{'VarDecl'}) {
            $info->{'ExGlobVarDeclHook'}='VarDecl';
            $Sf->{'ExGlobVarDeclHook'}=1;
            $has_vardecl=1;
            last;
        }        
    }    
    
    if ($has_vardecl==0) {
        my $parlinecount=$has_pars;
        my $incllinecount=$has_includes;
        for my $annline ( @{$Sf->{'RefactoredCode'}} ) {
            if ( not defined $annline or not defined $annline->[0] ) {
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
    }
    
    if ($die_if_one) { die Dumper( $Sf->{'RefactoredCode'} ); }
    return $stref;
}    # END of context_free_refactorings()

# -----------------------------------------------------------------------------
# This routine essentially discards unused lines and splits long lines
# I think this could actually be part of the emitter
sub create_refactored_source {
    ( my $stref, my $annlines, ) = @_;
    my $refactored_lines = [];
    for my $annline ( @{$annlines} ) {

        if ( not defined $annline or not defined $annline->[0] ) {
            croak "Undefined source code line in create_refactored_source()";
        }
        my $line = $annline->[0];
        my $info = $annline->[1];

        if ( not exists $info->{'Comments'}
            and ( exists $info->{'InBlock'} or not exists $info->{'Deleted'} ) )
        {
            print $line, "\n" if $V;
            if ( $line =~ /;/ && $line !~ /[\'\"]/ ) {
                my $spaces = $line;
                $spaces =~ s/\S.*$//;
                $line   =~ s/^\s+//;
                my @split_lines = split( /\s*;\s*/, $line );
                for my $sline (@split_lines) {
                    push @{$refactored_lines}, [ $spaces . $sline, $info ];
                }
            } else {
                $line =~ s/\s+\!\!.*$//
                  ; # FIXME: ad-hoc to remove comments from context-free refactoring

                my @split_lines = split_long_line($line);
                for my $sline (@split_lines) {
                    push @{$refactored_lines}, [ $sline, $info ];
                }
            }
        } else {
            push @{$refactored_lines}, [ $line, $info ];
        }
    }
    return $refactored_lines;
}    # END of create_refactored_source()

# -----------------------------------------------------------------------------
sub create_refactored_source_OLD {
    ( my $stref, my $f, ) = @_;
    print "CREATING FINAL $f CODE\n" if $V;
    die join( ' ; ', caller ) if $stref !~ /0x/;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    $Sf->{'RefactoredCode'} = [];
    for my $annline ( @{$annlines} ) {

        if ( not defined $annline or not defined $annline->[0] ) {
            croak
              "Undefined source code line for $f in create_refactored_source()";
        }
        my $line = $annline->[0];
        my $info = $annline->[1];

        if ( not exists $info->{'Comments'}
            and ( exists $info->{'InBlock'} or not exists $info->{'Deleted'} ) )
        {
            print $line, "\n" if $V;
            if ( $line =~ /;/ && $line !~ /[\'\"]/ ) {
                my $spaces = $line;
                $spaces =~ s/\S.*$//;
                $line   =~ s/^\s+//;
                my @split_lines = split( /\s*;\s*/, $line );
                for my $sline (@split_lines) {
                    push @{ $Sf->{'RefactoredCode'} },
                      [ $spaces . $sline, $info ];
                }
            } else {
                $line =~ s/\s+\!\!.*$//
                  ; # FIXME: ad-hoc to remove comments from context-free refactoring

                my @split_lines = split_long_line($line);
                for my $sline (@split_lines) {
                    push @{ $Sf->{'RefactoredCode'} }, [ $sline, $info ];
                }
            }
        } else {
            push @{ $Sf->{'RefactoredCode'} }, [ $line, $info ];
        }
    }
    return $stref;
}    # END of create_refactored_source_OLD()

# -----------------------------------------------------------------------------
# A convenience function to split long lines.
# - count the number of characters, i.e. length()
# - find the last comma before we exceed 64 characters (I guess it's really 72-5?):

sub split_long_line {
    my $line = shift;

    my @chunks = @_;

    my $nchars = 64 + 28;
    if ( scalar(@chunks) == 0 ) {
        print "\nLINE: \n$line\n" if $V;
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
            print "Split line on ", $ll - $idx, ", '$split_on'\n" if $V;
        } elsif ( $idx < 0 && $idx2 >= 0 ) {
            $idx = $idx2;
            print "Split line on ", $ll - $idx2, ", '$split_on2'\n"
              if $V;
        } elsif ( $idx < 0 && $idx2 < 0 && $idx3 >= 0 ) {
            $idx = $idx3;
            print "SPLIT line on ", $ll - $idx, ", '$split_on3'\n"
              if $V;

            # Need smarter split
            $smart = 1;
            $patt = join( '', reverse( split( '', $split_on3 ) ) );
        } elsif ( $idx < 0 && $idx2 < 0 && $idx4 >= 0 ) {
            $idx = $idx4;
            print "SPLIT line on ", $ll - $idx, ", '$split_on4'\n"
              if $V;

            # Need smarter split
            $smart = 1;
            $patt = join( '', reverse( split( '', $split_on4 ) ) );
        }

#       if ($smart==1) {
#           die substr( $line, 0, $ll - $idx3, '' ) if length(substr( $line, 0, $ll - $idx3, '' ))>$nchars;
#       }
        push @chunks, substr( $line, 0, $ll - $idx, '' );
        print "CHUNKS:\n", join( "\n", @chunks ), "\n" if $V;
        print "REST:\n", $line, "\n" if $V;
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

    my $annlines = [];

    if ( $Sf->{'Status'} == $PARSED ) {
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
          . show_status( $Sf->{'Status'} )
          if $W;
        if ( $Sf->{'Status'} > $INVENTORIED )
        {    # Means it was READ, and INVENTORIED but not PARSED
            print ", NOT PARSED\n" if $W;
        } else {
            print "\n" if $W;
        }
    }
    return $annlines;
}    # END of get_annotated_sourcelines()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
#sub _OBSOLETE_format_f95_var_decl {
#	# This sub can be called in different ways, I think it would be better to create different subs that call a common core
#    my $stref;
#    my $f;
#    my $Sf;
#    my $var;
#    my $vardecl;
#    my $var_or_vardecl;
#    if ( scalar(@_) == 3 ) {
#        # Sub is called with  $stref, $f, $var_or_vardecl 
#        ( $stref, $f, $var_or_vardecl ) = @_;
#        my $code_unit = sub_func_incl_mod( $f, $stref );
#        $Sf = $stref->{$code_unit}{$f};
#    } else {
#        # Sub is called with  $Sf, $var_or_vardecl 
#        ( $Sf, $var_or_vardecl ) = @_;
#    }
#    
#    if ( ref($var_or_vardecl) eq 'ARRAY') { 
#        if ( $var->[-1] == 1 ) {
#            return $var_or_vardecl; # This means it was a formatted vardecl 
#        } elsif ( ref($var_or_vardecl) eq 'ARRAY' && $var->[-1] == 0 ) {
#            # This means it is a vardecl but it is not yet formatted correctly. 
#            $var = $var_or_vardecl->[2][0];
#        }  else {
#            die 'format_f95_var_decl: invalid input '.Dumper($var_or_vardecl);
#        }
#    } else {
#        $var = $var_or_vardecl;
#    }
#    
#    my $spaces = '      ';
#    my $intent = [];
#    my $shape  = [];
#    my $attr   = '';
#    my $type   = 'Unknown';
#    my $nvar   = $var;
## --------------------------------------------------------------------------------------------------------------------------------    
#    # FIXME: we are using different data structures now!
#    
#    my $subset = in_nested_set($Sf, 'Vars', $var); # Should tell us exactly where we are
#    if ($subset ne '') {
#    my $Sv = $Sf->{ $subset }{'Set'}{$var};    
#    if ( exists $Sf->{$subset}{'Set'}{$var} ) {
##        if ( not exists $Sv->{'Decl'} ) {
##            say "WARNING: VAR $var does not have Decl in $subset in format_f95_var_decl()!" if $W;
##			croak Dumper($Sv);
##        }
#
#        if ( exists $Sf->{'ConflictingLiftedVars'}{$var} ) {
#            $nvar = $Sf->{'ConflictingLiftedVars'}{$var};
#            say "WARNING: CONFLICT for VAR $var in $subset, setting var name to $nvar in format_f95_var_decl()!" if $W;
#			croak Dumper($Sv);
#        }
#        $spaces =$Sv->{'Indent'};
#           #WV20150707 Decl is a record of 4 entries: [spaces, [type], [varname],formatted(0|1)]
#        $spaces =~ s/\S.*$//;
#        $shape = $Sv->{'Dim'};
#        $type  = $Sv->{'Type'};
#        $attr  = $Sv->{'Attr'};
#        $intent = $Sv->{'IODir'};                 
#
#    } elsif ( defined $f and defined $stref and defined $var ) {        
#        ( $type, my $kind, $attr ) = type_via_implicits( $stref, $f, $var );
#    } else {
#        croak
#"Can't type $var, not in Vars and format_f95_var_decl() called the wrong way for implicits";
#    }
#    
## --------------------------------------------------------------------------------------------------------------------------------    
#    if (not defined $shape) {croak($var) };
#    my $dim = [];
#    # FIXME: I think the case dimension(:) is not covered!
#    if ( @{$shape} >= 1) {
#        $dim=$shape;
#    } else {
#        $dim = [];
#    }
#
#    return {
#        'Indent' => $spaces,
#        'Type' => $type,
#        'Attr' => $attr,
#        'Dim' => $dim,
#        'IODir' => $intent,
#        'Names' => [$nvar],
#        'Name' => $nvar,
#        'Status' => 1
#    };
#
#}    # format_f95_var_decl()

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
    croak $subset if $subset=~/Glob/;
    if ($subset ne '' and exists $Sf->{$subset}{'Set'}{$var} and ref($Sf->{$subset}{'Set'}{$var}) eq 'HASH') {
    		my $Sv = $Sf->{ $subset }{'Set'}{$var};
        	if ( exists $Sf->{'ConflictingLiftedVars'}{$var} ) {
            	$nvar = $Sf->{'ConflictingLiftedVars'}{$var};
            	say "WARNING: CONFLICT for VAR $var in $subset, setting var name to $nvar in format_f95_var_decl()!" if $W;
				croak Dumper($Sv);
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
"Can't type $var, not in Vars and format_f95_var_decl() called the wrong way for implicits";
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


# ----------------------------------------------------------------------------------------------------

# This could work but it means the code has to be regenerated every time a parameter changes ...
sub UNUSED_resolve_params {
    ( my $Sf, my $val ) = @_;

    $val =~ s/\s*$//;
    $val =~ s/^\s+//;

    if ( $val =~ /\b[a-df-z_]\w*\b/ ) {
        print "CALL: $val\n";
        my @chunks = split( /\s*[\/\+\-\*]\s*/, $val );
        my @maybe_pars;
        for my $chunk (@chunks) {
            print "[$chunk]\n";
            if ( $chunk =~ /^[a-z_]\w*/ ) {
                if ( exists $Sf->{'Parameters'}{'Set'}{$chunk} ) {
                    push @maybe_pars, $chunk;
                } else {
                    croak "Can't find PARAM $chunk";
                }
            }
        }
        print "VAL:<$val>\n";
        if (@maybe_pars) {
            for my $par (@maybe_pars) {

                #				print "TEST PAR:{$par}\n";
                my $tval = $Sf->{'Parameters'}{'Set'}{$par}{'Val'};

                #				print 'PAR:', $par, ' VAL:', $tval, "\n";
                $val =~ s/\b$par\b/$tval/;

                #				print "AFTER SUB:<$val>\n";
            }

            #                    die;
            UNUSED_resolve_params( $Sf, $val );
        } else {
            return $val;
        }
    } else {
        return $val;
    }
}    # END of UNUSED_resolve_params()

# -----------------------------------------------------------------------------

sub format_f95_par_decl {
    ( my $stref, my $f, my $var_rec ) = @_;
    if ( ref($var_rec) eq 'HASH' && $var_rec->{'Status'} == 1 ) {
        return $var_rec;
    }
    my $var = do {
        if ( ref($var_rec) eq 'HAS' && $var_rec->{'Status'} == 0 ) {
            $var_rec->{'Name'};
        } else {

            #	    croak $var_rec;
            $var_rec;
        }
    };

    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};

    #    print "VAR:<".Dumper($var)."> ";
    my $val = $Sf->{'Parameters'}{'Set'}{$var}{'Val'};

    #	my $val_from_rec = 	$var_rec->[2][0][1];
    #	print "<$val><$val_from_rec>\n";die;
    my $Sv        = $Sf->{'Vars'}{$var};
    my $local_par = 0;
    if ( not defined $Sv ) {
        print
"WARNING: PARAMETER $var is probably local to $f in format_f95_par_decl(). If $f is a parameter include file, that is OK.\n"
          if $W;
        $local_par = 1;

        #		croak $var;
        $Sv->{'Type'}   = $Sf->{'Parameters'}{'Set'}{$var}{'Type'};
        $Sv->{'Indent'} = ' ' x 6;
        $Sv->{'Dim'}  = [];
        $Sv->{'Attr'}   = '';
    }

    # Here we should rename for globals? Maybe not: let's just rename the globals instead
#    ( $var, $val ) = _rename_conflicting_global_pars( $stref, $f, $var, $val );
    my $spaces = $Sv->{'Indent'};

    # FIXME: for multiple vars, we need to split this in multiple statements.
    # So I guess as soon as the Dim is not empty, need to split.
    my $shape = $Sv->{'Dim'};

    #	die Dumper($shape) if join( '', @{$shape} ) =~ /;/;
    my $dim    = '';
    my $dimrec = [];
    if ( @{$shape} ) {
#        my @dims = ();
#        for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
#            my $range =
#              ( $shape->[ 2 * $i ] eq '1' )
#              ? $shape->[ 2 * $i + 1 ]
#              : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
#            push @dims, $range;
#        }
        $dimrec = $shape; #', dimension(' . join( ',', @dims ) . ') ';
        #$dimrec = [ 'dimension', [@dims] ];
    }
#    if ($local_par) {
#        my $decl_line =
#            $spaces
#          . $Sv->{'Type'}
#          . $Sv->{'Attr'}
#          . $dim
#          . ', parameter ' . ' :: '
#          . $var . ' = '
#          . $val;
#        print "WARNING: LOCAL PAR: $decl_line\n" if $W;
#    }

    #	return $decl_line;
#    return [
#        $spaces,
#        [ $Sv->{'Type'}, $Sv->{'Attr'}, $dimrec, 'parameter' ],
#        [ [ $var, $val ] ], 1
#    ];
    
    return {
        'Indent' => $spaces,
        'Type' => $Sv->{'Type'}, 
        'Attr' => $Sv->{'Attr'}, 
        'Dim' => $dimrec, 
        'Parameter' => 'parameter',
        'Name' => [ $var, $val ] ,
        'Status' => 1
    };    
}    # format_f95_par_decl()


# -----------------------------------------------------------------------------

sub get_f95_par_decl {
    ( my $stref, my $f, my $var ) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
    my $Sv = $Sf->{'Parameters'}{'Set'}{$var};
        
    if ( not defined $Sv ) {
        print
"WARNING: PARAMETER $var is probably local to $f in format_f95_par_decl(). If $f is a parameter include file, that is OK.\n"
          if $W;
        $Sv->{'Type'}   = $Sf->{'Parameters'}{'Set'}{$var}{'Type'};
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
}

sub _rename_conflicting_vars {
    ( my $expr, my $stref, my $f ) = @_;
    croak ' I HOPE THIS NEVER HAPPENS! ' . __LINE__ ;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};

    # This splits an expression on non-word tokens
    my @vals     = grep { /[a-z]\w*/ } split( /\W+/, $expr );
    my @n_vals   = @vals;
    my $conflict = 0;
    if (@vals) {
        my $i = 0;
        for my $val (@vals) {
            $n_vals[$i] = $val;
            if (   $val eq 'if'
                || $val eq 'then'
                || $val eq 'else'
                || $val eq 'call' ) # WV20150723 I suppose this is weak, it should also include all predefined functions etc. But this is purely optimisation.
            {
                #skip
            } else {
                 # To decide on renaming, I should test if the include with commons containing the conflicting name is included in the current file.
                 
                if ( exists $Sf->{'ConflictingGlobals'}{$val} ) {
                    print "CONFLICT: $val in $expr ($f)\n" if $V;
                    $n_vals[$i] = $Sf->{'ConflictingGlobals'}{$val}[0];
                    $conflict = 1;
                } elsif ( exists $Sf->{'ConflictingLiftedVars'}{$val} ) {
                    warn "CONFLICT (LIFT) for $val: $f: $expr\n" if $V;
                    $n_vals[$i] = $Sf->{'ConflictingLiftedVars'}{$val}[0];
                    $conflict = 1;
                } else {
                    for my $inc ( keys %{ $Sf->{'Includes'} } ) {
                        if (
                            exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$val} )
                        {
                            print
"CONFLICT (INC): $val in <$expr> ($f), from $inc\n"
                              if $V;
                            $conflict = 1;
                            $n_vals[$i] =
                              $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$val}[0];
                            last;
                        }
                    }
                }
            }
            $i++;
        }
    }
    for my $v (@vals) {
        my $nv = shift @n_vals;
        if ( $nv ne $v ) {
            $expr =~ s/\b$v\b/$nv/;
        }
    }
    warn "EXPR: $expr\n"  if $conflict && $V;
    print "EXPR: $expr\n" if $conflict && $V;
    return $expr;
}    # END of _rename_conflicting_vars()

sub _rename_conflicting_lhs_var {
    ( my $expr, my $stref, my $f ) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};
    my $val                = $expr;

    if ( exists $Sf->{'ConflictingGlobals'}{$val} ) {
        warn "CONFLICT LHS : $val in $expr ($f)\n" if $V;
        return $Sf->{'ConflictingGlobals'}{$val}[0];
    } elsif ( exists $Sf->{'ConflictingLiftedVars'}{$val} ) {
        warn "CONFLICT LHS (LIFT) for $val: $f: $expr "
          . $Sf->{'ConflictingLiftedVars'}{$val}[0] . "\n"
          if $V;
        return $Sf->{'ConflictingLiftedVars'}{$val}[0];
    } else {
        for my $inc ( keys %{ $Sf->{'Includes'} } ) {
            if (
                exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
                {$val} )
            {
                warn "CONFLICT  LHS (INC): $val in <$expr> ($f), from $inc\n"
                  if $V;
                return $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
                  {$val}[0];
                last;
            }
        }
    }
    return $expr;
}    # END of _rename_conflicting_lhs_var()

sub emit_f95_var_decl {
    ( my $var_decl_rec ) = @_;

	if (not defined $var_decl_rec) {
		confess('Argument to emit_f95_var_decl is not defined!');
	}
    if ( ref($var_decl_rec) ne 'HASH' ) {
        croak "NOT ARRAY in emit_f95_var_decl(".$var_decl_rec.")";
    }
    my $spaces = $var_decl_rec->{'Indent'};# [0];
#    ( my $type, my $attr, my $dim, my $intent_or_par ) =
#      @{ $var_decl_rec->[1] };
      my $type = $var_decl_rec->{'Type'}; 
      if (not defined $type) {
      	croak Dumper($var_decl_rec);
      }
      my $attr= $var_decl_rec->{'Attr'}; 
      my $dim= $var_decl_rec->{'Dim'}; 
      
      my $is_par = exists $var_decl_rec->{'Parameter'} ? 1 : 0;
      my $var = $var_decl_rec->{'Name'};
      
    my $dimstr = '';
#    say Dumper($dim);
    if ( ref($dim) eq 'ARRAY' and scalar @{$dim}>0) {
        my @dimpairs = map { $_->[0].':'.$_->[1] } @{ $dim };
        $dimstr = 'dimension(' . join( ',', @dimpairs) . ')';
    } else {
#        croak Dumper($dim); 
    }
    my @attrs = ();
    if ($attr) {
        push @attrs, $attr;
    }
    if ($dimstr) {
        push @attrs, $dimstr;
    }

    if ( not $is_par ) {
        # Variable
        my $intent    =  $var_decl_rec->{'IODir'};
        
        if (not defined $intent or $intent eq '') {
        	carp 'Intent not defined for '.Dumper($var_decl_rec) if $W;
        	$intent='Unknown'; 
        }
        if (ref($intent) eq 'ARRAY' and scalar @{$intent}==0) {
        	say "WARNING: Intent is [] for $var" if $W;
        	$intent = 'Unknown';
        }
        
        my $intentstr = '';
        
            if ( $intent ne 'Unknown' ) {
                $intentstr ='intent('.$intent.')'; 
#                die 'BLANK:'.Dumper($var_decl_rec) if "$intent"=~/^\s*$/;
            } else {
                say "WARNING: Intent is Unknown for $var"                  
                  if $W;
            }
        
        if ($intentstr) {
            push @attrs, $intentstr;
        }
        
        if ( @attrs && $attrs[0] =~ /^\s*\(/ ) {
            my $decl_line =
                $spaces 
              . $type
              . join( ', ', @attrs ) . ' :: '
              . $var;
            return $decl_line;
        } else {
            my $decl_line =
                $spaces
              . join( ', ', ( $type, @attrs ) ) . ' :: '
              . $var;
            return $decl_line;
        }
    } else {
        # Parameter        
        my $var_val = $var->[0] . '=' . $var->[1] ;
        my $decl_line =
            $spaces 
          . $type 
          . $attr . ', ' 
          . $dimstr
          . 'parameter' . ' :: '
          . $var_val;

        #  	say 'emit_f95_var_decl PARAM: '.$decl_line ;
        return $decl_line;
    }
}

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
                say $annline->[0] if $V;
                push @{$merged_annlines}, $annline;
            }
            for my $extra_annline ( @{$new_annlines} ) {
                ( my $nline, my $ninfo ) = @{$extra_annline};
                $ninfo->{'LineID'} = $nextLineID++;
                say $nline if $V;
                push @{$merged_annlines}, [ $nline, $ninfo ];
            }
            if ( not $skip_insert_pos_line and $insert_before ) {
                say $annline->[0] if $V;
                push @{$merged_annlines}, $annline;
            }

        } else {
            say $annline->[0] if $V;
            push @{$merged_annlines}, $annline;
        }
    }
    $Sf->{'RefactoredCode'} = $merged_annlines;
    return $stref;

}    # END of splice_additional_lines()

# Usage: 
# $stref = _create_extra_arg_decls( $stref, $f, $insert_cond_subref, $new_annlines, $insert_before, $skip_insert_pos_line, $once )
#- Go through the AnnLines
#- Find the hook based on a condition on the $annline
#- splice the new lines after the hook.
#- if $once is 0, do this whenever the condition is met. Otherwise
sub splice_additional_lines_cond {
    (
        my $stref, my $f,
        my $insert_cond_subref,
        my $new_annlines,
        my $insert_before,
        my $skip_insert_pos_line,
        my $do_once
    ) = @_;
    say "SPLICE on condition for $f" if $V;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    my $nextLineID         = scalar @{$annlines} + 1;
    my $merged_annlines    = [];
    $do_once = defined $do_once ? $do_once : 1;
    my $once=1;      

    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};
        if ( $insert_cond_subref->($annline) and $once ) {
            $once = 0 unless $do_once==0;

            #            say "SPLICE POINT $line";
            if ( not $skip_insert_pos_line and not $insert_before ) {
                say $annline->[0] if $V;
                push @{$merged_annlines}, $annline;
            }
            for my $extra_annline ( @{$new_annlines} ) {
                ( my $nline, my $ninfo ) = @{$extra_annline};
                $ninfo->{'LineID'} = $nextLineID++;
                say $nline if $V;
                push @{$merged_annlines}, [ $nline, $ninfo ];
            }
            if ( not $skip_insert_pos_line and $insert_before ) {
                say $annline->[0] if $V;
                push @{$merged_annlines}, $annline;
            }

        } else {
            say $annline->[0] if $V;
            push @{$merged_annlines}, $annline;
        }
    }
    $Sf->{'RefactoredCode'} = $merged_annlines;
    return $stref;

}    # END of splice_additional_lines_cond()


sub stateless_pass {
    (my $stref, my $f, my $pass_actions, my $info) = @_;
    say "STATELESS PASS ".Dumper($info)." for $f" if $V;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {
        my $new_annline = $pass_actions->($annline);
        push @{$new_annlines}, $new_annline;
    }
    $Sf->{'RefactoredCode'} = $new_annlines;
    return $stref;
} # END of stateless_pass() 

sub stateful_pass {
    (my $stref, my $f, my $pass_actions, my $state, my $info ) = @_;
    local $Data::Dumper::Indent =0;
    local $Data::Dumper::Terse=1;
    say "STATEFUL PASS ".Dumper($info)." for $f" if $V;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {
        (my $new_annline, $state) = $pass_actions->($annline, $state);
        push @{$new_annlines}, $new_annline;
    }
    $Sf->{'RefactoredCode'} = $new_annlines;
    
    return ($stref,$state);
} # END of stateful_pass()



sub _emit_f95_parsed_var_decl { (my $pvd) =@_;
    my $type= $pvd->{'TypeTup'}{'Type'} . (exists $pvd->{'TypeTup'}{'Kind'} ?  '('.$pvd->{'TypeTup'}{'Kind'}.')' : '');
         my  @attrs=($type); 
         if (exists $pvd->{'Attributes'}{'Allocatable'}) {
            push @attrs, 'allocatable';
        }
        if (exists $pvd->{'Attributes'}{'Dim'} ) {
            push @attrs,'dimension('.join(', ',@{ $pvd->{'Attributes'}{'Dim'} }).')';
        }
        if (exists $pvd->{'Attributes'}{'Intent'} ) {
            push @attrs,'intent('. $pvd->{'Attributes'}{'Intent'} .')' ;
        }
          my $vars = join(', ',@{  $pvd->{'Vars'} });
       my $line = join(', ', @attrs).' :: '.$vars;    
    return $line;
}

1;