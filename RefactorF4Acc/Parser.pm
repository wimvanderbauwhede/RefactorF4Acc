package RefactorF4Acc::Parser;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::CallGraph qw( add_to_call_tree );
use RefactorF4Acc::Refactoring::Common
  qw( format_f95_var_decl emit_f95_var_decl );
use RefactorF4Acc::Parser::SrcReader qw( read_fortran_src );
use RefactorF4Acc::CTranslation qw( add_to_C_build_sources );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( parse_assignment );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_start_detect );

use F95VarDeclParser qw( parse_F95_var_decl );

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
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Parser::ISA = qw(Exporter);

@RefactorF4Acc::Parser::EXPORT_OK = qw(
  &parse_fortran_src
);

# -----------------------------------------------------------------------------
# parse_fortran_src() parses the source but does perform only limited context-free analysis
sub parse_fortran_src {
    ( my $f, my $stref ) = @_
      ;  # NOTE $f is not the name of the source but of the sub/func/incl/module

#    local $V=1;
    print "parse_fortran_src(): PARSING $f\n " if $V;

## 1. Read the source and do some minimal processsing, unless it's already been done (i.e. for extracted blocks)
    $stref = read_fortran_src( $f, $stref );    #
    print "DONE read_fortran_src( $f )\n" if $V;

    my $sub_or_incl_or_mod = sub_func_incl_mod( $f, $stref );
     my $is_incl = $sub_or_incl_or_mod eq 'IncludeFiles';
    my $is_external_include = $is_incl  ?  ($stref->{'IncludeFiles'}{$f}{'InclType'} eq 'External') : 0;
      
    print "SRC TYPE for $f: $sub_or_incl_or_mod\n" if $V;
    if ( $sub_or_incl_or_mod ne 'ExternalSubroutines' and 
    not $is_external_include
    ) {
        my $Sf = $stref->{$sub_or_incl_or_mod}{$f};       
        
# Set 'RefactorGlobals' to 0, we only refactor the globals for subs that are kernel targets and their dependencies
        if ( not exists $Sf->{'RefactorGlobals'} ) {
            $Sf->{'RefactorGlobals'} = 0;
        }
        if ( $refactor_toplevel_globals == 1 ) {
            print "INFO: set RefactorGlobals=1 for $f\n" if $I;
            $Sf->{'RefactorGlobals'} = 1;
        }

## 2. Parse the type declarations in the source, create a per-target table Vars and a per-line VarDecl list and other context-free stuff
# NOTE: The Vars set are the *declared* variables, not the *used* ones
        print "ANALYSE LINES of $f\n" if $V;
        $stref = _analyse_lines( $f, $stref );
        print "DONE _analyse_lines( $f )\n" if $V;

## 3. Parse use
        $stref = _parse_use( $f, $stref );
        print "DONE _parse_use( $f )\n" if $V;

## 4. Parse includes
# NOTE: Apart from simply parsing, this routine also causes IMPLICITs from the include file to be inherited by the parent
        $stref = _parse_includes( $f, $stref );

## 5. Parse subroutine and function calls
        if ( not $is_incl ) {
            if ( $stref->{$sub_or_incl_or_mod}{$f}{'HasBlocks'} == 1 ) {
                $stref = _separate_blocks( $f, $stref );
            }

            # Recursive descent via subroutine calls
            $stref = _parse_subroutine_and_function_calls( $f, $stref );
            $stref->{$sub_or_incl_or_mod}{$f}{'Status'} = $PARSED;
            print "DONE PARSING $sub_or_incl_or_mod $f\n" if $V;
        } else  {    # includes
## 6. For includes, parse common blocks and parameters, create $stref->{'Commons'}
            $stref = _get_commons_params_from_includes( $f, $stref );
            $stref->{'IncludeFiles'}{$f}{'Status'} = $PARSED;
            
        }
            say 'parse_fortan_source: '. __LINE__.' : '. Dumper($stref->{'Subroutines'}{$f}{Vars}{indzindicator}) if $f eq 'particles_main_loop'; 
     
        
# 7. Split variable declarations with multiple vars into single-var lines
            $stref = _split_multivar_decls( $f, $stref );
            $stref = _split_multipar_decls_and_set_type( $f, $stref );
    } else {
        print "INFO: $f is EXTERNAL\n" if $I;
    }
     
#    die 'HERE' if $f eq 'f_esl';
#    
    
    print
"LEAVING parse_fortran_src( $f ) with Status $stref->{$sub_or_incl_or_mod}{$f}{'Status'}\n"
      if $V;
    return $stref;
}    # END of parse_fortran_src()

# -----------------------------------------------------------------------------

# _analyse_lines() parses every line and determines its purpose, the info is added to $info. Furthermore, 
# Create a table of all variables declared in the target, and a list of all the var names occuring on each line.
# $Sf->{'Parameters'}
# $Sf->{'Vars'} = \%vars;

# We record the type of the var and whether it's a scalar or array, because we need that information for translation to C.
# Also check if the variable happens to be a function. If that is the case, mark that function as 'Called'; if we have not yet parsed its source, do it now.

# In order to get proper hooks for the ex-globals, I think we need to check signatures, includes and variable declarations here.

#WV20150305 I've added labels to the lines, as identifiers for e.g. start/end of pragmas. I can do this here because here the lines have been normalised but no refactoring has been done yet.
sub _analyse_lines {
    ( my $f, my $stref ) = @_;
    my $sub_func_incl_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_func_incl_or_mod}{$f};
    $Sf->{'ExGlobVarDeclHook'} = 0;
    my $srcref = $Sf->{'AnnLines'};

    if ( defined $srcref ) {
        print "\nVAR DECLS in $f:\n" if $V;
        my %vars       = ();
        $Sf->{'Vars'} = {} unless exists $Sf->{'Vars'};
        my $first      = 1;
        my $is_vardecl = 0;
        my $type       = 'NONE';
        my $varlst     = '';
        my $indent     = '';
        my @do_stack   = ();
        my $do_counter = 0;

        for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
            my $attr = '';
            my $line = $srcref->[$index][0];
            $line =~ /^(\s+).*/ && do { $indent = $1; };
            my $info = $srcref->[$index][1];
            $info->{'LineID'} = $index;

            if ( $line =~ /^\!\s+/ && $line !~ /^\!\s*\$(?:ACC|RF4A)\s/i ) {
                next;
            }

            # Handle !$ACC
            if ( $line =~ /^\!\s*\$(?:ACC|RF4A)\s.+$/i ) {
                my $accline = $line;
                $accline =~ s/^\!\s*\$(?:ACC|RF4A)\s+//i;
                my @chunks = split( /\s+/, $accline );
                my $pragma_name_prefix = 'Begin';
                if ( $chunks[0] =~ /Begin/i ) {
                    shift @chunks;
                }
                if ( $chunks[0] =~ /End/i ) {
                    shift @chunks;
                    $pragma_name_prefix = 'End';
                }
                ( my $pragma_name, my @pragma_args ) = @chunks;
                $info->{'AccPragma'}
                  { $pragma_name_prefix . ucfirst($pragma_name) } =
                  [@pragma_args];
                if (    $pragma_name =~ /KernelWrapper/i
                    and $pragma_name_prefix eq 'Begin' )
                {
                    $stref->{'KernelWrappers'}{ $pragma_args[0] }
                      { $pragma_name_prefix . ucfirst($pragma_name) } =
                      [ $f, $index ];
                    $stref = outer_loop_start_detect( $pragma_args[0], $stref );
                }
            }

            # Set up hook for later insertion of ExGlobVarDecls
            if (   exists $info->{'Includes'}
                or exists $info->{'FunctionSig'}
                or exists $info->{'SubroutineSig'}
                or exists $info->{'Use'} )
            {
                $info->{'ExGlobVarDecls'} = ++$Sf->{'ExGlobVarDeclHook'};
            }

            # FIXME Trailing comments are ignored!
            #            if ( $line =~ /^\!\s/ ) {
            #                $stref->{$sub_func_incl_or_mod}{$f}{'Info'}
            #                  ->[$index]{'TrailingComments'} = {};
            #                next;
            #            }

            if ( $line =~ /implicit\s+none/ ) {
                $info->{'ImplicitNone'} = 1;
                $Sf->{'ImplicitNone'}   = $index;
            } elsif ( $line =~ /^\s*use\s+(\w+)/ ) {
                my $module=$1;
                $info->{'Use'} = $module;
            } elsif ( $line =~ /implicit\s+/ ) {
                $info->{'Implicit'} = 1;
                $stref = _parse_implicit( $line, $f, $stref );
            } elsif ( $line =~ /^\d*\s+(else\s+if)/ ) {
                $info->{'ElseIf'} = 1;
            } elsif ( $line =~
                /^\d*\s+(if|else|select|case|read|write|print|open|close)\s*\(/
                or $line =~ /^\d*\s+(return|stop)\s*/ )
            {
                my $keyword=$1;
                $info->{ ucfirst($keyword) } = 1;
            } elsif ( $line =~ /^\d*\s+end\s+(if|case|do)\s*/ ) {
                my $keyword=$1;
                my $kw = ucfirst($keyword);
                $info->{ 'End' . $kw } = {};
                if ( $kw eq 'Do' ) {
                    $do_counter--;
                    my $corresponding_do_info = pop @do_stack;
                    $info->{'EndDo'} = $corresponding_do_info->{'Do'};
                    delete $info->{'EndDo'}{'Label'};
                }

            } elsif (
                $line =~ /^\d*\s*end\s+(subroutine|module|function)\s*(\w+)/ )
            {
                my $kw   = $1;
                my $name = $2;
                $info->{ 'End' . ucfirst($kw) } = { 'Name' => $name };
            } elsif ( $line =~ /^\d*\s+do\b/ ) {

#WV20150304: We parse the do and store the iterator and the range { 'Iterator' => $i,'Range' =>[$start,$stop]}
                my $do_stmt = $line;
                $do_stmt =~ s/^\d*\s+do\s+(\d*)\s+//;
                my $label = $1;

                ( my $iter, my $range ) = split( /\s*=\s*/, $do_stmt );
                ( my $range_start, my $range_stop ) = split( /s*,\s*/, $range );
                $info->{'Do'} = {
                    'Iterator' => $iter,
                    'Label'    => $label,
                    'Range'    => [ $range_start, $range_stop ],
                    'LineID'   => $info->{'LineID'}
                };
                $do_counter++;
                push @do_stack, $info;
            } elsif ( $line !~ /::/
                && $line !~ /\bparameter\b/
                && $line =~ /[\w\)]\s*=\s*[^=]/ )
            {
                $info->{'Assignment'} = 1;

#WV20150303: We parse this assignment and return {Lhs => {Varname, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
                my $vref = parse_assignment($line);
                $info->{'Assignment'} = {
                    'Lhs' => $vref->[0],
                    'Rhs' => {
                        'VarList' => $vref->[1],
                        'Expr'    => $vref->[2],
                    }
                };
            }

            # Actual variable declaration line (F77)
            # In principle every type can be followed by '*<number>' or *(*)
            # F77 VarDecl
            elsif ( ($line =~
/\b(logical|integer|real|double\s*precision|character)\s+([^\*]?.*)\s*$/
                or $line =~
/\b((?:logical|integer|real|double\s*precision|character)\s*\*(?:\d+|\(\*\)))\s+(.+)\s*$/) and $line!~/^\s+\w+\s+function\s+/
              )
            {
                $type   = $1;
                $varlst = $2;

# Now an ad hoc fix for spaces between the type and the asterisk. FIXME! I should just write a better FSM!
                if ( $line =~ /\w+\s+(\*\s*(\d+|\(\s*\*\s*\)))/ )
                { # FIXME: I assume after the asterisk there MUST be an integer constant
                    my $len = $1;
                    $type .= $len;
                    $varlst =~ s/^\S+\s+//;

                }

                $type =~ /\*/ && do {
                    ( $type, $attr ) = split( /\*/, $type );
                    if ( $attr eq '(' ) { $attr = '*' }
                };
                $indent = $line;
                $indent =~ s/\S.*$//;
                $is_vardecl = 1; # Actual parsing happens later on
            } elsif ( $line =~ /^\s*(.*)\s*::\s*(.*?)\s*$/ ) {
                # F95 VarDecl                
                # F95 declaration, no need for refactoring
                $type   = $1;
                $varlst = $2;
                $indent = $line;
                $indent =~ s/\S.*$//;
                my $pt = parse_F95_var_decl($line);

             # But this could be a parameter declaration, with an assignment ...
                if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+\s*=\s*.+?)\s*$/ )
                {    # F95-style parameters
                    $info->{'ParsedParDecl'} = $pt; #WV20150709 currently used by OpenCLTranslation, TODO: use ParamDecl
                    my $parliststr = $1;
                    my $var        = $pt->{Pars}{Var};
                    my $val        = $pt->{Pars}{Val};
                    my $type       = $pt->{TypeTup};

                    #							push @{$pars}, $var;
                    #					my @partups    = split( /\s*,\s*/, $parliststr );
                    #					my %pvars      =
                    #					  map { split( /\s*=\s*/, $_ ) }
                    #					  @partups;    # Perl::Critic, EYHO
                    #					if ( not exists $Sf->{'Parameters'} ) {
                    #						$Sf->{'Parameters'} = {};
                    #					}
                    #                   if ( not exists $Sf->{'Parameters'}{'Set'} ) {
                    #                   $Sf->{'Parameters'}{'Set'} = {};
                    #                   }   
                    #					my $pars = [];
                    #					my @pvarl = map { s/\s*=.+//; $_ } @partups;
                    #					for my $var (@pvarl) {
                    #						if ( not defined $Sf->{'Vars'}{$var} ) {
                    #							print
                    #"INFO: PARAMETER $var not declared in $f (F95-style)\n"
                    #							  if $I;
                    #						} else {
                    #							$Sf->{'Parameters'}{'Set'}{$var} = {
                    #								'Type' => $type,
                    #								'Var'  => $Sf->{'Vars'}{$var},
                    #								'Val'  => $pvars{$var}
                    #							};
                    #							push @{$pars}, $var;
                    #						}
                    #					}
                    $info->{'ParamDecl'} = [
                        $indent, [ $type, '', [], 'parameter' ],
                        [ [ $var, $val ] ], 0
                    ];    # F95-style
                    if ( not exists $Sf->{'Parameters'}{'OrderedList'} ) {
                        $Sf->{'Parameters'}{'OrderedList'} = [];
                    }
                    if ( not exists $Sf->{'Parameters'}{'Set'} ) {
                        $Sf->{'Parameters'}{'Set'} = {};
                    }
                    $Sf->{'Parameters'}{'Set'}{$var} = {  
                        'Type' => $type,
                        'Var'  => $var,
                        'Val'  => $val
                    };
                    
                    @{ $Sf->{'Parameters'}{'OrderedList'} } =
                      ( @{ $Sf->{'Parameters'}{'OrderedList'} }, $var );

                } else {
                    # F95 VarDecl, continued
                    if (not exists $info->{'ParsedVarDecl'} and not exists $info->{'VarDecl'} ) { 
                    $info->{'ParsedVarDecl'} = $pt; #WV20150709 currently used by OpenCLTranslation, TODO: use VarDecl
                    for my $tvar (@{ $pt->{'Vars'} } ) {
                    $Sf->{'Vars'}{$tvar}{'Indent'}=$indent;
                    $Sf->{'Vars'}{$tvar}{'Type'}  = $pt->{'TypeTup'}{'Type'};
                    $Sf->{'Vars'}{$tvar}{'ArrayOrScalar'} = 'Scalar';
                    $Sf->{'Vars'}{$tvar}{'Shape'} = [];
                    if ( exists $pt->{'Attributes'} ) {
                        if ( exists $pt->{'Attributes'}{'Dim'} ) {
                            if ( $pt->{'Attributes'}{'Dim'}[0] ne '0' ) {
#                                die Dumper($pt->{'Attributes'}{'Dim'});
                                $Sf->{'Vars'}{$tvar}{'Shape'} = $pt->{'Attributes'}{'Dim'};
                                $Sf->{'Vars'}{$tvar}{'ArrayOrScalar'}='Array';
                            }
                        }
                    }                    
#                    $Sf->{'Vars'}{$tvar}{'ArrayOrScalar'} = $pt->{'TypeTup'}{'ArrayOrScalar'} ;
                    if ( $type =~ /character/ ) {
                        $Sf->{'Vars'}{$tvar}{'Attr'} = '(len='
                          . $pt->{TypeTup}{'ArrayOrScalar'} . ')'
                          ; #WV20150709: maybe better ['len',$pt->{TypeTup}{'ArrayOrScalar'}]
                    } else {
                        $Sf->{'Vars'}{$tvar}{'Attr'} =
                          '(kind=' . $pt->{'TypeTup'}{'Kind'} . ')';
                    }
                                        
                    $Sf->{'Vars'}{$tvar}{'IODir'} = $pt->{'Attributes'}{'Intent'};
                    
#                    die 'F95 VarDecl: '.Dumper($Sf->{'Vars'}{$tvar}) if $tvar eq 'drydeposit';
                    }
                    }
                }
                $is_vardecl = 0;
            } elsif ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ )
            {               # F77-style parameters
                my $parliststr = $1;
                $indent = $line;
                $indent =~ s/\S.*$//;
                my @partups = split( /\s*,\s*/, $parliststr );
                my %pvars =
                  map { split( /\s*=\s*/, $_ ) } @partups;  # Perl::Critic, EYHO
                my @var_vals =
                  map { ( my $k, my $v ) = split( /\s*=\s*/, $_ ); [ $k, $v ] }
                  @partups;                                 # Perl::Critic, EYHO
                my @pvarl = map { s/\s*=.+//; $_ } @partups;
                my $pars = [];
                if ( not exists $Sf->{'Parameters'}{'OrderedList'} ) {
                    $Sf->{'Parameters'}{'OrderedList'} = [];
                }
                if ( not exists $Sf->{'Parameters'}{'Set'} ) {
                    $Sf->{'Parameters'}{'Set'} = {};
                }

                for my $var (@pvarl) {
die if ref($var) eq 'ARRAY';
                    if ( not defined $Sf->{'Vars'}{$var} ) {

                        if ( exists $pvars{$var} ) {

                            my $val = $pvars{$var};
                            if ( $val =~ /[0-9eE\.\+\-]/ ) {
                                my $type = 'Unknown';
                                if (   $val =~ /\./
                                    or $val =~ /e/i
                                    or $val =~ /\// )
                                {
                                    $type = 'real';    # FIXME: could be double!
                                } else {
                                    $type = 'integer';
                                }
                                $Sf->{'Parameters'}{'Set'}{$var} = { 
                                    'Type' => $type,
                                    'Var'  => $var,
                                    'Val'  => $val
                                };
                                print
"INFO: PARAMETER $var infered type: $type $var = $val\n"
                                  if $I;
                                push @{$pars}, $var;

                            } else {
                                print
"WARNING: PARAMETER $var not declared in $f; can't infer type:\n"
                                  if $W;
                                print
"WARNING: PARAMETER $var has NON_NUMERIC val $pvars{$var} in $f  (Parser::_analyse_lines)\n"
                                  if $W;
                            }
                        }
                    } else {
                        $type = 'Unknown';
                        $Sf->{'Parameters'}{'Set'}{$var} = {
                            'Type' => 'Unknown',
                            'Var'  => $Sf->{'Vars'}{$var},
                            'Val'  => $pvars{$var}
                        };
                        push @{$pars}, $var;
                    }
                }
                $info->{'ParamDecl'} =
                  [ $indent, [ $type, '', [], 'parameter' ], [@var_vals], 0 ]
                  ;    # F77-style
                @{ $Sf->{'Parameters'}{'OrderedList'} } =
                  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @{$pars} );
            }    # match var decls, parameter statements F77/F95

            if ($is_vardecl) {
                $is_vardecl = 0;
                my $T        = 0;
#                $T = 1 if $f eq 'timemanager' and $line=~/drydeposit/;
                my $pvars    = _parse_F77_vardecl( $varlst, $T );
#                die Dumper($pvars) if $f eq 'timemanager' and $line=~/drydeposit/;

                # I verified that here the dimensions are correct
                my @varnames = ();
                for my $var ( keys %{$pvars} ) {
                    if ( $var eq '' ) { croak "<$line> in $f" }
                    my $tvar = $var;
                    if (ref($var) eq 'ARRAY') {die '474:'.Dumper($var);}
                    $Sf->{'Vars'}{$tvar}{'Type'}  = $type;
                    $Sf->{'Vars'}{$tvar}{'Shape'} = $pvars->{$var}{'Shape'};
                    $Sf->{'Vars'}{$tvar}{'ArrayOrScalar'}  = $pvars->{$var}{'ArrayOrScalar'};
                    if ( not exists $pvars->{$var}{'Attr'} ) {
                        if ($attr) {
                            if ( $type =~ /character/ ) {
                                $Sf->{'Vars'}{$tvar}{'Attr'} = '(len=' . $attr . ')';
                            } else {
                                $Sf->{'Vars'}{$tvar}{'Attr'} = '(kind=' . $attr . ')';
                            }
                        } else {
                            $Sf->{'Vars'}{$tvar}{'Attr'} = '';
                        }
                    } else {
                        if ( $type =~ /character/ ) {
                            $Sf->{'Vars'}{$tvar}{'Attr'} =
                              '(len=' . $pvars->{$var}{'Attr'} . ')';
                        } else {
                            $Sf->{'Vars'}{$tvar}{'Attr'} =
                              '(kind=' . $pvars->{$var}{'Attr'} . ')';
                        }
                    }

                    # Take IODir from INTENT
                    if ( $type =~ /\bintent\s*\(\s*(\w+)\s*\)/ ) {
                        my $iodir = $1;
                        $iodir = ucfirst($iodir);
                        if ( $iodir eq 'Inout' ) {
                            $iodir = 'InOut';
                        }
                        $Sf->{'Vars'}{$tvar}{'IODir'} = $iodir;
                    }

                    $Sf->{'Vars'}{$tvar}{'Decl'} = [ $indent, [$type], [$var], 0 ];
                    $Sf->{'Vars'}{$tvar}{'Indent'} = $indent; 

                    if ( exists $stref->{'Subroutines'}{$tvar} and exists $stref->{'Subroutines'}{$tvar}{'Function'} and $tvar ne $f )
                    {    # FIXME: NO RECURSION!

                        $stref->{'Subroutines'}{$tvar}{'Called'} = 1;
                        
                        if (
                            not
                            exists $stref->{'Subroutines'}{$tvar}{'Callers'}{$f} )
                        {
                            $stref->{'Subroutines'}{$tvar}{'Callers'}{$f} = [];
                        }
                        push @{ $stref->{'Subroutines'}{$tvar}{'Callers'}{$f} },
                          $index;
                        if (
                            not
                            exists $stref->{'Subroutines'}{$tvar}{'AnnLines'} )
                        {
                            $stref = parse_fortran_src( $tvar, $stref );
                        }
                    }
                    push @varnames, $tvar;
                }    # loop over all vars declared on a single line

                print "\tVARS <$line>:\n ", join( ',', sort @varnames ), "\n"
                  if $V;
                  # FIXME: this is not OK when we split later on
                $info->{'VarDecl'} =
                  [ $indent, [], [@varnames], 0 ]
                  ; #WV20150708 We now store 'Decl' here so it us a record [$spaces,[$type, $attr, $dim , $intent ],[@vars],$formatted];
                if ($first) {
                    $first = 0;

                    # FIXME: no use in include files!
                    $info->{'ExGlobVarDecls'} =
                      ++$Sf->{ExGlobVarDeclHook};    # {};
                }
            }
            $srcref->[$index] = [ $line, $info ];
        }    # Loop over lines
        
#        $Sf->{'Vars'} = \  ; 
    } else {
        print "WARNING: NO AnnLines for $f\n";
        die "SOURCE for $f: " . Dumper($Sf);
    # FIXME: if we can't find the source, we should search the include path, but not attempt to create a module for that source!
    }

    #           die "FIXME: shapes not correct!";
    return $stref;
}    # END of _analyse_lines()

# -----------------------------------------------------------------------------
# For every 'include' statement in a subroutine
# the filename is entered in 'Includes' and in Info->[$index]{'Include'}
# If the include was not yet read, do it now.
sub _parse_includes {
    ( my $f, my $stref ) = @_;

    #	local $V=1;

    my $sub_or_func_or_mod_or_inc_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_mod_or_inc_or_mod}{$f};
    print "PARSING INCLUDES for $f ($sub_or_func_or_mod_or_inc_or_mod)\n" if $V;
    my $srcref       = $Sf->{'AnnLines'};
    my $last_inc_idx = 0;
    if ( defined $srcref ) {
        for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
            my $line = $srcref->[$index][0];
            my $info = $srcref->[$index][1];
            if ( $line =~ /^\!\s/ ) {
                next;
            }

            if ( $line =~ /^\s*include\s+\'([\w\.]+)\'/ ) {
                my $name = $1;
                print "FOUND include $name in $f\n" if $V;
                $Sf->{'Includes'}{$name} = $index;

                if (    exists $Sf->{'Translate'}
                    and exists $stref->{'IncludeFiles'}{$name}
                    and not
                    exists $stref->{'IncludeFiles'}{$name}{'Translate'} )
                {
                    $stref->{'IncludeFiles'}{$name}{'Translate'} =
                      $Sf->{'Translate'};
                    if ( $Sf->{'Translate'} eq 'C' ) {
                        $stref = add_to_C_build_sources( $name, $stref );
                    } else {
                        croak '!$acc translate (' 
                          . $f . ') '
                          . $Sf->{'Translate'}
                          . ": Only C translation through F2C_ACC is currently supported.\n";
                    }
                }
                $last_inc_idx = $index;

                $info->{'Include'} = {};
                $info->{'Include'}{'Name'} = $name;

                if ( $stref->{'IncludeFiles'}{$name}{'Status'} == $UNREAD ) {
                    print $line, "\n" if $V;

                    # Initial guess for Root. OK? FIXME?
                    $stref->{'IncludeFiles'}{$name}{'Root'}      = $f;
                    $stref->{'IncludeFiles'}{$name}{'HasBlocks'} = 0;
                    $stref = parse_fortran_src( $name, $stref );
                } else {
                    print $line, " already processed\n" if $V;
                }
                if (    exists $stref->{'Implicits'}
                    and exists $stref->{'Implicits'}{$name} )
                {
                    print "INFO: inheriting IMPLICITS from $name in $f\n" if $I;  
                    if ( not exists $stref->{'Implicits'}{$f} ) {
                        $stref->{'Implicits'}{$f} =
                          $stref->{'Implicits'}{$name};
                    } else {
                        for my $k ( keys %{ $stref->{'Implicits'}{$name} } ) {
                            if ( not exists $stref->{'Implicits'}{$f}{$k} ) {
                                $stref->{'Implicits'}{$f}{$k} =
                                  $stref->{'Implicits'}{$name}{$k};
                            } else {
                                die
"ERROR: $f and $name have different type for $k";
                            }
                        }
                    }
                }
            }
            $srcref->[$index] = [ $line, $info ];
        }
    } else {
        print "WARNING: NO LOCAL SOURCE for $f\n";

    # FIXME: if we can't find the source, we should search the include path, but
    # not attempt to create a module for that source!
    }

    # tag the next line after the last include

    $last_inc_idx++;
    $srcref->[$last_inc_idx][1]{'ExtraIncludesHook'} = 1;
    return $stref;
}    # END of parse_includes()

# -----------------------------------------------------------------------------
# Parse 'use' declarations in case the module is inlineable
#FIXME otherwise we don't? although maybe we should because the module can contain module-scoped variables etc.
# So maybe we need to parse all the stuff in a module except the subroutines, as that is done elsewhere
sub _parse_use {
    ( my $f, my $stref ) = @_;

    #	local $V=1;

    my $sub_or_func_or_mod_or_inc_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_mod_or_inc_or_mod}{$f};
    print "PARSING USE for $f ($sub_or_func_or_mod_or_inc_or_mod)\n" if $V;
    my $srcref       = $Sf->{'AnnLines'};
    my $last_inc_idx = 0;
    if ( defined $srcref ) {
        for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
            my $line = $srcref->[$index][0];
            my $info = $srcref->[$index][1];
            if ( $line =~ /^\!\s/ ) {
                next;
            }

            if ( $line =~ /^\s*use\s+(\w+)/ ) {
                my $name = $1;
                print "FOUND module $name in $f\n" if $V;
                $Sf->{'Uses'}{$name} = $index;

                if (    exists $Sf->{'Translate'}
                    and exists $stref->{'Modules'}{$name}
                    and not exists $stref->{'Modules'}{$name}{'Translate'} )
                {
                    $stref->{'Modules'}{$name}{'Translate'} =
                      $Sf->{'Translate'};
                    if ( $Sf->{'Translate'} eq 'C' ) {
                        $stref = add_to_C_build_sources( $name, $stref );
                    } else {
                        croak '!$acc translate (' 
                          . $f . ') '
                          . $Sf->{'Translate'}
                          . ": Only C translation through F2C_ACC is currently supported.\n";
                    }
                }
                $last_inc_idx = $index;

                $info->{'Use'} = {};
                $info->{'Use'}{'Name'} = $name;
                if ( not exists $stref->{'Modules'}{$name}{'Status'}
                    or $stref->{'Modules'}{$name}{'Status'} < $READ )
                {
                    print $line, "\n" if $V;

                    #				# Initial guess for Root. OK? FIXME?
                    #				$stref->{'IncludeFiles'}{$name}{'Root'}      = $f;
                    #				$stref->{'IncludeFiles'}{$name}{'HasBlocks'} = 0;
                    $stref = parse_fortran_src( $name, $stref );
                } else {
                    print $line, " already processed\n" if $V;
                }
                if ( exists $stref->{'Modules'}{$name}{'Inlineable'} ) {
                    $info->{'Use'}{'Inlineable'} = {};
                }
                if (    exists $stref->{'Implicits'}
                    and exists $stref->{'Implicits'}{$name} )
                {
                    print "INFO: inheriting IMPLICITS from $name in $f\n" if $I;
                    if ( not exists $stref->{'Implicits'}{$f} ) {
                        $stref->{'Implicits'}{$f} =
                          $stref->{'Implicits'}{$name};
                    } else {
                        for my $k ( keys %{ $stref->{'Implicits'}{$name} } ) {
                            if ( not exists $stref->{'Implicits'}{$f}{$k} ) {
                                $stref->{'Implicits'}{$f}{$k} =
                                  $stref->{'Implicits'}{$name}{$k};
                            } else {
                                die
"ERROR: $f and $name have different type for $k";
                            }
                        }
                    }
                }
            }
            $srcref->[$index] = [ $line, $info ];
        }
    } else {
        print "WARNING: NO LOCAL SOURCE for $f\n";

    # FIXME: if we can't find the source, we should search the include path, but
    # not attempt to create a module for that source!
    }

    # tag the next line after the last include

    $last_inc_idx++;
    $srcref->[$last_inc_idx][1]{'ExtraModulesHook'} = 1;
    return $stref;
}    # END of parse_includes()

# -----------------------------------------------------------------------------

sub OBSOLETE_detect_blocks {
    ( my $stref, my $s ) = @_;
    print "CHECKING BLOCKS in $s\n" if $V;
    my $sub_func_incl_or_mod = sub_func_incl_mod( $s, $stref );
    die "$sub_func_incl_or_mod $s "
      . $stref->{$sub_func_incl_or_mod}{$s}{'HasBlocks'}
      if $s eq 'timemanager';
    $stref->{$sub_func_incl_or_mod}{$s}{'HasBlocks'} = 0;
    my $srcref = $stref->{$sub_func_incl_or_mod}{$s}{'AnnLines'};
    for my $annline ( @{$srcref} ) {
        my $line = $annline->[0];
        if ( $line =~ /^\!\s/ ) {

# I'd like to use the OpenACC compliant pragma !$acc kernels , !$acc end kernels
# but OpenACC does not allow to provide a name
# so I propose my own tag: !$acc subroutine name, !$acc end subroutine
            if (   $line =~ /^\!\s+BEGIN\sSUBROUTINE\s(\w+)/
                or $line =~ /^\!\s*\$(?:ACC|RF4A)\ssubroutine\s(\w+)/i )
            {
                $stref->{$sub_func_incl_or_mod}{$s}{'HasBlocks'} = 1;
                my $tgt = uc( substr( $sub_func_incl_or_mod, 0, 3 ) );
                print "$tgt $s HAS BLOCK: $1\n" if $V;
                last;
            }
        }
    }

    return $stref;
}    # END of detect_blocks()

# -----------------------------------------------------------------------------

=pod

=begin markdown

### Factoring out code blocks into subroutines

This is some major refactoring, so why is it not in Refactoring/ ? 

=end markdown

=cut

#WV20150701 This routine is very early here and it is BROKEN: common block variables don't get declarations!
sub _separate_blocks {
    ( my $f, my $stref ) = @_;
#    local $V = 1;

#    die "separate_blocks(): FIXME: we need to add in the locals from the parent subroutine as locals in the new subroutine!";
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $srcref             = $Sf->{'AnnLines'};

    #die Dumper($Sf);
    $Data::Dumper::Indent = 2;

    # All local variables in the parent subroutine
    my $varsref = $Sf->{'Vars'};
    

    # Occurence
    my $occsref = {};
    my $itersref = {};
    # A map of every block in the parent
    my $blocksref = { 'OUTER' => { 'AnnLines' => [] } };

# 1. Process every line in $f, scan for blocks marked with pragmas.
# What this does is to separate the code into blocks (%blocks) and keep track of the line numbers
# The lines with the pragmas occur both in OUTER and the block

    ( $stref, $blocksref ) = __separate_into_blocks( $stref, $blocksref, $f );

# 2. For all non-OUTER blocks, create an entry for the new subroutine in 'Subroutines'
# Based on the content of %blocks

    $stref = __create_new_subroutine_entries( $stref, $blocksref, $f );

# 3. Identify which vars are used
#   - in both => these become function arguments
#   - only in "outer" => do nothing for those
#   - only in "inner" => can be removed from outer variable declarations
#
# Find all vars used in each block, starting with the outer block
# It is best to loop over all vars per line per block, because we can remove the encountered vars

    ($occsref, $itersref) = @{ __find_vars_in_block( $blocksref, $varsref, $occsref ) };

    # 4. Construct the subroutine signatures

    $stref =
      __construct_new_subroutine_signatures( $stref, $blocksref, $occsref, $itersref,
        $varsref, $f );
        
        $stref = __reparse_extracted_subroutines($stref, $blocksref);
        my @callinfo = caller(0);
        my $callinfostr=$callinfo[3];
        say  $callinfostr .' '. __LINE__ .' : ' .Dumper($stref->{Subroutines}{particles_main_loop}{Vars}{indzindicator});
    
#	warn "Vars are CORRECT AT END OF separate_blocks( $f ):\n-----\n";
#	warn "-----\n";
#	croak "BOOM!" if $f eq 'timemanager';
#die Dumper($stref->{'Subroutines'}{'LES_kernel_wrapper'});
    return $stref;
}    # END of separate_blocks()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# We need access to the info about the ACC pragma's here.
sub _parse_subroutine_and_function_calls {
    ( my $f, my $stref ) = @_;
    print "PARSING SUBROUTINE/FUNCTION CALLS in $f\n" if $V;
    my $pnid               = $stref->{'NId'};
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};

    # For C translation and call tree generation
    # TODO: $translate is obsolete!
    if ( $translate == $GO
        || ( $call_tree_only && ( $gen_sub || $main_tree ) ) )
    {
        if ( $translate == $GO ) {
            $stref = add_to_C_build_sources( $f, $stref );
        }
    }
    if ( exists $Sf->{'Translate'} ) {
        if ( $Sf->{'Translate'} eq 'C' ) {
            $stref = add_to_C_build_sources( $f, $stref );
        } else {
            croak '!$acc translate (' 
              . $f . ') '
              . $Sf->{'Translate'}
              . ": Only C translation through F2C_ACC is currently supported.\n";
        }
    }
    my $srcref = $Sf->{'AnnLines'};

    if ( defined $srcref ) {
        my $in_kernel_wrapper_region = 0;
        my $in_kernel_sub_region     = 0;
        my $kernel_wrapper_name      = '';
        my $current_sub_name         = '';
        for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
            my $line = $srcref->[$index][0];
            my $info = $srcref->[$index][1];
            next if ( $line =~ /^\!\s/ and $line !~ /^\!\s*\$(?:ACC|RF4A)\s/i );
            if ( exists $info->{'AccPragma'} ) {
                if ( exists $info->{'AccPragma'}{'BeginKernelWrapper'} ) {
                    $in_kernel_wrapper_region = 1;
                    $kernel_wrapper_name =
                      $info->{'AccPragma'}{'BeginKernelWrapper'}[0];
                } elsif ( exists $info->{'AccPragma'}{'EndKernelWrapper'} ) {
                    $in_kernel_wrapper_region = 0
                      ; #2; # FIXME: A bit weak, what if there are more than one?
                } elsif ( exists $info->{'AccPragma'}{'BeginKernelSub'} ) {
                    $in_kernel_sub_region = 1;
                } elsif ( exists $info->{'AccPragma'}{'EndKernelSub'} ) {
                    $in_kernel_sub_region = 0;
                }
            }

            if ( exists $info->{'SubroutineSig'} ) {
                $current_sub_name = $info->{'SubroutineSig'}[1];
            }
      # Subroutine calls. Surprisingly, these even occur in functions! *shudder*
            if (   $line =~ /call\s+(\w+)\s*\((.*)\)/
                || $line =~ /call\s+(\w+)\s*$/ ) {
                my $name =
                  $1;    # The name of the called subroutine. The caller is $f
                if ( $in_kernel_wrapper_region == 1 ) {
                    if ($in_kernel_sub_region) {
                        $stref->{'KernelWrappers'}{$kernel_wrapper_name}
                          {'KernelSubs'}{$name} =
                          { 'LineID' =>
                              $info->{'LineID'} };    # slot for the arguments
                    } else {
                        $stref->{'KernelWrappers'}{$kernel_wrapper_name}
                          {'OtherCalls'}{$name} =
                          { 'LineID' =>
                              $info->{'LineID'} };    # slot for the arguments
                    }
                }
                $stref = add_to_call_tree( $name, $stref, $f );
                if ( not exists $stref->{'Subroutines'}{$name} ) {
                    $stref->{'ExternalSubroutines'}{$name}{'Called'} = 1;
                    return $stref;
                }
                my $Sname = $stref->{'Subroutines'}{$name};

                if ( exists $Sf->{'Translate'}
                    and not exists $Sname->{'Translate'} )
                {
                    $Sname->{'Translate'} = $Sf->{'Translate'};
                }
                $stref->{'NId'}++;
                my $nid = $stref->{'NId'};
                push @{ $stref->{'Nodes'}{$pnid}{'Children'} }, $nid;
                $stref->{'Nodes'}{$nid} = {
                    'Parent'     => $pnid,
                    'Children'   => [],
                    'Subroutine' => $name
                };

                my $argstr = $2 || '';
                if ( $argstr =~ /^\s*$/ ) {
                    $argstr = '';
                }

                $Sname->{'Called'} = 1;

# What I want to know is: where in $f does the call to $name occur?
# Problem is of course that this is before refactoring, so after refactoring this line might be wrong!
# But then we probably want to do the analysis before we refactor anyway.
# The proper way of course is to change the index of the line after refactoring, but then it has to change in any datastructure that uses it as well!
                if ( not exists $Sname->{'Callers'}{$f} ) {
                    $Sname->{'Callers'}{$f} = [];
                }
                push @{ $Sname->{'Callers'}{$f} }, $index;

                if ( $Sf->{'RefactorGlobals'} == 1 ) {
                    print "SUB $name NEEDS GLOBALS REFACTORING\n" if $V;
                    $Sname->{'RefactorGlobals'} = 1;
                }

                my $tvarlst = $argstr;
                
# replace , by ; in array indices and nested function calls FIXME: UGLY! USE PROPER FSM!
                if ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
                    while ( $tvarlst =~ /\(((?:[^\(\),]*?,)+[^\(]*?)\)/ ) {
                        my $chunk  = $1;
                        my $chunkr = $chunk;
                        $chunkr =~ s/,/;/g;
                        my $pos = index( $tvarlst, $chunk );
                        substr( $tvarlst, $pos, length($chunk), $chunkr );
                    }
                }
# now split on , FIXME: UGLY! USE PROPER FSM!
                my @tvars = split( /\s*\,\s*/, $tvarlst );
# now replace ; by , FIXME: UGLY! USE PROPER FSM!
                my @argvars = ();
                for my $var (@tvars) {
                    $var =~ s/^\s+//;
                    $var =~ s/\s+$//;
                    $var =~ s/;/,/g;
                    push @argvars, $var;
                }

                $info->{'SubroutineCall'}{'Args'}{'List'} = \@argvars;
                $info->{'SubroutineCall'}{'Args'}{'Set'} =
                  { map { $_ => 1 } @argvars };
                $info->{'SubroutineCall'}{'Name'} = $name;

                if ( defined $Sname
                    and not exists $Sf->{'CalledSubs'}{$name} )
                {
                    if ( $sub_or_func_or_mod eq 'Subroutines' ) {
                        $Sf->{'CalledSubs'}{$name} = 1;
                    } else {
                        $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}
                          {$name} = 1;
                    }
                    if (   not exists $Sname->{'Status'}
                        or $Sname->{'Status'} < $PARSED
                        or $gen_sub )
                    {
                        print "\tFOUND SUBROUTINE CALL $name in $f\n" if $V;
                        $stref = parse_fortran_src( $name, $stref );
                    }
                }
            }

            # Maybe Function calls
            if (   $line !~ /function\s/
                && $line !~ /subroutine\s/
                && $line =~ /(\w+)\(/ )
            {
                my @chunks = ();
                my $cline  = $line;
                while ( $cline =~ /(\w+)\(/ ) {
                    if ( $line !~ /call\s+$1/ ) {
                        push @chunks, $1;
                        $cline =~ s/$1\(//;
                    } else {
                        $cline =~ s/call\s+\w+\(//;
                    }
                }
                for my $chunk (@chunks) {
                    if (
                        exists $stref->{'Subroutines'}{$chunk}
                        and exists $stref->{'Subroutines'}{$chunk}{'Function'}
                       # This means it's the first call to function $chunk in $f
                        and not exists $Sf->{'CalledFunctions'}{$chunk}
                      )
                    {
                        $Sf->{'CalledFunctions'}{$chunk} = 1;
                        print "FOUND FUNCTION CALL $chunk in $f\n" if $V;
                        if ( $chunk eq $f ) {
                            show($srcref);
                            die $line;
                        }
                        $stref->{'Subroutines'}{$chunk}{'Called'} = 1;

# We need to parse the function to detect called functions inside it, unless that has been done
                        if (   not exists $stref->{'Subroutines'}{$chunk}
                            or not
                            exists $stref->{'Subroutines'}{$chunk}{'Status'}
                            or $stref->{'Subroutines'}{$chunk}{'Status'} <
                            $PARSED )
                        {
                            $stref = parse_fortran_src( $chunk, $stref );
                        } else {
                            $stref = add_to_call_tree( $chunk, $stref, $f );
                        }

                        if ( exists $Sf->{'Translate'}
                            and not
                            exists $stref->{'Subroutines'}{$chunk}{'Translate'} )
                        {
                            $stref->{'Subroutines'}{$chunk}{'Translate'} =
                              $Sf->{'Translate'};
                        }

                    }
                }
            }

            $srcref->[$index] = [ $line, $info ];
        }    # loop over all annlines

        #        $Sf->{'CalledSubs'}=\%called_subs;
    }
    return $stref;
}    # END of parse_subroutine_and_function_calls()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Identify the include file as containing params or commons.
# If it contains both, split and call the routine again.
sub _get_commons_params_from_includes {
    ( my $f, my $stref ) = @_;
    my $Sf     = $stref->{'IncludeFiles'}{$f};
    my $srcref = $Sf->{'AnnLines'};
    my $indent = '';

    if ( defined $srcref ) {

        $Sf->{'Parameters'} = {} unless exists $Sf->{'Parameters'};
        $Sf->{'Parameters'}{'OrderedList'} = []
          unless exists $Sf->{'Parameters'}{'OrderedList'};
        $Sf->{'Parameters'}{'Set'} = {}
          unless exists $Sf->{'Parameters'}{'Set'};

        my %vars = %{ $stref->{'IncludeFiles'}{$f}{'Vars'} };

        if ( exists $Sf->{'Vars'}{''} ) { croak "EMPTY VAR! in $f" }
        my $has_pars    = 0;
        my $has_commons = 0;

        for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
            my $line = $srcref->[$index][0];
            my $info = $srcref->[$index][1];
            if ( $line =~ /^\!\s/ ) {
                next;
            }
            $line =~ /^(\s+).*/ && do { $indent = $1; };

            # common /name/ x...
            # However, common/name/x is also valid, damn F77!
            if ( $line =~ /^\s*common\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ ) {
                my $common_block_name = $1;
                my $commonlst         = $2;
                $has_commons = 1;
                my $parsedvars = _parse_F77_vardecl( $commonlst, 0 );
#                die Dumper(%vars) if $f eq 'includeinterpol';
                for my $var ( keys %{$parsedvars} ) {
                    
                    if ( not defined $Sf->{'Vars'}{$var} ) {
                        if (
                            exists $stref->{'Implicits'}{$f}
                            { lc( substr( $var, 0, 1 ) ) } )
                        {
                            print "INFO: common <", $var,
                              "> typed via Implicits for $f\n"
                              if $I; 
                            my $type_kind_shape_attr =
                              $stref->{'Implicits'}{$f}
                              { lc( substr( $var, 0, 1 ) ) };
                            ( my $type, my $array_or_scalar, my $shape, my $attr ) =
                              @{$type_kind_shape_attr};
                            my $indent      = ' ' x 6;
                            my $var_rec = {
                                'Decl' => [ $indent, [$type], [$var], 0 ],
                                'Shape'  => $parsedvars->{$var}{'Shape'},
                                'Type'   => $type,
                                'Attr'   => $attr,
                                'Indent' => '      ', # OBSOLETE
                                'ArrayOrScalar'   => $parsedvars->{$var}{'ArrayOrScalar'}
                            };
                            $Sf->{'Commons'}{$var} = $var_rec;
                            $Sf->{'Vars'}{$var} = $var_rec;
                        } else {
                            print "WARNING: common <", $var,
                              "> is not in {'IncludeFiles'}{$f}{'Vars'}\n"
                              if $W;
                        }
                    } else {
                        
                        print $var, "\t", $Sf->{'Vars'}{$var}{'Type'}, "\n"
                          if $V;
                        if ( exists $parsedvars->{$var}{Shape} and scalar @{$parsedvars->{$var}{Shape}}>0 ) {
                            
                            $Sf->{'Vars'}{$var}{Shape} = $parsedvars->{$var}{Shape};
                            $Sf->{'Vars'}{$var}{ArrayOrScalar}  = 'Array';
                        }
#                        die Dumper($Sf->{'Vars'}{$var})."\n".Dumper($parsedvars->{$var}{Shape}) if $f eq 'includeinterpol' and $var eq 'uprof';
                        $stref->{'IncludeFiles'}{$f}{'Commons'}{$var} =
                          $Sf->{'Vars'}{$var};
                    }
                }
                $srcref->[$index][1]{'Common'} =
                  { 'Name' => $common_block_name };
            }

            # TODO: also, why is this not the same code as above? Refactor!
            #  parameter(ip=150,jp=150,kp=90)
            if ( $line =~ /parameter\s*\(\s*(.*)\s*\)/ ) {
                my $parliststr = $1;
                $has_pars = 1;
                my @partups = split( /\s*,\s*/, $parliststr );
                my %pvars =
                  map { split( /\s*=\s*/, $_ ) }
                  @partups;    # Perl::Critic, EYHO # s/\s*=.+//; $_
                my @var_vals =
                  map { ( my $k, my $v ) = split( /\s*=\s*/, $_ ); [ $k, $v ] }
                  @partups;    # Perl::Critic, EYHO
                my @pvarl = map { s/\s*=.+//; $_ } @partups;
                my @pars  = ();
                my $type  = 'Unknown';

                for my $var (@pvarl) {

                    if (    not defined $Sf->{'Vars'}{$var}
                        and not exists $Sf->{'Parameters'}{'Set'}{$var} )
                    {
                        print
"WARNING: PARAMETER $var not declared in $f (Parser::_get_commons_params_from_includes)\n"
                          if $W;
                    }
                    if ( $pvars{$var} =~ /^\d*/ ) {
                        $type = 'integer';
                    } elsif ( $pvars{$var} =~ /^[\d\.]+/ ) {    # FIXME: weak
                        $type = 'real';
                    }
                    $Sf->{'Parameters'}{'Set'}{$var} = {
                        'Type' => $type,
                        'Var'  => $Sf->{'Vars'}{$var},
                        'Val'  => $pvars{$var}
                    };
                    push @pars, $var;
                }
                @{ $Sf->{'Parameters'}{'OrderedList'} } =
                  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @pars );
                $srcref->[$index][1]{'ParamDecl'} =
                  [ $indent, [ $type, '', [], 'parameter' ], [@var_vals], 0 ]
                  ;    # F77-style parameters in include file
            } elsif ( $line =~ /,\s*parameter\s*.*?::\s*(\w+)\s*=\s*(.+?)\s*$/ )
            {          # F95-style parameters
                my $type = $line;
                $type =~ s/^\s+//;
                $type =~ s/\s*\:\:.*$//;
                my $parliststr = $1;
                $has_pars = 1;
                my @partups = split( /\s*,\s*/, $parliststr );
                my %pvars =
                  map { split( /\s*=\s*/, $_ ) } @partups;  # Perl::Critic, EYHO
                my @pvarl = map { s/\s*=.+//; $_ } @partups;
                my @pars = ();

                for my $var (@pvarl) {
                    if ( not defined $Sf->{'Vars'}{$var} ) {
                        print
"WARNING: PARAMETER $var not declared in $f (F95-style)\n"
                          if $W;
                    } else {
                        $Sf->{'Parameters'}{'Set'}{$var} = {
                            'Type' => $type,
                            'Var'  => $Sf->{'Vars'}{$var},
                            'Val'  => $pvars{$var}
                        };
                        push @pars, $var;
                    }
                }
                @{ $Sf->{'Parameters'}{'OrderedList'} } =
                  ( @{ $Sf->{'Parameters'}{'OrderedList'} }, @pars );
                $srcref->[$index][1]{'ParamDecl'} =
                  [@pars];    # F95-style parameters in include file

            }

            $srcref->[$index] = [ $line, $info ];
        }    # loop over annlines

        if ($V) {
            print "\nCOMMONS for $f:\n\n";
            for my $v ( sort keys %{ $Sf->{'Commons'} } ) {
                print $v, "\n";
            }
        }

        $Sf->{'Vars'} = {%vars};

        # FIXME!
        # An include file should basically only contain parameters and commons.
        # If it contains commons, we should remove them!
        if ( $has_commons && $has_pars ) {
            print
"INFO: The include file $f contains both parameters and commons, attempting to split out params_$f.\n"
              if $I;
            $Sf->{'InclType'} = 'Both';
            $stref = __split_out_parameters( $f, $stref );
            $has_pars = 0;

        # What we should do is split this split out parameters into params_$name
        # and include params_$name in $name

        } elsif ($has_commons) {
            $Sf->{'InclType'} = 'Common';
        } elsif ($has_pars) {
            $Sf->{'InclType'} = 'Parameter';
        } else {
            $Sf->{'InclType'} = 'None';
        }

# Checking if any variable encountered in the include file is either a Parameter or Common var
        for my $var ( keys %vars ) {
            my $is_not_par = $has_pars && !exists( $Sf->{'Parameters'}{'Set'}{$var} );
            my $is_not_common =
              $has_commons && !exists( $Sf->{'Commons'}{$var} );
            if ( $is_not_par or $is_not_common ) {
                for my $annline ( @{ $Sf->{'AnnLines'} } ) {
                    next
                      if $annline->[0] eq ''
                          or exists $annline->[1]{'Comments'};
                    if ( $annline->[0] =~ /\W$var\W/ ) {
                        my $info =
                          $is_not_par
                          ? "$f has params but $var is not a param"
                          : "$f has commons but $var is not common";
                        warn
"WARNING: Parser: $info on the following line in $f:\n";
                        warn $annline->[0], "\n";
                    }
                }
                print
"WARNING: The include $f contains a variable <$var> that is neither a parameter nor a common variable, this is not supported\n"
                  if $W;
            }
        }
#        die Dumper(keys %{$Sf} ) if $f eq 'includecom';
    }
    return $stref;
}    # END of get_commons_params_from_includes()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Proper FSM parser for F77 variable declarations (apart from the type)
# So this parses the expressions used for the dimensions, but also length
# For example
# integer*(4) a(3+(2*i),j,-k:k+10)

sub _parse_F77_vardecl {
    ( my $varlst, my $T ) = @_;

    print "VARLST: <$varlst>\n" if $T;

    # parse varlst into this hash
    my $vars = {};

    #  We need following states:
    my (
        $do_nothing,     # 0
        $read_var,       # 1
        $store_var,      # 2
        $found_len,      # 3
        $read_len,       # 4
        $store_len,      # 5
        $found_shape,    # 6
        $read_shape,     # 7
        $store_shape     # 8
    ) = 0 .. 8;

    my @states = qw(
      do_nothing
      read_var
      store_var
      found_len
      read_len
      store_len
      found_shape
      read_shape
      store_shape
    );

    # initial state
    my $st = $do_nothing;

    # inside read_shape, we need a parenthesis counter:
    my $nest_count = 0;

    my $var   = '';
    my $pvar  = '';
    my $shape = '';
    my $len   = '';
    my $pc    = '';

    for my $c ( split( '', $varlst ) ) {

        my $pst = $st;    # previous state, for testing only

#### The transitions are:

        if ( $st == $do_nothing ) {
            if ( $c =~ /[a-z]/ ) { $st = $read_var }
            elsif ( $c eq '*' ) { $st = $read_len; next; }
            elsif ( $c eq '(' ) { $st = $found_shape; $nest_count = 0 }
        } elsif ( $st == $read_var && $c =~ /\W/ ) {
            $st = $store_var;
        } elsif ( $st == $store_var ) {
            if ( $pc eq '*' ) {
                $st = $read_len;
            } elsif ( $pc eq '(' ) {
                $st         = $read_shape;
                $nest_count = 0;
            } elsif ( $c eq '(' ) {
                $st         = $found_shape;
                $nest_count = 0;
            } elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
                $st = $read_var;
            } else {
                $st = $do_nothing;
            }
        } elsif ( $st == $read_len && $c =~ /[\s,]/ ) {
            $st = $store_len;
        } elsif ( $st == $store_len ) {
            if ( $pc eq ',' && $c =~ /[a-z]/ ) {
                $st = $read_var;
            } else {
                $st = $do_nothing;
            }
        } elsif ( $st == $found_len ) {
            $st = $read_len;
        } elsif ( $st == $found_shape ) {
            if ( $c eq ')' ) {
                $st = $store_shape;
            } else {
                $st = $read_shape;
            }
        } elsif ( $st == $read_shape && $nest_count <= 0 && $c eq ')' ) {
            $st = $store_shape;
        } elsif ( $st == $store_shape ) {
            if ( $c eq '*' ) {
                $st = $found_len;
            } elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
                $st = $read_var;
            } else {
                $st = $do_nothing;
            }
        }
        print
" PC: $pc; C:$c; NC: $nest_count; ST: $states[$st]; PST: $states[$pst]\n"
          if $T;

##### The actions are:
        if    ( $st == $read_var ) { $var .= $c }
        elsif ( $st == $read_len ) { $len .= $c }

        #    elsif ($st==$found_shape) {$shape.=$c;}
        elsif ( $st == $read_shape ) {
            $shape .= $c;
            if    ( $c eq '(' ) { $nest_count++; }
            elsif ( $c eq ')' ) { $nest_count--; }
        } elsif ( $st == $store_var ) {
            print "VAR:[$var]\n" if $T;
            if ( $var eq '' ) { croak $varlst }
            $vars->{$var}{'ArrayOrScalar'}  = 'Scalar';
            $vars->{$var}{'Shape'} = [];
            $pvar                  = $var;
            $var                   = '';
        } elsif ( $st == $store_len ) {
            print "LEN: {$len}\n" if $T;
            $vars->{$pvar}{'Attr'} = $len;
            $len = '';
        } elsif ( $st == $store_shape ) {
            print "SHAPE: <$shape>\n" if $T;
            $shape =~ s/^\s+//;
            $shape =~ s/\s+$//;
            my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
            my @shape = ();
            for my $range (@ranges) {
                if ( $range =~ /:/ ) {
                    push @shape, split( /:/, $range );
                } else {
                    push @shape, ( '1', $range );
                }
            }
            $vars->{$pvar}{'Shape'} = [@shape];
            $vars->{$pvar}{'ArrayOrScalar'}  = 'Array';
            $shape                  = '';
        }
        $pc = $c;

    }
    if ($T) {
        print "VAR: $var\n";
        print "PVAR: $var\n";
        print "SHAPE: $shape\n";
        print "LEN: $len\n";
        print "STATE: $states[$st]\n";
    }
#### Pending actions on end of string

    if ( $st == $read_var && $var ne '' ) {
        $vars->{$var} = { 'Shape' => [], 'ArrayOrScalar' => 'Scalar' };
    } elsif ( $st == $read_len && $pvar ne '' ) {
        $vars->{$pvar}{'Attr'} = $len;
    } elsif ( $st == $read_shape && $pvar ne '' ) {
        $shape =~ s/^\s+//;
        $shape =~ s/\s+$//;
        my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
        my @shape = ();
        for my $range (@ranges) {
            if ( $range =~ /:/ ) {
                push @shape, split( /:/, $range );
            } else {
                push @shape, ( '1', $range );
            }
        }
        $vars->{$pvar}{'Shape'} = [@shape];
        $vars->{$pvar}{'ArrayOrScalar'}  = 'Array';
    }

    return $vars;
}    # END of _parse_F77_vardecl()
# -----------------------------------------------------------------------------
# TODO: check if this works for F95-style parameters too
sub __split_out_parameters {
    ( my $f, my $stref ) = @_;
    my $Sf          = $stref->{'IncludeFiles'}{$f};
    my $srcref      = $Sf->{'AnnLines'};
    my $param_lines = [];
    my $nsrcref     = [];
    my $nindex      = 0;
    my $nidx_offset = 0;
    push @{$nsrcref},
      [
        "      include 'params_$f'",
        { 'Include' => { 'Name' => "params_$f", 'InclType' => 'Parameter' } }
      ];

    for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
        $nindex = $index + $nidx_offset;
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        if ( exists $info->{'ParamDecl'} ) {
            push @{$param_lines},
              [ $line, { 'ParamDecl' => [ @{ $info->{'ParamDecl'} } ] } ]
              ;    # split out parameters from 'Common' include file
            delete $srcref->[$index][1]
              {'ParamDecl'};   # split out parameters from 'Common' include file
            $srcref->[$index][1]{'Comment'} = 1;
            $srcref->[$index][0] = '! ' . $srcref->[$index][0];
        }
        push @{$nsrcref}, $srcref->[$index];
    }
    $stref->{'IncludeFiles'}{$f}{'AnnLines'}          = $nsrcref;
    $stref->{'IncludeFiles'}{$f}{'ParamInclude'}="params_$f"; 
    $stref->{'IncludeFiles'}{"params_$f"}             = {};
    $stref->{'IncludeFiles'}{"params_$f"}{'AnnLines'} = $param_lines;
    $stref->{'IncludeFiles'}{"params_$f"}{'InclType'} = 'Parameter';
    $stref->{'IncludeFiles'}{$f}{'InclType'}          = 'Common';
    $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'} =
      dclone( $stref->{'IncludeFiles'}{$f}{'Parameters'} );
    delete $stref->{'IncludeFiles'}{$f}{'Parameters'};

    #    die Dumper( $stref->{'IncludeFiles'}{"$f"}{'RefactorGlobals'} );
    $stref->{'IncludeFiles'}{"params_$f"}{'Root'}   = $f;
    $stref->{'IncludeFiles'}{"params_$f"}{'Source'} = 'Virtual';   #"params_$f";
    $stref->{'IncludeFiles'}{"params_$f"}{'Status'} = $PARSED;
    $stref->{'IncludeFiles'}{"params_$f"}{'RefactorGlobals'} = $NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'HasBlocks'}       = $NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'FStyle'} =
      $stref->{'IncludeFiles'}{$f}{'FStyle'};
    $stref->{'IncludeFiles'}{"params_$f"}{'FreeForm'} =
      $stref->{'IncludeFiles'}{$f}{'FreeForm'};

    #    die Dumper($stref->{'IncludeFiles'}{"params_$f"});
    return $stref;
}    # END of __split_out_parameters
# -----------------------------------------------------------------------------
sub _parse_implicit {
    ( my $line, my $f, my $stref ) = @_;

    # 1. test for compound, bail out
    my $tline = $line;
    while ( $tline =~ /\(/ ) {
        $tline =~ s/\(.+?\)//;
    }
    if ( $tline =~ /,/ ) {
        die
"Sorry, no support for combined implicit declarations, please split them over multiple lines -- or better, use proper typing!\n";
    }

    # 2. Get the spec and turn into a regexp
    my $type = 'Unknown';
    my $array_or_scalar =
      'Scalar';    # by default. If it is Array, need the size, so need a shape
    
    my $attr  = '';
    my $patt  = '.+';

    # IMPLICIT REAL(KIND=8)(d),COMPLEX(8)(z) => this is WEAK!
    if ( $line =~ /implicit\s+(\w.+)\((.+?)\)\((.+?)\)/ ) {
        $type = $1;
        $attr = $2;
#        $array_or_scalar =~ s/\s*kind\s*=\s*//i;    # strip "kind="
#        $shape = [ '1', $array_or_scalar ];         # FIXME only works for 1-D array
#        $array_or_scalar  = 'Array';
        $patt  = $3;
        $patt =~ s/,/|/g;
        $patt =~ s/(\w\-\w)/[$1]/g;
    } elsif ( $line =~ /implicit\s+(\w.+)\((.+?)\)/ ) {
        $type = $1;
        $patt = $2;
        if ( $type =~ /\*/ ) {
            ( $type, $attr ) = split( /\*/, $type );    # WEAK!
            if ( $attr eq '(' ) { $attr = '(*)' }
            else {
                $attr = "(kind=$attr)";
            }
        }
        $patt =~ s/,/|/g;
        $patt =~ s/(\w\-\w)/[$1]/g;
    }

    # 3. Generate the lookup table
    my %implicit_type_lookup = ();
    if ( exists $stref->{'Implicits'} and exists $stref->{'Implicits'}{$f} ) {
        %implicit_type_lookup = %{ $stref->{'Implicits'}{$f} };
    }
    for my $c ( 'a' .. 'z' ) {
        if ( $c =~ /($patt)/ ) {
            $implicit_type_lookup{$c} = [ $type, $array_or_scalar, $attr ];
        }
    }
    $stref->{'Implicits'} = {} unless exists $stref->{'Implicits'};
    $stref->{'Implicits'}{$f} = {%implicit_type_lookup};
    return $stref;
}    # END of _parse_implicit()
# -----------------------------------------------------------------------------
sub __separate_into_blocks {
    ( my $stref, my $blocksref, my $f ) = @_;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref )
      ;    # This is not a misnomer as it can also be a module.
    my $Sf       = $stref->{$sub_or_func_or_mod}{$f};
    my $srcref   = $Sf->{'AnnLines'};
    my $in_block = 0;

    # Initial settings
    my $block = 'OUTER';

    for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];

        if (
            $line =~ /^\!\s+BEGIN\sSUBROUTINE\s(\w+)/
            or $line =~ /^\!\s*\$(?:ACC|RF4A)\s+(?:Subroutine|KernelWrapper)\s+(\w+)/i
          )
        {
            $in_block = 1;
            $block    = $1;
            print "FOUND BLOCK $block\n" if $V;

            # Enter the name of the block in the metadata for the line
            $info->{'RefactoredSubroutineCall'}{'Name'} = $block;
            $info->{'SubroutineCall'}{'Name'}           = $block;
            delete $info->{'Comments'};
            $info->{'BeginBlock'}{'Name'} = $block;

            # Push the line with the pragma onto the list of 'OUTER' lines
            push @{ $blocksref->{'OUTER'}{'AnnLines'} },
              [ "! *** Refactored code into $block ***", {} ];

           # Push the line with the pragma onto the list of lines for the block,
           # to be replaced by function signature
            push @{ $blocksref->{$block}{'AnnLines'} },
              [
                "! *** Original code from $f starts here ***",
                { 'RefactoredSubroutineCall' => { 'Name' => $block } }
              ];

            $blocksref->{$block}{'BeginBlockIdx'} = $index;
            next;
        }
        if (   $line =~ /^\!\s+END\sSUBROUTINE\s(\w+)/
            or $line =~
            /^\!\s*\$(?:ACC|RF4A)\s+end\s(?:subroutine|kernelwrapper)\s(\w+)/i )
        {
            $in_block = 0;
            $block    = $1;

            # Push end-of-block pragma onto 'OUTER'
            push @{ $blocksref->{'OUTER'}{'AnnLines'} }, [ $line, {} ];

            # Push 'end' onto the list of lines for the block,
            push @{ $blocksref->{$block}{'AnnLines'} }, [ '      end subroutine '.$block, $info ]; 

     # Add info to %blocks.
     #            push @{ $blocksref->{$block}{'Info'} }, $Sf->{'Info'}[$index];
     #            $Sf->{'Info'}[$index]{'EndBlock'}{'Name'} = $block;
            $info->{'EndBlock'}{'Name'} = $block;
            $blocksref->{$block}{'EndBlockIdx'} = $index;
            next;
        }
        if ($in_block) {

            # Push the line onto the list of lines for the block
            push @{ $blocksref->{$block}{'AnnLines'} }, [ $line, $info ];

            # and the index onto Info in %blocks and $Sf
            #            push @{ $blocksref->{$block}{'Info'} }, $info;
            $info->{'InBlock'}{'Name'} = $block;
        } else {
            # Other lines go onto 'OUTER'
            push @{ $blocksref->{'OUTER'}{'AnnLines'} }, [ $line, $info ];
        }
        $srcref->[$index] = [ $line, $info ];
    }    # loop over annlines
    return ( $stref, $blocksref );
}    # END of __separate_into_blocks()
# -----------------------------------------------------------------------------
sub __create_new_subroutine_entries {
    ( my $stref, my $blocksref, my $f ) = @_;

    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );      
    my $Sf = $stref->{$sub_or_func_or_mod}{$f};

    for my $block ( keys %{$blocksref} ) {
#        say "\tBLOCK: $block";
        die "EMPTY block name $block" if $block eq '';
        next if $block eq 'OUTER';
        if ( not exists $stref->{'Subroutines'}{$block} ) {
            $stref->{'Subroutines'}{$block} = {};
            $stref->{'Subroutines'}{$block}{'Source'} = "./$block.f95"; #$Sf->{'Source'};
        } elsif ( exists $stref->{'Subroutines'}{$block}{'Translate'} ) {
            if ( $stref->{'Subroutines'}{$block}{'Translate'} eq 'C' ) {
                $stref->{'Subroutines'}{$block}{'Source'} = "./$block.f95";
                $stref = add_to_C_build_sources( $block, $stref );
            } else {
                croak '!$acc translate (' 
                  . $block . ') '
                  . $stref->{'Subroutines'}{$block}{'Translate'}
                  . ": Only C translation through F2C_ACC is currently supported.\n";
            }
        }
        my $Sblock = $stref->{'Subroutines'}{$block};
        $Sblock->{'AnnLines'} = [ @{$blocksref->{$block}{'AnnLines'}} ]; # a copy
        my $line_id=0;
        for my $annline (@{$Sblock->{'AnnLines'} } ) {
            $annline->[1]{'LineID'}=$line_id++;
        }
        
        $stref->{'SourceContains'}{ "./$block.f95" }{$block} = 'Subroutines'; # was $Sf->{'Source'}
        $Sblock->{'RefactorGlobals'}                          = 1;
        $stref->{'Subroutines'}{$block}                       = $Sblock;
        if ( $Sf->{'RefactorGlobals'} == 0 ) {
            $Sf->{'RefactorGlobals'} = 2;
        } else {

            #			die "$f => $block ".'BOOM!'.Dumper($Sf->{'RefactorGlobals'});
            print
              "INFO: RefactorGlobals==1 for $f while processing BLOCK $block\n" if $I;
        }
        
         $Sblock->{'Program'} = 0;
         $Sblock->{'FStyle'} = $Sf->{'FStyle'};
         $Sblock->{'FreeForm'} = $Sf->{'FreeForm'};
         $Sblock->{'Recursive'} = 0;
        
#        $stref = _analyse_lines( $block, $stref );
    }
    return $stref;
}    # END of __create_new_subroutine_entries()
# -----------------------------------------------------------------------------
sub __find_vars_in_block {
    ( my $blocksref, my $varsref, my $occsref ) = @_;
    my $itersref={};
    for my $block ( keys %{$blocksref} ) {
        $itersref->{$block}=[];
        my @annlines = @{ $blocksref->{$block}{'AnnLines'} };
        my %tvars = %{$varsref};    # Hurray for pass-by-value!
        
        print "\nVARS in $block:\n\n" if $V;
        for my $annline (@annlines) {
            
            (my $tline, my $info) = @{$annline};            
            if (exists $info->{'Do'}) {
                my $iter = $info->{'Do'}{'Iterator'};
                push @{$itersref->{$block}},$iter;
                delete $tvars{$iter};
             # Bit of a hack: I simply join the range expressions
                $tline =join(',',@{$info->{'Do'}{'Range'}});
            } else {
            $tline =~ s/\'.+?\'//;    # FIXME: looks like a HACK!
            }
            for my $var ( sort keys %tvars ) {
                if ( $tline =~ /\b$var\b/ ) {
                    print "FOUND $var\n" if $V;                    
                    $occsref->{$block}{$var} = $var;
                    delete $tvars{$var};
                }
            }
            
        }
    }
    return [$occsref, $itersref];
}    # END of __find_vars_in_block()
# -----------------------------------------------------------------------------
# TODO: see if this can be separated into shorter subs
sub __construct_new_subroutine_signatures {
    ( my $stref, my $blocksref, my $occsref, my $itersref, my $varsref, my $f ) = @_;
#    local $V = 1;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref )
      ;    # This is not a misnomer as it can also be a module.
    my $Sf     = $stref->{$sub_or_func_or_mod}{$f};
    my $srcref = $Sf->{'AnnLines'};

    my %args = ();

    for my $block ( keys %{$blocksref} ) {
        next if $block eq 'OUTER';        
        my $Sblock = $stref->{'Subroutines'}{$block};
        print "\nARGS for BLOCK $block:\n" if $V;
        $args{$block} =[];
        # Collect args for new subroutine
        for my $var ( sort keys %{ $occsref->{$block} } ) {
            if ( exists $occsref->{'OUTER'}{$var} ) {
                print "$var\n" if $V;
                
                push @{ $args{$block} }, $var;
            } 
            $Sblock->{'Vars'}{$var} = $varsref->{$var
              }; # FIXME: this is "inheritance, but in principle a re-parse is better?"
        }
        $Sblock->{'Args'}{'List'} = $args{$block} ;

        # Create Signature and corresponding Decls
        my $sixspaces = ' ' x 6;
        my $sig       = $sixspaces . 'subroutine ' . $block . '(';
        my $sigrec    = [ $sixspaces, $block, $args{$block} ];
 
        for my $argv ( @{ $args{$block} } ) {
            $sig .= "$argv,";
            my $decl = format_f95_var_decl( $Sf, $argv );    
            $decl->[0] .= $sixspaces;
            $Sf->{'Vars'}{$argv}{'Decl'} = $decl;
        }
        if ( @{ $args{$block} } ) {
            $sig =~ s/\,$/)/s;
        } else {
            $sig .= ')';
        }

        # Add variable declarations and info to line
        # Here we know the vardecls have been formatted.
        my $sigline = shift @{ $Sblock->{'AnnLines'} }; # This is the line that says "! *** Original code from $f starts here ***" 
        
        for my $iters ($itersref->{$block}) {
            for my $iter (@{ $iters } ) {
                 my $decl = format_f95_var_decl( $stref,$f,$iter ); 
             unshift @{ $Sblock->{'AnnLines'} },
              [ emit_f95_var_decl($decl), { 'VarDecl' => $decl } ];
            }
        }

        for my $argv ( @{ $args{$block} } ) {
            my $decl = format_f95_var_decl( $stref,$f,$argv );
            say '__construct_new_subroutine_signatures: '. __LINE__ . ' : '.Dumper( $Sf->{'Vars'}{$argv} ) if $argv eq 'indzindicator';
#            my $decl = _vars_entry_to_vardecl( $Sf->{'Vars'}{$argv} ); # $Sf->{'Vars'}{$argv}{'Decl'}            
            unshift @{ $Sblock->{'AnnLines'} },
              [ emit_f95_var_decl($decl), { 'VarDecl' => $decl } ];
        }
        unshift @{ $Sblock->{'AnnLines'} }, $sigline;

        # Now also add include statements and the actual sig to the line

        $Sblock->{'AnnLines'}[0][1] = {};
        for my $inc ( keys %{ $Sf->{'Includes'} } ) {
            $Sblock->{'Includes'}{$inc} = 1;
            unshift @{ $Sblock->{'AnnLines'} },
              [ "      include '$inc'", { 'Include' => { 'Name' => $inc } } ]
              ;                                   # add new lines at the front

            $Sblock->{'Includes'}{$inc} = 1;
        }
        unshift @{ $Sblock->{'AnnLines'} },[ $sig, { 'SubroutineSig' => $sigrec } ]; 
         # And finally, in the original source, replace the blocks by calls to the new subs

        #        print "\n-----\n".Dumper($srcref)."\n-----";
        for my $tindex ( 0 .. scalar( @{$srcref} ) - 1 ) {
            if ( $tindex == $blocksref->{$block}{'BeginBlockIdx'} ) {
                $sig =~ s/subroutine/call/;
                $srcref->[$tindex][0] = $sig;
            } elsif ( $tindex > $blocksref->{$block}{'BeginBlockIdx'}
                and $tindex <= $blocksref->{$block}{'EndBlockIdx'} )
            {
                $srcref->[$tindex][0] = '';
                $srcref->[$tindex][1]{'Deleted'} = 1;
            }
        }

#        unshift @{ $Sblock->{'Info'} }, $fl; # put the comment back at the front, no change to the lines

#        $Sblock->{'AnnLines'}[0][1] = $fal;

        #		print "YES! GENERATED DECLS ARE WRONG!!!\n";die;
        if ($V) {
            print 'SIG:' . $sig, "\n";

            #			print join( "\n", @{$decls} ), "\n";
        }
        $Sblock->{'Status'} = $READ;
#die 'BOOM:'.Dumper($Sblock->{'AnnLines'});
    }
    
    return $stref;
}    # END of __construct_new_subroutine_signatures()
# -----------------------------------------------------------------------------
sub __reparse_extracted_subroutines { (my $stref, my $blocksref) = @_;
    delete $blocksref->{'OUTER'};
    for my $block (keys %{$blocksref}) {
        $stref = parse_fortran_src($block, $stref);
    } 
    return $stref;
}
# -----------------------------------------------------------------------------
sub _split_multivar_decls { (my $f, my $stref) = @_;
        
    my $sub_func_incl_or_mod = sub_func_incl_mod( $f, $stref );
#         if ($f eq 'includeinterpol') {
#         say Dumper($stref->{$sub_func_incl_or_mod}{$f});
#         die;
#     }
    
    my $Sf = $stref->{$sub_func_incl_or_mod}{$f};    
    my $annlines = $Sf->{'AnnLines'};
    my $nextLineID = scalar @{$annlines}+1;
    my $new_annlines=[];
    for my $annline (@{$annlines}) {
        (my $line, my $info)=@{$annline};
        if (exists $info->{'VarDecl'} and scalar @{$info->{'VarDecl'}[2]}>1) {
                   
#            if ($line=~/drydeposit/) { die $line.Dumper($info) }
#            say scalar @{$info->{'VarDecl'}[2]};
            my @nvars = @{$info->{'VarDecl'}[2]};
            for my $var (@{$info->{'VarDecl'}[2]}) {
                my %rinfo = %{$info};
#                say "VAR: $var";
                $rinfo{'LineID'} =$nextLineID++;
# VarDecl                
#                [ $indent,[$type, $attr, [$start,$end] , $intent ],[$var],0]
# Vars   
#{
#  'Decl' => [
#              $indent,
#              [
#                $type
#              ],
#              [
#                $var
#              ],
#              0
#            ],
#  'Shape' => [
#               $start,
#               $end
#             ],
#  'Type' => $type,
#  'Attr' => $attr,
#  'Indent' => $indent,
#  'ArrayOrScalar' => 'Array'|'Scalar'
#}
             
                $rinfo{'VarDecl'}=[];
                $rinfo{'VarDecl'}[0]=$info->{'VarDecl'}[0]; # Indent
                $rinfo{'VarDecl'}[1]=[]; 
                $rinfo{'VarDecl'}[1][0]=$Sf->{'Vars'}{$var}{'Decl'}[1][0]; # Type
                $rinfo{'VarDecl'}[1][1]=$Sf->{'Vars'}{$var}{'Attr'}; # Attr
                $rinfo{'VarDecl'}[1][2]= [@{$Sf->{'Vars'}{$var}{'Shape'}}]; # Copy of Shape to Dim
                $rinfo{'VarDecl'}[2]=[$var];
                $rinfo{'VarDecl'}[3]=0;
                my $rline=$line;
                $Sf->{'Vars'}{$var}{'Decl'}[2]=[$var];
#                die Dumper($rinfo{'VarDecl'}) if $var eq 'drydeposit';
                for my $nvar (@nvars) {
                     if ($nvar ne $var) {
#                    say "NVAR: $nvar";
                    if ($rline=~/\s*,\s*$nvar\([^\(]+\)\W?/) {
                        $rline=~s/\s*,\s*$nvar\([^\(]+\)(\W?)/$1/;
                    } elsif ($rline=~/(\W)$nvar\([^\(]+\)\s*,\s*/) {
                        $rline=~s/(\W)$nvar\([^\(]+\)\s*,\s*/$1/;
                    } elsif ($rline=~/\s*,\s*$nvar\*\d+\W?/) {
                        $rline=~s/\s*,\s*$nvar\*\d+(\W?)/$1/;
                    } elsif ($rline=~/(\W)$nvar\*\d+\s*,\s*/) {
                        $rline=~s/(\W)$nvar\*\d+\s*,\s*/$1/;
                    } elsif ($rline=~/\W$nvar\s*,\s*/) {
                        $rline=~s/(\W)$nvar\s*,\s*/$1/;
                    } elsif ($rline=~/\s*,\s*$nvar\W?/) {
                    $rline=~s/\s*,\s*$nvar(\W?)/$1/;
                    }                     
#                    $rline=~s/,,/,/;
                     }
                }                
#                say "\t$rline".Dumper(%rinfo) if $rline=~/drydeposit/;
                push @{$new_annlines}, [$rline, \%rinfo];
            }        
        } else {            
            push @{$new_annlines}, $annline;
        }
    }
    $Sf->{'AnnLines'}=$new_annlines;
    
    return $stref;
} # END of _split_multivar_decls
# -----------------------------------------------------------------------------
sub _split_multipar_decls_and_set_type { (my $f, my $stref) = @_;
        
    my $sub_func_incl_or_mod = sub_func_incl_mod( $f, $stref );
    
    my $Sf = $stref->{$sub_func_incl_or_mod}{$f};    
    my $annlines = $Sf->{'AnnLines'};
    my $nextLineID = scalar @{$annlines}+1;
    my $new_annlines=[];
    for my $annline (@{$annlines}) {
        (my $line, my $info)=@{$annline};
    if (exists $info->{'ParamDecl'}  ) {
#            die $line. "\n".Dumper($info->{'ParamDecl'})."\n".Dumper($Sf->{'Parameters'}{'Set'}{maxpart});
#['      ',['integer','',[],'parameter'],[['pi','3.14159265'],['r_earth','6.371e6'],['r_air','287.05'],['ga','9.81']],0]
#{'Type' => 'integer',
#    'Val' => '1000000',
#    'Var' => {
#        'Decl' => ['      ',['integer'],['maxpart'],0],
#        'Shape' => [],
#        'Type' => 'integer',
#        'Attr' => '',
#        'Indent' => '      ',
#        'ArrayOrScalar' => 'Scalar'}
#        } 
#            say 'LINE: '.$line;
        if (scalar @{$info->{'ParamDecl'}[2]}==1) {
#            say 'LINE1: '.$line;
            my $var = $info->{'ParamDecl'}[2][0][0];
            if ($info->{'ParamDecl'}[1][0] eq 'Unknown') {
                my $type = $Sf->{'Parameters'}{'Set'}{$var}{'Var'}{'Decl'}[1][0];
                $info->{'ParamDecl'}[1][0] = $type;
                $Sf->{'Parameters'}{'Set'}{$var}{'Type'} = $type;
            }
            push @{$new_annlines}, [$line, $info];
        } elsif (   scalar @{$info->{'ParamDecl'}[2]}>1 ) {
            my @nvars = @{$info->{'ParamDecl'}[2]};
            for my $var_val (@{$info->{'ParamDecl'}[2]}) {
                my $var = $var_val->[0];
                my $val = $var_val->[1];
#                say "\nORIG LINE: $line";
#                say "$f: PAR: $var: ".Dumper($info->{'ParamDecl'})."\n".Dumper($Sf->{'Parameters'}{'Set'}{$var});
                my %rinfo = %{$info};
                $rinfo{'LineID'} =$nextLineID++;
                $rinfo{'ParamDecl'}=[];
                $rinfo{'ParamDecl'}[0]=$info->{'ParamDecl'}[0];
                $rinfo{'ParamDecl'}[1]=[];
                if (ref($Sf->{'Parameters'}{'Set'}{$var}{'Var'}) ne 'HASH') {
                    $rinfo{'ParamDecl'}[1][0]=$info->{'ParamDecl'}[1][0];
                     
                    $rinfo{'ParamDecl'}[1][1]='';
                    $rinfo{'ParamDecl'}[1][2]= [];                    
                } else {
                $rinfo{'ParamDecl'}[1][0]=$Sf->{'Parameters'}{'Set'}{$var}{'Var'}{'Decl'}[1][0]; # Type
                $rinfo{'ParamDecl'}[1][1]=$Sf->{'Parameters'}{'Set'}{$var}{'Var'}{'Attr'}; # Attr
                $rinfo{'ParamDecl'}[1][2]= [@{$Sf->{'Parameters'}{'Set'}{$var}{'Var'}{'Shape'}}]; # Copy of Shape to Dim
                }
                $rinfo{'ParamDecl'}[1][3]= 'parameter';
                $rinfo{'ParamDecl'}[2]=[[$var,$val]];
                $rinfo{'ParamDecl'}[3]=0;
                
                my $rline=$line;
                
                for my $nvar_vals (@nvars) {
                    my $nvar = $nvar_vals->[0];
                     if ($nvar ne $var) {
                         my $nval = $Sf->{'Parameters'}{'Set'}{$nvar}{'Val'};
#                    say "NPAR: $nvar = $nval";
# TODO: WEAK we only support scalars parnam=parval
                    if ($rline=~/\s*,\s*$nvar\s*=\s*$nval\W?/) {
                        $rline=~s/\s*,\s*$nvar\s*=\s*$nval(\W?)/$1/;
                    } elsif ($rline=~/(\W)$nvar\s*=\s*$nval\s*,\s*/) {
                        $rline=~s/(\W)$nvar\s*=\s*$nval\s*,\s*/$1/;
                    }                     
                     }
                }                
#                say "\t$rline";
#                say Dumper($rinfo{ParamDecl});
#                die if $f eq 'f_esl';
                push @{$new_annlines}, [$rline, \%rinfo];        
            }    
            }
        } else {            
            push @{$new_annlines}, $annline;
        }
    }
    $Sf->{'AnnLines'}=$new_annlines;
#     if ($f eq 'includepar') {
#         say show_annlines($stref->{$sub_func_incl_or_mod}{$f}{AnnLines});
#         die;
#     }
    return $stref;
} # END of _split_multipar_decls_and_set_type

# -----------------------------------------------------------------------------
# So, the problem with VarDecl is that it assumes all vars on a line have the same decl, but this is not true for the shape in F77!
# A quick fix is to extend the $shape to [$shape]
# The function below is for use after the var decl lines have been split so it should be fine.


#[
#  '      ',
#  [
#    'real',
#    '',
#    [
#      '1',
#      'maxspec'
#    ]
#  ],
#  [
#    'drydeposit'
#  ],
#  0
#]

sub _vars_entry_to_vardecl {
    (my $vars_entry) =@_;
    if ($vars_entry->{'Decl'}[-1] == 1) { return $vars_entry->{'Decl'} } else { 
#{
#  'Decl' => [
#              $indent,
#              [
#                $type
#              ],
#              [
#                $var
#              ],
#              0
#            ],
#  'Shape' => [
#               $start,
#               $end
#             ],
#  'Type' => $type,
#  'Attr' => $attr,
#  'Indent' => $indent,
#  'ArrayOrScalar' => 'Array'|'Scalar'
#}    
    my $indent = $vars_entry->{'Indent'};
    my $type = $vars_entry->{'Type'};
    my $attr = $vars_entry->{'Attr'};
    my $shape = $vars_entry->{'Shape'};
#    (my $start, my $end) = @{ $shape };
    
    my $var = $vars_entry->{'Decl'}[2][0];
    return [ $indent,[$type, $attr, $shape , [] ],[$var],0];
    }
}
# -----------------------------------------------------------------------------
1;

