module OpenCLAPIGenerator (
    gen_OpenCL_API_calls
        ) where
import F95Types
import Text.Regex.Posix -- suggest use of regular expressions
import Data.Char
import qualified Data.Map as H (lookup)

import System.Process -- only for localtime, entirely optional
import System.IO.Unsafe (unsafePerformIO) -- only for localtime, entirely optional

gen_OpenCL_API_calls :: ArgTable -> [String] -> [String] -> [String] -> String -> [String]    
gen_OpenCL_API_calls ocl_args arg_names const_arg_names src_lines templ_src_name = []

get_c_type :: VarType -> String
get_c_type vt = ""
                
ucfirst (x:xs)  = (toUpper x):xs

localtime = unsafePerformIO $ readProcess "/bin/date" [] []

