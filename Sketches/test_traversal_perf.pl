#!/usr/bin/env perl
use v5.28;
use Data::Dumper;
use RefactorF4Acc::Config;
use RefactorF4Acc::Parser::Expressions qw( parse_expression_faster interpret emit_expr_from_ast 
_find_consts_in_ast
_find_vars_in_ast
_find_args_in_ast
_traverse_ast_with_action
@sigils
);
$RefactorF4Acc::Parser::Expressions::defaultToArrays=1;
for (1..1000) {
for my $str (
    'z(j+i,k*km)*p(i+1,j+jm)','i+1','v( i + 1 )','z','z(j,k)','j+k','i-im',        
        "5+42+ +6/42/44-45*7", '6*7', '44 - -2', '(1+2*3)+3+4/5','4+(22*(33*44+1)+77)/2',
      '1 .and. .not. 0','1 <= 2', '(3.5 < 4) .or. (1 == 0.0)',
    '*8','RANK ( N, *8, *9 )','f(x)(y)', 'a**b**3', 'B .and. .not. A .or. C','.not.A .and. B','A(I,J,K)(M+N,1)', 'dimension(0:im,-1:jm)','a(1,1)', 'A(1,J,K)(M:N,1)', 'f(x+2,1)(v,12)','time',
    '((-beta-(beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
    '((-beta - (beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
    '-beta - beta','range(i,1,im,j,1,jm,k,1,km)',
    'print(__PH0__)','(((u(i,j,k),i=1,im),j=1,jm),k=1,km)',
    '( 3.14 , 2.7e-3)',
    '(/ 3.14 , 2.7e-3 /)',
    "[ 'A3.14' , 'B2.7e-3' ]",
    'u(i+1,j+jm)',
    'a,b',
    'WRITE(*,*)',
    '*, I, J, ( VECTOR(I), I = 1, 5 )',
    'p(i-1,j+jm,0)',
    'lhs_var',
    "READ( 3, '(5F4.1)')",
    'READ( 1, 2, ERR=8, END=9, IOSTAT=N ) X',
    'READ( 1, 2, ERR=8, END=9, IOSTAT=N ) X, Y',
    'READ FMT, A, V',
    'READ *, A, V',
    'READ *, AV',
    'READ( *, * )',
    'READ( *, FMT )',
    'READ( *)',
    'time'
) {
			(my $ast, my $rest, my $err) = parse_expression_faster($str);#*p(i+1,j+jm)');# 1.15s
            #my $vars = _find_vars_in_ast($ast,{}); 1.6s
            #                        ($ast, my $acc) = _traverse_ast_with_action($ast,{}, \&collect_vars ); # 2.1 s
            #say 'VARS';
            #say Dumper($vars);
            #say 'ACC';
            #say Dumper($acc);

}

}
sub collect_vars { (my $ast, my $acc) = @_;
    if (($ast->[0] &0xFF)==2) {
        my $mvar = $ast->[1]; 
                if (not exists $Config{'Macros'}{uc($mvar)} ) {
                    $acc->{$mvar}={'Type'=>'Scalar'} ;
                }      }
    elsif (($ast->[0] &0xFF)>28) {
    # constants
    my $mvar = $ast->[1]; 
    $acc->{$mvar}={'Type'=>$sigils[ ($ast->[0] & 0xFF) ]} ;    }
    elsif (($ast->[0] &0xFF)==10) {
        #say '@'.$ast->[1];
                my $mvar = $ast->[1];
                $acc->{$mvar}={'Type'=>'Array'};
                # Handle IndexVars
                my $index_vars={};
                $index_vars =  _traverse_ast_with_action($ast->[2],$index_vars,\&collect_vars);

                    for my $idx_var (keys %{ $index_vars }) {
                        if ($index_vars->{$idx_var}{'Type'} eq 'Array') {
                            delete $index_vars->{$idx_var};
                        }
                    }                   
                    $acc->{$mvar}{'IndexVars'} = $index_vars;
    } 
    #else {
    #say $sigils[$ast->[0]];
    #}
    return $acc;
}
