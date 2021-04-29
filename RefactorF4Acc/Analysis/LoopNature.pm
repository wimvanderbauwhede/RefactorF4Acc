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


# $accesses :

# Assignment: $info->{'Lhs'}{'VarAccesses'}, $info->{'Rhs'}{'VarAccesses'}
# If/ElseIf : $info->{'VarAccesses'}
# Case is not done yet, $info->{'CaseVar'} should have $info->{'VarAccesses'}, TODO
# While should not occur in F77 but still, we should do it, TODO

#					$accesses->{'Arrays'}{$array_var}{$rw}{'Exprs'}{$expr_str}=$offsets_str 
#						where 					
#							my $offsets_str :: String = join(':', @offset_vals);
#							my @offset_vals :: [Int]
#					$accesses->{'Arrays'}{$array_var}{$rw}{'Accesses'}{ $offsets_str } = $iter_val_pairs;
#						where
#							my $iter_val_pairs = [{$iter_str => [$mult,$offset]}, ... ]
#					$accesses->{'Arrays'}{$array_var}{$rw}{'Iterators'} = ['j:0','k:1'];

#					$accesses->{'Arrays'}{$array_var}{$rw}{'HaloAccesses'}{$loop_iter} = 
#						{'Bound' =>$b, 'Test' => [$loop_bound, $offset, $array_bound, $array_halo]};
#					$accesses->{'HasHaloAccesses'}=1;

#					$accesses->{'Scalars'}{$scalar_var}{$rw}{'Exprs'}{$expr_str}=$expr_str

our $outputTab = "\t";
our $True = 1;
our $False = 0;
our $nullAnno = {};
# type SubroutineTable = DMap.Map SubNameStr SubRec -- (ProgUnit Anno, String)
# So this corresponds to $stref->{'Subroutines'}
#                          errors         reduction variables  read variables       written variables    
# type AnalysisInfo =     (Anno,         [Expr Anno],         [Expr Anno],         [Expr Anno])
# type Anno = DMap.Map (String) [String]

# LoopAnalysis.analysisInfoBaseCase :: AnalysisInfo
our $analysisInfoBaseCase = [{},[],[],[]];
# data TupleTable = ['LoopIterRecord', { Int => TupleTable}] |  ['Empty'] 
# data Maybe = ['Just',a] | ['Nothing']

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

sub paralleliseBlock { my ($stref, $f, $accessAnalysis, $annlines_foldedConstants, $block_id) = @_;
    
# gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis)) block
    (my $loop_annlines,my $updated_accessAnalysis) = isolateAndParalleliseForLoops($stref, $f, $accessAnalysis, $annlines_foldedConstants, $block_id);

    return ($loop_annlines,$updated_accessAnalysis);
}

# --    Function traverses the 'Fortran' nodes to find For loops. It calls 'paralleliseLoop' on identified for loops in a recusive way such that the most
# --    nested loops in a cluster are analysed first.
# isolateAndParalleliseForLoops :: String -> SubroutineTable -> VarAccessAnalysis -> Fortran Anno -> Fortran Anno
# isolateAndParalleliseForLoops filename subTable accessAnalysis inp = case inp of
#         For _ _ _ _ _ _ _ -> paralleliseLoop filename [] accessAnalysis subTable recusivelyAnalysedNode
#             where
#                 recusivelyAnalysedNode = gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis )) inp
#         _ -> gmapT (mkT (isolateAndParalleliseForLoops filename subTable accessAnalysis)) inp

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
                # $updated_loop_annlines is just a single node, call it $info->{'LoopBlock'}
                # And a subfield of that is its Nature, which I think can be Map, Fold, Iter and in addition Stencil
                # $info->{'LoopBlock'}=
                # {
                #     'Nature' => { 
                #         Map | Fold | Iter => [loop iterators], 
                #         Stencil => {arrays with their stencils}
                #     },
                #     'LoopAnnLines' => $loop_annlines
                # } 

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

# returns {$block_id=>$loop_annlines} so simply any first-level loop in a list of annlines
# This works on Do and LoopBlocks
sub extractLoopAnnLines { my ($annlines) = @_;

    my $pass_extract_loops = sub { my ($annline,$state) = @_;
        my ($line,$info) = @_;
        # What we do now is:
        my $current_block_id = $state->{'InBlock'};
        if ($current_block_id==0) {
            if (exists $info->{'Do'}) {
                my $block_id = $info->{'BlockID'};
                $state->{'InBlock'}=$block_id;
                # Put the annline into LoopAnnLines
                push @{$state->{'LoopsAnnLines'}{$block_id}},$annline;
            } 
            elsif (exists $info->{'LoopBlock'}) {
                my $block_id = $info->{'BlockID'};
                # Put the annline into LoopAnnLines
                push @{$state->{'LoopsAnnLines'}{$block_id}},$annline;
            }
        } else {
            # Put the annline into LoopAnnLines
            push @{$state->{'LoopsAnnLines'}{$current_block_id}},$annline;
            if (exists $info->{'EndDo'}) {
                my $block_id = $info->{'BlockID'};
                if ($block_id eq $current_block_id) {
                $state->{'InBlock'}=0;
                }
            }            
        }
        return [$annline, $state];
    };
    
    my $state = { 'InBlock' => 0 , 'LoopsAnnLines' => {} };

    ($annlines,$state) = stateful_pass($annlines,$pass_extract_loops,"pass_extract_loop");

    my $loops_annlines = $state->{'LoopsAnnLines'};

    return $loops_annlines;
} # extractLoopAnnLines


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


#    Function is applied to sub-trees that are loops. It returns either a version of the sub-tree that uses new OpenCLMap nodes or the
#    original sub-tree annotated with reasons why the loop cannot be mapped
# paralleliseLoop_map :: String -> Fortran Anno -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> VarDependencyAnalysis -> VarAccessAnalysis -> SubroutineTable -> (Bool, Fortran Anno, VarAccessAnalysis)
sub paralleliseLoop_map {
    my ($stref,$f, $loop, $loopVarNames, $nonTempVars, $prexistingVars, $dependencies,$accessAnalysis, $block_id) = @_;
    # loopWrites :: [VarName]
    my $loopWrites = extractWrites_query( $loop); # 
    # $loopAnalysis :: AnalysisInfo 
    my $loopAnalysis = analyseLoop_map( $stref, $f, "Cannot map: ", [], $loopWrites, $nonTempVars, $prexistingVars, $accessAnalysis, $dependencies, $loop, $block_id); 
    $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'AnalysisInfo'} = $loopAnalysis;

    my $errors_map = getErrorAnnotations( $loopAnalysis);
    my $reads_map = getReads( $loopAnalysis);
    my $writes_map = getWrites( $loopAnalysis);

    my ($loopCarriedDeps_bool, $evaluated_bool, $loopCarriedDeps) = loopCarriedDependencyCheck( $loop); # TODO

    my $errors_mapQ = $loopCarriedDeps_bool 
        ? $evaluated_bool 
                ? insert ($outputTab . "Cannot map: Loop carried dependency detected:\n",
                    formatLoopCarriedDependencies($loopCarriedDeps), $errors_map)
                : insert ($outputTab . "Cannot map: Loop carried dependency possible (not evaluated):\n",
                    formatLoopCarriedDependencies( $loopCarriedDeps), $errors_map)
        : $errors_map
    ;
    # [VarName, Int,Int,Int]
    my $loopVariables = loopConditions_query( $loop); 

    # my $startVarNames = foldl (sub { my ($accum, $tup) =@_;
    #     my ($e1,$x,$e3,$e4) = @{$tup};
    #     return  [@{$accum} ,@{ extractVarNames( $x)}]
    #     }, [],$loopVariables);
    # my $endVarNames = foldl (sub { my ($accum, $tup) =@_; 
    #     my ($e1,$e2,$x,$e4) = @{$tup};
    #     return [@{$accum} ,@{ extractVarNames( $x)}];
    #     }, [], $loopVariables);
    # my $stepVarNames = foldl (sub { my ($accum, $tup) =@_; 
    #     my ($e1,$e2,$e3,$x) = @{$tup};
    #     return  [@{$accum} ,@{ extractVarNames( $x)}];
    #     }, [], $loopVariables);

    # my $varNames_loopConditions = listSubtract(listRemoveDuplications([@{$startVarNames}, @{$endVarNames}, @{$stepVarNames}]),$loopVarNames);
    # This gets the VarNames out of the tuple [iter_var_name, start, stop, step]
    # We have this info in $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}
    my $containedLoopIteratorVarNames = map { $_->[0] } @{$loopVariables};

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

    my $mapCode = ['TODO! Like OpenCLMap but different'];
    # Call it 'LoopBlock' with a 'Nature' field
    # I might support OpenCLMap as well of course
    # OpenCLMap nullAnno (generateSrcSpan filename (srcSpan loop))     # Node to represent the data needed for an OpenCL map kernel -- WV20170426
    #         readArgs        # List of arguments to kernel that are READ
    #         writtenArgs     # List of arguments to kernel that are WRITTEN
    #         loopVariables    # Loop variables of nested maps
    #         iterLoopVariables # WV20170426
    #         removeLoopConstructs_recursive( $loop); # Body of kernel code

    if (   $errors_mapQ == $nullAnno) {    
        return [$True, appendAnnotation( $mapCode, "$0 : Map at " . errorLocationFormatting (srcSpan $loop) . ""),$accessAnalysis];
    } else {   
        return [$False, appendAnnotationMap( $loop, $errors_mapQ),$accessAnalysis];
    }

} # END of paralleliseLoop_map

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
            my $readOperands=createExprListFromVarAccesses($info->{'VarAccesses'}, $info->{'LineID'},'Read');
            my $condExprAnalysis = [{}, [], $readOperands, []]; # AnalysisInfo tuple from the 'if' condition            
            $state = combineAnalysisInfo( $state, $condExprAnalysis);
        }

        if (exists $info->{'Assignment'}) {
            my $lhsExprInfo = $info->{'Lhs'};
            my $rhsExprInfo = $info->{'Rhs'};
            # lhsExprAnalysis :: AnalysisInfo
            my $lhsExprAnalysis = analyseLoopIteratorUsage( $comment, $loopVars, $loopWrites, $nonTempVars, $accessAnalysis, $lhsExprInfo);
            my $isNonTempAssignment = usesVarName_list( $nonTempVars, $lhsExprInfo->{'VarAccesses'});
            # readOperands :: [Expr]
            my $readOperands=createExprListFromVarAccesses($rhsExprInfo->{'VarAccesses'},$rhsExprInfo->{'LineID'}, 'Read');
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
            $state = fold( \&combineAnalysisInfo,  $state, [
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
            my $childrenAnalysis=analyseChildren($block_id,$accessAnalysis,$analysisInfoBaseCase);
    
            $state = foldl( \&combineAnalysisInfo, $state, $childrenAnalysis);
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

    
        return [[$annline],$state];
    };

    my $state = $analysisInfoBaseCase;
    (my $new_annlines,my $analysisInfo) = stateful_pass($codeSeg,$pass_analyseLoop_map,$state, "pass_analyseLoop_map($f)");

    return $analysisInfo;

} # END of analyseLoop_map

# Given an AST representing a loop, this function will return a tuple containg a bool signifiying whether a loop carried dependency is possible
# and a list of pairs of expressions that cause the dependency. The process is as follows:
#     +    Extract all assignments in the loop in question
#     +    Use the assignments to build up two data structures that pair variables with the array index
#         expressions that are used to WRITE to the variable and to READ from the variable.
#     +    Build a 'loopIterTable' which is a data structure representing all of the possible combinations
#         of loop iterator values for the particular loop.
#     +    For every var that is written to, compare with any reads to that var. Iterate through all of
#         the possible loop iterator values and evaluate the index positions that the read and the write
#         index expressions boil down to. Keep track of all index values used to READ the var and all 
#         index values used to WRITE to the var and make sure that if a WRITE never occurs to a place
#         that has PREVIOUSLY been read (not in this iteration) and a READ never occurs to a place that
#         has been PREVIOUSLY written to.
#     +    Index expressions that cause dependencies are passed back to eventually be returned to the
#         caller.
# loopCarriedDependencyCheck :: Fortran Anno -> (Bool, Bool, [(Expr Anno, Expr Anno)])
sub loopCarriedDependencyCheck { my ($codeSeg) = @_;
            # where
    my $assignments = extractAssignments( $codeSeg);
    my ($reads, $writes) = foldl(\&extractArrayIndexReadWrite_foldl, [{},{}],$assignments);
    my ($loopIterTable_maybe, $loopVars, $loopStepTable) = constructLoopIterTable(['Just',['Empty']], {}, [], $codeSeg);
    my $loopVarsQ = extractLoopIters( $codeSeg); 

    my ($loopIterTable_successfull, $loopIterTable) = isNothing $loopIterTable_maybe
        ? ($False, ['Empty'])
        : ($True, $loopIterTable_maybe);

    my $writtenVars = [sort keys %{$writes}];
    my $offendingExprs = foldl (
        sub { my ($acc,$elt)=@_;
            [@{$acc},@{$elt}]
        }, [] ,
        [
            map {
                loopCarriedDependency_varCheck( $loopStepTable, $loopIterTable, $loopVars, [ $reads, $writes], $_) # TODO
            } @{$writtenVars}
        ]
    );
    my $inDepthFailure = (not $loopIterTable_successfull) || not null($offendingExprs);

    my ($simpleFailure, $simpleOffenders) = simpleLoopCarriedDependencyCheck( $reads,$writes,$loopVarsQ); # TODO

    return $simpleFailure 
        ? $inDepthFailure  
            ? [$True, $loopIterTable_successfull, [@{$offendingExprs}, @{$simpleOffenders}]]
            : [$False, $loopIterTable_successfull, []]
        : [$False, $loopIterTable_successfull, []];
}

# Type used to colate all of the indexes at which variables are accessed in a chosen way (read/write).
# There are two ArrayAccessExpressions passed around during analysis, one that holds all of the indexs
# of a variable that are written to, and one that tracks where the variable is read. These data
# structures are used to determine whether loop carried dependencies exist in a particular loop.
#                                     Variable A         is accessed at indices
# type ArrayAccessExpressions = DMap.Map (VarName Anno)     [[Expr Anno]]
# Our type is {VarName=>[ArrayAccessExpr]} and it is a list because each elt is for a different line
# So we want to obtain a tuple 
# [
#     {VarName =>[[read index expressions]]},
#     {VarName =>[[write index expressions]]}
# ]

# And we have 
# extractArrayIndexReadWrite_foldl :: (ArrayAccessExpressions, ArrayAccessExpressions) -> Fortran Anno -> (ArrayAccessExpressions, ArrayAccessExpressions)

sub extractArrayIndexReadWrite_foldl { my ($reads_writes,$annline) = @_;
    my ($reads,$writes)=@{$reads_writes};
        my ($line,$info) = @{$annline};
        my $line_id = $info->{'LineID'};
        for my $var_name (keys %{$info->{'Lhs'}{'VarAccesses'}{'Arrays'}}) {
            my $rec = $info->{'Lhs'}{'VarAccesses'}{'Arrays'}{$var_name}{'Write'};
            my $expr = [
                $var_name,
                $line_id,
                $rec
            ];
            if (exists $writes->{$var_name}) {
                push @{$writes->{$var_name}}, $expr;
            } else {
                $writes->{$var_name}=[$expr];
            }
        } 
        for my $var_name (keys %{$info->{'Rhs'}{'VarAccesses'}{'Arrays'}}) {
            my $rec = $info->{'Rhs'}{'VarAccesses'}{'Arrays'}{$var_name}{'Read'};
            my $expr = [
                $var_name,
                $line_id,
                $rec
            ];
            if (exists $reads->{$var_name}) {
                push @{$reads->{$var_name}}, $expr;
            } else {
                $reads->{$var_name}=[$expr];
            }
        }         
    return [$reads,$writes];
}

# simpleLoopCarriedDependencyCheck :: ArrayAccessExpressions -> ArrayAccessExpressions -> [String] -> (Bool, [(Expr Anno, Expr Anno)])
sub simpleLoopCarriedDependencyCheck {my ($reads, $writes, $loopVars) = @_;
    foldl( sub { my ($acc,$elt)=@_;
        simpleLoopCarriedDependencyCheckQ( $reads,$writes,$loopVars,$acc,$elt);
    }, [$False, []], [keys %{$writes}]);
}

# simpleLoopCarriedDependencyCheckQ :: ArrayAccessExpressions -> ArrayAccessExpressions -> [String] -> (Bool, [(Expr Anno, Expr Anno)]) -> VarName Anno -> (Bool, [(Expr Anno, Expr Anno)])
# type ArrayAccessExpressions = DMap.Map (VarName Anno)     [[Expr Anno]]
sub simpleLoopCarriedDependencyCheckQ {my ($reads, $writes, $loopVars,$prevBool_prevPairs,$var) = @_; 
    my ($prevBool,$prevPairs) = @{$prevBool_prevPairs};
            # where 
    # [[Expr]]
    my $writtenIndices = listRemoveDuplications(
        map {
            map {applyGeneratedSrcSpans($_) } @{$_} 
        } @{findWithDefault( [], $var,$writes)}
    );
    my $readIndices = listRemoveDuplications(
        map {
            map {applyGeneratedSrcSpans($_) } @{$_}
        } @{findWithDefault( [], $var, $reads)}
    );

    my ($check_bool, $offendingReads, $offendingWrites) = @{foldl(
        sub { my ($acc,$elt) = @_;
        simpleLoopCarriedDependencyCheckQQ($loopVars,$readIndices,$acc,$elt);
        },
        [$prevBool, [],[]], 
        $writtenIndices
    )};
    my $offendingPairs = map {                     
        my ($read, $write) = @{$_};
        [generateArrayVar( $var, $read), generateArrayVar( $var,$write)] ;
    } @{zip( $offendingReads,$offendingWrites )};

    return [$check_bool || $prevBool, [@{$prevPairs}, @{$offendingPairs}]];
}

# simpleLoopCarriedDependencyCheckQQ :: [String] -> [[Expr Anno]] -> (Bool, ([[Expr Anno]], [[Expr Anno]])) -> [Expr Anno] -> (Bool, ([[Expr Anno]], [[Expr Anno]]))
sub simpleLoopCarriedDependencyCheckQQ {my ($loopVars, $readIndiceList, $prevBool_prevPairs, $writtenIndexSet) = @_;
# my ($prevBool, $prevPairs) = @{$prevBool_prevPairs};
    foldl(
        sub { my ($accumBool,$accumReadsWrites, $readIndexSet) = @_; # CHECK THE ARGS 
            my ($accumReads, $accumWrites) = @{$accumReadsWrites};
            if (accessDependencyCheckWV( $writtenIndexSet,$readIndexSet,$loopVars)) {
                return [$accumBool, [$accumReads, $accumWrites]];
            } else { 
                return [$True, [@{$accumReads},$readIndexSet],[@{$accumWrites},$writtenIndexSet]];
            }
        },                                                                            
        $prevBool_prevPairs, #[$prevBool, $prevPairs],
        $readIndiceList);
}
# So what I need is:
#     for every var in loopVars
#         for every expr in readIndexMap
#             given an expression in readIndexMap, does it contain a loop var? if so, get the index and get the entry from writtenIndexSet. If they are not identical there is a conflict
#                 loopvar `elem` (map (\(Varname _ v) -> v) index_vars

#  returns True if there is a conflict
# accessDependencyCheckWV :: [Expr Anno] -> [Expr Anno] -> [String] -> Bool

# TODO
sub accessDependencyCheckWV {my  ($writtenIndexSet, $readIndexSet, $loopVars ) = @_;
# let
    my $tlength = 
    length($readIndexSet) == length($writtenIndexSet)
    ? length($readIndexSet) 
    : error( "LEN:".length($readIndexSet)."<>".length($writtenIndexSet));

    my $readPositions = [0 .. $tlength-1];
    my $read_index_expr_vars_per_index =  map {extractVarNames($_)} @{$readIndexSet};  # which gives [[VarName p]]
    my $read_index_expr_vars_per_index_pos = zip( $read_index_expr_vars_per_index,$readPositions);
    my $maybeConflictsPerPos =map {
        my $index_vars_pos = $_;
        # let 
        my ($index_vars,$pos) = @{$index_vars_pos};
        my $maybeConflicts = map {
        
        my $loopvar = $_;
        if ( elem($loopvar, $index_vars) ) {                
                # OK, this loop var occurs in index pos on the LHS
            if ($pos > $tlength-1) { 
                error($pos."<>".$tlength);
            } else {
                if ($readIndexSet->[$pos] == $writtenIndexSet->[$pos]) {$True} else {$False}
            }
         } else {
                # the loopvar is not used, return True (no conflict)
                    $True
         }
     } @{$loopVars};
        # in  
            foldAnd( $True,$maybeConflicts) # if all of them are true
     } @{$read_index_expr_vars_per_index_pos};
#   in
      foldAnd( $True,$maybeConflictsPerPos);

}
# constructLoopIterTable :: Maybe TupleTable -> LoopStepTable -> [VarName Anno] -> Fortran Anno -> (Maybe TupleTable, [VarName Anno], LoopStepTable)

# If we ever want to support the OpenCLMap and OpenCLReduce nodes:
# constructLoopIterTable (Just oldTable) loopStepTable loopVars (OpenCLMap _ _ _ _ loopBoundsList iterLoopBoundsList fortran) = childrenTable -- WV20170426
#             where
#                 (var, e1, e2, e3) = head loopBoundsList
#                 newLoopIterTable = extendLoopIterTable oldTable DMap.empty loopVars e1 e2 e3
#                 childrenTable = constructLoopIterTable newLoopIterTable loopStepTable (loopVars ++ [var]) fortran

# constructLoopIterTable (Just oldTable) loopStepTable loopVars (OpenCLReduce _ _ _ _ loopBoundsList iterLoopBoundsList _ fortran) = childrenTable -- WV20170426
#             where
#                 (var, e1, e2, e3) = head loopBoundsList
#                 newLoopIterTable = extendLoopIterTable oldTable DMap.empty loopVars e1 e2 e3
#                 childrenTable = constructLoopIterTable newLoopIterTable loopStepTable (loopVars ++ [var]) fortran

# The problem is that a loop can contain other loops so I will have to write an extractLoopAnnLines

sub constructLoopIterTable { my ($maybe_tupletable,$loopStepTable,$loopVars,$annlines) = @_;
    my $loopIterTable={};
    if (isNothing $maybe_tupletable) {
        return [$maybe_tupletable, $loopVars, $loopStepTable];
    } else {
        my $oldTable = fromJust $maybe_tupletable;
    
        my $loops_annlines = extractLoopAnnLines($annlines);
        for my $block_id (sort keys %{$loops_annlines}) {
            my $loop_annlines = $loops_annlines->{$block_id};
            my $first_annline = shift @{ $loop_annlines}; # so the $loop_annlines does not start with a Do or LoopBlock, and we'll get the next level if there is one
            my ($line, $info) = @{$first_annline};            
            if (exists $info->{'Do'} or exists $info->{'LoopBlock'}) {
                if (exists $info->{'LoopBlock'}) { # This block has been parallelised and the annlines are in AnnLines
                    my $loop_annlines = $info->{'LoopBlock'}{'AnnLines'};
                    # We can again assume that the first line is a Do and thus we can get the loop conditions
                    $first_annline = shift @{ $loop_annlines}; # so the $loop_annlines does not start with a Do or LoopBlock, and we'll get the next level if there is one
                }
                my ($var,$e1,$e2,$e3)=@{getLoopConditions($first_annline)};            
                my $newLoopIterTable = extendLoopIterTable(  $oldTable, {}, $loopVars,$e1,$e2,$e3);                    
                $loopStepTable->{$var} = $e3;
                my $fortran = $loop_annlines;
                my $childrenTable = constructLoopIterTable($newLoopIterTable, $loopStepTable, append($loopVars,$var), $fortran);
                return $childrenTable
            }
            elsif (null($loops_annlines) ) {
                return [$maybe_tupletable,$loopVars,$loopStepTable];
            }
            else {
                croak "A loop should start with Do or be contained in a LoopBlock: ".Dumper($loop_annlines);
            }
        }
    }    
}

# extendLoopIterTable :: TupleTable -> ValueTable -> [VarName Anno] -> Expr Anno -> Expr Anno -> Expr Anno -> Maybe(TupleTable)
sub extendLoopIterTable {my ($oldTable, $valueTable, $loopVars, $startExpr, $endExpr, $stepExpr) = @_;
    if (not null($loopVars)) {
        my $allowedValues = case( $oldTable, 
            [
                [\&isLoopIterRecord, sub { my ($t) = @_; keys %{$t->[1]}}],
                [\&otherwise ,sub {[]}]
            ]
        );
    foldl( sub { my ($acc,$elt) = @_;
        extendLoopIterTableWithValues_foldl($valueTable, $loopVars, $startExpr, $endExpr, $stepExpr, $acc, $elt);
        },
        just($oldTable)
        ,$allowedValues);                                
    } else {
        my $range_maybe = evaluateRange( $valueTable, $startExpr, $endExpr, $stepExpr);
        case( $range_maybe, [
          [  \&isNothing, nothing],
          [\&isJust, sub {
              my $range = fromJust $range_maybe;
              just(
                addRangeToIterTable( $oldTable,$range)
              );
          }] 
        ]);
    }                                
}
# extendLoopIterTableWithValues_foldl :: ValueTable -> [VarName Anno] -> Expr Anno -> Expr Anno -> Expr Anno -> Maybe(TupleTable) -> Int -> Maybe(TupleTable)
extendLoopIterTableWithValues_foldl { my ( $valueTable, $loopVars, $startExpr, $endExpr, $stepExpr, $maybe_tupletable, $chosenValue ) = @_;
    if (isNothing $maybe_tupletable) {
        nothing;
    } else {
        my $oldRecord = fromJust(fromLoopIterRecord $maybe_tupletable);
        my $oldSubTable = findWithDefault( empty, $chosenValue, $oldRecord);
        my $newLoopVars = tail( $loopVars);
        my $newSubTable = extendLoopIterTable( 
             $oldSubTable 
            ,addToValueTable(head($loopVars), $chosenValue,$valueTable) 
            ,$newLoopVars 
            ,$startExpr 
            ,$endExpr 
            ,$stepExpr);
        
        if (null $loopVars) {
            error( "extendLoopIterTableWithValues_foldl: loopVars is empty" );
        } else {
            case( $newSubTable,[
                [Just newT , sub { 
                    my $newT = fromJust $newSubTable;
                    just(loopIterRecord(insert($chosenValue,$newT,$oldRecord)));
                }],
                [\&isNothing, nothing]
            ])
        }
}

# addRangeToIterTable :: TupleTable -> [Float] -> TupleTable
sub addRangeToIterTable { my  ($oldTable,$range) = @_;
    my $oldRecord = case( $oldTable, [ 
        [\&isEmpty, {}],
        [\&isLoopIterRecord , \&fromLoopIterRecord]
    ]);
    loopIterRecord(
        foldl(
            sub { my ($accum,$key) =@_;
                insert( round($key), empty, $accum);
            }, $oldRecord,$range)
    );            
}

sub loopCarriedDependency_varCheck { my (
    $loopStepTable, # LoopStepTable -> 
    $loopIterTable, # TupleTable -> 
    $loopVars, # [VarName Anno] -> 
    $reads_writes, # (ArrayAccessExpressions, ArrayAccessExpressions) -> 
    $var # VarName Anno -> 
    ) = @_; # [(Expr Anno, Expr Anno)]
    my ($reads, $writes) = @{$reads_writes};
    # read and writes are tables VarName=>[[VarName, LineID, {Exprs=>{},Accesses=>{},Iterators=>[]}]]
    # So read/writtenAccesses is a list of such tuples i.e. [ArrayAccessExpr]
    my $writtenAccesses = findWithDefault( [],$var,$writes); # :: [[VarName, LineID, {Exprs=>{},Accesses=>{},Iterators=>[]}]]
    my $readsAccesses = findWithDefault( [], $var, $reads);

    my $offendingIndexPairs = foldl(
        sub {my ($acc,$elt)=@_;
        loopCarriedDependency_writtenExprCheck($loopStepTable, $loopIterTable, $loopVars, $readsAccesses,$acc,$elt);
         }, [] , $writtenAccesses
        );
    my $offendingExprs = map { 
        my ($read, $written) =@{$_};
        [generateArrayVar($var,$read), generateArrayVar($var,$written)]
    } @{$offendingIndexPairs};
    return $offendingExprs;
}

# loopCarriedDependency_writtenExprCheck ::     
sub loopCarriedDependency_writtenExprCheck { my (
    $loopStepTable, # LoopStepTable -> 
    $loopIterTable, # TupleTable ->
    $loopVars, # [VarName Anno] -> 
    $readExprs, # :: [ArrayAccessExpr@[VarName, LineID, {Exprs=>{},Accesses=>{},Iterators=>[]}]] -> 
    $oldOffendingExprs, #  [ ([Expr Anno], [Expr Anno]) ] ->
    $writtenExpr # :: [ArrayAccessExpr@VarName, LineID, {Exprs=>{},Accesses=>{},Iterators=>[]}] -> 
    ) = @_; # [([Expr Anno], [Expr Anno])]
    my $offendingReads = foldl ( sub {
        my ($acc,$elt)=@_;
        loopCarriedDependency_readExprCheck( $loopStepTable, $loopIterTable, $loopVars, $writtenExpr,$acc,$elt);
    }
    , [] ,$readExprs);
    my $dependencyPairs = map {[$_, $writtenExpr]} @{$offendingReads};
    concat($oldOffendingExprs,$dependencyPairs);
}

# The linearity condition is checked in ArrayAccessPatterns so it is not needed here
sub loopCarriedDependency_readExprCheck { my (
    $loopStepTable, # LoopStepTable -> 
    $loopIterTable, # TupleTable ->
    $loopVars, # [VarName Anno] ->
    $writtenIndexExprs, # [ArrayAccessExpr@VarName, LineID, {Exprs=>{},Accesses=>{},Iterators=>[]}] ->
    $oldOffendingExprs, # [[Expr Anno]] ->
    $readIndexExprs # [ArrayAccessExpr@VarName, LineID, {Exprs=>{},Accesses=>{},Iterators=>[]}] ->
    )=@_; # [[Expr Anno]]


    my ($linear_noDep, $linear_depFound, $d1_, $d2_) = loopCarriedDependency_linearCheckEvaluate( [$loopIterTable], $loopVars, $readIndexExprs, $writtenIndexExprs, [empty, empty], [{}]); # TODO

    my $loopIterTable_optimised = optimiseLoopIterTable( $loopIterTable, {}, $loopVars, $readIndexExprs, $writtenIndexExprs);
    my ($exhaustive_offendBool, $d3_, $d4_) = @{loopCarriedDependency_exhaustiveEvaluate( $loopIterTable_optimised, $loopVars, $readIndexExprs, $writtenIndexExprs, [$False, empty, empty], {})}; # TODO

    return $linear_noDep 
        ? $oldOffendingExprs
    :  $linear_depFound 
        ? append($oldOffendingExprs,$readIndexExprs)
        : $exhaustive_offendBool 
            ? append($oldOffendingExprs ,$readIndexExprs)
            : $oldOffendingExprs;
}

# optimiseLoopIterTable :: TupleTable -> ValueTable -> [VarName Anno] -> [ArrayAccessExpr] -> [ArrayAccessExpr] -> TupleTable
sub optimiseLoopIterTable {my  ($tuple_table, $valueTable, $loopVars, $readIndexExprs, $writtenIndexExprs) = @_;
    if (isEmpty $tuple_table) {
        return empty;
    } else {
        my $iterTable = fromLoopIterRecord $tuple_table;
        my $chosenVar = head( $loopVars);

        my $allowedValues = [sort keys %{$iterTable}];
        my $accessIterTable = sub { my ($x) =@_;
            findWithDefault( empty,$x,$iterTable);
        };
        # So these are arrays of hashes with as keys strings representing array accesses
        #  
        my $read_chosenVarMask = maskOnVarNameUsage( $chosenVar ,$readIndexExprs);
        my $written_chosenVarMask = maskOnVarNameUsage( $chosenVar, $writtenIndexExprs);

        my $varAffectsOutcome = cmpArrayAccessExprs($read_chosenVarMask, $written_chosenVarMask);

        my $iterTable_recurseList = map {
                my $item = $_;
                optimiseLoopIterTable($accessIterTable->($item),$valueTable, tail($loopVars),$readIndexExprs,$writtenIndexExprs);
            } @{$allowedValues};

        my $iterTable_recurse = foldl( sub {
            my ($accum, $value_newTable) = @_;
            my ($value,$newTable)=@{$value_newTable};
             insert($value, $newTable, $accum);
         },$iterTable, zip($allowedValues,$iterTable_recurseList)
        );

        my $newLoopIterTable = $varAffectsOutcome 
            ? loopIterRecord($iterTable_recurse)
            : collapseIterTable(loopIterRecord($iterTable_recurse));            
        if (null $loopVars)  { 
            error( "optimiseLoopIterTable");
        } else {
            $newLoopIterTable;
        }
    }
}

# This seems to check if the var in ArrayAccessExpr matches chosenVar. If so, it wipes LineID; otherwise, it wipes the entire record.
# maskOnVarNameUsage :: VarName Anno -> [ArrayAccessExpr] -> {array expression strings}
    
sub maskOnVarNameUsage { my ($chosenVar,$array_access_exprs) = @_;
my $array_expr_strs={};
map {
    my ($array_access_expr)=$_;
    if (varNameUsed($chosenVar, $array_access_expr) ) {
        my ($var, $line_id,$rec) = @{$array_access_expr};
        for my $array_expr_str (keys %{$rec->{'Exprs'}}) {        
            $array_expr_strs->{$array_expr_str}=1;
        }
    } 
} @{$array_access_exprs};
return $array_expr_strs;
}

sub cmpArrayAccessExprs { my ($exprs1,$exprs2) = @_;

if (scalar keys %{$exprs1} !=scalar keys %{$exprs2} ) {
    return 0;
}
# at least they are the same size.
for my $expr1 (keys %{$exprs1}) {
    if (not exists $exprs2->{$expr1}) {
        return 0;
    }
}
return 1;
}
# varNameUsed :: VarName -> ArrayAccessExpr -> Bool
# my $array_access_expr = [
#     $var_name, # VarName
#     $line_id, # LineID
#     $rec # {Exprs=>{}, Accesses=>{}, Iterators=>[]}
# ];
sub varNameUsed {my ($chosenVar,$array_access_expr) = @_;
    foldl( 
        sub {
            my ($accum,$item)=@_;$
            $accum || $item eq $chosenVar;
        },$False, getItersFromVarAccessExpr($array_access_expr)
     );
}

# collapseIterTable :: TupleTable -> TupleTable
collapseIterTable {my ($tuple_table) = @_;
my $iterTable = fromLoopIterRecord $tuple_table;
my $allowedValues = keys %{$iterTable};
my $subTables = map {
    my $x =$_;
    findWithDefault( empty,$x,$iterTable);
 } @{$allowedValues};

    foldl ( sub {
        my ($accum,$key_newTable) =@_;
        my ($key,$newTable) = @{$key_newTable};
        insertIfNotRepresented( $key,$newTable,$accum);
         },
        empty, zip($allowedValues,$subTables)
        );
}
# insertIfNotRepresented :: Int -> TupleTable -> TupleTable -> TupleTable
insertIfNotRepresented {my ($key,$newItem, $tuple_table)=  @_;
if (isEmpty $tuple_table) {
LoopIterRecord (DMap.insert key newItem DMap.empty)
} elsif (
isLoopIterRecord $tuple_table
) {
    my $table = fromLoopIterRecord $tuple_table;
    my $representedItems = map { 
        my $x=$_;
        findWithDefault(empty,$x,$table);
    } sort keys %{$table};
    if (not elem( $newItem,$representedItems)) {
        loopIterRecord(insert($key,$newItem,$table));
    } else {
        loopIterRecord( $table);
    }
}
}

# The evalation of the possible index values is performed here and the loop dependency analysis checks performed.
# ARGUMENTS (in order)
#     TupleTable ---------------------Loop iterator table that is traversed as the recursion goes deeper. A value for the iterator at this 'level' of the table is selected
#                                     and inserted into the 'value table' so that when the indices in question are evaluated, the value for that iterator variable is available.
#      [VarName Anno] -----------------Loop variables list used to determine which loop iterator variable is the current one at this level of recursion. This allows for the correct
#                                     variable name to be assigned a value in the value table from the current level of the loop iterator table.
#      [Expr Anno] --------------------The indices that the current variable is READ at.
#      [Expr Anno] --------------------The indices that the current variable is WRITTEN at.
#      (Bool, TupleTable, TupleTable) -Since this is a fold, this is the accumulator. Bool is whether a dependency exists, the TupleTables are all of the resolved/evaluated index
#                                     positions for all of the READS and WRITES (respecitvely) that have been calculated so far.
#      ValueTable ---------------------A set of assigned values for the loop iterator variables that allows for indices that use loop iterators to be evaluated.
#      (Bool, TupleTable, TupleTable) -Return type. Bool is whether a dependency exists, the TupleTables are all of the resolved/evaluated index
#                                     positions for all of the READS and WRITES (respecitvely) that have been calculated so far.
loopCarriedDependency_exhaustiveEvaluate :: TupleTable -> [VarName Anno] -> [Expr Anno] -> [Expr Anno] -> (Bool, TupleTable, TupleTable) -> ValueTable -> (Bool, TupleTable, TupleTable)
loopCarriedDependency_exhaustiveEvaluate Empty loopVars readIndexExprs writtenIndexExprs (prevCheck, prevReads, prevWrites) valueTable =
            (prevCheck || depExistsBool, newReads, newWrites)
            where
                identcalExprs = map (applyGeneratedSrcSpans) readIndexExprs == map (applyGeneratedSrcSpans) writtenIndexExprs
                vt_elems = length (DMap.keys valueTable)

                reads_eval = map (evaluateExpr valueTable) readIndexExprs
                writes_eval = map (evaluateExpr valueTable) writtenIndexExprs

                (readsEvaluated, reads_fromMaybe) = foldl (convertFromMaybe_foldl) (True, []) reads_eval
                (writesEvaluated, writes_fromMaybe) = foldl (convertFromMaybe_foldl) (True, []) writes_eval

                reads_fromMaybe_int = (map (round) reads_fromMaybe)
                writes_fromMaybe_int = (map (round) writes_fromMaybe)

                readPreviouslyWritten = case lookupTupleTable reads_fromMaybe_int prevWrites of
                    Just a -> True
                    Nothing -> False
                writePreviouslyRead = case lookupTupleTable writes_fromMaybe_int prevReads of
                    Just a -> True
                    Nothing -> False

                newReads = insertIntoTupleTable reads_fromMaybe_int prevReads
                newWrites = insertIntoTupleTable writes_fromMaybe_int prevWrites
                depExistsBool = (not identcalExprs) && (readPreviouslyWritten || writePreviouslyRead || (not readsEvaluated) || (not writesEvaluated))

loopCarriedDependency_exhaustiveEvaluate (LoopIterRecord iterTable) loopVars readIndexExprs writtenIndexExprs previousAnalysis valueTable = if loopVars == []  then error "loopCarriedDependency_exhaustiveEvaluate" else analysis
            where
                allowedValues = DMap.keys iterTable
                valueTableIterations = map (\x -> addToValueTable (chosenVar) (fromIntegral x :: Float) valueTable) allowedValues
                accessIterTable = (\x -> DMap.findWithDefault Empty x iterTable)

                chosenVar = head loopVars
                newLoopVars = tail loopVars

                exprs1_chosenVarMask = maskOnVarNameUsage chosenVar readIndexExprs
                exprs2_chosenVarMask = maskOnVarNameUsage chosenVar writtenIndexExprs

                analysis = foldl (\accum (table, value) -> loopCarriedDependency_exhaustiveEvaluate (accessIterTable value) newLoopVars readIndexExprs writtenIndexExprs accum table) previousAnalysis (zip valueTableIterations allowedValues)

# This function performs a similar operation to loopCarriedDependency_exhaustiveEvaluate, except it is attempting to prove that loop carried dependencies DO NOT exist. This
# process only works for array index expressions that are linear functions (only made up using + or -) using only loop iterators and constants but allows for the analysis
# to be performed in constant time with respect to the number of loop iterations.
# The optimisation works on the idea that linear functions follow a very simple pattern. By tracking the indices that are written to and the indices that are read, the function
# continues analysing until it reaches a situation where there is a crossover in the domains of the reads and writes. If there has been no detected dependency by the time the
# domains have crossed over, there will never be any dependencies because the functions are linear. The crossover is characterised by the write index tuple with the largest values
# being larger than the read index tuple with the largest values and vice versa (largestRead > smallestWrite AND largestWrite > smallestRead)
# loopCarriedDependency_linearCheckEvaluate :: [TupleTable] -> [VarName Anno] -> [Expr Anno] -> [Expr Anno] -> (TupleTable, TupleTable) -> [ValueTable] -> (Bool, Bool, TupleTable, TupleTable)
sub loopCarriedDependency_linearCheckEvaluate { my ($tt_tts,$loopVars,$readIndexExprs,$writtenIndexExprs,$prevReads_prevWrites,$vt_valueTables) =@_;
    my ($prevReads, $prevWrites) = @{$prevReads_prevWrites};

    if (null $tt_tts)  {
  
        [$True, $False, $prevReads, $prevWrites];

    } else {
        my $tt = head $tt_tts;
        my $tts = tail $tt_tts;
        my $vt = head $vt_valueTables;
        my $valueTables = tail $vt_valueTables;
        if (isEmpty $tt) {
            # TODO!!!
            my $identcalExprs = map (applyGeneratedSrcSpans) readIndexExprs == map (applyGeneratedSrcSpans) writtenIndexExprs
            my $vt_elems = length([keys %{vt}]);

            my $reads_eval = mapf(sub {evaluateExpr($vt,@_)},$readIndexExprs);
            my $writes_eval = mapf(sub {evaluateExpr($vt,@_)},$writtenIndexExprs);

            my ($readsEvaluated, $reads_fromMaybe) = @{foldl (\&convertFromMaybe_foldl, [$True, []] ,$reads_eval)};
            my ($writesEvaluated, $writes_fromMaybe) = @{foldl (\&convertFromMaybe_foldl, [$True, []] ,$writes_eval)};

            my $reads_fromMaybe_int = map(\&round,$reads_fromMaybe);
            my $writes_fromMaybe_int = map(\&round,$writes_fromMaybe);

            my $readPreviouslyWritten = case( lookupTupleTable( $reads_fromMaybe_int,$prevWrites), [
                [\&isJust, $True],
                [\&isNothing,$False]]);

            my $writePreviouslyRead = case( lookupTupleTable( $writes_fromMaybe_int,$prevReads), [
                [\&isJust, $True],
                [\&isNothing,$False]]);

            my $newReads = insertIntoTupleTable $reads_fromMaybe_int,$prevReads;
            my $newWrites = insertIntoTupleTable $writes_fromMaybe_int,$prevWrites;
            my $depExistsBool = (not $identcalExprs) && ($readPreviouslyWritten || $writePreviouslyRead || (not $readsEvaluated) || (not $writesEvaluated));

            my $mostRead = getMostTuple $newReads;
            my $mostWritten = getMostTuple $newWrites;
            my $leastRead = getLeastTuple $newReads;
            my $leastWritten = getLeastTuple $newWrites;

            my $crossover = tupleTableElementGreaterThan( $mostRead,$leastWritten) && tupleTableElementGreaterThan($mostWritten,$leastRead);

            my $noDepBool = $crossover && (not $depExistsBool);

            my $analysis_nextIter = loopCarriedDependency_linearCheckEvaluate($tts, $loopVars, $readIndexExprs, $writtenIndexExprs, [$newReads,$newWrites], $valueTables);

            return $noDepBool || $depExistsBool ? [$noDepBool,$depExistsBool,$newReads,$newWrites]
            : $analysis_nextIter;
        } elsif (isLoopIterRecord $tt) {
            my $iterTable = fromLoopIterRecord $tt;
    # loopCarriedDependency_linearCheckEvaluate ((LoopIterRecord iterTable):tts) loopVars readIndexExprs writtenIndexExprs previousAnalysis (vt:valueTables)     
                # where
            my $allowedValues = [keys %{$iterTable}];
            # TODO
            my $valueTableIterations = map (\x -> addToValueTable (chosenVar) (fromIntegral x :: Float) vt) allowedValues
            my $iterTableIterations = map (accessIterTable) $allowedValues;
            my $accessIterTable = sub { (\x -> findWithDefault( empty $x $iterTable) };

            my $chosenVar = head $loopVars;
            my $newLoopVars = tail $loopVars;

            my ($analysis_noDepBool,$analysis_depBool,$analysis_reads,$analysis_writes) = @{loopCarriedDependency_linearCheckEvaluate($iterTableIterations, $newLoopVars, $readIndexExprs, $writtenIndexExprs, $previousAnalysis, $valueTableIterations)} ;# previousAnalysis (zip valueTableIterations allowedValues)
            my $analysis_nextIter = loopCarriedDependency_linearCheckEvaluate($tts, $loopVars, $readIndexExprs, $writtenIndexExprs, [$analysis_reads, $analysis_writes], $valueTables);
            # TODO
            |    (analysis_noDepBool || analysis_depBool) = (analysis_noDepBool, analysis_depBool, analysis_reads, analysis_writes)
            |    otherwise = analysis_nextIter
        } 
    }
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


sub analyseChildren { my ($block_id,$accessAnalysis,$childrenAnalysis) = @_;
    if (exists $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'Contains'}) {
        for my $child_block_id  (sort keys %{$accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'Contains'}} ) {        
                $childrenAnalysis = analyseChildren($child_block_id,$accessAnalysis,$childrenAnalysis)
        }    
    } 
    my $childAnalysis = $accessAnalysis->{'LoopNests'}{'Set'}{$block_id}{'AnalysisInfo'};
    $childrenAnalysis = combineAnalysisInfo($childrenAnalysis,$childAnalysis);                   

    return $childrenAnalysis
} # END of analyseChildren

#    Applied to an expression, returns an AnalysisInfo loaded with an error if it does not use all of the loop iterators in some way. As in,
#    in a nested loop over 'i' and 'j', expression 'x(i) + 12' doesn't use the iterator 'j' and so the AnalysisInfo will report that. If
#    this error occurs when looking for a map then a map cannot be performed. if it is found while looking for a reduction, it is a sign that
#    this expression represents a reduction variable.
# analyseLoopIteratorUsage :: String -> [VarName Anno] -> [VarName Anno] -> [VarName Anno] -> VarAccessAnalysis -> Expr Anno -> AnalysisInfo
sub analyseLoopIteratorUsage {my ($comment, $loopVars, $loopWrites, $nonTempVars, $accessAnalysis, $lhs_expr_info) = @_;
# where
# operands :: [Expr] which is [$varname,{...}] which we should get from %{$info->{'Lhs'}{'VarAccesses'}};
    my $writtenOperands = createExprListFromVarAccesses($lhs_expr_info->{'VarAccesses'},$lhs_expr_info->{'LineID'},'Write');
    # my $operands = case fnCall of
    #         True ->    extractContainedVars expr
    #         False -> extractOperands expr
    # writtenOperands = filter (usesVarName_list loopWrites) operands
    # fnCall = isFunctionCall f95IntrinsicFunctions accessAnalysis expr
    # nonTempWrittenOperands :: [Expr]
    my $nonTempWrittenOperands = filter( sub { (my $var_name) = @_;
        usesVarName_list($nonTempVars, $var_name);
     },$writtenOperands); 
    my $unusedIterMap = foldl( sub { my ($accumAnno,$loopVar) = @_;    
        analyseLoopIteratorUsage_foldl( $nonTempWrittenOperands,$comment,$accumAnno,$loopVar);
    }, {}, $loopVars);
    return [$unusedIterMap, [],[],[]];
} # END of analyseLoopIteratorUsage

# analyseLoopIteratorUsage_foldl :: [Expr Anno] -> String -> Anno -> VarName Anno -> Anno
sub analyseLoopIteratorUsage_foldl { my ($nonTempWrittenOperands, $comment, $accumAnno, $loopVar) = @_;
    # where
    # This needs changing because our Expr equivalent is [$var_name,{...}]

=pod info
So we take nonTempWrittenOperands, which are array accesses or scalars
For every  nonTempWrittenOperand we call extractContainedOperands
"contained operands" are extracted first using extractContainedVars
and they are the index expressions
Then for each of these we use extractOperands to get the actual array expressions

So in other words, 
After the we run extractContainedOperands what we get is a list of variables used in the array accesses. 
Then what we do is check for those that are not the loop iterator of the current loop
- If we want the containted vars from an array, we have that information in Exprs/Accesses/Iterators, depending on what we need
What we need is Iterators, we have to do

for my $var_expr (@{$nonTempWrittenOperands}) {
    my $iter_is_loopVar=0;
    for my $iter_idx_str (@{ $var_expr->[2]{'Iterators'} }) {
        my ($iter, $idx) = split(/:/,$iter_idx_str);
        if ($iter eq $loopVar) {
            $iter_is_loopVar=1;
        }
    }
    if ($iter_is_loopVar==0) {
        push @{$offendingExprs}, $var_expr;
    }
}
And then for every contained operand, which is an Expr, we apparently 

offendingExprs = 
    filter (\item -> not (elem loopVar (foldl (\accum item -> accum ++ extractVarNames item) [] (extractContainedOperands item) ))) 
        nonTempWrittenOperands

extractContainedOperands :: (Typeable p, Data p) => Expr p -> [Expr p]
extractContainedOperands expr =  foldl (\accum item -> accum ++ (extractOperands item)) [] containedVars
                where
                    containedVars = extractContainedVars expr

-- Used to extract array index expressions and function call arguments. 
extractContainedVars :: (Typeable p, Data p) => Expr p -> [Expr p]
extractContainedVars (Var _ _ lst) = foldl (\accumExprs (itemVar, itemExprs) -> accumExprs ++ itemExprs) [] lst
extractContainedVars _ = []
=cut

    # my $offendingExprs = filter(
    #         sub  { my ($item) = @_;
    #             return not elem( $loopVar, 
    #                 foldl( 
    #                     sub { my ($accum, $item) =@_;
    #                         return [@{$accum},@{ extractVarNames($item)}];
    #                     }, [], extractContainedOperands($item) 
    #                 )
    #             );                 
    #         }, $nonTempWrittenOperands);

    my $offendingExprs = [];
    for my $var_expr (@{$nonTempWrittenOperands}) {
        my $iter_is_loopVar=0;
        for my $iter_idx_str (@{ $var_expr->[2]{'Iterators'} }) {
            my ($iter, $idx) = split(/:/,$iter_idx_str);
            if ($iter eq $loopVar) {
                $iter_is_loopVar=1;
            }
        }
        if ($iter_is_loopVar==0) {
            push @{$offendingExprs}, $var_expr;
        }
    }

    my $offendingExprsStrs = map { $_->[1] . $outputTab . join(',', sort keys %{$_->[2]{'Exprs'}}) } @{$offendingExprs};

    my $loopVarStr = $loopVar;
    my $resultantMap = {};
    if (scalar @{$offendingExprs} == 0)  {
        $resultantMap = $accumAnno
    } else {
        $resultantMap = insert($outputTab . $comment . "Non temporary, write variables accessed without use of loop iterator \"" . $loopVarStr . "\":\n",$offendingExprsStrs, $accumAnno);
    }
    return $resultantMap;            
} # END of analyseLoopIteratorUsage_foldl

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
# extractAssignments :: [AnnLine] -> [AnnLine]
sub extractAssignments { my ($codeSeg) = @_;

    my @assignments = grep { 
        my ($line, $info) = @{$_};
        exists $info->{'Assignment'} 
    } @{$codeSeg};

    return \@assignments;
}
# [(VarName p, Expr p, Expr p, Expr p)]
sub loopConditions_query { my ( $loop)=@_;
    my @loopConditions=();
    for my $annline (@{$loop}) {
        my ($line, $info) = @{$annline};
        if (exists $info->{'Do'}) {
            my $iter = $info->{'Do'}{'Iterator'};
            my ($range_start, $range_stop, $range_step) = @{$info->{'Do'}{'Range'}{'Expressions'}};

            push @loopConditions, [$iter,$range_start, $range_stop, $range_step];
        }
    }
    return \@loopConditions;

}

sub getLoopConditions { my ($annline)=@_;
     my ($line, $info) = @{$annline};
        if (exists $info->{'Do'}) {
            my $iter = $info->{'Do'}{'Iterator'};
            my ($range_start, $range_stop, $range_step) = @{$info->{'Do'}{'Range'}{'Expressions'}};
            return [$iter,$range_start, $range_stop, $range_step];
        } else {
            croak 'Not a Do AnnLine';
        }
}

sub extractLoopIters { my ( $loop)=@_;
    my @loopIters=();
    for my $annline (@{$loop}) {
        my ($line, $info) = @{$annline};
        if (exists $info->{'Do'}) {
            my $iter = $info->{'Do'}{'Iterator'};
            push @loopIters, $iter;
        }
    }
    return \@loopIters;

}

sub getItersFromVarAccessExpr { (my $var_expr) = @_;
    my $iters = [];
    for my $iter_idx_str (@{ $var_expr->[2]{'Iterators'} }) {
        my ($iter, $idx) = split(/:/,$iter_idx_str);
        push @{$iters},$iter;
    }
    return $iters;
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
    my $readOperands=createExprListFromVarAccesses($info->{'Rhs'}{'VarAccesses'}, $info->{'LineID'},'Read');
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

# This function takes VarAccesses and turns them into a list of expressions
# I think I should add the LineID here for compatibility with Expr which has SrcSpan
sub createExprListFromVarAccesses { (my $accesses, my $line_id, my $rw) = @_;
 my $tmph = {
     %{$accesses->{'Arrays'}},
     %{$accesses->{'Scalars'}}
     };
    # create a tuple [$var_name,{Exprs ...}]
    my $operands=[];
    for my $var (sort keys %{$tmph}) {
        if (exists $tmph->{$var}{$rw}) {
            push @{$operands},[$var,$line_id,$tmph->{$var}{$rw}];
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

sub usesVarName_list { my ($varname_list, $expr)=@_;

    my $var_from_expr = $expr->[0];
    return elem($var_from_expr,$varname_list);
}

sub isNothing { my ($mt) = @_;
   if( $mt->[0] eq 'Nothing') {
        return 1;
   }
   elsif( $mt->[0] eq 'Just') {
       return 0;
   }
   else {
       croak "Not a Maybe type: ".Dumper($mt);
   }
}

sub just { my ($t)=@_;
    return ['Just',$t];
}

sub nothing { 
    return ['Nothing'];
}

sub isJust { my ($mt) = @_;
   if( $mt->[0] eq 'Nothing') {
        return 0;
   }
   elsif( $mt->[0] eq 'Just') {
       return 1;
   }
   else {
       croak "Not a Maybe type: ".Dumper($mt);
   }
}

sub fromJust { my ($mt) = @_;
    
   if( $mt->[0] eq 'Nothing') {
        croak "Nothing not Just ".Dumper($mt);
   }
   elsif( $mt->[0] eq 'Just') {
       return $mt->[1];
   }
   else {
       croak "Not a Maybe type: ".Dumper($mt);
   }    
}

sub isEmpty { my ($mt) = @_;
   if( $mt->[0] eq 'Empty') {
        return 0;
   }
   elsif( $mt->[0] eq 'LoopIterRecord') {
       return 1;
   }
   else {
       croak "Not a TupleTable type: ".Dumper($mt);
   }
}

sub isLoopIterRecord {
   if( $mt->[0] eq 'Empty') {
        return 1;
   }
   elsif( $mt->[0] eq 'LoopIterRecord') {
       return 0;
   }
   else {
       croak "Not a TupleTable type: ".Dumper($mt);
   }
}

sub fromLoopIterRecord { my ($mt) = @_;    
   if( $mt->[0] eq 'Empty') {
        croak "Empty not LoopIterRecord ".Dumper($mt);
   }
   elsif( $mt->[0] eq 'LoopIterRecord') {
       return $mt->[1];
   }
   else {
       croak "Not a TupleTable type: ".Dumper($mt);
   }    
}

sub empty { 
    return ['Empty'];
}

sub loopIterRecord { my ($t)=@_;
    return ['LoopIterRecord',$t];
}

sub error { (my $str)=@_;
    croak($str);
}

sub case { my ($sum_type_inst, $altCondsActions) = @_;
    for my $altCondsAction (@{$altCondsActions}) {
        my ($cond,$action) = @{$altCondsAction};
        if (ref($cond) eq 'CODE') {
            if ($cond->{$sum_type_inst}) {
                if (ref($action) eq 'CODE') {
                    return $action->{$sum_type_inst};
                } else {
                    $action;
                }
            }
        } 
        else {
            if ($cond) {
                if (ref($action) eq 'CODE') {
                    return $action->{$sum_type_inst};
                } else {
                    $action;
                }
            }            
        }
    }
}

sub otherwise {
    1;
}
sub append { my ($lst,$elt) = @_;
    [@{$lst},$elt];
}

sub concat { my @lsts = @_;
my $concat_lsts = [];
    for my $lst (@lsts) {
        $concat_lsts = [@{$concat_lsts},@{$lst}];
    }
    return $concat_lsts;
}

sub length { my ($lst)=@_;
    return scalar @{$lst};
}

sub null { my ($lst)=@_;
    return scalar @{$lst} == 0;
}


sub elem { my ($elt,$lst) = @_;
    my %hash = map {$_=>1} @{$lst};
    return exists $hash{$elt} ? 1 : 0;
}

sub insert { my ($key, $value, $table) = @_;
        $table->{$key}=$value;
        return dclone($table);
}

sub mapf {
	( my $f, my $ls ) = @_;
    return [
        map {
            $f->($_)
        } @{$ls}
    ];
}

sub foldl {
	( my $f, my $acc, my $ls ) = @_;
	for my $elt ( @{$ls} ) {
		$acc = $f->( $acc, $elt );
	}
	return $acc;
}    

sub fold {
    foldl(@_);
} 

sub foldAnd {
	( my $acc, my $ls ) = @_;
	for my $elt ( @{$ls} ) {
		$acc =  $acc && $elt ;
	}
	return $acc;
}

sub foldOr {
	( my $acc, my $ls ) = @_;
	for my $elt ( @{$ls} ) {
		$acc =  $acc || $elt ;
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
sub head { my ($lst)=@_;
    if (scalar @{$lst}>0) {
        return $lst->[0];
    } else {
        croak "head of empty list: ".Dumper($lst);
    }
}

sub tail { my ($lst)=@_;
    my @lst_ = @{$lst};
    if (scalar @lst_>0) {
        shift @lst_
        return \@lst_;
    } else {
        croak "tail of empty list: ".Dumper($lst);
    }
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

sub round { my ($v)=@_;
    my $iv=int($v)
    my $rest = $v-$iv;    
    if ($rest<0.5) {
        $iv;
    } else {
        $iv+1;
    }
}
1;
