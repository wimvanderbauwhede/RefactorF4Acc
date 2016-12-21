module F95VarDeclParser where
import F95Types
import Text.ParserCombinators.Parsec hiding (State)
import Text.ParserCombinators.Parsec.Expr
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language
import F95ParserCommon
{-
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
-}
f95_var_decl_parser :: Parser VarDecl
f95_var_decl_parser = do
        whiteSpace
        tt <- type_parser
        dim <- many (try (comma >> dim_parser))
        il <- many (comma >> intent_parser)
        let 
            intent 
                | length il == 0 = InOut
                | otherwise = head il
            diml
                | length dim == 0 = []
                | otherwise = head dim
        symbol "::"                    
        arglist <- arglist_parser
        pl <- many ocl_argmode_parser
        let 
            argmode
                | length pl == 0 = ReadWrite
                | otherwise = head pl
        return $ MkVarDecl tt diml intent arglist argmode True False [] -- FIXME: need to determine if arg or not, rather than always True

type_parser :: Parser VarType
type_parser = do    
        ntstr <- word
        wszl <- many $ parens (
                    natural 
                <|> (symbol "kind" >> symbol "=" >> natural)
                    )        
        let 
            wsz 
                | length wszl == 0 = 4
                | otherwise = head wszl
        let 
            nt
                | ntstr == "real" = F95Real
                | ntstr == "integer" = F95Integer
                | otherwise =  error $ "Unknown Numeric Type: "++ntstr
        return $ MkVarType nt wsz

dim_parser :: Parser [Range]
dim_parser = do
    symbol "dimension"
    dimlst <- parens (commaSep range_parser)
    return dimlst

range_parser :: Parser Range
range_parser = do
    rl <- (try range_expr <|> single_expr_range <|> single_var_range <|> single_const_range <?> "Range parser failed")
    return rl

single_var_range :: Parser Range    
single_var_range = do
    re <- word
    return $ MkRange (Const 1) (Var re)

single_const_range :: Parser Range
single_const_range = do
    re <- natural
    return $ MkRange (Const 1) (Const re)

single_expr_range :: Parser Range
single_expr_range = do
    re <- expr_parser
    return $ MkRange (Const 1) re   

range_expr :: Parser Range    
range_expr = do
    rs <- expr_parser
    symbol ":"
    re <- expr_parser
    return $ MkRange rs re

intent_parser :: Parser Intent    
intent_parser = do
    symbol "intent"
    intstr <- parens word
    let 
        intent 
            | intstr == "in" = In
            | intstr == "out" = Out
            | intstr == "inout" = InOut
    return intent

arglist_parser :: Parser [VarName]    
arglist_parser = do
--    symbol "::"
    arglst <- commaSep word
    return arglst    

ocl_argmode_parser :: Parser OclArgMode    
ocl_argmode_parser = do
        char '!'
        whiteSpace
        symbol "$acc"
        word
        accval <-word
        let 
            oclargmode
                | accval == "read" = Read
                | accval == "write" = Write
                | accval == "readwrite" = ReadWrite
        return oclargmode

expr_parser :: Parser Expr
expr_parser = buildExpressionParser optable term <?> "expression"

term :: Parser Expr
term = parens expr_parser <|> const_expr <|> (try array_idx_expr) <|> var_expr <?> "simple expression"
const_expr = do
    c <- natural
    return $ Const c
var_expr = do
    v <- word
    return $ Var v

array_idx_expr = do
    v <- word
    e <- parens expr_parser
    return $ ArrayIdx v e

optable =
    let
        binop name assoc   = Infix ( do {  reservedOp name; return (\x y ->(Op (MkOpExpr name x y))) } ) assoc
        prefix name     = Prefix  ( reservedOp  name >> return (\x ->(Pref (MkPrefixOpExpr name x))) ) 
    in
        [
          [ prefix "-" ]
        , [ binop "*"  AssocLeft, binop "/"  AssocLeft, binop "%" AssocLeft ]
        , [ binop "+"  AssocLeft, binop "-"  AssocLeft ]
        ]

{-
lexer       = P.makeTokenParser f95Def

f95Def = LanguageDef
    { commentStart = ""
    , commentEnd = ""
--    , commentLine = "!"
    , nestedComments = False
    , identStart = letter <|> char '$'
    , identLetter = alphaNum <|> char '$'
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
-}
