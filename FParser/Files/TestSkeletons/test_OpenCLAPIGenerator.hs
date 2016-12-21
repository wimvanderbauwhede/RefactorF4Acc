import OpenCLAPIGenerator
import F95Types
import Test.HUnit
import qualified Data.Map as H

-- this name is irrelevant
templ_src_name = "test_OpenCLAPIGenerator.f95"

-- Just an example of a variable declaration
var_decl = MkVarDecl (MkVarType F95Integer 4) [] InOut ["v1"] ReadWrite True False []
-- put into the table
ocl_args = H.fromList [("v1",var_decl)]
-- put var name in the list
arg_names = ["v1"]
-- assume no constants
const_arg_names = []
-- some valid source code here
src_lines =[
    "",
    ""
    ]

test_bufdecls= assertEqual "BufDecls" ([
        "",
        ""
        ]) (gen_OpenCL_API_calls ocl_args arg_names const_arg_names src_lines templ_src_name)

tests = TestList [
	"Buffer Declarations" ~: test_bufdecls
	]

main = runTestTT tests  



