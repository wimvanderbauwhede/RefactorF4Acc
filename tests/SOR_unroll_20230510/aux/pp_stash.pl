#!/usr/bin/env perl
use v5.22;
use warnings;
use strict;
use Data::Dumper;
use Cwd;
my $wd=cwd();

if (!@ARGV) {
    die "$0 path-to-stash-file (probably ../src/stash.pl)\n";
}

my $VV=1;


pp_stash($ARGV[0]);

sub pp_stash { (my $stash_src)=@_;


    if (not -e $stash_src) {
        die "Could not fine $stash_src\n";    
    }

    my $stash_ref = do( $stash_src );

    for my $src (sort keys %{$stash_ref}) {
        say '! '.('=' x 80);
        say "! $src";
        for my $tag (sort keys %{  $stash_ref->{$src} }) {           
        say '! '.('-' x 80);
            say "! $tag";
            for my $stashed_line (@{  $stash_ref->{$src}{$tag} }) {
                say $stashed_line;
            }
        say '! '.('-' x 80);
            say "";
        }
        say '! '.('=' x 80);
    }
}


#map {say $_ } @{  $ref->{'main.f95'}{7188} };


