package F95VarDeclParser;
use warnings;
use strict;
use 5.016;
our $VERSION = '0.01';

use Parser::Combinators;
$Parser::Combinators::V=0;

use Data::Dumper;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

our $VV=0;
use Exporter 'import';

@F95VarDeclParser::EXPORT    = qw(
		parse_F95_var_decl
);


sub parse_F95_var_decl {
	(my $str) = @_;

	print $str,"\n" if $VV;
	my $p =f95_var_decl_parser();
	(my $st, my $rest, my $matches) =$p->($str);
    print 'REST:'. Dumper($rest),"\n"  if $VV;

	print 'MATCHES:'.Dumper($matches),"\n"  if $VV;
#    die unless @{$matches};
	my $pt = getParseTree($matches);
	print 'PARSE TREE:'.Dumper($pt),"\n" if $VV;
	
	my $typetup = $pt->{TypeTup};
	if (ref($typetup) eq 'ARRAY') {
		$pt->{TypeTup} = { each %{$typetup->[0]}, Kind => 4};
	} elsif (exists $pt->{TypeTup}{Kind}) {
		$pt->{TypeTup}{Kind}*=1;
	}
#	print Dumper($pt);
    if ((exists $pt->{Attributes}) && (ref($pt->{Attributes}) eq 'HASH')) {
        if ( exists $pt->{Attributes}{Dim}) {
	       my $dim = $pt->{Attributes}{Dim};    
	       if (ref($dim) ne 'ARRAY') {
		      $pt->{Attributes}{Dim} = [$dim];
            }
        } else {
        	$pt->{Attributes}{Dim} = [0];
        }
    }

	my $varlist = $pt->{Vars} ;
	if (ref($varlist) ne 'ARRAY') {
		$pt->{Vars} = [$varlist];
	}
    my $parlist = $pt->{Pars}->[0]; #HACK
    my $lhs =$parlist->[0]->{Lhs};
    my $rhs =$parlist->[1]->{Rhs};
     	$pt->{Pars} = {Var => $lhs, Val => $rhs};
#	if (ref($parlist) ne 'ARRAY') {    
#		$pt->{Pars} = [$parlist];
#	}
	if (not exists $pt->{AccPragma}) {
		$pt->{AccPragma} = {AccKeyword => 'ArgMode', AccVal => 'ReadWrite'}
	}
    print Dumper($pt),"\n" if $VV;

	return $pt;
}

sub f95_var_decl_parser {
    sequence [
    	whiteSpace,
        {TypeTup => &type_parser},
        maybe(
        sequence [
        comma,
        {Attributes => sepBy(',',&attribute_parser)}
        ]
        ),
    	&varlist_parser,
		maybe( &openacc_pragma_parser) 
	] 
};


sub f95_var_decl_parser_ORIG {
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
    	&varlist_parser,
		maybe( &openacc_pragma_parser) 
	] 
};

# where
sub attribute_parser {     
    choice(&dim_parser, &intent_parser, &parameter_parser, &allocatable_parser)
}

sub type_parser {	
		sequence [
        {Type =>	word},
        maybe parens choice(
                {Kind => natural},
						sequence [
							choice( symbol('kind'), symbol('len') ),
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

sub parameter_parser {
    symbol('parameter')
}

sub allocatable_parser {
    {Allocatable => symbol('allocatable')}
}

sub varlist_parser {
	sequence [	
	symbol('::'),	
	choice({Pars => try(sepBy(',',&param_assignment)) },{Vars => sepBy(',',word) })
	]
}

sub param_assignment {
    sequence [
        {Lhs => word},
        symbol('='),
        {Rhs => regex('[\.\d]+')} #FIXME very weak !
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
