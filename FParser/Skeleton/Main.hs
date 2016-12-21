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

Sequence of actions:

 1/ detect arguments and argmodes, make a list of arguments

 2/ detect entry for new declarations for buffers and sizes, generate code and insert 

 3/ detect entry for API calls, generate code and insert 

-}

templ_src_name=  "module_LES_ocl_TEMPL.f95"
gen_src_name = "module_LES_ocl.f95"

      
-- ###############################################################################
-- Code for parsing the argument declarations

parse_arg_decls :: [String] -> [String] -> (ArgTable,[String],[String])
parse_arg_decls arg_lines const_arg_lines = (H.empty,[],[])
   
parse_par_decls :: [String] -> VarTable    
parse_par_decls par_lines = H.empty

eval_range_expr :: ArgTable -> VarTable -> String -> (String, Integer)
eval_range_expr ocl_args par_table var_name = ("DUMMY",0)
       
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
