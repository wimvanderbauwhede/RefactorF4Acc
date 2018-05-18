package RefactorF4Acc::CTranslation;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( stateful_pass pass_wrapper_subs_in_module );
use RefactorF4Acc::Refactoring::Streams qw( _declare_undeclared_variables _removed_unused_variables _fix_scalar_ptr_args _fix_scalar_ptr_args_subcall );
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::CTranslation::ISA = qw(Exporter);

@RefactorF4Acc::CTranslation::EXPORT_OK = qw(
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

sub translate_module_to_C {  (my $stref, my $ocl) = @_;
	if (not defined $ocl) {$ocl=0;}
	$stref->{'OpenCL'}=$ocl;
	$stref->{'TranslatedCode'}=[];	
	
	$stref = pass_wrapper_subs_in_module($stref,[
#					[ sub { (my $stref, my $f)=@_;  
#						alias_ordered_set($stref,$f,'DeclaredOrigArgs','RefactoredArgs'); 
##						say $f.' => '.Dumper($stref->{Subroutines}{$f}{DeclaredOrigArgs}) if $f eq 'adam_bondv1_feedbf_les_press_v_etc_superkernel';#adam_bondv1_feedbf_les_press_v_etc_superkernel
##						croak if $f eq 'adam_bondv1_feedbf_les_press_v_etc_superkernel'; 
#					} ],
#					[ \&_fix_scalar_ptr_args ],
#		  		[\&_fix_scalar_ptr_args_subcall],	
		[\&_declare_undeclared_variables],#,\&_removed_unused_variables],
		[\&add_OpenCL_address_space_qualifiers],
		[\&translate_sub_to_C]
		],$ocl);
		
	$stref = _write_headers($stref,$ocl);
	$stref = _emit_C_code($stref, $ocl);
}
sub add_OpenCL_address_space_qualifiers { (my $stref, my $f, my $ocl) = @_;		
	
	if ($ocl==1) {
		if ($f eq $Config{'KERNEL'} ) {


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
#							say in_nested_set($stref->{'Subroutines'}{$f},'Vars',$arg);
#							say "$f => $arg:\n".Dumper($decl);

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
						my $call_arg_expr =  $info->{'CallArgs'}{'Set'}{$call_arg}{'Expr'};
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
			$c_line = _emit_subroutine_sig_C( $stref, $f, $annline);
			if ($ocl==1 and $f eq $Config{'KERNEL'}) {
				$c_line = '__kernel '.$c_line;
			}
		}
		elsif (exists $info->{'VarDecl'} ) {
			
				my $var = $info->{'VarDecl'}{'Name'};
#				croak Dumper($stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}) if $var eq 'f';
				if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}
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
			my $switch_expr = _emit_expression_C(['$',$info->{'CaseVar'}],'',$stref,$f);
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
			my $subcall_ast = $info->{'SubroutineCall'}{'ExpressionAST'};
			$subcall_ast->[0] = '&';
			# There is an issue here:
			# We actually need to check the type of the called arg against the type of the sig arg
			# If the called arg is a pointer and the sig arg is a pointer, no '*', else, we need a '*'
			# But the problem is of course that we have just replaced the called args by the sig args
			# So what we need to do is check the type in $f and $subname, and use that to see if we need a '*' or even an '&' or nothing
			
			if ($subcall_ast->[1] eq 'barrier') {
				$subcall_ast->[2][1]=uc($subcall_ast->[2][1]);
#				push @{$pass_state->{'TranslatedCode'}},'#ifdef BARRIER_OK';
				$c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,'',$stref,$f).';';
				push @{$pass_state->{'TranslatedCode'}},$c_line ;
#				push @{$pass_state->{'TranslatedCode'}},'#endif // BARRIER_OK';
				$skip=1;
			}
			elsif ($subcall_ast->[1]=~/get_(local|global|group)_id/) {
				my $qual = $1;
				$c_line = $info->{'Indent'}."${qual}_id = get_${qual}_id(0);";
			} else {
				$c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,'',$stref,$f).';';
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
				 $c_line = '}';
		}
		elsif (exists $info->{'EndSelect'} ) {
				 $c_line = '    }'."\n".$info->{'Indent'}.'}';
		}
		
		elsif (exists $info->{'Comments'} ) {
			$c_line = $line;
			$c_line=~s/\!/\/\//;
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

	my $state = [$stref,$f, {'TranslatedCode'=>[]}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_translate_to_C, $state,'C_translation_collect_info() ' . __LINE__  ) ;

 	$stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
 	$stref->{'TranslatedCode'}=[@{$stref->{'TranslatedCode'}},@{$state->[2]{'TranslatedCode'}}];
# 	croak Dumper($stref->{'TranslatedCode'});
 	return $stref;
	
} # END of translate_sub_to_C()

sub _write_headers { (my $stref, my $ocl)=@_;
	
	my @headers=(
		($ocl ? '' : '#include <stdlib.h>'),
		($ocl ? '' : '#include <math.h>'),
		($ocl ? '' : 'inline unsigned int get_global_id(unsigned int n) { return 0; }'),
		'#include "array_index_f2c1d.h"',
		''
		);
		$stref->{'TranslatedCode'}=[@headers,@{$stref->{'TranslatedCode'}}];
		return $stref;
} # END of _write_headers()

sub _emit_C_code { (my $stref, my $ocl)=@_;
 	map {say $_ } @{$stref->{'TranslatedCode'}} if $V;
 	my $ext = $ocl ? 'cl' : 'c';
 	my $fsrc = $Config{'MODULE_SRC'};
 	my $csrc = $fsrc;$csrc=~s/\.\w+$//;
 	open my $OUT, '>', "$csrc.$ext";
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
#	my $decl =	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};

	my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg);
	die Dumper($decl) if $arg eq 'kp' and $f eq 'adam_map_22';
	my $array = $decl->{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
	my $const = 1;
	if (not defined $decl->{'IODir'}) {
		$const = 0;
	} else { 
		$const =    lc($decl->{'IODir'}) eq 'in' ? 1 : 0;
	}
	my $is_ptr =$array || ($const==0);
	my $ptr = $is_ptr ? '*' : '';
	$stref->{'Subroutines'}{$f}{'Pointers'}{$arg}=$ptr;	
	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=4};
	my $c_type = toCType($ftype,$fkind);
	my $ocl_address_space = ($stref->{'OpenCL'} ==1 and exists $decl->{'OclAddressSpace'} and $is_ptr ) ? $decl->{'OclAddressSpace'}.' ' : '';
	my $maybe_const = ($stref->{'OpenCL'} ==1 and $f eq $Config{'KERNEL'} and $ocl_address_space eq '') ? 'const ' : ''; 	
	my $c_arg_decl = $ocl_address_space . $maybe_const . $c_type.' '.$ptr.$arg;
	return ($stref,$c_arg_decl);
}



sub _emit_var_decl_C { (my $stref,my $f,my $var)=@_;
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
#croak "SUB $f => VAR $var =>".Dumper($decl) if $var=~/local_aaa/;
# {'Var' => 'st_sub_map_124','Status' => 1,'Dim' => [],'Attr' => '','Type' => {'Type' => 'integer'},'Val' => '0','Indent' => '  ','Name' => ['st_sub_map_124','0'],'InheritedParams' => undef,'Parameter' => 'parameter'}		
	my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
	my $const = '';
	my $val='';
	if (defined $decl->{'Parameter'}) {
		$const = 'const ';
		$val = ' = '.$decl->{'Val'};
#		croak Dumper($decl) if $var eq 'alpha';
		#say "PARAM $var => $val" if $var=~/st_\w+_(map|reduce)_\d+/;
	}
	my $ptr = $array  ? '*' : '';
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
	my $c_var_decl = $const.$c_type.' '.$ptr.$var.$val.';';
	return ($stref,$c_var_decl);
}

sub _emit_assignment_C { (my $stref, my $f, my $info)=@_;
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
#	say Dumper($lhs_ast);
	my $lhs = _emit_expression_C($lhs_ast,'',$stref,$f);
	my $indent='';
	$lhs=~/^(\s+)/ && do {
		$indent=$1;
		$lhs=~s/^\s+//;	
	};
	$lhs=~s/^\(([^\(\)]+)\)/$1/;
	$lhs=$indent.$lhs;
#	croak $lhs.Dumper($lhs_ast) if $lhs=~/F1D2C/;
	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};	
#	carp Dumper($rhs_ast) if $lhs=~/k_range/;

	my $rhs = _emit_expression_C($rhs_ast,'',$stref,$f);
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
	my $cond_expr = _emit_expression_C($cond_expr_ast,'',$stref,$f);
	$cond_expr=_change_operators_to_C($cond_expr);
	# FIXME! fix for stray '+'
	$cond_expr=~s/\+\>/>/g;
	my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');		
	return $rline;
}

sub _emit_expression_C {(my $ast, my $expr_str, my $stref, my $f)=@_;
#	carp Dumper($ast);
	if (ref($ast) ne 'ARRAY') {return $ast;}
	my @expr_chunks=();
	my $skip=0;
	
	if ($ast->[0] eq '^') {
		$ast->[0]='pow';
		unshift @{$ast},'&';		
	} 
	elsif ($ast->[0] eq '&' && $ast->[1] eq 'mod') {		
		shift @{$ast};
		$ast->[0]='%';	
	}
	
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			 my $nest_expr_str = _emit_expression_C( $entry, '',$stref,$f);
#			 say "NEST:$nest_expr_str ";
			push @expr_chunks, $nest_expr_str;
		} else {
			if ($entry =~/#/) {
				$skip=1;
			} elsif ($entry eq '&') {
				my $mvar = $ast->[$idx+1];
				# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
				# The (float) cast is necessary because otherwise I get an "ambiguous" error
				$mvar=~s/^(abs|min|max)$/(float)f$1/;
				$mvar=~s/^am(ax|in)1$/(float)fm$1/;				
				$mvar=~s/^alog$/(float)log/;				
				$expr_str.=$mvar.'(';
				
				 $stref->{'CalledSub'}= $mvar;
				 
				$skip=1;
			} elsif ($entry eq '$') {
				my $mvar = $ast->[$idx+1];
#				carp $mvar;
				my $called_sub_name = $stref->{'CalledSub'} // '';
                #WV20170515
#    			for my $macro (keys %{ $Config{'Macros'} } ) {
#	    			my $lc_macro=lc($macro);
#					$mvar=~s/\b$lc_macro\b/$macro/g;
#		    	}

				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar} ) {
					# Meaning that $mvar is a pointer in $f
					# Now we need to check if it is also a pointer in $subname
					my $ptr = $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar};
					if ($called_sub_name ne '' and exists  $stref->{'Subroutines'}{$called_sub_name} 
					and exists  $stref->{'Subroutines'}{$called_sub_name}{'Pointers'}{$mvar} ) {
						my $sig_ptr = $stref->{'Subroutines'}{$called_sub_name}{'Pointers'}{$mvar};
						if ($sig_ptr eq '' and $ptr eq '*') {
							$ptr = '*'	
						} elsif ($sig_ptr eq '*' and $ptr eq '') {
							$ptr = '&'
						} else {
							$ptr='';
						}
					}
					
					push @expr_chunks,  $ptr eq '' ? $mvar : '('.$ptr.$mvar.')';
				} else {
					push @expr_chunks,$mvar;
				}
				$skip=1;				
			} elsif ($entry eq '@') {
				
				my $mvar = $ast->[$idx+1];
				if ($mvar eq '_OPEN_PAR_') {
					$expr_str.=$mvar.'(';
#				} elsif ($mvar eq 'abs' ) { croak;
#					$expr_str.=$mvar.'(';					
				} else {
					if (scalar @{$ast} == 3 and $ast->[2] eq '1') {
						$expr_str.='(*'.$mvar.')';
						$ast->[2]='';
						$ast->[0]='$';
#						croak Dumper($ast);
					}  else {
					my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$mvar);
					my $dims =  $decl->{'Dim'};
					my $dim = scalar @{$dims};
					my @ranges=();
					my @lower_bounds=();
					for my $boundspair (@{$dims}) {
						(my $lb, my $hb)=@{$boundspair };
						push @ranges, "(($hb - $lb )+1)";
						push @lower_bounds, $lb; 
					} 				
				# For convenience we define a different function, not FTNREF
				 # F3D2C(
#                        unsigned int iz,unsigned int jz, // ranges, i.e. (hb-lb)+1
#                                int i_lb, int j_lb, int k_lb, // lower bounds
#                int ix, int jx, int kx)
# with the same definition as FTN3DREF
					if ($dim==0) { die Dumper $decl;
						
					} elsif ($dim==1) {
						$expr_str.=$mvar.'[F1D2C('.join(',',@lower_bounds). ' , ';
					} else {
						$expr_str.=$mvar.'[F'.$dim.'D2C('.join(',',@ranges[0.. ($dim-2)]).' , '.join(',',@lower_bounds). ' , ';						
					}
					}
				}
				$skip=1;
			} elsif (
				$ast->[$idx-1]!~/^[\&\@\$]/ 
			) {
#				say "ENTRY:$entry SKIP: $skip";
				push @expr_chunks,$entry;
				$skip=0;
			}
		}				
	} # for
	if ($ast->[0] eq '&' ) {
		my @expr_chunks_stripped = map { $_=~s/^\(([^\(\)]+)\)$/$1/;$_} @expr_chunks;
		if ($ast->[1] eq 'pow') {
				$expr_str.=join(',', map { "(float)($_)" } @expr_chunks_stripped);
		} else {
			$expr_str.=join(',',@expr_chunks_stripped);
		}
			$expr_str.=')'; 
		
			if ($ast->[1]  eq $stref->{'CalledSub'} ) {
				$stref->{'CalledSub'} ='';
			}
		
#		say "CLOSE OF &:".$expr_str if $expr_str=~/abs/;
	} elsif ( $ast->[0] eq '@') {				
		my @expr_chunks_stripped =   map {  $_=~s/^\(([^\(\)]+)\)$/$1/;$_} @expr_chunks;		
		if ( not ($expr_str=~/^\*/ and $expr_chunks_stripped[0]==1) ) { 
			$expr_str.=join(',',@expr_chunks_stripped);
			# But here we'd need to know what the var is!
			$expr_str.=')';
			if ($expr_str=~/\[/) {
				my $count_open_bracket = () =$expr_str=~/\[/;
				my $count_close_bracket = () =$expr_str=~/\]/; 
#				warn("FIXME: this is incorrect, I should count the brackets!");
				if ($count_open_bracket == $count_close_bracket + 1) { 
					$expr_str.=']'; #FIXME: this is incorrect, I should count the brackets!
				} 				 
			} 
		}
		
	} elsif ($ast->[0] ne '$' and $ast->[0] =~ /\W/) {
		my $op = $ast->[0];		
		if (scalar @{$ast} > 2) {
			my @ts=();
			for my $elt (1 .. scalar @{$ast} -1 ) {
				$ts[$elt-1] = (ref($ast->[$elt]) eq 'ARRAY') ? _emit_expression_C( $ast->[$elt], '',$stref,$f) : $ast->[$elt];					
			} 
			if ($op eq '^') { croak "OBSOLETE!";
				$op = '**';
				warn "TODO: should be pow()";
#				croak Dumper($ast);
			};
			$expr_str.=join($op,@ts);
		} elsif (defined $ast->[2]) { croak "OBSOLETE!";
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_C( $ast->[1], '',$stref,$f) : $ast->[1];
			my $t2 = (ref($ast->[2]) eq 'ARRAY') ? _emit_expression_C( $ast->[2], '',$stref,$f) : $ast->[2];			
			$expr_str.=$t1.$ast->[0].$t2;
			if ($ast->[0] ne '=') {
				$expr_str="($expr_str)";
			}			
		} else {
			# FIXME! UGLY!
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_C( $ast->[1], '',$stref,$f) : $ast->[1];
			$expr_str=$ast->[0].$t1;
			if ($ast->[0] eq '/') {
				$expr_str='1.0'.$expr_str; 
			}
		}
	} else {
		$expr_str.=join(';',grep {$_ ne '' } @expr_chunks);
	}	
#	$expr_str=~s/_complex_//g;
	$expr_str=~s/_OPEN_PAR_//g;
	$expr_str=~s/_LABEL_ARG_//g;
	if ($expr_str=~s/^\#dummy\#\(//) {
		$expr_str=~s/\)$//;
	}
	$expr_str=~s/\+\-/-/g;
	$expr_str=~s/\-\-/\- \-/g;
	# UGLY! HACK to fix boolean operations
#	 say "BEFORE HACK:".$expr_str if $expr_str=~/abs/;
	while ($expr_str=~/__[a-z]+__/ or $expr_str=~/\.\w+\.\+/) {
		$expr_str =~s/\+\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/\.(\w+)\.\+/\.${1}\./g;
		$expr_str =~s/__not__\+/\.not\./g; 
		$expr_str =~s/__not__/\.not\./g; 		
		$expr_str =~s/__false__/\.false\./g;
		$expr_str =~s/__true__/\.true\./g;
		$expr_str =~s/\+__(\w+)__\+/\.${1}\./g;		
		$expr_str =~s/__(\w+)__/\.${1}\./g;
#		  		$expr_str =~s/\.(\w+)\./$F95_ops{$1}/g;
	}	
#	say "AFTER HACK:".$expr_str if $expr_str=~/abs/;
	return $expr_str;		
} # END of _emit_expression_C()

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
 
# -----------------------------------------------------------------------------

sub translate_to_C_OLD { croak 'OBSOLETE!';
	( my $stref ) = @_;
    $translate = $GO;
    for my $subname ( keys %{ $stref->{'SubsToTranslate'} }) {
        print "\nTranslating $subname to C\n" if $V;
        $gen_sub  = 1;
        $stref = parse_fortran_src( $subname, $stref );
        $stref = refactor_C_targets($stref);
        emit_C_targets($stref);
        translate_sub_to_C($stref);
    }
	return $stref;
} # END of translate_to_C_OLD()
#  -----------------------------------------------------------------------------
sub refactor_C_targets { croak 'OBSOLETE!';
    ( my $stref ) = @_;
    print "\nREFACTORING C TARGETS\n";

    #   print Dumper(keys %{ $stref->{'Subroutines'} });
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        my $Sf = $stref->{'Subroutines'}{$f};
        if ( exists $stref->{'BuildSources'}{'C'}{ $Sf->{'Source'} } ) {
            $stref = refactor_subroutine_main( $f, $stref );
        }
    }
    return $stref;
}    # END of refactor_C_targets()

# -----------------------------------------------------------------------------
sub emit_C_targets { croak 'OBSOLETE!';
    ( my $stref ) = @_;
    print "\nEMITTING C TARGETS\n";
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        if (
            exists $stref->{'BuildSources'}{'C'}
            { $stref->{'Subroutines'}{$f}{'Source'} } )
        {
            emit_refactored_subroutine( $f, $targetdir, $stref, 1 );
        }
    }
}    # END of emit_C_targets()
# -----------------------------------------------------------------------------
sub translate_all_to_C { croak 'OBSOLETE!';
    ( my $stref ) = @_;
    local $V=1;
my $T=1;
# At first, all we do is get the call tree and translate all sources to C with F2C_ACC
# The next step is to fix the bugs in F2C_ACC via post-processing (later maybe actually debug F2C_ACC)
    chdir $targetdir;
    print "\n", "=" x 80, "\n" if $V;
    print "TRANSLATING TO C\n\n" if $V;
    print `pwd`                  if $V;
    foreach my $csrc ( keys %{ $stref->{'BuildSources'}{'C'} } ) {
        if ( -e $csrc ) {
            my $cmd = "f2c $csrc";
            print $cmd, "\n" if $V;
            system($cmd) if $T;
        } else {
            print "WARNING: $csrc does not exist\n" if $W;
        }
    }

# A minor problem is that we need to translate all includes contained in the tree as well
    foreach my $inc ( keys %{ $stref->{'BuildSources'}{'H'} } ) {
        my $cmd = "f2c $inc -H"; # FIXME: includes need -I support! NOTE $inc , not ./$inc, bug in F2C_ACC
        print $cmd, "\n" if $V;
        system($cmd) if $T;
    }
    
    my $i = 0;
    print "\nPOSTPROCESSING C CODE\n\n";
    foreach my $csrc ( keys %{ $stref->{'BuildSources'}{'C'} } ) {
        $csrc =~ s/\.f/\.c/;
         if ($T) {
            postprocess_C( $stref, $csrc, $i );
         } else {
         	print "postprocess_C( \$stref, $csrc, $i );\n";
         }
        $i++;
    }

    # Test the generated code
    print "\nTESTING C CODE\n\n";
    foreach my $ii ( 0 .. $i - 1 ) {
        my $cmd = 'gcc -Wall -c -I$GPU_HOME/include tmp' . $ii . '.c';
        print $cmd, "\n" if $V;
        system $cmd if $T;
    }

}    # END of translate_all_to_C()

# -----------------------------------------------------------------------------
# We need a separate pass I think to get the C function signatures
# Then we need to change all array accesses used as arguments to pointers:
# a[i] => a+i
# Every arg in C must be a pointer (FORTRAN uses pass-by-ref)
# So any arg in a call that is not a pointer is wrong
# We can assume that if the arg is say v and v__G exists, then
# it should be v__G
# vdepo[FTNREF1D(i,1)] => vdepo+FTNREF1D(i,1)
#
# Next, we need to figure out which arguments can remain non-pointer scalars
# That means:
# - parse the C function signature
# - find corresponding arguments in the FORTRAN signature
# - if they are Input Scalar, don't make them pointers
# - in that case, comment out the corresponding "int v = *v__G;" line

#WV04032012: TODO: this is hideous, need to refactor it into multiple functions and make more logical/robust! 
sub postprocess_C { croak 'OBSOLETE!';
    ( my $stref, my $csrc, my $i ) = @_;
    print "POSTPROC $csrc\n";
    my $sub           = '';
    my $argstr        = '';
    my %params        = ();
    my %vars          = ();
    my %argvars       = ();
    my %labels        = ();
    my %input_scalars = ();

    ### Local functions
    
    # We need to check if this particular label is a Break
    # So we need a list of all labels per subroutine.
    my $isBreak = sub {
        ( my $label ) = @_;
        return ( $labels{$label} eq 'BreakTarget'
              || $labels{$label} eq 'NoopBreakTarget' );
    };

    my $isNoop = sub {
        ( my $label ) = @_;
        return ( $labels{$label} eq 'NoopBreakTarget' );
    };

    open my $CSRC,   '<', $csrc; # FIXME: need PATH support
    open my $PPCSRC, '>', 'tmp' . $i . '.c';    # FIXME
    my $skip = 0;
    my $skipline = 0;
    while ( my $line = <$CSRC> ) {
        my $decl = '';
        $line=~/^\#define\ FALSE/ && do {
        	$skipline=1;
        	print $PPCSRC $line;
            next;
        }; 
        if ($line=~/^\#define\s+(\w+)/ ) {
        	my $par=$1;
        	if ( exists $stref->{'Subroutines'}{$sub}{'Parameters'}{'Set'}{$par} ) { # FIXME!i
                $skipline=0;
        	}
        }; 
        if ($line=~/^\s*\/\//) {
        	print $PPCSRC $line;
        	next;
        }
        $line=~/^\s*$/ && next;
        # Rewrite the subroutine signature. Not sure if this is still required, skip for now.
        $line =~ /^\s*void\s+(\w+)_\s+\(\s*(.*?)\s*\)\s+\{/ && do {
        	$skipline=0;
            $sub    = $1;
            $argstr = $2;
            my $Ssub = $stref->{'Subroutines'}{$sub};
            my @args = split( /\s*\,\s*/, $argstr );

            %argvars = map {
                s/^\w+\s+\*?//;
                s/^F2C-ACC.*?\.\s+\*?//;
                $_ => 1;
            } @args;

            for my $i ( keys %{ $Ssub->{'Includes'} } ) {
                if ( $stref->{'IncludeFiles'}{$i}{'InclType'} eq 'Parameter' ) {
                    %params = (
                        %params, %{ $stref->{'IncludeFiles'}{$i}{'Parameters'}{'Set'} }
                    );
                }
            }
            %vars = %{ $Ssub->{'Vars'} };
            for my $arg (@args) {
                $arg =~ s/^\w+\s+\*//;
                $arg =~ s/^F2C-ACC.*?\.\s+\*?//;
                my $var = $arg;
                $var =~ s/__G//;
                if ( exists $vars{$var} and $vars{$var}{'Type'} ) {
                    my $ftype = $vars{$var}{'Type'};
                    my $ctype = toCType($ftype);
#                    print Dumper($Ssub->{'RefactoredArgs'}{'Set'});
                    my $iodir = $Ssub->{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'};
                    my $kind  = $vars{$var}{'ArrayOrScalar'};

                    if ( $iodir eq 'In' and $kind eq 'Scalar' ) {
                        $arg = "$ctype $var";
                    } else {
                        $arg = "$ctype *$arg";
                    }
                } else {
                    die "No entry for $var in $sub\n" . Dumper(%vars);
                }
            }
            $line = "\t void ${sub}_( " . join( ',', @args ) . " ){\n";

            %labels = ();
            if ( exists $Ssub->{'Gotos'} ) {
                %labels = %{ $Ssub->{'Gotos'} };
            }
            # Create a header file with declarations
            $decl = $line;
            $decl =~ s/\{.*$/;/;
            my $hfile = "$sub.h";            
            open my $INC, '>', $hfile;
            my $shield = $hfile;
            $shield =~ s/\./_/;
            $shield = '_' . uc($shield) . '_';
            print $INC '#ifndef ' . $shield . "\n";
            print $INC '#define ' . $shield . "\n";
            print $INC $decl, "\n";
            print $INC '#endif //' . $shield . "\n";
            close $INC;

            $skip = 1;
        }; # signature
        
        # This too might be obsolete, or at least "TODO"
        $line =~ /(\w+)=\*(\w+)__G;/ && do {
            if ( $1 eq $2 ) {
                my $var = $1;
                my $iodir =
                  $stref->{'Subroutines'}{$sub}{'DeclaredOrigArgs'}{'Set'}{$var}
                  {'IODir'};
                my $kind = $vars{$var}{'ArrayOrScalar'};
                if ( $iodir eq 'In' and $kind eq 'Scalar' ) {
                    $line =~ s|^|\/\/|;
                    $input_scalars{ $var . '__G' } = $var;
                }
            }
        };
        # Fix translation errors
        $line =~ /F2C\-ACC\:\ Type\ not\ recognized\./ && do {
            my @chunks = split( /\,/, $line );
            for my $chunk (@chunks) {
                $chunk =~ /F2C\-ACC\:\ Type\ not\ recognized\.\ \*?(\w+)/
                  && do {
                    my $var = $1;
                    $var =~ s/__G//;
                    if ( exists $vars{$var} and $vars{$var}{'Type'} ) {
                        my $ftype = $vars{$var}{'Type'};
                        my $vtype = toCType($ftype);
                        $chunk =~ s/F2C\-ACC\:\ Type\ not\ recognized\./$vtype/;
                    } else {
                        croak "No entry for $var in $sub\n" . Dumper(%vars);
                    }
                  };
            }
            $line = join( ',', @chunks );
        };

        $line =~ /F2C\-ACC\:\ xUnOp\ not\ supported\./
          && do {    # FIXME: we assume the unitary operation is .not.
            my @chunks = split( /\,/, $line );
            for my $chunk (@chunks) {
                $chunk =~ s/F2C\-ACC\:\ xUnOp\ not\ supported\./\!/;
            }
            $line = join( ',', @chunks );

          };
          # Can't have externs!
        next if $line =~ /^\s*extern\s+void\s+noop/;
        
        if ( $skip == 0 ) {
            if ( $line =~ /^\s*extern\s+\w+\s+(\w+)_\(/ ) {
                my $inc   = $1;
                my $hfile = $inc . '.h';

                if ( not -e $hfile ) {
                    $line =~ s/^\s*extern\s+//;
                }
                print $PPCSRC '#include "' . $hfile . '"' . "\n";
                next;
            }

            $line =~ /^\s+extern\s+\w+\s+\w+[;,]/ && do {
                $line =~ s|^|\/\/|;
            };    # because parameters are macros, not variables

            #*  float float and similar need to be removed
            $line =~ /float\s+(float|sngl|sqrt)/ && do {
                $line =~ s|^|\/\/|;
            };

            $line =~ /int\s+(int|mod)/ && do {
                $line =~ s|^|\/\/|;
            };

            $line =~ /(short|int)\s+(int2|short)/ && do {
                $line =~ s|^|\/\/|;
            };

            $line =~ /(long|int)\s+(int8|long)/ && do {
                $line =~ s|^|\/\/|;
            };
            if ( $line =~ /^\s*(?:\w+\s+)?\w+\s+(\w+);/ )
            { # FIXME: only works for types consisting of single strings, e.g. double precision will NOT match!
                my $mf = $1;
                if (
                    exists $stref->{'Subroutines'}{$sub}{'CalledSubs'}{'Set'}
                    {$mf} )
                {
                    $line =~ s|^|\/\/|;
                }
            }
            $line =~ s/int\(/(int)(/g
              ;    # int is a FORTRAN primitive converting float to int
            $line =~ s/(int2|short)\(/(int)(/g
              ;    # int is a FORTRAN primitive converting float to int
            $line =~ s/(int8|long)\(/(long)(/g
              ;    # int is a FORTRAN primitive converting float to int
            $line =~ s/float\(/(float)(/g
              ;    # float is a FORTRAN primitive converting int to float
            $line =~ s/(dfloat|dble)\(/(double)(/g
              ;    # dble is a FORTRAN primitive converting int to float
            $line =~ s/sngl\(/(/g
              ;    # sngl is a FORTRAN primitive converting double to float

            $line =~ /goto\ C__(\d+):/ && do {
                my $label = $1;
                if ( $isBreak->($label) ) {
                    $_ = $line;
                    eval("s/goto\\ C__$label:/break/");
                    $line = $_;
                } else {
                    $line =~ s/C__(\d+)\:/C__$1/;
                }
            };

     #    s/goto\ C__37:/break/; # must have a list of all gotos that are breaks
            $line =~ /^\s+C__(\d+)/ && do {
                my $label = $1;
                if ( $isNoop->($label) ) {
                    $line =~ s|^|\/\/|;
                }
            };

            # Subroutine call
            $line !~ /\#define/
              && $line =~ s/\s([\+\-\*\/\%])\s/$1/g;    # FIXME: super ad-hoc!
            $line =~ /(^|^.*?\{\s)\s*(\w+)_\(\s([\+\*\,\w\(\)\[\]]+)\s\);/
              && do {

                # We need to replace the arguments with the correct ones.
                my $maybe_if  = $1;
                my $calledsub = $2;
                my $argstr    = $3;
                my @args      = split( /\s*\,\s*/, $argstr )
                  ; # FIXME: this will split things like v1,indzindicator[FTNREF1D(i,1)],v3
                
                my $called_sub_args =
                  $stref->{'Subroutines'}{$calledsub}{'DeclaredOrigArgs'}{'List'};
                my @nargs = ();

                for my $ii ( 0 .. scalar @{$called_sub_args} - 1 ) {
                    my $arg            = shift @args;
                    my $called_sub_arg = $called_sub_args->[$ii];
                    $ii++;
                    my $is_input_scalar =
                      ( $stref->{'Subroutines'}{$calledsub}{'Vars'}
                          {$called_sub_arg}{'ArrayOrScalar'} eq 'Scalar' )
                      && ( $stref->{'Subroutines'}{$calledsub}{'DeclaredOrigArgs'}
                        {$called_sub_arg}{'IODir'} eq 'In' )
                      ? 1
                      : 0;

                    if ( $arg =~ /^\((\w+)\)$/ ) {
                        $arg = $1;
                    }

                    #               $targ=~s/[\(\)]//g;
                    if ( $arg =~ /(\w+)\[/ ) {
                        my $var = $1;

                        # What is the type of $var?
                        my %calledsubvars =
                          %{ $stref->{'Subroutines'}{$calledsub}{'Vars'} };
                        my $ftype  = $calledsubvars{$called_sub_arg}{'Type'};
                        my $tftype = $vars{$var}{'Type'};
                        if ( $ftype ne $tftype ) {
                            print
"WARNING: $tftype $var ($sub) <> $ftype $called_sub_arg ($calledsub)\n"
                              if $W;
                        }
                        my $ctype  = toCType($ftype);
                        my $cptype = $ctype . '*';

                        while ( $arg !~ /\]/ ) {
                            my $targ = shift @args;

                            #                    print "TARG: $targ\t";
                            $arg .= ',' . $targ;

                            #                    print $arg,"\n";
                        }

                        if ( not $is_input_scalar ) {
                            $arg =~ s/\[/+/g;
                            $arg =~ s/\]//g;
                            $arg = "($cptype)($arg)";
                        }

                        #               die $arg;
                    }

                    #               print $arg,"\n";
                    if ( exists $argvars{ $arg . '__G' } ) {

# this is an argument variable
# if the called function argument type is Input Scalar
# and the argument variable is in %input_scalars
# then don't add __G
# Still not good: the arg for the called sub must be positional! So we must get the signature and count the position ...
# which means we need to parse the source first.

# print " SUBCALL $calledsub: $called_sub_arg: $is_input_scalar:" . $stref->{'Subroutines'}{$calledsub}{'Vars'}{$called_sub_arg}{'ArrayOrScalar'} .','. $stref->{'Subroutines'}{$calledsub}{'RefactoredArgs'}{'IODir'}{$called_sub_arg}."\n";

                        if ( not exists $input_scalars{ $arg . '__G' } ) {

                            # means v__G in enclosing sub signature is a pointer
                            if ( not $is_input_scalar ) {

                                # means the arg of the called sub is a pointer
                                $arg .= '__G';
                            } else {

                                # means the arg of the called sub is a scalar
                                #                           $arg;
                            }
                        } else {

                            # means v in enclosing sub signature is a scalar
                            if ( not $is_input_scalar ) {
                                $arg = '&' . $arg;
                            }
                        }
                    } elsif ( exists $vars{$arg}
                        and $vars{$arg}{'ArrayOrScalar'} ne 'Array' )
                    {

                        # means $arg is a Scalar
                        if ( not $is_input_scalar ) {
                            $arg = '&' . $arg;
                        }
                    }
                    push @nargs, $arg;
                }
                my $nargstr = join( ',', @nargs );
                chomp $line;
                $line =~ /^\s+if/ && do {
                    $line =~ s/^.*?\{//;
                };
                $line =~ s/\(.*//;
                $line .= '(' . $nargstr . ');' . "\n";
                my $close_if = ( $maybe_if =~ /if\s*\(/ ) ? '}' : '';
                $line = $maybe_if . $line . $close_if;

                #           die $line if $calledsub=~/initialize/;
              };

        } else {
            $skip = 0;
        }

        # VERY AD-HOC: get rid of write() statements
        $line =~ /^\s*write\(/ && do {
            $line =~ s|^|\/\/|;
        };

# fix % on float
# This is a pain: need to get the types of the operands and figure out the cases:
# int float, float int, float float
# FIXME: we assume float, float
        $line =~ s/\s+([\w\(\)]+)\s*\%\s*([\w\(\)]+)/ mod($1,$2)/;
        
        print $PPCSRC $line unless $skipline;
    }
    close $CSRC;
    close $PPCSRC;
}    # END of postprocess_C()

# -----------------------------------------------------------------------------
sub toCType {
    ( my $ftype, my $kind ) = @_;
    
    if (not defined $kind) {$kind=4};
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
#        $stref->{$sub_or_func}{$f}{'Status'} = $C_SOURCE;
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
