package RefactorF4Acc::Translation::SaC;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::ExpressionAST::Evaluate qw( eval_expression_with_parameters );
use RefactorF4Acc::Refactoring::Common qw( stateful_pass pass_wrapper_subs_in_module ); # emit_f95_var_decl);
use RefactorF4Acc::Refactoring::Streams qw( _declare_undeclared_variables _removed_unused_variables _fix_scalar_ptr_args _fix_scalar_ptr_args_subcall );
use RefactorF4Acc::Parser::Expressions qw(
	parse_expression
	get_vars_from_expression	
	@sigils
	);
# 
#   (c) 2010-2018 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Translation::SaC::ISA = qw(Exporter);

@RefactorF4Acc::Translation::SaC::EXPORT_OK = qw(
    &add_to_SaC_build_sources
    &translate_module_to_SaC	
);

#### #### #### #### BEGIN OF SaC TRANSLATION CODE #### #### #### ####

sub translate_module_to_SaC {  (my $stref, my $module_name) = @_;
	my $ocl=1;
	$stref->{'OpenCL'}=$ocl;
	$stref->{'TranslatedCode'}=[];	
	
	$stref = pass_wrapper_subs_in_module($stref,$module_name,
	           # module-specific passes 
            [],
            # subroutine-specific passes 
	
	   [
	    [\&_hack_to_fix_iodirs, 
	    \&_hack_to_fix_param_decls_in_superkernel, 
	    \&_hack_to_fix_kernel_sub],
	    [\&_determine_intermediate_arrays], 
#		[\&_declare_undeclared_variables],
#		[\&add_OpenCL_address_space_qualifiers],
		[\&_translate_sub_to_SaC]
		],$ocl);
		
	$stref = _write_headers($stref,$ocl);
	$stref = _emit_SaC_code($stref, $ocl);
	return $stref;
}


sub _translate_sub_to_SaC {  (my $stref, my $f) = @_;
	
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


	my $pass_translate_to_SaC = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
		my $skip=0;
		if (exists $info->{'Signature'} ) {
			($c_line,$pass_state) = _emit_subroutine_sig_SaC( $stref, $f, $annline, $pass_state);
#			if ($f eq $Config{'KERNEL'}) {
#				$c_line = '__kernel '.$c_line;
#			}
		}
		elsif (exists $info->{'VarDecl'} ) {
			
				my $var = $info->{'VarDecl'}{'Name'};
				if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}
				) {
					$skip=1;
				} else {
                    $skip=1;
				}
		}
		if ( exists $info->{'ParamDecl'} ) { 
            $skip=0;
				my $var = $info->{'VarDecl'}{'Name'};
				$c_line = _emit_const_assignment_SaC($stref,$f,$var);
		}
		elsif (exists $info->{'Select'} ) {				
			my $switch_expr = _emit_expression_SaC([2,$info->{'CaseVar'}],'',$stref,$f); # FIXME
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
		elsif (exists $info->{'Do'} ) { croak "Sorry, TODO!";
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
#			if ($line=~/test/) {
#				die Dumper( $info->{'Rhs'}{'ExpressionAST'} );
#			}
			my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};	
			my $mvar = $lhs_ast->[1];
			
			if (($lhs_ast->[0] & 0xFF) == 10 and  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$mvar}{'IODir'} ne 'out') {
#			say "LHS ARRAY $mvar "	
				$pass_state->{'ArrayAssignments'}{$mvar}=1;	
			} 
			my $lhs_str = _emit_lhs_assignment_SaC($stref, $f, $info);
			my $lhs_type = __get_sac_type($stref, $f, $mvar);
			
			my $cast = ($lhs_type eq 'int' or $lhs_type eq 'long') ? 0 : 1;			
			my $rhs_str = _emit_rhs_assignment_SaC($stref, $f, $info,$cast);
			$c_line = "$lhs_str = $rhs_str;";
			if ($mvar=~/^\w+_range$/) {					
				my $range_val = eval($rhs_str);
				if (not exists $stref->{'Subroutines'}{$f}{'Ranges'}) {
					$stref->{'Subroutines'}{$f}{'Ranges'}={$mvar => $range_val};
				} else {
					$stref->{'Subroutines'}{$f}{'Ranges'}{$mvar} = $range_val;
				}   				
			}
			if (($cast==0) && $c_line=~/1\.0f/) {
				$c_line=~s/1\.0f/1/g;
			} 
			if (exists $info->{'If'}) {
				my $if_str = _emit_ifthen_C($stref,$f,$info);
				$c_line =$if_str." {\n".$info->{'Indent'}.$c_line."\n".$info->{'Indent'}."}"; 
			}
			
#				$c_line = _emit_assignment_C($stref, $f, $info).';';
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
			my $csub = $subcall_ast->[1];
			if ($csub  eq 'barrier') {
				$subcall_ast->[2][1]=uc($subcall_ast->[2][1]);
				$c_line = $info->{'Indent'}._emit_expression_SaC($subcall_ast,'',$stref,$f).';';				
				push @{$pass_state->{'TranslatedCode'}},$c_line ;
				$skip=1;
			}
			elsif ($csub =~/get_(local|global|group)_id/) {
				$skip=1;
				my $qual = $1;
				$c_line = '//'.$info->{'Indent'}."${qual}_id = get_${qual}_id(0);";
			} else {
				if ($csub=~/_map_\d+/) {
					my $map_upper_bound = 1;
					for my $range_var (keys %{$stref->{'Subroutines'}{$csub}{'Ranges'}}) {
						$map_upper_bound*=$stref->{'Subroutines'}{$csub}{'Ranges'}{$range_var};
					}
					
					splice @{$subcall_ast},2,0,['2','global_id'];					
										
					unshift @{$stref->{'Subroutines'}{ $csub  }{'RefactoredArgs'}{'List'} }, 'global_id';
					$stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{'global_id'}={
						'Type' => 'integer', 'Attr'=>4,'IODir' => 'in','ArrayOrScalar'=>'Scalar'
					};
					
					# Because the whole thing is generated, it is safe to assume that all args are vars
				
					my $arg_exprs = [ map {$_->[1]} @{$subcall_ast}[2 .. $#{$subcall_ast}] ];	
					( my $sac_args_out,my $sac_args_in) = _separate_in_out_args( $csub, $stref, $arg_exprs);
					my %in_args = map {$_ => 1} @{$sac_args_in};
					my %top_args = %{$pass_state->{'TopArgs'}};
					my $subcall_ast_top = [];
					for my $entry (@{ $subcall_ast }) {
						my $n_entry = $entry;
						
						if (ref($entry) eq 'ARRAY') {
							
						my $is_array = $stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{$entry->[1]}{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
							$n_entry = ( ($is_array or exists $top_args{$entry->[1]}) and exists $in_args{$entry->[1]} ) ? [$entry->[0],$entry->[1].'_top'] : $entry;
						}
						push @{$subcall_ast_top }, $n_entry;
					}
					$c_line = _emit_expression_SaC($subcall_ast_top,'',$stref,$f).';'; 
					# This is *very* ad-hoc
					# We wrap a call to a function with name _map_\d+ to a map-style with loop
					# and we wrap a call to a function with name _reduce_\d+ to a fold-style with loop.
					
					my $out_args_str=join(',', @{$sac_args_out});
					my $out_args_top_str=join(',',map {$_.'_top'} @{$sac_args_out});
#								$decl->{'SizeVal'}=$size_val;
#			$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}=$decl;
					
					my $mod_array_args_str=join(',',map {
						 $stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{$_}{'IODir'} eq 'out' 
						 ? do {						 	
						 	my $size_val = $stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{$_}{'SizeVal'};
						 	my $zero = $stref->{'Subroutines'}{$csub}{'DeclaredOrigArgs'}{'Set'}{$_}{'Type'} eq 'integer' ? '0' : '0.0f';
						 	"genarray([$size_val],$zero)"
						 }
						 : "modarray(${_}_top)"; 
					}  @{$sac_args_out});
					my $with_loop_map = <<"END_WITH_LOOP_MAP";
				$out_args_top_str = with {
					([1] <= [global_id] <= [$map_upper_bound]) {
						$c_line
					} : ($out_args_str);
				} : ( $mod_array_args_str );
					
END_WITH_LOOP_MAP
						$c_line = $with_loop_map;  
				} elsif ($csub=~/_reduce_\d+/) {
					
=pod	

So a folding function in SaC is f :: b -> a -> b -> [a] -> b
				
	res  = with {
		([0] <= [iv] <= [5]) : a[iv];
    } : fold(reduce_kernel(c_in), initial_acc)

and also with indexing:

	inline int mult(int[6] a, int acc, int iv) {
		return (acc*a[iv]);
	}

	res = with {
    	([0] <= [iv] <= [5]): iv;
	} : fold(mult(a), 1);
   
   
So what I must do is inspect Gavin's reduce loops
It should be easy as the fold accumulators have already been identified.
Using the -plat FPGA flag we only need to check assignment lines with 

/local_(\w+)\s*=\s*(\w+)\s*$/ and !/local_chunk_size/
my $initial_acc = $2;
Need to check what it looks like when generated for CPU.   
=cut					
					
					croak "Sorry, fold handling not done yet!";
				} else {
					$c_line = $info->{'Indent'}._emit_expression_SaC($subcall_ast,'',$stref,$f).';';
				}
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
		elsif (exists $info->{'EndDo'} or exists $info->{'EndIf'}  ) {
			
				 $c_line = '}';
		}
		elsif (exists $info->{'EndSubroutine'} ) {
			if ($f eq $Config{'KERNEL'}) {
					 $c_line = $info->{'Indent'}.'return ('. join(',',map { "${_}_top"  } @{ $pass_state->{'OutputArgs'} }).");\n".'}';
			} else {
				# FIXME, this is not mutually exclusive
				# What I need to do is find which output args have been assigned to
				# So I need to build a table of vars that have been assigned to, easy. Then I need to create an extra assignment for each of them.
				
				$c_line='';
				for my $var (sort keys %{$pass_state->{'ArrayAssignments'}}) {
					$c_line.=$info->{'Indent'}."${var}_ = ${var}[global_id];\n";
				}
				
				 $c_line .= $info->{'Indent'}.'return ('. join(',', map {
				 	exists $pass_state->{'ArrayAssignments'}{$_} ? "${_}_" : $_;				 	
				 } @{ $pass_state->{'OutputArgs'} }).");\n".'}';
			}
		}		
		elsif (exists $info->{'EndSelect'} ) {
				 $c_line = '    }'."\n".$info->{'Indent'}.'}';
		}
		
		elsif (exists $info->{'Comments'} ) {
			$skip=1;
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

	my $state = [$stref,$f, {'TranslatedCode'=>[],'OutputArgs'=>[]}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_translate_to_SaC, $state,'SaC_translation_collect_info() ' . __LINE__  ) ;

 	$stref->{'Subroutines'}{$f}{'TranslatedCode'}=$state->[2]{'TranslatedCode'};
 	$stref->{'TranslatedCode'}=[@{$stref->{'TranslatedCode'}},@{$state->[2]{'TranslatedCode'}}];
# 	croak Dumper($stref->{'TranslatedCode'});
 	return $stref;
	
} # END of _translate_sub_to_SaC()



sub _hack_to_fix_iodirs {  (my $stref, my $f) = @_;

	my $pass_hack_to_fix_iodirs = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
		if (exists $info->{'VarDecl'} ) {
			
				my $var = $info->{'VarDecl'}{'Name'};
				if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}
				) {
					if ($pass_state->{'CurrentIODir'} ne 'unchanged' ) {
#						say "Setting IODir to ".$pass_state->{'CurrentIODir'}." for $var in $f";
#						say in_nested_set( $stref->{'Subroutines'}{$f},'Vars',$var);
						$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var}{'IODir'}=$pass_state->{'CurrentIODir'};
					}
				} 
									
		}
		
		elsif (exists $info->{'Comments'} ) {			
			if ($line=~/READ\s+\&\s+WRITTEN/) {
				$pass_state->{'CurrentIODir'}='inout';
			}
			elsif ($line=~/READ/) {
				$pass_state->{'CurrentIODir'}='in';
			}
			elsif ($line=~/WRITTEN/) {
				$pass_state->{'CurrentIODir'}='out';
			}
			else {
				$pass_state->{'CurrentIODir'}='unchanged';
			}
			
		}		
		
		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f, {'CurrentIODir'=>'unchanged'}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_hack_to_fix_iodirs, $state,'_hack_to_fix_iodirs() ' . __LINE__  ) ;

 	return $stref;
	
} # END of _hack_to_fix_iodirs()

sub _hack_to_fix_kernel_sub {  (my $stref, my $f) = @_;
	
if ($f eq $Config{'KERNEL'}) {
	my $pass_hack_to_fix_kernel_sub = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
		
		my $skip=0;
		if (exists $info->{'VarDecl'}
		and (
		$info->{'VarDecl'}{'Name'} eq 'state'
		or $info->{'VarDecl'}{'Name'} eq 'state_ptr')
		) {			
			$skip=1;
		}
		elsif (exists $info->{'ParamDecl'} ) {
			$skip=1;
		}
		elsif (exists $info->{'Assignment'} and
			$info->{'Lhs'}{'VarName'} eq 'state'
			) {				
			$skip=1;					
		}	
		elsif (exists $info->{'Select'} or
				exists $info->{'Case'} or
				exists $info->{'CaseDefault'} or
				exists $info->{'EndSelect'}) {
			$skip=1;
		}
		push @{$pass_state->{'NewAnnLines'}},$annline unless $skip;
		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f, {'NewAnnLines'=>[]}];
 	($stref,$state) = stateful_pass($stref,$f,$pass_hack_to_fix_kernel_sub, $state,'_hack_to_fix_iodirs() ' . __LINE__  ) ;
 	
	$stref->{'Subroutines'}{$f}{'RefactoredCode'} = $state->[2]{'NewAnnLines'};
#	map {say $_->[0]} @{$stref->{'Subroutines'}{$f}{'AnnLines'}};die ;
}

 	return $stref;
	
} # END of _hack_to_fix_kernel_sub()


sub _write_headers { (my $stref)=@_;
	

	my @headers=(
#	    '// use ScalarArith : all;',
		'use Array: all;',
		'use StdIO: all;',
		'use ArrayIndexFortranToSac: all;',
		''
		);
		$stref->{'TranslatedCode'}=[@headers,@{$stref->{'TranslatedCode'}}];
		return $stref;
} # END of _write_headers()

sub _emit_SaC_code { (my $stref)=@_;
 	map {say $_ } @{$stref->{'TranslatedCode'}} if $V;
 	my $ext = 'sac';#$ocl ? 'cl' : 'c';
 	my $fsrc = $Config{'MODULE_SRC'};
 	my $csrc = $fsrc;$csrc=~s/\.\w+$//;
 	open my $OUT, '>', "$csrc.$ext";
 	map {say $OUT $_ } @{$stref->{'TranslatedCode'}};
 	close $OUT;
	return $stref;
} # END of _emit_SaC_code

sub _emit_subroutine_sig_SaC { (my $stref, my $f, my $annline, my $state)=@_;
		$state->{'TopArgs'}={};
	    (my $line, my $info) = @{ $annline };
	    my $Sf        = $stref->{'Subroutines'}{$f};
	    my $is_superkernel = $f eq $Config{'KERNEL'};
	    my $name = $info->{'Signature'}{'Name'};
#	    say "NAME $name";
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
		my $sac_args_in_ref=['int global_id'];	    			
		my $sac_args_out_ref=[];	    			
		for my $arg (@{ $args_ref }) {
			next if $f eq $Config{'KERNEL'} and $arg eq 'state_ptr'; 
			($stref,my $sac_type, my $sac_dim, my $arg_name, my $inout) = _emit_arg_decl_SaC($stref,$f,$arg);
			my $is_array = $sac_dim ne '';
            if ($inout eq 'in') {
            	# $arg_name needs _top if it is *not* in the in-arg list of the superkernel
            	# I guess this means, "always if it is an array:
				push @{$sac_args_in_ref},"$sac_type$sac_dim $arg_name".($f eq $Config{'KERNEL'} and $is_array ? '_top' : '');
	        } elsif ($inout eq 'out') {
				push @{$sac_args_out_ref},$is_superkernel ? "$sac_type$sac_dim" : $sac_type;
				push @{$state->{'OutputArgs'}},$arg_name.($f eq $Config{'KERNEL'} ? '_top' : '');
				if ($f eq $Config{'KERNEL'} ) {
					$state->{'TopArgs'}{$arg_name}=1;		
				}
	        } else { # InOut
				push @{$sac_args_in_ref},"$sac_type$sac_dim $arg_name".($f eq $Config{'KERNEL'} ? '_top' : '') ;
				if ($f eq $Config{'KERNEL'} ) {
					$state->{'TopArgs'}{$arg_name}=1;		
				}
				push @{$sac_args_out_ref}, $is_superkernel ? "$sac_type$sac_dim" : $sac_type;
				push @{$state->{'OutputArgs'}},$arg_name;
	        }
		}
	    my $in_args_str = join( ',', @{$sac_args_in_ref} );	    
	    my $out_args_str = join( ',', @{$sac_args_out_ref} );	    
	    my $rline = "\ninline $out_args_str $name($in_args_str) {\n";
		return  ($rline,$state);
} # END of _emit_subroutine_sig_SaC()

# SaC the arguments must be split into in and out
# The declarations are of the form type[sz] where sz must be a constant, so I must evaluate it
# In general I will need the params from the sub body for this.

sub _emit_arg_decl_SaC { (my $stref,my $f,my $arg)=@_;
	my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$arg);
	my $set = in_nested_set($stref->{'Subroutines'}{$f},'Vars',$arg);
	 
    my $inout = $decl->{'IODir'};
#    die "$set $f $arg $inout" if $arg eq 'g';
	my $array = $decl->{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
	my $const = 1;
	if (not defined $decl->{'IODir'}) {
		$const = 0;
	} else { 
		$const =    lc($decl->{'IODir'}) eq 'in' ? 1 : 0;
	}
	my $sac_dim='';
	if (exists $decl->{'SizeVal'}) {
		$sac_dim='['.$decl->{'SizeVal'}.']';
	} else {
		if ($array == 1) {
			my $dim = $decl->{'Dim'};
			
			my @sizes = map {  '('.$_->[1].' - '.$_->[0].' +1)'   } @{$dim} ; 
			my $size_str = (scalar @sizes==1) ? $sizes[0] : join('*',@sizes);
#			say "ARG: $arg => $size_str";		
			my $size_val =  eval_expression_with_parameters($size_str, {}, $stref, $f);
		#	die "$size_str => $size_val";
#			say "SIZE STR: $size_str => $size_val";
			$decl->{'SizeVal'}=$size_val;
			$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}=$decl;
		    $sac_dim= $size_val == 1 ? '' : '['.$size_val.']'; # FIXME? ad hoc: v[1] is assumed to be a scalar
		}
	}
    
#	$stref->{'Subroutines'}{$f}{'Pointers'}{$arg}=$ptr;	
	my $ftype = $decl->{'Type'};
	my $fkind = $decl->{'Attr'};
	$fkind=~s/\(kind=//;
	$fkind=~s/\)//;
	if ($fkind eq '') {$fkind=4};
	my $sac_type = toSaCType($ftype,$fkind);
#	my $ocl_address_space = ($stref->{'OpenCL'} ==1 and exists $decl->{'OclAddressSpace'} and $is_ptr ) ? $decl->{'OclAddressSpace'}.' ' : '';
#	my $maybe_const = ($stref->{'OpenCL'} ==1 and $f eq $Config{'KERNEL'} and $ocl_address_space eq '') ? 'const ' : '';
# If the argument is an in arg  	
	return ($stref,$sac_type, $sac_dim,$arg, $inout);
}

sub _emit_const_assignment_SaC { (my $stref,my $f,my $var)=@_;
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
	my $val='';
	if (defined $decl->{'Parameter'}) {
		$val = $decl->{'Val'};
	} 
	my $c_var_decl = $var.' = '.$val.';';
	return ($stref,$c_var_decl);
}

sub _emit_var_decl_SaC { (my $stref,my $f,my $var)=@_;
	my $decl =  get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
	my $array = (exists $decl->{'ArrayOrScalar'} and $decl->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
	my $const = '';
	my $val='';
	if (defined $decl->{'Parameter'}) {
		$const = 'const ';
		$val = ' = '.$decl->{'Val'};
	}
	my $dim = $decl->{'Dim'};
	my @sizes = map {  '('.$_->[1].' - '.$_->[0].' +1)'   } @{$dim} ; 
	my $size_str = (scalar @sizes==1) ? $sizes[0] : join('*',@sizes); 

	my $ptr = $array  ? '*' : '';
	$stref->{'Subroutines'}{$f}{'Pointers'}{$var}=$ptr;
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
	
	my $c_type = toSaCType($ftype,$fkind);
	my $c_var_decl = $const.$c_type.' '.$ptr.$var.$val.';';
	return ($stref,$c_var_decl);
}

sub _emit_assignment_C { (my $stref, my $f, my $info)=@_;
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
	
	my $lhs = _emit_expression_SaC($lhs_ast,'',$stref,$f);
	my $indent='';
	$lhs=~/^(\s+)/ && do {
		$indent=$1;
		$lhs=~s/^\s+//;	
	};
	$lhs=~s/^\(([^\(\)]+)\)/$1/;
	$lhs=$indent.$lhs;
	
	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};	

	my $rhs = _emit_expression_SaC($rhs_ast,'',$stref,$f);
	my $rhs_stripped = $rhs;
	$rhs_stripped=~s/^\(([^\(\)]+)\)$/$1/;
	
	for my $macro (keys %{ $Config{'Macros'} } ) {
		my $lc_macro=lc($macro);
		$rhs_stripped=~s/\b$lc_macro\b/$macro/g;
	}
	
	my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
	if (exists $info->{'If'}) {
		my $if_str = _emit_ifthen_C($stref,$f,$info);
		$rline =$if_str.' '.$rline; 
	}	
	return $rline;
}

sub _emit_lhs_assignment_SaC { (my $stref, my $f, my $info)=@_;
	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};	
	my $arg = $lhs_ast->[1];
	my $is_out=0; 
	if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}) {
		$is_out =  $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'} eq 'out' ? 1 : 0;
	};	
	my $lhs = $is_out ? $arg : _emit_expression_SaC($lhs_ast,'',$stref,$f);
	
	my $indent='';
	$lhs=~/^(\s+)/ && do {
		$indent=$1;
		$lhs=~s/^\s+//;	
	};
	# unwrap if parens
	$lhs=~s/^\(([^\(\)]+)\)/$1/;	
	return "$indent$lhs";	
}	

sub _emit_rhs_assignment_SaC { (my $stref, my $f, my $info, my $cast)=@_;	
	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};	
	if ($cast==1) {
		$rhs_ast = _add_cast_calls($rhs_ast, $stref, $f);
	}
	my $rhs = _emit_expression_SaC($rhs_ast,'',$stref,$f);
	my $rhs_stripped = $rhs;
	$rhs_stripped=~s/^\(([^\(\)]+)\)$/$1/;
	
	for my $macro (keys %{ $Config{'Macros'} } ) {
		my $lc_macro=lc($macro);
		$rhs_stripped=~s/\b$lc_macro\b/$macro/g;
	}
	
	return $rhs_stripped;
}


sub _emit_ifthen_C { (my $stref, my $f, my $info)=@_;	
	my $cond_expr_ast=$info->{'CondExecExprAST'};	
#	die Dumper($cond_expr_ast);
	$cond_expr_ast = _add_cast_calls($cond_expr_ast, $stref, $f);
	my $cond_expr = _emit_expression_SaC($cond_expr_ast,'',$stref,$f);
	$cond_expr=_change_operators_to_SaC($cond_expr);
	# FIXME! fix for stray '+'
	$cond_expr=~s/\+\>/>/g;
	my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');		
	return $rline;
}


sub _emit_expression_SaC { my ($ast, $stref, $f)=@_;
	my $Sf = $stref->{'Subroutines'}{$f};
# croak 'FIXME: port differences from _emit_expression_SaC_OLD(), LINE 588';
#	say Dumper($ast);
    if (ref($ast) eq 'ARRAY') {
        if (scalar @{$ast}==3) {
			if ($ast->[0] == 8) { #eq '^'
				$ast->[0]='pow';
				unshift @{$ast},1;# '&' 
			} 
			elsif ($ast->[0] == 1  and $ast->[1] eq 'mod') {#eq '&'
					shift @{$ast};
					$ast->[0]= 7 ;# '%';					
			}

            if ($ast->[0] ==1 or $ast->[0] ==10) { # '&' array access or function call
                (my $sigil, my $name, my $args) =@{$ast};
				# if (in_nested_set($Sf,'Vars',$name)) {
				# 	say "NAME $name is an ARRAY (".$ast->[0].')';
				# 	$ast->[0]=10;
				# } else {
				# 	say "NAME $name is a FUNCTION (".$ast->[0].')';
				# }
				if ($ast->[0]==1) {
				 	$stref->{'CalledSub'}= $name;
				}

                if (@{$args}) {
					if ($args->[0] != 14 ) { # NOT ')('
						my @args_lst=();

						if($args->[0] == 27) { # ','
						# more than one arg
							for my $idx (1 .. scalar @{$args}-1) {
								my $arg = $args->[$idx];
								push @args_lst, _emit_expression_SaC($arg, $stref, $f);
							}

							#                    for my $arg (@{$args->[1]}) {
							#       push @args_lst, _emit_expression_SaC($arg, $stref, $f;
							#    }
							
							# return "$name(".join(',',@args_lst).')';
						} else {
							# only one arg
							$args_lst[0] = _emit_expression_SaC($args, $stref, $f);
							# return "$name("._emit_expression_SaC($args, $stref, $f).')';
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
							if ($name eq 'pow') {
								# Very ad-hoc! FIXME!
								@args_lst = map { "(float)($_)" } @args_lst;
							} else { # Basically for any non-intrinsic, not just pow(), FIXME!
								# We must check the args here and split
								my $csub = $stref->{'CalledSub'};
								if (exists $stref->{'Subroutines'}{ $csub  }) {
									( my $sac_args_out,my $sac_args_in) = _separate_in_out_args( $csub, $stref, \@args_lst);
									# Another evil SaC hack!
									return join(',', map {$_=~s/_top$//;$_} @{$sac_args_out}). 
									" = $name(".
									join(',',@{$sac_args_in}).
									')';		
								} 									
							}
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
								push @args_lst1, _emit_expression_SaC($arg, $stref, $f);
							}
							$args_str1=join(',',@args_lst1);

						} else {
							$args_str1= _emit_expression_SaC($args1, $stref, $f);
						}
						if($args2->[0] == 27) { #eq ','
							my @args_lst2=();
							for my $idx (1 .. scalar @{$args2}-1) {
								my $arg = $args2->[$idx];
								push @args_lst2, _emit_expression_SaC($arg, $stref, $f);
							}

							#                for my $arg (@{$args2->[1]}) {
							#    push @args_lst2, _emit_expression_SaC($arg, $stref, $f);
							#}
							$args_str2=join(',',@args_lst2);
						} else {
							$args_str2=_emit_expression_SaC($args2, $stref, $f);
						}
						return "$name(".$args_str1.')('.$args_str2.')';
					}
				} else {
					return "$name()";
				}			
            } else { # not '&' or '@'
                (my $opcode, my $lexp, my $rexp) =@{$ast};
                my $lv = (ref($lexp) eq 'ARRAY') ? _emit_expression_SaC($lexp, $stref, $f) : $lexp;
                my $rv = (ref($rexp) eq 'ARRAY') ? _emit_expression_SaC($rexp, $stref, $f) : $rexp;
                return $lv.$sigils[$opcode].$rv;
            }
        } elsif (scalar @{$ast}==2) { #  for '{'  and '$'
		
            (my $opcode, my $exp) =@{$ast};
            if ($opcode==0 ) {# eq '('
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_SaC($exp, $stref, $f) : $exp;
                return "($v)";
            } elsif ($opcode==28 ) {# eq '(/'
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_SaC($exp, $stref, $f) : $exp;
                return "{ $v }"; # FIXME: what is a SaC array constant?
            } elsif ($opcode==2 or $opcode>28) {# eq '$' or constants
				if ($opcode == 34) {
					croak 'Fortran LABEL as arg is not supported, sorry!'; #  "*$exp" : $exp;   # Fortran LABEL, does not exist in C
				}
				my $mvar = $ast->[1];
				my $called_sub_name = $stref->{'CalledSub'} // '';
				if (exists $stref->{'Subroutines'}{$f}{'Pointers'}{$mvar} ) {
					croak 'SaC does not have pointers!';
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
					if ($opcode == 30) { # Float
						$exp .= 'f'; # maybe need to check if there is an 'e' in there? TODO/FIXME
					}
					return $exp;
				}
                # return ($opcode == 34) ?  "*$exp" : $exp;   # Fortran LABEL, does not exist in C         
            } elsif ($opcode == 21 or $opcode == 4 or $opcode == 3) {# eq '.not.' '-'
                my $v = (ref($exp) eq 'ARRAY') ? _emit_expression_SaC($exp, $stref, $f) : $exp;
                return $sigils[$opcode]. $v;
            } elsif ($opcode == 27) { # ',' 
                croak Dumper($ast); # WHY is this here?
                my @args_lst=();
                for my $arg (@{$exp}) {
                    push @args_lst, _emit_expression_SaC($arg, $stref, $f);
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
                    push @args_lst, _emit_expression_SaC($arg, $stref, $f);
                }
                return join(',',@args_lst); 
            } else {
                croak Dumper($ast);
            }
        }
    } else {
		croak Dumper($ast);
		# UGLY SaC hack!
		# Also, with the new AST, is this not impossible?
		if ($ast=~/\d\.\d/) {$ast=$ast.'f';}
		return $ast;
	}
} # END of _emit_expression_SaC


sub _emit_expression_SaC_OLD { my ($ast, $expr_str, $stref, $f)=@_;
croak "REDO THIS BASED ON _emit_expression_SaC!";
# I assume that means it is a constant
	if (ref($ast) ne 'ARRAY') {
		# UGLY SaC hack!
		if ($ast=~/\d\.\d/) {$ast=$ast.'f';}
		return $ast;
	}
	
	my @expr_chunks=();
	my $skip=0;
	
	if (($ast->[0] & 0xFF) == 8) { #eq '^'
		$ast->[0]='pow';
		unshift @{$ast},1;# '&' FIXME: nodeId
	} 
	elsif (($ast->[0] & 0xFF) == 1  and $ast->[1] eq 'mod') {#eq '&'
		shift @{$ast};
		$ast->[0]= 7 ;# '%';	FIXME: nodeId
	}
	
	for my  $idx (0 .. scalar @{$ast}-1) {		
		my $entry = $ast->[$idx];
		if (ref($entry) eq 'ARRAY') {
			 my $nest_expr_str = _emit_expression_SaC( $entry, '',$stref,$f);
#			 say "NEST:$nest_expr_str ";
			push @expr_chunks, $nest_expr_str;
		} else {
			if ($entry =~/#/) {
				$skip=1;
            } elsif ($idx==0) {  # Look at the first elt, check the code  

	            if (($entry & 0xFF) == 1) { # eq '&'
					my $mvar = $ast->[$idx+1];
					# AD-HOC, replacing abs/min/max to fabs/fmin/fmax without any type checking ... FIXME!!!
					# The (float) cast is necessary because otherwise I get an "ambiguous" error
#					$mvar=~s/^(abs|min|max)$/(float)f$1/;
#					$mvar=~s/^am(ax|in)1$/(float)fm$1/;				
#					$mvar=~s/^alog$/(float)log/;				
					$expr_str.=$mvar.'(';
					
					 $stref->{'CalledSub'}= $mvar;
					 
					$skip=1;
				} elsif (($entry & 0xFF) == 2) { #eq '$'
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
				} elsif (($entry & 0xFF) == 10) {#eq '@'
					
					my $mvar = $ast->[$idx+1];
					if ($mvar eq '_OPEN_PAR_') {
						$expr_str.=$mvar.'(';
					} else {
						if (scalar @{$ast} == 3 and $ast->[2] eq '1') {
							$expr_str.='(*'.$mvar.')';
							$ast->[2]='';
							$ast->[0]= 2 + ((++$Fortran::Expression::Evaluator::Parser::nodeId)<<8);# '$';
						}  else {
#							say Dumper($mvar);
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
							if ($dim==1) {
								$expr_str.=$mvar.'[F1D2C('.join(',',@lower_bounds). ' , ';
							} else {
								$expr_str.=$mvar.'[F'.$dim.'D2C('.join(',',@ranges[0.. ($dim-2)]).' , '.join(',',@lower_bounds). ' , ';						
							}
							
#							# If we need to cast, here is the place to do it. 
#							# Again, I am not inclined (sir!) to do full type checking. So I will recklessly cast all int arrays to floats.
#							# FIXME! UGLY SaC HACK!
#							my $ftype = $decl->{'Type'};
#							my $fkind = $decl->{'Attr'};
#							$fkind=~s/\(kind=//;
#							$fkind=~s/\)//;
#							if ($fkind eq '') {$fkind=4};
#						
#							if ( $ftype eq 'integer') {
#								if ($fkind == 4) {
#									say $expr_str;
#									$expr_str = 'tof('.$expr_str;
#								} elsif ($fkind == 8) {
#									$expr_str = 'tod('.$expr_str;
#								} else {
#									warn "$mvar is an integer with kind $fkind, not casting!";
#								}
#							}
						}
					}

					$skip=1;
				} elsif ( # It is not '&', '$' or '@'
	                #$ast->[$idx-1]!~/^[\&\@\$]/ 
					($ast->[$idx-1] & 0xFF) != 1 and #!~/^[\&\@\$]/ 
					($ast->[$idx-1] & 0xFF) != 10 and #!~/^[\&\@\$]/ 
					($ast->[$idx-1] & 0xFF) != 2 #!~/^[\&\@\$]/ 
				) {
	#				say "ENTRY:$entry SKIP: $skip";
					push @expr_chunks,$entry;
					$skip=0;
				}
	        }
		}				
	} # for
	
	if (($ast->[0] & 0xFF) == 1  ) { # eq '&'
	
		# This removes outer parens if there are no parens in between
		my @expr_chunks_stripped = map { $_=~s/^\(([^\(\)]+)\)$/$1/;$_} @expr_chunks;
		
		if ($ast->[1] eq 'pow') { # Very ad-hoc! FIXME!
				$expr_str.=join(',', map { "(float)($_)" } @expr_chunks_stripped);
		} else {
			# We must check the args here and split
			my $csub = $stref->{'CalledSub'};
			if (exists $stref->{'Subroutines'}{ $csub  }) {
			( my $sac_args_out,my $sac_args_in) = _separate_in_out_args( $csub, $stref, \@expr_chunks_stripped);
				# Another evil SaC hack!
		        $expr_str =  join(',', map {$_=~s/_top$//;$_} @{$sac_args_out}). ' = '.$expr_str;
		        $expr_str.=join(',',@{$sac_args_in});
				} else {				 
					$expr_str.=join(',',@expr_chunks_stripped);
				}				
		}		
		$expr_str.=')'; 
		if ($ast->[1]  eq $stref->{'CalledSub'} ) {
			$stref->{'CalledSub'} ='';
		}
		
	} elsif ( ($ast->[0] & 0xFF) == 10) {				# eq '@'
		my @expr_chunks_stripped =   map {  $_=~s/^\(([^\(\)]+)\)$/$1/;$_} @expr_chunks;		
		if ( not ($expr_str=~/^\*/ and $expr_chunks_stripped[0]==1) ) { 
			$expr_str.=join(',',@expr_chunks_stripped);
			# But here we'd need to know what the var is!
			$expr_str.=')';
			if ($expr_str=~/\[/) {
				my $count_open_bracket = () =$expr_str=~/\[/;
				my $count_close_bracket = () =$expr_str=~/\]/; 
				if ($count_open_bracket == $count_close_bracket + 1) { 
					$expr_str.=']';
					# And if we did a cast, that should also happen here? 
				} 				 
			} 
		}
		
	} elsif (($ast->[0] & 0xFF) != 10
        #        and $ast->[0] =~ /\W/
    ) {
        my $opcode = $ast->[0];		
        my $op = $RefactorF4Acc::Parser::Expressions::sigils[$opcode & 0xFF];
		if (scalar @{$ast} > 2) {
			my @ts=();
			for my $idx (1 .. scalar @{$ast} -1 ) {				
				 if (ref($ast->[$idx]) eq 'ARRAY') { 
				 	$ts[$idx-1] = _emit_expression_SaC( $ast->[$idx], '',$stref,$f);
				 } else {
				 	my $const_expr =  $ast->[$idx];
				 	# FIXME UGLY SaC HACK! We just assume any number with a '.' is a float
				 	# To do this properly we'd need the type information of all variables and functions in the expression, and a set of typing rules. Spare me!
				 	if ($const_expr=~/^[\-]?\d*\.\d*$/) {
				 		$const_expr=$const_expr.'f';
				 	} elsif (
				 	(ref($ast->[$idx-1]) eq 'ARRAY' 
				 	and $ast->[$idx-1][1] eq '__eq__') or (ref($ast->[$idx+1]) eq 'ARRAY' and $ast->[$idx+1][1] eq '__eq__')) {
				 		$const_expr=$const_expr.'.0f';
				 	}
				 	$ts[$idx-1] = $const_expr;	
				 }				 				 							
			} 
			if ($op eq '^') { croak "OBSOLETE!";
				$op = '**';
				warn "TODO: should be pow()";
#				croak Dumper($ast);
			};
			$expr_str.=join($op,@ts) unless $op eq '$';
		} elsif (defined $ast->[2]) { croak "OBSOLETE!";
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_SaC( $ast->[1], '',$stref,$f) : $ast->[1];
			my $t2 = (ref($ast->[2]) eq 'ARRAY') ? _emit_expression_SaC( $ast->[2], '',$stref,$f) : $ast->[2];			
			$expr_str.=$t1.$ast->[0].$t2;
			if (($ast->[0] & 0xFF) != 9) { # ne '='
				$expr_str="($expr_str)";
			}			
		} else {
			# FIXME! UGLY!
			my $t1 = (ref($ast->[1]) eq 'ARRAY') ? _emit_expression_SaC( $ast->[1], '',$stref,$f) : $ast->[1];
            my $op = $RefactorF4Acc::Parser::Expressions::sigils[$ast->[0] & 0xFF];
			$expr_str=  $op eq '$' ? $t1 :  $op.$t1;
			if (($ast->[0] & 0xFF) == 6) { #eq '/'
#				$expr_str='1'.$expr_str; # I choose float as default. FIXME UGLY SaC HACK!
				$expr_str='1.0f'.$expr_str; # I choose float as default. FIXME UGLY SaC HACK! 
			}
		}
	} else {
		$expr_str.='<'.join(';',grep {$_ ne '' } @expr_chunks);
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
} # END of _emit_expression_SaC_OLD

sub _change_operators_to_SaC { (my $cond_expr) = @_;
	
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
#### #### #### #### END OF SaC TRANSLATION CODE #### #### #### ####
 
# -----------------------------------------------------------------------------


# -----------------------------------------------------------------------------
sub toSaCType {
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
}    # END of toSaCType()
# -----------------------------------------------------------------------------
sub add_to_SaC_build_sources {
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
} # END of add_to_SaC_build_sources()

sub _separate_in_out_args { ( my $csub, my $stref, my $arg_exprs) = @_;
	my @iodirs=();
	for my $arg (@{ $stref->{'Subroutines'}{ $csub  }{'RefactoredArgs'}{'List'} }) {
		push @iodirs,$stref->{'Subroutines'}{ $csub  }{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'}; 
	} 
	my @sac_args_in=();	    			
	my @sac_args_out=();	    
	for my $arg ( @{$arg_exprs} ) {
		my $inout = shift @iodirs;
            if ($inout eq 'in') {
				push @sac_args_in,$arg;
	        } elsif ($inout eq 'out') {
				push @sac_args_out,$arg;		
    	    } else { # InOut
				push @sac_args_in,$arg;
				push @sac_args_out,$arg;
    	    }
        }
        return( \@sac_args_out,\@sac_args_in);
}



# To do this right is too much work
# So what I do is: arrays and scalars are *always* cast to float unless they are in an index expression or a function call
# This is very weak of course
# Too weak, in fact! 

sub _add_cast_calls {(my $ast, my $stref, my $f)=@_;
#	return $ast;
    if (ref($ast) ne 'ARRAY') {
        if ($ast=~/([a-z]\w*)/) {
            my $mvar = $1;    
		 	if (not(
	    	   $mvar=~/__[a-z]+__/
			|| $mvar=~/__PH\d+__/		
			|| $mvar=~/_(?:CONCAT|COLON)_PRE_/
			|| $mvar=~/_PAREN_PAIR_/
			|| exists $Config{'Macros'}{uc($mvar)}
			)) {
            	$ast = __cast_entry($stref, $f,$mvar, $ast);
			}             	
        }
        return $ast;
    }
    for my  $idx (0 .. scalar @{$ast}-1) {		
        my $entry = $ast->[$idx];
        if (ref($entry) eq 'ARRAY') {
            # we should not descend if this is a subroutine call or an array argument
            # i.e, if we have ['&', 'f' ], don't descend
            # if we have ['@', 'a', [...],...] don't descend
            if ($idx>1 && (($ast->[0] & 0xFF) == 10) && $ast->[1] ne '_OPEN_PAR_') {
                # We're in an array, skip
#                say "Not descending into indices of array ".$ast->[1];
            } elsif ( ($entry->[0] & 0xFF) == 1 ) {
                # This is a subroutine, don't go in there
#                say "Not descending into function call ".$entry->[1];
            } else {
                # OK, go in there
                $entry = _add_cast_calls( $entry, $stref, $f);
                if( ($entry->[0] & 0xFF) == 2 or ($entry->[0] & 0xFF) == 10  ) {
                	my $mvar = $entry->[1];
				 	if (not(
			    	   $mvar=~/__[a-z]+__/
					|| $mvar=~/__PH\d+__/		
					|| $mvar=~/_(?:CONCAT|COLON)_PRE_/
					|| $mvar=~/_PAREN_PAIR_/
					|| exists $Config{'Macros'}{uc($mvar)}
					)) {
		                	$entry = __cast_entry($stref, $f,$mvar, $entry);
					}                	 
                }
            }
        }

        $ast->[$idx]=$entry;			
    }    
    return $ast;		
}

sub __get_sac_type {(my $stref, my $f, my $mvar) = @_;
			my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$mvar);
		# Again, I am not inclined (sir!) to do full type checking. So I will recklessly cast all int arrays to floats.
		# FIXME! UGLY SaC HACK!
		my $ftype = $decl->{'Type'};
		my $fkind = $decl->{'Attr'};
		$fkind=~s/\(kind=//;
		$fkind=~s/\)//;
		if ($fkind eq '') {$fkind=4};
	
		if ( $ftype eq 'integer') {
			if ($fkind == 4) {							
				return 'int';
			} elsif ($fkind == 8) {
				return 'long';
			} 							
		} elsif (
			$ftype eq 'real'
		)  {
			return 'float';
		} elsif (  $ftype =~/double/) {
			return 'double';
		} else {
			croak "$mvar: $ftype $fkind";
		}   			
}
sub __cast_entry { (my $stref, my $f, my $mvar, my $entry) = @_;
	
		my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$mvar);
		# Again, I am not inclined (sir!) to do full type checking. So I will recklessly cast all int arrays to floats.
		# FIXME! UGLY SaC HACK!		
		my $ftype = $decl->{'Type'};
		my $fkind = $decl->{'Attr'};
		$fkind=~s/\(kind=//;
		$fkind=~s/\)//;
		if ($fkind eq '') {$fkind=4};
	
		if ( $ftype eq 'integer') {
			if ($fkind == 4) {							
				$entry=[1,'tof',$entry];
			} elsif ($fkind == 8) {
				$entry=[1,'tod',$entry];
			} else {
				warn "$mvar is an integer with kind $fkind, not casting!";
			}
		}        
		return $entry;        	
	
	
}
=pod
The superkernel as generated by Gavin's compiler is missing parameter declarations for the array dimensions.
This pass adds these declarations in  

  $stref->{'Subroutines'}{$f}{'LocalParameters'}

where they will be found by `eval_expression_with_parameters()`
  
What we do is:

=cut
sub _hack_to_fix_param_decls_in_superkernel { my ($stref, $f)=@_;
	
	if ($f eq $Config{'KERNEL'}) {
		
# 1. Scan the declarations for arrays with dimensions that have parameters		
		my $pass_find_array_decls_with_dim_params = sub { (my $annline, my $state)=@_;
			(my $line,my $info)=@{$annline};
			my $c_line=$line;
			(my $stref, my $f, my $pass_state)=@{$state};
			my $skip=0;
			if (exists $info->{'VarDecl'} ) {
				# Implicit assumption that any parameter declaration used in the dimension attribute of an array declaration must have come before it
				if ( exists $info->{'ParamDecl'} ) { 	            
					my $var = $info->{'VarDecl'}{'Name'};
					if (exists $pass_state->{'MissingParams'}{$var}) {
						delete $pass_state->{'MissingParams'}{$var};
					}										
				} else {
						my $var = $info->{'VarDecl'}{'Name'};
#						say "$f $var ". Dumper($info);
						my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Vars'},$var);
						my $array = $decl->{'ArrayOrScalar'} eq 'Array' ? 1 : 0;
						if ($array) {
							my $dim = $decl->{'Dim'};
							for my $pair ( @{$dim} ) {
								for my $dim_expr (@{$pair}) {
									my $ast = parse_expression($dim_expr , {}, $stref, $f);
									my $pars = get_vars_from_expression($ast, {});
									for my $par (keys %{$pars}) {
										$pass_state->{'MissingParams'}{$par}{'InVarDecl'}{$var} = 1;
									}																	
								}	
							}
						}
				}
			}
			
			return ([$annline],[$stref,$f,$pass_state]);
		};
	
		my $state = [$stref,$f, {'MissingParams'=>{},'Found'=>0}];
	 	($stref,$state) = stateful_pass($stref,$f,$pass_find_array_decls_with_dim_params, $state,'_hack_to_fix_param_decls_in_superkernel_PASS1() ' . __LINE__  ) ;
		delete $state->[2]{'MissingParams'}{'_OPEN_PAR_'};		
		
# 2. Scan the Subroutine calls for accesses to arrays that have parameters. When we find one, we get the parameter declarations from the subroutine record.
# This is a bit dodgy but will work because we have inlined the parameters when the code was generated. 		
	 	my $pass_find_array_with_dim_params_in_subcalls = sub { (my $annline, my $state)=@_;
			(my $line,my $info)=@{$annline};
			my $c_line=$line;
			(my $stref, my $f, my $pass_state)=@{$state};
			my $skip=0;
			if ($pass_state->{'Found'} == 0 and  exists $info->{'SubroutineCall'} ) {
				my $csub = $info->{'SubroutineCall'}{'Name'};
				# Get the arguments
				for my $par (sort keys %{$pass_state->{'MissingParams'}}) {
					 for my $arg (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
					 	if (exists $pass_state->{'MissingParams'}{$par}{'InVarDecl'}{$arg}) {
#					 		say "Found arg $arg with par $par in call to $csub";
					 		# Now get the parameter from this subroutine
					 		my $decl = get_var_record_from_set($stref->{'Subroutines'}{$csub}{'Parameters'},$par);
#					 		emit_f95_var_decl($decl);					 		
					 		$pass_state->{'MissingParams'}{$par}{'ParDecl'} = $decl;					 			
					 		$stref->{'Subroutines'}{$f}{'LocalParameters'}{'Set'}{$par} = $decl;
					 		push @{$stref->{'Subroutines'}{$f}{'LocalParameters'}{'List'}},$par;
#					 		say in_nested_set( $stref->{'Subroutines'}{$csub},'Parameters',$par);				 		
					 		last;
					 	}
				 	}				 	
				 }		
				 $pass_state->{'Found'} =1;
			}			
			return ([$annline],[$stref,$f,$pass_state]);
		};
	
#		my $state = [$stref,$f, {'MissingParams'=>{}}];
	 	($stref,$state) = stateful_pass($stref,$f,$pass_find_array_with_dim_params_in_subcalls, $state,'_hack_to_fix_param_decls_in_superkernel_PASS2() ' . __LINE__  ) ;
	 	
#	 	die Dumper($stref->{'Subroutines'}{$f}{'LocalParameters'});
	}
 	return $stref;
	
} # END of _hack_to_fix_param_decls_in_superkernel 

=pod
This is an attempt to determine intermediate arrays used in the superkernel, so that we can generate these using genarray and remove them from the superkernel signature.

1. Scan all subroutines for 'Out' arguments, these can definitely be removed from the superkernel signature input arguments. They also are sure to be `genarray()` 
Make a map, tag with the subroutine. 
Do the same for 'In' arguments

	$in_or_out_args = {
	'Out' => {$f => {$var => 1, ...}},
	'In' => {$f => {$var => 1, ...}},
	'InOut' =>{$f => {$var => 1, ...}},
	}

The 'Out' is enough to use genarray. But it only means removal from args if it was not previously used as In or InOut. So that requires the full pass first. Basically:

	
2. Make a list of the calls in the superkernel, in order

	 $call_order = [$csub]
	 
This can of course be done in the same pass. In fact, it can be folded into the first pass	 
	 
3. Now check if an arg previously used as 'In' is used as 'Out'. 
	
	if ($arg is Out in $csub and $arg is In in $other_csub and $other_csub precedes $csub in $call_order 
	
	    $arg is Out: 
	    
	    	my $arg_is_out = exists $in_or_out_args->{'Out'}{$csub}{$arg} ? 1 : 0  ;
	    	
	    $arg is In in $other_csub and $other_csub precedes $csub in $call_order:
	    
	    	my $arg_is_prev_in = 0;
	    	my $arg_is_prev_inout = 0;
	    	for my $other_csub (@{$call_order}) {
	    		last if $other_csub = $csub;
	    		if (
	    		exists $in_or_out_args->{'In'}{$other_csub}{$arg}
	    		) {
	    			$arg_is_prev_in=$other_csub;	    		
	    		}
	    		if (
	    		exists $in_or_out_args->{'InOut'}{$other_csub}{$arg}
	    		) {
	    			$arg_is_prev_inout=$other_csub;	    		
	    		}
	    		
	    	}
	    	
	    if ( $arg_is_out ) { 
	    	if (!$arg_is_prev_in && !$arg_is_prev_inout) {
	    		# So far safe to remove, put in table 	    		
	    	} else {
	    		# Not safe, if it was in the table, delete it
	    	}     	
	    }   

		if ( $arg_is_prev_in && $arg_is_out ) {
	    	# $arg needs to be renamed. We need a table with the suffix count
	    }

What this means is that they actually have nothing to do with one another. 
In that case, I should rename the later occurrence   

	v :: In
	call f1(v,v2)
	v :: Out
	call f2(v1,v)
	v :: In
	call f3(v,v3)
	v :: InOut
	call f4(v)
 
should become 
 
	v :: In
	call f1(v,v2)
	v_ :: Out
	call f2(v1,v_)
	v :: In
	call f3(v_,v3)
	v :: InOut
	call f4(v_)
	
Now check if there is an InOut in between	

	v :: In
	call f1(v,v2)
	v :: InOut
	call f1b(v)	
	v :: Out
	call f2(v1,v)
	v :: In
	call f3(v,v3)
	v :: InOut
	call f4(v)

This is different because the input v in f1 and g1b is the same, but after that is is modified. 

	v2 = map f1(v)
	v' = map f1b(v)
	v'' = map f2(v1)
	v3 = map f3(v'')
	v''' = map f4(v'')

So what we should do is also keep a list of InOut and do another renaming, which we update for every subroutine call
 	 
=cut
sub _determine_intermediate_arrays {  (my $stref, my $f)=@_;
#	die $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{'eta'}{'IODir'} if $f eq 'shapiro_map_15' ;
		if ($f eq $Config{'KERNEL'}) {
	#		say "KERNEL $f";
	# 1. Scan the declarations for arrays with dimensions that have parameters		
			my $pass_array_arg_analysis = sub { (my $annline, my $state)=@_;
				(my $line,my $info)=@{$annline};
				(my $stref, my $f, my $pass_state)=@{$state};
				if (exists $info->{'SubroutineCall'} ) {
					my $csub = $info->{'SubroutineCall'}{'Name'};
					push @{$pass_state->{'CallOrder'}}, $csub;
					 for my $arg (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
	#				 	say in_nested_set($stref->{'Subroutines'}{$csub},'Vars',$arg);
					 	my $decl = get_var_record_from_set($stref->{'Subroutines'}{$csub}{'Vars'},$arg);
					 	if ($decl->{'ArrayOrScalar'} eq 'Array') {
					 		$pass_state->{'ArrayArgs'}{$decl->{'IODir'}}{$csub}{$arg}=1;
	#				 		say "ARRAY $arg in $csub is ".$decl->{'IODir'};
					 	}
				 	}				 	
					
				}
				
				return ([$annline],[$stref,$f,$pass_state]);
			};
		
			my $state = [$stref,$f, {'ArrayArgs'=>{},'CallOrder'=>[], 'ArgsToRemove'=>{}}];
		 	($stref,$state) = stateful_pass($stref,$f,$pass_array_arg_analysis, $state,'_determine_intermediate_arrays() ' . __LINE__  ) ;
		 		
		    my $array_args = $state->[2]{'ArrayArgs'};
	#	    say Dumper($array_args );
		    my $call_order = $state->[2]{'CallOrder'};
		    my $args_to_remove = {};
		    # For each sub in order
		    for my $csub (@{$call_order}) {
	#	    	say "SUB CALL $csub";
		    	# Loop over all Out args
			    for my $arg (sort keys %{ $array_args->{'out'}{$csub} }) {
	#		    	say "OUT arg $arg";
			    	my $arg_is_prev_in = 0;
			    	my $arg_is_prev_inout = 0;
			    	for my $other_csub (@{$call_order}) {
	#		    		say "OTHER: $other_csub"; 
			    		last if $other_csub eq $csub;
			    		if (
			    		exists $array_args->{'in'}{$other_csub}{$arg}
			    		) {
	#		    			say "ARG $arg is In in $other_csub";
			    			$arg_is_prev_in=$other_csub;	    		
			    		}
			    		if (
			    		exists $array_args->{'inout'}{$other_csub}{$arg}
			    		) {
	#		    			say "ARG $arg is InOut in $other_csub";
			    			$arg_is_prev_inout=$other_csub;	    		
			    		}
			    		
			    	}
				     
			    	if (!$arg_is_prev_in && !$arg_is_prev_inout) {
			    		# So far safe to remove, put in table 	
			    		$args_to_remove->{$arg}=1;    		
			    	} else {
			    		# Not safe, if it was in the table, delete it
			    		if (exists $args_to_remove->{$arg}) {
			    			delete $args_to_remove->{$arg};
			    		}
			    	}     				    
			    }
		    }
		    
			my $pass_remove_superkernel_intermediate_args = sub { (my $annline, my $state)=@_;
				(my $line,my $info)=@{$annline};
				(my $stref, my $f, my $pass_state)=@{$state};
				if (exists $info->{'Signature'} ) {
					
					my $reduced_arg_list =[ grep { not exists $args_to_remove->{$_} } @{$info->{'Signature'}{'Args'}{'List'}} ];				
					for my $arg ( sort keys %{$args_to_remove} ) {
						delete $info->{'Signature'}{'Args'}{'Set'}{$arg};
		    		}				
		    		$info->{'Signature'}{'Args'}{'List'}=$reduced_arg_list;
				}
				
				return ([$annline],[$stref,$f,$pass_state]);
			};
		
			$state = [$stref,$f, {'ArgsToRemove'=>$args_to_remove}];
		 	($stref,$state) = stateful_pass($stref,$f,$pass_remove_superkernel_intermediate_args, $state,'_determine_intermediate_arrays() ' . __LINE__  ) ;	    
		    
		    my $reduced_arg_list =[ grep { not exists $args_to_remove->{$_} } @{ $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'} } ];				
			for my $arg ( sort keys %{$args_to_remove} ) {
				delete $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg};
	    	}				
	    	$stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'List'}=$reduced_arg_list;
		    			
		}
	return $stref; 
} # END of _determine_intermediate_arrays()


1;
