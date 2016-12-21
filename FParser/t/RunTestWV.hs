module RunTestWV (runTestWV, assertEqualList, assertEqualListTuple) where
import Test.HUnit
import System.IO (Handle, stderr, stdout, hPutStr, hPutStrLn)

runTestWV label test = do
    c <- runTestText (putTextToHandle stderr False) test -- (TestCase test)
    let
        cc =  fst c
        ccs = [cases cc, tried cc, errors cc, failures cc]
    putStrLn $ label++" test: " ++ unwords (map show ccs)

assertEqualList str l1 l2 = map (\(t,r) -> assertEqual str t r) (zip l1 l2)
assertEqualListTuple str (l11,l12,l13) (l21,l22,l23) = [
        map (\(t,r) -> assertEqual str t r) (zip l11 l21),
        map (\(t,r) -> assertEqual str t r) (zip l12 l22),
        map (\(t,r) -> assertEqual str t r) (zip l13 l23)
    ]
    
