package RefactorF4Acc::Translation::LlvmToTyTraIR;
use v5.10;

use RefactorF4Acc::Config;

#
#   (c) 2019 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.2.0";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Translation::LlvmToTyTraIR::ISA = qw(Exporter);

@RefactorF4Acc::Translation::LlvmToTyTraIR::EXPORT_OK = qw(
  generate_llvm_ir_for_TyTra
);

=pod

TODO: integrate the scalarization pass into the translate_kernels_to_TyTraLlvmIR.pl script!

[wim@HackBookPro Autopar]$ cat rename_array_accesses_to_scalars.sh 
refactorF4acc.pl -P rename_array_accesses_to_scalars -c rf4a_scalarize.cfg 

[wim@HackBookPro Autopar]$cat rf4a_scalarize.cfg 

currently:
MODULE = module_shapiro_dyn_update_superkernel
MODULE_SRC = module_shapiro_dyn_update_superkernel.f95
TOP = shapiro_dyn_update_superkernel
KERNEL = shapiro_dyn_update_superkernel
PREFIX = .
SRCDIRS = .
NEWSRCPATH = ./Scalarized
EXCL_SRCS = (sub|init|param|module_\w+_superkernel_init|_host|\.[^f])
EXCL_DIRS = ./PostCPP,./Scalarized,./TyTraC
MACRO_SRC = macros.h
EXT = .f95



# Generating LLVM IR for TyTra

- The current compiler chain first generates accelerator-ready Fortran 95 using this compiler. 
- This is passed on to a second compiler which performs essentially a map/fold/stencil analysis and emits code in the form of kernels, intended for GPU acceleration using OpenCL, but in Fortran syntax.
- This compiler then translates that code into C for OpenCL or for the TyTra flow (TyTraC). To generate TyTraC, it first scalarises all kernels (`-P rename_array_accesses_to_scalars`) and then translates them to C (`-P translate_to_TyTraC`).
- Then we can generate LLVM IR from that C code, and transform it so that it can be converted finally to TyTraIR by the TyBEC backend compiler

## Generating LLVM IR from TyTraC

We do this in `_generate_llvm_ir` using `clang` and `opt`. 

## Transforming the LLVM IR for TyTra

First we need to have named arguments. This used to be the default in older LLVM and TyBEC requires it. Then we need to replace branches by `select` statements. Rather using the LLVM framework, I wrote a parser and emitter for our subset of LLVM IR.

_parse_llvm_ir parses the LLVM code for a single subroutine into a list of AST nodes.

### Named arguments

_rename_regs_to_args

### Branches to select

#### Better AST

_build_ast_tree
_simplify_ast_tree

#### Identify the registers subject to conditions
_identify_regs_w_multiple_occs
#### Identify origin and terminal nodes for these registers

_find_terminating_block
_find_originating_block

#### Find the conditions governing each path between origin and terminal nodes

_collect_select_conditions

#### Create the select and condition statements

    __emit_select_exprs($conds_for_paths, $simplified_ast_tree); 
    
#### Remove the branches and stores and rename the register assignments
    _remove_br_and_update_assignments_in_ast_tree

#### Insert the select code into the AST
    _insert_select_exprs_into_ast_tree

#### Rename temporary registers to keep LLVM happy    
    _rename_temp_regs

#### Emit the new LLVM IR 

    _emit_llvm_ir_from_ast_tree
    _create_llvm_ir_src
    __sanity_check

=end markdown
=cut

sub generate_llvm_ir_for_TyTra {
    (my $stref, my $module_name) = @_;

    my $module_src = $stref->{'Modules'}{$module_name}{'Source'};
    if (not defined $module_src) {
        $module_src = $Config{'MODULE_SRC'};
    }
    my $csrc = $module_src;
    $csrc =~ s/\.\w+$//;
    my $f = $csrc;

    my $ll_lines  = _generate_llvm_ir($targetdir, $f);
    my $ast_nodes = _parse_llvm_ir($ll_lines);

    # Now do the renaming
    my $new_ast_nodes = _rename_regs_to_args($stref, $f, $ast_nodes);

    # Now get ready for the big job
    # Build an AST tree and simplify it for analysis

    my $ast_tree      = _build_ast_tree($new_ast_nodes);
    # my $ll_lines_rec = _emit_llvm_ir_from_ast_tree($ast_tree);
    # map {say$_} @{$ll_lines_rec};
    my $regs_types = __get_regs_types_from_ast($new_ast_nodes);

    say "\n$f\n";
    # __pp_ast_tree($ast_tree);

    my $simplified_ast_tree  = _simplify_ast_tree($ast_tree->{Tree});
    $simplified_ast_tree->{'Types'}=$regs_types;


    my $regs_w_multiple_occs = _identify_regs_w_multiple_occs($simplified_ast_tree);

    # say 'REGS:',Dumper $regs_w_multiple_occs;
    my $regs_w_multiple_occs_no_uncond = _remove_non_pred_labels($regs_w_multiple_occs, $simplified_ast_tree);

    # say Dumper $regs_w_multiple_occs_no_uncond;
    my $paths_down_from_block = _find_terminating_block($regs_w_multiple_occs_no_uncond, $simplified_ast_tree);
    # say Dumper $paths_down_from_block;
    my $common_nodes_all_paths_down_label = _get_common_nodes_all_paths_label($paths_down_from_block);
    # say Dumper $common_nodes_all_paths_down_label;

    #  And now the common node(s) for all labels for a reg!
    my $common_nodes_all_labels_down_reg = _get_common_nodes_all_labels_reg($common_nodes_all_paths_down_label);
    # say 'terminal: ',Dumper $common_nodes_all_labels_down_reg;

    my $paths_up_from_block = _find_originating_block($regs_w_multiple_occs_no_uncond, $simplified_ast_tree);
    
    my $common_nodes_all_paths_up_label = _get_common_nodes_all_paths_label($paths_up_from_block);
    # say Dumper $common_nodes_all_paths_up_label;

    #  And now the common node(s) for all labels for a reg!
    my $common_nodes_all_labels_up_reg = _get_common_nodes_all_labels_reg($common_nodes_all_paths_up_label);
    # say 'origin: ',Dumper $common_nodes_all_labels_up_reg;

    my $origins_terminals_reg = _collect_origins_terminals_reg($common_nodes_all_labels_up_reg, $common_nodes_all_labels_down_reg);
    # say Dumper $origins_terminals_reg;

    # Now we do all paths between origin and terminal and collect the condition regs. 
    my $conds_for_paths = _collect_select_conditions ($origins_terminals_reg, $regs_w_multiple_occs_no_uncond, $simplified_ast_tree);
    # $Data::Dumper::Deepcopy=1;
    say __pp_select_exprs($conds_for_paths,'haskell'); 
    my $select_exprs = __emit_select_exprs($conds_for_paths, $simplified_ast_tree); 
    # say Dumper $select_exprs;
    # Now we modify the AST to remove the branches and stores and rename the register assignments
    my $new_ast_tree = _remove_br_and_update_assignments_in_ast_tree($ast_tree, $regs_w_multiple_occs_no_uncond);
    $new_ast_tree = _insert_select_exprs_into_ast_tree($select_exprs,$new_ast_tree,$origins_terminals_reg);
    $new_ast_tree = _rename_temp_regs($new_ast_tree) ;
    # croak Dumper $new_ast_tree;
    # Now we should insert the select lines into the modified AST 
    my $new_ll_lines = _emit_llvm_ir_from_ast_tree($new_ast_tree);
    # map {say $_} @{$new_ll_lines};

    _create_llvm_ir_src($new_ll_lines, $targetdir, $f, 'll', '_tf' );
    my $no_diff=1;
    # __sanity_check($targetdir, $f.'_tf', $no_diff);
    __sanity_check($targetdir, $f.'_tf');
    # exit;
    return $stref;
}    # END of generate_llvm_ir_for_TyTra

sub _rename_regs_to_args {
    (my $stref, my $f, my $ast_nodes) = @_;
    my %regs_to_args  = ();
    my %args_to_regs  = ();
    my $new_ast_nodes = [];
    my $reg_offset    = 0;

    for my $ast_node (@{$ast_nodes}) {
        if ($ast_node->[0] eq 'Signature') {
            my $f         = $ast_node->[1];
            my $arg_types = $ast_node->[2][1];
            if ($f eq $stref->{'SubroutineName'}) {
                my @args = @{$stref->{'SubroutineArgs'}};
                $reg_offset = scalar @args;
                my @typed_args = ();
                my $reg_idx    = 0;
                for my $arg_type (@{$arg_types}) {
                    my $arg = $args[$reg_idx];

                    # say "ARG: $arg_type $arg";
                    my $typed_arg = ['TypedReg', ['Type', $arg_type], ['Reg', $arg]];
                    push @typed_args, $typed_arg;
                    $regs_to_args{$reg_idx} = $arg;
                    $args_to_regs{$arg}     = $reg_idx;
                    ++$reg_idx;
                }
                push @{$new_ast_nodes}, ['Signature', $f, ['TypedArgs', [@typed_args]]];
            }
        }
        elsif (defined __ast_node_has_reg($ast_node) ) {
            my $regs         = __get_regs_from_ast_node($ast_node, []);
            my $new_ast_node = __rename_arg_regs($ast_node, \%regs_to_args, $reg_offset);
            push @{$new_ast_nodes}, $new_ast_node;
        }
        else {
            # just copy
            push @{$new_ast_nodes}, $ast_node;
        }
    }
    return $new_ast_nodes;
}    # END of _rename_regs_to_args

sub _generate_llvm_ir {
    my ($target_dir, $csrc) = @_;

    my $tytra_c_input = "$target_dir/$csrc.c";
    my $tytra_ir      = "$target_dir/$csrc";

    my $clang = 'clang-mp-8.0';
    my $opt   = 'opt-mp-8.0';

    system("$clang -O0 -Xclang -disable-O0-optnone -emit-llvm -c $tytra_c_input -o ${tytra_ir}_tmp.bc");
    system("$opt -S -mem2reg ${tytra_ir}_tmp.bc -o $tytra_ir-raw.ll");

    open my $LL_IN, '<', "$tytra_ir-raw.ll" or die $!;
    my $ll_lines = [];
    while (my $line = <$LL_IN>) {
        chomp $line;
        push @{$ll_lines}, $line;
    }
    close $LL_IN;
    return $ll_lines;
}    # END of _generate_llvm_ir

sub _parse_llvm_ir {
    my ($ll_lines) = @_;

    my @ast_nodes    = ();
    my %called_funcs = ();
    my $in_def       = '';
    for my $line (@{$ll_lines}) {

        # say $line;
        $line =~ /define\s+void\s+\@(\w+)\((.+)\)/ && do {

            #  say $line;
            my $f             = $1;
            my $arg_types_str = $2;
            my @arg_types     = split(/\s*,\s*/, $arg_types_str);
            my $ast_node      = ['Signature', $f, ['ArgTypes', [@arg_types]]];
            push @ast_nodes, $ast_node;

            # if ($f eq $stref->{'SubroutineName'}) {
            # 	my @args = $stref->{'SubroutineArgs'};
            # }
            $in_def = $f;

            # say $f;
            next;
        };
        $line =~ /^\s*\}/ && do {

            # say $line;
            push @ast_nodes, ['EndDefinition', $in_def];
            $in_def = '';
            last;
        };
        next unless $in_def;
        $line =~ /^\s*$/ && do {

            my $ast_node = ['Blank'];
            push @ast_nodes, $ast_node;
            next;
        };

        $line =~ /;\s+<label>:(\d+):/ && do {

            # say $line;
            my $label     = $1;
            my $preds_str = '';
            $line =~ /preds\s+=\s+(.+)/ && do {
                $preds_str = $1;
            };
            my @preds     = ($preds_str ne '') ? split(/\s*,\s*/, $preds_str) : ();
            my @preds_ast = map { /\%(\w+)/; ['Reg', $1] } @preds;
            my $ast_node  = ['Label', ['Reg', $label], [@preds_ast]];
            push @ast_nodes, $ast_node;
            next;
        };

        $line =~ /^\s*;(.+)$/ && do {
            my $comment  = $1;
            my $ast_node = ['Comment', $comment];
            push @ast_nodes, $ast_node;
            next;
        };

        $line =~ /\%/ && do {
            $line =~ /=/ && do {

                # load
                if ($line =~ /\%(\w+)\s+=\s+load\s+(\w+),\s*(.+)\s*$/) {
                    my $reg      = $1;
                    my $op       = 'load';
                    my $type_str = $2;
                    my $args_str = $3;
                    my @args     = split(/\s*,\s*/, $args_str);    # typically  typed reg, attr
                    my @reg_or_const =
                      map { /(.+?)\s+\%(\w+)/ ? ['TypedReg', ['Type', $1], ['Reg', $2]] : ['Const', $_] } @args;
                    my $ast_node =
                      ['Assignment', ['Reg', $reg], ['Op', $op], [['Type', $type_str], @reg_or_const]];

                    #   ['Assignment', ['Reg', $reg], ['TypedOp', ['Type', $type_str], ['Op', $op]], [@reg_or_const]];
                    push @ast_nodes, $ast_node;

                }

                #  call
                elsif ($line =~ /\%(\w+)\s+=\s+call\s+([\w\*]+)\s+\@(.+?)\((.+?)\)\s*$/) {
                    my $reg          = $1;
                    my $type_str     = $2;
                    my $fname        = $3;
                    my $args_str     = $4;
                    my @args         = split(/\s*,\s*/, $args_str);
                    my $arg_types    = [];
                    my @reg_or_const = map {
                        if (/^(.+?)\s+\%(\w+)$/) {
                            my $type = $1;
                            my $reg  = $2;
                            push @{$arg_types}, $type;
                            ['TypedReg', ['Type', $type], ['Reg', $reg]];
                        }
                        elsif (/^\%(\w+)$/) {
                            my $reg = $1;
                            ['Reg', $reg];
                        }
                        else {
                            ['Const', $_];
                        }
                    } @args;
                    my $attr = '';
                    if ($reg_or_const[-1][0] eq 'Attribute') {
                        $attr = pop @reg_or_const;
                    }
                    my $ast_node = [
                        'Assignment',
                        ['Reg', $reg],
                        ['Call', ['Type', $type_str]],
                        ['FName', $fname],
                        ['Args', [@reg_or_const]]
                    ];
                    push @ast_nodes, $ast_node;

                    $called_funcs{$fname} =
                      ['Declaration', ['FName', $fname], ['Type', $type_str], ['ArgTypes', $arg_types]];

                    # declare double @llvm.fabs.f64(double)

                    # %reg = op type [type] rest
                }
                elsif ($line =~ /\%(\w+)\s+=\s+(\w+)\s+(\w+(?:\s+\w+)?)\s+(.+)\s*$/) {
                    my $reg      = $1;
                    my $op       = $2;
                    my $type_str = $3;
                    my $args_str = $4;
                    my @args     = split(/\s*,\s*/, $args_str);

                    # so this can be
                    my @reg_or_const = map {
                        if (/\%(\w+)\s*(.*)\s*$/) {
                            my $reg  = $1;
                            my $rest = $2;
                            if ($rest !~ /\w+/) {
                                ['Reg', $reg];
                            }
                            else {
                                (['Reg', $reg], ['Attribute', $rest]);
                            }
                        }
                        else {
                            ['Const', $_];
                        }
                    } @args;
                    my $attr = '';
                    if ($reg_or_const[-1][0] eq 'Attribute') {
                        $attr = pop @reg_or_const;
                    }
                    my $ast_node =
                      ['Assignment', ['Reg', $reg], ['TypedOp', ['Type', $type_str], ['Op', $op]], [@reg_or_const]];
                    if ($attr) {
                        push @{$ast_node}, $attr;
                    }

                    #   croak $line. ' => '.$args_str.';'.Dumper( $ast_node) if $line=~/icmp/;
                    push @ast_nodes, $ast_node;
                }
                else {
                    croak $line;
                    (my $lhs, my $rhs) = split(/\s*=\s*/, $line);
                    my $ast_node = ['Pair', $lhs, $rhs];
                    push @ast_nodes, $ast_node;
                }
                next;
            };
            $line =~ /^\s*br/ && do {
                if ($line =~ /br\s+(\w+)\s+\%(\w+)\s*,\s*label\s+\%(\w+)\s*,\s*label\s+\%(\w+)/) {
                    my $type_str = $1;
                    my $reg      = $2;
                    my $label1   = $3;
                    my $label2   = $4;
                    my $ast_node = [
                        'IfThenElse',
                        ['Cond', ['TypedReg', ['Type', $type_str], ['Reg', $reg]]],
                        ['Reg', $label1],
                        ['Reg', $label2]
                    ];
                    push @ast_nodes, $ast_node;

                }
                elsif ($line =~ /br\s+label\s+\%(\w+)/) {
                    my $label    = $1;
                    my $ast_node = ['Goto', ['Reg', $label]];
                    push @ast_nodes, $ast_node;
                }
                next;
            };

            # store float %48, float* %11, align 4
            $line =~ /^\s*(\w+)\s+(.+?)\s*$/ && do {
                my $op       = $1;
                my $args_str = $2;
                my @args     = split(/\s*,\s*/, $args_str);
                my @args_ast = map {
                    my $arg          = $_;
                    my $type_str     = '';
                    my $reg          = '';
                    my $other        = '';
                    my $arg_ast_node = [];

                    # try parse as typed args
                    if ($arg =~ /([\w\*]+)\s+\%(\w+)/) {
                        $type_str     = $1;
                        $reg          = $2;
                        $arg_ast_node = ['TypedReg', ['Type', $type_str], ['Reg', $reg]];
                    }

                    # then as plain regs
                    elsif ($arg =~ /\%(\w+)/) {
                        $reg          = $1;
                        $arg_ast_node = ['Reg', $reg];
                    }

                    # then as anything else
                    elsif ($arg =~ /(.+)/) {
                        $other        = $1;
                        $arg_ast_node = ['Attribute', $other];
                    }
                    $arg_ast_node;
                } @args;

                # $line=~/^\s*(\w+)\s+(.+?)\s+\%(\w+)\s*,\s*(.+?)\s+\%(\w+)\s*,\s*(.+)\s*$/ && do {
                my $ast_node =
                  $op eq 'store'
                  ? ['Store', ['Args', [@args_ast]]] #  $arg_ast_node = ['TypedReg', ['Type', $type_str], ['Reg', $reg]];
                  : ['Operation', ['Op', $op], ['Args', [@args_ast]]];

                # croak $line.Dumper $ast_node if $line=~/store/;
                # if ($args_ast[-1][0] eq 'Attribute') {
                # 	croak "ATTR: $line";
                # }
                push @ast_nodes, $ast_node;
                next;
            };
        };

        $line =~ /ret\s+void/ && do {
            my $ast_node = ['Return'];
            push @ast_nodes, $ast_node;
            next;
        };

        my $ast_node = ['NonRegStatement', $line];
        push @ast_nodes, $ast_node;
    }
    @ast_nodes = (@ast_nodes, map { $called_funcs{$_} } sort keys %{called_funcs});
    return \@ast_nodes;

}    # END of _parse_llvm_ir

# We write directly to a file
sub _create_llvm_ir_src {
    my ($ll_lines, $target_dir, $f, $ext, $suffix, $prefix) = @_;
    if (defined $suffix) {
        $f.=$suffix;
    }
    if (defined $prefix) {
        $f="$prefix$f";
    }
    open my $OUT, '>', "$target_dir/$f.$ext" or die $!;
    for my $ll_line (@{$ll_lines}) {
        say $OUT $ll_line;
    }
    close $OUT;
}    # END of _create_llvm_ir_src

# We should write to a list of strings and then to a file!
sub _emit_llvm_ir {
    my ($ast_nodes) = @_;
    my @ll_lines = ();

    for my $ast_node (@{$ast_nodes}) {
        # say Dumper $ast_node;
        $ast_node->[0] eq 'Lit'         && push @ll_lines, $ast_node->[1];
        $ast_node->[0] eq 'Comment'         && push @ll_lines, ';' . $ast_node->[1];
        $ast_node->[0] eq 'Blank'           && push @ll_lines, '';
        $ast_node->[0] eq 'NonRegStatement' && push @ll_lines, $ast_node->[1];
        $ast_node->[0] eq 'Return'          && push @ll_lines, '  ret void';
        $ast_node->[0] eq 'EndDefinition'   && push @ll_lines, '}';

        $ast_node->[0] eq 'Signature' && do {
            my $f = $ast_node->[1];
            if ($ast_node->[2][0] eq 'ArgTypes') {
                my $arg_types = $ast_node->[2][1];
                my $sig_str   = 'define void @' . $f . '(' . join(', ', @{$arg_types}) . ') {';
                push @ll_lines, $sig_str;
            }
            elsif ($ast_node->[2][0] eq 'TypedArgs') {
                my $typed_args = $ast_node->[2][1];
                my $sig_str =
                  'define void @' . $f . '(' . join(', ', map { __emit_reg_or_const($_) } @{$typed_args}) . ') {';
                push @ll_lines, $sig_str;
            }
        };

        #my $ast_node=['Assignment',['Reg',$reg], ['TypedOp',['Type',$type_str],['Op',$op]], [\@reg_or_const]];
        $ast_node->[0] eq 'Assignment' && do {
            my $reg = __emit_reg_or_const($ast_node->[1]);

            # ['Assignment', ['Reg', $reg], ['Call', ['Type', $type_str]], ['FName', $fname],['Args',[@reg_or_const]]];
            if ($ast_node->[2][0] eq 'Call') {
                my $type     = $ast_node->[2][1][1];
                my $fname    = $ast_node->[3][1];
                my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[4][1]});
                push @ll_lines, "  $reg = call $type \@$fname($args_str)";
            }
            else {
                my $typed_op = __emit_typed_op($ast_node->[2]);
                my $attr     = '';
                if ($ast_node->[-1][0] eq 'Attribute') {
                    $attr = $ast_node->[-1][1];
                }
                my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[3]});
                push @ll_lines, "  $reg = $typed_op $args_str $attr";
            }
        };

        $ast_node->[0] eq 'Operation' && do {

            # ,['Op',$op], ['Args',[@args_ast]]];
            my $op       = __emit_typed_op($ast_node->[1]);
            my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[2][1]});
            push @ll_lines, "  $op $args_str";
        };
        $ast_node->[0] eq 'Store' && do {

            # ['Store', ['Args',[@args_ast]]];
            my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[1][1]});
            push @ll_lines, "  store $args_str";
        };
        $ast_node->[0] eq 'IfThenElse' && do {

            # ,['Cond',['TypedReg',['Type',$type_str], ['Reg',$reg]]],
            my $cond   = __emit_reg_or_const($ast_node->[1][1]);
            my $label1 = __emit_reg_or_const($ast_node->[2]);
            my $label2 = __emit_reg_or_const($ast_node->[3]);
            push @ll_lines, "  br $cond, label $label1, label $label2";
        };

        $ast_node->[0] eq 'Goto' && do {
            my $label = __emit_reg_or_const($ast_node->[1]);
            push @ll_lines, "  br label $label";
        };

        $ast_node->[0] eq 'Label' && do {

            #  ['Label', $label,[@preds]];
            my $label     = $ast_node->[1][1];    # because wrapped in Reg
            my $preds_str = '';
            if (scalar @{$ast_node->[2]} > 0) {
                $preds_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[2]});
            }
            push @ll_lines, "; <label>:$label:" . ($preds_str ? (' ' x 37) . '; preds = ' . $preds_str : '');
        };

        $ast_node->[0] eq 'Declaration' && do {
            my $fname        = $ast_node->[1][1];
            my $ftype        = $ast_node->[2][1];
            my $arg_types    = $ast_node->[3][1];
            my $arg_type_str = join(', ', @{$arg_types});
            push @ll_lines, "declare $ftype \@$fname($arg_type_str)";
        };
    }

    return \@ll_lines;
}    # END of _emit_llvm_ir

sub __emit_llvm_ir_single_ast_node {
    my ($ast_node) = @_;
    my $ll_line = '';
    
        # say Dumper $ast_node;
        $ast_node->[0] eq 'Lit'             && do {$ll_line = $ast_node->[1]};
        $ast_node->[0] eq 'Comment'         && do {$ll_line = ';' . $ast_node->[1]};
        $ast_node->[0] eq 'Blank'           && do {$ll_line = ''};
        $ast_node->[0] eq 'NonRegStatement' && do {$ll_line = $ast_node->[1]};
        $ast_node->[0] eq 'Return'          && do {$ll_line = '  ret void'};
        $ast_node->[0] eq 'EndDefinition'   && do {$ll_line = '}'};

        $ast_node->[0] eq 'Signature' && do {
            my $f = $ast_node->[1];
            if ($ast_node->[2][0] eq 'ArgTypes') {
                my $arg_types = $ast_node->[2][1];
                my $sig_str   = 'define void @' . $f . '(' . join(', ', @{$arg_types}) . ') {';
                $ll_line = $sig_str;
            }
            elsif ($ast_node->[2][0] eq 'TypedArgs') {
                my $typed_args = $ast_node->[2][1];
                my $sig_str =
                  'define void @' . $f . '(' . join(', ', map { __emit_reg_or_const($_) } @{$typed_args}) . ') {';
                $ll_line = $sig_str;
            }
        };

        #my $ast_node=['Assignment',['Reg',$reg], ['TypedOp',['Type',$type_str],['Op',$op]], [\@reg_or_const]];
        $ast_node->[0] eq 'Assignment' && do {
            my $reg = __emit_reg_or_const($ast_node->[1]);

            # ['Assignment', ['Reg', $reg], ['Call', ['Type', $type_str]], ['FName', $fname],['Args',[@reg_or_const]]];
            if ($ast_node->[2][0] eq 'Call') {
                my $type     = $ast_node->[2][1][1];
                my $fname    = $ast_node->[3][1];
                my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[4][1]});
                $ll_line = "  $reg = call $type \@$fname($args_str)";
            }
            else {
                my $typed_op = __emit_typed_op($ast_node->[2]);
                my $attr     = '';
                if ($ast_node->[-1][0] eq 'Attribute') {
                    $attr = $ast_node->[-1][1];
                }
                my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[3]});
                $ll_line = "  $reg = $typed_op $args_str $attr";
            }
        };

        $ast_node->[0] eq 'Operation' && do {

            # ,['Op',$op], ['Args',[@args_ast]]];
            my $op       = __emit_typed_op($ast_node->[1]);
            my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[2][1]});
            $ll_line = "  $op $args_str";
        };
        $ast_node->[0] eq 'Store' && do {

            # ['Store', ['Args',[@args_ast]]];
            my $args_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[1][1]});
            $ll_line = "  store $args_str";
        };
        $ast_node->[0] eq 'IfThenElse' && do {

            # ,['Cond',['TypedReg',['Type',$type_str], ['Reg',$reg]]],
            my $cond   = __emit_reg_or_const($ast_node->[1][1]);
            my $label1 = __emit_reg_or_const($ast_node->[2]);
            my $label2 = __emit_reg_or_const($ast_node->[3]);
            $ll_line = "  br $cond, label $label1, label $label2";
        };

        $ast_node->[0] eq 'Goto' && do {
            my $label = __emit_reg_or_const($ast_node->[1]);
            $ll_line = "  br label $label";
        };

        $ast_node->[0] eq 'Label' && do {

            #  ['Label', $label,[@preds]];
            my $label     = $ast_node->[1][1];    # because wrapped in Reg
            my $preds_str = '';
            if (scalar @{$ast_node->[2]} > 0) {
                $preds_str = join(', ', map { __emit_reg_or_const($_) } @{$ast_node->[2]});
            }
            $ll_line = "; <label>:$label:" . ($preds_str ? (' ' x 37) . '; preds = ' . $preds_str : '');
        };

        $ast_node->[0] eq 'Declaration' && do {
            my $fname        = $ast_node->[1][1];
            my $ftype        = $ast_node->[2][1];
            my $arg_types    = $ast_node->[3][1];
            my $arg_type_str = join(', ', @{$arg_types});
            $ll_line = "declare $ftype \@$fname($arg_type_str)";
        };
    
    return $ll_line;
}    # END of __emit_llvm_ir_single_ast_node

sub _emit_llvm_ir_from_ast_tree {(my $ast_tree) = @_;

    my @ast_nodes =();
    # push @ast_nodes,  $ast_tree->{Signature};     

    for my $label ( @{$ast_tree->{List}} ) {
        # say Dumper $ast_tree->{Tree}{$label};
        push @ast_nodes, $ast_tree->{Tree}{$label}{LabelNode} if exists $ast_tree->{Tree}{$label}{LabelNode};
        @ast_nodes=(@ast_nodes, @{ $ast_tree->{Tree}{$label}{Block} });
        if (exists $ast_tree->{Tree}{$label}{IfThenElse}) {   
            push @ast_nodes, $ast_tree->{Tree}{$label}{IfThenElse};
        }
        elsif (exists $ast_tree->{Tree}{$label}{Goto}) {   
            push @ast_nodes, $ast_tree->{Tree}{$label}{Goto};
        }
        elsif (exists $ast_tree->{Tree}{$label}{Return}) {   
            push @ast_nodes, $ast_tree->{Tree}{$label}{Return};
        }
    }

    @ast_nodes=(@ast_nodes, @{ $ast_tree->{PostAmble} });
# say Dumper @ast_nodes;
    my $ll_lines = _emit_llvm_ir(\@ast_nodes);
    return $ll_lines;

} # END of _emit_llvm_ir_from_ast_tree


sub _pp_llvm_ast {
    (my $ast_nodes) = @_;
    my $ll_lines = _emit_llvm_ir($ast_nodes);
    map { say $_ } @{$ll_lines};
}    # END of _pp_llvm_ast

sub __emit_reg_or_const {
    (my $ast_node) = @_;

    if ($ast_node->[0] eq 'TypedReg') {
        return $ast_node->[1][1] . ' %' . $ast_node->[2][1];
    }
    elsif ($ast_node->[0] eq 'Reg') {
        return '%' . $ast_node->[1];
    }
    else {    # for Const and Attribute
        return $ast_node->[1];
    }

}    # END of __emit_reg_or_const

sub __emit_typed_op {
    (my $ast_node) = @_;

    if ($ast_node->[0] eq 'TypedOp') {
        return $ast_node->[2][1] . ' ' . $ast_node->[1][1];
    }
    elsif ($ast_node->[0] eq 'Op') {
        return $ast_node->[1];
    }
    else {
        croak Dumper $ast_node;
    }
}    # END of __emit_typed_op

sub __ast_node_has_reg {
    my ($ast_node) = @_;
    if (ref($ast_node) eq 'ARRAY') {
        if ($ast_node->[0] eq 'Reg') {
            return $ast_node->[1];
        }
        else {
            for my $elt (@{$ast_node}) {
                my $maybe_reg = __ast_node_has_reg($elt);
                return $maybe_reg if defined $maybe_reg;
            }
        }
    }
    else {
        return undef;
    }
}    # END of __ast_node_has_reg

sub __get_assigned_reg_from_ast_node {
    my ($ast_node) = @_;
    if ($ast_node->[0] eq 'Assignment') {
        return $ast_node->[1][1];
    }
    elsif ($ast_node->[0] eq 'Store') {
        return $ast_node->[1][1][1][2][1];
    }
    else {
        return '';
    }
}    # END of __get_assigned_reg_from_ast_node

sub __get_store_from_ast_node {
    my ($ast_node) = @_;
    if ($ast_node->[0] eq 'Store') {
#  ['Store', ['Args', [ ['TypedReg', ['Type', $type_str], ['Reg', $reg]], ... ]]] ;
#               the target reg              the reg with the new value   the type of that reg
        my $target_reg = $ast_node->[1][1][1][2][1];
        my $target_reg_type = $ast_node->[1][1][1][1][1];
        # my $update_val = __emit_reg_or_const($ast_node->[1][1][0]) ;
        my $update_val = $ast_node->[1][1][0] ;
        # say "$target_reg => $update_val";
        return [ $target_reg , [$update_val, $target_reg_type] ];
    }
    else {
        return undef;
    }
}    # END of __get_store_from_ast_node


# start with an empty $regs array []
sub __get_regs_from_ast_node {
    my ($ast_node, $regs) = @_;
    if (ref($ast_node) eq 'ARRAY') {
        if ($ast_node->[0] eq 'Reg') {
            push @{$regs}, $ast_node->[1];
            return $regs;
        } else {
            for my $elt (@{$ast_node}) {
                $regs = __get_regs_from_ast_node($elt, $regs);
            }
            return $regs;
        }
    }
    else {
        return $regs;
    }
}    # END of __get_regs_from_ast_node


# start with empty {}
sub __get_reg_types_from_ast_node {
    my ($exp, $regs_types) = @_;
# If I want to get the types for as many regs as possible, I should look at:
    if ($exp->[0] eq 'Signature'
    and $exp->[2][0] eq 'TypedArgs'
    ) {
        #  ['Signature', $f, ['TypedArgs', [@typed_args]]];
        for my $typed_arg (@{$exp->[2][1]}) {
            #  ['TypedReg', ['Type', $arg_type], ['Reg', $arg]];
            my $reg = $typed_arg->[2][1];
            my $type = $typed_arg->[1][1];
            $regs_types->{$reg} = $type;
        }                
    }
    elsif ($exp->[0] eq 'TypedReg') {
    # ['TypedReg', ['Type', $type], ['Reg', $reg]]; 
        my $reg = $exp->[2][1];
        my $type = $exp->[1][1];
        $regs_types->{$reg} = $type;
    }
    elsif ($exp->[0] eq 'Assignment') {
        if ($exp->[2][0] eq 'Op') {
    # ['Assignment', ['Reg', $reg], ['Op', $op], [['Type', $type_str], @reg_or_const]];
            my $reg = $exp->[1][1];
            my $type = $exp->[3][0][1];
            $regs_types->{$reg} = $type;
        }
        elsif ($exp->[2][0] eq 'TypedOp') {
    # ['Assignment', ['Reg', $reg], ['TypedOp', ['Type', $type_str], ['Op', $op]], [@reg_or_const]];
            my $reg = $exp->[1][1];
            my $type = $exp->[2][1][1];
            $regs_types->{$reg} = $type;
        }
        elsif ($exp->[2][0] eq 'Call') {
            my $reg = $exp->[1][1];
            my $type = $exp->[2][1][1];
            $regs_types->{$reg} = $type;
    # ['Assignment', ['Reg', $reg], ['Call', ['Type', $type_str]], ['FName', $fname], ['Args', [@reg_or_const]] ];
        }
    }
    return $regs_types;

} # END of __get_reg_types_from_ast_node


sub __get_regs_types_from_ast {
    my ($ast_nodes) = @_;
    my $regs_types = {};

    for my $ast_node (@{$ast_nodes}) {
        $regs_types = __get_reg_types_from_ast_node($ast_node,$regs_types);
    }
    return $regs_types;
} # END of __get_regs_types_from_ast

sub __rename_arg_regs {
    my ($ast_node, $regs_to_args, $reg_offset) = @_;
    if (ref($ast_node) eq 'ARRAY') {
        if ($ast_node->[0] eq 'Reg') {

            # rename it
            if (exists $regs_to_args->{$ast_node->[1]}) {
                $ast_node->[1] = $regs_to_args->{$ast_node->[1]};
            }
            else {
                $ast_node->[1] -= $reg_offset;
            }

            # we're done, return the node
            return $ast_node;
        }
        else {
            my $new_node = [];
            for my $elt (@{$ast_node}) {
                push @{$new_node}, __rename_arg_regs($elt, $regs_to_args, $reg_offset);
            }
            return $new_node;
        }
    }
    else {
        return $ast_node;
    }
}    # END of __rename_arg_regs

# FIXME: not sure about the handling of the state. I assume if it is a ref it will be OK
sub __rename_regs_in_ast_node { (my $ast_node, my $renamer, my $renamer_state)=@_;

    if (ref($ast_node) eq 'ARRAY') {
        if ($ast_node->[0] eq 'Reg') {
            return $renamer->($ast_node,$renamer_state);
        }
        else {
            my $new_node = [];
            for my $elt (@{$ast_node}) {
                push @{$new_node}, __rename_regs_in_ast_node($elt, $renamer, $renamer_state);
            }
            return $new_node;
        }
    }
    else {
        return $ast_node;
    }
}



sub __sanity_check {
    my ($target_dir, $f, $no_diff) = @_;
    if (not defined $no_diff ) {
        # system("opt-mp-8.0 -S $target_dir/$f.ll  | diff -u -w - $target_dir/$f.ll");
        # system("/opt/local/bin/bash","-c"," cat $target_dir/$f.ll");
        system("/opt/local/bin/bash",'-c',"diff -u -w <(opt-mp-8.0 -O0 -S $target_dir/$f.ll | grep -v -E \'^;|^\\s*\$|source_filename|attributes\') <(grep -v -E \'^\\;\\s+(?:br|store|.label)\|^\\s*\$' $target_dir/$f.ll)");
    } else {
        system("opt-mp-8.0 -S $target_dir/$f.ll ");
    }
}

=pod LLVM IR sample
  %14 = icmp eq i32 %0, 1
  br i1 %14, label %15, label %49
; <label>:15:                                     ; preds = %13
  %16 = fpext float %5 to double
  %17 = fmul double 2.500000e-01, %16
  %18 = add nsw i32 %2, %1
  %21 = sitofp i32 %20 to double
  %22 = fmul double %17, %21
  %23 = fsub double 1.000000e+00, %22
  %48 = fadd float %47, %46
  store float %48, float* %11, align 4
  br label %50

; <label>:49:                                     ; preds = %13
  store float %6, float* %11, align 4
  ret void  
  %84 = load float, float* %30, align 4

so we have
['Assignment',$reg, ['TypedOp',$type,$op], [$reg_or_$const]]]]  
['Operation',['TypedOp',$type,$op], ['Args',[' ',]]]  Const or Reg
[' ',]  eg. [' ','ret','void']
[';',$comment] 
['Label',$label,[$preds]] => custom emitter
['Branch',['Cond',['TypedReg',$type, $reg]],$label1, $label2]

=cut

# Because I need to keep the ordering of the labels, this is a List =>[], Tree=>{} combo
sub _build_ast_tree {
    my ($ast_nodes) = @_;
    my $label       = 0;
    my %ast_tree    = (
        Signature => [],
        List      => [$label],
        Tree      => {$label => {Block => [],},},
        PostAmble => []
    );
    my $idx=0;
    for my $ast_node (@{$ast_nodes}) {
        if ($ast_node->[0] eq 'Signature') {
            $ast_tree{Signature} = $ast_node;
        }
        if ($ast_node->[0] eq 'Label') {
            $label = $ast_node->[1][1];
            push @{$ast_tree{List}}, $label;
            $ast_tree{Tree}{$label} = {
                Preds => [],
                Block => [],
                LabelNode => $ast_node
            };
            if (scalar @{$ast_node->[2]} > 0) {
                $ast_tree{Tree}{$label}{Preds} = $ast_node->[2];
            }
        }
        elsif ($ast_node->[0] eq 'IfThenElse') {
            $ast_tree{Tree}{$label}{IfThenElse} = $ast_node;
        }
        elsif ($ast_node->[0] eq 'Goto') {
            $ast_tree{Tree}{$label}{Goto} = $ast_node;
        }
        elsif ($ast_node->[0] eq 'Return') {
            $ast_tree{Tree}{$label}{Return} = $ast_node;
        }
        elsif ($ast_node->[0] eq 'EndDefinition') { 
            last;
        }
        else {    # any other node goes onto the current block
            push @{$ast_tree{Tree}{$label}{Block}}, $ast_node;
        }
        ++$idx;
    }
    my $end_idx = scalar @{$ast_nodes}-1;
    # push @{$ast_tree{PostAmble}},['Comment',"POSTAMBLE: $idx .. $end_idx"];
    
    for my $ast_node_idx ($idx .. $end_idx ) {
        push @{$ast_tree{PostAmble}}, $ast_nodes->[$ast_node_idx];
    }

    return \%ast_tree;
}    # END of _build_ast_tree

sub __pp_ast_tree {
    my ($ast_tree) = @_;
    say $ast_tree->{Signature}[1];
    for my $label (@{$ast_tree->{List}}) {
        say "$label => {";
        if (exists $ast_tree->{Tree}{$label}{Preds}) {
            say "\t" . 'Preds => ' . join(', ', map { $_->[1] } @{$ast_tree->{Tree}{$label}{Preds}});
        }
        say "\t" . 'Block => '

          # .join("\n\t\t",
          . join(', ', grep { $_ ne '' } map { __get_assigned_reg_from_ast_node($_); } @{$ast_tree->{Tree}{$label}{Block}});

        if (exists $ast_tree->{Tree}{$label}{IfThenElse}) {
            say "\t"
              . 'IfThenElse => '
              . $ast_tree->{Tree}{$label}{IfThenElse}[1][1][2][1] . ' ? '
              . $ast_tree->{Tree}{$label}{IfThenElse}[2][1] . ' : '
              . $ast_tree->{Tree}{$label}{IfThenElse}[3][1];

            #join("\n",@{ _emit_llvm_ir([$ast_tree->{$label}{IfThenElse}])});
        }
        if (exists $ast_tree->{Tree}{$label}{Goto}) {
            say "\t" . 'Goto => ' . $ast_tree->{Tree}{$label}{Goto}[1][1];

            # join("\n",@{ _emit_llvm_ir([$ast_tree->{$label}{Goto}]) });
        }
        if (exists $ast_tree->{Tree}{$label}{Return}) {
            say "\t" . 'Return';
        }
        say "}";
    }
}

=pod Simplified AST
The simplified AST tree does not have the source, only the label/reg info
$simplified_ast_tree{$label} = {
    Preds => [$pred_label_1,...],
    Block => [ [$reg_1, $line_idx_1], ... ],
    IfThenElse => [$cond_reg, $label_true, $label_false],
    Goto => $label,
    Return => 1
    Store => {$reg => $new_reg,...}
};
=cut
sub _simplify_ast_tree {
    my ($ast_tree) = @_;
    my %simplified_ast_tree = ();
    for my $label (sort keys %{$ast_tree}) {
        my @preds = ();
        if (exists $ast_tree->{$label}{Preds}) {
            @preds = map { $_->[1] } @{$ast_tree->{$label}{Preds}};
        }
        $simplified_ast_tree{$label}{Preds} = \@preds;

        # Regs are paired with the line idx in Block
        my $idx = 0;
        my @regs =
          grep { $_->[0] ne '' } map { [__get_assigned_reg_from_ast_node($_), $idx++]; } @{$ast_tree->{$label}{Block}};
        $simplified_ast_tree{$label}{Block} = \@regs;
        my @stores =  grep { defined $_ } map { __get_store_from_ast_node($_) } @{$ast_tree->{$label}{Block}};  
        
        my $store_table = { map { $_->[0] => $_->[1] } @stores };
        
        $simplified_ast_tree{$label}{Store} = $store_table;

        if (exists $ast_tree->{$label}{IfThenElse}) {
            $simplified_ast_tree{$label}{IfThenElse} = [
                $ast_tree->{$label}{IfThenElse}[1][1][2][1], $ast_tree->{$label}{IfThenElse}[2][1],
                $ast_tree->{$label}{IfThenElse}[3][1]
            ];
        }
        if (exists $ast_tree->{$label}{Goto}) {
            $simplified_ast_tree{$label}{Goto} = $ast_tree->{$label}{Goto}[1][1];
        }
        if (exists $ast_tree->{$label}{Return}) {
            $simplified_ast_tree{$label}{Return} = 1;
        }
    }
    return \%simplified_ast_tree;
}    # END of _simplify_ast_tree

# returns a hash with $reg as keys and as values a hash of the labels
# %labels_for_reg =(
#    $reg => {$label =>[$reg, $idx]}
# )
sub _identify_regs_w_multiple_occs { my ($s_ast_tree) = @_;
    my %labels_for_reg = ();
    for my $label (sort keys %{$s_ast_tree}) {
        map { $labels_for_reg{$_->[0]}{$label} = $_ } @{$s_ast_tree->{$label}{Block}};
    }

    for my $reg (keys %labels_for_reg) {
        if (scalar keys %{$labels_for_reg{$reg}} < 2) {
            delete $labels_for_reg{$reg};
        }
    }
    return \%labels_for_reg;
}    # END of _identify_regs_w_multiple_occs

# We must consider only labels that occur in Preds!
sub _remove_non_pred_labels { my ($labels_for_reg, $s_ast_tree) = @_;
    my %label_in_preds = ();
    for my $label (sort keys %{$s_ast_tree}) {
        if (exists $s_ast_tree->{$label}{Preds}) {
            for my $pred_label (@{$s_ast_tree->{$label}{Preds}}) {
                $label_in_preds{$pred_label} = $label;
            }
        }
    }

    for my $reg (sort keys %{$labels_for_reg}) {
        my @labels              = sort keys %{$labels_for_reg->{$reg}};
        my @labels_not_in_preds = grep { not exists $label_in_preds{$_} } @labels;
        for my $non_pred_label (@labels_not_in_preds) {
            delete $labels_for_reg->{$reg}{$non_pred_label};
        }
    }
    return $labels_for_reg;
}    # END of _remove_non_pred_labels

=pod Terminal block
To find the terminating block for all branches.
So, starting from a block with a condition, this is the common block where all paths via conditions lead to.
Maybe like this:
- Given a node with an assignment, i.e. $labels_for_reg;
- Follow all paths that do not have another assignment => either IfThenElse or Goto
- Create an (ordered) list of the nodes
- Go right to the end
Then, for all these paths, check the first common node. That is the one.
=cut
sub _find_terminating_block {
    my ($labels_for_reg, $s_ast_tree) = @_;
    my %paths_down_from_block = ();
    for my $reg (sort keys %{$labels_for_reg}) {
        $paths_down_from_block{$reg} = {};
        for my $label (sort keys %{$labels_for_reg->{$reg}}) {
            $paths_down_from_block{$reg}{$label} = __collect_paths_down_from_block($s_ast_tree, $label, [], []);
        }
    }
    return \%paths_down_from_block;
}    # END of _find_terminating_block

# This is naturally a tree, so how do I turn this into separate paths?
# Non-tail recursion 
sub __collect_paths_down_from_block {
    my ($s_ast_tree, $label, $path_from_block, $paths_from_block) = @_;
    if (exists $s_ast_tree->{$label}{Goto}) {
        my $next_label = $s_ast_tree->{$label}{Goto};
        push @{$path_from_block}, $next_label;
        $paths_from_block = __collect_paths_down_from_block($s_ast_tree, $next_label, $path_from_block, $paths_from_block);
    }
    elsif (exists $s_ast_tree->{$label}{IfThenElse}) {
        my $next_label_t      = $s_ast_tree->{$label}{IfThenElse}[1];
        my $next_label_f      = $s_ast_tree->{$label}{IfThenElse}[2];
        my @path_from_block_t = @{$path_from_block};
        my @path_from_block_f = @{$path_from_block};

        push @path_from_block_t, $next_label_t;
        push @path_from_block_f, $next_label_f;
        $paths_from_block = __collect_paths_down_from_block($s_ast_tree, $next_label_t, [@path_from_block_t], $paths_from_block);
        $paths_from_block = __collect_paths_down_from_block($s_ast_tree, $next_label_f, [@path_from_block_f], $paths_from_block);
    }
    else {
        # Terminal node, return the path
        push @{$paths_from_block}, $path_from_block;
        return $paths_from_block;
    }
}    # END of __collect_paths_down_from_block

# so now that I have all these paths, I must find the nodes that are common
# First, we get the common nodes for all paths, per label
sub _get_common_nodes_all_paths_label {
    my ($paths_down_from_block) = @_;
    my $common_nodes_all_paths_label = {};
    for my $reg (sort keys %{$paths_down_from_block}) {
        $common_nodes_all_paths_label->{$reg} = {};
        for my $label (sort keys %{$paths_down_from_block->{$reg}}) {
            $common_nodes_all_paths_label->{$reg}{$label} = {};
            my $all_paths    = $paths_down_from_block->{$reg}{$label};
            my %common_paths = ();

            # First create the union
            my @union_of_all_paths = ();
            my @all_path_sets      = ();

            for my $path (@{$all_paths}) {
                @union_of_all_paths = (@union_of_all_paths, @{$path});
                my %path_set = map { $_ => 1 } @{$path};
                push @all_path_sets, \%path_set;
            }
            my %unique_nodes = map { $_ => 1 } @union_of_all_paths;

            # Then test every elt in the union against all paths, keep only the elts that match all
            for my $node (sort keys %unique_nodes) {
                my $is_common = 1;
                for my $path_set (@all_path_sets) {
                    if (not exists $path_set->{$node}) {
                        $is_common = 0;
                        last;
                    }
                }
                if ($is_common) {
                    $common_paths{$node} = 1;
                }
            }
            $common_nodes_all_paths_label->{$reg}{$label} = [\%common_paths, $all_paths->[0]];
        }
    }
    return $common_nodes_all_paths_label;
}    # END of _get_common_nodes_all_paths_label

# It is possible that there are multiple nodes common to all paths, and we need to keep the closest one.
# Which means I need to keep the ordering.
sub _get_common_nodes_all_labels_reg {
    my ($common_nodes_all_paths_label) = @_;
    my $common_nodes_all_labels_reg = {};
    for my $reg (sort keys %{$common_nodes_all_paths_label}) {
        $common_nodes_all_labels_reg->{$reg} = {};

        # Again, we do as above: make the union, compare to each separate set
        my %union_of_all_labels = ();
        for my $label (sort keys %{$common_nodes_all_paths_label->{$reg}}) {
            %union_of_all_labels = (%union_of_all_labels, %{$common_nodes_all_paths_label->{$reg}{$label}[0]});
        }
        my $a_label; # because it does not matter which label
        for my $node (sort keys %union_of_all_labels) {
            my $is_common = 1;
            for my $label (sort keys %{$common_nodes_all_paths_label->{$reg}}) {
                $a_label = $label;
                if (not exists $common_nodes_all_paths_label->{$reg}{$label}[0]{$node}) {
                    $is_common = 0;
                    last;
                }
            }
            if ($is_common) {
                $common_nodes_all_labels_reg->{$reg}{$node} = 1;
            }
        }

   # If there is a common "tail", it will be common to all.
   # So I can pick any path, and then simply test for the first node encountered which occurs in $common_nodes_all_labels_reg
        my $path = $common_nodes_all_paths_label->{$reg}{$a_label}[1];
        # say "REG: $reg PATH:" . Dumper($path) . ' ' . Dumper($common_nodes_all_labels_reg->{$reg});

        # So now I need to find the first elt in $path which occurs in $common_nodes_all_labels_reg->{$reg}
        my $first_common_node;
        for my $node (@{$path}) {
            if (exists $common_nodes_all_labels_reg->{$reg}{$node}) {
                $first_common_node = $node;
                last;
            }
        }
        $common_nodes_all_labels_reg->{$reg} = {$first_common_node => 1};
    }
    return $common_nodes_all_labels_reg;
}    # END of _get_common_nodes_all_labels_reg

# Now we have to do the same thing upwards from the nodes with assignments
sub _find_originating_block { my ($labels_for_reg, $s_ast_tree)=@_;
    my %paths_up_from_block = ();

    for my $reg (sort keys %{$labels_for_reg}) {
        $paths_up_from_block{$reg} = {};
        for my $label (sort keys %{$labels_for_reg->{$reg}}) {
            my $paths = __collect_paths_up_from_block($s_ast_tree, $label, [$label]);
            $paths_up_from_block{$reg}{$label} = $paths;
        }
    }

    return \%paths_up_from_block;
}  # END of _find_originating_block

# Main difference with the downward path is that I only need to follow one of the paths up from each label
# Come to think of it, this was maybe true for the downward path too?
# So we have a simple recursion
sub __collect_paths_up_from_block { my ($s_ast_tree, $label, $path_from_block) = @_;
# say "LABEL1:";
# say $label;
if (exists $s_ast_tree->{$label}{Preds} and scalar @{$s_ast_tree->{$label}{Preds}}>0) {
    my $next_label = $s_ast_tree->{$label}{Preds}[0];
    # say "NEXT LABEL: $next_label";
    push @{$path_from_block}, $next_label;
    __collect_paths_up_from_block($s_ast_tree, $next_label, $path_from_block);
} else {
# Terminal node, return the path
# I return this in an array for compat with the utility functions
    return [$path_from_block];
}
} # END of __collect_paths_up_from_block
# Once that is done we can follow all paths between these two common nodes and build the conditional expression for each path
# 

sub _collect_origins_terminals_reg { my ($common_nodes_all_labels_up_reg, $common_nodes_all_labels_down_reg)=@_; 
    my $origins_terminals_reg = {};
    for my $reg (sort keys %{ $common_nodes_all_labels_down_reg }) {
        my @oo = each %{ $common_nodes_all_labels_up_reg->{$reg} };
        my $origin = shift @oo;

        my @tt = each %{ $common_nodes_all_labels_down_reg->{$reg} };
        my $terminal = shift @tt;
        $origins_terminals_reg->{$reg}=[$origin, $terminal];
    }
    return $origins_terminals_reg;
} # END of _collect_origins_terminals_reg

sub _collect_select_conditions {
    my ($origins_terminals_reg, $labels_for_reg, $s_ast_tree) = @_;
    my %conds_for_paths = ();
    for my $reg (sort keys %{$origins_terminals_reg}) {
        my ($origin,$terminal) = @{ $origins_terminals_reg->{$reg} };
        # say "$origin,$terminal";
        my $assignment_node_for_path = exists $labels_for_reg->{$reg}{$origin} ? [$origin] : [''];
        $conds_for_paths{$reg} = __collect_conds_for_path($s_ast_tree, $reg, $labels_for_reg, $origin, $terminal, [$assignment_node_for_path], []);
    }
    return \%conds_for_paths;
}    # END of _collect_select_conditions

# This is naturally a tree, so how do I turn this into separate paths?
sub __collect_conds_for_path {
    my ($s_ast_tree, $reg, $labels_for_reg, $label, $terminal, $conds_for_path, $conds_for_paths) = @_;
    if (exists $labels_for_reg->{$reg}{$label}) {
        $conds_for_path->[0]=["$label"];
    }
    # say 'done? '.$label.'<>'.$terminal.' <'.($label==$terminal).'>';
    if ($label==$terminal) {
        # $label.': Done!';
        push @{$conds_for_paths}, $conds_for_path;
        return $conds_for_paths;
    } else {
        if (exists $s_ast_tree->{$label}{Goto}) {
            
            my $next_label = $s_ast_tree->{$label}{Goto};        
            # say $label.': Goto '.$next_label;
            $conds_for_paths = __collect_conds_for_path($s_ast_tree, $reg, $labels_for_reg, $next_label, $terminal, $conds_for_path, $conds_for_paths);
        }
        elsif (exists $s_ast_tree->{$label}{IfThenElse}) {
            
            # say Dumper $s_ast_tree->{$label}{IfThenElse};
            my $cond = $s_ast_tree->{$label}{IfThenElse}[0];
            my $next_label_t      = $s_ast_tree->{$label}{IfThenElse}[1];
            my $next_label_f      = $s_ast_tree->{$label}{IfThenElse}[2];
            my @path_from_block_t = @{$conds_for_path};
            my @path_from_block_f = @{$conds_for_path};

            push @path_from_block_t, $cond;
            push @path_from_block_f, -1*$cond;
            # say $label.': IfThenElse '.$next_label_t;
            $conds_for_paths = __collect_conds_for_path($s_ast_tree, $reg, $labels_for_reg, $next_label_t, $terminal,[@path_from_block_t], $conds_for_paths);
            # say $label.': IfThenElse '.$next_label_f;
            $conds_for_paths = __collect_conds_for_path($s_ast_tree, $reg, $labels_for_reg, $next_label_f, $terminal,[@path_from_block_f], $conds_for_paths);
        }
    }    
}    # END of __collect_conds_for_path



# OK, I now have all composite conditions for all paths, as well as the reg assigned via that path
# Let's first do a simple pretty-printer

# We need to distinguish between assigned regs and regs written to in a store
# So we need that information here
# Which means it should be at least present in the simplified AST as well
sub __pp_select_exprs { my ($conds_for_paths_, $hs)=@_;
    my $conds_for_paths = dclone($conds_for_paths_);
    for my $reg (sort keys %{ $conds_for_paths }) {
        my $conds_per_label={};
        for my $path (  @{ $conds_for_paths->{$reg} } ) {
            my ($label) = @{ shift @{$path} };
            if (not exists $conds_per_label->{$label}) {
                $conds_per_label->{$label}=[$path];
            } else {
                push @{$conds_per_label->{$label}}, $path;
            }
        }
        my @select_cond_lines=();
        my $select_expr_str = "$reg = ";
        my @labels = sort keys %{$conds_per_label};
        my $last_label = pop @labels;     
            
        for my $label (@labels) {            
            my $conds_expr_str = __pp_cond_expr($conds_per_label->{$label},$hs);            
            if (defined $hs) {
                $select_expr_str .= "if $conds_expr_str then ${reg}_${label} else ";
            } else {
                $select_expr_str .= "$conds_expr_str ? ${reg}_${label} : ";
            }
            
        }
        $select_expr_str.=  "${reg}_${last_label}";
        
        say $select_expr_str;
        say  '';
    }

} # END of __pp_select_exprs

sub __pp_cond_expr { my ($conds,$hs)=@_;
    my @cond_expr_substrs=();
    for my $cond (@{ $conds }) {
        if (defined $hs) {
            push @cond_expr_substrs , scalar @{$cond}>1 ? '('.join(' && ', map { $_< 0 ?  "(!b".(-1*$_).')' : 'b'.$_ } @{$cond}).')' : map { $_< 0 ?  "(! b".(-1*$_).')' : 'b'.$_ } @{$cond};
        } else {
            push @cond_expr_substrs , scalar @{$cond}>1 ? '('.join(' and ', map { $_< 0 ?  "(not b".(-1*$_).')' : 'b'.$_ } @{$cond}).')' : map { $_< 0 ?  "(not b".(-1*$_).')' : 'b'.$_ } @{$cond};            
        }
    }
    my $cond_expr_str = join(defined $hs ? ' || ' : ' or ',  @cond_expr_substrs);
    return scalar @cond_expr_substrs > 1 ? "($cond_expr_str)" : $cond_expr_str;
} # END of __pp_cond_expr

# To make this a proper emitter, we need the type info for all regs.
sub __emit_select_exprs { my ($conds_for_paths, $s_ast_tree)=@_;
    
    my %select_exprs=();
    my $unique_regs={};
    for my $reg (sort keys %{ $conds_for_paths }) {
        my $type = exists $s_ast_tree->{'Types'}{$reg} ? $s_ast_tree->{Types}{$reg} : '';
        # if ($type eq '') {
        #     say "WARNING: no type for register $reg!";
        # } else {
        #     say "REG type for register $reg :: $type";
        # }
        my $conds_per_label={};
        for my $path (  @{ $conds_for_paths->{$reg} } ) {
            my ($label) = @{ shift @{$path} };
            if (not exists $conds_per_label->{$label}) {
                $conds_per_label->{$label}=[$path];
            } else {
                push @{$conds_per_label->{$label}}, $path;
            }
        }
        my @select_cond_lines=();
        my $select_expr_str = "$reg = ";
        my @labels = sort keys %{$conds_per_label};
        my $last_label = pop @labels;     
        # I assume that if one of the exprs is a store, all of them must be store
        my $is_store =  exists $s_ast_tree->{$last_label}{Store} and exists  $s_ast_tree->{$last_label}{Store}{$reg} ? 1 : 0;        
        my $cond_reg = '';
        my $select_chain_reg = $is_store ? $reg.'_store' : $reg;        
        
        my $target_reg = $reg;
        my  $reg_type =  $s_ast_tree->{$last_label}{Store}{$reg}->[1];
        my $prev_select_chain_reg = 'prev_'.$target_reg.'_0';
        my $ct=0;
        for my $label (@labels) {
            # my $is_store =  exists $s_ast_tree->{$label}{Store} and exists  $s_ast_tree->{$label}{Store}{$reg} ? 1 : 0;
            my ($cond_expr_lines, $cond_reg, $unique_regs) = __emit_cond_expr($conds_per_label->{$label}, $unique_regs, $reg);
            if ($ct == scalar @labels - 1) {                
                if ($is_store ) {
                    my ($update_reg_expr, $reg_type) = @{ $s_ast_tree->{$label}{Store}{$reg} };
                    my ($last_update_reg_expr, $last_reg_type) = @{$s_ast_tree->{$last_label}{Store}{$reg}};
                    # $select_expr_str =   "\%$select_chain_reg = select i1 \%$cond_reg , $update_reg_expr, $last_update_reg_expr";
                    $select_expr_str =  [
                        'Assignment', 
                        ['Reg', $select_chain_reg], 
                        ['TypedOp', ['Type', 'i1'], ['Op', 'select']], 
                        [
                            ['Reg',$cond_reg],
                            $update_reg_expr,
                            $last_update_reg_expr
                        ]
                    ];
                 } else {
                    
                    # $select_expr_str =   "\%$select_chain_reg = select i1 \%$cond_reg , $type \%${reg}_${label}, $type \%${reg}_${last_label}";
                    $select_expr_str =  [
                        'Assignment', 
                        ['Reg', $select_chain_reg], 
                        ['TypedOp', ['Type', 'i1'], ['Op', 'select']], 
                        [
                                ['Reg',$cond_reg],
                                ['TypedReg',['Type',$type],['Reg',"${reg}_${label}"]],
                                ['TypedReg',['Type',$type],['Reg',"${reg}_${last_label}"]]
                        ]
                    ];
                }
            } else {
                if ($is_store ) {                    
                    my ($update_reg_expr, $reg_type) = @{ $s_ast_tree->{$label}{Store}{$reg} };
                    my $store_reg_type = $type;        
                    $store_reg_type=~s/\*$//;

                    # $select_expr_str =   "\%$select_chain_reg = select i1 \%$cond_reg , $update_reg_expr, $type \%$prev_select_chain_reg";
                    $select_expr_str =  [
                        'Assignment', 
                        ['Reg', $select_chain_reg], 
                        ['TypedOp', ['Type', 'i1'], ['Op', 'select']], 
                        [
                                ['Reg',$cond_reg],
                                $update_reg_expr,
                                ['TypedReg',['Type',$store_reg_type],['Reg',$prev_select_chain_reg]]
                        ]
                    ];

                } else {
                    # $select_expr_str =   "\%$select_chain_reg = select i1 \%$cond_reg , $type \%${reg}_${label}, $type \%$prev_select_chain_reg";
                    $select_expr_str =  [
                        'Assignment', 
                        ['Reg', $select_chain_reg], 
                        ['TypedOp', ['Type', 'i1'], ['Op', 'select']], 
                        [
                                ['Reg',$cond_reg],
                                ['TypedReg',['Type',$type],['Reg',"${reg}_${label}"]],
                                ['TypedReg',['Type',$type],['Reg',$prev_select_chain_reg]]
                        ]
                    ];                    
                }
            }

            if ($is_store) {
                my $store_reg_type = $type;        
                $store_reg_type=~s/\*$//;
                # push @select_cond_lines, "store $store_reg_type \%$select_chain_reg, $reg_type \%$target_reg";
                push @select_cond_lines, ['Store', 
                    ['Args', 
                        [
                            ['TypedReg',['Type',$store_reg_type], ['Reg',$select_chain_reg]],
                            ['TypedReg',['Type',$reg_type],  ['Reg',$target_reg]]
                        ]
                    ]
                ];
            }
                      
            push @select_cond_lines, $select_expr_str;
            if ($ct <= scalar @labels - 1) {
                for my $cond_line (reverse @{$cond_expr_lines}) {
                    push @select_cond_lines, $cond_line;
                }
            }
            $select_chain_reg=$prev_select_chain_reg;
            $ct++;
            $prev_select_chain_reg = 'prev_'.$target_reg.'_'.$ct;
                                      
        }
        $select_exprs{$reg}= [reverse  @select_cond_lines] ;
    }
    return \%select_exprs;
} # END of __emit_select_exprs


# for every op we rename with the name of the reg and the op, so not_$reg; and_$reg1_$reg2; and we chain these names
sub __emit_cond_expr { my ($conds, $unique_cond_regs, $target_reg)=@_;
my @orig_conds=@{$conds};
my @cond_expr_lines=();
$unique_cond_regs={}; # temp hack!
    my @cond_expr_substrs=();
    my $ct=0;
    for my $cond (@orig_conds) {
        ++$ct;
        for my $sub_cond (@{$cond}) {
            if ($sub_cond < 0 ) {
                my $reg = -1*$sub_cond;
                $sub_cond= 'not_'.$reg.'_'.$ct;
                my $sub_cond_reg = $sub_cond;
                if (not exists $unique_cond_regs->{$sub_cond_reg}) {
                    $unique_cond_regs->{$sub_cond_reg}=1;
            # Another catch: LLVM does not have a not (!) 
            # So I generate xor i1 %reg, ¡1                
                # push @cond_expr_lines, "\%$sub_cond = xor i1 \%$reg, 1"; 
                push @cond_expr_lines, ['Assignment', ['Reg', $sub_cond_reg], ['TypedOp', ['Type', 'i1'], ['Op', 'xor']], [['Reg',$reg],['Const','true']]];
                } 
                # else {
                #     say "REG $sub_cond_reg already defined!";
                # }
            }
        }
        if (@{$cond}>1) {
            my $arg1=shift @{$cond};
            my $arg2= $cond->[0];
            my $and_reg='and_'.$arg1.'_'.$arg2.'_'.$ct;; 
            $cond->[0]=$and_reg;
            # push @cond_expr_lines, "\%$and_reg = and i1 \%$arg1 \%$arg2";
            if (not exists $unique_cond_regs->{$and_reg}) {
                    $unique_cond_regs->{$and_reg}=1;
            push @cond_expr_lines,['Assignment', ['Reg', $and_reg], ['TypedOp', ['Type', 'i1'], ['Op', 'and']], [['Reg',$arg1],['Reg',$arg2]]];
            }
            while (@{$cond}>1) {
                my $arg1=shift @{$cond};
                my $arg2= $cond->[0];
                my $and_reg='and_'.$arg1.'_'.$arg2.'_'.$ct;;
                $cond->[0]=$and_reg;
                if (not exists $unique_cond_regs->{$and_reg}) {
                    $unique_cond_regs->{$and_reg}=1;
                # push @cond_expr_lines, "\%$and_reg = and i1 \%$arg1 \%$arg2";
                    push @cond_expr_lines,['Assignment', ['Reg', $and_reg], ['TypedOp', ['Type', 'i1'], ['Op', 'and']], [['Reg',$arg1],['Reg',$arg2]]];
                }
            }
        }
    }

    my @orig_conds_f = map {$_->[0]} @orig_conds;
    if (@orig_conds_f>1) {        
        my $arg1=shift @orig_conds_f;
        my $arg2= $orig_conds_f[0];
        my $or_reg='or_'.$arg1.'_'.$arg2.'_'.$ct;;         
        $orig_conds_f[0]=$or_reg;
        # push @cond_expr_lines, "\%$or_reg = or i1 \%$arg1 \%$arg2";
        if (not exists $unique_cond_regs->{$or_reg}) {
                    $unique_cond_regs->{$or_reg}=1;
        push @cond_expr_lines,['Assignment', ['Reg', $or_reg], ['TypedOp', ['Type', 'i1'], ['Op', 'or']], [['Reg',$arg1],['Reg',$arg2]]];
        }
        while (@orig_conds_f>1) {
            my $arg1=shift @orig_conds_f;
            my $arg2= $orig_conds_f[0];
            my $or_reg='or_'.$arg1.'_'.$arg2.'_'.$ct;;
            $orig_conds_f[0]=$or_reg;
        if (not exists $unique_cond_regs->{$or_reg}) {
                    $unique_cond_regs->{$or_reg}=1;

            # push @cond_expr_lines, "\%$or_reg = or i1 \%$arg1 \%$arg2";
            push @cond_expr_lines,['Assignment', ['Reg', $or_reg], ['TypedOp', ['Type', 'i1'], ['Op', 'or']], [['Reg',$arg1],['Reg',$arg2]]];
        }
        }
    }
    return ( \@cond_expr_lines, $orig_conds_f[0], $unique_cond_regs);
} # END of __emit_cond_expr

sub _insert_select_exprs_into_ast_tree { my ($select_exprs,$new_ast_tree,$origins_terminals_reg)=@_;
    # %select_exprs is per $reg
    # For each reg, find the terminal node from  %origins_terminals_reg
    for my $reg (sort keys %{$select_exprs}) {
        my $terminal = $origins_terminals_reg->{$reg}[1];
        # say "INSERT SELECT for $reg in $terminal";
         @{$new_ast_tree->{Tree}{$terminal}{Block}} = ( (map { ref($_) ne 'ARRAY' ? ['Lit',$_ ] : $_ }   @{$select_exprs->{$reg}}), @{$new_ast_tree->{Tree}{$terminal}{Block}});
    }
    
    return $new_ast_tree;
} # END of _insert_select_exprs_into_ast_tree

# What we need is the labels of blocks for all regs
sub _remove_br_and_update_assignments_in_ast_tree { my ($ast_tree,$labels_for_regs)=@_;
    my $new_ast_tree = dclone($ast_tree);
    
    for my $label (@{$ast_tree->{List}}) {
        # say "REG: $reg";
        # for my $label (sort keys %{$labels_for_regs->{$reg}}) {
            # say "LABEL: $label";
            
            for my $reg (sort keys %{$labels_for_regs}) { # all the regs that are subject to conditions
               if (exists $labels_for_regs->{$reg}{$label}) { 
                   # there is a reg in this block
                    my $reg_idx = $labels_for_regs->{$reg}{$label}[1];
                    my $node = $new_ast_tree->{Tree}{$label}{Block}[$reg_idx];
                    if ($node->[0] eq 'Store') {
                        my $orig_code_str=__emit_llvm_ir_single_ast_node($node);
                        # say ';'.$orig_code_str;
                        $new_ast_tree->{Tree}{$label}{Block}[$reg_idx] = ['Comment', $orig_code_str];
                    } else {# It's an assignment, rename the reg
                        $node->[1][1].='_'.$label;
                        my $updated_code_str=__emit_llvm_ir_single_ast_node($node);
                        # say $updated_code_str;
                        $new_ast_tree->{Tree}{$label}{Block}[$reg_idx] = $node;
                    }
               }
            }
            if (exists $new_ast_tree->{Tree}{$label}{IfThenElse}) {
                my $node = $new_ast_tree->{Tree}{$label}{IfThenElse};
            my $orig_code_str=__emit_llvm_ir_single_ast_node($node);
            # say ';'.$orig_code_str;
            $new_ast_tree->{Tree}{$label}{IfThenElse} = ['Comment', $orig_code_str];
            }
            if (exists $new_ast_tree->{Tree}{$label}{Goto}) {
                my $node = $new_ast_tree->{Tree}{$label}{Goto};
                my $orig_code_str=__emit_llvm_ir_single_ast_node($node);
                # say ';'.$orig_code_str;
                $new_ast_tree->{Tree}{$label}{Goto} = ['Comment', $orig_code_str];
            }
            # my $idx=0;

            # for my $node (@{ $ast_tree->{Tree}{$label}{Block} }) {
            #     say "NODE TYPE: ".$node->[0];
            #     if ($node->[0] eq 'Goto' or $node->[0] eq 'IfThenElse' ) {                    
            #         my $orig_code_str=__emit_llvm_ir_single_ast_node($node);
            #         $node=['Comment', $orig_code_str];
            #         say "$reg $label => $orig_code_str";
            #     }
            #     push @{ $new_ast_tree->{Tree}{$label}{Block} }, $node;
            #     ++$idx;
            # }
        
    }
    
    return $new_ast_tree;
} # END of _remove_br_and_update_assignments_in_ast_tree

# Finally (hopefully!) we need to renumber the temporary registers. It looks like I can keep the named regs 
# I could also just maked them named I supposes, by prefixing them with 'r'. That is easier, so try that first
sub _rename_temp_regs { my ($ast_tree) = @_;
    for my $label ( @{$ast_tree->{List}} ) {
     # say Dumper $ast_tree->{Tree}{$label};
     my @nodes=();
         if (exists $ast_tree->{Tree}{$label}{LabelNode}) {
            my $node = $ast_tree->{Tree}{$label}{LabelNode};
            push @nodes, ['LabelNode', $node];
        }
        for my $node (@{ $ast_tree->{Tree}{$label}{Block} }) {
            push @nodes, ['Block',$node];
        }        
        $ast_tree->{Tree}{$label}{Block}=[];
        if (exists $ast_tree->{Tree}{$label}{IfThenElse}) {   
            my $node = $ast_tree->{Tree}{$label}{IfThenElse};
            push @nodes, ['IfThenElse',$node];
        }
        elsif (exists $ast_tree->{Tree}{$label}{Goto}) {   
            my $node = $ast_tree->{Tree}{$label}{Goto};
            push @nodes, ['Goto',$node];
        }
        elsif (exists $ast_tree->{Tree}{$label}{Return}) {   
            my $node = $ast_tree->{Tree}{$label}{Return};
            push @nodes, ['Return',$node];
        }

        for my $node_pair (@nodes) {
            my ($node_type, $node)=@{$node_pair};

            if (defined __ast_node_has_reg($node)) {
                    $node = __rename_regs_in_ast_node($node, sub { 
                        (my $reg_node)=@_;    
                        my $reg_name = $reg_node->[1];
                        if ($reg_name=~/^\d+$/) {
                            $reg_name="r$reg_name";
                        }
                        return ['Reg',$reg_name];
                    }
                );
            }
            if ($node_type eq 'Block') {
                push @{ $ast_tree->{Tree}{$label}{Block} }, $node;
            } else {
                $ast_tree->{Tree}{$label}{$node_type}=$node;
            }

        }
        
    }
    # croak Dumper $ast_tree;
    return $ast_tree;
} # END of _rename_temp_regs 


=pod 
So, to change br by select:

%res = select i1 %cond, t1 %res_t,  t1 %res_f

We look for a conditional branch
- assign the condition to a reg
- in each branch, we find an assignment to an output arg. Or in general we need to build the dependency graph from every output arg to all regs
- then we can take these instructions out of the branch and put them in a select instead.

The complication is nested branches, of course. The proper way should be to find the innermost nest and replace that with the select, then work our way up.

Which means we should first build up a nested datastructure for the branches.

  %h_j_k = fadd float %hzero_j_k, %eta_j_k


  %wet_j_k=1
  %cond = fcmp olt float %h_j_k, %hmin
  br i1 %cond, label %13, label %14

; <label>:13:                                     ; preds = %9
  %wet_j_k=0
  br label %14

; <label>:14:                                     ; preds = %13, %9


what we want is

%cond = fcmp olt float %h_j_k, %hmin

%wet_j_k = select i1 %cond, t1 i32 0,  i32 1

I think in the end we can simply look at which regs get assigned to in more than one labeled block.
This is OK as the labels are generated purely for the branches and jumps.

Then all we need to do is work out which conditions govern the choice between these blocks and
then we can use select. If there are more than 2 occurences we'll need several select operations.

The datastructure needed is essentially a binary tree, although not quite because the Goto labels can of course be shared.
my $ast_tree = {
    $label => { 
        Block => [@ast_nodes],
        IfThenElse =>{  # can just use the current AST node
            Cond => $ast_node,
            BrTrue => $label_true, 
            BrFalse => $label_false,
        },
        Goto => $label_goto # can just use the current AST node
    },
    ...
};

A node has either an IfThenElse, in which case it is a binary node, or a Goto, in which case it is a leaf node.
In this strucure, we look at the leaf nodes and we look for common occurences. 
The main question is if we need to push the blocks down to leaves for nodes that are binary?
Maybe not: either the assignment will be in the Block or in a block in of the binary branches.

I need to rename the registers to which the shared variables are assigned, e.g. by suffixing them with the label of the node.
But is this still valid LLVM?

It might be convenient to change the AST so that every line is annotated with the registers on it, so we don't have to search every time
=head1 IfThenElse Replacement Algorithm

So now we can compare the ordered list of these labels per reg with the Preds in each block.
e.g. by sorting and joining the keys and comparing the strings
The select() goes into the block that matches

There are two cases: 
1. either the reg is on the LHS of an assignment:
- In the blocks that have the assignment, we change the reg in the LHS to ${reg}_${block_label}, and we get its type $t
- In the block that is the pred of these blocks (should be one only), we find the IfThenElse and from that the condition register $cond
- We delete that line
- In the block that has the matching preds, right after the label, we insert the select line:

    %$reg = select i1 %$cond, $t %${reg}_${block_label_t}, %$t ${reg}_${block_label_f}

2. or it is the 2nd argument of a store
- In the blocks that have the stores (I assume it has to be both), we get the first arg of the store instruction $reg_or_cond and its type $t, as well as the type and reg of the 2nd arg ($reg and $t*), and of the third arg, $arg3
- We delete the `store` lines
- In the block that is the pred of these blocks (should be one only), we find the IfThenElse and from that the condition register $cond
- We delete that line
- In the block that has the matching preds, right after the label, we insert the select line:

    %${reg}_{$block_label} = select i1 %$cond, $t %${reg_or_cond_t}, %$t ${reg_or_cond_f}

And below that, we insert a new store: 

    store $t %${reg}_{$block_label}, $t* %$reg, $arg3

Now, the above works for the simplest possible case. For the general case, as far as I can work it out, we need to follow every possible chain of conditions and what assignment they result in. 
In other words, for every IfThenElse we follow both branches. The main problem I have now is to find the terminating block for all branches. 
So, starting from a block with a condition, this is the common block where all paths via conditions lead to. 
Maybe like this:
- Given a node with an assignment, i.e. $labels_for_reg;
- Follow all paths that do not have another assignment => either IfThenElse or Goto
- Create an (ordered) list of the nodes
- Go right to the end
Then, for all these paths, check the first common node. That is the one.

define void @update_map_24(float %hzero_j_k, float %eta_j_k, float* %h_j_k, float %hmin, float %un_j_k, float %vn_j_k, i32* %wet_j_k, float* %u_j_k, float* %v_j_k) {
  %1 = fadd float %hzero_j_k, %eta_j_k
  store float %1, float* %h_j_k, align 4
;;  store i32 1, i32* %wet_j_k, align 4
  %2 = load float, float* %h_j_k, align 4
  %3 = fcmp olt float %2, %hmin
;;  br i1 %3, label %4, label %5

; <label>:4:                                     ; preds = %0
;;  store i32 0, i32* %wet_j_k, align 4
;;  br label %5

; <label>:5:                                     ; preds = %4, %0
  %wet_j_k_5 = select i1 %3, i32 0, i32 1
  store i32 %wet_j_k_5, i32* %wet_j_k, align 4
  store float %un_j_k, float* %u_j_k, align 4
  store float %vn_j_k, float* %v_j_k, align 4
  ret void
}

=cut

=pod
=head1 Emitting Haskell

The main challenge is how to handle non-map arguments to a function, in fact how do we know which arguments are non-map? The answer to that is that we know this in the TyTraCL step. 
There are some more complications: TyTraCL passes stencil vector tuples, which I would need to unpack; and the LLVM pass has the scalarised variables, which I need to relate to the original ones.

Related, if an arg is inout, we need to split this into in and out.

This is only the case if we have:

v1 = f arg  -- a read
arg_out = g v2 -- a write

In LLVM this will be 

%r1 = load t, t* %arg
; some operation on %r1
store t %r2, t* arg

So we need to rename the store arg to arg_out and emit 

arg_out = r2



=cut


