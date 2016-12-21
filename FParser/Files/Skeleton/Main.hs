module Main where
import F95SrcIO ( read_F95_src, write_F95_src )
import F95OpenACCParser ( extract_OpenACC_regions_from_F95_src )
import F95VarDeclParser ( run_parser, f95_var_decl_parser )
import F95ParDeclParser ( f95_par_decl_parser )
import F95Types
import OpenCLAPIGenerator ( gen_OpenCL_API_calls )
import EvalExpr    
import qualified Data.Map as H

{-
Name 
Matriculation Number + initial character

Functional Programming 4

Assessed Exercise 1 (Mandatory): Parsing, Code Generation and State Manipulation in Haskell: a Real-world Application

Date
-}

{-
Status report:

Report the status of your submission. Which parts did you do? Does your solution work? What bugs are you aware of? Which extensions, if any, did you implement?
        
-}

{-

Sequence of actions:

 1/ detect arguments and argmodes, make a list of arguments

 2/ detect entry for new declarations for buffers and sizes, generate code and insert 

 3/ detect entry for API calls, generate code and insert 

-}

templ_src_name=  "module_LES_ocl_TEMPL.f95"
gen_src_name = "module_LES_ocl.f95"

      
-- ###############################################################################
-- Code for parsing the argument declarations

-- Given the lines containing arguments arg_lines and the lines containing the constant arguments const_arg_lines
-- create a table with as key the variable name and as value the parsed declaration
-- also returns a list of the argument variable names and the constant argument variable names
parse_arg_decls :: [String] -> [String] -> (ArgTable,[String],[String])
parse_arg_decls arg_lines const_arg_lines = (H.empty,[],[])

-- Given the parameter declarations, create a table with as key the parameter name and as value the parsed declaration	
parse_par_decls :: [String] -> VarTable    
parse_par_decls par_lines = H.empty

-- This takes a range expression and returns a tuple with the variable name and the computed size
eval_range_expr :: ArgTable -> VarTable -> String -> (String, [Integer])
eval_range_expr ocl_args par_table var_name = ("DUMMY",[])
       
-- ###############################
main :: IO ()
main = do 
    putStr $ unlines [
        "-- read source template from file"
        ,"-- extract OpenACC regions"
        ,"-- parse declarations"
        ,"-- compute sizes for OpenCL arguments (this is hard, leave for last)"
        ,"-- generate the target source code" 
        ,"-- write generated source to file"
        ]
