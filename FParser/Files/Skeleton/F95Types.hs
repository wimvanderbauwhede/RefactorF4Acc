module F95Types (
    module F95VarDecl
    ,module F95ParDecl
    ,module F95SubDecl
    ,ArgTable
    ,dummyVarType 
    ,dummyRange 
    ,dummyIntent 
    ,dummyArgMode 
    ,dummyVarDecl 
    ,dummyConstExpr 
    ,dummyVarExpr 
    ,dummyExpr 
    ,dummyVarName 
        )
    where

import F95SubDecl
import F95VarDecl
import F95ParDecl

import Data.Map
-- a table with as key the argument name and as value the corresponding VarDecl record.
type ArgTable = Data.Map.Map String VarDecl


dummyVarType = MkVarType F95Integer 0
dummyRange =  MkRange (Const 0) (Const 0)
dummyIntent = InOut
dummyArgMode = ReadWrite
dummyVarDecl = MkVarDecl dummyVarType [] dummyIntent [] dummyArgMode True False []

dummyConstExpr = Const 0
dummyVarExpr = Var "DUMMY"
dummyExpr = dummyConstExpr

dummyVarName = "DUMMY"
