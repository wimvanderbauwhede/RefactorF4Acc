module NormaliseF95Code (normalise_F95_code,normalise_F95_code_lines)
where
import Data.Char

normalise_F95_code line = filter (\c -> (not $ isSpace c) && (not $ isSeparator c) && c/= '\t' && c/= '\r' && c/='\n') (map toLower line)

normalise_F95_code_lines src_lines = filter (\line -> (line /="" && head line /= '!'))  (map normalise_F95_code src_lines)
