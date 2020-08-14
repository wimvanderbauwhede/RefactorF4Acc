{-# LANGUAGE RankNTypes #-}
data FType = FInteger | FReal | FComplex | FLogical | FCharacter deriving (Eq, Show)
type FKind = Int

data Array = Array {
         arrayType ::(FType,FKind) 
        ,arrayDim :: [(Integer,Integer)] 
--        ,arrayVals :: [a]
    }


integer = FInteger
real = FReal
complex = FComplex
logical = FLogical
character = FCharacter

ftype = fst
fkind = snd

mkArray integer 4 dim = Array (integer,4) dim -- []

arrayRank = length . arrayDim 
shape =  (map (\(s,e) -> e-s+1)) . arrayDim
size :: Array -> Int
size = fromInteger . product . shape
dimFromShape = (map (\s -> (1,s))) . shape 
reshape array shape = array{arrayDim=dimFromShape array}

mkScalar t k =  mkArray t k []

data CommonBlock  = CommonBlock {
     commonSequence :: [Array]
--    ,commonStorage :: [Char]
}

arrayToScalars :: Array -> [Array]
arrayToScalars a@(Array t dimtups) 
    | ftype t == complex =
        take (2*(size a)) $ repeat (Array (real, fkind t) [])
    | otherwise = take (size a) $ repeat (Array t [])

typeableCommonSequence cb = concatMap arrayToScalars (commonSequence cb)

typecheckCommonBlock ccb lcb = let
    ctcs = typeableCommonSequence ccb
    ltcs = typeableCommonSequence lcb
    in
            (length ltcs <= length ctcs) 
        && null (filter typeCheck  (zip ctcs ltcs))

typeCheck (elt1,elt2) = True

main = return ()
