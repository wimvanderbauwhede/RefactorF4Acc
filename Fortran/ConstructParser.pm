package Fortran::ConstructParser;
use warnings;
use strict;
use v5.10;
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

our $VERSION = '0.01';

use Parser::Combinators;
$Parser::Combinators::V=0;

use Data::Dumper;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

our $VV=0;

use Exporter 'import';

@Fortran::ConstructParser::EXPORT = qw(
		parse_Fortran_open_call
		parse_Fortran_do_construct
		parse_Fortran_if_construct
);

#parse_Fortran_IO_call( '  open(55,unit=44,file="filename")' );
#parse_Fortran_do_construct(' do i=1,im ');

sub parse_Fortran_open_call {
	(my $str) = @_;
    my $p =fortran_IO_call_parser();
	(my $st, my $rest, my $matches) =$p->($str);
    say 'REST:'. Dumper($rest)  if $VV;

	say 'MATCHES:'.Dumper($matches) if $VV;
	my $pt = getParseTree($matches);
	say 'PARSE TREE:'.Dumper($pt) if $VV;
    return $pt;
}

sub parse_Fortran_do_construct {
	(my $str) = @_;
    my $p =fortran_do_construct_parser();
	(my $st, my $rest, my $matches) =$p->($str);
    say 'REST:'. Dumper($rest)  if $VV;

	say 'MATCHES:'.Dumper($matches) if $VV;
	my $pt = getParseTree($matches);
	say 'PARSE TREE:'.Dumper($pt) if $VV;
    return $pt;
}

sub parse_Fortran_if_construct {
	(my $str) = @_;
    my $p =fortran_if_construct_parser();
	(my $st, my $rest, my $matches) =$p->($str);
    say 'REST:'. Dumper($rest)  if $VV;

	say 'MATCHES:'.Dumper($matches) if $VV;
	my $pt = getParseTree($matches);
	say 'PARSE TREE:'.Dumper($pt) if $VV;
    return $pt;
}

sub fortran_IO_call_parser {

sequence( 
[ 
	whiteSpace,
    symbol('open'),
    parens(
        sepByChar( ',',
                choice(
                sequence( [
                    symbol( 'unit'), &eqs,  choice({'UnitConst' => natural },{'UnitVar' => word}) 
                ] ),
                sequence( [
                    choice(
                        symbol( 'file'), symbol( 'name')
                    ), &eqs,
                    {'FileName' => 
                    choice(
                    sequence( [ {'ExprVar'=> word}, {'Expr' => &opaque_expr_parser } ] ),
                    	{'Var' => word }, # This will pass on vars but break on arrays
                        {'Star' => symbol('*') },
                        {'Expr' => regex('^[^\,]+') }
                    )
                    }
                ] ),
                sequence( [
                    symbol( 'access') ,&eqs, choice(
                            charExpr( 'append'), charExpr( 'sequential'), charExpr( 'direct')
                        )
                ] ),
                sequence( [
                    symbol( 'blank' ),&eqs ,choice(
                        charExpr( 'zero'), charExpr( 'null')
                    )
                ] ),
                sequence( [                
                    symbol( 'err' ),&eqs, {'Err' => natural}
                ] ),
                sequence( [
                    symbol( 'form' ),&eqs, choice(
                        charExpr( 'unformatted'), charExpr( 'formatted'), charExpr( 'print')
                    )
                ] ),
                sequence( [
                    symbol( 'iostat' ),&eqs, {'IOStat' => word }
                ] ),
                sequence( [
                    choice(
                        symbol( 'recl'), symbol( 'recordsize')
                    ) ,&eqs,  {Recl => regex('[\w\d\-\*\+]+') } #natural,word
                ] ),
                sequence( [
                    choice(
                        symbol( 'status'), symbol( 'type')
                    ),&eqs, 
                    choice(
                        charExpr( 'old'), charExpr( 'new'), charExpr( 'unknown'), charExpr( 'scratch')
                    )
                ] ),
                sequence( [
                    symbol( 'fileopt')  ,&eqs, choice(
                        charExpr( 'nopad'),sequence( [ symbol( 'buffer'),&eqs,natural ] ),charExpr( 'eof')
                    )
                ] ),
                symbol( 'readonly'),
                sequence( [
                    symbol( 'action' ),&eqs, choice(
                        charExpr( 'readwrite'), charExpr( 'read'), charExpr( 'write')
                    )
                ] ),
                sequence( [
                            word ,&eqs, {'AttrVal' => choice(
                        &string, word
                    ) }
                ] ) ,
				{ 'UnitConst' => natural},
                {'UnitVar' => word},                
            )
        )
    )
] );

}

# Match anything but if the open and close parens are not paired, check for closing paren and remove if there is one. 
sub opaque_expr_parser {
	    sub {	(my $str)= @_;
        my $p =  regex('^[^\,]+'); 			 			
 		(my $status, my $str2, my $matches) = $p->($str);
        if ($status) {
        	 my $open_paren_counter = () = $matches=~/(\()/g;
        	 my $close_paren_counter = () = $matches=~/(\))/g;
        	 if  ( $close_paren_counter > $open_paren_counter ) { # parens not matched 
        	if ($matches=~/\)$/) {
        		$matches=~s/\)$//;
        		$str2.=')';
        	}
        	 }
            return ($status, $str2, $matches);
        } 
        return (0, $str, []);
    };	
}

sub eqs {
    symbol('=');
}
# The Fortran spec calls them character expressions
sub charExpr { (my $str)=@_;
    regex('[\'\"]'.$str.'[\'\"]');
}

# A single- or double-quoted string
sub string { (my $str)=@_;
    regex('[\'\"][^\"\']*[\'\"]');
}

sub fortran_do_construct_parser {
	sequence( [
	maybe(sequence([{ConstructName => word},semi])), 
	 symbol( 'do'),
	 {Index => word},
	 &eqs,
	  {Init => &var_or_num},
	  comma, 
	  {Limit => &var_or_num}, 
	  maybe( sequence( [ comma,{ Step => &var_or_num } ] ))
	  ]);
}

sub var_or_num {
	choice(natural,word);
}


#[construct-name :] IF (logical-expression1) THEN
#statement-block1
#[ELSE IF (logical-expression2) THEN [construct-name]
#statement-block2 ] ...
#[ELSE [construct-name]
#statement-block3]
#END IF [construct-name]
sub fortran_if_construct_parser {
	sequence( [
	maybe(choice(symbol('else'),sequence([{ConstructName => word},semi]))), 
	 symbol( 'if'),
	 parens(
	 {LogicalExpression => &logical_expression}
	 ),
	 symbol( 'then'),
	  maybe( {ConstructName => word} )
	  ]);
}

sub comb_logical_expression {
	sequence(
		[
			choice(parens(&logical_expression),&logical_expression),
			choice(
			symbol('.eqv.'),
			symbol('.neqv.'),
			symbol('.and.'),
			symbol('.or.'),
			symbol('.xor.'),
			),
			choice(parens(&logical_expression),&logical_expression)
		]
	
	);
}
sub logical_expression {
	sequence(
		[
			maybe(symbol('.not.')),
			&var_or_num,
			choice(
				symbol('.eq.'),
				symbol('.ne.'),
				symbol('.lt.'),
				symbol('.le.'),
				symbol('.gt.'),
				symbol('.ge.'),
				symbol('=='),
				symbol('/='),
				symbol('<'),
				symbol('<='),
				symbol('>'),
				symbol('>='),			
			), 
			maybe(symbol('.not.')),
			&var_or_num
		]
	);
}

1;



