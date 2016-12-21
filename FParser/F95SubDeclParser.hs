module F95SubDeclParser (
	f95_sub_decl_parser
		)
where
import F95SubDecl
import F95Types
import Text.ParserCombinators.Parsec hiding (State)
import Text.ParserCombinators.Parsec.Expr
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language
import F95ParserCommon
import F95VarDeclParser
import F95ParDeclParser

f95_sub_decl_parser :: Parser SubDecl
f95_sub_decl_parser = do
    whiteSpace
    symbol "subroutine" 
    sub_name <- word
    sub_args <- parens (commaSep word)
    use_statements <- many (symbol "use" >> word)
    try (symbol "implicit" >> symbol "none")
    par_decls <- manyTill f95_par_decl_parser (try f95_var_decl_parser)
    sub_arg_decls <- manyTill f95_var_decl_parser (try code_line_parser)
    code_lines <- manyTill code_line_parser  (try (whiteSpace >> symbol "end" >> symbol "subroutine" ))    
    many (symbol sub_name)
    return $ MkSubDecl sub_name sub_args par_decls sub_arg_decls code_lines

code_line_parser = do
    whiteSpace
    notFollowedBy (symbol "end" >> symbol "subroutine")
    rest <- code_line_rest_parser
    return $ rest

-- this should parse any line that is not a vardecl  
code_line_rest_parser = do
    cs <- many (noneOf ":\n")
    newline
    return cs
    
