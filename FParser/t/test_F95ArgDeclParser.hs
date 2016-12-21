import F95VarDeclParser -- ( parse_F95_arg_decl, print_parsed_F95_arg_decl )
import F95ParserCommon -- ( parse_F95_arg_decl, print_parsed_F95_arg_decl )
import Test.HUnit
import RunTestWV
import NormaliseF95Code
import System.Process
import F95ArgDeclParserTestRefs

ex_expr= [ "x+1" ,"2-y2", "2*x","2*(x+1)","2+x*y", "-1*(x+y)","-(1*(x+y))"] 
ex_range = [ "ip:5", "0:1","0:x","x:y","-1:x+1"]
ex_range_part = [ "0:1","0:x","x:y","-1:x+1","0","x","x+y","ip+1"]
ex_dim = [
    "dimension(ip)",
    "dimension(ip+1)",
    "dimension(0:ip+1)",
    "dimension(-1:jp+1)",
    "dimension(ip,jp,kp)",
    "dimension(ip+1,jp+1,kp+1)",
    "dimension(0:ip+1,-1:jp+1,-1:kp+1)"
    ]
ex_intent = [ "intent(in)","intent (out)", "intent ( inout )"    ]
ex_argdecls = [
    "        real(kind=4), dimension(ip,jp,kp)  :: u",
    "        real(8), dimension(ip,jp,kp), intent(in)  :: uin",
    "        real(kind=4), dimension(ip+1,jp+1,kp+1)  :: v",
    "        real(kind=4), dimension(0:ip+1,-1:jp+1,-1:kp+1)  :: w",
    "        integer, dimension(0:ip+1,0:jp+1,0:kp+1)  :: t1 !$acc argmode read",
    "        integer(kind=8), dimension(0:ip+1,0:jp+1,0:kp+1)  :: t1,t2,t3 !$acc argmode read"
    ]
ex_type =[ "real(kind=4)","real","integer","integer(8)", "real ( kind = 8 )"]
ex_arglst = [ ":: p",":: u,v,w", "::fold, gold, h42"]
ex_ocl_argmode = [ "!$acc argmode read", "!$acc argmode write","!$acc argmode readwrite"]    

parse_F95_arg_decl = run_parser
test_expr_parser = assertEqualList "expr_parser" expr_parser_tests  (map (parse_F95_arg_decl expr_parser) ex_expr)
test_range_expr = assertEqualList "range_expr" range_expr_tests  (map (parse_F95_arg_decl range_expr) ex_range)
test_range_parser = assertEqualList "range_parser" range_parser_tests  (map (parse_F95_arg_decl range_parser) ex_range_part)
test_dim_parser = assertEqualList "dim_parser" dim_parser_tests  (map (parse_F95_arg_decl dim_parser) ex_dim)
test_intent_parser = assertEqualList "intent_parser" intent_parser_tests  (map (parse_F95_arg_decl intent_parser) ex_intent)
test_type_parser = assertEqualList "type_parser" type_parser_tests  (map (parse_F95_arg_decl type_parser) ex_type)
test_arglist_parser = assertEqualList "arglist_parser" arglist_parser_tests  (map (parse_F95_arg_decl (arglist_parser_wrapper arglist_parser)) ex_arglst)
test_ocl_argmode_parser = assertEqualList "ocl_argmode_parser" ocl_argmode_parser_tests  (map (parse_F95_arg_decl ocl_argmode_parser) ex_ocl_argmode)
test_f95_var_decl_parser = assertEqualList "f95_var_decl_parser" f95_arg_decl_parser_tests  (map (parse_F95_arg_decl f95_var_decl_parser) ex_argdecls)

tests = TestList [
    "expr_parser" ~: test_expr_parser
    ,"range_expr" ~: test_range_expr      
    ,"range_parser" ~: test_range_parser      
    ,"dim_parser" ~: test_dim_parser      
    ,"intent_parser" ~: test_intent_parser      
    ,"type_parser" ~: test_type_parser      
    ,"arglist_parser" ~: test_arglist_parser
    ,"ocl_argmode_parser" ~: test_ocl_argmode_parser
    ,"f95_var_decl_parser" ~: test_f95_var_decl_parser
      ]

main = do
    runTestWV "F95ArgDeclParser" tests
{-
    putStrLn $ show $ (run_parser expr_parser "(3+4)")
    putStrLn $ show $ (run_parser expr_parser "x+(3+4)-y*z*(-1+4)")
    putStrLn $ show $ (run_parser expr_parser "5*(3+4)")
    putStrLn $ show $ (run_parser expr_parser "(x+4)")
    putStrLn $ show $ (run_parser expr_parser "x+4")
    putStrLn $ show $ (run_parser expr_parser "-1*(3+4)")
    putStrLn $ show $ (run_parser expr_parser "(3-4*z)")
-}    
{-
print_parsed_F95_arg_decl p str = run_parser_print p str
main_ref = do
    putStrLn "expr_parser_tests = ["
    mapM (\x -> putStrLn ("-- "++x) >> print_parsed_F95_arg_decl expr_parser x) ex_expr
    putStrLn "    ]\nrange_expr_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl range_expr x) ex_range
    putStrLn "    ]\nrange_parser_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl range_parser x) ex_range_part
    putStrLn "    ]\ndim_parser_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl dim_parser x) ex_dim
    putStrLn "    ]\nintent_parser_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl intent_parser x) ex_intent
    putStrLn "    ]\ntype_parser_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl type_parser x) ex_type
    putStrLn "    ]\narglist_parser_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl arglist_parser x) ex_arglst
    putStrLn "    ]\nocl_argmode_parser_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl ocl_argmode_parser x) ex_ocl_argmode
    putStrLn "    ]\nf95_var_decl_parser_tests = ["
    mapM (\x -> putStrLn  ("-- "++x) >> print_parsed_F95_arg_decl f95_var_decl_parser x) ex_argdecls
    putStrLn "    ]"
-}
