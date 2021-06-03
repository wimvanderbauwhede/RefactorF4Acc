{-# LANGUAGE DeriveDataTypeable #-}
module TyTraCLAST where

import Data.Generics (Data, Typeable)
import Data.List (intercalate)

noStencilRewrites = False -- FIXME: hangs when set to True, I need a different halting condition for the rewrite rules!

type Name = String
type FType = String
type Size = Int
-- Vector In   Out  Stencil Temp Don't care
data VE = VI  | VO  | VS  | VT | VDC deriving (Show, Read, Ord, Typeable, Data, Eq)
data DType = 
    DInteger | DInt 
  | DReal | DFloat 
  | DSVec Int DType --  to encode SVecs
  | DTuple [DType] -- to encode Tuple
  | DDC -- Don't Care ; Int and Integer, Real and Float as I can't make up my mind
    deriving (Show, Read, Ord, Typeable, Data, Eq)

type FSig = [Expr]


ppFSig (fname,ftypes) = fname ++" :: "++(intercalate " -> " (filter (/="()") (map ppFSigArg ftypes) ) )
ppFSigArg (Scalar _ dt _) = ppDType dt
ppFSigArg (Tuple ts) = "("++(intercalate ", " (filter (/="()") $ map ppFSigArg ts))++")"
ppFSigArg (SVec sz x) = "SVec "++(show sz)++" "++(ppFSigArg x)

ppDType DInteger = "Int"
ppDType DInt = "Int"
ppDType DReal = "Dloat"
ppDType DFloat = "Float"
ppDType (DSVec sz dt) = "SVec "++(show sz)++(ppDType dt)
ppDType (DTuple dts) = "("++ (intercalate ", " (map ppDType dts)) ++")"
ppDType DDC = show DDC

data FName = Single String | Composite [FName]
  deriving (Ord, Typeable, Data, Eq)

instance Show FName where    
  show (Single nm) = nm
  show (Composite nms) = 
    intercalate ", " (map show nms)

data FIntent = In | Out | InOut | Unknown | NA
  deriving (Show, Read, Ord, Typeable, Data, Eq)

data FDecl = MkFDecl {
  ftype :: String,  
  dim :: Maybe [Int],
  intent :: Maybe FIntent,
  names :: [String] 
  } |
--  deriving (Ord, Typeable, Data, Eq)
 MkFParamDecl {
  ftype :: String,  
  dim :: Maybe [Int],
  name :: String,
  val :: String 
  }
 deriving (Ord, Read, Typeable, Data, Eq)

errorDecl = MkFDecl "ERROR" Nothing Nothing []

instance Show FDecl where  
  show (MkFDecl ftype mdim intent names ) = let
        attributes = [ftype]
        attributes' = case mdim of          
          Just dims -> let
              dims_str = intercalate "," $ map (\dm ->  "1:"++(show dm)) dims
            in
              attributes++["dimension("++dims_str++")"]
          Nothing -> attributes
        attributes'' = case intent of
            Just i -> attributes'++["intent("++(show i)++")"]
            Nothing -> attributes'
      in
        (intercalate ", " attributes'') ++ " :: "++ (intercalate ", " names)
  show (MkFParamDecl ftype mdim name val) = let
    maybe_dimstr = case mdim of          
      Just dims -> let
          dims_str = intercalate "," $ map (\dm ->  "1:"++(show dm)) dims
        in
          ", dimension("++dims_str++")"
      Nothing -> ""
    in
      ftype++", parameter"++maybe_dimstr++" :: "++ name ++ " = " ++ val
        

type TyTraCLAST = [(Expr,Expr)]                      
type FunctionSignature = [(String,[Expr])]      
type StencilDefinition = [(String,[Integer])]    
type MainArgDecls = [(String,FDecl)]
type ScalarisedArgs = [(String,[(String,(Integer,FIntent,String))])]
type OrigNames = [(String,[(String,[(String,FIntent)])])]

type ASTInstance = (TyTraCLAST, FunctionSignature, StencilDefinition, MainArgDecls, ScalarisedArgs, OrigNames) 

data Expr =
        -- Left-hand side:
                      Scalar VE DType Name
                    | Const Int
                    | Tuple [Expr]
                    | Vec VE Expr -- Name -- (Vec ve (SVec sz (Scalar ve dt v_n) ) )

        -- Right-hand side:
                    | SVec Size Expr -- Name
                    | ZipT [Expr]
                    | UnzipT Expr
                    | Elt Int Expr
                    | PElt Int -- partially applied Elt
                    | Map Expr Expr -- map f v
                    | Fold Expr Expr Expr -- fold f acc v
                    | Stencil Expr Expr -- stencil s v
                    | Function Name [Expr] -- 2nd arg is list of non-map/fold args
                    | Id Name [Expr] -- id, but it's treated as a named function for ease of code generation
                    | ApplyT [Expr]  -- applyt (f1,f2)
                    | MapS Expr Expr -- maps s f
                    | Comp Expr Expr -- comp f2 f1
                    | FComp Expr Expr -- like comp but to combine a fold and a map, quite a-hoc!
                    | SComb Expr Expr -- scomb s1 s2
                        deriving (Show, Read, Ord, Typeable, Data, Eq)

{-
Various helpers for pretty printing and code generation
-}

newtype LHSPrint = LHSPrint Expr

instance Show LHSPrint where
    show (LHSPrint (Scalar _ _ x)) = show x
    show (LHSPrint (Vec _ x)) = show (LHSPrint x)
    show (LHSPrint (Function x _)) = show x
    show (LHSPrint x) = show x

ppAST :: TyTraCLAST -> [String]
ppAST ast = map ppExprTup ast

ppExprTup :: (Expr, Expr) -> String
ppExprTup (lhs,rhs) = (ppLHSExpr lhs) ++ " = " ++ (ppRHSExpr rhs)

ppLHSExpr  :: Expr -> String
ppLHSExpr (Scalar _ _ x) = x
ppLHSExpr (Vec _ x) = ppLHSExpr x
ppLHSExpr (SVec _ x) = ppLHSExpr x
ppLHSExpr (Function x _) = x
ppLHSExpr (Tuple xs) = "("++(intercalate ", " (map ppLHSExpr xs))++")"
ppLHSExpr x = "<TODO:"++(show x)++">"

ppRHSExpr :: Expr -> String
ppRHSExpr (Scalar _ _ x) = x
ppRHSExpr (Vec _ x) = ppRHSExpr x
-- ppRHSExpr
ppRHSExpr (SVec _ x) = ppRHSExpr x
ppRHSExpr (ZipT xs) = "zipt ("++(intercalate ", " (map ppRHSExpr xs))++")"
ppRHSExpr (UnzipT x) = "unzipt ("++(ppRHSExpr x)++")"
ppRHSExpr (Elt idx x) =  "elt "++(show idx)++" "++(ppRHSExpr x)
ppRHSExpr (PElt idx) = "pelt "++(show idx)++" "
ppRHSExpr (Map f v) = "map " ++ (ppRHSExpr f) ++ " " ++ (ppRHSExpr v)
ppRHSExpr (Fold f acc v) = "fold " ++ (ppRHSExpr f)  ++ " " ++ (ppRHSExpr acc) ++ " " ++ (ppRHSExpr v)
ppRHSExpr (Stencil s v) = "stencil " ++ (ppRHSExpr s)++" "++(ppRHSExpr v)
ppRHSExpr (Function fname xs) = let
    non_map_args = map ppRHSExpr xs
  in
    if null non_map_args then fname else  "("++fname++" " ++ (unwords non_map_args)++")" 
ppRHSExpr (Id _ _) = "id "
ppRHSExpr (ApplyT xs)  = "applyt ("++(intercalate ", " (map ppRHSExpr xs))++")"
ppRHSExpr (MapS s f) = "maps "++(ppRHSExpr s)++" "++ (ppRHSExpr f)
ppRHSExpr (Comp f2 f1) = "comp "++(ppRHSExpr f2) ++" "++(ppRHSExpr f1)
ppRHSExpr (FComp f2 f1) = "fcomp "++(ppRHSExpr f2) ++" "++(ppRHSExpr f1)
ppRHSExpr (SComb s1 s2) = "(scomb "++ (ppRHSExpr s1) ++" "++(ppRHSExpr s2)++")"

ppRHSExpr x = show x

getDType (Vec _ dt_exp ) = dt_exp
getDType (ZipT es) = Tuple (map getDType es)

setName :: FName -> Expr -> Expr
setName (Single name') (Scalar ve dt name) = Scalar ve dt name'
setName (Single name') (Vec ve exp) = Vec ve (setName (Single name') exp)
setName (Single name') (SVec sz exp) = SVec sz (setName (Single name') exp)
-- Tuple [SVec 5 (Scalar VDC DInt "wet_s_0"),SVec 5 (Scalar VDC DFloat "eta_s_0")]
setName (Single name') (Tuple exps) = Tuple $ map (\(exp,ct) -> setName (Single (name'++"_"++ show ct)) exp) (zip exps [0..])
setName (Composite names') (Tuple exps) = Tuple $ map (\(exp,name) -> setName name exp) (zip exps names')

setName fnm@(Composite names') (SVec sz exp) = SVec sz (setName fnm exp)

setName name' exp = error $ "Don't know how to set the name "++ show name' ++ " for " ++ show exp


-- SVec 3 (Tuple [SVec 5 (Scalar VDC DInt "sv_wet_s_0_in"),SVec 5 (Scalar VDC DFloat "sv_eta_s_0_in")])

getName :: Expr -> FName
getName (Scalar ve dt name) = Single name
getName (Vec ve exp) = getName exp
getName (SVec sz exp) = getName exp
-- WV: I want to know if this happens
-- getName (Tuple exps) = error $ "No unique name to get for "++(show exps)
getName (Tuple exps) = Composite (map getName exps)
getName (SComb exp1 exp2) = Composite (map getName [exp1,exp2])
getName (ZipT exps) = Composite (map getName exps)
--  Stencil (SVec 3 (Scalar VDC DInt "s1")) (Vec VT (Scalar VDC DInt "v_1"))
getName expr = Single $ show expr

updateName :: String -> String -> Expr -> Expr
updateName prefix postfix (Tuple exps) = Tuple $ map (\exp -> setName (appendPrePost prefix postfix (getName exp)) exp) exps
updateName prefix postfix exp =  setName (appendPrePost prefix postfix (getName exp)) exp

appendPrePost :: String -> String -> FName -> FName 
appendPrePost prefix postfix (Single nm) = -- prefix++"_"++nm++"_"++postfix
  let
    nm' = if 
      -- (take (1 + length prefix) nm) == prefix++"_" || 
          prefix=="" then nm else prefix++"_"++nm
    nm'' = if 
      -- (drop ( length nm' -length postfix -1) nm') == "_" ++ postfix || 
      postfix == "" then nm' else nm'++"_"++postfix
  in
    Single nm''    
appendPrePost prefix postfix (Composite nms) = Composite $ map (appendPrePost prefix postfix) nms

flattenNames :: FName -> FName
flattenNames (Single nm) =  Composite [Single nm]
flattenNames (Composite nms) = Composite $ concatMap ( (\(Composite x) -> x) . flattenNames) nms

unwrapName  :: FName -> [Name]
unwrapName (Single nm) =  [nm]
unwrapName  (Composite nms) = concatMap unwrapName nms