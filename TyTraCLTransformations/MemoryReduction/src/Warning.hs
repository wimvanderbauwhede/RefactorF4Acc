{-
I got fed up with the lack of diagnostics. This function prints a warning and returns the value.    
-}

module Warning (
        warning
) where 

import System.IO.Unsafe (unsafePerformIO)

warning :: a -> String -> a
warning val str = unsafePerformIO $ do
    putStrLn str
    return val
