package RefactorF4Acc::Refactoring::Common;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;

#
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
$Data::Dumper::Indent = 0;

use Exporter;

@RefactorF4Acc::Refactoring::Common::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Common::EXPORT_OK = qw(
  &context_free_refactorings
  &create_refactored_source
  &get_annotated_sourcelines
  &split_long_line
  &format_f95_par_decl
  &format_f95_var_decl 
  &format_f77_var_decl
);

our %f95ops = (
	'not'  => '.not.',     #       complement, negation
	'and'  => '.and.',     #       logical and
	'or'   => '.or.',      #       logical or
	'eqv'  => '.eq.',      #       logical equivalence
	'neqv' => '.neqv.',    #      logical not equivalence, exclusive or

	'eq' => '==',          #    equality, old
	'ne' => '/=',          #    not equal. old
	'lt' => '<',           #     less than, old
	'gt' => '>',           #     greater than, old
	'le' => '<=',          #    less than or equal, old
	'ge' => '>=',          #    greater than or equal, old

);

#* BeginDo: just remove the label
#* EndDo: replace label CONTINUE by END DO
#* Break: keep as is; add a comment to identify it as a break
#* Goto: Do nothing
#* GotoTarget: Do nothing
#* NoopBreakTarget: replace CONTINUE with "call noop"
#* BreakTarget: Do nothing
sub context_free_refactorings {
	( my $stref, my $f ) = @_;
	print "CREATING FINAL $f CODE\n" if $V;
	my @extra_lines = ();
	my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
	my $Sf = $stref->{$sub_or_func_or_inc}{$f};
	if ( $Sf->{'Status'} != $PARSED ) {
		croak "NOT PARSED: $f\n".caller()."\n";
	}
	my $annlines = get_annotated_sourcelines( $stref, $f );
	my $firstdecl = 1;
	$Sf->{'RefactoredCode'} = [];
	my @include_use_stack=();
	for my $annline ( @{$annlines} ) {
		if ( not defined $annline or not defined $annline->[0] ) {
			croak
			  "Undefined source code line for $f in create_refactored_source()";
		}
		my $line = $annline->[0];
#		print "LINE: $line\n" if $f eq 'timemanager' && $line=~/gridunc/;
		my $info = $annline->[1];
		my %tags      = %{$info};
		if( exists $info->{'Deleted'} and $line eq '') {			
            next;
		}
		if ( exists $tags{'ImplicitNone'} ) {
			 next;
		}
        if ( exists $tags{'Signature'} ) {
#	       push @extra_lines, ['        implicit none',{'ImplicitNone'=>1}];
        }
        if ( exists $tags{'Goto'} ) {
        $line=~s/\bgo\sto\b/goto/;
        }
		# BeginDo: just remove the label
		if ( exists $tags{'BeginDo'} ) {
			$line =~ s/do\s+\d+\s+/do /;
		}

		# EndDo: replace label CONTINUE by END DO;
		# if no continue, remove label & add end do on next line
		if ( exists $tags{'EndDo'} ) {

			#warn "$f: END DO $line\n";
			my $is_goto_target = 0;
			if ( $Sf->{'Gotos'}{ $tags{'EndDo'}{'Label'} } ) {                
				# this is an end do which serves as a goto target
				$is_goto_target = 1;
			}
			my $count = $tags{'EndDo'}{'Count'};
			if ( exists $tags{'Continue'} ) {
				if ( $is_goto_target == 0 ) {
					$line = '      end do';
					$count--;
				} elsif ($noop) {
					$line =~ s/continue/call noop/;
				}
			} elsif ( $line =~ /^\d+\s+\w/ ) {
				if ( $is_goto_target == 0 ) {
					$line =~ s/^\d+//;
				}
			}
			while ( $count > 0 ) {
				push @extra_lines, [ '      end do', { 'EndDo' => 1 } ];
				$count--;
			}
		}
		if ( $noop
			&& ( exists $tags{'NoopBreakTarget'} || exists $tags{'NoopTarget'} )
		  )
		{
			$line =~ s/continue/call noop/;
		}
		if ( exists $tags{'Break'} ) {
			$line .= '  !Break';

			# $line=~s/goto\s+(\d+)/call break($1)/;
		}
		if ( exists $tags{'PlaceHolders'} ) {
			
			for my $ph (keys %{ $tags{'PlaceHolders'} }) {
				my $str = $tags{'PlaceHolders'}->{$ph};
				$line =~ s/$ph/$str/;
			}
		}
		if ( exists $tags{'VarDecl'} and not exists $tags{'FunctionSig'} ) {
			my @vars = @{ $tags{'VarDecl'} };

			# first create all parameter declarations
			if ( $firstdecl == 1 ) {
				$info->{'ExGlobVarDecls'} = {};
				$firstdecl = 0;
				for my $par ( @{ $Sf->{'Parameters'}{'OrderedList'} } ) {

					# What we need is a new formatter
					my $new_line = format_f95_par_decl( $stref, $f, $par );					
					push @extra_lines,
					  [ $new_line, { 'Extra' => 1, 'Parameter' => [$par] } ];
				}
				my @vars_not_pars =
				  grep { not exists $Sf->{'Parameters'}{$_} } @vars;
				my $filtered_line = '';				
				if (@vars_not_pars) {
					$filtered_line =
					  format_f95_multiple_var_decls( $Sf,@vars_not_pars );
					my %tr = %{$info};
					$tr{'Extra'} = 1;
					push @extra_lines, [ $filtered_line, \%tr ];
				}
				$line = '!! Original line !! ' . $line;
				$info->{'Deleted'} = 1;
			} else {
				if ( scalar @vars == 1 ) {
					if ( exists( $Sf->{'Parameters'}{ $vars[0] } ) ) {
						# Remove this line
						$line = '!! Original line !! ' . $line;
						$info->{'Deleted'} = 1;
					} else {
						$line = format_f95_var_decl( $Sf, $vars[0] );						
					}
				} else {
					# filter out parameters
					my @vars_not_pars =
					  grep { not exists $Sf->{'Parameters'}{$_} } @vars;
					if (@vars_not_pars) {
						$line =
						  format_f95_multiple_var_decls( $Sf,@vars_not_pars );
					} else {
						$line = '!! Original line !! ' . $line;
						$info->{'Deleted'} = 1;
					}
				}
			}
		}		
			if (exists $tags{'If'} or exists $tags{'ElseIf'} ) {
				while ( $line =~ /\.\s+(?:and|not|or|neqv|eqv)\./ ) {
					$line =~ s/\.\s+(and|not|or|neqv|eqv)\./ .$1. /;
				}
				while ( $line =~ /\.\s+(?:and|not|or|neqv|eqv)\./ ) {
					$line =~ s/\.(and|not|or|neqv|eqv)\s+\./ .$1. /;
				}
				while ( $line =~ /\.\s*(?:eq|ne|gt|lt|le|ge)\s*\./ ) {
					$line =~ s/\.\s*(eq|ne|gt|lt|le|ge)\s*\./ $f95ops{$1} /;
				}
				# FIXME: it is possible that there is a conflict in the conditional expression!
				$line = rename_conflicting_vars($line,$stref,$f);
    		} elsif (exists $tags{'Assignment'}) { 
    			my $kv=$line;
    			my $spaces=$line; $spaces=~s/\S.*$//;
    			$kv=~s/^\s+//;    			
    			$kv=~s/\s+$//;
    			(my $k, my $rhs_expr) = split(/\s*=\s*/,$kv);
    			
    			$rhs_expr = rename_conflicting_vars($rhs_expr,$stref,$f);
=obsolete    			
    			my @rhs_vals= grep {/[a-z]\w*/} split( /\W+/, $rhs_expr );    			
    			my @n_rhs_vals=@rhs_vals;
    			my $conflict=0;
    			if (@rhs_vals) {
    				my $i=0;
    				for my $rhs_val (@rhs_vals) {
    					$n_rhs_vals[$i]=$rhs_val;
                        if (exists $Sf->{'ConflictingGlobals'}{$rhs_val}) {
                        	print "CONFLICT: $rhs_val in $line ($f)\n";
                            $n_rhs_vals[$i]=$Sf->{'ConflictingGlobals'}{$rhs_val};
                        } else {
                            for my $inc (keys %{ $Sf->{'Includes'} }) {                                        
                                if (exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val}) {
                                	print "CONFLICT: $rhs_val in <$line> ($f), from $inc\n";
                                	$conflict=1;
                                    $n_rhs_vals[$i] = $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val};
                                    last; 
                                }                    
                            }    	
                        }				
                        $i++;
    				}
    			}
    			for my $v (@rhs_vals) {
    				my $nv=shift @n_rhs_vals;
    				if ($nv ne $v) {
    				    $rhs_expr=~s/\b$v\b/$nv/;
    				}
    			}	
    			print "RHS: $rhs_expr\n" if $conflict;
	

    			my $nk=$k;
    			if (exists $Sf->{'ConflictingGlobals'}{$k}) {
    				$nk = $Sf->{'ConflictingGlobals'}{$k};
    			} else {
    			for my $inc (keys %{ $Sf->{'Includes'} }) {
#    				print "INC: $inc\n";    				
                    if (exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$k}) {
                         $nk=$stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$k};
                        last;
                    }    				
    			}	   		    
		      }
=cut            		      
		      my $nk= rename_conflicting_vars($k,$stref,$f);
		      $line = $spaces.$nk. ' = '.$rhs_expr;
		} # assignment
		elsif ( exists $tags{'Parameter'} ) {
			$line = '!! Original line !! ' . $line;
			$info->{'Deleted'} = 1;
		} 
		elsif ( exists $tags{'SubroutineCall'} ) {			
			$line = rename_conflicting_vars($line,$stref,$f);
		}
		elsif ( exists $tags{'Include'} ) {			
			
			my $inc=$tags{'Include'}{'Name'};
			
                $line = "      use $inc";
                # use must come right after subroutine/function/program
                # or after another use
                push @include_use_stack, [ $line, $info ];# if $line ne '';
                next;
                
		}
		push @{ $Sf->{'RefactoredCode'} }, [ $line, $info ];# if $line ne '';
		if (@extra_lines) {
			for my $extra_line (@extra_lines) {
				push @{ $Sf->{'RefactoredCode'} }, $extra_line;
			}
			@extra_lines = ();
		}
	}
    
    # now splice the include stack just below the signature
    if (@include_use_stack) {
    # 1. Look for the signature
    my $offset=0;
    for my $tmpannline ( @{ $Sf->{'RefactoredCode'} } ) {
    	if (exists $tmpannline->[1]{'Signature'} or 
    	exists $tmpannline->[1]{'SubroutineSig'} or 
    	exists $tmpannline->[1]{'FunctionSig'}) {
#    		print "Found sig for $f at $offset\n";
    		last;
    	}   
    	$offset++;
    	if (exists $tmpannline->[1]{'Include'}) {
    		die "Hit include without seeing sub or func in $f";
    	}
    }
#    if ($offset !=0) {
#    print "OFFSET $f:$offset\n";
#    }
    if ($offset==0) {
    	my $firstline=shift @{ $Sf->{'RefactoredCode'} };
    	my @new  = ($firstline,
                                @include_use_stack,
                                @{ $Sf->{'RefactoredCode'} }
                                );
                                $Sf->{'RefactoredCode'}=[@new];
    } else {
    	my @part1=();
    	for (0..$offset) {
    		push @part1, shift @{ $Sf->{'RefactoredCode'} };
    	}
    	my @part2=@{ $Sf->{'RefactoredCode'} };
        my @new  = (@part1,@include_use_stack,@part2);
        $Sf->{'RefactoredCode'}=[@new];
        
    }
    }	
#	if ( $f eq 'particles_main_loop' ) {
#		print "REFACTORED LINES ($f):\n";
#
#		for my $tmpline ( @{ $Sf->{'RefactoredCode'} } ) {
#			print $tmpline->[0], "\n";#"\t", join( ';', keys %{ $tmpline->[1] } ),"\n";
#		}
#		print "=================\n";
#		die;
#	}

	return $stref;
}    # END of context_free_refactorings()

# -----------------------------------------------------------------------------
sub create_refactored_source {
	( my $stref, my $f, ) = @_;
	print "CREATING FINAL $f CODE\n" if $V;
	die join( ' ; ', caller ) if $stref !~ /0x/;
	my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};
	my $annlines           = get_annotated_sourcelines( $stref, $f );
	$Sf->{'RefactoredCode'} = [];
	for my $annline ( @{$annlines} ) {

		if ( not defined $annline or not defined $annline->[0] ) {
			croak
			  "Undefined source code line for $f in create_refactored_source()";
		}
		my $line = $annline->[0];
		my $info = $annline->[1];
		
		if (    not exists $info->{'Comments'}
			and (exists $info->{'InBlock'} or not exists $info->{'Deleted'} ))
		{
			print $line, "\n" if $V;
			if ( $line =~ /;/ && $line !~ /[\'\"]/ ) {
				my $spaces = $line;
				$spaces =~ s/\S.*$//;
				$line   =~ s/^\s+//;
				my @split_lines = split( /\s*;\s*/, $line );
				for my $sline (@split_lines) {
					push @{ $Sf->{'RefactoredCode'} },
					  [ $spaces . $sline, $info ];
				}
			} else {
				$line =~ s/\s+\!\!.*$//
				  ; # FIXME: ad-hoc to remove comments from context-free refactoring
				   
				my @split_lines = split_long_line($line);
				for my $sline (@split_lines) {
					push @{ $Sf->{'RefactoredCode'} }, [ $sline, $info ];
				}
			}
		} else {
			push @{ $Sf->{'RefactoredCode'} }, [ $line, $info ];
		}
	}
	return $stref;
}    # END of create_refactored_source()

# -----------------------------------------------------------------------------

# A convenience function to split long lines.
# - count the number of characters, i.e. length()
# - find the last comma before we exceed 64 characters (I guess it's really 72-5?):

sub split_long_line {
	my $line = shift;

	my @chunks = @_;

	my $nchars = 64 + 28;
	if ( scalar(@chunks) == 0 ) {
		print "\nLINE: \n$line\n" if $V;
		$nchars = 72 + 28;
	}
	my $split_on  = ',';
	my $split_on2 = ' ';
	my $split_on3 = '.ro.';
	my $split_on4 = '.dna.';

	# FIXME: add split on ';' and on operators (F95)
	my $smart = 0;
	if ( length($line) > $nchars ) {
		my $patt  = '';
		my $ll    = length($line);
		my $rline = join( '', reverse( split( '', $line ) ) );

		#       print $rline,"\n";
		#       print "$ll - $nchars = ",$ll - $nchars,"\n";
		my $idx  = index( $rline, $split_on,  $ll - $nchars );
		my $idx2 = index( $rline, $split_on2, $ll - $nchars );
		my $idx3 = index( $rline, $split_on3, $ll - $nchars );
		my $idx4 = index( $rline, $split_on4, $ll - $nchars );
		if ( $idx < 0 && $idx2 < 0 && $idx3 < 0 && $idx4 < 0 ) {
			print "WARNING: Can't split line \n$line\n" if $W;
		} elsif ( $idx >= 0 ) {
			print "Split line on ", $ll - $idx, ", '$split_on'\n" if $V;
		} elsif ( $idx < 0 && $idx2 >= 0 ) {
			$idx = $idx2;
			print "Split line on ", $ll - $idx2, ", '$split_on2'\n"
			  if $V;
		} elsif ( $idx < 0 && $idx2 < 0 && $idx3 >= 0 ) {
			$idx = $idx3;
			print "SPLIT line on ", $ll - $idx, ", '$split_on3'\n"
			  if $V;

			# Need smarter split
			$smart = 1;
			$patt = join( '', reverse( split( '', $split_on3 ) ) );
		} elsif ( $idx < 0 && $idx2 < 0 && $idx4 >= 0 ) {
			$idx = $idx4;
			print "SPLIT line on ", $ll - $idx, ", '$split_on4'\n"
			  if $V;

			# Need smarter split
			$smart = 1;
			$patt = join( '', reverse( split( '', $split_on4 ) ) );
		}

#       if ($smart==1) {
#           die substr( $line, 0, $ll - $idx3, '' ) if length(substr( $line, 0, $ll - $idx3, '' ))>$nchars;
#       }
		push @chunks, substr( $line, 0, $ll - $idx, '' );
		print "CHUNKS:\n", join( "\n", @chunks ), "\n" if $V;
		print "REST:\n", $line, "\n" if $V;
		split_long_line( $line, @chunks );
	} else {
		push @chunks, $line;

		my @split_lines = ();
		if ( @chunks > 1 ) {
			my $fst  = 1;
			my $rest = scalar @chunks;
			for my $chunk (@chunks) {
				if ( $rest > 0 ) {
					$rest--;
					$chunk .= ' &';    # WARNING: FREE FORM!
				}
				if ($fst) {
					$fst = 0;
				} else {
					if ( $chunk =~ /^\s*$/ ) {
						$chunk = '';
					} else {

						#                       $chunk = '     &  ' . $chunk;
						#                        $chunk = '     &' . $chunk;
						$chunk = '      '
						  . $chunk;   # WARNING: free form but with 6 spaces ...
					}
				}
				push @split_lines, $chunk;
			}
		} else {
			@split_lines = @chunks;
		}
		if (   $split_lines[0] !~ /^\!/
			&& $split_lines[0] =~ /\t/
			&& $split_lines[0] !~ /^\s{6}/
			&& $split_lines[0] !~ /^\t/ )
		{

			# problematic tab!
			print "WARNING: Pathological TAB in " . $split_lines[0] . "\n"
			  if $W;
			my $sixspaces = ' ' x 6;
			$split_lines[0] =~ s/^\ +\t//;
			if ( length( $split_lines[0] ) > 66 ) {
				$split_lines[0] =~ s/^\s+//;
				$split_lines[0] =~ s/\s+$//;
			}
			if ( length( $split_lines[0] ) > 66 ) {
				print "WARNING: Line still too long: " . $split_lines[0] . "\n"
				  if $W;
			}
			$split_lines[0] = $sixspaces . $split_lines[0]
			  unless $split_lines[0] =~ /^\s+\d+/;
		}

		my @fin_lines = ();
		for my $chunk (@split_lines) {
			if ( $chunk =~ /^\s*\&\s*$/ ) {
				$chunk = '';
			} elsif ( $chunk =~ /\n\s*\&\s*$/m ) {
				$chunk =~ s/\n.*$//m;
			}
			push @fin_lines, $chunk;
		}
		if ( $fin_lines[-1] =~ /\&\s*$/ ) {
			$fin_lines[-1] =~ s/\s*\&\s*$//;
		} elsif ( @fin_lines>1 && $fin_lines[-1] =~ /^\s*$/ && $fin_lines[-2] =~ /\&\s*$/) {
			$fin_lines[-2] =~ s/\&\s*$//;
		}
		return @fin_lines;
	}
}    # END of split_long_line()

# -----------------------------------------------------------------------------
sub get_annotated_sourcelines {
	( my $stref, my $f ) = @_;
	my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
	my $Sf                 = $stref->{$sub_or_func_or_inc}{$f};

	my $annlines = [];
	if ( $Sf->{'Status'} == $PARSED ) {
		if ( not exists $Sf->{'RefactoredCode'} ) {
			$Sf->{'RefactoredCode'} = [];
			$annlines = [ @{ $Sf->{'AnnLines'} } ];    # We want a copy!
		} else {
			$annlines = $Sf->{'RefactoredCode'};       # Here a ref is OK
		}
	} else {
		warn "get_annotated_sourcelines( $f ) \n";
		warn "STATUS: $Sf->{'Status'} \n";
		warn Dumper($Sf);
		croak "$f NOT PARSED";
		die "\n",caller,"\n";
	}
	return $annlines;
}    # END of get_annotated_sourcelines()

# -----------------------------------------------------------------------------

sub format_f95_decl {
	( my $Sfv, my $var_is_par ) = @_;
	( my $var, my $is_par, my $val ) = @{$var_is_par};
	my $Sv = $Sfv->{$var};
	if ( not exists $Sv->{'Decl'} ) {
		print "WARNING: VAR $var does not exist in format_f95_decl()!\n" if $W;
		croak $var;
	}
	my $spaces = $Sv->{'Decl'};
	$spaces =~ s/\S.*$//;

	# FIXME: for multiple vars, we need to split this in multiple statements.
	# So I guess as soon as the Shape is not empty, need to split.
	my $shape = $Sv->{'Shape'};
	die Dumper($shape) if join( '', @{$shape} ) =~ /;/;
	my $dim = '';
	if ( @{$shape} ) {
		my @dims = ();
		for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
			my $range =
			  ( $shape->[ 2 * $i ] eq '1' )
			  ? $shape->[ 2 * $i + 1 ]
			  : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
			push @dims, $range;
		}
		$dim = ', dimension(' . join( ',', @dims ) . ') ';
	}
	my $decl_line = $spaces
      . $Sv->{'Type'}
      . $Sv->{'Attr'}
	  . $dim
	  . ( $is_par ? ', parameter ' : '' ) . ' :: '
	  . $var
	  . ( $is_par ? ' = ' . $val : '' );

	#    die $decl_line  if $dim;
	return $decl_line;
}    # format_f95_decl()

# -----------------------------------------------------------------------------
sub format_f95_var_decl {
	( my $Sf, my $var ) = @_;
	my $Sv = $Sf->{'Vars'}{$var};
	if ( not exists $Sv->{'Decl'} ) {
		print "WARNING: VAR $var does not exist in format_f95_decl()!\n" if $W;
		croak $var;
	} 
	my $nvar=$var;
	if (exists $Sf->{'ConflictingLiftedVars'}{$var} ){
	   $nvar=$Sf->{'ConflictingLiftedVars'}{$var};
	}
	my $spaces = $Sv->{'Decl'};
	$spaces =~ s/\S.*$//;
    
	# FIXME: for multiple vars, we need to split this in multiple statements.
	# So I guess as soon as the Shape is not empty, need to split.
	my $shape = $Sv->{'Shape'};
	die Dumper($shape) if join( '', @{$shape} ) =~ /;/;
	my $dim = '';
	if ( @{$shape} ) {
		my @dims = ();
		for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
			my $range =
			  ( $shape->[ 2 * $i ] eq '1' )
			  ? $shape->[ 2 * $i + 1 ]
			  : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
			push @dims, $range;
		}
		$dim = ', dimension(' . join( ',', @dims ) . ') ';
	}
	my $decl_line =
	  $spaces . $Sv->{'Type'} .$Sv->{'Attr'}. $dim . ' :: ' . $nvar;

	#    die $decl_line  if $dim;
	return $decl_line;
}    # format_f95_var_decl()

# -----------------------------------------------------------------------------
sub format_f77_var_decl {
    ( my $Sfv, my $var ) = @_;
    my $Sv = $Sfv->{$var};
    if ( not exists $Sv->{'Decl'} ) {
        print "WARNING: VAR $var does not exist in format_f77_var_decl()!\n" if $W;
        croak $var;
    }
    my $spaces = $Sv->{'Indent'};    

    # FIXME: for multiple vars, we need to split this in multiple statements.
    # So I guess as soon as the Shape is not empty, need to split.
    my $shape = $Sv->{'Shape'};
    
    my $dim = '';
    if ( @{$shape} ) {
        my @dims = ();
        for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
            my $range =
              ( $shape->[ 2 * $i ] eq '1' )
              ? $shape->[ 2 * $i + 1 ]
              : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
            push @dims, $range;
        }
        $dim = '(' . join( ',', @dims ) . ') ';
    }
    my $attr='';
    if (exists $Sv->{'Attr'} && $Sv->{'Attr'} ne '') {
    	$attr= '*'.$Sv->{'Attr'};
    }
    my $decl_line =
      $spaces . $Sv->{'Type'} .$attr. ' ' . $var . $dim ;

    #    die $decl_line  if $dim;
    return $decl_line;
}    # format_f77_var_decl()

# -----------------------------------------------------------------------------
#sub format_f95_multiple_decl {
#	( my $Sfv, my $var_is_par_tups ) = @_;
#	my @vars = map { $_->[0] } @{$var_is_par_tups};
#
#	my @var_vals = map { "$_->[0] = $_->[2]" } @{$var_is_par_tups};
#	my %test = map { ( $_->[1], 1 ) } @{$var_is_par_tups};
#	my $Sv = $Sfv->{ $vars[0] };
#	if ( not exists $Sv->{'Decl'} ) {
#		print "WARNING: VAR $vars[0] does not exist in format_f95_decl()!\n"
#		  if $W;
#		croak $vars[0];
#	}
#	my $spaces = $Sv->{'Indent'};
#	
#	my $type = $Sv->{'Type'};
# 	
#    my $attr = $Sv->{'Attr'};
#	# FIXME: for multiple vars, we need to split this in multiple statements.
#	# So I guess as soon as the Shape is not empty, need to split.
#	my $split = ( exists $test{0} and exists $test{1} );
#	if ( !$split ) {
#		for my $var (@vars) {
#			my $shape = $Sfv->{$var}{'Shape'};
#			if ( @{$shape} > 0 && @vars > 1 ) {
#				$split = 1;
#				last;
#			}
#		}
#	}
#
#	if ($split) {
#
#		my $decl_line = $spaces;    #.$Sv->{'Type'}.' :: '.join(', ',@vars);
#		  # What we need to do is split these into separate statements with semicolons
#		for my $tup ( @{$var_is_par_tups} ) {
#			( my $var, my $is_par, my $val ) = @{$tup};
#			my $dim   = '';
#			my $shape = $Sfv->{$var}{'Shape'};
#			if ( @{$shape} > 1 ) {
#
#				my @dims = ();
#				for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
#					my $range =
#					  ( "$shape->[2*$i]" eq '1' )
#					  ? $shape->[ 2 * $i + 1 ]
#					  : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
#					push @dims, $range;
#				}
#				$dim = ', dimension(' . join( ',', @dims ) . ') ';
#			}
#
#			my $decl = '';
#			if ($is_par) {
#				$decl =
#				  "$type$attr $dim ,parameter :: $var = $val; "
#				  ; # FIXME: it is possible that $val is a function of another parameter
#			} else {
#				$decl = "$type$attr $dim :: $var; ";
#			}
#			$decl_line .= $decl;
#		}
#		return $decl_line;
#	} else {
#
#		# for Shape, it means they are all empty OR there is just one!
#		my $dim = '';
#		if ( @vars == 1 ) {
#			my $shape = $Sfv->{ $vars[0] }{'Shape'};
#			if ( @{$shape} ) {
#				my @dims = ();
#				for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
#					my $range =
#					  ( $shape->[ 2 * $i ] eq '1' )
#					  ? $shape->[ 2 * $i + 1 ]
#					  : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
#					push @dims, $range;
#				}
#				$dim = ', dimension(' . join( ',', @dims ) . ') ';
#			}
#		}
#		my $decl_line = $spaces . $type . $attr . $dim;
#		if ( exists $test{1} ) {
#			$decl_line .= ' ,parameter :: ' . join( ', ', @var_vals );
#
#		} else {
#			$decl_line .= ' :: ' . join( ', ', @vars );
#		}
#		return $decl_line;
#	}
#}    # format_f95_multiple_decl()

# -----------------------------------------------------------------------------
sub format_f95_multiple_var_decls {
	( my $Sf, my @vars ) = @_;

	my $Sv = $Sf->{'Vars'}{ $vars[0] };
	if ( not exists $Sv->{'Decl'} ) {
		print "WARNING: VAR $vars[0] does not exist in format_f95_decl()!\n"
		  if $W;		  
		croak $vars[0];
	}
	my @nvars=();
	for my $var (@vars) {
		if (exists $Sf->{'ConflictingLiftedVars'}{$var} ){
            push @nvars, $Sf->{'ConflictingLiftedVars'}{$var};
        } else {
        	push @nvars,$var;
        }
	}
	my $spaces = $Sv->{'Indent'};
	
	my $type = $Sv->{'Type'};
	
    my $attr = $Sv->{'Attr'};
	# FIXME: for multiple vars, we need to split this in multiple statements.
	# So I guess as soon as the Shape is not empty, need to split.
	my $split = 0;
	if ( !$split ) {
		for my $var (@vars) {
			my $shape = $Sf->{'Vars'}{$var}{'Shape'};
			if ( @{$shape} > 0 && @vars > 1 ) {
				$split = 1;
				last;
			}
		}
	}

	if ($split) {

		my $decl_line = $spaces;    #.$Sv->{'Type'}.' :: '.join(', ',@vars);
		  # What we need to do is split these into separate statements with semicolons
		for my $var (@vars) {
            my $nvar=shift @nvars;
			my $dim   = '';
			my $shape = $Sf->{'Vars'}{$var}{'Shape'};
			if ( @{$shape} > 1 ) {

				my @dims = ();
				for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
					my $range =
					  ( "$shape->[2*$i]" eq '1' )
					  ? $shape->[ 2 * $i + 1 ]
					  : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
					push @dims, $range;
				}
				$dim = ', dimension(' . join( ',', @dims ) . ') ';
			}
            
			my $decl = "$type$attr $dim :: $nvar; ";
			$decl_line .= $decl;
		}
		return $decl_line;
	} else {

		# for Shape, it means they are all empty OR there is just one!
		my $dim = '';
		if ( @vars == 1 ) {
			my $shape = $Sf->{'Vars'}{ $vars[0] }{'Shape'};
			if ( @{$shape} ) {
				my @dims = ();
				for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
					my $range =
					  ( $shape->[ 2 * $i ] eq '1' )
					  ? $shape->[ 2 * $i + 1 ]
					  : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
					push @dims, $range;
				}
				$dim = ', dimension(' . join( ',', @dims ) . ') ';
			}
		}
		my $decl_line =
		    $spaces . $type . $attr. $dim . ' :: '
		  . join( ', ', @nvars )
		  . ' !! Context-free, multi !! ';
		return $decl_line;
	}
}    # format_f95_multiple_var_decls()

# ----------------------------------------------------------------------------------------------------

# This could work but it means the code has to be regenerated every time a parameter changes ...
sub resolve_params {
	( my $Sf, my $val ) = @_;

	$val =~ s/\s*$//;
	$val =~ s/^\s+//;

	if ( $val =~ /\b[a-df-z_]\w*\b/ ) {
		print "CALL: $val\n";
		my @chunks = split( /\s*[\/\+\-\*]\s*/, $val );
		my @maybe_pars;
		for my $chunk (@chunks) {
			print "[$chunk]\n";
			if ( $chunk =~ /^[a-z_]\w*/ ) {
				if ( exists $Sf->{'Parameters'}{$chunk} ) {
					push @maybe_pars, $chunk;
				} else {
					croak "Can't find PARAM $chunk";
				}
			}
		}
		print "VAL:<$val>\n";
		if (@maybe_pars) {
			for my $par (@maybe_pars) {
				print "TEST PAR:{$par}\n";
				my $tval = $Sf->{'Parameters'}{$par}{'Val'};
				print 'PAR:', $par, ' VAL:', $tval, "\n";
				$val =~ s/\b$par\b/$tval/;
				print "AFTER SUB:<$val>\n"; 
			}

			#                    die;
			resolve_params( $Sf, $val );
		} else {
			return $val;
		}
	} else {
		return $val;
	}
}

# -----------------------------------------------------------------------------

sub format_f95_par_decl {
	( my $stref,my $f, my $var ) = @_;
    my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};	
	my $val = $Sf->{'Parameters'}{$var}{'Val'};
	my $Sv  = $Sf->{'Vars'}{$var};
	my $local_par=0;
	if ( not exists $Sv->{'Decl'} ) {
		print "WARNING: PAR $var is probably local to $f in format_f95_par_decl()!\n" if $W;
		$local_par=1;
#		croak $var;
        $Sv->{'Type'} = $Sf->{'Parameters'}{$var}{'Type'};
        $Sv->{'Indent'} = ' ' x 6;
        $Sv->{'Shape'} = [];
        $Sv->{'Attr'}='';
	}
	
	# Here we should rename for globals!
	($var, $val) = rename_conflicting_global_pars($stref, $f, $var, $val);
	my $spaces = $Sv->{'Indent'} ;
	

	# FIXME: for multiple vars, we need to split this in multiple statements.
	# So I guess as soon as the Shape is not empty, need to split.
	my $shape = $Sv->{'Shape'} ;
	die Dumper($shape) if join( '', @{$shape} ) =~ /;/;
	my $dim = '';
	if ( @{$shape} ) {
		my @dims = ();
		for my $i ( 0 .. ( @{$shape} / 2 - 1 ) ) {
			my $range =
			  ( $shape->[ 2 * $i ] eq '1' )
			  ? $shape->[ 2 * $i + 1 ]
			  : $shape->[ 2 * $i ] . ':' . $shape->[ 2 * $i + 1 ];
			push @dims, $range;
		}
		$dim = ', dimension(' . join( ',', @dims ) . ') ';
	}
	my $decl_line = $spaces
	  . $Sv->{'Type'}
	  . $Sv->{'Attr'}
	  . $dim
	  . ', parameter ' . ' :: '
	  . $var . ' = '
	  . $val;

	#    die $decl_line  if $dim;
	if ($local_par) {
		print "WARNING: LOCAL PAR: $decl_line\n" if $W;  
	}
	return $decl_line;
}    # format_f95_decl()

sub rename_conflicting_global_pars {
	(my $stref, my $f, my $k, my $rhs_expr)=@_;
    my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};

                my @rhs_vals= grep {/[a-z]\w*/} split( /\W+/, $rhs_expr );              
                my @n_rhs_vals=@rhs_vals;
                if (@rhs_vals) {
                    my $i=0;
                    for my $rhs_val (@rhs_vals) {
#                       print" RHS: $rhs_val\n"; 
                        $n_rhs_vals[$i]=$rhs_val;
                        if (exists $Sf->{'ConflictingGlobals'}{$rhs_val}) {                            
                            $n_rhs_vals[$i]=$Sf->{'ConflictingGlobals'}{$rhs_val};
                        } else {
                            for my $inc (keys %{ $Sf->{'Includes'} }) {                                        
                                if (exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val}) {                                    
                                    $n_rhs_vals[$i] = $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val};
                                    last; 
                                }                    
                            }       
                        }               
                        $i++;
                    }
                }
                for my $v (@rhs_vals) {
                    my $nv=shift @n_rhs_vals;
                    if ($nv ne $v) {
                        $rhs_expr=~s/\b$v\b/$nv/;
                    }
                }   
                my $nk=$k;
                if (exists $Sf->{'ConflictingGlobals'}{$k}) {
                    $nk = $Sf->{'ConflictingGlobals'}{$k};
                } else {
                for my $inc (keys %{ $Sf->{'Includes'} }) {
#                   print "INC: $inc\n";                    
                    if (exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$k}) {
                         $nk=$stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$k};
                        last;
                    }                   
                }               
              }	
              return ($nk, $rhs_expr);
	
}
sub rename_conflicting_vars {
	(my $expr, my $stref, my $f)=@_;
    my $sub_or_func_or_inc = sub_func_or_incl( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
	
    my @vals= grep {/[a-z]\w*/} split( /\W+/, $expr );     
                my @n_vals=@vals;
                my $conflict=0;
                if (@vals) {
                    my $i=0;
                    for my $val (@vals) {
                        $n_vals[$i]=$val;
                        if ( $val eq 'if' ||
                           $val eq 'then' ||
                           $val eq 'else' ||
                           $val eq 'call'
                        ) {
                           #skip 
                        } else { 
                        
                        if (exists $Sf->{'ConflictingGlobals'}{$val}) {
                            print "CONFLICT: $val in $expr ($f)\n" if $V;
                            $n_vals[$i]=$Sf->{'ConflictingGlobals'}{$val};
                            $conflict=1;
                        } elsif (exists $Sf->{'ConflictingLiftedVars'}{$val}) {
                        	warn "CONFLICT (LIFT): $f: $expr\n" if $V;   
                        	$n_vals[$i]=$Sf->{'ConflictingLiftedVars'}{$val};
                        	$conflict=1;
                        } else {
                            for my $inc (keys %{ $Sf->{'Includes'} }) {                                        
                                if (exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$val}) {
                                    print "CONFLICT (INC): $val in <$expr> ($f), from $inc\n" if $V;
                                    $conflict=1;
                                    $n_vals[$i] = $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$val};
                                    last; 
                                }                    
                            }       
                        }       
                        }        
                        $i++;
                    }
                }
                for my $v (@vals) {
                    my $nv=shift @n_vals;
                    if ($nv ne $v) {
                        $expr=~s/\b$v\b/$nv/;
                    }
                }   
                print "EXPR: $expr\n" if $conflict && $V;
    return 	$expr;  		
}
