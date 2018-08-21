package RefactorF4Acc::Main;
# 
#   (c) 2010-now Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   

use 5.010;

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Getopt::Std;

use Carp;
use Data::Dumper;
$Data::Dumper::Indent = 1;
$Data::Dumper::Terse = 0;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;

use RefactorF4Acc::State qw( init_state );
use RefactorF4Acc::Inventory qw( find_subroutines_functions_and_includes );
use RefactorF4Acc::Parser qw( parse_fortran_src build_call_graph mark_blocks_between_calls refactor_marked_blocks_into_subroutines );
use RefactorF4Acc::CallTree qw( create_call_tree );
use RefactorF4Acc::Analysis qw( analyse_all );
use RefactorF4Acc::Refactoring qw( refactor_all );
use RefactorF4Acc::Emitter qw( emit_all );
use RefactorF4Acc::Builder qw( create_build_script build_executable );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_variable_analysis );

use vars qw( $VERSION );
$VERSION = "1.0.0";

use Exporter;

@RefactorF4Acc::Main::ISA = qw(Exporter);
@RefactorF4Acc::Main::EXPORT = qw( &main );

our $usage = "
    $0 [-hvwicCNg] <toplevel subroutine name> 
       [<subroutine name(s) for C translation>]
    Typical use: rf4a -c ./rf4a.cfg -g -v -i main   
    -h: help
    -w: show warnings 
    -v: verbose (implies -w)
    -i: show info messages
    -d: show debug messages
    -c <cfg file name>: use this cfg file (default is ~/.rf4a)
    -C: Only generate call tree, don't refactor or emit
    -g: refactor globals inside toplevel subroutine 
    -b: Generate SCons build script
    -B: Build the generated code
    -A: Annotate the refactored lines 
    -P: Name of pass to be performed
    \n";
#    -N: Replace CONTINUE by CALL NOOP    

our @unit_tests= (1,2,3,4,5,6,7,8);
our @test_descs =qw(
find_subroutines_functions_and_includes
parse_fortran_src
refactor_marked_blocks_into_subroutines
build_call_graph
analyse_all
refactor_all

emit_all
);


# -----------------------------------------------------------------------------

=pod

=begin markdown

## Main subroutine

The `main()` subroutine performs following actions:

- Argument parsing
- `init_state()`: Initialise the global state
- `find_subroutines_functions_and_includes()`: Find all subroutines, functions and includes (from now on, 'targets') in the source code tree. 
The subroutine creates an entry in the state for every target:

        $stref->{$target_type}{$target_name}{'Source'}  = $target_source;
        $stref->{$target_type}{$target_name}{'Status'}  = $UNREAD;
        
- Parsing: `parse_fortran_src()` :

    - Read the source and do some minimal processsing 
    
            $stref = read_fortran_src( $f, $stref );
        
    - Parse the type declarations in the source, create a table `%vars`
    - Get variable declarations unless the target is a function 
    - Parse Subroutines & Functions
    
            $stref = detect_blocks( $f, $stref );     
            $stref = parse_includes( $f, $stref );        
            $stref = parse_subroutine_and_function_calls( $f, $stref );
            
        Set Status to PARSED    
    - Parse Includes: parse common blocks and parameters, create `$stref->{'Commons'}`
    
            $stref = get_commons_params_from_includes( $f, $stref );
        
- Analysis: `analyse_all()` : 
This routine analyses the code for goto-based loops and breaks, so that we can rewrite those horrible `DO`-blocks as proper loops. 

        $stref = analyse_all($stref);

- Refactoring: `refactor_all()`:

- Emit the refactored source:

        if ( not $call_tree_only ) {
            emit_all($stref);
        }
    
- Create build script:
    
	    create_build_script($stref);
	    if ($build) {
	        build_executable();
	    }
    
- Done.
    
    exit(0);

    
=end markdown

=cut

sub main {
	(my $unit_test_list)=@_;
		
	(my $subname, my $subs_to_translate, my $gen_scons, my $build, my $call_tree_only, my $pass) = parse_args();
	
	#  Initialise the global state.
	my $stref = init_state($subname);
    $stref->{'SubsToTranslate'}=$subs_to_translate;
    
	# 1. Inventory: Find all subroutines in the source code tree
	
	$stref = find_subroutines_functions_and_includes($stref);
	if ($V) {
		for my $sub (sort keys %{ $stref->{'Subroutines'} }) {
			say $sub,"\t=>\t",$stref->{'Subroutines'}{$sub}{'Source'};
		}
	}

    # 2. Parser: Parse the source
    for my $data_block (keys %{ $stref->{'BlockData'} } ) {
    	$stref = parse_fortran_src( $data_block, $stref );
    }
	$stref = parse_fortran_src( $subname, $stref );
	
	$stref = mark_blocks_between_calls( $stref );
	
	$stref = refactor_marked_blocks_into_subroutines( $stref );

	if ( $call_tree_only  ) {
		$stref->{'PPCallTree'}=[];
		$stref=create_call_tree($stref,$subname);
		map {print $_}  @{ $stref->{'PPCallTree'} };
		exit(0);
	}

	$stref = build_call_graph($subname, $stref);
	
    # 3. Analysis: Analyse the source
    my $stage=0;
    
	$stref = analyse_all($stref,$subname, $stage);

			 
    # 4. Refactoring: Refactor the source    
    # - if a pass is given using -P on command line, it is performed instead of the default refactoring
    # - multiple passes can be comma-separated
        
	$stref = refactor_all($stref,$subname, $pass);

	# 5. Emitter: Emit the refactored source
	
	if ( not $call_tree_only ) {
		emit_all($stref);
	}

	if ( $translate == $YES ) {
	    # Here we could actually call the genOclKernelFromF95Src script

		$translate = $GO;
		for my $subname ( keys %{ $stref->{'SubsToTranslate'} }) {
			print "\nTranslating $subname to OpenCL C\n";
			$gen_sub  = 1;
		}
	}

	# 6. Builder: Build and run the generated code
	# - create an SCons build script
	if ($gen_scons) {
	   create_build_script($stref);
	}
	# - build the code
	if ($build) {
		build_executable();
	}
	
	exit(0);

}    # END of main()
# -----------------------------------------------------------------------------
sub parse_args {
 	# Argument parsing. Factor out!
	if ( not @ARGV ) {
		die "Please specifiy FORTRAN subroutine or program to refactor\n";
	}
	my %opts = ();
	getopts( 'vwidhACTNgbBGc:P:', \%opts );
	
	my $help = ( $opts{'h'} ) ? 1 : 0;
    if ($help) {
        die $usage;
    }
	
	my $cfgrc= $ENV{HOME}.'/.rf4a';
    if (-e './rf4a.cfg') {
        $cfgrc='./rf4a.cfg';
    }
    if ($opts{'c'}) {
         $cfgrc= $opts{'c'} ;
    } 
	read_rf4a_config($cfgrc);
	
	my $subname = $ARGV[0];
	if ($subname) {
		$subname =~ s/\.f(?:90)?$//;
	} elsif (exists $Config{'TOP'}) {
		$subname = $Config{'TOP'};
	} else {
		die "No default for toplevel subroutine (TOP) in rf4a.cfg, please specify the toplevel subroutine on command line\n"; 
	}
    
    if ( exists $Config{'NEWSRCPATH'}) {
        $targetdir =  $Config{'NEWSRCPATH'};
    }   
    
    my $pass =  $opts{'P'} // '';
    
    $ANN = ( $opts{'A'} ) ? 1 : 0;
    
	$V = ( $opts{'v'} ) ? 1 : 0;
	$I = ( $opts{'i'} ) ? 1 : 0;
	$W = ( $opts{'w'} ) ? 1 : 0;
	$DBG = ( $opts{'d'} ) ? 1 : 0;
	$NO_ONLY = (exists $Config{'NO_ONLY'}[0] ) ? $Config{'NO_ONLY'}[0] : $NO_ONLY;
	$SPLIT_LONG_LINES = (exists $Config{'SPLIT_LONG_LINES'}[0] ) ? $Config{'SPLIT_LONG_LINES'}[0] : $SPLIT_LONG_LINES;
	$MAX_LINE_LENGTH = (exists $Config{'MAX_LINE_LENGTH'}[0] ) ? $Config{'MAX_LINE_LENGTH'}[0] : $MAX_LINE_LENGTH;
	$RENAME_EXT = (exists $Config{'RENAME_EXT'}[0] ) ? $Config{'RENAME_EXT'}[0] : $RENAME_EXT;
	$EXT = (exists $Config{'EXT'}[0] ) ? $Config{'EXT'}[0] : $EXT;
	$LIBS = (exists $Config{'LIBS'} ) ? $Config{'LIBS'} : $LIBS;
	$LIBPATHS = (exists $Config{'LIBPATH'} ) ? $Config{'LIBPATH'} : $LIBPATHS;
	$INCLPATHS = (exists $Config{'INCLPATH'} ) ? $Config{'INCLPATH'} :
		(exists $Config{'F95PATH'} ) ? $Config{'F95PATH'} : $INCLPATHS;
	$CFG_refactor_toplevel_globals = (exists $Config{'REFACTOR_TOPLEVEL_GLOBALS'}) ? 1 : 0 	;
	$CFG_refactor_toplevel_globals=( $opts{'g'} ) ? 1 : $CFG_refactor_toplevel_globals; # Global from Config
# Currently broken	
	if ( $opts{'G'} ) {
		print "Generating docs...\n";
		generate_docs();
		exit(0);
	}
	
	if ( $opts{'C'} ) {
		$call_tree_only = 1;
		$main_tree = $ARGV[1] ? 0 : 1;		 
	}
# OBSOLETE, use $!RF4A pragma instead	
	my %subs_to_translate = ();
	if ( $opts{'T'} ) {
		if ( !@ARGV ) {
		}
		$translate = 1;
		%subs_to_translate = map { $_ => 1 } @ARGV[ 1, -1 ];
	}
# Currently broken
	my $build = ( $opts{'B'} ) ? 1 : 0;
    my $gen_scons = ( $opts{'b'} ) ? 1 : 0;
    if ($build) { 
        $gen_scons = 1;
    }
	return (lc($subname),\%subs_to_translate,$gen_scons,$build,$call_tree_only, $pass);
} # END of parse_args()

=head1 SYNOPSIS

This is a source-to-source compiler for Fortran 77 and Fortran 90/95, for the purpose of automatically refactoring legacy code to work with OpenCL.
 
=head1 USAGE

   rf4a [-hvwicCNg] <toplevel subroutine name> 

A typical usage would be 

   rf4a -c ../rf4a.cfg -N -g main
   
This will perform the refactoring on all routines starting from a subroutine called 'main' (usually the main program).      

=head1 OVERVIEW


=head1 NAMING CONVENTIONS

The data structure storing all information about the code base is `$stref`. 
Subroutine/function names are `$f`.
Code units can be 

  $code_unit = Subroutine|Function|Include|Module

To access information for a particular code unit we use `$Sf`:
  
  $Sf = $stref->{$code_unit}{$f}

The lines of source code are stored as pairs `[$line,$info]` in
 
  $annlines = $Sf->{AnnLines}

The annotations are in a hash `$info`. 

Most subroutines return $stref.


=head1 TODOs

* Subroutine args marked as InOut can actually be In if the value is never used. We should check that!
"Never used" means that we have to check against all calls to the subroutine. 
As I am interested in factored-out routines, I will focus on single-call routines.
- If an argument is marked as InOut 
    - if the actual value is an expression, set to In
    - if the actual value is a local variable and it is not read after the call to the subroutine, set to In
        This is more complicated: 
        1. determine it's a local variable, i.e. not in the caller argument list. OK
        2. look if it occurs after the call to the subroutine => need to parse all lines

* Remap scalar arguments into arrays to have fewer arguments to pass -> mostly done, but not complete
What is needed is not just a merge for scalars, but also for arrays    
  
=begin markdown

# FORTRAN Refactoring Tool |$VER|

\copyright  Wim Vanderbauwhede, 2010-2012 

## SYNOPSIS

    |$usage|
    
## DESCRIPTION

The purpose of this tool is to refactor FORTRAN code by automatically performing the following transformations:

- Replace all `common` block variables by subroutine arguments.
- Factor out marked blocks of code into subroutines
- Resolve name conflicts between parameters, local variables and function arguments
- Rewrite label-based loops into DO-loops
- Normalise the code to lowercase and 6-spaces based layout
    
Furthermore, the tool preforms a number of operations intended to facilitate translation to C:

* Replace `continue` statements by calls to a no-op routine
* Analyse which `goto`'s can be replaced by `break` statements in C
* Analyse the IO direction and type of all subroutine arguments
     
It is designed to work on large FORTRAN programs, split over multiple files, written in a mixture of FORTRAN 77 and FORTRAN 95.        

## DESIGN

Because the aim of the tool is to refactor the source code, and not to translate or compile it, we don't use a full grammar-based lexer and parser but instead we perform context-free parsing using regular expressions. 
As in many cases we require the context to analyse the parsed data, the program maintains a global state with the following structure:

    State
        Top -- Toplevel sub name 
        Nodes -- A node represents a call to a subroutine or function. 
                 For each node ID, store ID of parent & children and the sub name
        NId -- Current node ID, for traversal
        CallTree -- The call tree as a list of indented strings. #TODO make more generic and add a pretty-printer
        Indents -- used during traversal for counting the indentation level
        Subroutines -- A map with for subroutine name, following entries:
            Source -- Source file name for the subroutine
            AnnLines -- The source per line, split lines have been merged, with information about each line            
            Blocks -- Blocks marked for refactoring into subroutines
            HasBlocks -- Boolean: does this sub contain blocks?
    *       Args -- subroutine arguments
            Includes -- This is a map { name => index }, used as a set 
    *       Vars -- all declared variables. 
            Parameters
            CalledSubs -- Another map-used-as-set of all subs called in the sub  
            Status -- UNREAD,READ,PARSED,FROM_BLOCK,C_SOURCE
    *       Globals -- For every include, a list of its /common/ vars used in the sub             
    *       CommonIncludes -- A set of includes that contain /common/ vars
    *       Commons -- Like Globals, but for every var it has Type, Kind, Shape, IODir
    *       HasCommons -- Boolean, if TRUE we need to refactor /common/ vars         
            ConflictingParams -- List of parameters that conflict with global variables 
            StringConsts -- String constants are replaced by placeholders 
                            and stored in this map
            Gotos -- Set of labels for which a 'goto' exists
    *       Program -- Boolean, if TRUE this sub is a program
            Called -- Boolean, if TRUE this sub is called in other subs 
    *       RefactoredArgIODirs -- IO dir for every refactored arg #TODO: make this RefactoredArgs -> IODirs, List, ...
    *       RefactoredArgList -- List of all refactored args 
            RefactoredCode -- refactored source, line by line, long lines are split
        Functions -- Same as Subroutines, but for Functions #TODO: maybe we could simply have a flag "IsFunction" in Subroutines?
            Source            
            AnnLines  
            Vars          
            Parameters
            [Blocks]
            HasBlocks            
            Includes            
            CalledSubs
            Status      
            StringConsts
            [Gotos]
            Called
            RefactoredCode      
        IncludeFiles -- Similar as Subroutines/Functions but for Includes
            Source
            AnnLines            
            Vars            
            Parameters
            Status            
    *       Type -- Common or Parameter
    *       Root -- highest subroutine in the call tree for every include
            Commons 
    *       ConflictingGlobals -- List of global variables that conflict with other vars or params
            RefactoredCode
        BuildSources    

=end markdown
=cut

# $test_subref is the actual test, $fail_subref is a routine that takes $stref and returns whatever you want to return on failure.
sub test { (my $test_num, my $stref, my $test_subref, my $fail_subref) = @_;
	return;
	my %unit_tests_map = map {$_=>1} @unit_tests; # These are the ids of the tests to run		
	my $last_test = [sort {$b <=> $a} @unit_tests]->[0];	
	if (exists $unit_tests_map{$test_num}) {
		my $res=  $test_subref->($stref);	
		if ($res eq 'FAIL') {
			my $output = $fail_subref->($stref);			
			if (ref($output) eq 'HASH' or ref($output) eq 'ARRAY') {  
				die "! Test ".$test_descs[$test_num-1].": $res\n".Dumper( $output );
			} else {
				die "! Test ".$test_descs[$test_num-1].": $res\n\n".$output."\n" ;
			}
		} else {
			say "! Test $test_num: ".$res;
		}	 
		die if $last_test==$test_num;
	}	
}

1;