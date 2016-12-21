module F95OpenACCParser (
extract_OpenACC_regions_from_F95_src
) where
import Text.Regex.TDFA

extract_OpenACC_regions_from_F95_src :: [String] -> ([String],[String],[String])
extract_OpenACC_regions_from_F95_src in_src_lines = 
    let
        in_args=False
        in_const_args=False
        arg_lines=[]
        const_arg_lines=[]
        par_lines = []
    in
        rec_helper in_args in_const_args arg_lines const_arg_lines par_lines in_src_lines         

rec_helper in_args  in_const_args arg_lines const_arg_lines par_lines [] = (arg_lines,const_arg_lines,par_lines)         
rec_helper in_args  in_const_args arg_lines const_arg_lines par_lines in_src_lines 
    | line =~ "^ *$" :: Bool -- ignore blank lines
        = rec_helper in_args in_const_args arg_lines const_arg_lines par_lines r_src_lines 
	| (line =~ "^ *[c*!]" :: Bool) && not (line =~ "^\\s*!\\s*\\$" :: Bool) -- Ignore comments that don't start with /^\s*!\s*\$/
        = rec_helper in_args in_const_args arg_lines const_arg_lines par_lines r_src_lines 
    -- | line =~ ", {0,1}parameter {1,4}:{2}" :: Bool -- parameter declaration
    | (line =~ ", {0,1}parameter {1,4}" :: Bool) && (line =~ ":{2}" :: Bool)  -- parameter declaration
        = rec_helper in_args  in_const_args arg_lines const_arg_lines (par_lines++[line]) r_src_lines
    | line =~ "^!\\$acc arguments" :: Bool -- FIXME: support /i
        = rec_helper True in_const_args arg_lines const_arg_lines par_lines r_src_lines 
    | line =~ "^!\\$acc end arguments" :: Bool 
        = rec_helper False in_const_args arg_lines const_arg_lines par_lines r_src_lines 
    | in_args = rec_helper in_args  in_const_args (arg_lines++[line]) const_arg_lines par_lines r_src_lines
    | line =~ "^!\\$acc constarguments" :: Bool -- FIXME: support /i
        = rec_helper in_args True arg_lines const_arg_lines par_lines r_src_lines 
    | line =~ "^!\\$acc end constarguments" :: Bool 
        = rec_helper in_args False arg_lines const_arg_lines par_lines r_src_lines 
    | in_const_args = rec_helper False True arg_lines (const_arg_lines++[line]) par_lines r_src_lines
    | length r_src_lines == 0 
        =  (arg_lines,const_arg_lines,par_lines)
    | otherwise = rec_helper in_args in_const_args arg_lines const_arg_lines par_lines r_src_lines
    where
        line:r_src_lines = in_src_lines
        

