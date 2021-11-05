{-# LANGUAGE ScopedTypeVariables #-}
{- HLINT "ignore Use when" -}
module Main where
import Control.Monad ( when )
import System.IO ( openFile, hPutStr, hClose, IOMode(..) )
import Data.List ((\\),foldl')
import TyTraCLAST 
import ASTInstance (ast,functionSignaturesList,superkernelName)
import Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, regroupTuples, removeDuplicateExpressions, decomposeExpressions) --, groupMapCalls)
import CodeGeneration (
    inferSignatures, 
    generateFortranCode,
    createStages
    )

info = True 
printTyTraCL = True
    
data Stage = Original | SplitLhsTuples | SubstituteVectors | ApplyRewriteRules | FuseStencils | RegroupTuples | DecomposeExpressions | RemoveDuplicateExpressions deriving (Show, Ord, Eq)
stage = RemoveDuplicateExpressions

ast1 :: TyTraCLAST
ast1 = splitLhsTuples ast
ast2 :: TyTraCLAST
ast2 = substituteVectors ast1
(ast3 :: TyTraCLAST, (_,idSigList)) = applyRewriteRules ast2
ast3'' :: TyTraCLAST
ast3'' = fuseStencils ast3
ast3' :: TyTraCLAST
ast3' = regroupTuples ast3''
ast4 :: [TyTraCLAST]
ast4 = decomposeExpressions ast1 ast3' 
tagged_asts = map (\ast -> (foldl'(\isFold (lhs,rhs) -> case rhs of
                            Fold _ _ _ -> True
                            _ -> isFold
                    ) False ast,ast)) ast4
(fold_asts,maps_asts) = foldl' (\(f_,m_) (is_f,ast) -> if is_f then (f_++[ast],m_) else (f_,m_++[ast])) ([],[]) tagged_asts
ast5 = removeDuplicateExpressions $ concat maps_asts -- the fold stages must remain separate!
ast6 = fold_asts ++ [ast5] --[ groupMapCalls ast5]

asts  
    | stage == Original = [ast]
    | stage == SplitLhsTuples = [ast1]
    | stage == SubstituteVectors = [ast2]
    | stage == ApplyRewriteRules = [ast3]
    | stage == FuseStencils = [ast3'']
    | stage == RegroupTuples = [ast3']
    | stage == DecomposeExpressions = ast4
    | stage == RemoveDuplicateExpressions = ast6

inferedSignatures :: [[(Name,FSig)]]
inferedSignatures = map inferSignatures ast4

generatedFortranCode = generateFortranCode asts functionSignaturesList idSigList 
(generatedMainProgramCode,generatedModuleCode) = generatedFortranCode

main = do
    if info then
            do
            putStrLn "-- Original function signatures"
            mapM_ print functionSignaturesList
            putStrLn "-- Original AST"
            mapM_ print ast
            putStrLn "\n-- Split LHS tuples"
            mapM_ print ast1
            putStrLn "\n-- Substitute vectors (recursive)"
            mapM_ print ast2
            putStrLn "\n-- Apply rewrite rules"
            mapM_ print ast3
            putStrLn "\n-- Fuse stencils"
            mapM_ print ast3''
            putStrLn "\n-- Regroup tuples"
            mapM_ print ast3'
            putStrLn "\n-- Decompose expressions and infer function signatures"
            mapM_ ( \((x1,x2),ct) -> do                
                if not (null (x2 \\ functionSignaturesList)) then
                    do
                        putStrLn $ "-- Inferred function signatures stage "++(show ct)
                        mapM print x2
                else
                    return [()]
                putStrLn $ "-- Decomposed expressions stage "++(show ct)
                mapM_ print x1   
                ) (zip (zip ast4 inferedSignatures) [1..])   
            mapM_ (\x -> do
                            mapM_ print x) ast6         
            putStrLn ""
        else return ()
    if printTyTraCL then
            do        
            putStrLn "-- Original function signatures"
            mapM_ (putStrLn . ppFSig) functionSignaturesList
            putStrLn "\n-- Original TyTraCL code"
            mapM_ putStrLn $ ppAST ast
            putStrLn "\n-- Fuse stencils"
            mapM_ putStrLn $ ppAST ast3''
            putStrLn "\n-- Regroup tuples"       
            mapM_ putStrLn $ ppAST ast3'
            putStrLn "\n-- Decomposed expressions and inferred function signatures"            
            mapM_ (
                 \((x1,x2),ct) -> do
                if not (null (x2 \\ functionSignaturesList)) then
                    putStrLn $ "-- Inferred function signatures stage "++(show ct)
                else
                    return ()
                -- mapM print x2
                mapM_ (putStrLn . ppFSig) (x2 \\ functionSignaturesList)
                -- putStrLn $ "-- " ++ (show . LHSPrint . fst . head) x1
                putStrLn $ "-- Decomposed expressions stage "++(show ct)
                -- mapM_ print x1   
                putStr $ unlines $ ppAST x1
                ) (zip (zip ast4 inferedSignatures) [1..])
                -- ) [(( ast5, inferedSignatures),0)]
            putStrLn "\n-- Common subexpression elimination\n"
            mapM_ (putStr . unlines . ppAST) ast6


        else return ()     

    let
        fp = mkSrcFileName superkernelName
    fh <- openFile fp WriteMode     
    hPutStr fh generatedMainProgramCode
    hClose fh
    if not (null generatedModuleCode) then
        do
            let
                fp' = mkModuleSrcFileName superkernelName
            fh' <- openFile fp' WriteMode     
            hPutStr fh' generatedModuleCode
            hClose fh'
    else
        return ()

mkSrcFileName str = "gen_"++ str ++ ".f95"
mkModuleSrcFileName str = "module_gen_"++ str ++ ".f95"
