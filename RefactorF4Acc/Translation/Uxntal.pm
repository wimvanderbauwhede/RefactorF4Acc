package RefactorF4Acc::Translation::Uxntal;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass stateful_pass_inplace pass_wrapper_subs_in_module update_arg_var_decl_sourcelines get_annotated_sourcelines);
use RefactorF4Acc::Refactoring::Fixes qw(
	_declare_undeclared_variables
	_remove_unused_variables
	);
# use RefactorF4Acc::Parser::Expressions qw( @sigils );
use RefactorF4Acc::Translation::LlvmToTyTraIR qw( generate_llvm_ir_for_TyTra );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Translation::Uxntal::ISA = qw(Exporter);

@RefactorF4Acc::Translation::Uxntal::EXPORT_OK = qw(
    &add_to_C_build_sources
    &translate_module_to_Uxntal
	&translate_sub_to_Uxntal
);

#### #### #### #### BEGIN OF UXNTAL TRANSLATION CODE #### #### #### ####

#               0    1    2    3    4    5    6    7    8    9    10   11   12   13    14
our @sigils = ('(', '&', '$', 'ADD', 'SUB', 'MUL', 'DIV', 'mod', 'pow', '=', '@', '#', ':' ,'//', ')('
#                15    16    17  18   19    20     21       22       23      24       25       26
               ,'EQU', 'NEQ', 'LTH', 'GTH', 'lte', 'gte', 'not', 'AND', 'ORA', 'EOR', '.eqv.', '.neqv.'
#                27   28
               ,',', '(/',
# Constants
#                29        30      31         32           33             34       35
               ,'integer', 'real', 'logical', 'character', 'PlaceHolder', 'Label', 'BLANK'
              );


# $ocl: 0 = C, 1 = CPU/GPU OpenCL, 2 = C for TyTraIR aka TyTraC, 3 = pipe-based OpenCL for FPGAs
# 4 = translate_to_TyTraLlvmIR, 5 = translate_to_OpenCL_memory_reduction
sub translate_module_to_Uxntal {  (my $stref, my $module_name, my $ocl) = @_;

	if (not defined $ocl) {$ocl=0;}
	$stref->{'OpenCL'}=$ocl;
	$stref->{'TranslatedCode'}=[];
	$Config{'FIXES'}={
	_declare_undeclared_variables => 1,
	# _remove_unused_variables => 1
	};
	$stref = pass_wrapper_subs_in_module($stref,$module_name,
	   # module-specific passes.
       [
        #    [\&_emit_OpenCL_pipe_declarations]
       ],
       # subroutine-specific passes
	   [
		  [
			  \&determine_argument_io_direction_rec,
			  \&update_arg_var_decl_sourcelines,
			  \&_declare_undeclared_variables]
			  ,#,\&_remove_unused_variables],
		  [\&translate_sub_to_Uxntal]
       ],
       $ocl);

	# $stref = _write_headers($stref,$ocl);
	$stref = _emit_Uxntal_code($stref, $module_name, $ocl);
	# This enables the postprocessing for custom passes
	$stref->{'CustomPassPostProcessing'}=1;
    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'}={};
} # END of translate_module_to_Uxntal

sub translate_sub_to_Uxntal {  (my $stref, my $f, my $ocl) = @_;

=info
	# First we collect info. What we need to know is:

	- What are the subroutine arguments, and their types?
	- Scalar && IODir eq 'In' => emit a scalar
	- otherwise => emit a pointer
	- make a list/table of all the arguments, of course we already have that in $stref->{'Subroutines'}{$f}{'RefactoredArgs'}
	- Then for every VarDecl we encounter:
		- if it's an Arg, remove it
		- otherwise, convert it to C syntax
		- In any case, if it is an array, we need the dimensions; but that should exists already in $stref->{'Subroutines'}{$f}{'Vars'}
	- If we find a select/case, we need to mark the *first* case to indicate that it should *not* be prefixed with  "}\n break;"
	- so maybe we actually don't need a separate pass after all ...

WV 2021-06-07

Instead of the nice but cumbersome approach we had until now, from now on it is simple:
- All args are pointers
- If a call arg is an expression, I will need to generate a temp, TODO
- Arguments to calls are therefore always either bare or &arg_var[...]
- Accesses in subroutine bodies are always *lhs_vars = expr(*rhs_vars)
- Scalar local vars are only pointers if they are args to a subroutine
- The latter is weak because it means that if I have a parameter used as arg,

=cut
	my $Sf = $stref->{'Subroutines'}{$f};
	my $annlines = get_annotated_sourcelines( $stref, $f );

	my $pass_pointer_analysis = sub { my ($annline,$state) = @_;
		my ($line, $info) = @{$annline};

		if (exists $info->{'Signature'} ) {
			$state->{'Args'} = { map { $_=>1 } @{$info->{'Signature'}{'Args'}{'List'}}};
		}
		elsif (exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'};
			# carp "$var";
			if (exists $state->{'Args'}{$var} ) {
				$state->{'Pointers'}{$var}='*';
			} else {
				$state->{'Pointers'}{$var}='';
				$state->{'LocalVars'}{$var}=1;
			}
		}
		elsif ( exists $info->{'ParamDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};
				$state->{'Pointers'}{$var}='';
				$state->{'Parameters'}{$var}=1;
		}
		elsif (exists $info->{'SubroutineCall'} ) {
			# croak Dumper $info; 
			my $fname =  $info->{'SubroutineCall'}{'Name'};
			if (not exists $F95_intrinsic_functions{$fname} ) {
				for my $arg_expr_str (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
					# say "<$fname $arg_expr_str>";
					my $arg = ($info->{'SubroutineCall'}{'Args'}{'Set'}{$arg_expr_str}{'Type'} eq 'Scalar'
					or $info->{'SubroutineCall'}{'Args'}{'Set'}{$arg_expr_str}{'Type'} eq 'Const'
					or $info->{'SubroutineCall'}{'Args'}{'Set'}{$arg_expr_str}{'Type'} eq 'Expr'
					) ? $info->{'SubroutineCall'}{'Args'}{'Set'}{$arg_expr_str}{'Expr'}
					: $info->{'SubroutineCall'}{'Args'}{'Set'}{$arg_expr_str}{'Arg'};
					if (exists $state->{'LocalVars'}{$arg}) {
						$state->{'Pointers'}{$arg}='*';
					}
					elsif (exists $state->{'Parameters'}{$arg}) {
						$state->{'Pointers'}{$arg}='&';
						carp 'TODO: a const scalar passed as arg';
					}
				}
			} 
		}
		elsif ( exists $info->{'FunctionCalls'} ) {
			for my $entry (@{$info->{'FunctionCalls'}}) {
				my $fname =  $entry->{'Name'};
				if (not exists $F95_intrinsic_functions{$fname} ) {
					# We assume intrinsics take values not pointers
					for my $arg (sort keys %{$entry->{'Args'}}) {
						if (exists $state->{'LocalVars'}{$arg}) {
							$state->{'Pointers'}{$arg}='*';
						}
					}
				}
			}
		}

		return ([[$line,$info]],$state)
	};

	my $pass_state = {'Pointers'=>{},'Args' =>{},'LocalVars' =>{}, 'Parameters'=>{}};
	(my $new_annlines_,$pass_state) = stateful_pass($annlines,$pass_pointer_analysis,$pass_state,"pass_pointer_analysis($f)");
	$Sf->{'Pointers'} = $pass_state->{'Pointers'};

	my $pass_translate_to_Uxntal = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
        my $id = $info->{'LineId'};
		my $skip=0;
		if (exists $info->{'Signature'} ) {
			$pass_state->{'Args'}=$info->{'Signature'}{'Args'}{'List'};
				my ($sig_line,$arg_decls) = _emit_subroutine_sig_Uxntal( $stref, $f, $annline);
				@{$pass_state->{'ArgVarDecls'}}= map { $info->{'Indent'}.$_ } @{$arg_decls};
				$c_line = $sig_line."\n";
		}
		elsif (exists $info->{'VarDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};
				if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}) {
					$c_line='( '.$line.' )';
					$skip=1;
				} else {
					$c_line = $info->{'Indent'}. _emit_var_decl_Uxntal($stref,$f,$var);
					$pass_state->{'ArgVarDecls'}=[@{$pass_state->{'ArgVarDecls'}},$c_line];
					$skip=1;
				}
		}
		elsif ( exists $info->{'ParamDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};

				$c_line = _emit_var_decl_Uxntal($stref,$f,$var);
		}
		# For Uxntal, we need to turn the Case into an IfThen
		elsif (exists $info->{'Select'} ) {
			my $switch_expr = _emit_expression_Uxntal([2,$info->{'CaseVar'}],$stref,$f,$info); # FIXME
			$c_line ="switch ( $switch_expr ) {";
		}
		elsif (exists $info->{'Case'} ) {
            # FIXME: support macros
			$c_line=$line.': {';#'case';
			if ($info->{'Case'}>1) {
				$c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.$c_line;
			}
		}
		elsif (exists $info->{'CaseDefault'}) {
			$c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.'default : {';
		}
		elsif (exists $info->{'Do'} ) {
			if (exists $info->{'Do'}{'While'}) {
				croak 'TODO: Do While';
			} else {
			# $pass_state->{'DoIter'} = $f.'_'.$info->{'Do'}{'Iterator'};
			# $pass_state->{'DoStep'} = $info->{'Do'}{'Range'}{'Expressions'}[2];
			# id, iterator, step; loop upper bound is on the wst
			push @{$pass_state->{'DoStack'}}, [$id,$f.'_'.$info->{'Do'}{'Iterator'},$info->{'Do'}{'Range'}{'Expressions'}[2]];
				$c_line = 
				$info->{'Do'}{'Range'}{'Expressions'}[1] . ' ' . $info->{'Do'}{'Range'}{'Expressions'}[0] . "\n" .
				'&loop_'.$f.'_'.$id . "\n" .
				';'.$pass_state->{'DoIter'}.' STA2 ';
				# $info->{'Do'}{'Iterator'}.' = '.$info->{'Do'}{'Range'}{'Expressions'}[0] .';'.
				# $info->{'Do'}{'Iterator'}.' <= '.$info->{'Do'}{'Range'}{'Expressions'}[1] .';'.
				# $info->{'Do'}{'Iterator'}.' += '.$info->{'Do'}{'Range'}{'Expressions'}[2] .') {';
			}
		}
		elsif (exists $info->{'BeginDo'} ) {
			croak 'TODO: BeginDo: what is this?';
				$c_line='for () {';
		}

		if (exists $info->{'Assignment'} ) {
				$c_line = _emit_assignment_Uxntal($stref, $f, $info) ;
		}
		elsif (exists $info->{'SubroutineCall'} ) {
			#
			# my $subcall_ast = [ 1, $info->{'SubroutineCall'}{'Name'},$info->{'SubroutineCall'}{'ExpressionAST'} ];

			# There is an issue here:
			# We actually need to check the type of the called arg against the type of the sig arg
			# If the called arg is a pointer and the sig arg is a pointer, no '*', else, we need a '*'
			# But the problem is of course that we have just replaced the called args by the sig args
			# So what we need to do is check the type in $f and $subname, and use that to see if we need a '*' or even an '&' or nothing

            $c_line = $info->{'Indent'}._emit_subroutine_call_expr_Uxntal($stref,$f,$info);
		}
		elsif (exists $info->{'IOCall'}) {
			croak Dumper $info->{'IOCall'}{'Args'}{'AST'};
		}
        elsif (exists $info->{'If'} ) {
            $pass_state->{'IfBranchId'} = $id;
            my $branch_id = $pass_state->{'IfBranchId'};
            push @{$pass_state->{'IfStack'}},$id;
            $pass_state->{'IfId'}=$id;
			$c_line = _emit_ifthen_Uxntal($stref, $f, $info, $branch_id);
            # say emit_uxntal_expr_str($cond) . " ,&branch$id JCN";
            # say ",&branch$id_end JMP";
            # say "&branch$id";
            # other statements to emit ...
        } elsif (exists $info->{'ElseIf'} ) {
            # my $branch_id = $state->{'IfBranchId'};
            # $state->{'IfBranchId'} = $id;
            # $c_line = "&branch${branch_id}_end\n";
            # $c_line .= ",&cond_end{$if_id} JMP";  
            #  $branch_id = $state->{'IfBranchId'};
			($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state); 
            # say emit_uxntal_expr_str($cond) . " ,&branch$branch_id JCN";
			$c_line .= _emit_ifthen_Uxntal($stref, $f, $info, $branch_id);
            # say ",&branch{$branch_id}_end JMP";
            # say "&branch{$branch_id}";
            # other statements to emit ...
        } elsif (exists $info->{'Else'} ) {
            # my $branch_id = $state->{'IfBranchId'};
            # $state->{'IfBranchId'} = $id;
            # $c_line = "&branch${branch_id}_end\n";
            # $c_line .= ",&cond_end{$if_id} JMP\n";  
            # $branch_id = $state->{'IfBranchId'};
			($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state);
            # $state->{'IfBranchId'} = $id;
            $c_line .= "&branch$branch_id";
            # other statements to emit ...
        } elsif (exists $info->{'EndIf'} ) {
            $c_line = '&cond_end'.$pass_state->{'IfId'}; 
            pop @{$pass_state->{'IfStack'}};
            $pass_state->{'IfId'}=$pass_state->{'IfStack'}[-1];
        }
		# elsif (exists $info->{'If'} ) {
		# 	$c_line = _emit_ifthen_Uxntal($stref, $f, $info);
		# }
		# elsif (exists $info->{'ElseIf'} ) {
		# 	$c_line = '} else '._emit_ifthen_Uxntal($stref, $f, $info);
		# }
		# elsif (exists $info->{'Else'} ) {
		# 	$c_line = ' } else {';
		# }
		elsif (
				exists $info->{'EndDo'}
			) {
				my $do_tup = pop @{$pass_state->{'DoStack'}};
				my ($do_id, $do_iter, $do_step) = @{$do_tup};
				my $inc = $do_iter == 1 ? 'INC2' : toHex($do_iter,2).' ADD2';
            $c_line = "DUP2 ;$do_iter LDA2 $inc NEQ2 ".',&loop_'.$f.'_'.$do_id.' JCN';
		}
		elsif ( exists $info->{'EndProgram'} ) {

            $info->{'Indent'} = '' ;
            $c_line = 'BRK' ;

		}
		elsif ( exists $info->{'EndSubroutine'} ) {

            # $info->{'Indent'} = '' ;
            $c_line = 'JMP2r' ;

		}
		elsif (exists $info->{'EndSelect'} ) {
				 $c_line = '    }'."\n".$info->{'Indent'}.'}';
		}

		elsif (exists $info->{'Comments'} ) {
			$c_line = $line;
			#!$PRAGMA unroll
			if ($ocl==3 and $line=~/\$pragma/i) {
				$c_line=~s/\!\$/#/;
			} else {
			$c_line=~s/\!/\/\//;
			}
		}
		elsif (exists $info->{'Use'}) {
			if ($line=~/$f/) {
				$c_line = '//'.$line; $skip=1;
			} else {
			# We should parse the module, or we can simply assume that we replace it with an include with the same name
			warn "Replacing USE with #include: ".$line;
			$line=~s/^\s*use\s+//;
			$line=~s/\s*$//;
			$c_line = '#include "'.$line.'.h"';
			}
		}
		elsif (
			exists $info->{'ImplicitNone'} or
			exists $info->{'Implicit'}
		) {
			$c_line = '//'.$line; $skip=1;
		}
		elsif (exists $info->{'Include'} ) {
			$line=~s/^\s*//;
			$c_line = '#'.$line;
		}
		elsif (exists $info->{'Goto'} ) { 
			$c_line = ',&'.$f.'_'.$info->{'Goto'}{'Label'}.' JMP';
		}
		elsif (exists $info->{'Continue'}) { 
			$c_line='&'.$f.'_'.$info->{'Label'};
		}
		elsif (exists $info->{'Common'}) {
			$c_line='';
		}
		if (exists $info->{'Label'} ) {
			if (not exists $info->{'Continue'}) { die "Labels can only occur on `continue` lines\n"; } 
			# croak Dumper $info;
			# $c_line = $info->{'Label'}. ' : '."\n".$info->{'Indent'}.$c_line;
		}

		push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line unless $skip;

		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f, 
	# pass state
	{
		'TranslatedCode'=>[], 
		'Args'=>[],'ArgVarDecls'=>[],
		'IfStack'=>{},'IfId' =>0,'IfBranchId' =>0,
		'DoIter'=>'', 'DoId' => 0
	}
	];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_translate_to_Uxntal, $state,'C_translation_collect_info() ' . __LINE__  ) ;

 	$stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
 	$stref->{'TranslatedCode'}=[
		 @{$state->[2]{'ArgVarDecls'}},
		@{$stref->{'TranslatedCode'}},'',@{$state->[2]{'TranslatedCode'}}] ;
	# For fixing LLVM IR
	$stref->{'SubroutineArgs'}=$state->[2]{'Args'};
	$stref->{'SubroutineName'}=$f;
 	return $stref;

} # END of translate_sub_to_Uxntal()

# FIXME: only include if they are actually used in the code!
# $ocl: 0 = C, 1 = CPU/GPU OpenCL, 2 = C for TyTraIR aka TyTraC, 3 = pipe-based OpenCL for FPGAs
sub _write_headers { (my $stref, my $ocl)=@_;
	my @headers = grep { $_ ne '' } (
		# 0 means C, needs the header;
		( $ocl>0 ? '' : '#include <stdlib.h>'),
		( ($ocl>0 and $ocl!=2) ? '' : '#include <math.h>'),
		( $ocl>0 ? '' : 'unsigned int get_global_id(unsigned int n);'),
		# ($ocl != 2 ? '#include "array_index_f2c1d.h"' : ''), # WV 2019-11-20 this is incorrect as non-map/fold args can be arrays
		'#include "array_index_f2c1d.h"' ,
		''
		);

	my @footers = grep { $_ ne '' } (
		# 0 means C, needs the header;
		( $ocl>0 ? '' : 'inline unsigned int get_global_id(unsigned int n) { return 0; }'),
		);
		$stref->{'TranslatedCode'}=[@headers,@{$stref->{'TranslatedCode'}},@footers];

		if (not -e $targetdir.'/array_index_f2c1d.h') {
			_gen_array_index_f2c1d_h();
		}
		return $stref;
} # END of _write_headers()

sub _emit_Uxntal_code { (my $stref, my $module_name, my $ocl)=@_;
 	map {say $_ } @{$stref->{'TranslatedCode'}} if $V;
	# WV 2021-06-08 I use .cc so that this is ostensibly C++ code.
	# This is because in pure C, the switch/case does not work with const int (!)
	# I don't want to replace the const int by #define in an ad-hoc way so C++ it is.
 	my $ext = 'tal';
 	my $module_src = $stref->{'Modules'}{$module_name}{'Source'};
	if (not defined $module_src) {
		$module_src=$Config{'MODULE_SRC'};
	}

 	my $fsrc = $module_src;
    if ($module_src eq '') { # No module? Try to treat it as a program
        if ($module_name eq  $stref->{'Top'}) {
            $fsrc= $stref->{'Program'};
            $fsrc=~s/^.+\///;
        }
    }
	# croak "$targetdir/$fsrc";
 	my $csrc = $fsrc;$csrc=~s/\.\w+$//;
	 $csrc=~s/.+\///;
    if (not -d $targetdir) {
        mkdir $targetdir;
    }
	# croak "$targetdir/$csrc.$ext";
 	open my $OUT, '>', "$targetdir/$csrc.$ext";
 	map {say $OUT $_ } @{$stref->{'TranslatedCode'}};
 	close $OUT;
	return $stref;
} # END of _emit_Uxntal_code

sub _emit_subroutine_sig_Uxntal { (my $stref, my $f, my $annline)=@_;
	    (my $line, my $info) = @{ $annline };
	    my $Sf        = $stref->{'Subroutines'}{$f};

	    my $name = $info->{'Signature'}{'Name'};
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
		# croak Dumper ($info, $Sf->{'RefactoredArgs'});
		my $c_args_ref=[];
		for my $arg (@{ $args_ref }) {
			($stref,my $c_arg_decl) = _emit_arg_decl_Uxntal($stref,$f,$arg,$f);
			push @{$c_args_ref},$c_arg_decl;
		}
	    my $args_str = join( ' ', @{$c_args_ref} );
		my $rline = 
		# $args_str."\n".
		'@'.$name;
		if (exists $stref->{'Subroutines'}{$f}{'Program'} and $stref->{'Subroutines'}{$f}{'Program'}==1
		) {
			$rline = '|0100';
		}
		return  ($rline,$c_args_ref);
} # END of _emit_subroutine_sig_Uxntal

sub _emit_arg_decl_Uxntal { (my $stref,my $f,my $arg, my $name)=@_;

	my $decl_for_iodir =	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg) ;

	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=2};
	my $uxntal_size = toUxntalType($ftype,$fkind);
	my $c_arg_decl = '@'.$name.'_'.$arg.' $'.$uxntal_size;
	return ($stref,$c_arg_decl);
}



sub _emit_var_decl_Uxntal { (my $stref,my $f,my $var)=@_;
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
	my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
	# say $decl->{"ParsedVarDecl"};
	my $const = '';
	my $val='';
	if (defined $decl->{'Parameter'}) {
		my $val_str = $val; 
		if ($val=~/[\'\"'](.+?)[\'\"]/) {
			$val_str = "'$1";
		}
		elsif ($val=~/^\d+(?:_[1248])?$/) {
			my $sz=2;
			if ($val=~s/_([1248])$//) { $sz=$1}
			$val_str = toHex($val,$sz);
		}
		my $par_decl_str = '%'.$f.'_'.$var.' { '. $val_str .' }';
		return ($stref,$par_decl_str);
		# $const = 'const ';
		# $val = ' = '.$decl->{'Val'};
		# # In the case of a constant array: replace '(/' with '{' and add '[]' to front
		# # WV 2021-10-19 This is OK but a bit hacky, because Fortran also supports the '[ ... ]' syntax
		# # It would be better to use ParsedVarDecl
		# if ($val=~s/\(\//{/) {
		# 	$val=~s/\/\)/}/;
		# 	$val = '[]' . $val;
		# }
	} else {
		my $dim= $array  ? __C_array_size($decl->{'Dim'}) : 1;
		my $ftype = $decl->{'Type'};
		my $fkind = $decl->{'Attr'};
		if (ref ($ftype) eq 'HASH') {
			if (exists $ftype->{'Kind'}) {
				$fkind = $ftype->{'Kind'};
			}
			$ftype = $ftype->{'Type'};
		}
		$fkind=~s/\(kind=//;
		$fkind=~s/\)//;
		if ($fkind eq '') {$fkind=4};

		my $sz = toUxntalType($ftype,$fkind)*$dim;
		my $c_var_decl =  '@'.$f.'_'.$var.' $'. $sz;
		return ($stref,$c_var_decl);
	}
}

sub _emit_assignment_Uxntal { (my $stref, my $f, my $info)=@_;
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
	my $lhs = _emit_expression_Uxntal($lhs_ast,$stref,$f,$info);

	my $indent='';
	$lhs=~/^(\s+)/ && do {
		$indent=$1;
		$lhs=~s/^\s+//;
	};
	$lhs=~s/^\(([^\(\)]+)\)/$1/;
	$lhs=$indent.$lhs;

	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};

	my $rhs = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
	my $rhs_stripped = $rhs;
	$rhs_stripped=~s/^\(([^\(\)]+)\)$/$1/;

	for my $macro (keys %{ $Config{'Macros'} } ) {
		my $lc_macro=lc($macro);
		$rhs_stripped=~s/\b$lc_macro\b/$macro/g;
	}

	# my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
	$lhs =~s/LDA2$//;
	my $rline = $info->{'Indent'}.$rhs_stripped . ' '. $lhs. ' STA2';
	if (exists $info->{'If'}) {
		my $if_str = _emit_ifthen_Uxntal($stref,$f,$info);
		$rline =$indent.$if_str.' '.$rline;
	}
	# carp "$f $rline";
	return $rline;
}



sub _emit_ifthen_Uxntal { (my $stref, my $f, my $info, my $branch_id)=@_;
	my $cond_expr_ast=$info->{'Cond'}{'AST'};
	my $cond_expr = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
	# $cond_expr=_change_operators_to_Uxntal($cond_expr);
	# FIXME! fix for stray '+'
	# $cond_expr=~s/\+\>/>/g;
	# my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');
	my $rline = "$cond_expr ,&branch$branch_id JCN\n" .
	             ",&branch{$branch_id}_end JMP\n" .
             "&branch{$branch_id}";
	return $rline;
}

sub _emit_ifbranch_end_Uxntal { my ($id, $state) = @_;
	my $branch_id = $state->{'IfBranchId'};
	my $if_id = $state->{'IfId'};
	my $r_line = "&branch${branch_id}_end\n";
	$r_line .= ",&cond_end{$if_id} JMP\n";
	$state->{'IfBranchId'} = $id;
	$branch_id = $state->{'IfBranchId'};
	return ($r_line,$branch_id);
}
# I wonder if for call args it might be better to have a separate function which checks if the arg is scalar, array, array access, const
# The AST is a tree made of a nesting of lists. Each list starts with an integer identifying its type:
#                 0    1    2    3    4    5    6    7    8    9    10   11   12   13    14
# our @sigils = ('(', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//', ')('
#                 15    16    17  18   19    20     21       22       23      24       25       26
#			    ,'==', '/=', '<', '>', '<=', '>=', '.not.', '.and.', '.or.', '.xor.', '.eqv.', '.neqv.'
#                 27   28
#			    ,',', '(/',
# Constants
#                 29        30      31         32           33             34       35
#			    ,'integer', 'real', 'logical', 'character', 'PlaceHolder', 'Label', 'BLANK'
#   );
# $: scalar
# &: subroutine
# @: array


sub _emit_expression_Uxntal { my ($ast, $stref, $f, $info)=@_;
	my $Sf = $stref->{'Subroutines'}{$f};

    if (ref($ast) eq 'ARRAY') {
        if (scalar @{$ast}==3) {
			# Uxn does not have pow or mod so these would have to be functions 
			if ($ast->[0] == 8) { # eq '^'
				(my $op, my $arg1, my $arg2) = @{$ast};
				$ast = [1,'pow',[27,$arg1,$arg2] ] ;
			}
			# elsif ($ast->[0] == 1 and $ast->[1] eq 'mod') {# eq '&'
			# 		shift @{$ast};
			# 		my $arg1 = $ast->[1][1];
			# 		my $arg2 = $ast->[1][2];
			# 		$ast = [7,$arg1,$arg2];# '%';
			# }

            if ($ast->[0] == 1 or $ast->[0] ==10) { #  array access 10=='@' or function call 1=='&'
                (my $sigil, my $name, my $args) =@{$ast};
				# if ($ast->[0] == 1) { # No need for this in Uxn, we might as well keep the Fortran names
				# 	my $mvar = $name;
				# 	# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
				# 	# The (float) cast is necessary because otherwise I get an "ambiguous" error
				# 	$mvar=~s/^(abs|min|max)$/(float)f$1/;
				# 	$mvar=~s/^am(ax|in)1$/(float)fm$1/;
				# 	$mvar=~s/^alog$/(float)log/;
				# 	$name = $mvar;
				#  	$stref->{'CalledSub'}= $mvar;
				# }

                if (@{$args}) {
					if ($args->[0] != 14 ) { # NOT ')('
						my @args_lst=();
						my $has_slices=0;
						if($args->[0] == 27) { # ','
						# more than one arg
							for my $idx (1 .. scalar @{$args}-1) {
								my $arg = $args->[$idx];
								my $is_slice = $arg->[0] == 12;
								push @args_lst, _emit_expression_Uxntal($arg, $stref, $f,$info) unless $is_slice;
								$has_slices ||= $is_slice;
							}
						} else {
							# only one arg
							$args_lst[0] = _emit_expression_Uxntal($args, $stref, $f,$info);
							# return "$name("._emit_expression_Uxntal($args, $stref, $f).')';
						}

						if ($ast->[0]==10) { # An array access
							# In Uxntal, an array access is ;array $idx ADD2 LDA2 and if $idx is a scalar, I assume it's $idx LDA2
							if( $args->[0]==29 and $args->[1] eq '1') { # if we have v(1)
								return ';'.$f.'_'.$name.' LDA2';
							} else {
								my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$name);
								my $dims =  $decl->{'Dim'};
								my $maybe_amp = $has_slices ? '&' : '';
								my $ndims = scalar @{$dims};

								my @ranges=();
								my @lower_bounds=();
								for my $boundspair (@{$dims}) {
									(my $lb, my $hb)=@{$boundspair };
									push @ranges, "(($hb - $lb )+1)";
									push @lower_bounds, $lb;
								}
								if ($ndims==1) {
									return ';'.$f.'_'.$name.' '.$args_lst[0].' ADD2 LDA2'
								} else {
									die "No support for multidimensional arrays yet\n";
									# return $maybe_amp.$name.'[F'.$ndims.'D2C('.join(',',@ranges[0.. ($ndims-2)]).' , '.join(',',@lower_bounds). ' , '.join(',',@args_lst).')]';
								}
							}
						} else { # A subroutine access. 
							return join(' ',@args_lst).' '.$name;
						}
					} else { #  ')(', e.g. f(x)(y)
						die 'ERROR: f()() is not supported, sorry!'."\n";
					}
				} else {
					return $name;
				}
            } else { # not '&' or '@'

                (my $opcode, my $lexp, my $rexp) =@{$ast};

                my $lv = (ref($lexp) eq 'ARRAY') ? _emit_expression_Uxntal($lexp, $stref, $f,$info) : $lexp;
                my $rv = (ref($rexp) eq 'ARRAY') ? _emit_expression_Uxntal($rexp, $stref, $f,$info) : $rexp;

                return "$lv $rv  ".$sigils[$opcode].'2'; # FIXME, needs refining
            }
        } elsif (scalar @{$ast}==2) { #  for '{'  and '$'

            (my $opcode, my $exp) =@{$ast};
            if ($opcode==0 ) { # eq '('
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_Uxntal($exp, $stref, $f,$info) : $exp;
                return "[ $v ]"; # FIXME
            } elsif ($opcode==28 ) { # eq '(/'
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_Uxntal($exp, $stref, $f,$info) : $exp;
                return "[ $v ]"; # FIXME
            } elsif ($opcode==2 or $opcode>28) {# eq '$' or constants
				if ($opcode == 34) {
					die 'ERROR: Fortran LABEL as arg is not supported, sorry!'."\n"; #  "*$exp" : $exp;   # Fortran LABEL, does not exist in C
				}

				if ($exp=~/^\d+(?:_[1248])?$/) {
					my $sz=2;
					if ($exp=~s/_([1248])$//) { $sz=$1}
					$exp = toHex($exp,$sz);
				}
				my $mvar = $ast->[1];
				my $called_sub_name = $stref->{'CalledSub'} // '';
				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar} ) {
					# Meaning that $mvar is a pointer in $f
					# Now we need to check if it is also a pointer in $subname
					my $ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar};
					# carp "$f <$ptr>" ."<$called_sub_name>".'<', exists  $stref->{'Subroutines'}{$called_sub_name} ,'><', exists $stref->{'Subroutines'}{$called_sub_name}{'Pointers'}{$mvar},'>' if $mvar eq 'wet_j_k';
					if ($called_sub_name ne '' and $called_sub_name ne $f and
					exists  $stref->{'Subroutines'}{$called_sub_name}
					and exists $stref->{'Subroutines'}{$called_sub_name}{'Pointers'}{$mvar} ) {
						my $sig_ptr = $stref->{'Subroutines'}{$called_sub_name}{'Pointers'}{$mvar};
						warn "SIG PTR: $sig_ptr <> $ptr";
						if ($sig_ptr eq '' and $ptr eq '*') {
							$ptr = '*'
						} elsif ($sig_ptr eq '*' and $ptr eq '') {
							$ptr = '&'
						} else {
							$ptr='';
						}
					} else {
						if ( $called_sub_name eq $f) {
							carp "FIXME: we should parse the entire assigment expr so that we know we are dealing with an assignment!";
							$ptr = '*';
						}
						# If the variable in question is 'Out' or 'InOut' we should use the pointer

					}
                    if ($ptr eq '') {
                        # return $exp;
						return ';'.$f.'_'.$exp.' LDA2';
                    } else {
						# return '('.$ptr.$exp.')';
						return ';'.$f.'_'.$exp.' LDA2';
                    }
				} else {
					if ($exp eq '.true.') {
					return '#01';	
					} elsif ($exp eq '.false.') {
					return '#00';
					} else {
						return $exp;
					}
				}
            } elsif ($opcode == 21 or $opcode == 4 or $opcode == 3) {# eq '.not.' '-'
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_Uxntal($exp, $stref, $f,$info) : $exp;
                return $v.' '.$sigils[$opcode] ;
            } elsif ($opcode == 27) { # ','
                croak Dumper($ast) if $DBG; # WHY is this here?
                my @args_lst=();
                for my $arg (@{$exp}) {
                    push @args_lst, _emit_expression_Uxntal($arg, $stref, $f,$info);
                }
                return join(',',@args_lst);
            } else {
                croak 'BOOM! '.Dumper($ast).$opcode  if $DBG;
            }
        } elsif (scalar @{$ast} > 3) {

            if($ast->[0] == 27) { # ','
                my @args_lst=();
                for my $idx (1 .. scalar @{$ast}-1) {
                    my $arg = $ast->[$idx];
                    push @args_lst, _emit_expression_Uxntal($arg, $stref, $f,$info);
                }
                return join(',',@args_lst);
            } else {
                croak Dumper($ast) if $DBG;
            }
        }
    } else {
		# Should not happen?
		return $ast;
	}
} # END of _emit_expression_Uxntal

sub _change_operators_to_Uxntal { (my $expr) = @_;
die 'FIXME!';
my %Uxntal_ops =(
    '+' => 'ADD',
    '-' => 'SUB',
    '*' => 'MUL',
    '/' => 'DIV',
	'eq' => 'EQU',
	'ne' => 'NEQ',
	'le' => '',
	'ge' => '',
	'GTH' => '>',
	'LTH' => '<',
	'not' => '',
	'and' => 'AND',
	'or' => 'ORA',
);
# .not. expr => 1 - expr => #01 expr SUB
# expr >= c => expr c GTHk EQU ORA
# expr <= c => expr c LTHk EQU ORA
while ($expr=~/\.(\w+)\./) {
	$expr=~s/\.(\w+)\./$Uxntal_ops{$1}/;
}
	return $expr;
}
#### #### #### #### END OF C TRANSLATION CODE #### #### #### ####


sub _emit_subroutine_call_expr_Uxntal { my ($stref,$f,$info) = @_;
	my @call_arg_expr_strs_Uxntal=();
	my $subname = $info->{'SubroutineCall'}{'Name'};
	my $Ssubname = $stref->{'Subroutines'}{$subname};
	# croak Dumper ($info, $Ssubname->{'Vars'}) if $f=~/test_subcall/;
	

	my $mvar = $subname;
	# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
	# The (float) cast is necessary because otherwise I get an "ambiguous" error
	$mvar=~s/^(abs|min|max)$/(float)f$1/;
	$mvar=~s/^am(ax|in)1$/(float)fm$1/;
	$mvar=~s/^alog$/(float)log/;
	my $subname_C = $mvar;
# What we need for every argument is IODir , ArrayOrScalar from the record
# So we'd better loop over the List in the record. 
	#  "inout" args will occur in both places if required.
	my @in_args=();
	my @out_args=();
	my $idx=0;
	for my $sig_arg (@{$Ssubname->{'RefactoredArgs'}{'List'}}) {
		$idx++;
		my $rec = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg};
		my $call_arg_expr_str = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
		# say "$sig_arg => $call_arg_expr_str";
		my $intent = $rec->{'IODir'};
		my $isArray = $rec->{'ArrayOrScalar'} eq 'Array';
		if (not $isArray  and $rec->{'Type'} eq 'character') {
			if ($rec->{'Attr'}=~/len=(\d+)/) {
				my $len = $1;
				$isArray = $len>1;
			}
		}
		my $wordSz = $rec->{'Type'} eq 'character' ? 1 : 2;
		if ($rec->{'Attr'}=~/kind=(\d+)/) {
			$wordSz = $1;
		}
		# say $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'};	
		my $isConstOrExpr = (($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' ) or ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr'));
		if ($intent eq 'in' or $intent eq 'inout') {
			if ($isArray) { 
				say ';'.$f.'_'.$call_arg_expr_str;
			}
			elsif (not $isConstOrExpr) { # must be a scalar variable
				say ';'.$f.'_'.$call_arg_expr_str.' STA'.$wordSz;
			} 
			else {
				my $arg_expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'}[0] == 27 ? $info->{'SubroutineCall'}{'ExpressionAST'}[$idx] : $info->{'SubroutineCall'}{'ExpressionAST'};
				say _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);
			}
		}
	}
	say $subname;
	$idx=0;
	for my $sig_arg (reverse @{$Ssubname->{'RefactoredArgs'}{'List'}}) {
		$idx++;
		my $rec = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg};
		my $call_arg_expr_str = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
		# say "$sig_arg => $call_arg_expr_str";
		my $intent = $rec->{'IODir'};
		my $isArray = $rec->{'ArrayOrScalar'} eq 'Array';
		if (not $isArray  and $rec->{'Type'} eq 'character') {
			if ($rec->{'Attr'}=~/len=(\d+)/) {
				my $len = $1;
				$isArray = $len>1;
			}
		}
		my $wordSz = $rec->{'Type'} eq 'character' ? 1 : 2;
		if ($rec->{'Attr'}=~/kind=(\d+)/) {
			$wordSz = $1;
		}		
		# say $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'};	
		my $isConst = (($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' ) or ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr'));
		if ($intent eq 'out' or $intent eq 'inout') {
			if (not $isArray and not $isConst) { 
				my $arg_expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'}[0] == 27 ? $info->{'SubroutineCall'}{'ExpressionAST'}[$idx] : $info->{'SubroutineCall'}{'ExpressionAST'};
				# say _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);
				say ';'.$f.'_'.$call_arg_expr_str.' STA'.$wordSz;
			}
		}
	}

die if $f=~/test_subcall/;

# 	for my $call_arg_expr_str (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
		

# 		my $arg_type = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'};
# 			if ( $arg_type eq 'Scalar') {
# 				my $ptr = '';
# 				# If it is a parameter, it will get an '&'.
# 				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$call_arg_expr_str}) {
# 					$ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$call_arg_expr_str};
# 					$ptr = $ptr ne '&' ? '' : $ptr;
# 				}
# 				push @call_arg_expr_strs_C, "$ptr$call_arg_expr_str";
# 			}
# 			elsif ( $arg_type eq 'Array') {
# 				# This is an array access.
# 				my $call_arg_expr_str_C='';
# 				my $name = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Arg'};
# 				my $args = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'AST'}[2];
# # croak Dumper $args if $info->{'SubroutineCall'}{'Name'} eq 'update_map_24';
# 				my @args_lst=();
# 				my $has_slices=0;
# 				if($args->[0] == 27) { # ','
# 				# more than one arg
# 					for my $idx (1 .. scalar @{$args}-1) {
# 						my $arg = $args->[$idx];
# 						my $is_slice = $arg->[0] == 12;
# 						push @args_lst, _emit_expression_Uxntal($arg, $stref, $f,$info) unless $is_slice;
# 						$has_slices ||= $is_slice;
# 					}
# 				} else {
# 					# only one arg
# 					$args_lst[0] = _emit_expression_Uxntal($args, $stref, $f,$info);
# 				}

# 				if( $args->[0]==29 and $args->[1] eq '1') { # if we have v(1)
# 					push @call_arg_expr_strs_C, '(*'.$name.')';
# 				} else {
# 					my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$name);
# 					my $dims =  $decl->{'Dim'};
# 					my $ndims = scalar @{$dims};

# 					my @ranges=();
# 					my @lower_bounds=();
# 					for my $boundspair (@{$dims}) {
# 						(my $lb, my $hb)=@{$boundspair };
# 						push @ranges, "(($hb - $lb )+1)";
# 						push @lower_bounds, $lb;
# 					}
# 					if ($ndims==1) {
# 						my $offset_expr = '-'.$lower_bounds[0];
# 						if ($lower_bounds[0]<0) {
# 								$offset_expr = '+'.($lower_bounds[0]*-1);
# 						} elsif ($lower_bounds[0]==0) {
# 							$offset_expr = '';
# 						}
# 						push @call_arg_expr_strs_C, '&'.$name.'['.$args_lst[0].''.$offset_expr.']'; #F1D2C('.$lower_bounds[0]. ', '.
# 					} else {
# 						push @call_arg_expr_strs_C, '&'.$name.'[F'.$ndims.'D2C('.join(',',@ranges[0.. ($ndims-2)]).' , '.join(',',@lower_bounds). ' , '.join(',',@args_lst).')]';
# 					}
# 				}
# 				# push @call_arg_expr_strs_C, $call_arg_expr_str_C;
# 			}
# 			elsif ( $arg_type eq 'Expr') {
# 				croak "TODO: Can't handle arguments of type $arg_type yet.";
# 			}
# 			else {
# 				# Probably a Label, give up
# 				croak "Can't handle arguments of type $arg_type yet.";
# 			}

# 	}
# 	# croak Dumper join(", ", @call_arg_expr_strs_C) if  eq 'update_map_24';
# 	return $subname_C.'('.join(", ", @call_arg_expr_strs_C).')';
} # END of _emit_subroutine_call_expr_Uxntal


# -----------------------------------------------------------------------------
sub toUxntalType {
    ( my $ftype, my $kind ) = @_;

    if (not defined $kind) {$kind=4};
	if ($kind=~/kind/) {$kind=~s/kind\s*=\s*//;}; # FIXME, this should have been sorted in the Parser

    my %corr = (
        'logical'          => 1, # C has no bool
        'integer'          =>  $kind,
        # 'real'             => ($ftype eq 'real' and $kind == 8 ? 'double' : 'float'),
        # 'double precision' => 'double',
        # 'doubleprecision'  => 'double',
        'character'        => 1
    );
    if ( exists( $corr{$ftype} ) ) {
        return $corr{$ftype};
    } else {
        die "TYPE for $ftype is not supported\n" if $W;
    }
}    # END of toUxntalType()

sub toHex { my ($n,$sz) = @_;
	my $szx2 = $sz*2;
	return sprintf("#%0${szx2}x",$n);
}
# -----------------------------------------------------------------------------
sub add_to_C_build_sources {
    ( my $f, my $stref ) = @_;
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $is_inc = $sub_or_func eq 'IncludeFiles';
    if (not $is_inc ) {
    my $src =  $stref->{$sub_or_func}{$f}{'Source'};
    if ( not exists $stref->{'BuildSources'}{'C'}{$src} ) {
        print "ADDING $src to C BuildSources\n" if $V;
        $stref->{'BuildSources'}{'C'}{$src} = 1;
    }
    } else {
    	my $inc=$f;
        if ( not exists $stref->{'BuildSources'}{'H'}{$inc} ) {
            print "ADDING $inc to C Header BuildSources\n" if $V;
            $stref->{'BuildSources'}{'H'}{$inc} = 1;
        }

    }

    return $stref;
} # END of add_to_C_build_sources()

sub __C_array_size { (my $dims) = @_;
	my $array_size=1;
	for my $dim (@{$dims}) {
		my $lb=$dim->[0];
		my $ub=$dim->[1];
		my $dim_size = eval("$ub-$lb+1");
		$array_size*=$dim_size;
	}
	return $array_size;
}

sub __all_bounds_numeric { (my $dims)=@_;
	my $all_bounds_numeric=0;
 no warnings 'numeric';
 for my $dim (@{$dims}) {
 	for my $entry (@{$dim}) {
       $all_bounds_numeric ||=  ($entry eq $entry+0) ? 1 : 0;
 	}
 }
	return $all_bounds_numeric;
}

sub _gen_array_index_f2c1d_h {
	# open RefactorF4Acc::Translation::Uxntal::DATA or die $!;
	if (not -d $targetdir) {
		mkdir $targetdir;
	}
	open my $fh, '>', $targetdir.'/array_index_f2c1d.h' or die "$! : $targetdir";
	while(my $line = <RefactorF4Acc::Translation::Uxntal::DATA>) {
		print $fh $line;
	}
	close $fh;
	close RefactorF4Acc::Translation::Uxntal::DATA;
} # END of _gen_array_index_f2c1d_h

__DATA__

#ifndef __ARRAY_INDEX_F2C_H__
#define __ARRAY_INDEX_F2C_H__
__attribute__((always_inline)) inline unsigned int F3D2C(
        unsigned int i_rng,unsigned int j_rng, // ranges, i.e. (hb-lb)+1
        int i_lb, int j_lb, int k_lb, // lower bounds
        int ix, int jx, int kx
        ) {
    return (i_rng*j_rng*(kx-k_lb)+i_rng*(jx-j_lb)+ix-i_lb);
}

__attribute__((always_inline)) inline unsigned int F2D2C(
        unsigned int i_rng, // ranges, i.e. (hb-lb)+1
        int i_lb, int j_lb, // lower bounds
        int ix, int jx
        ) {
    return (i_rng*(jx-j_lb)+ix-i_lb);
}


__attribute__((always_inline)) inline unsigned int F1D2C(
        int i_lb, // lower bounds
        int ix
        ) {
    return ix-i_lb;
}

__attribute__((always_inline)) inline unsigned int F4D2C(
        unsigned int i_rng,unsigned int j_rng, unsigned int k_rng, // ranges, i.e. (hb-lb)+1
        int i_lb, int j_lb, int k_lb, int l_lb, // lower bounds
        int ix, int jx, int kx, int lx
        ) {
    return (i_rng*j_rng*k_rng*(lx-l_lb)+
            i_rng*j_rng*(kx-k_lb)+
            i_rng*(jx-j_lb)+
            ix-i_lb
            );
}


#endif
