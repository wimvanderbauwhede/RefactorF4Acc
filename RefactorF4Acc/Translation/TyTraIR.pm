package RefactorF4Acc::Translation::TyTraIR;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw(
	pass_wrapper_subs_in_module					
	);
use RefactorF4Acc::Translation::TyTra::Common qw(
pp_links 
_mkVarName 
__isMainInArg 
__isMainOutArg 
_addToMainSig 
_addToVarTypes 
F3D2C 
F2D2C 
F1D2C 
F4D2C 
);
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Translation::TyTraIR::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTraIR::EXPORT_OK = qw(
&pass_emit_TyTraIR
);

our $FOLD=0;


sub pass_emit_TyTraIR {(my $stref)=@_;
    # WV: I think Selects and Inserts should be in Lines but I'm not sure
    $stref->{'EmitAST'} = 'TyTraIR_AST';
	$stref->{'TyTraIR_AST'} = {'Lines' => [], 'Selects' => [], 'Inserts' => [], 'Stencils'=>{},'Portions'=>{},'ASTEmitter' => \&_add_TyTraIR_AST_entry};
	$stref = pass_wrapper_subs_in_module($stref,
			[
#				[ sub { (my $stref, my $f)=@_;  alias_ordered_set($stref,$f,'DeclaredOrigArgs','DeclaredOrigArgs'); } ],
		  		[
			  		\&identify_array_accesses_in_exprs,
				],
			]
		);        
        my $tytracl_str = _emit_TyTraIR($stref);
        say $tytracl_str;
        exit ;

	return $stref;
} # END of pass_emit_TyTraIR()

# {'Lines' => [
#		{'NodeType' => 'StencilDef',
#			'Lhs' => {'Ctr' => $ctr_st},
#			'Rhs' => {'StencilPattern' => { 'Accesses' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'}},
#			'Dims' => ...}
#		};
# 		{'NodeType' => 'StencilAppl',
# 			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] },
# 			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
# 		};
#		{'NodeType' => 'Map',
#			'Lhs' => {
#				'Vars' =>[@out_tup_ast],
#			},
#			'Rhs' => {
#				'NonMapArgs' => {
#					'Vars'=>[@non_map_args_ms_ast],
#				},
#				'MapArgs' =>{
#					'Vars' =>$in_tup_ms_ast,
#				}
#			}
#		};
#	],
#	'Selects' => [
#						{
#							'Lhs' => {'Var' => [$array_var, 'TODO','portion']},
#							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern' =>['TODO']}
#						};
#	],
#	'Inserts' => [
#						{
#							'Lhs' => {'Var' => [$array_var,$ctr_out,''] },
#							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern'=> ['TODO']},
#						};
#	]
#};

sub _emit_TyTraIR {  (my $stref) = @_;
	# FIXME: we ignore Selects and Inserts for now.
    # We need the superkernel as the main, and we must identify its input and output arguments
    # Input args have Ctr==0 on the Rhs
    # Output args $arg have Ctr == $tytracl_ast->{'UniqueVarCounters'}{$arg}
	my $tytracl_ast = $stref->{'TyTraIR_AST'} ;
	my $tytracl_strs = [];
    my $main_rec = {'NodeType' => 'Main', 'InArgs' => [], 'OutArgs' => [],'Main' => $tytracl_ast->{'Main'}};
    my $var_types={};
    my $stencils={};
    my $state = {};
	for my $node (@{ $tytracl_ast->{'Lines'} } ) {
        my $fname = $node->{'FunctionName'};
		my $lhs = $node->{'Lhs'} ;
		my $rhs = $node->{'Rhs'} ;
        $main_rec = _addToMainSig($stref,$main_rec, $node, $lhs, $rhs, $fname);
        ($var_types, $stencils) = _addToVarTypes($stref, $var_types, $stencils, $node, $lhs, $rhs, $fname,\&__toTyTraIRType);
        # These are never arguments of the main function
		if ($node->{'NodeType'} eq 'StencilDef') {
			my $ctr = $lhs->{'Ctr'};
			my $stencil_ast = $rhs->{'StencilPattern'}{'Accesses'};
            my $array_dims = $rhs->{'StencilPattern'}{'Dims'};
            my @evaled_array_dims = ();
            for my $array_dim (@{ $array_dims } ) {
                push @evaled_array_dims, eval( $array_dim->[1].' - '.$array_dim->[0] );
            }

			my @stencil_pattern = map { $_=~s/:/,/;"[$_]" } sort keys %{$stencil_ast};
            # I should get the linear dimension from somewhere, we could add this information to the stencil detection
            # TODO: this needs to be generic so I should split the above and combine it with the dimensions
            my @stencil_pattern_eval = map {my $res=eval("my \$a=$_;my \$b=\$a->[0]*".$evaled_array_dims[0]."+\$a->[1];\$b");$res} @stencil_pattern;# FIXME: HACK!
            #my $stencil_definition = '['.join(',',@stencil_pattern).']';
            my $stencils_ = _generate_TyTraIR_stencils( $rhs->{'StencilPattern'} );
            my $stencil_definition = '['.join(',',@{$stencils_}).']';

			my $line = "s$ctr = $stencil_definition";
			$state->{$ctr}{'StencilDef'}=$stencil_definition;
			push @{$tytracl_strs},'-- '.$line;
		}
        # The stencil itself should be skipped but the others can be main args
        # The value returned from a stencil application should never be an output arg
        # Because of the way we identify and generate stencils, the stencil arg will always be a var, not a tuple
		elsif ($node->{'NodeType'} eq 'StencilAppl') {
			my $lhs_var = _mkVarName($lhs->{'Var'});
			my $rhs_var = _mkVarName($rhs->{'Var'});
            (my $var_name, my $ctr, my $ext) = @{$rhs->{'Var'}};
            #            if ($ctr == 0 && $ext eq '') {
            #                push @{ $main_rec->{'InArgs'} }, $var_name;
            #            }
			my $stencil_ctr = $rhs->{'StencilCtr'};
			my $line = "$lhs_var = stencil s$stencil_ctr $rhs_var".' -- '.$state->{$stencil_ctr}{'StencilDef'};
			push @{$tytracl_strs},$line;
		}
#			'Lhs' => {
#				'Vars' =>[@out_tup_ast],
#			},
#			'Rhs' => {
#				'Function' => $f,
#				'NonMapArgs' => {
#					'Vars'=>[@non_map_args_ms_ast],
#				},
#				'MapArgs' =>{
#					'Vars' =>$in_tup_ms_ast,
#				}
#			}
        # Arguments of map can be main args in several ways
        # NonMapArgs, which I can make sure are not tuples
        # MapArgs which can be (in fact will usually be) a ZipT of args
		elsif ($node->{'NodeType'} eq 'Map') {
			my $out_vars = $lhs->{'Vars'};
			my $map_args = $rhs->{'MapArgs'}{'Vars'};
			my $non_map_args = $rhs->{'NonMapArgs'}{'Vars'};
			my $lhs_str = (scalar @{$out_vars} == 1 )
				? _mkVarName($out_vars->[0]). ' = '
				: '('.join(',',map {_mkVarName($_) } @{$out_vars}).') = unzipt $';

			my $non_map_arg_str = (scalar @{$non_map_args} == 0 ) ? '' : (scalar @{$non_map_args} == 1 )
				? _mkVarName($non_map_args->[0])
				: '('.join(',',map {_mkVarName($_) } @{$non_map_args}).')';
			my $map_arg_str = (scalar @{$map_args} == 1 )
					? _mkVarName($map_args->[0])
					: '(zipt ('.join(',',map {_mkVarName($_) } @{$map_args}).'))';
            my $f = $rhs->{'Function'};
			my $f_str = $non_map_arg_str eq '' ? $f : "($f $non_map_arg_str)";
			my $line = "$lhs_str map $f_str $map_arg_str";
			push @{$tytracl_strs},$line;
		}
		elsif ($node->{'NodeType'} eq 'Fold') {
			my $out_vars = $lhs->{'Vars'};
			my $map_args = $rhs->{'FoldArgs'}{'Vars'};
			my $non_map_args = $rhs->{'NonFoldArgs'}{'Vars'};
			my $acc_args = $rhs->{'AccArgs'}{'Vars'};
			
			my $lhs_str = (scalar @{$out_vars} == 1 )
				? _mkVarName($out_vars->[0]). ' = '
				: '('.join(',',map {_mkVarName($_) } @{$out_vars}).') = unzipt $';

			my $non_map_arg_str = (scalar @{$non_map_args} == 0 ) ? '' : (scalar @{$non_map_args} == 1 )
				? _mkVarName($non_map_args->[0])
				: '('.join(',',map {_mkVarName($_) } @{$non_map_args}).')';
				
			my $acc_arg_str	= (scalar @{$acc_args} == 1 )
				? _mkVarName($acc_args->[0])
				: '('.join(',',map {_mkVarName($_) } @{$acc_args}).')';
			my $map_arg_str = (scalar @{$map_args} == 1 )
					? _mkVarName($map_args->[0])
					: '(zipt ('.join(',',map {_mkVarName($_) } @{$map_args}).'))';
					
            my $f = $rhs->{'Function'};
			my $f_str = $non_map_arg_str eq '' ? $f : "($f $non_map_arg_str)";
			my $line = "$lhs_str fold $f_str $acc_arg_str $map_arg_str";
			push @{$tytracl_strs},$line;
		}		
        elsif ($node->{'NodeType'} eq 'Comment') {
            my $line = ' -- ' . $node->{'CommentStr'};
            push @{$tytracl_strs},$line;
        }
		else {
			croak;
		}
	}
    # Indent
     my @tytracl_strs_indent = map {"    $_"} @{$tytracl_strs};
   #

    # Wrap into main
    #
    my $main_in_args_str = scalar @{$main_rec->{'InArgs'}} > 1 ? '('.join(',', @{$main_rec->{'InArgs'}}).')' :  $main_rec->{'InArgs'}->[0];
    my $main_out_args_str = scalar @{$main_rec->{'OutArgs'}} > 1 ? '('.join(',', @{$main_rec->{'OutArgs'}}).')' :  $main_rec->{'OutArgs'}->[0];
    unshift @tytracl_strs_indent, '  let';
    unshift @tytracl_strs_indent, "main $main_in_args_str =";
    unshift @tytracl_strs_indent, "";
    push @tytracl_strs_indent,'  in';
    push @tytracl_strs_indent,"    $main_out_args_str";

    # Add function type decls
    #
    for my $f (sort keys %{ $var_types }) {
        #        say $f;
        if (exists $var_types->{$f} and ref($var_types->{$f}) eq 'HASH' and exists $var_types->{$f}{'FunctionTypeDecl'}) {
            unshift @tytracl_strs_indent,$var_types->{$f}{'FunctionTypeDecl'};
        }
    }
    #    say Dumper($main_rec);
	my $tytracl_str = join("\n", @tytracl_strs_indent);
	return $tytracl_str;
} # END of _emit_TyTraIR()


sub __toTyTraIRType { (my $type)=@_;

    if ($type eq 'real') { return 'real';
    } elsif ($type eq 'integer') { return 'i32';
    } else {
        # ad-hoc!
        return ucfirst($type);
    }
}

# Maybe I will be lazy and only support 1, 2, 3 and 4 dimension

sub _generate_TyTraIR_stencils { (my $stencil_patt)=@_;
    my $stencil_ast = $stencil_patt->{'Accesses'}; 
    my $array_dims = $stencil_patt->{'Dims'};
    my @stencil_pattern = map { [ split(/:/,$_) ] } sort keys %{$stencil_ast};
    #    say Dumper(@stencil_pattern). ' ; '.Dumper($array_dims );
    my $tytracl_stencils=[];
    for my $index_tuple (@stencil_pattern) {
        my @ranges = ();
        my @lower_bounds = ();
        my $n_dims = scalar @{ $array_dims };
        for my $array_dim (@{ $array_dims } ) {
            push @ranges, eval( $array_dim->[1].' - '.$array_dim->[0] . ' + 1');
            push @lower_bounds, $array_dim->[0];
        }
        if ($n_dims == 1) {
            push @{$tytracl_stencils}, F1D2C(@lower_bounds, @{$index_tuple});
        } elsif ($n_dims == 2) {
            #            say Dumper( (@ranges[0..1],@lower_bounds, @{$index_tuple}) );
            push @{$tytracl_stencils}, F2D2C($ranges[0],@lower_bounds, @{$index_tuple});
        } elsif ($n_dims == 3) {
            push @{$tytracl_stencils}, F3D2C(@ranges[0..1],@lower_bounds, @{$index_tuple});
        } elsif ($n_dims == 4) {
            push @{$tytracl_stencils}, F4D2C(@ranges[0..2],@lower_bounds, @{$index_tuple});
        } else {
            croak "Sorry, only up to 4 dimensions supported right now!";
        }
    }

    my $tytracl_stencils_str;

    return $tytracl_stencils
}

sub _add_TyTraIR_AST_entry { (my $f, my $state, my $tytracl_ast, my $type, my $block_id, my $array_var, my $rw) = @_;
	
	if (not defined $array_var) {
		$array_var = '#dummy#';
	}
	if ($type eq 'INIT_AST') {
	if (not exists $tytracl_ast->{'UniqueVarCounters'}) {
		$tytracl_ast->{'UniqueVarCounters'}={'!s' => 0};
	}
	}
	
	my $unique_var_counters=$tytracl_ast->{'UniqueVarCounters'};
	
	if ($type eq 'INIT_COUNTERS') {
 	if (not exists $unique_var_counters->{$array_var}) {
 			$unique_var_counters->{$array_var}=0;
 	}	
	}
	if ($type eq 'STENCIL') {
							my $ctr_st = ++$unique_var_counters->{'!s'};
						push @{$tytracl_ast->{'Lines'}},
						{'NodeType' => 'StencilDef', 'FunctionName' => $f,
							'Lhs' => {'Ctr' => $ctr_st},
							'Rhs' => {'StencilPattern' => {
                                    'Accesses' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{$rw}{'Accesses'},
                                    'Dims' => $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'}
                                }
                            }
						};
						my $ctr_in = $unique_var_counters->{$array_var};

				 		if (not exists $unique_var_counters->{"${array_var}_s"}) {
				 			$unique_var_counters->{"${array_var}_s"}=0;
				 		} else {
				 			$unique_var_counters->{"${array_var}_s"}++;
				 		}
				 		my $ctr_sv = $unique_var_counters->{"${array_var}_s"};
                        #say "${array_var}_s$ctr_sv = stencil s$ctr_st ${array_var}_${ctr_in}";
				 		push @{ $tytracl_ast->{'Lines'} },
				 		{'NodeType' => 'StencilAppl', 'FunctionName' => $f,
				 			'Lhs' => {'Var' => [$array_var,$ctr_sv,'s'] },
				 			'Rhs' => {'StencilCtr' => $ctr_st,'Var' => [$array_var, $ctr_in,''] }
				 		};
				 		$tytracl_ast->{'Stencils'}{$array_var}=1,
	} elsif ($type eq 'SELECT') {
				 								my $ctr_in = $unique_var_counters->{$array_var};
#						push @selects,"${array_var}_portion = select patt ${array_var}_${ctr_in} -- TODO";
						push @{ $tytracl_ast->{'Selects'} },
						{
							'Lhs' => {'Var' => [$array_var, 'TODO','portion']},
							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern' =>['TODO']}
						};
				 		if (not exists $unique_var_counters->{"${array_var}_portion"}) {
				 			$unique_var_counters->{"${array_var}_portion"}=0;
				 		} else {
				 			$unique_var_counters->{"${array_var}_portion"}++;
				 		}
				 		$tytracl_ast->{'Portions'}{$array_var}=1,
 	} elsif ($type eq 'INSERT') {
						my $ctr_in = $unique_var_counters->{$array_var};
						my $ctr_out = ++$ctr_in;
						$unique_var_counters->{$array_var}=$ctr_out;
#						push @inserts, "${array_var}_${ctr_out} = insert patt buf_to_insert ${array_var}_${ctr_in} -- TODO";						
						push @{$tytracl_ast->{'Inserts'}},{
							'Lhs' => {'Var' => [$array_var,$ctr_out,''] },
							'Rhs' =>  {'Var' => [$array_var, $ctr_in,''], 'Pattern'=> ['TODO']},
						};
 	} elsif ($type eq 'MAP') {
 		my $node_type = 'Map';
 		my %portions = %{$tytracl_ast->{'Portions'}};
 		my %stencils= %{$tytracl_ast->{'Stencils'}};
 		# so this provides the output and input tuples for a given $f
	# so for each var in $in_tup we need to get the counter, and for each var in $out_tup after that too.
		(my $out_tup, my $in_tup_maybe_dummies) = pp_links($state->{'Subroutines'}{$f}{'Blocks'}{$block_id}{'Links'});
		 $in_tup_maybe_dummies =$state->{'Subroutines'}{$f}{'Args'}{'In'};
#		  say Dumper($in_tup_maybe_dummies);
		# This is incorrect because it does not return arguments that are used in conditions only
		my %accs =();
		my @acc_args = ();
		if ($FOLD) {
		 @acc_args =  @{$state->{'Subroutines'}{$f}{'Args'}{'Acc'}};
		 if (scalar @acc_args > 0) {
		 	say "$f is a reduction ";
		 	$node_type = 'Fold';		 	
		 }
		  %accs = map {$_ => $_} @acc_args;
		}
		# A slightly better way is to look at which arrays are covered entirely by a map operation
		my $n_dims = scalar keys %{$state->{'Subroutines'}{ $f }{'Blocks'}{$block_id}{'LoopIters'}};

		my @in_tup = grep { $_!~/^\!/ } @{$in_tup_maybe_dummies};
		my @in_tup_correct_dim =  grep {
			exists $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_} and
			scalar @{ $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_}{'Dims'} } >= $n_dims
		} @in_tup;

		my @in_tup_non_map_args =  grep {
			# Add ACC condition			
			(
			(not exists $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_}) or
			(scalar @{ $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$_}{'Dims'} } < $n_dims)
			)
		} @in_tup;
		
		my @in_tup_non_fold_args = grep { not exists $accs{$_}  } @in_tup_non_map_args; 

		my $in_tup_ms_ast = [
			map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ?
				[$_,$unique_var_counters->{$_.'_s'},'s'] : #
				exists $portions{$_} ?
				[$_,$unique_var_counters->{$_.'_portion'},'portion'] :
				[$_,$unique_var_counters->{$_},'']
			} @in_tup_correct_dim
		];
		
		my $map_args_ms_ast = $in_tup_ms_ast;
		my $fold_args_ms_ast = $in_tup_ms_ast;
#		my $in_tup_ms = [
#			map {				
#				if (not exists $unique_var_counters->{$_}) {
#					$unique_var_counters->{$_}=0;
#				}
#				exists $stencils{$_} ?
#				$_.'_s'.$unique_var_counters->{$_.'_s'} : #
#				exists $portions{$_} ?
#				$_.'_portion_'.$unique_var_counters->{$_.'_portion'} :
#				$_.'_'. $unique_var_counters->{$_}
#			} @in_tup_correct_dim
#		];
		my @non_map_args_ms_ast = map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ?
				[$_,$unique_var_counters->{$_.'_s'},'s'] :
				exists $portions{$_} ?
				[$_,$unique_var_counters->{$_.'_portion'},'portion'] :
				[$_,$unique_var_counters->{$_},'']
			} @in_tup_non_map_args;
			
		my @non_fold_args_ms_ast = map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}
				exists $stencils{$_} ?
				[$_,$unique_var_counters->{$_.'_s'},'s'] :
				exists $portions{$_} ?
				[$_,$unique_var_counters->{$_.'_portion'},'portion'] :
				[$_,$unique_var_counters->{$_},'']
			} @in_tup_non_fold_args;			
			
		my @acc_args_ast = map {
				if (not exists $unique_var_counters->{$_}) {
					$unique_var_counters->{$_}=0;
				}				
				[$_,$unique_var_counters->{$_},'']
			} @acc_args;			
			
		my @out_tup_ast=();
		for my $var (@{$out_tup}) {
			if (not exists $unique_var_counters->{$var}) {
				$unique_var_counters->{$var}=0;
			} else {
				$unique_var_counters->{$var}++;
			}
			push @out_tup_ast,[$var,$unique_var_counters->{$var},'']
		}

        if ($node_type eq 'Map') {
		push @{$tytracl_ast->{'Lines'}},
		{'NodeType' => $node_type,'FunctionName' => $f,

			'Lhs' => {
				'Vars' =>[@out_tup_ast],
			},
			'Rhs' => {
                'Function' => $f,
				'NonMapArgs' => {
					'Vars'=>[@non_map_args_ms_ast],
				},
				'MapArgs' =>{
					'Vars' =>$map_args_ms_ast,
				}
			}
		};
        } elsif ($FOLD and $node_type eq 'Fold') { 
		push @{$tytracl_ast->{'Lines'}},
		{'NodeType' => 'Fold','FunctionName' => $f,

			'Lhs' => {
				'Vars' =>[@out_tup_ast],
			},
			'Rhs' => {
                'Function' => $f,
                'AccArgs' => {
                	'Vars'=>[@acc_args_ast],
                },
				'NonFoldArgs' => {
					'Vars'=>[@non_fold_args_ms_ast],
				},
				'FoldArgs' =>{
					'Vars' =>$fold_args_ms_ast,
				}
			}
		};        	
        }
        #		map { say $_ } @inserts;	
	} elsif ($type eq 'MAIN') {
		# TRICK: $state = $stref
#				$ast_to_emit = $ast_emitter->( $f,  $stref,  $ast_to_emit, 'SELECT',  $block_id,  $array_var,  $rw) if $emit_ast; 
        $tytracl_ast->{'Main'} = $f;

        		
#		map { say $_ } sort keys %{ $stref->{'Subroutines'}{$f} };
#		say Dumper $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'};
		 for my $arg (@{ $state->{'Subroutines'}{$f}{'RefactoredArgs'}{'List'} } ) {
#		 	say $arg. ' => '. $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
         $tytracl_ast->{'OrigArgs'}{$arg} =  $state->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'};
		 }
		
	}
				 		
	return $tytracl_ast;
} # END of _add_TyTraIR_AST_entry

sub _scalarize_array_expr { (my $expr_str) = @_;
    my $var_str=$expr_str;
    #$var_str=~s/[\(,]/_/g; 
    #$var_str=~s/\)//g; 
    #$var_str=~s/\+/p/g;
    #$var_str=~s/\-/m/g;
    #$var_str=~s/\*/t/g;
    $var_str=~tr/(,+\-*)/__pmt /;
    $var_str=~s/\s+//g;
    return $var_str;

}



1;
