module Main where
import Data.List
import TyTraCLAST 
import ASTInstance (ast,functionSignaturesList)
import Transforms (splitLhsTuples, substituteVectors, applyRewriteRules, fuseStencils, decomposeExpressions)
import CodeGeneration (
    inferSignatures, 
    -- generateSignatures, 
    -- createStages, 
    -- generatedOpaqueFunctionDefs, 
    -- generateDefs, 
    -- generateNonSubDefs, 
    -- generateStageKernel,
    -- generateMainProgram
    generateFortranCode
    )

ast1 = splitLhsTuples ast
ast2 = substituteVectors ast1
(ast3, (_,idSigList)) = applyRewriteRules ast2
ast3' = fuseStencils ast3
ast4 = decomposeExpressions ast1 ast3'
-- generatedSignatures = map generateSignatures ast4
inferedSignatures :: [[(Name,FSig)]]
inferedSignatures = map inferSignatures ast4

-- (asts_function_defs,ast_stages) = createStages ast4
-- generatedFunctionDefs = map generateDefs asts_function_defs
-- generatedNonFunctionDefs = map generateDefs asts_no_function_defs 
-- For every stage ([String],[String]) so [([String],[String])]
-- (generatedDecls,generatedStmts) = unzip $ map generateNonSubDefs ast_stages
-- generatedDeclsStmts_per_stage = map generateNonSubDefs ast_stages
-- uniqueGeneratedDeclsStmts_per_stage = map (\(decls,stmts) -> (nub decls, stmts)) generatedDeclsStmts_per_stage
-- uniqueGeneratedDecls = sort $ nub $ concat generatedDecls
-- generatedStageKernels = map (\(ast,ct) -> generateStageKernel ct ast) (zip ast_stages [1..])
-- mainProgramStr = generateMainProgram ast_stages

generatedFortranCode = generateFortranCode ast4
info = True -- False
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
        -- --    mapM print map_checks
            -- putStrLn "\n-- Decompose expressions"
            -- mapM_ ( \x -> (putStrLn ("-- " ++ ((show . LHSPrint . fst . head) x)) >> mapM print x )  ) ast4
            -- putStrLn "\n-- Infer intermediate function signatures"
            -- mapM_ ( \x -> (putStrLn "-- "  >> mapM print x )  ) inferedSignatures 
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
        --     putStrLn "\n! Main Program"             
        --     putStrLn mainProgramStr
        --     putStrLn "\n! Generate opaque subroutine definitions"    
        --     mapM_ putStrLn generatedOpaqueFunctionDefs
        --     putStrLn "\n! Generate subroutine definitions"
        --     mapM_ putStrLn (map (\(ls,ct) -> unlines (["! Stage "++(show ct)]++ls)) (zip generatedFunctionDefs [1..]))
        --     putStrLn "\n! Generated stage kernels"
        --     mapM_ (putStrLn . unlines) generatedStageKernels 
        else return ()        
    -- do
    putStr generatedFortranCode
    -- putStrLn "\n! Main Program"             
    -- putStrLn mainProgramStr            
    -- putStrLn "\n! Generate opaque subroutine definitions"    
    -- mapM_ putStrLn generatedOpaqueFunctionDefs
    -- putStrLn "\n! Generate subroutine definitions"
    -- mapM_ putStrLn (map (\(ls,ct) -> unlines (["! Stage "++(show ct)]++ls)) (zip generatedFunctionDefs [1..]))
    -- putStrLn "\n! Generated stage kernels"
    -- mapM_ (putStrLn . unlines) generatedStageKernels 