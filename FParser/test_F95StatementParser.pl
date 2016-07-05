#!/usr/bin/perl
# NOTE: On Mavericks, it MUST be /usr/bin/perl, NOT the MacPorts Perl!
use warnings;
use strict;
use v5.16;
use Call::Haskell import => 'F95StatementParser( parseF95Statement,parseF95Decl )' , path => '.', packages => [], clean => 0, verbose => 0;
use Data::Dumper;

our %vars_in_expr=();


my $str= '"7188 if (b1 .and. .not. b2) call f(var , v(42,43)+3*w(2*i+j))"';
#my $str= '"call f(var , v(42,43)+3/w(2*i+j))"';
#my $context = "[\"v\",1]";
my $res =  parseF95Statement($str);#,$context);
#say Dumper($res);
my $nres= transform_ast($res);
say Dumper($nres);
say Dumper(%vars_in_expr);

my $decl_str='"integer,parameter :: v1 = 42*v2"';
my $decl = parseF95Decl($decl_str);
my $ndecl= transform_ast($decl);

say Dumper($ndecl);


sub transform_ast {
    (my $ast)=@_;
    if (ref($ast) eq 'ARRAY') {
        my $nast=[];
        for my $elt (@{$ast}) {
            if (ref($elt) eq 'HASH' and scalar keys %{$elt}==0) {
                next;
            }
            if (ref($elt) eq 'ARRAY' and scalar @{$elt}==0) {
                next;
            }
            if (ref($elt) eq 'HASH' and exists $elt->{ 'TypeName' } and $elt->{ 'TypeName' } eq 'Bare') {
                next;
            }

            if (ref($elt) eq 'HASH' and exists $elt->{ 'TypeName' } ) {
                if (exists $elt->{ 'TypeArgs' }) {
                    $elt = {  $elt->{ 'TypeName' } => $elt->{ 'TypeArgs' } }
                } else {                    
                    $elt = {$elt->{ 'TypeName' } => 1};
#                    say 'HERE:'.Dumper($elt);
                }
            }
                   
            my $nelt = transform_ast($elt);
            if (ref($nelt) eq 'HASH' and scalar keys %{$nelt}==0) {
                next;
            }
            if (ref($nelt) eq 'ARRAY' and scalar @{$nelt}==0) {
                next;
            }

            push @{$nast},$nelt
        }
        return $nast;
    } elsif (ref($ast) eq 'HASH') {
        my $nast={};
        for my $k (keys %{$ast}) {
            my $v = $ast->{$k};
            my $nv = transform_ast($v);
            if (ref($nv) eq 'HASH' and scalar keys %{$nv}==0) {
                next;
            }
            if ($k eq 'Var' and ref($nv) eq 'ARRAY') {
                $nv = $nv->[0][0];
                my $vn = $nv->[0]{'VarName'}[0];
                $vars_in_expr{$vn}=1;
            }
#            if (ref($nv) eq 'ARRAY' and scalar @{$nv}==0) {
#                next;
#            }
#            if (ref($nv) eq 'ARRAY' and scalar @{$nv}==0) {
#                next;
#            }

             $nast->{$k}=$nv;
        }
        return $nast;
    } else {
        return $ast;
    }
}
