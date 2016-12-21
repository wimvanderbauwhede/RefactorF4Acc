module OpenCLAPIGenerator (
gen_OpenCL_API_calls
        ) where
import F95Types
--import F95ArgDeclParser ( parse_F95_arg_decl)
import Text.Regex.TDFA
import Data.Char
import Data.List (intercalate)
import qualified Data.Map as H (lookup) 
import System.Process
import System.IO.Unsafe (unsafePerformIO)

gen_OpenCL_API_calls :: ArgTable -> [VarName] -> [VarName] -> [SrcLine] -> FileName -> [SrcLine]  
gen_OpenCL_API_calls ocl_args arg_names const_arg_names src_lines templ_src_name =
    let
        gen_src_lines= foldl 
            gen_code 
            [
                "!!! This code was generated on " ++ localtime ++" from " ++ templ_src_name ++ " gen_OpenCL_API_calls ",
                "!!! DO NOT EDIT !!! Edit "++templ_src_name++" instead, and regenerate."
            ] 
            src_lines
            where
                b8 = take 8 $ repeat ' '
                gen_code gen_src_lines line 
                    | not (line =~ "^!\\$acc" :: Bool) = gen_src_lines ++ [line]
                    | line =~ "^!\\$acc bufdecls" = gen_src_lines ++ [ "! OpenCL buffer declarations"] 
                        ++ map (\an->b8++"integer(8) :: "++an++"_buf") arg_names
                    | line =~ "^!\\$acc sizedecls" = gen_src_lines ++ [b8 ++ "! OpenCL buffer size declarations"]
                        ++ map ( \an -> 
                                 let 
                                    dim = case H.lookup an ocl_args of
                                        Just arg -> length $ vd_dimension arg
                                        Nothing -> error $ "Could not find "++an
                                 in
                                    (b8++"integer, dimension("++(show dim)++") :: "++an++"_sz")
                            ) arg_names
                    | line =~ "^!\\$acc makesizes" = 
                        let 
                            const_array_from_range ocl_args an = 
                                let 
                                    vd = case H.lookup an ocl_args of
                                        Just vd -> vd
                                        Nothing -> error $ "No entry for " ++ an
--                                    ranges = vd_dimension vd
--                                    sizes = map ( show . (\(Const n) -> n+1) . r_stop ) ranges
                                    sizes = vd_shape vd
                                in   
                                     "(/ " ++ (intercalate ", " (map show sizes)) ++ " /)"
                            sz_expr ocl_args an 
                                | let
                                      vd = case H.lookup an ocl_args of
                                        Just vd_ -> vd_
                                        Nothing -> error $ "No entry for " ++ an                                        
                                  in  
                                      vd_has_const_ranges vd = const_array_from_range ocl_args an 
                                | otherwise = "shape("++an++")"
                        in
                            gen_src_lines
                            ++ [b8 ++ "! OpenCL buffer sizes"]
                            ++ map (\an->(b8++an++"_sz = "++(sz_expr ocl_args an))) arg_names
                        -- If an has a fully-const dim, generate a const array instead
                    | line =~ "^!\\$acc makebuffers" = gen_src_lines
                        ++ [b8 ++ "! Create OpenCL buffers"]
                        ++map (
                            \an-> let 
                                    arg_rec = case H.lookup an ocl_args of
                                        Just argrec -> argrec
                                        Nothing -> error $ "Could not find "++an
                                    dimstr = show $ length $ vd_dimension arg_rec    
                                    ctype = get_c_type $ vd_vartype arg_rec
                                    argmodestr = show $ vd_argmode arg_rec                                    
                                in
                                    (b8++"call oclMake"++dimstr++"D"++ctype++"Array"++argmodestr++"Buffer("++an++"_buf,"++an++"_sz,"++an++")")
                              ) arg_names
                    | line =~ "^!\\$acc setargs" = gen_src_lines ++ [b8 ++ "! Set OpenCL argument order" ] ++ (
                            let
                                gen_set_code (gen_src_lines,argpos) an = 
                                    let                        
                                        arg_rec = case H.lookup an ocl_args of
                                            Just argrec -> argrec
                                            Nothing -> error $ "Could not find "++an
                                        ctype = ucfirst $ get_c_type $ vd_vartype arg_rec
                                        str = b8 ++"call oclSet"++ctype++"ArrayArg("++(show argpos)++", "++an++"_buf )"
                                    in
                                        (gen_src_lines++[str],argpos+1)
                                gen_set_const_code (gen_src_lines,argpos) const_an = 
                                    let                        
                                        arg_rec = case H.lookup const_an ocl_args of
                                            Just argrec -> argrec
                                            Nothing -> error $ "Could not find "++const_an
                                        ctype = ucfirst $ get_c_type $ vd_vartype arg_rec
                                        str = b8 ++ "call oclSet"++ctype++"ConstArg("++(show argpos)++", "++const_an++" )"
                                    in
                                        (gen_src_lines++[str],argpos+1)
                                (arg_strs,argpos) = foldl gen_set_code ([],0) arg_names
                                (const_arg_strs,_) = foldl gen_set_const_code ([],argpos) const_arg_names
                                strs = arg_strs ++ const_arg_strs
                            in
                                strs
                                )
                    | line =~ "^!\\$acc writebuffers" = gen_src_lines ++ [b8 ++ "! Copy all arrays required for the full run"] ++ (
                            let
                                strs = foldl (\gen_src_lines an -> let                        
                                                arg_rec = case H.lookup an ocl_args of
                                                    Just argrec -> argrec
                                                    Nothing -> error $ "Could not find "++an
                                                dim = length $ vd_dimension arg_rec
                                                ctype = ucfirst $ get_c_type $ vd_vartype arg_rec
                                            in
                                                if vd_argmode arg_rec /= Write 
                                                    then
                                                        gen_src_lines ++[b8 ++ "call oclWrite"++(show dim)++"D"++ctype++"ArrayBuffer("++an++"_buf,"++an++"_sz,"++an++")"]
                                                    else
                                                        gen_src_lines
                                    ) [] arg_names
                            in
                                strs
                                )
                    | otherwise  = gen_src_lines -- ++ [line]
    in
        gen_src_lines
-- END of gen_OpenCL_API_calls()
{-
get_c_type_NOGOOD ftype wordsz=
    if wordsz==4 
        then
            if ftype == "real" then "float" else if ftype == "integer" then "int" else error "Unknown type "++ftype
        else 
            if wordsz==8 
                then 
                    if ftype == "real" then "double" else if type == "integer" then "long" else  error "Unknown type "++ftype
                else 
                    error "Unknown word size "++wordsz
-}
get_c_type (MkVarType F95Real wsz)
    | wsz == 4 = "float"
    | wsz == 8 = "double"
    | otherwise =  error $ "Unknown word size "++(show wsz)
get_c_type (MkVarType F95Integer wsz)
    | wsz == 4 = "int"
    | wsz == 8 = "long"
    | otherwise =  error $ "Unknown word size "++(show wsz)

                
ucfirst (x:xs)  = (toUpper x):xs

localtime = filter (/='\n') (unsafePerformIO $ readProcess "/bin/date" [] [])

