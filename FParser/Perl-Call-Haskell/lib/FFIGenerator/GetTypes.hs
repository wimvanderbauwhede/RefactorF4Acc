module FFIGenerator.GetTypes ( getFFITypes, hasSimpleSig, getTypes )
where    
import Data.Typeable

getTypes f = 
 let
    tf = typeOf f
    typestr = show tf
 in    
    (filter (/= "->") (words typestr), typeRepSplit tf [])

convertToCType t 
    | t == "Int" = "CLong"
    | t == "Double" = "CDouble"
    | t == "[Char]" = "CString"
    | t == "String" = "CString"
    | otherwise = "serialise" -- error $ "Type "++t++" not supported"

hasSimpleSig f = 
    let
        tts =map convertToCType (fst (getTypes f))
    in
        foldl (&&) True (map (/= "serialise") tts)
             
getFFITypes f 
  | hasSimpleSig f = 
    let
        tts =map convertToCType (fst (getTypes f))
        res = last tts
    in
        (init tts)++["IO "++res]
  | otherwise = ["CString","IO CString"]

typeRepSplit :: TypeRep -> [TypeRep] -> [TypeRep]
typeRepSplit tr trls =
    let
        trtc = typeRepTyCon tr
        tra = typeRepArgs tr
    in    
       if (show trtc) == "(->)" 
         then typeRepSplit (last tra) (trls++(init tra)) 
         else trls++[tr]