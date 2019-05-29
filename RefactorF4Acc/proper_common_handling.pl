#!/usr/bin/env perl
use v5.10;
use strict;
use warnings;

use Data::Dumper;

use RefactorF4Acc::Analysis::CommonBlocks qw(
	collect_common_vars_per_block
	identify_common_var_mismatch
);

my $stref = {};
my $f='test';

$stref->{'Subroutines'}{$f}{'CommonBlocks'} = {};

#if ( $stref->{'Subroutines'}{$f}{'HasLocalCommons'}) {
#    if ($stref->{'Subroutines'}{$f}{'CommonVarMismatch'}) {
#        _match_up_common_vars($stref,$f);
#    }
#}


for my $common_decl_str_ ('common v1,v2, /BLK1/ v7// v3, v4, / BLK2 / v5,v6', 'common w1,w2',
    'common / blk3/ u,uu(9)//z(3)'
) {

$stref = collect_common_vars_per_block($stref, $f, $common_decl_str_);    

}

     say "\nCOMMON BLOCKS:\n";
    say Dumper($stref->{'Subroutines'}{$f}{'CommonBlocks'});

# Now we can create the pairs with dimensions in Analysis

