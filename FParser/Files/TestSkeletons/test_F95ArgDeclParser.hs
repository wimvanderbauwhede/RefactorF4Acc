import F95VarDeclParser 
import Test.HUnit
import System.Process
import F95ArgDeclParserTestRefs  -- provides *_parser_tests, these are the correct results for each parse. 

-- Populate with lists of strings to test the various parsers
ex_expr= [ "" ]
ex_range = [ "" ]
ex_range_part = [ "" ]
ex_dim = [ "" ]
ex_intent =[ "" ]
ex_argdecls = [ "" ]
ex_type =[ "" ]
ex_arglst = [ "" ]
ex_ocl_argmode = [ "" ]

parse_F95_arg_decl = run_parser

test_expr_parser = assertEqual "expr_parser" expr_parser_tests  (map (parse_F95_arg_decl expr_parser) ex_expr)
test_range_expr = assertEqual "range_expr" range_expr_tests  (map (parse_F95_arg_decl range_expr) ex_range)
test_range_parser = assertEqual "range_parser" range_parser_tests  (map (parse_F95_arg_decl range_parser) ex_range_part)
test_dim_parser = assertEqual "dim_parser" dim_parser_tests  (map (parse_F95_arg_decl dim_parser) ex_dim)
test_intent_parser = assertEqual "intent_parser" intent_parser_tests  (map (parse_F95_arg_decl intent_parser) ex_intent)
test_type_parser = assertEqual "type_parser" type_parser_tests  (map (parse_F95_arg_decl type_parser) ex_type)
test_arglist_parser = assertEqual "arglist_parser" arglist_parser_tests  (map (parse_F95_arg_decl arglist_parser) ex_arglst)
test_ocl_argmode_parser = assertEqual "ocl_argmode_parser" ocl_argmode_parser_tests  (map (parse_F95_arg_decl ocl_argmode_parser) ex_ocl_argmode)
test_f95_arg_decl_parser = assertEqual "f95_var_decl_parser" f95_arg_decl_parser_tests  (map (parse_F95_arg_decl f95_var_decl_parser) ex_argdecls)

tests = TestList [
    "expr_parser" ~: test_expr_parser
    ,"range_expr" ~: test_range_expr      
    ,"range_parser" ~: test_range_parser      
    ,"dim_parser" ~: test_dim_parser      
    ,"intent_parser" ~: test_intent_parser      
    ,"type_parser" ~: test_type_parser      
    ,"arglist_parser" ~: test_arglist_parser
    ,"ocl_argmode_parser" ~: test_ocl_argmode_parser
    ,"f95_var_decl_parser" ~: test_f95_arg_decl_parser
      ]

main = runTestTT tests

