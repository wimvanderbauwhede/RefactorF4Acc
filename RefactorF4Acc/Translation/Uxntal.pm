package RefactorF4Acc::Translation::Uxntal;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( max );
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
#                29         30      31         32           33         34             35       36
               ,'integer', 'real', 'logical', 'character', 'complex', 'PlaceHolder', 'Label', 'BLANK'
              );

# TODO This needs to be changed so that only the used functions are emitted
my $lib_lines = [
	'( TODO LIBRARIES )',
	'~../../../uxntal-libs/fmt-print.tal',
	'( now obsolete )',
	'@print-list',
    'ROT ROT SWP',
    '#30 ADD #18 DEO',
	'#30 ADD #18 DEO',
    '#20 #18 DEO',
    '#18 DEO',
    '#0a #18 DEO',
    'JMP2r',

'@print-char #18 DEO JMP2r',
'@print-char-stderr #19 DEO JMP2r',

'( a bool is a byte; prints `t` or `f` )
@print-bool
DUP ,&true JCN
#66 #18 DEO JMP2r
&true
#74 #18 DEO JMP2r
',
'( a bool is a byte; prints `t` or `f` )
@print-bool-stderr
DUP ,&true JCN
#66 #19 DEO JMP2r
&true
#74 #19 DEO JMP2r
',

'( this assumes 2-byte integers )
( @print-int #18 write-int
@print-int-stderr #19 !write-int )

@write-int ( w* unit -- )
STH
DUP2
DUP2 #2710  LTH2 ,&d2 JCN
#2710 DIV2 DUP #30 ADD STHrk DEO
#2710 MUL2 SUB2
DUP2
&d2
DUP2 #03e8  LTH2 ,&d3 JCN
#03e8 DIV2 DUP #30 ADD STHrk DEO
#03e8 MUL2 SUB2
DUP2
&d3
DUP2 #0064  LTH2 ,&d4 JCN
#0064 DIV2 DUP #30 ADD STHrk DEO
#0064 MUL2 SUB2
DUP2
&d4
#000a DIV2 DUP #30 ADD STHrk DEO
#000a MUL2 SUB2 #30 ADD STHrk DEO POP
JMP2r
',

# '( this assumes a string with structure `{ 0006 "hello 0a } STH2r` )
# @print-string ( {str}* -- ) #18 !write-string
# @print-string-stderr ( {str}* -- ) #19 !write-string

# @write-string ( {str}* unit -- )
# 	STH
#     DUP2 LDA2 ( str len )
#     SWP2 ( len str )
#     INC2 INC2 DUP2  ( len str+2 str+2 )
#     ROT2 ADD2 SWP2 ( str+2+len str+2 )
#     &l ( -- )
#     LDAk STHrk DEO
#         INC2 GTH2k ?&l
#         POP2 POP2 
# 	POPr
# JMP2r
# ',

# '@len LDA2 JMP2r'


];

sub translate_program_to_Uxntal {  (my $stref, my $program_name) = @_;

	$stref->{'Uxntal'} = {
		'Macros' => { 'Set' =>{}, 'List' => [] },
		'CLIHandling' => ['( TODO CLI HANDLING )'],
		'Main' => {'TranslatedCode'=>[],'Name'=>''},
		'Libraries' => { 'Set' =>{}, 'List' => $lib_lines },
		'Subroutines' => {},
		# { 'LocalVars'=> {'Set' =>{}, 'List' => [] }, 'Args' => {'Set' =>{}, 'List' => [] },  'isMain' => '' , 'TranslatedCode'}
		'Globals' => { 'Set' =>{}, 'List' => [] },
	};

	$stref = fold_constants_all($stref) ;

	my $new_annlines = $stref->{'Subroutines'}{$program_name}{'RefactoredCode'};
	$stref->{'TranslatedCode'}=[];
	$Config{'FIXES'}={
		# _declare_undeclared_variables => 1,
		# _remove_unused_variables => 1
	};
	$stref = pass_wrapper_subs_in_module($stref,$program_name,
	   # module-specific passes.
       [
			# [\&translate_module_decls_to_Uxntal]
       ],
       # subroutine-specific passes
	   [
		  [
			  \&replace_case_by_if
		  ],
		  [\&translate_sub_to_Uxntal]
       ]
       );
	   $stref->{'TranslatedCode'}=[
		@{$stref->{'Uxntal'}{'Macros'}{'List'}},
		@{$stref->{'Uxntal'}{'CLIHandling'}},

		'','|0100',
		$stref->{'Uxntal'}{'Main'}{'Name'},
		'BRK','',

		@{$stref->{'Uxntal'}{'Main'}{'TranslatedCode'}},
		@{$stref->{'Uxntal'}{'Libraries'}{'List'}},
		@{$stref->{'TranslatedCode'}}, # These are the subroutines
		@{$stref->{'Uxntal'}{'Globals'}{'List'}},
	   ];
	#    carp "TODO: Global decls";
	# This prints out the lines from $stref->{'TranslatedCode'}
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
		# say "MOD LINE: <$line>";
        my $c_line=$line;
        (my $stref, my $mod_name, my $pass_state)=@{$state};
        my $skip=1;

        if (exists $info->{'VarDecl'}) {
                my $var = $info->{'VarDecl'}{'Name'};
				$c_line = _emit_var_decl_Uxntal( $stref, $mod_name, $info, $var);
				$skip=0;
        }
		elsif ( exists $info->{'ParamDecl'} ) {
			croak "SHOULD NOT HAPPEN ParamDecl", Dumper($info);;
			my $var = $info->{'VarDecl'}{'Name'};
		}
		elsif ( exists $info->{'ParsedVarDecl'} ) {
			croak "SHOULD NOT HAPPEN ParsedVarDecl", Dumper($info);

		}
		elsif ( exists $info->{'ParsedParDecl'} ) {
			croak "SHOULD NOT HAPPEN ParsedParDecl", Dumper($info);
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
		if ($subset eq '') {
			croak "$f $var";
		}
		my $decl = get_var_record_from_set($Sf->{$subset},$var);

		my $wordsz=0;
		my $type = $decl->{'Type'};
		if ($type eq 'integer') {
			# carp Dumper $decl;
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
				if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '' and $decl->{'Attr'}!~/len=1/) {
					# It's a string, not a character, so we store the address, not the value.
					# croak('WRONG! Need to disambiguate between the pointer and the value!');
					$wordsz=2;
				} else {
					$wordsz=1;
				}
		} else {
			die "Supported types are integer, character and logical: $var in $f is $type\n";
		}
		$Sf->{'WordSizes'}{$var} = $wordsz;
		# carp Dumper($decl) if $var eq 'funktalGlobalCharArray';
		if (exists $decl->{'ModuleName'}) {
			$stref->{'Modules'}{$decl->{'ModuleName'}}{'WordSizes'}{$var} = $wordsz;
		}
	}

	my $annlines = get_annotated_sourcelines( $stref, $f );

	# This analysis only looks at args, local vars and local parameters. We need to include globals
	# Or maybe not, as pointer analysis is not necessary for Uxntal.
	# We populate $state->{'Pointers'} and $state->{'WordSizes'} but the latter is not used as
	# $Sf->{'WordSizes'} is populated above;
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
			} elsif ($type eq 'logical') {
				$wordsz=1;
			} elsif ($type eq 'character') {
				$wordsz=1;
			} else {
				die "Supported types are integer, character and logical: $var in $f is $type\n";
			}
			$state->{'WordSizes'}{$var}=$wordsz;
		}
		# FIXME: this is because of the presence of an empty $info->{'SubroutineCall'} record.
		elsif (exists $info->{'SubroutineCall'} and exists $info->{'SubroutineCall'}{'Name'}) {
			my $fname =  $info->{'SubroutineCall'}{'Name'};
			if (not exists $F95_intrinsic_functions{$fname} ) {
				for my $call_arg_expr_str (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
					my $call_arg = ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Scalar'
					or $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const'
					or $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr'
					) ? $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Expr'}
					: $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Arg'};

					if (exists $state->{'LocalVars'}{$call_arg}) {
						$state->{'Pointers'}{$call_arg}='*';
					}
					elsif (exists $state->{'Parameters'}{$call_arg}) {
						$state->{'Pointers'}{$call_arg}='&';
						# carp 'TODO: a const scalar passed as arg: ',$call_arg_expr_str ;
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

	my $pass_state = {'Pointers'=>{},'Args' =>{},'LocalVars' =>{}, 'Parameters'=>{}, 'WordSizes'=>{}};
	(my $new_annlines_,$pass_state) = stateful_pass($annlines,$pass_pointer_analysis,$pass_state,"pass_pointer_analysis($f)");
	$Sf->{'Pointers'} = $pass_state->{'Pointers'};

# --------------------------------------------------------------------------------------------
	my $pass_translate_to_Uxntal = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $c_line="( TODO $line )";
		(my $stref, my $f, my $pass_state)=@{$state};
        my $id = $info->{'LineID'};
		my $skip=0;
		my $skip_comment=0;
		if (exists $info->{'Signature'} ) {
			# subroutine f(x) becomes @f ;x LDA{sz} if x is read
			# but if x is write, then we have
			# @f ... ;x STA{sz} JMP2r
			# So what we need is to create a Set $arg => [$wordz, $iodir]
			# and a List of $arg
			# Or maybe {ReadArgs} and {WriteArgs} with the actual code
			$pass_state->{'Args'}=$info->{'Signature'}{'Args'}{'List'};
			my ($sig_line,$arg_decls, $args_to_store,$write_args,$isMain) = _emit_subroutine_sig_Uxntal( $stref, $f, $annline);
			$pass_state->{'Subroutine'}{'ArgDecls'}=$arg_decls;
			$pass_state->{'Subroutine'}{'Sig'}=[
				"( ____ $line )",
				$sig_line
				];
			$pass_state->{'Subroutine'}{'ReadArgs'}=$args_to_store;
			$skip=1;$skip_comment=1;
			$pass_state->{'Subroutine'}{'WriteArgs'}=$write_args;
			if ($isMain) {
				$pass_state->{'Subroutine'}{'IsMain'}=$f;
			}
		}
		elsif (exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'};
			if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}) {
				$c_line='( '.$line.' )';
				# croak 'WHY?'.$line;
			} else {
				($stref,my $uxntal_var_decl) =  _emit_var_decl_Uxntal($stref,$f,$info,$var);
				if (not exists $pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_var_decl}) {
					$pass_state->{'Subroutine'}{'LocalVars'}{'Set'}{$uxntal_var_decl}=$uxntal_var_decl;
					$skip_comment=1;
					push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}}, "( ____ $line )" unless $skip_comment;
					push @{$pass_state->{'Subroutine'}{'LocalVars'}{'List'}},$uxntal_var_decl;
				} else {
					croak "Vars should be unique: $uxntal_var_decl";
				}
			}
			$skip=1;
		}
		elsif ( exists $info->{'ParamDecl'} ) {
			# A parameter should become a macro
			my $var = $info->{'ParamDecl'}{'Var'};
			($stref,my $uxntal_par) = _emit_var_decl_Uxntal($stref,$f,$info,$var);
			if (not exists $stref->{'Uxntal'}{'Macros'}{'Set'}{$uxntal_par}) {
				$stref->{'Uxntal'}{'Macros'}{'Set'}{$uxntal_par}=$uxntal_par;
				push @{$stref->{'Uxntal'}{'Macros'}{'List'}},$uxntal_par;
			} else {
				croak "Macros should be unique: $uxntal_par";
			}
			$skip=1;
		}
		# For Uxntal, we need to turn the Case into an IfThen
		elsif (exists $info->{'Select'} ) {
			croak 'SHOULD NOT HAPPEN!';
		}
		elsif (exists $info->{'Case'} ) {
			croak 'SHOULD NOT HAPPEN!';
		}
		elsif (exists $info->{'CaseDefault'}) {
			croak 'SHOULD NOT HAPPEN!';
			# $c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.'default : {';
		}
		elsif (exists $info->{'Do'} ) {
			if (exists $info->{'Do'}{'While'}) {
				# say 'TODO: Do While: '.Dumper($info->{'Do'}{'ExpressionsAST'});
				push @{$pass_state->{'DoStack'}}, [$id,$info->{'Do'}{'ExpressionsAST'},'While'];
				$c_line = '&while_loop_'.$f.'_'.$id . "\n" ;
			} else {
			my $do_iterator = $f.'_'.$info->{'Do'}{'Iterator'};
			my $do_step = $info->{'Do'}{'Range'}{'Expressions'}[2];
				if ($do_step!~/^\-?\d+$/) {
					error("Only DO with constant integer STEP is supported: $line in $f",0,'ERROR');
				}
				push @{$pass_state->{'DoStack'}}, [
					$id,$do_iterator,$do_step,'Do'];
				my $do_start= _emit_expression_Uxntal($info->{'Do'}{'Range'}{'ExpressionASTs'}[0],$stref, $f, $info);
				my $do_stop =  _emit_expression_Uxntal($info->{'Do'}{'Range'}{'ExpressionASTs'}[1],$stref, $f, $info);
				$c_line = $do_stop . ' INC2 ' . $do_start . "\n" .
				'&loop_'.$f.'_'.$id . "\n" .
				';'.$do_iterator.' STA2 ';
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
				# say "PRINT: $line";
				$c_line = __emit_list_based_print_write($stref,$f,$line,$info, '*','yes');
				# say "UXNTAL: $c_line";
			} elsif (exists $info->{'WriteCall'}) {
				my $call_ast = $info->{'IOCall'}{'Args'}{'AST'};
				my $iolist_ast = $info->{'IOList'}{'AST'};
				# say 'WRITE: IOCall Args:'.Dumper($call_ast),'IOList:',Dumper($iolist_ast);
				# say "WRITE: $line";
				my ($print_calls, $offsets, $unit, $advance) = _analyse_write_call($stref,$f,$info);
				if (scalar @{$print_calls} == 1 and
					(
						$print_calls->[0] eq 'print-list' or
						$print_calls->[0] eq 'print-list-stderr'
					)
				) {
					$c_line = __emit_list_based_print_write($stref,$f,$line,$info, $unit,$advance);
					# say "UXNTAL SINGLE WRITE: $c_line";
				} else {
					# if ($unit eq 'STDOUT' or $unit eq 'STDERR') {
						$c_line = '';
						my $maybe_str = ($unit eq 'STDOUT' or $unit eq 'STDERR')? '' : 
						_emit_expression_Uxntal([32,$unit],$stref, $f, $info);
						# ";$unit ";
						my $idx=1;
						for my $print_call (@{$print_calls}) {
							my $maybe_offset= $maybe_str ne '' 
								? $offsets->[$idx-1] == 0
									? '' 
									: toHex( $offsets->[$idx-1],2).' ADD2 ' 
								: '';
							my $arg_ast = [];
							if ($iolist_ast->[0] == 27) {
								# warn "$line: $print_call: ".Dumper($iolist_ast->[$idx++]);
								$arg_ast = $iolist_ast->[$idx++];
							} else {
								# warn "$line: $print_call: ".Dumper($iolist_ast);
								$arg_ast = $iolist_ast;
							}
							my $arg_exp_Uxntal = _emit_expression_Uxntal($arg_ast,$stref, $f, $info);
							if ($arg_exp_Uxntal=~/\#\d+/ and $print_call=~/string/) {
								$print_call=~s/string/char/;
							}
							$c_line.= $arg_exp_Uxntal.' '.$maybe_str.$maybe_offset.$print_call." ";
						}
						# say "UXNTAL: $c_line";
					# } else {
					# 	carp 'TODO STRING:'.Dumper($unit, $advance, $print_calls, $iolist_ast);
					# }
				}
			} else {
				croak 'TODO: IOCall '.Dumper( $info->{'IOCall'}{'Args'}{'AST'})."\nIOList ".Dumper($info->{'IOList'}{'AST'});

			}
		}
		elsif (exists $info->{'If'} and not exists $info->{'IfThen'} ) {
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
		elsif (
				exists $info->{'EndDo'}
			) {
				my $do_tup = pop @{$pass_state->{'DoStack'}};
				if ($do_tup->[-1] eq 'Do') {
					# croak Dumper $f,$annline,$do_tup;
					my ($do_id, $do_iter, $do_step) = @{$do_tup};
					my $inc = $do_step == 1 ? 'INC2' : toHex($do_step,2). ($do_step>0 ? ' ADD2' : ' SUB2');
            		# $c_line = "DUP2 INC2 ;$do_iter LDA2 $inc DUP2 ROT2 ROT2 NEQ2 ".',&loop_'.$f.'_'.$do_id.' JCN';
					$c_line = ";$do_iter LDA2 $inc OVR2 OVR2 NEQ2 ".',&loop_'.$f.'_'.$do_id.' JCN';
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
			# WV 20240126: or not? A subroutine has not return values, right. And any `OUT`s should have been written to elsewhere.
			# $c_line = _emit_subroutine_return_vals_Uxntal($stref,$f,$info);
            # $info->{'Indent'} = '' ;
            $c_line = "JMP2r";

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
				$c_line = '( '.$line.' )'; $skip=1;$skip_comment=1;
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
		$skip_comment=1;
		push @{$pass_state->{'Subroutine'}{'TranslatedCode'}},"( ____ $line )" unless $skip_comment or $line=~/^\s*$/;
		push @{$pass_state->{'Subroutine'}{'TranslatedCode'}},$c_line unless $skip;
		# push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line	 unless $skip;
		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f,

	# pass state
	# for subroutine, we need the args, local vars and the actual body
	# That then goes into $stref->{'Uxntal'}{'Subroutines'}{$f}
	{
		'Args' => {'Set' =>{}, 'List' => [] },
		'Subroutine' => {
			'WriteArgs' => {}, # This should probably replace Pointers
			'IsMain' => '',
			'TranslatedCode'=>[],
			'ArgDecls'=>[],
			'LocalVars'=> {'Set' =>{}, 'List' => [] },
			# 'LocalVarDecls' =>[],
			'ReadArgs' => [],
			'Sig' => '',
		},
		'IfStack'=>[],'IfId' =>0,'IfBranchId' =>0,
		'DoStack'=>[], 'DoIter'=>'', 'DoId' => 0,
	}
	];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_translate_to_Uxntal, $state,'pass_translate_to_Uxntal() ' . __LINE__  ) ;
# --------------------------------------------------------------------------------------------
	my $sub_uxntal_code = $state->[2]{'Subroutine'};
	# $stref->{'Uxntal'}{'Subroutines'}{$f}=$sub_uxntal_code;
 	# $stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
 	my @translated_sub_code=(
		# @{$stref->{'TranslatedCode'}},'',
		@{$sub_uxntal_code->{'ArgDecls'}},
		@{$sub_uxntal_code->{'LocalVars'}{'List'}},
		@{$sub_uxntal_code->{'Sig'}},
		@{$sub_uxntal_code->{'ReadArgs'}},
		@{$sub_uxntal_code->{'TranslatedCode'}},
		# @{$stref->{'TranslatedCode'}},'',
		#  @{$state->[2]{'ArgVarDecls'}},'',
		#  @{$state->[2]{'TranslatedCode'}}
	 ) ;
	# $stref->{'Uxntal'}{'Subroutines'}{$f}{'TranslatedCode'}=$stref->{'TranslatedCode'};

	if ( $sub_uxntal_code->{'IsMain'} ne '') {
		$stref->{'Uxntal'}{'Main'}{'Name'} = $sub_uxntal_code->{'IsMain'};
		$stref->{'Uxntal'}{'Main'}{'TranslatedCode'} = [@translated_sub_code];
		delete $stref->{'Uxntal'}{'Subroutines'}{$f};
	} else {
		$stref->{'TranslatedCode'}=[
				@{$stref->{'TranslatedCode'}},'',"( ==== $f ==== )",'', @translated_sub_code
		];
	}
 	return $stref;

} # END of translate_sub_to_Uxntal()


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

 	open my $OUT, '>', "$targetdir/$csrc.$ext";
 	map {say $OUT $_ } @{$stref->{'TranslatedCode'}};
 	close $OUT;
	return $stref;
} # END of _emit_Uxntal_code

sub _emit_subroutine_sig_Uxntal { (my $stref, my $f, my $annline)=@_;
	    (my $line, my $info) = @{ $annline };
	    my $Sf = $stref->{'Subroutines'}{$f};

	    my $name = $info->{'Signature'}{'Name'};
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
		my $uxntal_arg_decls=[];
		my $uxntal_args_to_store=[];
		my $uxntal_write_args={};
		for my $arg (@{ $args_ref }) {
			($stref,my $uxntal_arg_decl, my $uxntal_arg_store, my $uxntal_write_arg) = _emit_arg_decl_Uxntal($stref,$f,$arg,$name);
			if ($uxntal_write_arg) {
				$uxntal_write_args->{$arg}=[$arg,$name];
			}
			unshift @{$uxntal_arg_decls},$uxntal_arg_decl;
			unshift @{$uxntal_args_to_store},$uxntal_arg_store;
		}

	    # my $args_str = join( ' ', @{$uxntal_arg_decls} );
		my $rline = '@'.$name;
		my $isMain = 0;
		if (exists $stref->{'Subroutines'}{$f}{'Program'} and $stref->{'Subroutines'}{$f}{'Program'}==1
		) {
			$isMain = 1;
			# $rline = '|0100';
		}
		return  ($rline,$uxntal_arg_decls, $uxntal_args_to_store, $uxntal_write_args,$isMain);
} # END of _emit_subroutine_sig_Uxntal

sub _emit_arg_decl_Uxntal { (my $stref,my $f,my $arg, my $name)=@_;

	# my $decl_for_iodir =	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg) ;
	my $iodir = $decl->{'IODir'};
	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	my $isArray = $decl->{'ArrayOrScalar'} eq 'Array';
	my $isString = ($decl->{'Type'} eq 'character' and (exists $decl->{'Attr'} and ($decl->{'Attr'} !~/len\s*=\s*1/)));
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=2};
	# my $uxntal_size = toUxntalType($ftype,$fkind);
	my $word_sz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$arg};
	# croak "$f $arg: $word_sz != $uxntal_size" if $word_sz != $uxntal_size;
	my $uxntal_arg_decl = '@'.$name.'_'.$arg.' $'.__nBytes($word_sz, $isArray, $isString);
	my $uxntal_arg_store = ';'.$name.'_'.$arg.' STA'.(__nBytes($word_sz, $isArray, $isString)==1?'':'2');
	my $uxntal_write_arg = $iodir eq 'out' or $iodir eq 'inout' ? 1 : 0 ;
	return ($stref,$uxntal_arg_decl,$uxntal_arg_store, $uxntal_write_arg);
}
sub __nBytes { my ($wordSz, $isArray, $isString) = @_;
# If the arg is an array, 2 bytes
# If the arg is a scalar, wordSz
# If the arg is a string, 2 bytes
if ($isArray or $isString) {
	return 2;
} else {
	return $wordSz;
}

}

sub _emit_var_decl_Uxntal { (my $stref,my $f,my $info,my $var)=@_;
	my $sub_or_module = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_module}{$f};
	# say "_emit_var_decl_Uxntal: VAR $var in $f ";
	my $decl =  get_var_record_from_set($stref->{$sub_or_module}{$f}{'Vars'},$var);

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
		# croak "$subset $f ". Dumper( $decl) if $var eq 'funktalGlobalCharArray';
		my $dim= $array  ? __C_array_size($decl->{'Dim'}) : 1;
		my $ftype = $decl->{'Type'};
		my $strlen=0;
		if ($ftype eq 'character') {
			if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '') {
				$strlen = $decl->{'Attr'};
				$strlen=~s/len=//;
				$strlen=~s/^\(//;
				$strlen=~s/\)$//;
				# croak $decl->{'Attr'}.$strlen;
				$dim *= $strlen;
			}
		}
		my $fkind = $decl->{'Attr'};
		if (ref($ftype) eq 'HASH') {
			if (exists $ftype->{'Kind'}) {
				$fkind = $ftype->{'Kind'};
			}
			$ftype = $ftype->{'Type'};
		}
		$fkind=~s/\(kind=//;
		$fkind=~s/\)//;
		if ($fkind eq '') {$fkind=4};

		my $sz = $Sf->{'WordSizes'}{$var}; # This breaks because we did not populate this for modules!
		if (not defined $sz) {
			croak "$f $var ".Dumper($decl);
		}
		# toUxntalType($ftype,$fkind)*$dim;
		if (($ftype eq 'character') and ($strlen >1)) {
			my $len = toRawHex($strlen,2);
			my $padding = $len;
			$padding =~s/^0+//;
			my $c_var_decl = '@'.$f.'_'.$var.' '.$len.' $'. $padding;
			return ($stref,$c_var_decl);
		} else {
			my $padding = toRawHex($sz*$dim,2);
			$padding =~s/^0+//;
			my $c_var_decl = '@'.$f.'_'.$var.' $'. $padding;
			return ($stref,$c_var_decl);
		}
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
		my $len = toRawHex(length($expr_str)-1,2);
		if ($len==1) {
			$expr_str = toHex(ord(substr($expr_str,0,1)),1);
		} else {
			$expr_str = "{ $len $expr_str } STH2r";
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

	# for my $macro (keys %{ $Config{'Macros'} } ) {
	# 	my $lc_macro=lc($macro);
	# 	$rhs_stripped=~s/\b$lc_macro\b/$macro/g;
	# }
	$rhs_stripped=__substitute_PlaceHolders_Uxntal($rhs_stripped,$info);

	# my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
	my $lhs_post = $lhs;
	$lhs_post =~s/LDA\s*$/STA /;
	$lhs_post =~s/LDA2\s*$/STA2 /;
	if ($lhs_post !~/STA/) {
		$lhs_post .= ' STA2 ( must be string! ) ';
	}

	my $rline = $info->{'Indent'} . $rhs_stripped . ' ( = ) '. $lhs_post;
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
        if (scalar @{$ast}==3) { # e.g. ['@','v',['$','i']]
			# Uxn does not have pow or mod so these would have to be functions
			if ($ast->[0] == 8) { # eq '^'
				(my $op, my $arg1, my $arg2) = @{$ast};
				$ast = [1,'pow',[27,$arg1,$arg2] ] ;
			}
			elsif ($ast->[0] == 7) { # eq '%'
				(my $op, my $arg1, my $arg2) = @{$ast};
				$ast = [1,'mod',[27,$arg1,$arg2] ] ;
			}
            if ($ast->[0] == 1 or $ast->[0] ==10) { #  array access 10=='@' or function call 1=='&'
                (my $opcode, my $name, my $args) =@{$ast};
				if ($ast->[0] == 1 and $ast->[1] eq 'int') {
					# [1,'int',['(', $arg, $sz]]
					my $uxn_ast = $ast->[2][1];
					return _emit_expression_Uxntal($uxn_ast, $stref, $f,$info);
				}
				elsif ($ast->[0] == 1 and $ast->[1] eq 'print') {
					# [1,'print','*', $arg]
					my $uxn_ast = [1,'print',$ast->[2][2]];
					return _emit_expression_Uxntal($uxn_ast, $stref, $f,$info);
				}

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

						if ($ast->[0]==10) { # An array access; but also a string access?
							# In Uxntal, an array access is ;array $idx ADD2 LDA2 and if $idx is a scalar, I assume it's $idx LDA2, because we use shorts everywhere.
							my $var_name = $ast->[1];
							my $wordsz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$var_name};
							my $qual_vname = $f .'_' . $var_name;
							my $subset='';
							my $is_arg = in_nested_set($Sf,'DeclaredOrigArgs',$var_name) eq 'DeclaredOrigArgs' ? 1 : 0;
							if (not $is_arg) { # could be a module global
								my $decl = get_var_record_from_set($Sf->{'ModuleVars'},$var_name);
								# carp "VAR: $var_name ".Dumper($decl) if $var_name eq 'funktalGlobalString';
								if (defined $decl) {
									my $mod_name ='';
									if (exists $decl->{'ModuleName'}) {
										$mod_name = $decl->{'ModuleName'};
									}
									if ($mod_name ne '') {
										$qual_vname = $mod_name.'_'.$var_name;
										if (not exists $stref->{'Uxntal'}{'Globals'}{'Set'}{$qual_vname}) {
											$stref->{'Uxntal'}{'Globals'}{'Set'}{$qual_vname} = 1;
											($stref, my $global_var_decl)= _emit_var_decl_Uxntal($stref,$mod_name,$info,$var_name);
											push @{$stref->{'Uxntal'}{'Globals'}{'List'}},$global_var_decl ;
										}
									}
								}
							}
							if( $args->[0]==29 and $args->[1] eq '1') { # if we have v(1)
								return ';'.$qual_vname.($is_arg? ' LDA2': '').' LDA'.($wordsz==1?'':'2');
							} else {
								my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$name);
								if ($decl->{'ArrayOrScalar'} eq 'Array') {
									my $dims =  $decl->{'Dim'};
									# my $maybe_amp = $has_slices ? '&' : '';
									my $ndims = scalar @{$dims};

									# my @ranges=();
									# my @lower_bounds=();
									# for my $boundspair (@{$dims}) {
									# 	(my $lb, my $hb)=@{$boundspair };
									# 	push @ranges, "(($hb - $lb )+1)";
									# 	push @lower_bounds, $lb;
									# }
									if ($ndims==1) { # access to a 1-D array, v(i)
										return ';'.$qual_vname.($is_arg? ' LDA2': '').' '.$args_lst[0].' ADD2 LDA'.($wordsz==1?'':'2');
									} elsif ($ndims==0 and $decl->{'Type'} eq 'character') {
										my $cb = _emit_expression_Uxntal($ast->[2][1], $stref, $f,$info);
										my $ce = _emit_expression_Uxntal($ast->[2][2], $stref, $f,$info);
										my $id=$info->{'LineID'};
										my $len = $decl->{'Attr'};$len=~s/len=//;
										return genSubstr($qual_vname.($is_arg? ' LDA2': ''), $cb,$ce, $len, $id);
										# I think I should have a streq function and maybe a substr function
										# we should be able to use a range-fold for this
										# <chars> ;fl <cb> <ce> streq
									} else {
										error( "No support for multidimensional ($ndims) arrays yet\n" . Dumper($ast),0,'ERROR');
									}
								} elsif ( $decl->{'Type'} eq 'character') {
									# Although the AST says '10', decls says it's a scalar
										my $strn= (exists $decl->{'ModuleName'} ? $decl->{'ModuleName'} :$f).'_'.$ast->[1];
										# croak "ALLOW FOR MODULE GLOBALS HERE!";
										my $cb = _emit_expression_Uxntal($ast->[2][1], $stref, $f,$info);
										my $ce = _emit_expression_Uxntal($ast->[2][2], $stref, $f,$info);
										my $id=$info->{'LineID'};
										if($decl->{'Attr'}!~/len/) {
											croak 'String with index>1 but the type is character', Dumper $ast;
										}
										my $len = $decl->{'Attr'};$len=~s/len=//;
										return genSubstr($strn, $cb,$ce, $len, $id);
								} else { # Although the AST says '10', decls says it's a scalar
									croak Dumper $ast,$decl;
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
					my $len = toRawHex( length($lv)-1,2);
					$lv = "{ $len $lv } STH2r";
				}
				if ($rv=~/^\"/) {
					my $len = toRawHex( length($rv)-1,2);
					$rv = "{ $len $rv } STH2r";
				}
				if (isStrCmp($ast, $stref, $f,$info)) {
					return "$lv $rv scmp ( TODO: scmp for strings with length ) ";
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
					# croak "CONST EXP: $exp";
				}
				my $mvar = $ast->[1]; # Why is this not $exp?
				# croak "PROBLEM: $mvar <> $exp " if $mvar ne $exp;
				# my $qual_vname = $f .'_' . $mvar;
				my $called_sub_name = $stref->{'CalledSub'} // '';

				my $wordsz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$mvar};
				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar} ) {
					my $is_arg = in_nested_set($Sf,'DeclaredOrigArgs',$mvar) eq 'DeclaredOrigArgs' ? 1 : 0;
					# Meaning that $mvar is a pointer in $f
					# Now we need to check if it is also a pointer in $subname
					my $ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar};

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
					croak "$mvar $exp" if $mvar ne $exp;
					if ( in_nested_set($Sf,'Parameters',$mvar)) {
						# What is lacking here is a check in the container.
						return $f.'_'.$mvar;
					}

					elsif ( in_nested_set($Sf,'ModuleParameters',$mvar)) {
						# What is lacking here is a check in the container.
						croak 'MODULE PAR: _'.$mvar;
					}
					else {
						# But if the variable is a string, we should not do LDA
						# and if it is not a var, there should not be LDA either
						# if ($mvar =~ /^[a-zA-Z_]/) {
						my $qual_vname = $f.'_'.$mvar;
						my $subset = in_nested_set($Sf,'Vars',$mvar);
						my $decl = get_var_record_from_set($Sf->{$subset},$mvar);
						if (isString($decl) or isArray($decl)) {
							return ';'.$qual_vname.' ';
						} else {
							return ';'.$f.'_'.$mvar.' LDA' . ($wordsz==1 ? '' : '2' ).' ';#.' ( LOCAL ) ';
						}
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
							$instr = ' LDA' .($wordsz==1 ? '' : '2' );#.' ( NOT LOCAL ) ';
						}
						if ($exp =~ /^[a-zA-Z_]/) {
							my $qual_vname = $f.'_'.$exp;
							my $subset = in_nested_set($Sf,'ModuleVars',$exp);
							my $decl = get_var_record_from_set($Sf->{$subset},$exp);
							# my ($mod_name, $set) = __has_module_level_declaration($stref,$f,$exp) ;
							my $mod_name ='';
							if (exists $decl->{'ModuleName'}) {
								$mod_name = $decl->{'ModuleName'};
							}

							if ($mod_name ne '') {
								$qual_vname = $mod_name.'_'.$exp;
								if (not exists $stref->{'Uxntal'}{'Globals'}{'Set'}{$qual_vname}) {
									($stref, my $global_var_decl)= _emit_var_decl_Uxntal($stref,$mod_name,$info,$exp);
									$stref->{'Uxntal'}{'Globals'}{'Set'}{$qual_vname} = 1;
									push @{$stref->{'Uxntal'}{'Globals'}{'List'}},$global_var_decl ;
								}
								return $rune.$qual_vname . ' '. $instr;#. '( SCALAR MODULE VAR )'; #
							} else { # Could be a module parameter
								my $subset = in_nested_set($Sf,'ModuleParameters',$exp);
								my $decl = get_var_record_from_set($Sf->{$subset},$exp);
								my $mod_name ='';
								if (exists $decl->{'ModuleName'}) {
									$mod_name = $decl->{'ModuleName'};
								}

								if ($mod_name ne '') {
									$qual_vname = $mod_name.'_'.$exp;
									if (not exists $stref->{'Uxntal'}{'Macros'}{'Set'}{$qual_vname}) {
										$stref->{'Uxntal'}{'Macros'}{'Set'}{$qual_vname} = 1;
										($stref, my $global_var_decl)= _emit_var_decl_Uxntal($stref,$mod_name,$info,$exp);
										push @{$stref->{'Uxntal'}{'Macros'}{'List'}},$global_var_decl ;
									}

									return $qual_vname ;
								 } else {
									return $rune.$f.'_'.$exp . ' '. $instr. ' ( SCALAR FALLBACK )';
								}
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
	my $subname = $info->{'SubroutineCall'}{'Name'};
	if (exists $info->{'SubroutineCall'}{'IsExternal'}) {
		if ($subname eq 'exit') {
			return 'BRK';
		}
		if (exists  $F95_intrinsic_subroutine_sigs{$subname}) {
			return __emit_intrinsic_subroutine_call_expr_Uxntal($stref,$f,$line,$info);
		}
	}
	my $Ssubname = $stref->{'Subroutines'}{$subname};
	my $Sf = $stref->{'Subroutines'}{$f};
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
		my $call_arg_decl = get_var_record_from_set($Sf->{'Vars'},$call_arg_expr_str);
		my $isParam = defined $call_arg_decl and exists $call_arg_decl->{'Parameter'};
		# croak Dumper $call_arg_decl,$rec,$call_arg_expr_str if $call_arg_expr_str eq 'idx';
		# say "$subname: $sig_arg => ";say $call_arg_expr_str;
		my $intent = $rec->{'IODir'};
		my $isArray = $rec->{'ArrayOrScalar'} eq 'Array';
		my $isString = 0;
		if (not $isArray  and $rec->{'Type'} eq 'character') {
			if ($rec->{'Attr'}=~/len=(.+?)/) {
				my $len = $1;
				$isString = $len ne '1';
			}
		}
		my $word_sz = $Sf->{'WordSizes'}{$sig_arg};
		my $wordSz = $rec->{'Type'} eq 'character' ? 1 : 2;
		if ($rec->{'Attr'}=~/kind=(\d+)/) {
			$wordSz = $1;
		}

		my $isConstOrExpr = exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str} ?
		(($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Const' )
		or ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Expr')
		or $isParam)
		: 0;

		# if ($intent eq 'in' or $intent eq 'inout') {
			if ($isArray ) {
				push @call_arg_expr_strs_Uxntal, ';'.$f.'_'.$call_arg_expr_str;#.' ( ARG by ADDR ) ';
			}
			elsif ($isString) {
				push @call_arg_expr_strs_Uxntal, ';'.$f.'_'.$call_arg_expr_str.' LDA2';
			}
			elsif (not $isConstOrExpr) { # must be a scalar variable, so load it and pass by value
				push @call_arg_expr_strs_Uxntal, ';'.$f.'_'.$call_arg_expr_str.' LDA'.($word_sz==1 ? '' : '2' );#.' ( ARG by VAL ) ';
			}
			else {
				my $arg_expr_ast = $info->{'SubroutineCall'}{'ExpressionAST'}[0] == 27 ? $info->{'SubroutineCall'}{'ExpressionAST'}[$idx] : $info->{'SubroutineCall'}{'ExpressionAST'};
				push @call_arg_expr_strs_Uxntal, _emit_expression_Uxntal($arg_expr_ast, $stref, $f,$info);#.' ( ARG by VAL, CONST ) ';
			}
		# }
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
				push @call_arg_expr_strs_Uxntal,
				';' .$subname.'_'.$sig_arg.' LDA'.$wordSz.   ' ;'.$f.'_'.$call_arg_expr_str.' STA'.$wordSz.' ( OUT/INOUT CHECK IF WORKS FOR ADDRESSES! )';
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
				push @sub_retvals_Uxntal, ';'.$f.'_'.$sig_arg.' LDA'.$wordSz. ' ( RETVAL ) ';
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
	my $word_sz = $kind;
	if ($ftype eq 'character' and $kind=~/len/) {
		if ($kind !~/len=1/) {
			$word_sz=2;
		} else {
			$word_sz=1;
		}
	}

    my %corr = (
        'logical'          => 1, # C has no bool
        'integer'          =>  $word_sz,
        # 'real'             => ($ftype eq 'real' and $kind == 8 ? 'double' : 'float'),
        # 'double precision' => 'double',
        # 'doubleprecision'  => 'double',
        'character'        => $word_sz
    );
    if ( exists( $corr{$ftype} ) ) {
        return $corr{$ftype};
    } else {
        croak "TYPE for $ftype is not supported\n" if $W;
    }
}    # END of toUxntalType()

sub toHex { my ($n,$sz) = @_;
croak if not defined $n;
	my $szx2 = $sz*2;
	return sprintf("#%0${szx2}x",$n);
}
sub toRawHex { my ($n,$sz) = @_;
	my $szx2 = $sz*2;
	return sprintf("%0${szx2}x",$n);
}


sub genSubstr { my ($strn, $cb,$ce, $len,$id) = @_;
	if ($cb eq $ce) { # -1 to go to base-0 but +2 because of the length field, so +1
		return $cb . ' INC2 ;'.$strn.' LDA2 ( STRING ) ADD2 LDA'
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

# returns the Uxntal string with the print instructions
sub _emit_list_print_Uxntal { my ($stref,$f,$line,$info,$unit,$advance,$list_to_print) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $port = ($unit eq 'STDERR') ? '#19' : '#18';
# so for every elt in the list, we must work out if it is
#  - an integer
# - a character
# - a string
# - a boolean
# - anything else, but that should fail
# although of course in principle a function should work too

	my $line_Uxntal = '';
	for my $elt ( @{$list_to_print} ) {
		my $print_fn_Uxntal = _emit_print_from_ast($stref,$f,$line,$info,$unit,$elt);

		my $arg_to_print_Uxntal =  _emit_expression_Uxntal($elt,$stref, $f, $info);
		$line_Uxntal .= "$arg_to_print_Uxntal $print_fn_Uxntal #20 $port DEO ( , )\n"
	}
	if ($advance eq 'yes') {
		if ($unit eq 'STDOUT') {
			$line_Uxntal .= '#0a #18 DEO';
		}
		elsif ($unit eq 'STDERR') {
			$line_Uxntal .= '#0a #19 DEO';
		}
	}
	return $line_Uxntal;

} # END of _emit_list_print_Uxntal

# returns the print function to be used: print-char, print-int etc
sub _emit_print_from_ast { my ($stref,$f,$line,$info,$unit,$elt) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $suffix = $unit eq 'STDERR' ? '-stderr' : '';
	my $code = $elt->[0];
	if ($code == 2 or $code == 10) { # A scalar, but can be an unindexed string or array
		my $var_name = $elt->[1];
		# my $wordsz = $stref->{'Subroutines'}{$f}{'WordSizes'}{$var_name};
		my $decl = get_var_record_from_set($Sf->{'Vars'},$var_name);
		my $type = $decl->{'Type'};
		if ($code == 2 and $decl->{'ArrayOrScalar'} eq 'Array') {
			error("Printing an array is currently unsupported");
		}
		if ( $decl->{'Type'} eq 'character') {
			if( $code == 2 and $decl->{'Attr'}!~/len/) {
				return 'print-char'.$suffix;
			}
			elsif( $code == 10 and $decl->{'ArrayOrScalar'} eq 'Array') {
				my $dims =  $decl->{'Dim'};
				my $ndims = scalar @{$dims};
				if ($ndims==0 ) {
					return 'print-string'.$suffix;
				} else {
				# an indexed array of characters, so print a char
					return 'print-char'.$suffix;
				}
			}
			elsif( $code == 10 and $decl->{'ArrayOrScalar'} eq 'Scalar') {
				die "Code says array but decls says Scalar:".Dumper( $elt);
			} else {
				return 'print-string'.$suffix;
			}
		}
		if ( $decl->{'Type'} eq 'integer') {
			return 'print-int'.$suffix;
		}
		if ( $decl->{'Type'} eq 'logical') {
			return 'print-bool'.$suffix;
		}
	}
	elsif ($code == 1 ) {
		my $fname = $elt->[1];
		# This is a function, need to get its return type
		# TODO
		my $return_type = $stref->{'Subroutines'}{$fname}{'Signature'}{'ReturnType'};
		my $return_type_attr = $stref->{'Subroutines'}{$fname}{'Signature'}{'ReturnTypeAttr'};
		# I am assuming the return type can only be integer(kind=2), character, string or boolean
	}
	elsif ($code>=29) {
		my $const_type = $code;
		my $const = $elt->[1];
		if ($const_type == 29 ) {
			return 'print-int'.$suffix;
		}
		elsif ($const_type == 31 ) {
			return 'print-bool'.$suffix;
		}
		elsif ($const_type == 32 ) {
			return 'print-char'.$suffix;
		}
		elsif ($const_type == 34 ) {
			die("Placeholder in print statement\n");
		}
		else {
			error('Unsupported type in print statement: '.$sigils[$const_type]);
		}
	}
	elsif ($code>=3 and $code<=6) {
		return 'print-int'.$suffix;
	}
	elsif ($code==7 or $code==8) {
		die("TODO: printing of ".$sigils[$code]."\n");
	}
	elsif ($code>=15 and $code<=26) {
		return 'print-bool'.$suffix;
	}
	elsif ($code==13) {
		die("TODO: printing of string concatenation expression\n");
	}
	else {
		error('Unsupported type in print statement: '.$sigils[$code]);
	}
} # END of _emit_print_from_ast
# -----------------------------------------------------------------------------

sub _analyse_write_call { my ($stref,$f,$info)=@_;
	my $call_args_ast = $info->{'IOCall'}{'Args'}{'AST'}[2];
	my $iolist_ast = $info->{'IOList'}{'AST'};

	# This is really complicated.
	# The first arg can be an integer, a variable or '*'
	# If it's zero, it's STDERR, so we need #19 instead of #18
	# If it's a variable, we are copying into a string, which is not DEO at all
	# If it's advance=no it means no newline, that bit is easy
	# And then there is the format, which tells us which print action we need to do

	# other args can be named or not (fmt=, advance=)
	# Formats must be parsed to see if it is a list or not
	# They are stored as placeholders
	my $print_calls=[];
	my $offsets=[];
	my $unit='';
	my $advance='yes';
	if ($call_args_ast->[0]==27) {
		shift @{$call_args_ast};
		# Now we have the actual arg list
		my $i=0;
		for my $arg_ast (@{$call_args_ast}) {
			# all of these will be tagged
			# tags can be
			# 29 : if 0, this is STDERR; I assume 1 is STDOUT, needs to check
			# 32: char: if *, means it's like print *
			# 34: PlaceHolder, this is the string with the format (`fmt=` is removed)
			# 9: =, check what is next, it should be [2,$attr]
			# Most common $attr is advance; the value will be a PlaceHolder
			my $attr = __analyse_write_call_arg($stref,$f,$info,$arg_ast,$i);
			++$i;
			if ($attr->[0] eq 'fmt') {
				($print_calls,$offsets) = __parse_fmt($attr->[1],$info);
			}
			elsif ($attr->[0] eq 'unit') {
				$unit = $attr->[1];
			}
			elsif ($attr->[0] eq 'advance') {
				$advance=$attr->[1];
			} else {
				error("Unsupported WRITE call syntax: ".Dumper($info));
			}
		}
	}
	else { # single element
		my $attr = __analyse_write_call_arg($stref,$f,$info,$call_args_ast,0);
	}

	if ($unit eq 'STDERR') {
		$print_calls = [map {$_.='-stderr'} @{$print_calls}];
	}
	elsif ($unit ne 'STDOUT') { # so must be a var
		$print_calls = [map {$_=~s/print/memwrite/;$_} @{$print_calls}];
	}

	return ($print_calls, $offsets, $unit, $advance);
} # END of _analyse_write_call
# -----------------------------------------------------------------------------
# This call returns unit, fmt or advance. Could in principle return any attribute
sub __analyse_write_call_arg { my ($stref,$f,$info,$arg,$i) = @_;
	# all of these will be tagged
	my $tag = $arg->[0];
	my $arg_val = $arg->[1];
	if ($tag == 29) {
		# 29 : if 0, this is STDERR; otherwise it means a file but I will not support this
		if ($arg_val==0) {
			# STDERR
			return ['unit','STDERR'];
		} else {
			error("WRITE only supported with unit=0, unit=* or a variable");
		}
		# "The standard logical units 0, 5, and 6 are preconnected to Solaris as stderr, stdin, and stdout"
		# it looks like for gfortran on Linux, 0 is also stderr
	}
	elsif ($tag == 32) {
		# 32: char: if *, means it's like print *
		if ($arg_val eq '*' ) {
			if ($i==0){
				return ['unit','STDOUT'];
			}
			elsif ($i==1) {
				return ['fmt','*'];
			}
		} else {
			error("WRITE only supported with unit=0, unit=* or a variable");
		}
	}
	elsif ($tag == 34) {
		# 34: PlaceHolder, this is the string with the format (`fmt=` is removed)
		my $fmt_str = $info->{'PlaceHolders'}{$arg_val};
		$fmt_str=~s/^[\"\']\(//;
		$fmt_str=~s/\)[\'\"]$//;
		# say "FMT=$fmt_str";
		return ['fmt',$fmt_str];
	}
	elsif ($tag == 9) {
		# 9: =, check what is next, it should be [2,$attr]
		# Most common $attr is advance; the value will be a PlaceHolder
		if (ref($arg_val) eq 'ARRAY' and $arg_val->[0] == 2) {
			my $attr = $arg_val->[1];
			if ($attr eq 'advance') {
				my $attr_val = $arg->[2];
				if ($attr_val->[0] == 34) {
					my $attr_val_str =  $info->{'PlaceHolders'}{$attr_val->[1]};
					$attr_val_str=~s/^[\"\']//;
					$attr_val_str=~s/[\"\']$//;
					return [ 'advance',$attr_val_str];
				}
			}
		}
	}
	elsif ($tag == 2) {
		# must be a variable
		my $unit_var = 	$arg_val;
		return ['unit',$unit_var];
	} else {
		die "Unknown arg type: ".Dumper($arg);
	}
} # END of __analyse_write_call_arg
# -----------------------------------------------------------------------------
# returs a list of the types to be printed.
# I only support I, A, L and Z.
# For A, if it is >1 it is a string, else a character.
# What I return is the list of required print calls
# w.m means a width of w characters, showing m digits
# w>m is an error
# w<m pads upfront with spaces
# if the field is too small, a string of w `*`s is returned
# I am not going to do this.
# I will simply use m and ignore w
sub __parse_fmt { my ($fmt_str,$info) = @_;

	my @chunks = split(/\s*,\s*/,$fmt_str);
	my $print_calls=[];
	my $offsets=[0];
	my $offset=0;
	my $chunk_idx=1;
	for my $chunk (@chunks) {
		my $c=uc(substr($chunk,0,1));
		my $nchars=substr($chunk,1);
		if ($nchars=~/^\d\.(\d)$/) {
			$nchars=$1;
		} elsif ($nchars=~/^(\d)$/) {
			$nchars=$1;
		} else {
			# croak 'INFO:',Dumper($info->{'IOList'}{'AST'},$info->{'PlaceHolders'});
			if ($info->{'IOList'}{'AST'}[0]==27) {
				# more than one argument
				my $val_ast = $info->{'IOList'}{'AST'}[$chunk_idx];
				$nchars = __get_len_from_AST($val_ast,$info->{'PlaceHolders'});

			} else {
				my $val_ast = $info->{'IOList'}{'AST'}[0];
				$nchars = __get_len_from_AST($val_ast,$info->{'PlaceHolders'});
			}
		}
		# warn "NCHARS: $nchars";
		if ( $c eq 'I' ) {
			push @{$print_calls}, 'print-int';
			$offset+=max(2,$nchars);
		}
		elsif ( $c eq 'Z' ) {
			push @{$print_calls}, 'print-hex';
			$offset+=max(1,$nchars);
		}
		elsif ( $c eq 'L' ) {
			push @{$print_calls}, 'print-bool';
			$offset+=max(1,$nchars);
		}
		elsif ( $c eq 'A' ) {
			if (uc($chunk) eq 'A') {
				push @{$print_calls}, 'print-string';
				# offset is unknown
				# set it totally ad-hoc to 8
				$offset+=8;
			} else {
				if ($nchars==1) {
					push @{$print_calls}, 'print-char';
					$offset+=max(1,$nchars);
				}
				elsif ($nchars>1) {
					push @{$print_calls}, 'print-string';
					$offset+=max(1,$nchars);
				} else {
					die "Problem with FMT $chunk\n";
				}
			}
		}
		elsif ( $c eq '*' ) {
			push @{$print_calls}, 'print-list';
		}
		else {
			die "Unsupported FMT: $chunk\n";
		}
		push @{$offsets},$offset;
		$chunk_idx++;
	}
	return ($print_calls,$offsets);
} # END of __parse_fmt

sub __get_len_from_AST { my ($val_ast, $phs) = @_;
#                29         30      31         32           33         34             35       36
#              ,'integer', 'real', 'logical', 'character', 'complex', 'PlaceHolder', 'Label', 'BLANK'
	if ($val_ast->[0] == 29) {
		return length($val_ast->[1].'');
	} elsif ($val_ast->[0] == 30) {
		return length($val_ast->[1].'');
	} elsif ($val_ast->[0] == 31) {
		return 1;
	} elsif ($val_ast->[0] == 32) {
		return 1;
	} elsif ($val_ast->[0] == 33) {
		return length($val_ast->[1].'');
	} elsif ($val_ast->[0] == 34) {
		return length($phs->{$val_ast->[1]});
	} elsif ($val_ast->[0] == 35) {
		return length($val_ast->[1].'');
	} elsif ($val_ast->[0] == 36) {
		return length($val_ast->[1].'');
	}
}
sub __emit_list_based_print_write { my ($stref,$f,$line,$info,$unit, $advance) = @_;
# carp Dumper $info->{'IOCall'}{'Args'}{'AST'};
my $port = $unit eq 'STDERR' ? '#19' : '#18';
	my $ast =  $info->{'IO'} eq 'print'
		? $info->{'IOCall'}{'Args'}{'AST'}
		:  [1,'write',[27,[32,'*'],@{ $info->{'IOList'}{'AST'} }[
			1 ..
			scalar  @{ $info->{'IOList'}{'AST'} } - 1
			] ] ]
		;
	my $c_line = '';
	# list-oriented print
	if (ref($ast->[2][1]) eq 'ARRAY' and $ast->[2][1][1] eq '*') {
		my @list_to_print = @{$ast->[2]};
		shift @list_to_print; shift @list_to_print;
		# croak Dumper @list_to_print;
		$c_line = _emit_list_print_Uxntal($stref,$f,$line,$info,$unit, $advance,\@list_to_print);

	} else {
		my $fmt_ast = $ast->[2][1];
		if ($fmt_ast->[0]==29) {
			error("Unsupported: PRINT with label arg: $line",0,'ERROR');
		}
		my $print_fmt = __analyse_write_call_arg($stref,$f,$info,$fmt_ast,0);
		my ($print_call_list, $offsets) = __parse_fmt($print_fmt->[1]);
		my $call_arg_list = $ast->[2]; shift @{$call_arg_list};shift @{$call_arg_list};
		if (scalar @{$print_call_list} != scalar @{$call_arg_list}) {
			die Dumper($print_call_list,$call_arg_list);
		}
		$c_line='';
		for my $arg_ast (@{$call_arg_list}) {
			my $print_call = shift @{$print_call_list};
			$c_line.= _emit_expression_Uxntal($arg_ast,$stref, $f, $info).' '.$print_call. " #20 $port DEO"."\n";
		}
	}
	# if ($unit eq 'STDERR') {
		return $c_line . " #0a $port DEO";
	# }
	# else {
	# 	return $c_line . ' #0a #18 DEO'."  ( unit: <$unit> ) ";
	# }

} # END of __emit_list_based_print_write

sub isArray { my ($rec) = @_;
		return ($rec->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
}

sub isString { my ($rec) = @_;

	my $is_array = $rec->{'ArrayOrScalar'} eq 'Array';
	my $is_string = 0;
	if (not $is_array  and $rec->{'Type'} eq 'character') {
		if ($rec->{'Attr'}=~/len=(.+?)/) {
			my $len = $1;
			$is_string = $len ne '1';
		}
	}
	return $is_string
}


# ----------------------------------------------------------------------------------------------------
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
# carp Dumper $dims;
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
