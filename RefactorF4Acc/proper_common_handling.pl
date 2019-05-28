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

#my %common_blocks=();


for my $common_decl_str_ ('common v1,v2, /BLK1/ v7// v3, v4, / BLK2 / v5,v6', 'common w1,w2',
    'common / blk3/ u,uu(9)//z(3)'
) {

$stref = _collect_common_vars_per_block($stref, $f, $common_decl_str_);    

}
# This is done after all COMMON blocks have been parsed, so say for simplicity at the end of parsing of a code unit, or alternatively when the first non-decl statement is encountered.
#
$stref = _create_common_block_var_sequences($stref, $f);
# Now we can parse all common var decl strings
# And we can also get the dimensions 
# I think I will keep the old code to handle the declarations




sub _match_up_common_vars { my ($stref,$f) = @_;

   return $stref;
}


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

    #say Dumper(@common_chunks);
    while (@common_chunks) {
        my $common_block_name = shift @common_chunks;
        my $common_vars_str = shift @common_chunks;
        $common_vars_str=~s/,\s*$//;
        if ( $common_block_name=~/^\s*$/) {  $common_block_name = 'BLANK';}
        push @{$common_blocks{$common_block_name}} ,$common_vars_str;
    }

    $stref->{'Subroutines'}{$f}{'CommonBlocks'}={  %common_blocks };
    return $stref;
}


sub _create_common_block_var_sequences { my ($stref, $f, $common_decl_str_) = @_;
    my %common_blocks = %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} };
    for my $common_block_name (keys %common_blocks) {
        $common_blocks{$common_block_name}=[split(/\s*,\s*/,join(',',@{$common_blocks{$common_block_name}}))];
    }
    # Now parse them and create the pairs with the dimensions

    say Dumper(%common_blocks);

    $stref->{'Subroutines'}{$f}{'CommonBlocks'}={  %common_blocks };
    return $stref;
}

