from Combinators import *

snip4 = 'www.python.org ; 42'
parser4 =  [ sepBy(dot, word ), semi, natural  ] 
res4 = run(parser4, snip4 )
print( res4 )
print()
"""
parser4c =  [ sepByChar('.', word ), semi, natural  ]
res4c = parser4c( snip4 )
print( res4c )

snip2 = 'href="http://www.python.org"'
href_attr_parser = sequence( [
    symbol('href'),symbol('='), symbol('"http://'), sepBy(dot(), word() ) , symbol('"') 
    ] )
res_tag = href_attr_parser(snip2)
print( res_tag )


snip = '< a  href="http://www.python.org" >Learn Python</a>'
tag_parser = [ 
    angleBrackets( 
       [ symbol('a') ,href_attr_parser ] 
       ), 
    many( word() ),
    angleBrackets( symbol('/a') )
   ]
        

href_tag = tag_parser(snip)
print( href_tag )
"""
parser11 =  many1( choice( [  {"Num" : natural} , {"Str":word} ] ) )
res11 = run( parser11, "42 choices" )
print( res11 )

