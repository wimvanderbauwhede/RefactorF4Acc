# F77 parser
package RefactorF4Acc::Parser;
# 
#   (c) 2010-now Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::State qw( initialise_per_code_unit_tables );
use RefactorF4Acc::CallTree qw( add_to_call_tree );
use RefactorF4Acc::Refactoring::Helpers qw( emit_f95_var_decl get_f95_var_decl stateful_pass_inplace ); 
use RefactorF4Acc::Parser::SrcReader qw( read_fortran_src );
use RefactorF4Acc::Parser::Expressions qw( 
    get_vars_from_expression 
    parse_expression
    parse_expression_no_context  
    get_args_vars_from_expression 
    get_args_vars_from_subcall      
    emit_expr_from_ast 
    get_consts_from_expression
    find_assignments_to_scalars_in_ast
    find_implied_do_in_ast
    find_args_vars_in_ast
    find_vars_in_ast
	_find_consts_in_ast
    );
use RefactorF4Acc::Translation::OpenCLC qw( add_to_C_build_sources );    # OBSOLETE

use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_start_detect );
#use RefactorF4Acc::Analysis::ArgumentIODirs qw(  conditional_assignment_fsm );
use RefactorF4Acc::Analysis::Variables qw( identify_vars_on_line analyse_variables );
use RefactorF4Acc::Analysis::CommonBlocks qw( collect_common_vars_per_block );
use Fortran::F95VarDeclParser qw( parse_F95_var_decl );
use Fortran::ConstructParser qw(
  parse_Fortran_open_call
);  


use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Parser::ISA = qw(Exporter);

@RefactorF4Acc::Parser::EXPORT_OK = qw(
  parse_fortran_src
  refactor_marked_blocks_into_subroutines
  mark_blocks_between_calls
  build_call_graph
  analyse_lines
  initialise_per_code_unit_tables  
);

# -----------------------------------------------------------------------------
# parse_fortran_src() parses the source but does perform only limited context-free analysis
# This routine is recursive
sub parse_fortran_src {
	( my $f, my $stref, my $is_source_file_path ) = @_;  # NOTE $f is not the name of the source but of the sub/func/incl/module.
	 
	# local $V=1;
	say "parse_fortran_src(): PARSING $f" if $V;

## 1. Read the source and do some minimal processsing, unless it's already been done (i.e. for extracted blocks)
	print "parse_fortran_src(): CALL read_fortran_src( $f )\n" if $V;
	$stref = read_fortran_src( $f, $stref, $is_source_file_path );    #
	say "DONE read_fortran_src( $f )" if $V;	
	my $sub_or_incl_or_mod = sub_func_incl_mod( $f, $stref ); # Maybe call this "code_unit()"	
	my $is_incl = $sub_or_incl_or_mod eq 'IncludeFiles' ? 1 : 0;
	my $is_mod = $sub_or_incl_or_mod eq 'Modules' ? 1 : 0;
	if ($is_mod and $is_source_file_path) {		
		$f = $stref->{'SourceFiles'}{$f}{'ModuleName'};
	}
	my $is_external_include =
	  $is_incl ? ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'External' ) : 0;

	say "SRC TYPE for $f: $sub_or_incl_or_mod" if $V;

	if ( 
		$sub_or_incl_or_mod ne 'ExternalSubroutines' 
		and $stref->{$sub_or_incl_or_mod}{$f}{'Status'} != $FILE_NOT_FOUND
		) { 
		my $Sf = $stref->{$sub_or_incl_or_mod}{$f};		
		if (not exists $Sf->{'Entry'} or $Sf->{'Entry'} == 0 ) {

		# OK, time to declare all the variable sets and declaration sets		
		$Sf = initialise_per_code_unit_tables( $Sf, $stref, $f, $is_incl,$is_mod );
		
# Set 'RefactorGlobals' to 0, we only refactor the globals for subs that are kernel targets and their dependencies
		if ( not exists $Sf->{'RefactorGlobals'} ) {
			$Sf->{'RefactorGlobals'} = 0;
		}
		if ( $CFG_refactor_toplevel_globals == 1 ) { 
			print "INFO: set RefactorGlobals=1 for $f\n" if $I;
			$Sf->{'RefactorGlobals'} = 1;
		} 
		
## 2. Parse the type declarations in the source, create a per-target table Vars and a per-line VarDecl list and other context-free stuff
		# NOTE: The Vars set are the *declared* variables, not the *used* ones
		print "ANALYSE LINES of $f\n" if $V;
		$stref = analyse_lines( $f, $stref );
		say "DONE analyse_lines( $f )" if $V;
		say "ANALYSE LOOPS/BREAKS in $f\n" if $V;
		$stref = _identify_loops_breaks( $f, $stref );
		say "DONE _identify_loops_breaks($f)" if $V;
		
## 3. Parse use
		$stref = _parse_use( $f, $stref );
		say  "DONE _parse_use( $f )" if $V;

	## 4. Parse includes
	# NOTE: Apart from simply parsing, this routine also causes IMPLICITs from the include file to be inherited by the parent
		$stref = __add_include_hooks( $f, $stref );

	## 5. Parse subroutine and function calls
		if ( not $is_incl and not $is_mod) {

			# Recursive descent via subroutine calls
		 	$stref->{ParseStack}{$f} = 1;
			$stref = _parse_subroutine_and_function_calls( $f, $stref );
			$stref->{$sub_or_incl_or_mod}{$f}{'Status'} = $PARSED;
			delete $stref->{ParseStack}{$f};
			print "DONE PARSING $sub_or_incl_or_mod $f\n" if $V;

		} elsif ($is_incl) {    # includes
			$stref->{'IncludeFiles'}{$f}{'Status'} = $PARSED;
		} else {						
			$stref->{'Modules'}{$f}{'Status'} = $PARSED;			
		}

		} else {
			say "INFO: SKIPPING ENTRY $f" if $I;
		}
	} else {
		print "INFO: $f is EXTERNAL\n" if $I;
		if ($stref->{$sub_or_incl_or_mod}{$f}{Status} == $FILE_NOT_FOUND) {
			warning("No source file for $f\n\tIf this is an external file please provide the path in EXTSRCDIRS in the config file",1);
		};
	}

	print "LEAVING parse_fortran_src( $f ) with Status "
	  . show_status( $stref->{$sub_or_incl_or_mod}{$f}{'Status'} ) . "\n"
	  if $V;
	#   carp "LEAVING parse_fortran_src( $f ) with Status " . show_status( $stref->{$sub_or_incl_or_mod}{$f}{'Status'} ) . "\n";
	   
	   if ($is_mod) { 
	   	for my $sub ( @{ $stref->{'Modules'}{ $f }{'Contains'} } ) {
#	   		say $sub;
	   		$stref = parse_fortran_src($sub, $stref);
	   	}
		# croak $f;
	   }
       # WV 2019-03-29 Here I should clean up some keys that are only used during parsing
       # but only when parse_fortran_src exits, so in fact maybe do this in Preconditioning?
       #delete  $stref->{$sub_or_incl_or_mod}{$f}{'DeclCount'};
       #delete  $stref->{$sub_or_incl_or_mod}{$f}{'DoneInitTables'};
	   
	return $stref;

}    # END of parse_fortran_src()

# -----------------------------------------------------------------------------



# analyse_lines() parses every line and determines its purpose, the info is added to $info. Furthermore,
# Create a table of all variables declared in the target, and a list of all the var names occuring on each line.
# $Sf->{'Parameters'}
# $Sf->{'Vars'} = \%vars;

# We record the type of the var and whether it's a scalar or array, because we need that information for translation to C.
# Also check if the variable happens to be a function. If that is the case, mark that function as 'Called'; if we have not yet parsed its source, do it now.

# In order to get proper hooks for the ex-globals, I think we need to check signatures, includes and variable declarations here.

#WV20150305 I've added labels to the lines, as identifiers for e.g. start/end of pragmas. I can do this here because here the lines have been normalised but no refactoring has been done yet.
sub analyse_lines {
	( my $f, my $stref ) = @_;
	
	my $grouped_warnings={};
	my $sub_incl_or_mod = sub_func_incl_mod( $f, $stref );
	
	my $is_incl = $sub_incl_or_mod eq 'IncludeFiles' ? 1 : 0;
	
#	say "analyse_lines( $f ) : $sub_incl_or_mod is_include: $is_incl";
	my $Sf = $stref->{$sub_incl_or_mod}{$f};
#	croak Dumper( sort keys %{$Sf});
	$Sf->{'ExGlobVarDeclHook'} = 0;
	
	my $srcref = (exists $Sf->{'RefactoredCode'} and scalar @{$Sf->{'RefactoredCode'}}>0) 
	? $Sf->{'RefactoredCode'}  
	: $Sf->{'AnnLines'};

	if ( defined $srcref ) {
		
		say "\nINFO: VAR DECLS in $f:" if $I;
		my %vars = ();
		
		my $prev_stmt_was_spec=1;
		my $in_excluded_block	   = 0; # for printing a given block for debug
		my $excluded_block   = -1;
		my $first          = 1;		
		my $type           = 'NONE';
		my $has_commons	= 0;
		my $has_pars	= 0;
		if ($is_incl) { # only matters in this case, for Preconditioning
			$Sf->{'HasCommons'}=0;
			$Sf->{'HasParameters'}=0; 
		}
		my $varlst         = '';
		my $indent         = '';
		my @do_stack       = ();
		my $do_counter     = 0;
		my $case_counter     = 0;
		my $block_nest_counter = 0;
		my $block_counter = 0;
		my $current_block={};
		my %block_id = ();
		my $block_id_str = '';
		my $current_block_id_str = '';
		my @blocks_stack=();
		my %extra_lines=(); # $index => [ ... ]

		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $attr = '';
			( my $lline, my $info ) = @{ $srcref->[$index] };
					
			# Get indent			
			$lline =~ /^(\s+).*/ && do { $indent = $1; }; # This is not OK for lines with labels of course.
			$info->{'Indent'}=$indent;						
			$info->{'LineID'} = $index;
			


			# Skip comments (we already marked them in SrcReader)
			if ( $lline =~ /^\s*\!/ && $lline !~ /^\!\s*\$(?:ACC|RF4A)\s/i ) {				
				next;
			}
			if (exists $info->{'Macro'} and not exists $info->{'Includes'} ) {
				next;
			} 

			# Handle !$ACC on individual line
			if ( $lline =~ /^\!\s*\$(?:ACC|RF4A)\s.+$/i ) {				
				( $stref, $info ) = __handle_acc( $stref, $f, $index, $lline );
			}
			if (exists $info->{'AccPragma'}{'BeginKernel'}) {
				$Sf->{'HasKernelRegion'}=1;
			}
			if (exists $info->{'AccPragma'}{'BeginInline'}) {
				if (scalar @{$info->{'AccPragma'}{'BeginInline'}} > 0 ) { 
 					if (exists $Sf->{'SubsToInline'}) {
						push @{$Sf->{'SubsToInline'}}, $info->{'AccPragma'}{'BeginInline'}[0];
					} else {
						$Sf->{'SubsToInline'}=[
							$info->{'AccPragma'}{'BeginInline'}[0]
						]
					}
				} else { 
					# Find the subs to be inline in a separate pass
					$Sf->{'HasInlineRegion'}=1;
				}
				# die Dumper $Sf->{'SubsToInline'};
			}			
			# Here we remove the label if there is one, but we store it in Label so we can re-emit it
			my $line = $lline;
			
			if ($line=~/^\s*(\d+)/) {
				my $label=$1;
				$info->{'Label'}=$label;
				$line=~s/^\s*\d+\s*//;	
			} else {
				# remove any leading spaces
				$line=~s/^\s+//;
			}
			say "LINE: $line\t".$info->{'LineID'} ;
			# --------------------------------------------------------------------------------
			# BLOCK identification code
			# --------------------------------------------------------------------------------
			# START of BLOCK
			# croak $line if $line=~/parameter.+alpha/;
			$line=~/^(map|structure|union|select)\s+/ && do {
				my $block_type=$1;
				++$block_nest_counter;
				++$block_counter;
				my $block = {'Nest'=>$block_nest_counter, 'Type' => $block_type, 'LineID' => $index, 'InBlock' => $current_block };
				$block_id{$block_counter}=$block;
				$current_block=$block;
				push @blocks_stack,$block_id{$block_counter}; 
				$info->{ucfirst($block_type)}=1;
				say $lline. "\t\tPUSH $block_nest_counter " if $in_excluded_block and $DBG;
			};
			
			$line=~/^if.*?then\s*$/ && do {				
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => 'if', 'LineID' => $index, 'InBlock' => $current_block };
				if ($line=~/if\s*\(\s*0\s*\)/) {
					$in_excluded_block=1;
					$excluded_block=$block_nest_counter;
					$block->{'Type'}='if0';
				}
				
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter" if $in_excluded_block and $DBG;
			};	
			$line=~/^do\s+(\w+)\s+\w+\s*=/ && do {				 
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => 'do', 'Label' => $1, 'LineID' => $index, 'InBlock' => $current_block };
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter" if $in_excluded_block and $DBG;
			};	
			$line=~/^do\s+\w+\s*=/ && do {				 
				++$block_nest_counter;
				++$block_counter;				
				my $block={'Nest'=>$block_nest_counter, 'Type' => 'do', 'Label' => '', 'LineID' => $index, 'InBlock' => $current_block };
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter DO (NO LABEL)" if $in_excluded_block and $DBG;
			};				
				
			#= SUBROUTINE FUNCTION PROGRAM
			# Procedure block identification				
			($line =~ /^(\w+\s+\w+\s+(?:function|subroutine)|\w+\s+subroutine|[\*\(\)\w]+\s+function|function|subroutine|program|module|block)\s+(\w+)/ 
			or $line =~ /^(blockdata)/
			) && do {				
				my $full_proc_type=$1;
				my $proc_name=$2;
#				say "PROC NAME in $f: $proc_name" if $f ne $proc_name;			
				my $proc_type = $full_proc_type=~/program/ ? 'program' : 
					$full_proc_type=~/subroutine/ ? 'subroutine' : 
					($full_proc_type eq 'block' and $proc_name eq 'data'
					or $full_proc_type eq 'blockdata'
					) ? 'block data' : 
					'function';
				if ($proc_type eq 'block data') {
					$full_proc_type = 'block data';
					$proc_name = 'block_data';
                	$line=~/block\s*data\s+(\w+)/i && do { $proc_name=$1 };
				}
				# If it's a function, create a record for the return value
				if ($proc_type eq 'function') {
					$full_proc_type=~s/\s+$//;
					if ($full_proc_type ne 'function') {
						$full_proc_type=~s/\s+function//;
						$full_proc_type=~s/\s*(?:pure|recursive|elemental)\s*//;
						if ($full_proc_type ne '' and $full_proc_type ne 'block data') {
							$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$proc_name}={
								'Indent'=> $indent,
								'Type'          => $full_proc_type ,
								'ArrayOrScalar' => 'Scalar',
								'Dim'           => [],
								'Attr' => '',
								'IODir' => 'Out',
								'Name'=>$proc_name,
								'Implicit' => 0
							};
							push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} },$proc_name; 
						}
					}
				}								        						
				++$block_nest_counter;
				++$block_counter;
				
				my $block={'Nest'=>$block_nest_counter, 'Type' => $proc_type, 'Name'=>$proc_name, 'LineID' => $index, 'InBlock' => $current_block };
				$info->{'Block'}= $block;
				$current_block=$block;
				push @blocks_stack,$block;
				say $lline. "\t\tPUSH $block_nest_counter" if $in_excluded_block and $DBG;
			};
			
			#= END of BLOCK:			
			$line=~/^end/  && do { 
				my $block = pop @blocks_stack;
				say $lline. "\t\tPOP $block_nest_counter ".uc($block->{'Type'})  if $in_excluded_block and $DBG;
				$info->{'Block'}= $block;
				# if ($info->{'Block'}{'Nest'} == 1 or 
				# 	$info->{'Block'}{'Nest'} == $info->{'Block'}{'InBlock'}{'Nest'}) {
				# 		$info->{'Block'}{'InBlock'}=$info->{'Block'}{'InBlock'}{'InBlock'};
				# 		$block = $info->{'Block'};
				# }
				# croak 'Block: '. Dumper $info->{'Block'} if $f eq 'sub2' and $info->{'LineID'} == 18 ;
				$current_block=$block->{'InBlock'};
				--$block_nest_counter;
				if (defined $block and exists $block->{'Nest'} and $block->{'Nest'} == $excluded_block and $in_excluded_block==1) {
					$in_excluded_block=2;
					$excluded_block=-1;
				}
			};
			
#= CONTINUE statement. 			
			$line=~/^continue/ && do {
				if (exists $info->{'Label'} ) {
				my $cont_label=$info->{'Label'} ;
				$info->{'Continue'}={'Label' => $cont_label};

				my $block = pop @blocks_stack; 
				say $lline. "\t\tPOP $block_nest_counter continue" if $in_excluded_block and $DBG;
				if (exists $block->{'Label'} ) {
					my $do_label =$block->{'Label'};
					if ($cont_label eq $do_label) {
#						say "\t" x $block_nest_counter,"END for block #$block_counter, NEST:".$block->{'Nest'}.' CONTINUE'." LABEL: ".$do_label;
						$info->{'Block'}= $block;
						$current_block=$block;
						$info->{'EndControl'}= 1;				 
						--$block_nest_counter;
					} else {
						push @blocks_stack, $block;
						say $lline. "\t\tPUSH $block_nest_counter continue (incorrect DO label)" if $in_excluded_block and $DBG;
					}
				} else {
					push @blocks_stack, $block;
					say $lline. "\t\tPUSH $block_nest_counter continue (no DO label)" if $in_excluded_block and $DBG;
				}
				} else {
					$info->{'Continue'}={};
				}
			};
			# --------------------------------------------------------------------------------
			# END of BLOCK identification code			
			# --------------------------------------------------------------------------------
if ($in_excluded_block==0) {	
						
			# --------------------------------------------------------------------------------
			# Declarations, anything not an executable statement. Last one in the chain is the IF/THEN/ELSE			
			# --------------------------------------------------------------------------------

=info non-executable statements
Statements prefixed with + are specification statements
Statements with * are currently ignored
Statements with ** are currently not even recognised, i.e. they are copied as-is

+AUTOMATIC*
+EQUIVALENCE*+ => WARNING
+EXTERNAL*
+INTRINSIC*
+STATIC*
MAP/END MAP*
STRUCTURE/END STRUCTURE*
UNION/END UNION*

ENTRY* => WARNING
FORMAT**
+NAMELIST
OPTIONS**
+POINTER**
PRAGMA**
+RECORD**
+SAVE**
+VOLATILE*
+BLOCK DATA
+BYTE
+CHARACTER
+COMMON
+COMPLEX
+DATA
+DIMENSION
+DOUBLE COMPLEX
+DOUBLE PRECISION
FUNCTION
+IMPLICIT
+INCLUDE
+INTEGER
+LOGICAL
+PARAMETER
PROGRAM
+REAL
SUBROUTINE
+VIRTUAL

=cut
						
#== IMPLICIT NONE						
			if ( $line =~ /implicit\s+(none|undefined\s*\(\s*a\s*\-\s*z\s*\))/ ) {
				$info->{'ImplicitNone'} = 1;
				$info->{'Indent'} = $indent;
				$info->{'SpecificationStatement'} = 1;
				$Sf->{'ImplicitNone'}   = $index;
				
				$srcref->[$index] = [ $indent . $line, $info ];
				next;
#== INCLUDE				
			} elsif ( exists $info->{'Includes'} ) {
				$info = __parse_include_statement($stref, $f, $sub_incl_or_mod, $Sf, $line, $info, $index);
				$info->{'SpecificationStatement'} = 1;
				$srcref->[$index] = [ $line, $info ];
				next;								
#== USE				
# WV20190626 I'm not sure why 'include' is handled in SrcReader and 'use' here ...
			} elsif ( $line =~ /^use\s+(\w+)/ ) {
				
				my $module = $1;
				$info->{'Use'}{'Name'} = $module;
				if ($line =~ /only\s*:\s*([\w\s\,]+)/) {
					my $only_list_str = $1;
					my @only_list = split(/\s*,\s*/,$only_list_str);
					$info->{'Use'}{'Only'}=\@only_list; 
				} else {
					$info->{'Use'}{'Only'}=[];
				}
				$info->{'SpecificationStatement'} = 1;
				$srcref->[$index] = [ $line, $info ];
				next;
#== CONTAINS				
			} elsif ( $line =~ /^contains/ ) {
				$info->{'Contains'} = 1;			
#== IMPLICIT (not none)				
			} elsif ( $line =~ /implicit\s+/ ) {
				$info->{'Implicit'} = 1;
				$info->{'SpecificationStatement'} = 1;
				$stref = _parse_implicit( $line, $f, $stref );
				$srcref->[$index] = [ $line, $info ];
				next;	
			}			
#== END of IF/SELECT/DO						
			elsif ( $line =~ /^end\s*(if|select|do)\s*/ ) {			
				my $keyword = $1;
				$info->{ 'End'} = $keyword;
				my $kw      = ucfirst($keyword);				
				$info->{ 'End' . $kw } = {};
				$info->{ 'EndControl' } = 1;
				if ( $kw eq 'Do' ) {
					$do_counter--;
					my $corresponding_do_info = pop @do_stack;
					$info->{'EndDo'} = $corresponding_do_info->{'Do'};					
					delete $info->{'EndDo'}{'Label'};
					my $do_label = $corresponding_do_info->{'Do'}{'Label'};					
					if (defined $do_label and $do_label ne 'LABEL_NOT_DEFINED') {						
						$Sf->{'DoLabelTarget'}{$do_label}='EndDo';
					}					
				}
				$prev_stmt_was_spec=0;
			}			
#== DIMENSION (VIRTUAL)		
		 elsif ( $line =~ /^(?:dimension|virtual)/ ) {			
# Although a Dimension line is not a declaration, I will use it as such, so the var must be in DeclaredLocalVars/DeclaredCommonVars
				$info->{'Dimension'}=1;
				$info->{'SpecificationStatement'} = 1;
				$type   = 'Unknown';
				$varlst = $line;
				$varlst =~s/^(?:dimension|virtual)\s+//;			
				my @vars_with_dim = _parse_comma_sep_expr_list($varlst);
# If @vars_with_dim > 1 then we should split this line.
# We currently do $srcref->[$index], with $index = 0 .. scalar( @{$srcref} ) - 1 ) 				
# So in order to splice in lines, what I guess I should do is create these new lines and store them at some index, then
# use that index to break up $annlines and splice them in: [@{$annlines}[0..$index], $extra_lines,@{$annlines}[$index.. $end_index] ]
					
				$extra_lines{$index}=[];
				for my $var_dim (@vars_with_dim ) {
					
					my $dline = $var_dim;
					my $varname = $var_dim;
					$varname=~s/\s*\(.+//;
					$var_dim=~s/^\w+/dimension/;
					my $type='Unknown';				

					my $subset;
					my $is_macro = exists $Config{'Macros'}{uc($varname)} ? 1 : 0;
					if (not $is_macro ) {
						if (not in_nested_set( $Sf, 'Vars', $varname ) ) {
						# So this var was not declared before. Declare it and type it, then get the dimension 
							($type, my $array_or_scalar, my $attr)= type_via_implicits($stref, $f,$varname);
							$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}={
								'Indent' => $indent,
								'Type' => $type,
								'ArrayOrScalar'=>$array_or_scalar,
								'Attr' => $attr,
								'Dim'=>[],
								'Name'=>$varname,
								'Names'=>[$varname],
								'Implicit' => 1
							};		
							$subset='DeclaredOrigLocalVars';					
						} else {
						
							my $decl = get_var_record_from_set($Sf->{'Vars'},$varname);
							$subset = in_nested_set( $Sf, 'Vars', $varname );
						  
							if (ref($decl) ne 'HASH' and $subset eq 'UndeclaredOrigArgs') {			
							# This is for so far undeclared arguments: they already have an entry
							# We call __parse_f95_decl on them and that will make them DeclaredOrigArgs
							
								($type, my $array_or_scalar, my $attr)= type_via_implicits($stref, $f,$varname);
								$decl={
									'Indent' => $indent,
									'Type' => $type,
									'ArrayOrScalar'=>$array_or_scalar,
									'Attr' => $attr,
									'Dim'=>[],
									'Name'=>$varname,
									'Names'=>[$varname],
									'IODir' => 'Unknown',
									'Implicit' => 0
								};		
								$Sf->{'UndeclaredOrigArgs'}{'Set'}{$varname}=$decl;		
							} 
							elsif ($subset eq 'UndeclaredOrigLocalVars') {
							# Change to DeclaredOrigLocalVars
							
								$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}=dclone($decl);
								delete $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$varname};
								@{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} } = grep { $_ ne $varname } @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} };
							} 
							else {
							
							# Means that the variable is either declared via T or undeclared via C. 	
								if ($subset eq 'UndeclaredCommonVars') {
									my $decl = dclone( $Sf->{'UndeclaredCommonVars'}{'Set'}{$varname} );
									$Sf->{'DeclaredCommonVars'}{'Set'}{$varname} = $decl;
									delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$varname};
									@{ $Sf->{'UndeclaredCommonVars'}{'List'} } =  grep { $_ ne $varname } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
									$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$varname] );									
								}  						
						}
						# carp $subset,';',$var_dim,';',Dumper($decl) if $line=~/catn13/;
						$type = $decl->{'Type'};
						if (exists $decl->{'Attr'} and $decl->{'Attr'} ne '') {
							my $attr = $decl->{'Attr'};
							# play it safe
							$attr=~s/^\(//;
							$attr=~s/\)$//;
							$type.="($attr)";
						}
					}
					 my $vline = "$type, $var_dim  :: $varname";
					#  croak $vline if $line=~/catn13/;
                     ( $Sf, my $info ) = __parse_f95_decl( $stref, $f, $Sf, $indent, $vline, {'Dimension' => 1});
                     $Sf->{'DeclCount'}{$varname}++;
                     $info->{'StmtCount'}{$varname}=$Sf->{'DeclCount'}{$varname};
					push @{ $extra_lines{$index} }, [$indent."dimension $dline",$info];
				} # if it's not a macro
		 }
				next;
		}
		
#== COMMON block processing for common blocks not in an include file
			# common /name/ x...
			# However, common/name/x is also valid, and even  common x, damn F77!
			# And in fact, so is common /name/ x,y, /name2/ w,z
			# Worse, the spec is COMMON [/[ cb ]/] nlist [[,]/[ cb ] / nlist ]
			# so  x//y is also OK and //x also ... 
#@ Common => 
#@    Name => $common_block_name
#@    Vars => 
#@        Set =>$parsedvars
#@        List => $parsedvars_lst
		 elsif ( $line =~ /^common\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ or 
				$line =~ /^(common)\s+(.+)$/ 
		 ) {
		 	
             # WV this is weak/incorrect because we can have              
             # COMMON [/[ cb ]/] nlist [[,]/[ cb ] / nlist ]
             # So the good way is to split on '/' first, like in the DATA statement
             #
				my $common_block_name = $1; # means it will be 'common' for a blank block
				my $commonlst         = $2;
				$commonlst=~s/\/\//,/g;
				$commonlst=~s/^,//;        
				$has_commons=1;
				$Sf->{'HasCommons'}=1; 		
				
#				say "COMMON for $f: $commonlst";
                $info->{'SpecificationStatement'} = 1; 
                $info->{'HasVars'} = 1; 
				
				( my $parsedvars, my $parsedvars_lst ) = f77_var_decl_parser( $commonlst, 0 );
				# say "LINE $line <".Dumper($parsedvars, $parsedvars_lst).'>' if $f eq 'spec_bis_conn';

#				croak $line.':'.Dumper($parsedvars) if $line=~/iacn11/ and $f eq 'ff305';				
				for my $var ( @{$parsedvars_lst} ) {	
#					my $subset;
					$Sf->{'Commons'}{$var} = $var;
					my $var_decl={};
					my $subset='';
					if ( not in_nested_set( $Sf, 'Vars', $var ) ) {    # This means that it is an undeclared common
							print "INFO: common <", $var, "> typed via Implicits for $f\n" if $I;
							my @type_kind_attr =
							  type_via_implicits( $stref, $f, $var );
							( my $type, my $array_or_scalar, my $attr ) =
							  @type_kind_attr;
							# carp __LINE__ . ": $f $var :: $type via IMPLICIT" ;  
							push @{ $info->{'Ann'} }, annotate( $f, __LINE__ . "$var :: $type via IMPLICIT" );
							my $default_indent = ' ' x 6;
							my $decl   = {
								'IODir'  => 'Unknown',
								'Indent' => $default_indent,
								'Type'   => $type,
								'Attr'   => $attr,
								'Dim'    => [ @{ $parsedvars->{$var}{'Dim'} } ],
								'Name'   => $var,
								'Status' => 1,								
								'ArrayOrScalar' => $parsedvars->{$var}{'ArrayOrScalar'},
								'CommonBlockName' => $common_block_name,
								'Implicit' => 1
							};
							$decl=__get_params_from_dim($decl,$Sf);
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$var} = $decl;
							push  @{ $Sf->{'UndeclaredCommonVars'}{'List'} },$var;
							say "INFO: DECLARED COMMON VAR $var from $f, was typed via implicit rules" if $I;							

					} else { # Means the var is already declared. So just use the existing declaration						
						# As this is a common it can't be an argument
						if (exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var} ){
							my $decl = $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var};
#							say Dumper($decl).'<>'.Dumper($parsedvars->{$var});
							if (
							     (not exists $decl->{'ArrayOrScalar'} or
								 $decl->{'ArrayOrScalar'} eq 'Scalar') and 
								 $parsedvars->{$var}{'ArrayOrScalar'} eq 'Array'
							) {								
								$decl->{'Dim'} =  [ @{ $parsedvars->{$var}{'Dim'} } ];	
							} elsif (
							exists $decl->{'ArrayOrScalar'} and
								$decl->{'ArrayOrScalar'} eq 'Array' and 
								$parsedvars->{$var}{'ArrayOrScalar'} eq 'Array'							
							) {
								die "ERROR: dimension of $var speficied both in declaration and COMMON\n";
							}
							
							$Sf->{'DeclaredCommonVars'}{'Set'}{$var} = dclone($decl);
							$Sf->{'DeclaredCommonVars'}{'Set'}{$var}{'CommonBlockName'} = $common_block_name;
							delete $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var};
							@{ $Sf->{'DeclaredOrigLocalVars'}{'List'} } = grep { $_ ne $var } @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} };
							push @{ $Sf->{'DeclaredCommonVars'}{'List'} }, $var;
							$var_decl=$decl;
							$subset='DeclaredCommonVars';
						}
						elsif (exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var} ){
							my $decl = $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var};
#							say Dumper($decl).'<>'.Dumper($parsedvars->{$var});
							if (
							     (not exists $decl->{'ArrayOrScalar'} or
								 $decl->{'ArrayOrScalar'} eq 'Scalar') and 
								 $parsedvars->{$var}{'ArrayOrScalar'} eq 'Array'
							) {								
								$decl->{'Dim'} =  [ @{ $parsedvars->{$var}{'Dim'} } ];	
							} elsif (
							exists $decl->{'ArrayOrScalar'} and
								$decl->{'ArrayOrScalar'} eq 'Array' and 
								$parsedvars->{$var}{'ArrayOrScalar'} eq 'Array'							
							) {
								die "ERROR: dimension of $var speficied both in declaration and COMMON\n";
							}
							$decl=__get_params_from_dim($decl,$Sf);
							$Sf->{'DeclaredCommonVars'}{'Set'}{$var} = exists $Sf->{'Program'} ? $decl : dclone($decl);
							$Sf->{'DeclaredCommonVars'}{'Set'}{$var}{'CommonBlockName'} = $common_block_name;
							if (not exists $Sf->{'Program'} ) {
							delete $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$var};
							@{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} } = grep { $_ ne $var } @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} };
							}
							push @{ $Sf->{'DeclaredCommonVars'}{'List'} }, $var;
						}					
						else {
							my $subset = in_nested_set( $Sf, 'Vars', $var );
							if ($subset ne 'DeclaredCommonVars') {
								# It could be UndeclaredOrigLocalVars via EQUIVALENCE
							    carp "SHOULD BE IMPOSSIBLE!  $var in $subset in $f: $line\n".Dumper( $Sf->{$subset}{'Set'}{$var} ) if $DBG;
								#UndeclaredCommonVars
							}
						}						
					}
				} # for loop 
				
				$info->{'Common'} = { 'Name' => $common_block_name , 'Vars' => 
					{
						'Set' =>$parsedvars, 'List' => $parsedvars_lst
					}
				};
				$Sf->{'HasLocalCommons'}=1 unless $is_incl;
				$stref = collect_common_vars_per_block($stref, $f, $line) unless $is_incl;    
			}		
#== NAMELIST
#@ Namelist => 
#@    namelist_group_name => @namelist_vars
		elsif (	$line =~ /^namelist\s*\/\s*([\w\d]+)\s*\/\s*(.+)$/ 				 
		 ) {
				my $namelist_group_name = $1;
				my $namelist_varlst         = $2;
				$namelist_varlst=~s/\/\//,/g;
				$namelist_varlst=~s/^,//;        
				$info->{'SpecificationStatement'} = 1;			
                $info->{'HasVars'} = 1; 
                my @namelist_vars = split(/\s*,\s*/,$namelist_varlst);
				$info->{'Namelist'}={$namelist_group_name => \@namelist_vars}; 	
				$Sf->{'Namelist'}{$namelist_group_name} = \@namelist_vars;
				 
		 }
#== FORMAT		 
		elsif ( $line =~/^format/) {
			$info->{'Format'}=1;
			$info->{'IOCall'}{'Args'} = { 'Set' => {}, 'List' => [ ] };
			$prev_stmt_was_spec=0;
		}
#== SAVE
# The SAVE statement prevents items in a subprogram from becoming undefined
# after the RETURN or END statements are executed.
# Syntax
# Description
# All variables to be saved are placed in an internal static area. All common
# blocks are saved by allocating a static area. Therefore, common block names
# specified in SAVE statements are just ignored.
# A SAVE statement is optional in the main program and has no effect.
# A SAVE with no list saves everything that can be saved.
# Restrictions
# The following constructs must not appear in a SAVE statement:
# • Variables or arrays in a common block
# • Dummy argument names
# • Record names
# • Procedure names
# • Automatic variables or arrays			 
		elsif ( $line =~/^save/) {
			$info->{'Save'}=1;
			$info->{'SpecificationStatement'} = 1;
			warning('SAVE will be deleted: '. "\n". $line,3) if $Config{'NO_SAVE'}==1;
			# croak('SAVE will be deleted: '. "\n". $line);
		}		
#== DATA
		elsif ($line=~/^data\b/ and $line!~/=/) { 
		 	# DATA
		 	$info->{'Data'} = 1;
		 	$info->{'SpecificationStatement'} = 1;
                $info->{'HasVars'} = 1; 
		 		$line.=' ! Parser line '.__LINE__.' : removed spaces from data' if $DBG;
			 	my @chunks = split(/\//,$line);
			 	$chunks[1]=~s/\s+//g;
			 	$line=join('/',@chunks);
				say "DATA declaration $line" if $V;
				$info = _parse_data_declaration($line,$info, $stref, $f);
		} 
		elsif  ($line=~/^data\b/ and $line=~/=/ and $line=~/\/\s*$/ ) {
		    	# This is either a DATA declaration with an implicit DO, or else an assignment to the variable data
		    	# which can be an array with an arbitrary expression ...
		    	# A really ugly, ad-hoc way is like this:
		    	# if the last character is a '/'
		    	# and there is a match on ')/'
		    	# we can split between the ')' and '/'
		    	# However, how about we do just nothing?
		    	$info->{'SpecificationStatement'} = 1;
                $info->{'HasVars'} = 1; 
		    	say "DATA declaration with IMPLIED DO at $line" if $V;
		}
#== INTRINSIC, EXTERNAL, STATIC, AUTOMATIC, VOLATILE
		 	elsif ($line=~/^(intrinsic|external|static|automatic|volatile)\s+([\w,\s]+)/) {
		 		my $qualifier = $1;
		 		my $external_procs_str = $2;
		 		$external_procs_str=~s/\s//g;
		 		my @external_procs = split(/\s*,\s*/,$external_procs_str);

		 		$info->{ucfirst($qualifier)} = { map {$_=>1} @external_procs};
		 		$info->{'SpecificationStatement'} = 1;
		 		$Sf->{ucfirst($qualifier)}={ map {$_=>1} @external_procs };
#		 		say Dumper($Sf->{ucfirst($qualifier)});
		 			say "INFO: ".uc($qualifier)." is ignored" if $qualifier ne 'external' and $DBG;
                if ($qualifier ne 'intrinsic' and $qualifier ne 'external') {
                $info->{'HasVars'} = 1; 
                }
		 	}
#== EQUIVALENCE 		 	 
#EQUIVALENCE ( nlist ) [, ( nlist ) ] …
#nlist List of variable names, array element names,array names, and character
#substring names separated by commas
#e.g. (IADN14(1), IADN15(1)), (RADN14(2),RADN15(2))
		 	elsif ($line=~/^equivalence\s+/) {		 	
		 		$info->{'Equivalence'} = 1;
		 		$info->{'SpecificationStatement'} = 1;
                $info->{'HasVars'} = 1; 
                my $indent = $info->{'Indent'};
		 		$stref->{$sub_incl_or_mod}{$f}{'HasEquivalence'}=1;
		 		# WE DO NOT SUPPORT THE FOLLOWING: "An EQUIVALENCE statement can extend a COMMON block on the right-hand side"
		 		if (not exists $grouped_warnings->{'EQUIVALENCE'}) {
		 			$grouped_warnings->{'EQUIVALENCE'}=[ "The EQUIVALENCE  statement cannot always be refactored, this could possible break your code:",
		 			'  SOURCE: '.$stref->{$sub_incl_or_mod}{$f}{'Source'},
                    '  CODE UNIT: '.$f, '  LINES:'		 			
		 			 ];
		 		}		 		
		 		my $warn =  '    '.$info->{'LineID'}.': '.$line;
			 	push @{	$grouped_warnings->{'EQUIVALENCE'} }, $warn;

			 	my $tline = $line;
			 	$tline=~s/^equivalence\s+//;
#			 	(my $ast, my $rest, my $err, my $has_funcs)
			 	my $ast = parse_expression($tline, $info,  $stref,  $f);
				$info->{'AST'}=$ast;
                # We must do the procedure below for every element in that list
                my @asts=(); # an AST for each tuple
                if (($ast->[0] & 0xFF) == 27) {
                    for my $idx (1 .. scalar @{$ast}-1) {
                        push @asts, $ast->[$idx];
                    }
                } else {
                    push @asts, $ast;
                }
                $info->{'Vars'}{'Set'}= {};
                
                for my $ast (@asts) {
				 	my $vars = find_vars_in_ast($ast,{});
				 	$info->{'Vars'}{'Set'}= {%{$info->{'Vars'}{'Set'}},%{ $vars } } ;
            	}
            	$info->{'Vars'}{'List'}= [sort keys %{$info->{'Vars'}{'Set'}}];
				# carp __LINE__ .': '.$f. ' EQUIVALENCE: '.Dumper($info->{'Vars'}{'List'});
				push @{ $info->{'Ann'} }, annotate( $f, __LINE__ . " EQUIVALENCE" );

		 	}		
#== VARIABLE and PARAMETER DECLARATIONS
#@ VarDecl =>
#@     Name => $varname
#@     Names => $varnames
#@ ParamDecl =>
#@        Indent    => $indent
#@        Type      => $type
#@        Attr      => $attr
#@        Dim       => []
#@        Parameter => 'parameter'
#@		  InheritedParams => $inherited_params
#@        Names     => [@var_vals]
#@        Status    => 0         
#@        Var    => $var
#@        Val    => $val
#@        AST    => $ast
# $inherited_params => 

# Actual variable declaration line (F77)
# In principle every type can be followed by '*<number>' or *(*) or (<number>)
#==F77 VarDecl
			elsif (
				(	
					
					$line =~
/^(logical|complex|byte|integer|real|double\s*(?:precision|complex)|character)\s+([^\*]?.*)\s*$/
					or $line =~
/^((?:logical|complex|byte|integer|real|double\s*(?:precision|complex)|character)\s*\(\d+\))([^\*]?.*)\s*$/
					or $line =~
/^((?:logical|complex|byte|integer|real|double\s*(?:precision|complex)|character)\s*\(kind\s*=\s*.+?\))([^\*]?.*)\s*$/
					or $line =~
/^((?:logical|complex|byte|integer|real|double\s*(?:precision|complex)|character)\s*\*(?:\d+|\((?:\*|\w+)\)))\s+(.+)\s*$/
or $line=~/^character\s*\(\s*len\s*=\s*[\w\*]+\s*\)/
				)
				and $line !~ /\s+function\s+\w+/
				and $line !~/^.+,.+::\s*.+\s*$/ # What we say here is that a declaration such as real(4) :: v(nx+1,ny) is treated as F77 
				and $line !~/\!\$ACC/
			  ) {			  	
				$type   = $1;
				$varlst = $2;
				
				
				( $Sf, $info ) = __parse_f77_var_decl( $Sf, $stref, $f,$indent, $line, $info, $type, $varlst );
				$info->{'SpecificationStatement'} = 1;				
				# carp __LINE__ . ": $f DECL ".Dumper($info) ;  
				push @{ $info->{'Ann'} }, annotate( $f, __LINE__ . " DECL" );
				#croak if $line=~/__pipe\s\!\$ACC/;
		}
#== F95 declaration, no need for refactoring		 	
		 elsif ( $line =~ /^(.+)\s*::\s*(.+)(?:\s*|\s+\!\$ACC.+)$/ ) {# croak if $line=~/__pipe\s\!\$ACC/;
		 
				( $Sf, $info ) = __parse_f95_decl( $stref, $f, $Sf, $indent, $line, $info);
				if (exists $info->{'ParamDecl'}) {
					$has_pars=1;
					$Sf->{'HasParameters'}=1;
				}		
                $info->{'SpecificationStatement'} = 1;
                $info->{'HasVars'} = 1; 
			} 
#== PARAMETER			
#== F77-style parameters			
			elsif ( $line =~ /\bparameter\s*\(\s*(.+)\s*\)/ ) {  #  parameter\s*\(\s*alpha = f*dt\s*\) => 'alpha = f*dt'
				my $parliststr = $1;
				# croak $line;# if $line=~/nstreams/ and $f=~/\.inc/ ;
				( $Sf, $info ) = __parse_f77_par_decl( $Sf, $stref, $f, $indent, $line, $info, $parliststr );				
				$has_pars=1;
				$Sf->{'HasParameters'}=1;
				$info->{'SpecificationStatement'} = 1;
                $info->{'HasVars'} = 1; 
			}    # match var decls, parameter statements F77/F95	
#== Statement Function
# fun ( [ d [, d ] … ] ) = e
# fun Name of statement function being defined
# d Statement function dummy argument
# e Expression. e can be any of the types arithmetic, logical, or character.
# I make the assumption that the first argument MUST be used in the definition
# Otherwise it is impossible to distinguish from an array assignment
# An alternative way would be to check if this statement comes immediately after another SpecificationStatement 
			elsif ( 
				$prev_stmt_was_spec and
			 $line =~ /([a-z]\w*)\s*\(\s*([a-z]\w*)[,\w]*\)\s*=\s*.*\2\W/ 			
			) {				
				my $maybe_function = $1;				
				say  "INFO: I'm pretty sure $maybe_function is a StatementFunction in $f" if $I;
				# croak "INFO: I'm pretty sure $maybe_function is a StatementFunction in $f : <$line>";

				$info->{'StatementFunction'} = $maybe_function;
				$info->{'HasVars'} = 1; 
				$info->{'SpecificationStatement'} = 1;    
				$info = _parse_assignment( $line, $info, $stref, $f );
			}								
#== MODULE is done in SrcReader
#== SIGNATURES SUBROUTINE FUNCTION PROGRAM ENTRY
#@ Signature =>
#@    Args =>
#@        List => [...]
#@        Set => {}
#@    Name => $name;
#@    Function  => $bool
#@    Program  => $bool
#@    Entry  => $bool
#@    BlockData  => $bool
#@    ReturnType => integer | real | ...
#@    ReturnTypeAttr => number or '(*)'
#@    ResultVar => $result_var
#@    Characteristic => pure | elemental | recursive 
			elsif ( 
			 ($line =~ /\b(subroutine|function|program|entry|block)[\s\(]/
			 or $line =~ /\b(blockdata)/
			 ) and $line !~ /^end\s+/) {
				( $Sf, $line, $info ) =
				  __parse_sub_func_prog_decls( $Sf, $line, $info );
			}
#== END of CODE UNIT
			elsif (
				$line =~ /^end\s+(subroutine|module|function|block\s*data)\s*(\w+)/ 
				) {
				my $kw   = $1;
				if ($kw eq 'block data') {
					$kw='subroutine';
				}
				my $name = $2;
				$info->{ 'End'} = $kw;
				$info->{ 'End' . ucfirst($kw) } = { 'Name' => $name };
			}
			elsif (  # incorrect end of block, handle it anyway via the info from the start of the block
				$line =~ /^end/ 
				) {
				# my $kw   = $1;
                
				my $kw = $info->{'Block'}{'Type'};
				if ($kw eq 'block data') {
					$kw='subroutine';
				}

				my $name = $info->{'Block'}{'Name'};
				$line = "end $kw $name";
				$info->{ 'End'} = $kw;
				$info->{ 'End' . ucfirst($kw) } = { 'Name' => $name };				
				# die $f,$line, Dumper $info;
			}
#== DO statement			
#Do =>
#@    While => $bool
#@    ExpressionsAST => $ast
#@    Range => 
#@        Vars => [ ... ]
#@        Expressions' => [ ... ]			
			elsif ( $line =~ /^do\b/) { 
#WV20150304: We parse the do and store the iterator and the range { 'Iterator' => $i,'Range' =>[$start,$stop]}
				my $do_stmt = $line;
				my $label   = $info->{'Label'} // 'LABEL_NOT_DEFINED';
				if ( $do_stmt =~ /do\s+\d+/ ) {
					$do_stmt =~ s/^do\s+(\d+)\s+//;
					my $label = $1;
				} else {					
					$do_stmt =~ s/^do\s+//;
				}
				# test for while here
				if ($do_stmt=~/while/) {
					$do_stmt=~s/while\s*//;
					# we can parse this as a normal expression I think						
					my $ast = parse_expression($do_stmt,  $info,  $stref,  $f);
					my $mvars = get_vars_from_expression($ast,{});
					my $vars= [ sort keys %{$mvars} ];
#					warn 'Support for WHILE: '.$line;#.Dumper($vars);
					$info->{'Do'} = {
						'While' =>1,
						'Iterator' => '',
						'Label'    => $label,
						'ExpressionsAST' => $ast,
						'Range'    => {	
							'Vars'        => $vars,
							},
						'LineID' => $info->{'LineID'}
					};
				} else {
					( my $iter, my $range ) = split( /\s*=\s*/, $do_stmt );
					( my $range_start, my $range_stop, my $range_step ) = split( /s*,\s*/, $range );
					if (not defined $range_step) {
						$range_step=1; # the default
					}
					my $mvars = [];
					for my $mchunk ( $range_start, $range_stop,$range_step ) {
						next if not defined $mchunk;
						next if $mchunk =~ /^\d+$/;
						my @mchunks = ();
						if ( $mchunk =~ /\W/ ) {
							@mchunks = split( /\W+/, $mchunk );
						} elsif ( $mchunk =~ /^\w+$/ ) {
							push @mchunks, $mchunk;
						} else {
							die "ERROR: Unknown pattern $mchunk in DO range\n";
						}
						for my $mvar (@mchunks) {
							next if exists $Config{'Macros'}{uc($mvar)}; # skip macros
							next if exists $F95_reserved_words{$mvar};
							next if exists $stref->{$sub_incl_or_mod}{$f}{'CalledSubs'}{'Set'}{$mvar};    # Means it's a function
							next if $mvar =~ /^__PH\d+__$/;
							next if $mvar !~ /^[_a-z]\w*$/;
							push @{$mvars}, $mvar;
						}
					}
					$info->{'Do'} = {
						'Iterator' => $iter,
						'Label'    => $label,
						'Range'    => {
							'Expressions' => [ $range_start, $range_stop, $range_step ],
							'Vars'        => $mvars
						},
						'LineID' => $info->{'LineID'}
					};
				}
				$info->{ 'Control' } = 1;
                $info->{'HasVars'} = 1; 
				$do_counter++;
				push @do_stack, $info;
				
#== SELECT/CASE 
#@ CaseVar => $var
#@ CaseVals => [...]

			} elsif ($line=~/select\s+case\s*\((\w+)\)/) {
					$info->{'CaseVar'} = $1;
					$info->{ 'Control' } = 1;
                $info->{'HasVars'} = 1; 
				} elsif ($line=~/case\s*\((.+)\)\s*$/) {
					my $case_vals_str = $1;
					my @case_vals = _parse_comma_sep_expr_list($case_vals_str);
					$info->{'CaseVals'} = [@case_vals];
					$info->{ 'Control' } = 1;
                $info->{'HasVars'} = 1; 
					$info->{ 'Case' } = ++$case_counter;				
				} elsif ($line=~/case\s+\default/) {
					$info->{'CaseDefault'} = 1;
					$info->{ 'Control' } = 1;								
			}			
#== ELSE			 
			elsif ( $line =~ /^else\s*$/ ) {			 	
					$info->{'Else'} = 1;			
					$info->{ 'Control' } = 1;
					$info->{ 'EndControl' } = 1;		
	
			} else {
# Check for IF and remove it, then check for executable statements that can come after IF				
				my $mline = $line;    # modifiable copy of $line				

				
#== IF -- Block, Arithmetic and logical IF statements		
# st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
# END IF, END, or another logical IF statement.
#@ CondExecExpr => $cond
#@ CondExecExprAST => $ast
#@ CondVars =>
#@     Set => {...}
#@     List => [...]
					
			if ( $line =~ /^(if|else\s*if)\s*\(/ ) {			  	
				my $keyword = $1;				
				if ( $line =~ /^(else\s*if)/ ) {
					$info->{'ElseIf'} = 1;					
					$info->{ 'EndControl' } = 1;
				} else {
					$info->{ ucfirst($keyword) } = 1; # 'If'	
				}
				
			# The following part should be in a separate condition block I think			
			# What I should do is:
			# Detect an IF. If so, detect if it is a THEN or an expression. 
			# Get any variables from the condition. If it's an expression, assign it to $mline and just carry on. 
			
				my $is_cond_assign = 0;
				my $is_cond        = 0;
#				my $cond           = '';
#				my $rest           = '';

				( my $cond, $mline ) = _parse_if_cond($line);
				
				$info->{'CondExecExpr'}=$cond;
				if ($mline=~/(\d+)\s*,\s*(\d+)\s*,\s*(\d+)\s*$/) {
					# arithmetic IF
					$Sf->{'ReferencedLabels'}{$1}=$1;
					$Sf->{'ReferencedLabels'}{$2}=$2;
					$Sf->{'ReferencedLabels'}{$3}=$3;					
				}
				if ($cond=~/^\d+$/) { $cond.='+0';}

				my $ast = parse_expression($cond,  $info,  $stref,  $f);
				
				$info->{'CondExecExprAST'}= $ast;
				my $vars_in_cond_expr =  get_vars_from_expression( $ast,{});
				
				my $vars_and_index_vars_in_cond_expr={};
				for my $var (sort keys %{$vars_in_cond_expr}) {
					if ($vars_in_cond_expr->{$var}{'Type'} eq 'Array'
					and scalar keys %{$vars_in_cond_expr->{$var}{'IndexVars'}}>0) {
						for my $indexvar (sort keys %{$vars_in_cond_expr->{$var}{'IndexVars'}}) {
							$vars_and_index_vars_in_cond_expr->{$indexvar} = {'Type' =>'Scalar'};
						}														
					} 
					$vars_and_index_vars_in_cond_expr->{$var} = $vars_in_cond_expr->{$var};#{'Type'}; 						
				}
				# croak Dumper $vars_and_index_vars_in_cond_expr;
#					carp($line,Dumper($vars_and_index_vars_in_cond_expr)) if $line=~/ttt/;
				for my $macro (keys %{$Config{'Macros'}} ) {
					delete $vars_and_index_vars_in_cond_expr->{ lc($macro) };
				}
				$info->{'CondVars'}{'Set'} = $vars_and_index_vars_in_cond_expr;
				$info->{'CondVars'}{'List'} = [ sort keys %{$vars_and_index_vars_in_cond_expr} ];
				if ($mline eq 'then') {
					$info->{ 'Control' } = 1;	
					$info->{ 'IfThen' } = 1;						
				}
                $info->{'HasVars'} = 1; 
			} 

# So in principle anything after this can come after IF (...) 
			# --------------------------------------------------------------------------------
			# Executable statements, last one is assignment			
			# --------------------------------------------------------------------------------
=info executable statements allowed after IF

st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
END IF, END, or another logical IF statement

Statements with * are currently ignored

ASSIGN*
DECODE*
ENCODE*
ENDFILE*

ACCEPT
Assignment
BACKSPACE
CALL
CLOSE
CONTINUE
GOTO
GOTO (Assigned)*
GOTO (Unconditional)*

INQUIRE
OPEN
PAUSE
PRINT
READ
RETURN
REWIND
STOP
TYPE
WRITE 
=cut

=info other executable statements 
Statements with * are currently ignored
Statements with ** are currently not even recognised
DO
DO WHILE*
ELSE
ELSE IF

IF (Arithmetic)
IF (Block)
IF (Logical)

END
END DO
END FILE**
END IF
=cut 

#==    READ, WRITE, and PRINT statements		
#@ CallAttrs
#@     List => [...]
#@     Set => 
#@         Type => $type
#@ CallArgs
#@     List => []
#@     Set => {}
#@ ExprVars =>
#@     List => []
#@     Set => {}
#@ ImpliedDoVars => $call_args	
			if ( 
				$mline !~ /^(?:read|accept|inquire|write|type|print)\s*=/  and
				$mline =~ /^(read|accept|inquire|write|type|print)(?:\s*\(|\s+)/ 			
			) {				
				my $keyword = $1;
				$info->{ ucfirst($keyword) . 'Call' } = 1;
				$info->{'IO'}=$keyword;
				
				$info = _parse_read_write_print( $mline, $info, $stref, $f );
                $info->{'HasVars'} = 1; 
				
			}
#== OPEN,
#== REWIND,  
#== CLOSE statements		
#@ FileName =>
#@     Var => $var
#@ Vars
#@     List => []
#@     Set => {}		
			elsif ( $mline =~ /^(open|close|rewind)\s*\(/
			or  $mline =~ /^(rewind)\s+\w+/
			) {
				my $keyword = $1;
				$info->{ ucfirst($keyword) . 'Call' } = 1;
				$info->{'IO'}=$keyword;
                $info->{'HasVars'} = 1; 
				if ( $keyword eq 'open' ) {
					$mline=~s/\s+$//;
					my $ast = parse_Fortran_open_call($mline);										
					$info->{'AST'} = $ast;
					$info->{'IOCall'}{'AST'} = $ast;
					$info->{'IOCall'}{'Args'} = { 'Set' => {}, 'List' => [ ] };
					if ( exists $ast->{'FileName'} ) {						
						if ( exists $ast->{'FileName'}{'Var'} and $ast->{'FileName'}{'Var'} !~ /__PH/ ) {						
							$info->{'FileNameVar'} =
							  $ast->{'FileName'}{'Var'
							  }; # TODO: in principle almost any other field could be a var
							$info->{'Vars'}{'Set'}
							  { $ast->{'FileName'}{'Var'} } = 1;
						} elsif ( exists $ast->{'FileName'}{'Expr'} ) {
							my $expr = $ast->{'FileName'}{'Expr'};
							if ( exists $ast->{'FileName'}{'ExprVar'} ) {
								$expr = $ast->{'FileName'}{'ExprVar'} . $expr;
							}

							my @chunks = split( /\W+/, $expr );
							for my $mvar (@chunks) {
								next if $mvar eq '';
								next if $mvar =~ /^\d+$/;
								next
								  if $mvar =~
									  /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
								next if $mvar =~ /__PH\d+__/;
								next if exists $F95_reserved_words{$mvar};
								next if exists $Config{'Macros'}{uc($mvar)};
								$info->{'Vars'}{'Set'}{$mvar} = 1;
							}
						}
					}
					if ( exists $ast->{'UnitVar'} ) {
						$info->{'Vars'}{'Set'}{ $ast->{'UnitVar'} } = 1;
					}
					if ( exists $ast->{'IOStat'} ) {
						$info->{'Vars'}{'Set'}{ $ast->{'IOStat'} } = 1;
					}
                    if ( exists $ast->{'AttrVal'} and ref($ast->{'AttrVal'}) eq 'ARRAY') {
                        for my $val (@{ $ast->{'AttrVal'} } ) {
                            next if $val=~/__PH\d+__/; 
                            $info->{'Vars'}{'Set'}{ $val } = 1;
                        }
					}
					@{ $info->{'Vars'}{'List'} } = keys %{ $info->{'Vars'}{'Set'} };
				}
#REWIND u
#REWIND ( [ UNIT=] u [, IOSTAT=ios ] [, ERR= s ])
#u Unit identifier of an external unit connected to the file
#u must be connected for sequential access, or append access.
#ios I/O specifier, an integer variable or an integer array element
#s Error specifier: s must be the label of an executable statement in the same
#program in which this REWIND statement occurs. The program control is
#transferred to this label in case of an error during the execution of the
#REWIND statement.				
				elsif ( $keyword eq 'rewind' ) {					
						$info = _parse_read_write_print( $mline, $info, $stref, $f );
#						croak Dumper($info->{'Vars'});
				}			
#== BACKSPACE, ENDFILE statements			
			} elsif ($mline=~/(backspace|endfile)/) {
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
				$info->{'IO'}=$keyword;
				$info->{'IOCall'}{'Args'} = { 'Set' => {}, 'List' => [ ] };
				warn uc($keyword)." is ignored!" if $DBG;
				warning(uc($keyword)." is ignored",3); 
#== RETURN, STOP and PAUSE statements		
			} elsif ($mline=~/^(return|stop|pause)/) {	
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
                my $return_expr = $mline;
                $return_expr =~s/$keyword\s*//;
                $info->{'Vars'}{'Written'}={'List'=>[],'Set'=>{}};
                $info->{'Vars'}{'Read'}={'List'=>[],'Set'=>{}}; 
                if ($return_expr) {
                    my $expr_ast = parse_expression($return_expr);
					$info->{'ReturnExprAST'} = $expr_ast;
                    my $vars = get_vars_from_expression($expr_ast,{});
    				$info->{'Vars'}{'Read'}{'Set'}=$vars;
                    $info->{'Vars'}{'Read'}{'List'} = [sort keys %{$vars}];
                }
			}
#== ASSIGN ... TO ...			
#@ Assign
#@   Label => $label
#@   Var => $var	
			 elsif ($mline=~/^assign\s+(\w+)\s+to\s+(\w+)/) {
			 	my $label=$1;
			 	my $var = $2;				
				$info->{'Assign'}={'Label' => $label, 'Var' => $var};
                $info->{'HasVars'} = 1; 
				$Sf->{'ReferencedLabels'}{$label}=$label;
				warning('ASSIGN is ignored',3);
			 }													
#== CONTINUE statement. 			
			elsif ($line=~/continue/) {				
				$info->{'Continue'}={};				
			}
#== DECODE/ENCODE statement. 			
			elsif ($line=~/(decode|encode)/) {		
				my $keyword = $1;
				$info->{ ucfirst($keyword) } = 1;
				$info->{'IO'}=$keyword;
                $info->{'HasVars'} = 1; 
				warning(uc($keyword).' is ignored',3);					
			}							
#== ASSIGNMENT
# This is an ASSIGNMENT and so can come after IF (...)		
#@ Lhs => 
#@        VarName       => $lhs_varname
#@        IndexVars     => $lhs_vars
#@        ArrayOrScalar => Array | Scalar
#@        ExpressionAST => $lhs_ast
#@ Rhs => 
#@        VarList       => $rhs_all_vars
#@        ExpressionAST => $rhs_ast		
			elsif ( $mline =~ /[\w\)]\s*=\s*[^=]/ ) {
				
					$info->{'Assignment'} = 1;
                    $info->{'HasVars'} = 1; 
					my $free_form =  $Sf->{'FreeForm'};							
					$mline = __remove_blanks($mline,$free_form);
#WV20150303: We parse this assignment and return {Lhs => {Varname, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
#croak "$f <$mline>" if $mline=~/^rfos01/ ;

					$info = _parse_assignment( $mline, $info, $stref, $f );
					# croak Dumper($info) if $mline=~/isuccess/;
			}
			# GOTO is handled separately in _identify_loops_breaks 
#			elsif ($mline=~/go\s*to\s+(\w+)/) {
#							carp "GOTO: $mline ".Dumper($info);
#			} 
			elsif ($mline=~/(\d+)\s*,\s*(\d+)\s*,\s*(\d+)/) {
#				say "ARITHMETIC IF: $mline";
				my $label_lt=$1;
				my $label_eq=$2;
				my $label_gt=$3;
				$info->{'ArithmeticIf'}=[$label_lt, $label_eq, $label_gt];
#				say Dumper($info);
			}
			# else {
			# 	carp "UNDETERMINED LINE: <$mline> ".Dumper($info) if $line=~/go to/;
			# }
			}
			
			

			if (not exists $info->{'Block'}) {
				$info->{'Block'}=$current_block;
			}
			# carp Dumper $info->{'Block'};
			$block_id_str = scalar keys %{$info->{'Block'}} ? join(':',@{get_block_id($info->{'Block'},[])}) : $current_block_id_str ;
			# carp $block_id_str;
			$current_block_id_str=$block_id_str;
			if ( exists $info->{'Block'}) {
				$info->{'BlockID'} = $block_id_str;
			}

			$srcref->[$index] = [ $lline, $info ];
} else {
	# Comment out the code shielded with if (0) then ... endif 	
	$srcref->[$index] = [ '!0 '.$lline, {'Blank'=>1}];
	if ($in_excluded_block==2) {
		$in_excluded_block=0;
	}
} # in excluded block
			if ($in_excluded_block==1 and not exists $info->{'Block'}) {
				
				say $lline if $DBG;
			}
			# say $line if (not exists $info->{'HasVars'}
			# and not exists $info->{'Control'}
			# and not exists $info->{'SpecificationStatement'}
			# and not exists $info->{'Comments'}
			# and not exists $info->{'Blank'}
			# and not exists $info->{'EndDo'}
			# and not exists $info->{'EndSubroutine'}
			# and not exists $info->{'EndProgram'}
			# );
			if ( 
				(not exists $info->{'SpecificationStatement'} and
				exists $info->{'HasVars'})
			or exists $info->{'Control'}			
			or exists $info->{'EndControl'}
			) {
				$prev_stmt_was_spec=0;
			}

		}    # Loop over lines
		# We sort the indices from high to low so that the insertions are at the correct index 
		for my $idx (sort {$b <=> $a} keys %extra_lines) {		
			$srcref = [@{$srcref}[0..$idx-1],@{ $extra_lines{$idx} },@{$srcref}[($idx+1) .. (scalar(@{$srcref})-1)] ]; 
		}
		$Sf->{'AnnLines'}=$srcref;
		
	} else {
		die "ERROR: NO source file found for $f ($sub_incl_or_mod). If this file is in an external directory, please speficy the directory in EXTSRCDIRS in the config file\n" ;
		if ($Sf->{'Entry'} ==0) {
		# TODO: if we can't find the source, we should search the include path, but not attempt to create a module for that source!			
		}
	}
	if ($W) {
		print "WARNING: 	" if scalar keys % {$grouped_warnings};
	for my $warning_type (sort keys % {$grouped_warnings} ) {
		for my $line (@{$grouped_warnings->{$warning_type}}) {
			say $line;
		}
	}
	}

	return $stref;
}    # END of analyse_lines()

# -----------------------------------------------------------------------------
# For every 'include' statement in a subroutine
# the filename is entered in 'Includes' and in Info->[$index]{'Include'}
# If the include was not yet read, do it now.
sub __add_include_hooks {
	( my $f, my $stref ) = @_;
#		local $V=1;

	my $sub_or_func_or_mod_or_inc_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod_or_inc_or_mod}{$f};
	print "PARSING INCLUDES for $f ($sub_or_func_or_mod_or_inc_or_mod)\n" if $V;
	my $srcref       = $Sf->{'AnnLines'};
	my $last_inc_idx = 0;
	
	if ( defined $srcref ) { 
		
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			
			
			if ( $line =~ /^\!\s/ ) {
				next;
			}
			
			if ( exists $info->{'Includes'} ) { 
				$last_inc_idx = $index;
			} # If the line contains an 'include' statement

		} # loop over all lines
	} else {
		print "WARNING: NO LOCAL SOURCE for $f\n" if $DBG;
		# TODO: if we can't find the source, we should search the include path, but
		# not attempt to create a module for that source!
	}

	# tag the next line after the last include
	$last_inc_idx++;
	$srcref->[$last_inc_idx][1]{'ExtraIncludesHook'} = 1;
	return $stref;
}    # END of __add_include_hooks()

# -----------------------------------------------------------------------------
# Parse 'use' declarations 
# the module can contain module-scoped variables etc.
# So we need to parse all the stuff in a module except the subroutines, as that is done elsewhere
# WV20170607I simply assume that any variable declaration is a global
sub _parse_use {
	( my $f, my $stref ) = @_;

	#	local $V=1;

	my $sub_or_func_or_mod_or_inc_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_mod_or_inc_or_mod}{$f};
	print "PARSING USE for $f ($sub_or_func_or_mod_or_inc_or_mod)\n" if $V;
	my $srcref       = $Sf->{'AnnLines'};
	my $last_inc_idx = 0;
	if ( defined $srcref ) {
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			if ( $line =~ /^\!\s/ ) {
				next;
			}

			if ( $line =~ /^\s*use\s+(\w+)/ ) { # if exists $info->{'Includes'}
				my $name = $1;
				print "FOUND module $name in $f\n" if $V;
				$Sf->{'Uses'}{$name} = $index;

				if (    exists $Sf->{'Translate'}
					and exists $stref->{'Modules'}{$name}
					and not exists $stref->{'Modules'}{$name}{'Translate'} )
				{
					$stref->{'Modules'}{$name}{'Translate'} =
					  $Sf->{'Translate'};
					if ( $Sf->{'Translate'} eq 'C' ) {
						$stref = add_to_C_build_sources( $name, $stref );
					} else {
						if ($DBG) {
						croak '!$acc translate (' 
						  . $f . ') '
						  . $Sf->{'Translate'}
						  . ": Only C translation through F2C_ACC is currently supported.\n";
						  }
					}
				}
				$last_inc_idx = $index;

				$info->{'Use'} = {};
				$info->{'Use'}{'Name'} = $name;
				if (exists $stref->{'Modules'}{$name}{'ModType'} and
				$stref->{'Modules'}{$name}{'ModType'} ne 'External') {
				if ( not exists $stref->{'Modules'}{$name}{'Status'}
					or $stref->{'Modules'}{$name}{'Status'} < $READ )
				{
					print $line, "\n" if $V;

					$stref = parse_fortran_src( $name, $stref );
				} else {
					print $line, " already processed\n" if $V;
				}
				if ( exists $stref->{'Modules'}{$name}{'Inlineable'} and $stref->{'Modules'}{$name}{'Inlineable'} ==1) {
					$info->{'Use'}{'Inlineable'} = 1;
				} else {
					$info->{'Use'}{'Inlineable'} = 0;
				}
				if (    exists $stref->{'Implicits'}
					and exists $stref->{'Implicits'}{$name} )
				{
					print "INFO: inheriting IMPLICITS from $name in $f\n" if $I;
					if ( not exists $stref->{'Implicits'}{$f} ) {
						$stref->{'Implicits'}{$f} =
						  $stref->{'Implicits'}{$name};
					} else {
						for my $k ( keys %{ $stref->{'Implicits'}{$name} } ) {
							if ( not exists $stref->{'Implicits'}{$f}{$k} ) {
								$stref->{'Implicits'}{$f}{$k} =
								  $stref->{'Implicits'}{$name}{$k};
							} else {
								die "ERROR: $f and $name have different type for $k";
							}
						}
					}
				}
				
				# the used module has been parsed
				if ( exists $stref->{'Modules'}{$name} ) {    # Otherwise it means it is an external module
					 # 'Parameters' here is OK because the include might contain other includes
					
					# say "Adding UsedParameters to $sub_or_func_or_mod_or_inc_or_mod $f from module $name ". __FILE__. ' ' . __LINE__;
					$Sf->{'UsedParameters'} = &append_to_set( $Sf->{'UsedParameters'}, $stref->{'Modules'}{$name}{'Parameters'} );
					# I think here I should 'inherit' UsedLocalVars from this module, i.e. any LocalVars in $name
					$Sf->{'UndeclaredCommonVars'} = append_to_set( $Sf->{'UndeclaredCommonVars'}, $stref->{'Modules'}{$name}{'DeclaredCommonVars'} );
				}
				} else {
					warning("module $name is EXTERNAL", 2);
				}
			} # If the line contains a 'use' statement			
			$srcref->[$index] = [ $line, $info ];
		}
	} else {
		print "WARNING: NO LOCAL SOURCE for $f\n" if $DBG;

	# TODO: if we can't find the source, we should search the include path, but
	# not attempt to create a module for that source!
	}

	# tag the next line after the last include

	$last_inc_idx++;
	$srcref->[$last_inc_idx][1]{'ExtraModulesHook'} = 1;
	return $stref;
}    # END of parse_use()

# -----------------------------------------------------------------------------

# UsedLocalVars is a misnomer, because these variables could be globals 
sub __module_has_globals { (my $stref, my $f, my $mod_name, my $called_sub_name)=@_; 
#	say "TEST: $called_sub_name";
#	say exists $stref->{'Subroutines'}{$called_sub_name}{'Uses'}{$mod} ? 1 :0;
#	say exists $stref->{'Subroutines'}{$called_sub_name}{'InModule'} ? 1:0;
#	say exists $stref->{'Modules'}{  $stref->{'Subroutines'}{$called_sub_name}{'InModule'} }{'Uses'}{$mod} ? 1:0;
		# This depends: for any called function, we should test if it uses the same module or resides in a module that uses the same module
		my $Sf = $stref->{'Subroutines'}{$f};
		if (exists $stref->{'Subroutines'}{$called_sub_name}{'Uses'}{$mod_name} or ( 
			exists $stref->{'Subroutines'}{$called_sub_name}{'InModule'} and
		 	exists $stref->{'Modules'}{  $stref->{'Subroutines'}{$called_sub_name}{'InModule'} }{'Uses'}{$mod_name} )
		) {
			say "INFO: MODULE $mod_name USED in $f is GLOBAL because of $called_sub_name" if $I;
			$stref->{'Modules'}{$mod_name}{'IsGlobal'}=1;
		
			$Sf->{'UsedGlobalVars'} = append_to_set( $Sf->{'UsedGlobalVars'}, $stref->{'Modules'}{$mod_name}{'LocalVars'} );
			
			for my $var (keys %{ get_vars_from_set($stref->{'Modules'}{$mod_name}{'LocalVars'} ) } ) {
#				say "VAR $var";
				$Sf->{'Commons'}{$var}=1;
				$stref->{'Subroutines'}{$called_sub_name}{'Commons'}{$var}=1;				
			}
		}
		return $stref;
}	

sub _check_used_modules_for_globals { (my $stref, my $f,  my $called_sub_name)=@_;
	for my $mod_name (keys %{ $stref->{'Subroutines'}{$f}{'Uses'} } ) {
#		say "MOD: $mod";
		$stref = __module_has_globals($stref, $f, $mod_name, $called_sub_name);
	}				
	return $stref;
}


# -----------------------------------------------------------------------------
# CALL
# We need access to the info about the ACC pragma's here.
# As this comes after analyse_lines, I should use $info not regex!
sub _parse_subroutine_and_function_calls {
	( my $f, my $stref ) = @_;
	print "PARSING SUBROUTINE/FUNCTION CALLS in $f\n" if $V;

	my $pnid               = $stref->{'NId'};
	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
	my $external_sub       = 0;
	my $entry_call = 0;

	my $srcref = $Sf->{'AnnLines'};

	if ( defined $srcref ) {
		# Subroutine calls to be offloaded must be enclosed in a KernelWrapper region 
		# TODO: We currently only allow ONE KernelWrapper region in a code unit (or in fact in a program).
		my $in_kernel_wrapper_region = 0;
		# Each subroutine in that region should be enclodsed in a KernelSub region		
		my $in_kernel_sub_region     = 0;
		my $kernel_wrapper_name      = '';
		my $current_sub_name         = '';
		
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			(my $line, my $info) = @{$srcref->[$index]};
			next if exists $info->{'OrigComments'};
			next if ( $line =~ /^\!\s/ and $line !~ /^\!\s*\$(?:ACC|RF4A)\s/i ); # TODO: use $info
			if ( exists $info->{'AccPragma'} ) {
				if ( exists $info->{'AccPragma'}{'BeginKernelWrapper'} ) {
					$in_kernel_wrapper_region = 1;
					$kernel_wrapper_name =
					  $info->{'AccPragma'}{'BeginKernelWrapper'}[0];
				} elsif ( exists $info->{'AccPragma'}{'EndKernelWrapper'} ) {
					$in_kernel_wrapper_region = 0; 
				} elsif ( exists $info->{'AccPragma'}{'BeginKernelSub'} ) {
					$in_kernel_sub_region = 1;
				} elsif ( exists $info->{'AccPragma'}{'EndKernelSub'} ) {
					$in_kernel_sub_region = 0;
				}
			}

			if ( exists $info->{'Signature'} ) {
				$current_sub_name = $info->{'Signature'}{'Name'};
			}
#== CALL, SUBROUTINE CALL
#@ SubroutineCall => 
#@     Name => $name
#@     ExpressionAST => $ast
#@     Args => CallArgs
#@ CallArgs => $expr_args
#@ ExprVars => $expr_other_vars
#@ IsExternal => $bool

# Subroutine calls. Surprisingly, these even occur in functions! *shudder*
			if (   $line =~ /call\s+(\w+)\s*\((.*)\)/
				|| $line =~ /call\s+(\w+)\s*$/ )
			{
				my $name = $1;    # The name of the called subroutine. The caller is $f
				my $argstr = $2;
				if (not defined $argstr) {
					$argstr='';
				}
				if ( $argstr =~ /^\s*$/ ) {
					$argstr = '';
				}
				
				$info->{'SubroutineCall'}{'Name'} = $name;
				if ( $in_kernel_wrapper_region == 1 ) {
					if ($in_kernel_sub_region) {
						$stref->{'KernelWrappers'}{$kernel_wrapper_name}
						  {'KernelSubs'}{$name} =
						  { 'LineID' =>
							  $info->{'LineID'} };    # slot for the arguments
					} else {
						$stref->{'KernelWrappers'}{$kernel_wrapper_name}
						  {'OtherCalls'}{$name} =
						  { 'LineID' =>
							  $info->{'LineID'} };    # slot for the arguments
					}
				}

				$stref = add_to_call_tree( $name, $stref, $f ); # Calls to ENTRY are treated as ordinary calls.  
				if ( not exists $stref->{'Subroutines'}{$name} and not exists $stref->{'Entries'}{$name} ) {
					$stref->{'ExternalSubroutines'}{$name}{'Called'} = 1;

					# This is wrong, all I need to do is not parse this one.
					# But when I continue it breaks as there is no definition
					# Also check if it is intrinsic.
					#					croak "FIX INTRINSICS!";
					#					return $stref;
					$external_sub = 1;
				
				} else {
					$external_sub = 0;
					if (exists $stref->{'Entries'}{$name}) {						
						$entry_call=1;
					} else {
						$entry_call=0;
					}
				}
	                if ($argstr ne '') {

						my $ast = parse_expression( $argstr, $info, $stref, $f ); 
						
						# This returns the arguments if they are consts, vars or PlaceHolders, but really this should return the expression string.
						# Or rather, we should not use this in Analysis::Arguments but use the AST
						( my $expr_args, my $expr_other_vars ) = get_args_vars_from_subcall($ast);
						
						for my $expr_arg (@{$expr_args->{'List'}}) {
							if (substr($expr_arg,0,1) eq '*') {
								my $label=substr($expr_arg,1);
								$Sf->{'ReferencedLabels'}{$label}=$label;		
							}
						}
						
						$info->{'SubroutineCall'}{'Args'} = $expr_args;
						$info->{'ExprVars'} = $expr_other_vars;						
						$info->{'SubroutineCall'}{'ExpressionAST'} = $ast;
						
	                } else {
	                    $info->{'SubroutineCall'}{'Args'}               = {'List'=>[],'Set'=>{}};
					    $info->{'ExprVars'}               = {'List'=>[],'Set'=>{}};	
					    $info->{'SubroutineCall'}{'ExpressionAST'} = [];
	                }
				
				if ( $external_sub == 0 ) {
					# If this is a call to an ENTRY, I will for the time being treat this separately
					# as CalledEntries
					# I think we need this only to determine which modules to use
					# We can do that via the subroutine to which the entry belongs.
									
						my $Sname = $entry_call ? $stref->{'Subroutines'}{$stref->{'Entries'}{$name}} : $stref->{'Subroutines'}{$name};
									
						if ( exists $Sf->{'Translate'}
							and not exists $Sname->{'Translate'} ) {
							$Sname->{'Translate'} = $Sf->{'Translate'};
						}
						$Sname->{'Called'} = 1;
	# What I want to know is: where in $f does the call to $name occur?
	# Problem is of course that this is before refactoring, so after refactoring this line might be wrong!
	# But then we probably want to do the analysis before we refactor anyway.
	# The proper way of course is to change the index of the line after refactoring, but then it has to change in any datastructure that uses it as well!
						if ( not exists $Sname->{'Callers'}{$f} ) {
							$Sname->{'Callers'}{$f} = [];
						}						
						push @{ $Sname->{'Callers'}{$f} }, $index;
	
						if ( $Sf->{'RefactorGlobals'} == 1 ) {
							say "SUB $name NEEDS GLOBALS REFACTORING" if $V;
							$Sname->{'RefactorGlobals'} = 1;
						}

						if ( defined $Sname) { 
							if (not exists $Sf->{'CalledSubs'}{'Set'}{$name} ) {
								if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
									$Sf->{'CalledSubs'}{'Set'}{$name} = [1,1]; # mark $name a called sub in $f
									push @{ $Sf->{'CalledSubs'}{'List'} }, $name;
								} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
								# mark $name as a called sub in $current_sub_name 
									$Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'Set'}{$name} = [1,1];
									push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'List'} }, $name;
								}
								
								if (  not exists $stref->{'ParseStack'}{$name} and (
									not exists $Sname->{'Status'}
									or $Sname->{'Status'} < $PARSED
									or $gen_sub )
									)
								{
									print
									"\tFOUND SUBROUTINE CALL $name in $f with STATUS="
									. show_status( $Sname->{'Status'} )
									. ", PARSING\n"
									if $V;
									
									$stref = parse_fortran_src( $name, $stref );
								}
							} else {
								# Update the count 
								if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
									$Sf->{'CalledSubs'}{'Set'}{$name}[1]++; # update in $f
									# push @{ $Sf->{'CalledSubs'}{'List'} }, $name;
								} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
								# update in $current_sub_name 
									$Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'Set'}{$name}[1]++;
									# push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'List'} }, $name;
								}

							}
						} 
						# it does not yet hang here
						if ($entry_call==1) {
							if ( defined $Sname) {
								if ( not exists $Sf->{'CalledEntries'}{'Set'}{$name}) {													
									if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
										$Sf->{'CalledEntries'}{'Set'}{$name} = [1,1]; # mark $name a called sub in $f
										push @{ $Sf->{'CalledEntries'}{'List'} }, $name;
									} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
										# mark $name as a called sub in $current_sub_name 
										$Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'Set'}{$name} = [1,1];
										push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'List'} }, $name;
									}
								} else {
									if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
										$Sf->{'CalledEntries'}{'Set'}{$name}[1]++; # mark $name a called sub in $f
										# push @{ $Sf->{'CalledEntries'}{'List'} }, $name;
									} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
										# mark $name as a called sub in $current_sub_name 
										$Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'Set'}{$name}[1]++;
										# push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledEntries'}{'List'} }, $name;
									}
								}
							}
						}
#					}
				} else {

					# An external sub
					$info->{'SubroutineCall'}{'IsExternal'} = 1;
					# I should add these to CalledSubs I think
					if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
							$Sf->{'CalledSubs'}{'Set'}{$name} = 1; # mark $name a called sub in $f
							push @{ $Sf->{'CalledSubs'}{'List'} }, $name;
						} else { # The current code unit is NOT a subroutine, which means it is a Module I guess
						# mark $name as a called sub in $current_sub_name 
							$Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'Set'}{$name} = 1;
							push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'List'} }, $name;
						}
					
				}
# Add labels used as arguments to ReferencedLabels
				for my $arg (keys %{ $info->{'SubroutineCall'}{'Args'}{'Set'} }) {
					if (exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$arg}{'SubType'} and 
						$info->{'SubroutineCall'}{'Args'}{'Set'}{$arg}{'SubType'} eq 'Label') {							
						$Sf->{'ReferencedLabels'}{$arg}=$arg;
					}  
				}
			}

			# Maybe Function calls
			if (   $line !~ /function\s/
				&& $line !~ /subroutine\s/
				&& $line =~ /(\w+)\s*\(/ )
			{
				# carp "FUNCTION CALL: $line" if $line=~/=.+ff08/i;
				# say "LINE: $line";				
				my @chunks = ();
				my $cline  = $line;
				while ( $cline =~ /(\w+)\(/ ) { # this could be a function call
					my $maybe_func=$1;
					# if ($line=~/(\w+)\s+$maybe_func/ and $1 ne 'call' and exists $F95_reserved_words{$1} ) { last; }
					if ( $line !~ /call\s+$maybe_func\b/ ) {
						push @chunks, $maybe_func;
						$cline =~ s/$maybe_func\(//;
					} else {
						$cline =~ s/call\s+\w+\s*\(//;
					}
					# say "LINE: $line";
				}
				# say "Got to here 1b";
				for my $chunk (@chunks) {
					if (
						    exists $stref->{'Subroutines'}{$chunk}
						and exists $stref->{'Subroutines'}{$chunk}{'Function'}
						) {
					   # This means it's the first call to function $chunk in $f
						if ( not exists $Sf->{'CalledSubs'}{'Set'}{$chunk} ) {
							$Sf->{'CalledSubs'}{'Set'}{$chunk} = [1,1];
							push @{ $Sf->{'CalledSubs'}{'List'} }, $chunk;
							print "FOUND FUNCTION CALL $chunk in $f\n" if $V;
							if ( $DBG and $chunk eq $f ) {
								show($srcref);
								croak $line;
							}
							$stref->{'Subroutines'}{$chunk}{'Called'} = 1;

# We need to parse the function to detect called functions inside it, unless that has been done
							if (   not exists $stref->{'Subroutines'}{$chunk}
								or not
								exists $stref->{'Subroutines'}{$chunk}{'Status'}
								or $stref->{'Subroutines'}{$chunk}{'Status'} < $PARSED 
								) {
								$stref = parse_fortran_src( $chunk, $stref );
							} else {
								$stref = add_to_call_tree( $chunk, $stref, $f );
							}
# WV 20201209 I think this is OBSOLETE			
							if ( exists $Sf->{'Translate'}
								and not exists $stref->{'Subroutines'}{$chunk}{'Translate'} 
								) {
								$stref->{'Subroutines'}{$chunk}{'Translate'} = $Sf->{'Translate'};
							}
						} else {
							$Sf->{'CalledSubs'}{'Set'}{$chunk}[1]++;
						}
					}					
				}
			# check if one of the args of a function happens to be a function or subroutine (!)
			# We do this the "brute force" way
					my @lchunks = split( /\W+/, $line );
					my %sub_func_as_arg= ();
					for my $mvar (@lchunks) {
						next if $mvar eq '';
						next if $mvar =~ /^\d+$/;
						next if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
						next if exists $F95_reserved_words{$mvar};
						next if exists $Config{'Macros'}{uc($mvar)};
						if (exists $stref->{'Subroutines'}{$mvar}) {
							$sub_func_as_arg{$mvar} = 1;
						}
					}
					for my $sub_or_func (keys %sub_func_as_arg) {
						if (  $sub_or_func ne $f 
								and (not exists $stref->{'Subroutines'}{$sub_or_func}
								or not exists $stref->{'Subroutines'}{$sub_or_func}{'Status'}
								or $stref->{'Subroutines'}{$sub_or_func}{'Status'} < $PARSED) 
								) {
									say "INFO: FOUND $sub_or_func TO BE PARSED on line ".$line." in $f" if $I;
								$stref = parse_fortran_src( $sub_or_func, $stref );
							} 
					}
			}
			$srcref->[$index] = [ $line, $info ];
		}    # loop over all annlines
		$stref->{$sub_or_func_or_mod}{$f}{'AnnLines'} = [ @{$srcref} ];
	}

	return $stref;
}    # END of parse_subroutine_and_function_calls()

# -----------------------------------------------------------------------------

# This is required for the include analysis, so maybe I should put it there.
# This routine builds a call graph of numbered nodes, each node has the ids of the child nodes and the correponding name of the called sub, plus the id of the parent and the current name
# The difference with the call tree is that repeated calls are included.
sub build_call_graph {
	( my $f, my $stref ) = @_;
	if (not exists $stref->{'VisitedNodes'}{$f}) {
		$stref->{'VisitedNodes'}{$f}=$stref->{'NId'}+1;
		$stref->{'VisitedNodeCtr'}++;
		say "INFO: Visiting $f\t".($stref->{'NId'}+1)."\t".$stref->{'VisitedNodeCtr'} if $I;
	
	my $prevnid = $stref->{'NId'};    # previous NId

#	if ( $prevnid == 0 ) {
#		$stref->{'PNIds'} = []; # So why was this not set at the same time as NId? Do this in State.pm!
#	}
	my $pnid =
	  ( $prevnid > 0 )
	  ? $stref->{'PNIds'}[-1]
	  : 0;                            # So take the last node in the PNIds list

	my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
	if ( $sub_or_func_or_mod ne 'ExternalSubroutines' ) {
		my $Sf = $stref->{$sub_or_func_or_mod}{$f};

		$stref->{'NId'}++;
		my $nid = $stref->{'NId'};
		$stref->{'Nodes'}{$nid} = {
			'Children'   => [],
			'Parent'     => $pnid,
			'Subroutine' => $f
		};
		# So to get the entire call chain: 
		# say "BUILDING CALL CHAIN for $f:";
		my %callers=($f=> $nid);
		my @call_chain=($f);
		my $tnid = $pnid; #$stref->{'Nodes'}{$nid}{'Parent'};
		while ($tnid>0) {
			my $f = $stref->{'Nodes'}{$tnid}{'Subroutine'};
			# say $f;
			$callers{$f}=$tnid;
			unshift @call_chain,$f;
			$tnid = $stref->{'Nodes'}{$tnid}{'Parent'};
		}
		#  say join(',',@call_chain);


		# Add the current node to the list of Children in the parent
		push @{ $stref->{'Nodes'}{$pnid}{'Children'} }, [ $nid, $f ];

		# Now identify calls and recurse
		my $annlines = $Sf->{'AnnLines'};
		if ( defined $annlines ) {
			my $called_sub_name = '';
			my $line_ct=0;
			for my $annline ( @{$annlines} ) {
				( my $line, my $info ) = @{$annline};
				++$line_ct;
				if (
					    exists $info->{'Deleted'}
					and $info->{'Deleted'} == 1
					and ( not exists $info->{'InBlock'}
						or $info->{'InBlock'}{'Name'} ne $f )
				  ) { 
                      next;
				}
				if ( exists $info->{'SubroutineCall'} 
				) {
					$called_sub_name = $info->{'SubroutineCall'}{'Name'};
					push @{ $stref->{'PNIds'} }, $nid;
					# suppose this has already been called. Then it has a NId and a record in Nodes.
					# I get the NId from VisitedNodes
					my $cnid = $stref->{'VisitedNodes'}{$f};
					my $node = $stref->{'Nodes'}{$cnid};
					 
					if (exists $callers{$called_sub_name}) {
						# say "SUBROUTINE CALL: LOOP for $called_sub_name at line $line_ct in  $f";
					} else {
						$stref = build_call_graph( $called_sub_name, $stref );
					}
					# say $called_sub_name;
					pop @{ $stref->{'PNIds'} };
				}
				
				if ( exists $info->{'FunctionCalls'} ) {
					for my $fcall_rec (@{ $info->{'FunctionCalls'} } ) {
					$called_sub_name = $fcall_rec->{'Name'};
					push @{ $stref->{'PNIds'} }, $nid;
					if (exists $callers{$called_sub_name}) {
						# say "FUNCTION CALL: LOOP for $called_sub_name at line $line_ct in  $f";
					} else {
						$stref = build_call_graph( $called_sub_name, $stref );
					}
					# say $called_sub_name;
					pop @{ $stref->{'PNIds'} };
					}
				}
				
			}    # loop over all annlines
		}
	} 
	# else {
	# 	        say "external $pnid ($sub_or_func_or_mod, $f)";
	# }

	} else {
		# We have already visited this routine's call graph
		++$stref->{'VisitedNodes'}{$f};
	}
	return $stref;
}    # END of build_call_graph()

# -----------------------------------------------------------------------------
# Proper FSM parser for F77 variable declarations (apart from the type)
# So this parses the expressions used for the dimensions, but also length
# For example
# integer*(4) a(3+(2*i),j,-k:k+10)

sub f77_var_decl_parser {
	( my $varlst, my $T ) = @_;

	print "VARLST: <$varlst>\n" if $T;

	# parse varlst into this hash
	my $vars     = {};
	my $vars_lst = [];    # ordered list
	                      #  We need following states:
	my (
		$do_nothing,      # 0
		$read_var,        # 1
		$store_var,       # 2
		$found_len,       # 3
		$read_len,        # 4
		$store_len,       # 5
		$found_shape,     # 6
		$read_shape,      # 7
		$store_shape      # 8
	) = 0 .. 8;

	my @states = qw(
	  do_nothing
	  read_var
	  store_var
	  found_len
	  read_len
	  store_len
	  found_shape
	  read_shape
	  store_shape
	);

	# initial state
	my $st = $do_nothing;

	# inside read_shape, we need a parenthesis counter:
	my $nest_count = 0;

	my $var   = '';
	my $pvar  = '';
	my $shape = '';
	my $len   = '';
	my $pc    = '';

	for my $c ( split( '', $varlst ) ) {

		my $pst = $st;    # previous state, for testing only

#### The transitions are:

		if ( $st == $do_nothing ) {
			if ( $c =~ /[a-z]/ ) { $st = $read_var }
			elsif ( $c eq '*' ) { $st = $read_len; next; }
			elsif ( $c eq '(' ) { $st = $found_shape; $nest_count = 0 }
		} elsif ( $st == $read_var && $c =~ /\W/ ) {
			$st = $store_var;
		} elsif ( $st == $store_var ) {
			if ( $pc eq '*' ) {
				$st = $read_len;
			} elsif ( $pc eq '(' ) {
				$st         = $read_shape;
				$nest_count = 0;
			} elsif ( $c eq '(' ) {
				$st         = $found_shape;
				$nest_count = 0;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $read_len && $c =~ /[\s,]/ ) {
			$st = $store_len;
		} elsif ( $st == $store_len ) {
			if ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		} elsif ( $st == $found_len ) {
			$st = $read_len;
		} elsif ( $st == $found_shape ) {
			if ( $c eq ')' ) {
				$st = $store_shape;
			} else {
				$st = $read_shape;
			}
		} elsif ( $st == $read_shape && $nest_count <= 0 && $c eq ')' ) {
			$st = $store_shape;
		} elsif ( $st == $store_shape ) {
			if ( $c eq '*' ) {
				$st = $found_len;
			} elsif ( $pc eq ',' && $c =~ /[a-z]/ ) {
				$st = $read_var;
			} else {
				$st = $do_nothing;
			}
		}
		print " PC: $pc; C:$c; NC: $nest_count; ST: $states[$st]; PST: $states[$pst]\n" if $T;

##### The actions are:
		if    ( $st == $read_var ) { $var .= $c }
		elsif ( $st == $read_len ) { $len .= $c }

		#    elsif ($st==$found_shape) {$shape.=$c;}
		elsif ( $st == $read_shape ) {
			$shape .= $c;
			if    ( $c eq '(' ) { $nest_count++; }
			elsif ( $c eq ')' ) { $nest_count--; }
		} elsif ( $st == $store_var ) {
			print "VAR:[$var]\n" if $T;
			if ($DBG and $var eq '' ) { croak $varlst }
			push @{$vars_lst}, $var;
			$vars->{$var}{'ArrayOrScalar'} = 'Scalar';
			$vars->{$var}{'Dim'}           = [];
			$pvar                          = $var;
			$var                           = '';
		} elsif ( $st == $store_len ) {
			print "LEN: {$len}\n" if $T;
			$vars->{$pvar}{'Attr'} = $len;
			$len = '';
		} elsif ( $st == $store_shape ) {
			print "SHAPE: <$shape>\n" if $T;
			$shape =~ s/^\s+//;
			$shape =~ s/\s+$//;
			my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
			my @tshape = ();
			for my $range (@ranges) {
				if ( $range =~ /:/ ) {
					push @tshape, [ split( /:/, $range ) ];
				} else {
					push @tshape, [ '1', $range ];
				}
			}
			$vars->{$pvar}{'Dim'}           = \@tshape;
			$vars->{$pvar}{'ArrayOrScalar'} = 'Array';
			$shape                          = '';
		}
		$pc = $c;

	}
	if ($T) {
		print "VAR: $var\n";
		print "PVAR: $var\n";
		print "SHAPE: $shape\n";
		print "LEN: $len\n";
		print "STATE: $states[$st]\n";
	}
#### Pending actions on end of string

	if ( $st == $read_var && $var ne '' ) {
		push @{$vars_lst}, $var;
		$vars->{$var} = { 'Dim' => [], 'ArrayOrScalar' => 'Scalar' };
	} elsif ( $st == $read_len && $pvar ne '' ) {
		$vars->{$pvar}{'Attr'} = $len;
	} elsif ( $st == $read_shape && $pvar ne '' ) {
		$shape =~ s/^\s+//;
		$shape =~ s/\s+$//;
		my @ranges = split( /\s*,\s*/, $shape );    # or ($shape);
		      # @shape is a list of the ranges, each range is a list
		my @shape = ();
		for my $range (@ranges) {
			if ( $range =~ /:/ ) {
				push @shape, [ split( /:/, $range ) ];
			} else {
				push @shape, [ '1', $range ];
			}
		}
		$vars->{$pvar}{'Dim'}           = [@shape];
		$vars->{$pvar}{'ArrayOrScalar'} = 'Array';
	}

	return ( $vars, $vars_lst );
}    # END of f77_var_decl_parser()



# -----------------------------------------------------------------------------
sub _parse_implicit {
	( my $line, my $f, my $stref ) = @_;
	my @impl_rules = ($line);
	# 1. test for compound, bail out
	my $tline = $line;
	while ( $tline =~ /\(/ ) {
		$tline =~ s/\(.+?\)//;
	}
	if ( $tline =~ /,/ ) {
		my $mline=$line;
		$mline=~s/implicit\s+//;
		@impl_rules = _parse_comma_sep_expr_list($mline);
		@impl_rules = map { "implicit $_" } @impl_rules;
	}
	
	my %implicit_type_lookup = ();
	if ( exists $stref->{'Implicits'} and exists $stref->{'Implicits'}{$f} ) {
		%implicit_type_lookup = %{ $stref->{'Implicits'}{$f} };
	}
	for my $line (@impl_rules) {
	# 2. Get the spec and turn into a regexp
	my $type = 'Unknown';
	my $array_or_scalar =
	  'Scalar';    # by default. If it is Array, need the size, so need a shape

	my $attr = '';
	my $patt = '.+';

	# IMPLICIT REAL(KIND=8)(d),COMPLEX(8)(z) => this is WEAK!
	if ( $line =~ /implicit\s+(\w.+)\((.+?)\)\((.+?)\)/ ) {
		$type = $1;
		$attr = $2;		
		$patt = $3;
		$patt =~ s/,/|/g;
		$patt =~ s/(\w\-\w)/[$1]/g;
	} elsif ( $line =~ /implicit\s+(\w.+)\((.+?)\)/ ) {
		$type = $1;		
		$patt = $2;
		if ( $type =~ /\*/ ) {
			( $type, $attr ) = split( /\*/, $type );    # WEAK!
			if ( $attr eq '(' ) { 
				$attr = '(*)';				
			}
			else {
				if ($type ne 'character') {
					$attr = $attr eq '' ? '' : "(kind=$attr)";
					
				} else {
					$attr = $attr eq '' ? '' : "($attr)";
				}
			}
		}
		$patt =~ s/,/|/g;
		$patt =~ s/(\w\-\w)/[$1]/g;
	}
	$type=~s/\s*$//;
	# 3. Generate the lookup table
	for my $c ( 'a' .. 'z' ) {
		if ( $c =~ /($patt)/ ) {
			$implicit_type_lookup{$c} = [ $type, $array_or_scalar, $attr];
		}
	}
	
	}
	$stref->{'Implicits'} = {} unless exists $stref->{'Implicits'};
	$stref->{'Implicits'}{$f} = {%implicit_type_lookup};
	return $stref;
}    # END of _parse_implicit()






# -----------------------------------------------------------------------------
# So, the problem with VarDecl is that it assumes all vars on a line have the same decl, but this is not true for the shape in F77!
# A quick fix is to extend the $shape to [$shape]
# The function below is for use after the var decl lines have been split so it should be fine.

#[
#  '      ',
#  [
#    'real',
#    '',
#    [
#      '1',
#      'maxspec'
#    ]
#  ],
#  [
#    'drydeposit'
#  ],
#  0
#]

# -----------------------------------------------------------------------------
sub __parse_sub_func_prog_decls {
	( my $Sf, my $line, my $info ) = @_;

	# Determine the subroutine arguments
	my $name = '';
	if (   $line =~ /^\s*subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*(?:pure|elemental|recursive)\s+subroutine\s+(\w+)\s*\((.*)\)/
		or $line =~ /^\s*(?:\w+\s+)*[\w\(\)\*]+\s+function\s+(\w+)\s*\((.*)\)/		
		or $line =~ /^\s*function\s+(\w+)\s*\((.*)\)/ )
	{
		 $name   = $1;
		my $argstr = $2;

		$argstr =~ s/^\s+//;
		$argstr =~ s/\s+$//;
		my @args = split( /\s*,\s*/, $argstr );

		$info->{'Signature'}{'Args'}{'List'} = [@args];
		$info->{'Signature'}{'Args'}{'Set'}  = { map { $_ => '$info '. __PACKAGE__ . ' ' . __LINE__ } @args };
		$info->{'Signature'}{'Name'}         = $name;
		if (not exists  $Sf->{'DeclaredOrigArgs'}{'List'}
			or scalar  @{ $Sf->{'DeclaredOrigArgs'}{'List'} } == 0
		) {
		$Sf->{'UndeclaredOrigArgs'}{'List'}  = [@args];
		$Sf->{'UndeclaredOrigArgs'}{'Set'} = { map { $_ => 'UndeclaredOrigArgs: ' .$_.' @ '. __PACKAGE__ . ' ' . __LINE__ } @args };   # UGH!
		}
		$Sf->{'OrigArgs'}{'List'} = [@args];

		#		$Sf->{'OrigArgs'}{'Set'} = { map { $_ => 1 } @args };
        if ( $line =~ /(pure|elemental|recursive)\s+/ ) {
        	$info->{'Signature'}{'Characteristic'} = $1;
        }
		if ( $line =~ /function\s+/ ) {
			$info->{'Signature'}{'Function'} = 1;
			if ($line =~ /(\w+)(?:\*(\S+))\s+function\s/ or $line =~ /(double\s+precision)\s+function\s/ ) {
				my $maybe_type=$1;
				my $maybe_attr=$2;
				if ($maybe_type !~/pure|elemental|recursive/) {
					$info->{'Signature'}{'ReturnType'} = $maybe_type;
					$info->{'Signature'}{'ReturnTypeAttr'} = defined $maybe_attr ? $maybe_attr : '';					
				}
			}
			if ($line =~ /function\s+\w+\s*\(.*\)\s+result\s+(\w+)/ ) {
                my $result_var=$1;                
                $info->{'Signature'}{'ResultVar'} = $result_var;                
            } 
			# We need to check here if the function has an explicit return type
			# If it is F95 there can be a RESULT attribute as well, 
			# if there is that will be the name of the result, else it's the function name
			# We could add the result arg to OrigArgs, but have a ResultVar in $Sf that we check against.
			# And similar for the return type: we have ReturnType in $Sf
			# So, 
			# - if there is no ResultVar, $f goes into UndeclaredOrigArgs, else $result_var goes into UndeclaredOrigArgs 
			# - The type is unknown unless there is ReturnType.
			# - PROBLEM: at the moment we put $f in DeclaredOrigLocalVars
		} else {
			$info->{'Signature'}{'Function'} = 0;
		}
	} elsif ( $line =~ /^\s*subroutine\s+(\w+)[^\(]*$/
		or $line =~ /^\s*(?:pure|elemental|recursive)\s+subroutine\s+(\w+)[^\(]*$/ )
	{

		# Subroutine without arguments
		 $name = $1;
		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Args'}{'Set'}  = {};
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Function'}     = 0;
	} elsif ( $line =~ /^\s*program\s+(\w+)\s*$/ ) {
		# If it's a program, there are no arguments
		 $name = $1;

		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Program'}      = 1;
	} elsif ( $line =~ /^\s*block\s*data/ ) {  
		 $name = 'block_data';
		if ( $line =~ /^\s*block\s*data\s+(\w+)\s*/ ) {
			$name=$1;
		}
		$info->{'Signature'}{'Args'}{'List'} = [];
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'BlockData'}      = 1;				
	}
	elsif (   $line =~ /^entry\s+(\w+)/
	) {
		 $name   = $1;
		 my $argstr ='';
		 if ( $line =~ /^entry\s+\w+\s*\((.*)\)/) {
			$argstr = $1;
		 }
		$argstr =~ s/^\s+//;
		$argstr =~ s/\s+$//;
		my @args = split( /\s*,\s*/, $argstr );
		$info->{'Signature'}{'Args'}{'List'} = [@args];
		$info->{'Signature'}{'Args'}{'Set'}  = { map { $_ => __PACKAGE__ . ' ' . __LINE__ } @args };
		$info->{'Signature'}{'Name'}         = $name;
		$info->{'Signature'}{'Entry'} = 1;
		$info->{'Entry'}=1;
		$info->{'Signature'}{'Function'} = 0;
		
		$Sf->{'HasEntries'} =1;
# The entry arg list is different from the parent sub arg list. 
# Also we already parsed the parent, so there should be no undeclared args in principle
# Anyway, what I need is to have OrigArgs for the ENTRY, not the parent.
# So I define $Sname = $Sf->{'Entry'}{$name} and take it from there
		$Sf->{'Entries'}{'Set'}{$name} = {};
		push @{ $Sf->{'Entries'}{'List'} },$name;
		my $Sname = $Sf->{'Entries'}{'Set'}{$name};

		# As all vars are declared (or not) *before* ENTRY, I think we should pretend that 
		# all args are declared. That way I'm sure no extra declarations will be added 
		
		$Sname->{'DeclaredOrigArgs'}{'List'}  = [@args];
		$Sname->{'DeclaredOrigArgs'}{'Set'} = { map { $_ => __PACKAGE__ . ' ' . __LINE__ } @args };   # UGH! 		
		$Sname->{'UndeclaredOrigArgs'}{'List'}  = [];
		$Sname->{'UndeclaredOrigArgs'}{'Set'} = { };
		$Sname-> {'OrigArgs'} = { 			
				'Subsets' => {
					'UndeclaredOrigArgs' => $Sname->{'UndeclaredOrigArgs'},
					'DeclaredOrigArgs'   => $Sname->{'DeclaredOrigArgs'}
				},
				'List' => [@args],
			};				
		
	} else { 
		die 'ERROR: Unrecognised subroutine declaration: '.$line."\n";
	}
#	croak Dumper $info if $name eq 'gzwrit';
    $Sf->{'Signature'}=$info->{'Signature'};
	return ( $Sf, $line, $info );
}    # END of __parse_sub_func_prog_decls()

# -----------------------------------------------------------------------------
sub __handle_acc {
	( my $stref, my $f, my $index, my $line, my $info ) = @_;
	my $accline = $line;
	
	my $is_accline = ($accline =~ s/^\!\s*\$(?:ACC|RF4A)\s+//i);
	if ($is_accline ) {
		
		my @chunks = split( /\s+/, $accline );
		
		my $pragma_name_prefix = 'Begin';
		if ( $chunks[0] =~ /Begin/i ) {
			shift @chunks;
		}
		if ( $chunks[0] =~ /End/i ) {
			shift @chunks;
			$pragma_name_prefix = 'End';
		}
		
		( my $pragma_name, my @pragma_args ) = @chunks;

		if (lc($pragma_name) ne 'inline' and not @pragma_args) {
			$pragma_args[0] = lc($pragma_name).'_'.$index;
		}
		$info->{'AccPragma'}{ $pragma_name_prefix . ucfirst( lc($pragma_name) ) } = [@pragma_args];
		
		# WV20170517 I think the following is OBSOLETE
		if (    $pragma_name =~ /KernelWrapper/i
			and $pragma_name_prefix eq 'Begin' )
		{
			$stref->{'KernelWrappers'}{ $pragma_args[0] }
			{ $pragma_name_prefix . ucfirst( lc($pragma_name) ) } =
			[ $f, $index ];
			$stref = outer_loop_start_detect( $pragma_args[0], $stref );
		}
	}
	return ( $stref, $info );
	
}    # END of __handle_acc()

# -----------------------------------------------------------------------------
	# F95 VarDecl
	# F95 declaration, no need for refactoring
sub __parse_f95_decl {
	(my $stref, my $f,  my $Sf, my $indent, my $line, my $info) = @_;
	
    my $is_module = (exists $stref->{'Modules'}{$f}) ? 1 : 0;
    
	my $pt = parse_F95_var_decl($line);
# croak $line.Dumper($info).Dumper($pt) if $line=~/alpha/;
	# But this could be a parameter declaration, with an assignment ...
	if ( $line =~ /,\s*parameter\s*.*?::\s*(\w+\s*=\s*.+?)\s*$/ ) {    


		# F95-style parameters
		$info->{'ParsedParDecl'} = $pt; #WV20150709 currently used by OpenCLTranslation, TODO: use ParamDecl and the AST from the expression parser
		
		my $parliststr = $1;
		( $Sf, $info ) = __parse_f77_par_decl(  $Sf, $stref, $f, $indent,  $line, $info, $parliststr );

		# my $var        = $pt->{'Pars'}{'Var'};
		# my $val        = $pt->{'Pars'}{'Val'};
		# my $type       = $pt->{'TypeTup'}; # e.g. integer(kind=8) => {Type => 'integer', Kind => 8}

		# my $pars_in_val = ___check_par_val_for_pars($val);

		# my $param_decl = {
		# 	'Indent'    => $indent,
		# 	'Type'      => $type,
		# 	'Attr'      => '',
		# 	'Dim'       => [],
		# 	'Parameter' => 'parameter',
		# 	'Names'     => [ [ $var, $val ] ],
		# 	'Name' => $var,
		# 	'Val' => $val,
		# 	'Status'    => 0,
		# 	'Implicit' => 0
		# };    # F95-style
		# $info->{'ParamDecl'} = $param_decl;
		# $info->{'VarDecl'} = {'Name' => $var };
		
		# $info->{'UsedParameters'} = $pars_in_val;

		# $Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;

		# # List is only used in Parser, find out what it does
		# $Sf->{'LocalParameters'}{'List'}  = [ @{ $Sf->{'LocalParameters'}{'List'} }, $var ];

	} else {
		# F95 VarDecl, continued
		
		if (    not exists $info->{'ParsedVarDecl'}
			and not exists $info->{'VarDecl'} )
		{
			# Halos pragma
			# The format is $RF4A Halos (ilh,ihh),(jlh,jhh),(klh,khh)
			# $decl->{'Halos'} = [[ilh,ihh],[jlh,jhh],[klh,khh]];
            my $halos=[];
            my $has_halo_attr=0;
            if (exists $info->{'TrailingComment'} and $info->{'TrailingComment'}=~/\$(?:ACC|RF4A)\s+[Hh]alos\s*\(+(.+?)\s*\)+\s*$/) {
                    my $halo_str=$1;
					# split on ),(
                    my @halo_chunks=split(/\s*\)\s*,\s*\(\s*/,$halo_str);
					# split on ,
                    @{$halos} = map { [ split(/\s*,\s*/,$_) ] } @halo_chunks;
                    $has_halo_attr=1;
                    
            }
			
			if (not exists $pt->{'Attributes'}{'Allocatable'}) {
				# This is a HACK because we changed the structure of Dim in the case of allocatable arrays
				$info->{'ParsedVarDecl'} = $pt;
			} 
			$info->{'VarDecl'} = {
				'Indent' => $indent,
				'Names'  => $pt->{'Vars'},
				'Status' => 0
			};
			my $idx=0;
			for my $tvar ( @{ $pt->{'Vars'} } ) { # corresponds to @{$pvars_lst} in F77
										
				my $decl = {};
				$decl->{'Indent'}        = $indent;
				$decl->{'Type'}          = $pt->{'TypeTup'}{'Type'};
				$decl->{'ArrayOrScalar'} = 'Scalar';
				$decl->{'Dim'}           = [];
				
				my $type =$decl->{'Type'}; 
				if ( exists $pt->{'Attributes'} ) {
					if ( exists $pt->{'Attributes'}{'Dim'} ) {
						if ( $pt->{'Attributes'}{'Dim'}[0] ne '0' ) {
							my @shape = ();
							for my $range ( @{ $pt->{'Attributes'}{'Dim'} } ) {
								if ( $range =~ /:/ ) {
									push @shape, [ split( /:/, $range ) ];
								} else {
									push @shape, [ '1', $range ];
								}
							}
							$decl->{'Dim'}           = \@shape;
							$decl->{'ArrayOrScalar'} = 'Array';
						}
					}
					if ( exists $pt->{'Attributes'}{'Allocatable'}) {
						$decl->{'Allocatable'}='allocatable';
						my $alloc_dim = $pt->{'Attributes'}{'Dim'}[$idx];
						my @dims = map { ['',''] } @{$alloc_dim};
						$decl->{'Dim'}           = \@dims;
					}                    
				}
                # We ignore the halo attribute unless it's an array
                # We should also check if the dims match!
                if ($decl->{'ArrayOrScalar'} eq 'Array' and $has_halo_attr) {
#                	say "SUB $f VAR $tvar HALOS: ".Dumper($halos);
                    $decl->{'Halos'} = $halos;
                    if( scalar( @{$decl->{'Dim'} } ) != scalar(@{$halos}) ) {
                        die("ERROR: The halo attribute must have the same dimension as the array\n".$line."\n");
                    }
                }
				if ( $type =~ /character/ ) {
					if (exists $pt->{TypeTup}{'ArrayOrScalar'} ) {
						$decl->{'Attr'} = '(len=' . $pt->{TypeTup}{'ArrayOrScalar'} . ')';
					# } elsif (exists $pt->{'	'}{'Dim'}) {
					# 	$decl->{'Attr'} = '(len=' . $pt->{'Attributes'}{'Dim'}[0] . ')';
					} elsif (exists $pt->{'TypeTup'}{'Kind'}) {
						$decl->{'Attr'} = 'len=' . $pt->{'TypeTup'}{'Kind'} ;						
					} else {
						warning("No length given for character string $tvar:\n\t$line",2 );
						$decl->{'Attr'} = 'len=*';
					}
					
				} elsif ( exists $pt->{'TypeTup'}{'Kind'} ) {
					$decl->{'Attr'} = '(kind=' . $pt->{'TypeTup'}{'Kind'} . ')';
#					croak $decl->{'Attr'};
				} else {
					$decl->{'Attr'} = '';					
				}

				$decl->{'IODir'} = defined $pt->{'Attributes'}{'Intent'} ? $pt->{'Attributes'}{'Intent'} : 'Unknown';
				
				$decl->{'Name'}=$tvar;
				
				my $subset =in_nested_set($Sf,'Vars',$tvar);						
				my $orig_decl = ($subset ne '') ? $Sf->{$subset}{'Set'}{$tvar} : {};
				if (ref($orig_decl) ne 'HASH') {
					$orig_decl  = {};
				}
				if ($decl->{'Type'} eq 'character'  
					and exists $decl->{'Att(r)'}
					and exists $orig_decl->{'Attr'}
					) {
						$decl->{'Attr'}=$orig_decl->{'Attr'};
				}  		  		
				# croak Dumper($pt),Dumper($decl) if $tvar eq 'catn13';							 
				# It is possible that at this point the variable had not been declared yet and we use implicit rules
				# Then we change it to declared.
				if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar} ) {								
					$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} = $decl;
					delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar};
					@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
					$Sf->{'DeclaredOrigArgs'}{'List'} = ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'}, [$tvar] );
					
				} 
				elsif ( exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} ) {
					$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} = $decl;					
				}				
				# In principle F95 code can also have COMMON vars
# When we encounter UndeclaredCommonVars we make them DeclaredCommonVars
				elsif ( exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) {
					$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} = $decl;
					delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}; # Regardless of what was there
					@{ $Sf->{'UndeclaredCommonVars'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
					$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$tvar] );
				} else { # A var decl must be unique, so it it's not a arg, it's a local or a common
				
				# I added this check so that I can use the parser for variables that are declared using implicit rules 
				# All this does is update the var entry
					if (exists $Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$tvar} ) {
						
						$Sf->{'UndeclaredOrigLocalVars'}{'Set'}{$tvar} = $decl;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'UndeclaredOrigLocalVars'}{'List'} }, $tvar;
						} 
					} elsif	(exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} ) {						
						$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} = $decl;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} }, $tvar;
						} 						
					} elsif (exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) {
						my $common_block_name = $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} = $decl;
							$Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'} = $common_block_name;
							my @test=grep {$_ eq $tvar}  @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
							if ( scalar @test == 0) { 
								push @{ $Sf->{'UndeclaredCommonVars'}{'List'} }, $tvar;
							} 
					} elsif (exists $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} ) {
						my $common_block_name = $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
						$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} = $decl;
						$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'} = $common_block_name;
						my @test=grep {$_ eq $tvar}  @{ $Sf->{'DeclaredCommonVars'}{'List'} };
						if ( scalar @test == 0) { 
							push @{ $Sf->{'DeclaredCommonVars'}{'List'} }, $tvar;
						} 						 
					} else {						
						my $subset =in_nested_set($Sf,'Vars',$tvar);
						if ($subset ne '') {
#							carp "LINE $line: $tvar in subset $subset of Vars";
							$Sf->{$subset}{'Set'}{$tvar} = $decl;
						} else {
							say "INFO: <$line>: $tvar does not have a record in Vars" if $I;
							$subset = $is_module ? 'DeclaredCommonVars' : 'DeclaredOrigLocalVars';
							if ($is_module) { $decl->{'CommonBlockName'} = $f; } # overload CommonBlockName with module name 
							$Sf->{$subset}{'Set'}{$tvar}=$decl;
							push @{$Sf->{$subset}{'List'}}, $tvar;
						}
					}					
				}
				# carp Dumper $decl;
#				croak Dumper($Sf->{'DeclaredOrigLocalVars'}{'Set'}{'ihead'}) if $line=~/rnorm/;
				$idx++;
			}
		}
	}
	
	push @{ $info->{'Ann'} }, annotate( $Sf->{'Source'}, __LINE__ );
	return ( $Sf, $info );

}    # END of __parse_f95_decl()

# -----------------------------------------------------------------------------

sub __parse_f77_par_decl { 
	# F77-style parameters
	( my $Sf, my $stref, my $f,my $indent, my $line, my $info, my $parliststr ) = @_;
	# say "LINE: $line";
	
	my $type   = 'Unknown';
	my $typed=0;
	my $attr = '';
	$indent =~ s/\S.*$//;

	my $ast =  parse_expression($parliststr, $info, $stref, $f);
	# croak Dumper( $ast) if $line=~/alpha/;
	if ($ast->[0] == 9
	and $ast->[2][0] == 0
	and scalar @{$ast->[2][1]} == 3
	) {
		$type='complex';		
	}
	# This returns be a {($var,{Epxr => $exp, AST=>$ast})} Set + [$var] List
	my $var_val_pairs = _get_var_val_pairs($ast);

	my @param_names=@{ $var_val_pairs->{'List'} };
	$info->{'ParamDecl'}{'Names'}=\@param_names;
	for my $var (@param_names) {		
		my $val = $var_val_pairs->{'Set'}{$var}{'Expr'};
		my $val_ast = $var_val_pairs->{'Set'}{$var}{'AST'};
		my $maybe_var = in_nested_set( $Sf, 'LocalVars', $var);
		# say "$f $maybe_var $var";
		if ( $maybe_var ) { 
			my $var_rec = get_var_record_from_set( $Sf->{'LocalVars'}, $var );
			$type=$var_rec->{'Type'} if $type eq 'Unknown';
			$attr=$var_rec->{'Attr'};
			$typed=1;
			delete $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var}; 
			@{ $Sf->{'DeclaredOrigLocalVars'}{'List'} } = grep { $_ ne $var } @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} };
		} 
		
		# else {
			# type via constants and inherited params
			# Basically, we start with integer, and any other type overrides this
			# But in principle also an integer*8 should override this
			# So we should in principle look at the Attr as well

			# if the val_ast contains pars
			# get vars from the AST			
			my $pars_in_val_for_var=find_vars_in_ast($val_ast,{});
			my $inherited_params={};
			for my $mpar ( keys %{$pars_in_val_for_var} ) {
				next if $mpar eq '';
				next if exists $F95_intrinsic_functions{$mpar}; 
				# carp "$f $mpar for $var";
				my $params_set = in_nested_set($Sf, 'Parameters', $mpar);
				my $mpar_rec = get_var_record_from_set( $Sf->{$params_set}, $mpar );
				if (not defined $mpar_rec) { # not in LocalParameters, try the "parent"
					# say "\nPARAM $mpar used in VAR DECL for $var in $f on line $line has no record in $f";#.Dumper($ast, $mpar_rec);
					# The problem here is that the parameter can be declared in the source file including this include. So I must check the parameter declarations via IncludedFrom
					# This source file can be an include file or a proper source, in which case it would be a subroutine or module. 
					if (scalar keys %{$Sf->{'IncludedFrom'}} == 1) {
						(my $code_unit_name, my $sub_incl_or_mod)= each %{$Sf->{'IncludedFrom'}};

						# say "Looking in enclosing SRC: $code_unit_name $sub_incl_or_mod";
						my $params_set = in_nested_set($stref->{$sub_incl_or_mod}{$code_unit_name}, 'Parameters', $mpar);
						$mpar_rec = get_var_record_from_set( $stref->{$sub_incl_or_mod}{$code_unit_name}{$params_set}, $mpar );
						# say Dumper($mpar_rec);
						# This is of course not the end of it, because 
						# (1) The param can be defined in terms of other params
						# (2) If it is not in that file, it might be in its parent, so in principle this has to be recursive
						# I am lazy and so I will simply test one more level.						

						if (not defined $mpar_rec) { # not in Parameters, try the "grandparent"
						
						# say "\nAGAIN, PARAM $mpar used in VAR DECL for $var in $f on line $line has no record";#.Dumper($ast, $mpar_rec);
						# The problem here is that the parameter can be declared in the source file including this include. So I must check the parameter declarations via IncludedFrom
						# This source file can be an include file or a proper source, in which case it would be a subroutine or module. 
						# say Dumper($stref->{$sub_incl_or_mod}{$code_unit_name}{'IncludedFrom'});
							if (scalar keys %{$stref->{$sub_incl_or_mod}{$code_unit_name}{'IncludedFrom'}} == 1) {
								(my $code_unit_name, my $sub_incl_or_mod)= each %{$stref->{$sub_incl_or_mod}{$code_unit_name}{'IncludedFrom'}};
								# say "Looking in SRC2: $code_unit_name $sub_incl_or_mod";
								my $params_set = in_nested_set($stref->{$sub_incl_or_mod}{$code_unit_name}, 'Parameters', $mpar);
								# say "FOUND PARAM IN: $params_set";
								$mpar_rec = get_var_record_from_set( $stref->{$sub_incl_or_mod}{$code_unit_name}{$params_set}, $mpar );
								# say Dumper($mpar_rec);
							} else {
								say "Could not find a record for PARAM $mpar in $f";
							}
						} else {
							# say "FOUND PARAM IN: $params_set in $code_unit_name";
						}
					}
				} else {
					# say "FOUND PARAM IN: $params_set in $f";
				}
				# carp $mpar.':'.Dumper($mpar_rec);
				my $mtype=$mpar_rec->{'Type'};
				my $mattr=$mpar_rec->{'Attr'};
				if ($mtype ne 'integer' and $mtype ne 'complex' or not $typed) {
					$type = $mtype;
					$typed=1;
				}				
				$inherited_params->{'Set'}{$mpar}=$mpar_rec;
				croak if $DBG and ref($mpar_rec) ne 'HASH';
			}
			
			# the pars could be integers, see if the consts in the val_ast might be reals or PlaceHolder
			# get const types from the AST
			my $const_types = _find_consts_in_ast( $val_ast, {});
			# $type = 'integer';
			my %ttatrs_types=();
			# say "CONSTS for VAR $var:";
			$ttatrs_types{$var}=[$type,$attr];
			for my $const (keys %{$const_types}) {
				
				

				my $ctype = $const_types->{$const};
				if ($ctype eq 'PlaceHolder') {
					my $ttype = 'character';
					my $tattr = '(*)';
					$ttatrs_types{$var}=[$ttype,$tattr];
				}
				elsif ($ctype ne 'integer' and $type ne 'complex' or not $typed) {
					# say "NOT integer $var $const $ctype";
					my $ttype = $ctype;
					$typed=1;
					$ttatrs_types{$var}=[$ttype,$attr];
					
				}
				else {
					
					if ($type ne 'complex') {
					$ttatrs_types{$var}=[$ctype,''];
					} else {
						$ttatrs_types{$var}=[$type,''];
					}
					# say "$var $const must be int".Dumper($ttatrs_types{$const});
				}
			}
			
		# }
		# carp "$var $val ".Dumper(%ttatrs_types) if $line=~/ipn002/;
		my $param_decl = {
						'Type' => $ttatrs_types{$var}[0],#$type,
						'Var'  => $var,
						'Val'  => $val,
						'AST' => $val_ast,
						'Attr' => $ttatrs_types{$var}[1],#$attr,
						'DEBUG' => __FILE__.' '.__LINE__,
						'Indent'    => $indent,
						'Dim'       => [],
						'Parameter' => 'parameter',
						'InheritedParams' => $inherited_params,
						'Status'    => 0,
						'Implicit' => 0     
					};
					# croak Dumper($param_decl) if $var eq 'icp001';
		$Sf->{'LocalParameters'}{'Set'}{$var}=$param_decl;		
	}

	return ( $Sf, $info );

}    # END of __parse_f77_par_decl()

# -----------------------------------------------------------------------------
# TODO: F95 decls should not be parsed by a routine named __parse_f77_var_decl !!! 
sub __parse_f77_var_decl {
	( my $Sf, my $stref, my $f,my $indent,  my $line, my $info, my $type, my $varlst ) = @_;
    my $is_module = (exists $stref->{'Modules'}{$f}) ? 1 : 0;
    # Half-baked F95/F77 declarations are threated as F77, so remove the :: here
    my $half_baked = ($line=~s/\:://);
	
    my $attr='';
    my $pvars;
    my $pvars_lst;
	
    if (defined $type) {
    	if ( $type eq 'double precision') {
            $line = 'real(8) '.$varlst;
        }
        elsif ($type eq 'double complex') {
            $line = 'complex(8) '.$varlst;
        }
    }
	( $pvars, $pvars_lst ) = _parse_F77_decl_NEW( $line );
	

# croak $line.Dumper($pvars, $pvars_lst ) if $line=~/integer\(KIND=MPI_OFFSET_KIND\)\s*MPI_DISPLACEMENT_CURRENT/i;	
    # For backward compat, remove later. TODO
    $type = $pvars->{$pvars_lst->[0]}{'Type'};

	my @varnames = ();
	# Add type information to Vars
	my $annotation='';
	for my $tvar ( @{$pvars_lst} ) {
		
		if ($DBG and $tvar eq '' ) { croak "<$line> in $f" }
#		my $tvar = $var;
		if ( ref($tvar) eq 'ARRAY' ) { die __LINE__ . ':' . Dumper($tvar); }
		my $common_block_name='';
		# As the Dim can be defined elsewhere, we need extra checks to get the correct value
		my $dim = $pvars->{$tvar}{'Dim'};		
		# In all the cases below, we get the dimension from the record
		# Because I think it only happens for DIMENSION and COMMON lines.
		if (exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar} ) {					
			my $tdim = exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar}{'Dim'} ? dclone($Sf->{'DeclaredOrigLocalVars'}{'Set'}{$tvar}{'Dim'}) : [];
			if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}			
			
		} elsif (exists $Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar} ) {
			my $tdim =exists $Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar}{'Dim'} ? dclone($Sf->{'DeclaredOrigLocalArgs'}{'Set'}{$tvar}{'Dim'}) : [];
			if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
			
		} elsif (exists $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} ) {
			my $tdim =exists $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'Dim'} ? dclone($Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'Dim'}) : [];
			if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
			$common_block_name = $Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
		} elsif (exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) { 
			my $tdim = exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'Dim'} ? dclone($Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'Dim'}) : [];
			if (scalar @{$tdim}>0) {
				$dim=$tdim;
			}
			$common_block_name = $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}{'CommonBlockName'};
		}
		
		my $tvar_rec = {
			'Type'          => $type, # this is passed in as an argument  
			'Dim'           => $dim, # see above
			'ArrayOrScalar' => $pvars->{$tvar}{'ArrayOrScalar'},
			'Attr'			=> $pvars->{$tvar}{'Attr'},
			'IODir'         => 'Unknown',
		};
		# The Attr field depends on if it is a character or not
		if ( not exists $pvars->{$tvar}{'Attr'} ) {
			if ($attr) {
				if ( $type !~ /character/ ) {
					$tvar_rec->{'Attr'} = $attr ;
				}
			} else {
				$tvar_rec->{'Attr'} = '';
			}
		} else {
			if ($pvars->{$tvar}{'Attr'} ne '') {
			if ( $type !~ /character/) {
				if ( $pvars->{$tvar}{'Attr'}!~/kind=/) {
					$tvar_rec->{'Attr'} = '(kind=' . $pvars->{$tvar}{'Attr'} . ')';
				} else {
					$tvar_rec->{'Attr'} = '' . $pvars->{$tvar}{'Attr'} . '';
				}
			}
			} else {
				$tvar_rec->{'Attr'} = ''
			}
		}

		# Take IODir from INTENT if it exists
		# Because F77 has an INTENT declaration
		if ( $type =~ /\bintent\s*\(\s*(\w+)\s*\)/ ) {
			my $iodir = $1;
			$iodir = ucfirst($iodir);
			if ( $iodir eq 'Inout' ) {
				$iodir = 'InOut';
			}
			$tvar_rec->{'IODir'} = $iodir;			
		}
		
		# Create the final declaration
		my $decl = {
			'Indent' => $indent,
			'Type'   => $tvar_rec->{'Type'},
			'Attr'   => $tvar_rec->{'Attr'},
			'Dim'    => $dim,
			'Name'   => $tvar,
			'IODir'  => $tvar_rec->{'IODir'},
			'Status' => 0,
			'StmtCount'	=> $tvar_rec->{'StmtCount'},
			'ArrayOrScalar' => scalar @{$dim} > 0 ? 'Array' : 'Scalar' ,
			'Implicit' => 0
		};
		# Here $decl->{'Type'} is OK
		
		if ($common_block_name ne '') {
			$decl->{'CommonBlockName'} = $common_block_name;
		}
		
		if (exists $pvars->{$tvar}{'InheritedParams'}) {
			for my $mpar (keys %{ $pvars->{$tvar}{'InheritedParams'}{'Set'} }) {
				$decl->{'InheritedParams'}{'Set'}{$mpar}=$pvars->{$tvar}{'InheritedParams'}{'Set'}{$mpar};
				croak if $DBG and ref($pvars->{$tvar}{'InheritedParams'}{'Set'}{$mpar}) ne 'HASH';
			}
		}
				
		if (scalar @{$dim}>=1) {
			for my $dimpair (@{$dim}) {
				for my $mexpr ( @{$dimpair} ) {
					my @mpars = split(/\W+/, $mexpr);
					for my $mpar (@mpars) {
						if (defined $mpar and in_nested_set($Sf,'Parameters',$mpar) ) {
							my $subset = in_nested_set($Sf,'Parameters',$mpar);
							my $pdecl = get_var_record_from_set($Sf->{$subset},$mpar);
	         				$decl->{'InheritedParams'}{'Set'}{$mpar}=$pdecl;
							#  croak '' if ref($pdecl) ne 'HASH';
	         			}				
					}
				}
			}
		} 						

		push @varnames, $tvar;
		
# When we encounter UndeclaredOrigArgs we make them DeclaredOrigArgs
		if ( exists $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar} ) {
			# say "$f: $tvar";
			$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar} = $decl;
			delete $Sf->{'UndeclaredOrigArgs'}{'Set'}{$tvar}; # Regardless of what was there
			@{ $Sf->{'UndeclaredOrigArgs'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredOrigArgs'}{'List'} };
			$Sf->{'DeclaredOrigArgs'}{'List'} = ordered_union( $Sf->{'DeclaredOrigArgs'}{'List'}, [$tvar] );
			$Sf->{'DeclaredOrigArgs'}{'Set'}{$tvar}{'StmtCount'}=1;
			$info->{'ArgDecl'}{$tvar}=1;
			# $info->{'TEST'}=1;
		}		
# When we encounter UndeclaredCommonVars we make them DeclaredCommonVars
		elsif ( exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar} ) {
			$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar} = $decl;
			delete $Sf->{'UndeclaredCommonVars'}{'Set'}{$tvar}; # Regardless of what was there
			@{ $Sf->{'UndeclaredCommonVars'}{'List'} } = grep { $_ ne $tvar } @{ $Sf->{'UndeclaredCommonVars'}{'List'} };
			$Sf->{'DeclaredCommonVars'}{'List'} = ordered_union( $Sf->{'DeclaredCommonVars'}{'List'}, [$tvar] );
			$Sf->{'DeclaredCommonVars'}{'Set'}{$tvar}{'StmtCount'}=1;
			
		} else { # A var decl must be unique, so if it's not a arg, it's a local or a common
		
		# The var can be either DeclaredOrigLocalVars or DeclaredCommonVars. 
		# In both case we simply update the record
			my $subset = in_nested_set($Sf,'Vars',$tvar);
			if ($subset eq '') { # Var doesn't exist yet so it becomes DeclaredOrigLocalVars 
				$subset = $is_module ? 'DeclaredCommonVars' : 'DeclaredOrigLocalVars';
				if ($is_module) { $decl->{'CommonBlockName'} = $f; } # overload CommonBlockName with module name 
				push @{$Sf->{$subset}{'List'}}, $tvar;
				$Sf->{$subset}{'Set'}{$tvar} = $decl;
			} else {
				# Var was declared but this could be via e.g. Dimension				
				$Sf->{$subset}{'Set'}{$tvar} = $decl;
			}			
		}
		$Sf->{'DeclCount'}{$tvar}++;
		$info->{'StmtCount'}{$tvar} = $Sf->{'DeclCount'}{$tvar};
		$annotation.= "$tvar :: ".$tvar_rec->{'Type'}.' ' ;
	}    # loop over all vars declared on a single line

	print "\tINFO: VARS <$line>:\n ", join( ',', sort @varnames ), "\n" if $I;

	$info->{'VarDecl'} = {
		'Indent' => $indent,	
		'Names'  => \@varnames,
		'Status' => 0
	};

    if (scalar @varnames == 1 ) {
    	$info->{'VarDecl'}{'Name'} = $varnames[0];
    }
	
	push @{ $info->{'Ann'} }, annotate( $f, __LINE__ . ' '. $annotation );
	return ( $Sf, $info );
}    # END of __parse_f77_var_decl()

# -----------------------------------------------------------------------------
sub _identify_loops_breaks {
	( my $f, my $stref ) = @_;
	my $sub_or_func = sub_func_incl_mod( $f, $stref );
	my $Sf          = $stref->{$sub_or_func}{$f};
	my $srcref      = $Sf->{'AnnLines'};
	if ( defined $srcref ) {
		my %do_loops = ();
		my %gotos    = ();

		#   my %labels=();
		my $nest = 0;
		for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
			my $line = $srcref->[$index][0];
			my $info = $srcref->[$index][1];
			next if $line =~ /^\!\s+/;

			# BeginDo: we find a do with a label
			# This can be a 'proper' do .. end do but only if either there is and end do or there is a continue. Otherwise I should keep the label!
			# So I need a check on the labels
			 
			$line =~ /^\s*\d*\s+do\s+(\d+)\s+\w/ && do {
				my $label = $1;
				$info->{'BeginDo'}{'Label'} = $label;
#				if (not exists $info->{'Do'}{'Label'}  or $info->{'Do'}{'Label'} eq 'LABEL_NOT_DEFINED') {
#					$info->{'Do'}{'Label'} = $label;
#				} else {
#					say "Do label already defined: $label <> ". $info->{'Do'}{'Label'};
#				}
				$Sf->{'DoLabelTarget'}{$label}='Unknown';
				if ( not exists $do_loops{$label} ) {
					@{ $do_loops{$label} } = ( [$index], $nest );
					$nest++;
				} else {
					push @{ $do_loops{$label}[0] }, $index;
				}
				$srcref->[$index] = [ $line, $info ];
				next;
			};
#    (Un)conditional GO TO, assigned GO TO, and computed GO TO statements
			# Goto
			$line =~ /^\s*\d*\s+.*?[\)\ ]\s*go\s*to\s+(\d+)\s*$/ && do {
				my $label = $1;
				$info->{'Goto'}{'Label'} = $label;
				$Sf->{'ReferencedLabels'}{$label}=$label;
				$Sf->{'Gotos'}{$label} = 1;				
				push @{ $gotos{$label} }, [ $index, $nest ];
				$line=~s/\sgo\s+to\s/ goto /;
				# carp 'GOTO: '.$line;
#				say " GOTO: $line";
				$srcref->[$index] = [ $line, $info ];
				next;
			};
#    CONTINUE statement
			# continue can be end of do loop or break target (amongs others?)
			$line =~ /^\s*(\d+)\s+(continue|\w)/ && do {
				my $label = $1;
				if (exists $Sf->{'DoLabelTarget'}{$label} ) {
					$Sf->{'DoLabelTarget'}{$label}='Continue';
				}
				my $is_cont = $2 eq 'continue' ? 1 : 0;
				if ($is_cont) {
					$info->{'Continue'}{'Label'} = $label;
				}
				if ( exists $do_loops{$label} ) {
					if ( $nest == $do_loops{$label}[1] + 1 ) {
						$info->{'EndDo'}{'Label'} = $label;
						$info->{'EndDo'}{'Count'} =
						  scalar @{ $do_loops{$label}[0] };
						delete $do_loops{$label};
						$nest--;
					} else {
						warning("Found CONTINUE for label $label in $f but nesting level is wrong\n\t$line",2);
# : $nest<>$do_loops{$label}[1]\n"  if $W;
					}
				} elsif ( exists $gotos{$label} ) {
					my $target = 'GotoTarget';
					for my $pair ( @{ $gotos{$label} } ) {
						( my $tindex, my $tnest ) = @{$pair};
						$target = 'GotoTarget';
						if ( $nest <= $tnest )
						{  # What if there are several gotos point to one label?
							if ( $tnest > 0 ) {
								if ($is_cont) {
									$target = 'NoopBreakTarget';
									$srcref->[$tindex][1]{'Break'}{'Label'} =
									  $label;
								} else {
									$target = 'BreakTarget';
									$srcref->[$tindex][1]{'Break'}{'Label'} =
									  $label;
								}
							} else {
								if ($is_cont) {
									$target = 'NoopTarget';
								}
							}
						} else {							
							warning("Found GOTO target that is not a BREAK for label $label: wrong nesting in $f\n\t$line",2);# $nest<>$gotos{$label}[1]"							
						}
					}
					$info->{$target}{'Label'} = $label;
					$Sf->{'Gotos'}{$label} = $target;
					delete $gotos{$label};
				}
				$srcref->[$index] = [ $line, $info ];
				next;
			};

   # When an open() fails, you can pass a label to some place for error handling
   # Some evil code combines such end-of-do-block labels
			$line =~ /^\s+open.*?\,\s*err\s*=\s*(\d+)\s*\)/ && do {
				my $label = $1;
				$Sf->{'Gotos'}{$label} = 1;
				next;
			};
			
			$srcref->[$index] = [ $line, $info ];
		}
	} else {
		print "WARNING: NO SOURCE (AnnLines) for $f\n" if $DBG
	}
	return $stref;
}    # END of _identify_loops_breaks()
# -----------------------------------------------------------------------------

=info_read_inquire_write_print
#== ACCEPT
ACCEPT f [, iolist ]
ACCEPT grname
f Format identifier: Label | character expression | integer variable name (Read from) | *
iolist List of variables, substrings, arrays, and records:, Written to
grname Name of the namelist group, Read from

#== READ
READ( [ UNIT=] u [, [ FMT=] f ] [, IOSTAT= ios ] [, REC= rn ] [, END= s ] [, ERR= s ] ) iolist
READ f [, iolist ]
READ([UNIT=] u, [NML=] grname [,IOSTAT=ios ] [,END=s ] [,ERR=s ] )
READ grname

An alternate for the REC=rn form is allowed, as follows:
READ( u 'rn … ) iolist

u Unit identifier: integer expression (Read from) | *
f Format identifier, i.e. * or a label or a variable name, Read from
ios I/O status specifier: integer variable, Written to
rn Record number to be read: integer expression, Read from
s Statement label: Label 
iolist List of variables, Written to
grname Name of a namelist group, Read from

READ( 1, 2, ERR=8, END=9, IOSTAT=N ) X, Y
READ( 1, REC=3, IOSTAT=N, ERR=8 ) V
READ( *, * ) A, V
READ *, A, V
READ( CA, 1 ) L, R
READ( 3, '(5F4.1)') V
READ( 1, G )
READ( UNIT=1, NML=G )

#== INQUIRE
INQUIRE( [ UNIT=] u, slist )
INQUIRE( FILE=fn, slist )
fn Name of the file being queried
u Unit of the file being queried
slist Specifier list

The INQUIRE slist can include one or more of the following, in any order:
• ERR = s : Label
• EXIST = ex : bool Written to
• OPENED = od  : ool Written to
• NAMED = nmd : ool Written to
• ACCESS = acc : character string Written to
• SEQUENTIAL = seq : character string Written to
• DIRECT = dir : character string Written to
• FORM = fm : character string Written to
• FORMATTED = fmt : character string Written to
• UNFORMATTED = unf : character string Written to
• NAME = fn : character string Written to
• BLANK = blnk : character string Written to
• IOSTAT = ios : integer variable Written to
• NUMBER = num : integer variable Written to
• RECL = rcl : integer variable Written to
• NEXTREC = nr : integer variable Written to

#== PRINT
PRINT f [, iolist ]
PRINT grname
f Format identifier, i.e. * or a label or a variable name
iolist List of variables, substrings, arrays, records, …
grname Name of the namelist group

#== OPEN
OPEN( KEYWORD1=value1, KEYWORD2=value2, … )

[UNIT=] u
FILE = fin or NAME = fin : a character expression (Read from) or *
ACCESS = acc: character expression, Read from
BLANK = blnk : a character expression ,Read from
ERR = s : Label
FORM = fm : a character expression, Read from
IOSTAT = ios : an integer variable, Written to
RECL = rl or  RECORDSIZE = rl
STATUS = sta or TYPE = sta : a character expression, Read from
FILEOPT = fopt : a character expression, Read from
READONLY 
ACTION = act : READ | WRITE | READWRITE


#== CLOSE
CLOSE( [ UNIT=] u [, STATUS= sta] [, IOSTAT= ios] [, ERR= s ] )

u Unit identifier 
sta is a character expression, Read from
ios I/O status specifier : an integer variable, Written to
s Error specifier : Label

#== WRITE
WRITE( [ UNIT=] u [, [FMT=] f ] [, IOSTAT=ios ] [, REC=rn ] [, ERR=s ] ) iolist
WRITE( [ UNIT= ] u, [ NML= ] grname [, IOSTAT= ios ] [, ERR= s ] )
u Unit identifier of the unit connected to the file
f Format identifier
ios I/O status specifier
rn Record number
s Error specifier (statement label)
iolist List of variables
grname Name of the namelist group

An alternate for the REC=rn form is allowed, as follows:
WRITE( u ' rn … ) iolist

WRITE(*,*) x, f(x)
WRITE( 1, REC=3, IOSTAT=N, ERR=8 ) V
WRITE( 1 ' 3, IOSTAT=N, ERR=8 ) V

#== REWIND
REWIND u
REWIND ( [ UNIT=] u [, IOSTAT=ios ] [, ERR= s ])
u Unit identifier of an external unit connected to the file
u must be connected for sequential access, or append access.
ios I/O specifier, an integer variable or an integer array element, Written to
s Error specifier: Label 

We have 3 different cases:

1. operation (arglist) : READ, WRITE, INQUIRE, OPEN, CLOSE,  REWIND => $attrs_ast
2. operation (arglist) iolist : READ, WRITE => $attrs_ast, $exprs_ast
3. operation comma_sep_list : READ, PRINT, ACCEPT, REWIND => $attr_ast

=cut


sub _parse_read_write_print {
	
    ( my $line, my $info, my $stref, my $f ) = @_;
    
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf          = $stref->{$sub_or_func}{$f};
    my $tline=$line;
    #    For READ and WRITE we can have this stupid non-standard syntax:
    if (exists $info->{'ReadCall'} or exists $info->{'WriteCall'} ) {
        my $has_a_single_quote = ($tline =~ tr/\'//) % 2;
        if ($has_a_single_quote) {
        	$tline=~s/\'/, rec=/;
        }
    }
    if (not (exists $info->{'PrintCall'} or exists $info->{'AcceptCall'}) ) {
    	# Normalise by removing UNIT, NML and FMT
    	$tline=~s/(unit|nml|fmt)\s*=\s*//gi;
    }
    
    # Rather than having Attributes, Arguments and Expressions I will simply have Vars.Written and Vars.Read
    
#    say "TLINE: $tline";
    my $attrs_ast=[];
    my $exprs_ast=[];
    my $err=0;
    my $rest='';
    my $case=0;
    if ($tline=~/^\w+\s*\(/) {
        ($attrs_ast, $rest, $err) = parse_expression_no_context($tline,$info,$stref,$f);
        $case=1;
        if ($err) {        	
            # Case 2.
            $case=2;
            #The $rest string contains the part after the closing parens so just parse that as well
            $exprs_ast = parse_expression($rest,$info,$stref,$f);
        }  
    } else {
        # Case 3.
        $case=3;
        $tline=~s/^(\w+)\s*//;
        $tline="$1($tline)";
#		say "TLINE3: $tline";

        $attrs_ast = parse_expression($tline,$info,$stref,$f);
#		say Dumper($attrs_ast);
#		say "REST: $rest, ERR: $err";
        #say emit_expr_from_ast($attrs_ast);
    }
    #say Dumper($attrs_ast, $rest, $err);
    my $attr_pairs = $case == 3 ? {} : find_assignments_to_scalars_in_ast($attrs_ast,{});
    # This is not good enough because implied do is (v(i),i=i_start,i_stop)
    # So what I should so is say: if we have ',' and elt 1 is '=' then also consider elt 2 
    my $impl_do_pairs = $case<2 ? {} : find_implied_do_in_ast($exprs_ast,{});
#    say "LINE:$tline";
#    say Dumper($exprs_ast);
#    say "ATTR PAIRS: ".Dumper($attr_pairs);
#    say "IMPLIED DO PAIRS: ".Dumper($impl_do_pairs);
    $info->{'IOCall'}{'Args'} = { 'Set' => {}, 'List' => [ ] };
    $info->{'IOCall'}{'Args'}{'AST'}=$attrs_ast;
    $info->{'IOList'}{'AST'}=$exprs_ast;
    
    #    $info->{'CallAttrs'} = { 'Set' => $attrs_ast, 'List' => [ sort keys %{ $attrs_ast } ] };
    my $impl_do_vars_list = [ sort keys %{ $impl_do_pairs } ];
    
    # We must identify any parameters or vars in the start_loop and 
    my %impl_do_range_vars=();
        for my $impl_do_var ( @{ $impl_do_vars_list } ) {
        	my ($loop_start, $loop_end) = @{ $impl_do_pairs->{$impl_do_var} };
        my $loop_start_vars = find_vars_in_ast($loop_start,{});        
        my $loop_end_vars = find_vars_in_ast($loop_end,{});
        %impl_do_range_vars = ( %impl_do_range_vars, %{$loop_start_vars},%{$loop_end_vars} );        
    }
    $info->{'ImpliedDoVars'} = { 
        'Set' => $impl_do_pairs,
         'List' => $impl_do_vars_list 
    };
     $info->{'ImpliedDoRangeVars'} = { 
        'Set' => \%impl_do_range_vars,
         'List' => [sort keys %impl_do_range_vars] 
    };
    my $attrs_vars = get_vars_from_expression($attrs_ast,{} );
    $info->{'CallAttrs'} = { 'Set' => $attrs_vars, 'List' => [ sort keys %{ $attrs_vars } ] };
    my $exprs_vars = get_vars_from_expression($exprs_ast,{} );
    #my $vars = { %{ $attrs_vars }, %{ $expr_vars } };
    $info->{'ExprVars'} =  { 'Set' => $exprs_vars, 'List' => [ sort keys %{ $exprs_vars }] };    
    
    $info->{'Vars'}{'Written'}={'List'=>[],'Set'=>{}};
    $info->{'Vars'}{'Read'}={'List'=>[],'Set'=>{}};
    
    if ( exists $info->{'AcceptCall'} ) {
#    ACCEPT
		#- case 3
		#if grname add all vars to Written
		if ( ($attrs_ast->[0] & 0xFF) ==2 and exists   $Sf->{'Namelist'}{ $attrs_ast->[1] } ) {
			$info->{'Vars'}{'Written'}{'List'} = $Sf->{'Namelist'}{$attrs_ast->[1]};
			$info->{'Vars'}{'Written'}{'Set'} = map {$_=>1} @{ $info->{'Vars'}{'Written'}{'List'} };
		} else {
			# This must be the iolist case. First check for implied do; then call args_vars. All args are Written, the rest is Read
			(my $args, my $other_vars) = @{ find_args_vars_in_ast($exprs_ast)  };
			if (%{$impl_do_pairs}) {	
			for my $idv (sort keys %{$impl_do_pairs}) {
				if (exists $args->{'Set'}{$idv}) {
					delete $args->{'Set'}{$idv};
					@{$args->{'List'}} =  sort keys %{$args->{'Set'}}; 
				}
			}
			}
		    $info->{'Vars'}{'Written'}=$args;
		    $info->{'Vars'}{'Read'}=$other_vars;	
		    return $info;
		}
#else set all args in iolist to Read from and all vars to Written to
    } elsif ( exists $info->{'ReadCall'} ) {
	#READ
		#- all three cases
	
		#If case 1 we need to check the grname (2nd arg) and  add all vars to Read from
		if ($case==1) { # this means read ( ... ) so the AST is [1,'read',[ ...]]
			if ( ($attrs_ast->[2][0] & 0xFF)==2 and exists  $Sf->{'Namelist'}{ $attrs_ast->[2][1] } ) {
	            $info->{'Vars'}{'Written'}{'List'} = $Sf->{'Namelist'}{$attrs_ast->[2][1]};
	            $info->{'Vars'}{'Written'}{'Set'} = map {$_=>1} @{ $info->{'Vars'}{'Written'}{'List'} };
	        } 
	        if (exists $attr_pairs->{'iostat'}) {
	        	my $ios = $attr_pairs->{'iostat'}[1];
	        	$info->{'Vars'}{'Written'}{'Set'}{$ios}=1;
	        }
		} elsif ($case==2) {
			  #If case 2, add REC vars to Read from
			if (exists $attr_pairs->{'iostat'}) {
	            my $ios = $attr_pairs->{'iostat'}[1];
	            $info->{'Vars'}{'Written'}{'Set'}{$ios}=1;
	        }
	        if (exists $attr_pairs->{'rec'}) {
                my $rn = $attr_pairs->{'rec'}[1];
                $info->{'Vars'}{'Read'}{'Set'}{$rn}=1;
            }
	        # This must be the iolist case. First check for implied do; then call args_vars. All args are Written, the rest is Read
	            (my $args, my $other_vars) = @{ find_args_vars_in_ast($exprs_ast)  };
	            if (%{$impl_do_pairs}) {   
		            for my $idv (sort keys %{$impl_do_pairs}) {
		                if (exists $args->{'Set'}{$idv}) {
		                    delete $args->{'Set'}{$idv};
#		                    @{$args->{'List'}} =  sort keys %{$args->{'Set'}}; 
		                }
		            }
	            }
	            $info->{'Vars'}{'Written'}{'Set'}= {%{$args->{'Set'} }, %{$info->{'Vars'}{'Written'}{'Set'}}};
	            $info->{'Vars'}{'Written'}{'List'}= [sort keys %{ $info->{'Vars'}{'Written'}{'Set'} } ];
	            $info->{'Vars'}{'Read'}=$other_vars;
		} else {# $case==3
	    #If case 3, and more than one arg, process iolist as in ACCEPT		
  	# This must be the iolist case. First check for implied do; then call args_vars. All args are Written, the rest is Read
	            
	            (my $args, my $other_vars) = @{ find_args_vars_in_ast($exprs_ast)  };
	            if (%{$impl_do_pairs}) {      
	            for my $idv (sort keys %{$impl_do_pairs}) {
	                if (exists $args->{'Set'}{$idv}) {
	                    delete $args->{'Set'}{$idv};
	                    @{$args->{'List'}} =  sort keys %{$args->{'Set'}}; 
	                }
	            }
	            }
	            $info->{'Vars'}{'Written'}=$args;
	            $info->{'Vars'}{'Read'}=$other_vars;    
		}
#        croak $case.Dumper($info->{'Vars'}) if $line=~/read.*time/;
#carp Dumper($info->{'Vars'}) if $f eq 'ifdata' and $line=~/time/;
	} elsif ( exists $info->{'PrintCall'} ) {
	#PRINT
	#- case 3
	#if grname add all vars to Read from
	
	#else set all args in iolist to Read from and all vars to Read from
	# use 
        if ( ($attrs_ast->[0] & 0xFF) ==2 and exists   $Sf->{'Namelist'}{ $attrs_ast->[1] } ) {
            $info->{'Vars'}{'Read'}{'List'} = $Sf->{'Namelist'}{$attrs_ast->[1]};
            $info->{'Vars'}{'Read'}{'Set'} = { map {$_=>1} @{ $info->{'Vars'}{'Read'}{'List'} } };
        } else {
            # This must be the iolist case. First check for implied do; then call args_vars. All args are Written, the rest is Read
            my $vars = find_vars_in_ast($exprs_ast, {}  );
            if (%{$impl_do_pairs}) {    
            for my $idv (sort keys %{$impl_do_pairs}) {
                if (exists $vars->{'Set'}{$idv}) {
                    delete $vars->{'Set'}{$idv};
                    @{$vars->{'List'}} =  sort keys %{$vars->{'Set'}}; 
                }
            }
            }
            $info->{'Vars'}{'Read'}{'Set'}=$vars;
            # we do this later
#            $info->{'Vars'}{'Read'}{'List'}= [ sort keys %{ $info->{'Vars'}{'Read'}{'Set'} } ];                       
        }
         return $info;
	
	} elsif ( exists $info->{'WriteCall'} ) {
	#WRITE
	#case 1 and 2 
	if ($case==1) {
		#case 1, grname, Read from
		if ( ($attrs_ast->[0] & 0xFF) ==2 and exists   $Sf->{'Namelist'}{ $attrs_ast->[1] } ) {
            $info->{'Vars'}{'Read'}{'List'} = $Sf->{'Namelist'}{$attrs_ast->[1]};
            $info->{'Vars'}{'Read'}{'Set'} = { map {$_=>1} @{ $info->{'Vars'}{'Read'}{'List'} } };
        }
	}
	elsif ($case==2) {
    #case 2, iolist, Read from
    #If case 2, add REC vars to Read from
        if (exists $attr_pairs->{'rec'}) {
            my $rn = $attr_pairs->{'rec'}[1];
            $info->{'Vars'}{'Read'}{'Set'}{$rn}=1;
        }
		
            # This must be the iolist case. First check for implied do; then call args_vars. All args are Written, the rest is Read
            my $vars = find_vars_in_ast($exprs_ast, {}  );
            if (%{$impl_do_pairs}) {    
            for my $idv (sort keys %{$impl_do_pairs}) {
                if (exists $vars->{'Set'}{$idv}) {
                    delete $vars->{'Set'}{$idv};
                    @{$vars->{'List'}} =  sort keys %{$vars->{'Set'}}; 
                }
            }
            }
            $info->{'Vars'}{'Read'}{'Set'}=$vars;
                                   
	}	
	#If case 1 or 2, add IOSTAT var to Written to
	   if (exists $attr_pairs->{'iostat'}) {
                my $ios = $attr_pairs->{'iostat'}[1];
                $info->{'Vars'}{'Written'}{'Set'}{$ios}=1;
       }
	} elsif ( exists $info->{'InquireCall'} ) {
    	#INQUIRE    	
    	#Other args are all Written to except the ERR Label
        for my $attr (keys %{ $attr_pairs } ) {
        	if ($attr ne 'err') {
        	   my $attr_val = $attr_pairs->{$attr}[1]; # should always be the name of a $ or @
        	   $info->{'Vars'}{'Written'}{'Set'}{$attr_val}=1;
        	}
        }            	
    	
	} elsif ( exists $info->{'OpenCall'} ) {
		carp "TODO: parse OPEN call using new parser" if $DBG;
		#OPEN 
		#if unit has vars, add to Read from
		#
		#Read from:
		#UNIT
		#FILE = fn Name of the file being queried : character string
		#
		#ACCESS
		#BLANK
		#FORM
		#NAME
		#RECL
		#
		#FILEOPT = fopt : a character expression
		#READONLY 
		#ACTION = act : READ | WRITE | READWRITE
		#STATUS = sta or TYPE = sta : a character expression
		#
		#All args are all Read from except the ERR Label and IOSTAT
		#Add labels to ReferencedLabels
		#IOSTAT Written to
		#
	} elsif ( exists $info->{'CloseCall'} ) {
		carp "TODO: parse CLOSE call using new parser" if $DBG;
		#CLOSE
		#if unit has vars, add to Read from
		#All args are all Read from except the ERR Label and IOSTAT
		#Add labels to ReferencedLabels
		#IOSTAT Written to
	} elsif ( exists $info->{'RewindCall'} ) {
    #REWIND
#    say $case,Dumper($attrs_ast);
		if ($case==3) {
		# REWIND u
			if ($attrs_ast->[0] < 29) {
				 my $vars = find_vars_in_ast($exprs_ast, {}  );
	            $info->{'Vars'}{'Read'}{'Set'}=$vars;
			}
		} else {
        # REWIND ( [ UNIT=] u [, IOSTAT=ios ] [, ERR= s ])
            if (exists $attr_pairs->{'iostat'}) {
                my $ios = $attr_pairs->{'iostat'}[1];
                $info->{'Vars'}{'Written'}{'Set'}{$ios}=1;
            }
        } 
	} else {
		# I dont do TOPEN/TCLOSE/ENCODE/DECODE/TYPE 
		die 'ERROR: Unsupported IO call, probably not part of the FORTRAN 77 standard: '.$tline."\n";
	}    

    #Add labels to ReferencedLabels, WHY?
    if (exists $attr_pairs->{'err'}) {
        my $label= $attr_pairs->{'err'}[1];
        $Sf->{'ReferencedLabels'}{$label}=$label;
    }
    #if unit has vars, add to Read from
    if ( ($attrs_ast->[0] & 0xFF) <29 ) { # it's not a constant
    	my %unit_vars=();
    	if ( ($attrs_ast->[0] & 0xFF) == 27 ) { # a comma-sep list
    		if ( ($attrs_ast->[1][0] & 0xFF) < 29 ) { # first elt not a constant
    	       %unit_vars = %{ find_vars_in_ast($attrs_ast->[1],{}) };		
    		}
    	} else {
    		%unit_vars = %{ find_vars_in_ast($attrs_ast,{}) };
    	}
    		    	
    	if ( %unit_vars ) {
    	   $info->{'Vars'}{'Read'}{'Set'} = { %{ $info->{'Vars'}{'Read'}{'Set'} }, %unit_vars };
    	}     	
    }
# create the lists
    $info->{'Vars'}{'Read'}{'List'}= [ sort keys %{ $info->{'Vars'}{'Read'}{'Set'} } ];
    $info->{'Vars'}{'Written'}{'List'}= [ sort keys %{ $info->{'Vars'}{'Written'}{'Set'} } ];
#    carp Dumper($info->{'Vars'}) if $f eq 'ifdata' and $line=~/time/;
    return $info;

}    # END of _parse_read_write_print()

# -----------------------------------------------------------------------------
sub _parse_assignment {
	( my $line, my $info, my $stref, my $f ) = @_;
	
	my $code_unit = sub_func_incl_mod( $f, $stref );
	my $tline = $line;

	$tline =~ s/^\s*\d+//;    # remove labels
	$tline =~ s/^\s+//;       # remove blanks
	$tline =~ s/\s+$//;       # remove blanks

	( my $lhs, my $rhs ) = split( /\s*=\s*/, $tline );

	#     say "LHS: $lhs, RHS: $rhs";
	my $lhs_ast = parse_expression( $lhs, $info, $stref, $f );


	#	say 'ARGS: '.Dumper($lhs_args);
	#	say 'VARS:'.Dumper($lhs_vars)  if $lhs_ast->[1] eq 'len';
#	say $line . '=>'.$lhs.Dumper($lhs_ast);
	if (   exists $F95_reserved_words{ $lhs_ast->[1] }
		or exists $F95_intrinsics{ $lhs_ast->[1] } )
	{
		my $tmp_line = $line;
		$tmp_line =~ s/__PH\d+__/.../g;
		warning("Assignment to reserved word or intrinsic '"
		  . $lhs_ast->[1]
		  . "' at line\n\t'"
		  . $tmp_line
		  . "'\n\tin subroutine/function '$f' in '"
		  . $stref->{$code_unit}{$f}{'Source'}
		  . "'\n\tThis is DANGEROUS, please fix your code!",2);
		$stref->{$code_unit}{$f}{'MaskedIntrinsics'}{ $lhs_ast->[1] } = 1;
		$lhs_ast = parse_expression( $lhs, $info, $stref, $f );
	}

	# WV 2019-04-24 seems to me I could use get_vars_from_expression() as the LHS is either a scalar or an array access
	# That returns a href and we can just turn that into a list as usual
    # WV 2021-04-18 LHS can also an array without index 
	
    my $lhs_vars = get_vars_from_expression($lhs_ast);
    (my $lhs_varname, my $lhs_var_attrs)  =  each %{ $lhs_vars } ;
	my $lhs_index_vars={'List'=>[],'Set'=>{}};
	if (exists $lhs_var_attrs->{'IndexVars'}) {
		for my $maybe_idx_var (sort keys %{ $lhs_var_attrs->{'IndexVars'} } ) {
			if ($lhs_var_attrs->{'IndexVars'}{$maybe_idx_var }{'Type'} eq 'Scalar') {
				push @{$lhs_index_vars->{'List'}},$maybe_idx_var ;
				$lhs_index_vars->{'Set'}{$maybe_idx_var}= $lhs_var_attrs->{'IndexVars'}{$maybe_idx_var };
			}
		}		
	}	
	# carp Dumper($lhs_vars);
	my $array_constant=0;
	if ($rhs=~/\(\/.+\/\)/) {
		$rhs=~s/\(\//(/;
		$rhs=~s/\/\)/)/;
		$array_constant=1;
	}
	
	my $rhs_ast = parse_expression( $rhs, $info, $stref, $f );
	if ($array_constant==1) {
		$rhs_ast->[1]='_OPEN_CONST_ARRAY_';
	}

	#	say 'RHS_AST:'.Dumper($rhs_ast );
	# Same here, why not just use get_vars_from_expression() ?
#	( my $rhs_args, my $rhs_vars ) =
#	  @{ get_args_vars_from_expression($rhs_ast) };
    my $rhs_vars_set  = get_vars_from_expression($rhs_ast) ;
	#	say 'RHS_ARGS:'.Dumper($rhs_args);
	my $rhs_all_vars = {
		'Set'  => $rhs_vars_set,
		'List' => [ sort keys %{ $rhs_vars_set } ]
	};

	#{Lhs => {VarName, ArrayOrScalar, IndexExpr}, Rhs => {Expr, VarList}}
	if ( defined  $lhs_varname and defined $lhs_var_attrs) {
# check here if the var is declared as array!
		$info->{'Lhs'} = {
			'VarName'       => $lhs_varname,
			'IndexVars'     => $lhs_index_vars,
			'ArrayOrScalar' => $lhs_var_attrs->{'Type'},
			'ExpressionAST' => $lhs_ast
		};
	} else {
		croak 'SHOULD NOT HAPPEN: '.Dumper($lhs_ast) if $DBG;
		$info->{'Lhs'} = {
			'ArrayOrScalar' => 'Other',
			'ExpressionAST' => $lhs_ast
		};
	}
# Here also, check if any of these vars has been declared as array
	$info->{'Rhs'} = {
		'VarList'       => $rhs_all_vars,
		'ExpressionAST' => $rhs_ast
	};

	return $info;
}    # END of _parse_assignment()

# -----------------------------------------------------------------------------
# This matches anything of the form name ( ..., (...), ... )
sub _parse_array_access_or_function_call {
	( my $str, my $stop_after_outer_parens ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;
	my $outer_paren_closed=0;

	my $matched_str = '';
	for my $ch_idx ( 0 .. $nchars - 1 ) {
		my $ch = shift @chars;
		if ( $ch eq '(' ) {			
			if ( $ch_idx == 0 ) { # first char is a paren, give up
				unshift @chars, $ch;
				last;
			}
			$found_parens = 1; # found '(' not as first char
			++$parens_count;
		} elsif ( $ch eq ')' ) { # found ')'
			--$parens_count;
			if ( $parens_count == 0 ) {
				$found_parens = 0;
				$outer_paren_closed=1; 
			}
		} elsif ( $ch eq ',' and $found_parens == 0 ) { # a ',' outside the parens, give up
			unshift @chars, $ch;
			last;
		}
		$matched_str .= $ch;
		last if $found_parens == 1 and $parens_count == 0;
		last if $outer_paren_closed and $stop_after_outer_parens;
	}
	my $rest = join( '', @chars );
	return ( $matched_str, $rest );
}    # END of _parse_array_access_or_function_call()
# -----------------------------------------------------------------------------
sub _parse_IO_sub_call {
	( my $str ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;

	my $matched_str = '';
	for my $ch_idx ( 0 .. $nchars - 1 ) {		
		my $ch = shift @chars;
		if ( $ch eq ' ' or $ch eq "\t" ) {
			next;
		} elsif ( $ch eq '(' ) {
			if ( $ch_idx < 2 ) {
				unshift @chars, $ch;
				last;
			}
			$found_parens = 1;
			++$parens_count;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
		}
		if ( $found_parens == 1 and $parens_count == 0 ) {
			last;
		}
		$matched_str .= $ch;
	}
	my $rest = join( '', @chars );

	return ( $matched_str, $rest );
}    # END of _parse_IO_sub_call()
# --------------------------------------------------------------------------------
sub _parse_if_cond {
	( my $str ) = @_;

	my $parens_count = 1;
	
	
	my $open_paren_idx=index($str,'(');
	my $close_paren_idx=-1;


	for my $idx ($open_paren_idx+1 .. length($str)-1 ) {
		my $ch = substr($str,$idx,1);
		# skip blanks
		if ( $ch eq ' ' or $ch eq "\t" ) { 
			next;
		} elsif ( $ch eq '(' ) { 			
			++$parens_count;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
			if ($parens_count == 0) {
				$close_paren_idx=$idx;
				last;
			}
		}
	}
	my $cond = substr($str,$open_paren_idx+1, $close_paren_idx-$open_paren_idx-1);
	my $rest = substr($str, $close_paren_idx+1);
#	while(substr($rest,0,1) eq ' ') {
#		$rest = substr($rest,1);
#	}
#say $rest;
	$rest=~s/^\s*//;
	$rest=~s/\s*$//;
	return ($cond,$rest); 
} # END _parse_if_cond()

# --------------------------------------------------------------------------------
# Takes a string which contains a comma-separated list of expressions, returns a list of the expressions
sub _parse_comma_sep_expr_list {

	( my $str ) = @_;

	my $parens_count = 0;
	my $found_parens = 0;
	my @chars        = split( '', $str );
	my $nchars       = scalar @chars;

	my $matched_str  = '';
	my @matched_strs = ();

	for my $ch_idx ( 0 .. $nchars - 1 ) {
		my $ch = shift @chars;
		if ( $ch eq '(' ) {
			$found_parens = 1;
			++$parens_count;
			$matched_str .= $ch;
		} elsif ( $ch eq ')' ) {
			--$parens_count;
			if ( $found_parens == 1 and $parens_count == 0 ) {
				$found_parens = 0;
			}
			$matched_str .= $ch;
		} elsif ( $ch eq ',' and $found_parens == 0 ) {
			push @matched_strs, $matched_str;
			$matched_str = '';
		} elsif ( $ch ne ' ' ) {
			$matched_str .= $ch;
		}
		if ( $ch_idx == $nchars - 1 ) {
			push @matched_strs, $matched_str;
		}
	}
	return @matched_strs;
} # END of _parse_comma_sep_expr_list

# What we do is find the words in the value,
sub ___check_par_val_for_pars {
	( my $val ) = @_;
	return {} if $val =~ /^\d+$/;
	return {} if $val =~ /^[\'\"]/;
	return {} if $val =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;

	my @mpars = split( /\W+/, $val );
	my $pars_in_val = {};
	for my $mpar (@mpars) {
		next if $mpar =~ /^\d+$/;
		next if $mpar =~ /^[\'\"]/;
		next if $mpar =~ /^(\-?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$/;
		next if exists $F95_reserved_words{$mpar};
		next if exists $Config{'Macros'}{uc($mpar)}; # macros
		$pars_in_val->{$mpar} = 1;
	}

	#	say "PARS IN VAL:".Dumper($pars_in_val);

	return $pars_in_val;
}

sub __remove_blanks { (my $line, my $free_form)=@_;
	
	my $c1to6='';
	if (not $free_form) {
		$c1to6=substr($line,0,5);
		$line= substr($line,length($c1to6));
#		say  "C1TO6:".$c1to6;
	} elsif ($line=~/^(\s*\d+\s+)/  ) {
		$c1to6=$1;
#		say  "C1TO6:".$c1to6;
		$line= substr($line,length($c1to6)); 
	}
	
	
	my $indent = $line;
	$indent =~s/\S.*$//;
	if ($line=~/^do\s+/) {
		$line=~s/^do\s+//;
		$line=~s/\s+//g;
		$line = "do $line";
	} else {
		$line=~s/\s+//g;
	}	
	#FM351 
#	croak "INDENT IS WRONG!";
#	say "ASSIGN:".$c1to6.'|'.$indent.'|'.$line if $line=~/rvon01/;
	return  $c1to6.$indent.$line;
}

=info_data_declarations
data r1,r2,r3 /1.,2.,3./, array1 /1.,2.,3.,4./
data r4 /1.23456789012345d0/ ! correct initialization
data r5 /1.23456789012345/ ! loses precision
data array2 /arrsize*rinit/,q /(0.,0.)/
data (array3(l),l=1,10) /10*init/
data b /B'01101000100010111110100001111010'/
data o /O'15042764172'/
data z /Z'688be87a'/

DATA nlist / clist / [[,] nlist / clist /] …
nlist List of variables, arrays, array elements, substrings, and implied DO
lists separated by commas
clist List of the form: c [, c ] …
c One of the forms: c or r*c, and
c is a constant or the symbolic name of a constant.
r Nonzero, unsigned integer constant or the symbolic name of such
constant

Syntax
DATA data-stmt-set [[,] data-stmt-set] ...
Where:
data-stmt-set is object-list / value-list /
object-list is a comma-separated list of variable names or implied-dos.
value-list is a comma-separated list of [repeat *] data-constant
repeat is a scalar INTEGER constant.
data-constant is a scalar constant (either literal or named)
or a structure constructor.
implied-do is (implied-do-object-list , implied-do-var=expr, expr[, expr])
implied-do-object-list is a comma-separated list of array elements, scalar structure components,
or implied-dos.
implied-do-var is a scalar INTEGER variable.
expr is a scalar INTEGER expression.

If we ignore a DATA declaration for analysis. I guess nothing much happens. So why bother parsing this at all?
The answer: we need this if we want to do proper renaming.
But of course we can in principle do this without parsing, just rename whatever is there rather than looking for the variable names first.
This is of course slow. It would be better to get the variables.

=cut

sub _parse_data_declaration { (my $line,my $info, my $stref, my $f) = @_;
	
	my $new_annlines=[];
	my $indent =$line;$indent=~s/data.*$//;
	my $mline=$line;
    # Remove the DATA keyword
	$mline=~s/^data\s+//; 
	# Remove the trailing '/'
	$mline=~s/\/\s*$//;
	# Split on '/\s*,', 
	my @data_decl_ast=[];
	my @data_decl_pair_strs = split(/\/\s*,/,$mline);
	my $data_vars ={};
	for my $data_decl_pair_str (@data_decl_pair_strs ) {
		(my $nlist_str, my $clist_str) =split(/\s*\/\s*/,$data_decl_pair_str );
		my $nlist_ast = parse_expression($nlist_str,$info,$stref,$f);
		my $nlist_vars = find_vars_in_ast($nlist_ast);
		$data_vars = { %{$data_vars},%{$nlist_vars}};
		my $clist_ast = parse_expression($clist_str,$info,$stref,$f);
		my $info={};
		$info->{'NList'}{'AST'} = $nlist_ast;
		$info->{'CList'}{'AST'} = $clist_ast;
		$info->{'Data'}=1;
		$info->{'SpecificationStatement'} = 1;
		my $line= "$nlist_str / $clist_str /"; # TODO: this is not quite one var per DATA line but at least it is one pair per DATA line
		push @{$new_annlines}, [$line, $info];
	}
	my $data_vars_list = [sort keys %{$data_vars}];
	$info->{'Vars'}={'Set' =>$data_vars, 'List' => $data_vars_list};
	return $info;
		
} # END of _parse_data_declaration()


sub  _get_var_from_ast { (my  $ast ) = @_;
	my $var='';
	# The AST is always an array
	
	# If there is a length, we need the 2nd elt
	if (($ast->[0] & 0xFF) == 5) {
	# That elt can either be a scalar
	# or an array
		if (($ast->[1][0] & 0xFF) == 2) { # $
			$var= $ast->[1][1];
		} elsif (($ast->[1][0] & 0xFF) == 10) { # @
			$var= $ast->[1][1];
		} else {
			if($DBG){
				croak Dumper($ast);
			}
		}
	  
	} else {
		if( ($ast->[0] & 0xFF) == 2) {
			$var= $ast->[1];
		} elsif ( ($ast->[0] & 0xFF) == 10) {
			$var= $ast->[1];
        } elsif ( ($ast->[0] & 0xFF) == 1) {
        	warn "Variable $var is masking an intrinsic!";
            $var= $ast->[1];			
		} else {
			if($DBG){
			croak( ($ast->[0] & 0xFF).': '.Dumper($ast) ); 
			}
		}
	}
	return $var;
} # _get_var_from_ast()

sub  _get_var_from_ast_OLD { (my  $ast ) = @_;
	my $var='';
	# The AST is always an array
	
	# If there is a length, we need the 2nd elt
	if ($ast->[0] eq '*') {
	# That elt can either be a scalar
	# or an array
		if($ast->[1][0] eq '$') {
			$var= $ast->[1][1];
		} elsif ($ast->[1][0] eq '@') {
			$var= $ast->[1][1];
		} else {
			croak Dumper($ast) if $DBG;
		}
	  
	} else {
		if($ast->[0] eq '$') {
			$var= $ast->[1];
		} elsif ($ast->[0] eq '@') {
			$var= $ast->[1];
		} else {
			croak Dumper($ast) if $DBG;
		}
	}
	return $var;
}

sub  _get_len_from_ast { (my  $ast ) = @_;
	my $len='';
	if (($ast->[0] & 0xFF)==5) {
		# there is a len
		my $len_expr = $ast->[2];
	 # Worth a try, but not sure about '*' 		
		$len = emit_expr_from_ast($len_expr);
		return $len;

	} 
	return $len;	
}

# This code runs on any sub that has a Kernel region
# I could of course use this pass to enumerate all the subroutines, put them in KernelSubs 
# Or I can do a separate pass later to do just that task 
# WV20190523 Maybe this should go somewhere else, this is not parsing. Put it in Analysis::Blocks 
sub mark_blocks_between_calls { (my $stref)=@_;
	my $n_kernel_regions=0;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next unless exists $stref->{'Subroutines'}{$f}{'HasKernelRegion'};
		$n_kernel_regions++;
		if ($n_kernel_regions>1) {
			die "Sorry, only one ACC Kernel region is currently supported.\n";
		}
		
		my $in_kernel_region=0;
		my $in_block=0;
		my $nested_block='';
		my $index=0;
		my $extract_subs=0;
		my $called_subs = [];
		
		my $pass_actions = sub { (my $annline, my $state) = @_;
			(my $line, my $info)=@{$annline};
			
			(my $in_kernel_region, my $in_block, my $nested_block, my $index,my $extract_subs, my $called_subs)= @{$state};
			my $skip=0;
			if (exists $info->{'AccPragma'}{'BeginKernel'}) {
				$in_kernel_region=1;
				$skip=1; 		
				$info->{'Removed'}=1;
				$line=~s/\$//g;
				$annline=[$line,$info];
			}
			if (exists $info->{'AccPragma'}{'EndKernel'}) {
				$in_kernel_region=0;
				$skip=1;
				$info->{'Removed'}=1;
				$line=~s/\$//g;
				$annline=[$line,$info];
			}
			
			if ( $skip==0 and $in_kernel_region and not exists $info->{'Comments'} and not exists $info->{'Blank'} and not exists $info->{'Removed'}) {
					# if a line is relevant
			# if not a call, put a begin marker before it
				if (not exists $info->{'SubroutineCall'}) { #say $line."\t".Dumper($info);
					$in_block=1;
					my $begin_marker_line = '!$ACC Subroutine';
					(my $dummy, my $begin_marker_info) = __handle_acc({}, '',$index, $begin_marker_line, {});
					my $begin_marker_annline = [$begin_marker_line,$begin_marker_info];
					my $sub_name = $begin_marker_info->{'AccPragma'}{'BeginSubroutine'}[0];				

					if (exists $info->{'Block'}) {
						if ( not exists $info->{'EndControl'}) {
							push @{$called_subs}, $sub_name;
							$nested_block=$info->{'Block'}{'Type'}.$info->{'Block'}{'Nest'};
							return ([ $begin_marker_annline, $annline ], [$in_kernel_region,$in_block,$nested_block, $index++,$extract_subs, $called_subs] );
						} else {
							$nested_block='';
							return ([  $annline ], [$in_kernel_region,$in_block,$nested_block, $index++,$extract_subs, $called_subs] );
						}
					} else {
						push @{$called_subs}, $sub_name;
						return ([ $begin_marker_annline, $annline ], [$in_kernel_region,$in_block,$nested_block, $index++,$extract_subs, $called_subs] );
					}
					
					
				} else {
					my $sub_name = $info->{'SubroutineCall'}{'Name'};
					
					
					if ($in_block) {
						if ($nested_block eq '') {
							push @{$called_subs}, $sub_name;
							# if a call and $in_block and not nested, put an end marker before it
							$in_block=0;
							my $end_marker_line = '!$ACC End Subroutine';
							$extract_subs=1;
							(my $dummy, my $end_marker_info) = __handle_acc({}, '',$index, $end_marker_line, {});
							my $end_marker_annline = [$end_marker_line , $end_marker_info ];	
							return ( [ $end_marker_annline, $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
						} else {
							return ( [ $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
						}
					} else {
						push @{$called_subs}, $sub_name;
						return ( [ $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
					}	
				}	
			} else {
				return ([ $annline ], [$in_kernel_region,$in_block,$nested_block, $index,$extract_subs,  $called_subs] );
			}
		};
		
		($stref, my $state) = stateful_pass_inplace ($stref,  $f,  $pass_actions,  [$in_kernel_region,$in_block, $nested_block, $index,$extract_subs,$called_subs], 'mark_blocks_between_calls' );
		($in_kernel_region,$in_block, $nested_block,$index,$extract_subs,$called_subs)=@{$state};
		
		$stref->{'Subroutines'}{$f}{'HasBlocks'}=$extract_subs;
		if ($extract_subs) {
			$stref->{'Subroutines'}{$f}{'AnnLines'}=$stref->{'Subroutines'}{$f}{'RefactoredCode'};
		}
		$stref->{'KernelSubs'}=$called_subs;		
	}	
	return $stref;
} # END of mark_blocks_between_calls


sub _get_var_recs_from_parse_tree { (my $tpt, my $vspt)=@_;
	my $type;
	my $attr='';
	my $attr_name='kind';
	my $dims=[];
	my @decls=();
	my $var_name;
	my $array_or_scalar='Scalar';

	my $var_decls={};
	my $var_lst=[];
	# carp Dumper($tpt, $vspt);
	# type part
	if ($tpt->[0] == 5) { # '*'
		# set the type 
		if ($tpt->[1][0] == 2 ) { # '$'
		# set the type
			$type = $tpt->[1][1];
		}
		# set the attribute
		if ($tpt->[2][0] == 0) { # ( ... )
			# Emit this and use as attr
			if ($tpt->[2][1][0] == 32 and $tpt->[2][1][1] eq '*') {
				$attr = '*';
			} else {
			$attr = emit_expr_from_ast($tpt->[2]);
			}
		} 
		elsif  ($tpt->[2][0] == 29) {
			# take the value
			$attr = $tpt->[2][1];
		}

	} elsif ($tpt->[0] == 1 ) { # i.e. character(len=...)
		$type = $tpt->[1];
		if ($tpt->[2][0] == 9) {
			$attr =  emit_expr_from_ast($tpt->[2][2]);
		} else {
			$attr =  emit_expr_from_ast($tpt->[2]);
		}
	} elsif ($tpt->[0] == 2 ) { # '$', so no attribute. Means attributes are per-var
		# set the type
		$type = $tpt->[1];  
		
	}

	if ($type eq 'character') {$attr_name='len'};

	
	# vars part
	my @vpts=();
	## first transform into a plain list
	if ($vspt->[0] ==27) { # comma-sep list
		#    say Dumper($vspt);
		shift @{$vspt};
		@vpts=@{ $vspt };#->[1 .. (scalar( @{$vspt}) -1)] };
	} else { # single elt
		@vpts = ( $vspt );
	}
	## then

	for my $vpt (@vpts) {
		# it can be either a scalar, an array, or an expression with '*' and a scalar or array
		my $tvpt=$vpt;
		
		if ($vpt->[0] == 5) {
			# means there is a '*', so get both parts
			# one of the parts again can be a scalar or an array
			if ($vpt->[1][0] == 29) { # this is the string 'integer'
				$tvpt=$vpt->[2];
				# get the attr
				$attr = $vpt->[1][1];
			} elsif ($vpt->[2][0] == 29) {
				$tvpt=$vpt->[1];
				# get the attr
				$attr = $vpt->[2][1];
			}  elsif ($vpt->[1][0] == 2) {
				# the part before the * is a scalar, get it
				# e.g.  
				# character fnamei*(*)
				$var_name = $tvpt->[1][1];
				# croak $var_name;
			}
		} 
		if ($tvpt->[0] == 2) {
			# get the name and create the decl
			$var_name = $tvpt->[1];
		}
		elsif ($tvpt->[0] == 1) { # The array will be '&' so 1
			# it's an array, get the dim.
			$array_or_scalar='Array';
			# dim part
			my @dpts=();
			# first transform into a plain list
			if ($tvpt->[2][0] ==27) { # comma-sep list
				shift @{ $tvpt->[2] };
				@dpts=@{ $tvpt->[2] } ;#[1.. scalar @{$tvpt->[2][0]} -1]};
			} else { # single elt
				@dpts = ( $tvpt->[2] );
			}
			## then for each of these, check if it is a ':'
			for my $dpt (@dpts) {
				my $tdim=[];
				if ($dpt->[0] == 12) { #':'
					# take both parts, use directly if integer or variable
					# emit of expression
					$tdim=[emit_expr_from_ast($dpt->[1]), emit_expr_from_ast($dpt->[2])];

				} else {
					# part 1 is a 1, only use part 2
					$tdim=[1, emit_expr_from_ast($dpt)];
				}
				push @{$dims},$tdim;
			}

			# then get the name and create the decl
			$var_name = $tvpt->[1];
		}
		my $decl={
			'Name'=>$var_name,
			'Type'=>$type,
			'Attr'=> $attr ? $attr_name.'='.$attr : '',
			'Dim'=>$dims,
			'ArrayOrScalar' => $array_or_scalar
		};
		
		push @{$var_lst}, $var_name;
		$var_decls->{$var_name}=$decl;
		$dims=[];
	}

	return ($var_decls, $var_lst);
} # END of _get_var_recs_from_parse_tree 


sub _parse_F77_decl_NEW { (my $decl_str)=@_;

        my ($parse_tree_type, $rest, $err) = parse_expression_no_context($decl_str);
        (my $parse_tree_vars, $rest, $err) = parse_expression_no_context($rest);
        
        (my $var_recs, my $var_lst) = _get_var_recs_from_parse_tree($parse_tree_type, $parse_tree_vars);
                
        return ($var_recs, $var_lst);
    

} # END of _parse_F77_decl_NEW

# We have to parse the include files to get the COMMON variables because of EQUIVALENCE 
sub __parse_include_statement { my ($stref, $f, $sub_incl_or_mod, $Sf, $line, $info, $index) = @_;
	$Sf->{'HasIncludes'}=1;
	my $name = $info->{'Includes'};
	print "FOUND include $name in $f\n" if $V;
	$Sf->{'Includes'}{$name} = { 'LineID' => $index };

	$info->{'Include'} = {};
	$info->{'Include'}{'Name'} = $name;
	$stref->{'IncludeFiles'}{$name}{'IncludedFrom'}{$f}=$sub_incl_or_mod;
	if ( $stref->{'IncludeFiles'}{$name}{'Status'} == $UNREAD ) {
		say $line if $V;
		# Initial guess for Root. 
		$stref->{'IncludeFiles'}{$name}{'Root'}      = $f;
		$stref->{'IncludeFiles'}{$name}{'HasBlocks'} = 0;
		$stref = parse_fortran_src( $name, $stref );
	} else {
		say $line, " already processed" if $V;
		# Not quite sure about this, 
		if ($stref->{'IncludeFiles'}{$name}{'Status'} == $FILE_NOT_FOUND
		and $stref->{'IncludeFiles'}{$name}{'InclType'} ne 'External'
		){
			warn "Status for Include $name is FILE NOT FOUND";
		}
	}

	if (    exists $stref->{'Implicits'}
		and exists $stref->{'Implicits'}{$name} )
	{
		print "INFO: inheriting IMPLICITS from $name in $f\n" if $I;
		if ( not exists $stref->{'Implicits'}{$f} ) {
			$stref->{'Implicits'}{$f} =
			  $stref->{'Implicits'}{$name};
		} else {
			for my $k ( keys %{ $stref->{'Implicits'}{$name} } ) {
				if ( not exists $stref->{'Implicits'}{$f}{$k} ) {
					$stref->{'Implicits'}{$f}{$k} =
					  $stref->{'Implicits'}{$name}{$k};
				} else {
					die "ERROR: $f and $name have different type for $k";
				}
			}
		}
	}


	# The include has been parsed.
	if ( exists $stref->{'IncludeFiles'}{$name} )
	{    # Otherwise it means it is an external include
		 # 'Parameters' here is OK because the include might contain other includes
		$Sf->{'IncludedParameters'} =
		  append_to_set( $Sf->{'IncludedParameters'},
			$stref->{'IncludeFiles'}{$name}{'Parameters'} );
			
		if (exists $stref->{'IncludeFiles'}{$name}{'Includes'}) {
			for my $param_inc (keys %{ $stref->{'IncludeFiles'}{$name}{'Includes'} } ) {
		$Sf->{'IncludedParameters'} =
		  append_to_set( $Sf->{'IncludedParameters'},
			$stref->{'IncludeFiles'}{$param_inc}{'Parameters'} );
				
			}
		}
	}
	
	say "DONE PARSE INCLUDE $name" if $V;
	return $info;
} # END of __parse_include_statement

# This should be a Set + List
sub _get_var_val_pairs { my ($ast) = @_;

	my $var_val_pairs = {'List'=>[], 'Set'=>{}};
	# So either this is a comma-sep list [',', ['=',k1,v1],...]
	# or it is a single assignment ['=',k1,v1]
	if ($ast->[0] == 27) {
		shift @{$ast};
	} else {
		$ast = [$ast];
	}
	for my $var_val_ast (@{$ast}) {
		# say Dumper($var_val_ast);
		my $var = $var_val_ast->[1][1]; # because k1 is ['$', var1]
		my $val_ast = $var_val_ast->[2]; # the ast
		push @{ $var_val_pairs->{'List'}}, $var ;
		$var_val_pairs->{'Set'}{ $var}  = { 'AST' =>$val_ast, 'Expr' => emit_expr_from_ast($val_ast) };
	}
	
	return $var_val_pairs;
}


sub __get_params_from_dim { my ($decl, $Sf)=@_;
	my $dim=$decl->{'Dim'};
	if (scalar @{$dim}>=1) {
		for my $dimpair (@{$dim}) {
			for my $mexpr ( @{$dimpair} ) {
				my @mpars = split(/\W+/, $mexpr);
				for my $mpar (@mpars) {
					if (defined $mpar and in_nested_set($Sf,'Parameters',$mpar) ) {
						my $subset = in_nested_set($Sf,'Parameters',$mpar);
						my $pdecl = get_var_record_from_set($Sf->{$subset},$mpar);
						
						$decl->{'InheritedParams'}{'Set'}{$mpar}=$pdecl;
						croak  if $DBG and ref($pdecl) ne 'HASH';
					}				
				}
			}
		}
	} 	
	return $decl;
} # END of __get_params_from_dim

1;



=pod

sub new_logic {
	
	
# The problem with this logic is that we need to add some info to see which line should be kept.
# The only way to do this is to annotate the type lines with info passed via the type record
# So we add an entry "Stmts" which starts out as 0 and which we increment and store in $info (after splitting the lines!
# Then the second pass keeps the line with Stmts==1 and marks the others for deletion
# This is actually also the right thing to do for parameters I think.

	
# DIMENSION (D)
if (not in_nested_set( $Sf, 'Vars', $varname ) ) {   
    $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredCommonVars' 
        or in_nested_set( $Sf, 'Vars', $varname ) eq 'ExGlobArgs' 
        ) {
# So it's a Declared Common (i.e. prev. was C, TC, CT
# Get the dimension
# Update Decl 
$Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredOrigLocalVars') {
# Means there was a T before
# Update Decl 

} else {
# Should be impossible
}


# COMMON (C)
if (not in_nested_set( $Sf, 'Vars', $varname ) ) {   
    $Sf->{'DeclaredCommonVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredOrigLocalVars' 
        ) {
# So it's a Declared Orig Local (i.e. prev. was D, T, DT or TD
# Update Decl 
# Change from DeclaredOrigLocalVars to DeclaredCommonVars and copy to ExGlobArgs
} else {
# Should be impossible
}

# TYPE DECL (T), actually this is identical to D in terms of the logic
if (not in_nested_set( $Sf, 'Vars', $varname ) ) {   
    $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$varname}=$decl;
} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredCommonVars' 
        or in_nested_set( $Sf, 'Vars', $varname ) eq 'ExGlobArgs' 
        ) {
# So it's a Declared Common (i.e. prev. was C, DC, CD
# Update Decl 

} elsif (in_nested_set( $Sf, 'Vars', $varname ) eq 'DeclaredOrigLocalVars') {
# Update Decl 

} else {
# Should be impossible
}
	
	
	
	
}

=cut


