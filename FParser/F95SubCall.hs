module F95SubCall (
        SubCall
        )
    where
import F95VarCall

data SubCall = MkSubCall {
	sd_name :: String
    ,sd_arglst :: [String]
} deriving (Eq, Ord, Show)


