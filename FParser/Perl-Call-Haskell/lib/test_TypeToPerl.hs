module Main where
import FFIGenerator.TypeToPerl

s5= "([Char],[Int],(Maybe Int),TTup,(Map [Char] Int)) -> IO Int"
s1= "([Char],[Int],TTup,(Maybe Int)) -> String"
s2 ="Bool -> Bool"
s3 = "(String,Int)"
s4="[Bool] -> Bool"
main = do
    print $  typeToPerl s1
    print $  typeToPerl s5
    print $  typeToPerl s2
    print $  typeToPerl s3
    print $  typeToPerl s4

