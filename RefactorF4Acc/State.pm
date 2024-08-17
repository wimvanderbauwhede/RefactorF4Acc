package RefactorF4Acc::State;
use v5.10;
use RefactorF4Acc::Config;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

use warnings;
use strict;
use Carp;

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT = qw(
    init_state
    initialise_per_code_unit_tables
);

sub init_state {
    ( my $vref ) = @_;
    my $subname = $vref;
    if (ref($vref) eq 'HASH') {
        $subname =$vref->{'Top'};
    }

    # Nodes|Subroutines|Includes|NId|BuildSources|Indents
    my $stateref = {
        'Top'          => $subname,
        'IncludeFiles' => {},
        'Subroutines'  => {}, # {$f}{Function} = 1
        'SourceFiles' => {}, # This is for anything not in a code unit, usually just comments and blank lines
        'BuildSources' => {}
        ,    # sources to be built, can be C, H (header) or F (Fortran)
        'Indents' => 0,    # bit silly, purely for pretty-printing
        'NId'     => 0,    # running node id for traversal
        'PNids'	=> [],
        'Nodes'   => {     # nodes in call tree
#            0 => {
#                'Parent'     => 0,
#                'Children'   => [],
#                'Subroutine' => $subname
#            }
        },
        'Macros' => {
        	'Define' => {},
        	'Undef' => {},
        	'All' => {}
        }
    };

    if ($Config{'MACRO_SRC'} ne '' ){
    	my $macro_src =$Config{'MACRO_SRC'};
    	if ( -e $macro_src ) {
	        open my $MACROS, '<', $macro_src;
    	    while ( my $line = <$MACROS> ) {
        	    next unless $line =~ /^\s*\#/;
            	$line =~ /\#define\s+(.+)\s*$/ && do {
	                my $pair = $1;
	                $pair=~s/\s+/ /g;
	                $pair=~s/\s/=/;
	                (my $macro, my $val)=split(/=/,$pair);
	                if (not defined $val) {$val = ''};
	                $stateref->{'Macros'}{'Undef'}{$macro}=$val;
	                $stateref->{'Macros'}{'All'}{$macro}=$val;
	                $Config{'Macros'}{$macro}=$val;
	                next;
            	};
            	$line =~ /\#undef\s+(.+)\s*$/ && do {
                	my $macro = $1;
                	$stateref->{'Macros'}{'Undef'}{$macro}=$macro;
                	$stateref->{'Macros'}{'All'}{$macro}=$macro;
                	$Config{'Macros'}{$macro}=$macro;
                	next;
            	};
        	}
        	close $MACROS;
	    }
    }

    if (ref($vref) eq 'HASH') {
        for my $k (keys %{$vref}) {
            $stateref->{$k} = $vref->{$k};
        }
    }
    return $stateref;
} # END of init_state



# -----------------------------------------------------------------------------
# Here I initialise tables for Variables and Declarations and a few other Subroutine-specific data structures
sub initialise_per_code_unit_tables {
	( my $Sf, my $stref, my $f, my $is_incl, my $is_mod, my $skipParams ) = @_;
	if (not defined $is_mod) {
	 	$is_mod = 0;
	}
	my $code_unit = $is_incl ? 'include' : $is_mod ? 'module' : 'subroutine';
	if (not defined $skipParams) {
	 	$skipParams = 0;
	}
	say "initialise_per_code_unit_tables for $code_unit $f" if $V;

	if ( not exists $Sf->{'CommonBlocks'}) {
		$Sf->{'CommonBlocks'} = {};
	}
# 	if ( not exists $Sf->{'ExMismatchedCommonArgs'} ) {
# 		# List gets orig names. Set gets prefixes as values
# 		$Sf->{'ExMismatchedCommonArgs'} = { 'List' => [], 'Set' => {} };
# 	}
	if ( not exists $Sf->{'ReferencedLabels'}) {
		$Sf->{'ReferencedLabels'}={};
	}
	if ( not exists $Sf->{'MaskedIntrinsics'} ) {
		$Sf->{'MaskedIntrinsics'}={};
	}
	if ( not exists $Sf->{'CalledSubs'} ) {
		$Sf->{'CalledSubs'} = { 'List' => [], 'Set' => {} };
	}
	if ( not exists $Sf->{'InlinedCalls'} ) {
		$Sf->{'InlinedCalls'} = { 'List' => [], 'Set' => {} };
	}
	if ( not exists $Sf->{'CalledEntries'} ) {
		$Sf->{'CalledEntries'} = { 'List' => [], 'Set' => {} };
	}
	if ( not exists $Sf->{'Entries'} ) {
		$Sf->{'Entries'} = { 'List' => [], 'Set' => {} };
		$Sf->{'Entry'}=0;
	}
# WV20151021 what we need here is a check that this function has not been called before for this $Sf
	if ( not exists $Sf->{'DoneInitTables'} ) {
		say "initialise_per_code_unit_tables : INIT TABLES for $code_unit $f" if $V;

		$Sf->{'HasCommons'} = 0;
		$Sf->{'HasIncludes'} = 0;

		# WV20151021 maybe need to do that for all subsets of Vars too?
		# WV20151021 the question is if this needs to be hierarchical?
		# Also, I think I wil use 'Subsets'
		$Sf->{'DeclaredOrigLocalVars'}   = { 'Set' => {}, 'List' => [] };
		$Sf->{'UndeclaredOrigLocalVars'} = { 'Set' => {}, 'List' => [] };

		if (!$skipParams) {
			#		$Sf->{'Parameters'} = {};
			$Sf->{'LocalParameters'}    = { 'Set' => {}, 'List' => [] };
			$Sf->{'IncludedParameters'} = { 'Set' => {}, 'List' => [] };
			$Sf->{'ModuleParameters'} = { 'Set' => {}, 'List' => [] }; # 
			$Sf->{'InheritedParameters'} = { 'Set' => {}, 'List' => [] };
			$Sf->{'ParametersFromContainer'} = { 'Set' => {}, 'List' => [] };
		}
		# Var decls via a 'use' declaration
		$Sf->{'UsedLocalVars'} = { 'Set' => {}, 'List' => [] }; # I don't think this actually exists
		# Same actualy, but this includes access via a container
		# WV2024-01-15 this needs to change:
		# VarsFromContainer is for containers that are *not* modules
		# For modules, we use ModuleVars only
		$Sf->{'VarsFromContainer'} = { 'Set' => {}, 'List' => [] };
		# This is only for testing which vars are commons, nothing else.
		$Sf->{'Commons'} = {};

# FIXME At the moment we assume automatically that CommonVars become ExGlobArgs
# WV20170607 I now also assume that any var declared in a USEd module is a global, so will become ExGlobArg
# WV20240103 I want to change this so that module variables are entirely separate from COMMON variables
# WV20240103 To do this right, I should also separate non-module containers from module containers
		$Sf->{'DeclaredCommonVars'}   = { 'Set' => {}, 'List' => [] };
		$Sf->{'UndeclaredCommonVars'} = { 'Set' => {}, 'List' => [] };

		$Sf->{'CommonVars'}           = {
			'Subsets' => {
				'DeclaredCommonVars'   => $Sf->{'DeclaredCommonVars'}, 
				'UndeclaredCommonVars' => $Sf->{'UndeclaredCommonVars'},
			}
		};

		$Sf->{'ModuleVars'}   = { 'Set' => {}, 'List' => [] };

		$Sf->{'OrigLocalVars'} = {
			'Subsets' => {
				'DeclaredOrigLocalVars' => $Sf->{'DeclaredOrigLocalVars'},
				'UndeclaredOrigLocalVars' => $Sf->{'UndeclaredOrigLocalVars'}
			}
		};

		if ( not $is_incl and not $is_mod ) {

 # WV: Maybe I should have an additional record 'FromInclude' in the set record!
 # This seemed like a good idea but it requires so many changes. Instead I think I'll just populate ExGlobArgs on the fly
# 			$Sf->{'ExInclGlobArgs'} = {
#				'Set' => {}, 'List' => []
#			};
# 			$Sf->{'ExContainerGlobArgs'} = {
#				'Set' => {}, 'List' => []
#			};

			$Sf->{'RenamedInheritedExGlobs'}  = { 'List' => [], 'Set' => {}};
			# I think this should include args that where module globals
			$Sf->{'ExGlobArgs'} = {
				'Set' => {}, 'List' => []
			};
			# Declarations for arguments in include files
			$Sf->{'ExInclArgs'}         = { 'Set' => {}, 'List' => [] };
			$Sf->{'DeclaredOrigArgs'}   = { 'Set' => {}, 'List' => [] };
			$Sf->{'UndeclaredOrigArgs'} = { 'Set' => {}, 'List' => [] };

			$Sf->{'ExInclLocalVars'} = { 'Set' => {}, 'List' => [] };

			$Sf->{'LocalVars'} = {
				'Subsets' => {
					'OrigLocalVars'   => $Sf->{'OrigLocalVars'},
					'ExInclLocalVars' => $Sf->{'ExInclLocalVars'},
					'UsedLocalVars' => $Sf->{'UsedLocalVars'}, # presumably this is always empty
				}
			};

			$Sf->{'OrigArgs'} = {
				'Subsets' => {
					'UndeclaredOrigArgs' => $Sf->{'UndeclaredOrigArgs'},
					'DeclaredOrigArgs'   => $Sf->{'DeclaredOrigArgs'}
				},
				'List' => [],
			};

			$Sf->{'Args'} = {
				'Subsets' => {
					'OrigArgs'   => $Sf->{'OrigArgs'},
					'ExGlobArgs' => $Sf->{'ExGlobArgs'},
					'ExInclArgs' => $Sf->{'ExInclArgs'}
				}
			};
			if (!$skipParams) {
				$Sf->{'Parameters'} = {
					'Subsets' => {
						'LocalParameters'    => $Sf->{'LocalParameters'},
						'IncludedParameters' => $Sf->{'IncludedParameters'},
						'ModuleParameters' => $Sf->{'ModuleParameters'},
						'ParametersFromContainer' => $Sf->{'ParametersFromContainer'}
					}
				};
			}
			$Sf->{'Vars'} = {
				'Subsets' => {
					'Args'       => $Sf->{'Args'},
					'CommonVars' => $Sf->{'CommonVars'},
					'LocalVars'  => $Sf->{'LocalVars'},
					'Parameters' => $Sf->{'Parameters'},
					'ModuleVars' => $Sf->{'ModuleVars'}
				}
			};

		} else {    # For includes and modules
# 			say "MOD $f";
 			if ($is_mod) {
 				for my $sub (sort keys %{ $Sf->{Subroutines} }) {
 					$stref->{'Subroutines'}{$sub} =initialise_per_code_unit_tables( $stref->{'Subroutines'}{$sub}, $stref, $sub,0,0,$skipParams);
 				}
 			}
			# Includes can contain LocalVars, CommonVars or Parameters
			# Commons can't be Args so they will go in ExInclLocalVars?
			# I guess includes can contain other includes that contain all this as well, how do I deal with that?

			$Sf->{'LocalVars'} =
			  { 'Subsets' => {
			  	'OrigLocalVars' => $Sf->{'OrigLocalVars'},
			  	'UsedLocalVars' => $Sf->{'UsedLocalVars'} # presumably this is always empty
			  }
			  };
			 if (!$skipParams) {
				$Sf->{'Parameters'} = {
					'Subsets' => {
						'LocalParameters'    => $Sf->{'LocalParameters'},
						'IncludedParameters' => $Sf->{'IncludedParameters'},
						'ModuleParameters' => $Sf->{'ModuleParameters'}
					}
				};
			 }
			$Sf->{'Vars'} = {
				'Subsets' => {
					'LocalVars'  => $Sf->{'LocalVars'},
					'CommonVars' => $Sf->{'CommonVars'},
					'Parameters' => $Sf->{'Parameters'},
					'ModuleVars' => $Sf->{'ModuleVars'}
				}
			};
		}
		$Sf->{'Uses'} ={};
		$Sf->{'UsesTransitively'} ={};

		$Sf->{'DoneInitTables'} = 1;
	}
	return $Sf;
} # END of initialise_per_code_unit_tables

1;
