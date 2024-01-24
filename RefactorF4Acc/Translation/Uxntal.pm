package RefactorF4Acc::Translation::Uxntal;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::F95SpecWords qw( %F95_intrinsic_functions %F95_intrinsic_subroutine_sigs );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass stateful_pass_inplace pass_wrapper_subs_in_module update_arg_var_decl_sourcelines get_annotated_sourcelines);
use RefactorF4Acc::Refactoring::Fixes qw(
	_declare_undeclared_variables
	_remove_unused_variables
	__has_module_level_declaration
	);
use RefactorF4Acc::Refactoring::CaseToIf qw( replace_case_by_if )	;
use RefactorF4Acc::Refactoring::FoldConstants qw( fold_constants_all fold_constants_no_iters )	;
# use RefactorF4Acc::Parser::Expressions qw( @sigils );
use RefactorF4Acc::Translation::LlvmToTyTraIR qw( generate_llvm_ir_for_TyTra );
use RefactorF4Acc::Emitter qw( emit_AnnLines );
use Fortran::F95VarDeclParser qw( parse_F95_var_decl );
#
#   (c) 2010-2024 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

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
    &translate_program_to_Uxntal
	&translate_sub_to_Uxntal
);

#### #### #### #### BEGIN OF UXNTAL TRANSLATION CODE #### #### #### ####

#               0    1    2    3      4      5      6      7      8      9   10   11   12   13    14
our @sigils = ('(', '&', '$', 'ADD', 'SUB', 'MUL', 'DIV', 'mod', 'pow', '=', '@', '#', ':' ,'//', ')('
#                15    16      17    18      19     20     21     22     23     24       25       26
               ,'EQU', 'NEQ', 'LTH', 'GTH', 'lte', 'gte', 'not', 'AND', 'ORA', 'EOR', '.eqv.', '.neqv.'
#                27   28
               ,',', '(/',
# Constants
#                29        30      31         32           33         34             35       36
               ,'integer', 'real', 'logical', 'character', 'complex', 'PlaceHolder', 'Label', 'BLANK'
              );


# WV2023-12-08 I think this has to be done fundamentally differently.
# Maybe I should  fold_constants_no_iters on all modules and the main program first.
# Essentially, this should be like the constant folding step in Refactoring.

sub translate_program_to_Uxntal {  (my $stref, my $program_name) = @_;
# die $program_name;
# croak Dumper( keys(%{$stref->{'Modules'}}),$stref->{'Program'},$stref->{'SourceContains'}{$stref->{'Program'}}{'List'});
	$stref = fold_constants_all($stref) ;


	# ($stref,my $new_annlines) = fold_constants_no_iters($stref,$program_name);
	# $stref->{'Subroutines'}{$program_name}{'RefactoredCode'} = $new_annlines;
	# for my $module_name (sort keys %{$stref->{'Modules'}} ) {
	# 	($stref,my $new_annlines) = fold_constants_no_iters($stref,$module_name);
	# 	$stref->{'Modules'}{$module_name}{'RefactoredCode'} = $new_annlines;
	# }
	# croak Dumper $stref->{'Subroutines'}{$program_name}{'RefactoredCode'};
	my $new_annlines = $stref->{'Subroutines'}{$program_name}{'RefactoredCode'};
	# say $program_name;
	# croak Dumper pp_annlines($new_annlines);
	# croak Dumper pp_annlines($new_annlines,1);
	$stref->{'TranslatedCode'}=[];
	$Config{'FIXES'}={
		# _declare_undeclared_variables => 1,
	# _remove_unused_variables => 1
	};
	$stref = pass_wrapper_subs_in_module($stref,$program_name,
	   # module-specific passes.
       [
			[\&translate_module_decls_to_Uxntal]
        #    [\&_emit_OpenCL_pipe_declarations]
       ],
       # subroutine-specific passes
	   [
		  [
			#   \&determine_argument_io_direction_rec,
			#   \&update_arg_var_decl_sourcelines,
			#   \&_declare_undeclared_variables,
			  \&replace_case_by_if
		  ],
			#,\&_remove_unused_variables],
		  [\&translate_sub_to_Uxntal]
       ]
       );

	# $stref = _write_headers($stref,$ocl);
	$stref = _emit_Uxntal_code($stref, $program_name);
	# This enables the postprocessing for custom passes
	$stref->{'CustomPassPostProcessing'}=1;
    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'}={};
} # END of translate_program_to_Uxntal

# TODO: This should include handling of 'use' declarations.
# Unfortunately for those we will need to split the module level declarations from the subroutines.
sub translate_module_decls_to_Uxntal { (my $stref, my $mod_name) = @_;

    my $pass_emit_module_declarations = sub { (my $annline, my $state)=@_;
        (my $line,my $info)=@{$annline};
		say "MOD LINE: <$line>";
        my $c_line=$line;
        (my $stref, my $mod_name, my $pass_state)=@{$state};
        my $skip=1;

        if (exists $info->{'VarDecl'}) {
                my $var = $info->{'VarDecl'}{'Name'};
				$c_line = _emit_var_decl_Uxntal( $stref, $mod_name, $info, $var);
				$skip=0;
        }
		elsif ( exists $info->{'ParamDecl'} ) {
			croak "SHOULD NOT HAPPEN";
			my $var = $info->{'VarDecl'}{'Name'};
		}
        push @{$pass_state->{'TranslatedCode'}},$c_line unless $skip;

        return ([$annline],[$stref,$mod_name,$pass_state]);
    };

    my $state = [$stref,$mod_name, {'TranslatedCode'=>[]}];
    ($stref,$state) = stateful_pass_inplace($stref,$mod_name,$pass_emit_module_declarations , $state,'emit_module_declarations() ' . __LINE__  ) ;

    $stref->{'Modules'}{$mod_name}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
    $stref->{'TranslatedCode'}=[@{$stref->{'TranslatedCode'}},@{$state->[2]{'TranslatedCode'}},''];

    return $stref;
} # END of translate_module_decls_to_Uxntal

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
- All non-constant, non-param args are pointers because they are addresses
- If a call arg is an expression, then it's a value
- Arguments to calls are therefore always either `;`; &arg_var[idx_expr] becomes ;arg_var idx_expr ADD2
- Accesses in subroutine bodies are always *lhs_vars = expr(*rhs_vars), i.e. expr(*rhs_vars LDA{1,2}) lhs_vars STA{1,2}
- Scalar local vars are values, so also LDA
- A parameter used as arg should be passed by value

=cut
	my $Sf = $stref->{'Subroutines'}{$f};

	for my $var (@{$Sf->{'AllVarsAndPars'}{'List'}}) {
		my $subset = in_nested_set($Sf,'Vars',$var);
		# if ($subset eq '') {
		# 	$subset = in_nested_set($Sf,'ModuleVars',$var);
		# }
		# if ($subset eq '') {
		# 	$subset = in_nested_set($Sf,'ModuleParameters',$var);
		# }
		if ($subset eq '') {
			croak "$f $var";
		}
		my $decl = get_var_record_from_set($Sf->{$subset},$var);
		# croak "$f $var",Dumper($decl) if $f eq 'clearFunktalTokens' and $var eq 'funktalTokensIdx';
		# say "$f $var $subset", Dumper $decl;

		my $wordsz=0;
		my $type = $decl->{'Type'};	
		if ($type eq 'integer') {
			my $kind = $decl->{'Attr'};
			$kind=~s/kind\s*=\s*//;
			$kind=~s/^\s*\(\s*//;
			$kind=~s/\s*\)\s*$//;
			$kind*=1;
			if ($kind>2) {
				die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
			}
			$wordsz=$kind;
		}
		elsif ($type eq 'logical') {
			$wordsz=1;
		}
		elsif ($type eq 'character') {
				$wordsz=1;
		} else {
			die "Supported types are integer, character and logical: $var in $f is $type\n";
		}
		$Sf->{'WordSizes'}{$var} = $wordsz;
	}

	my $annlines = get_annotated_sourcelines( $stref, $f );
# This analysis only looks at args, local vars and local parameters. We need to include globals
	my $pass_pointer_analysis = sub { my ($annline,$state) = @_;
		my ($line, $info) = @{$annline};

		if (exists $info->{'Signature'} ) {
			$state->{'Args'} = { map { $_=>1 } @{$info->{'Signature'}{'Args'}{'List'}}};
		}
		elsif (exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'};
			if (exists $state->{'Args'}{$var} ) {
				$state->{'Pointers'}{$var}='*'; # means should be treated as a pointer
			} else {
				$state->{'Pointers'}{$var}=''; # means should be treated as a scalar, i.e. LDA
				$state->{'LocalVars'}{$var}=1;
			}
			my $wordsz=0;
			my $type = $info->{'ParsedVarDecl'}{'TypeTup'}{'Type'};	
			if ($type eq 'integer') {
				my $kind = $info->{'ParsedVarDecl'}{'TypeTup'}{'Kind'};
				if ($kind>2) {
					die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
				}
				$wordsz=$kind;
			}
			elsif ($type eq 'logical') {
				$wordsz=1;
			}
			elsif ($type eq 'character') {
					$wordsz=1;
			} else {
				die "Supported types are integer, character and logical: $var in $f is $type\n";
			}
			$state->{'WordSizes'}{$var}=$wordsz;
		}
		elsif ( exists $info->{'ParamDecl'} ) {
			my $var = $info->{'ParamDecl'}{'Var'};
			$state->{'Pointers'}{$var}='';
			$state->{'Parameters'}{$var}=1;
			my $wordsz=0;
			my $type = $info->{'ParsedParDecl'}{'TypeTup'}{'Type'};	
			if ($type eq 'integer') {
				my $kind = $info->{'ParsedParDecl'}{'TypeTup'}{'Kind'};
				if ($kind>2) {
					die "Integers must be 8-bit or 16-bit: $var in $f is $kind\n";
				}
				$wordsz=$kind;
			}
			elsif ($type eq 'logical') {
				$wordsz=1;
			}
			elsif ($type eq 'character') {
					$wordsz=1;
			} else {
				die "Supported types are integer, character and logical: $var in $f is $type\n";
			}
			$state->{'WordSizes'}{$var}=$wordsz;
		}
		# FIXME: this is because of the presence of an empty $info->{'SubroutineCall'} record.
		elsif (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) {
			my $fname =  $info->{'SubroutineCall'}{'Name'};
			# croak $line.';'.Dumper( $info) unless defined $fname;
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

		elsif (exists $info->{'Do'} ) {
			if (exists $info->{'Do'}{'While'}) {
				say 'TODO: Do While: '.Dumper($info->{'Do'}{'ExpressionsAST'});
			} else {
				say 'TODO: Do: '.Dumper($info->{'Do'});
			}
		}
		elsif (exists $info->{'BeginDo'} ) {
			croak 'TODO: BeginDo: what is this?';
		}

		if (exists $info->{'Assignment'} ) {
			if (exists $info->{'If'}) {
			}
		}
		elsif (exists $info->{'SubroutineCall'} and not exists $info->{'IOCall'}) {
			if (exists $info->{'If'}) {
			}
		}
		elsif (exists $info->{'IOCall'}) {
			if (exists $info->{'PrintCall'}) {
			}
		}
        elsif (exists $info->{'IfThen'}  ) {
        }


		return ([[$line,$info]],$state)
	};

	my $pass_state = {'Pointers'=>{},'Args' =>{},'LocalVars' =>{}, 'Parameters'=>{}, 'WordSizes'=>{}};
	(my $new_annlines_,$pass_state) = stateful_pass($annlines,$pass_pointer_analysis,$pass_state,"pass_pointer_analysis($f)");
	$Sf->{'Pointers'} = $pass_state->{'Pointers'};
	# $Sf->{'WordSizes'} = $pass_state->{'WordSizes'};


# --------------------------------------------------------------------------------------------
	my $pass_translate_to_Uxntal = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		say "$f LINE:<$line> ";#.Dumper($info);
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
        my $id = $info->{'LineID'};
		my $skip=0;
		if (exists $info->{'Signature'} ) {
			$pass_state->{'Args'}=$info->{'Signature'}{'Args'}{'List'};
			my ($sig_line,$arg_decls) = _emit_subroutine_sig_Uxntal( $stref, $f, $annline);
			@{$pass_state->{'ArgVarDecls'}}= map { $_ } @{$arg_decls};
			$c_line = $sig_line."\n";
		}
		elsif (exists $info->{'VarDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};
				# carp Dumper $info;
				if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}) {
					$c_line='( '.$line.' )';
					$skip=1;
				} else {
					$c_line =  _emit_var_decl_Uxntal($stref,$f,$info,$var);
					$pass_state->{'ArgVarDecls'}=[@{$pass_state->{'ArgVarDecls'}},$c_line];
					$skip=1;
				}
		}
		elsif ( exists $info->{'ParamDecl'} ) {
			# carp Dumper $info;
			my $var = $info->{'ParamDecl'}{'Var'};

				$c_line = _emit_var_decl_Uxntal($stref,$f,$info,$var);
		}
		# For Uxntal, we need to turn the Case into an IfThen
		elsif (exists $info->{'Select'} ) {
			croak 'SHOULD NOT HAPPEN!';
			my $switch_expr = _emit_expression_Uxntal([2,$info->{'CaseVar'}],$stref,$f,$info); # FIXME
			$c_line ="switch ( $switch_expr ) {";
		}
		elsif (exists $info->{'Case'} ) {
			croak 'SHOULD NOT HAPPEN!';
            # FIXME: support macros
			# $c_line=$line.': {';#'case';
			# if ($info->{'Case'}>1) {
			# 	$c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.$c_line;
			# }
		}
		elsif (exists $info->{'CaseDefault'}) {
			croak 'SHOULD NOT HAPPEN!';
			# $c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.'default : {';
		}
		elsif (exists $info->{'Do'} ) {
			if (exists $info->{'Do'}{'While'}) {
				say 'TODO: Do While: '.Dumper($info->{'Do'}{'ExpressionsAST'});
				push @{$pass_state->{'DoStack'}}, [$id,$info->{'Do'}{'ExpressionsAST'},'While'];
				$c_line = '&while_loop_'.$f.'_'.$id . "\n" ;
			} else {
			# $pass_state->{'DoIter'} = $f.'_'.$info->{'Do'}{'Iterator'};
			# $pass_state->{'DoStep'} = $info->{'Do'}{'Range'}{'Expressions'}[2];
			# id, iterator, step; loop upper bound is on the wst
			# carp Dumper $info->{'Do'};
			push @{$pass_state->{'DoStack'}}, [$id,$f.'_'.$info->{'Do'}{'Iterator'},$info->{'Do'}{'Range'}{'Expressions'}[2],'Do'];
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
			($c_line,$pass_state) = _emit_assignment_Uxntal($stref, $f, $info,$pass_state) ;
		}
		elsif (exists $info->{'SubroutineCall'} and not exists $info->{'IOCall'}) {
			# WV2023-12-07 TODO: what if this has an If without Then?
			#
			# my $subcall_ast = [ 1, $info->{'SubroutineCall'}{'Name'},$info->{'SubroutineCall'}{'ExpressionAST'} ];

			# There is an issue here:
			# We actually need to check the type of the called arg against the type of the sig arg
			# If the called arg is a pointer and the sig arg is a pointer, no '*', else, we need a '*'
			# But the problem is of course that we have just replaced the called args by the sig args
			# So what we need to do is check the type in $f and $subname, and use that to see if we need a '*' or even an '&' or nothing

            $c_line = _emit_subroutine_call_expr_Uxntal($stref,$f,$line,$info);
			# If without Then
			if (exists $info->{'If'}) {
				my $indent = $info->{'Indent'};
				my $branch_id = $info->{'LineID'};
				my $cond_expr_ast=$info->{'Cond'}{'AST'};
				my $cond_expr = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
			# What we have is e.g.
			# if (fl(1:2) == __PH0__) VV = .true.
			# What we need is
			# NOT <cond> <label_end> JCN
				$c_line = "\n$indent $cond_expr EQU #00 ,&branch$branch_id JCN\n" . $c_line;
			# <expr>
				$c_line .= $indent.' '."&branch$branch_id";
			}
		}
		elsif (exists $info->{'IOCall'}) {
			if (exists $info->{'PrintCall'}) {
				$c_line = _emit_expression_Uxntal($info->{'IOCall'}{'Args'}{'AST'},$stref, $f, $info);
			} else {
				say 'TODO: IOCall '.Dumper( $info->{'IOCall'}{'Args'}{'AST'})."\nIOList ".Dumper($info->{'IOList'}{'AST'});
			}
		}
		elsif (exists $info->{'If'} and not exists $info->{'IfThen'} ) {
			# croak 'TODO: If without Then'. $line."\n".Dumper($info);
			if (exists $info->{'Goto'}) {
				$c_line = ',&'.$f.'_'.$info->{'Goto'}{'Label'}.' JMP';
			} else {
				croak "If without Then, not assignment, goto or call: $line";
			}
			my $indent = $info->{'Indent'};
			my $branch_id = $info->{'LineID'};
			my $cond_expr_ast=$info->{'Cond'}{'AST'};
			my $cond_expr = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
			$c_line = "\n( If without Then )\n" . $indent.' '."$cond_expr EQU #00 ,&branch$branch_id JCN\n" . $c_line;
			$c_line .= $indent.' '."&branch$branch_id";
		}
        elsif (exists $info->{'IfThen'} and not exists $info->{'ElseIf'} ) {
            $pass_state->{'IfBranchId'} = $id;
            push @{$pass_state->{'IfStack'}},$id;
            $pass_state->{'IfId'}=$id;
			$c_line = _emit_ifthen_Uxntal($stref, $f, $info, $id);
        } elsif (exists $info->{'ElseIf'} ) {
			($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state);
			$c_line .= _emit_ifthen_Uxntal($stref, $f, $info, $branch_id);
        } elsif (exists $info->{'Else'} ) {
			($c_line, my $branch_id) = _emit_ifbranch_end_Uxntal($id,$pass_state);
            $c_line .= "&branch$branch_id";
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
				if ($do_tup->[-1] eq 'Do') {
					# croak Dumper $f,$annline,$do_tup;
					my ($do_id, $do_iter, $do_step) = @{$do_tup};
					my $inc = $do_step == 1 ? 'INC2' : toHex($do_step,2).' ADD2';
            		$c_line = "DUP2 ;$do_iter LDA2 $inc NEQ2 ".',&loop_'.$f.'_'.$do_id.' JCN';
				} else { # while
				# croak Dumper $do_tup;
					my ($do_id, $do_while_cond) = @{$do_tup};
					$c_line =  _emit_expression_Uxntal($do_while_cond,$stref, $f, $info);
					$c_line .= "\n".',&while_loop_'.$f.'_'.$do_id.' JCN';
				}
		}
		elsif ( exists $info->{'EndProgram'} ) {

            $info->{'Indent'} = '' ;
            $c_line = 'BRK' ;

		}
		elsif ( exists $info->{'EndSubroutine'} ) {
			# Here we must emit the code to put the values for Out and InOut args on the stack
			$c_line = _emit_subroutine_return_vals_Uxntal($stref,$f,$info);
            # $info->{'Indent'} = '' ;
            $c_line .= "\nJMP2r";

		}
		elsif (exists $info->{'EndSelect'} ) {
			croak 'SHOULD NOT HAPPEN!';
				#  $c_line = '    }'."\n".$info->{'Indent'}.'}';
		}

		elsif (exists $info->{'Comments'} ) {
			$c_line = '( '.$line.' )';
		}
		elsif (exists $info->{'Use'}) {
			if ($line=~/$f/) {
				$c_line = '( '.$line.' )'; $skip=1;
			} else {
			# We should parse the module, or we can simply assume that we replace it with an include with the same name
			warn "Replacing USE with #include: ".$line;
			$line=~s/^\s*use\s+//;
			$line=~s/\s*$//;
			$c_line = "( from $line )";
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
		chomp $c_line;
		push @{$pass_state->{'TranslatedCode'}},"( $line )" unless $skip;
		push @{$pass_state->{'TranslatedCode'}},$c_line unless $skip;
		# push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line unless $skip;
		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f,
	# pass state
	{
		'TranslatedCode'=>[],
		'Args'=>[],'ArgVarDecls'=>[],
		'IfStack'=>[],'IfId' =>0,'IfBranchId' =>0,
		'DoStack'=>[], 'DoIter'=>'', 'DoId' => 0,
	}
	];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_translate_to_Uxntal, $state,'pass_translate_to_Uxntal() ' . __LINE__  ) ;
# --------------------------------------------------------------------------------------------
 	$stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
 	$stref->{'TranslatedCode'}=[
		@{$stref->{'TranslatedCode'}},'',
		 @{$state->[2]{'ArgVarDecls'}},'',
		 @{$state->[2]{'TranslatedCode'}}
		 ] ;
	# # For fixing LLVM IR
	# $stref->{'SubroutineArgs'}=$state->[2]{'Args'};
	# $stref->{'SubroutineName'}=$f;
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
carp $f;
	    (my $line, my $info) = @{ $annline };
	    my $Sf = $stref->{'Subroutines'}{$f};

	    my $name = $info->{'Signature'}{'Name'};
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
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

sub _emit_var_decl_Uxntal { (my $stref,my $f,my $info,my $var)=@_;
	my $sub_or_module = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_module}{$f};
	say "_emit_var_decl_Uxntal: VAR $var in $f ";
	my $decl =  get_var_record_from_set($stref->{$sub_or_module}{$f}{'Vars'},$var);
	croak Dumper( $decl,$stref->{'Subroutines'}{'tokeniseFunktal'}{'ExGlobArgs'}{'Set'}{'funktalStringConstsIdx'}) if ($f eq 'tokeniseFunktal' and $var eq 'funktalStringConstsIdx');
	my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;

	my $const = '';
	my $val='';

	if (defined $decl->{'Parameter'}) {
		$val = $decl->{'Val'};
		my $val_str = $val;
		if ($val=~/[\'\"'](.+?)[\'\"]/) {
			$val_str = '"'.$1;
		}
		elsif ($val=~/^\d+(?:_[1248])?$/) {
			my $sz=2;
			if ($val=~s/_([1248])$//) { $sz=$1}
			$val_str = toHex($val,$sz);
		}
		elsif (exists $decl->{'AST'}) {
			my $ast = $decl->{'AST'};
			$val_str = _emit_expression_Uxntal($ast,$stref, $f, $info);
		} else {
			croak "ParsedParDecl without AST, FIXME!";
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
		# FIXME: Dim can still contain named constants
		# croak "$f ". Dumper( $decl). Dumper($stref->{$sub_or_module}{$f}{'Vars'}) if $decl->{'Name'}=~/funktalTokens/i;
		#.Dumper($stref->{$sub_or_module}{$f}{'Vars'})
		my $subset = in_nested_set( $Sf, 'Vars', $var );
		# croak "$subset $f ". Dumper( $decl) if $decl->{'Type'} eq 'real';
		# croak "$subset $f ". Dumper( $decl) if Dumper($decl->{'Dim'}) =~/funktalMaxNTokens/;
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
} # END of _emit_var_decl_Uxntal

# Emits constant strings with only a leading double quote
sub __substitute_PlaceHolders_Uxntal { my ($expr_str,$info) = @_;
	if ($expr_str=~/__PH/ and exists $info->{'PlaceHolders'}) {
		# croak $expr_str.Dumper($info->{'PlaceHolders'})
		while ($expr_str =~ /(__PH\d+__)/) {
			my $ph=$1;
			my $ph_str = $info->{'PlaceHolders'}{$ph};
			$ph_str=~s/[\'\"]$//;
			$ph_str=~s/^[\']/\"/;
			$expr_str=~s/$ph/$ph_str/;
		}
	}
	return $expr_str;
} # END of __substitute_PlaceHolders

sub _emit_assignment_Uxntal { (my $stref, my $f, my $info, my $pass_state)=@_;
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
	my $lhs = _emit_expression_Uxntal($lhs_ast,$stref,$f,$info);
	my $lhs_stripped = $lhs;
	my $indent='';
	$lhs_stripped=~/^(\s+)/ && do {
		$indent=$1;
		$lhs_stripped=~s/^\s+//;
	};
	$lhs_stripped=~s/^\(([^\(\)]+)\)/$1/;
	$lhs_stripped=$indent.$lhs_stripped;

	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};

	my $rhs = _emit_expression_Uxntal($rhs_ast,$stref,$f,$info);
	my $rhs_stripped = $rhs;
	$rhs_stripped=~s/^\(([^\(\)]+)\)$/$1/;

	for my $macro (keys %{ $Config{'Macros'} } ) {
		my $lc_macro=lc($macro);
		$rhs_stripped=~s/\b$lc_macro\b/$macro/g;
	}
	$rhs_stripped=__substitute_PlaceHolders_Uxntal($rhs_stripped,$info);

	# my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
	my $lhs_post = $lhs;
	$lhs_post =~s/LDA$/STA/;
	$lhs_post =~s/LDA2$/STA2/;
	# if ($rhs_stripped=~/\#([0-9a-f]+)/i) {
	# 	my $hexdigits=$1;
	# 	my $n_hexdigits = length($hexdigits);
	# 	if ($n_hexdigits==2) {
	# 		$lhs_post =~s/STA2/STA/;
	# 	}
	# 	elsif ($n_hexdigits!=4) {
	# 		croak "HEX OF WRONG SIZE: $rhs_stripped";
	# 	}
	# }
	# if ($lhs_post!~/STA/) { say "WRONG ASSIGN: <$rhs> <$lhs>"; } else {
	# 	say "CORRECT ASSIGN?: <$rhs_stripped> <$lhs_post>";
	# }
	my $rline = "\n" . $info->{'Indent'} . $rhs_stripped . ' '. $lhs_post;
	if (exists $info->{'If'}) {
		# croak 'TODO: If without Then', Dumper($info);
		my $branch_id = $info->{'LineID'};
		# $pass_state->{'IfBranchId'} = $id;
		# my $branch_id = $pass_state->{'IfBranchId'};
		# push @{$pass_state->{'IfStack'}},$id;
		# $pass_state->{'IfId'}=$id;
		my $cond_expr_ast=$info->{'Cond'}{'AST'};
		my $cond_expr = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
	# What we have is e.g.
	# if (fl(1:2) == __PH0__) VV = .true.
	# What we need is
	# NOT <cond> <label_end> JCN
		$rline = "\n( If without Then )\n" . $indent.' '."$cond_expr EQU #00 ,&branch$branch_id JCN\n" . $rline;
	# <expr>
		$rline .= $indent.' '."&branch$branch_id";

		# my $if_str = _emit_ifthen_Uxntal($stref,$f,$info,$branch_id);
		# $rline =$indent.' '.$rline;
		# die $rline;
	}
	# carp "$f $rline";
	return ($rline,$pass_state);
} # END of _emit_assignment_Uxntal



sub _emit_ifthen_Uxntal { (my $stref, my $f, my $info, my $branch_id)=@_;
	my $cond_expr_ast=$info->{'Cond'}{'AST'};
	my $cond_expr = _emit_expression_Uxntal($cond_expr_ast,$stref,$f,$info);
	# $cond_expr=_change_operators_to_Uxntal($cond_expr);
	# FIXME! fix for stray '+'
	# $cond_expr=~s/\+\>/>/g;
	# my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');
	my $rline = "$cond_expr ,&branch$branch_id JCN\n" .
	             ",&branch${branch_id}_end JMP\n" .
             "&branch${branch_id}";
	return $rline;
}

sub _emit_ifbranch_end_Uxntal { my ($id, $state) = @_;
	my $branch_id = $state->{'IfBranchId'};
	my $if_id = $state->{'IfId'};
	my $r_line = "&branch${branch_id}_end\n";
	$r_line .= ",&cond_end${if_id} JMP\n";
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
#                 29        30      31         32           34             35       36
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
                (my $opcode, my $name, my $args) =@{$ast};
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
							# In Uxntal, an array access is ;array $idx ADD2 LDA2 and if $idx is a scalar, I assume it's $idx LDA2, because we use shorts everywhere.
							if( $args->[0]==29 and $args->[1] eq '1') { # if we have v(1)
								return ';'.$f.'_'.$name.' LDA2';
							} else {
								my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$name);
								if ($decl->{'ArrayOrScalar'} eq 'Array') {
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
									} elsif ($ndims==0 and $decl->{'Type'} eq 'character') {
										# die "No support for strings yet\n" .
										# Dumper($info).';'.
										# Dumper($decl).';'.
										# croak Dumper($ast);
										# fl(1:2)
										my $strn=$ast->[1];
										my $cb = _emit_expression_Uxntal($ast->[2][1], $stref, $f,$info);
										my $ce = _emit_expression_Uxntal($ast->[2][2], $stref, $f,$info);
										my $id=$info->{'LineID'};
										my $len = $decl->{'Attr'};$len=~s/len=//;
										return genSubstr($strn, $cb,$ce, $len, $id);
										# I think I should have a streq function and maybe a substr function
										# we should be able to use a range-fold for this
										# <chars> ;fl <cb> <ce> streq
									} else {
										die "No support for multidimensional ($ndims) arrays yet\n" . Dumper($ast);
										# return $maybe_amp.$name.'[F'.$ndims.'D2C('.join(',',@ranges[0.. ($ndims-2)]).' , '.join(',',@lower_bounds). ' , '.join(',',@args_lst).')]';
									}
								} elsif ( $decl->{'Type'} eq 'character') {
									# Although the AST says '10', decls says it's a scalar
										my $strn=$ast->[1];
										my $cb = _emit_expression_Uxntal($ast->[2][1], $stref, $f,$info);
										my $ce = _emit_expression_Uxntal($ast->[2][2], $stref, $f,$info);
										my $id=$info->{'LineID'};
										my $len = $decl->{'Attr'};$len=~s/len=//;
										return genSubstr($strn, $cb,$ce, $len, $id);
								} else { # Although the AST says '10', decls says it's a scalar
									# croak Dumper $ast,$decl;
								}
							}
						} else { # A subroutine access.
							if ($name ne 'achar') {
								return join(' ',@args_lst).' '.$name;
							} else {
								return join(' ',@args_lst);
							}
						}
					} else { #  ')(', e.g. f(x)(y)
						die 'ERROR: f()() is not supported, sorry!'."\n";
					}
				} else {
					return 'SIGIL:'.$sigils[$opcode] ." $name";
				}
            } else { # not '&' or '@'

                (my $opcode, my $lexp, my $rexp) =@{$ast};

                my $lv = (ref($lexp) eq 'ARRAY') ? _emit_expression_Uxntal($lexp, $stref, $f,$info) : $lexp;
                my $rv = (ref($rexp) eq 'ARRAY') ? _emit_expression_Uxntal($rexp, $stref, $f,$info) : $rexp;
				if ($lv=~/^\"/) {
					$lv = "{ $lv 00 } STH2r";
				}
				if ($rv=~/^\"/) {
					$rv = "{ $rv 00 } STH2r";
				}
				if (isStrCmp($ast, $stref, $f,$info)) {
					return "$lv $rv scmp ";
				} else {
                	return "$lv $rv  ".($opcode != 27 ? $sigils[$opcode].'2' : ''); # FIXME, needs refining
				}
            }
        } elsif (scalar @{$ast}==2) { #  for '('  and '$'

            (my $opcode, my $exp) =@{$ast};

			my $sigil = $sigils[$opcode];

            if ($opcode==0 ) { # eq '('
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_Uxntal($exp, $stref, $f,$info) : $exp;
				# croak 'TODO: ( ... ) '.Dumper( $exp);
                return "[ $v ]"; # FIXME, but of course this is valid Uxntal
            } elsif ($opcode==28 ) { # eq '(/'
			croak 'TODO: (/ ... /) '.Dumper( $exp);
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_Uxntal($exp, $stref, $f,$info) : $exp;
                return "[ $v ]"; # FIXME
            } elsif ($opcode==2 or $opcode>28) {# eq '$' or constants

				$exp = __substitute_PlaceHolders_Uxntal($exp,$info) if $opcode == 34;
				if ($opcode == 35) {
					die 'ERROR: Fortran LABEL as arg is not supported, sorry!'."\n"; #  "*$exp" : $exp;   # Fortran LABEL, does not exist in C
				}
				# Handle integers, also with size notations, e.g. 11_1, 22_2
				# Transform into hex
				if ($exp=~/^\d+(?:_[1248])?$/) {
					my $sz=2;
					if ($exp=~s/_([1248])$//) { $sz=$1}
					$exp = toHex($exp,$sz);
				}
				my $mvar = $ast->[1]; # Why is this not $exp?
				my $called_sub_name = $stref->{'CalledSub'} // '';
				croak "$f <$mvar>".Dumper($ast) if $opcode==2 and not exists $stref->{'Subroutines'}{$f}{'WordSizes'}{$mvar};
				# croak "$f <$mvar>".Dumper($stref->{'Subroutines'}{$f}{'WordSizes'}) if $opcode==2 and not exists $stref->{'Subroutines'}{$f}{'WordSizes'}{$mvar};
				my $wordsz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$mvar};
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
							# function expects a value but is getting pointer
							$ptr = ''; # change to value
						} elsif ($sig_ptr eq '*' and $ptr eq '') {
							# function expects a pointer but is getting a scalar
							croak "PROBLEM: $mvar in call to $called_sub_name in $f";
							$ptr = '&'
						}
					} else {
						if ( $called_sub_name eq $f) {
							carp "FIXME: we should parse the entire assigment expr so that we know we are dealing with an assignment!";
							$ptr = '*';
						}
						# If the variable in question is 'Out' or 'InOut' we should use the pointer

					}

					if ( in_nested_set($Sf,'Parameters',$exp)) {
						# What is lacking here is a check in the container.
						# That would be
						return $f.'_'.$exp;
					}
					elsif ( (__has_module_level_declaration($stref,$f,$exp))[0] ne '') {

						croak $f.'_'.$exp.';'.Dumper( __has_module_level_declaration($stref,$f,$exp));
					} else {
						# if ($ptr eq '') {
							# return $exp;
							return ';'.$f.'_'.$exp.' LDA' . $wordsz;
						# } else {
						# 	# return '('.$ptr.$exp.')';
						# 	return ';'.$f.'_'.$exp.' LDA2';
						# }
					}
				} else { # not local variables
					if ($exp eq '.true.') {
						return '#01';
					} elsif ($exp eq '.false.') {
						return '#00';
					} else {
						my $rune = '';
						my $instr = '';
						if ($sigil eq '$') {
							$rune = ';';
							$instr = ' LDA' .$wordsz;
						}
						if ($exp =~ /^[a-zA-Z_]/) {
							my ($mod_name, $set) = __has_module_level_declaration($stref,$f,$exp) ;

							if ($mod_name) {
								# carp Dumper $stref->{'Modules'}{$mod_name}{$set};
								# my $rec = get_var_record_from_set($stref->{'Modules'}{$mod_name}{'Vars'},$exp);
								# if ($rec->{'Type'} eq 'logical') {
								# 	$instr = 'LDA'; 
								# }
								if ($set=~/par/i) {
									croak $set;
								}
								return $rune.$mod_name.'_'.$exp . ' '. $instr; #
							} else {
								# carp "<$f>, <$exp>, <$mod_name>"; carp $stref->{'Subroutines'}{$f}{$set};
								# my $rec = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$exp);
								# if ($rec->{'Type'} eq 'logical') {
								# 	$instr = 'LDA';
								# }

								return $rune.$f.'_'.$exp . ' '. $instr;#"SIGIL:$sigil ".
							}
						} else {
							return $exp;
						}
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


sub _emit_subroutine_call_expr_Uxntal { my ($stref,$f,$line,$info) = @_;
	my @call_arg_expr_strs_Uxntal=();
	# carp Dumper $info;
	my $subname = $info->{'SubroutineCall'}{'Name'};
	# croak "$f,$subname:",Dumper($info->{'SubroutineCall'}) if $line=~/^int$/;
if (exists $info->{'SubroutineCall'}{'IsExternal'}) {
	# carp "$f,$subname:",Dumper($info->{'SubroutineCall'}) ;
	if ($subname eq 'exit') {
		return 'BRK';
	}
	if (exists  $F95_intrinsic_subroutine_sigs{$subname}) {
		# croak Dumper $F95_intrinsic_subroutine_sigs{$subname};
		return __emit_intrinsic_subroutine_call_expr_Uxntal($stref,$f,$line,$info);
	}

}
	my $Ssubname = $stref->{'Subroutines'}{$subname};

	# my $mvar = $subname;
	# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
	# The (float) cast is necessary because otherwise I get an "ambiguous" error
	# $mvar=~s/^(abs|min|max)$/(float)f$1/;
	# $mvar=~s/^am(ax|in)1$/(float)fm$1/;
	# $mvar=~s/^alog$/(float)log/;
	# my $subname_C = $mvar;
# What we need for every argument is IODir , ArrayOrScalar from the record
# So we'd better loop over the List in the record.
	#  "inout" args will occur in both places if required.
	my @in_args=();
	my @out_args=();
	my $idx=0;
	for my $sig_arg (@{$Ssubname->{'RefactoredArgs'}{'List'}}) {
		$idx++;
		my $rec = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg};
		my $call_arg_expr_str = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} // $sig_arg;
		# say Dumper $info->{'SubroutineCall'};
		# say "$subname: $sig_arg => ";say $call_arg_expr_str;
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
		$wordSz==1 && do {$wordSz=''};
		# say $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'};
		my $isConstOrExpr = exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str} ?
		(($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' ) or ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr')) : 0;

		if ($intent eq 'in' or $intent eq 'inout') {
			if ($isArray) {
				push @call_arg_expr_strs_Uxntal, ';'.$f.'_'.$call_arg_expr_str;
			}
			elsif (not $isConstOrExpr) { # must be a scalar variable
				push @call_arg_expr_strs_Uxntal, ';'.$f.'_'.$call_arg_expr_str.' STA'.$wordSz;
			}
			else {
				my $arg_expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'}[0] == 27 ? $info->{'SubroutineCall'}{'ExpressionAST'}[$idx] : $info->{'SubroutineCall'}{'ExpressionAST'};
				push @call_arg_expr_strs_Uxntal, _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);
			}
		}
	}
	push @call_arg_expr_strs_Uxntal, $subname;
	$idx=0;
	for my $sig_arg (reverse @{$Ssubname->{'RefactoredArgs'}{'List'}}) {
		$idx++;
		my $rec = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg};
		my $call_arg_expr_str = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} // $sig_arg;
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
		$wordSz==1 && do {$wordSz=''};
		# say $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'};
		my $isConstOrExpr = exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str} ?
		(($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' ) or ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr')) : 0;
		if ($intent eq 'out' or $intent eq 'inout') {
			if (not $isArray and not $isConstOrExpr) {
				my $arg_expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'}[0] == 27 ? $info->{'SubroutineCall'}{'ExpressionAST'}[$idx] : $info->{'SubroutineCall'}{'ExpressionAST'};
				# say _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);
				push @call_arg_expr_strs_Uxntal, ';'.$f.'_'.$call_arg_expr_str.' STA'.$wordSz;
			}
		}
	}

	return join("\n", @call_arg_expr_strs_Uxntal);

} # END of _emit_subroutine_call_expr_Uxntal


sub __emit_intrinsic_subroutine_call_expr_Uxntal { my ($stref,$f,$line,$info) = @_;
	my $subname = $info->{'SubroutineCall'}{'Name'};
	# my @arg_decls=();
	# for my $arg_decl_str (@{ $F95_intrinsic_subroutine_sigs{$subname} }) {
	# 	push @arg_decls, parse_F95_var_decl($arg_decl_str);
	# 	# carp Dumper $arg_decl;
	# }
	# for my $call_arg_str (@{ $info->{'SubroutineCall'}{'Args'}{'List'} }) {
	# }
	my $ast = $info->{'SubroutineCall'}{'ExpressionAST'};
	# carp Dumper $ast;
	my $tal_str = _emit_expression_Uxntal($ast, $stref, $f, $info);
	return "$tal_str $subname";
} # END of __emit_intrinsic_subroutine_call_expr_Uxntal

sub _emit_subroutine_return_vals_Uxntal { my ($stref,$f,$info) = @_;
	my @sub_retvals_Uxntal=();
	# my $subname = $info->{'SubroutineCall'}{'Name'};
	my $Ssubname = $stref->{'Subroutines'}{$f};

	my $idx=0;

	for my $sig_arg (@{$Ssubname->{'RefactoredArgs'}{'List'}}) {
		$idx++;
		my $rec = $Ssubname->{'RefactoredArgs'}{'Set'}{$sig_arg};
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
		$wordSz==1 && do {$wordSz=''};

		if ($intent eq 'out' or $intent eq 'inout') {
			if (not $isArray ) {
				push @sub_retvals_Uxntal, ';'.$f.'_'.$sig_arg.' LDA'.$wordSz;
			}
		}
	}

	return join("\n", @sub_retvals_Uxntal);
} # END of _emit_subroutine_return_vals_Uxntal

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
        croak "TYPE for $ftype is not supported\n" if $W;
    }
}    # END of toUxntalType()

sub toHex { my ($n,$sz) = @_;
	my $szx2 = $sz*2;
	return sprintf("#%0${szx2}x",$n);
}
sub toRawHex { my ($n,$sz) = @_;
	my $szx2 = $sz*2;
	return sprintf("%0${szx2}x",$n);
}


sub genSubstr { my ($strn, $cb,$ce, $len,$id) = @_;
	if ($cb eq $ce) {
		return $cb . ' #0001 SUB2 ;'.$strn.' ADD2 LDA'
	} else {
		my $cbb = $cb; $cbb=~s/^\#00//;$cbb='#'.$cbb;
		my $ceb = $ce; $ceb=~s/^\#00//;$ceb='#'.$ceb;
		return
		'{ DUP #00 SWP ;'.$strn.' ADD2 LDA' . "\n" .
		'  SWP #00 SWP '.$cb.' SUB2' . "\n" .
		'  ;substr_'.$id.' ADD2 STA'  . "\n" .
		'  JMP2r'  . "\n" .
		'} STH2r '.$ceb.' '.$cbb.' range-map'  . "\n" .
		'{ @substr_'.$id.' $'.toRawHex($len+1,1).' } STH2r';
	}
}

sub isStrCmp { my ($ast, $stref, $f,$info) =@_;
	my $lhs_name = $ast->[1][0] == 10 ? $ast->[1][1] : '';
	my $rhs_name = $ast->[2][0] == 10 ? $ast->[2][1] : '';
	my $lhs_is_str = $ast->[1][0] == 34 ? 1 : 0;
	my $rhs_is_str = $ast->[2][0] == 34 ? 1 : 0;
	if (not $lhs_is_str) {
		if ($lhs_name ne '') {
			my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$lhs_name);
			if ($decl->{'Type'} eq 'character') {
				$lhs_is_str=1;
			}
		}
	}
	if (not $rhs_is_str) {
		if ($rhs_name ne '') {
			my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$rhs_name);
			if ($decl->{'Type'} eq 'character') {
				$rhs_is_str=1;
			}
		}
	}
	return $lhs_is_str * $rhs_is_str;
}
# @scmp ( a* b* -- f )
# 	STH2
# 	&l ( a* b* -- f )
# 		LDAk LDAkr STHr NEQk ?&d
# 		DUP EOR EQUk ?&d
# 		POP2 INC2 INC2r !&l
# 	&d ( a* c1 c2 b* -- f )
# 		NIP2 POP2r EQU JMP2r

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
carp Dumper $dims;
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
