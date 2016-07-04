module F95StatementParser  ( parseF95Statement ) where

-- import whatever you need
import Language.Fortran.Parser
import Language.Fortran
-- Must be compiled with -i../language-fortran/src/

-- This function takes a single line of F95, no preprocessing is required from your side
-- It returns the string resulting from calling `show` on the parsed expression
parseF95Statement :: String -> String -> String
parseF95Statement f95_line context_str = show (fortranAst,contextAst)
		where
			fortranAst = statement_parse "var = v(42)+w(2*i+j)\n" -- f95_line
			contextAst = context_parse "integer :: vvv,v" -- context_str
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
