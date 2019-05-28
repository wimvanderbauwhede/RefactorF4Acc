#!/usr/bin/env perl
use v5.20;
use strict;
use warnings;

use Data::Dumper;
my $commonsInIncludes = 0;
my $commonVarMismatch = 1;
my $stref = {};
my $f='test';

$stref->{'Subroutines'}{$f}{'CommonBlocks'} = {};

if (not $commonsInIncludes) {
    if ($commonVarMismatch) {
        _match_up_common_vars($stref,$f);
    }
}


for my $common_decl_str_ ('common v1,v2, /BLK1/ v7// v3, v4, / BLK2 / v5,v6', 'common w1,w2',
    'common / blk3/ u,uu(9)//z(3)'
) {

$stref = _collect_common_vars_per_block($stref, $f, $common_decl_str_);    

}

     say "\nCOMMON BLOCKS:\n";
    say Dumper($stref->{'Subroutines'}{$f}{'CommonBlocks'});

# Now we can create the pairs with dimensions in Analysis


sub _match_up_common_vars { my ($stref,$f) = @_;

   return $stref;
}

# This is for Parser, so the result should a list of var names
#
sub _collect_common_vars_per_block { my ($stref, $f, $common_decl_str_) = @_;
    my %common_blocks = %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} };
    my $common_decl_str = $common_decl_str_;
    $common_decl_str=~s/common\s*//;
    if ($common_decl_str!~/^\//) {
        $common_decl_str='BLANK/'.$common_decl_str;
    } else {
        $common_decl_str=~s/^\/\s*//;
    }
    my  @common_chunks = split(/\s*\/\s*/,$common_decl_str);

    while (@common_chunks) {

        my $common_block_name = shift @common_chunks;
        if ( $common_block_name eq '' or $common_block_name=~/^\s+$/) {  $common_block_name = 'BLANK';}

        if (not exists $common_blocks{$common_block_name}) {
            $common_blocks{$common_block_name}=[];
        }
        my $common_vars_str = shift @common_chunks;

        $common_vars_str=~s/,\s*$//;
        my @common_vars_strs = split(/\s*,\s*/,$common_vars_str);
        my @common_vars =  map { s/\(.+$// ;$_} @common_vars_strs ;
                        $common_blocks{$common_block_name} =[ @{$common_blocks{$common_block_name}} ,@common_vars ];
    }
    $stref->{'Subroutines'}{$f}{'CommonBlocks'}={  %common_blocks };
    return $stref;
}



