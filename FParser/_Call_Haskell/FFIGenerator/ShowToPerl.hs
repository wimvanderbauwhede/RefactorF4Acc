module FFIGenerator.ShowToPerl ( showToPerl )
where
import Text.ParserCombinators.Parsec hiding (State)
-- import Text.ParserCombinators.Parsec.Char    
import Text.ParserCombinators.Parsec.Expr
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language
import Data.List


showToPerl :: String -> String
showToPerl = run_parser showParser

{-
vds1 = "MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = 4}, vd_dimension = [MkRange {r_start = Const 1, r_stop = Var \"ip\"},MkRange {r_start = Const 1, r_stop = Var \"jp\"},MkRange {r_start = Const 1, r_stop = Var \"kp\"}], vd_intent = InOut, vd_varlist = [\"u\"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]}"
vds = "((42,\"42\",True,MkTup 42 False (\"42\",3)),MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = (4,\"42\",5)}, vd_dimension = [MkRange {r_start = Const 1 \"1\", r_stop = Var \"ip\"},MkRange {r_start = Const 1, r_stop = Var \"jp\"},MkRange {r_start = Const 1 , r_stop = Var \"kp\"}], vd_intent = InOut, vd_varlist = [\"u\"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]})"

-- main = run_parser_print showParser vds
main = putStrLn $ showToPerl vds
-}

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

showParser =
    list_parser <|> -- [ ... ]
    tuple_parser <|> -- ( ... )
    map_parser <|> --  fromList [ ... ]
    bare_record_parser <|> --  { ... }
    try record_parser <|> -- MkRec { ... }
    try algtype_parser <|> -- MkAlg ...
--    type_identifier <|>
    unknown_parser <|> -- <unknown>
    number <|>    -- signed integer
    qstring -- <|> 
--    type_identifier -- <?> "Error"

showParserAlg =
    list_parser <|>
    try (parens map_parser) <|> 
    try (parens algtype_parser) <|>
    tuple_parser <|>
    bare_record_parser <|> --  { ... } WV Hack because in Language.Fortran a custom Show returns this
    try record_parser <|>
    unknown_parser <|>
    lone_type_identifier <|>
    number <|>
    qstring 

qstring = do
    s <- stringLiteral
    return $ "\'"++s++"\'"

number = do
    n <- integer
    return $ show n

list_parser = do
    ls <- brackets $ commaSep showParser 
    return $ "["++(joinComma ls) ++"]"

tuple_parser = do
    ls <- parens $ commaSep showParser 
    return $ "["++(joinComma ls) ++"]"

map_parser = do
    symbol "fromList"
    ls <- brackets (commaSep (parens (commaSep showParser))) -- [ (k,v) ]
    -- return { k => v }
    return $ "{"++(joinComma (map (\[k,v] -> k++"=>"++v) ls))++"}"

record_parser = do
    ti <- type_identifier
    ls <- braces $ commaSep kvparser
    return $ (ti++"( {"++(joinComma ls)++"} )")

bare_record_parser = do
    ls <- braces $ commaSep kvparser
    return $ ("Bare( {"++(joinComma ls)++"} )")
    

algtype_parser = do
    ti <- type_identifier 
    ls <- many showParserAlg
    return $ ti++"( "++(joinComma ls)++" )"

unknown_parser = do 
    symbol "<unknown>"
    return "\"<unknown>\""

kvparser = do
    k <- identifier
    symbol "="
    t <- showParser
    return $ k++"=>"++t

type_identifier = do
    fst <- oneOf ['A' .. 'Z']
    rest <- many alphaNum
    whiteSpace
    return $ fst:rest

lone_type_identifier = do
    fst <- oneOf ['A' .. 'Z']
    rest <- many alphaNum
    whiteSpace
    return $ (fst:rest)++"()"
    

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

