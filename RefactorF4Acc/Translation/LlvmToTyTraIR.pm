package RefactorF4Acc::Translation::LlvmToTyTraIR;
use v5.10;

# use RefactorF4Acc::Config;
# use RefactorF4Acc::Utils;
# use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
# use RefactorF4Acc::Refactoring::Common qw( stateful_pass pass_wrapper_subs_in_module );
# use RefactorF4Acc::Refactoring::Streams qw( _declare_undeclared_variables _update_arg_var_decls _removed_unused_variables _fix_scalar_ptr_args _fix_scalar_ptr_args_subcall );
# use RefactorF4Acc::Parser::Expressions qw( @sigils );
# 
#   (c) 2019 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
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

@RefactorF4Acc::Translation::LlvmToTyTraIR::ISA = qw(Exporter);

@RefactorF4Acc::Translation::LlvmToTyTraIR::EXPORT_OK = qw(
    _generate_llvm_ir
    _parse_llvm_ir
	_pp_llvm_ast
);



sub pass_generate_llvm_ir {(my $stref, my $module_name)=@_;
    # WV: I think Selects and Inserts should be in Lines but I'm not sure
    $stref->{'EmitAST'} = 'TyTraCL_AST';
	$stref->{'TyTraCL_AST'} = {
        'Lines' => [], 
        'Selects'=>[], 'Inserts'=>[], 'Stencils'=>{},'Portions'=>{},
        'Main' => {},
        'MainFunction' => 'main',
        'ASTEmitter' => \&_add_TyTraCL_AST_entry
        };
	$stref = pass_wrapper_subs_in_module($stref,$module_name,
	           # module-specific passes 
            [],
            # subroutine-specific passes 	
			[
                # [\&_remove_redundant_arguments],
		  		[
			  		\&identify_array_accesses_in_exprs,
				],
			]
		);


	return $stref;
} # END of pass_emit_TyTraCL()


sub _generate_llvm_ir { 
    # (my $stref, my $module_name)=@_;
 	
 	# my $ext =  'c';
 	# my $module_src = $stref->{'Modules'}{$module_name}{'Source'};
	# if (not defined $module_src) {
	# 	$module_src=$Config{'MODULE_SRC'};
	# } 
 	# my $fsrc = $module_src;
 	# my $csrc = $fsrc;
	# $csrc=~s/\.\w+$//;
    (my $file_path) = @_;

	my ($target_dir, $csrc) = split ('/', $file_path);
	$csrc=~s/\.\w+$//;
 	my $tytra_c_input = "$target_dir/$csrc.c";
 	my $tytra_ir="$target_dir/$csrc";

	my $clang = 'clang-mp-8.0';
	my $opt = 'opt-mp-8.0';

	system("$clang -O0 -Xclang -disable-O0-optnone -emit-llvm -c $tytra_c_input -o ${tytra_ir}_tmp.bc");
	system("$opt -S -mem2reg ${tytra_ir}_tmp.bc -o $tytra_ir.ll");

    open my $LL_IN, '<', "$tytra_ir.ll" or die $!;
	my $ll_lines=[];
 	while (my $line=<$LL_IN>) {
		chomp $line;
		push @{$ll_lines}, $line;
	}
    close $LL_IN;
    return $ll_lines;
} # END of _generate_llvm_ir


sub _parse_llvm_ir { my ( $ll_lines )=@_;

	my %regs_to_args=();
	my %args_to_regs=();
    my @ast_nodes=();
    my $in_def='';
	for my $line (@{$ll_lines}) {
		say $line;
		$line=~/define\s+void\s+\@(\w+)\((.+)\)/ && do {            
			#  say $line;
				my $f=$1;
				my $arg_types_str=$2;
				my @arg_types=split(/\s*,\s*/,$arg_types_str);
				my $ast_node = ['Signature',$f,['ArgTypes',[@arg_types]]];
                push @ast_nodes, $ast_node;
				# if ($f eq $stref->{'SubroutineName'}) {
				# 	my @args = $stref->{'SubroutineArgs'};
				# }	
                $in_def=$f;
				# say $f;
				next;			
		};
        $line=~/^\s*\}/ && do {
			# say $line;
            push @ast_nodes, ['EndDefinition', $in_def];
            $in_def='';
			last;
        };
        next unless $in_def;
        $line=~/^\s*$/  && do {
			
		my $ast_node = ['Blank'];
			push @ast_nodes, $ast_node;
			next;
		};
		
		$line=~/;\s+<label>:(\d+):/ && do {
			say $line;
			my $label=$1;
			my $preds_str='';
			$line=~/preds\s+=\s+(.+)/ && do {
				$preds_str=$1;
			};
			my @preds =  ($preds_str ne '') ? split(/\s*,\s*/,$preds_str) : ();
			my @preds_ast = map { /\%(\w+)/; ['Reg',$1]     } @preds;
			my $ast_node = ['Label', $label,[@preds_ast]];
            push @ast_nodes, $ast_node;
			next;
		};

		$line=~/^\s*;(.+)$/  && do {
			my $comment=$1;
		my $ast_node = ['Comment', $comment];
			push @ast_nodes, $ast_node;
			next;
		};

		$line=~/\%/ && do {
				$line=~/=/ && do {
					# say $line;					
					if ($line=~/\%(\w+)\s+=\s+load\s+(\w+),\s*(.+)\s*$/) {
					my $reg=$1;
					my $op='load';
					my $type_str=$2;
					my $args_str=$3;
					my @args = split(/\s*,\s*/,$args_str); # typically  typed reg, attr
					my @reg_or_const = map  { /(.+?)\s+\%(\w+)/ ? ['TypedReg',['Type',$1],['Reg',$2]] : ['Const',$_] } @args;
					my $ast_node=['Assignment',['Reg',$reg], ['TypedOp',['Type',$type_str],['Op',$op]], [@reg_or_const]];
                    push @ast_nodes, $ast_node;

					} elsif(
					$line=~/\%(\w+)\s+=\s+(\w+)\s+(\w+(?:\s+\w+)?)\s+(.+)\s*$/
					) {
					my $reg=$1;
					my $op=$2;
					my $type_str=$3;
					my $args_str=$4;
					my @args = split(/\s*,\s*/,$args_str);
					my @reg_or_const = map  { /\%(\w+)/ ? ['Reg',$1] : ['Const',$_] } @args;
					my $ast_node=['Assignment',['Reg',$reg], ['TypedOp',['Type',$type_str],['Op',$op]], [@reg_or_const]];
                    push @ast_nodes, $ast_node;
					} else {
						croak $line;
						(my $lhs, my $rhs) = split(/\s*=\s*/, $line);
						my $ast_node=['Pair', $lhs, $rhs];
						push @ast_nodes, $ast_node;
					}
					next;
				};
				$line=~/^\s*br/ && do {
					if ($line=~/br\s+(\w+)\s+\%(\w+)\s*,\s*label\s+\%(\w+)\s*,\s*label\s+\%(\w+)/) {
					my $type_str=$1;
					my $reg=$2;
					my $label1=$3;
					my $label2=$4;
					my $ast_node=['Branch',['Cond',['TypedReg',['Type',$type_str], ['Reg',$reg]]],['Reg',$label1], ['Reg',$label2]];
                    push @ast_nodes, $ast_node;
					
					} elsif ($line=~/br\s+label\s+\%(\w+)/) {
					my $label=$1;					
					my $ast_node=['Branch',['Reg',$label]];
                    push @ast_nodes, $ast_node;
					}
					next;
				};
				# store float %48, float* %11, align 4
				$line=~/^\s*(\w+)\s+(.+?)\s*$/ && do {
					my $op=$1;
					my $args_str = $2;
					my @args = split(/\s*,\s*/,$args_str);
					my @args_ast = map  { my $arg=$_;
					my $type_str='';
					my $reg='';
					my $other='';
                    my $arg_ast_node=[];
						# try parse as typed args 						
						if ($arg=~/(\w+)\s+\%(\w+)/) {
							$type_str=$1;
							$reg=$2;
                            $arg_ast_node=['TypedReg',['Type', $type_str],['Reg', $reg]];
						}
						# then as plain regs
						elsif ($arg=~/\%(\w+)/) {
							$reg=$1;
                            $arg_ast_node=['Reg', $reg];
						}
						# then as anything else
						elsif ($arg=~/(.+)/) {
							$other=$1;
                            $arg_ast_node=['Attribute',$other];
						}
						$arg_ast_node;
					} @args;
					# $line=~/^\s*(\w+)\s+(.+?)\s+\%(\w+)\s*,\s*(.+?)\s+\%(\w+)\s*,\s*(.+)\s*$/ && do {
					my $ast_node=['Operation',['Op',$op], ['Args',[@args_ast]]];
                    push @ast_nodes, $ast_node;				
					next;
				};
				
		};
		
        my $ast_node = ['NonRegStatement',$line];
        push @ast_nodes, $ast_node;
	}
 	
	return \@ast_nodes;

} # END of _parse_llvm_ir

sub _pp_llvm_ast { (my $ast_nodes)=@_;

	for my $ast_node (@{$ast_nodes}) {
		$ast_node->[0] eq 'Comment' && say ';'.$ast_node->[1];
		$ast_node->[0] eq 'Blank' && say '';	
		$ast_node->[0] eq 'NonRegStatement' && say $ast_node->[1];    
		$ast_node->[0] eq 'EndDefinition' && say '}';    				

		$ast_node->[0] eq 'Signature' && do {
			my $f = $ast_node->[1];
			my $arg_types = $ast_node->[2][1];
			my $sig_str = 'define void @'.$f.'('.join(', ',@{$arg_types}).') #0 {';
			say $sig_str;
		};				
	#my $ast_node=['Assignment',['Reg',$reg], ['TypedOp',['Type',$type_str],['Op',$op]], [\@reg_or_const]];
		$ast_node->[0] eq 'Assignment' && do {
			my $reg = __emit_reg_or_const($ast_node->[1]);
			my $typed_op = __emit_typed_op($ast_node->[2]);
			
			my $args_str = join(', ', map {  __emit_reg_or_const($_)} @{$ast_node->[3]});
			say "  $reg = $typed_op $args_str";
		};
		$ast_node->[0] eq 'Operation' && do {
			# ,['Op',$op], ['Args',[@args_ast]]];
			my $op = __emit_typed_op($ast_node->[1]);
			my $args_str = join(', ', map {  __emit_reg_or_const($_)} @{$ast_node->[2][1]});
			say "  $op $args_str";
		};
		
		$ast_node->[0] eq 'Branch' && do {
			# ,['Cond',['TypedReg',['Type',$type_str], ['Reg',$reg]]],
			if ($ast_node->[1][0] eq 'Cond') {
			my $cond = __emit_reg_or_const($ast_node->[1][1]);
			my $label1 = __emit_reg_or_const($ast_node->[2]); 
			my $label2 = __emit_reg_or_const($ast_node->[3]);
			say "  br $cond, label $label1, label $label2";
			} else {
				my $label = __emit_reg_or_const($ast_node->[1]); 
				say "  br label $label";
			}
		};
		$ast_node->[0] eq 'Label' && do {
			#  ['Label', $label,[@preds]];
			my $label = $ast_node->[1];
			my $preds_str = '';
			if (scalar @{$ast_node->[2]} > 0) {
				#  croak Dumper $ast_node;
				$preds_str = join(', ',map {  __emit_reg_or_const($_) } @{$ast_node->[2]});
			}
			say "; <label>:$label:". ($preds_str ? '                                     ; preds = '.$preds_str : '');
		};
	}
} # END of _pp_llvm_ast

sub __emit_reg_or_const { (my $ast_node)=@_;

if ($ast_node->[0] eq 'TypedReg') {
	return $ast_node->[1][1].' %'.$ast_node->[2][1];
} elsif ($ast_node->[0] eq 'Reg') {
	return '%'.$ast_node->[1];
} else { # for Const and Attribute
	return $ast_node->[1];
}

} # END of __emit_reg_or_const

sub __emit_typed_op {  (my $ast_node)=@_;

if ($ast_node->[0] eq 'TypedOp') {
	return $ast_node->[2][1].' '.$ast_node->[1][1];
} elsif ($ast_node->[0] eq 'Op') {
	return $ast_node->[1];
} else {
	croak Dumper $ast_node;
}
} # END of __emit_typed_op

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