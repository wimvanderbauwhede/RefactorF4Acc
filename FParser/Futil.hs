module Futil where

import Data.Char(isSpace,isAlpha,toLower,toUpper,digitToInt)
import Control.Monad(join)
import Text.ParserCombinators.Parsec hiding (label,sepBy,sepBy1,newline)

newline = do (char '\r' >>= \_ -> return ()) <|> return ()
             char '\n'
--newlines1 = newline >> whiteSpaceWithNewlines
newlines  = many  $ lexeme newline
newlines1 = many1 $ lexeme newline

--aEqualsB :: String -> CharParser st Expr -> CharParser st Expr
--aEqualsB a b = reserved a >> reservedOp "=" >> b
aEqualsB :: String -> CharParser st e -> CharParser st (String,e)
aEqualsB a b = reserved a     >>= \str ->
               reservedOp "=" >>
               b              >>= \expr ->
               return (map toLower str,expr)

nocase name = walk name >> return name
                where
                  walk []     = return ()
                  walk (c:cs) = do { caseChar c <?> msg; walk cs }
                       
                  caseChar c
                    | isAlpha c  = char (toLower c) <|> char (toUpper c)
                    | otherwise  = char c
                          
                  msg         = show name


-- notFollowedBy' :: Show a => GenParser tok st a -> GenParser tok st ()
-- notFollowedBy' p = try $ join $ do a <- try p
--                                    return (unexpected (show a))
--                                 <|>
--                                    return (return ())
-- Just like notFollowedBy, but no expectation that "a" must be a Show instance
-- ...which allows notFollowedBy' (reservedOp "=")
notFollowedBy' :: GenParser tok st a -> GenParser tok st ()
notFollowedBy' p = try $ (try p >> fail "notFollowedBy'") <|> return ()

sepBy1,sepBy :: GenParser tok st a -> GenParser tok st sep ->
                GenParser tok st [a]
sepBy p sep  = sepBy1 p sep <|> return []
sepBy1 p sep = do x <- p
                  xs <- many $ try $ sep >> p
                  return (x:xs)

sepBy2 :: GenParser tok st a -> GenParser tok st sep -> GenParser tok st [a]
sepBy2 p sep = do x1 <- p
                  sep
                  x2 <- p 
                  xs <- many $ try $ sep >> p
                  return (x1:x2:xs)

commaSep  p = sepBy p comma
commaSep1 p = sepBy1 p comma

gapped  a b = choice [try $ reserved a >> reserved b, reserved $ a ++ b]
gapped1 a b = reserved a >> reserved b

endswith :: String -> String -> Bool
endswith end []     = False
endswith end (c:cs) = (cs==end) || endswith end cs

{-decimal = number 10 digit        

number base baseDigit =

 do digits <- many1 baseDigit
    l <- return $ length digits
    let i = foldl (\x d -> base*x + toInteger (digitToInt d)) 0 digits
    seq i $ return (l,i)
-}

-----------------------------------------------------------
-- The lexer
-----------------------------------------------------------


lexeme p = p >>= \x -> whiteSpace >> return x

reserved n = lexeme $ try $ do nocase n -- Do the toLower first
                               notFollowedBy' (alphaNum <|> char '_')
                               return $ map toLower n

--lexer     = P.makeTokenParser fDef

{-fDef  = javaStyle
          { -- PGK: Should have a P.opEnd in Parsec to avoid final underscore
            P.commentLine    = "!"
          , P.identStart     = letter
          , P.identLetter    = alphaNum <|> char '_'
          , P.caseSensitive  = False
          }
-}

{-fDef = P.LanguageDef
       {
         P.commentStart   = "",
         P.commentEnd     = "",
         P.commentLine    = "!",
         P.nestedComments = True,
         P.identStart     = letter,
         P.identLetter    = alphaNum <|> char '_',
         P.opStart        = P.opLetter fDef,
         P.opLetter       = oneOf ":!#$%&*+./<=>?@\\^|-~",
         P.reservedOpNames= [],
         P.reservedNames  = [],
         P.caseSensitive  = False
       }
-}

symbol s = lexeme $ string s
colon           = symbol ":" -- P.colon lexer
comma           = symbol ","
--comma           = P.comma lexer
--parens          = P.parens lexer    
parens p        = between (symbol "(") (symbol ")") p
--braces          = P.braces lexer    
--semiSep         = P.semiSep lexer  
--semiSep1        = P.semiSep1 lexer    
--commaSep        = P.commaSep lexer
--commaSep1       = P.commaSep1 lexer
--brackets        = P.brackets lexer
--whiteSpace      = P.whiteSpace lexer    
whiteSpace      = skipMany $ simpleSpace <|> oneLineComment
--                  <|> do  { char '&'
--                          ; option () $ do { char '\r'; return () }
--                          ; char '\n'
--                          ; return ()
--                          } -- Fortran line continuation
--                  <|> oneLineComment
simpleSpace = skipMany1 (satisfy (\c -> (c /= '\n') && (c /= '\r') &&
                         isSpace c))
              <|> do  { char '&'
                      ; option () $ do { char '\r'; return () }
                      ; char '\n'
                      ; return ()
                      } -- Fortran line continuation

oneLineComment =
  do{ try $ char '!'
    ; skipMany (satisfy (/= '\n'))
    ; return ()
    }
--whiteSpace      = P.whiteSpace lexer    
--whiteSpaceWithNewlines      = P.whiteSpaceWithNewlines lexer    
--symbol          = P.symbol lexer 
--identifier      = P.identifier lexer    
--identifier = lexeme $ try $
--               do{ name <- ident
--                 ; if (isReservedName name)
--                   then unexpected ("reserved word " ++ show name)
--                   else return name
--                }
identifier = lexeme $ try $ do{ c <- letter
                              ; cs <- many (alphaNum <|> char '_')
                              ; return (c:cs)
                              }
                         --   <?> "identifier"
--reserved        = P.reserved lexer    
--reservedOp      = P.reservedOp lexer
--integer         = P.integer lexer    
--natural         = P.natural lexer
integer         = lexeme int        <?> "integer"
natural         = lexeme nat        <?> "natural"
int             = do{ f <- lexeme sign
                    ; n <- nat
                    ; return (f $ snd n)
                    }
sign            =   (char '-' >> return negate) 
                <|> (char '+' >> return id)     
                <|> return id
--nat             = zeroNumber <|> decimal
nat             = decimal
decimal         = number 10 digit
number base baseDigit =

 do digits <- many1 baseDigit
    l <- return $ length digits
    let i = foldl (\x d -> base*x + toInteger (digitToInt d)) 0 digits
    seq i $ return (l,i)

{-number base baseDigit
    = do{ digits <- many1 baseDigit
        ; let n = foldl (\x d -> base*x + toInteger (digitToInt d)) 0 digits
        ; seq n (return n)
        }          
-}

--decimal         = P.decimal lexer
--charLiteral     = P.charLiteral lexer    
--stringLiteral   = P.stringLiteral lexer    

reservedOp "="      = try $ lexeme (string "=")         >>
                            notFollowedBy' (oneOf ">=") >>
                            return ()

reservedOp "*"      = try $ lexeme (string "*")         >>
                            notFollowedBy' (char '*')   >>
                            return ()

reservedOp "<"      = try $ lexeme (string "<")         >>
                            notFollowedBy' (char '=')   >>
                            return ()

reservedOp ">"      = try $ lexeme (string ">")         >>
                            notFollowedBy' (char '=')   >>
                            return ()

reservedOp "/"      = try $ lexeme (string "/")         >>
                            notFollowedBy' (oneOf "/=") >>
                            return ()

reservedOp ".NOT."  = try $ lexeme (nocase ".NOT.")     >> return ()
reservedOp ".AND."  = try $ lexeme (nocase ".AND.")     >> return ()
reservedOp ".OR."   = try $ lexeme (nocase ".OR.")      >> return ()
reservedOp ".EQV."  = try $ lexeme (nocase ".EQV.")     >> return ()
reservedOp ".NEQV." = try $ lexeme (nocase ".NEQV.")    >> return ()
reservedOp op       = try $ lexeme (string op) >> return ()


