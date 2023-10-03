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
use RefactorF4Acc::Parser qw( parse_fortran_src build_call_graph mark_blocks_between_calls );
use RefactorF4Acc::Refactoring::Blocks qw( refactor_marked_blocks_into_subroutines );
use RefactorF4Acc::CallTree qw( create_call_tree );
use RefactorF4Acc::Preconditioning qw( precondition_includes precondition_decls precondition_subroutines_with_includes );
use RefactorF4Acc::Analysis qw( analyse_all );
use RefactorF4Acc::Refactoring qw( refactor_all );
use RefactorF4Acc::CustomPasses qw( run_custom_passes );
use RefactorF4Acc::Emitter qw( emit_all emit_AnnLines );
use RefactorF4Acc::Builder qw( create_build_script build_executable );
use RefactorF4Acc::Analysis::LoopDetect qw( outer_loop_variable_analysis );

use vars qw( $VERSION );
$VERSION = "2.1.1";

use Exporter;

@RefactorF4Acc::Main::ISA = qw(Exporter);
@RefactorF4Acc::Main::EXPORT = qw( &main &usage );

our $usage = "
    $0 [-hVvwicCNg] <toplevel subroutine name>
       [<subroutine name(s) for C translation>]
    Typical use: refactorF4Acc.pl -c ./custom_rf4a.cfg -w
    -h: help
    -V: print the version number
    -w <level>: show warnings, levels 0 (none) to 3 (most). default level = 1,
    -v: verbose (implies -w)
    -i: show info messages
    -d: show debug messages
    -c <cfg file name>: use this cfg file (default is ./rf4a.cfg, or a global ~/.rf4a)
    -I: Inline all include files. Use this if include files are not self-contained and can't be turned into modules
    -C: Only generate call tree, don't refactor or emit
    -b: Generate SCons build script
    -B: Build the generated code
    -A: Annotate the refactored lines
    -P: Name of pass to be performed
    -S: Show code to be emitted
    -s: Provide a comma-separated list of source files to be refactored. Same as specifying SOURCEFILES in the config file
    -o: Provide a custom output path
    \n";
#    -N: Replace CONTINUE by CALL NOOP
    # -g: refactor globals inside toplevel subroutine (NOTE: in the current version this does nothing, globals will always be refactored)

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
    # $args is a hash with the same structure as %opts for getopts
    # $stref_init is the initial state, usually carried over from a previous pass
    # $stref_merger is a subroutine reference containing the logic to merge $stref and $stref_init
	(my $args, my $stref_init, my $stref_merger)=@_;
    
    # Populate %Config with defaults from $menu_config
    init_config();
        
    # $code_unit_name is either provided on command line or $Config{'TOP'} or, if it's a module, $Config{'MODULE'}
    # If $code_unit_name is blank then we the files in the $SOURCEFILES list are processed one by one
    # Otherwise a non-blank $SOURCEFILES list will be considered the list of the source files to be inventoried, so includes in them will also be added to the inventory.
	(my $code_unit_name, my $gen_scons, my $build, my $call_tree_only, my $pass) = parse_args($args);
	#  Initialise the global state. $code_unit_name could be empty
	my $stref = init_state($code_unit_name);
	if (defined $stref_init and defined $stref_merger) {
            $stref=$stref_merger->($stref, $stref_init);
    }

    # local $V=1;
	# 1. Inventory: Find all subroutines in the source code tree
	if ($V) {
        say "--------------". ('-' x length($code_unit_name)) ;
        say "INVENTORY for $code_unit_name";
        say "--------------". ('-' x length($code_unit_name)) ;
        }
	$stref = find_subroutines_functions_and_includes($stref);
	if ($I) {
        say "INFO: Subroutines that will be analysed:";
		for my $sub (sort keys %{ $stref->{'Subroutines'} }) {
            if (exists $stref->{'Subroutines'}{$sub}{'Source'}) {
			    say $sub,"\t=>\t",$stref->{'Subroutines'}{$sub}{'Source'};
            } else {
                say $sub,"\t=>\tEXTERNAL";
            }
		}
	}

    # 2. Parser: Parse the source
    if ($V) {
        say "--------------". ('-' x length($code_unit_name)) ;
        say "PARSE ALL for $code_unit_name";
        say "--------------". ('-' x length($code_unit_name)) ;
        }
    for my $data_block (keys %{ $stref->{'BlockData'} } ) {
    	$stref = parse_fortran_src( $data_block, $stref, 0 );
    }
    # It is possible that the TOP routine was set to the default (PROGRAM) while doing the inventory
    if ($code_unit_name eq '' and $Config{'TOP'} ne '') {
    	$code_unit_name = $Config{'TOP'};
        $stref->{'Top'}=$code_unit_name;
        say "Using PROGRAM $code_unit_name as TOP" if $V;
    }

    if ($code_unit_name eq '' and scalar @{ $Config{'SOURCEFILES'} }>0) {
    	# $code_unit_name is empty, i.e. no TOP routine. So we go through all sources one by one by file name
    	for my $fp ( @{ $Config{'SOURCEFILES'} } ) {
    		parse_fortran_src( $fp, $stref, 1 );
    	}
    } else {
	   $stref = parse_fortran_src( $code_unit_name, $stref, 0 );
    }

    # say "\n MAIN \n";
    # map {say $_} @{pp_annlines($stref->{'Subroutines'}{'test_loop_nature'}{'AnnLines'},1)};
                # croak Dumper $stref->{Subroutines}{shapiro_map_24}{DeclaredOrigArgs}{List};

    if ($V) {
        say "--------------". ('-' x length($code_unit_name)) ;
        say "BLOCKS PROCESSING for $code_unit_name";
        say "--------------". ('-' x length($code_unit_name)) ;
        }
	$stref = mark_blocks_between_calls( $stref );

	$stref = refactor_marked_blocks_into_subroutines( $stref );
    if ($V) {
        say "--------------". ('-' x length($code_unit_name)) ;
        say "PRECONDITIONING for $code_unit_name";
        say "--------------". ('-' x length($code_unit_name)) ;
        }
    #
    $stref = precondition_includes($stref);

    if ($code_unit_name eq '' and scalar @{ $Config{'SOURCEFILES'} }>0) {
        # $code_unit_name is empty, i.e. no TOP routine. So we go through all sources one by one by file name
        for my $fp ( @{ $Config{'SOURCEFILES'} } ) {
            precondition_decls( $fp, $stref );
        }
    } else {
       $stref = precondition_decls( $code_unit_name, $stref );
    }

   if ($code_unit_name eq '' and scalar @{ $Config{'SOURCEFILES'} }>0) {
        # $code_unit_name is empty, i.e. no TOP routine. So we go through all sources one by one by file name
        for my $fp ( @{ $Config{'SOURCEFILES'} } ) {
            precondition_subroutines_with_includes( $fp, $stref );
        }
    } else {
       $stref = precondition_subroutines_with_includes( $code_unit_name, $stref );
    }

	if ( $call_tree_only  ) {
		$stref->{'PPCallTree'}=[];
		$stref=create_call_tree($stref,$code_unit_name);
		map {print $_}  @{ $stref->{'PPCallTree'} };
        say Dumper$stref->{'CallTreeInfo'};
        map {say $_} sort( keys( %{$stref->{'CallTreeInfo'}}));
		exit(0);
	}
    if ($V) {
        say "--------------". ('-' x length($code_unit_name)) ;
        say "BUILDING CALL GRAPH for $code_unit_name";
        say "--------------". ('-' x length($code_unit_name)) ;
        }
	$stref = build_call_graph($code_unit_name, $stref);

    # 3. Analysis: Analyse the source
    my $stage=0;
    if ($V) {
        say "----------------". ('-' x length($code_unit_name)) ;
        say "ANALYSE ALL for $code_unit_name";
        say "----------------". ('-' x length($code_unit_name)) ;
        }
    if ($code_unit_name eq '' and scalar @{ $Config{'SOURCEFILES'} }>0) {
    	for my $fp ( @{ $Config{'SOURCEFILES'} } ) {
            $stref = analyse_all($stref,$fp, $stage, 1);
        }
    } else {
	   $stref = analyse_all($stref,$code_unit_name, $stage);
    }

    # After the analysis we can either do the refactoring of the code, i.e. the main purpose of the compiler
    # or run one or more custom passes.
    #
    if ($pass) {
        if ($V)
        {
            say "--------------------". ('-' x length($pass)) ;
            say "RUNNING CUSTOM PASS $pass";
            say "--------------------". ('-' x length($pass)) ;
        }
        if ($code_unit_name eq '' and scalar @{ $Config{'SOURCEFILES'} }>0) {
        # $code_unit_name is empty, i.e. no TOP routine. So we go through all sources one by one by file name
            for my $fp ( @{ $Config{'SOURCEFILES'} } ) {
    	       $stref = run_custom_passes($stref,$fp, $pass,1);
            }
        } else {
        	   $stref = run_custom_passes($stref,$code_unit_name, $pass);
        }
    } else {

    # 4. Refactoring: Refactor the source
    # - if a pass is given using -P on command line, it is performed instead of the default refactoring
    # - multiple passes can be comma-separated
   if ($code_unit_name eq '' and scalar @{ $Config{'SOURCEFILES'} }>0) {
        # $code_unit_name is empty, i.e. no TOP routine. So we go through all sources one by one by file name
        for my $fp ( @{ $Config{'SOURCEFILES'} } ) {
        	$stref = refactor_all($stref,$fp,1);
        }
        } else {
	       $stref = refactor_all($stref,$code_unit_name);
        }
    }
	# 5. Emitter: Emit the refactored source

	if ( not $call_tree_only ) {
		emit_all($stref);
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
    if (defined $args) {
        return $stref;
    } else {
	    exit(0);
    }


}    # END of main()
# -----------------------------------------------------------------------------
# To facilitate integration of passes, I want to support passing in of a hash with structure {$flag => $flag_value | 1}
# So for example my $args={'P' => '', 'c' => 'rf4a.cfg', 'v'=>1}
sub parse_args { (my $args)=@_;

	my %opts = ();
    if (defined $args) {
        %opts = %{$args};
    } #else {
    getopts( 'Vvw:iIdhACTgbBGSc:P:s:o:', \%opts );
    #}
	if ($opts{'V'}) {
		die "Version: $VERSION\n";
	}
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
    # I think I could overload  $cfgrc to be a hash, so that I would simply say
    if (ref($cfgrc) eq 'HASH') {
        for my $k (keys %{$cfgrc}) {
            $Config{$k} = $cfgrc->{$k};
        }
    } else {
        if (!$opts{'s'}) {
            if (not -e $cfgrc) {
                say "There is not configuration file, let's create one.\n";
                interactive_create_rf4a_cfg();
            } else {
                read_rf4a_config($cfgrc);
            }
        } 
    }

	my $has_code_unit_name=0;
	my $code_unit_name = $ARGV[0];
    # die  "ARG: $code_unit_name";
	if ($code_unit_name) {
		$code_unit_name =~ s/\.f(?:9[05])?$//;
		$has_code_unit_name=1;
	} elsif ($Config{'MODULE'} ne '') {
		$code_unit_name = $Config{'MODULE'};
		$has_code_unit_name=1;
	} elsif ($Config{'TOP'} ne '') {
		$code_unit_name = $Config{'TOP'};
		$has_code_unit_name=1;
	} else {
        # Make sure code_unit_name is empty
        $code_unit_name = '';
	}

    if ( $Config{'NEWSRCPATH'} ne '') {
        $targetdir =  $Config{'NEWSRCPATH'};
    }

    my $pass =  $opts{'P'} // '';
    # WV: need to document this in Config.
    # I introduce this for passes that currently use a redirect.
    my $custom_pass_output_path = $opts{'o'} // '';
    if ($custom_pass_output_path) {
        $Config{'CUSTOM_PASS_OUTPUT_PATH'}=$custom_pass_output_path;
    }
    # if ($pass and not $output_path) {
    #     warn "No output path for custom pass $pass, if needed specify with -o "
    # }

    # If -s or $Config{'SOURCEFILES'} is not empty, we can proceed without TOP
    my $sourcefiles_str = $opts{'s'} // '';
    if ($sourcefiles_str ne '') {
        # OK, source files from command line
        $Config{'SOURCEFILES'} = [ split(/\s*\,\s*/,$sourcefiles_str) ];
    } elsif ( @{$Config{'SOURCEFILES'}}==0) {
    	# OK, source files from config file
        # $SOURCEFILES = $Config{'SOURCEFILES'}
    # } elsif (not $has_code_unit_name) {
    	# die "No default for toplevel subroutine (TOP) in rf4a.cfg, please specify the toplevel subroutine on command line\n";
        say "No default for toplevel subroutine (TOP) in rf4a.cfg, I will use the program name" if $V;
    }

    $ANN = ( $opts{'A'} ) ? 1 : 0;

	$V = ( $opts{'v'} ) ? 1 : 0;
	$I = ( $opts{'i'} ) ? 1 : 0;
    $WARNING_LEVEL = defined $opts{'w'} ? $opts{'w'} : 1;
    # say "WARNING LEVEL: $WARNING_LEVEL" if $WARNING_LEVEL!=1;
	$W = $WARNING_LEVEL >= 1 ? 1 : 0;
    $WW = $WARNING_LEVEL >= 2 ? 1 : 0;
    $WWW = $WARNING_LEVEL >= 3 ? 1 : 0;
	$DBG = ( $opts{'d'} ) ? 1 : 0;
    $SHOW = $opts{'S'} ? 1: 0;

    $Config{'INLINE_INCLUDES'} = $opts{'I'}  ? 1 : 0;

	$CFG_refactor_toplevel_globals= 1; # FIXME: refactoring while ignoring globals is broken ( $opts{'g'} ) ? 1 : $CFG_refactor_toplevel_globals; # Global from Config

	if ( $opts{'C'} ) {
		$call_tree_only = 1;
		$main_tree = $ARGV[1] ? 0 : 1;		 # not used
	}

	my $build = ( $opts{'B'} ) ? 1 : 0;
    my $gen_scons = ( $opts{'b'} ) ? 1 : 0;
    if ($build) {
        $gen_scons = 1;
    }

    return (toLower($code_unit_name),$gen_scons,$build,$call_tree_only, $pass);
} # END of parse_args()


# Sorry, this POD is wildly out of date, please see the repo docs!

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

# FORTRAN Refactoring Tool |$VERSION|

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

sub usage {
	die $usage;
}
1;
