
# RefactorF4Acc datastructures

The compiler is written in a mostly functional style, with a global state that is passed around rather than accessed implicitly. However, in Perl variables are not immutable; what is passed around is a reference to the global state, by convention called `$stref`.

I use camel case for the names of the keys in the maps. 

The compiler keeps an AST for each subroutine or function definition (in $stref->{Subroutines}).

## AST (`AnnLines`)

The AST used by the parser is not a conventional tree. Rather, it is a list of `($line, $info)` pairs (which I call 'annotated lines' or AnnLines). To access the AST for a subroutine `$f`, you would typically do

	my $annlines = $stref->{Subroutines}{$f}{AnnLines};
	for my $annline (@{$annlines}) {
		my ($line, $info) = @{$annline};
	}

The `$info` field is a map. Most of the keys depend on the actual code on a given line but there are some general ones:

    Deleted
    Removed
    Ann
    Ref
    Refactored

    LineID

    Comments

Block structure is tracked via a 'Block' attribute, where blocks can be control structures (If, Do) or one of Map|Structure|Union|Select 

    $info->{Block} = { 
    'Nest' => $block_nest_counter, # Int
    'Type' => $block_type, # Map|Structure|Union|Select
    'LineID' => $index, # Int
    'InBlock' => $current_block  # Block
    };

LineID is a unique ID for each line but you cannot assume that it monotonically increases. InBlock contains a reference to the parent block.

### Variables

The main task of this compiler is to analyse and refactor variables. Variables put into a datastructure of nested sets, see XXX

The variable declaration record is as follows:

      $decl={
        'Indent' => $indent,
        'Type' => $type,
        'ArrayOrScalar'=>$array_or_scalar,
        'Attr' => $attr,
        'Dim'=>[],
        'Name'=>$varname,
        'Names'=>[$varname],
        'IODir' => 'Unknown',
        'CommonBlockName' => $common_block_name
      };		

There are two helper functions to access the nested sets:

    get_var_record_from_set($set_ref,$var)
    in_nested_set($Sf,$set_name,$var)

Typically,

	( my $f, my $stref ) = @_;
	my $sub_incl_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_incl_or_mod}{$f};

and `$set` is `$Sf->{$set_name}`

### Parser

The first step of the parser (read_fortran_src in SrcReader) performs normalisation of the code: multi-line statements are combined, comments are normalised. It also identifies start and end of code units (Subroutine|Module|Function|Program) as well as Include statements in each file. Subroutine can also be a Function or Entry.
String literals are replaced by placeholders to facilitate further parsing.

        Parser/SrcReader.pm
        _procLine < _pushAnnLine < read_fortran_src
        1138:		$info->{'Pragma'} = 1;		
        1144,1148:  $info->{'Comments'} = 1;
        1159:		$info->{'Contains'} = 1;       
        1193:       $info->{'TrailingComment'} = $cline; 
        1204,1208:  $info->{'Label'} = $label;
        1232:		$info->{'Macro'} = 1;	
        1234,1238:  $info->{'Includes'} = $1;
        1259:       $info->{'FunctionSig'} = [ $spaces, $name, [] ];
        1261:       $info->{'Module'} = $name;
        1263:       $info->{'EntrySig'} = $name;                
        1265:       $info->{'SubroutineSig'} = [ $spaces, $name, [] ];
        1272:		$info->{'End(Subroutine|Module|Function|Program)'} = $unit_name; 
        1276:       $info->{'Blank'} = 1;            
        1301:       $info->{'PlaceHolders'} = $phs_ref

        _isCommentOrBlank
        _restore_case_of_macros

The actual parser is parse_fortran_src in Parser.pm, which first calls read_fortran_src. 
Then it calls in `_analyse_lines` to parse all lines that are not subroutine calls, use or include statements. These are parsed separately becasue they are recursive: the source is parsed on encountering them (`_parse_use`, `_parse_includes`, `_parse_subroutine_and_function_calls`).

The parser identifies each line and stores the information in `$info`.

### List of all fields in `$info`


#### SrcReader

        Ref = 0 ..
        Pragma = 0|1	
        Comments = 0|1
        Contains = 0|1      
        TrailingComment = $comment_str
        Label = $label
        Macro = 0|1
        Includes = $incl_path
        FunctionSig = [ $spaces, $name, [] ]
        Module = $name
        EntrySig = $name                
        SubroutineSig = [ $spaces, $name, [] ]
        End(Subroutine|Module|Function|Program) = $unit_name 
        Blank = 0|1
        PlaceHolders = $phs_ref

#### Parser

        'Control', 'EndControl'
        'Block', 'BeginBlock', 'EndBlock','InBlock'
        'AccPragma'        
        
        'Assignment', 'Lhs', 'Rhs'
        'CallArgs','ExprVars','CallAttrs'       
        'CondExecExpr','CondExecExprAST','CondVars'
        
        'IO'        
        'Indent',        
        'LineID'
        
        'VarDecl'        
        'ParamDecl'
        'ParsedVarDecl'

        'RefactoredSubroutineCall'
        
        'Removed'
        'Signature'
        'StmtCount'        
        'ModuleParameters'

##### Fortran language features

        'Assign'
        'Common'                
        'Data'
        'Dimension'        
        'EndBlockData'
        'Entry'
        'Equivalence'
        'External'
        'Format'
        'Select','EndSelect'
        'Namelist'
        'Return'
        'Implicit','ImplicitNone'
        
        'If','IfThen','Else','ElseIf','EndIf'
        'Case','CaseDefault','CaseVals','CaseVar'
        
        'BeginDo','EndDo',
        'Goto','Break','Label','NoopBreakTarget','NoopTarget','Continue'
        
        'CloseCall'        
        'InquireCall'         
        'PrintCall'
        'ReadCall'
        'WriteCall'        
        
        'Include'
        'Module','EndModule','Contains','Use'
        'Subroutine','EndSubroutine'

#### Parser/Expressions
        'FunctionCalls','SubroutineCall'
        
#### Analysis

        'OuterLoopEnd', 'OuterLoopStart'

#### Refactoring

        'ExGlobArgDecls','ExGlobVarDeclHook'
        
        'Ast','FileNameVar','Vars'
        
        'DeadCode'
        'Deleted'
        
        'Refactored'
        



```

```
