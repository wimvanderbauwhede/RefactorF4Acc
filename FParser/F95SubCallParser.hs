module F95SubCallParser (
	f95_sub_call_parser
		)
where
import F95Types
import Text.ParserCombinators.Parsec hiding (State)
import Text.ParserCombinators.Parsec.Expr
import qualified Text.ParserCombinators.Parsec.Token as P
import Text.ParserCombinators.Parsec.Language
import F95VarDeclParser

f95_sub_call_parser :: Parser SubCall
f95_sub_call_parser = do
    whiteSpace
    symbol "call"
    sub_name <- word
    sub_args <- parens commaSep word
    return $ MkSubCall sub_name sub_args

