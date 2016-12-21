module F95OpenACCParser (
    extract_OpenACC_regions_from_F95_src
) where
import Text.Regex.Posix -- suggest use of regular expressions

-- Takes the source code as list of strings and returns a list of the lines containing variable declarations identified as Arguments and ConstArguments and parameter declarations, in that order
extract_OpenACC_regions_from_F95_src :: [String] -> ([String],[String],[String])
extract_OpenACC_regions_from_F95_src in_src_lines = ([],[],[])
  
