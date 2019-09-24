package RefactorF4Acc::Translation::OpenCLC;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );
use RefactorF4Acc::Refactoring::Common qw( stateful_pass pass_wrapper_subs_in_module update_arg_var_decl_sourcelines);
use RefactorF4Acc::Refactoring::Fixes qw( _declare_undeclared_variables _removed_unused_variables _fix_scalar_ptr_args _fix_scalar_ptr_args_subcall );
use RefactorF4Acc::Parser::Expressions qw( @sigils );
use RefactorF4Acc::Translation::LlvmToTyTraIR qw( generate_llvm_ir_for_TyTra );

# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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
	
	$stref = pass_wrapper_subs_in_module($stref,$module_name,
	   # module-specific passes.  
       [
           [\&_emit_OpenCL_pipe_declarations]
       ],
       # subroutine-specific passes 	
	   [
		  [\&determine_argument_io_direction_rec,\&update_arg_var_decl_sourcelines,\&_declare_undeclared_variables],#,\&_removed_unused_variables],
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
}
sub add_OpenCL_address_space_qualifiers { (my $stref, my $f, my $ocl) = @_;
	
	if ($ocl>=1) { 
		if (not exists $Config{'KERNEL'} and exists $Config{'TOP'}) {
			$Config{'KERNEL'}=$Config{'TOP'}
		} else {
			$Config{'KERNEL'}='';
		}
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
#							my $decl = $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
							my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg);
#							say $f.Dumper( $stref->{'Subroutines'}{$f}{'Args'} );
#							say $arg.Dumper($decl);
							if ($decl->{'ArrayOrScalar'} eq 'Array') {								
								$decl->{'OclAddressSpace'} = '__global';
							} 
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
 			($stref,$state) = stateful_pass($stref,$f,$pass_add_OpenCL_address_space_qualifiers, $state,'pass_add_OpenCL_address_space_qualifiers() ' . __LINE__  ) ;
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
		 		
=cut


	my $pass_translate_to_C = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
#		say Dumper($stref->{'Subroutines'}{$f}{'DeletedArgs'});
		my $skip=0;
		if (exists $info->{'Signature'} ) {
			$pass_state->{'Args'}=$info->{'Signature'}{'Args'}{'List'};
			# WV20190823 I think this is OBSOLETE			
			if($ocl==3 and $info->{'Signature'}{'Name'} eq 'pipe_initialisation') {
				$c_line='';	
			} else {
			$c_line = _emit_subroutine_sig_C( $stref, $f, $annline);
			if ($ocl==3 or ($ocl==1 and $f eq $Config{'KERNEL'})) {
				$c_line = '__kernel __attribute__((reqd_work_group_size(1,1,1))) '.$c_line;
			}
			}
		}
		elsif (exists $info->{'VarDecl'} ) {
			
				my $var = $info->{'VarDecl'}{'Name'};
#				croak Dumper($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}) if $var eq 'f';
				if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}
				or ($ocl==3 and $var=~/__pipe$/)
				) {
					$c_line='//'.$line;
					$skip=1;
				} else {
									
					$c_line = _emit_var_decl_C($stref,$f,$var);
					if (exists $info->{'TrailingComment'} and $info->{'TrailingComment'}=~/\$ACC\s+MemSpace\s+(\w+)/) {
						# This code will basically only work for arrays with dimensions defined by constants and macros
#						croak Dumper($var);
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
			my $switch_expr = _emit_expression_C([2,$info->{'CaseVar'}],$stref,$f); # FIXME
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
		elsif (exists $info->{'Do'} ) { #say $line.Dumper($info->{Expressions});
		# bit ad-hoc but we need to check this for macros too.
#			for my $macro (keys %{ $Config{'Macros'} } ) {
#				my $lc_macro=lc($macro);
#				for my $i (0 ..2) {
#					$info->{'Do'}{'Range'}{'Expressions'}[$i]=~s/\b$lc_macro\b/$macro/g;
#				}				
#			}
			# do r_iter=start_position, ((start_position + local_chunk_size) - 1)
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
			# say Dumper($subcall_ast);
			# $subcall_ast->[0] = 1; # FIXME '&';

			# There is an issue here:
			# We actually need to check the type of the called arg against the type of the sig arg
			# If the called arg is a pointer and the sig arg is a pointer, no '*', else, we need a '*'
			# But the problem is of course that we have just replaced the called args by the sig args
			# So what we need to do is check the type in $f and $subname, and use that to see if we need a '*' or even an '&' or nothing
			
			if ($subcall_ast->[1] eq 'barrier') {
				$subcall_ast->[2][1]=uc($subcall_ast->[2][1]);
#				push @{$pass_state->{'TranslatedCode'}},'#ifdef BARRIER_OK';
				$c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,$stref,$f).';';
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
				my $qual = $1;
				$c_line = $info->{'Indent'}."${qual}_id = get_${qual}_id(0);";
			} else {
				
				$c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,$stref,$f).';';
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
		elsif (exists $info->{'EndDo'} or exists $info->{'EndIf'}  or exists $info->{'EndSubroutine'} ) {
			if ($ocl==3 and  exists $info->{'EndSubroutine'} and  $info->{'EndSubroutine'}{'Name'} eq 'pipe_initialisation') {
				     $c_line = '' ;
#			} elsif ($ocl==2 and  exists $info->{'EndSubroutine'} and  $info->{'EndSubroutine'}{'Name'} eq $Config{'TOP'}) {
#				     $c_line = '*/' ;
			} else {
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
		if (exists $info->{'Label'} ) {
			$c_line = $info->{'Label'}. ' : '."\n".$info->{'Indent'}.$c_line;
		}
		
		push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line unless $skip;
		
		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f, {'TranslatedCode'=>[], 'Args'=>[]}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_translate_to_C, $state,'C_translation_collect_info() ' . __LINE__  ) ;

 	$stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
 	$stref->{'TranslatedCode'}=[@{$stref->{'TranslatedCode'}},@{$state->[2]{'TranslatedCode'}}];	
	# For fixing LLVM IR
	$stref->{'SubroutineArgs'}=$state->[2]{'Args'};
	$stref->{'SubroutineName'}=$f;
 	return $stref;
	
} # END of translate_sub_to_C()

# FIXME: only include if they are actually used in the code!
sub _write_headers { (my $stref, my $ocl)=@_;
	
	my @headers= grep { $_ ne '' } (
		# 0 means C, needs the header; 
		( $ocl>0 ? '' : '#include <stdlib.h>'),
		( $ocl>0 and $ocl!=2 ? '' : '#include <math.h>'),
		( $ocl>0 ? '' : 'inline unsigned int get_global_id(unsigned int n) { return 0; }'),
		($ocl != 2 ? '#include "array_index_f2c1d.h"' : ''),
		''
		);
		$stref->{'TranslatedCode'}=[@headers,@{$stref->{'TranslatedCode'}}];
		return $stref;
} # END of _write_headers()

sub _emit_C_code { (my $stref, my $module_name, my $ocl)=@_;
 	map {say $_ } @{$stref->{'TranslatedCode'}} if $V;
 	my $ext = ($ocl and $ocl!=2) ? 'cl' : 'c';
 	my $module_src = $stref->{'Modules'}{$module_name}{'Source'};
	if (not defined $module_src) {
		$module_src=$Config{'MODULE_SRC'};
	} 
 	my $fsrc = $module_src;#$Config{'MODULE_SRC'}; 
# 	croak $fsrc;
 	my $csrc = $fsrc;$csrc=~s/\.\w+$//;
    if (not -d $targetdir) {
        mkdir $targetdir;
    }
 	open my $OUT, '>', "$targetdir/$csrc.$ext";
 	map {say $OUT $_ } @{$stref->{'TranslatedCode'}};
 	close $OUT;
	return $stref;
} # END of _emit_C_code

sub _emit_subroutine_sig_C { (my $stref, my $f, my $annline)=@_;
#	say "//SUB $f";
	    (my $line, my $info) = @{ $annline };
	    my $Sf        = $stref->{'Subroutines'}{$f};
	    
	    my $name = $info->{'Signature'}{'Name'};
#	    say "NAME $name";
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
		my $c_args_ref=[];	    			
		for my $arg (@{ $args_ref }) {
			($stref,my $c_arg_decl) = _emit_arg_decl_C($stref,$f,$arg);
			push @{$c_args_ref},$c_arg_decl;
		}
	    my $args_str = join( ',', @{$c_args_ref} );	    
	    my $rline = "void $name($args_str) {\n";
		return  $rline;
}

sub _emit_arg_decl_C { (my $stref,my $f,my $arg)=@_;
    
	my $decl_for_iodir =	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg) ;
	    
#	croak Dumper($decl2) if $f eq 'dyn_0' and $arg eq 'dx';
	my $array = $decl->{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
	my $const = 1;
	if (not defined $decl_for_iodir->{'IODir'}) {
		$const = 0;
	} else { 
		$const =    lc($decl_for_iodir->{'IODir'}) eq 'in' ? 1 : 0;
	}
	my $is_ptr =$array || ($const==0);
	my $ptr = $is_ptr ? '*' : '';
    #die "$ptr $arg" if $f =~/shapiro_map/ && $arg eq 'eta_j_k';
	$stref->{'Subroutines'}{$f}{'Pointers'}{$arg}=$ptr;	
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
	my $const = '';
	my $val='';	
	if (defined $decl->{'Parameter'}) {
		$const = 'const ';
		$val = ' = '.$decl->{'Val'};
	}
	my $ocl = $stref->{'OpenCL'};
	my $ptr = ($array && $ocl<3) ? '*' : '';
   	
	my $dim= ($array && $ocl==3 ) ? '['.__C_array_size($decl->{'Dim'}).']' : '';
	$stref->{'Subroutines'}{$f}{'Pointers'}{$var}=$ptr;
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
	my $lhs = _emit_expression_C($lhs_ast,$stref,$f);
	   
	my $indent='';
	$lhs=~/^(\s+)/ && do {
		$indent=$1;
		$lhs=~s/^\s+//;	
	};
	$lhs=~s/^\(([^\(\)]+)\)/$1/;
	$lhs=$indent.$lhs;

	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};	
#	carp Dumper($rhs_ast) if $lhs=~/k_range/;
    
	my $rhs = _emit_expression_C($rhs_ast,$stref,$f);
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
#	say $rhs_stripped;
	my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
	if (exists $info->{'If'}) {
		my $if_str = _emit_ifthen_C($stref,$f,$info);
		$rline =$if_str.' '.$rline; 
	}	
	return $rline;
}



sub _emit_ifthen_C { (my $stref, my $f, my $info)=@_;	
	my $cond_expr_ast=$info->{'CondExecExprAST'};	
	my $cond_expr = _emit_expression_C($cond_expr_ast,$stref,$f);
	$cond_expr=_change_operators_to_C($cond_expr);
	# FIXME! fix for stray '+'
	$cond_expr=~s/\+\>/>/g;
	my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');		
	return $rline;
}

sub _emit_expression_C { my ($ast, $stref, $f)=@_;
	my $Sf = $stref->{'Subroutines'}{$f};
# croak 'FIXME: port differences from _emit_expression_C_OLD(), LINE 588';
#	say Dumper($ast);
    if (ref($ast) eq 'ARRAY') {
        if (scalar @{$ast}==3) {
			if ($ast->[0] == 8) { #eq '^'
				$ast->[0]='pow';
				unshift @{$ast},1;# '&' 
			} 
			elsif ($ast->[0] == 1  and $ast->[1] eq 'mod') {#eq '&'
					shift @{$ast};
					# $ast->[0]= 7 ;# '%';
					my $arg1 = $ast->[1][1];
					my $arg2 = $ast->[1][2];
					$ast = [7,$arg1,$arg2];# '%';
					# croak Dumper $ast;
			}

            if ($ast->[0] ==1 or $ast->[0] ==10) { # '&' array access or function call
                (my $sigil, my $name, my $args) =@{$ast};
				# if (in_nested_set($Sf,'Vars',$name)) {
				# 	say "NAME $name is an ARRAY (".$ast->[0].')';
				# 	$ast->[0]=10;
				# } else {
				# 	say "NAME $name is a FUNCTION (".$ast->[0].')';
				# }
				if ($ast->[0] ==1) {
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

						if($args->[0] == 27) { # ','
						# more than one arg
							for my $idx (1 .. scalar @{$args}-1) {
								my $arg = $args->[$idx];
								push @args_lst, _emit_expression_C($arg, $stref, $f);
							}

							#                    for my $arg (@{$args->[1]}) {
							#       push @args_lst, _emit_expression_C($arg, $stref, $f;
							#    }
							
							# return "$name(".join(',',@args_lst).')';
						} else {
							# only one arg
							$args_lst[0] = _emit_expression_C($args, $stref, $f);
							# return "$name("._emit_expression_C($args, $stref, $f).')';
						}

						if ($ast->[0]==10) { 
							if( $args->[0]==29 and $args->[1] eq '1') {
								return '(*'.$name.')';
							} else {
									my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$name);
									my $dims =  $decl->{'Dim'};
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
											return $name.'[F'.$ndims.'D2C('.join(',',@ranges[0.. ($ndims-2)]).' , '.join(',',@lower_bounds). ' , '.join(',',@args_lst).')]';
										}
			#						}
							}
						} else {							
							return "$name(".join(',',@args_lst).')';
						}
					} else { #  ')(', e.g. f(x)(y)
					croak 'f()() is not supported, sorry!';
						(my $sigil,my $args1, my $args2) = @{$args};
						my $args_str1='';
						my $args_str2='';
						if($args1->[0] == 27) { #eq ',' 
							my @args_lst1=();
							for my $idx (1 .. scalar @{$args1}-1) {
								my $arg = $args1->[$idx];
								push @args_lst1, _emit_expression_C($arg, $stref, $f);
							}
							$args_str1=join(',',@args_lst1);

						} else {
							$args_str1= _emit_expression_C($args1, $stref, $f);
						}
						if($args2->[0] == 27) { #eq ','
							my @args_lst2=();
							for my $idx (1 .. scalar @{$args2}-1) {
								my $arg = $args2->[$idx];
								push @args_lst2, _emit_expression_C($arg, $stref, $f);
							}

							#                for my $arg (@{$args2->[1]}) {
							#    push @args_lst2, _emit_expression_C($arg, $stref, $f);
							#}
							$args_str2=join(',',@args_lst2);
						} else {
							$args_str2=_emit_expression_C($args2, $stref, $f);
						}
						return "$name(".$args_str1.')('.$args_str2.')';
					}
				} else {
					return "$name()";
				}			
            } else { # not '&' or '@'
				
                (my $opcode, my $lexp, my $rexp) =@{$ast};
				
                my $lv = (ref($lexp) eq 'ARRAY') ? _emit_expression_C($lexp, $stref, $f) : $lexp;
                my $rv = (ref($rexp) eq 'ARRAY') ? _emit_expression_C($rexp, $stref, $f) : $rexp;
				
                return $lv.$sigils[$opcode].$rv;
            }
        } elsif (scalar @{$ast}==2) { #  for '{'  and '$'
		
            (my $opcode, my $exp) =@{$ast};
            if ($opcode==0 ) {#eq '('
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_C($exp, $stref, $f) : $exp;
                return "($v)";
            } elsif ($opcode==28 ) {#eq '(/'
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_C($exp, $stref, $f) : $exp;
                return "{ $v }";
            } elsif ($opcode==2 or $opcode>28) {# eq '$' or constants
				if ($opcode == 34) {
					croak 'Fortran LABEL as arg is not supported, sorry!'; #  "*$exp" : $exp;   # Fortran LABEL, does not exist in C
				}
				my $mvar = $ast->[1];
				my $called_sub_name = $stref->{'CalledSub'} // '';
				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar} ) {
					# Meaning that $mvar is a pointer in $f
					# Now we need to check if it is also a pointer in $subname
					my $ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar};
					if ($called_sub_name ne '' and exists  $stref->{'Subroutines'}{$called_sub_name} 
					and exists $stref->{'Subroutines'}{$called_sub_name}{'Pointers'}{$mvar} ) {
						my $sig_ptr = $stref->{'Subroutines'}{$called_sub_name}{'Pointers'}{$mvar};
						if ($sig_ptr eq '' and $ptr eq '*') {
							$ptr = '*'	
						} elsif ($sig_ptr eq '*' and $ptr eq '') {
							$ptr = '&'
						} else {
							$ptr='';
						}
					} 
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
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_C($exp, $stref, $f) : $exp;
                return $sigils[$opcode]. $v;
            } elsif ($opcode == 27) { # ',' 
                croak Dumper($ast); # WHY is this here?
                my @args_lst=();
                for my $arg (@{$exp}) {
                    push @args_lst, _emit_expression_C($arg, $stref, $f);
                }
                return join(',',@args_lst);        
            } else {
                die 'BOOM! '.Dumper($ast).$opcode;
            }
        } elsif (scalar @{$ast} > 3) {

            if($ast->[0] == 27) { # ','
                my @args_lst=();
                for my $idx (1 .. scalar @{$ast}-1) {
                    my $arg = $ast->[$idx];
                    push @args_lst, _emit_expression_C($arg, $stref, $f);
                }
                return join(',',@args_lst); 
            } else {
                croak Dumper($ast);
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
    ($stref,$state) = stateful_pass($stref,$f,$pass_emit_OpenCL_pipe_declarations , $state,'emit_OpenCL_pipe_declarations() ' . __LINE__  ) ;

    $stref->{'Modules'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
    $stref->{'TranslatedCode'}=[@{$stref->{'TranslatedCode'}},@{$state->[2]{'TranslatedCode'}},''];
}
   
    return $stref; 	
 } # _emit_OpenCL_pipe_declarations
# -----------------------------------------------------------------------------

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

#    for my $inc ( keys %{ $stref->{$sub_or_func}{$f}{'Includes'} } ) {
#        if ( not exists $stref->{'BuildSources'}{'H'}{$inc} ) {
#            print "ADDING $inc to C Header BuildSources\n" if $V;
#            $stref->{'BuildSources'}{'H'}{$inc} = 1;
#        }
#    }
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
