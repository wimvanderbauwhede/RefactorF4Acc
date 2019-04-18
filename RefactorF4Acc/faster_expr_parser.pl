#!/usr/bin/env perl
use v5.28;
use Data::Dumper;
use RefactorF4Acc::Parser::Expressions qw( parse_expression_faster interpret emit_expr_from_ast 
_find_consts_in_ast
_find_vars_in_ast
);

$RefactorF4Acc::Parser::Expressions::defaultToArrays=1;

for my $str ('z(j+i,k*km)*p(i+1,j+jm)','i+1','v( i + 1 )','z','z(j,k)','j+k','i-im') {
    say "TEST: $str";
    (my $ast, my $rest, my $err) = parse_expression_faster($str);#*p(i+1,j+jm)');
    if ($err) {say 'ERROR' } else {
        #say "AST: ".Dumper($ast);
        say 'EMIT: '.emit_expr_from_ast($ast);

    }
}
#die;
for my $str ("5+42+ +6/42/44-45*7", '6*7', '44 - -2', '(1+2*3)+3+4/5','4+(22*(33*44+1)+77)/2') {
    say "\nTEST: $str";
    (my $ast, my $rest, my $err) = parse_expression_faster($str);
    if ($err) {say 'ERROR' } else {
        #say "AST: ".Dumper($ast);
        say 'EMIT: '.emit_expr_from_ast($ast);

    }
    #say Dumper($ast);
    say eval($str);
    say interpret($ast);
}


for my $str ('1 .and. .not. 0','1 <= 2', '(3.5 < 4) .or. (1 == 0.0)') {
    say "\nTEST: $str";
    (my $ast, my $rest, my $err) = parse_expression_faster($str);
    if ($err) {say 'ERROR' } else {
        #say "AST: ".Dumper($ast);
        say 'EMIT: '.emit_expr_from_ast($ast);

    }
    my $str2=$str;
    $str2=~s/\.([a-z]+)\./$1/g;
    $str2=~s/not/!/g;
    #say Dumper($ast);
    say eval($str2);
    say interpret($ast);
}


for my $str ('*8','RANK ( N, *8, *9 )','f(x)(y)', 'a**b**3', 'B .and. .not. A .or. C','.not.A .and. B','A(I,J,K)(M+N,1)', 'dimension(0:im,-1:jm)','a(1,1)', 'A(1,J,K)(M:N,1)', 'f(x+2,1)(v,12)','time',
    '((-beta-(beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
    '((-beta - (beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
    '-beta - beta','range(i,1,im,j,1,jm,k,1,km)',
    'print(__PH0__)','(((u(i,j,k),i=1,im),j=1,jm),k=1,km)',
    '( 3.14 , 2.7e-3)',
    '(/ 3.14 , 2.7e-3 /)',
    "[ 'A3.14' , 'B2.7e-3' ]",
    'u(i+1,j+jm)'
) {
    say "\nTEST: $str";
    (my $ast, my $rest, my $err) = parse_expression_faster($str);#*p(i+1,j+jm)');
    if ($err or $rest ne '') {say 'ERROR: <'.$rest.'>' } else {
        #say "AST: ".Dumper($ast);
        say 'EMIT: '.emit_expr_from_ast($ast);
    }
    my $consts = _find_consts_in_ast($ast,{});
    say Dumper($consts);
    my $vars = _find_vars_in_ast($ast,{});
    say Dumper($vars);
}


