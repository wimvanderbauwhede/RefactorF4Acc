package RefactorF4Acc::Emitter;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers
  qw( create_refactored_source get_annotated_sourcelines stateful_pass stateless_pass
  emit_f95_var_decl
  emit_f95_parsed_var_decl
  emit_f95_parsed_par_decl
);
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast );
use RefactorF4Acc::Refactoring::Subroutines::Emitters
  qw( emit_subroutine_sig emit_subroutine_call );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );
use Carp;
use Data::Dumper;

#use Digest::MD5;
#use File::Copy;
use Cwd;

use Exporter;
@RefactorF4Acc::Emitter::ISA       = qw(Exporter);
@RefactorF4Acc::Emitter::EXPORT_OK = qw(
  &emit_all
  &emit_AnnLines
);

sub emit_all {
    ( my $stref ) = @_;
    if ($I) {
        print "=" x 80, "\n";
        print "ENTERING EMIT_ALL\n";
        print "=" x 80, "\n";
    }

    my $EXT = $Config{EXT};

    # I build a fresh list here. I should just delete 'F' at the end
    $stref->{'BuildSources'}{$EXT} = {};

    return $stref unless scalar keys %{ $stref->{'SourceContains'} } >0;

    _init_emit_all($stref) unless $DUMMY;

    for my $src ( sort keys %{ $stref->{'SourceContains'} } ) {
        my %used_modules=();
        if (    exists $stref->{'SourceContains'}{$src}{'Path'}
            and exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'} )
        {
            say "SKIPPING $src";
            next;
        }
        print 'INFO: ', '-' x 80, "\n" if $I;
        print "INFO: Emitter: refactored code for $src\n" if $I;

        my ( $has_subdirs, $subdir_path ) = __get_src_subdirs($src);


        if ( not $DUMMY ) {
            if ($has_subdirs) {
                say "CREATING SUBDIR $targetdir/$subdir_path" if $V;
                system("mkdir -p $targetdir/$subdir_path");
            }
        }

        if ($I) {
            if ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {
                say "INFO:\tSRC: $src";
                print "INFO:\tCONTAINS: ";
                say join( ', ', @{ $stref->{'SourceContains'}{$src}{'List'} } );
            }
        }

        if (    not exists $stref->{'BuildSources'}{'C'}{$src}
            and not exists $stref->{'BuildSources'}{'F'}{$src} )
        {
            say "INFO: Emitter: ADD $src to BuildSources" if $I;
            $stref->{'BuildSources'}{'F'}{$src} = 1;
        }
        elsif ( exists $stref->{'BuildSources'}{'F'}{$src}
            and $stref->{'BuildSources'}{'F'}{$src} == 0 )
        {
            say "INFO: Emitter: REMOVE $src from BuildSources" if $I;
            delete $stref->{'BuildSources'}{'F'}{$src};
        }

        my $nsrc = $src;
        if ( exists $stref->{'BuildSources'}{'F'}{$src} ) {
            $nsrc =~ s/\.\w+$/$EXT/;
        }
        else {
            next;
        }
        if ( exists $stref->{'IncludeFiles'}{$src} ) {
            for my $srcdir ( @{ $Config{'SRCDIRS'} } ) {
                if ( -e "$srcdir/$src" ) {
                    $nsrc = "$srcdir/$src";
                    last;
                }
            }
        }
        if ( $nsrc =~ /$EXT$/ ) {
            $stref->{'BuildSources'}{$EXT}{$nsrc} = 1;
        }
        if ($DUMMY) {
            say 'INFO: ' . ( '=' x 80 );
            say "INFO: Emitter: New source: $targetdir/$nsrc ($src)";
            say 'INFO: ' . ( '=' x 80 );
            show_annlines( $stref->{'RefactoredCode'}{$src}, 0 );
        }
        else {
            say "INFO: Emitter: New source: $targetdir/$nsrc ($src)" if ( $I or $DBG );
            show_annlines( $stref->{'AnnLines'}{$src}, 0 );

            my $mod_lines = $stref->{'RefactoredCode'}{$src};

            if ( exists $stref->{'SourceFiles'}{$src}{'AnnLines'} ) {
                my @source_level_comments = grep { exists $_->[1]{'Comments'} }
                  @{ $stref->{'SourceFiles'}{$src}{'AnnLines'} };
                if (@source_level_comments) {
                    $mod_lines = [ @source_level_comments, @{$mod_lines} ];
                }
            }

            show_annlines( $mod_lines, 0 ) if $SHOW;

            open my $TGT, '>', "$targetdir/$nsrc"
              or die $! . ": $targetdir/$nsrc";

            for my $mod_line ( @{$mod_lines} ) {
                my $info = $mod_line->[1];
                # say "$targetdir/$nsrc".' LINE '.$mod_line->[0];
                if (
                       exists $info->{'Blank'}
                    or exists $info->{'Deleted'}

        # or (exists $info->{'Comments'} and not exists $info->{'OrigComments'})
                  )
                {
                    # say "$targetdir/$nsrc".' LINE '.$mod_line->[0].' DELETED';
                    next;
                }

                # If the line is not a USE statement
                # or it is but the module is not in the list of used modules
                # if (not exists $info->{'Use'} or not exists $used_modules{$info->{'Use'}{'Name'}} ) {
                #     if ( exists $info->{'Use'}) {
                #         $used_modules{$info->{'Use'}{'Name'}}=1;
                #     }
                    print $TGT $mod_line->[0];
                # } else { # So this means that the line is a USE statement
                #     say "SKIPPED: ".$mod_line->[0];
                #     croak Dumper  %used_modules,$info->{'Use'}{'Name'};
                # }
                if ( $ANN and exists $mod_line->[1]->{'Ann'} ) {
                    say $TGT ' ! ' . join( '; ', @{ $mod_line->[1]{'Ann'} } );
                }
                else {
                    print $TGT "\n";
                }
            }
            close $TGT;
        }
    }    # loop over all source files

    for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {
        if ( exists $stref->{'IncludeFiles'}{$f}{'UsedBy'}
            and scalar @{ $stref->{'IncludeFiles'}{$f}{'UsedBy'} } > 0 )
        {

            _emit_refactored_include( $f, $targetdir, $stref );
        }
        else {
            say "INFO: INCLUDE $f NOT USED!" if $I;
        }
    }
    if ($DUMMY) {
        say '! ' . '=' x 80;
        say '! DUMMY GENERATION DONE';
        say '! ' . '=' x 80;
    }
# croak show_annlines($stref->{'Subroutines'}{'optimcmrkp'}{'RefactoredCode'});
    # NOOP source
    # Note that we always use the C source
    if ( $noop and not $DUMMY ) {
        _gen_noop($targetdir);
    }
    delete $stref->{'BuildSources'}{'F'};
    return $stref;

}    # END of emit_all()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# This routine does not generate or manipulate files, it only does copying etc.
sub _init_emit_all {
    ( my $stref ) = @_;
    # say "Creating NEWSRCPATH $targetdir";
    # if target dir for refactored code does not exist, create it
    # and copy include files into it
    if ( not -e $targetdir ) {
        say "Creating NEWSRCPATH $targetdir" if $V;
        mkdir $targetdir;

        # FIXME: the includes should be taken from $stref->{'IncludeFiles'}
        # But actually, all includes should have been converted to F95 modules!
    }
    elsif ( not -d $targetdir ) {
        die "ERROR: $targetdir exists but is not a directory!\n";
    }
    else {
        # target dir exists. check if subdirs exists
        my $wd = cwd();
        for my $srcdir ( @{ $stref->{'SourceDirs'} } ) {

            if ( not -d "$wd/$targetdir/$srcdir" ) {
                say "Creating SRCDIR $srcdir inside $targetdir" if $V;
                system("mkdir -p $wd/$targetdir/$srcdir")
                  ;    # FIXME: WEAK! only one level!
            }
        }

        # Remove existing Fortran-95 sources
        __remove_previously_generated_f95_sources($stref);
    }
}

# -----------------------------------------------------------------------------
sub _emit_refactored_include {
    ( my $f, my $dir, my $stref ) = @_;

    # local $I=1;
    # local $V=1;
    if ($I) {
        say "INFO: " . "=" x 80;
        say "INFO: INCLUDE FILE: $f";
        say "INFO: WRITE TO $targetdir";
        say "INFO: " . "=" x 80;
    }

    # map {say $_} sort keys %{$stref->{'IncludeFiles'}{$f}};
    # say "INFO: INCLUDE: $f" if $I;
    my $srcref = $stref->{'IncludeFiles'}{$f}{'RefactoredCode'};
    my $incsrc = $stref->{'IncludeFiles'}{$f}{'Source'};

    if ( defined $srcref ) {
        if ($DUMMY) {
            say 'INFO:  ' . ( '=' x 80 );
            say "INFO:  FILE: $dir/$incsrc";
            say 'INFO:  ' . ( '=' x 80 );
            show_annlines( $srcref, 0 );
        }
        else {

            my $nsrc = $incsrc;

            if ( exists $stref->{'IncludeFiles'}{$f}{'SrcPath'} ) {
                my ( $has_subdirs, $subdir_path ) =
                  __get_src_subdirs( $stref->{'IncludeFiles'}{$f}{'SrcPath'} );
                $nsrc = "$subdir_path/$incsrc";
                if ( not -d "$dir/$subdir_path" ) {
                    system("mkdir -p $dir/$subdir_path");
                }
            }

            for my $srcdir ( @{ $Config{'SRCDIRS'} } ) {
                if ( -e "$srcdir/$f" ) {
                    $nsrc = "$srcdir/$incsrc";
                    last;
                }
                else {
                    #   'Source' => 'params_PARALLEL.f90',
                    #   'InclType' => 'Parameter',
                    #   'Root' => 'PARALLEL',
                    if ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'Parameter'
                        and exists $stref->{'IncludeFiles'}{$f}{'Root'} )
                    {
                        my $orig_f = $stref->{'IncludeFiles'}{$f}{'Root'};
                        if ( -e "$srcdir/$orig_f" ) {
                            $nsrc = "$srcdir/$incsrc";
                        }
                    }
                }
            }

            my $EXT = $Config{EXT};
            $stref->{'BuildSources'}{$EXT}{$nsrc} = 1;
            print "INFO: Emitter: refactored code for include $f: $dir/$nsrc\n"
              if $I;

            #        say "! FILE: $dir/$incsrc";
            open my $SRC, '>', "$dir/$nsrc" or die "$!: $dir/$nsrc";

            my $prevline = 'C ';

            $srcref = create_refactored_source( $stref, $f, $srcref );
            for my $annline ( @{$srcref} ) {
                my $line = $annline->[0];
                if ( not( $prevline =~ /^\s*$/ and $line =~ /^\s*$/ ) ) {
                    print $SRC "$line\n";
                    print "$line\n" if $DBG;
                }
                $prevline = $line;
            }
            close $SRC;
        }
    }
    else {
        #    	say "Not writing $f";
    }
}    # END of emit_refactored_include

# -----------------------------------------------------------------------------

sub _gen_noop {
    ( my $tgtdir ) = @_;
    open my $NOOP, '>', "$tgtdir/noop.c";
    print $NOOP '// Instead of continue, use a subroutine to do nothing.
//Purely for translation, to get around a bug in F2C_ACC: in the C code we drop them!
void noop_ () {
    return;
}
';
    close $NOOP;

}

sub UNUSED_gen_break {
    open my $BREAK, '>', '/tmp/break.c';
    print $BREAK, '
void break(int l) {
        break;
}
';
    close $BREAK;
}

sub __remove_previously_generated_f95_sources {
    ( my $stref ) = @_;
    my $wd = cwd();
    for my $srcdir ( @{ $stref->{'SourceDirs'} } ) {
        chdir "$wd/$targetdir/$srcdir";
        my @srcs = glob( '*' . $Config{EXT} );
        for my $src (@srcs) {
            unlink $src;
        }
        chdir $wd;
    }
}

sub __get_src_subdirs {
    my ($src_path) = @_;
    if ( $src_path =~ /\w\/\w/ ) {
        my @dirs = split( /\//, $src_path );
        if ( !-d $src_path ) {
            pop @dirs;
        }

        my @subdirs = @dirs;
        if ( $subdirs[0] eq '.' ) {
            shift @subdirs;
        }
        my $subdirpath = join( '/', @subdirs );
        return ( 1, $subdirpath );
    }
    else {
        return ( 0, '' );
    }
}    # END of __get_src_subdirs

# This is a proper emitter using the AST (if it is present)
# It's not used for the main refactoring, for that we still use the old emitter.
sub emit_AnnLines {
    my ( $stref, $f, $annlines ) = @_;
    # carp "HERE: emit_AnnLines($f)\n";
    my $code_unit = sub_func_incl_mod( $f, $stref );
    my $Sf        = $stref->{$code_unit}{$f};

    my $pass_emit_RefactoredCode = sub {
        ( my $annline, my $used_modules ) = @_;
        ( my $line, my $info ) = @{$annline};
        # warn "LINE $line\n";

        my $rline  = $line;
        # This allows to emit lines for which there is no proper $info
        if (exists $info->{'Textual'}) {
            say $line;
            return [ [ $annline ] ];
        }
        my $indent = '      ';
        if ( exists $info->{'Indent'} ) {
            $indent = $info->{'Indent'};
        }
        my $label = '';
        if (exists $info->{'Label'}) {
            $label=$info->{'Label'};
        }
        if ($label ne '') {
            my $indent_len = length($indent);
            my $label_len =  length($label);
            if ($indent_len>$label_len+1) {
                $indent =  $label . ' ' x ($indent_len-$label_len);
            } else {
                $indent =  $label . ' ';
            }
        }
        my $maybe_cond = '';
        my $block_info='';
        if (exists $info->{'Block'}) {
            my $block_id = join(':',@{get_block_id($info->{'Block'},[])});
            for my $k (sort keys %{$info->{'Block'}}) {
                next if $k eq 'InBlock';
                my $v = $info->{'Block'}{$k};
                my $v_str = ref($v) eq 'HASH' ? '<'.join(',',(sort keys %{$v})).'>' : ref($v) eq 'ARRAY' ? join(',',@{$v}) : $v;
                $block_info .= $k.':'.$v_str.' ' if $ANN;
            }
            $block_info = "\t! ".$block_id.' '.$block_info if $ANN;
        }
        if ( exists $info->{'If'} and not exists $info->{'IfThen'} ) {
            my $ast           = $info->{'Cond'}{'AST'};
            my $cond_expr_str = emit_expr_from_ast($ast);
            $maybe_cond = 'if ( ' . $cond_expr_str . ' ) ';
        }
        if ( exists $info->{'Module'} ) {
            my $module_name = $info->{'Module'};
            $rline = "module $module_name";
        }
        elsif ( exists $info->{'End'} ) {
            my $kw = $info->{'End'};
            my $name = ref($info->{'End'.ucfirst($kw)}) eq 'HASH' ? exists $info->{'End'.ucfirst($kw)}{'Name'} ? $info->{'End'.ucfirst($kw)}{'Name'} : '' : '';
            $rline = $indent."end $kw $name"

        }
        #== IMPLICIT NONE
        elsif ( exists $info->{'ImplicitNone'} ) {
            $rline = $indent . 'implicit none';

#== USE
# WV20190626 I'm not sure why 'include' is handled in SrcReader and 'use' here ...
        }
        elsif ( exists $info->{'Use'}) {
            my $module_name = $info->{'Use'}{'Name'};
            if (not exists $used_modules->{$module_name}) {
                $used_modules->{$module_name} = 1;
            my $only_list   = $info->{'Use'}{'Only'} // [];
            my $maybe_only =
              scalar @{$only_list}
              ? ', only : ' . join( ', ', @{$only_list} )
              : '';

            $rline = $indent . "use $module_name $maybe_only ! emit_AnnLines($f)";
            # warn "EMIT $rline\n";
            } else {
                $rline = $indent . "! use $module_name ! emit_AnnLines($f)";
            }
#== CONTAINS
        }
        elsif ( exists $info->{'Contains'} ) {
            $rline = $indent . 'contains'

#== END of IF/SELECT/DO
        }
        elsif ( exists $info->{'EndSelect'} ) {
            $rline = $indent . 'end select';
        }
        elsif ( exists $info->{'EndIf'} ) {
            $rline = $indent . 'end if';
        }
        elsif ( exists $info->{'EndDo'} ) {
            $rline = $indent . 'end do';

#== INTRINSIC, EXTERNAL, STATIC, AUTOMATIC, VOLATILE
        }
        elsif ( exists $info->{'Intrinsic'} ) {
            croak 'TODO: Intrinsic';
        }
        elsif ( exists $info->{'External'} ) {
            croak 'TODO: External';

            # } elsif (exists $info->{'Static'} ) {

            # } elsif (exists $info->{'Automatic'} ) {

        }
        elsif ( exists $info->{'Volatile'} ) {
            my $vars = $info->{'Volatile'};
            $rline =
              $indent . 'volatile :: ' . join( ', ', sort keys %{$vars} );
        }
        elsif ( exists $info->{'Goto'} ) {
            my $label = $info->{'Goto'}{'Label'};
            $rline = $indent . $maybe_cond . "goto $label";
        }
        elsif ( exists $info->{'StatementFunction'} ) {
            my $lhs_ast      = $info->{'Lhs'}{'ExpressionAST'};
            my $rhs_ast      = $info->{'Rhs'}{'ExpressionAST'};
            my $lhs_expr_str = emit_expr_from_ast($lhs_ast);
            my $rhs_expr_str = emit_expr_from_ast($rhs_ast);

            my $rline = $indent . "$lhs_expr_str = $rhs_expr_str";
        }
        elsif ( exists $info->{'Signature'} ) {

#== SIGNATURES SUBROUTINE FUNCTION PROGRAM ENTRY
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
#@    ReturnTypeAttr => number or '(*)'
#@    ResultVar => $result_var
#@    Characteristic => pure | elemental | recursive
            ( $rline, $info ) = emit_subroutine_sig($annline);
        }
#== VARIABLE AND PARAMETER DECLARATION
        elsif ( exists $info->{'ParsedVarDecl'} ) {
            # say "$f RLINE:$rline";
            # say Dumper $info;
            # carp Dumper $info->{'ParsedVarDecl'};
            if (exists $info->{'ArgDecl'}) {
                my $var_name = $info->{'VarDecl'}{'Name'};
                my $subset = in_nested_set( $Sf, 'Args', $var_name );
                my $decl = get_var_record_from_set($Sf->{$subset},$var_name);
                # carp Dumper $decl;
                my $var_decl_str =
                  emit_f95_var_decl( $decl, $Config{'FOLD_CONSTANTS'});
                $rline = $indent . $var_decl_str;
            } else {
                if (exists $info->{'ParsedVarDecl'}{'Vars'}) {
                    my $var_decl_str =
                    emit_f95_parsed_var_decl( $info->{'ParsedVarDecl'} );
                    $rline = $indent . $var_decl_str;
                } elsif (exists $info->{'VarDecl'}) {
                    my $var_name = $info->{'VarDecl'}{'Name'};
                    my $subset = in_nested_set( $Sf, 'Vars', $var_name );
                    my $decl = get_var_record_from_set($Sf->{$subset},$var_name);
                    my $var_decl_str =
                    emit_f95_var_decl( $decl, $Config{'FOLD_CONSTANTS'});
                    $rline = $indent . $var_decl_str;
                } else {
                    croak 'No decl info for '.$rline.' in '.$f;
                }
            }
        }
        elsif ( exists $info->{'ParamDecl'} ) {

            # carp Dumper  $info;;
            my $par_decl_str =
              emit_f95_parsed_par_decl( $info->{'ParsedParDecl'} );

            $rline = $indent . $par_decl_str;
        }
#== WHILE
        elsif ( exists $info->{'While'} ) {
            my $ast         = $info->{'Do'}{'ExpressionsAST'};
            my $do_expr_str = emit_expr_from_ast($ast);
            $rline = $indent . 'do while (' . $do_expr_str . ')';
        }
#== DO
        elsif ( exists $info->{'Do'} ) {

            # 'Iterator' => $iter,
            # 'Label'    => $label,
            # 'Range'    => {
            # 	'Expressions' => [ $range_start, $range_stop, $range_step ],
            # 	'Vars'        => $mvars
            # },
            # carp 'DO LINE:'.$line.' =>'. Dumper $info->{'Do'};
            my $iter = $info->{'Do'}{'Iterator'};
            my $label =
                exists $info->{'Do'}{'Label'}
              ? $info->{'Do'}{'Label'} eq 'LABEL_NOT_DEFINED'
                  ? ''
                  : ' ' . $info->{'Do'}{'Label'} . ', '
              : '';
            if ( $info->{'Do'}{'Range'}{'Expressions'}[-1] == 1 ) {
                pop @{ $info->{'Do'}{'Range'}{'Expressions'} };
            }
            my $do_expr_str =
              join( ', ', @{ $info->{'Do'}{'Range'}{'Expressions'} } );
            $rline =
              $indent . 'do' . $label . ' ' . $iter . ' = ' . $do_expr_str;

            # 	'While' =>1,
            # 	'Iterator' => '',
            # 	'Label'    => $label,
            # 	'ExpressionsAST' => $ast,
            # 	'Range'    => {
            # 		'Vars'        => $vars,
            # 		},
            # 	'LineID' => $info->{'LineID'}
            # };

        }
#== SELECT/CASE
        elsif ( exists $info->{'CaseVar'} ) {
            $rline = $indent . 'select case ( ' . $info->{'CaseVar'} . ' )';
        }
        elsif ( exists $info->{'CaseVals'} ) {
            my $case_vals = $info->{'CaseVals'};
            $rline = $indent . 'case ( ' . join( ', ', map {
                ref($_) eq 'ARRAY' ? join(':',@{$_}) : $_
            } @{$case_vals} ) . ' )';
        }
        elsif ( exists $info->{'CaseDefault'} ) {
            $rline = $indent . 'case default';

#== ELSE
        }
        elsif ( exists $info->{'Else'} ) {
            $rline = $indent . 'else';

#== IF -- Block, Arithmetic and logical IF statements
# st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
# END IF, END, or another logical IF statement.
#@ Cond
#@  Expr => $cond
#@  AST => $ast
#@  Vars =>
#@     Set => {...}
#@     List => [...]

        }
        elsif ( exists $info->{'IfThen'} ) {
            my $ast           = $info->{'Cond'}{'AST'};
            my $cond_expr_str = emit_expr_from_ast($ast);

            if ( exists $info->{'ElseIf'} ) {
                # my $ast = $info->{'Cond'}{'AST'};
                $rline = $indent . 'else if ( ' . $cond_expr_str . ' ) then';
            } else {
                $rline = $indent . 'if ( ' . $cond_expr_str . ' ) then';
            }
        } elsif ( exists $info->{'EndIf'} ) {
            $rline = $indent . 'end if';
#== BACKSPACE, ENDFILE statements
        }
        elsif ( exists $info->{'IO'} ) {
            my $io_call   = $info->{'IO'};
            my $attrs_ast = $info->{'IOCall'}{'Args'}{'AST'};
            if ($attrs_ast->[0] == 1) {
                $attrs_ast=$attrs_ast->[2];
            }
            # croak Dumper $attrs_ast;
            my $attrs_str = emit_expr_from_ast($attrs_ast);

            my $exprs_ast = $info->{'IOList'}{'AST'};
            # carp Dumper $attrs_ast, $exprs_ast;
            my $exprs_str = emit_expr_from_ast($exprs_ast);
            if ( $exprs_str ne '' ) {
                $exprs_str .= ', ';
            }
            $rline =
                $indent
              . $maybe_cond
              . $io_call . ' '
              . $attrs_str
              . $exprs_str ;
            #   . ')';

#== RETURN, STOP and PAUSE statements
        }
        elsif ( exists $info->{'Return'} ) {
            # carp "$f:". Dumper ($line,$info);
            my $expr_ast = $info->{'ReturnExprAST'};
            my $expr_str = emit_expr_from_ast($expr_ast) // ''; # ReturnExprAST may not be present
            $rline = $indent . $maybe_cond . 'return ' . $expr_str;
        }
        elsif ( exists $info->{'Stop'} ) {
            my $expr_ast = $info->{'ReturnExprAST'};
            my $expr_str = emit_expr_from_ast($expr_ast);
            $rline = $indent . $maybe_cond . 'stop ' . $expr_str;
        }
        elsif ( exists $info->{'Pause'} ) {
            $rline = $indent . $maybe_cond . 'pause';
        }
        elsif ( exists $info->{'Assignment'} ) {

#== ASSIGNMENT
# This is an ASSIGNMENT and so can come after IF (...)
#@ Lhs =>
#@        VarName       => $lhs_varname
#@        IndexVars     => $lhs_vars
#@        ArrayOrScalar => Array | Scalar
#@        ExpressionAST => $lhs_ast
#@ Rhs =>
#@        Vars       => $rhs_all_vars (Set,List)
#@        ExpressionAST => $rhs_ast

            my $lhs_ast      = $info->{'Lhs'}{'ExpressionAST'};
            my $rhs_ast      = $info->{'Rhs'}{'ExpressionAST'};
            my $lhs_expr_str = emit_expr_from_ast($lhs_ast);
            my $rhs_expr_str = emit_expr_from_ast($rhs_ast);
# croak  $rhs_expr_str.Dumper $annline->[1]{'Rhs'}{'ExpressionAST'} if $f=~/test_loop/ and $line=~/p3/;

            $rline = $indent . $maybe_cond . "$lhs_expr_str = $rhs_expr_str";

        }
#== CALL, SUBROUTINE CALL
#@ SubroutineCall =>
#@     Name => $name
#@     ExpressionAST => $ast
#@     Args => CallArgs
#@ CallArgs => $expr_args
#@ ExprVars => $expr_other_vars
#@ IsExternal => $bool

        elsif ( exists $info->{'SubroutineCall'} ) {
            # $rline =  'CALL: '.$rline;
            my ($call_str, $info_) = emit_subroutine_call( $stref, $f, $annline );
            # croak Dumper $call_str;
            chomp $call_str;
            $rline = $call_str ;

        }
        elsif (
                not exists $info->{'Comments'}
            and not exists $info->{'Blank'}

          )
        {
            $rline .= ' !!! ORIG !!!' if $ANN;
        } else {
            $block_info='';
        }
        # if ($block_info ne '') {
        # return [
        #     [ $block_info, {}],
        #     [ $rline, $info ]
        # ];
        # } else {
        # say $rline;
#say Dumper([ $rline.$block_info, $info ]);
        return ([
            [ $rline.$block_info, $info ]
        ], $used_modules);
        # }
    };

    # my $refactored_code_before = dclone( $Sf->{'RefactoredCode'} );
    my $used_modules = {};
    (my $new_annlines,$used_modules) = stateful_pass( $annlines, $pass_emit_RefactoredCode, $used_modules,
        "pass_emit_RefactoredCode($f) " . __LINE__ );

    # if ($f=~/test_loop/) {
    # map { say $_} @{ pp_annlines( $new_annlines ) };

    # die;
    # }
    $Sf->{'RefactoredCode'}=$new_annlines;
    return $stref;

} # END of emit_AnnLines


