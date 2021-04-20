# RefactorF4Acc datastructures

The compiler is written in a mostly functional style, with a global state that is passed around rather than accessed implicitly. However, in Perl variables are not immutable; what is passed around is a reference to the global state, by convention called `$stref`.

I use camel case for the names of the keys in the maps. 

The compiler keeps an AST for each subroutine or function definition (in $stref->{Subroutines}).

The AST used by the parser is not a conventional tree. Rather, it is a list of `($line, $info)` pairs (which I call 'annotated lines' or AnnLines). To access the AST for a subroutine `$f`, you would typically do

	my $annlines = $stref->{Subroutines}{$f}{AnnLines};
	for my $annline (@{$annlines}) {
		my ($line, $info) = @{$annline};
	}

The `$info` field is a map. Most of the keys depend on the actual code on a given line but there are some general ones:

Deleted
Removed
Ann
Skip
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

## Variables

The main task of this compiler is to analyse and refactor variables. Variables put into a datastructere of nested sets, see XXX

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

and $set is $Sf->{$set_name}


## Parser

The first step of the parser (read_fortran_src in SrcReader) performs normalisation of the code: multi-line statements are combined, comments are normalised. It also identifies start and end of code units (Subroutine|Module|Function|Program) as well as Include statements in each file. Subroutine can also be a Function or Entry.
String literals are replaces by placeholders to facilitate further parsing.

Parser/SrcReader.pm
_procLine < _pushAnnLine < read_fortran_src
1138:		$info->{'Pragma'} = 1;		
1144,1148:    	$info->{'Comments'} = 1;
1159:		$info->{'Contains'} = 1;       
1193:       	$info->{'TrailingComment'} = $cline; 
1204,1208:      	$info->{'Label'} = $label;
1232:		$info->{'Macro'} = 1;	
1234,1238:     	$info->{'Includes'} = $1;
1259:          	$info->{'FunctionSig'} = [ $spaces, $name, [] ];
1261:           	$info->{'Module'} = $name;
1263:           	$info->{'EntrySig'} = $name;                
1265:           	$info->{'SubroutineSig'} = [ $spaces, $name, [] ];
1272:		$info->{'End(Subroutine|Module|Function|Program)'} = $unit_name; 
1276:           	$info->{'Blank'} = 1;            
1301:           	$info->{'PlaceHolders'} = $phs_ref

_isCommentOrBlank
_restore_case_of_macros

The actual parser is parse_fortran_src in Parser.pm, which first calls read_fortran_src. 
Then it calls in _analyse_lines to parse all lines that are not subroutine calls, use or include statements. These are parsed separately becasue they are recursive: the source is parsed on encountering them (_parse_use, _parse_includes, _parse_subroutine_and_function_calls).

The parser identifies each line and stores the information in $info.

Parser.pm

parse_fortran_src < MAIN
refactor_marked_blocks_into_subroutines < MAIN
_initialise_decl_var_tables < parse_fortran_src

_analyse_lines < parse_fortran_src
425:				$info->{'Indent'}=$indent;						
426:				$info->{'LineID'} = $index;

449:				$info->{'Label'}=$label; # Fortran language feature
469:				$info->{(Map|Structure|Union|Select)}=1;  # Fortran language feature
483,492,501,545,556,579,1262:	$info->{'Block'}= $block;

571,592,1238:				$info->{'Continue'}={'Label' => $cont_label}; # Fortran language feature
581,672:				$info->{'EndControl'}= 1;				 

651:				$info->{'ImplicitNone'} = 1; # F95 language feature
657:				$info->{'Use'} = $module; # F95 language feature
662:				$info->{'Implicit'} = 1; # F95 language feature

671:				$info->{ 'End' . $kw } = {}; # Fortran language feature

676:				$info->{'EndDo'} = $corresponding_do_info->{'Do'}; # Fortran language feature

687:				$info->{'Dimension'}=1; # Fortran language feature
766:				$info->{'StmtCount'}{$varname}=$Sf->{'DeclCount'}{$varname};
845:				$info->{'Common'} = { 'Name' => $common_block_name , 'Vars' => { 'Set' =>$parsedvars, 'List' => $parsedvars_lst}}; # Fortran language feature
859:				$info->{'Namelist'}=$namelist_group_name; # Fortran language feature	
864:				$info->{'Format'}=1; # Fortran language feature
869:		 		$info->{'Data'} = 1; # Fortran language feature
896:		 		$info->{ucfirst($qualifier)} = { map {$_=>1} @external_procs};
903:		 		$info->{'Equivalence'} = 1; # Fortran language feature

958:				$info->{ 'End' . ucfirst($kw) } = { 'Name' => $name }; # Fortran language feature

979,1016:			$info->{'Do'} = {
						'While' =>1,
						'Iterator' => '',
						'Label'    => $label,
						'ExpressionsAst' => $ast,
						'Range'    => {	
							'Expressions' =>[$range_start, $range_stop, $range_step],
							'Vars'        => $vars,
							},
						'LineID' => $info->{'LineID'}
					};
1026,1032,1037,1041,1046,1096:				$info->{ 'Control' } = 1;
1031:				$info->{'CaseVar'} = $1;
1036:				$info->{'CaseVals'} = [@case_vals];
1038:				$info->{ 'Case' } = ++$case_counter; # Fortran language feature			
1040:				$info->{'CaseDefault'} = 1; # Fortran language feature

1045:				$info->{'Else'} = 1; # Fortran language feature			

1047, 1061:				$info->{ 'EndControl' } = 1;		
1060:				$info->{'ElseIf'} = 1; # Fortran language featur					

1063:				$info->{ ucfirst($keyword) } = 1; # 'If'  # Fortran language feature	
1078:				$info->{'CondExecExpr'}=$cond;
1088:				$info->{'CondExecExprAST'}= $ast;
1093:				$info->{'CondVars'}{'Set'} = $vars_in_cond_expr;
1094:				$info->{'CondVars'}{'List'} = [ keys %{$vars_in_cond_expr} ];

1097:				$info->{ 'IfThen' } = 1; # Fortran language feature						
1160:				$info->{ ucfirst($keyword) . 'Call' } = 1; # Fortran language feature
1161,1169,1221,1244:				$info->{'IO'}=1;
1168:				$info->{ ucfirst($keyword) . 'Call' } = 1; # Fortran language feature
1174:				$info->{'Ast'} = $ast;
1178:				$info->{'FileNameVar'} =
1181:				$info->{'Vars'}{'Set'}
1199,1204,1207,1212:				$info->{'Vars'}{'Set'}{$mvar} = 1;
1215:				@{ $info->{'Vars'}{'List'} } = keys %{ $info->{'Vars'}{'Set'} };
1220:				$info->{ ucfirst($keyword) } = 1;
1226:				$info->{ ucfirst($keyword) } = 1;
1232:				$info->{'Assign'}={'Label' => $label, 'Var' => $var}; # Fortran language feature
1243:				$info->{ ucfirst($keyword) } = 1;

1250:				$info->{'Assignment'} = 1;

_parse_includes < parse_fortran_src
1366, 1367:			$info->{'Include'}{
'Name' = $name
} # Fortran language feature

_parse_use < parse_fortran_src
1477,1478,1491,1493:				$info->{'Use'} = {
'Name' => $name,
'Inlineable' => 0|1;
};# F95 language feature

_separate_blocks < refactor_marked_blocks_into_subroutines
__find_called_subs_in_OUTER < _separate_blocks < refactor_marked_blocks_into_subroutines
_parse_subroutine_and_function_calls < parse_fortran_src
1744:				$info->{'AccPragma'}{'BeginKernelWrapper'}[0];

1772, 2479:				$info->{'SubroutineCall'} = {
'Name' => $name,
'ExpressionAST' => $ast,
'Args' => $info->{'CallArgs'},
'IsExternal' => 0|1
'ArgMap' => {} # Populated in Analysis.pm
}; # Fortran language feature

1778:				$info->{'LineID'} };    # slot for the arguments
1783:				$info->{'LineID'} };    # slot for the arguments

1815:				$info->{'CallArgs'}               = 
{'Set' => $call_args_set,
'List' => $call_args_list
};
1816:				$info->{'ExprVars'}               = $expr_other_vars;


build_call_graph < MAIN

f77_var_decl_parser < _analyse_lines < parse_fortran_src
f77_var_decl_parser < __parse_f77_var_decl < _analyse_lines < parse_fortran_src
__split_out_parameters < _analyse_lines < parse_fortran_src
__find_parameter_used_in_inc_and_add_to_Only < _analyse_lines < parse_fortran_src
_parse_implicit < _analyse_lines < parse_fortran_src

__separate_into_blocks < _separate_blocks < refactor_marked_blocks_into_subroutines
2478:				$info->{'RefactoredSubroutineCall'}{'Name'} = $block;

2481:				$info->{'BeginBlock'}{'Name'} = $block;
2506:				$info->{'EndBlock'}{'Name'} = $block;			
2513:				$info->{'InBlock'}{'Name'} = $block;

__create_new_subroutine_entries
__find_vars_in_block
__construct_new_subroutine_signatures
__reparse_extracted_subroutines
__update_caller_datastructures

_split_multivar_decls
_split_multipar_decls_and_set_type

__parse_sub_func_prog_decls < _analyse_lines < parse_fortran_src
3091:				$info->{'Signature'}={
'Name' => $name,
'Function' => 0|1,
'Program' => 0|1,
'BlockData' => 0|1,
'Entry' => 0|1,
'Args' => {
	'List' => [@args],
	'Set' => map { $_ => 1 } @args 
},
'RefactoredArgs' => {
	'List' => [],
	'Set' => {}
}
}


__handle_acc < mark_blocks_between_calls
3205:				$info->{'AccPragma'}=
{ 
  $pragma_name_prefix . ucfirst( lc($pragma_name) )  => [@pragma_args]
}

__parse_f95_decl < _analyse_lines < parse_fortran_src
3234:				$info->{'ParsedParDecl'} = $pt;
3253:				$info->{'ParamDecl'} =  {
			'Indent'    => $indent,
			'Type'      => $type,
			'Attr'      => '',
			'Dim'       => [],
			'Parameter' => 'parameter',
			'Names'     => [ [ $var, $val ] ],
			'Status'    => 0,
			'ArrayOrScalar' => 'Scalar' # FIXME: Asumption that parameters are always scalars  
		};    # F95-style



3254 ,3283:				$info->{'VarDecl'} =  {
				'Indent' => $indent,
				'Names'  => $pt->{'Vars'},
				'Status' => 0,
				'Name' => 
				'Type' => $pt->{'TypeTup'}{'Type'};
				'ArrayOrScalar' => 'Scalar';
				'Dim'           = [];
				'Allocatable' => 'allocatable',
				'Attr' =>
				'IODir' =>
			};
3256:				$info->{'UsedParameters'} = $pars_in_val;
Fortran::F95VarDeclParser::parse_F95_var_decl 
3281:				$info->{'ParsedVarDecl'} = {
TypeTup =>{
Type => Word
Kind => Int
},
Attributes => {
Dim => [],
Allocatable => 0|1.
Intent => in|out|inout
},
Vars => [$varlist],
Pars => {
Var => Word
Val => Expression,
},
AccPragma => {
},
VarsDims =>{
Dim
}

};


__parse_f77_par_decl < _analyse_lines < parse_fortran_src
3528:				$info->{'UsedParameters'} = $pars_in_val;
3529:				$info->{'ParamDecl'}      = {
		'Indent'    => $indent,
		'Type'      => $type,
		'Attr'      => $attr,
		'Dim'       => [],
		'Parameter' => 'parameter',
		'Names'     => [@var_vals],
		'Status'    => 0,			 
	};

__parse_f77_var_decl < _analyse_lines < parse_fortran_src
3875:				$info->{'StmtCount'}{$tvar} = $Sf->{'DeclCount'}{$tvar};
3881:				$info->{'VarDecl'} =  {
		'Indent' => $indent,	
		'Names'  => \@varnames,
		'Status' => 0
	};

_identify_loops_breaks < parse_fortran_src
3920:				$info->{'BeginDo'}{'Label'} = $label;
3939:				$info->{'Goto'}{'Label'} = $label;
3954:				$info->{'Continue'}{'Label'} = $label;
3958:				$info->{'EndDo'}{
'Label' => $label,
'Count' => $count
4000:				$info->{$target}{'Label'} = $label;
$target = (DoLabelTarget|GotoTarget|NoopBreakTarget|BreakTarget|NoopTarget)

_parse_read_write_print < _analyse_lines < parse_fortran_src
4033:				$info->{'CallAttrs'} = { 'Set' => {

}, 'List' => [] };
4070:				$info->{'CallAttrs'}{'Set'}{$call_attr} = { 'Type' => $type };
4105,4164,4173,4199:				$info->{'CallArgs'} = { 'List' => [], 'Set' => {} };
4106,4151,4168,4175,4201:				$info->{'ExprVars'} = { 'List' => [], 'Set' => {} };

_parse_assignment < _analyse_lines < parse_fortran_src
4297,4304,4310:				$info->{'Lhs'} = {

_parse_array_access_or_function_call < _parse_read_write_print < _analyse_lines < parse_fortran_src
_parse_IO_sub_call < _parse_read_write_print < _analyse_lines < parse_fortran_src
_parse_if_cond < _analyse_lines < parse_fortran_src

_parse_comma_sep_expr_list

___check_par_val_for_pars < __parse_f95_decl

__remove_blanks

_parse_data_declaration < _analyse_lines < parse_fortran_src
4596, 4603:				$info->{'Lhs'} =  {
			'VarName'       => $lhs_varname,
			'IndexVars'     => $lhs_vars,
			'ArrayOrScalar' => Array|Scalar|Other,
			'ExpressionAST' => $lhs_ast
		};


4621:				my $ph_str = $info->{'PlaceHolders'}{$ph};

4628:	$rinfo->{'Rhs'} = {
		'VarList'       => {
		'Set'  => { %{ $rhs_args->{'Set'} },  %{ $rhs_vars->{'Set'} } },
		'List' => [ @{ $rhs_args->{'List'} }, @{ $rhs_vars->{'List'} } ]
	};

		'ExpressionAST' => $rhs_val_ast
	};	
4644:				$info->{'Assignment'}=1;
4645:				$info->{'Data'}=1;



_get_var_from_ast < __parse_f77_var_decl
_get_dim_from_ast < __parse_f77_var_decl
_get_len_from_ast < __parse_f77_var_decl

mark_blocks_between_calls
4797, 4804:				$info->{'Removed'}=1;

Parser/Expressions.pm
261:				$info->{'FunctionCalls'}{$mvar}=1;


## Analysis

Analysis.pm
229:		if (   exists $info->{'Assignment'}
230:			or exists $info->{'SubroutineCall'}
231:			or exists $info->{'If'} # Control
232:			or exists $info->{'ElseIf'} # Control
233:			or exists $info->{'Do'} # Control
234:			or exists $info->{'WriteCall'}# IO
235:			or exists $info->{'PrintCall'}# IO
236:			or exists $info->{'ReadCall'}# IO
237:			or exists $info->{'InquireCall'}# IO
238:			or exists $info->{'OpenCall'}# IO
239:			or exists $info->{'CloseCall'}# IO
240:			or exists $info->{'ParamDecl'} )
531:		if (   exists $info->{'Assignment'}
532:			or exists $info->{'SubroutineCall'}
533:			or exists $info->{'If'} # Control
534:			or exists $info->{'ElseIf'} # Control
535:			or exists $info->{'Do'} # Control
536:			or exists $info->{'WriteCall'}# IO
537:			or exists $info->{'PrintCall'}# IO
538:			or exists $info->{'ReadCall'}# IO
539:			or exists $info->{'InquireCall'}# IO
540:			or exists $info->{'OpenCall'}# IO
541:			or exists $info->{'CloseCall'}# IO
542:			or exists $info->{'ParamDecl'} )
546:			if ( exists $info->{'If'} or exists $info->{'ElseIf'} ) {
547:				@chunks = @{ $info->{'CondVars'}{'List'} };
550:			if (   exists $info->{'PrintCall'}
551:				or exists $info->{'WriteCall'}
552:				or exists $info->{'ReadCall'}
553:				or exists $info->{'InquireCall'} 
555:				@chunks = ( @chunks, @{ $info->{'CallArgs'}{'List'} }, @{ $info->{'ExprVars'}{'List'} }, @{ $info->{'CallAttrs'}{'List'} } );
557:			} elsif ( exists $info->{'SubroutineCall'} ) {
558:				for my $var_expr ( @{ $info->{'CallArgs'}{'List'} } ) {
559:					if ( exists $info->{'CallArgs'}{'Set'}{$var_expr}{'Arg'} ) {
560:						push @chunks, $info->{'CallArgs'}{'Set'}{$var_expr}{'Arg'};
565:				for my $expr_var ( @{ $info->{'ExprVars'}{'List'} } ) {
568:			} elsif ( exists $info->{'OpenCall'} ) {
569:				if ( exists $info->{'Vars'} ) {
570:					@chunks = ( @chunks, @{ $info->{'Vars'}{'List'} } );
572:			} elsif ( exists $info->{'Do'} ) {
573:				@chunks = ( @chunks, $info->{'Do'}{'Iterator'}, @{ $info->{'Do'}{'Range'}{'Vars'} } );
574:			} elsif ( exists $info->{'Assignment'} and not exists $info->{'Data'}) {
575:				@chunks = ( @chunks, $info->{'Lhs'}{'VarName'}, @{ $info->{'Lhs'}{'IndexVars'}{'List'} }, @{ $info->{'Rhs'}{'VarList'}{'List'} } );
576:			} elsif ( exists $info->{'ParamDecl'} ) {
577:				@chunks = ( @chunks, keys %{ $info->{'UsedParameters'} } );
735:		if ( exists $info->{'SubroutineCall'}
736:			and not exists $info->{'SubroutineCall'}{'IsExternal'} )
738:			my $sub = $info->{'SubroutineCall'}{'Name'};
740:			$info->{'SubroutineCall'}{'ArgMap'} = {};    # A map from the sig arg to the call arg, because there can be duplicate call args but not sig args
742:			my $call_args = $info->{'SubroutineCall'}{'Args'}{'List'};
745:			for my $call_arg_expr ( @{ $info->{'CallArgs'}{'List'} } ) {
750:				if ( $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Type'} eq 'Array' ) {
751:					$call_arg = $info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Arg'};
760:						$info->{'CallArgs'}{'Set'}{$call_arg_expr}{'Type'} = 'Sub';
770:				$info->{'SubroutineCall'}{'ArgMap'}{$sig_arg} = $call_arg_expr;
791:		if ( exists $info->{'SubroutineCall'}
792:			and not exists $info->{'SubroutineCall'}{'IsExternal'} )
794:			my $sub = $info->{'SubroutineCall'}{'Name'};
802:				my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
1060:		if (exists $info->{'Comments'} or exists $info->{'Blank'}) {
1066:		(exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'} and $info->{'Signature'}{'Program'} == 1) or
1067:		exists $info->{'Include'} or
1068:		exists $info->{'VarDecl'} or
1069:		exists $info->{'Common'} or
1070:		exists $info->{'Dimension'} or 
1071:		exists $info->{'External'} or
1072:		exists $info->{'Equivalence'} # I guess there might be others ...


Analysis/ArgumentIODirs.pm
291:				if ( exists $info->{'Blank'} or exists $info->{'Comments'} or exists $info->{'Deleted'}) {
296:				if (  exists $info->{'Format'} ) {
301:				if ( exists $info->{'Signature'} ) {
306:				if ( exists $info->{'Use'} or exists $info->{'Include'} ) {
311:				if ( exists $info->{'VarDecl'} ) { 
315:				if ( exists $info->{'Do'} ) {
316:					my $mvar = $info->{'Do'}{'Iterator'};
323:					for my $mvar ( @{ $info->{'Do'}{'Range'}{'Vars'} } ) {
335:					exists $info->{'OpenCall'}  
337:                  for my $var ( @{ $info->{'Vars'}{'List'} } ) {
343:				if ( exists $info->{'WriteCall'} or exists $info->{'PrintCall'} ) {
346:						@{ $info->{'CallArgs'}{'List'} },
347:						@{ $info->{'ExprVars'}{'List'} },
348:						@{ $info->{'CallAttrs'}{'List'} }
362:				if ( exists $info->{'ReadCall'} or exists $info->{'InquireCall'}) {
364:					for my $mvar ( @{ $info->{'CallArgs'}{'List'} } ) {
372:						@{ $info->{'ExprVars'}{'List'} },
373:						@{ $info->{'CallAttrs'}{'List'} }
385:				if (exists $info->{'If'}  ) {
386:						my $cond_vars = $info->{'CondVars'}{'List'};						
392:				if (   exists $info->{'SubroutineCall'} && exists $info->{'SubroutineCall'}{'Name'} ) {
393:					my $name = $info->{'SubroutineCall'}{'Name'};
398:					for my $mvar ( @{$info->{'ExprVars'}{'List'}} ) {
460:				elsif (exists $info->{'Assignment'} ) {
464:					my $rhs_vars = $info->{'Rhs'}{'VarList'}{'List'};
471:					my $lhs_var = $info->{'Lhs'}{'VarName'};
473:					my $lhs_index_vars = $info->{'Lhs'}{'IndexVars'}{'List'};
547:				if ( exists $info->{'Blank'} or exists $info->{'Comments'} ) {
552:				if (  exists $info->{'Format'} ) {
557:				if ( exists $info->{'Signature'} ) {
562:				if ( exists $info->{'Use'} or exists $info->{'Include'} ) {
567:				if ( exists $info->{'VarDecl'} ) { next; }
569:				if ( exists $info->{'Do'} ) {
570:					my $mvar = $info->{'Do'}{'Iterator'};
578:					for my $mvar ( @{ $info->{'Do'}{'Range'}{'Vars'} } ) {
592:					exists $info->{'OpenCall'} 
597:                  for my $var ( @{ $info->{'Vars'}{'List'} } ){
608:				if (   exists $info->{'WriteCall'}
609:					or exists $info->{'PrintCall'} )
614:						@{ $info->{'CallArgs'}{'List'} },
615:						@{ $info->{'ExprVars'}{'List'} },
616:						@{ $info->{'CallAttrs'}{'List'} }
630:				if ( exists $info->{'ReadCall'} or exists $info->{'InquireCall'}) {
633:					for my $mvar ( @{ $info->{'CallArgs'}{'List'} } ) {
644:						@{ $info->{'ExprVars'}{'List'} },
645:						@{ $info->{'CallAttrs'}{'List'} }
661:				if (   exists $info->{'SubroutineCall'}
662:					&& exists $info->{'SubroutineCall'}{'Name'} ) {
663:					my $name = $info->{'SubroutineCall'}{'Name'};
669:					for my $mvar ( @{$info->{'ExprVars'}{'List'}} ) {
987:	my $name              = $info->{'SubroutineCall'}{'Name'};
999:		my $argmap = $info->{'SubroutineCall'}{'ArgMap'};		
1012:				my $call_arg_type = $info->{'CallArgs'}{'Set'}{$call_arg}{'Type'};
1020:						$call_arg = $info->{'CallArgs'}{'Set'}{$call_arg}{'Arg'};
1116:		for my $arg ( @{ $info->{'SubroutineCall'}{'Args'}{'List'} } ) {			
1147:		if ( exists $info->{'VarDecl'} ) {
1149:			my $varname = $info->{'VarDecl'}{'Name'};
1171:                    if (exists $info->{'Skip'}) {
1173:                    	push @{$info->{'Ann'}},'SKIP';

Analysis/DeadCodeElimination.pm
44:        if (exists $info->{'If'} ) {
51:        if (exists $info->{'Do'} ) {
58:        if (exists $info->{'EndIf'} ) {
70:        if (exists $info->{'Do'} ) {
82:        if (not exists $info->{'Assignment'} and not exists $info->{'SubroutineCall'}) {
93:        if (exists $dead_code_regions->{$info->{'LineID'}}) {
94:            $info->{'DeadCode'}=1;

Analysis/IdentifyStencils.pm
227:			if ( exists $info->{'Signature'} ) {
228:				my $subname =$info->{'Signature'}{'Name'} ; 
235:			if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'} and $line=~/dimension/) { # Lazy			 	
236:				my $array_var=$info->{'VarDecl'}{'Name'};				
239:				my @dims = @{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} };
287:			if (exists $info->{'Assignment'} ) {
289:				if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_rel/) {
294:				if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Scalar' and $info->{'Lhs'}{'VarName'} =~/^(\w+)_range/) {
297:					my $expr_str = emit_expression($info->{'Rhs'}{'ExpressionAST'},'');
305:						ref($info->{'Rhs'}{'ExpressionAST'}) eq 'ARRAY' 
306:					and $info->{'Rhs'}{'ExpressionAST'}[0] eq '@'
307:					and ref($info->{'Lhs'}{'ExpressionAST'}) eq 'ARRAY' 
308:					and $info->{'Lhs'}{'ExpressionAST'}[0] eq '@'
309:					and $info->{'Lhs'}{'ExpressionAST'}[1] eq $info->{'Rhs'}{'ExpressionAST'}[1]
311:						my $var_name = $info->{'Rhs'}{'ExpressionAST'}[1];
321:					(my $rhs_ast, $state) = _find_array_access_in_ast($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'Read');
322:					(my $lhs_ast, $state) = _find_array_access_in_ast($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'},'Write')
324:				my $var_name = $info->{'Lhs'}{'VarName'};
328:				push @{$state->{'Subroutines'}{ $f }{'Assignments'}{$var_name}}, $info->{'Rhs'}{'ExpressionAST'};			

Analysis/LoopDetect.pm
82:        if ( exists $info->{'Do'} ) {
89:              $info->{'Do'}{'Iterator'};
93:        if ( exists $info->{'SubroutineSig'} ) {
94:            $subname = $info->{'SubroutineSig'}[1]; #[$spaces, $subname,[@subargs]] 
153:        if ( exists $info->{'Do'} ) {
154:            if ( $info->{'LineID'} == $outer_loop_info->{'LineID'} ) {
155:                $info->{'OuterLoopStart'} = $kernelwrapper;
159:        if ( exists $info->{'EndDo'} ) {
160:            if ( exists $info->{'EndDo'}{'LineID'}
161:                and $info->{'EndDo'}{'LineID'} == $outer_loop_info->{'LineID'} )
165:                $info->{'OuterLoopEnd'} = {};
171:            } elsif ( exists $info->{'EndDo'}{'Label'}
172:                and $info->{'EndDo'}{'Label'} ==
177:                $info->{'OuterLoopEnd'} = $kernelwrapper;
251:            if ( exists $info->{'OuterLoopStart'}
252:                and $info->{'OuterLoopStart'} eq $kernelwrapper )
257:                and exists $info->{'AccPragma'}
258:                and exists $info->{'AccPragma'}{'BeginKernelWrapper'}
259:                and $info->{'AccPragma'}{'BeginKernelWrapper'}[0] eq
265:                and exists $info->{'AccPragma'}
266:                and exists $info->{'AccPragma'}{'EndKernelWrapper'}
267:                and $info->{'AccPragma'}{'EndKernelWrapper'}[0] eq
273:                if ( $code_region == $LOOP and exists $info->{'Do'} ) {
274:                    my $iter = $info->{'Do'}{'Iterator'};
278:                if ( $code_region == $LOOP and exists $info->{'Assignment'} ) {
282:                    my $varname = $info->{'Assignment'}{'Lhs'}{'VarName'};
286:                    and exists $info->{'SubroutineCall'} )
291:                    my $sub_name = $info->{'SubroutineCall'}{'Name'};
306:                      { $info->{'SubroutineCall'}{'Name'} }{RefactoredArgs}
309:                      $info->{'SubroutineCall'}{'RefactoredArgs'};
327:            if ( $code_region == $WRAPPER and exists $info->{'Assignment'} ) {
328:                if ( not exists $info->{Deleted} ) {
330:                    my $varname = $info->{'Assignment'}{'Lhs'}{'VarName'};
336:            if ( $code_region == $WRAPPER and exists $info->{'SubroutineCall'} )
338:                if ( not exists $info->{Deleted} ) {
340:                    my $sub_name = $info->{'SubroutineCall'}{'Name'};
354:            if ( exists $info->{'OuterLoopEnd'}
355:                and $info->{'OuterLoopEnd'} eq $kernelwrapper )
369:    if (exists($info->{AccPragma}) and exists($info->{AccPragma}{BeginKernelWrapper})) {
372:if (exists($info->{AccPragma}) and exists($info->{AccPragma}{EndKernelWrapper})) {
377:if (exists($info->{SubroutineCall}) {
379:	my $name  = $info->{'SubroutineCall'}{'Name'};			 	
383:if (exists($info->{Assignment}) and $info->{Assignment}==1) {

Refactoring

Refactoring.pm
108:		if ( exists $info->{'IO'}){
113:				[$info->{'Indent'}.'continue',{'Continue' => 1}],
171:	    	if (not exists $info->{'Removed'}) {
172:				if (exists $info->{'IO'}) { 
173:					$info->{'Removed'}=1;
175:				} elsif (exists $info->{'Do'}) {
186:				} elsif (exists $info->{'If'}) { 
203:						push @{$new_annlines}, [$info->{'Indent'}.'continue' ,{'Continue'=>1}];
206:				} elsif (exists $info->{'Else'} or exists $info->{'ElseIf'}) {
243:		if (exists $info->{'Removed'} and not exists $prev_info->{'Removed'}) {
267:		if (not exists $info->{'Removed'} and exists $prev_info->{'Removed'}) {
291:		if ( not exists $info->{'Comments'} and not exists $info->{'Blank'} and not exists $info->{'Removed'}) {
312:		if (exists $info->{'PlaceHolders'}) {					
315:				my $ph_str = $info->{'PlaceHolders'}{$ph};


Refactoring/Common.pm
96:        if ( exists $info->{'Deleted'} and $line eq '' ) {
99:        if ( exists $info->{'ImplicitNone'} ) {
102:        if ( exists $info->{'Implicit'} ) { 
104:        	$info->{'Deleted'}=1;
105:        	$info->{'Ann'}=[ annotate($f, __LINE__ .' Original Implicit statement' ) ];
108:        if ( exists $info->{'Dimension'} and not exists $info->{'VarDecl'} ) {
111:        	$info->{'Deleted'}=1;
112:        	$info->{'Ann'}=[ annotate($f, __LINE__ .' Original Dimension statement' ) ];
115:        if ( exists $info->{'Common'} ) {
118:        	$info->{'Deleted'}=1;
119:        	$info->{'Ann'}=[ annotate($f, __LINE__ .' Original Common statement' ) ];
123:        if ( exists $info->{'External'} ) {
125:        	if (scalar keys %{ $info->{'External'}} >1) {
128:        	for my $maybe_ext (keys %{ $info->{'External'} } ) {
134:        			$info->{'Deleted'}=1;        			
140:						$info->{'Deleted'}=1;
147:        	$info->{'Ann'}=[ annotate($f, __LINE__ .' External statement' ) ];
149:		if ( exists $info->{'Data'} ) {
158:        if ( exists $info->{'Goto'} ) {
160:            $info->{'Ref'}++;
164:        if ( exists $info->{'BeginDo'} ) {
165:        	my $label = $info->{'BeginDo'}{'Label'};
171:            	$info->{'Ref'}++;
177:        if ( exists $info->{'EndDo'} and exists $info->{'EndDo'}{'Label'} ) {
181:            if ( $Sf->{'Gotos'}{ $info->{'EndDo'}{'Label'} } ) {
186:            my $count = $info->{'EndDo'}{'Count'};
187:            if ( exists $info->{'Continue'} ) {
191:                	if (exists $info->{'EndDo'}{'Label'}) {
192:                		$label = $info->{'EndDo'}{'Label'}
193:                	} elsif (exists $info->{'Continue'}{'Label'}) {
194:                		$label = $info->{'Continue'}{'Label'}
197:                    	$line = $info->{'Indent'}. $label.    ' end do'; # END DO can't be a label target I think
199:                    	$line = $info->{'Indent'}.' end do';
206:                $info->{'Ref'}++;
210:                    $info->{'Ref'}++;
223:            && (   exists $info->{'NoopBreakTarget'}
224:                || exists $info->{'NoopTarget'} )
228:            $info->{'Ref'}++;
230:        if ( exists $info->{'Break'} ) {
232:            $info->{'Ref'}++;
237:        if ( exists $info->{'PlaceHolders'} ) { 
241:				my $ph_str = $info->{'PlaceHolders'}{$ph};
245:            $info->{'Ref'}++;
252:        if ( exists $info->{'VarDecl'} ) {        	        	        
253:        	my $var =  $info->{'VarDecl'}{'Name'};
254:			my $stmt_count = $info->{'StmtCount'}{$var};
256:            if (exists  $info->{'ParsedVarDecl'} ) {
257:                my $pvd = $info->{'ParsedVarDecl'}; 
258:                if (scalar @{ $info->{'ParsedVarDecl'}{'Vars'} } == 1) {
259:                    if (exists $info->{'Dimension'}) {
262:                    	push @{$info->{'Ann'}}, annotate($f, __LINE__ .': Dimension, '.($stmt_count == 1 ? '' : 'SKIP'));
266:                    push @{$info->{'Ann'}}, annotate($f, __LINE__ .': ParsedVarDecl, '.($stmt_count == 1 ? '' : 'SKIP'));                    
272:	                $info->{'Skip'}=1;
273:	                $info->{'Deleted'} = 1;
274:	                $info->{'Ann'}=[ annotate($f, __LINE__ .' Removed ParamDecl' ) ];
275:	            } elsif (not exists $info->{'Ref'} or $info->{'Ref'} == 0 ){
278:	                delete $info->{'ExGlobArgDecls'};
279:	                $info->{'Ref'} = 1;                 
280:	                push @{$info->{'Ann'}}, annotate($f, __LINE__ .': Ref==0, '.$stmt_count );
288:            	$info->{'Skip'}=1; 
292:            		$info->{'Skip'}=1;
303:        if ( exists $info->{'If'} or exists $info->{'ElseIf'} ) {
313:            $info->{'Ref'}++;
320:        elsif ( exists $info->{'ParamDecl'} )
323:                my $par_decls= [ $info->{'ParamDecl'} ];
325:                my $info_ref = $info->{'Ref'} // 0;         
326:                       	if (exists $info->{'VarDecl'}{'Name'} ) {             		
327:                             my $var = $info->{'VarDecl'}{'Name'};                                               
330:                    elsif (exists $info->{'ParamDecl'}{'Name'} ) {                    		
331:                             my $var_val = $info->{'ParamDecl'}{'Name'};
334:                    } elsif (exists $info->{'ParamDecl'}{'Names'} ) { 
336:                        for my $var_val (@{  $info->{'ParamDecl'}{'Names'} }) {
345:                		$par_decl->{'Name'}[1]=$info->{'PlaceHolders'}{$ph};
363:		            $info->{'Ann'}=[ annotate($f, __LINE__ .' Original ParamDecl' ) ];
364:		            $info->{'Deleted'} = 1;
372:        elsif ( exists $info->{'SubroutineCall'} ) {
373:            $info->{'Ref'}++;
374:        } elsif ( exists $info->{'Include'} ) { 
376:            my $inc  = $info->{'Include'}{'Name'};
383:                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__. ' Include' );
391:                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__. ' Include' );
394:                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';            		
403:                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';					            		  	
407:                  	push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' no pars used'); #croak 'SKIP USE PARAM';
408:                  	$info->{'Deleted'}=1;            		
414:                  push @{ $info->{'Ann'} }, annotate($f, __LINE__ . ' External ');
416:            $info->{'Ref'}++;
421:            $info->{'LineID'} = $nextLineID++;
424:        } 
490:        if ( exists $info->{'Deleted'} or exists $info->{'Comments'} or exists $info->{'Blank'}  ) {
493:        if (exists $info->{'ParamDecl'}) {
496:        if (exists $info->{'Include'} ) {
499:        if (exists $info->{'VarDecl'}) {
500:            $info->{'ExGlobVarDeclHook'}='VarDecl';
519:            if ( exists $info->{'Deleted'} or exists $info->{'Comments'} or exists $info->{'Blank'}  ) {
523:                if (exists $info->{'ParamDecl'} and --$parlinecount == 0) {
524:                    $info->{'ExGlobVarDeclHook'}='AFTER LAST ParamDecl';
530:                if (exists $info->{'Include'} and --$incllinecount == 0) {
531:                    $info->{'ExGlobVarDeclHook'}='AFTER LAST Include';
536:            } elsif (exists $info->{'Signature'}) {
537:                $info->{'ExGlobVarDeclHook'}='Signature';
564:        if ( not exists $info->{'Comments'} and ( exists $info->{'InBlock'} or not exists $info->{'Deleted'} ) ) {
575:				if (not exists $info->{'ReadCall'} and not exists $info->{'WriteCall'} and not exists $info->{'PrintCall'} ) {

583:					 if (exists $info->{'PlaceHolders'} ) {
585:					 	for my $ph (keys %{$info->{'PlaceHolders'}} ) {
586:					 		my $ph_str = $info->{'PlaceHolders'}{$ph};
645:        if ( not exists $info->{'Comments'}
646:            and ( exists $info->{'InBlock'} or not exists $info->{'Deleted'} ) )
1466:        if ( $info->{'LineID'} == $insert_pos_lineID and $once ) {

Refactoring/Functions.pm
44:        if (exists $info->{'VarDecl'}) {
45:            my $var = $info->{'VarDecl'}{'Name'};
67:            	    	$info->{'Deleted'}=1;
75:                push @{$info->{'Ann'}}, annotate($f, __LINE__  );             

Refactoring/IncludeFiles.pm
80:		if ( exists $info->{'Common'} ) {
83:		if ( exists $info->{'VarDecl'} ) {
85:			my $var = $info->{'VarDecl'}{'Name'};			
102:					$info->{'Ref'}++;
107:		if ( exists $info->{'ParamDecl'} ) {
109:            if (exists $info->{'ParamDecl'}{'Name'}) {
110:			my $var_val = $info->{'ParamDecl'}{'Name'};
118:                	$info->{'Ref'}++;
119:                    $info->{'ParamDecl'}=[$gvar];    
122:            } elsif (exists $info->{'ParamDecl'}{'Names'}) { #die $line.Dumper($info);
123:                for my $var_val (@{ $info->{'ParamDecl'}{'Names'} }) {
131:                	$info->{'Ref'}++;
132:                    $info->{'ParamDecl'}=[$gvar];    
141:		if ( exists $info->{'Implicit'} ) {
144:		    $info->{'Comments'}=1;

Refactoring/Modules.pm

129:						if ( exists $info->{'VarDecl'} ) {
130:							my $ref_vardecl_line = emit_f95_var_decl( get_var_record_from_set( $stref->{'Modules'}{ $existing_module_name{$src} }{'Vars'}, $info->{'VarDecl'}{'Name'} ) );
132:						} elsif ( exists $info->{'Use'} and $info->{'Use'}{'Inlineable'} == 1 ) {
142:					my $merged_annlines = splice_additional_lines_cond( $stref, $existing_module_name{$src}, sub { ( my $annline ) = @_; ( my $line, my $info ) = @{$annline}; return exists $info->{'Contains'} }, $old_annlines, $new_annlines, 0, 0, 1 );
273:				if ( exists $info->{'Contains'} ) {
348:				if ( exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'} ) {
350:					my $progname = $info->{'Signature'}{'Name'};
449:						if ( exists $info->{'Contains'} ) {
528:						if ( exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'} ) {
530:							my $progname = $info->{'Signature'}{'Name'};

Refactoring/Streams.pm
161:		if (exists $info->{'Assignment'} ) {
163:			if (scalar @{ $info->{'Rhs'}{'VarList'}{'List'} } == 1 and $info->{'Rhs'}{'VarList'}{'List'}[0]=~/_ptr/) {
170:				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Rhs'}{'ExpressionAST'},'In');
171:				 $info->{'Rhs'}{'ExpressionAST'}=$ast;
175:				$info->{'Rhs'}{'VarList'}{'Set'}=$vars;
176:				$info->{'Rhs'}{'VarList'}{'List'}= [ grep {$_ ne 'IndexVars' and $_ ne '_OPEN_PAR_' } sort keys %{$vars} ];
178:				 	$info->{'Rhs'}{'VarList'}={'List'=>[],'Set'=>{}};
181:			if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array') {
183:				(my $ast, $state) = _rename_ast_entry($stref, $f,  $state, $info->{'Lhs'}{'ExpressionAST'}, 'Out');
184:				$info->{'Lhs'}{'ExpressionAST'}=$ast;
186:				$info->{'Lhs'}{'VarName'} = $stream_var;
187:				$info->{'Lhs'}{'ArrayOrScalar'} = 'Scalar';
189:			$state->{'IndexVars'}={ %{$state->{'IndexVars'} }, %{ $info->{'Lhs'}{'IndexVars'}{'Set'} } };
190:			for my $var ( @{ $info->{'Rhs'}{'VarList'}{'List'} } ) {
192:				if ($info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Type'} eq 'Array' and exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'}) {					
193:					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'} } }
197:		if (exists $info->{'If'} ) {					
198:			my $cond_expr_ast = $info->{'CondExecExprAST'};
201:			$info->{'CondExecExpr'}=$ast;
202:			for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
204:				if ($info->{'CondVars'}{'Set'}{$var}{'Type'} eq 'Array' and exists $info->{'CondVars'}{'Set'}{$var}{'IndexVars'}) {	
205:					$state->{'IndexVars'}={ %{ $state->{'IndexVars'} }, %{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} } }
211:				$info->{'CondVars'}{'Set'}=$vars;
212:				$info->{'CondVars'}{'List'}= [ grep {$_ ne 'IndexVars' and $_ ne '_OPEN_PAR_' } sort keys %{$vars} ];
214:				 	$info->{'CondVars'}={'List'=>[],'Set'=>{}};
297:		if (exists $info->{'Signature'} ) { 			
300:			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
307:			$info->{'Signature'}{'Args'}{'List'}=$new_args;
308:			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
310:		} elsif (exists $info->{'VarDecl'} ) {
311:			my $var = $info->{'VarDecl'}{'Name'};
314:				if (exists $info->{'ParsedVarDecl'}) {
315:					$info->{'ParsedVarDecl'}{'StreamVars'}=$state->{'StreamVars'}{$var}{'Set'}; # Every streamvar derived from var has the same type
316:					$info->{'ParsedVarDecl'}{'Vars'}=$vars;
317:					delete $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'};
319:					if (exists $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'} ) {
320:						delete $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'};
371:		if (exists $info->{'Assignment'} ) {
372:			my $lhs_var = $info->{'Lhs'}{'VarName'};
375:				$info->{'Deleted'}=1;
376:	  			my $rhs_vars = $info->{'Rhs'}{'VarList'}{'Set'};
380:		} elsif (exists $info->{'SubroutineCall'} ) {
381:			for my $arg ( @{ $info->{'SubroutineCall'}{'Args'}{'List'} } ){
384:					$info->{'Deleted'}=1;
385:		  			my $args = $info->{'SubroutineCall'}{'Args'}{'Set'};
393:		elsif (exists $info->{'VarDecl'}) {
394:			my $decl_var = $info->{'VarDecl'}{'Name'};
398:				$info->{'Deleted'}=1;	    			  
406:		elsif (exists $info->{'Signature'} ) {
408:			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {				
418:			$info->{'Signature'}{'Args'}{'List'}=$new_args;
420:			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
478:		if (exists $info->{'Signature'} ) {
484:			exists $info->{'VarDecl'} and exists $info->{'ParsedVarDecl'}{'StreamVars'}
487:			my $tvar_rec = $info->{'ParsedVarDecl'};
493:				'Indent' => $info->{'Indent'},
502:				my $orig_name =$info->{'VarDecl'}{'Name'}; 
503:				$info->{'VarDecl'}{'Name'}=$tvar;
504:				$info->{'VarDecl'}{'OrigName'}=$orig_name;
518:		} elsif (exists $info->{'Assignment'} ) {
522:		} elsif (exists $info->{'If'} ) {
527:			if ( exists $info->{'PlaceHolders'} ) { 
530:					my $ph_str = $info->{'PlaceHolders'}{$ph};
534:            $info->{'Ref'}++;
561:		if ( exists $info->{'SubroutineCall'} and 
562:			not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
564:				my $subname = $info->{'SubroutineCall'}{'Name'};
640:		if ( exists $info->{'SubroutineCall'} and 
641:			not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
643:				my $subname = $info->{'SubroutineCall'}{'Name'};
648:			for my $sig_arg (keys %{$info->{'SubroutineCall'}{'ArgMap'} }) {
649:				my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
653:					if ($info->{'CallArgs'}{'Set'}{$call_arg}{'Expr'} eq $call_arg.'(1)') {
654:						$info->{'CallArgs'}{'Set'}{$call_arg}{'Expr'} = $call_arg;
674:	      	    my $indent = $info->{'Indent'} // '      ';
675:		    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
676:		    my @new_call_exprs = map  { $info->{'CallArgs'}{'Set'}{$_}{'Expr'} } @{$info->{'CallArgs'}{'List'}};  
680:		    $info->{'SubroutineCall'}{'ExpressionAST'}=$updated_expr_ast;
709:		if ( exists $info->{'SubroutineCall'} and 
710:			not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
712:				my $subname = $info->{'SubroutineCall'}{'Name'};
775:		if ( exists $info->{'VarDecl'} ) {
776:			my $var = $info->{'VarDecl'}{'Name'};
854:	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
856:	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};
858:	my $rline = $info->{'Indent'}.$lhs.' = '.$rhs;
859:	if (exists $info->{'If'}) {
868:	my $cond_expr_ast=$info->{'CondExecExpr'};
870:	my $rline = $info->{'Indent'}.'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? 'then' : '');	
880:	    my $name = $info->{'SubroutineCall'}{'Name'};
882:	my $new_arg_map = $info->{'SubroutineCall'}{'ArgMap'} ;
885:      my $orig_call_args = $info->{'CallArgs'}{'List'};
899:      			delete $info->{'CallArgs'}{'Set'}{$call_arg};
900:      			map { $info->{'CallArgs'}{'Set'}{$_} = {'Expr' => $_,'Type'=>'Scalar'} } @{$stref->{'Subroutines'}{$name}{'StreamVars'}{$current_sig_arg}{'List'} };
901:      			delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};      	
903:      				$info->{'SubroutineCall'}{'ArgMap'}{$stream_arg}=$stream_arg;
911:      		delete $info->{'CallArgs'}{'Set'}{$call_arg};
912:      		delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
915:      $info->{'CallArgs'}{'List'}=$new_call_args;      
922:	    my $indent = $info->{'Indent'} // '      ';
923:	    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
924:	    my @new_call_exprs = map  { $info->{'CallArgs'}{'Set'}{$_}{'Expr'} } @{$new_call_args};  
928:	    $info->{'SubroutineCall'}{'ExpressionAST'}=$updated_expr_ast;
935:		if ( exists $info->{'PlaceHolders'} ) { 
938:				my $ph_str = $info->{'PlaceHolders'}{$ph};
941:            $info->{'Ref'}++;
943:	    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
961: 		if ( exists $info->{'Signature'} ) {
962: 			$state->{'Args'} = $info->{'Signature'}{'Args'}{'Set'}; 
964: 		elsif (exists $info->{'Select'})  {
965: 			my $select_expr_str = $info->{'CaseVar'}; 
973:		elsif (exists $info->{'CaseVals'})  {
974:			for my $val (@{ $info->{'CaseVals'} }) {
987:		elsif ( exists $info->{'VarDecl'} ) {
988:			$state->{'DeclaredVars'}{ $info->{'VarDecl'}{'Name'}}=1;
990:		elsif ( exists $info->{'Assignment'}  ) {
992:			my $var = $info->{'Lhs'}{'VarName'};
999:				if (exists $info->{'Lhs'}{'IndexVars'}) {
1000:					for my $var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
1011:				if (exists $info->{'Lhs'}{'IndexVars'}) {
1013:					for my $var (keys %{ $info->{'Lhs'}{'IndexVars'}{'Set'} }) {
1018:				for my $var (keys %{$info->{'Rhs'}{'VarList'}{'Set'} }) {
1021:				for my $var (keys %{  $info->{'Rhs'}{'VarList'}{'Set'} } ) {
1022:					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'}) {
1024:						for my $var (keys %{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'} }) {
1028:					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'}) {
1030:						for my $var (keys %{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'} }) {
1037:		elsif ( exists $info->{'SubroutineCall'} ) {
1039:			for my $var (keys %{ $info->{'SubroutineCall'}{'Args'}{'Set'} }) {
1043:		if (exists $info->{'If'} and not $skip_if) {						
1044:				my $cond_expr_ast=$info->{'CondExecExprAST'};#= $ast;parse_expression($info->{'CondExecExpr'}, $info,$stref, $f);
1046:			for my $var (keys %{ $info->{'CondVars'}{'Set'} }) {
1051:				for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
1053:					if (exists  $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} ) {							
1055:						for my $var (keys %{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} }) {
1111:		if ( exists $info->{'VarDecl'} ) {		
1112:			my $var = $info->{'VarDecl'}{'Name'};
1120:		elsif ( exists $info->{'Signature'} ) {
1122:			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
1130:			$info->{'Signature'}{'Args'}{'List'}=$new_args;
1132:			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };			
1163: 		if ( exists $info->{'Signature'} ) {
1164: 			$state->{'Args'} = $info->{'Signature'}{'Args'}{'Set'}; 
1166: 		elsif (exists $info->{'Select'})  {
1167: 			my $select_expr_str = $info->{'CaseVar'}; 
1172:		elsif (exists $info->{'CaseVals'})  {
1173:			for my $val (@{ $info->{'CaseVals'} }) {
1183:		elsif ( exists $info->{'VarDecl'} ) {
1184:			$state->{'DeclaredVars'}{ $info->{'VarDecl'}{'Name'}}=1;
1186:		elsif ( exists $info->{'Assignment'}  ) {
1188:			my $var = $info->{'Lhs'}{'VarName'};
1191:				if (exists $info->{'Lhs'}{'IndexVars'}) {
1192:					$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Lhs'}{'IndexVars'}{'Set'} } };
1194:				$state->{'ExprVars'} ={ %{ $state->{'ExprVars'} }, %{ $info->{'Rhs'}{'VarList'}{'Set'} } };
1195:				for my $var (keys %{  $info->{'Rhs'}{'VarList'}{'Set'} } ) {
1196:					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'}) {
1197:						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'Vars'} }};
1199:					if (exists $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'}) {
1200:						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'Rhs'}{'VarList'}{'Set'}{$var}{'IndexVars'} }};
1204:		elsif ( exists $info->{'SubroutineCall'} ) {
1205:			$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{$info->{'SubroutineCall'}{'Args'}{'Set'} } };
1207:		if (exists $info->{'If'} ) {						
1208:				my $cond_expr_ast=$info->{'CondExecExprAST'};#= $ast;parse_expression($info->{'CondExecExpr'}, $info,$stref, $f);
1209:				$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'} } }; 
1210:				for my $var ( @{ $info->{'CondVars'}{'List'} } ) {
1212:					if (exists  $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} ) {							
1213:						$state->{'ExprVars'} ={%{$state->{'ExprVars'}},%{ $info->{'CondVars'}{'Set'}{$var}{'IndexVars'} } };
1270:		if (exists $info->{'Assignment'} ) { 
1272:			my $var = $info->{'Lhs'}{'VarName'};
1277:				for my $rhs_var (@{ $info->{'Rhs'}{'VarList'}{'List'} } ) {
1300:		if (exists $info->{'VarDecl'} and $pass_state->{'Once'}==0 ) { 
1307:				'Indent' => $info->{'Indent'},
1319:				  'Indent' => $info->{'Indent'},
1350: 		if ( exists $info->{'Signature'} ) {
1352:			for my $arg (@{ $info->{'Signature'}{'Args'}{'List'} } ) {
1368:			$info->{'Signature'}{'Args'}{'List'}=$new_args;
1369:			$info->{'Signature'}{'Args'}{'Set'} = { map {$_=>1} @{$new_args} };
1377:		elsif ( exists $info->{'VarDecl'} ) {
1381:			my $var= $info->{'VarDecl'}{'Name'};
1388:				$info->{'VarDecl'}{'Name'}=$new_arg;
1389:  				$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} = [];
1390:    			$info->{'ParsedVarDecl'}{'Attributes'}{'Vars'} = [$new_arg]; 					
1398:		elsif ( exists $info->{'Assignment'}  ) {
1399:			my $var = $info->{'Lhs'}{'VarName'};
1400:			my $rhs_ast = $info->{'Rhs'}{'ExpressionAST'};
1439:		if ( exists $info->{'SubroutineCall'} and not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} } ) {
1441:	    	my $name = $info->{'SubroutineCall'}{'Name'};
1447:			for my $sig_arg (keys %{$info->{'SubroutineCall'}{'ArgMap'} }) {
1448:				my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
1458:						$info->{'CallArgs'}{'Set'}{$call_arg} = {'Expr' => $call_arg.'(1)','Type'=>'Scalar'};
1460:						$info->{'CallArgs'}{'Set'}{$call_arg} = {'Expr' => $call_arg,'Type'=>'Array'};
1466:			$info->{'SubroutineCall'}{'ArgMap'} = $new_arg_map;	
1469:	      my $orig_call_args = $info->{'CallArgs'}{'List'};
1485:	      		delete $info->{'CallArgs'}{'Set'}{$call_arg};
1486:	      		delete $info->{'SubroutineCall'}{'ArgMap'}{$call_arg};
1489:	      $info->{'CallArgs'}{'List'}=$new_call_args;
1491:	      	    my $indent = $info->{'Indent'} // '      ';
1492:		    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
1493:		    my @new_call_exprs = map  { $info->{'CallArgs'}{'Set'}{$_}{'Expr'} } @{$new_call_args};  
1497:		    $info->{'SubroutineCall'}{'ExpressionAST'}=$updated_expr_ast;
1531:	if ( exists $info->{'VarDecl'} ) {
1535:			my $var= $info->{'VarDecl'}{'Name'};
1538:			if (exists $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}
1539:			and scalar @{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} } > 0
1541:				my $dim_parse_str = '('.join(',',@{ $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'} }).')';

Refactoring/Subroutines/IncludeStatements.pm
40:    my $inc       = $info->{'Include'}{'Name'};
69:            $info->{'Ann'} = [annotate($f, __LINE__  )];
70:            $info->{'Include'}{'Name'} = $inc;
71:            $info->{'Ref'}=1;
72:            if ($info->{'ExGlobArgDecls'} >= $Sf->{'ExGlobVarDeclHook'}) {
73:                $info->{'ExGlobArgDecls'} = ++$Sf->{'ExGlobVarDeclHook'};

Refactoring/Subroutines/Signatures.pm
43:    if (not exists $info->{'EntrySig'} ) {
47:    	my $name = $info->{'Signature'}{'Name'};
72:    } elsif ( exists $info->{'EntrySig'} ) {
73:    	my $name = $info->{'Signature'}{'Name'};
82:    $info->{'Refactored'} = 1;
83:    $info->{'Ref'} = 1;
84:    $info->{'Signature'}{'Args'}=$Sf->{'RefactoredArgs'};
85:    $info->{'Signature'}{'RefactoredArgs'}=$Sf->{'RefactoredArgs'}; # not sure if this is needed

Refactoring/Subroutines.pm
187:            	$info->{'EndBlockData'}=1;
227:    	$info->{'Ref'}++;
300:        if ( exists $info->{'Signature'} ) {
319:        if ( exists $info->{'Include'} ) {
324:			  my $inc       = $info->{'Include'}{'Name'};
328:			  	$info->{'Include'}{'Name'}=$param_inc;
331:			  	delete $info->{'Includes'};
332:			  	$info->{'Ann'}=[  annotate($f, __LINE__) ];                    			  	
342:        if ( exists $info->{'Use'} ) {
343:        	if( exists $info->{'Use'}{'Inlineable'} and $info->{'Use'}{'Inlineable'}==1) {
351:        if ($inc_counter==0 and  not exists $info->{'Include'} and $hook_after_last_incl==1) {
352:        	$info->{'ExGlobVarDeclHook'} = 'AFTER LAST Include via _refactor_globals_new() line ' . __LINE__; 
356:        if ( exists $info->{'ExGlobVarDeclHook'} ) {        	
364:        if ( exists $info->{'SubroutineCall'} ) {         	
370:        if ( exists $info->{'FunctionCalls'} ) {        	        	
403:                    $info->{'Ann'}=[ annotate($f, __LINE__ .' : INHERITED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];                                               
404:                    $info->{'LineID'}= $nextLineID++;
405:                    $info->{'Ref'}=1;
406:                    $info->{'ParamDecl'}={'Name' => $par};
428:                    $info->{'Ann'}=[ annotate($f, __LINE__ .' : INCLUDED PARAM ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];                                               
429:                    $info->{'LineID'}= $nextLineID++;
430:                    $info->{'Ref'}=1;
431:                    $info->{'ParamDecl'}={'Name' => $par};
454:                    $info->{'Ann'}=[ annotate($f, __LINE__ .' : EX-GLOB ' . $annline->[1]{'ExGlobVarDeclHook'} ) ];                                               
455:                    $info->{'LineID'}= $nextLineID++;
456:                    $info->{'Ref'}=1;
457:                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
468:                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-INCL' ) ];
469:                    $info->{'LineID'}= $nextLineID++;
470:                    $info->{'Ref'}=1;
471:                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
517:	                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT')  ];
518:	                    $info->{'LineID'}= $nextLineID++;
519:	                    $info->{'Ref'}=1;
520:	                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
533:                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-INCL VAR' ) ];
534:                    $info->{'LineID'}= $nextLineID++;
535:                    $info->{'Ref'}=1;
536:                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
572:                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT VAR') ];                    
573:                    $info->{'LineID'}= $nextLineID++;
574:                    $info->{'Ref'}=1;
575:                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
590:                    $info->{'Ann'}=[annotate($f, __LINE__ .' : EX-IMPLICIT COMMON')  ];
591:                    $info->{'LineID'}= $nextLineID++;
592:                    $info->{'Ref'}=1;
593:                    $info->{'VarDecl'}={'Name' => $var};#$rdecl;
612:    my $name = $info->{'SubroutineCall'}{'Name'};
622:    for my $call_arg (@{ $info->{'SubroutineCall'}{'Args'}{'List'} }) {
623:        if (exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'} ) {
624:        	push @orig_args , $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Expr'};
645:        	if (not exists  $info->{'SubroutineCall'}{'Args'}{'Set'}{$ex_glob} ) {
661:        $info->{'SubroutineCall'}{'Args'}{'List'}= $args_ref;
664:	    my $indent = $info->{'Indent'} // '      ';
665:	    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
668:		if ( exists $info->{'PlaceHolders'} ) { 
671:				my $ph_str = $info->{'PlaceHolders'}{$ph};
674:            $info->{'Ref'}++;
676:	    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
688:	    my $name = $info->{'SubroutineCall'}{'Name'};
690:		my $args_ref = $info->{'SubroutineCall'}{'Args'}{'List'};
692:	    my $indent = $info->{'Indent'} // '      ';
693:	    my $maybe_label= ( exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}} ) ?  $info->{'Label'}.' ' : '';
696:		if ( exists $info->{'PlaceHolders'} ) { 
699:				my $ph_str = $info->{'PlaceHolders'}{$ph};
702:            $info->{'Ref'}++;
704:	    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
713:	    my $name = $info->{'Signature'}{'Name'};
715:		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
717:	    my $indent = $info->{'Indent'} // '      ';	    
720:		if ( exists $info->{'PlaceHolders'} ) { 
723:				my $ph_str = $info->{'PlaceHolders'}{$ph};
726:            $info->{'Ref'}++;
728:	    $info->{'Ann'}=[annotate($f, __LINE__ ) ];
741:		if (exists $info->{'Assignment'} ) {
742:			$ast= $info->{'Rhs'}{'ExpressionAST'};
743:		} elsif ( exists $info->{'SubroutineCall'} ) {
744:			$ast = $info->{'SubroutineCall'}{'ExpressionAST'}
754:		if ( exists $info->{'PlaceHolders'} ) { 
758:				my $ph_str = $info->{'PlaceHolders'}{$ph};
761:            $info->{'Ref'}++;
763:		if (exists $info->{'Assignment'} ) {
789:		} elsif (exists $info->{'SubroutineCall'}) {


CTranslation.pm
82:				if (exists $info->{'Signature'} ) {
95:				elsif (exists $info->{'SubroutineCall'} and 
96:					not exists $stref->{'ExternalSubroutines'}{ $info->{'SubroutineCall'}{'Name'} }
98:						my $subname = $info->{'SubroutineCall'}{'Name'};
102:					for my $sig_arg (keys %{$info->{'SubroutineCall'}{'ArgMap'} }) {
103:						my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
104:						my $call_arg_expr =  $info->{'CallArgs'}{'Set'}{$call_arg}{'Expr'};
149:		if (exists $info->{'Signature'} ) {
155:		elsif (exists $info->{'VarDecl'} ) {
157:				my $var = $info->{'VarDecl'}{'Name'};
166:					if (exists $info->{'TrailingComment'} and $info->{'TrailingComment'}=~/\$ACC\s+MemSpace\s+(\w+)/) {		
184:		elsif ( exists $info->{'ParamDecl'} ) {
185:				my $var = $info->{'VarDecl'}{'Name'};
189:		elsif (exists $info->{'Select'} ) {				
190:			my $switch_expr = _emit_expression_C(['$',$info->{'CaseVar'}],'',$stref,$f);
193:		elsif (exists $info->{'Case'} ) {
196:			if ($info->{'Case'}>1) {
197:				$c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.$c_line;
200:		elsif (exists $info->{'CaseDefault'}) {
201:			$c_line = $info->{'Indent'}."} break;\n".$info->{'Indent'}.'default : {';
203:		elsif (exists $info->{'Do'} ) { #say $line.Dumper($info->{Expressions});
213:				$info->{'Do'}{'Iterator'}.' = '.$info->{'Do'}{'Range'}{'Expressions'}[0] .';'. 
214:				$info->{'Do'}{'Iterator'}.' <= '.$info->{'Do'}{'Range'}{'Expressions'}[1] .';'.
215:				$info->{'Do'}{'Iterator'}.' += '.$info->{'Do'}{'Range'}{'Expressions'}[2] .') {'; 
217:		elsif (exists $info->{'BeginDo'} ) {
220:		if (exists $info->{'Assignment'} ) {
223:		elsif (exists $info->{'SubroutineCall'} ) {
225:			my $subcall_ast = $info->{'SubroutineCall'}{'ExpressionAST'};
236:				$c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,'',$stref,$f).';';
243:				$c_line = $info->{'Indent'}."${qual}_id = get_${qual}_id(0);";
245:				$c_line = $info->{'Indent'}._emit_expression_C($subcall_ast,'',$stref,$f).';';
248:		elsif (exists $info->{'If'} ) {				
251:		elsif (exists $info->{'ElseIf'} ) {		
254:		elsif (exists $info->{'Else'} ) {		
257:		elsif (exists $info->{'EndDo'} or exists $info->{'EndIf'}  or exists $info->{'EndSubroutine'} ) {
260:		elsif (exists $info->{'EndSelect'} ) {
261:				 $c_line = '    }'."\n".$info->{'Indent'}.'}';
264:		elsif (exists $info->{'Comments'} ) {
268:		elsif (exists $info->{'Use'}) {
280:		exists $info->{'ImplicitNone'} or
281:		exists $info->{'Implicit'}		
285:		elsif (exists $info->{'Include'} ) {
289:		elsif (exists $info->{'Goto'} ) {
292:		elsif (exists $info->{'Continue'}) {
295:		if (exists $info->{'Label'} ) {
296:			$c_line = $info->{'Label'}. ' : '."\n".$info->{'Indent'}.$c_line;
299:		push @{$pass_state->{'TranslatedCode'}},$info->{'Indent'}.$c_line unless $skip;
344:	    my $name = $info->{'Signature'}{'Name'};
346:		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
420:	my $lhs_ast =  $info->{'Lhs'}{'ExpressionAST'};
431:	my $rhs_ast =  $info->{'Rhs'}{'ExpressionAST'};	
451:	my $rline = $info->{'Indent'}.$lhs.' = '.$rhs_stripped;
452:	if (exists $info->{'If'}) {
462:	my $cond_expr_ast=$info->{'CondExecExprAST'};	
467:	my $rline = 'if ('.$cond_expr.') '. (exists $info->{'IfThen'} ? '{' : '');		

OpenCLTranslation.pm
97:		if (exists $info->{'Select'})  {
98:			 $case_var =$info->{'CaseVar'};
99:			 } elsif (exists $info->{'CaseDefault'})  {
103:			 } elsif (exists $info->{'Case'})  {
108:			if (scalar @{$info->{'CaseVals'}}==1) {
109:				$cond_str.=$info->{'CaseVals'}[0];
112:				for my $case_val ( @{$info->{'CaseVals'}} ) {
119:		if (exists $info->{'EndSelect'})  {
124:        if ( exists $info->{'ParsedVarDecl'}
125:            and lc($info->{'ParsedVarDecl'}{'Attributes'}{'Intent'}) eq 'in'
126:            and $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}->[0] eq '0' )
128:            for my $var_name ( @{ $info->{'ParsedVarDecl'}{'Vars'} } ) {
134:        if (    exists $info->{'Use'} ) {
135:            my $inlined_mod_name = $info->{'Use'}{'Name'};  
161:        push @{$refactored_annlines}, $annline unless exists $info->{'Comments'};
179:        if (exists $info->{'If'} and exists $next_info->{'EndIf'}) {            
183:        if (exists $info->{'Do'} and exists $next_info->{'EndDo'}) {            
263:        if (    exists $info->{'Use'}
264:            and exists $info->{'Use'}{'Inlineable'} )
266:            my $inlined_mod_name = $info->{'Use'}{'Name'};
271:            if (   exists $info->{'ParsedVarDecl'}
272:                or exists $info->{'ParsedParDecl'} )
296:        if (    exists $info->{'Use'}
297:            and exists $info->{'Use'}{'Inlineable'} )
299:            my $inlined_mod_name = $info->{'Use'}{'Name'};
304:            if (exists $info->{'EndModule'}) { next; } 
433:        exists $info->{'Open'} or
434:        exists $info->{'Print'} or
435:        exists $info->{'Write'} or
436:        exists $info->{'Read'} or
437:        exists $info->{'Close'};
442:        exists $info->{'Return'};

## Emitter 

Emitter.pm
170:				if (exists $info->{'Blank'}
171:				or exists $info->{'Skip'}
172:				or exists $info->{'Deleted'}

-----

Parser/Expressions.pm
261:    $info->{'FunctionCalls'}{$mvar}=1;
Refactoring/Common.pm
500:    $info->{'ExGlobVarDeclHook'}='VarDecl'| 'AFTER LAST ParamDecl'| 'AFTER LAST Include'| 'Signature';
Refactoring/IncludeFiles.pm
119:    $info->{'ParamDecl'}=[$gvar];
Refactoring/Subroutines/IncludeStatements.pm
73:     $info->{'ExGlobArgDecls'} = ++$Sf->{'ExGlobVarDeclHook'};
Refactoring/Subroutines.pm
187:    $info->{'EndBlockData'}=1;
352:    $info->{'ExGlobVarDeclHook'} = 'AFTER LAST Include via _refactor_globals_new() line ' . __LINE__;
-----

SrcReader

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


 'Case'  = ++$case_counter;				
 'Control'  = 1;			
 'End' . $kw  = {;
 'End' . ucfirst($kw)  = { 'Name' => $name ;
 'EndControl'  = 1;		
 'IfThen'  = 1;						
 ucfirst($keyword)  = 1;
 ucfirst($keyword)  = 1; # 'If'	
 ucfirst($keyword) . 'Call'  = 1;
$target{'Label' = $label;
'AccPragma'{ $pragma_name_prefix . ucfirst( lc($pragma_name) )  = [@pragma_args];
'AccPragma'{'BeginKernel') {
'AccPragma'{'BeginKernelSub' ) {
'AccPragma'{'BeginKernelWrapper' ) {
'AccPragma'{'BeginSubroutine' ) { 
'AccPragma'{'EndKernel') {
'AccPragma'{'EndKernelSub' ) {
'AccPragma'{'EndKernelWrapper' ) {
'AccPragma'{'EndSubroutine' ) {
'Assign'={'Label' => $label, 'Var' => $var;
'Assignment'
'Assignment'{'Lhs'{'VarName';
'Ast' = $ast;
'Ast'{'IOStat' eq $var) {
'BeginBlock'{'Name' = $block;
'BeginDo'{'Label' = $label;
'Blank'
'Block'= $block;
'Block'{'Nest';
'Break' ) {
'CallArgs'               = $expr_args;
'CallArgs' = { 'List' => [], 'Set' => { ;
'CallArgs'{'Set'{$_ = {'Expr' => $_,'Type'=>'Scalar'  @{$stref->{'Subroutines'{$name{'StreamVars'{$current_sig_arg{'List' ;
'CallArgs'{'Set'{$_{'Expr'  @{$new_call_args;  
'CallAttrs' = { 'Set' => {, 'List' => [] ;
'CallAttrs'{'Set'{$call_attr = { 'Type' => $type ;
'Case')  {
'CaseDefault' = 1;
'CaseVals' = [@case_vals];
'CaseVar' = $1;
'Close';
'CloseCall'# IO
'Comments'
'Common' = { 'Name' => $common_block_name , 'Vars' => 
'Common'{'Vars'{'List'  ) {
'CondExecExpr'=$ast;
'CondExecExprAST'= $ast;
'CondVars'={'List'=>[],'Set'=>{;
'CondVars'{'Set' = $vars_in_cond_expr;
'CondVars'{'Set'{$var{'IndexVars'  
'Contains' , $old_annlines, $new_annlines, 0, 0, 1 );
'Continue'={'Label' => $cont_label;
'Data' = 1;
'DeadCode'=1;
'Deleted'
'Dimension'=1;
'Do';					
'Do'{'Iterator';
'Do'{'Label' = $label;
'Do'{'Label' eq 'LABEL_NOT_DEFINED') {
'Do'{'Label';
'Do'{'Range'{'Expressions'[$i]=~s/\b$lc_macro\b/$macro/g;
'Do'{'Range'{'Vars'  ) {
'Do'{'Range'{'Vars'  );
'Else' = 1;			
'ElseIf' = 1;					
'End'.$unit_type =$unit_name; 
'EndBlock'{'Name' = $block;			
'EndBlockData'=1;
'EndControl'= 1;				 
'EndDo'{'Count' =
'EndDo'{'Label' = $label;
'EndDo'{'Label';
'EndDo'{'LineID'
'EndIf') {            
'EndModule') { next;  # FIXME! This should be done when extracting the subroutines! 
'EndSelect' ) {
'EndSubroutine' ) {
'Entry'=1; # FIXME
'EntrySig' = $name;                
'Equivalence' = 1;
'ExGlobArgDecls' = ++$Sf->{'ExGlobVarDeclHook';
'ExGlobArgDecls' >= $Sf->{'ExGlobVarDeclHook') {
'ExGlobArgDecls';
'ExGlobVarDeclHook' ) {        	
'ExGlobVarDeclHook'='AFTER LAST Include';
'ExGlobVarDeclHook'='AFTER LAST ParamDecl';
'ExGlobVarDeclHook'='Signature';
'ExGlobVarDeclHook'='VarDecl';
'ExprVars'               = $expr_other_vars;
'ExprVars' = { 'List' => [], 'Set' => { ;
'External'  ) {
'FileNameVar' =
'Format'=1;
'FunctionCalls' ) {        	        	
'FunctionCalls'{$mvar=1;
'FunctionSig' = [ $spaces, $name, [] ];
'Goto'{'Label' = $label;
'IO'=1;
'If'  ) {
'IfThen' ? 'then' : '');	
'Implicit'		
'ImplicitNone' = 1;
'InBlock'{'Name' = $block;
'InBlock'{'Name' ne $f )
'Include' = {;
'Include'{'InclType' eq 'Parameter' ) {
'Include'{'Name' = $inc;
'Include'{'Name' = $name;
'Include'{'Name';
'Include'{'Name'=$param_inc;
'Includes'
'Indent',
'InquireCall' 
'Label' = $label;
'Lhs'{'ArrayOrScalar' = 'Scalar';
'Lhs'{'ExpressionAST') eq 'ARRAY' 
'Lhs'{'IndexVars'{'List';
'Lhs'{'IndexVars'{'Set'  ;
'Lhs'{'VarName' = $stream_var;
'LineID'
'Macro'=1;	
'Module' = $name;
'Namelist'=$namelist_group_name; 				
'NoopBreakTarget'
'NoopTarget' )
'Open' or
'OuterLoopEnd' eq $kernelwrapper )
'OuterLoopStart'
'OuterLoopStart' = $kernelwrapper;
'OuterLoopStart' eq $kernelwrapper )
'ParamDecl' = $param_decl;
'ParamDecl'=[$gvar];    
'ParamDecl'={'Name' => $par;
'ParamDecl'{'Names') { #die $line.Dumper($info);
'ParsedParDecl' = $pt; #WV20150709 currently used by OpenCLTranslation, TODO: use ParamDecl
'ParsedVarDecl'
'ParsedVarDecl'{'Attributes'{'Dim' = [];
'ParsedVarDecl'{'Attributes'{'Intent') eq 'in'
'ParsedVarDecl'{'Attributes'{'Vars' = [$new_arg]; 					
'ParsedVarDecl'{'StreamVars'
'ParsedVarDecl'{'StreamVars'=$state->{'StreamVars'{$var{'Set'; # Every streamvar derived from var has the same type
'ParsedVarDecl'{'Vars'=$vars;
'PlaceHolders' = $phs_ref
'Pragma'=1;		
'Print' or
'PrintCall'# IO
'Read' or
'ReadCall'
'Ref' = 1; 
'Refactored' = 1;
'RefactoredSubroutineCall'{'Name' = $block;
'Removed'=1;
'Return';
'Rhs' = {
'Rhs'{'ExpressionAST','');
'Rhs'{'VarList'={'List'=>[],'Set'=>{;
'Select')  {
'Signature'{'Args'=$Sf->{'RefactoredArgs';
'Signature'{'Args'{'List';
'Signature'{'Args'{'Set'  = { map { $_ => 1  @args ;
'Signature'{'BlockData'      = 1;				
'Signature'{'Entry' = 1;
'Signature'{'Function' = 1;
'Signature'{'Name'         = $name;
'Signature'{'Program'      = 1;
'Signature'{'RefactoredArgs'=$Sf->{'RefactoredArgs'; # not sure if this is needed
'Skip'=1; 
'StmtCount'); 
'StmtCount'{$tvar = $Sf->{'DeclCount'{$tvar;
'SubroutineCall'
'SubroutineCall'{'ArgMap' ) {
'SubroutineCall'{'ArgMap'{$sig_arg = $call_arg_expr;
'SubroutineCall'{'Args'{'List'  ) {			
'SubroutineCall'{'Args'{'List'= $args_ref;
'SubroutineCall'{'Args'{'Set'=  $stref->{'Subroutines'{$name{'DeclaredOrigArgs'{'Set';
'SubroutineCall'{'Args'{'Set'{$call_arg{'Expr' ) {
'SubroutineCall'{'ExpressionAST'
'SubroutineCall'{'IsExternal' )
'SubroutineCall'{'Name' = $name;
'SubroutineCall'{'Name';			 	
'SubroutineCall'{'RefactoredArgs';
'SubroutineSig' = [ $spaces, $name, [] ];
'TrailingComment' = $cline;
'Use' = $module;
'Use'{'Inlineable' )
'Use'{'Name' = $name;
'UsedParameters' = $pars_in_val;
'VarDecl'=$rdecl;
'VarDecl'={'Name' => $var;#$rdecl;
'VarDecl'{'Attr',
'VarDecl'{'FStyle' = 'F77';
'VarDecl'{'Name'=$tvar;
'VarDecl'{'Names' ;
'VarDecl'{'OrigName'=$orig_name;
'Vars'{'List'  ) {
'Vars'{'Set'{ $val  = 1;
'Write' or
'WriteCall'
AccPragma{BeginKernelWrapper)) {
AccPragma{EndKernelWrapper)) {
Assignment==1) {
Deleted ) {
Expressions);
SubroutineCall) {

