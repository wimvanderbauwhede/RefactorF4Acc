module F95Preprocess (join_lines) where
import qualified Data.Text as T
import F95SrcIO (read_F95_src)

-- import module content
import_module_content src_lines = src_lines
{- 
This is more complicated:
- find "use <module_name>" lines
- open the module
- in principle, import all module-level variables, means we have to parse those first
- easier, import all parameter declarations
-}
    
-- split lines that have multiple statements with ';'    
split_lines :: [String] -> [String]
split_lines src_lines = src_lines

-- when a line contains &, we should add the next line:
join_lines :: [String] -> [String]
join_lines src_lines = 
    let
        (joined_lines,_)  = foldl create_joint_line ([],"")  src_lines
    in
        joined_lines

create_joint_line (new_lines,joint_line) line = let
        trimmed_line = T.unpack $ T.strip (T.pack line)
        res
         | trimmed_line == [] = (new_lines,joint_line)
         | last trimmed_line == '&' = (new_lines,joint_line++(init trimmed_line))
         | joint_line /= "" = (new_lines++[joint_line++trimmed_line],"")
         | joint_line == "" = (new_lines++[line],"")
    in 
        res
        
main = do
    src_lines <- read_F95_src "module_LES_ocl_TEMPL.f95"
    let
        joined_lines = join_lines src_lines
    mapM putStrLn joined_lines
