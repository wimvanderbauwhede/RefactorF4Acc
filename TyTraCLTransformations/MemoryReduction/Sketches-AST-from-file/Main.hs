{-# LANGUAGE ScopedTypeVariables #-}
{- HLINT "ignore Use when" -}
module Main where
import System.Environment    
import Control.Monad ( when )
import TyTraCLAST 
-- import ASTInstance (ast,functionSignaturesList)
import Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, decomposeExpressions)
import CodeGeneration (
    inferSignatures, 
    generateFortranCode
    )
import ASTReader ( readAST )

info 
    | noStencilRewrites = True
    | otherwise = True

data Stage = Original | SplitLhsTuples | SubstituteVectors | ApplyRewriteRules | FuseStencils | DecomposeExpressions deriving (Show, Ord, Eq)
{-
stage 
    | noStencilRewrites = DecomposeExpressions
    | otherwise = DecomposeExpressions

ast1 :: TyTraCLAST
ast1 = splitLhsTuples ast
ast2 :: TyTraCLAST
ast2 = substituteVectors ast1
(ast3 :: TyTraCLAST, (_,idSigList)) = applyRewriteRules ast2
ast3' :: TyTraCLAST
ast3' = fuseStencils ast3
ast4 :: [TyTraCLAST]
ast4 = decomposeExpressions ast1 ast3' 

asts  -- = ast4
    | stage == Original = [ast]
    | stage == SplitLhsTuples = [ast1]
    | stage == SubstituteVectors = [ast2]
    | stage == ApplyRewriteRules = [ast3]
    | stage == FuseStencils = [ast3']
    | stage == DecomposeExpressions = ast4

transformedASTs ast stage 
        | stage == Original = [ast]
        | stage == SplitLhsTuples = [ast1]
        | stage == SubstituteVectors = [ast2]
        | stage == ApplyRewriteRules = [ast3]
        | stage == FuseStencils = [ast3']
        | stage == DecomposeExpressions = ast4
    where
        ast1 :: TyTraCLAST
        ast1 = splitLhsTuples ast
        ast2 :: TyTraCLAST
        ast2 = substituteVectors ast1
        (ast3 :: TyTraCLAST, (_,idSigList)) = applyRewriteRules ast2
        ast3' :: TyTraCLAST
        ast3' = fuseStencils ast3
        ast4 :: [TyTraCLAST]
        ast4 = decomposeExpressions ast1 ast3' 

inferedSignatures :: [[(Name,FSig)]]
inferedSignatures = map inferSignatures ast4

generatedFortranCode = generateFortranCode asts functionSignaturesList idSigList 
-}

main = do
    astFilePathLst <- getArgs
    let
        astFilePath
            | null astFilePathLst = error "Please specify the path to the ASTInstance file"
            | otherwise = head astFilePathLst
    astInst <- readAST astFilePath -- better make this the file name provided as argument
    let
        (   ast, 
            functionSignaturesList, 
            stencilDefinitionsList, 
            mainArgDeclsList, 
            scalarisedArgsList, 
            origNamesList
            ) = astInst
    -- print astInst
    let
        stage 
            | noStencilRewrites = DecomposeExpressions
            | otherwise = DecomposeExpressions
        
        ast1 :: TyTraCLAST
        ast1 = splitLhsTuples ast
        ast2 :: TyTraCLAST
        ast2 = substituteVectors ast1
        (ast3 :: TyTraCLAST, (_,idSigList)) = applyRewriteRules ast2
        ast3' :: TyTraCLAST
        ast3' = fuseStencils ast3
        ast4 :: [TyTraCLAST]
        ast4 = decomposeExpressions ast1 ast3' 
        
        asts  -- = ast4
            | stage == Original = [ast]
            | stage == SplitLhsTuples = [ast1]
            | stage == SubstituteVectors = [ast2]
            | stage == ApplyRewriteRules = [ast3]
            | stage == FuseStencils = [ast3']
            | stage == DecomposeExpressions = ast4
        functionSignatures :: Map.Map Name FSig
        functionSignatures =  Map.fromList functionSignaturesList
            
        inferedSignatures :: [[(Name,FSig)]]
        inferedSignatures = map (inferSignatures functionSignatures) ast4
        -- We must pass astInst as arg into this instead of functionSignaturesList
        -- generatedFortranCode = generateFortranCode asts functionSignaturesList idSigList 
        generatedFortranCode = generateFortranCode asts astInst idSigList 
                
    if info 
        then
            do
            putStrLn "-- Original AST"
            mapM_ print ast
            putStrLn "\n-- Split LHS tuples"
            mapM_ print ast1
            putStrLn "\n-- Substitute vectors (recursive)"
            mapM_ print ast2
            putStrLn "\n-- Apply rewrite rules"
            mapM_ print ast3
            putStrLn "\n-- Fuse stencils"
            mapM_ print ast3'    
            putStrLn "\n-- Decompose expressions and Infer intermediate function signatures"
            putStrLn "-- Original function signatures"
            mapM_ print functionSignaturesList
            putStrLn "-- Decomposed expressions and infered function signatures"
            mapM_ ( \((x1,x2),ct) -> do
                if noStencilRewrites  then putStrLn $ "-- stage_kernel_" ++ show ct else return ()
                putStrLn $ "-- " ++ (show . LHSPrint . fst . head) x1
                putStrLn "-- Decomposed expressions"
                mapM_ print x1   
                putStrLn "-- Infered function signatures"
                mapM print x2
                ) (zip (zip ast4 inferedSignatures) [1..])
        else return ()            
    putStr generatedFortranCode
