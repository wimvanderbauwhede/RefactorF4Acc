package RefactorF4Acc::Refactoring::Subroutines;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Parser qw( parse_fortran_src );
use RefactorF4Acc::Refactoring::Helpers qw( 
	emit_f95_var_decl 
	stateful_pass
	splice_additional_lines_cond
	);
use RefactorF4Acc::Refactoring::ContextFree qw( context_free_refactorings );	
use RefactorF4Acc::Refactoring::Subroutines::Emitters qw( emit_subroutine_sig );
use RefactorF4Acc::Refactoring::Common qw( refactor_COMMON_blocks );
use RefactorF4Acc::Refactoring::Equivalence qw( change_EQUIVALENCE_to_assignment_lines );
use RefactorF4Acc::Refactoring::StatementFunctions qw( move_StatementFunctions_after_SpecificationStatements );

use vars qw( $VERSION );
$VERSION = "2.1.1";

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
  refactor_all_subroutines
);

=pod
Subroutines
    refactor_all_subroutines
    _refactor_subroutine_main
    _refactor_globals
    _refactor_calls_globals 
=cut

# -----------------------------------------------------------------------------

sub refactor_all_subroutines {
	( my $stref ) = @_;

	for my $f ( sort keys %{ $stref->{'Subroutines'} } ) {

		next if ( $f eq '' or $f eq 'UNKNOWN_SRC' or not defined $f );
		next if exists $stref->{'Entries'}{$f};

		my $Sf = $stref->{'Subroutines'}{$f};

		next if ( exists $Sf->{'Entry'} && $Sf->{'Entry'} == 1 );
		if ( not defined $Sf->{'Status'} ) {
			$Sf->{'Status'} = $UNREAD;
			say "INFO: no Status for $f" if $I;
		}

		next if $Sf->{'Status'} == $UNREAD;
		next if $Sf->{'Status'} == $READ;
		next if $Sf->{'Status'} == $FROM_BLOCK;

		$stref = _refactor_subroutine_main( $stref, $f );
	}

	return $stref;
}    # END of refactor_all_subroutines()

# ------------------------------------------------------------------------

=pod

=begin markdown

## Info refactoring `_refactor_subroutine_main()`

Essentially, call `_refactor_globals()` on every sub

for every line:

- check if it needs changing:
- need to mark the insert points for subroutine calls that replace the refactored blocks! 
This is a node called 'RefactoredSubroutineCall'
- we also need the "entry point" for adding the declarations for the localized global variables 'ExGlobArgs'

* Signature: add the globals to the signature
(* VarDecls: keep as is)
* ExGlobArgs: add new var decls
* SubroutineCall: add globals for that subroutine to the call
* RefactoredSubroutineCall: insert a new subroutine call instead of the "begin of block" comment. 
* InBlock: skip; we need to handle the blocks separately
* BeginBlock: insert the new subroutine signature and variable declarations
* EndBlock: insert END
                      
=end markdown
=cut

sub _refactor_subroutine_main {
	( my $stref, my $f ) = @_;

	#    local $V=1;
	#    local $I=1;
	#    local $W=1;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $is_block_data =
	  ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? 1 : 0;
	if ($V) {
		print "\n\n";
		print "#" x 80, "\n";
		print "Refactoring $f\n";
		if ( exists $Sf->{'Function'} and $Sf->{'Function'} == 1 ) {
			print "REFACTORING FUNCTION $f\n";
		} else {
			print "REFACTORING SUBROUTINE $f\n";
		}
		print "#" x 80, "\n";
		say "context_free_refactorings($f)";
	}

	$stref = context_free_refactorings( $stref, $f );    # FIXME maybe do this later	

	# say "get_annotated_sourcelines($f)" if $V;
	my $annlines = $Sf->{'RefactoredCode'};

	if ( $Sf->{'HasCommons'} and $Config{'INLINE_INCLUDES'}==0 ) {
		# If there are no COMMON blocks the argument list should not change, so there should be no need to do this		
		$annlines = _group_local_param_decls_at_top( $stref, $f, $annlines );
	}

	if (
		1 or $Sf->{'HasCommons'} or (                    # FIXME
			exists $Sf->{'Contains'} and scalar @{ $Sf->{'Contains'} } > 0
		)
	  )
	{
		print "REFACTORING COMMONS for SUBROUTINE $f\n" if $V; 

		if ( $Sf->{'RefactorGlobals'} == 1 ) {

			$annlines = refactor_COMMON_blocks( $stref, $f, $annlines );

		} elsif ( $DBG and $Sf->{'RefactorGlobals'} == 2 ) {
			croak 'SHOULD BE OBSOLETE!';
		}
	}

	$annlines = _fix_end_lines( $stref, $f, $annlines );    # FIXME maybe do this later

	if ($is_block_data) {
		$annlines = _add_extra_assignments_in_block_data( $stref, $f, $annlines );
	}

	$annlines = _add_implicit_none( $stref, $f, $annlines );


	# The assignment lines for the mismatched ex-COMMON vars can go here
	# probably before the first line that is not a SpecificationStatement and not a Comment and not a Blank and not Skip or Deleted
	if ( exists $stref->{'Subroutines'}{$f}{'HasCommonVarMismatch'} ) {
		$annlines = _add_ExMismatchedCommonArg_assignment_lines( $stref, $f, $annlines );
		$Sf->{'RefactoredCode'} = $annlines;

		# Re-parsing to get the Info for the emitted lines
		# FIXME: at this stage the PlaceHolders have already been put back! This breaks the parser in some places!

		#	    $stref = parse_fortran_src($f, $stref);
		#	    $annlines=$Sf->{'AnnLines'};
	}

	$annlines = change_EQUIVALENCE_to_assignment_lines( $stref, $f, $annlines );

	#	$Sf->{'AnnLines'} = $annlines;
	#	$Sf->{'RefactoredCode'} = $annlines; # cargo cult
	$annlines = move_StatementFunctions_after_SpecificationStatements( $stref, $f, $annlines );

	$annlines = _emit_refactored_signatures( $stref, $f, $annlines );
	$Sf->{'RefactoredCode'} = $annlines;

	#say Dumper(pp_annlines($annlines));
	$Sf->{'AnnLines'} = $annlines;
	return $stref;
}    # END of _refactor_subroutine_main()

# -----------------------------------------------------------------------------
# The code below fixes the end lines of the code by adding 'program $f' or 'subroutine $f' or 'function $f'
# For some reason this is BROKEN elsewhere so FIXME!
sub _fix_end_lines {
	my ( $stref, $f, $rlines ) = @_;

	my $Sf                 = $stref->{'Subroutines'}{$f};
	my $is_block_data      = ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? 1 : 0;
	my $what_is_block_data = 'subroutine';                                                        #'block data'
	my $sub_or_prog =
		( exists $Sf->{'Program'}   and $Sf->{'Program'} == 1 )   ? 'program'
	  : ( exists $Sf->{'Function'}  and $Sf->{'Function'} == 1 )  ? 'function'
	  : ( exists $Sf->{'BlockData'} and $Sf->{'BlockData'} == 1 ) ? $what_is_block_data
	  :                                                             'subroutine';
	say 'fix end ' . $f if $V;
	my $done_fix_end = 0;

	while ( !$done_fix_end and @{$rlines} ) {
		my $annline = pop @{$rlines};

		( my $line, my $info ) = @{$annline};

		#		say "$f REV LINE: $line" if $f eq 'cphs';
		next if ( $line =~ /^\s*$/ );    # Skip comments
		if (   $line =~ /^\s*end\s+$sub_or_prog/
			or $line =~ /^\s*\d+\s+end\s+$sub_or_prog/ )
		{
			push @{$rlines}, $annline;
			$done_fix_end = 1;
			last;
		}

		if (   $line =~ /^\s*end\s*$/
			or $line =~ /^\s*\d+\s+end\s*$/ )
		{
			$line =~ s/\s+$//;
			if ($is_block_data) {
				$info->{'EndBlockData'} = 1;
			}

			push @{$rlines}, [ $line . " $sub_or_prog $f", $info ];
			$done_fix_end = 1;
		}

		if ( $line =~ /^\s*contains\s*$/ ) {
			$line =~ s/\s+$//;
			push @{$rlines}, $annline;
			push @{$rlines}, [ "end $sub_or_prog $f", $info ];
			$done_fix_end = 1;
		}
	}

	return $rlines;
}    # END of _fix_end_lines()


# For every $var in BlockData we need ${var}_ARG = $var
sub _add_extra_assignments_in_block_data {
	( my $stref, my $f, my $annlines ) = @_;
	my $Sf                   = $stref->{'Subroutines'}{$f};
	my $new_annlines         = [];
	my $extra_arg_decl_lines = [];
	for my $arg ( @{ $Sf->{'ExGlobArgs'}{'List'} } ) {
		my $maybe_renamed_arg = $arg;
		my $decl              = $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg};
		if ( not exists $decl->{'OrigName'} ) {

			# This means the ExGlobArgs are the original ones, not the renamed ones
			$maybe_renamed_arg = $arg . '_ARG';
			my $mod_decl = dclone($decl);
			$mod_decl->{'Name'}                         = $maybe_renamed_arg;
			$mod_decl->{'OrigName'}                     = $arg;
			$Sf->{'ExGlobArgs'}{'Set'}{ $arg . '_ARG' } = $mod_decl;
			delete $Sf->{'ExGlobArgs'}{'Set'}{$arg};
			@{ $Sf->{'ExGlobArgs'}{'List'} } = map { $_ eq $arg ? $maybe_renamed_arg : $_ } @{ $Sf->{'ExGlobArgs'}{'List'} };

			# Need to check if these were not already declared
			if (
					not exists $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$maybe_renamed_arg}
				and not exists $Sf->{'DeclaredOrigArgs'}{'Set'}{$maybe_renamed_arg}
				and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$maybe_renamed_arg}

				#    	and not exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}
			  )
			{

				say "INFO VAR in $f: IODir for $maybe_renamed_arg: " . $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg}{'IODir'}
				  if $I and not $Sf->{'Program'};
				my $rdecl = $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg};
				my $rline = emit_f95_var_decl($rdecl);
				my $info  = {};
				$info->{'Ann'}     = [ annotate( $f, __LINE__ . ' : EX-GLOB ' ) ];
				$info->{'LineID'}  = 0;                                              #$nextLineID++;
				$info->{'Ref'}     = 1;
				$info->{'VarDecl'} = { 'Name' => $maybe_renamed_arg };               #$rdecl;
				$info->{'ArgDecl'} = 1;
				push @{$extra_arg_decl_lines}, [ $rline, $info ];
			}
		}
		my $orig_arg_name = $Sf->{'ExGlobArgs'}{'Set'}{$maybe_renamed_arg}{'OrigName'};
		push @{$new_annlines}, [ "        $maybe_renamed_arg = $orig_arg_name", { 'Extra' => 1 } ];

	}

	#       my $stref,
	#        my $f,
	#        my $insert_cond_subref,
	#        my $old_annlines,
	#        my $new_annlines,
	#        my $insert_before,
	#        my $skip_insert_pos_line,
	#        my $do_once
	#croak Dumper($annlines);
	my $merged_annlines = splice_additional_lines_cond(
		$stref, $f,
		sub {
			( my $annline ) = @_;
			return exists $annline->[1]{'EndBlockData'} ? 1 : 0;
		},
		$annlines,
		$new_annlines,
		1,
		0,
		1
	);
##croak Dumper($extra_arg_decl_lines);
	my $merged_annlines_w_args = splice_additional_lines_cond(
		$stref, $f,
		sub {
			( my $annline ) = @_;
			return exists $annline->[1]{'Data'} ? 1 : 0;
		},
		$merged_annlines,
		$extra_arg_decl_lines,
		1,
		0,
		1
	);

	#croak Dumper(pp_annlines($merged_annlines_w_args));
	return $merged_annlines_w_args;
}    # END of _add_extra_assignments_in_block_data

sub _add_implicit_none {
	my ( $stref, $f, $annlines ) = @_;
	my $Sf            = $stref->{'Subroutines'}{$f};
	my $first_vardecl = 1;
	my $rlines        = [];
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		if ( ( exists $info->{'VarDecl'} or exists $info->{'ParamDecl'} or exists $info->{'Equivalence'} )
			and $first_vardecl )
		{
			$first_vardecl = 0;

			# Here I think I can insert 'implicit none'
			if ( not exists $Sf->{'ImplicitNone'} ) {
				say "Adding 'implicit none' at " . __PACKAGE__ . ' ' . __LINE__
				  if $V;
				my $r_info = {};
				my $indent = ' ' x 6;
				$r_info->{'Indent'}       = $indent;
				$r_info->{'ImplicitNone'} = 1;
				$r_info->{'Ann'}          = [ annotate( $f, __LINE__ ) ];
				push @{$rlines}, [ $indent . 'implicit none', $r_info ];
			}
		}
		push @{$rlines}, $annline;
	}
	return $rlines;
}    # END of _add_implicit_none

# The assignment lines for the mismatched ex-COMMON vars should come
# before the first line that is not a SpecificationStatement and not a Comment and not a Blank and not Skip or Deleted

sub _add_ExMismatchedCommonArg_assignment_lines {
	my ( $stref, $f, $annlines ) = @_;
	my $Sf             = $stref->{'Subroutines'}{$f};
	my $first_vardecl  = 1;
	my $last_statement = 0;
	my $rlines         = [];

	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};

		if (    not exists $info->{'Signature'}
			and not exists $info->{'VarDecl'}
			and not exists $info->{'ImplicitNone'}
			and not exists $info->{'SpecificationStatement'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Skip'}
			and not exists $info->{'Deleted'}
			and $first_vardecl == 1 )
		{
			$first_vardecl = 0;
			
			for my $rline ( @{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'ArgAssignmentLines'} } ) {				
				# push @{$rlines}, $rline ;
				push @{$rlines}, [$rline->[0].' ! ArgAssignmentLines', $rline->[1]] ;
			}
		}

		# For the reverse assignments:
		# In a subroutine they should come before a RETURN or before the END
		#  In a function they should come before the assignment to the function name, a RETURN or the END, whichever is first
		if ( ( exists $info->{'Return'} or exists $info->{'EndSubroutine'} or ( exists $info->{'Assignment'} and $info->{'Lhs'}{'VarName'} eq $f ) )
			and $last_statement == 0 )
		{
			$last_statement = 1;
			for my $rline ( @{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'ArgRevAssignmentLines'} } ) {
				push @{$rlines}, [$rline->[0].' ! ArgRevAssignmentLines', $rline->[1]] ;
			}
		}
		push @{$rlines}, $annline;
	}
	return $rlines;
}    # END of _add_ExMismatchedCommonArg_assignment_lines



sub _emit_refactored_signatures {
	my ( $stref, $f, $annlines ) = @_;

	#    my $Sf = $stref->{'Subroutines'}{$f};

	my $rlines = [];
	my $has_return_type = 0;
	my $fname='';
	for my $annline ( @{$annlines} ) {
		( my $line, my $info ) = @{$annline};
		if ( exists $info->{'Signature'} ) {
			@{$annline} = emit_subroutine_sig($annline);			
			( my $line, my $info ) = @{$annline};
			if (exists $info->{'Signature'}{'ReturnType'}) {
				$has_return_type=1;
				$fname=$info->{'Signature'}{'Name'};
			}
			#            say Dumper($annline);
		}
		if ( $has_return_type 
		and exists $info->{'VarDecl'} 
		and $info->{'VarDecl'}{'Name'} eq $fname
		) {
			$info->{'Deleted'}=1;
			$info->{'Skip'}=1;
			$annline = [ $line, $info ];
		}


		push @{$rlines}, $annline;
	}
	return $rlines;
}    # END of _emit_refactored_signatures

# This only works for 1-D array. It's already bad enough though.
sub __equate_overlapping_ranges {
	my ( $index1, $dim1, $index2, $dim2 ) = @_;
	my $offset1    = $dim1->[0][0];
	my $end_index1 = $dim1->[0][1];
	my $offset2    = $dim2->[0][0];
	my $end_index2 = $dim2->[0][1];
	my $array1 = [$index1];
	my $array2 = [$index2];

	# range is defined as size-1
	if ( $index1 - $offset1 < $index2 - $offset2 ) {

		# offset it with the starting index,
		my $trange1 = $index1 - $offset1;

		# and subtract this from the larger of the two
		my $start_index2 = ( $index2 - $offset2 + 1 ) - $trange1;

		# this is the start index for that array
		# then check if the end index of that array
		# if it is smaller than the end index of the other array,
		if ( $end_index2 - $start_index2 < $end_index1 - $offset1 ) {
			my $range2 = $end_index2 - $start_index2;
			$array2 = [ $start_index2, $end_index2 ];
			$array1 = [ $offset1,      $offset1 + $range2 ];
		} else {
			my $range1 = $end_index1 - $offset1;
			$array1 = [ $offset1,      $end_index1 ];
			$array2 = [ $start_index2, $start_index2 + $range1 ];
		}
	} else { #reverse the whole thing
		my $trange2      = $index2 - $offset2;
		my $start_index1 = ( $index1 - $offset1 + 1 ) - $trange2;
		if ( $end_index1 - $start_index1 < $end_index2 - $offset2 ) {
			my $range1 = $end_index1 - $start_index1;
			$array1 = [ $start_index1, $end_index1 ];
			$array2 = [ $offset2,      $offset2 + $range1 ];
		} else {
			my $range2 = $end_index2 - $offset2;
			$array2 = [ $offset2,      $end_index2 ];
			$array1 = [ $start_index1, $start_index1 + $range2 ];
		}
	}
	return [ $array1, $array2 ];
}    # END of __equate_overlapping_ranges


# We take the parameter declaration lines out of the annlines, and then re-insert them before the first variable declaration 
sub _group_local_param_decls_at_top { my ( $stref, $f ) = @_;
	my $Sf = $stref->{'Subroutines'}{$f};
	my $pass_split_out_ParamDecls = sub {
		(my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		#  say "LINE:$line ".Dumper(sort keys %{$info});
		my $new_annlines = [$annline];
		if (exists $info->{'ParamDecl'}) {	
			
					$new_annlines =[ 
					["! Moved param decl for  ".
					(ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY' ? 
					$info->{'ParamDecl'}{'Name'} [0] :
					$info->{'ParamDecl'}{'Name'}
					). ' in '.$f.' to top of code unit'					
					,{'Comments' => 1}],					
					];
					$info->{'Ann'}       = [ annotate( $f, __LINE__ . ' :  _group_local_param_decls_at_top'  ) ];
					push @{$state},[ $line , $info];
		}		
		
		return ($new_annlines,$state);
	};
	my $param_decl_annlines = [['! Grouped Parameter Declarations',{'Comments' => 1}]];
 	($stref,$param_decl_annlines) = stateful_pass($stref,$f,$pass_split_out_ParamDecls, $param_decl_annlines,'_split_out_ParamDecls ' . __LINE__  ) ;	

	 if (scalar @{ $param_decl_annlines } > 1) {
		my $merged_annlines = splice_additional_lines_cond(
			$stref, $f,
			sub {
				( my $annline ) = @_;
				(my $line,my $info)=@{$annline};
				return (
					exists $info->{'VarDecl'}
				) ? 1 : 0;
			},
			[],
			$param_decl_annlines,
			1, # insert before
			0, # skip insertion condition line
			1 # do this only once
		);
		# say "SUBROUTINE $f";
		# say Dumper(pp_annlines($merged_annlines));
		return $merged_annlines;
	 } else {
		return $Sf->{'RefactoredCode'};
	 }
} # END of _group_local_param_decls_at_top

1;
