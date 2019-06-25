#!/usr/bin/env perl
use v5.28;
use Data::Dumper;
use RefactorF4Acc::Config;
use RefactorF4Acc::Parser::Expressions qw( parse_expression);

$RefactorF4Acc::Parser::Expressions::defaultToArrays=1;
for (1..1000) {
for my $str (
    'z(j+i,k*km)*p(i+1,j+jm)',
    'i+1',
    'v( i + 1 )',
    'z',
    'z(j,k)',
    'j+k',
    'i-im',        
        "5+42+ +6/42/44-45*7", 
        '6*7', 
        '44 - -2', 
        '(1+2*3)+3+4/5',
        '4+(22*(33*44+1)+77)/2',
      '1 .and. .not. 0','1 <= 2', 
      '(3.5 < 4) .or. (1 == 0.0)',
    '8',
    'RANK ( N, *8, *9 )',
    'f(x)(y)', 
    'a**b**3', 
    'B .and. .not. A .or. C',
    '.not.A .and. B',
    'A(I,J,K)(M+N,1)', 
    'dimension(0:im,-1:jm)',
    'a(1,1)', 
    'A(1,J,K)(M:N,1)', 
    'f(x+2,1)(v,12)',
    'time',
    '((-beta-(beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
    '((-beta - (beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
    '(dx1(i+1)*w(i,j,k-1)+dx1(i)*w(i+1,j,k-1))/(dx1(i)+dx1(i+1))',
    '(diu2(i-1,j,k)+diu2(i-1,j+1,k) +diu2(i  ,j,k)+diu2(i  ,j+1,k) ) *.25',
    '5.*((z2(k)+0.5*dzn(k))/600.)**0.2',
    '(dzn(k+1)*((dx1(i+1)*sm(i,j,k)+dx1(i)*sm(i+1,j,k)) /(dx1(i)+dx1(i+1))) +dzn(k)*((dx1(i+1)*sm(i,j,k+1)+dx1(i)*sm(i+1,j,k+1)) /(dx1(i)+dx1(i+1)))) /(dzn(k)+dzn(k+1))',
    'amax1(AAA,u(im,j,k))',
    '-beta - beta',
    'range(i,1,im,j,1,jm,k,1,km)',
    'print(__PH0__)',
    '(u(i,j,k),i1,im)',
    '( 3.14 , 2.7e-3)',
    '( 3.14 , 2.7e-3 )',
    'u(i+1,j+jm)',
    '(a,b)',
    'WRITE()',
    'p(i-1,j+jm,0)',
    'lhs_var',
    "READ( 3, 5E1)",
    'READ( 1, 2, ERR8, END9, IOSTAT,N ) ',
    'READ( 1, 2, ERR8, END9, IOSTAT,N ) ',
    'READ( FMT, A, V)',
    'READ(A, V)',
    'time'
) {
			my $ast = parse_expression($str,{},{},'main');

}
}
