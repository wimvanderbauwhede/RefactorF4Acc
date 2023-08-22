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


sub replace_case_by_if { my ( $stref, $f, $annlines ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	$Sf->{'RefactoredCode'}=$annlines;

	my $pass_replace_case_by_if= sub {
		(my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};

		return (XXX,$state);
	};

# XXX TODO state
	my $statement_function_annlines = [['! Moved statement functions',{'Comments' => 1}]];
 	($stref,$statement_function_annlines) = stateful_pass_inplace($stref,$f,$pass_replace_case_by_if, $statement_function_annlines,'pass_replace_case_by_if §' . __LINE__  ) ;

# XXX TODO

} # END of replace_case_by_if


1;
