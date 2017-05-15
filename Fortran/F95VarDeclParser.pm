package Fortran::F95VarDeclParser;
use warnings;
use strict;
use v5.10;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#
our $VERSION = '0.01';

use Parser::Combinators;
$Parser::Combinators::V=0;

use Carp;
use Data::Dumper;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

our $VV=0;
use Exporter 'import';

@Fortran::F95VarDeclParser::EXPORT    = qw(
		parse_F95_var_decl
);
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

sub parse_F95_var_decl {
	(my $str) = @_;
#$str=~s/^\s+//;
#chomp $str;
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
#carp $str .' => '.Dumper($pt);	
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
		{'Dim' =>  parens( &comma_sep_expr_list ) }
#        {'Dim' => parens sepByChar(',',  
#        	choice( 
#        		regex('^[^,\)\(]+?(?:\([^,\)\(]+\))[^,\(\)]+'), 
#        		regex('^[^,\)\(]+?(?:\([^,\)\(]+\))'),
#        		regex('^[^,\)]+') 
#        		)   
#        	) 
#        },
#        maybe( char(')'))
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
		{'Rhs' => choice(word,regex('[\-\.\dedq]+')) } #FIXME  weak !
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


# matches an unsigned integer
sub comma_sep_expr_list {
#	local $V=1;
	my $gen = sub {
		( my $str ) = @_;
#		local $V=1;
		say "* comma_sep_expr_list( '$str' )" if $V;
		my $status = 0;
		my $matches_remainder = _parse_comma_sep_expr_list($str);
		(my $matches, my $remainder)=@{$matches_remainder};
		if ( scalar @{$matches} > 0  ) {
			$status = 1;
#			$str = substr($str,0,length($str)-length($remainder)); # 1234 5678
			say "comma_sep_expr_list: remainder => <$remainder>"   if $V;		
#			say "comma_sep_expr_list: str => <$str>"   if $V;			
			say "comma_sep_expr_list: matches => [".join(',',@{$matches})."]" if $V;
			return ( $status, $remainder, $matches );			
		} else {
			say "comma_sep_expr_list: match failed => <$str>" if $V;
			return ( $status, $str, undef );   # assumes $status is 0|1, $str is string, $matches is [string]
		}
	};
	return $gen;
}


sub _parse_comma_sep_expr_list {

	( my $str ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;

	my $matched_str  = '';
	my @matched_strs = ();

	for my $ch_idx ( 0 .. $nchars - 1 ) {
		my $ch = shift @chars;
		if ( $ch eq '(' ) {
			$found_parens = 1;
			++$parens_count;
			$matched_str .= $ch;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
			if ( $found_parens == 1 and $parens_count == 0 ) {
				$found_parens = 0;
			} elsif ($parens_count<0) {
				push @matched_strs, $matched_str;
				unshift @chars,')';
				last;
			}
			$matched_str .= $ch;
		} elsif ( $ch eq ',' and $found_parens == 0 ) {
			push @matched_strs, $matched_str;
			$matched_str = '';
		} elsif ( $ch ne ' ' ) {
			$matched_str .= $ch;
		}
		if ( $ch_idx == $nchars - 1 ) {
			push @matched_strs, $matched_str;
		}
	}
	my $remainder = join('',@chars);
	return [\@matched_strs,$remainder];
} # END of _parse_comma_sep_expr_list

1;
