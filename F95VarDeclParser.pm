package F95VarDeclParser;
use warnings;
use strict;
use 5.016;
our $VERSION = '0.01';

use Parser::Combinators;
$Parser::Combinators::V=0;

use Carp;
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
    print "\n" if $VV;
    print 'REST:'. "\n".Dumper($rest),"\n"  if $VV;

	print 'MATCHES:'.Dumper($matches),"\n"  if $VV;
#    die unless @{$matches};
#carp Dumper($matches);
	my $pt = getParseTree($matches);
	print 'PARSE TREE:'.Dumper($pt),"\n" if $VV;
	
	my $typetup = $pt->{TypeTup};
#	carp "TYPE TUPLE:".Dumper( $typetup );
	if (exists $typetup->{'Type'}{'Opt'}) {
		$typetup->{'Type'}= $typetup->{'Type'}{'Main'}. ' ' . $typetup->{'Type'}{'Opt'};
	} else {
		$typetup->{'Type'}= $typetup->{'Type'}{'Main'};
	}
	if (ref($typetup) eq 'ARRAY') {
		
		$pt->{TypeTup} = { each %{$typetup->[0]}, Kind => 4};
	} elsif (exists $pt->{TypeTup}{Kind}) {
		
		$pt->{TypeTup}{Kind}*=1 unless $pt->{TypeTup}{Kind} eq '*';
	}
#	print "parse_F95_var_decl:".Dumper($pt);
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

    my $parlist = $pt->{'Pars'};#->[0]; #HACK
#    say Dumper($parlist);	
    my $lhs =$parlist->{Lhs};
    my $rhs =$parlist->{Rhs};
     	$pt->{'Pars'} = {Var => $lhs, Val => $rhs};
#	if (ref($parlist) ne 'ARRAY') {    
#		$pt->{'Pars'} = [$parlist];
#	}
	if (not exists $pt->{AccPragma}) {
		$pt->{AccPragma} = {AccKeyword => 'ArgMode', AccVal => 'ReadWrite'}
	}
	
if (exists  $pt->{VarsDims} && exists  $pt->{VarsDims}{'Dim'} ) {
	if (ref($pt->{VarsDims}{'Dim'}) eq 'ARRAY' and  @{  $pt->{VarsDims}{'Dim'} } > 0 ) {
	
	    my @dims = map { [  map { ':' } @{ $_->{'Sep'} }] } @{$pt->{VarsDims}{Dim}};
	    $pt->{Attributes}{Dim}=\@dims;
	    $pt->{'Vars'}= $pt->{VarsDims}{Var};
	    delete  $pt->{VarsDims} ;
	} else {
	    my @dims = ( [  map { ':' } @{ $pt->{VarsDims}{Dim}{Sep} } ] );
	    $pt->{Attributes}{Dim}=\@dims;
	    $pt->{'Vars'}= [$pt->{VarsDims}{Var}];
	    delete  $pt->{VarsDims} ;
	}
}

    print "<<<".Dumper($pt),">>>\n" if $VV;

	return $pt;
}

sub f95_var_decl_parser {
    sequence [
    	whiteSpace,
        {'TypeTup' => &type_parser},
        maybe(
        sequence [
        comma,
        {'Attributes' => sepByChar(',',&attribute_parser)}
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
	    	] 
    	),
	    maybe(
    		sequence [
	    		comma,
		    	&intent_parser
    		] 
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
        {'Type' =>	sequence( [{'Main' => word},maybe( {'Opt'=>word} ) ])  },
        choice( sequence([symbol('*'),{ 'Kind' => natural }]),
        maybe( parens( choice(
                {'Kind' => natural},
						sequence [
							choice( symbol('kind'), symbol('len') ),
							symbol('='),
                            {'Kind' => choice(natural, char('*'))}
						] 
					)  ))
            )      
		] 
}

sub dim_parser {
		sequence [
			symbol('dimension'),
#        {'Dim' => parens sepByChar(',', regex('[^,\)]+')) }, # FIXME: does not work for dim expressions with parentheses!
#        {'Dim' => parens sepByChar(',', choice( regex('(?:[^,\)]*(?:\([^,\)]+\))?[^,\)]*)+'), regex('[^,\)]+') ) ) },
# This is a very ugly hack, it works only for 1 pair of parens
# What this matches is "start with anything except ",)(", then "(" whatever ")"
        {'Dim' => parens sepByChar(',',  choice( regex('^[^,\)\(]+?(?:\([^,\)\(]+\))[^,\(\)]+'), regex('^[^,\)\(]+?(?:\([^,\)\(]+\))'),regex('^[^,\)]+') )   ) },
        maybe( char(')'))
		] 
}

sub intent_parser {
	 sequence [
        symbol('intent'),
     {'Intent' => parens word}
		] 
}

sub parameter_parser {
    symbol('parameter')
}

sub allocatable_parser {
    {'Allocatable' => symbol('allocatable')}
}

sub varlist_parser {
	sequence( [	
	symbol('::'),		
	choice({'Pars' => try(sepBy(comma,&param_assignment)) }
        #, {'VarsDims' =>sepByChar(',',  choice( regex('^[^,\)\(]+?(?:\([^,\)\(]+\))[^,\(\)]+'), regex('^[^,\)\(]+?(?:\([^,\)\(]+\))'),regex('^[^,\)]+') )   )}
        , {'VarsDims' => sepByChar(',',#comma, 
                sequence [
                    {'Var' => word}, 
                    {'Dim' => parens(
                            {'Sep' => sepBy(comma, symbol(':')) } 
                    )
                }
                ]
#                choice(  regex('\w+\(:\)') , regex('\w+\(:,:\)'), regex('\w+\(:,:,:\)') )  
            ) }
        ,{'Vars' => sepByChar(',',word) } )
	] )
}

sub param_assignment {
    sequence( [
        {'Lhs' => word },
        symbol('='),                
		{'Rhs' => choice(word,regex('[\.\d]+')) } #regex('[\.\d]+')} #FIXME very weak !
    ] )
}
sub openacc_pragma_parser { sequence [
        char('!'),
        whiteSpace,
        choice( symbol('$ACC'), symbol('$acc')),
		{'AccPragma' => sequence [
		{'AccKeyWord' => word},
		{'AccVal' => word}
		] }
        ]
}

1;
