module Main where

import TyTraCLAST 
import ASTInstance (ast,functionSignaturesList)
import Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, decomposeExpressions)
import CodeGeneration (
    inferSignatures, 
    generateFortranCode
    )

info =  False    

ast1 = splitLhsTuples ast
ast2 = substituteVectors ast1
(ast3, (_,idSigList)) = applyRewriteRules ast2
ast3' = fuseStencils ast3
ast4 = decomposeExpressions ast1 ast3' 

inferedSignatures :: [[(Name,FSig)]]
inferedSignatures = map inferSignatures ast4

generatedFortranCode = generateFortranCode ast4 functionSignaturesList idSigList 

main = do
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
            putStrLn "-- Decompose expressions and infered function signatures"
            mapM_ ( \(x1,x2) -> do
                putStrLn ("-- " ++ ((show . LHSPrint . fst . head) x1))
                putStrLn "-- Decomposed expressions"
                mapM print x1   
                putStrLn "-- Infered function signatures"
                mapM print x2
                ) (zip ast4 inferedSignatures)
        else return ()            
    putStr generatedFortranCode
