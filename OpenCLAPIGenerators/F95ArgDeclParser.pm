package F95ArgDeclParser;
use warnings;
use strict;
use 5.008_005;
our $VERSION = '0.01';

use Parser::Combinators;
$Parser::Combinators::V=0;

use Data::Dumper;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

our $VV=0;
use Exporter 'import';

@F95ArgDeclParser::EXPORT    = qw(
		parse_F95_arg_decl
);


sub parse_F95_arg_decl {
	(my $str) = @_;

	print $str,"\n" if $VV;
	my $p =f95_arg_decl_parser();
	(my $st, my $rest, my $matches) =$p->($str);
	print Dumper($matches),"\n"  if $VV;
#    die unless @{$matches};
	my $pt = getParseTree($matches);
	print Dumper($pt),"\n" if $VV;
	my $typetup = $pt->{TypeTup};
	if (ref($typetup) eq 'ARRAY') {
		$pt->{TypeTup} = { each %{$typetup->[0]}, Kind => 4};
	} elsif (exists $pt->{TypeTup}{Kind}) {
		$pt->{TypeTup}{Kind}*=1;
	}
    if (exists $pt->{Dim}) {
	my $dim = $pt->{Dim};    
	if (ref($dim) ne 'ARRAY') {
		$pt->{Dim} = [$dim];
    }
    } else {
        	$pt->{Dim} = [0];
    }

	my $arglist = $pt->{Args} ;
	if (ref($arglist) ne 'ARRAY') {
		$pt->{Args} = [$arglist];
	}
	if (not exists $pt->{AccPragma}) {
		$pt->{AccPragma} = {AccKeyword => 'ArgMode', AccVal => 'ReadWrite'}
	}
    print Dumper($pt),"\n" if $VV;

	return $pt;
}

sub f95_arg_decl_parser {
    sequence [
    	whiteSpace,
        {TypeTup => &type_parser},
	    maybe(
		    sequence [
			    comma,
                &dim_parser
	    	], 
    	),
	    maybe(
    		sequence [
	    		comma,
		    	&intent_parser
    		], 
	    ),
    	&arglist_parser,
		maybe( &openacc_pragma_parser) 
	] 
};

# where

sub type_parser {	
		sequence [
        {Type =>	word},
        maybe parens choice(
                {Kind => natural},
						sequence [
							symbol('kind'),
							symbol('='),
                            {Kind => natural}
						] 
					)        
		] 
}

sub dim_parser {
		sequence [
			symbol('dimension'),
        {Dim => parens sepBy(',', regex('[^,\)]+')) },
        maybe( char(')'))
		] 
}

sub intent_parser {
	 sequence [
        symbol('intent'),
     {Intent => parens word}
		] 
}

sub arglist_parser {
	sequence [
		symbol('::'),
	{Args => sepBy(',',word) }
	]
}

sub openacc_pragma_parser { sequence [
        char('!'),
        whiteSpace,
        choice( symbol('$ACC'), symbol('$acc')),
		{AccPragma => sequence [
		{AccKeyWord => word},
		{AccVal => word}
		] }
        ]
}

1;
