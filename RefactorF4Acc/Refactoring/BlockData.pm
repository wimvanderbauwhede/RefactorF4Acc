package RefactorF4Acc::Refactoring::BlockData;
use v5.10;
use RefactorF4Acc::Config;
#use RefactorF4Acc::Utils;
#use RefactorF4Acc::Refactoring::Helpers qw( get_f95_var_decl stateful_pass_inplace stateless_pass_inplace );
#
#   (c) 2010-2019 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  add_BLOCK_DATA_call_after_last_VarDecl
);


# This adds a call without arguments, the arguments are in COMMON blocks and will be refactored later
# TODO: this should work with 'SpecificationStatement'

sub add_BLOCK_DATA_call_after_last_VarDecl {
	( my $f, my $stref ) = @_;

	if (scalar keys %{ $stref->{'BlockData'} } > 0) {
		say "** analyse_all() => add_BLOCK_DATA_call_after_last_VarDecl()" if $V;
		my $Sf = $stref->{'Subroutines'}{$f};
		my $annlines=$Sf->{'AnnLines'};

		my $in_decls=0;
		my $decl=0;
		my $found_hook=0;
		my $new_annlines=[];
		for my $annline (@{$annlines}) {
			(my $line, my $info)=@{$annline};

			if (exists $info->{'Comments'} or exists $info->{'Blank'}) {
				push @{$new_annlines}, $annline;
				next;
			}

			if (
			(exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'} and $info->{'Signature'}{'Program'} == 1) or
			exists $info->{'Include'} or
			exists $info->{'VarDecl'} or
			exists $info->{'Common'} or
			exists $info->{'Dimension'} or
			exists $info->{'External'} or
			exists $info->{'Equivalence'} or
			exists $info->{'ImplicitNone'} or
			exists $info->{'Save'}
			# I guess there might be others ...
			) {
				$decl=1;
			} else {
				$decl=0;
			}
			if ($decl and $in_decls==0) {
				$in_decls=1;
			}
			if ($in_decls and not $decl and $found_hook==0) {
				$found_hook=1;
				# So here we should put in the additional calls to BLOCK DATA
				for my $block_data (keys %{ $stref->{'BlockData'} } ) {
					my $call_block_data_line = "        call $block_data"; #croak $line;
					push @{$new_annlines}, [
					$call_block_data_line,
					{
						'SubroutineCall'=> {
							'Name' => $block_data,
							'Args' => {'List'=>[],'Set'=>{} },
							'ExpressionAST' => $NEW_PARSER? [] : [
								1,$block_data
							],
						},
						'ExprVars' => {
							'List' => [],
							'Set' => {}
						},
						'NonSpecificationStatement' =>1,
						'LineID' => ++$annlines->[-1][1]{'LineID'}
					}
					];
					unshift @{$stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'}}, $block_data;
					$stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$block_data}=[1,1];
				}
			}
			push @{$new_annlines}, $annline;
		}
		$stref->{'Subroutines'}{$f}{'AnnLines'}=$new_annlines;
	}
	return $stref;
} # END of add_BLOCK_DATA_call_after_last_VarDecl

1;
