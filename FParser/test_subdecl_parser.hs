module Main where
import F95SrcIO ( read_F95_src, write_F95_src )
import F95SubDeclParser ( f95_sub_decl_parser )
import qualified Data.Map as H
import F95ParserCommon

templ_src_name=  "test_sub_decl.f95"

      
main = do
    templ_src_lines <- read_F95_src templ_src_name 
    let
        sub_decl = run_parser f95_sub_decl_parser (unlines templ_src_lines)
    putStrLn $ show sub_decl 
