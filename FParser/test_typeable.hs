{-# LANGUAGE DeriveDataTypeable #-}
module Main where
import F95VarDecl
import F95Types
import Data.Typeable
import Data.Data
import Data.Map hiding ( map)
f :: VarDecl -> String
f vd = "<<"++(show vd)++">>"

g :: Int -> [(String,Bool)] -> [Int] -> (String,String) -> Data.Map.Map String Int -> Maybe Float -> String
g n ls1 ls2 t h mf = "<<"++(show n)++(show ls2)++">>"

h = Data.Map.fromList [("k",4)]

data TestMap = MkTestMap String (Data.Map.Map String Int) (Maybe Float) deriving (Read,Show)
tm :: TestMap    
tm = MkTestMap "test" h (Just 3.23)

vd:: VarDecl
vd = read  "MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = 4}, vd_dimension = [MkRange {r_start = Const 1, r_stop = Var \"ip\"},MkRange {r_start = Const 1, r_stop = Var \"jp\"},MkRange {r_start = Const 1, r_stop = Var \"kp\"}], vd_intent = InOut, vd_varlist = [\"u\"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]}"

data Tup = MkTup Int Bool (String,Int) deriving (Show, Read, Typeable, Data)
data Tup2 = MkTup2 Int Bool (String,Int) Tup deriving (Show, Read, Typeable, Data)

vd2:: Tup2
vd2 = MkTup2 42 False ("42",3) (MkTup 42 False ("42",3))

vd3:: (Int,String,Bool,Tup)
vd3 = (42, "42",True,MkTup 42 False ("42",3))

mv :: Maybe Int
mv = Just 42
main = do
    putStrLn $ show tm
    putStrLn $ show h
    putStrLn $ show vd2
    putStrLn $ show vd3
    putStrLn $ show vd
    putStrLn $ show $ typeOf vd
--    putStrLn $ show $ typeRep vd
--    putStrLn $ show $ splitTyConApp $ typeOf vd
--    putStrLn $ show $ typeRepTyCon $ typeOf vd
--    putStrLn $ show $ typeRepArgs $ typeOf vd
    putStrLn ""
    putStrLn $ show mv
    putStrLn $ show $ typeOf mv
--    putStrLn $ show $ typeRep mv
--    putStrLn $ show $ splitTyConApp $ typeOf mv
--    putStrLn $ show $ typeRepTyCon $ typeOf mv
--    putStrLn $ show $ typeRepArgs $ typeOf mv
    putStrLn ""
    putStrLn $ show (dataTypeOf vd)
    putStrLn $ show $ dataTypeConstrs (dataTypeOf vd)
    putStrLn ""
    putStrLn $ show $ splitTyConApp (typeOf f)
    putStrLn $ show $ typeRepTyCon $ typeOf f
    putStrLn $ show $ typeRepArgs $ typeOf f
--    putStrLn $ show $ dataTypeOf f
--    putStrLn $ show $ dataTypeConstrs (dataTypeOf f)
    putStrLn $ show $ map constrFields (dataTypeConstrs (dataTypeOf vd))
    putStrLn $ show $ isAlgType (dataTypeOf vd)
--    putStrLn $ show $ indexConstr (dataTypeOf vd) 
    putStrLn ""
    putStrLn $ show $ typeOf g
    putStrLn $ show $ splitTyConApp (typeOf g)
    putStrLn $ show $ typeRepTyCon $ typeOf g
    putStrLn $ show $ typeRepArgs $ typeOf g

