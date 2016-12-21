module FExprParser (f77_f95_expr_parser ) where

-- import F95Types
import FExpr

import Prelude hiding (significand, exponent)
import Text.ParserCombinators.Parsec hiding (label,sepBy,sepBy1,newline)
import Text.ParserCombinators.Parsec.Expr
import Text.ParserCombinators.Parsec.Combinator(lookAhead)
import Futil hiding (sign)
{-- 
import ParseTree
import SymbolTable
--}
import Control.Monad(ap,liftM,liftM2,when)
import Data.List(genericLength)
import Debug.Trace

f77_f95_expr_parser = assignment_stmt
-- R301 (Unused)
-- Note that like underscore, letter, digit, oneOf are NOT lexeme parsers.
character :: CharParser SmT Char
character =

  choice [
    alphanumeric_character,
    special_character
    ]

   where special_character = oneOf "=+-*/(),.':!\"%&;<>?$ "


-- R302
alphanumeric_character =

  choice [
    letter,
    digit,
    underscore
    ]


-- R303
underscore = char '_'

-- R304
name = identifier

-- R305
constant :: CharParser SmT Expr
constant =

  choice [
    liftM (Lit     []) literal_constant,
    liftM (ExprPrim []) named_constant
    ]


-- R306
literal_constant :: CharParser SmT Lit
literal_constant =

  choice [
    real_literal_constant,
    int_literal_constant,-- . IntLit,
    (try complex_literal_constant), -- The try aids Rule 701
    logical_literal_constant,
    char_literal_constant
    ]


-- R307
-- Use a different AST type (e.g. IntCons n). This will allow named
-- constants to be replaced by their numeric values
named_constant :: CharParser st Prim 
named_constant = name >>= \n -> return $ VarName [] n


-- R308
int_constant = constant


-- R309
char_constant = constant


-- R310
intrinsic_operator :: CharParser st Op
intrinsic_operator =

  choice [
    liftM (BOp []) power_op,
    liftM (BOp []) mult_op,
    liftM (BOp []) add_op,
    liftM (BOp []) concat_op,
    liftM (BOp []) rel_op,
    liftM (UOp []) not_op,
    liftM (BOp []) and_op,
    liftM (BOp []) or_op,
    liftM (BOp []) equiv_op
    ]


-- R311
defined_operator :: CharParser st Op
defined_operator =

  choice [
    liftM (UOp []) defined_unary_op,
    liftM (BOp []) defined_binary_op,
    extended_intrinsic_op
    ]


-- R312
extended_intrinsic_op = intrinsic_operator


-- R401
-- id is the Haskell identity function
signed_digit_string :: CharParser st Integer
signed_digit_string =

 do f <- sign <|> return id
    (l,i) <- digit_string
    return $ f i


-- R402
digit_string :: CharParser st (Int,Integer)
digit_string = lexeme decimal


-- R403
signed_int_literal_constant =

 do f <- sign <|> return id
    (IntLit _ n k) <- int_literal_constant
    return $ IntLit [] (f n) k


-- R404
int_literal_constant :: CharParser st Lit
int_literal_constant =
  
 do (l,i) <- digit_string
    k <- option Nothing $
                reservedOp "_" >> kind_param >>= return . Just . VarName []
    return $ IntLit [] i (IntType [] k)


-- R405
kind_param = scalar_int_constant_name


-- R406
sign :: Num a => CharParser st (a -> a)
sign =

  choice [
    reservedOp "+" >> return id,
    reservedOp "-" >> return negate
    ]


rep_char_dq =

  choice [
    liftM Just str_letter_dq,
    dbl_quote
    ]
      <?> "rep_char_dq"

rep_char_sq =

  choice [
    liftM Just str_letter_sq,
    sgl_quote
    ]
      <?> "rep_char_sq"
      

str_letter_dq = satisfy (\c -> (c /= '"') && (c > '\026'))
str_letter_sq = satisfy (\c -> (c /= '\'') && (c > '\026'))


dbl_quote = try $ char '"' >> char '"' >> return (Just '"')
sgl_quote = try $ char '\'' >> char '\'' >> return (Just '\'')
 

str_lit = str_lit_dq <|> str_lit_sq
str_lit_dq = lexeme ( do 
        str <- between (char '"') (char '"' <?> "end of string") (many rep_char_dq) 
        return $ foldr (maybe id (:)) "" str 
                 ) <?> "literal string"

str_lit_sq = lexeme ( do 
        str <- between (char '\'') (char '\'' <?> "end of string") (many rep_char_sq) 
        return $ foldr (maybe id (:)) "" str                 )  <?> "literal string"


-- R412 -- Output differs (even) with input of "0.1e-01"
signed_real_literal_constant :: CharParser SmT Lit
signed_real_literal_constant =

 do f <- sign <|> return id
    (RealLit [] r k) <- real_literal_constant
    return $ RealLit [] (f r) k --s f x
 --     where s f (RealLit r k) = RealLit (f r) k
        
--RealLit (f (getR x)) (getK x)
--getR (RealLit r k) = r
--getK (RealLit r k) = k


-- R413
real_literal_constant :: CharParser SmT Lit--Expr
real_literal_constant =

 do s <- try significand
    e <- option 1.0 $ exponent_letter >> exponent
    k <- option Nothing $
                reservedOp "_" >> kind_param >>= return . Just . VarName []
    return $ RealLit [] (s * e) (RealType [] k)


-- R414
significand :: CharParser SmT Double
significand =

  maybe_digit_string    >>= \(nl,n) ->
  reservedOp "."  >>
  maybe_digit_string    >>= \(fl,f) ->
  return $ fromInteger n + fromInteger f/(10.0^fl)

maybe_digit_string = do
    res <- many digit_string 
    let
        retval 
            | length res == 0 = (0,0)
            | otherwise = head res
    return retval

-- R415
exponent_letter = nocase "E"


-- R416
exponent :: CharParser SmT Double -- Integer
exponent = signed_digit_string >>= return . power
             where power e | e < 0     = 1.0/power(-e)
                           | otherwise = fromInteger (10^e)


-- R417
complex_literal_constant =

  parens $
  real_part                     >>= \(RealLit _ r k1) ->
  comma                         >>
  imag_part                     >>= \(RealLit _ c k2) ->
  if k1 /= k2
   then error "grammar.hs:complex_literal_constant: inequal kinds."
   else return $ CmplxLit [] (r,c) k1


-- R418
real_part :: CharParser SmT Lit
real_part = signed_real_literal_constant


-- R419
imag_part :: CharParser SmT Lit
imag_part = signed_real_literal_constant


-- R420
char_literal_constant :: CharParser SmT Lit
char_literal_constant =

 do k <- option Nothing $ kind_param >>= \k ->
                          reservedOp "_" >> (return $ Just $ VarName [] k)
    s <- str_lit
    return $ CharLit [] s (CharType [] k Nothing)


-- R421
logical_literal_constant :: CharParser SmT Lit
logical_literal_constant =

 lexeme $
 do char '.'
    l <- choice [nocase "TRUE."  >> return True,
                 nocase "FALSE." >> return False]
    k <- option Nothing $ char '_' >>
         kind_param >>= return . Just . VarName []
    return $ BoolLit [] l (LogicalType [] k)

-- R601
variable :: CharParser SmT Prim
variable =

  choice [
--    try subobject,
    scalar_variable_name >>= return . VarName [],
    array_variable_name  >>= return . VarName []
    ]


-- R603
logical_variable = variable


-- R604
default_logical_variable = variable


-- R605
char_variable = variable


-- R607
int_variable = variable


-- R608
default_int_variable = variable


-- R609
substring :: CharParser SmT Prim
substring =

 do p <- parent_string
    let ds = case p of (UnknownComp _ ds _) -> ds
                       x@(VarName _ n)  -> [(x,[])]
    s <- parens substring_range
    return $ UnknownComp [] ds (Just s)
--    return $ Substring p r


-- R610
parent_string :: CharParser SmT Prim
parent_string =

  choice [
--    try $ array_element >>= \ae -> lookAhead (reservedOp "(") >> return ae,
    try array_element,
--    try scalar_structure_component,
    scalar_variable_name >>= return . VarName []
    ]


-- R611
substring_range :: CharParser SmT Subscript
substring_range =

 do l <- option Nothing $ scalar_int_expr >>= return . Just
    reservedOp ":"
    u <- option Nothing $ scalar_int_expr >>= return . Just
    return $ SubstrRange [] (l,u)


--R612
data_ref :: CharParser SmT [(Prim,[Subscript])]
data_ref = sepBy1 part_ref $ reservedOp "%"


-- R613
part_ref :: CharParser SmT (Prim,[Subscript])
part_ref =

 do n  <- part_name
    ss <- option [] $ parens section_subscript_list
    return (VarName [] n,ss)

-- R615  Final part_ref contains a non-empty section-subscript_list?
array_element :: CharParser SmT Prim
--array_element = liftM2 UnknownComp data_ref Nothing
--array_element = data_ref >>= \ds -> return $ UnknownComp ds Nothing 
array_element =

 data_ref >>= \ps ->
 if ((snd $ last ps) == [])
   then fail "No section subscript found in array_element."
   else return $ UnknownComp [] ps Nothing
--   else return $ ArrElem ps



-- R616
array_section :: CharParser SmT Prim
array_section =
 do ps <- data_ref
    s  <- option Nothing $ parens substring_range >>= return . Just
    if (((snd $ last ps) == []) && (length ps < 2))
      then fail "Invalid array_section."
      else return $ UnknownComp [] ps s
    --   else return $ ArrSection ps s



-- R617
subscript :: CharParser SmT Subscript
subscript = scalar_int_expr >>= return . Subscript []


-- R618
section_subscript :: CharParser SmT Subscript
section_subscript =

  choice [
    try subscript_triplet,
    subscript,-- >>= \s -> return $ Subscript s,
    vector_subscript -- >>= \v -> return $ SubscriptV v
    ]


-- R619
subscript_triplet :: CharParser SmT Subscript
subscript_triplet =

 do l <- option Nothing $ subscript >>= \(Subscript _ s1) -> return $ Just s1
    reservedOp ":"
    u <- option Nothing $ subscript >>= \(Subscript _ s2) -> return $ Just s2
    s <- option Nothing $ reservedOp ":" >> stride >>= return . Just
    return $ Triplet [] (l,u,s)


-- R620
stride = scalar_int_expr


-- R621
vector_subscript = int_expr >>= return . SubscriptV []


-- R704
defined_unary_op :: CharParser st UOp
defined_unary_op =

  try $
  lexeme $
  do char '.'
     ls <- many1 letter
     let op_names = ["false", "true", "lt", "le", "eq", "ne", "gt", "ge"]
     when (elem ls op_names) $ fail "Invalid operator name."
     char '.'
     return $ DefUOp [] ls


-- R708
power_op :: CharParser st BOp
power_op = reservedOp "**" >> return Expt


-- R709 -- A more complex match for "/" was needed as mult_op was failing on
-- a private module's public::x, operator(/)
-- See also array_constructor's use of (/ and /) e.g. (/1,2/) ... but
-- also remember:   public :: operator (/)
mult_op :: CharParser st BOp
mult_op =

  choice [
    reservedOp "*" >> return Mul,
    reservedOp "/" >> return Div
    ]


-- R710
add_op :: CharParser st BOp
add_op =

  choice [
    reservedOp "+" >> return Add,
    reservedOp "-" >> return Sub
    ]


-- R712
concat_op :: CharParser st BOp
concat_op = reservedOp "//" >> return Concat

-- R714
rel_op :: CharParser st BOp
rel_op =

  choice [
    reservedOp "==" >> return OEq,
    reservedOp "/=" >> return ONeq,
    reservedOp "<"  >> return OLt,
    reservedOp "<=" >> return OLtoe,
    reservedOp ">"  >> return OGt,
    reservedOp ">=" >> return OGtoe
    ]


-- R719
not_op :: CharParser st UOp
not_op = reservedOp ".NOT." >> return Not


-- R720
and_op :: CharParser st BOp
and_op = reservedOp ".AND." >> return And


-- R721
or_op :: CharParser st BOp
or_op = reservedOp ".OR." >> return Or


-- R722
equiv_op :: CharParser st BOp
equiv_op =

  choice [
    reservedOp ".EQV." >> return Eqv,
    reservedOp ".NEQV." >> return Neqv
    ]


-- R703,R705,R706,R707,R711,R713,R715,
-- R716,R717,R718,R723,R724 are all represented 
-- by the following use of Parsec's buildExpressionParser
-- See F Book - Page 40 for the precedence used.
-- "The rules of F state that the parts of expressions without parentheses
--  are evaluated successively from left to right for operators of equal
--  precedence, with the exception of **" - F Book - Page 30

-- R723
expr :: CharParser SmT Expr
expr = buildExpressionParser table primary <?> "expression"

table = [ [opP defined_unary_op ],
          [opR power_op         ],
          [opL mult_op'         ],
          [opP add_op'          ],
          [opL add_op           ],
          [opL concat_op        ],
          [opL rel_op           ],
          [opP not_op           ],
          [opL and_op           ],
          [opL or_op            ],
          [opL equiv_op         ],
          [opL defined_binary_op]
        ]
 where
   opL p   = Infix  (p >>= \o -> return $ BExpr [] o) AssocLeft
   opR p   = Infix  (p >>= \o -> return $ BExpr [] o) AssocRight
   opP p   = Prefix (p >>= \o -> return $ UExpr [] o)
   add_op' = add_op >>= \o -> case o of Add -> return Plus
                                        Sub -> return Minus
   mult_op' = try $ mult_op >>= \mo -> notFollowedBy' (char ')') >> return mo


-- R701
primary :: CharParser SmT Expr
primary =

  choice [
--    try $ liftM (ExprPrim []) function_reference,
--    try $ liftM (ExprPrim []) structure_constructor,
--    array_constructor,
    try intrinsic_call,
    try array_index,
    liftM (ExprPrim []) variable, -- contains subobject, which contains structure_component
    constant,    
--    liftM (ExprPrim []) constant_subobject,
    parens expr
    ]

intrinsic_call = do
    vname <- intrinsic_procedure_name
    idx_exprs <- parens (commaSep expr)
    return $ IntrinsicCall [] vname idx_exprs

array_index = do
    vname <- variable 
    idx_exprs <- parens (commaSep expr)
    return $ ArrayIdx [] vname idx_exprs

-- R724 specified as defined_op (defined-op) in the grammar
defined_binary_op :: CharParser st BOp
defined_binary_op =

  try    $
  lexeme $
  do char '.'
     ls <- many1 letter
     let op_names = ["false", "true", "lt", "le", "eq", "ne", "gt", "ge"]
     when (elem ls op_names) $ fail "Invalid operator name."
     char '.'
     return $ DefBOp [] ls


-- R725
logical_expr = expr

-- R726
char_expr = expr

-- R728
int_expr = expr

-- R729
numeric_expr = expr

-- R730
initialization_expr = expr

-- R731
char_initialization_expr = char_expr

-- R732
int_initialization_expr = int_expr

-- R733
logical_initialization_expr = logical_expr

-- R734
specification_expr = scalar_int_expr

-- R735
assignment_stmt :: CharParser SmT ExecStmt
assignment_stmt =

 do v <- try $ variable >>= \v -> reservedOp "=" >> return v
    e <- expr
    newlines1
    return $ AssignStmt [] v e



-- R737
-- target :: CharParser SmT Expr
target :: CharParser SmT Prim
target =

  choice [
--    variable >>= \n -> getState >>= \s -> return $ Var $ getVarInfo s n,
--    variable >>= return . ExprPrim,
--    try $ function_reference,
    variable
--    expr,
--    liftM (ExprPrim []) variable
--    expr -- Bad ordered version, never reached.
    ]


-- R743
mask_expr = logical_expr

-- R924
-- PGK Detour here: full info for all var exprs; using state etc.
inquire_spec :: CharParser SmT (String,Expr)
--inquire_spec :: CharParser SmT (String,Prim)
inquire_spec = 

  choice [
    aEqualsB "IOSTAT"      scalar_default_int_variable,
    aEqualsB "EXIST"       scalar_default_logical_variable,
    aEqualsB "EXIST"       scalar_default_logical_variable,
    aEqualsB "OPENED"      scalar_default_logical_variable,
    aEqualsB "NUMBER"      scalar_default_int_variable,
    aEqualsB "NAMED"       scalar_default_logical_variable,
    aEqualsB "NAME"        scalar_char_variable,
    aEqualsB "ACCESS"      scalar_char_variable,
    aEqualsB "SEQUENTIAL"  scalar_char_variable,
    aEqualsB "DIRECT"      scalar_char_variable,
    aEqualsB "FORM"        scalar_char_variable,
    aEqualsB "FORMATTED"   scalar_char_variable,
    aEqualsB "UNFORMATTED" scalar_char_variable,
    aEqualsB "RECL"        scalar_default_int_variable,
    aEqualsB "NEXTREC"     scalar_default_int_variable,
    aEqualsB "POSITION"    scalar_char_variable,
    aEqualsB "ACTION"      scalar_char_variable,
    aEqualsB "READ"        scalar_char_variable,
    aEqualsB "WRITE"       scalar_char_variable,
    aEqualsB "READWRITE"   scalar_char_variable
    ]
{-

-- R1001  This rule doesn't exist in F
--format_stmt = reserved "FORMAT" >> format_specification


-- R1002  Unused, due to the non-existence of R1001
format_specification = parens $ option [] format_item_list


-- R1003
format_item :: CharParser st Lit
format_item =

  choice [
    do option NullLit r
       choice [
         data_edit_desc,
         parens format_item_list >> return NullLit
         ],
    control_edit_desc
    ]


-- R1004
r = int_literal_constant


-- R1005
data_edit_desc :: CharParser st Lit
data_edit_desc =

  choice [
    reserved "I" >> w >> option NullLit (reservedOp "." >> m),
    reserved "F" >>  w >> reservedOp "." >> d,
    reserved "EN" >> w >> reservedOp "." >> d >> option NullLit
                                                        (reserved "E" >> e),
    reserved "ES" >> w >> reservedOp "." >> d >> option NullLit
                                                        (reserved "E" >> e),
    reserved "L" >>  w,
    reserved "A" >>  option NullLit w
    ]


-- R1006
w = int_literal_constant


-- R1007
m = int_literal_constant


-- R1008
d = int_literal_constant


-- R1009
e = int_literal_constant


-- R1010
control_edit_desc =

  choice [
    position_edit_desc,
    option NullLit r >> reservedOp "/" >> return NullLit,
    colon >> return NullLit,
    sign_edit_desc >> return NullLit
    ]


-- R1012
position_edit_desc =

  choice [
    reserved "TL" >> n,
    reserved "TR" >> n,
    reserved "T"  >> n
    ]


-- R1013
n = int_literal_constant


-- R1014
sign_edit_desc =

  choice [
    reserved "SP",
    reserved "SS",
    reserved "S"
    ]
-}
-- R1298
intrinsic_procedure_name :: CharParser SmT Name
intrinsic_procedure_name

 = choice [
     reserved "ABS",
     reserved "ACOS",
     reserved "ADJUSTL",
     reserved "ADJUSTR",
     reserved "AIMAG",
     reserved "AINT",
     reserved "ALL",
     reserved "ALLOCATED",
     reserved "ANINT",
     reserved "ANY",
     reserved "ASIN",
     reserved "ASSOCIATED",
     reserved "ATAN",
     reserved "ATAN2",
     reserved "BIT_SIZE",
     reserved "BTEST",
     reserved "CEILING",
     reserved "CHAR",
     reserved "CMPLX",
     reserved "CONJG",
     reserved "COS",
     reserved "COSH",
     reserved "COUNT",
     reserved "CPU_TIME",
     reserved "CSHIFT",
     reserved "DATE_AND_TIME",
     reserved "DIGITS",
     reserved "DOT_PRODUCT",
     reserved "EOSHIFT",
     reserved "EPSILON",
     reserved "EXP",
     reserved "EXPONENT",
     reserved "FLOOR",
     reserved "FRACTION",
     reserved "GET_COMMAND_ARGUMENT", -- F2003 Extension
     reserved "HUGE",
     reserved "IAND",
     reserved "IBCLR",
     reserved "IBITS",
     reserved "IBSET",
     reserved "ICHAR",
     reserved "IEOR",
     reserved "INDEX",
     reserved "INT",
     reserved "IOR",
     reserved "ISHFT",
     reserved "ISHFTC",
     reserved "KIND",
     reserved "LBOUND",
     reserved "LEN",
     reserved "LEN_TRIM",
     reserved "LOG",
     reserved "LOG10",
     reserved "LOGICAL",
     reserved "MATMUL",
     reserved "MAX",
     reserved "MAXEXPONENT",
     reserved "MAXLOC",
     reserved "MAXVAL",
     reserved "MERGE",
     reserved "MIN",
     reserved "MINEXPONENT",
     reserved "MINLOC",
     reserved "MINVAL",
     reserved "MODULO",
     reserved "MVBITS",
     reserved "NEAREST",
     reserved "NINT",
     reserved "NOT",
     reserved "NULL",
     reserved "PACK",
     reserved "PRECISION",
     reserved "PRESENT",
     reserved "PRODUCT",
     reserved "RADIX",
     reserved "RANDOM_NUMBER",
     reserved "RANDOM_SEED",
     reserved "RANGE",
     reserved "REAL",
     reserved "REPEAT",
     reserved "RESHAPE",
     reserved "RRSPACING",
     reserved "SCALE",
     reserved "SCAN",
     reserved "SELECTED_INT_KIND",
     reserved "SELECTED_REAL_KIND",
     reserved "SET_EXPONENT",
     reserved "SHAPE",
     reserved "SIGN",
     reserved "SIN",
     reserved "SINH",
     reserved "SIZE",
     reserved "SPACING",
     reserved "SPREAD",
     reserved "SQRT",
     reserved "SUM",
     reserved "SYSTEM_CLOCK",
     reserved "TAN",
     reserved "TANH",
     reserved "TINY",
     reserved "TRANSPOSE",
     reserved "TRIM",
     reserved "UBOUND",
     reserved "UNPACK",
     reserved "VERIFY"
     ]

{--
-- R1210
function_reference :: CharParser SmT Prim
function_reference =

 do n  <- function_name
    as <- parens $ option [] actual_arg_spec_list
    notFollowedBy' $ oneOf "%(" -- Guards against character Substrings
    return $ UnknownApp [] n as


-- R1211
call_stmt :: CharParser SmT ExecStmt
call_stmt =

 do reserved "CALL"
    n  <- subroutine_name
    as <- parens $ option [] actual_arg_spec_list
    newlines1
    return $ CallStmt [] n as
--}

-- Note the "try" in R1212 covers only "keyword=", not the entire "option ..." 
-- Otherwise, a string "var" will match "keyword", then fail
-- on "reservedOp". The empty "option [] ..." would then parse successfully,
-- leaving the enclosing "try" happy, and in no mood for backtracking.

-- R1212
actual_arg_spec :: CharParser SmT (Maybe Name,Expr)
actual_arg_spec =

 do k <- option Nothing $ try $ keyword >>= \k ->
         reservedOp "=" >> (return $ Just k)
    a <- actual_arg
    return (k,a)


-- R1213
keyword = dummy_arg_name


-- R1214   n.b. variable and procedure_name are identical. Context sensitive.
actual_arg :: CharParser SmT Expr
actual_arg =

  choice [
    expr,
    liftM (ExprPrim []) variable,
    liftM (ExprPrim [] . VarName []) procedure_name
--    Previously:
--    variable >>= return . ExprPrim,
--    procedure_name >>= \n -> return $ ExprPrim $ VarName n
    ]

{--
-- R1226
return_stmt :: CharParser SmT ExecStmt
return_stmt = reserved "RETURN"   >> newlines1 >> return ReturnStmt


-- R1227
contains_stmt :: CharParser SmT ()
contains_stmt = reserved "CONTAINS" >> newlines1 >> return () -- >> return ContainsStmt

--}
-----------------------------------------------------------
-- The scalar productions
-----------------------------------------------------------

scalar_int_expr                 = int_expr
scalar_char_expr                = char_expr
scalar_logical_expr             = logical_expr
scalar_int_initialization_expr  = int_initialization_expr
scalar_char_initialization_expr = char_initialization_expr
scalar_variable_name            = variable_name
scalar_int_variable             = int_variable
scalar_default_int_variable     = liftM (ExprPrim []) default_int_variable
scalar_default_logical_variable = liftM (ExprPrim []) default_logical_variable
scalar_char_variable            = liftM (ExprPrim []) char_variable

-----------------------------------------------------------
-- The names
-----------------------------------------------------------

module_name :: CharParser st String
module_name              = identifier
local_name               = identifier
use_name                 = identifier
program_name             = identifier
scalar_int_constant_name = identifier
type_name                = identifier
object_name              = identifier
function_name            = identifier
dummy_arg_name           = identifier
procedure_name           = identifier
subroutine_name          = identifier
array_variable_name      = identifier
variable_name            = identifier
do_construct_name        = identifier
block_construct_name     = identifier
part_name                = identifier
result_name              = identifier
generic_name             = identifier
component_name           = identifier

-----------------------------------------------------------
-- The lists
-----------------------------------------------------------

intrinsic_procedure_name_list = commaSep1 intrinsic_procedure_name
procedure_name_list           = commaSep1 procedure_name
section_subscript_list        = commaSep1 section_subscript
dummy_arg_name_list           = commaSep1 dummy_arg_name
expr_list                     = commaSep1 expr

