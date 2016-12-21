module F95SrcIO (
		read_F95_src,
        write_F95_src
) where
import Data.Char (toLower)
-- Fortran is case-insensitive so turn everything into lowercase
lc = map toLower
read_F95_src :: String -> IO [String]
read_F95_src src_name = return ["DUMMY!"]

write_F95_src :: String -> [String] -> IO ()
write_F95_src src_name src_lines =  putStrLn "DUMMY!"

    
