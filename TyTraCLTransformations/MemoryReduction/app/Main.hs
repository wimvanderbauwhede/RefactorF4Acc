{-# LANGUAGE ScopedTypeVariables #-}
{- HLINT "ignore Use when" -}
module Main where
import Control.Monad ( when )
import System.IO ( openFile, hPutStr, hClose, IOMode(..) )
import Data.List ((\\))
import TyTraCLAST 
import ASTInstance (ast,functionSignaturesList,superkernelName)
import Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, regroupTuples, decomposeExpressions)
import CodeGeneration (
    inferSignatures, 
    generateFortranCode,
    createStages
    )

info 
    | noStencilRewrites = True
    | otherwise = True    

    
data Stage = Original | SplitLhsTuples | SubstituteVectors | ApplyRewriteRules | FuseStencils | RegroupTuples | DecomposeExpressions deriving (Show, Ord, Eq)
stage 
    | noStencilRewrites = DecomposeExpressions
    | otherwise = DecomposeExpressions

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

asts  -- = ast4
    | stage == Original = [ast]
    | stage == SplitLhsTuples = [ast1]
    | stage == SubstituteVectors = [ast2]
    | stage == ApplyRewriteRules = [ast3]
    | stage == FuseStencils = [ast3'']
    | stage == RegroupTuples = [ast3']
    | stage == DecomposeExpressions = ast4

inferedSignatures :: [[(Name,FSig)]]
inferedSignatures = map inferSignatures ast4

generatedFortranCode = generateFortranCode asts functionSignaturesList idSigList 
(generatedMainProgramCode,generatedModuleCode) = generatedFortranCode

printTyTraCL = True

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
            -- putStrLn "\n-- Decompose expressions and infer intermediate function signatures"
            putStrLn "\n-- Decompose expressions and infer function signatures"
            mapM_ ( \((x1,x2),ct) -> do
                if noStencilRewrites  then putStrLn $ "-- stage_kernel_" ++ show ct else return ()
                if not (null (x2 \\ functionSignaturesList)) then
                    do
                        putStrLn $ "-- Inferred function signatures stage "++(show ct)
                        mapM print x2
                else
                    return [()]
                putStrLn $ "-- Decomposed expressions stage "++(show ct)
                mapM_ print x1   
                ) (zip (zip ast4 inferedSignatures) [1..])        
            putStrLn ""
        else return ()
    if printTyTraCL then
            do        
            putStrLn "-- Original function signatures"
            -- mapM_ print functionSignaturesList
            mapM_ (putStrLn . ppFSig) functionSignaturesList
            putStrLn "\n-- Original TyTraCL code"
            mapM_ putStrLn $ ppAST ast
            -- putStrLn "\n-- Decompose expressions and infer intermediate function signatures"
            putStrLn "\n-- Decomposed expressions and inferred function signatures"
            mapM_ ( \((x1,x2),ct) -> do
                if noStencilRewrites  then putStrLn $ "-- stage_kernel_" ++ show ct else return ()
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
            -- let
            --     (asts_function_defs,ast_stages) = createStages ast4
            -- mapM_ putStrLn (concatMap  ppAST ast_stages) 

        else return ()     
    -- putStr generatedFortranCode
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