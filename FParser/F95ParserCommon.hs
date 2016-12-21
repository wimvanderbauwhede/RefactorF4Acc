module F95ParserCommon
where
import F95Types
import Text.ParserCombinators.Parsec hiding (State)
-- import Text.ParserCombinators.Parsec.Char    
import Text.ParserCombinators.Parsec.Expr
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language

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
-- This is a wrapper to deal with two possible ways of parsing "::"
arglist_parser_wrapper arglist_parser = do
        arglst <- (try arglist_parser)
        if arglst == [] 
            then 
                do {symbol "::"; arglst' <- arglist_parser; return arglst'}
            else
                return arglst

lexer       = P.makeTokenParser f95Def

f95Def = emptyDef
    { commentStart = ""
    , commentEnd = ""
    , commentLine = "! "
    , nestedComments = False
--    , identStart = letter <|> char '$'
    , identLetter = alphaNum <|> char '$' <|> char '_'
    , opStart = opLetter f95Def
    , opLetter = oneOf "=+-*/.:%&<>" -- :#%&*+./<=>?@\\^|-~"
    , reservedOpNames= []
    , reservedNames = []
    , caseSensitive = False
    }


parens          = P.parens lexer    
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

