module F95StatementParser  ( parseF95Statement,parseF95Decl ) where

-- import whatever you need
import Language.Fortran.Parser
import Language.Fortran
import qualified Data.Map as H
type A0 = H.Map String [String]
-- Must be compiled with -i../language-fortran/src/

-- This function takes a single line of F95, no preprocessing is required from your side
-- It returns the string resulting from calling `show` on the parsed expression
parseF95Statement :: String  -> (Fortran A0, String)
parseF95Statement f95_line = (fortranAst, show fortranAst ) -- ,contextAst)
		where
			fortranAst = statement_parse f95_line
--			contextAst = context_parse "integer :: vvv,v" -- context_str

parseF95Decl :: String  -> (Decl A0, String)
parseF95Decl f95_line = (contextAst, show contextAst ) -- ,contextAst)
		where
--			fortranAst = statement_parse f95_line
			contextAst = context_parse f95_line


-- Lanauge fortran doesn't include type information with assignments and my compiler only
-- considers types when evaluating iterator value ranges during loop analysis. 

-- parse_with_your_parser :: String -> Context -> (AST, Context)    
-- readContext :: String -> Context    

--	TAKEN FROM "LanaguageFortranTools.hs"
	-- 	Type used when determining allowed values for iterator variables. Holds the currently chosen values
	-- 	for previous iterator variables that allow the calculation of inner iterator variables in the case
	-- 	of nested loops whose bounds depends on previous iterator variables.
	-- 	Also used during constant folding to hold current constants
	-- type ValueTable = DMap.Map String (Float, BaseType Anno)
