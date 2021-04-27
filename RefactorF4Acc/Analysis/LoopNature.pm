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

our $outputTab = "\t";
our $True = 1;
our $False = 0;
our $nullAnno = {};
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
            
            croak Dumper $accessAnalysis->{'LoopNests'}{'Set'};
            # So I assume for every block this does paralleliseBlock
            (my $parallelisedProgUnit, $accessAnalysis) = parallelise_all_Blocks($stref, $f, $accessAnalysis, $annlines_foldedConstants);
            # everywhere mkT(paralleliseBlock　filename　originalTable　accessAnalysis) annlines_foldedConstants

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

# type SrcSpan = (SrcLoc, SrcLoc)
# data SrcLoc = SrcLoc {
#                 srcFilename :: String,
#                 srcLine :: Int,
#                 srcColumn :: Int
#                 }

# So for us that is [LineID, LineID] assuming srcColumn is never needed. I think that is OK because it does not really matter if there are several reads in an expression, and there can only every be one write in an expression
# Instead of Maybe SrcSpan we return [] for Nothing
# Also, we don't have [SrcSpan], instead we have [LineID]
# So instead we have getEarliestLineId which is simple:

sub getEarliestLineId { my ($block_line_ids) = @_; 
    my $earliest_line_id=-1;
    for my $block_line_id (@{$block_line_ids}) {
        my ($block_id,$line_id)=@{$block_line_id};
        if ($line_id<$earliest_line_id or $earliest_line_id==-1) {
            $earliest_line_id=$line_id;
        }    
    }
    return $earliest_line_id;
}
=pod
# getEarliestSrcSpan :: [SrcSpan] -> Maybe(SrcSpan)
getEarliestSrcSpan [] = Nothing
getEarliestSrcSpan spans = Just (foldl (\accum item -> if checkSrcSpanBefore item accum then item else accum) (spans!!0) spans)

# getLatestSrcSpan :: [SrcSpan] -> Maybe(SrcSpan)
getLatestSrcSpan [] = Nothing
getLatestSrcSpan spans = Just (foldl (\accum item -> if checkSrcSpanBefore item accum then accum else item) (spans!!0) spans)

# checkSrcLocEqualLines :: SrcLoc -> SrcLoc -> Bool
checkSrcLocEqualLines (SrcLoc _ l1 _) (SrcLoc _ l2 _) = l1 == l2

# getEarliestSrcLoc :: [SrcLoc] -> Maybe(SrcLoc)
getEarliestSrcLoc [] = Nothing
getEarliestSrcLoc locs = Just (foldl (\accum item -> if checkSrcLocBefore item accum then item else accum) (locs!!0) locs)

# checkSrcLocBefore :: SrcLoc -> SrcLoc -> Bool
checkSrcLocBefore (SrcLoc file_before line_before column_before) (SrcLoc file_after line_after column_after) =  (line_before < line_after) || ((line_before == line_after) && (column_before < column_after))

# checkSrcSpanAfter :: SrcSpan -> SrcSpan -> Bool
checkSrcSpanAfter ((SrcLoc file_before line_before column_before), _) (_, (SrcLoc file_after line_after column_after)) = (line_before > line_after) || ((line_before == line_after) && (column_before > column_after))
-- checkSrcSpanAfter ((SrcLoc file_before line_before column_before), _) ((SrcLoc file_after line_after column_after), _) = (line_before > line_after) || ((line_before == line_after) && (column_before > column_after))

# checkSrcSpanBefore :: SrcSpan -> SrcSpan -> Bool
checkSrcSpanBefore (_, (SrcLoc file_before line_before column_before)) ((SrcLoc file_after line_after column_after), _) = (line_before < line_after) || ((line_before == line_after) && (column_before < column_after))
-- checkSrcSpanBefore ((SrcLoc file_before line_before column_before), _) ((SrcLoc file_after line_after column_after), _) = (line_before < line_after) || ((line_before == line_after) && (column_before < column_after))

# checkSrcSpanBefore_line :: SrcSpan -> SrcSpan -> Bool
checkSrcSpanBefore_line ((SrcLoc file_before line_before column_before), beforeEnd) ((SrcLoc file_after line_after column_after), afterEnd) = (line_before < line_after)

# checkSrcSpanContainsSrcSpan :: SrcSpan -> SrcSpan -> Bool
checkSrcSpanContainsSrcSpan ((SrcLoc _ outerLS outerCS), (SrcLoc _ outerLE outerCE)) ((SrcLoc _ innerLS innerCS), (SrcLoc _ innerLE innerCE)) = outerStartsBefore && outerEndsAfter
        where
            outerStartsBefore = (outerLS < innerLS)|| (outerLS == innerLS && outerCS < innerCS)
            outerEndsAfter = (outerLE > innerLE)|| (outerLE == innerLE && outerCE > innerCE)




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
# WV: codeBlockSpan is actually $loop_annlines, so we can get the line IDs from the info of the first and last annline
sub getNonTempVars { my ($codeBlockSpan,$accessAnalysis) = @_;
        # where
            my $localVarAccesses = #(\(x:xs,_, _, _) -> x) 
                $accessAnalysis->{'LocalVarAccesses'};
            # list of varnames                
            my $subroutineArguments = #(\(_,_, x, _) -> x) 
                $accessAnalysis->{'Args'};
            my $readsAfterBlock = varAccessAnalysis_readsAfter( $codeBlockSpan, $localVarAccesses);
            my $writesReadsAfterBlock = varAccessAnalysis_writesAfter( $codeBlockSpan, $readsAfterBlock);
            # list of varnames
            my $hangingReads = filter(
                sub { (my $varname) = @_; checkHangingReads( $writesReadsAfterBlock, $varname) },
                [keys %{$writesReadsAfterBlock->{'LocalVarAccesses'}}]
            );
    return [@{$hangingReads},@{$subroutineArguments}];
}
# varAccessAnalysis_writesAfter :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis
sub varAccessAnalysis_writesAfter { my ($codeBlockSpan, $accessAnalysis) = @_;

    return foldl(
        sub { my ($accumAnalysis,$varname) = @_;
            return varAccessAnalysis_writesAfterQ( $codeBlockSpan, $accessAnalysis, $accumAnalysis,$varname); 
        },
        {},
        [keys %{$accessAnalysis->{'LocalVarAccessAnalysis'}}]
    );
}

# varAccessAnalysis_writesAfterQ :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis -> VarName Anno -> LocalVarAccessAnalysis
sub varAccessAnalysis_writesAfterQ {  my ($codeBlockSpan, $accessAnalysis, $accumAnalysis,$varname) = @_;
# (_, SrcLoc _ line_end _)
    my $line_end = $codeBlockSpan->[-1][1]{'LineId'};
#where
    my $var_access = findWithDefault({},$varname,$accessAnalysis->{'LocalVarAccessAnalysis'});
    my $readSpans = findWithDefault([], 'Read',$var_access);
    my $writeSpans = findWithDefault([], 'Write',$var_access);

    my $newWriteSpans = filter( sub { my ($block_line_id) = @_;
            my $line_write = $block_line_id->[1];
            return  $line_write >= $line_end;
        }, $readSpans);

    my $outputAnalysis={};
    
    $outputAnalysis->{'LocalVarAccessAnalysis'}{$varname} = { 
        'Read' => $readSpans, 
        'Write' => $newWriteSpans
    };

    return combineLocalVarAccessAnalysis( $accumAnalysis, $outputAnalysis);    
}

# varAccessAnalysis_readsAfter :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis
sub varAccessAnalysis_readsAfter{ my ($codeBlockSpan, $accessAnalysis) = @_;
    return foldl( sub { my ($accumAnalysis,$varname) = @_;
        return varAccessAnalysis_readsAfterQ( $codeBlockSpan,  $accessAnalysis, $accumAnalysis,$varname) ;
    }, {}, [keys %{$accessAnalysis->{'LocalVarAccessAnalysis'}}]);
}

# varAccessAnalysis_readsAfterQ :: SrcSpan -> LocalVarAccessAnalysis -> LocalVarAccessAnalysis -> VarName Anno -> LocalVarAccessAnalysis
sub varAccessAnalysis_readsAfterQ {
    my ($codeBlockSpan, $accessAnalysis, $accumAnalysis,$varname) = @_;
    # 'LocalVarAccessAnalysis' => {
    #     $var => {
    #     'Write' => [(BlockId,LineId)]
    #     'Read' => [(BlockId,LineId)]
    #     }
    # }    
    # (_, SrcLoc _ line_end _)
    my $line_end = $codeBlockSpan->[-1][1]{'LineId'};
    # where
    my $var_access = findWithDefault({},$varname,$accessAnalysis->{'LocalVarAccessAnalysis'});
    my $readSpans = findWithDefault([], 'Read',$var_access);
    my $writeSpans = findWithDefault([], 'Write',$var_access);    

    my $newReadSpans = filter( sub { my ($block_line_id) = @_;
            my $line_read = $block_line_id->[1];
            return  $line_read >= $line_end;
        }, $readSpans);

    my $outputAnalysis={};
    
    $outputAnalysis->{'LocalVarAccessAnalysis'}{$varname} = { 
        'Read' => $newReadSpans, 
        'Write' => $writeSpans
    };

    return combineLocalVarAccessAnalysis( $accumAnalysis, $outputAnalysis);
}


# checkHangingReads :: LocalVarAccessAnalysis -> VarName Anno -> Bool
sub checkHangingReads { my ($accessAnalysis,$varname) = @_;
        # where 
    my $var_access = findWithDefault({},$varname,$accessAnalysis->{'LocalVarAccessAnalysis'});
    my $readSpans = findWithDefault([], 'Read',$var_access);
    my $writeSpans = findWithDefault([], 'Write',$var_access);  
    my $earliestRead = getEarliestLineId( $readSpans); # if the list is empty this will return -1
    my $earliestWrite = getEarliestSrcSpan( $writeSpans);
    return $earliestRead > -1 # there is a read
        ? $earliestWrite > -1  # there is a write
            ? $earliestWrite > $earliestRead 
                ? 1  # if the write is after the read
                : 0  # if the read is after the write
            : 1 # if there was no write
        : 0; # if there wass no read
}


# getPrexistingVars :: SrcSpan -> VarAccessAnalysis -> [VarName Anno]
sub getPrexistingVars{ my ($codeBlockSrcSpan, $accessAnalysis) = @_;
        # where
    my $localVarAccesses = $accessAnalysis->{'LocalVarAccessAnalysis'};
    my $subroutineArguments = $accessAnalysis->{'Args'};
    my $allVars = $accessAnalysis->{'LocalVars'}{'List'};
    my $accessAnalysisInsideSrc = getAccessesInsideSrcSpan( $localVarAccesses,$codeBlockSrcSpan);
    my $prexistingVars = filter( sub { my ($var) = @_;
            return isPrexistingVar( $codeBlockSrcSpan, $accessAnalysisInsideSrc,$var);
    }, $allVars);
    return listRemoveDuplications([@{$prexistingVars},@{$subroutineArguments}]);
}
# This tests if a variable has been written to or read from before the point it is encountered. 
# If it was not written to, returns True
# If it was only written to, returns False 
# If it was written to after being read from, return True
# isPrexistingVar :: SrcSpan -> LocalVarAccessAnalysis -> VarName Anno -> Bool
sub isPrexistingVar {my ($codeBlockSrcSpan,$accessAnalysisInsideSrc,$varname) = @_;
        # where
    my $var_access = findWithDefault({},$varname,$accessAnalysisInsideSrc->{'LocalVarAccessAnalysis'});
    my $reads = findWithDefault([], 'Read',$var_access);
    my $writes = findWithDefault([], 'Write',$var_access);         
    my $earliestRead = getEarliestLineId( $reads); # if the list is empty this will return -1
    my $earliestWrite = getEarliestSrcSpan( $writes);
    return $earliestWrite == -1
        ? 1
        : $earliestRead == -1 
            ? 0
            : $earliestRead < $earliestWrite
}
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


# paralleliseLoop :: String -> [VarName Anno] -> VarAccessAnalysis -> SubroutineTable -> Fortran Anno -> (Fortran Anno, VarAccessAnalysis)
# getLoopVar gets the loop iterators
sub paralleliseLoop { my ($stref, $f, $loopvar, $accessAnalysis, $loop_annlines, $block_id) = @_;
    # filename loopVars accessAnalysis subTable loop = transformedAst
    # where
    my $newLoopVars = [$loopvar];

    my $nonTempVars = getNonTempVars($loop_annlines,$accessAnalysis);
    my $prexistingVars = getPrexistingVars($loop_annlines, $accessAnalysis);
    my $dependencies = analyseDependencies($loop_annlines);

    #    If the 'bool' variable for any of the attempts to parallelise is true, then parallism has been found
    #    and the new AST node is returned from this function, to be placed in the AST by the calling function.
    #    
    (my $mapAttempt,$accessAnalysis)  = paralleliseLoop_map($stref,$f,$loop_annlines,$newLoopVars,$nonTempVars,$prexistingVars, $dependencies,$accessAnalysis, $block_id);# subTable  # TODO
    my $mapAttempt_bool = fst $mapAttempt;
    my $mapAttempt_ast = snd $mapAttempt;

    (my $reduceAttempt,$accessAnalysis) = paralleliseLoop_reduce($stref,$f,$mapAttempt_ast,$newLoopVars,$nonTempVars,$prexistingVars,$dependencies,$accessAnalysis);  # TODO
    my $reduceAttempt_bool = fst $reduceAttempt;
    my $reduceAttempt_ast = snd $reduceAttempt;
    my $Nothing=[]; # This is a series of AnnLines as it is Fortran Anno; starts out empty 
    (my $reduceWithOuterIterationAttempt, $accessAnalysis) = paralleliseLoop_reduceWithOuterIteration($stref,$f,$reduceAttempt_ast, $Nothing, $newLoopVars,$newLoopVars,$nonTempVars,$prexistingVars,$dependencies,$accessAnalysis); # TODO
    my $reduceWithOuterIterationAttempt_bool = fst $reduceWithOuterIterationAttempt;
    my $reduceWithOuterIterationAttempt_ast = snd $reduceWithOuterIterationAttempt;
    # WV: TODO: if all these fail we should move the loop to the OpenCL device anyway, using a new OpenCLSeq node

    my $transformedAst =  $mapAttempt_bool 
        ?  $mapAttempt_ast
        :  $reduceAttempt_bool 
                    ? $reduceAttempt_ast
                    : $reduceWithOuterIterationAttempt_ast;

    my $updated_accessAnalysis = $accessAnalysis; #TODO, currently I update the accessAnalysis rather than creating a fresh copy

    return ($transformedAst, $updated_accessAnalysis);
} # END of paralleliseLoop


#                          errors         reduction variables  read variables       written variables    
# type AnalysisInfo =     (Anno,         [Expr Anno],         [Expr Anno],         [Expr Anno])
# type Anno = DMap.Map (String) [String]

# LoopAnalysis.analysisInfoBaseCase :: AnalysisInfo
our $analysisInfoBaseCase = [{},[],[],[]];

#    Function takes a list of loop variables and a possible parallel loop's AST and returns a string that details the reasons why the loop cannot be mapped. If the returned string is empty, the loop represents a possible parallel map
# LoopAnalysis.analyseLoop_map :: String -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> VarAccessAnalysis -> VarDependencyAnalysis -> SubroutineTable -> Fortran Anno -> AnalysisInfo
sub analyseLoop_map {
    my ($stref, $f, $comment, $loopVars, $loopWrites, $nonTempVars, $prexistingVars, $accessAnalysis, $dependencies, $codeSeg, $block_id) = @_; # subTable
    # codeSeg is like AnnLines, but because it is nested, it is recursive 
    # So I think we do a simple stateful_pass here, let's just see what each of these does
    # case codeSeg of
    my $pass_analyseLoop_map = sub { my ($annline,$state) = @_;
    my ($line,$info)=@{$annline};
    if (exists $info->{'If'} or exists $info->{'ElseIf'}) {
# my $vars_and_index_vars_in_cond_expr ={ $array_var_name}=> {
#     'Type' => 'Array' ,
#     'IndexVars' => {
#            $index_var_name => {'Type' => 'Scalar'}
#        }
#   },
#  $scalar_var_name => {'Type' => 'Scalar'}
# }
# $info->{'CondVars'}{'Set'} = $vars_and_index_vars_in_cond_expr;
# $info->{'CondVars'}{'List'} = [ sort keys %{$vars_and_index_vars_in_cond_expr} ];

        my $readOperands=createExprListFromVarAccesses($info->{'VarAccesses'}, 'Read');
        my $condExprAnalysis = [{}, [], $readOperands, []]; # AnalysisInfo tuple from the 'if' condition            
        $state = combineAnalysisInfo(  $state, [$condExprAnalysis]);
    }

    if (exists $info->{'Assignment'}) {
        my $lhsExprInfo = $info->{'Lhs'};
        my $rhsExprInfo = $info->{'Rhs'};
        # Assg _ srcspan lhsExpr rhsExpr -> foldl (combineAnalysisInfo) analysisInfoBaseCase [lhsExprAnalysis,
        #                                                                                         (DMap.empty,[],
        #                                                                                         prexistingReadExprs,
        #                                                                                         if isNonTempAssignment then [lhsExpr] else [])]
            # where
# --    Type used to standardise loop analysis functions
# --    Functions below are used to manupulate and access the AnalysisInfo. 
# --                        errors         reduction variables read variables       written variables    
# type AnalysisInfo =     (Anno,         [Expr Anno],         [Expr Anno],         [Expr Anno])                
            # lhsExprAnalysis :: AnalysisInfo
        my $lhsExprAnalysis = analyseLoopIteratorUsage( $comment, $loopVars, $loopWrites, $nonTempVars, $accessAnalysis, $lhsExprInfo);
        my $isNonTempAssignment = usesVarName_list( $nonTempVars, $lhsExprInfo->{'VarAccesses'});
        # readOperands :: [Expr]
        my $readOperands=createExprListFromVarAccesses($rhsExprInfo->{'VarAccesses'}, 'Read');
        # my $readOperands = extractOperands( $rhsExprInfo);
        # WV: not sure if this should not be the same as for the Reduction
        my $readExprs = foldl(
            sub { my ($accum,$item) = @_;
            return [@{$accum},@{extractContainedVars($item)},$item];
            }
            , [], $readOperands
            );
        my $prexistingReadExprs = filter( 
            sub {
                my ($readExpr)=@_;
                return usesVarName_list($prexistingVars,$readExpr);
                }, $readExprs);
        $state = combineAnalysisInfo(  $state, [
            $lhsExprAnalysis, 
            [{},[],$prexistingReadExprs, $isNonTempAssignment ? [$lhsExprInfo->{'VarAccesses'}] : []] 
            ] );
    }
    if (exists $info->{'Do'}) { # We assume that the expression is entirely static and has been folded so only var really matters
    #     # I need to put the loop var is already in loopVars
    #     For _ _ var e1 e2 e3 _ -> 
    # gmapQ looks at the loops nested in the given loop, but only one level
    #     childrenAnalysis = (gmapQ (mkQ analysisInfoBaseCase (analyseLoop_map comment (loopVars ++ [var]) loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable)) codeSeg)

    # childrenAnalysis should be done via $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'Contains'} 
    # Like this but it has to be recursive!
    my $childrenAnalysis=childrenAnalysis($block_id,$accessAnalysis,$analysisInfoBaseCase);
    
            # return foldl( &combineAnalysisInfo, $analysisInfoBaseCase, $childrenAnalysis);
        }
        # Call _ srcspan callExpr arglist -> callAnalysis
        #     where
        #         #    If the called subroutine exists in a file that was supplied to the compiler, analyse it. If the subroutine is parallelisable,
        #         #    it is not parallelised internally but is instead included as part of some externel parallelism. If the subroutine was not parsed
        #         #    then add a parallelism error to the annotations.
        #         recursiveCall = analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable

        #         subroutineName = if extractVarNames callExpr == [] then (error "analyseLoop_map: callExpr" ++ (show callExpr))  else varNameStr (head (extractVarNames callExpr))
        #         argTranslation = generateArgumentTranslation subTable codeSeg
        #         (subroutineParsed, subTableEntry) = case DMap.lookup subroutineName subTable of
        #                                 Just a -> (True, a)
        #                                 Nothing -> (False, error "analyseLoop_map: DMap.lookup subroutineName subTable")
        #         subroutineBody = subroutineTable_ast subTableEntry
        #         subCallAnalysis = recursiveCall (extractFirstFortran subroutineBody)

        #         callAnalysis =     if not subroutineParsed then
        #                             (errorMap_call, [], [], argExprs)
        #                         else
        #                             subCallAnalysis

        #         errorMap_call = DMap.insert (outputTab ++ comment ++ "Call to external function:\n")
        #                                     [errorLocationFormatting srcspan ++ outputTab ++ outputExprFormatting callExpr]
        #                                     DMap.empty
        #         argExprs = everything (++) (mkQ [] extractExpr_list) arglist

        # FSeq _ srcspan codeSeg1 codeSeg2 -> combineAnalysisInfo codeSeg1Analysis codeSeg2Analysis
        #     where
        #         recursiveCall = analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable
        #         codeSeg1Analysis = recursiveCall codeSeg1
        #         codeSeg2Analysis = recursiveCall codeSeg2
        # _ -> foldl combineAnalysisInfo analysisInfoBaseCase (childrenAnalysis ++ nodeAccessAnalysis)
        #     where
        #         recursiveCall = analyseLoop_map comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable

        #         nodeAccessAnalysis = gmapQ (mkQ analysisInfoBaseCase (analyseLoopIteratorUsage comment loopVars loopWrites nonTempVars accessAnalysis)) codeSeg
        #         childrenAnalysis = gmapQ (mkQ analysisInfoBaseCase recursiveCall) codeSeg
    };

    my $state = $analysisInfoBaseCase;
    (my $new_annlines,$state) = stateful_pass($codeSeg,$pass_analyseLoop_map,$state, "pass_analyseLoop_map($f)");
} 

sub childrenAnalysis { my ($block_id,$accessAnalysis,$childrenAnalysis) = @_;
    if (exists $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'Contains'}) {
        for my $child_block_id  (sort keys %{$accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'Contains'}} ) {        
                $childrenAnalysis = childrenAnalysis($child_block_id,$accessAnalysis,$childrenAnalysis)
        }    
    } 
    my $childAnalysis = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'AnalysisInfo'};
    $childrenAnalysis = combineAnalysisInfo($childrenAnalysis,$childAnalysis);                   

    return $childrenAnalysis
}

#    Applied to an expression, returns an AnalysisInfo loaded with an error if it does not use all of the loop iterators in some way. As in,
#    in a nested loop over 'i' and 'j', expression 'x(i) + 12' doesn't use the iterator 'j' and so the AnalysisInfo will report that. If
#    this error occurs when looking for a map then a map cannot be performed. if it is found while looking for a reduction, it is a sign that
#    this expression represents a reduction variable.
# analyseLoopIteratorUsage :: String -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> VarAccessAnalysis -> Expr Anno -> AnalysisInfo
sub analyseLoopIteratorUsage {my ($comment, $loopVars, $loopWrites, $nonTempVars, $accessAnalysis, $lhs_expr_info) = @_;
# where
# operands :: [Expr] which is [$varname,{...}] which we should get from %{$info->{'Lhs'}{'VarAccesses'}};
    my $writtenOperands = createExprListFromVarAccesses($lhs_expr_info->{'VarAccesses'});
    # my $operands = case fnCall of
    #         True ->    extractContainedVars expr
    #         False -> extractOperands expr
    # writtenOperands = filter (usesVarName_list loopWrites) operands
    # fnCall = isFunctionCall f95IntrinsicFunctions accessAnalysis expr
    my $nonTempWrittenOperands = filter( sub { (my $var_name) = @_;
        return usesVarName_list($nonTempVars, $var_name);
     },$writtenOperands);
    my $unusedIterMap = foldl( sub { my ($accumAnno,$loopVar) = @_;    
        return analyseLoopIteratorUsage_foldl( $nonTempWrittenOperands,$comment,$accumAnno,$loopVar);
    }, {}, $loopVars);
    return [$unusedIterMap, [],[],[]];
}
# analyseLoopIteratorUsage_foldl :: [Expr Anno] -> String -> Anno -> VarName Anno -> Anno
sub analyseLoopIteratorUsage_foldl { my ($nonTempWrittenOperands, $comment, $accumAnno, $loopVar) = @_;
        # where
    my $offendingExprs = filter(
            sub  { my ($item) = @_;
                return not elem( $loopVar, 
                    foldl( 
                        sub { my ($accum, $item) =@_;
                            return [@{$accum},@{ extractVarNames($item)}];
                        }, [], extractContainedOperands($item) 
                    )
                )                 
            },$nonTempWrittenOperands);

    my $offendingExprsStrs = map { errorLocationFormatting( srcSpan( $_) } . $outputTab . outputExprFormatting($_)) } @{$offendingExprs};

    my $loopVarStr = $loopVar;
    my $resultantMap = {};
    if (scalar @{$offendingExprs} == 0)  {
                            $resultantMap = $accumAnno
                        } else {
                                $resultantMap = DMap.insert (outputTab ++ comment ++ "Non temporary, write variables accessed without use of loop iterator \"" ++ loopVarStr ++ "\":\n") offendingExprsStrs accumAnno
                        }
my $nonTempWrittenOperandsStrs = map (\item -> errorLocationFormatting (srcSpan item) ++ outputTab ++ outputExprFormatting item) nonTempWrittenOperands
    return $resultantMap;            
}


# combineAnalysisInfo :: AnalysisInfo -> AnalysisInfo -> AnalysisInfo
# combineAnalysisInfo accum item = (combineMaps accumErrors itemErrors, accumReductionVars ++ itemReductionVars, accumReads ++ itemReads, accumWrites ++ itemWrites)
#         where
#             (accumErrors, accumReductionVars, accumReads, accumWrites) = accum
#             (itemErrors, itemReductionVars, itemReads, itemWrites)     = item
sub combineAnalysisInfo { my ($accumAnalysis, $analysisInfoItem)=@_;
    my ($accumErrors,$accumReductionVars,$accumReads,$accumWrites) = @{$accumAnalysis};
    my ($itemErrors,$itemReductionVars,$itemReads,$itemWrites)     = @{$analysisInfoItem};
    return [
        { %{$accumErrors},%{$itemErrors}}, 
        [@{$accumReductionVars}, @{$itemReductionVars}], 
        [@{$accumReads}, @{$itemReads}], 
        [@{$accumWrites}, @{$itemWrites}]
    ];
}
=pod
-- WV20170426 The addition of these loop variables is a bit ad-hoc because 
paralleliseLoop_reduceWithOuterIteration :: String -> Fortran Anno -> Maybe (Fortran Anno) -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> VarDependencyAnalysis -> VarAccessAnalysis -> (Bool, Fortran Anno)
paralleliseLoop_reduceWithOuterIteration filename loop Nothing loopVarNames loopVarNames' nonTempVars prexistingVars dependencies accessAnalysis     
    |    nextFor_maybe == Nothing = (False, loop')                                                                                                                             
    |    otherwise = (reduceWithOuterIterationAttempt_bool, newAst')
        where
            loop'' = everywhere (mkT (updateIterLoopVars loopVarNames)) loop
            loop' = loop'' -- warning loop'' ("! ITERATIVE LOOP (1a): \n"++(show loopVarNames')++"\n"++(miniPPF loop'')++"\n! END ITERATIVE LOOP (1a)\n" )
            newAst' = newAst -- warning newAst ("! ITERATIVE LOOP (1b): \n"++(show loopVarNames')++"\n"++(miniPPF newAst)++"\n! END ITERATIVE LOOP (1b)\n" )
            nextFor_maybe = extractFirstChildFor loop
            (priorFortran, nextFor, followingFortran) = case nextFor_maybe of 
                            Nothing -> error "paralleliseLoop_reduceWithOuterIteration: nextFor_maybe is Nothing"25 
                            Just a -> a
            newLoopVarNames = case getLoopVar nextFor of
                Just a -> loopVarNames' ++ [a]
                Nothing -> loopVarNames'                            
            (reduceWithOuterIterationAttempt_bool, reduceWithOuterIterationAttempt_ast) = paralleliseLoop_reduceWithOuterIteration filename loop (Just nextFor) loopVarNames newLoopVarNames nonTempVars prexistingVars dependencies accessAnalysis
            newAst = case reduceWithOuterIterationAttempt_ast of
                        For a1 a2 a3 a4 a5 a6 fortran -> For a1 a2 a3 a4 a5 a6 (appendFortran_recursive (appendFortran_recursive followingFortran fortran) priorFortran)

paralleliseLoop_reduceWithOuterIteration filename iteratingLoop (Just parallelLoop) loopVarNames loopVarNames' nonTempVars prexistingVars dependencies accessAnalysis 
                | errors_reduce' == nullAnno     =    
                    (True, appendAnnotation reduceWithOuterIterationCode (compilerName ++ ": Reduction with outer iteration at " ++ errorLocationFormatting (srcSpan iteratingLoop) ++ " with parallel loop at "  ++ errorLocationFormatting (srcSpan parallelLoop')) "")
                | nextFor_maybe /= Nothing     =     
                    paralleliseLoop_reduceWithOuterIteration filename (appendAnnotationMap iteratingLoop errors_reduce') (Just nextFor) loopVarNames newLoopVarNames nonTempVars prexistingVars dependencies accessAnalysis 
                | otherwise                    =    (False, appendAnnotationMap iteratingLoop errors_reduce')

        where            
            parallelLoop' = parallelLoop -- warning parallelLoop ("! ITERATIVE LOOP (1a): \n"++(show loopVarNames')++"\n"++(miniPPF parallelLoop)++"\n! END ITERATIVE LOOP (1a)\n" )
            loopWrites = extractWrites_query parallelLoop'
            loopAnalysis = analyseLoop_reduce reduceWithOuterIterationComment [] [] loopWrites nonTempVars prexistingVars dependencies accessAnalysis parallelLoop' 
            errors_reduce = getErrorAnnotations loopAnalysis
            reductionVarNames = getReductionVarNames loopAnalysis
            reads_reduce = getReads loopAnalysis
            writes_reduce = getWrites loopAnalysis
            -- WV: CHECK THIS!
            iteratingLoop' =   everywhere (mkT (updateIterLoopVars loopVarNames)) iteratingLoop -- warning iteratingLoop ("! ITERATIVE LOOP (2): \n"++(miniPPF iteratingLoop)++"\n! END ITERATIVE LOOP (2)\n" )
            iteratingLoopVars = listSubtract (extractLoopVars iteratingLoop') (extractLoopVars parallelLoop')

            (loopCarriedDeps_bool, evaluated_bool, loopCarriedDeps) = loopCarriedDependencyCheck_reductionWithIteration iteratingLoop parallelLoop'
            errors_reduce' = case loopCarriedDeps_bool of
                                True -> case evaluated_bool of
                                        True -> DMap.insert (outputTab ++ "Cannot reduce: Loop carried dependency detected:\n") (formatLoopCarriedDependencies loopCarriedDeps) errors_reduce
                                        False -> DMap.insert (outputTab ++ "Cannot reduce: Loop carried dependency possible (not evaluated):\n") (formatLoopCarriedDependencies loopCarriedDeps) errors_reduce
                                False -> errors_reduce

            loopVariables = loopCondtions_query parallelLoop'

            startVarNames = foldl (\accum (_,x,_,_) -> accum ++ extractVarNames x) [] loopVariables
            endVarNames = foldl (\accum (_,_,x,_) -> accum ++ extractVarNames x) [] loopVariables
            stepVarNames = foldl (\accum (_,_,_,x) -> accum ++ extractVarNames x) [] loopVariables

            nextFor_maybe = extractFirstChildFor parallelLoop'
            (priorFortran, nextFor, followingFortran) = case nextFor_maybe of 
                            Nothing -> error "paralleliseLoop_reduceWithOuterIteration: nextFor is Nothing"
                            Just a -> a
            newLoopVarNames = case getLoopVar nextFor of
                Just a -> loopVarNames' ++ [a]
                Nothing -> loopVarNames'                             
            newAst = appendFortran_recursive followingFortran (appendFortran_recursive reductionCode priorFortran)

            reduceWithOuterIterationCode = case iteratingLoop of
                                        For a1 a2 a3 a4 a5 a6 fortran -> For a1 a2 a3 a4 a5 a6 newAst -- reductionCode
                                        _ -> error "paralleliseLoop_reduceWithOuterIteration: iterating loop is not FOR"

            varNames_loopConditions = listSubtract (listRemoveDuplications (startVarNames ++ endVarNames ++ stepVarNames)) loopVarNames
            containedLoopIteratorVarNames = (map (\(a, _, _, _) -> a) (loopCondtions_query parallelLoop'))

            reads_map_varnames = foldl (++) [] (map extractVarNames reads_reduce)
            readArgs = (listRemoveDuplications $ listSubtract reads_map_varnames (containedLoopIteratorVarNames ++ iteratingLoopVars)    )    -- List of arguments to kernel that are READ
            -- readArgs = (listRemoveDuplications $ listSubtract reads_map_varnames (containedLoopIteratorVarNames ++ varNames_loopConditions ++ iteratingLoopVars)    )    -- List of arguments to kernel that are READ
            
            writes_map_varnames = foldl (++) [] (map extractVarNames writes_reduce)
            writtenArgs = (listRemoveDuplications $ listSubtract writes_map_varnames containedLoopIteratorVarNames)     -- List of arguments to kernel that are WRITTEN
            
            allReductionVarNames = (foldl (\accum item -> accum ++ extractVarNames item) [] reductionVarNames)
            reductioNVarInfo = (listRemoveDuplications (foldl (\accum item -> accum ++ [(item, getValueAtSrcSpan item (srcSpan parallelLoop') accessAnalysis)] ) [] allReductionVarNames))

            iterLoopVariables = extractLoopVars iteratingLoop -- WV20170426
            reductionCode' = reductionCode -- warning reductionCode (miniPPF reductionCode)
            reductionCode = OpenCLReduce nullAnno (generateSrcSpan filename (srcSpan parallelLoop'))  -- WV20170426 
                         readArgs            -- List of arguments to kernel that are READ
                        writtenArgs         -- List of arguments to kernel that are WRITTEN
                        loopVariables        -- Loop variables of nested maps
                        iterLoopVariables -- WV20170426
                        reductioNVarInfo     -- List of variables that are considered 'reduction variables' along with their initial values
                        (removeLoopConstructs_recursive parallelLoop') -- Body of kernel code
            reduceWithOuterIterationComment = "Cannot iterative reduce (iter:" ++ (errorLocationFormatting $ srcSpan iteratingLoop) ++ ", par:" ++ (errorLocationFormatting $ srcSpan parallelLoop') ++ "): "

--    Function uses a SYB query to get all of the loop condtions contained within a particular AST. loopCondtions_query traverses the AST
--    and calls getLoopConditions when a Fortran node is encountered.
loopCondtions_query :: (Typeable p, Data p) =>  Fortran p -> [(VarName p, Expr p, Expr p, Expr p)]
loopCondtions_query = everything (++) (mkQ [] getLoopConditions)

getLoopConditions :: (Typeable p, Data p) => Fortran p -> [(VarName p, Expr p, Expr p, Expr p)]
getLoopConditions codeSeg = case codeSeg of
        For _ _ var start end step _ -> [(var, start, end, step)]
        OpenCLMap _ _ _ _ loopVars iterLoopVars _ -> loopVars -- WV20170426
        OpenCLReduce _ _ _ _ loopVars iterLoopVars _ _ -> loopVars -- WV20170426
        _ -> []    
=cut
#    Function is applied to sub-trees that are loops. It returns either a version of the sub-tree that uses new OpenCLMap nodes or the
#    original sub-tree annotated with reasons why the loop cannot be mapped
# paralleliseLoop_map :: String -> Fortran Anno -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> VarDependencyAnalysis -> VarAccessAnalysis -> SubroutineTable -> (Bool, Fortran Anno, VarAccessAnalysis)
sub paralleliseLoop_map {
    my ($stref,$f, $loop, $loopVarNames, $nonTempVars, $prexistingVars, $dependencies,$accessAnalysis, $block_id) = @_;
    # loopWrites :: [VarName]
    my $loopWrites = extractWrites_query( $loop); #
    # WV: def: analyseLoop_map  comment loopVars loopWrites nonTempVars prexistingVars accessAnalysis dependencies subTable codeSeg 
    # loopAnalysis :: AnalysisInfo
    my $loopAnalysis = analyseLoop_map( $stref, $f, "Cannot map: ", [], $loopWrites, $nonTempVars, $prexistingVars, $accessAnalysis, $dependencies, $loop, $block_id); #subTable

    my $errors_map = getErrorAnnotations( $loopAnalysis);
    my $reads_map = getReads( $loopAnalysis);
    my $writes_map = getWrites( $loopAnalysis);

    my ($loopCarriedDeps_bool, $evaluated_bool, $loopCarriedDeps) = loopCarriedDependencyCheck( $loop);

    my $errors_mapQ = $loopCarriedDeps_bool 
        ? $evaluated_bool 
                ? insert ($outputTab . "Cannot map: Loop carried dependency detected:\n",
                    formatLoopCarriedDependencies($loopCarriedDeps), $errors_map)
                : insert ($outputTab . "Cannot map: Loop carried dependency possible (not evaluated):\n",
                    formatLoopCarriedDependencies( $loopCarriedDeps), $errors_map)
        : $errors_map
    ;
    my $loopVariables = loopConditions_query( $loop); 
    my $startVarNames = foldl (sub { my ($accum, $tup) =@_;
        my ($e1,$x,$e3,$e4) = @{$tup};
        return  [@{$accum} ,@{ extractVarNames( $x)}]
        }, [],$loopVariables);
    my $endVarNames = foldl (sub { my ($accum, $tup) =@_; 
        my ($e1,$e2,$x,$e4) = @{$tup};
        return [@{$accum} ,@{ extractVarNames( $x)}];
        }, [], $loopVariables);
    my $stepVarNames = foldl (sub { my ($accum, $tup) =@_; 
        my ($e1,$e2,$e3,$x) = @{$tup};
        return  [@{$accum} ,@{ extractVarNames( $x)}];
        }, [], $loopVariables);

    # my $varNames_loopConditions = listSubtract(listRemoveDuplications([@{$startVarNames}, @{$endVarNames}, @{$stepVarNames}]),$loopVarNames);
    # This gets the VarNames out of the tuple [iter_var_name, start, stop, step]
    # We have this info in $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}
    my $containedLoopIteratorVarNames = map {
        $_->[0] # or something, TODO!
        # (\(a, _, _, _) -> a)
        } @{$loopVariables};

    my $reads_map_varnames = foldl( sub {  my ($accum, $elt) =@_;
            return [@{$accum},@{$elt}];   #  (++)
    }   , [],map {extractVarNames($_)} @{$reads_map});
    my $readArgs = listRemoveDuplications( listSubtract( $reads_map_varnames, $containedLoopIteratorVarNames)); # List of arguments to kernel that are READ
        # readArgs = (listRemoveDuplications $ listSubtract reads_map_varnames (containedLoopIteratorVarNames ++ varNames_loopConditions)    )    # List of arguments to kernel that are READ
        
    my $writes_map_varnames = foldl( sub {  my ($accum, $elt) =@_;
            return [@{$accum},@{$elt}];   #  (++)
    }   , [],map {extractVarNames($_)} @{$writes_map});
    my $writtenArgs = listRemoveDuplications( listSubtract( $writes_map_varnames, $containedLoopIteratorVarNames));     # List of arguments to kernel that are WRITTEN
        # WV20170426
    my $iterLoopVariables=[];

    my $mapCode = ['TODO!'];
    
    # OpenCLMap nullAnno (generateSrcSpan filename (srcSpan loop))     # Node to represent the data needed for an OpenCL map kernel -- WV20170426
    #         readArgs        # List of arguments to kernel that are READ
    #         writtenArgs     # List of arguments to kernel that are WRITTEN
    #         loopVariables    # Loop variables of nested maps
    #         iterLoopVariables # WV20170426
    #         removeLoopConstructs_recursive( $loop); # Body of kernel code

    if (   $errors_mapQ == $nullAnno) {    
        return [$True, appendAnnotation( $mapCode, "$0 : Map at " . errorLocationFormatting (srcSpan $loop) . "")];
    } else {   
        return [$False, appendAnnotationMap( $loop, $errors_mapQ)];
    }

} # END of paralleliseLoop_map



# --    These functions are used to extract a list of varnames that are written to in a particular chunk of code. 
# --    WV: TODO: what about subroutine calls in the loop?
# extractWrites_query :: (Typeable p, Data p) => Fortran p -> [VarName p]
# extractWrites_query = everything (++) (mkQ [] extractWrites)

# extractWrites :: (Typeable p, Data p) => Fortran p -> [VarName p]
# extractWrites (Assg _ _ (Var _ _ list) _) = map (fst) list
# extractWrites _ = []

sub extractWrites_query{ my ($loop) = @_;
my @writes=();
    for my $annline (@{$loop}) {
        my ($line, $info) = @{$annline};
        if (exists $info->{'Assignment'}) {
            push @writes, $info->{'Lhs'}{'VarName'};
        }
    }
    return \@writes;
}
# analyseDependencies :: Fortran Anno -> VarDependencyAnalysis
sub analyseDependencies { my ($codeSeg) =@_;
                        # where
    my $assignments = extractAssignments($codeSeg);
    # We start from an empty VarDependencyAnalysis table
    my $varDeps = foldl(
        sub { my ($accum,$item) = @_;
            constructDependencies($accum,$item) 
        }, {}, $assignments 
    );
    return $varDeps;
}

sub extractAssignments { my ($codeSeg) = @_;

    my @assignments = grep { 
        my ($line, $info) = @{$_};
        exists $info->{'Assignment'} 
    } @{$codeSeg};

    return \@assignments;
}


# constructDependencies :: VarDependencyAnalysis -> Fortran Anno -> VarDependencyAnalysis
# constructDependencies prevAnalysis (Assg _ _ expr1 expr2) 

# constructDependencies prevAnalysis _ = prevAnalysis

#     Type used to colate dependency data between variables within a particular block of code
#                                         Variable A         depends on all these expressions
# type VarDependencyAnalysis = DMap.Map (VarName Anno) [Expr Anno]


# constructDependencies :: VarDependencyAnalysis -> Fortran Anno -> VarDependencyAnalysis
sub constructDependencies { my ($prevAnalysis,  $annline)=@_;
    my ($line, $info)  = @{$annline};
   
    # create a tuple [$var_name,{Exprs ...}], see doc for createExprListFromVarAccesses
    my $readOperands=createExprListFromVarAccesses($info->{'Rhs'}{'VarAccesses'}, 'Read');
    my $writtenVarNames = [$info->{'Lhs'}{'VarName'}];

    my $varDepAnalysis = foldl( sub { my ($accum, $item) = @_; 
        addDependencies($accum,$item,$readOperands);
    }, $prevAnalysis, $writtenVarNames);
    return $varDepAnalysis;
}

# addDependencies :: VarDependencyAnalysis -> VarName Anno -> [VarName Anno] -> VarDependencyAnalysis
#    A dependent depends on a dependee. For example
#        A = B + 12
#    A depends on B. A is the dependee, B is the dependent
# addDependencies :: VarDependencyAnalysis -> VarName Anno -> [Expr Anno] -> VarDependencyAnalysis
sub addDependencies {my ($prevAnalysis,$dependent,$dependees) = @_;
    foldl( sub { my ($accum,$item) = @_;
        addDependency( $accum,$dependent,$item)
        },
    $prevAnalysis,$dependees );
}
# addDependency :: VarDependencyAnalysis -> VarName Anno -> Expr Anno -> VarDependencyAnalysis
sub addDependency { my ($prevAnalysis, $dependent, $dependee) = @_;
    appendToMap( $dependent, $dependee, $prevAnalysis);
}


sub parallelise_all_Blocks { my ($stref, $f, $accessAnalysis, $annlines_foldedConstants) = @_;
    # 1. look for the blocks with the longest ID
    my $max_lev = 0;
    my $blocks_per_nestlevel = [];
    for my $block_id (@{$accessAnalysis->{'LoopNests'}{'List'}[0]}) {
        my $nest_lev = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'NestLevel'};
        push @{$blocks_per_nestlevel->[$nest_lev]},$block_id;
        $max_lev = max($max_lev, $nest_lev);
    }

    for my $rev_lev (0 .. $max_lev-1) {
        my $nest_lev = $max_lev - $rev_lev;
        for my $block_id (@{$blocks_per_nestlevel->[$nest_lev]}) {
            if ($nest_lev>1) {
                my $in_block_id = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'InBlock'};
                my $line_id = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'BlockEnd'};
                $accessAnalysis->{'LoopNests'}{'Set'}{$in_block_id}{'Contains'}{$block_id}=$line_id;
            }
        }
    }

    my $parallelisedProgUnit = dclone($annlines_foldedConstants);
    # my $parallelised_loops={};
    for my $rev_lev (0 .. $max_lev-1) {
        my $nest_lev = $max_lev - $rev_lev;
        for my $block_id (@{$blocks_per_nestlevel->[$nest_lev]}) {
            ($parallelisedProgUnit,$accessAnalysis) = paralleliseBlock($stref, $f, $accessAnalysis, $parallelisedProgUnit, $block_id);
            # $parallelised_loops->{$block_id} = $loop_annlines;
            # But really we should put those loops into $parallelisedProgUnit, a copy of $annlines_foldedConstants
            # It is not hard: based on $accessAnalysis we get the LineIDs for the $loop_annlines
            # Then we need an elegant way to remove the old and put in the new.
        }
    }

    return ($parallelisedProgUnit, $accessAnalysis);
}
# maybe annotate the blocks with this number for convenience

# 2. Get all blocks with that length, process them
# 3. Get all blocks with length $max_id_len-1, process them; treat the ones that occur in the InBlock of step 2 as non-leaf
# We do this by testing for existence of a field 
    # 'Contains' => {$block_id => nature of the loop}
# 4. etc, until length 1 i.e. no loop

# in the right order. 


    # 'LoopNests' => { 
    #     'List' => [ [$block_id,$iterator,{Range => []}],... ],
    #     'Set' => {
    #         $block_id => {
    #             'BlockStart' => LineID,
    #             'BlockEnd' => LineID,
    #             'Iterator' => $loopvar,
    #             'Range' => []
    #             'InBlock' => BlockID,
    #             'NestLevel' => Int >= 1,
    #             'Contains' => {
    #                 $contained_block_id_1 => {...},
    #               }
    #         },
    #     }
    # }
# Handling nested blocks

# --    This function is called using generics so that every 'Block' is traversed. This step is necessary to be able to reach the first 'Fortran'
# --    node. From here, the first call to 'isolateAndParalleliseForLoops' is made (again with generics) which recursively traverses the 'Fortran' nodes to
# --    find for loop that should be analysed
# paralleliseBlock :: String -> SubroutineTable -> VarAccessAnalysis -> Block Anno -> Block Anno
# paralleliseBlock filename subTable accessAnalysis block = gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis)) block

# --    Function traverses the 'Fortran' nodes to find For loops. It calls 'paralleliseLoop' on identified for loops in a recusive way such that the most
# --    nested loops in a cluster are analysed first.
# isolateAndParalleliseForLoops :: String -> SubroutineTable -> VarAccessAnalysis -> Fortran Anno -> Fortran Anno
# isolateAndParalleliseForLoops filename subTable accessAnalysis inp = case inp of
#         For _ _ _ _ _ _ _ -> paralleliseLoop filename [] accessAnalysis subTable recusivelyAnalysedNode
#             where
#                 recusivelyAnalysedNode = gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis )) inp
#         _ -> gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis)) inp


sub paralleliseBlock { my ($stref, $f, $accessAnalysis, $annlines_foldedConstants, $block_id) = @_;
    
# gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis)) block
    (my $loop_annlines,my $updated_accessAnalysis) = isolateAndParalleliseForLoops($stref, $f, $accessAnalysis, $annlines_foldedConstants, $block_id);

    return ($loop_annlines,$updated_accessAnalysis);
}

sub isolateAndParalleliseForLoops { my ($stref, $f, $accessAnalysis, $annlines_foldedConstants, $block_id) = @_;
    # so here we cut out the loop with $block_id from $annlines_foldedConstants
    # we loop up the begin and end LineID from $accessAnalysis
    my $block_start = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id }{'BlockStart'};
    my $block_end = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id }{'BlockEnd'};
    my $loop_var = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id }{'Iterator'};
    # 'BlockEnd' => LineID,
    # 'Iterator' => $loopvar,
    # 'Range' => [...]

    # I think what we do is: we accumulate the lines of the block and when we reach the end
    # we call paralleliseLoop on those accumuated lines.
    # That returns an updated block which is in principle simple a new node OpenCLMap etc
    # I then replace the EndDo node with this new node and I store the old loop lines just in case
    # 
    my $pass_paralleliseLoop = sub { my ($annline,$state) = @_;
        my ($line,$info) = @_;
        # What we do now is:
        if ($state->{'InBlock'}==0) {
            if ($info->{'LineId'} == $block_start) {
                $state->{'InBlock'}=1;
                # Put the annline into LoopAnnLines
                push @{$state->{'LoopAnnLines'}},$annline;
                # return nothing
                return [[],$state];
            } else {
                # return the original line
                return [[$annline],$state];
            }
        } else {
            # Put the annline into LoopAnnLines
            push @{$state->{'LoopAnnLines'}},$annline;
            if ($info->{'LineId'} == $block_end) {
                $state->{'InBlock'}=0;
                # Do the actual processing of the loop code
                my $loop_annlines = $state->{'LoopAnnLines'};
                my ($updated_loop_annlines,$updated_accessAnalysis) = paralleliseLoop($stref, $f, $loop_var, $state->{'AccessAnalysis'}, $loop_annlines, $block_id);
                $state->{'AccessAnalysis'}=$updated_accessAnalysis;
                # Replace the block
                return [$updated_loop_annlines, $state];
            } else {
                # return nothing
                return [[],$state];
            }
        }
    };
    
    my $state = { 'InBlock' => 0 , 'LoopAnnLines' => [], 'AccessAnalysis' => $accessAnalysis };

    (my $updated_loop_annlines,$state) = stateful_pass($annlines_foldedConstants,$pass_paralleliseLoop,"pass_paralleliseLoop($f)");

    my $updated_accessAnalysis = $state->{'AccessAnalysis'};

    return ($updated_loop_annlines,$updated_accessAnalysis);
} # END of isolateAndParalleliseForLoops




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

# This is my equivalent for Expr. The hash is stored as $info->{Rhs|Lhs|nothing}{'VarAccesses'}{Scalar|Array}{$scalar_var1}{Read|Write}
#
# [$varname_str, { 
#      'Exprs' => {
#          'v(i,j+1,k-1)' => '0:1:-1',
#            $expr_str_1=>$offsets_str_1,...
#        }, 
#      'Accesses' =>{ 
#             '0:1:-1' => { 
#                 'i:0' => [1,0],
#                 'j:1' => [1,1],
#                 'k:2' => [1,-1]
#                 }
#            $offsets_str_1  => {
#                "$iter_var_name:$idx" =>  [$mult_val,$offset_val]
#            }
#        }, 
#      'Iterators' => ['i:0','j:1','k:2',
#          "$iter_var_name:$idx",...]
       
#     }
# ]

# This function takes VarAccesses and turns them into a list of expressions
sub createExprListFromVarAccesses { (my $accesses, my $rw) = @_;
 my $tmph = {
     %{$accesses->{'Arrays'}},
     %{$accesses->{'Scalars'}}
     };
    # create a tuple [$var_name,{Exprs ...}]
    my $operands=[];
    for my $var (sort keys %{$tmph}) {
        if (exists $tmph->{$var}{$rw}) {
            push @{$operands},[$var,$tmph->{$var}{$rw}];
        }
    }
    return $operands;
}

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

# appendToMap :: Ord k => k -> a -> DMap.Map k [a] -> DMap.Map k [a]
sub appendToMap { my ($key, $item, $table) = @_;
    my $ntable = insert( $key, [@{findWithDefault( [], $key, $table)},$item],$table);
    return $ntable;
}

sub listRemoveDuplications { ordered_union(@_); }

sub usesVarName_list { my ($varname_list, my $expr)=@_;

    my $var_from_expr = $expr->[0];
    return elem($var_from_expr,$varname_list);
}

sub elem { my ($elt,$lst) = @_;
    my %hash = map {$_=>1} @{$lst};
    return exists %hash{$elt} ? 1 : 0;
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

sub max { (my $v1, my $v2) =@_;
    return $v1 < $v2 ? $v2 : $v1;
}

sub min { (my $v1, my $v2) =@_;
    return $v1 > $v2 ? $v2 : $v1;
}

1;
