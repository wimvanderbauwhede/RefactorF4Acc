# Fold all constants in a code unit
# This is done primarily for analysis, but it is of course a program transformation
package RefactorF4Acc::Refactoring::FoldConstants;
#
#   (c) 2021 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( get_annotated_sourcelines stateless_pass );
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
use RefactorF4Acc::ExpressionAST::Evaluate qw(
    fold_constants_in_expr
    fold_constants_in_expr_no_iters
    replace_consts_in_ast_no_iters
    eval_expression_with_parameters
    );
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast parse_expression_no_context get_vars_from_expression);
use RefactorF4Acc::Emitter qw( emit_AnnLines );
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Refactoring::FoldConstants::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::FoldConstants::EXPORT_OK = qw(
    fold_constants_all
    fold_constants
    fold_constants_no_iters
    fold_constants_in_decls
);

# foldConstants :: ProgUnit Anno -> ProgUnit Anno
# We'll take ProgUnit to mean a subroutine
# To do this right, I need to indentify the nested loops in the subroutine.
# That will provide a BlockID which is need to work out what is a loop iterator
# So this requires running identify_array_accesses_in_exprs() first to identify any nested loops.
# $ast = (fold_constants_in_expr($stref, $f, $block_id, $ast);
sub fold_constants {
    my ($stref, $f, $substitute_loop_iters_by_consts) = @_;
    if (not defined $substitute_loop_iters_by_consts) {
        $substitute_loop_iters_by_consts = 0;
    }
    # carp $f. ref($stref);
    my $Sf = $stref->{'Subroutines'}{$f};
    # Chicken and egg!
    $stref = identify_array_accesses_in_exprs($stref,$f);
    # die;
    # croak Dumper $Sf->{'ArrayAccesses'} if $f eq 'sub1';
    my $pass_fold_constants = sub { (my $annline)=@_;
        (my $line,my $info)=@{$annline};
        # From $info, find the lines that contain expressions that might have constants to fold.
        # These would the same types of lines as in identify_array_accesses_in_exprs()
            # say "LINE: $f $line";
            # $stref->{'Subroutines'}{ $f }{'ArrayAccesses'} has all block ids as keys, but how is this linked to the actual loop nest?
            my $in_block = exists $info->{'Block'} ? $info->{'Block'}{'LineID'} : '-1';
            my $block_id = exists $info->{'BlockID'} ? $info->{'BlockID'}  : 0;

			# The array dimensions have already been folded and are stored in
            # $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'}
            # i.e. in $stref->{}
			# if ( exists $info->{'Signature'} ) {
			# }
			# # For every VarDecl, identify dimension if it is an array
			# els
            if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'}
            #  and is_array_decl($info)
             ) {

                my $var_name = $info->{'VarDecl'}{'Name'};
                my $subset = in_nested_set( $Sf, 'Vars', $var_name );
                my $decl = get_var_record_from_set($Sf->{$subset},$var_name);
                if (exists $decl->{'ArrayOrScalar'}
                and $decl->{'ArrayOrScalar'} eq 'Array'
                ) {
                    my $expr_str = '['.join(',',map {'['.$_->[0].','.$_->[1].']'} @{$decl->{'Dim'}}).']';
                    my ($ast,$str_,$error_,$has_funcs_)=parse_expression_no_context($expr_str);
                    my ($const_ast, $retval_) = replace_consts_in_ast_no_iters($stref, $f, $ast, $info);
                    my $const_expr_str = emit_expr_from_ast($const_ast);
                    $const_expr_str=~s/\(\//[/g;
                    $const_expr_str=~s/\/\)/]/g;
                    my $const_dims= eval( $const_expr_str );
                    $decl->{'ConstDim'} = $const_dims;
                    $Sf->{$subset}{$var_name}{'Set'}=$decl;
                    # say "$f SUBSET: $subset => $var_name";
                    $Sf->{$subset}{'Set'}{$var_name} = $decl;
                    my $pv_dims = [
                        map {  $_->[0].':'.$_->[1] }
                        @{$const_dims}
                    ];
                    $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}=$pv_dims;
                }

			}
            if (exists $info->{'ParamDecl'} ) {
                carp Dumper $info->{'ParsedParDecl'} ;
                my $var_name = $info->{'ParsedParDecl'}{'Pars'}{'Var'};
                # croak $f,Dumper $info if $f eq 'sub1' and $var_name eq 'p1';
                my $val_expr_str = $info->{'ParsedParDecl'}{'Pars'}{'Val'};
                my $evaled_val = eval_expression_with_parameters($val_expr_str,$info, $stref, $f) ;
                $info->{'ParsedParDecl'}{'Pars'}{'Val'} = $evaled_val;
                # warn 'TODO!';
			}
            # say "LINE: $line";
            if ($substitute_loop_iters_by_consts) {
                if (exists $info->{'Assignment'} ) {
                    # We need the AST for LHS and RHS
                    if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array' ) {
                        my $lhs_ast = $info->{'Lhs'}{'ExpressionAST'};
                        my $const_fold_lhs_ast = fold_constants_in_expr($stref, $f, $block_id, $lhs_ast);
                        $info->{'Lhs'}{'ExpressionAST'}=$const_fold_lhs_ast;
                    }

                    my $rhs_ast  = $info->{'Rhs'}{'ExpressionAST'};
                    my $const_fold_rhs_ast = fold_constants_in_expr($stref, $f, $block_id, $rhs_ast);
                    $info->{'Rhs'}{'ExpressionAST'}=$const_fold_rhs_ast;
                }
                if (exists $info->{'If'} ) {
                    # FIXME: Surely conditions of if-statements can contain array accesses, so FIX THIS!
                    #say "IF statement, TODO: ".Dumper($info->{'Cond'}{'Expr'});
                    my $cond_expr_ast = $info->{'Cond'}{'AST'};
                    my $const_fold_cond_expr_ast = fold_constants_in_expr($stref, $f, $block_id, $cond_expr_ast);
                    $info->{'Cond'}{'AST'} = $const_fold_cond_expr_ast;
                }
            }
            elsif ( exists $info->{'Do'} ) { #  the expressions for the loop bounds have been folded:
                my $block_id = $info->{'BlockID'};
                my $iter =  $info->{'Do'}{'Iterator'};
                my $evaled_range = $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{$block_id}{'LoopIters'}{$iter}{'Range'};
                $info->{'Do'}{'Range'}{'Expressions'} = $evaled_range;
            }
            # } elsif ( exists $info->{'EndDo'} ) {

            # }

        return [[$line,$info]];
    };
    my $annlines = $Sf->{'RefactoredCode'};
    my $new_annlines = stateless_pass($annlines,$pass_fold_constants,"pass_fold_constants($f) " . __LINE__  ) ;
    # $stref = identify_var_accesses_in_exprs($stref,$f,$new_annlines);
    #  emit_AnnLines($stref,$f,$new_annlines) ;
    return ($stref,$new_annlines);
} # END of fold_constants

# This routine folds constants in declarations and statements but only based on parameters, not on iterators
sub fold_constants_no_iters {
    my ($stref, $f) = @_;
    my $mod_or_sub = sub_func_incl_mod($f,$stref);
    my $Sf = $stref->{$mod_or_sub}{$f};

    my $pass_fold_constants = sub { (my $annline)=@_;
        (my $line,my $info)=@{$annline};
        say "$f FOLD CONSTS ON LINE <$line>";croak Dumper $info if $line=~/\s*[\(:]\s*funktalMaxNTokens/i;
        # From $info, find the lines that contain expressions that might have constants to fold.
        # These would the same types of lines as in identify_array_accesses_in_exprs()

            if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'}
            #  and is_array_decl($info)
             ) {

                my $var_name = $info->{'VarDecl'}{'Name'};

                my $subset = in_nested_set( $Sf, 'Vars', $var_name );
                my $decl = get_var_record_from_set($Sf->{$subset},$var_name);

                if (exists $decl->{'ArrayOrScalar'}
                and $decl->{'ArrayOrScalar'} eq 'Array'
                ) {

                    my $expr_str = '['.join(',',map {'['.$_->[0].','.$_->[1].']'} @{$decl->{'Dim'}}).']';
croak if $expr_str=~/funktalMaxNTokens/;
                    my ($ast,$str_,$error_,$has_funcs_)=parse_expression_no_context($expr_str);
                    my ($const_ast, $retval_) = replace_consts_in_ast_no_iters($stref, $f, $ast, $info);
                    my $const_expr_str = emit_expr_from_ast($const_ast);

                    $const_expr_str=~s/\(\//[/g;
                    $const_expr_str=~s/\/\)/]/g;

                    my $const_dims= eval( $const_expr_str );
                    my $sub_or_func = sub_func_incl_mod($f,$stref);
# croak "$sub_or_func $f",Dumper $stref->{$sub_or_func}{$f}{'Vars'} if $const_expr_str=~/funktalMaxNTokens/;
# croak "FOLDING $var_name in $f: $expr_str => $const_expr_str => ".Dumper($const_dims) if $const_expr_str=~/funktalMaxNTokens/;
                    # croak $const_expr_str if not defined $const_dims;
                    if ( defined $const_dims) {
                        $decl->{'ConstDim'} = $const_dims;
                        $Sf->{$subset}{$var_name}{'Set'}=$decl;
                        $Sf->{$subset}{'Set'}{$var_name} = $decl;
                        my $pv_dims = [
                            map {  $_->[0].':'.$_->[1] }
                            @{$const_dims}
                        ];
                        $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}=$pv_dims;
                    } else {
                        warning("Could not constant-fold DIMENSION on line\n$line\nin subroutine $f");
                    }
                }
                if ($decl->{'Type'} eq 'character') { 
                    if ($decl->{'Attr'}) {
                        my $len_expr= $decl->{'Attr'}; 
                        $len_expr=~s/len\s*=\s*//;
                        if ($len_expr ne '(*)') {
                        my $expr_str = $len_expr;
                        my ($ast,$str_,$error_,$has_funcs_)=parse_expression_no_context($expr_str);
                        my ($const_ast, $retval_) = replace_consts_in_ast_no_iters($stref, $f, $ast, $info);
                        my $const_expr_str = emit_expr_from_ast($const_ast);

                        $const_expr_str=~s/\(\//[/g;
                        $const_expr_str=~s/\/\)/]/g;

                        my $const_len= eval( $const_expr_str );
                        $info->{'ParsedVarDecl'}{'Attributes'}{'Len'}= "len=$const_len";
                        } else {
                            $info->{'ParsedVarDecl'}{'Attributes'}{'Len'}= "len=*";
                        }
                    }
                }
			}
            elsif (exists $info->{'ArgDecl'}) { # This is in case VarDecl is just the Name, FIXME!
                my $var_name = $info->{'VarDecl'}{'Name'};
                my $subset = in_nested_set( $Sf, 'Vars', $var_name );
                my $decl = get_var_record_from_set($Sf->{$subset},$var_name);
            }
            if (exists $info->{'ParamDecl'} ) {
                # carp Dumper( $info);
                my $ast = exists $info->{'ParamDecl'}{'AST'} ? $info->{'ParamDecl'}{'AST'}
                : exists $info->{'ParsedParDecl'}{'Pars'}{'AST'} ? $info->{'ParsedParDecl'}{'Pars'}{'AST'} : [];
                my $var_name = $info->{'ParsedParDecl'}{'Pars'}{'Var'};
                my $val_expr_str = $info->{'ParsedParDecl'}{'Pars'}{'Val'};
                # WV 2021-06-16 FIXME: somehow $info->{'ParsedParDecl'}{'Pars'}{'Val'} only has the integer part of the value!
                if (ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY') {
                    $val_expr_str = $info->{'ParamDecl'}{'Name'}[1];
                }
                if ($val_expr_str=~/^([a-z]\w+)/i
                    and  not exists $F95_intrinsics{$1}
                ) {
                    my $evaled_val = eval_expression_with_parameters($val_expr_str,$info, $stref, $f) ;
                    $info->{'ParsedParDecl'}{'Pars'}{'Val'} = $evaled_val;
                }
                elsif ($ast->[0] ==1 and
                        exists $F95_intrinsics{$ast->[1]}
                    # $val_expr_str=~/^([a-z]\w+)\s*\(/i
                    # and exists $F95_intrinsics{$1}
                ) {
                    # my $evaled_val = eval_expression_with_parameters($val_expr_str,$info, $stref, $f) ;
                    # TODO: this only works if the args are constant literals. Need to eval the args.
                    my $evaled_val = eval_intrinsic($val_expr_str);
                    # croak "TODO: F95_intrinsics: $f $line $val_expr_str";
                    # croak Dumper $info; 
                    $info->{'ParsedParDecl'}{'Pars'}{'Val'} = $evaled_val;
                }
			}
			if (exists $info->{'Assignment'} ) {
                # We need the AST for LHS and RHS
                if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array' ) {
                    my $lhs_ast = $info->{'Lhs'}{'ExpressionAST'};
                    my $const_fold_lhs_ast = fold_constants_in_expr_no_iters($stref, $f, $lhs_ast,$info);
                    $info->{'Lhs'}{'ExpressionAST'}=$const_fold_lhs_ast;
                }

                my $rhs_ast  = $info->{'Rhs'}{'ExpressionAST'};
                my $const_fold_rhs_ast = fold_constants_in_expr_no_iters($stref, $f, $rhs_ast,$info);
                $info->{'Rhs'}{'ExpressionAST'}=$const_fold_rhs_ast;
			}
	 		if (exists $info->{'If'} or exists $info->{'IfThen'} or exists $info->{'ElseIf'}) {
                # FIXME: Surely conditions of if-statements can contain array accesses, so FIX THIS!
                #say "IF statement, TODO: ".Dumper($info->{'Cond'}{'Expr'});
                my $cond_expr_ast = $info->{'Cond'}{'AST'};
                my $const_fold_cond_expr_ast = fold_constants_in_expr_no_iters($stref, $f, $cond_expr_ast,$info);
                $info->{'Cond'}{'AST'} = $const_fold_cond_expr_ast;
            }
            elsif ( exists $info->{'Do'} ) { #  the expressions for the loop bounds have been folded:
            if (not exists $info->{'Do'}{'While'}) {
                my $iter =  $info->{'Do'}{'Iterator'};
                my $const_range_exprs = [];

                if (scalar @{ $info->{'Do'}{'Range'}{'Expressions'} } !=3) { croak Dumper $info;}
                for my $range_expr_str (@{$info->{'Do'}{'Range'}{'Expressions'}}) {
                     if( $range_expr_str =~ /^[\+\-\d]+$/) {
                         push @{$const_range_exprs}, $range_expr_str*1;
                     } else {
                        my ($ast,$str_,$error_,$has_funcs_)=parse_expression_no_context($range_expr_str);
                        my ($const_ast, $retval_) = replace_consts_in_ast_no_iters($stref, $f, $ast, $info);
                        my $unfolded_vars = get_vars_from_expression($const_ast) // {};
                        # carp Dumper $unfolded_vars ;#if $line=~/niters/;
                        my $const_expr_str = emit_expr_from_ast($const_ast);
                        # carp $const_expr_str;
                        my $const_range_expr_val = keys %{$unfolded_vars} ? $const_expr_str : eval($const_expr_str);
                        push @{$const_range_exprs}, $const_range_expr_val;
                     }
                }
                $info->{'Do'}{'Range'}{'Expressions'} = $const_range_exprs;
                $info->{'Do'}{'Range'}{'Vars'} = []; # FIXME! Only works if all vars have been replaced!
            }  else {
                carp "TODO: FOLD CONSTANTS IN WHILE: $line";
            }
            }
            elsif ( exists $info->{'PrintCall'} ) {
                my $print_args_ast = $info->{'IOCall'}{'Args'}{'AST'};
                my $const_fold_print_args_ast = fold_constants_in_expr_no_iters($stref, $f, $print_args_ast,$info);
                # croak Dumper $const_fold_print_args_ast;
                $info->{'IOCall'}{'Args'}{'AST'} = $const_fold_print_args_ast;
             }
        return [[$line,$info]];
    };
    my $annlines =  get_annotated_sourcelines($stref,$f); # was $Sf->{'RefactoredCode'};
    my $new_annlines = stateless_pass($annlines,$pass_fold_constants,"pass_fold_constants($f) " . __LINE__  ) ;
    return ($stref,$new_annlines);
} # END of fold_constants_no_iters

sub fold_constants_all {
	( my $stref ) = @_;
    # Modules should be included too
	for my $module_name (sort keys %{$stref->{'Modules'}} ) {
        next if ( $module_name eq '' or $module_name eq 'UNKNOWN_SRC' or not defined $module_name );

		my $Mmn = $stref->{'module_name'}{$module_name};
        carp "STATUS for $module_name: ".$Mmn->{'Status'};
		($stref,my $new_annlines) = fold_constants_no_iters($stref,$module_name);
		$stref->{'Modules'}{$module_name}{'RefactoredCode'} = $new_annlines;
	}
	for my $f ( sort keys %{ $stref->{'Subroutines'} } ) {
		next if ( $f eq '' or $f eq 'UNKNOWN_SRC' or not defined $f );
		# next if exists $stref->{'Entries'}{$f};
		my $Sf = $stref->{'Subroutines'}{$f};

		if ( not defined $Sf->{'Status'} ) {
			$Sf->{'Status'} = $UNREAD;
			say "INFO: no Status for $f" if $I;
		}

		next if $Sf->{'Status'} == $UNREAD;
		next if $Sf->{'Status'} == $READ;
		next if $Sf->{'Status'} == $FROM_BLOCK;

		($stref, my $new_annlines) = fold_constants_no_iters( $stref, $f );

        $Sf->{'RefactoredCode'}=$new_annlines;

        # $stref = emit_AnnLines($stref,$f,$new_annlines) ;

	}

	return $stref;
}    # END of fold_constants_all()

sub fold_constants_in_decls {
    my ($stref, $f) = @_;

    my $Sf = $stref->{'Subroutines'}{$f};
    my $pass_fold_constants_in_decls = sub { (my $annline)=@_;
        (my $line,my $info)=@{$annline};
            if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'}
             ) {
                my $var_name = $info->{'VarDecl'}{'Name'};
                my $subset = in_nested_set( $Sf, 'Vars', $var_name );
                my $decl = get_var_record_from_set($Sf->{$subset},$var_name);
                if (exists $decl->{'ArrayOrScalar'}
                and $decl->{'ArrayOrScalar'} eq 'Array'
                ) {
                    my $dims = $decl->{'Dim'};
                    $decl->{'ConstDim'}=[];
                    for my $dim (@{$dims}) {
                        my $const_dim=[];
                        for my $expr_str (@{$dim}) {
                            if ($expr_str!~/^\d+$/) {
                                my $evaled_str = eval_expression_with_parameters( $expr_str, $info,  $stref,  $f);
                                # say "EVAL: $expr_str => $evaled_str";
                                push @{$const_dim},  $evaled_str;
                            } else {
                                push @{$const_dim},  $expr_str;
                            }
                        }
                        push @{$decl->{'ConstDim'}}, $const_dim;
                    }
                    $Sf->{$subset}{'Set'}{$var_name} = $decl;
                }
			}
        return [$annline];
    };
    my $annlines = $Sf->{'RefactoredCode'};
    $annlines = stateless_pass($annlines,$pass_fold_constants_in_decls,"pass_fold_constants_in_decls($f) " . __LINE__  ) ;

    return $stref;
} # END of fold_constants_in_decls

sub eval_intrinsic { my ($val_expr_str) = @_;
    my $intr = $val_expr_str;
    $intr=~s/\s*\(.+$//;
    my $intr_args_str = $val_expr_str;
    $intr_args_str =~s/\s*\)\s*$//;
    $intr_args_str =~s/$intr\s*\(\s*//;
    my @intr_args = split(/\s*,\s*/,$intr_args_str);
    for my $intr_arg (@intr_args) {
        if ($intr_arg=~/^[a-z_]/) {
            error("TODO: evaluating intrinsics only works with numerical literals");
        }
    }
    my $intr_calc = $F95_intrinsic_functions_for_eval{$intr};
    my $res = $intr_calc->(@intr_args);
    # croak Dumper($intr,@intr_args,$res);
    return $res;
} # END of eval_intrinsic