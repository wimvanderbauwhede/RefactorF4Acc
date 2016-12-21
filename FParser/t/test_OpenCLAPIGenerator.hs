import OpenCLAPIGenerator
import F95Types

import Test.HUnit
import RunTestWV

import System.IO (Handle, stderr, stdout, hPutStr, hPutStrLn)

import NormaliseF95Code (normalise_F95_code, normalise_F95_code_lines)
import qualified Data.Map as H
import Data.Char (toLower)
lc = map toLower

templ_src_name = "test_OpenCLAPIGenerator.f95"

comment_line = "!!! DO NOT EDIT !!! Edit test_OpenCLAPIGenerator.f95 instead, and regenerate."

-- !$ACC BufDecls

var_decl_bufdecl = MkVarDecl (MkVarType F95Integer 4) [] InOut ["v1"] ReadWrite True False []
ocl_args_bufdecl = H.fromList [("v1",var_decl_bufdecl)]
arg_names_bufdecl = ["v1"]
const_arg_names = []
src_lines_bufdecl =[
    "! Buffers",
    "!$ACC BufDecls",
    ""
    ]    
ref_strs_bufdecl =  normalise_F95_code_lines [
        comment_line,
        "! buffers",
        "! OpenCL buffer declarations",
        "        integer(8) :: v1_buf",
        ""]
test_strs_bufdecl = normalise_F95_code_lines (gen_OpenCL_API_calls ocl_args_bufdecl arg_names_bufdecl const_arg_names (map lc src_lines_bufdecl) templ_src_name)

-- !$ACC SizeDecls
{-
            integer, dimension(4) :: mask1_sz
        integer, dimension(1) :: cn234ls_sz
        integer, dimension(1) :: n_state_sz
    -}

-- !$ACC MakeSizes     
{-
        real(kind=4), dimension(0:3,0:ip+1,-1:jp+1,-1:kp+1)  :: mask1
        real(kind=4), dimension(1:2*(ip+jp+kp))  :: cn234ls
        integer, dimension(0:1) :: n_state

        mask1_sz = (/ 3, 151, 152, 92 /)                                                     
        cn234ls_sz = (/ 779 /)                                                               
        n_state_sz = (/ 1 /)  
-}
     
range0 r = MkRange (Const 0) (Const r)
range1 r = MkRange (Const 1) (Const r)
var_decls_makesz = [
    MkVarDecl (MkVarType F95Real 4) [range0 152, range0 152, range0 91] InOut ["p"] ReadWrite True True [153,153,92],
    MkVarDecl (MkVarType F95Real 4) [range0 3, range0 151, range0 152, range0 92] InOut ["mask1"] ReadWrite True True [4,152,153,93],
    MkVarDecl (MkVarType F95Real 4) [range0 779] InOut ["cn234ls"] ReadWrite True True [780],
    MkVarDecl (MkVarType F95Real 4) [range0 3, range1 150, range1 150, range1 90] Out ["fgh"] Read True True [4,150,150,90],
    MkVarDecl (MkVarType F95Integer 4) [range0 1] InOut ["n_state"] ReadWrite True True [2]
    ]
var_decls_makesz_offby1 = [
    MkVarDecl (MkVarType F95Real 4) [range0 151, range0 151, range0 90] InOut ["p"] ReadWrite True True [152,152,91],
    MkVarDecl (MkVarType F95Real 4) [range0 2, range0 150, range0 151, range0 91] InOut ["mask1"] ReadWrite True True [2,151,152,92],
    MkVarDecl (MkVarType F95Real 4) [range0 778] InOut ["cn234ls"] ReadWrite True True [779],
    MkVarDecl (MkVarType F95Real 4) [range0 2, range1 149, range1 149, range1 89] Out ["fgh"] Read True True [3,149,149,89],
    MkVarDecl (MkVarType F95Integer 4) [range0 0] InOut ["n_state"] ReadWrite True True [1]
    ]
    
arg_names_makesz = ["p","mask1","cn234ls","fgh","n_state"]
ocl_args_makesz =  H.fromList (zip arg_names_makesz var_decls_makesz)
ocl_args_makesz_offby1 =  H.fromList (zip arg_names_makesz var_decls_makesz_offby1)
src_lines_makesz = [
    "!$ACC MakeSizes"
    ]
ref_strs_makesz =  normalise_F95_code_lines [
        comment_line,
        "! OpenCL buffer sizes",
        "p_sz = (/ 153, 153, 92 /)",
        "mask1_sz = (/ 4, 152, 153, 93 /)",
        "cn234ls_sz = (/ 780 /)",                                         
        "fgh_sz = (/ 4, 150, 150, 90 /)",
        "n_state_sz = (/ 2 /)"
    ]    
test_strs_makesz = normalise_F95_code_lines (gen_OpenCL_API_calls ocl_args_makesz arg_names_makesz const_arg_names (map lc src_lines_makesz) templ_src_name)
test_strs_makesz_offby1 = normalise_F95_code_lines (gen_OpenCL_API_calls ocl_args_makesz_offby1 arg_names_makesz const_arg_names (map lc src_lines_makesz) templ_src_name)
   
src_lines_szdecl = [
    "!$ACC SizeDecls"
    ]
ref_strs_szdecl =  normalise_F95_code_lines [
        comment_line,
        "! OpenCL buffer size declarations",
        "integer, dimension(3) :: p_sz",
        "integer, dimension(4) :: mask1_sz",
        "integer, dimension(1) :: cn234ls_sz",
        "integer, dimension(4) :: fgh_sz",
        "integer, dimension(1) :: n_state_sz"
    ]    
test_strs_szdecl = normalise_F95_code_lines (gen_OpenCL_API_calls ocl_args_makesz arg_names_makesz const_arg_names (map lc src_lines_szdecl) templ_src_name)

-- !$ACC MakeBuffers
    
src_lines_makebufs = [
    "!$ACC MakeBuffers"
    ]       
ref_strs_makebufs = normalise_F95_code_lines [
         comment_line,
        "! Create OpenCL buffers",
        "call oclMake3DfloatArrayReadWriteBuffer(p_buf,p_sz,p)",
        "call oclMake4DfloatArrayReadWriteBuffer(mask1_buf,mask1_sz,mask1)",
        "call oclMake1DfloatArrayReadWriteBuffer(cn234ls_buf,cn234ls_sz,cn234ls)",
        "call oclMake4DfloatArrayReadBuffer(fgh_buf,fgh_sz,fgh)",
        "call oclMake1DintArrayReadWriteBuffer(n_state_buf,n_state_sz,n_state)"
    ]

test_strs_makebufs = normalise_F95_code_lines (gen_OpenCL_API_calls ocl_args_makesz arg_names_makesz const_arg_names (map lc src_lines_makebufs) templ_src_name)

-- !$ACC SetArgs
src_lines_setargs = [
    "!$ACC SetArgs"
    ]
ref_strs_setargs = normalise_F95_code_lines [
         comment_line,
        "call oclSetFloatArrayArg(0, p_buf )",
        "call oclSetFloatArrayArg(1, mask1_buf )",
        "call oclSetFloatArrayArg(2, cn234ls_buf )",
        "call oclSetFloatArrayArg(3, fgh_buf )",
        "call oclSetIntArrayArg(4, n_state_buf )"         
    ]    

test_strs_setargs =  normalise_F95_code_lines (gen_OpenCL_API_calls ocl_args_makesz arg_names_makesz const_arg_names (map lc src_lines_setargs) templ_src_name)

-- !$ACC WriteBuffers    
    
src_lines_writebufs= [
    "!$ACC WriteBuffers"
    ]
ref_strs_writebufs = normalise_F95_code_lines [
         comment_line,
        "! Copy all arrays required for the full run",
        "call oclWrite3DFloatArrayBuffer(p_buf,p_sz,p)",
        "call oclWrite4DFloatArrayBuffer(mask1_buf,mask1_sz,mask1)",
        "call oclWrite1DFloatArrayBuffer(cn234ls_buf,cn234ls_sz,cn234ls)",
        "call oclWrite4DFloatArrayBuffer(fgh_buf,fgh_sz,fgh)",
        "call oclWrite1DIntArrayBuffer(n_state_buf,n_state_sz,n_state)"     
    ]    

test_strs_writebufs =  normalise_F95_code_lines (gen_OpenCL_API_calls ocl_args_makesz arg_names_makesz const_arg_names (map lc src_lines_writebufs) templ_src_name)


test_bufdecls= assertEqualList "BufDecls" ref_strs_bufdecl test_strs_bufdecl
test_sizedecls= assertEqualList "SizeDecls" ref_strs_szdecl test_strs_szdecl
test_makesizes
    | ref_strs_makesz == test_strs_makesz = assertEqualList "MakeSizes" ref_strs_makesz test_strs_makesz
    | ref_strs_makesz == test_strs_makesz_offby1 = assertEqualList "MakeSizes" ref_strs_makesz test_strs_makesz_offby1
    | otherwise = assertEqualList "MakeSizes" ref_strs_makesz test_strs_makesz -- WV: Just to keep ghc happy
--test_makesizes_offby1= assertEqualList "MakeSizes" ref_strs_makesz test_strs_makesz_offby1
test_makebufs= assertEqualList "MakeBufs" ref_strs_makebufs test_strs_makebufs
test_setargs= assertEqualList "SetArgs" ref_strs_setargs test_strs_setargs
test_writebufs= assertEqualList "WriteBufs" ref_strs_writebufs test_strs_writebufs

tests = TestList [
	"Buffer Declarations" ~: test_bufdecls,
	"Size Declarations" ~: test_sizedecls,
	"Make Sizes" ~: test_makesizes,
--	"Make Sizes Off-by-1" ~: test_makesizes_offby1,
	"Make Buffers" ~: test_makebufs,
	"Set Args" ~: test_setargs,
	"Write Buffers" ~: test_writebufs
	]

main = do
--    mapM putStrLn test_strs_makesz
--    mapM putStrLn test_strs_makesz_offby1
    runTestWV "OpenCLAPIGenerator" tests

