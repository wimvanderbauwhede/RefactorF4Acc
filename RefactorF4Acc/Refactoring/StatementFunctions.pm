package RefactorF4Acc::Refactoring::StatementFunctions;
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
  move_StatementFunctions_after_SpecificationStatements
);


sub move_StatementFunctions_after_SpecificationStatements { my ( $stref, $f, $annlines ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	$Sf->{'RefactoredCode'}=$annlines;
# first cut out the StatementFunction lines
	my $pass_cut_out_StatementFunction_lines= sub {
		(my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		#  say "LINE:$line ".Dumper(sort keys %{$info});
		my $new_annlines = [$annline];
		if (exists $info->{'StatementFunction'}) {	
			
					$new_annlines =[ 
					["! Removed statement function ".$info->{'StatementFunction'},{'Comments' => 1}],					
					]; 
					push @{$state},$annline;
		}		
		
		return ($new_annlines,$state);
	};
	
	my $statement_function_annlines = [['! Moved statement functions',{'Comments' => 1}]];
 	($stref,$statement_function_annlines) = stateful_pass_inplace($stref,$f,$pass_cut_out_StatementFunction_lines, $statement_function_annlines,'_cut_out_StatementFunctions §' . __LINE__  ) ;	
	#  carp Dumper(pp_annlines($statement_function_annlines));
	 if (scalar @{ $statement_function_annlines } > 1) {
	my $merged_annlines = splice_additional_lines_cond_inplace(
		$stref, $f,
		sub {
			( my $annline ) = @_;
			(my $line,my $info)=@{$annline};
			return (
				exists $info->{'HasVars'}
			or exists $info->{'Control'}			
			or exists $info->{'EndControl'}
			) ? 1 : 0;
		},
		[],
		$statement_function_annlines,
		1, # insert before
		0, # skip insertion condition line
		1 # do this only once
	);
	# croak Dumper(pp_annlines($merged_annlines));
	return $merged_annlines;
	 } else {
	return $Sf->{'RefactoredCode'};
	 }
	
} # END of move_StatementFunctions_after_SpecificationStatements


1;
