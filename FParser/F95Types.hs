module F95Types (
    module F95VarDecl
    ,module F95ParDecl
    ,module F95SubDecl
    ,ArgTable
    ,SrcLine
    ,VarDeclLine
    ,ParDeclLine
    ,FileName
        )
    where

import F95SubDecl
import F95VarDecl
import F95ParDecl

import Data.Map
type ArgTable = Data.Map.Map String VarDecl
--type VarName = String
type SrcLine = String
type VarDeclLine = String
type ParDeclLine = String
type FileName = String

dummyVarDecl = MkVarDecl (MkVarType F95Integer 0) [] InOut [] ReadWrite True False []

