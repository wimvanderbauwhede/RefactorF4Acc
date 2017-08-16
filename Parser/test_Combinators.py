from Combinators import *


str51 = 'debug'
str52 = 'debug) '

print('*** create parser ***')
dim_parser2 = {'Dim' : debug } # parens( word ) }
print('*** apply parser ***')

res51 =apply( dim_parser2,str51)
print( '** parser after application: ',dim_parser2)
print('str51: ',res51)

print('*** apply parser again ***')

res52 = apply( dim_parser2,str52)
print('str52: ',res52)


#exit(0)

test1 = 'integer'
parser1 =  word 
res1 = apply( word, test1 )
print(res1)

snip4 = 'www.python.org ; 42'
parser4 =  [ { 'URL' : sepBy(dot, word ) }, semi, natural  ] 
res4 = run(parser4, snip4 )
print( res4 )
print()

parser4c =  [ sepByChar('.', word ), semi, natural  ]
res4c = apply( parser4c, snip4 )
print( res4c )

snip2 = 'href="http://www.python.org"'
href_attr_parser = sequence( [
    symbol('href'),
    symbol('='), 
    symbol('"http://'), 
    sepBy(dot, word ) , symbol('"') 
    ] )
res_tag = href_attr_parser(snip2)
print( res_tag )


snip = '< a  href="http://www.python.org" >Learn Python</a>'
tag_parser = [ 
    angleBrackets( 
       [ symbol('a') ,href_attr_parser ] 
       ), 
    many( word ),
    angleBrackets( symbol('/a') )
   ]
        

href_tag = apply(tag_parser,snip)
print( href_tag )

parser11 =  many1( choice(   {"Num" : natural} , {"Str":word}  ) )
res11 = run( parser11, "42 choices" )
print( res11 )


str2 = '    integer(8) :: var '

p = sequence( [
    whiteSpace,
    word,
    parens( natural ),
    symbol('::'),
    word
    ] ) 

res = p(str2)

print(res)
print( '------------------------------------------------------------------------------' )

type_parser =  [
    {'Type' : word},
    maybe( parens( choice( 
        {'Kind' : natural},
        [
            symbol('kind'),
            symbol('='),
            {'Kind' : natural}
            ] 
            )))    
    ]

dim_parser = [
    symbol('dimension'),
    {'Dim' : parens( sepByChar(',', regex('[^,\)]+'))) }
    ]

intent_parser =  [
    symbol('intent'),
    { 'Intent' : parens( word ) }
    ]

arglist_parser =  [
    symbol('::'),
    {'Args' : sepByChar(',', word) }
    ]

F95_arg_decl_parser =  [
        whiteSpace,
        {'TypeTup' : type_parser},
        maybe(
             [
                comma,
                dim_parser
            ], 
        ),
        maybe(
             [
                comma,
                intent_parser
            ], 
        ),
        symbol('::'),
        {'Vars' : commaSep(word)}
    ] 

# where

str1 = '      integer(kind=8), dimension(0:ip, -1:jp+1, kp) , intent( In ) :: u, v,w'
str4 = 'integer(kind=8), dimension(0:ip, -1:jp+1, kp) , intent( In ) :: u, v,w'
str4='integer'
str5 = 'dimension(0:ip, -1:jp+1, kp) '#, intent( In ) :: u, v,w'

str6 = ' intent( In ) '#:: u, v,w'
str7 = ':: u, v,w'
(st,rest, matches) = apply(F95_arg_decl_parser,str1)
print('str1:')
print(matches)
print( '------------------------------------------------------------------------------' )
print( '------------------------------------------------------------------------------' )

print(getParseTree( matches ))


print( '------------------------------------------------------------------------------' )

res4 = apply(word,str4) #type_parser(str4)
print('str4: ',res4)
res4 = apply(word,str4) #type_parser(str4)
print('str4: ',res4)



res6 = apply( intent_parser,str6)
print('str6: ',res6)
[st,rest, matches] = apply(arglist_parser,str7)
print('str7: ',matches)



str2 = '      real, dimension(0:7) :: f '


( st, rest, matches2) = apply(F95_arg_decl_parser,str2)
print('str2: '+rest)
print( matches2)

str3 = '      real(8), dimension(0:7,kp) :: f,g '
res = run(F95_arg_decl_parser,str3)
print('str3: ',res)
#print(  matches3)


