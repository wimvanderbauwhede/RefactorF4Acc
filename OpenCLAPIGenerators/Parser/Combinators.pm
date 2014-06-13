package Parser::Combinators;

use strict;
use 5.008_005;
our $VERSION = '0.03';

use Exporter 'import';

@Parser::Combinators::EXPORT    = qw(
        sequence 
        choice
        try
        maybe
        regex
        parens
        char
        sepBy
        oneOf
        word
        natural
        symbol
        greedyUpto
        upto
        many
        many1
        whiteSpace
		comma
		matches
		unwrap
		empty
        getParseTree
        bindP
        returnP
        $V
        );

use Data::Dumper;
$Data::Dumper::Indent=0;
$Data::Dumper::Terse =1;
our $V= 0;

# I want to write the parser using lists, because sequencing is the most common operation.
# So I need a function to generate the actual parser from the lists
# which is actually a sequence of parsers
# The first arg is a list ref, the second arg is an optional code ref to process the returned list of matches
sub sequence {
    (my $plst, my $proc)=@_;
    my $gen = sub {
        (my $str)=@_;
		print "* sequence($str)\n" if $V;
        my $matches=[];
        my $st=1;
        my $str2='';
        my $ms=undef;
        for my $p (@{$plst}) {
            if (ref($p) eq 'CODE') {
                ($st, $str, $ms)=$p->($str);
            } elsif (ref($p) eq 'HASH') {
                my %hp=%{$p};
                (my $k, my $pp) = each %hp;
                ($st, $str, my $mms)=$pp->($str);
                $ms = {$k => $mms};
            } else { # assuming it's ARRAY
                my $p2 = sequence($p);
                ($st, $str, $ms)=$p2->($str)
            }
            if (!$st) {
                return (0,$str,[]);
            } 	
            push @{$matches},$ms;# if scalar @{ $ms };
        }
        if (defined($proc)) {
            if( ref($proc) eq 'CODE') {
                return (1,$str,$proc->($matches));
            } else {
                print 'TROUBLE: <',Dumper($plst),'><',Dumper($proc),'>' if $V;
                return (1,$str,$matches);
            }
        } else {
            return (1,$str,$matches)
        }
    };
    return $gen;
}

# In the best tradition, bind() and return()
sub bindP {
    (my $p1,my $p2) =@_;
    my $gen = sub {(my $str1) =@_;
        print "* bindP( \'$str1\' )\n" if $V;
        my $matches=undef;
        (my $st1,my $str2,my $m1) = $p1->( $str1 );
        push @{$matches},$m1;
        if ($st1) {
            print "bind: p1( $str1 ) matched,[$m1] try p2( $str2 )\n";
            (my $st2,my $str3, my $m2) = $p2->( $str2 );
           if(ref($m2) eq 'ARRAY' ){
                $matches =[ @{$matches},@{$m2} ];
            } elsif (defined $m2) {
                push @{$matches},$m2;
            }
            return ($st2,$str3,$matches);
        } else {        
            return (0,$str1,undef);
        }
    };
    return $gen;
}

# Only we can't call it 'return' so let's call it enter :-)
sub returnP {
    sub {
        (my $str) = @_;
        return (0,$str,undef);
    }
}

# Choice: try every parser in the list until one succeeds or return fail.  '<|>' in Parsec
sub choice {
    my @parsers=@_;
    my $gen = sub {	(my $str)= @_;
		print "* choice('$str')\n" if $V;
        for my $p (@parsers) {
            my $status=0; my $matches=[];
            if (ref($p) eq 'CODE') {
                ($status, $str, $matches)=$p->($str);
            } elsif (ref($p) eq 'HASH') {
                my %hp = %{$p};
                (my $k, my $pp) = each %hp;
                ($status, $str, my $mms)=$pp->($str);
                $matches = {$k => $mms};
            } else {
                die Dumper($p);
            }
            if ($status) {
                print "choice: remainder => <$str>\n" if $V;
                print "choice: matches => [".Dumper($matches)."]\n" if $V;
                return ($status, $str, $matches);
            }
        }
        return (0, $str, []);
    };
    return $gen;
}
# Normally, when a parser parses a string, it removes the portion that matched. If you want to keep the string, wrap the parser in try()
sub try {
    (my $p)=@_;
    my $gen = sub {
        (my $str)=@_;
		print "* try( '$str' )\n" if $V;
        (my $status, my $rest, my $matches)=$p->($str);
        if ($status) {
            print "try: remainder => <$rest>\n" if $V;
            print "try: matches => [".Dumper($matches)."]\n" if $V;
            return (1, $rest, $matches);
        } else {
            print "try: match failed => <$str>\n" if $V;
            return (0, $str, $matches);
        }
    };
    return $gen;
}

# maybe() is like try() but always succeeds
# it returns the matches and the consumed string or the orig string and no matches
sub maybe {
    (my $p)=@_;
    my $gen = sub {
        (my $str)=@_;
		print "* maybe('$str')\n" if $V;
        (my $status, my $rest, my $matches)=$p->($str);
        if ($status) {
            print "maybe matches: [".Dumper($matches)."]\n" if $V;
            return (1, $rest, $matches);
        } else {
            print "maybe: no matches for <$str>\n" if $V;
            return (1, $str, undef);
        }
    };
    return $gen;
}

# Enough rope: this parser will parse whatever the regex is, stripping trailing whitespace
sub regex {
    (my $regex_str) = @_;
    my $gen = sub {	
        (my $str)=@_;
        print "* regex( '/$regex_str/', '$str' )\n" if $V;
        my $matches=undef;
        if(
                $str=~s/($regex_str)\s*//
          ) {
            my $m=$1;
            $matches=$m;
            print "regex: remainder => <$str>\n" if $V;
            print "regex: matches => [$matches]\n" if $V;
            return (1,$str, $matches);
        } else {
            print "regex: match failed => <$str>\n" if $V;
        }
        return (0,$str, $matches); # assumes $status is 0|1, $str is string, $matches is [string]
    };
    return $gen;
}

sub parens {
    (my $ref)= @_;
    my $gen = sub {	(my $str)=@_;
		print "* parens($str)\n" if $V;
        my $matches=undef;
        (my $status, my $str, my $ch)=char('(')->($str);
        if ($status==1) {
            $str=~s/\s*//;
            (my $st,$str,$matches)=$ref->($str); 
            print "parens: remainder => <$str>\n" if $V;
            print "parens: matches => [".Dumper($matches)."]\n" if $V;
            $status*=$st;
            if ($status==1) {
                (my $st, $str, my $ch)=char(')')->($str);
                if ($st==1) {
                    $str=~s/\s*//;
                }
                $status*=$st;
                if ($status==1) { # OK!
                    print "parens: matches => ".Dumper($matches)."\n" if $V;
                    return (1,$str, $matches);
                } else { # parse failed on closing paren
                    return (0,$str, $matches);
                }
            } else { # parse failed on $ref
                return (0,$str, $matches);
            }
        } else { # parse failed on opening paren
            return (0,$str,undef);
        }
    };
    return $gen;
}

sub char {
    (my $ch)=@_;
    my $gen =  sub {
        (my $str)=@_;
        print "* char('$ch', '$str')\n" if $V;
        if (substr($str,0,1) eq $ch) {
            print "char: matched \'$ch\' \n" if $V;
			print "char: remainder <".substr($str,1).">\n" if $V;
            return (1,substr($str,1),$ch);
        } else {
            return (0,$str,undef);
        }
    };
    return $gen;
}

sub sepBy {
    (my $sep, my $ref)=@_;
    my $gen = sub {	(my $str)=@_;
		 print "* sepBy('$sep', '$str')\n" if $V;
        my $matches=[];
        (my $status,$str,my $m)=$ref->($str);
        if ($status) {
            push @{$matches},$m;		
            print "sepBy: remainder => <$str>\n" if $V;
            while( do {($status,$str,$m)=char($sep)->($str); 
                    if ($status) {$str=~s/\s*//;};
                    $status==1} ) {
                (my $st,$str,$m)=$ref->($str);
                push @{$matches},$m;
            }
            print "sepBy matches => [".Dumper($matches)."]\n" if $V;
        } else { # first match failed. 
            return (0,$str,undef);
        }
        return (1, $str, $matches);
    };
    return $gen;
}
# This is a lexeme parser, so it skips trailing whitespace
sub word {
    my $gen = sub {	
        (my $str)=@_;
		print "* word( '$str' )\n" if $V;
        my $status=0;
        if(
                $str=~/^(\w+)/ 
          ) {
            my $m=$1;
            my $matches=$m;
            $status=1;
            $str=~s/^$m\s*//;
            print "word: remainder => <$str>\n" if $V;
            print "word: matches => [$matches]\n" if $V;
            return ($status,$str, $matches);
        } else {
            print "word: match failed => <$str>\n" if $V;
            return ($status,$str, undef); # assumes $status is 0|1, $str is string, $matches is [string]
        }
    };
    return $gen;
}
# matches an unsigned integer
sub natural {
    my $gen = sub {	
        (my $str)=@_;
        print "* natural( '$str' )\n" if $V;
        my $status=0;
        if(
                $str=~/^(\d+)/ 
          ) {
            my $m=$1;
            my $matches=$m;
            $status=1;
            $str=~s/^$m\s*//;
            print "natural: remainder => <$str>\n" if $V;
            print "natural: matches => [$matches]\n" if $V;
            return ($status,$str, $matches);
        } else {
            print "natural: match failed => <$str>\n" if $V;
            return ($status,$str, undef); # assumes $status is 0|1, $str is string, $matches is [string]
        }
    };
    return $gen;
}

# As in Parsec, parses a literal and removes trailing whitespace
sub symbol {
    (my $lit_str) = @_;
    $lit_str=~s/(\W)/\\$1/g; 
    my $gen = sub {	
        (my $str)=@_;
        print "* symbol( '$lit_str', '$str' )\n" if $V;
        my $status=0;
        if(
                $str=~/^\s*$lit_str\s*/ 
          ) {
            my $m=$1;
            my $matches=$lit_str;
            $status=1;
            $str=~s/^\s*$lit_str\s*//;
            print "symbol: remainder => <$str>\n" if $V;
            print "symbol: matches => [$matches]\n" if $V;
            return ($status,$str, $matches);
        } else {
            print "symbol: match failed => <$str>\n" if $V;
            return ($status,$str, undef); 
        }
    };
    return $gen;
}

# This parser parses anything up to the last occurence ofa given literal and trailing whitespace
sub greedyUpto {
    (my $lit_str) = @_;
    $lit_str=~s/(\W)/\\$1/g; 
    my $gen = sub {	
        (my $str)=@_;
        print "* greedyUpto( \'$lit_str\', \'$str\' )\n" if $V;
        if(
                $str=~/^(.*)\s*$lit_str\s*/ 
          ) {
            my $m=$1;
            $m=~s/\s*$//;
            my $matches= $m eq '' ? undef : $m;
            $str=~s/^.*$lit_str\s*//;
            print "greedyUpto: remainder => <$str>\n" if $V;
            print "greedyUpto: matches => [$matches]\n" if $V;
            return (1,$str, $matches);
        } else {
            print "greedyUpto: match failed => <$str>\n" if $V;
            return (0,$str, undef); 
        }
    };
    return $gen;
}

# This parser parses anything up to the last occurence of a given literal and trailing whitespace
sub upto {
    (my $lit_str )= @_;
    $lit_str=~s/(\W)/\\$1/g; 
    my $gen = sub {	
        (my $str)=@_;
        print "upto1 \'$lit_str\': <$str>\n" if $V;
        if(
                $str=~/^(.*?)\s*$lit_str\s*/ 
          ) {
            my $m=$1;
            my $matches= $m eq '' ? undef : $m;
            $str=~s/^.*?$lit_str\s*//;
            print "upto: remainder => <$str>\n" if $V;
            print "upto: matches => [$matches]\n" if $V;
            return (1,$str, $matches);
        } else {
            print "upto: match failed => <$str>\n" if $V;
            return (0,$str, undef); 
        }
    };
    return $gen;
}


# `many`, as in Parsec, parses 0 or more the specified parsers
sub many {
    (my $parser) = @_;
    my $gen = sub {
        (my $str)=@_;
        print "* many( '$str' )\n" if $V;
        (my $status,$str,my $m)=$parser->($str);
        if ($status) {
            my $matches = [$m];		
            while( $status==1 ) {
                (my $st,$str,$m)=$parser->($str);
                push @{$matches},$m;
            }
            print "many: remainder => <$str>\n" if $V;
            print "many: matches => [".Dumper($matches)."]\n" if $V;
            return (1, $str, $matches);
        } else { # first match failed. 
            print "many: first match failed => <$str>\n" if $V;
            return (1, $str,undef);
        }
    };
    return $gen;
}

# `many1`, as in Parsec, parses 1 or more the specified parsers
sub many1 {
    (my $parser) = @_;
    my $gen = sub {
        (my $str)=@_;
        my $matches=[];
        print "* many( '$str' )\n" if $V;
        (my $status,$str,my $m)=$parser->($str);
        if ($status) {
            push @{$matches},$m;		
            while( $status==1 ) {
                (my $st,$str,$m)=$parser->($str);
                push @{$matches},$m;
            }
            print "many: remainder => <$str>\n" if $V;
            print "many: matches => [".Dumper($matches)."]\n" if $V;
        } else { # first match failed. 
            print "many: first match failed => <$str>\n" if $V;
            return (0, $str,undef);
        }
        return (1, $str, $matches);
    };
    return $gen;
}

sub comma {
    my $gen = sub { (my $str) = @_;
		print "* comma( '$str' )\n" if $V;
        my $st = ($str=~s/^\s*,\s*//);
        if ($st) {
            print "comma: match\n" if $V;
        } else {
            print "comma: match failed\n" if $V;
        }
        return ($st, $str, undef);
    };
    return $gen;
}

sub semi {
    my $gen = sub { (my $str) = @_;
		print "* semi( '$str' )\n" if $V;
        my $st = ($str=~s/^\s*;\s*//);
        return ($st, $str, undef);
    };
    return $gen;
}



# strip leading whitespace, always success
sub whiteSpace {
    my $gen = sub {
        (my $str)=@_;
        print "* whiteSpace( \'$str\' )\n" if $V;
        $str=~s/^(\s*)//;	
        my $m=$1;
        return (1,$str,$m)
    };
    return $gen;
}

sub oneOf {
    (my $patt_lst) = @_;
    my $gen = sub {
	(my $str)= @_;
		print "* oneOf([".join('|',@{$patt_lst})."],'$str')\n" if $V;
        for my $p (@{$patt_lst}) {
            (my $status, $str, my $matches)= symbol($p)->($str);
            if ($status) {
                print "choice: remainder => <$str>\n" if $V;
                print "choice: matches => [".Dumper($matches)."]\n" if $V;
                return (1, $str, $matches);
            }
        }
        return (0, $str, undef);
    };
    return $gen;
}

sub matches {
	return @{$_[0]};
}

sub unwrap {
	(my $elt_in_array)=@_;
	my $elt = shift @{$elt_in_array};
		return $elt;
} 

sub empty {
	(my $elt_in_array)=@_;
	return (@{$elt_in_array} ) ? 0 : 1;
}

# This function returns labeled items in the parse tree.
# It is rather aggressive in removing unlabeled items
sub get_tree_as_lists { (my $list) = @_;
    my $hlist=[];
    for my $elt (@{$list}) {
        if (ref($elt) eq 'ARRAY' and scalar @{$elt}>0) { # non-empty list
            push @{ $hlist }, get_tree_as_lists($elt);
        } elsif (ref($elt) eq 'HASH') { # hash: need to process the rhs of the pair
            (my $k, my $v) = each %{$elt};
            if (ref($v) ne 'ARRAY') { # not an array => wrap in array and redo
                 push @{$hlist}, {$k => $v};
            } elsif (@{$v}==1) { # a single-elt array
                push @{$hlist}, {$k => $v->[0]};
            } else { 
                my $pv =[
                    map {
                        if (ref($_) eq 'ARRAY') {
                            get_tree_as_lists($_) 
                        } elsif ( ref($_) eq 'HASH') {
                            get_tree_as_lists([$_]) 
                        } elsif (defined $_) { $_ } 
                    } @{$v} 
                ];
                push @{$hlist}, {$k => $pv};
            }
        } 
    }
    return scalar @{$hlist}==1 ? $hlist->[0] : $hlist;
}

sub is_list_of_objects { (my $mlo) =$_;
    if (ref($mlo) eq 'ARRAY') {
        my @tmlo=@{$mlo};
    my @l=grep { ref($_) ne 'HASH' } @tmlo;
    return scalar(@l)?0:1;
    } else {
        return 0;
    }
}

sub l2m { (my $hlist) =@_;
        my $hmap = {};  
        my @hmap_vals = map {  (my $k, my $v)=%{$_}; $v } @{$hlist};
        my @hmap_keys = map {  (my $k, my $v)=%{$_}; $k } @{$hlist};
        my @hmap_rvals = map { is_list_of_objects($_) ? l2m($_) : $_ } @hmap_vals;
#        my @hmap_keys_vals = map {  each %{$_} } @{$hlist}
        for my $k ( @hmap_keys ) {
            my $rv = shift @hmap_rvals;
            $hmap->{$k}=$rv;
        }
#        my %{$hmap} = @hmap_keys_vals;
        return $hmap;
}

            
        
sub getParseTree { (my $m) =@_;
    return l2m(get_tree_as_lists($m));
}
#    return ( (hlist.length==1) ? (head hlist) : hlist) # This just returns 'false' ...

1;

__END__

=encoding utf-8

=head1 NAME

Parser::Combinators - A library of building blocks for parsing text

=head1 SYNOPSIS

  use Parser::Combinators;

  my $parser = < a combination of the parser building blocks from Parser::Combinators >
  (my $status, my $rest, my $matches) = $parser->($str);
  my $parse_tree = getParseTree($matches);


=head1 DESCRIPTION

Parser::Combinators is a library of parser building blocks ('parser combinators'), inspired by the Parsec parser combinator library in Haskell
(http://legacy.cs.uu.nl/daan/download/parsec/parsec.html).
The idea is that you build a parsers not by specifying a grammar (as in yacc/lex or Parse::RecDescent), but by combining a set of small parsers that parse
well-defined items.

=head2 Usage

Each parser in this library , e.g. C<word> or C<symbol>, is a function that returns a function (actually, a closure) that parses a string. You can combine these parsers by using special
parsers like C<sequence> and C<choice>. For example, a JavaScript variable declaration 

     var res = 42;

could be parsed as:

    my $p =
        sequence [
            symbol('var'),
            word,
            symbol('='),
            natural,
            semi
        ]

if you want to express that the assignment is optional, i.e. C< var res;> is also valid, you can use C<maybe()>:

    my $p =
        sequence [
            symbol('var'),
            word,
            maybe(
                sequence [
                   symbol('='),
                   natural
                   ]
            ),
            semi
        ]

If you want to parse alternatives you can use C<choice()>. For example, to express that either of the next two lines are valid:

    42
    return(42)

you can write

    my $p = choice( number, sequence [ symbol('return'), parens( number ) ] )

This example also illustrates the `parens()` parser to parse anything enclosed in parenthesis

=head2 Provided Parsers

The library is not complete in the sense that not all Parsec combinators have been implemented. Currently, it contains:

        whiteSpace : parses any white space, always returns success. 

        * Lexeme parsers (they remove trailing whitespace):

        word : (\w+)
        natural : (\d+)
        symbol : parses a given symbol, e.g. symbol('int')
		comma : parses a comma
        semi : parses a semicolon
        
        char : parses a given character

        * Combinators:

        sequence( [ $parser1, $parser2, ... ], $optional_sub_ref )
        choice( $parser1, $parser2, ...) : tries the specified parsers in order
        try : normally, the parser consums matching input. try() stops a parser from consuming the string
        maybe : is like try() but always reports success
        parens( $parser ) : parser '(', then applies $parser, then ')'
        many( $parser) : applies $parser zero or more times
        many1( $parser) : applies $parser one or more times
        sepBy( $separator, $parser) : parses a list of $parser separated by $separator
        oneOf( [$patt1, $patt2,...]): like symbol() but parses the patterns in order

        * Dangerous: the following parsers take a regular expression, so you can mix regexes and other combinators ...                                       

        upto( $patt )
        greedyUpto( $patt)
        regex( $patt)

=head2 Labeling

You can label any parser in a sequence using an anonymous hash, for example:

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

Applying this parser returns a tuple as follows:
   
  my $str = 'integer(kind=8), '
  (my $status, my $rest, my $matches) = type_parser($str);

Here,C<$status> is 0 if the match failed, 1 if it succeeded.  C<$rest> contains the rest of the string. 
The actual matches are stored in the array $matches. As every parser returns its resuls as an array ref, 
C<$matches> contains the concrete parsed syntax, i.e. a nested array of arrays of strings. 

    Dumper($matches) ==> [{'Type' => 'integer'},['kind','\\=',{'Kind' => '8'}]]

You can remove the unlabeled matches and convert the raw tree into nested hashes using C<getParseTree>:

  my $parse_tree = getParseTree($matches);

    Dumper($parse_tree) ==> {'Type' => 'integer','Kind' => '8'}

=head2 A more complete example

I wrote this library because I needed to parse argument declarations of Fortran-95 code. Some examples of valid declarations are:

      integer(kind=8), dimension(0:ip, -1:jp+1, kp) , intent( In ) :: u, v,w
      real, dimension(0:7) :: f 
      real(8), dimension(0:7,kp) :: f,g 

I want to extract the type and kind, the dimension and the list of variable names. For completeness I'm parsing the `intent` attribute as well.
The parser is a sequence of four separate parsers C<type_parser>, C<dim_parser>, C<intent_parser> and C<arglist_parser>.
All the optional fields are wrapped in a C<maybe()>.


    my $F95_arg_decl_parser =    
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
        &arglist_parser
	];

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
        {Dim => parens sepBy(',', regex('[^,\)]+')) }
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
            {Vars => sepBy(',',&word)}
        ]
    }    

Running the parser and calling C<getParseTree()> on the first string results in 

    {
    'TypeTup' => {
                'Type' => 'integer',
                'Kind' => '8'
            },
    'Dim' => ['0:ip','-1:jp+1','kp'],
    'Intent' => 'In',
    'Vars' => ['u','v','w']
    }

See the test fortran95_argument_declarations.t for the source code.    

=head3 No Monads?!

As this library is inspired by a monadic parser combinator library from Haskell, I have also implemented C<bindP()> and C<returnP()> for those who like monads ^_^
So instead of saying 

    my $pp = sequence [ $p1, $p2, $p3 ]

you can say
   
    my $pp = bindP( 
        $p1, 
        sub { (my $x) =@_;
            bindP( 
                $p2,  
                sub {(my $y) =@_;
                bindP(
                    $p3,
                    sub { (my $z) = @_;
                        returnP->($z);
                        }
                    )->($y)
                }
                )->($x);
            }
        );

which is obviously so much better :-)

=head1 AUTHOR

Wim Vanderbauwhede E<lt>Wim.Vanderbauwhede@gmail.comE<gt>

=head1 COPYRIGHT

Copyright 2013- Wim Vanderbauwhede

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

- The original Parsec library: L<http://legacy.cs.uu.nl/daan/download/parsec/parsec.html> and L<http://hackage.haskell.org/package/parsec>

=cut

