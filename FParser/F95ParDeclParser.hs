module F95ParDeclParser (
	f95_par_decl_parser
		)
where
import F95Types
import Text.ParserCombinators.Parsec hiding (State)
import Text.ParserCombinators.Parsec.Expr
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language
import F95ParserCommon
import F95VarDeclParser

f95_par_decl_parser :: Parser ParDecl
f95_par_decl_parser = do
        whiteSpace
        tt <- type_parser
        -- FIXME: in principle can have a dimension here!
        let
            dim = []
--        dim <- many (comma >> dim_parser)
        comma 
        symbol "parameter"
        symbol "::"
        parname <- word
        symbol "="
        parval <- (expr_parser <|> f95_array_ctor_parser)  
        let 
            diml
                | length dim == 0 = []
                | otherwise = head dim
        
        return $ MkParDecl tt diml parname parval

f95_array_ctor_parser :: Parser Expr    
f95_array_ctor_parser = do
        whiteSpace
        symbol "(/"
        exprs <- commaSep1 expr_parser 
        symbol "/)"
        return $ ArrayCtor exprs

