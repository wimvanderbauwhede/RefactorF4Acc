module F95OpenACCParser (
    extract_OpenACC_regions_from_F95_src
) where
import Text.Regex.Posix -- suggest use of regular expressions

-- given the source code as a list of lines (strings), extract the OpenACC regions for Arguments and ConstArguments as well as the parameter declarations (i.e. _any_ variable declaration with the parameter attribute), and return them as a tuple of three lists of strings, in that order.
extract_OpenACC_regions_from_F95_src :: [String] -> ([String],[String],[String])
extract_OpenACC_regions_from_F95_src in_src_lines = ([],[],[])
  
