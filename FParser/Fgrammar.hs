module Fgrammar where

import Prelude hiding (significand, exponent)
import Text.ParserCombinators.Parsec hiding (label,sepBy,sepBy1,newline)
import Text.ParserCombinators.Parsec.Expr
import Text.ParserCombinators.Parsec.Combinator(lookAhead)
import Futil hiding (sign)
-- import Fast
import ParseTree
import SymbolTable
import Control.Monad(ap,liftM,liftM2,when)
import Data.List(genericLength)
import Debug.Trace

-- :m +Text.ParserCombinators.Parsec
-- print $ runParser (string "test") [] "" "test"
      
-- R201
program :: CharParser SmT Program
program =

 do whiteSpace
    newlines
    p  <- program_unit
    ps <- many program_unit
    eof
    return $ Program p ps

--program :: CharParser SmT Program
--program =  whiteSpace              >>= \_  ->
--           newlines                >>= \_  ->
--           program_unit            >>= \p  ->
--           many program_unit       >>= \ps ->
--           eof                     >>= \_  ->
--           (return $ Program p ps)


-- R202
program_unit :: CharParser SmT ProgUnit
program_unit =

 choice [
   main_program,
   module_
   ]


-- R1101
main_program :: CharParser SmT ProgUnit
main_program =

 do n1 <- program_stmt
    us <- many $ parD use_stmt
    ms <- many $ parD main_specification
    e  <- execution_part
    n2 <- end_program_stmt

    return $ MainProg [] (n1,n2) (us ++ ms) e


-- R1102
program_stmt :: CharParser SmT Name
program_stmt =

 do reserved "PROGRAM"
    n <- program_name
    newlines1
    return n


-- R1103
end_program_stmt :: CharParser SmT Name 
end_program_stmt =

 do gapped "END" "PROGRAM"
    n <- program_name
    newlines1 -- Always at a file's end
    return n


-- R1103x
main_specification :: CharParser SmT SpecStmt
main_specification =

  choice [
    type_declaration_stmt,
    intrinsic_stmt
    ]


-- R1104w
module_ =

  choice [
    try public_module,
    private_module
    ]


-- R1104x
public_module =

 do n1 <- module_stmt
    us <- many $ parD use_stmt
    reserved "PUBLIC"
    newlines1
    n2 <- end_module_stmt
    return $ PublicMod [] (n1,n2) us


-- R1104y
private_module =

 do n1 <- module_stmt
    us <- many $ parD use_stmt

    p  <- option [] $ liftM (:[]) $ try $ parD private_stmt
--    p  <- option [] $ try $ reserved "PRIVATE" >> newlines1 >> return [PSpecStmt PrivStmt False]
--    setState []
    ms <- many $ parD module_specification
    s  <- option [] subprogram_part
    n2 <- end_module_stmt
    return $ PrivateMod [] (n1,n2) (us ++ p ++ ms) s


-- R1105
module_stmt :: CharParser SmT Name
module_stmt =

 do reserved "MODULE"  --    >>
    n <- module_name   --        >>= \n ->
    newlines1           --   >> 
    return n


-- R1106
end_module_stmt :: CharParser SmT Name
end_module_stmt =

 do gapped "END" "MODULE" -- >>
    n <- module_name      --      >>= \n ->
    newlines1              -- >>
    return n


-- R1106x
module_specification :: CharParser SmT SpecStmt
module_specification =

  choice [
    access_stmt,
    derived_type_def,
    type_declaration_stmt,
    module_procedure_interface_block,
    intrinsic_stmt
    ]


-- R212
subprogram_part :: CharParser SmT [SubProg]
subprogram_part =

 do contains_stmt
    many1 subprogram


-- R213
subprogram :: CharParser SmT SubProg
subprogram =

  choice [
    try function_subprogram,
    subroutine_subprogram
    ]


-- R1216
function_subprogram :: CharParser SmT SubProg
function_subprogram =

 do (pfxs,n1,args,r) <- function_stmt
    us  <- many $ parD use_stmt
--    setState []
    ps  <- many $ parD procedure_specification
    e   <- execution_part
    n2  <- end_function_stmt
    return $ FuncSubProg [] False (n1,n2) (us ++ ps) e pfxs args r


-- R1221
subroutine_subprogram :: CharParser SmT SubProg
subroutine_subprogram =

 do (pfxs,n1,args) <- subroutine_stmt
    us  <- many $ parD use_stmt
    ps  <- many $ parD procedure_specification
    e   <- execution_part
    n2  <- end_subroutine_stmt
    return $ SubrSubProg [] False (n1,n2) (us ++ ps) e pfxs args


-- R1221x
procedure_specification :: CharParser SmT SpecStmt 
procedure_specification =

 choice [
   type_declaration_stmt,
   intrinsic_stmt,
   dummy_procedure_interface_block, -- dummy_interface_block in f grammar
   optional_stmt
   ]


-- R1217
function_stmt :: CharParser SmT ([AttrSpec],Name,[Name],Prim)
function_stmt =

 do pfxs <- many prefix
    reserved "FUNCTION"
    n <- function_name
    args <- parens $ option [] dummy_arg_name_list
    reserved "RESULT"
    r <- liftM (UnknownName []) $ parens result_name
    newlines1
    return (pfxs,n,args,r) -- $ FuncStmt ps n as r


-- R1218
prefix :: CharParser SmT AttrSpec -- Better as 3 new AttrSpecs?
prefix =

  choice [
    reserved "RECURSIVE" >> return RecursiveSpec,
    reserved "ELEMENTAL" >> return ElementalSpec,
    reserved "PURE"      >> return PureSpec
    ]


-- R1220
end_function_stmt :: CharParser SmT Name -- Stmt
end_function_stmt =

 do gapped "END" "FUNCTION"
    n <- function_name
    newlines1
    return n


-- R1222
subroutine_stmt :: CharParser SmT ([AttrSpec],Name,[String])
subroutine_stmt =

 do ps <- many prefix
    reserved "SUBROUTINE"
    n <- subroutine_name
    as <- parens $ option [] dummy_arg_name_list
    newlines1
    return (ps,n,as) -- $ SubrStmt ps n as


-- R1224
end_subroutine_stmt :: CharParser SmT Name -- Stmt
end_subroutine_stmt =

 do gapped "END" "SUBROUTINE"
    n <- subroutine_name
    newlines1
    return n


-- R208
execution_part :: CharParser SmT [PExecStmt]
execution_part = many $ parE executable_construct

-- "nopar" extension indicates enclosed array expressions execute in SERIAL.
-- The try is needed if the first post-declaration statement is nopar. e.g:
-- real, dimension(4) :: x,y
-- nopar x = y
parD d  = try $ do p <- option True $ reserved "NOPAR" >> return False
                   d' <- d
                   return $ PSpecStmt p d'

parE ec = do p <- option True $ reserved "NOPAR" >> return False
             ec' <- ec
             return $ PExecStmt p ec'


-- R215 -- Ensure the start of each construct is distinct!
executable_construct :: CharParser SmT ExecStmt 
executable_construct =

 choice [
   action_stmt,
   liftM (ControlStmt []) case_construct,
   liftM (ControlStmt []) do_construct,
   liftM (ControlStmt []) forall_construct,
   liftM (ControlStmt []) if_construct,
   liftM (ControlStmt []) where_construct,
   liftM (ControlStmt []) block_construct  -- (Draft) Fortran 2008
   ]

-- R216
action_stmt :: CharParser SmT ExecStmt
action_stmt =

  choice [
    allocate_stmt,
    assignment_stmt,
    liftM (IOStmt []) backspace_stmt,
    call_stmt,
    liftM (IOStmt []) close_stmt,
    liftM (ControlStmt []) cycle_stmt,
    deallocate_stmt,
    liftM (IOStmt []) endfile_stmt,
    liftM (ControlStmt []) exit_stmt,
    liftM (IOStmt []) inquire_stmt,
    liftM (IOStmt []) open_stmt,
    pointer_assignment_stmt,
    liftM (IOStmt []) print_stmt,
    liftM (IOStmt []) read_stmt,
    return_stmt,
    liftM (IOStmt []) rewind_stmt,
    liftM (ControlStmt []) stop_stmt,
    liftM (IOStmt []) write_stmt
    ]


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
named_constant = name >>= \n -> return $ UnknownName [] n


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
                reservedOp "_" >> kind_param >>= return . Just . UnknownName []
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
                reservedOp "_" >> kind_param >>= return . Just . UnknownName []
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
                          reservedOp "_" >> (return $ Just $ UnknownName [] k)
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
         kind_param >>= return . Just . UnknownName []
    return $ BoolLit [] l (LogicalType [] k)





-- R423
derived_type_stmt :: CharParser SmT (AttrSpec,Name)
derived_type_stmt =

 do reserved "TYPE"
    comma
    a <- access_spec
    reservedOp "::"
    n <- type_name
    newlines1
    return (a,n)


-- R424
private_stmt :: CharParser SmT SpecStmt
private_stmt =

 do reserved "PRIVATE"
    newlines1
    return PrivStmt


-- R425
component_def_stmt :: CharParser SmT SpecStmt
component_def_stmt =

 do t <- type_spec
    as <- option [] $ comma >> component_attr_spec_list
    reservedOp "::"
    ns <- component_decl_list
    newlines1
    return $ TypeDeclStmt [] t as [(n,Nothing) | n <- ns]


-- R426
component_attr_spec :: CharParser SmT AttrSpec
component_attr_spec = 

  choice [
    reserved "POINTER" >> return PointerSpec,
    reserved "DIMENSION" >> parens component_array_spec >>=
      return . DimensionSpec []
--PGK:    reserved "ALLOCATABLE" >> return AllocatableSpec
    ]


-- R427
component_array_spec :: CharParser SmT [Subscript] --[(Expr,Expr)]
component_array_spec =

 choice [
   try explicit_shape_spec_list,
   deferred_shape_spec_list
   ]


-- R428
component_decl = component_name

-- R430
end_type_stmt :: CharParser SmT Name--Stmt
end_type_stmt =

 do gapped "END" "TYPE"
    n <- type_name
    newlines1
    return n


-- R431
structure_constructor :: CharParser SmT Prim 
structure_constructor =

 do n  <- type_name
    es <- parens $ expr_list
    notFollowedBy' $ oneOf "%(" -- Guards against character Substrings
    return $ UnknownApp [] n [(Nothing, e) | e <- es]


-- R432
array_constructor :: CharParser SmT Expr -- Prim
array_constructor =

 do reservedOp "(/"
    avs <- ac_value_list
    reservedOp "/)"
    return $ ArrayCtor [] avs


-- R433 Are all expressions like this; never followed by equals?
-- When matched as a list, remove all NullExprs?
ac_value :: CharParser SmT Expr
ac_value =

  choice [
    try $ expr >>= \e -> notFollowedBy' (reservedOp "=") >> return e,
    ac_implied_do
--    try ac_implied_do,
--    expr
    ]


-- R434
ac_implied_do :: CharParser SmT Expr
ac_implied_do =

 parens $
 do acs <- ac_value_list
    comma -- why no comma?
    ic3 <- ac_implied_do_control
    return $ ImpliedDo [] acs ic3


-- R435
ac_implied_do_control :: CharParser SmT (Prim,(Expr,Expr,Maybe Expr))
ac_implied_do_control =

 do i <- ac_do_variable
    reservedOp "="
    l <- scalar_int_expr
    comma
    u <- scalar_int_expr
    s <- option Nothing $ comma >> liftM Just scalar_int_expr
    return (i,(l,u,s))


-- R436
--ac_do_variable :: CharParser SmT VarInfo
ac_do_variable = scalar_int_variable


-- R501
type_declaration_stmt :: CharParser SmT SpecStmt
type_declaration_stmt =

 do t  <- type_spec
    as <- many $ comma >> attr_spec
    reservedOp "::"
    ns <- entity_decl_list
    newlines1
    return $ TypeDeclStmt [] t as ns

{-
    l <- return $ length es
    ts <- return $ replicate l t
    ass <- return $ replicate l as
    (ns,is) <- return $ unzip es
    vs <- return $ zip3 ts ass ns
    updateState (vs ++)
    return $ TypeDeclStmt vs is
-}

-- R502
type_spec :: CharParser SmT Type
type_spec =

  choice [
    reserved "INTEGER"   >>
      option Nothing kind_selector >>= return . IntType [],
    reserved "REAL"      >>
      option Nothing kind_selector >>= return . RealType [],
    reserved "CHARACTER" >>
      char_selector                >>= \(l,k) -> return (CharType [] k l),
    reserved "COMPLEX"   >>
      option Nothing kind_selector >>= return . CmplxType [],
    reserved "LOGICAL"   >>
      option Nothing kind_selector >>= return . LogicalType [],
    reserved "TYPE"      >>
      parens type_name             >>= return . DerivedType []
    ]

  <?> "type_spec"

-- WV: Should add kind  

-- R503
attr_spec :: CharParser SmT AttrSpec
attr_spec =

  choice [
    reserved "PARAMETER"   >> return ParameterSpec,
    access_spec,
    reserved "ALLOCATABLE" >> return AllocatableSpec,
    reserved "DIMENSION"   >> parens array_spec  >>= return . DimensionSpec [],
    reserved "INTENT"      >> parens intent_spec,
    reserved "OPTIONAL"    >> return OptionalSpec,
    reserved "POINTER"     >> return PointerSpec,
    reserved "SAVE"        >> return SaveSpec,
    reserved "TARGET"      >> return TargetSpec
    ]

  <?> "attr_spec"


-- R504
entity_decl :: CharParser SmT (Name,Maybe Expr)
entity_decl =

 do n <- object_name
    i <- option Nothing $ initialization >>= return . Just
    return (n,i)


-- R505
-- function_reference can ONLY be null(), and object-name should
-- have the pointer attribute
initialization :: CharParser SmT Expr
initialization =

  choice [
--    try $ reservedOp "=>" >> function_reference >>= return . ExprPrim,
    reservedOp "=>" >> liftM (ExprPrim []) function_reference,
    reservedOp "="  >> initialization_expr
    ]


-- R506
-- kind_selector =

-- parens $ reserved "KIND" >> reservedOp "=" >> scalar_int_constant_name


-- R506
kind_selector =

 parens $ reserved "KIND" >> reservedOp "=" >> scalar_int_constant_name >>=
 (return . Just . UnknownName [])


-- R507
char_selector :: CharParser SmT (Maybe Expr,Maybe Prim) -- Name)
char_selector =

 parens $
 do reserved "LEN" <?> "len specifier required in char_selector"
    reservedOp "="
    l <- char_len_param_value
    k <- option Nothing $ do comma
                             reserved "KIND"
                             reservedOp "="
                             n <- scalar_int_constant_name
                             return $ Just $ UnknownName [] n
    return (l,k)


-- R510
char_len_param_value :: CharParser SmT (Maybe Expr)
char_len_param_value =

  choice [
    specification_expr >>= return . Just,
    reservedOp "*"     >>  return Nothing -- LengthStarIntExpr
    ]


-- R511
-- "reserved" stops this from failing with 'private'; the first 'p' is common
access_spec :: CharParser st AttrSpec
access_spec =

  choice [
    reserved "PUBLIC"  >> return PublicSpec,
    reserved "PRIVATE" >> return PrivateSpec
    ]


-- R512
{-intent_spec = do { try ( reserved "INOUT" ); return InOut }
          <|> do { i <- option () $ reserved "IN"
                 ; o <- option () $ reserved "OUT"
                 }
          <?> "intent_spec"
-}
-- R512
intent_spec :: CharParser st AttrSpec
intent_spec =

  choice [
    try ( gapped "IN" "OUT" ) >> return IntentInOutSpec,
    reserved "IN" >> return IntentInSpec,
    reserved "OUT" >> return IntentOutSpec
    ]


-- R513
-- The ambiguity in: array_spec ":" seems to resolve to the "first" match
-- in the list below; i.e. assumed_shape_spec_list
array_spec :: CharParser SmT [Subscript] -- (Expr,Expr)]
array_spec =

  choice [
    try explicit_shape_spec_list,
    try assumed_shape_spec_list,
    try deferred_shape_spec_list
    ]


-- R514
explicit_shape_spec :: CharParser SmT Subscript -- (Expr,Expr)
explicit_shape_spec =

 do l <- option Nothing $
           try $ lower_bound >>= \e -> reservedOp ":" >> (return $ Just e)
    u <- upper_bound >>= return . Just
    return $ Shape [] (l,u)


-- R515
lower_bound = specification_expr


-- R516
upper_bound = specification_expr


-- R517
assumed_shape_spec :: CharParser SmT Subscript --(Expr,Expr)
assumed_shape_spec =

 do l <- option Nothing $ lower_bound >>= return . Just
    reservedOp ":"
    return $ Shape [] (l,Nothing)


-- R518
deferred_shape_spec :: CharParser st Subscript --(Expr,Expr)
deferred_shape_spec =

 do reservedOp ":"
    return $ Shape [] (Nothing,Nothing)


-- R521
optional_stmt :: CharParser SmT SpecStmt
optional_stmt =

 do reserved "OPTIONAL"
    reservedOp "::"
    ns <- dummy_arg_name_list
    newlines1
    return $ OptionalStmt [] ns


-- R522
access_stmt :: CharParser st SpecStmt
access_stmt =

 do a <- access_spec
    reservedOp "::"
    as <- access_id_list
    newlines1
    return $ AccessStmt [] a as


-- R523
access_id :: CharParser st GenSpec
access_id =

  choice [
    generic_spec,
    local_name >>= return . LocalName []
    ]


-- R601
variable :: CharParser SmT Prim
variable =

  choice [
    try subobject,
    scalar_variable_name >>= return . UnknownName [],
    array_variable_name  >>= return . UnknownName []
    ]


-- R602
-- Is 'try' needed here as it was above, in 'variable'?
subobject :: CharParser SmT Prim
subobject =

  choice [
    try substring,
    try array_element,
    try array_section,
    structure_component
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
                       x@(UnknownName _ n)  -> [(x,[])]
    s <- parens substring_range
    return $ UnknownComp [] ds (Just s)
--    return $ Substring p r


-- R610
parent_string :: CharParser SmT Prim
parent_string =

  choice [
--    try $ array_element >>= \ae -> lookAhead (reservedOp "(") >> return ae,
    try array_element,
    try scalar_structure_component,
    scalar_variable_name >>= return . UnknownName []
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
    return (UnknownName [] n,ss)


-- R614
structure_component :: CharParser SmT Prim
--structure_component = liftM StructComp data_ref
--structure_component = data_ref >>= \ds -> return $ UnknownComp ds Nothing 
-- This is too keen, and the rightmost part-ref grabs the last subscript_list...
-- See the constraint below. try, fail, and count could fix this.
-- Or the commented code below could kick things off. Beware though. A lot of
-- places expect the last of a list of [(_,ss)] to contain the final subscripts,
-- as opposed to any (Just Subscript), or even [Subscript].
structure_component =

 data_ref >>= \ps ->
 if (length ps < 2)
   then fail "Invalid structure_component."
   else return $ UnknownComp [] ps Nothing
   
{-   else case reverse ps of
               ((p,ss@(_:_)):rest) ->
                    return $ UnknownComp [] (reverse $ (p,[]):rest) (Just ss) 
               _ -> return $ UnknownComp [] ps                      Nothing
-}
--structure_component = data_ref >>= return . StructComp
--structure_component = (sepBy2 part_ref $ reservedOp "%") >>= return . StructComp

-- Constraint: In a structure-component, there shall be more than one
-- part-ref and the rightmost part-ref shall be of the form part-name.


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

{- do ps <- data_ref
    s  <- option Nothing $ parens substring_range >>= return . Just
    return $ UnknownComp ps s
-}

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


-- R622
allocate_stmt :: CharParser SmT ExecStmt
allocate_stmt =

 do reserved "ALLOCATE"
    (as,v) <- parens $ do as <- allocation_list
                          v  <- option Nothing $ do comma
                                                    reserved "STAT"
                                                    reservedOp "="
                                                    v1 <- stat_variable
                                                    return $ Just v1
                          return (as,v)
    newlines1
    return $ AllocateStmt [] as v

     where allocation_list = commaSep1 $ try $
                             do a <- allocation
                                notFollowedBy' $ reservedOp "="
                                return a
                                                  

-- R623
--stat_variable :: CharParser SmT VarInfo
stat_variable :: CharParser SmT Prim --Expr
stat_variable = scalar_int_variable


-- R624
allocation :: CharParser SmT (Prim,[(Maybe Expr,Expr)])
allocation =

 do o <- allocate_object
    ss <- option [] $ parens allocate_shape_spec_list
    return (o,ss)


-- R625
allocate_object :: CharParser SmT Prim
allocate_object =

  choice [
    try structure_component,
    variable_name >>= return . UnknownName [] 
    ]


-- R626
allocate_shape_spec :: CharParser SmT (Maybe Expr,Expr)
allocate_shape_spec =

 do l <- option Nothing $ try $
      allocate_lower_bound >>= \l -> reservedOp ":" >> (return $ Just l)
    u <- allocate_upper_bound
    return (l,u)


-- R627
allocate_lower_bound = scalar_int_expr


-- R628
allocate_upper_bound = scalar_int_expr


-- R630
pointer_object =

  choice [
    try structure_component,
    variable_name >>= return . UnknownName []
    ]


-- R631
deallocate_stmt :: CharParser SmT ExecStmt
deallocate_stmt =

 do reserved "DEALLOCATE"
    (as,v) <- parens $ do as <- allocate_object_list
                          v  <- option Nothing $ do comma
                                                    reserved "STAT"
                                                    reservedOp "="
                                                    v1 <- stat_variable
                                                    return $ Just v1
                          return (as,v)
    newlines1
    return $ DeAllocateStmt [] as v

     where allocate_object_list = commaSep1 $ try $
                                  do a <- allocate_object
                                     notFollowedBy' $ reservedOp "="
                                     return a


-- R702
constant_subobject :: CharParser SmT Prim 
constant_subobject = subobject


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
    try $ liftM (ExprPrim []) function_reference,
    try $ liftM (ExprPrim []) structure_constructor,
    array_constructor,
    liftM (ExprPrim []) variable, -- contains subobject, which contains structure_component
    constant,
    liftM (ExprPrim []) constant_subobject,
    parens expr
    ]


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


-- R736
pointer_assignment_stmt :: CharParser SmT ExecStmt
pointer_assignment_stmt =

 do p <- try $ pointer_object >>= \p -> reservedOp "=>" >> return p
    t <- target
    newlines1
    return $ PtrAssignStmt [] p t


-- R737
-- target :: CharParser SmT Expr
target :: CharParser SmT Prim
target =

  choice [
--    variable >>= \n -> getState >>= \s -> return $ Var $ getVarInfo s n,
--    variable >>= return . ExprPrim,
    try $ function_reference,
    variable
--    expr,
--    liftM (ExprPrim []) variable
--    expr -- Bad ordered version, never reached.
    ]


-- R739
where_construct :: CharParser SmT ControlStmt
where_construct = try $ do reserved "WHERE"
                           e <- parens mask_expr
                           newlines1
                           as  <- many $ parE assignment_stmt
                           eas <- many $ do e1 <- try $ do reserved "ELSEWHERE"
                                                           parens mask_expr
                                            newlines1
                                            as1 <- many $ parE assignment_stmt
                                            return (e1,as1)
                           as2 <- option [] $ do reserved "ELSEWHERE"
                                                 newlines1
                                                 many $ parE assignment_stmt
                           gapped "END" "WHERE"
                           newlines1
                           return $ WhereCons [] (e,as) eas as2


-- R743
mask_expr = logical_expr


-- R747
-- Why not: option NullExpr $ comma >> scalar_logical_expr
forall_construct :: CharParser SmT ControlStmt
forall_construct =

 do reserved "FORALL"
    (ic3s,e) <- parens $ do ics <- forall_triplet_spec_list
                            e <- option Nothing $
                                 comma >> scalar_logical_expr >>= return . Just
                            return (ics,e)
    newlines1
    b <- many $ parE forall_body_construct
    gapped1 "END" "FORALL"
    newlines1
    return $ ForAll [] ic3s e b

  where forall_triplet_spec_list = commaSep1 $ try forall_triplet_spec


-- R750
forall_triplet_spec :: CharParser SmT (Prim,(Expr,Expr,Maybe Expr))
forall_triplet_spec =

 do i <- index_name
    reservedOp "="
    l <- scalar_int_expr
    colon
    u <- scalar_int_expr
    s <- option Nothing $ colon >> scalar_int_expr >>= return . Just
    return (i,(l,u,s))

  where index_name = variable --identifier


-- R751
forall_body_construct :: CharParser SmT ExecStmt
forall_body_construct =

  choice [
    assignment_stmt,
    pointer_assignment_stmt,
    forall_construct >>= return . ControlStmt [],
    where_construct  >>= return . ControlStmt []
    ]


-- R801
block :: CharParser SmT [PExecStmt]
block = many $ parE executable_construct


-- R802
if_construct :: CharParser SmT ControlStmt
if_construct =

 try $
 do reserved "IF"
    e1 <- parens scalar_logical_expr
    reserved "THEN"
    newlines1
    b1 <- block
    ebs <- many $ do try $ gapped "ELSE" "IF"
                     e2 <- parens scalar_logical_expr
                     reserved "THEN"
                     newlines1
                     b2 <- block
                     return (e2,b2)
    b <- option Nothing $ reserved "ELSE" >> newlines1 >> liftM Just block
    gapped "END" "IF"
    newlines1
    return $ IfCons [] ((e1,b1):ebs) b

-- R807  (Proposed for Fortran 2008)
block_construct :: CharParser SmT ControlStmt
block_construct =

 do n <- option [] $ try $ block_construct_name >>= \n -> colon >> return n
    reserved "BLOCK"
    us <- many $ parD use_stmt
    ms <- many $ parD main_specification
    b  <- block
    gapped "END" "BLOCK"
    n1 <- option [] block_construct_name
    newlines1
    return $ BlockCons [] n (us ++ ms) b


-- R808
case_construct :: CharParser SmT ControlStmt
case_construct =

 do try $ gapped "SELECT" "CASE"
    e <- parens case_expr
    newlines1
    cbs <- many $ try $ reserved "CASE" >> case_selector >>= \c ->
                                           newlines1 >>
                                           block >>= \b ->
                                           return (c,b)
    b <- option Nothing $ gapped1 "CASE" "DEFAULT" >>
                          newlines1 >>
                          liftM Just block
    gapped "END" "SELECT"
    newlines1
    return $ CaseCons [] e cbs b


-- R812
case_expr =

  choice [
    scalar_int_expr,
    scalar_char_expr
    ]


-- R813
case_selector :: CharParser SmT [(Maybe Expr,String,Maybe Expr)]
case_selector = parens case_value_range_list


-- R814
case_value_range :: CharParser SmT (Maybe Expr,String,Maybe Expr)
case_value_range =

  choice [
    do l <- liftM Just case_value
       c <- option [] $ reservedOp ":" >> return ":"
       u <- option Nothing $ liftM Just case_value
       return (l,c,u),
    reservedOp ":" >> case_value >>= \u -> return (Nothing,":",Just u)
    ]


-- R815
case_value :: CharParser SmT Expr
case_value =

  choice [
    scalar_int_initialization_expr,
    scalar_char_initialization_expr
    ]


-- R816
do_construct :: CharParser SmT ControlStmt
do_construct =

 do n <- option [] $ try $ do_construct_name >>= \n -> colon >> return n
    reserved "DO"
    ic3 <- option Nothing $ liftM Just loop_control
    newlines1
    b <- block
    gapped "END" "DO"
    n1 <- option [] do_construct_name
    newlines1
    return $ DoCons [] n ic3 b


-- R821
loop_control :: CharParser SmT (Prim,(Expr,Expr,Maybe Expr))
loop_control =

 do i <- do_stmt_variable
    reservedOp "="
    l <- scalar_int_expr
    comma
    u <- scalar_int_expr
    s <- option Nothing $ comma >> liftM Just scalar_int_expr
    return (i,(l,u,s))


-- R822
--do_stmt_variable :: CharParser SmT VarInfo
do_stmt_variable = scalar_int_variable


-- R834
cycle_stmt =

 do reserved "CYCLE"
    n <- option [] do_construct_name
    newlines1
    return $ CycleStmt [] n


-- R835
exit_stmt =

 do reserved "EXIT"
    n <- option [] do_construct_name
    newlines1
    return $ ExitStmt [] n


-- R840
stop_stmt :: CharParser SmT ControlStmt
stop_stmt = reserved "STOP" >> newlines1 >> return StopStmt


-- R901
io_unit :: CharParser SmT Expr
io_unit =

  choice [
    external_file_unit,
    reservedOp "*" >> return FormatStarCharExpr,
    internal_file_unit 
    ]


-- R902
external_file_unit :: CharParser SmT Expr
external_file_unit = scalar_int_expr


-- R903
internal_file_unit :: CharParser SmT Expr
internal_file_unit = liftM (ExprPrim []) char_variable


-- R904
open_stmt :: CharParser SmT IOStmt
open_stmt =

 do reserved "OPEN"
    cs <- parens connect_spec_list
    newlines1
    return $ OpenStmt [] cs


-- R905
connect_spec :: CharParser SmT (String,Expr)
connect_spec =

  choice [
    aEqualsB "UNIT"     external_file_unit,
    aEqualsB "IOSTAT"   scalar_default_int_variable, 
    aEqualsB "FILE"     file_name_expr,
    aEqualsB "STATUS"   scalar_char_expr,
    aEqualsB "ACCESS"   scalar_char_expr,
    aEqualsB "FORM"     scalar_char_expr,
    aEqualsB "RECL"     scalar_int_expr,
    aEqualsB "POSITION" scalar_char_expr,
    aEqualsB "ACTION"   scalar_char_expr 
    ]


-- R906
file_name_expr = scalar_char_expr


-- R907
close_stmt :: CharParser SmT IOStmt
close_stmt =

 do reserved "CLOSE"
    cs <- parens close_spec_list
    newlines1
    return $ CloseStmt [] cs


-- R908
close_spec :: CharParser SmT (String,Expr)
close_spec =

  choice [
    aEqualsB "UNIT"   external_file_unit,
    aEqualsB "IOSTAT" scalar_default_int_variable,
    aEqualsB "STATUS" scalar_char_expr
    ]


-- R909
read_stmt :: CharParser SmT IOStmt
read_stmt =

  do reserved "READ"
     (f,ios,is) <- choice [
                     do ios <- parens io_control_spec_list
                        is  <- option [] input_item_list
                        return (Nothing,ios,is),

                     do f   <- format 
                        is  <- option [] $ comma >> input_item_list
                        return (Just f,[],is)
                     ]
     newlines1
     return $ ReadStmt [] f ios is


-- R910
write_stmt :: CharParser SmT IOStmt
write_stmt =

  do reserved "WRITE"
     ios <- parens io_control_spec_list
     os  <- option [] output_item_list
     newlines1
     return $ WriteStmt [] ios os


-- R911
print_stmt :: CharParser SmT IOStmt
print_stmt =

 do reserved "PRINT"
    f  <- format
    os <- option [] $ comma >> output_item_list
    newlines1
    return $ PrintStmt [] f os


-- R912
io_control_spec :: CharParser SmT (String,Expr)
io_control_spec =

  choice [
    aEqualsB "UNIT"    io_unit,
    aEqualsB "FMT"     format,
    aEqualsB "REC"     scalar_int_expr,
    aEqualsB "IOSTAT"  scalar_default_int_variable,
    aEqualsB "ADVANCE" scalar_char_expr,
    aEqualsB "SIZE"    scalar_default_int_variable
    ]


-- R913
format =

  choice [
    char_expr,-- This should be parsed (also at runtime) by format_specification
    reservedOp "*" >> return FormatStarCharExpr
    ]


-- R914
input_item = variable

-- R915
output_item = expr

-- R919
backspace_stmt :: CharParser SmT IOStmt
backspace_stmt =

 do reserved "BACKSPACE"
    ps <- parens position_spec_list
    newlines1
    return $ BackSpaceStmt [] ps


-- R920
endfile_stmt :: CharParser SmT IOStmt
endfile_stmt =

 do reserved "ENDFILE"
    ps <- parens position_spec_list
    newlines1
    return $ EndFileStmt [] ps


-- R921
rewind_stmt :: CharParser SmT IOStmt
rewind_stmt =

  do reserved "REWIND"
     ps <- parens position_spec_list
     newlines1
     return $ RewindStmt [] ps


-- R922
position_spec :: CharParser SmT (String,Expr)
position_spec =

  choice [
    aEqualsB "UNIT"   external_file_unit,
    aEqualsB "IOSTAT" scalar_default_int_variable
    ]


-- R923
inquire_stmt :: CharParser SmT IOStmt
inquire_stmt =

 do reserved "INQUIRE" 
    (is,os) <- choice [
                 try $ parens inquire_spec_list >>= \is -> return (is,[]),
                 do i  <- parens $
                          aEqualsB "IOLENGTH" scalar_default_int_variable
                    os <- output_item_list
                    return ([i],os)
                 ]
    newlines1
    return $ InquireStmt [] is os


-- R924
-- PGK Detour here: full info for all var exprs; using state etc.
inquire_spec :: CharParser SmT (String,Expr)
--inquire_spec :: CharParser SmT (String,Prim)
inquire_spec = 

  choice [
    aEqualsB "UNIT"        external_file_unit,
    aEqualsB "FILE"        file_name_expr,
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


-- R1107
use_stmt :: CharParser SmT SpecStmt
use_stmt =

 do reserved "USE"
    n <- module_name
    (o,l) <- option ([],[]) $ comma >> choice [
                                         do o  <- try $ reserved "ONLY" >> colon
                                            ol <- option [] only_list
                                            return (o,ol),
                                         rename_list >>= \rl -> return ([],rl)
                                         ]
    newlines1
    return $ UseStmt [] n o l


-- R1108
rename :: CharParser st GenSpec
rename =

 do ln <- local_name
    reservedOp "=>" -- This isn't an operator
    un <- use_name
    return $ OnlyRename [] ln un


-- R1109
only :: CharParser st GenSpec
only =

  choice [
    try only_rename,
    generic_spec,
    only_use_name
    ]


-- R1110
only_use_name :: CharParser st GenSpec
only_use_name = liftM (OnlyName []) use_name


-- R1111
only_rename :: CharParser st GenSpec
only_rename =

 do ln <- local_name
    reservedOp "=>"
    un <- use_name
    return $ OnlyRename [] ln un


-- R1201
module_procedure_interface_block :: CharParser SmT SpecStmt
module_procedure_interface_block =

 do reserved "INTERFACE"
    g <- generic_spec
    newlines1
    ms <- many1 module_procedure_stmt
    gapped "END" "INTERFACE"
    newlines1
    return $ ModProcIFaceBlock [] g (concat ms)


-- R1206
module_procedure_stmt :: CharParser st [Name] --Stmt
module_procedure_stmt =

 do gapped1 "MODULE" "PROCEDURE"
    ns <- procedure_name_list
    newlines1
    return ns


-- R1207
generic_spec :: CharParser st GenSpec
generic_spec =

  choice [
    try $ reserved "OPERATOR" >> parens defined_operator >>= return . OpSpec [],
    try $ reserved "ASSIGNMENT" >> parens (reservedOp "=") >> return AssignSpec,
    liftM (GenName []) generic_name
    ]


-- R1202
dummy_procedure_interface_block :: CharParser SmT SpecStmt
dummy_procedure_interface_block =

 do reserved "INTERFACE"
    newlines1
    is <- many1 interface_body
    gapped "END" "INTERFACE"
    newlines1
    return $ DummyProcIFaceBlock [] is


-- R1205
--interface_body :: CharParser SmT ((Stmt,Stmt),[Stmt],[Stmt])
interface_body :: CharParser SmT SubProg --((Stmt,Stmt),[Stmt],[Stmt])
interface_body =

  choice [
    do (pfxs,n1,args,r) <- try function_stmt
       us  <- many $ parD use_stmt
--       setState []
       ps  <- many $ parD procedure_specification
       n2  <- end_function_stmt
       return $ FuncSubProg [] False (n1,n2) (us ++ ps) [] pfxs args r,

    do (pfxs,n1,args) <- subroutine_stmt
       us  <- many $ parD use_stmt
--       setState []
       ps  <- many $ parD procedure_specification
       n2  <- end_subroutine_stmt
       return $ SubrSubProg [] False (n1,n2) (us ++ ps) [] pfxs args
    ]


-- R1209
intrinsic_stmt :: CharParser SmT SpecStmt
intrinsic_stmt

 = do reserved "INTRINSIC"
      reservedOp "::"
      is <- intrinsic_procedure_name_list
      newlines1
      return $ IntrinsicStmt [] is


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
    liftM (ExprPrim [] . UnknownName []) procedure_name
--    Previously:
--    variable >>= return . ExprPrim,
--    procedure_name >>= \n -> return $ ExprPrim $ UnknownName n
    ]


-- R1226
return_stmt :: CharParser SmT ExecStmt
return_stmt = reserved "RETURN"   >> newlines1 >> return ReturnStmt


-- R1227
contains_stmt :: CharParser SmT ()
contains_stmt = reserved "CONTAINS" >> newlines1 >> return () -- >> return ContainsStmt


-----------------------------------------------------------
-- The scalar productions
-----------------------------------------------------------

scalar_int_expr                 = int_expr
scalar_char_expr                = char_expr
scalar_logical_expr             = logical_expr
scalar_int_initialization_expr  = int_initialization_expr
scalar_char_initialization_expr = char_initialization_expr
scalar_variable_name            = variable_name
scalar_structure_component      = structure_component
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

only_list                     = commaSep1 only
rename_list                   = commaSep1 rename
entity_decl_list              = commaSep1 entity_decl
actual_arg_spec_list          = commaSep1 actual_arg_spec
intrinsic_procedure_name_list = commaSep1 intrinsic_procedure_name
procedure_name_list           = commaSep1 procedure_name
--allocation_list               = commaSep1 allocation
--allocate_object_list          = commaSep1 allocate_object
allocate_shape_spec_list      = commaSep1 allocate_shape_spec
case_value_range_list         = commaSep1 case_value_range
position_spec_list            = commaSep1 position_spec
close_spec_list               = commaSep1 close_spec
section_subscript_list        = commaSep1 section_subscript
inquire_spec_list             = commaSep1 inquire_spec
input_item_list               = commaSep1 input_item
output_item_list              = commaSep1 output_item
connect_spec_list             = commaSep1 connect_spec
io_control_spec_list          = commaSep1 io_control_spec
--forall_triplet_spec_list      = commaSep1 forall_triplet_spec
dummy_arg_name_list           = commaSep1 dummy_arg_name
access_id_list                = commaSep1 access_id
component_attr_spec_list      = commaSep1 component_attr_spec
component_decl_list           = commaSep1 component_decl
expr_list                     = commaSep1 expr
ac_value_list                 = commaSep1 ac_value
--ac_value_list                 = commaSep1 $ option NullExpr ac_value
explicit_shape_spec_list      = commaSep1 explicit_shape_spec
assumed_shape_spec_list       = commaSep1 assumed_shape_spec
deferred_shape_spec_list      = commaSep1 deferred_shape_spec
--format_item_list              = commaSep1 format_item
{-explicit_shape_spec_list :: CharParser st [Expr]
explicit_shape_spec_list = try ( do { lol <- commaSep1 explicit_shape_spec
                                    ; return (join lol)
                                    }
                               )
assumed_shape_spec_list :: CharParser st [Expr]
assumed_shape_spec_list  = try ( do { lol <- commaSep1 assumed_shape_spec
                                    ; return (join lol)
                                    }
                               )
deferred_shape_spec_list :: CharParser st [Expr]
deferred_shape_spec_list = try ( do { lol <- commaSep1 deferred_shape_spec
                                    ; return (join lol)
                                    }
                               )
-}

