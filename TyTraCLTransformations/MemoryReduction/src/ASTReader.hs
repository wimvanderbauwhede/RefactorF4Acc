{-# LANGUAGE DeriveDataTypeable #-}
module Main where


import Data.Generics (Data, Typeable)
import Data.List (intercalate)

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

main :: IO ()
main = do
  ast <- readAST "ast-to-read.hs"
  print ast

readAST :: FilePath -> IO ASTInstance
readAST path = do
  alldata <- readFile path
  let
    -- ast :: ASTInstance
     ast = read alldata
  return ast
  -- return alldata



