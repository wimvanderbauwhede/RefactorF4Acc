#!/usr/bin/env perl
use warnings;
use strict; 
use v5.16;
use RefactorF4Acc::Parser::Expressions qw(parse_expression emit_expression get_vars_from_expression get_args_vars_from_expression get_args_vars_from_subcall );
use Data::Dumper;

my $f='main';

my $stref={'Subroutines'=> {$f => {'CalledSubs' => {'bb'=>1,'f'=>1} }}};
my $info={'SubroutineCall'=>{}};
#my $expr_str="f(a,12.3,b(2,c*2.3e-4+v),p(im+1,k,j))";
#my $expr_str="zbm(i+25,j+25),zba(i+25,j+25),b";
#my $expr_str=" do(do(do(real(a1(i,j,k)),range(i,1,im)),range(j,1,jm)),range(k,1,km)), do(do(do(real(a2(i,j,k)),range(i,1,im)),range(j,1,jm)),range(k,1,km)), do(do(do(real(a3(i,j,k)),range(i,1,im)),range(j,1,jm)),range(k,1,km))";
#my $expr_str="covx1(i,n)=(cov7(i,j,k)+cov7(i+1,j,k))/2.";
#my $expr_str="time=(cov7(i,j,k)+cov7(i+1,j,k))/2.";
my $expr_str="interpol_all(itime,fghold,xts(i,j+1),yts*zt,cov7(i,j,k)+cov7(i+1,j,k),(x+y)/2.,3.45,fghold)";

#($stref, $info) = parse_expression($expr_str,$info, $stref, $f);
#say Dumper($info);
#my $emit_expr_str=emit_expression($info->{'ExpressionAST'});
#say $expr_str;
#say $emit_expr_str;
#my $vars= get_vars_from_expression($info->{'ExpressionAST'},{});
#say Dumper($vars);
#my $args= get_rhs_vars_from_expression($info->{'ExpressionAST'});

#    (my $lhs,my $rhs ) = split( /\s*=\s*/, $expr_str );
	my $ast = parse_expression($expr_str,$info, $stref, $f);
#    say 'AST:'.Dumper($ast);
    
    (my $args,my $vars)= get_args_vars_from_subcall($ast) ;
#	(my $args,my $vars)= @{ get_args_vars_from_expression($ast) };

say 'Args:'.Dumper($args->{'List'});
say 'Vars:'.Dumper($vars);


#	my $rhs_ast = parse_expression($rhs,$info, $stref, $f);
#    say 'RHS:'.Dumper($rhs_ast);
#    
#	(my $rhs_args,my $rhs_vars)= @{ get_args_vars_from_expression($rhs_ast) };
#
#    say 'RHS Args:'.Dumper($rhs_args);
#say 'RHS Vars:'.Dumper($rhs_vars);


