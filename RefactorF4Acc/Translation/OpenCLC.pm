package RefactorF4Acc::Translation::OpenCLC;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass stateful_pass_inplace pass_wrapper_subs_in_module update_arg_var_decl_sourcelines get_annotated_sourcelines);
use RefactorF4Acc::Refactoring::Fixes qw(
	_declare_undeclared_variables
	_remove_unused_variables
	);
use RefactorF4Acc::Parser::Expressions qw( @sigils );
use RefactorF4Acc::Translation::LlvmToTyTraIR qw( generate_llvm_ir_for_TyTra );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Translation::OpenCLC::ISA = qw(Exporter);

@RefactorF4Acc::Translation::OpenCLC::EXPORT_OK = qw(
    &add_to_C_build_sources
    &translate_module_to_C
	&translate_sub_to_C
);
#    &translate_all_to_C
#    &refactor_C_targets
#    &emit_C_targets
#    &toCType

## So assuming a subroutine has been marked with
# if (exists $stref->{'Subroutines'}{$sub}{'Translate'} and $stref->{'Subroutines'}{$sub}{'Translate'} eq 'C') {
# 	# Then we can emit C code
# 		translate_sub_to_C($stref,$sub);
# }

#### #### #### #### BEGIN OF C TRANSLATION CODE #### #### #### ####
# $ocl: 0 = C, 1 = CPU/GPU OpenCL, 2 = C for TyTraIR aka TyTraC, 3 = pipe-based OpenCL for FPGAs
# 4 = translate_to_TyTraLlvmIR, 5 = translate_to_OpenCL_memory_reduction
sub translate_module_to_C {  (my $stref, my $module_name, my $ocl) = @_;

	if (not defined $ocl) {$ocl=0;}
	my $generate_TyTraLlvmIR = 0;
	# So if $ocl is 4, we change it to 2 and set the extra flag
	if ($ocl == 4) {
		$generate_TyTraLlvmIR = 1;
		$ocl=2;
	}
	$stref->{'OpenCL'}=$ocl;
	$stref->{'TranslatedCode'}=[];
	$Config{'FIXES'}={
	_declare_undeclared_variables => 1,
	# _remove_unused_variables => 1
	};
	$stref = pass_wrapper_subs_in_module($stref,$module_name,
	   # module-specific passes.
       [
           [\&_emit_OpenCL_pipe_declarations]
       ],
       # subroutine-specific passes
	   [
		  [
			  \&determine_argument_io_direction_rec,
			  \&update_arg_var_decl_sourcelines,
			  \&_declare_undeclared_variables]
			  ,#,\&_remove_unused_variables],
		  [\&add_OpenCL_address_space_qualifiers],
		  [\&translate_sub_to_C]
       ],
       $ocl);

	$stref = _write_headers($stref,$ocl);
	$stref = _emit_C_code($stref, $module_name, $ocl);
	if ($generate_TyTraLlvmIR and $module_name !~/superkernel/) {
		$stref = generate_llvm_ir_for_TyTra($stref, $module_name);
	}
	# This enables the postprocessing for custom passes
	$stref->{'CustomPassPostProcessing'}=1;
    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'}={};
} # END of translate_module_to_C

our @F95_OpenCL_API_list = qw(
	get_global_id
	get_local_id
	get_group_id
	barrier
);
our %F95_OpenCL_API = map {$_=>1} @F95_OpenCL_API_list;


sub add_OpenCL_address_space_qualifiers { (my $stref, my $f, my $ocl) = @_;

	if ($ocl>=1) {
		if ($Config{'KERNEL'} eq '' and $Config{'TOP'} ne '') {
			$Config{'KERNEL'}=$Config{'TOP'}
		}
		# else {
		# 	$Config{'KERNEL'}='';
		# }
		if ($ocl==3 or $f eq $Config{'KERNEL'} ) {


#	The pass is as follows:
#- in the Kernel sig, if it's a ptr, it's global. Means if it's not a scalar.
#- In the called subs, if a global ptr is passed as is, i.e. as an Array, the sig arg must get global as well.
#so in the arg map we check if an arg is a global ptr by checking the Expr
#if this is the case then we set the sig arg OclAddressSpace to global too.

			my $pass_add_OpenCL_address_space_qualifiers = sub { (my $annline, my $state)=@_;
				(my $line,my $info)=@{$annline};
				(my $stref, my $f)=@{$state};
		#		say Dumper($stref->{'Subroutines'}{$f}{'DeletedArgs'});
				my $skip=0;
				if (exists $info->{'Signature'} ) {
					for my $arg (@{ $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'} } ) {
						my $_arg_idx=0;
						if (not defined $arg) {
							carp "Undefined arg in position $_arg_idx in DeclaredOrigArgs for $f";
						}
#							my $decl = $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
						my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg);
#							say $f.Dumper( $stref->{'Subroutines'}{$f}{'Args'} );
#							say $arg.Dumper($decl);
						if ($decl->{'ArrayOrScalar'} eq 'Array') {
							$decl->{'OclAddressSpace'} = '__global';
							# RS 19/11/2021 - we could put all READ-ONLY pointers into constant
							# memory space but, depending on the device, the constant memory can be
							# smaler than global memory and have different/no caching policy.
						}
						elsif ($decl->{'ArrayOrScalar'} eq 'Scalar') {
							# RS 19/11/2021 - I think it makes sense to put scalars into constant mem.
							# Note, if the scalar is Read/Write, it will be put into global mem.
							# WV 2021-10-19 if they are pointers it makes sense. Otherwise they should be in registers.
							my $decl_for_iodir = $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
							$decl->{'OclAddressSpace'} = (defined $decl_for_iodir->{'IODir'} and
														lc($decl_for_iodir->{'IODir'}) eq 'in')
														? '__constant'
														: '__global';
						}

						++$_arg_idx;
					}
				}
				elsif (exists $info->{'SubroutineCall'} and
					not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
					){
						my $subname = $info->{'SubroutineCall'}{'Name'};

					# First update the ArgMap
					# This is to account for the renamed pointers
					for my $sig_arg (keys %{$info->{'SubroutineCall'}{'ArgMap'} }) {
						my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
						my $call_arg_expr =  $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'};
						if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$call_arg_expr} and
						exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$call_arg_expr}{'OclAddressSpace'} ) {
							my $ocl_address_space = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$call_arg_expr}{'OclAddressSpace'};
#							carp "$f => $subname => setting OpenCL address space for $sig_arg to $ocl_address_space";
							$stref->{'Subroutines'}{$subname}{'DeclaredOrigArgs'}{'Set'}{$sig_arg}{'OclAddressSpace'}=$ocl_address_space;
						}
					}
				}

				return ([$annline],[$stref,$f]);
			};
			my $state = [$stref,$f];
 			($stref,$state) = stateful_pass_inplace($stref,$f,$pass_add_OpenCL_address_space_qualifiers, $state,'pass_add_OpenCL_address_space_qualifiers() ' . __LINE__  ) ;
		}
	}
	return $stref;
} # END of

sub translate_sub_to_C {  (my $stref, my $f, my $ocl) = @_;

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
			if (exists $state->{'Args'}{$var} and not exists $F95_OpenCL_API{$f}) {
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
			my $fname =  $info->{'SubroutineCall'}{'Name'};
			if (not exists $F95_intrinsic_functions{$fname} and not exists $F95_OpenCL_API{$fname}) {
			for my $arg_expr_str (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
				# say "<$fname $arg_expr_str>";
				my $arg = $info->{'SubroutineCall'}{'Args'}{'Set'}{$arg_expr_str}{'Type'} eq 'Scalar'
				? $info->{'SubroutineCall'}{'Args'}{'Set'}{$arg_expr_str}{'Expr'}
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
				if (not exists $F95_intrinsic_functions{$fname} and not exists $F95_OpenCL_API{$fname}) {
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

	my $pass_translate_to_C = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
#		say Dumper($stref->{'Subroutines'}{$f}{'DeletedArgs'});

		my $skip=0;
		if (exists $info->{'Signature'} ) {
			$pass_state->{'Args'}=$info->{'Signature'}{'Args'}{'List'};
			if($ocl==3 and $info->{'Signature'}{'Name'} eq 'pipe_initialisation') {
				# WV20190823 I think this is OBSOLETE
				$c_line='';
			} else {
				my $sig_line = _emit_subroutine_sig_C( $stref, $f, $annline);
				$c_line = $sig_line." {\n";
				# RS 19/11/21
				$pass_state->{'ForwardDecl'} = $sig_line.';' unless ($sig_line=~/int\s+main/ or ($ocl==1 or $ocl==3 or $ocl==5) and $f eq $Config{'KERNEL'});
				if ($ocl==3 ) {
					$c_line = '__kernel __attribute__((reqd_work_group_size(1,1,1))) '.$c_line;
				} elsif (($ocl==1 or $ocl==5) and $f eq $Config{'KERNEL'}) {
					$c_line = '__kernel '.$c_line;
				}
			}
		}
		elsif (exists $info->{'VarDecl'} ) {

				my $var = $info->{'VarDecl'}{'Name'};
				if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}
				or ($ocl==3 and $var=~/__pipe$/)
				) {
					$c_line='//'.$line;
					$skip=1;
				} else {
				# WV20191106 If we always use 1-D arrays then array slices should be mimicked by
				# multiplying the array index with the size of the first dimension, e.g for an 8x8 array
				# v(2,:) would become v[8]
				# and for an 8x8x8, v(2,:,:) would become v[1*8*8] and v(2,3,:) would be v(1*8*8+2*8)
				# And this should be a pointer, not a value, so should it then not be &v[8]? I think so.
					$c_line = _emit_var_decl_C($stref,$f,$var);
					if (exists $info->{'TrailingComment'} and $info->{'TrailingComment'}=~/\$ACC\s+MemSpace\s+(\w+)/) {
						# This code will basically only work for arrays with dimensions defined by constants and macros
						#
						my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
						my $dim = $decl->{'Dim'};
						my @sizes = map {  '('.$_->[1].' - '.$_->[0].' +1)'   } @{$dim} ; #[['1','nth']]
						my $size_str = (scalar @sizes==1) ? $sizes[0] : join('*',@sizes);
						my $memspace='__'.$1;
						my $indent = ($c_line =~s/^\s+//);
						$c_line=~s/\*//;
						$c_line=~s/;//;

						$c_line = $indent.	 $memspace.' '.$c_line.'['.uc($size_str).'];' ;
					}
				}
		}
		elsif ( exists $info->{'ParamDecl'} ) {
				my $var = $info->{'VarDecl'}{'Name'};

				$c_line = _emit_var_decl_C($stref,$f,$var);
		}
		elsif (exists $info->{'Select'} ) {
            #my $switch_expr = _emit_expression_C(['$',$info->{'CaseVar'}],'',$stref,$f);
			my $switch_expr = _emit_expression_C([2,$info->{'CaseVar'}],$stref,$f,$info); # FIXME
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
				$c_line='for ('.
				$info->{'Do'}{'Iterator'}.' = '.$info->{'Do'}{'Range'}{'Expressions'}[0] .';'.
				$info->{'Do'}{'Iterator'}.' <= '.$info->{'Do'}{'Range'}{'Expressions'}[1] .';'.
				$info->{'Do'}{'Iterator'}.' += '.$info->{'Do'}{'Range'}{'Expressions'}[2] .') {';
		}
		elsif (exists $info->{'BeginDo'} ) {
				$c_line='for () {';
		}
		if (exists $info->{'Assignment'} ) {
				$c_line = _emit_assignment_C($stref, $f, $info).';';
		}
		elsif (exists $info->{'SubroutineCall'} ) {
			#
			my $subcall_ast = [ 1, $info->{'SubroutineCall'}{'Name'},$info->{'SubroutineCall'}{'ExpressionAST'} ];

			# $subcall_ast->[0] = 1; # FIXME '&';

			# There is an issue here:
			# We actually need to check the type of the called arg against the type of the sig arg
			# If the called arg is a pointer and the sig arg is a pointer, no '*', else, we need a '*'
			# But the problem is of course that we have just replaced the called args by the sig args
			# So what we need to do is check the type in $f and $subname, and use that to see if we need a '*' or even an '&' or nothing

			if ($subcall_ast->[1] eq 'barrier') {
				$subcall_ast->[2][1]=uc($subcall_ast->[2][1]);
#				push @{$pass_state->{'TranslatedCode'}},'#ifdef BARRIER_OK';
				$c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,$stref,$f,$info).';';
				push @{$pass_state->{'TranslatedCode'}},$c_line ;
#				push @{$pass_state->{'TranslatedCode'}},'#endif // BARRIER_OK';
				$skip=1;
			}
			elsif ($subcall_ast->[1]=~/ocl_pipe_(real|integer)/) {
				my $ftype = $1;
				$c_line = $info->{'Indent'}.'pipe '.toCType($ftype).' '.$subcall_ast->[2][1].' __attribute__((xcl_reqd_pipe_depth(32)));'; # TODO: make configurable, this is Xilinx-specific!
			}
            elsif ($subcall_ast->[1]=~/(read|write)_pipe/) {
                my $iodir = $1;
                $c_line = $info->{'Indent'} . $subcall_ast->[1] .'_block'.'('.$subcall_ast->[2][1][1].','.'&'.$subcall_ast->[2][2][1].');'; # TODO: make configurable, this is Xilinx-specific!
            }
			elsif ($subcall_ast->[1]=~/get_(local|global|group)_id/) {
				my $ocl_id_var = $info->{'SubroutineCall'}{'Args'}{'List'}[0];
				my $ocl_dimidx = $info->{'SubroutineCall'}{'Args'}{'List'}[1];
				my $qual = $1;
				# $c_line = $info->{'Indent'}."${qual}_id = get_${qual}_id(0);";
				$c_line = $info->{'Indent'}."$ocl_id_var = get_${qual}_id($ocl_dimidx);";
			} else {
				$c_line = $info->{'Indent'}._emit_subroutine_call_expr_C($stref,$f,$info).';';
				# croak Dumper $info if $info->{'SubroutineCall'}{'Name'} eq 'update_map_24';
				# $c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,$stref,$f,$info).';';
            }
		}
		elsif (exists $info->{'If'} ) {
			$c_line = _emit_ifthen_C($stref, $f, $info);
		}
		elsif (exists $info->{'ElseIf'} ) {
			$c_line = '} else '._emit_ifthen_C($stref, $f, $info);
		}
		elsif (exists $info->{'Else'} ) {
			$c_line = ' } else {';
		}
		elsif (
				exists $info->{'EndDo'}
			or exists $info->{'EndIf'}
			or exists $info->{'EndSubroutine'}
			or exists $info->{'EndProgram'}
			) {
			if ($ocl==3 and  exists $info->{'EndSubroutine'} and  $info->{'EndSubroutine'}{'Name'} eq 'pipe_initialisation') {
				$c_line = '' ;
			} else {
				$info->{'Indent'} = '' if exists $info->{'EndSubroutine'} or exists $info->{'EndProgram'} ;
				$c_line = '}' ;
			}
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
			$c_line = $line.';';
		}
		elsif (exists $info->{'Continue'}) {
			$c_line='';
		}
		elsif (exists $info->{'Common'}) {
			$c_line='';
		}
		if (exists $info->{'Label'} ) {
			$c_line = $info->{'Label'}. ' : '."\n".$info->{'Indent'}.$c_line;
		}

		push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line unless $skip;

		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f, {'TranslatedCode'=>[], 'Args'=>[],'ForwardDecl'=>''}];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_translate_to_C, $state,'C_translation_collect_info() ' . __LINE__  ) ;

 	$stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
 	$stref->{'TranslatedCode'}=[$state->[2]{'ForwardDecl'},@{$stref->{'TranslatedCode'}},'',@{$state->[2]{'TranslatedCode'}}] unless exists $F95_OpenCL_API{$f};
	# For fixing LLVM IR
	$stref->{'SubroutineArgs'}=$state->[2]{'Args'};
	$stref->{'SubroutineName'}=$f;
 	return $stref;

} # END of translate_sub_to_C()

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

sub _emit_C_code { (my $stref, my $module_name, my $ocl)=@_;
 	map {say $_ } @{$stref->{'TranslatedCode'}} if $V;
	# WV 2021-06-08 I use .cc so that this is ostensibly C++ code.
	# This is because in pure C, the switch/case does not work with const int (!)
	# I don't want to replace the const int by #define in an ad-hoc way so C++ it is.
 	my $ext = ($ocl and $ocl!=2) ? 'cl' : 'cc';
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
} # END of _emit_C_code

sub _emit_subroutine_sig_C { (my $stref, my $f, my $annline)=@_;
	    (my $line, my $info) = @{ $annline };
	    my $Sf        = $stref->{'Subroutines'}{$f};

	    my $name = $info->{'Signature'}{'Name'};
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
		carp Dumper $info;
		my $c_args_ref=[];
		for my $arg (@{ $args_ref }) {
			($stref,my $c_arg_decl) = _emit_arg_decl_C($stref,$f,$arg);
			push @{$c_args_ref},$c_arg_decl;
		}
	    my $args_str = join( ',', @{$c_args_ref} );
		my $rline = "void $name($args_str)";
		if (exists $stref->{'Subroutines'}{$f}{'Program'} and $stref->{'Subroutines'}{$f}{'Program'}==1
		) {
			$rline = "int main($args_str)";
		}
		return  $rline;
} # END of _emit_subroutine_sig_C

sub _emit_arg_decl_C { (my $stref,my $f,my $arg)=@_;

	my $decl_for_iodir =	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg) ;

	# my $array = $decl->{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
	# my $const = 1;
	# if (not defined $decl_for_iodir->{'IODir'}) {
	# 	$const = 0;
	# } else {
	# 	$const = lc($decl_for_iodir->{'IODir'}) eq 'in' ? 1 : 0;
	# }
	# my $is_ptr = $array || ($const==0);
	# # WV 2021-06-07 All args are always pointers!
	# $is_ptr=1;
	# my $ptr = $is_ptr ? '*' : '';
    # #die "$ptr $arg" if $f =~/shapiro_map/ && $arg eq 'eta_j_k';
	# $stref->{'Subroutines'}{$f}{'Pointers'}{$arg}=$ptr;
	my $ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$arg};
	my $is_ptr = $ptr eq '*' ? 1 : 0;
	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=4};
	my $c_type = toCType($ftype,$fkind);
	my $ocl_address_space = ($stref->{'OpenCL'} >=1 and exists $decl->{'OclAddressSpace'} and $is_ptr ) ? $decl->{'OclAddressSpace'}.' ' : '';
	my $maybe_const = ($stref->{'OpenCL'} ==1 and $f eq $Config{'KERNEL'} and $ocl_address_space eq '') ? 'const ' : '';
	my $c_arg_decl = $ocl_address_space . $maybe_const . $c_type.' '.$ptr.$arg;
	return ($stref,$c_arg_decl);
}



sub _emit_var_decl_C { (my $stref,my $f,my $var)=@_;
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
	my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
	# say $decl->{"ParsedVarDecl"};
	my $const = '';
	my $val='';
	if (defined $decl->{'Parameter'}) {
		$const = 'const ';
		$val = ' = '.$decl->{'Val'};
		# In the case of a constant array: replace '(/' with '{' and add '[]' to front
		# WV 2021-10-19 This is OK but a bit hacky, because Fortran also supports the '[ ... ]' syntax
		# It would be better to use ParsedVarDecl
		if ($val=~s/\(\//{/) {
			$val=~s/\/\)/}/;
			$val = '[]' . $val;
		}
	}
	my $ocl = $stref->{'OpenCL'};
	# my $ptr = ($array && $ocl<3) ? '*' : '';
   	# $ptr = $const eq '' ? '*' : '';
	# RS 19/11/21 - translating multidim arrays for memory reduction.
	my $dim= ($array && ($ocl==1 || $ocl==5)) ? '['.__C_array_size($decl->{'Dim'}).']' : '';
	my $ptr =  $stref->{'Subroutines'}{$f}{'Pointers'}{$var} ;

	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
#	carp Dumper($fkind);
	if (ref ($ftype) eq 'HASH') {
		if (exists $ftype->{'Kind'}) {
			$fkind = $ftype->{'Kind'};
		}
		$ftype = $ftype->{'Type'};
	}
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=4};

	my $c_type = toCType($ftype,$fkind);
	my $c_var_decl = $const.$c_type.' '.$ptr.$var.$dim.$val.';';
	return ($stref,$c_var_decl);
}

sub _emit_assignment_C { (my $stref, my $f, my $info)=@_;
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
	my $lhs = _emit_expression_C($lhs_ast,$stref,$f,$info);

	my $indent='';
	$lhs=~/^(\s+)/ && do {
		$indent=$1;
		$lhs=~s/^\s+//;
	};
	$lhs=~s/^\(([^\(\)]+)\)/$1/;
	$lhs=$indent.$lhs;

	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};
#	carp Dumper($rhs_ast) if $lhs=~/k_range/;

	my $rhs = _emit_expression_C($rhs_ast,$stref,$f,$info);
	#  croak 'WRONG RHS '.$rhs if $rhs=~/hzero_j_k/;
#	say "RHS:$rhs" if$rhs=~/abs/;
	my $rhs_stripped = $rhs;
	$rhs_stripped=~s/^\(([^\(\)]+)\)$/$1/;

	for my $macro (keys %{ $Config{'Macros'} } ) {
		my $lc_macro=lc($macro);
		$rhs_stripped=~s/\b$lc_macro\b/$macro/g;
	}

#	say "RHS STRIPPED:$rhs_stripped" if$rhs=~/abs/;
#	$rhs_stripped=~s/^\(// && $rhs_stripped=~s/\)$//;
#	if ( $rhs_stripped=~/[\(\)]/) {
#		# Undo!
#		$rhs_stripped=$rhs;
#	}
	# say $rhs_stripped;
	my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
	if (exists $info->{'If'}) {
		my $if_str = _emit_ifthen_C($stref,$f,$info);
		$rline =$indent.$if_str.' '.$rline;
	}
	# carp "$f $rline";
	return $rline;
}



sub _emit_ifthen_C { (my $stref, my $f, my $info)=@_;
	my $cond_expr_ast=$info->{'Cond'}{'AST'};
	my $cond_expr = _emit_expression_C($cond_expr_ast,$stref,$f,$info);
	$cond_expr=_change_operators_to_C($cond_expr);
	# FIXME! fix for stray '+'
	$cond_expr=~s/\+\>/>/g;
	my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');
	return $rline;
}
# I wonder if for call args it might be better to have a separate function which checks if the arg is scalar, array, array access, const
sub _emit_expression_C { my ($ast, $stref, $f, $info)=@_;
	my $Sf = $stref->{'Subroutines'}{$f};
# croak 'FIXME: port differences from _emit_expression_C_OLD(), LINE 588';
	# say Dumper($ast);
    if (ref($ast) eq 'ARRAY') {
        if (scalar @{$ast}==3) {
			if ($ast->[0] == 8) { #eq '^'
				(my $op, my $arg1, my $arg2) = @{$ast};
				$ast = [1,'pow',[27,$arg1,$arg2] ] ;
				# $ast->[0]='pow';
				# unshift @{$ast},1;# '&'

			}
			elsif ($ast->[0] == 1  and $ast->[1] eq 'mod') {#eq '&'
					shift @{$ast};
					# $ast->[0]= 7 ;# '%';
					my $arg1 = $ast->[1][1];
					my $arg2 = $ast->[1][2];
					$ast = [7,$arg1,$arg2];# '%';
					# croak Dumper $ast;
			}

            if ($ast->[0] == 1 or $ast->[0] ==10) { #  array access 10=='@' or function call 1=='&'
                (my $sigil, my $name, my $args) =@{$ast};
				# if (in_nested_set($Sf,'Vars',$name)) {
				# 	say "NAME $name is an ARRAY (".$ast->[0].')';
				# 	$ast->[0]=10;
				# } else {
				# 	say "NAME $name is a FUNCTION (".$ast->[0].')';
				# }
				if ($ast->[0] == 1) {
					my $mvar = $name;
					# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
					# The (float) cast is necessary because otherwise I get an "ambiguous" error
					$mvar=~s/^(abs|min|max)$/(float)f$1/;
					$mvar=~s/^am(ax|in)1$/(float)fm$1/;
					$mvar=~s/^alog$/(float)log/;
					$name = $mvar;
				 	$stref->{'CalledSub'}= $mvar;
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
								push @args_lst, _emit_expression_C($arg, $stref, $f,$info) unless $is_slice;
								$has_slices ||= $is_slice;
							}
						} else {
							# only one arg
							$args_lst[0] = _emit_expression_C($args, $stref, $f,$info);
							# return "$name("._emit_expression_C($args, $stref, $f).')';
						}

						if ($ast->[0]==10) { # An array access
							if( $args->[0]==29 and $args->[1] eq '1') { # if we have v(1)
								return '(*'.$name.')';
							} else {
								my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$name);
								my $dims =  $decl->{'Dim'};
								my $maybe_amp = $has_slices ? '&' : '';
		#						if (__all_bounds_numeric($dims)) {
		#							$expr_str.=$name.'['.__C_array_size($dims).',';
		#						} else {
								my $ndims = scalar @{$dims};

								my @ranges=();
								my @lower_bounds=();
								for my $boundspair (@{$dims}) {
									(my $lb, my $hb)=@{$boundspair };
									push @ranges, "(($hb - $lb )+1)";
									push @lower_bounds, $lb;
								}
								if ($ndims==1) {
									return $name.'[F1D2C('.join(',',@lower_bounds). ' , '.join(',',@args_lst).')]';
								} else {
									return $maybe_amp.$name.'[F'.$ndims.'D2C('.join(',',@ranges[0.. ($ndims-2)]).' , '.join(',',@lower_bounds). ' , '.join(',',@args_lst).')]';
								}
		#						}
							}
						} else {
							return "$name(".join(',',@args_lst).')';
						}
					} else { #  ')(', e.g. f(x)(y)
					die 'ERROR: f()() is not supported, sorry!'."\n";
						(my $sigil,my $args1, my $args2) = @{$args};
						my $args_str1='';
						my $args_str2='';
						if($args1->[0] == 27) { #eq ','
							my @args_lst1=();
							for my $idx (1 .. scalar @{$args1}-1) {
								my $arg = $args1->[$idx];
								push @args_lst1, _emit_expression_C($arg, $stref, $f,$info);
							}
							$args_str1=join(',',@args_lst1);

						} else {
							$args_str1= _emit_expression_C($args1, $stref, $f,$info);
						}
						if($args2->[0] == 27) { #eq ','
							my @args_lst2=();
							for my $idx (1 .. scalar @{$args2}-1) {
								my $arg = $args2->[$idx];
								push @args_lst2, _emit_expression_C($arg, $stref, $f,$info);
							}

							#                for my $arg (@{$args2->[1]}) {
							#    push @args_lst2, _emit_expression_C($arg, $stref, $f);
							#}
							$args_str2=join(',',@args_lst2);
						} else {
							$args_str2=_emit_expression_C($args2, $stref, $f,$info);
						}
						return "$name(".$args_str1.')('.$args_str2.')';
					}
				} else {
					return "$name()";
				}
            } else { # not '&' or '@'

                (my $opcode, my $lexp, my $rexp) =@{$ast};

                my $lv = (ref($lexp) eq 'ARRAY') ? _emit_expression_C($lexp, $stref, $f,$info) : $lexp;
                my $rv = (ref($rexp) eq 'ARRAY') ? _emit_expression_C($rexp, $stref, $f,$info) : $rexp;

                return $lv.$sigils[$opcode].$rv;
            }
        } elsif (scalar @{$ast}==2) { #  for '{'  and '$'

            (my $opcode, my $exp) =@{$ast};
            if ($opcode==0 ) {#eq '('
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_C($exp, $stref, $f,$info) : $exp;
                return "($v)";
            } elsif ($opcode==28 ) {#eq '(/'
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_C($exp, $stref, $f,$info) : $exp;
                return "{ $v }";
            } elsif ($opcode==2 or $opcode>28) {# eq '$' or constants
				if ($opcode == 34) {
					die 'ERROR: Fortran LABEL as arg is not supported, sorry!'."\n"; #  "*$exp" : $exp;   # Fortran LABEL, does not exist in C
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
					# warn "PTR: $ptr";
                    if ($ptr eq '') {
                        return $exp;
                    } else {
						return '('.$ptr.$exp.')';
                    }
				} else {
					return $exp;
				}
                # return ($opcode == 34) ?  "*$exp" : $exp;   # Fortran LABEL, does not exist in C
            } elsif ($opcode == 21 or $opcode == 4 or $opcode == 3) {# eq '.not.' '-'
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_C($exp, $stref, $f,$info) : $exp;
                return $sigils[$opcode]. $v;
            } elsif ($opcode == 27) { # ','
                croak Dumper($ast) if $DBG; # WHY is this here?
                my @args_lst=();
                for my $arg (@{$exp}) {
                    push @args_lst, _emit_expression_C($arg, $stref, $f,$info);
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
                    push @args_lst, _emit_expression_C($arg, $stref, $f,$info);
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
} # END of _emit_expression_C

sub _change_operators_to_C { (my $cond_expr) = @_;

my %C_ops =(
	'eq' => '==',
	'ne' => '!=',
	'le' => '<=',
	'ge' => '>=',
	'gt' => '>',
	'lt' => '<',
	'not' => '!',
	'and' => '&&',
	'or' => '||',
);
while ($cond_expr=~/\.(\w+)\./) {
	$cond_expr=~s/\.(\w+)\./$C_ops{$1}/;
}
	return $cond_expr;
}
#### #### #### #### END OF C TRANSLATION CODE #### #### #### ####

=info_emit_OpenCL_pipe_declarations
The original proposed syntax was

      integer :: velnw_0_velnw_1_smart_cache_u_i_j_k_pipe

and then further on

subroutine pipe_initialisation

    call ocl_pipe_real(velnw_0_velnw_1_smart_cache_u_i_j_k_pipe)
	! ...
end subroutine pipe_initialisation

But I want to replace this with

      integer :: velnw_0_velnw_1_smart_cache_u_i_j_k_pipe !$OCL pipe real



=cut

 sub _emit_OpenCL_pipe_declarations {
 (my $stref, my $f, my $ocl) = @_;

if ($stref->{'OpenCL'}==3) {
    my $pass_emit_OpenCL_pipe_declarations = sub { (my $annline, my $state)=@_;
        (my $line,my $info)=@{$annline};
        my $c_line=$line;
        (my $stref, my $f, my $pass_state)=@{$state};
#       say Dumper($stref->{'Subroutines'}{$f}{'DeletedArgs'});
        my $skip=1;

        if (exists $info->{'VarDecl'}) {
                my $var = $info->{'VarDecl'}{'Name'};
#               croak Dumper($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}) if $var eq 'f';
                if ($ocl==3 and exists $info->{'TrailingComment'} ) {#and exists $stref->{'Modules'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}) {
                	my $decl=get_var_record_from_set($stref->{'Modules'}{$f}{'Vars'},$var);
                	my @pragma_chunks = split(/\s+/,$info->{'TrailingComment'});

                	if ($pragma_chunks[0] eq '$OCL' or $pragma_chunks[0] eq '$ACC' or $pragma_chunks[0] eq '$RF4A') {
                		if ($pragma_chunks[1] eq 'pipe') {
                            my $ftype = $pragma_chunks[2];
                            $c_line = $info->{'Indent'}.'pipe '.toCType($ftype).' '.$var.' __attribute__((xcl_reqd_pipe_depth(32)));'; # TODO: make configurable, this is Xilinx-specific!
                		}
                	}
                    $skip=0;
                }
        }
        push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line unless $skip;

        return ([$annline],[$stref,$f,$pass_state]);
    };

    my $state = [$stref,$f, {'TranslatedCode'=>[]}];
    ($stref,$state) = stateful_pass_inplace($stref,$f,$pass_emit_OpenCL_pipe_declarations , $state,'emit_OpenCL_pipe_declarations() ' . __LINE__  ) ;

    $stref->{'Modules'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
    $stref->{'TranslatedCode'}=[@{$stref->{'TranslatedCode'}},@{$state->[2]{'TranslatedCode'}},''];
}

    return $stref;
 } # _emit_OpenCL_pipe_declarations
# -----------------------------------------------------------------------------



sub _emit_subroutine_call_expr_C { my ($stref,$f,$info) = @_;
	my @call_arg_expr_strs_C=();
	my $subname = $info->{'SubroutineCall'}{'Name'};

	my $mvar = $subname;
	# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
	# The (float) cast is necessary because otherwise I get an "ambiguous" error
	$mvar=~s/^(abs|min|max)$/(float)f$1/;
	$mvar=~s/^am(ax|in)1$/(float)fm$1/;
	$mvar=~s/^alog$/(float)log/;
	my $subname_C = $mvar;

	for my $call_arg_expr_str (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
		my $arg_type = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'};
			if ( $arg_type eq 'Scalar') {
				my $ptr = '';
				# If it is a parameter, it will get an '&'.
				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$call_arg_expr_str}) {
					$ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$call_arg_expr_str};
					$ptr = $ptr ne '&' ? '' : $ptr;
				}
				push @call_arg_expr_strs_C, "$ptr$call_arg_expr_str";
			}
			elsif ( $arg_type eq 'Array') {
				# This is an array access.
				my $call_arg_expr_str_C='';
				my $name = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Arg'};
				my $args = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'AST'}[2];
# croak Dumper $args if $info->{'SubroutineCall'}{'Name'} eq 'update_map_24';
				my @args_lst=();
				my $has_slices=0;
				if($args->[0] == 27) { # ','
				# more than one arg
					for my $idx (1 .. scalar @{$args}-1) {
						my $arg = $args->[$idx];
						my $is_slice = $arg->[0] == 12;
						push @args_lst, _emit_expression_C($arg, $stref, $f,$info) unless $is_slice;
						$has_slices ||= $is_slice;
					}
				} else {
					# only one arg
					$args_lst[0] = _emit_expression_C($args, $stref, $f,$info);
				}

				if( $args->[0]==29 and $args->[1] eq '1') { # if we have v(1)
					push @call_arg_expr_strs_C, '(*'.$name.')';
				} else {
					my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$name);
					my $dims =  $decl->{'Dim'};
					my $ndims = scalar @{$dims};

					my @ranges=();
					my @lower_bounds=();
					for my $boundspair (@{$dims}) {
						(my $lb, my $hb)=@{$boundspair };
						push @ranges, "(($hb - $lb )+1)";
						push @lower_bounds, $lb;
					}
					if ($ndims==1) {
						my $offset_expr = '-'.$lower_bounds[0];
						if ($lower_bounds[0]<0) {
								$offset_expr = '+'.($lower_bounds[0]*-1);
						} elsif ($lower_bounds[0]==0) {
							$offset_expr = '';
						}
						push @call_arg_expr_strs_C, '&'.$name.'['.$args_lst[0].''.$offset_expr.']'; #F1D2C('.$lower_bounds[0]. ', '.
					} else {
						push @call_arg_expr_strs_C, '&'.$name.'[F'.$ndims.'D2C('.join(',',@ranges[0.. ($ndims-2)]).' , '.join(',',@lower_bounds). ' , '.join(',',@args_lst).')]';
					}
				}
				# push @call_arg_expr_strs_C, $call_arg_expr_str_C;
			}
			elsif ( $arg_type eq 'Expr') {
				croak "TODO: Can't handle arguments of type $arg_type yet.";
			}
			else {
				# Probably a Label, give up
				croak "Can't handle arguments of type $arg_type yet.";
			}

	}
	# croak Dumper join(", ", @call_arg_expr_strs_C) if  eq 'update_map_24';
	return $subname_C.'('.join(", ", @call_arg_expr_strs_C).')';
} # END of _emit_subroutine_call_expr_C


# -----------------------------------------------------------------------------
sub toCType {
    ( my $ftype, my $kind ) = @_;

    if (not defined $kind) {$kind=4};
	if ($kind=~/kind/) {$kind=~s/kind\s*=\s*//;}; # FIXME, this should have been sorted in the Parser

    my %corr = (
        'logical'          => 'int', # C has no bool
        'integer'          => ($ftype eq 'integer' and $kind == 8 ? 'long' : 'int'),
        'real'             => ($ftype eq 'real' and $kind == 8 ? 'double' : 'float'),
        'double precision' => 'double',
        'doubleprecision'  => 'double',
        'character'        => 'char'
    );
    if ( exists( $corr{$ftype} ) ) {
        return $corr{$ftype};
    } else {
        print "WARNING: NO TYPE for $ftype\n" if $W;
        return 'NOTYPE';
    }
}    # END of toCType()
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
	# open RefactorF4Acc::Translation::OpenCLC::DATA or die $!;
	if (not -d $targetdir) {
		mkdir $targetdir;
	}
	open my $fh, '>', $targetdir.'/array_index_f2c1d.h' or die "$! : $targetdir";
	while(my $line = <RefactorF4Acc::Translation::OpenCLC::DATA>) {
		print $fh $line;
	}
	close $fh;
	close RefactorF4Acc::Translation::OpenCLC::DATA;
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
