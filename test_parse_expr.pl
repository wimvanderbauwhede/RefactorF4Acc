#!/usr/bin/env perl
use warnings;
use strict; 
use v5.16;
use RefactorF4Acc::Parser::Expressions qw(parse_expression emit_expression get_vars_from_expression);
use Data::Dumper;

my $f='main';

my $stref={'Subroutines'=> {$f => {'CalledSubs' => {'bb'=>1,'f'=>1} }}};
my $info={'SubroutineCall'=>{}};
my $expr_str="f(a,12.3,b(2,c*2.3e-4+v),p(im+1,k,j))";
($stref, $info) = parse_expression($expr_str,$info, $stref, $f);
#say Dumper($info);
my $emit_expr_str=emit_expression($info->{'ExpressionAST'});
say $expr_str;
say $emit_expr_str;
my $vars= get_vars_from_expression($info->{'ExpressionAST'},{});
say Dumper($vars);

