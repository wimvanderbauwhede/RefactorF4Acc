import F95SrcIO
import NormaliseF95Code (normalise_F95_code)
import Text.Regex.TDFA

src_name = "../module_LES_ocl.f95"    
src_name_ref = "module_LES_ocl_REF.f95"    
main = do
    src_lines <- read_F95_src src_name
    src_lines_ref <- read_F95_src src_name_ref
    let
        n_src_lines = filter (\line -> (line /="" && head line /= '!')) (map normalise_F95_code src_lines)
        n_src_lines_ref = filter (\line -> (line /="" && head line /= '!'))  (map normalise_F95_code src_lines_ref)
--    putStrLn "GEN"
    cmps <- mapM compare_line (zip n_src_lines n_src_lines_ref)   
    let 
        res = sum cmps
        tot = length cmps
    putStrLn $ "Main test: non-matching lines: " ++ show res ++ "/" ++ show tot
    
compare_line (test_line, ref_line)
    | test_line /= ref_line = 
        if ((test_line =~ "shape" :: Bool) || (ref_line =~ "shape" :: Bool))
            then
                return 0
            else do
                putStrLn $ "NOK! " ++ test_line ++ " <> " ++ ref_line
                return 1
    | otherwise = do 
--        putStrLn $ "OK! " ++ ref_line
        return 0
