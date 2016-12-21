module FFIGenerator.TypeToPerl ( typeToPerl )
where
import Text.ParserCombinators.Parsec hiding (State)
-- import Text.ParserCombinators.Parsec.Char    
import Text.ParserCombinators.Parsec.Expr
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language
import Data.List

{- Takes the string from show typeOf:
"([Char],[Int],(Maybe Int),TTup,(Map [Char] Int)) -> Bool"
What we need to do is:
- quote all typenames
- replace all parentheses with brackets
- transform alg datatypes into function calls 


-}
typeToPerl :: String -> String
typeToPerl = run_parser functype_parser  

run_parser_print :: Show a => Parser a -> String -> IO ()
run_parser_print p str = do
      case parse p "" str of
           Left err -> do
               putStr "parse error at "
               print err
           Right x  -> putStrLn $ "    "++(show x)++","
                                                                                                                                                         
run_parser :: Parser a -> String -> a
run_parser p str =  case parse p "" str of
    Left err -> error $ "parse error at " ++ (show err)
    Right val  -> val  

joinComma ls = intercalate "," ls

typeofParser =
    try algtype_parser_bare <|>
    type_identifier <|>
    list_parser <|> -- [ ... ]
    try algtype_parser <|> -- ( ... )
    tuple_parser -- Maybe Int
    
    
{-
typeofParserAlg =
    list_parser <|>
    try (parens map_parser) <|> 
    try (parens algtype_parser) <|>
    tuple_parser <|>
    try record_parser <|>
    lone_type_identifier <|>
    number <|>
    qstring 

qstring = do
    s <- stringLiteral
    return $ "\""++s++"\""

number = do
    n <- natural
    return $ show n
-}

functype_parser = do
    ls <- sepBy typeofParser (symbol "->") 
    return $ "["++(joinComma ls) ++"]"
     
list_parser = do
    ls <- brackets typeofParser
    if ls == "'Char'" 
    then 
      return $ "'String'"    
    else 
      return $ "["++ls ++"]"

tuple_parser = do
    ls <- parens $ commaSep typeofParser 
    return $ "["++(joinComma ls) ++"]"
{-
map_parser = do
    symbol "fromList"
    ls <- brackets (commaSep (parens (commaSep typeofParser))) -- [ (k,v) ]
    -- return { k => v }
    return $ "{"++(joinComma (map (\[k,v] -> k++"=>"++v) ls))++"}"

record_parser = do
    ti <- type_identifier
    ls <- braces $ commaSep kvparser
    return $ (ti++"( {"++(joinComma ls)++"} )")
-}
algtype_parser = do
    at <- parens algtype_parser_bare
    return at
     
algtype_parser_bare = do
    ti <- alg_type_identifier 
    ls <- many1 typeofParser
--    return $ "{ 'TypeName' => "++ti++", 'TypeArgs' => [ "++(joinComma ls)++" ] }"
    return $ ti++"( "++(joinComma ls)++" )"
{-
kvparser = do
    k <- identifier
    symbol "="
    t <- typeofParser
    return $ k++"=>"++t
-}
alg_type_identifier = do
    fst <- oneOf ['A' .. 'Z']
    rest <- many alphaNum
    whiteSpace
    return $ fst:rest
    
type_identifier = do
    fst <- oneOf ['A' .. 'Z']
    rest <- many alphaNum
    whiteSpace
    return $ "'"++(fst:rest)++"'"
{-
lone_type_identifier = do
    fst <- oneOf ['A' .. 'Z']
    rest <- many alphaNum
    whiteSpace
    return $ (fst:rest)++"()"
  -}  

lexer       = P.makeTokenParser emptyDef


parens          = P.parens lexer    
brackets        = P.brackets lexer    
braces          = P.braces lexer    
commaSep        = P.commaSep lexer
commaSep1       = P.commaSep1 lexer
whiteSpace      = P.whiteSpace lexer    
symbol          = P.symbol lexer    
word            = P.identifier lexer
identifier      = P.identifier lexer
reserved        = P.reserved lexer    
reservedOp      = P.reservedOp lexer
integer         = P.integer lexer    
charLiteral     = P.charLiteral lexer    
stringLiteral   = P.stringLiteral lexer    
comma           = P.comma lexer
semi            = P.semi lexer
natural         = P.natural lexer
-- letter          = P.letter lexer

