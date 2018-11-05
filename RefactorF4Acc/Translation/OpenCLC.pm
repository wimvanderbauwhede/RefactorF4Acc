package RefactorF4Acc::Translation::OpenCLC;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( stateful_pass pass_wrapper_subs_in_module );
use RefactorF4Acc::Refactoring::Streams qw( _declare_undeclared_variables _removed_unused_variables _fix_scalar_ptr_args _fix_scalar_ptr_args_subcall );
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.1.0";

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
    # This makes sure that no fortran is emitted by emit_all()
    $stref->{'SourceContains'}={};
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
            #my $switch_expr = _emit_expression_C(['$',$info->{'CaseVar'}],'',$stref,$f);
			my $switch_expr = _emit_expression_C([2,$info->{'CaseVar'}],'',$stref,$f); # FIXME
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
			$subcall_ast->[0] = 1; # FIXME '&';
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

# FIXME: only include if they are actually used in the code!
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
    
#	my $decl =	$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg};
	my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg);
	my $array = $decl->{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
	my $const = 1;
	if (not defined $decl->{'IODir'}) {
		$const = 0;
	} else { 
		$const =    lc($decl->{'IODir'}) eq 'in' ? 1 : 0;
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
    #	expr_str
    #croak Dumper($stref->{'Subroutines'}{$f}{'Pointers'}{'eta_j_k'}) if $f=~/shapiro_map/ && $lhs_ast->[1] eq 'eta_j_k';
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
	if (ref($ast) ne 'ARRAY') {return $ast;}
	my @expr_chunks=();
	my $skip=0;
	
	if (($ast->[0] & 0x0F) == 8) { #eq '^'
		$ast->[0]='pow';
		unshift @{$ast},1;# '&' FIXME: nodeId
	} 
	elsif (($ast->[0] & 0x0F) == 1  and $ast->[1] eq 'mod') {#eq '&'
		shift @{$ast};
		$ast->[0]= 7 ;# '%';	FIXME: nodeId
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
            } elsif ($idx==0) {    
                #} els
            if (($entry & 0x0F) == 1) { # eq '&'
				my $mvar = $ast->[$idx+1];
				# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
				# The (float) cast is necessary because otherwise I get an "ambiguous" error
				$mvar=~s/^(abs|min|max)$/(float)f$1/;
				$mvar=~s/^am(ax|in)1$/(float)fm$1/;				
				$mvar=~s/^alog$/(float)log/;				
				$expr_str.=$mvar.'('; 
			
				 $stref->{'CalledSub'}= $mvar;
				 
				$skip=1;
			} elsif (($entry & 0x0F) == 2) { #eq '$'
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
                        push @expr_chunks,  $mvar;
                    } else {
                        push @expr_chunks, '('.$ptr.$mvar.')';
                    }
				} else {
					push @expr_chunks,$mvar;
				}
				$skip=1;				
			} elsif (($entry & 0x0F) == 10) {#eq '@'
				
				my $mvar = $ast->[$idx+1];
				if ($mvar eq '_OPEN_PAR_') {
					$expr_str.=$mvar.'(';
#				} elsif ($mvar eq 'abs' ) { croak;
#					$expr_str.=$mvar.'(';					
				} else {
					# This is e.g. state_ptr(1)
					if (scalar @{$ast} == 3 and $ast->[2] eq '1') {
						$expr_str.='(*'.$mvar.')';
						$ast->[2]='';
						$ast->[0]= 2 + ((++$Fortran::Expression::Evaluator::Parser::nodeId)<<4);# '$';						
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
						if ($dim==1) {
							$expr_str.=$mvar.'[F1D2C('.join(',',@lower_bounds). ' , ';
						} else {
							$expr_str.=$mvar.'[F'.$dim.'D2C('.join(',',@ranges[0.. ($dim-2)]).' , '.join(',',@lower_bounds). ' , ';						
						}
					}
				}
				$skip=1;
			} elsif (
                #$ast->[$idx-1]!~/^[\&\@\$]/ 
				($ast->[$idx-1] & 0x0F) != 1 and #!~/^[\&\@\$]/ 
				($ast->[$idx-1] & 0x0F) != 10 and #!~/^[\&\@\$]/ 
				($ast->[$idx-1] & 0x0F) != 2 #!~/^[\&\@\$]/ 
			) {
#				say "ENTRY:$entry SKIP: $skip";
				push @expr_chunks,$entry;
				$skip=0;
			}
        }
		}				
	} # for
	# Here state_ptr is OK
	if (($ast->[0] & 0x0F) == 1  ) { # eq '&'       
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
	} elsif ( ($ast->[0] & 0x0F) == 10) {				# eq '@'
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
		
	} elsif (($ast->[0] & 0x0F) == 2 and scalar @{$ast} == 2) {
        # This means we are dealing with a variable
        # This is a HACK 
        croak 'BOOM!' if scalar @expr_chunks > 1;
        $expr_str = shift @expr_chunks;
	} elsif (($ast->[0] & 0x0F) != 10
        #        and $ast->[0] =~ /\W/
    ) {
        my $opcode = $ast->[0];		
        my $op = $RefactorF4Acc::Parser::Expressions::sigils[$opcode & 0x0F];
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
			$expr_str.=join($op,@ts) unless $op eq '$';
			
		} elsif (defined $ast->[2]) { croak "OBSOLETE!";
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_C( $ast->[1], '',$stref,$f) : $ast->[1];
			my $t2 = (ref($ast->[2]) eq 'ARRAY') ? _emit_expression_C( $ast->[2], '',$stref,$f) : $ast->[2];			
			$expr_str.=$t1.$ast->[0].$t2;
			if (($ast->[0] & 0x0F) != 9) { # ne '='
				$expr_str="($expr_str)";
			}			

		} else {
			# FIXME! UGLY!
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_C( $ast->[1], '',$stref,$f) : $ast->[1];
            my $op = $RefactorF4Acc::Parser::Expressions::sigils[$ast->[0] & 0x0F];            
			$expr_str=  $op eq '$' ? $t1 :  $op.$t1;
			if (($ast->[0] & 0x0F) == 6) { #eq '/'
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
    #	 say "BEFORE HACK:".$expr_str if $expr_str=~/eta_j_k/;
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
    #	say "AFTER HACK:".$expr_str if $expr_str=~/eta_j_k/;
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
