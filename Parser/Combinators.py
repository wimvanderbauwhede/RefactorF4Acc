#package Parser::Combinators
import types
import re
#
#   (c) 2017 Wim Vanderbauwhede 
#
VERSION = '0.06'

__all__ =[
 'apply',
 'show',
 'sequence',
 'choice',
 'try',
 'maybe',
 'regex',
 'parens',
 'char',
 'sepBy',
 'sepByChar',
 'oneOf',
 'word',
 'natural',
 'number',
 'symbol',
 'greedyUpto',
 'upto',
 'many',
 'many1',
 'whiteSpace',
 'comma',
 'semi',
 'matches',
 'unwrap',
 'empty',
 'getParseTree'
]

# I want to write the parser using lists, because sequencing is the most common operation.
# So I need a function to generate the actual parser from the lists
# which is actually a sequence of parsers
# The first arg is a list ref, the second arg is an optional code ref to process the returned list of matches
V=False

def apply( p, str_ ):
    if type(p) is  types.FunctionType:
        if V: print('FUNCTION '+str_) 
        # note: for barewords we need p()(str_) but this is not consistent I think.
        return p(str_)
    elif type(p) is list:
        if V: print('LIST!')
        return sequence(p)(str_)
    elif type(p) is dict:
        ( k, pp ) = p.popitem()
        ( status, str2, mms ) = pp(str_)
        matches = { k : mms }
        return ( status, str2, matches )
    else: # ( ref(p) eq 'REF' ):
        if V: print('ELSE!')
        return p(str_)
#    else:
#        die show(p)

def foldl( f, acc, ls ):    
    for elt in ls:
        acc = f( acc, elt )
    return acc

def sequence( plst):
    def gen( str_ ): 
        def f( acc, p ): 
            ( st1, str1, matches) = acc            
            if st1 != 0:
               # meaning the previous match succeeded or the remainder is empty
                ( st2, str2, ms ) = apply( p, str1 )
                if ( st2 * st1 == 0 ):
                    return ( 0, str1, [] )
                else:
#                    #say "SEQ matches: " . Dumper(:matches, ms ) if V
                    return ( 1, str2, matches+[ ms ] )                
            else:
                # Can be either match failed or remainder is empty
                if st1 == 0:
                    # Match failed
#                    #say "SEQ did not match, returning " . Dumper(acc) if V
                    return acc
                else:
                    # Remainder is empty
                    return ( 0, str1, matches )
        ( status, str2, matches ) = foldl( f, ( 1, str_, [] ), plst ) 
#        #say "SEQ AFTER FOLD has matches: "
#          . Dumper(matches)
#          . ' and status '
#          . status
#          if V
        if ( status == 0 ):
#            #say "seq returns empty match []" if V
            return ( 0, str_, [] )
#        elif proc is not None:
#            if type(proc[0]) is types.FunctionType:
##                #say "seq returns parsers called on " . Dumper(matches) if V
#                return ( 1, str2, proc[0](matches) )
#            else:
##                #say 'TROUBLE: <', show(plst), '><', show(proc), '>' if V
#                return ( 1, str_, matches )
        else:
#            #say "seq returns " . Dumper(matches) if V
            return ( 1, str2, matches )
    return gen

# Choice: try every parser in the list until one succeeds or return fail.  '<|>' in Parsec
def choice( parsers ):
    def gen( str_ ) :
        for p  in parsers:
            ( status, str_, matches ) = apply( p, str_ )
#            print( status )
            if status == 1:
                if V: print( "choice: remainder => <"+str_+">")
                if V: print( "choice: matches => [" +matches+ "]")
                return ( status, str_, matches )
        if V: print( "NONE of the choices matched" )
        return ( 0, str_, None ) # was []
    return gen

# Normally, when a parser parses a string, it removes the portion that matched. If you want to keep the string, wrap the parser in try()
def tryParse( p ):
    def gen( str_ ):
#        #say "* try( 'str' )" if V
        ( status, rest, matches ) = p(str_)
        if (status):
#            #say "try: remainder => <rest>" if V
#            #say "try: matches => [" . show(matches) . "]" if V
            return ( 1, rest, matches )
        else:
#            #say "try: match failed => <str>" if V
            return ( 0, str_, matches )
    return gen

# maybe() is like try() but always succeeds
# it returns the matches and the consumed str_ing or the orig str_ing and no matches
def maybe( p ):
    def gen( str_ ):
#        #say "* maybe('str_')" if V
        ( status, rest, matches ) = apply( p, str_ )
        if (status):
#            #say "maybe matches: [" . show(matches) . "]" if V
            return ( 1, rest, matches )
        else:
#            #say "maybe: no matches for <str_>" if V
            return ( 1, str_, undef )
    return gen

def parens( p ):
    def gen( str_ ):
#        #say "* parens(str_)" if V
        matches = None
        ( status, str_3, ch ) = char('(')(str_)
        if status == 1 :
            # OK, found a '(', now try and parse the rest
            str_4 = str_3.lstrip()
#            str_4 =~ s/\s*//
            ( st, str_4s, matches ) = apply( p, str_4 )
#            #say "parens: remainder => <str_4s>" if V
#            #say "parens: matches => [" . show(matches) . "]" if V
            status *= st
            if status == 1 :
                ( st, str_5, ch ) = char(')')(str_4s)
                status *= st
                if status == 1:    # OK!
                    str_6 = str_5.lstrip()
#                    #say "parens: remainder => <str_5>" if V
#                    #say "parens: matches => " . show(matches) . "" if V
                    return ( 1, str_6, matches )
                else:                 # parse failed on closing paren
#                    #say "parse failed on closing paren str_5" if V
                    return ( 0, str_5, matches )
                
            else:    # parse failed on ref
                        # WV20160428 this was str_4, whick broke nested parens
                #say "parse failed on ref str_ str_4" if V
                return ( 0, str_, matches )
            
        else:    # parse failed on opening paren
            return ( 0, str_3, undef )
    return gen

def char ( ch ):
    def gen( str_  ):
        #say "* char('ch', 'str_')" if V
        if  str_[ 0 : 1 ] == ch :
            #say "char: matched \'ch\' " if V
            #say "char: remainder <" . substr_( str_, 1 ) . ">" if V
            return ( 1, str_[ 1 : ], ch )
        else:
            return ( 0, str_, None )
    return gen


def sepBy ( sep, p ):
    def gen (str_ ):
        matches = []
        #say "* sepBy( 'str_')" if V
        ( status, str_1, m ) = apply(p, str_)
        if status:
            matches.push( m )
            #say "sepBy: remainder => <str_1>" if V
            ( status, str_2, m ) = sep(str_1)
            if (status):
                matches.push( m )
            while status:
                str_2s = str_2.lstrip()
                ( st, str_3, m ) = p(str_2s)
                matches.push(m)
                ( status, str_2, m ) = sep(str_3)
                if status:
                    matches.push( m )
            #say "sepBy matches => [" . show(matches) . "]" if V
            return ( 1, str_2, matches )
        else:    # first match failed.
            return ( 0, str_1, None )
    return gen

def sepByChar ( sep, p ):
    def gen( str_) :
        matches = []
        #say "* sepByChar('sep', 'str_')" if V
        ( status, str_1, m ) = apply( p, str_ )
        if status:
            matches.push( m )
            #say "sepByChar: remainder => <str_1>" if V
            ( status, str_2, m ) = char(sep)(str_1)
            while status:
                str_2s = str_2.lstrip()
                ( st, str_3, m ) = apply( p, str_2s )
                matches.push( m )
                ( status, str_2, m ) = char(sep)(str_3)
            
            #say "sepByChar matches => [" . show(matches) . "]" if V
            return ( 1, str_2, matches )
        else:    # first match failed.
            return ( 0, str_1, undef )
    return gen



# This is a lexeme parser, so it skips trailing whitespace
# Should be called "identifier" I think
def word(*dummy):
    def gen ( str_ ):
        #say "* word( 'str' )" if V
        patt = re.compile('^([a-z_]\w*)')
        matches = patt.match(str_)
        if  matches is not None :
            patt2=re.compile('^'+matches.group(0)+'\s*')
            str_ = patt2.sub('',str_,count=1)
            #say "word: remainder => <str>"   if V
            #say "word: matches => [matches]" if V
            return ( 1, str_, matches.group(0) )
        else:
            #say "word: match failed => <str>" if V
            return ( 0, str_, None )
                 # assumes status is 0|1, str is string, matches is [string]
    return gen


def identifier(*dummy):
    word()


# matches an unsigned integer
def natural(*dummy):
    def gen( str_) :
        #say "* natural( 'str_' )" if V
        patt = re.compile('^(\d+)')
        matches = patt.match(str_)
        if  matches is not None :
            patt2=re.compile('^'+matches.group(0)+'\s*')
            str_ = patt2.sub('',str_,count=1)
            #say "word: remainder => <str>"   if V
            #say "word: matches => [matches]" if V
            return ( 1, str_, matches.group(0) )
        else:
            #say "word: match failed => <str>" if V
            return ( 0, str_, None )
                 # assumes status is 0|1, str is string, matches is [string]
    return gen



# matches any number
def number():
    def gen( str_) :
        if V: 
            print( "* number( '"+str_+"' )\n" ) 
        status = 0
        patt = re.compile('^([\-\+]?\d*(?:\.\d*)?(?:[eE][\-\+]?\d*(?:\.\d*)?)?)(\W|[^\.]|)')
        matches = patt.match(str_)
        if matches is not None :            
            m       = matches.group(1)
            check   = matches.group(2)
            matches = m
            if check == '' :
             # It means no wrong characters after the number, defined as \w or \.
                status = 1
                patt2=re.compile('^'+m+'\s*')
                str_ = patt2.sub('', str_,count=1)
                # otherwise it was not a number
                if V: 
                    print( "number: remainder => <str_>\n")
                    print( "number: matches => [matches]\n" )
            return ( status, str_, matches )
        else:
            if V:
                print( "number: match failed => <str_>\n" )
            return ( status, str_, undef )
                 # assumes status is 0|1, str_ is str_ing, matches is [str_ing]
    return gen



# As in Parsec, parses a literal and removes trailing whitespace
def symbol ( lit_str_ ):
    patt1=re.compile('(\W)')
    m1 = patt1.match(lit_str_);
    lit_str_ = patt1.sub(m1.group(0),lit_str_)
    def gen( str_) :
        #say "* symbol( 'lit_str_', 'str_' )" if V
        status = 0
        patt2 = re.compile('\s*'+lit_str_+'\s*')
        m2 = patt2.match(str_)
        if m2 is not None:
            m       = m2.group(0)
            matches = lit_str_
            status = 1
            #str_ =~ s/^\s*lit_str_\s*//
            str_ = patt2.sub('',str_)
            #say "symbol: remainder => <str_>"   if V
            #say "symbol: matches => [matches]" if V
            return ( status, str_, matches )
        else:
            #say "symbol: match failed => <str_>" if V
            return ( status, str_, None )
    return gen


# This parser parses anything up to the last occurence of a given literal and trailing whitespace
def greedyUpto ( lit_str_ ):
    patt1=re.compile('(\W)')
    m1 = patt1.match(lit_str);
    lit_str_ = patt1.sub(m1.group(0),lit_str_)
    #lit_str_ =~ s/(\W)/\\1/g
    def gen( str_) :
        #say "* greedyUpto( \'lit_str_\', \'str_\' )" if V
        #if ( str_ =~ /^(.*)\s*lit_str_\s*/ ):
        patt2 = re.compile('^(.*)\s*'+lit_str_+'\s*')
        m2 = patt2.match(str_)
        if m2 is not None:
            matches = m2.group(0).strip()
            #m =~ s/\s*//
            #matches = m is '' ? undef : m
            #str_ =~ s/^.*lit_str_\s*//
            #say "greedyUpto: remainder => <str_>"   if V
            #say "greedyUpto: matches => [matches]" if V
            return ( 1, str_, matches )
        else:
            #say "greedyUpto: match failed => <str_>" if V
            return ( 0, str_, None )
    return gen


# This parser parses anything up to the last occurence of a given literal and trailing whitespace
def upto ( lit_str_ ):
    patt1=re.compile('(\W)')
    m1 = patt1.match(lit_str);
    lit_str_ = patt1.sub(m1.group(0),lit_str_)
    #lit_str_ =~ s/(\W)/\\1/g
    def gen( str_) :
        #say "* greedyUpto( \'lit_str_\', \'str_\' )" if V
        #if ( str_ =~ /^(.*)\s*lit_str_\s*/ ):
        patt2 = re.compile('^(.*?)\s*'+lit_str_+'\s*')
        m2 = patt2.match(str_)
        if m2 is not None:
            matches = m2.group(0).strip()
            #m =~ s/\s*//
            #matches = m is '' ? undef : m
            #str_ =~ s/^.*lit_str_\s*//
            #say "greedyUpto: remainder => <str_>"   if V
            #say "greedyUpto: matches => [matches]" if V
            return ( 1, str_, matches )
        else:
            #say "greedyUpto: match failed => <str_>" if V
            return ( 0, str_, None )
    return gen

# Enough rope: this parser will parse whatever the regex is, str_ipping trailing whitespace
def regex ( regex_str_ ):
    def gen( str_) :
        patt = re.compile(regex_str)
        #regex_str_=~s/\*/\\\*/g
        matches = patt.match(str_)
        if matches is not None:
            str_ = patt.sub('',str_,count=0)
            matches = m
            return ( 1, str_, matches )
        return ( 0, str_, matches )
    return gen

# `many`, as in Parsec, parses 0 or more the specified parsers
def many ( parser ):
    def gen( str_) :
#        print "* many( 'str_' )\n" if V
        ( status, str_, m ) = parser(str_)
        if status:
            matches = [m]
            while status == 1:
                ( status, str_, m ) = parser(str_)
                matches.push( m )
#            print "many: remainder => <str_>\n" if V
#            print "many: matches => [" . show(matches) . "]\n" if V
            return ( 1, str_, matches )
        else:    # first match failed.
#            print "many: first match failed => <str_>\n" if V
            return ( 1, str_, None )
    return gen


# `many1`, as in Parsec, parses 1 or more the specified parsers
def many1 ( parser ):
    def gen( str_) :
        matches = []
        #say "* many( 'str_' )" if V
        ( status, str_, m ) = parser(str_)
        if status:
            matches=matches+[ m ]
            while status == 1:
                ( status, str_, m ) = parser(str_)
                matches= matches+[ m ] #.push( m )
            #say "many: remainder => <str_>" if V
            #say "many: matches => [" . show(matches) . "]" if V
        else:    # first match failed.
            #say "many: first match failed => <str_>" if V
            return ( 0, str_, None )
        return ( 1, str_, matches )
    return gen                

# Matches a comma with optional whitespace
def comma():
    def gen( str_) :
        #say "* comma( 'str_' )" if V
        patt =re.compile('^\s*,\s*')
        m = patt.match(str_)
        str_ = patt.sub('',str_,count=1) 
        st = 0
        if m is not None:
            st = 1
            #say "comma: match" if V
        #else:
            #say "comma: match failed" if V
        return ( st, str_, None )
    return gen

# Matches a semicolon with optional whitespace
def semi():
    def gen( str_) :
        #say "* comma( 'str_' )" if V
        patt =re.compile('^\s*;\s*')
        m = patt.match(str_)
        str_ = patt.sub('',str_,count=1) 
        st = 0
        if m is not None:
            st = 1
            #say "comma: match" if V
        #else:
            #say "comma: match failed" if V
        return ( st, str_, None )
    return gen

# strip leading whitespace, always success
def whiteSpace(): 
    def gen ( str_ ):
        #say "* whiteSpace( \'str_\' )" if V
        patt = re.compile('^(\s*)')
        m = patt.match( str_ ).group(0)
        str_1 = str_.lstrip()
        return ( 1, str_1, m )
    return gen


def oneOf ( patt_lst ):
    def gen( str_) :
        #say "* oneOf([" . join( '|',:patt_lst ) . "],'str_')" if V
        for p in patt_lst:
            ( status, str_, matches ) = symbol(p)(str_)
            if status:
                #say "choice: remainder => <str_>" if V
                #say "choice: matches => [" . show(matches) . "]" if V
                return ( 1, str_, matches )
        return ( 0, str_, undef )
    return gen

# Enough rope: this parser will parse whatever the regex is, str_ipping trailing whitespace
def regex ( regex_str_ ):
    def gen( str_) :
        #regex_str_=~s/\*/\\\*/g
        #say "* regex( '/regex_str_/', 'str_' )" if V
        patt = re.compile( regex_str_ )
        matches =  patt.match( str_ )
        if matches is not None:
            patt2 = re.compile('('+regex_str_+')\s*' )
            str_ = patt2.sub('',str_,count=1)
            return ( 1, str_, matches.group(0) )
        #else:
            #say "regex: match failed => <str_>" if V
        return ( 0, str_, matches )
              # assumes status is 0|1, str_ is str_ing, matches is [str_ing]
    return gen

def matches(x):
    return x

def unwrap ( elt_in_array ):
    elt = elt_in_array.shift()
    return elt

def empty( elt_in_array ):
    if len(elt_in_array ) > 0:
        return False 
    else: 
        return True

#TODO:

def get_tree_as_lists ( list ):
    return list
def is_list_of_objects ( mlo ):
    return mlo
def flatten_lists_in_tree ( hlist ):
    return hlist
def add_to_map ( hmap, k, rv ):
    return hmap
def remove_undefined_values ( hlist ):
    return hlist
def remove_nested_singletons ( hlist ):
    return hlist
def l2m ( hlist, hmap ):
    return hmap


def getParseTree ( m ):
    mm = remove_undefined_values(m)
    tal = get_tree_as_lists(m)
    map_ = l2m( tal, {})
    return map_

def run ( p, str_ ):
    ( st, rest, m ) = apply( p, str_ )
    getParseTree(m)
    
parser1 = many1( choice( [ natural(), word() ] ) )
res1 = parser1("42 choices")
print( res1 )

parser = sequence( [word(),word(), parens( many1(  choice( [natural(),word()] ) ) ), symbol('.') ] )

res = parser("a test (with 2 parens) . ")
print(res)

