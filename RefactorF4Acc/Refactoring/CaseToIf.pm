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
use RefactorF4Acc::Refactoring::Helpers qw(
	stateful_pass_inplace
	splice_additional_lines_cond_inplace
	);

use vars qw( $VERSION );
$VERSION = "2.1.1";

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
#@ Case, CaseVals => [...,[...,...],...]
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
	my $Sf = $stref->{'Subroutines'}{$f};
	$Sf->{'RefactoredCode'}=$annlines;

	my $pass_replace_case_by_if= sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		say "LINE:<$line>";
		my $c_line=$line;
		(my $stref, my $f, my $pass_state)=@{$state};
        my $id = $info->{'LineId'};
		my $skip=0;
		if (exists $info->{'CaseVar'}) {
			push @{$pass_state->{'CaseStack'}}, $info->{'CaseVar'}; skip=1;
		}
		elsif (exists $info->{'Case'}) {
			if ($pass_state->{'CaseElseIf'} == 0) {$pass_state->{'CaseElseIf'}=0}
			if ($pass_state->{'CaseElseIf'}) {
				$info->{'ElseIf'} = 1;
			} else {
				$info->{'If'} = 1;
			}
			delete $info->{'Case'};
			# The comma-separated expressions:
			# Turn into ( $expr == $v )
			joined with ' or '
			# The nested pairs are b,e => (b <= v) and  (v <= e)
		}
		elsif (exists $info->{'CaseDefault'}) {
			$info->{'Else'}=1;
			delete $info->{'CaseDefault'};
		}
		elsif (exists $info->{'EndSelect'} ) {
			$info->{'EndIf'} = 1;
			delete $info->{'EndSelect'};
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
	return $stref;
} # END of replace_case_by_if


1;
