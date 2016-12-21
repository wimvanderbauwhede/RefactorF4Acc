module F95SrcIO (
		read_F95_src,
        write_F95_src
) where
import Data.Char (toLower)
-- Fortran is case-insensitive so turn everything into lowercase
lc = map toLower
read_F95_src :: String -> IO [String]
read_F95_src src_name = do
    src <- readFile src_name
    let
        src_lines = lines $ lc src
    return src_lines

write_F95_src :: String -> [String] -> IO ()
write_F95_src src_name src_lines =  do
    let
        src = unlines src_lines
    writeFile src_name src

    
