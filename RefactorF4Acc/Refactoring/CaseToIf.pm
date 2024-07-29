package RefactorF4Acc::Refactoring::CaseToIf;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Parser qw( parse_fortran_src );
use RefactorF4Acc::Parser::Expressions qw( parse_expression_no_context emit_expr_from_ast get_vars_from_expression );
use RefactorF4Acc::Refactoring::Helpers qw(
	stateful_pass_inplace
	splice_additional_lines_cond_inplace
	);
use RefactorF4Acc::Emitter qw( emit_AnnLines );

use vars qw( $VERSION );
$VERSION = "5.1.0";

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  replace_case_by_if
);

#== SELECT/CASE
#@ Select, CaseVar => expression AST
#@ Case, CaseVals => [...,[...,...],...] (must be constants)
#@ CaseDefault
#@ EndSelect

#== IF/THEN/ELSE
#@ If, ElseIf, Else, EndIf
#@ Cond Expr => $cond
#@ Cond AST => $ast
#@ CondVars =>
#@     Set => {...}
#@     List => [...]

sub replace_case_by_if { my ( $stref, $f, $annlines ) = @_;
	# my $Sf = $stref->{'Subroutines'}{$f};
	# $Sf->{'RefactoredCode'}=$annlines;

	my $pass_replace_case_by_if= sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		# say "CASE STMT LINE:<$line>";
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
        my $id = $info->{'LineId'};
		# my $skip=0;
		if (exists $info->{'CaseVar'}) {
			push @{$pass_state->{'CaseStack'}}, dclone($info->{'CaseVar'});
			$pass_state->{'CaseElseIf'}=0;
			delete $info->{'CaseVar'};
			delete $info->{'Select'};
			$info->{'Deleted'}=1;
			# $skip=1;
		}
		elsif (exists $info->{'Case'}) {
			if ($pass_state->{'CaseElseIf'}) {
				$info->{'ElseIf'} = 1;
			} else {
				if ($pass_state->{'CaseElseIf'} == 0) {$pass_state->{'CaseElseIf'}=1}
			}
			$info->{'If'} = 1;
			$info->{'IfThen'} = 1;

			delete $info->{'Case'};
			my $select_expr_ast = $pass_state->{'CaseStack'}[-1];

			# The comma-separated expressions:
			# Turn into ( $expr == $v )
			# The nested pairs are b,e => (b <= v) and  (v <= e)
			my $case_expr_lst = dclone($info->{'CaseVals'});
			if (ref($case_expr_lst) ne 'ARRAY') {
				$case_expr_lst = [$case_expr_lst];
			}
			$info->{'Cond'}{'AST'} =  __replace_seq_by_ors($select_expr_ast,$case_expr_lst);
			$info->{'Cond'}{'Expr'}  = emit_expr_from_ast($info->{'Cond'}{'AST'});
			$info->{'CondVars'}{'Set'} = get_vars_from_expression($info->{'Cond'}{'AST'});
			$info->{'CondVars'}{'List'} = [sort keys %{$info->{'CondVars'}{'Set'}}];
			delete $info->{'CaseVals'};
		}
		elsif (exists $info->{'CaseDefault'}) {
			$info->{'Else'}=1;
			delete $info->{'CaseDefault'};
		}
		elsif (exists $info->{'EndSelect'} ) {
			$info->{'EndIf'} = 1;
			delete $info->{'EndSelect'};
			$info->{'End'} = 'if';
			$info->{'TrailingComment'} = ' ex-case';
			pop @{$pass_state->{'CaseStack'}};
		}

		return ([$annline],[$stref,$f,$pass_state]);
	};

	my $state = [$stref,$f,
	# pass state
	{
		'CaseStack'=>[],'CaseElseIf' =>0
	}
	];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_replace_case_by_if, $state,'pass_replace_case_by_if() ' . __LINE__  ) ;
	# my $Sf = $stref->{'Subroutines'}{$f};
	# $stref = emit_AnnLines($stref,$f,$Sf->{'RefactoredCode'});
	# die Dumper pp_annlines($Sf->{'RefactoredCode'}) if $f eq 'decodeTokenStr';
	return $stref;
} # END of replace_case_by_if

sub __replace_seq_by_ors { my ($x,$seq) = @_;
	#(AST,String,Error,HasFuncs)
	# carp 'CASEVAL:'. Dumper($x,$seq) ;
	if (scalar @{$seq} == 1) {
		 my ($item_ast,$r,$e,$f) = parse_expression_no_context($seq->[0]);
		#  carp 'CASEVAL:'. Dumper($item_ast,$r,$e,$f) ;
		 return [15, $x,$item_ast];
	} else {
		my @item_asts=();
		for my $item (@{$seq}) {
			if (ref($item) eq 'ARRAY') {
				push @item_asts, __replace_range_by_inequalities($x,@{$item});
			} else {
				my ($item_ast,$r,$e,$f) = parse_expression_no_context($item);
				push @item_asts, [15, $x,$item_ast];
			}
		}
		# croak Dumper @item_asts;
	# [or,[or,[or,$item_ast,$item_ast],$item_ast],$item_ast]]
		# croak emit_expr_from_ast( __build_or_seq_rec( @item_asts ) ) if @item_asts>2;
		return __build_or_seq_rec( @item_asts );
	}
} # END of __replace_range_by_inequalities

sub __build_or_seq_rec { my @item_asts = @_;
	if (scalar @item_asts == 1) {
		return $item_asts[0]}
	elsif (scalar @item_asts == 2) {
		return [23,@item_asts];
	} else {
		return [23,pop @item_asts,__build_or_seq_rec(@item_asts)];
	}
}

sub __replace_range_by_inequalities { my ($x,$lb,$ub) = @_;
#(AST,String,Error,HasFuncs)
	my ($lb_ast,$r1,$e1,$f1) = parse_expression_no_context($lb);
	my ($ub_ast,$r2,$e2,$f2) = parse_expression_no_context($ub);
	# croak Dumper emit_expr_from_ast([0, [22,[20,$x,$lb_ast],[19,$x,$ub_ast] ]]);
	return [0,[22,[20,$x,$lb_ast],[19,$x,$ub_ast] ]];
} # END of __replace_range_by_inequalities

1;
