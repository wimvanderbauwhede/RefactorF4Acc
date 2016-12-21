module Main where
import F95SrcIO ( read_F95_src, write_F95_src )
import F95OpenACCParser ( extract_OpenACC_regions_from_F95_src )
import F95VarDeclParser ( f95_var_decl_parser )
import F95ParDeclParser ( f95_par_decl_parser )
import F95ParserCommon ( run_parser )
import F95Types
import OpenCLAPIGenerator ( gen_OpenCL_API_calls )
import EvalExpr    
import qualified Data.Map as H

{-

Sequence of actions:

 1/ detect arguments and argmodes, make a list of arguments

 2/ detect entry for new declarations for buffers and sizes generate code and insert there

 3/ detect entry for API calls generate code and insert there

* I should incorporate this into rf4a 
* In fact, I should stick to the OpenACC standard. However, instead I'm defining these:

!ACC Arguments
...
!ACC End Arguments

!ACC ArgMode [Read|Write|ReadWrite]

!ACC 

-}

templ_src_name=  "module_LES_ocl_TEMPL.f95"
gen_src_name = "module_LES_ocl.f95"

      
-- ###############################################################################
-- Code for parsing the argument declarations

parse_arg_decls :: [VarDeclLine] -> [VarDeclLine] -> (H.Map VarName VarDecl,[VarName],[VarName])
parse_arg_decls arg_lines const_arg_lines = let
    (arg_names,ocl_args) = foldl (\an_oa_tup line -> 
            let
                (arg_names,ocl_args)=an_oa_tup
                pt = run_parser f95_var_decl_parser line
                var_names = vd_varlist pt
                arg_names'= arg_names ++ var_names
                ocl_args' = foldl (\ocl_args arg_name -> H.insert arg_name pt ocl_args) ocl_args var_names
            in
                (arg_names',ocl_args')
        ) ([],H.empty) arg_lines
    (const_arg_names,ocl_args') = foldl (\an_coa_tup line -> 
            let
                (const_arg_names,ocl_args)=an_coa_tup
                pt = run_parser f95_var_decl_parser line
                var_names = vd_varlist pt
                arg_names'= arg_names ++ var_names
                ocl_args' = foldl (\ocl_args arg_name -> H.insert arg_name pt ocl_args) ocl_args var_names
            in
                (arg_names',ocl_args')
        ) ([],ocl_args) const_arg_lines

    in 
        (ocl_args',arg_names,const_arg_names)
-- end parse_arg_decls()
parse_par_decls par_lines = foldl (
    \par_table line ->
            let
                par_decl = run_parser f95_par_decl_parser line
                par_name = pd_parname par_decl
                par_val = pd_parval par_decl
            in
                H.insert par_name par_val par_table 
    ) H.empty par_lines

{-
Now, the aim is to look at every dimension range and see if we can compute the total size
In order to do so, in this particular case, we only need to find parameter values and substitute them. 
In general, it could be that there are non-parameter variables in the expression I think.
Anyway, what it means is that for all ocl_args, we need to evaluate the expressions, but we can do it context-free, in other words

ocl_arg_sizes :: [(VarName,Integer)]
ocl_arg_sizes = map (eval_range_expr ocl_args par_table) (keys ocl_args) 
    
And of course we don't need to do this for the constant arguments
-}

eval_range_expr :: ArgTable -> VarTable -> VarName -> (VarName, [Integer])
eval_range_expr ocl_args par_table var_name = 
    let
        var_rec = case H.lookup var_name ocl_args of
            Just vr -> vr
            Nothing -> error $ "Could not find "++var_name++" in ocl_args"
        ranges = vd_dimension var_rec
        sizes = map (\r -> let
                    (start,_) = eval (r_start r) par_table
                    (stop,_) = eval (r_stop r) par_table
                in
                    stop-start+1 ) ranges
    in
        (var_name,sizes)

update_vd_shape ocl_arg_sizes ocl_args arg_name =
    let
        ocl_arg_sizes_map = H.fromList ocl_arg_sizes
        sizes = case H.lookup arg_name ocl_arg_sizes_map of
            Just sz -> sz
            Nothing -> []
        var_decl = case H.lookup arg_name ocl_args of
            Just vd -> vd
            Nothing -> error $ "No entry for "++arg_name
--        const_ranges = map (\sz -> (MkRange (Const 0) (Const sz))) sizes
--        var_decl' = var_decl{vd_dimension = const_ranges}
        var_decl' = var_decl{vd_shape = sizes,vd_has_const_ranges=True}
    in    
        H.insert arg_name var_decl' ocl_args
-- ###############################
main = do
    templ_src_lines <- read_F95_src templ_src_name 
    let
        (arg_lines,const_arg_lines,par_lines) = extract_OpenACC_regions_from_F95_src templ_src_lines        
        par_table =  parse_par_decls par_lines
        (ocl_args,arg_names, const_arg_names) = parse_arg_decls arg_lines const_arg_lines
        -- somewhere here we need to eval the dim fields of the types of the arguments using the par_table
        ocl_arg_sizes = map (eval_range_expr ocl_args par_table) (H.keys ocl_args)
        -- so now put the sizes into the dim field, and assume they are all constant
        ocl_args' = foldl (update_vd_shape ocl_arg_sizes) ocl_args (H.keys ocl_args)
        gen_src_lines = gen_OpenCL_API_calls ocl_args' arg_names  const_arg_names templ_src_lines templ_src_name
--    putStrLn $ show (H.keys ocl_args)
--    mapM putStrLn arg_lines
--    mapM (putStrLn . show) ocl_arg_sizes
    write_F95_src gen_src_name gen_src_lines
