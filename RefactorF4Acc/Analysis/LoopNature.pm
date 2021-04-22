# Analyse loops in terms of map, fold and iterative as well as for stencils and halos
package RefactorF4Acc::Analysis::LoopNature;
# 
#   (c) 2021 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::FoldConstants qw( fold_constants );
use RefactorF4Acc::Analysis::VarAccessAnalysis qw( analyseAllVarAccesses );
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::LoopNature::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::LoopNature::EXPORT_OK = qw(
    analyse_loop_nature_all
    analyseLoopNature
);

# type SubroutineTable = DMap.Map SubNameStr SubRec -- (ProgUnit Anno, String)
# So this corresponds to $stref->{'Subroutines'}

# analyseLoopNature :: [String] -> SubroutineTable -> (SubroutineTable, [(String, String)]) -> String -> (SubroutineTable, [(String, String)])
# analyseLoopNature ioWriteSubroutines originalTable (accumSubTable, annoListing) subName = (newSubTable, annoListing ++ [(filename, parAnno)])
sub analyseLoopNature { # paralleliseProgUnit_foldl    
    my ($stref, $f) = @_;
    my $ioWriteSubroutines=[]; # This is a list of subs that do IO Write, a hack really 
    # my ($accumSubTable, $annoListing) =@{$accumSubTable_annoListing};
    
        # where
            my $Sf = $stref->{'Subroutines'}{$f}; # subrec; $stref->{'Subroutines'} is originalTable
            my $annlines =  $Sf->{'RefactoredCode'}; # progUnit = subAst subrec
            my $filename =  $Sf->{'Source'}; # subSrcFile subrec; we don't need this, we can use $f
            my $annlines_foldedConstants = fold_constants( $stref, $f);
            # my $accessAnalysis :: VarAccessAnalysis
            my $accessAnalysis = analyseAllVarAccesses($stref, $f, $ioWriteSubroutines, $annlines);
            # die;
            croak Dumper $accessAnalysis;
            # So I assume for every block this does paralleliseBlock
            my $parallelisedProgUnit = paralleliseBlock($stref, $f, $accessAnalysis, $annlines_foldedConstants);
            # everywhere( mkT(\&paralleliseBlock,$filename,$originalTable,$accessAnalysis), $annlines_foldedConstants);

            # my $parAnno = compileAnnotationListing $parallelisedProgUnit;
            # my $newSubTable = insert( $f, MkSubRec( $parallelisedProgUnit, $filename, []), $accumSubTable);

            # Instead of the above, we so
            $stref->{'Subroutines'}{$f}{'RefactoredCode'} = $parallelisedProgUnit;
            # However, what I am interested in is if a certain loop nest can become a map or fold
            # So I would update LoopNests or Blocks in $Sf with this information

        # return ($newSubTable, [@{$annoListing}, [$filename, $parAnno]]);
        return $stref;
}

#    Type used to colate data on variable accesses throughout a program.
#                        All reads     All writes
# type VarAccessRecord = ([SrcSpan],     [SrcSpan])
    
# WV: this map provides all read and write locations for a local variable
# type LocalVarAccessAnalysis = DMap.Map (VarName Anno) VarAccessRecord
# This is in fact quite the same as what I have done in ArrayAccessPatterns, the question is if I can run this first to get that info 
# So I am going to assume that ArrayAccesses gives me enough information

# WV: this map provides the expression(s) defining the local variable, I guess, so this would be assignments and should be args of subcalls with intent Out or InOut
# type LocalVarValueAnalysis = DMap.Map (VarName Anno) [(SrcSpan, Expr Anno)]
# LocalVarValueAnalysis is a table of the expressions for all local variables in a loop nest. This is Rhs of Assignment 
# (or SubroutineCall, but that is a no-go, this is why we have to inline all calls)
# This corresponds to ArrayAssignments (which is a bit of a misnomer now as it includes Scalar info as well )


# WV: I wonder if instead of [VarName Anno] a declaration would not have been better?
# WV: The list of LocalVarAccessAnalysis is an extenstion to deal with IO routines: [Kernel, IORoutines]
#                                                                            Subroutine arguments     Declared var names
# type VarAccessAnalysis = ([LocalVarAccessAnalysis],    LocalVarValueAnalysis, [VarName Anno],     [VarName Anno])
#
# subroutine args and declared var names we get from $Sf->{'Args'} and $Sf->{'Vars'} , the var accesses we have from ArrayAccesses and values from ArrayAssignments
# So the whole accessAnalysis is contained in $Sf


=pod
#    Since Language-Fortran does not seem to differentiate between function calls and array access, it was necessary
#    to find a way to identify a function call. This function achieves that. When an expression is passed in, a top level
#    VarNames is extracted (The possibility for multipe varnames is also dealt with here as the Language-Fortran
#    specification allows for this). A check to see whether this VarName was NOT declared at the top of the program is done 
#    and a check to see whether the expr in question contains other expressions is also performed. If both of these checks
#    pass then the expr is a function call. (The second check here comes from the fact that the arguments of a function call
#    are stored in a list inside the original expr. If there are no arguments to the function, a NullExpr
#    object can be found. For a normal scalar value, there would be absolutely nothing in this internal list, not even a 
#    NullExpr object)
#    WV: we also need to check for intrinsics using f95IntrinsicFunctions

# isFunctionCall :: [String] -> VarAccessAnalysis -> Expr Anno -> Bool
isFunctionCall intrinsics accessAnalysis expr =  (exprVarNameStr `elem` intrinsics  ) || ( (all (\x -> not (elem x declaredVarNames)) exprVarNames) && subVars /= [])
                        where
                            subVars = extractContainedVars expr -- not so sure if this also works on e.g. sqrt(5)
                            exprVarNames = extractVarNames expr -- in principle just 1 variable name?
                            exprVarNameStr = if length exprVarNames > 0 
                                then
                                    let 
                                        VarName _ exprVarNameStr = head exprVarNames
                                    in
                                        exprVarNameStr
                                else ""   
                            declaredVarNames = (\(_,_,_,x) -> x) accessAnalysis -- all var names declared at toplevel

# isFunctionCall_varNames :: [String] -> [VarName Anno] -> Expr Anno -> Bool
isFunctionCall_varNames intrinsics declaredVarNames expr =  (exprVarNameStr `elem` intrinsics  ) || ( (all (\x -> not (elem x declaredVarNames)) exprVarNames) && subVars /= [] )
                        where
                            exprVarNameStr = if length exprVarNames > 0 
                                then 
                                    let
                                        VarName _ exprVarNameStr = head exprVarNames
                                    in
                                        exprVarNameStr     
                                else ""
                            subVars = extractContainedVars expr
                            exprVarNames = extractVarNames expr

# isNullExpr :: Expr Anno -> Bool
isNullExpr (NullExpr _ _) = True
isNullExpr _ = False

# getAccessLocationsInsideSrcSpan :: VarAccessAnalysis -> VarName Anno -> SrcSpan -> ([SrcSpan], [SrcSpan])
getAccessLocationsInsideSrcSpan accessAnalysis accessVar src = (readsInside, writesInside)
        where
            localVarAccesses = (getAccessesInsideSrcSpan ((\(x:xs,_,_,_) -> x) accessAnalysis) src)
            -- (reads, writes) = DMap.findWithDefault (error "getAccessLocationsBeforeSrcSpan: doesn't exist") accessVar localVarAccesses

            (readsInside, writesInside) = DMap.findWithDefault ([], []) accessVar localVarAccesses
            -- readsInside = filter (\x -> checkSrcSpanContainsSrcSpan src x) reads
            -- writesInside = filter (\x -> checkSrcSpanContainsSrcSpan src x) writes

# getAccessesBetweenSrcSpansIgnore :: VarAccessAnalysis -> SrcSpan -> SrcSpan -> [SrcSpan] -> ([VarName Anno], [VarName Anno])
getAccessesBetweenSrcSpansIgnore accessAnalysis (_,startLoc) (endLoc,_) skipSrcs = getAccessesBetweenManySrcSpans accessAnalysis allowedSrcSpans -- ([], [])
        where
            sortedSkipSrcs = sortBy srcSpanCompare skipSrcs
            allowedSrcSpans = getAccessesBetweenSrcSpansIgnoreBuildSrcSpans startLoc endLoc skipSrcs

getAccessesBetweenSrcSpansIgnoreBuildSrcSpans :: SrcLoc -> SrcLoc -> [SrcSpan] -> [(SrcLoc, SrcLoc)]
getAccessesBetweenSrcSpansIgnoreBuildSrcSpans prevEndLoc finalEndLoc [] = [(prevEndLoc, finalEndLoc)]
getAccessesBetweenSrcSpansIgnoreBuildSrcSpans prevEndLoc finalEndLoc ((startLoc, endLoc):skipSrcs) = [(prevEndLoc, startLoc)] ++ getAccessesBetweenSrcSpansIgnoreBuildSrcSpans endLoc finalEndLoc skipSrcs

# srcSpanCompare :: SrcSpan -> SrcSpan -> Ordering
srcSpanCompare ((SrcLoc f1 l1 c1), _) ((SrcLoc f2 l2 c2), _)     |    l1 < l2 || (l1 == l2 && c1 < c2)     = LT
                                                                |    l1 > l2 || (l1 == l2 && c1 > c2)     = GT
                                                                |    l1 == l2 && c1 == c2                 = EQ

# getAccessesBetweenManySrcSpans ::  VarAccessAnalysis -> [(SrcLoc, SrcLoc)] -> ([VarName Anno], [VarName Anno])
getAccessesBetweenManySrcSpans accessAnalysis [] = ([],[])
getAccessesBetweenManySrcSpans accessAnalysis ((startLoc, endLoc):srcs) = ((listConcatUnique currentReads followingReads), (listConcatUnique currentWrites followingWrites))
        where
            (currentReads, currentWrites) = getAccessesBetweenSrcSpans accessAnalysis startLoc endLoc
            (followingReads, followingWrites) = getAccessesBetweenManySrcSpans accessAnalysis srcs

# getAccessLocationsBeforeSrcSpan :: VarAccessAnalysis -> VarName Anno -> SrcSpan -> ([SrcSpan], [SrcSpan])
getAccessLocationsBeforeSrcSpan accessAnalysis accessVar src = (readsBefore, writesBefore)
        where
            localVarAccesses = (\(x:xs,_,_,_) -> x) accessAnalysis
            -- (reads, writes) = DMap.findWithDefault (error "getAccessLocationsBeforeSrcSpan: doesn't exist") accessVar localVarAccesses
            (reads, writes) = DMap.findWithDefault ([], []) accessVar localVarAccesses
            readsBefore = filter (\x -> checkSrcSpanBefore x src) reads
            writesBefore = filter (\x -> checkSrcSpanBefore x src) writes

# getAccessLocationsAfterSrcSpan :: VarAccessAnalysis -> VarName Anno -> SrcSpan -> ([SrcSpan], [SrcSpan])
getAccessLocationsAfterSrcSpan
 accessAnalysis accessVar src = (readsAfter, writesAfter)
        where
            localVarAccesses = (\(x:xs,_,_,_) -> x) accessAnalysis
            -- (reads, writes) = DMap.findWithDefault (error "getAccessLocationsAfterSrcSpan: doesn't exist") accessVar localVarAccesses
            (reads, writes) = DMap.findWithDefault ([], []) accessVar localVarAccesses
            readsAfter = filter (\x -> checkSrcSpanAfter x src) reads
            writesAfter = filter (\x -> checkSrcSpanAfter x src) writes

# getAccessesAfterSrcSpan :: VarAccessAnalysis -> SrcLoc -> ([VarName Anno], [VarName Anno])
getAccessesAfterSrcSpan accessAnalysis startLoc = (reads, writes)
        where
            localVarAccesses = (\(x:xs,_,_,_) -> x) accessAnalysis
            allVars = DMap.keys localVarAccesses
            reads = filter (varReadAfterSrcLoc localVarAccesses startLoc) allVars
            writes = filter (varWrittenAfterSrcLoc localVarAccesses startLoc) allVars

# varWrittenAfterSrcLoc :: LocalVarAccessAnalysis -> SrcLoc -> VarName Anno -> Bool
varWrittenAfterSrcLoc localVarAccesses loc var = appearance
        where
            writes = map (snd) (snd (DMap.findWithDefault ([],[]) var localVarAccesses) )
            appearance = foldl (\accum item -> accum || ((checkSrcLocBefore loc item) )) False writes

# varReadAfterSrcLoc :: LocalVarAccessAnalysis -> SrcLoc -> VarName Anno -> Bool
varReadAfterSrcLoc localVarAccesses loc var = appearance
        where
            reads = map (fst) (fst (DMap.findWithDefault ([],[]) var localVarAccesses)) 
            appearance = foldl (\accum item -> accum || ((checkSrcLocBefore loc item) )) False reads

# getAccessesBeforeSrcSpan :: VarAccessAnalysis -> SrcLoc -> ([VarName Anno], [VarName Anno])
getAccessesBeforeSrcSpan accessAnalysis endLoc = getAccessesBetweenSrcSpans accessAnalysis (SrcLoc "" 0 0) endLoc

# getAccessesBetweenSrcSpans :: VarAccessAnalysis -> SrcLoc -> SrcLoc -> ([VarName Anno], [VarName Anno])
getAccessesBetweenSrcSpans accessAnalysis startLoc endLoc = (reads, writes)
        where
            localVarAccesses = (\(x:xs,_,_,_) -> x) accessAnalysis
            allVars = DMap.keys localVarAccesses
            reads = filter (varReadInRange localVarAccesses startLoc endLoc) allVars
            writes = filter (varWrittenInRange localVarAccesses startLoc endLoc) allVars

# varReadInRange :: LocalVarAccessAnalysis -> SrcLoc -> SrcLoc -> VarName Anno -> Bool
varReadInRange localVarAccesses startLoc endLoc var = appearance
        where
            reads = map (fst) (fst (DMap.findWithDefault ([],[]) var localVarAccesses)) 
            appearance = foldl (\accum item -> accum || ((checkSrcLocBefore startLoc item) && (checkSrcLocBefore item endLoc))) False reads

# varWrittenInRange :: LocalVarAccessAnalysis -> SrcLoc -> SrcLoc -> VarName Anno -> Bool
varWrittenInRange localVarAccesses startLoc endLoc var = appearance
        where
            writes = map (fst) (snd (DMap.findWithDefault ([],[]) var localVarAccesses) )
            appearance = foldl (\accum item -> accum || ((checkSrcLocBefore startLoc item) && (checkSrcLocBefore item endLoc))) False writes

# checkSrcLocBefore

# getArguments :: Program Anno -> [VarName Anno]
getArguments prog = argNames
        where
            argNames = everything (++) (mkQ [] getArgNamesAsVarNames) prog 

# getArguments_list :: Arg Anno -> [VarName Anno]
getArguments_list arg = everything (++) (mkQ [] getArgNamesAsVarNames) arg

# getArgNamesAsVarNames :: ArgName Anno -> [VarName Anno]
getArgNamesAsVarNames (ArgName _ str) = [VarName nullAnno str]
getArgNamesAsVarNames _ = []

# getDeclaredVarNames :: Decl Anno -> [VarName Anno]
getDeclaredVarNames (Decl _ _ lst _) = foldl (\accum (expr1, _, _) -> accum ++ extractVarNames expr1) [] lst
getDeclaredVarNames decl = []

# analyseAllVarValues_fortran :: Fortran Anno -> LocalVarValueAnalysis
analyseAllVarValues_fortran (Assg _ src expr1 expr2) = foldl (\accum item -> appendToMap item (src, expr2) accum) DMap.empty varnames
                                where
                                    varnames = extractVarNames expr1
analyseAllVarValues_fortran _ = DMap.empty

# analyseAllVarAccess_block :: [String] -> [VarName Anno] -> Block Anno -> (LocalVarAccessAnalysis,LocalVarAccessAnalysis)
analyseAllVarAccess_block ioWriteSubroutineNames declarations (Block _ _ _ _ _ fortran) = analyseAllVarAccess_fortran ioWriteSubroutineNames declarations (DMap.empty,DMap.empty) fortran


# analyseAllVarAccess_fortran :: [String] -> [VarName Anno] -> (LocalVarAccessAnalysis,LocalVarAccessAnalysis) -> Fortran Anno ->  (LocalVarAccessAnalysis,LocalVarAccessAnalysis)
# So this looks like the real work 
analyseAllVarAccess_fortran ioWriteSubroutineNames declarations (prevAnalysis,prevAnalysis_io) codeSeg  = case codeSeg of
                                    Assg _ _ writeExpr readExpr -> (analysisQ,DMap.empty)
                                                where
                                                    readExprs = extractOperands readExpr
                                                    readVarNames = foldl (collectVarNames_foldl declarations) [] readExprs
                                                    -- on the LHS the expr can never be a function call so it is easy
                                                    writtenVarNames = extractVarNames writeExpr

                                                    analysis = foldl (addVarReadAccess (srcSpan readExpr)) prevAnalysis readVarNames
                                                    analysisQ = foldl (addVarWriteAccess (srcSpan writeExpr)) analysis writtenVarNames
                                    If _ _ readExpr mainFortran elseList maybeFortran -> (analysisIncChildren,analysisIncChildren_io)
                                                where
                                                    readExprs = extractOperands readExpr
                                                    readVarNames = foldl (collectVarNames_foldl declarations) [] readExprs

                                                    elseListFortran = map (snd) elseList
                                                    allFortran = case maybeFortran of
                                                            Nothing -> mainFortran:elseListFortran
                                                            Just finalElse -> mainFortran:finalElse:elseListFortran
                                                        
                                                    analysis = foldl (addVarReadAccess (srcSpan readExpr)) prevAnalysis readVarNames
                                                    analysis_io = foldl (addVarReadAccess (srcSpan readExpr)) prevAnalysis_io readVarNames

                                                    (analysisIncChildren_list,analysisIncChildren_io_list) = unzip $ map (analyseAllVarAccess_fortran ioWriteSubroutineNames declarations (analysis,analysis_io)) allFortran
                                                    analysisIncChildren = foldl combineLocalVarAccessAnalysis analysis analysisIncChildren_list
                                                    analysisIncChildren_io = foldl combineLocalVarAccessAnalysis analysis analysisIncChildren_io_list

                                 ## Call p SrcSpan (Expr p) (ArgList p);                 
                                    Call _ src callExpr argList -> analysis_tup
                                                where
                                                    subroutineName = if extractVarNames callExpr == [] 
                                                        then (error "flattenSubroutineCall: callExpr\n" ++ (show callExpr))
                                                        else varNameStr (head (extractVarNames callExpr))
                                                    # IOWRITE
                                                    # WV the plan is that any calls to subs that are not in the srcs in list on command will be 
                                                    # treated as I/O and eventually lead to generation of oclRead calls
                                                    # But only if they are not in the main loop.
                                                    # TODO: for now I just add their names on command line with the -iowrite flag
                                                    # We need to collect the arguments, identify which ones are written to the OpenCL device
                                                    # and read these back before this call
                                                    # What we need to do is replace the AST node for the sub call with a group (FSeq) with all OpenCLBufferRead statements
                                                    # Best place to do this is where the other OpenCLBufferRead statements are added
                                                    analysis_tup = 
                                                        let
                                                                extractedExprs = everything (++) (mkQ [] extractExpr_list) argList
                                                                extractedOperands = foldl (\accum item -> accum ++ extractOperands item) [] extractedExprs
                                                                #varNames :: [VarName Anno String]
                                                                varNames = foldl (collectVarNames_foldl declarations) [] extractedOperands
                                                                # So these names need to be saved and used later to compare them to the 
                                                                # arguments of the kernel
                                                        in
                                                            if (subroutineName `elem` ioWriteSubroutineNames)
                                                            then 
                                                                let
                                                                    analysis = foldl (addVarReadAccess src) prevAnalysis_io varNames
                                                                    analysisQ = foldl (addVarWriteAccess src) analysis varNames
                                                                in
                                                                    #warning DMap.empty ("Subroutine "++subroutineName++" is an I/O Write subroutine, skipping analysis for "++(show analysisQ)++"\n")
                                                                    # (prevAnalysis,warning analysisQ ("Subroutine "++subroutineName++" is an I/O Write subroutine, skipping analysis for "++(show analysisQ)++"\n"))
                                                                    (prevAnalysis,analysisQ)
                                                            else 
                                                                let

                                                        #    Both read and write since we don't know the intent inside the function/subroutine call.
                                                        #    When the subtoutine is supplied to the compiler, this information is disregarded for
                                                        #    more in depth analysis
                                                                    analysis = foldl (addVarReadAccess src) prevAnalysis varNames
                                                                    analysisQ = foldl (addVarWriteAccess src) analysis varNames
                                                                in
                                                                    (analysisQ,prevAnalysis_io)


                                    _ -> (analysisIncChildren ,analysisIncChildren_io)
                                                where 
                                                    extractedExprs = gmapQ (mkQ (Null nullAnno nullSrcSpan) extractExpr) codeSeg
                                                    extractedOperands = foldl (\accum item -> accum ++ extractOperands item) [] extractedExprs
                                                    readVarNames = foldl (collectVarNames_foldl declarations) [] extractedOperands

                                                    analysis = foldl (addVarReadAccess (srcSpan codeSeg)) prevAnalysis readVarNames
                                                    analysis_io = foldl (addVarReadAccess (srcSpan codeSeg)) prevAnalysis_io readVarNames
                                                    (analysisIncChildren_list,analysisIncChildren_io_list) = unzip $ gmapQ (mkQ (DMap.empty,DMap.empty) (analyseAllVarAccess_fortran ioWriteSubroutineNames declarations (analysis,analysis_io))) codeSeg
                                                    analysisIncChildren = foldl (combineLocalVarAccessAnalysis) DMap.empty analysisIncChildren_list
                                                    analysisIncChildren_io = foldl (combineLocalVarAccessAnalysis) DMap.empty analysisIncChildren_io_list

# WV: I guess the structure of the If is:
# If  _ _ condition first_block [else_if cond more_blocks] (Maybe else_block)                                                    
# If  p SrcSpan (Expr p) (Fortran p) [((Expr p),(Fortran p))] (Maybe (Fortran p))
# WV: This is to deal with function calls. For these, we extract the arguments.
# collectVarNames :: [VarName Anno] -> Expr Anno -> [VarName Anno]
collectVarNames declarations item = varnames
                        where
                            fnCall = isFunctionCall_varNames f95IntrinsicFunctions declarations item
                            fnArgs = extractContainedVars item
                            varnames = case fnCall of
                                True -> foldl (\accum item -> accum ++ extractVarNames item) [] fnArgs
                                False -> extractVarNames item

# collectVarNames_foldl :: [VarName Anno] -> [VarName Anno] -> Expr Anno -> [VarName Anno]
collectVarNames_foldl declarations accum item = accum ++ collectVarNames declarations item

# getValueAtSrcSpan :: VarName Anno -> SrcSpan -> VarAccessAnalysis -> Expr Anno
getValueAtSrcSpan varname target_src (_, analysis, _, _) = valueAtSrc
                                where
                                    values = DMap.findWithDefault [] varname analysis
                                    valueAtSrc = foldl (\accum (item_src, expr) -> if checkSrcSpanBefore item_src target_src then expr else accum) (NullExpr nullAnno nullSrcSpan) values

# getAccessedExprs :: [VarName Anno] -> [Expr Anno] -> Expr Anno -> [Expr Anno]
getAccessedExprs declarations accum item = case fnCall of
                                            True ->    accum ++ extractContainedVars item
                                            False -> accum ++ extractOperands item
                                        where 
                                            fnCall = isFunctionCall_varNames f95IntrinsicFunctions declarations item

#      Recursive function to add a record of a read for a certain VarName
# addVarReadAccess :: SrcSpan -> LocalVarAccessAnalysis -> VarName Anno -> LocalVarAccessAnalysis
addVarReadAccess srcspan analysis varname = DMap.insert varname (newAccessRecord) analysis
                                        where
                                            (oldReads, oldWrites) = (DMap.findWithDefault ([],[]) varname analysis)
                                            newAccessRecord = (oldReads ++ [srcspan], oldWrites)

#      Recursive function to add a record of a write for a certain VarName
# addVarWriteAccess :: SrcSpan -> LocalVarAccessAnalysis -> VarName Anno -> LocalVarAccessAnalysis
addVarWriteAccess srcspan analysis varname = DMap.insert varname newAccessRecord analysis
                                        where
                                            (oldReads, oldWrites) = (DMap.findWithDefault ([],[]) varname analysis)
                                            newAccessRecord = (oldReads, oldWrites ++ [srcspan])                                                        

# combineVarAccessAnalysis :: VarAccessAnalysis -> VarAccessAnalysis -> VarAccessAnalysis
combineVarAccessAnalysis analysis1 analysis2 = resultantAnalysis
                        where
                            ([varAccess1,varAccess1Q], varValue1, subArgs1, declared1) = analysis1
                            ([varAccess2,varAccess2Q], varValue2, subArgs2, declared2) = analysis2
                            varAccessComb = combineLocalVarAccessAnalysis varAccess1 varAccess2
                            varAccessCombQ = combineLocalVarAccessAnalysis varAccess1Q varAccess2Q
                            varValueComb = combineMaps varValue1 varValue2
                            subArgsComb = subArgs1 ++ subArgs2
                            declaredComb = declared1 ++ declared2

                            resultantAnalysis = ([varAccessComb,varAccessCombQ], varValueComb, subArgsComb, declaredComb)

# type VarAccessRecord = ([SrcSpan],     [SrcSpan])
# type LocalVarAccessAnalysis = DMap.Map (VarName Anno) VarAccessRecord
#     Helper function used to merge two sets of variable access analysis records.
# combineLocalVarAccessAnalysis :: LocalVarAccessAnalysis -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis
combineLocalVarAccessAnalysis analysis1 analysis2 = resultantAnalysis
                        where
                            analysis2List = DMap.toList analysis2
                            resultantAnalysis = foldl (\accum (key, value) -> DMap.insert key (combineBinaryListTuples (DMap.findWithDefault ([],[]) key accum) value) accum) analysis1 analysis2List

# combineBinaryListTuples :: ([a], [b]) -> ([a], [b]) -> ([a], [b])
combineBinaryListTuples (a1, b1) (a2, b2) = (a1 ++ a2, b1 ++ b2)

# getPrexistingVars :: SrcSpan -> VarAccessAnalysis -> [VarName Anno]
getPrexistingVars codeBlockSrcSpan accessAnalysis = listRemoveDuplications (prexistingVars ++ subroutineArguments)
        where
            localVarAccesses = (\(x:xs,_, _, _) -> x) accessAnalysis
            subroutineArguments = (\(_,_, x, _) -> x) accessAnalysis
            allVars = DMap.keys localVarAccesses
            accessAnalysisInsideSrc = getAccessesInsideSrcSpan localVarAccesses codeBlockSrcSpan
            prexistingVars = filter (isPrexistingVar codeBlockSrcSpan accessAnalysisInsideSrc) allVars
# This tests if a variable has been written to or read from before the point it is encountered. 
# If it was not written to, returns True
# If it was only written to, returns False 
# If it was written to after being read from, return True
# isPrexistingVar :: SrcSpan -> LocalVarAccessAnalysis -> VarName Anno -> Bool
isPrexistingVar codeBlockSrcSpan accessAnalysisInsideSrc var = case earliestWrite of
                                                                    Nothing -> True
                                                                    Just firstWrite -> case earliestRead of
                                                                                            Nothing -> False
                                                                                            Just firstRead -> checkSrcSpanBefore firstRead firstWrite
        where
            (reads, writes) = DMap.findWithDefault ([], []) var accessAnalysisInsideSrc
            earliestRead = getEarliestSrcSpan reads
            earliestWrite = getEarliestSrcSpan writes

            

# varHasSrcBefore :: SrcSpan -> LocalVarAccessAnalysis -> VarName Anno -> Bool
varHasSrcBefore codeBlockSrcSpan localVarAccess var = foldl (\accum item -> accum || (checkSrcSpanBefore item codeBlockSrcSpan)) False varWrites
        where
            (varReads, varWrites) = DMap.findWithDefault ([],[]) var localVarAccess
=cut
#    The function is directly called by Transformer.hs when it is attempting to parallelise a certain loop. This function is supplied with a start
#    and end point for a loop (SrcSpan) and the VarAccessAnalysis record for the program. The returned list is all of the VarNames that must be
#    considdered non temporary for that loop. For a variable to be considered non temporary, it must either be an argument to this code block or
#    it must be read after the end of the loop, before any data is written to it. In the second case, this means that a variable is non temporary
#    if the final value left in it by the loop is read and used elsewhere.
# getNonTempVars :: SrcSpan -> VarAccessAnalysis -> [VarName Anno]
sub getNonTempVars { my ($codeBlockSpan,$accessAnalysis) = @_;
        # where
            my $localVarAccesses = #(\(x:xs,_, _, _) -> x) 
                $accessAnalysis->{'LocalVarAccesses'};
            my $subroutineArguments = #(\(_,_, x, _) -> x) 
                $accessAnalysis->{'Args'};
            my $readsAfterBlock = varAccessAnalysis_readsAfter( $codeBlockSpan, $localVarAccesses);
            my $writesReadsAfterBlock = varAccessAnalysis_writesAfter( $codeBlockSpan, $readsAfterBlock);
            my $hangingReads = filter(
                sub { (my $elt) = @_; checkHangingReads( $writesReadsAfterBlock, $elt) },
                [keys %{$writesReadsAfterBlock}]
            );
    return [@{$hangingReads},@{$subroutineArguments}];
}
# varAccessAnalysis_writesAfter :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis
sub varAccessAnalysis_writesAfter { my ($codeBlockSpan, $accessAnalysis) = @_;

    foldl(
        sub { (my $elt) = @_;
            varAccessAnalysis_writesAfterQ( $codeBlockSpan, $accessAnalysis, $elt); 
        },
        {},
        [keys %{$accessAnalysis}]
    );
}

# varAccessAnalysis_writesAfterQ :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis -> VarName Anno -> LocalVarAccessAnalysis
varAccessAnalysis_writesAfterQ (_, SrcLoc _ line_end _) accessAnalysis accumAnalysis varname = combineLocalVarAccessAnalysis accumAnalysis outputAnalysis
        where
            (readSpans, writeSpans) = DMap.findWithDefault ([], []) varname accessAnalysis
            newWriteSpans = filter (\((SrcLoc _ line_write column_write), _) -> line_write >= line_end) writeSpans
            outputAnalysis = DMap.insert varname (readSpans, newWriteSpans) DMap.empty

# varAccessAnalysis_readsAfter :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis
varAccessAnalysis_readsAfter codeBlockSpan accessAnalysis = foldl (varAccessAnalysis_readsAfterQ codeBlockSpan accessAnalysis) DMap.empty (DMap.keys accessAnalysis)


# varAccessAnalysis_readsAfterQ :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis -> VarName Anno -> LocalVarAccessAnalysis
varAccessAnalysis_readsAfterQ (_, SrcLoc _ line_end _) accessAnalysis accumAnalysis varname = combineLocalVarAccessAnalysis accumAnalysis outputAnalysis
        where
            (readSpans, writeSpans) = DMap.findWithDefault ([], []) varname accessAnalysis
            newReadSpans = filter (\((SrcLoc _ line_read column_read), _) -> line_read >= line_end) readSpans
            outputAnalysis = DMap.insert varname (newReadSpans, writeSpans) DMap.empty

# checkHangingReads :: LocalVarAccessAnalysis -> VarName Anno -> Bool
checkHangingReads analysis varname = case earliestRead of
                                                        Just r ->    case earliestWrite of
                                                                        Just w -> not (checkSrcSpanBefore_line w r)
                                                                        Nothing -> True
                                                        Nothing ->    False
        where 
            (readSpans, writeSpans) = DMap.findWithDefault ([], []) varname analysis
            earliestRead = getEarliestSrcSpan readSpans
            earliestWrite = getEarliestSrcSpan writeSpans
=pod
# getAccessesInsideSrcSpan :: LocalVarAccessAnalysis -> SrcSpan -> LocalVarAccessAnalysis
getAccessesInsideSrcSpan localVarAccesses src = foldl (getAccessesInsideSrcSpan_var src) localVarAccesses vars
        where
            vars = DMap.keys localVarAccesses

# getAccessesInsideSrcSpan_var :: SrcSpan -> LocalVarAccessAnalysis -> VarName Anno -> LocalVarAccessAnalysis
getAccessesInsideSrcSpan_var src localVarAccesses var = newLocalVarAccesses
        where
            (reads, writes) = DMap.findWithDefault ([], []) var localVarAccesses
            newReads = filter (srcSpanInSrcSpan src) reads
            newWrites = filter (srcSpanInSrcSpan src) writes
            newLocalVarAccesses = DMap.insert var (newReads, newWrites) localVarAccesses
=cut
#    This function is called using generics so that every 'Block' is traversed. This step is necessary to be able to reach the first 'Fortran'
#    node. From here, the first call to 'isolateAndParalleliseForLoops' is made (again with generics) which recursively traverses the 'Fortran' nodes to
#    find for loop that should be analysed
# paralleliseBlock :: String -> SubroutineTable -> VarAccessAnalysis -> Block Anno -> Block Anno
sub paralleliseBlock { my ($stref, $f, $accessAnalysis, $annlines) = @_;
    
#    Function traverses the 'Fortran' nodes to find For loops. It calls 'paralleliseLoop' on identified for loops in a recusive way such that the most
#    nested loops in a cluster are analysed first.
# isolateAndParalleliseForLoops :: String -> SubroutineTable -> VarAccessAnalysis -> Fortran Anno -> Fortran Anno
    my $isolateAndParalleliseForLoops =  sub { (my $annline, my $state)=@_;
			(my $line,my $info)=@{$annline};
    # filename subTable accessAnalysis inp = case inp of
    if (exists $info->{'Do'}) {
        # If the InBlock info for this Do-loop is 0, we extract the $annlines inside this Do block and run a recursive analysis on it.
        # 

        # recusivelyAnalysedNode = gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis )) inp
        # paralleliseLoop filename [] accessAnalysis subTable recusivelyAnalysedNode
    }
    
    # _ -> gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis)) inp
        return ([[$line,$info]],$state);
    };    
    # filename subTable accessAnalysis block = 
    my $state = $accessAnalysis;
    (my $new_annlines, $state) = stateful_pass($annlines,$isolateAndParalleliseForLoops,"isolateAndParalleliseForLoops($f) " . __LINE__);
    # gmapT (mkT ($isolateAndParalleliseForLoops filename subTable accessAnalysis)) block
    return $new_annlines;
}




# paralleliseLoop :: String -> [VarName Anno] -> VarAccessAnalysis -> SubroutineTable -> Fortran Anno -> Fortran Anno
# getLoopVar gets the loop iterators
sub paralleliseLoop { my ($stref, $f, $loopVars, $accessAnalysis, $loop_annlines, $block_id) = @_;
    # filename loopVars accessAnalysis subTable loop = transformedAst
                                # where
    my $loopvar = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'Iterator'};
    my $newLoopVars = [@{$loopVars}, $loopvar];
                                    # case getLoopVar loop of
                                    #     Just a -> loopVars ++ [a]
                                    #     Nothing -> loopVars

    my $nonTempVars = getNonTempVars($loop_annlines,$accessAnalysis);
    my $prexistingVars = getPrexistingVars($loop_annlines, $accessAnalysis);
    my $dependencies = analyseDependencies($loop_annlines);

    #    If the 'bool' variable for any of the attempts to parallelise is true, then parallism has been found
    #    and the new AST node is returned from this function, to be placed in the AST by the calling function.
    #    
    my $mapAttempt = [];#paralleliseLoop_map filename loop newLoopVars nonTempVars prexistingVars dependencies accessAnalysis subTable
    my $mapAttempt_bool = fst $mapAttempt;
    my $mapAttempt_ast = snd $mapAttempt;

    my $reduceAttempt = [];#paralleliseLoop_reduce filename mapAttempt_ast newLoopVars nonTempVars prexistingVars  dependencies accessAnalysis
    my $reduceAttempt_bool = fst $reduceAttempt;
    my $reduceAttempt_ast = snd $reduceAttempt;

    my $reduceWithOuterIterationAttempt = [];#paralleliseLoop_reduceWithOuterIteration filename reduceAttempt_ast Nothing newLoopVars newLoopVars nonTempVars prexistingVars dependencies accessAnalysis
    my $reduceWithOuterIterationAttempt_bool = fst $reduceWithOuterIterationAttempt;
    my $reduceWithOuterIterationAttempt_ast = snd $reduceWithOuterIterationAttempt;
    # WV: TODO: if all these fail we should move the loop to the OpenCL device anyway, using a new OpenCLSeq node

    my $transformedAst =  $mapAttempt_bool 
        ?  $mapAttempt_ast
        :  $reduceAttempt_bool 
                    ? $reduceAttempt_ast
                    : $reduceWithOuterIterationAttempt_ast ;
    return $transformedAst
}

=pod
#    Function takes a list of loop variables and a possible parallel loop's AST and returns a string that details the reasons why the loop cannot be mapped. If the returned string is empty, the loop represents a possible parallel map
# analyseLoop_map :: String -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> VarAccessAnalysis -> VarDependencyAnalysis -> SubroutineTable -> Fortran Anno -> AnalysisInfo
analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable codeSeg = case codeSeg of
        # If _ _ condExpr ifTrue elifList maybeElse -> foldl combineAnalysisInfo analysisInfoBaseCase ([condExprAnalysis] ++ readWriteAnalysis ++ [ifTrueAnalysis] ++ elifCondAnalysis ++ elifBodyAnalysis ++ [elseAnalysis]  )
        If _ _ condExpr ifTrue elifList maybeElse -> foldl combineAnalysisInfo analysisInfoBaseCase ([condExprAnalysis, ifTrueAnalysis] ++ elifCondAnalysis ++ elifBodyAnalysis ++ [elseAnalysis]  )
            where
                recursiveCall = analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable
                # readWriteAnalysis = gmapQ (mkQ analysisInfoBaseCase recursiveCall) codeSeg # so this should call recursiveCall on all nodes of codeSeg, why? 
                condExprAnalysis = (nullAnno, [], extractOperands condExpr, []) # AnalysisInfo tuple from the 'if' condition
                ifTrueAnalysis = recursiveCall ifTrue
                elifBodyAnalysis = map (\(_, elif_fortran) ->  recursiveCall elif_fortran) elifList # list of AnalysisInfo tuples from the body of each 'else if' branch
                elifCondAnalysis = map (\(elif_expr, _) -> (nullAnno, [], extractOperands elif_expr, [])) elifList # list of AnalysisInfo tuples from the condition of each 'else if' branch
                elseAnalysis = case maybeElse of
                                    Just else_fortran ->  recursiveCall else_fortran
                                    Nothing -> analysisInfoBaseCase

        Assg _ srcspan lhsExpr rhsExpr -> foldl (combineAnalysisInfo) analysisInfoBaseCase [lhsExprAnalysis,
                                                                                                (DMap.empty,[],
                                                                                                prexistingReadExprs,
#                                                                                                (warning prexistingReadExprs ("MAP: PRE-EXISTING READ EXPRS: "++(unwords (map miniPP prexistingReadExprs))++"\n") ),
                                                                                                if isNonTempAssignment then [lhsExpr] else [])]
            where
                lhsExprAnalysis = analyseLoopIteratorUsage comment loopVars loopWrites nonTempVars accessAnalysis lhsExpr
                isNonTempAssignment = usesVarName_list nonTempVars lhsExpr

                readOperands = extractOperands rhsExpr
                # WV: not sure if this should not be the same as for the Reduction
                readExprs = foldl (\accum item -> accum ++ (extractContainedVars item) ++ [item]) [] readOperands
                prexistingReadExprs = filter (usesVarName_list prexistingVars ) readExprs
#                prexistingReadExprs = filter (usesVarName_list  (warning prexistingVars ("MAP: PRE-EXISTING VARS: "++(show (map (\(VarName _ v)->v) prexistingVars) )++"\nRHS FULL: "++(miniPP rhsExpr)++"\n"++ ("READ EXPRS: "++(show (map miniPP readExprs))++"\n")  ) )) readExprs 
                # prexistingReadExprs = filter (usesVarName_list  (warning prexistingVars ("PRE: "++(show (map (\(VarName _ v)->v) prexistingVars) )++"\nRHS: "++(miniPP rhsExpr)++"\n") ))  (warning readExprs ("READ OPS: "++(show (map miniPP readExprs))++"\n") )
                #prexistingReadExprs = filter (usesVarName_list  prexistingVars) readExprs 
                #
        For _ _ var e1 e2 e3 _ -> foldl combineAnalysisInfo analysisInfo childrenAnalysis  # foldl combineAnalysisInfo analysisInfoBaseCase childrenAnalysis 
            where
                childrenAnalysis = (gmapQ (mkQ analysisInfoBaseCase (analyseLoop_map comment (loopVars ++ [var]) loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable)) codeSeg)
                
                e1Vars = extractAllVarNames e1
                e2Vars = extractAllVarNames e2
                e3Vars = extractAllVarNames e3

                readVars = map (generateVar) (listRemoveDuplications (e1Vars ++ e2Vars ++ e3Vars))
                analysisInfo = (nullAnno, [], readVars, [])

        Call _ srcspan callExpr arglist -> callAnalysis
            where
                #    If the called subroutine exists in a file that was supplied to the compiler, analyse it. If the subroutine is parallelisable,
                #    it is not parallelised internally but is instead included as part of some externel parallelism. If the subroutine was not parsed
                #    then add a parallelism error to the annotations.
                recursiveCall = analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable

                subroutineName = if extractVarNames callExpr == [] then (error "analyseLoop_map: callExpr" ++ (show callExpr))  else varNameStr (head (extractVarNames callExpr))
                argTranslation = generateArgumentTranslation subTable codeSeg
                (subroutineParsed, subTableEntry) = case DMap.lookup subroutineName subTable of
                                        Just a -> (True, a)
                                        Nothing -> (False, error "analyseLoop_map: DMap.lookup subroutineName subTable")
                subroutineBody = subroutineTable_ast subTableEntry
                subCallAnalysis = recursiveCall (extractFirstFortran subroutineBody)

                callAnalysis =     if not subroutineParsed then
                                    (errorMap_call, [], [], argExprs)
                                else
                                    subCallAnalysis

                errorMap_call = DMap.insert (outputTab ++ comment ++ "Call to external function:\n")
                                            [errorLocationFormatting srcspan ++ outputTab ++ outputExprFormatting callExpr]
                                            DMap.empty
                argExprs = everything (++) (mkQ [] extractExpr_list) arglist

        FSeq _ srcspan codeSeg1 codeSeg2 -> combineAnalysisInfo codeSeg1Analysis codeSeg2Analysis
            where
                recursiveCall = analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable
                codeSeg1Analysis = recursiveCall codeSeg1
                codeSeg2Analysis = recursiveCall codeSeg2
        _ -> foldl combineAnalysisInfo analysisInfoBaseCase (childrenAnalysis ++ nodeAccessAnalysis)
            where
                recursiveCall = analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable

                nodeAccessAnalysis = gmapQ (mkQ analysisInfoBaseCase (analyseLoopIteratorUsage comment loopVars loopWrites nonTempVars accessAnalysis)) codeSeg
                childrenAnalysis = gmapQ (mkQ analysisInfoBaseCase recursiveCall) codeSeg
=cut

sub analyse_loop_nature_all {
	( my $stref ) = @_;

	for my $f ( sort keys %{ $stref->{'Subroutines'} } ) {

		next if ( $f eq '' or $f eq 'UNKNOWN_SRC' or not defined $f );
		# next if exists $stref->{'Entries'}{$f};

		my $Sf = $stref->{'Subroutines'}{$f};

		if ( not defined $Sf->{'Status'} ) {
			$Sf->{'Status'} = $UNREAD;
			say "INFO: no Status for $f" if $I;
		}

		next if $Sf->{'Status'} == $UNREAD;
		next if $Sf->{'Status'} == $READ;
		next if $Sf->{'Status'} == $FROM_BLOCK;
        #   map {say 'TEST'.$_} @{pp_annlines($Sf->{'RefactoredCode'})} if $f=~/test_loop/;
		$stref = analyseLoopNature( $stref, $f );

        # emit_RefactoredCode($stref,$f,$Sf->{'RefactoredCode'}) ;
	}
    
	return $stref;
}    # END of analyse_loop_nature_all()

sub findWithDefault { my ($default, $key, $table) = @_;

    if (not exists $table->{$key}) {
        if (ref($default) eq 'SUB') {
            $default->();
        } else { 
            return $default;
        }
    } else {
        return $table->{$key};
    }
    
}

sub insert { my ($key, $value, $table) = @_;
        $table->{$key}=$value;
        return dclone($table);
}

sub foldl {
	( my $f, my $acc, my $ls ) = @_;
	my $i = 0;
	my $n = scalar @{$ls};
	for my $elt ( @{$ls} ) {
		++$i;
		$acc = $f->( $acc, $elt );
	}
	return $acc;
}    

# sub zip { my ($l1, $l2) = @_;
#     my $len_l1= scalar @{$l1};
#     my $len_l2= scalar @{$l2};
#     my $common_len = $len_l1 < $len_l2 ? $len_l1 : $len_l2;
#     my $l12=[];
#     for my $idx (0..$common_len-1) {
#         my $elt1 = $l1->[$idx];
#         my $elt2 = $l2->[$idx];
#         push @{$l12},[$elt1,$elt2];
#     }
#     return $l12;
# }

sub unzip { (my $l12) = @_;
    my $l1=[];
    my $l2=[];
    for my $pair (@{$l12}) {
        my ($elt1,$elt2)=@{$pair};
        push @{$l1},$elt1;
        push @{$l2},$elt2;
    }
    return ($l1,$l2);
}

sub fst { (my $tup_ref) = @_; 
    return $tup_ref->[0];
}

sub snd { (my $tup_ref) = @_; 
    return $tup_ref->[1];
}

sub filter { (my $f, my $lst) = @_;
    my $res = grep { $f->{$_} } @{$lst};
    return $res;
}

1;