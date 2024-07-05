package RefactorF4Acc::Refactoring::Helpers;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast );
#
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp qw(croak carp confess longmess shortmess);
use Data::Dumper;
use Storable qw( dclone );
#$Data::Dumper::Indent = 0;

use Exporter;

@RefactorF4Acc::Refactoring::Helpers::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Helpers::EXPORT_OK = qw(
  &create_refactored_source
  &get_annotated_sourcelines
  &split_long_line
  &format_f95_par_decl
  &get_f95_par_decl
  &get_f95_var_decl
  &emit_f95_var_decl
  &emit_f95_parsed_var_decl
  &emit_f95_parsed_par_decl
  &splice_additional_lines
  &splice_additional_lines_cond_inplace
  &splice_additional_lines_cond
  &slice_annlines_cond
  &stateless_pass_inplace
  &stateful_pass_inplace
  &stateful_pass_reverse_inplace
  &stateless_pass
  &stateful_pass
  &stateful_pass_reverse
  &stateless_pass_reverse
  &top_src_is_module
  &pass_wrapper_subs_in_module
  &update_arg_var_decl_sourcelines
  &substitute_placeholders
  &parsedVarDecl_to_Decl
  %f95ops
);

our %f95ops = (
    'not'  => '.not.',     #       complement, negation
    'and'  => '.and.',     #       logical and, assoc
    'or'   => '.or.',      #       logical or, assoc
    'eqv'  => '.eq.',      #       logical equivalence
    'neqv' => '.neqv.',    #      logical not equivalence, exclusive or

    'eq' => '==',          #    equality, old
    'ne' => '/=',          #    not equal. old
    'lt' => '<',           #     less than, old
    'gt' => '>',           #     greater than, old
    'le' => '<=',          #    less than or equal, old
    'ge' => '>=',          #    greater than or equal, old

);

# -----------------------------------------------------------------------------
# This routine essentially discards unused lines and splits long lines
# I think this could actually be part of the emitter
sub create_refactored_source {
    ( my $stref, my $f, my $annlines, ) = @_;
    my $refactored_lines = [];

    for my $annline ( @{$annlines} ) {

       ( my $line , my $info ) = @{ $annline};

       push @{$info->{'Ann'}}, annotate("create_refactored_source($f)", __LINE__ );

        if ( not exists $info->{'Comments'} and ( exists $info->{'InBlock'} or not exists $info->{'Deleted'} ) ) {
            print $line, "\n" if $DBG;
				if (not exists $info->{'ReadCall'} and not exists $info->{'WriteCall'} and not exists $info->{'PrintCall'} ) {

					# Problem is of course that strings can contain comments and comments can contain quotes.
					# So placeholder strings can in principle occur in comments. That is what we are looking for here, trailing comments
					# So we must exclude the strings that look like comments, hence the PlaceHolders trick.
					# So in principle I must look for the first ! outside any pair of ' or "
					# say I split a line on ' => pre ' str1 ' sep1 ' str2 ' sep2_maybe_! '
					# So I remove pre; then I remove str then look at sep. If sep has ! => OK, found comment.

					my $line_without_comment = $line;
					if ($DBG) {
                        my $replace_PHs = 1;
                        if ($replace_PHs and exists $info->{'PlaceHolders'} ) {
                            my $ph_line=$line;
                            my $phs={};
                            for my $ph (keys %{$info->{'PlaceHolders'}} ) {
                                my $ph_str = $info->{'PlaceHolders'}{$ph};
                                $phs->{$ph_str}=$ph;
                            }
                                while ( $ph_line =~ /(\'.*?\')/ ) {
                                    my $strconst = $1;
                                    my $ph       = $phs->{$strconst};
                                    $ph_line =~ s/\'.*?\'/$ph/;
                                }
                                while ( $ph_line =~ /(\".*?\")/ ) {
                                    my $strconst = $1;
                                    my $ph       = $phs->{$strconst};
                                    $ph_line =~ s/\".*?\"/$ph/;
                                }
                            $line_without_comment = $ph_line;
                        }
					}
				    my $comment = '';
				    if ($DBG) {
                        # So after putting the strings back we check for a !
                        if ($line_without_comment =~/\!(.+)$/) { say "<$line>\n<$line_without_comment>";# if $line_without_comment=~/__PH\d+_/ ;
    #					say $info->{'TrailingComment'};
                                # found a comment, remove it from the line with placeholders (?!)
                                $comment=$1;
                                $line_without_comment = $line; # This is the line with placeholders
                                $line_without_comment =~s/\!$comment//; # So this should only work if there were no matched quotes in the comment!
                        } else {
                                $line_without_comment = $line;
                        }
				    }
 	           	    my @split_lines = $Config{'SPLIT_LONG_LINES'} ? split_long_line($line_without_comment) : ( $line_without_comment );
    	         	for my $sline (@split_lines) {
        	            	push @{$refactored_lines}, [ $sline, $info ];
            	    }
            	    if ($DBG) {
                        if ($comment ne '') {
                                $refactored_lines->[-1][0].=' !'.$comment;
                        }
            	    }
				} else {
					push @{$refactored_lines}, [ $line, $info ];
				}
        } else {
            push @{$refactored_lines}, [ $line, $info ];
        }
    }
    return $refactored_lines;
}    # END of create_refactored_source()

# -----------------------------------------------------------------------------
# A convenience function to split long lines.
# - count the number of characters, i.e. length()
# - find the last comma before we exceed 64 characters (I guess it's really 72-5?):
# There is a problem with trailing comments
# So I have to remove these first, then see if the line must be split, then append the comment to the last segment

sub split_long_line {
    my $line = shift;
    $line=~s/\s+/ /g unless $line=~/[\'\"]/; # replace multiple spaces by a single one if there are no string constants on the line
    my @chunks = @_;

    my $nchars = 64 + 28;
    if ( scalar(@chunks) == 0 ) {
#print "\nLINE: \n<$line>\n" if $DBG;
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

        my $idx  = index( $rline, $split_on,  $ll - $nchars );
        my $idx2 = index( $rline, $split_on2, $ll - $nchars );
        my $idx3 = index( $rline, $split_on3, $ll - $nchars );
        my $idx4 = index( $rline, $split_on4, $ll - $nchars );
        if ( $idx < 0 && $idx2 < 0 && $idx3 < 0 && $idx4 < 0 ) {
            print "WARNING: Can't split line \n$line\n" if $W;
        } elsif ( $idx >= 0 ) {
            print "Split line on ", $ll - $idx, ", '$split_on'\n" if $DBG;
        } elsif ( $idx < 0 && $idx2 >= 0 ) {
            $idx = $idx2;
            print "Split line on ", $ll - $idx2, ", '$split_on2'\n"
              if $DBG;
        } elsif ( $idx < 0 && $idx2 < 0 && $idx3 >= 0 ) {
            $idx = $idx3;
            print "SPLIT line on ", $ll - $idx, ", '$split_on3'\n"
              if $DBG;

            # Need smarter split
            $smart = 1;
            $patt = join( '', reverse( split( '', $split_on3 ) ) );
        } elsif ( $idx < 0 && $idx2 < 0 && $idx4 >= 0 ) {
            $idx = $idx4;
            print "SPLIT line on ", $ll - $idx, ", '$split_on4'\n"
              if $DBG;

            # Need smarter split
            $smart = 1;
            $patt = join( '', reverse( split( '', $split_on4 ) ) );
        }

        push @chunks, substr( $line, 0, $ll - $idx, '' );
        print "CHUNKS:\n", join( "\n", @chunks ), "\n" if $DBG;
        print "REST:\n", $line, "\n" if $DBG;
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
        } elsif ( @fin_lines > 1
            && $fin_lines[-1] =~ /^\s*$/
            && $fin_lines[-2] =~ /\&\s*$/ )
        {
            $fin_lines[-2] =~ s/\&\s*$//;
        }
        return @fin_lines;
    }
}    # END of split_long_line()

# -----------------------------------------------------------------------------
sub get_annotated_sourcelines {
    ( my $stref, my $f ) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    # croak if ref($f) eq 'HASH';
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
#die Dumper $stref->{Subroutines}{'global'}{Source};

    my $annlines = [];
#	croak "$sub_or_func_or_inc $f:".Dumper ($Sf) if not exists $Sf->{Status};
    if (exists  $Sf->{'Status'} ) {
        if ($Sf->{'Status'} == $PARSED ) {
            if ( not exists $Sf->{'RefactoredCode'} ) {
                $Sf->{'RefactoredCode'} = [];
                if ( defined $Sf->{'AnnLines'} ) {
                    $annlines = [ @{ $Sf->{'AnnLines'} } ];    # We want a copy!
                } else {
                    die 'get_annotated_sourcelines: no AnnLines for ' . $f;
                }
            } else {
                $annlines = $Sf->{'RefactoredCode'};           # Here a ref is OK
            }
        } else {
            print "WARNING: get_annotated_sourcelines($f) STATUS: "
            . show_status( $Sf->{'Status'} ). shortmess()
            if $DBG;
            if ( $Sf->{'Status'} > $INVENTORIED )
            {    # Means it was READ, and INVENTORIED but not PARSED
                print ", NOT PARSED\n" if $DBG;
            } else {
                print "\n" if $DBG;
            }
        }
    } else {
        warning(  "$sub_or_func_or_inc $f has no Status");
        if (exists $Sf->{'RefactoredCode'}) {
            $annlines = $Sf->{'RefactoredCode'};
        }
    }
    return $annlines;
}    # END of get_annotated_sourcelines()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
sub get_f95_var_decl {
    (my $stref, my $f, my $var) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
	my $Sf= $stref->{$sub_or_func_or_inc}{$f};
    my $spaces = '      ';
    my $intent = 'Unknown';
    my $dim  = [];
    my $attr   = '';
    my $type   = 'Unknown';
    my $nvar   = $var;
    my $array_or_scalar = 'Unknown';


    my $subset = in_nested_set($Sf, 'Vars', $var); # Should tell us exactly where we are

    if ($subset ne '' and exists $Sf->{$subset}{'Set'}{$var} and ref($Sf->{$subset}{'Set'}{$var}) eq 'HASH') {
    		my $decl = $Sf->{ $subset }{'Set'}{$var};
        	if ( exists $Sf->{'ConflictingLiftedVars'}{$var} ) {
            	$nvar = $Sf->{'ConflictingLiftedVars'}{$var};
            	say "WARNING: CONFLICT for VAR $var in $subset, setting var name to $nvar in format_f95_var_decl()!" if $WW;
				croak Dumper($decl) if $DBG;
        	}
            if (not exists $decl->{'Names'} and not exists $decl->{'Name'}) {
                croak "WARNING: VAR $var has no Name or Names field in get_f95_var_decl()! ".Dumper($decl) if $DBG;
                warning("VAR $var has no Names field in get_f95_var_decl()!" ,$WW);
                $decl->{'Names'}=[$nvar];
            }
        # 'Names' => [$nvar],
            if (not exists $decl->{'Name'}) {
                croak "WARNING: VAR $var has no Name field in get_f95_var_decl()!" if $DBG;
                warning("VAR $var has no Name field in get_f95_var_decl()!",$WW);
                $decl->{'Name'}=$nvar;
            }
        # 'Name' => $nvar,
            $decl->{'Status'} = 1;
            return $decl;

	        # $spaces =$decl->{'Indent'};
	        # $spaces =~ s/\S.*$//;
	        # $dim = $decl->{'Dim'};
	        # $type  = $decl->{'Type'};
	        # $attr  = $decl->{'Attr'};
	        # $intent = $decl->{'IODir'};
            # $array_or_scalar = $decl->{'ArrayOrScalar'};

    } elsif ( defined $f and defined $stref and defined $var ) {
        carp "WARNING: VAR '$var' in $f declared via IMPLICITS in get_f95_var_decl()!" if $DBG;
        warning("VAR '$var' in $f declared via IMPLICITS",2);
        ( $type, my $kind, $attr ) = type_via_implicits( $stref, $f, $var );
        return {
            'Indent' => $spaces,
            'Type' => $type,
            'Attr' => $attr,
            'Dim' => $dim,
            'IODir' => $intent,
            'ArrayOrScalar' => $array_or_scalar,
            'Names' => [$nvar],
            'Name' => $nvar,
            'Status' => 1,
            'MemSpace' => 'Global'
        };
    } else {
        croak
"Can't type $var, not in Vars and format_f95_var_decl() called the wrong way for implicits" if $DBG;
    }



}    # get_f95_var_decl()

# -----------------------------------------------------------------------------


sub format_f95_par_decl {
    ( my $stref, my $f, my $var_rec ) = @_;

    if ( ref($var_rec) eq 'HASH' && $var_rec->{'Status'} == 1 ) {
        return $var_rec;
    }
    my $var = do {
        if ( ref($var_rec) eq 'HASH' && $var_rec->{'Status'} == 0 ) {
            $var_rec->{'Name'};
        } else {
            $var_rec;
        }
    };

    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
    my $par_rec = get_var_record_from_set( $Sf->{'Parameters'},$var);

    my $val = $par_rec->{'Val'};

	my $type = defined $par_rec->{'Type'} ? $par_rec->{'Type'} : 'Unknown';
	my $attr = defined $par_rec->{'Attr'} ? $par_rec->{'Attr'} :  '';
    my $spaces = ' ' x 6;
	my $dim = [];
    if (exists $par_rec->{'Dim'}) {
        $dim=$par_rec->{'Dim'};
    }

	if (not defined $par_rec->{'Type'} or $par_rec->{'Type'} eq 'Unknown') {
		my $Sv = get_var_record_from_set($Sf->{'LocalVars'},$var);
		if (not defined $Sv) {
            say "WARNING: PARAMETER $var is probably local to $f in format_f95_par_decl(). If $f is a parameter include file, that is OK." if $W;
		} else {
			$spaces = $Sv->{'Indent'};
			$dim=$Sv->{'Dim'};
			if (
		 		not defined $Sv->{'Type'} or $Sv->{'Type'} eq 'Unknown'
			) {
				say "WARNINGL: IMPLICIT TYPING OF PARAM $var from $f" if $W;
				($type, my $array_or_scalar, $attr) =type_via_implicits( $stref, $f, $var);
			} else {
				$type = $Sv->{'Type'};
			}
		}
	}
    # Can't trust the type set via implicits! WEAK! FIXME!
    if ($val=~/^[\+\-\*\d]+$/) {
       	$type = 'integer';
    } elsif ($val=~/^[\.\+\-\*\/\d]+$/) {
       	$type = 'real';
    } elsif ($val=~/^[\'\"]/) {
        my $len = length($val) -2;
        $type = 'character';
        $attr="(len=$len)";
    } elsif ($val=~/^__PH\d+__/) {
        $type = 'character';
        $attr='len=*';
    }

    # FIXME: for multiple vars, we need to split this in multiple statements.
    # So I guess as soon as the Dim is not empty, need to split.
    my $shape = $dim;
    my $dimrec = [];
    if ( @{$shape} ) {
        $dimrec = $shape;
    }

    my $final_par_rec=
     {
        'Indent' => $spaces,
        'Type' => $type,
        'Attr' => $attr,
        'Dim' => $dimrec,
        'Parameter' => 'parameter',
        'Name' => [ $var, $val ] ,
        'Status' => 1
    };

     carp "FINAL PAR REC $f:".Dumper($final_par_rec) if $DBG and $type eq 'Unknown';

    return $final_par_rec;
}    # format_f95_par_decl()


# -----------------------------------------------------------------------------

sub get_f95_par_decl {
    ( my $stref, my $f, my $var ) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
    my $Sv = get_var_record_from_set($Sf->{'Parameters'},$var);

    if ( not defined $Sv ) {
        print
"WARNING: PARAMETER $var is probably local to $f in format_f95_par_decl(). If $f is a parameter include file, that is OK.\n"
          if $W;
          my $rec_from_f=get_var
        $Sv->{'Type'}   = 'Unknown';#$Sf->{'Parameters'}{'Set'}{$var}{'Type'};
        $Sv->{'Indent'} = ' ' x 6;
        $Sv->{'Dim'}  = [];
        $Sv->{'Attr'}   = '';
    }
    my $spaces = $Sv->{'Indent'};
    my $dim = $Sv->{'Dim'};
	my $val = $Sv->{'Val'};
    return {
        'Indent' => $spaces,
        'Type' => $Sv->{'Type'},
        'Attr' => $Sv->{'Attr'},
        'Dim' => $dim,
        'Parameter' => 'parameter',
        'Name' => [ $var, $val ] ,
        'Var' => $var,
        'Val' => $val,
        'Status' => 1
    };
}    # get_f95_par_decl()
# -----------------------------------------------------------------------------

sub _rename_conflicting_global_pars {
    ( my $stref, my $f, my $k, my $rhs_expr ) = @_;
    my $sub_or_func_or_inc = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_inc}{$f};
    my @rhs_vals = grep { /[a-z]\w*/ } split( /\W+/, $rhs_expr );
    my @n_rhs_vals = @rhs_vals;
    if (@rhs_vals) {
        my $i = 0;
        for my $rhs_val (@rhs_vals) {
            $n_rhs_vals[$i] = $rhs_val;
            if ( exists $Sf->{'ConflictingGlobals'}{$rhs_val} ) {
                $n_rhs_vals[$i] = $Sf->{'ConflictingGlobals'}{$rhs_val}[0];
            } else {
                for my $inc ( keys %{ $Sf->{'Includes'} } ) {
                    if (
                        exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val} )
                    {
                        $n_rhs_vals[$i] =
                          $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$rhs_val}[0];
                        last;
                    }
                }
            }
            $i++;
        }
    }
    for my $v (@rhs_vals) {
        my $nv = shift @n_rhs_vals;
        if ( $nv ne $v ) {
            $rhs_expr =~ s/\b$v\b/$nv/g;
        }
    }
    my $nk = $k;
    if ( exists $Sf->{'ConflictingGlobals'}{$k} ) {
        $nk = $Sf->{'ConflictingGlobals'}{$k}[0];
    } else {
        for my $inc ( keys %{ $Sf->{'Includes'} } ) {

            #                   print "INC: $inc\n";
            if (
                exists $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}
                {$k} )
            {
                $nk = $stref->{'IncludeFiles'}{$inc}{'ConflictingGlobals'}{$k}[0];
                last;
            }
        }
    }
    return ( $nk, $rhs_expr );
} # _rename_conflicting_global_pars()

sub emit_f95_var_decl {
    ( my $var_decl_rec , my $fold_consts) = @_;
    if (not defined $fold_consts) {
        $fold_consts=0;
    }

    # carp Dumper($var_decl_rec);
	if (not defined $var_decl_rec) {
		confess('Argument to emit_f95_var_decl is not defined!')  if $DBG;
	}
    if ( ref($var_decl_rec) ne 'HASH' ) {
        croak "NOT a HASH in emit_f95_var_decl(".$var_decl_rec.")"  if $DBG;
    }
    my $external = 0;#exists $var_decl_rec->{'External'} ? 1 : 0;
    my $spaces = $var_decl_rec->{'Indent'};
    croak Dumper($var_decl_rec) if $DBG and not defined $spaces;

      my $type = $var_decl_rec->{'Type'};
      if (not defined $type) {
      	croak Dumper($var_decl_rec) if $DBG;
        #    Dumper($stref->{'Subroutines'}{  $var_decl_rec->{'Name'});
      } elsif(ref($type) eq 'HASH') {
      	# Contains Type and Kind
      	my $ttype=$type->{'Type'};
      	my $tkind=$type->{'Kind'};
      	$type= $ttype . (defined $tkind ?  "($tkind)" : '');
      }
      my $attr= $var_decl_rec->{'Attr'};
      if ($fold_consts==1 and exists $var_decl_rec->{'ConstAttr'} and defined $var_decl_rec->{'ConstAttr'}
            ) {
            $attr =$var_decl_rec->{'ConstAttr'};
        }
      my $is_array = (exists $var_decl_rec->{'ArrayOrScalar'} and $var_decl_rec->{'ArrayOrScalar'} eq 'Array') ? 1 : 0;
      my $dim = $var_decl_rec->{'Dim'};
        if ($is_array and
            $fold_consts==1 and exists $var_decl_rec->{'ConstDim'} and defined $var_decl_rec->{'ConstDim'}
            ) {
            $dim =$var_decl_rec->{'ConstDim'};
        } elsif (exists $var_decl_rec->{'Val'}
            and $var_decl_rec->{'Val'}=~/^(\(\/|\[)/
        ) {
            my $const_array_sz = scalar split(/\s*\,\s*/,$var_decl_rec->{'Val'});
            $dim = [[1,$const_array_sz]];
            $var_decl_rec->{'ConstDim'} = $dim;
        } elsif ($DBG and $is_array) {
            carp "VAR has no ConstDim: ". Dumper($var_decl_rec);# ->{'Name'}

            # WV: TODO: create ConstDim here if the InheritedParams allow it
        }

      my $is_par = exists $var_decl_rec->{'Parameter'} ? 1 : 0;
      # We seem to have three ways of encoding the (var,val) pairs
      my ($var,$val);
      if ($is_par) { 

        if (exists $var_decl_rec->{'Name'} and defined $var_decl_rec->{'Name'}) {
            if (ref(  $var_decl_rec->{'Name'} ) eq 'ARRAY'  and scalar @{ $var_decl_rec->{'Name'} } == 2 ) {
                ($var,$val) = @{	$var_decl_rec->{'Name'} };
            } elsif (ref(  $var_decl_rec->{'Name'} ) ne 'ARRAY'  and exists $var_decl_rec->{'Val'} ) {
                $var = $var_decl_rec->{'Name'};
                $val = $var_decl_rec->{'Val'};
            }
        }
        elsif (exists $var_decl_rec->{'Var'} and defined $var_decl_rec->{'Var'}) {
            if (ref(  $var_decl_rec->{'Var'} ) eq 'ARRAY'  and scalar @{ $var_decl_rec->{'Var'} } == 2 ) {
                ($var,$val) = @{	$var_decl_rec->{'Var'} };
                croak 'SHOULD NEVER HAPPEN!' if $DBG;
            } elsif (ref(  $var_decl_rec->{'Var'} ) ne 'ARRAY'  and exists $var_decl_rec->{'Val'} ) {
                $var = $var_decl_rec->{'Var'};
                $val = $var_decl_rec->{'Val'};
            }
        } elsif(exists $var_decl_rec->{'Names'}) {
            if (scalar @{ $var_decl_rec->{'Names'} } == 1 and ref($var_decl_rec->{'Names'}[0]) eq 'ARRAY') {
                ($var,$val) = @{ $var_decl_rec->{'Names'}[0] };
            } else {
                croak 'Parameter declaration record is incorrect: '.Dumper($var_decl_rec) if $DBG;
            }
        }
      } else {
        if (exists $var_decl_rec->{'Var'}) {
            $var = $var_decl_rec->{'Var'}
        } elsif (exists $var_decl_rec->{'Name'} and defined $var_decl_rec->{'Name'}) {
            $var = $var_decl_rec->{'Name'} ;
        } else {
            croak Dumper $var_decl_rec;
        }
      }
        # carp Dumper( $var_decl_rec,$var);
     my $maybe_init_val = exists $var_decl_rec->{'InitialValue'} ? ' = '.$var_decl_rec->{'InitialValue'} : '';
    #  if ($maybe_init_val) {
    #  }
    # carp "DIM:".Dumper($dim);
    my $dimstr = '';
    if ( ref($dim) eq 'ARRAY' and scalar @{$dim}>0 
        and not (scalar @{$dim}==1 and $dim->[0].'' eq '0')) {
        if ( ref($dim->[0]) eq 'ARRAY' ) {
            my @dimpairs = map { $_->[0].':'.$_->[1] } @{ $dim };
            $dimstr = 'dimension(' . join( ',', @dimpairs) . ')';
        } else { # assuming it is alread a list of '$b:$e' strings
                $dimstr = 'dimension(' . join( ',', @{$dim}) . ')';
        }
    }
    my @attrs = ();
    if ($attr) {
    	if ( $type eq 'character') {
    	if ($attr=~/len/) {
    		$type.='('.$attr.')';
        } else {
                if ($attr=~/\((.+)\)/) {
                    $attr=$1;
                }
    		$type.='(len='.$attr.')';
        }
    		$attr='';
    	} elsif ($attr=~/kind/ ) {
            if ($attr=~/kind=\d+/ ) {
                $type=~s/\*\d+$//;
                if ($attr!~/\(.+\)/) {
                    $type.='('.$attr.')';$attr='';
                }
            } else {
                $attr='';
            }
    	} else {
            push @attrs, $attr;
    	}
    }
    if (exists $var_decl_rec->{'Allocatable'} ) {
    	push @attrs, 'allocatable';
    }
    if ($dimstr) {
        push @attrs, $dimstr;
    }

    if ( not $is_par ) {
        # Variable
        my $intent    =  $var_decl_rec->{'IODir'};
        if (exists $var_decl_rec->{'External'}) {
            $intent='Unknown';
        }
        if (not defined $intent or $intent eq '') {
#        	carp 'Intent not defined for '.Dumper($var_decl_rec) if $W;
        	say 'WARNING: Intent not known for declaration of '.$var if $WWW;#.' '.$var_decl_rec->{'Ann'} if $W;
        	$intent='Unknown';
        }
        if (ref($intent) eq 'ARRAY' and scalar @{$intent}==0) {
        	say "INFO: Intent is [] for $var, setting to Unknown" if $I;
        	$intent = 'Unknown';
        }
        my $trailing_comment='';
        my $intentstr = '';

        if ( $intent ne 'Unknown' and $intent ne 'Ignore' ) {
        	$intentstr ='intent('.$intent.')';
		}
		elsif ($intent eq 'Ignore' and $DBG) {
			$trailing_comment=" ! Intent $intent";
		}

        if (not $external) {
	        if ($intentstr) {
    	        push @attrs, $intentstr;
        	}
        } else {
        	    push @attrs, 'external';
        }

        if ( @attrs && $attrs[0] =~ /^\s*\(/ ) {
            my $decl_line =
                $spaces
              . $type
              . join( ', ', @attrs ) . ' :: '
              . $var . $maybe_init_val 
              . $trailing_comment;
            return $decl_line;
        } else {
            if (not defined $type) {
      	        croak Dumper($var_decl_rec)
            }

            my $decl_line =
                $spaces
              . join( ', ', ( $type, @attrs ) ) . ' :: '
              . $var . $maybe_init_val
              . $trailing_comment;
              #say 'emit_f95_var_decl 2'.$decl_line ;
            return $decl_line;
        }

    } else {
        # Parameter
#        say Dumper($var_decl_rec);
        if ($dimstr) {$dimstr.=', '}
        croak Dumper($var_decl_rec) if $DBG and not defined $val;

        my $var_val = ref($var) eq 'ARRAY' ? $var->[0] . '=' . $var->[1] :  $var.'='.$val;
        my $decl_line =
            $spaces
          . $type
          . $attr . ', '
          . $dimstr
          . 'parameter' . ' :: '
          . $var_val;

          #say 'emit_f95_var_decl PARAM: '.$decl_line ;

        return $decl_line;
    }
} # END of emit_f95_var_decl();

# -----------------------------------------------------------------------------
# This routine take $stref, $f, $insert_pos_lineID, $new_annlines, $insert_before, $skip_insert_pos_line
#- Go through the AnnLines
#- Find the hook based onthe lineID
#- splice the new lines after the hook.

sub splice_additional_lines {
    (
        my $stref, my $f,
        my $insert_pos_lineID,
        my $new_annlines,
        my $insert_before,
        my $skip_insert_pos_line
    ) = @_;
    say "SPLICE @ $insert_pos_lineID for $f" if $V;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    my $nextLineID         = scalar @{$annlines} + 1;
    my $merged_annlines    = [];
    my $once               = 1
      ; # This is needed because some comment/deleted lines have duplicate LineIDs

    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};

        if ( $info->{'LineID'} == $insert_pos_lineID and $once ) {
            $once = 0;

            #            say "SPLICE POINT $line";
            if ( not $skip_insert_pos_line and not $insert_before ) {
                say $annline->[0] if $DBG;
                push @{$merged_annlines}, $annline;
            }
            for my $extra_annline ( @{$new_annlines} ) {
                ( my $nline, my $ninfo ) = @{$extra_annline};
                $ninfo->{'LineID'} = $nextLineID++;
                say $nline if $DBG;
                push @{$merged_annlines}, [ $nline, $ninfo ];
            }
            if ( not $skip_insert_pos_line and $insert_before ) {
                say $annline->[0] if $DBG;
                push @{$merged_annlines}, $annline;
            }

        } else {
            say $annline->[0] if $DBG;
            push @{$merged_annlines}, $annline;
        }
    }

    return $merged_annlines;

}    # END of splice_additional_lines()

# Usage:
# $merged_annlines = splice_additional_lines_cond_inplace( $stref, $f, $insert_cond_subref, $old_annlines, $new_annlines, $insert_before, $skip_insert_pos_line, $once )
#- Go through the AnnLines
#- Find the hook based on a condition on the $annline (i.e. $insert_cond_subref->($annline) )
#- splice the new lines before/after the hook depending on $insert_before
#- if $once is 0, do this whenever the condition is met. Otherwise do it once
# NOTE that get_annotated_sourcelines will preferentially use RefactoredCode rather than AnnLines
# If this is unwanted, pass in $old_annlines explicitly
sub splice_additional_lines_cond_inplace {
    (
        my $stref,
        my $f,
        my $insert_cond_subref,
        my $old_annlines,
        my $new_annlines,
        my $insert_before,
        my $skip_insert_pos_line,
        my $do_once
    ) = @_;
    say "SPLICE on condition for $f" if ($V||$DBG);
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};

    my $annlines           = scalar @{$old_annlines} ? $old_annlines : get_annotated_sourcelines( $stref, $f );
    croak if $DBG and scalar @{$annlines}==0;
    my $nextLineID         = scalar @{$annlines} + 1;
    my $merged_annlines    = [];
    $do_once = defined $do_once ? $do_once : 1;
    my $once=1;

    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};
#        say Dumper($info);
        if ( $insert_cond_subref->($annline) and $once ) {
            $once = 0 unless $do_once==0;
            if (not $insert_before ) {
            	say $annline->[0] if $DBG;
                if ( not $skip_insert_pos_line ) {
                    push @{$merged_annlines}, $annline;
                } else {
            	   # Skip; but I comment out instead if $DBG is on
            	#    if ($DBG) {
            	#    	 $info->{'Comments'}=1;
            	# 	 push @{$merged_annlines}, ['! SKIP ! '.$line, $info];
            	#    }
                }
            }
            for my $extra_annline ( @{$new_annlines} ) {
                ( my $nline, my $ninfo ) = @{$extra_annline};
                $ninfo->{'LineID'} = $nextLineID++;
                say $nline if $DBG;
                push @{$merged_annlines}, [ $nline, $ninfo ];
            }
            if ($insert_before ) {
                say $annline->[0] if $DBG;
                if ( not $skip_insert_pos_line ) {
                    push @{$merged_annlines}, $annline;
                } else {
                   # Skip; but I comment out instead if $DBG is on
                #    if ($DBG) {
                #      $info->{'Comments'}=1;
                #      push @{$merged_annlines}, ['! '.$line, $info];
                #    }
                }
            }
        } else {
            say $annline->[0] if $DBG;
            push @{$merged_annlines}, $annline;
        }
    }
    say "END SPLICE on condition for $f" if ($V||$DBG);
    return $merged_annlines;

}    # END of splice_additional_lines_cond_inplace()


sub splice_additional_lines_cond {
    (
        my $insert_cond_subref,
        my $annlines,
        my $annlines_to_splice,
        my $insert_before,
        my $skip_insert_pos_line,
        my $do_once
    ) = @_;

    croak if $DBG and scalar @{$annlines}==0;
    my $nextLineID         = scalar @{$annlines} + 1;
    my $merged_annlines    = [];
    $do_once = defined $do_once ? $do_once : 1;
    my $once=1;

    for my $annline ( @{$annlines} ) {
        ( my $line, my $info ) = @{$annline};
        if ( $insert_cond_subref->($annline) and $once ) {
            $once = 0 unless $do_once==0;
            if (not $insert_before ) {
            	say $annline->[0] if $DBG;
                if ( not $skip_insert_pos_line ) {
                    push @{$merged_annlines}, $annline;
                } else {
            	   # Skip; but I comment out instead if $DBG is on
            	   if ($DBG) {
            	   	 $info->{'Comments'}=1;
            		 push @{$merged_annlines}, ['! SKIP ! '.$line, $info];
            	   }
                }
            }
            for my $extra_annline ( @{$annlines_to_splice} ) {
                ( my $nline, my $ninfo ) = @{$extra_annline};
                $ninfo->{'LineID'} = $nextLineID++;
                say $nline if $DBG;
                push @{$merged_annlines}, [ $nline, $ninfo ];
            }
            if ($insert_before ) {
                say $annline->[0] if $DBG;
                if ( not $skip_insert_pos_line ) {
                    push @{$merged_annlines}, $annline;
                } else {
                   # Skip; but I comment out instead if $DBG is on
                   if ($DBG) {
                     $info->{'Comments'}=1;
                     push @{$merged_annlines}, ['! '.$line, $info];
                   }
                }
            }
        } else {
            say $annline->[0] if $DBG;
            push @{$merged_annlines}, $annline;
        }
    }

    return $merged_annlines;

}    # END of splice_additional_lines_cond()

# Return the first slice of AnnLines matching the conditions for begin and end lines
# $cond_* :: AnnLine -> Bool -- give the conditions for the first and last line of the slice :: AnnLine -> Bool
# $skip_*_line :: Bool
# stateless_pass :: AnnLines -> (AnnLine -> Bool) -> (AnnLine -> Bool) -> Bool -> Bool -> AnnLines
sub slice_annlines_cond {
    my ($annlines, $cond_begin, $cond_end, $skip_begin_line,$skip_end_line) = @_;
    if (not defined $skip_begin_line) {
        $skip_begin_line=0;
    }
    if (not defined $skip_end_line) {
        $skip_end_line=0;
    }
    my $annlines_slice=[];
    my $in_slice = 0;
    for my $annline ( @{$annlines} ) {
        if ($cond_begin->($annline)) {
            $in_slice=1;
            next if $skip_begin_line;
        }
        if ($in_slice and $cond_end->($annline)) {
            $in_slice=0;
            push @{$annlines_slice},$annline unless $skip_end_line;
            last;
        }
        if($in_slice) {
            push @{$annlines_slice},$annline;
        }
    }
    return $annlines_slice;
} # END of slice_annlines_cond()

# The passes below go through all lines of code that are not marked as Deleted
# TODO: add some control over this
sub stateless_pass_inplace {
    (my $stref, my $f, my $pass_actions, my $pass_info, my $keep_deleted) = @_;

    # say "STATELESS PASS INPLACE ".Dumper($pass_info)." for $f" if $DBG;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    # croak Dumper $f if ref($f) eq 'HASH';
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {
    	if (not exists $annline->[1]{'Deleted'}) {
	        my $pass_annlines = $pass_actions->($annline); # returns an ARRAY ref
	        for my $new_annline (@{ $pass_annlines }) {
                if (not exists $new_annline->[1]{'Deleted'}) {
	        	    push @{$new_annlines}, $new_annline;
                }
	        }
    	} else {
            if (defined $keep_deleted) {
    		    push @{$new_annlines}, $annline;
            }
    	}
    }
    $Sf->{'RefactoredCode'} = $new_annlines;
    return $stref;
} # END of stateless_pass_inplace()

# This version of the stateless pass takes $annlines as argument and returns $new_annlines
sub stateless_pass {
    my ($annlines, $pass_actions, $pass_info, $keep_deleted) = @_;

    # say "STATELESS PASS ".Dumper($pass_info) if $DBG;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {
    	if (not exists $annline->[1]{'Deleted'}) {
	        my $pass_annlines = $pass_actions->($annline); # returns an ARRAY ref
            croak if ref($pass_annlines) ne 'ARRAY';
	        for my $new_annline (@{ $pass_annlines }) {
                if (not exists $new_annline->[1]{'Deleted'}) {
	        	push @{$new_annlines}, $new_annline;
                }
	        }
    	} else {
            if (defined $keep_deleted) {
    		    push @{$new_annlines}, $annline;
            }
    	}
    }
    return $new_annlines;
} # END of stateless_pass()

# original  annlines are taken from $Sf->{'AnnLines'} or $Sf->{'RefactoredCode'}
# updated annlines are stored in $Sf->{'RefactoredCode'}
sub stateful_pass_inplace { my ( $stref, $f, $pass_actions, $state, $pass_info, $keep_deleted ) = @_;
    # return ($stref,$state);
#    local $Data::Dumper::Indent =0;
#    local $Data::Dumper::Terse=1;
    # say "STATEFUL PASS INPLACE ".Dumper($pass_info)." for $f" if $DBG;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );

    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );
    

    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {
    	if (not exists $annline->[1]{'Deleted'}) {
	        (my $pass_annlines, $state) = $pass_actions->($annline, $state);
    	    for my $new_annline (@{ $pass_annlines }) {
                if (not exists $new_annline->[1]{'Deleted'}) {
        		push @{$new_annlines}, $new_annline;
                }
        	}
    	} else {
            if (defined $keep_deleted) {
    		push @{$new_annlines}, $annline;
            }
    	}
    }
    $Sf->{'RefactoredCode'} = $new_annlines;

    return ($stref,$state);
} # END of stateful_pass_inplace()

# This version of the stateful pass takes $annlines as argument and returns $new_annlines
sub stateful_pass { my ( $annlines, $pass_actions, $state, $pass_info, $keep_deleted ) = @_; # return ($new_annlines,$state);
    # say "STATEFUL PASS ".Dumper($pass_info) if $DBG;

    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( @{$annlines} ) {
    	if (not exists $annline->[1]{'Deleted'}) {
	        (my $pass_annlines, $state) = $pass_actions->($annline, $state);
    	    for my $new_annline (@{ $pass_annlines }) {
                if (not exists $new_annline->[1]{'Deleted'}) {
        		push @{$new_annlines}, $new_annline;
                }
        	}
    	} else {
            if (defined $keep_deleted) {
    		push @{$new_annlines}, $annline;
            }
    	}
    }

    return ($new_annlines,$state);
} # END of stateful_pass()

sub stateful_pass_reverse_inplace {
    (my $stref, my $f, my $pass_actions, my $state, my $pass_info, my $keep_deleted ) = @_;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );

    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $annlines           = get_annotated_sourcelines( $stref, $f );

    my $nextLineID         = scalar @{$annlines} + 1;
    my $new_annlines=[];
    for my $annline ( reverse @{$annlines} ) {
#    	if (ref(    	$annline->[1] ) ne 'HASH') {croak 'ANNLINE: '. Dumper($annline);}
    	if (not exists $annline->[1]{'Deleted'}) {
	        (my $pass_annlines, $state) = $pass_actions->($annline, $state);
    	    for my $new_annline (@{ $pass_annlines }) {
        		push @{$new_annlines}, $new_annline;
        	}
    	} else {
            if (defined $keep_deleted) {
    		push @{$new_annlines}, $annline;
            }
    	}
    }
    $new_annlines =[ reverse @{ $new_annlines  } ];
    $Sf->{'RefactoredCode'} = $new_annlines;

    return ($stref,$state);
} # END of stateful_pass_inplace()

sub stateful_pass_reverse {
   my ($annlines, $pass_actions, $state, $pass_info, $keep_deleted ) = @_;
    my $new_annlines_rev=[];
    for my $annline ( reverse @{$annlines} ) {
    	if (not exists $annline->[1]{'Deleted'}) {
	        (my $pass_annlines, $state) = $pass_actions->($annline, $state);
    	    for my $new_annline (@{ $pass_annlines }) {
        		push @{$new_annlines_rev}, $new_annline;
        	}
    	} else {
            if (defined $keep_deleted) {
    		    push @{$new_annlines_rev}, $annline;
            }
    	}
    }
    my $new_annlines =[ reverse @{ $new_annlines_rev  } ];

    return ($new_annlines,$state);
} # END of stateful_pass_reverse()

sub stateless_pass_reverse {
   my ($annlines, $pass_actions, $pass_info, $keep_deleted ) = @_;
    my $new_annlines_rev=[];
    for my $annline ( reverse @{$annlines} ) {
    	if (not exists $annline->[1]{'Deleted'}) {
	        my $pass_annlines = $pass_actions->($annline);
    	    for my $new_annline (@{ $pass_annlines }) {
        		push @{$new_annlines_rev}, $new_annline;
        	}
    	} else {
            if (defined $keep_deleted) {
    		    push @{$new_annlines_rev}, $annline;
            }
    	}
    }
    my $new_annlines =[ reverse @{ $new_annlines_rev  } ];

    return $new_annlines;
} # END of stateless_pass_reverse()


sub emit_f95_parsed_var_decl { (my $pvd) =@_;
    # Kind does not contain 'kind=' or 'len='
    my $type= $pvd->{'TypeTup'}{'Type'} . (exists $pvd->{'TypeTup'}{'Kind'} 
        ? '(kind='.$pvd->{'TypeTup'}{'Kind'}.')'
        : '');
    my @attrs=($type);
    # Special case for character, needs 'len='
    if ($pvd->{'TypeTup'}{'Type'} eq 'character') { 
        $type = $pvd->{'TypeTup'}{'Type'};
        if (exists $pvd->{'Attributes'} and exists $pvd->{'Attributes'}{'Len'}) {
            @attrs=($type.'('.$pvd->{'Attributes'}{'Len'}.')' );
        } elsif (exists $pvd->{'TypeTup'}{'Kind'}) { 
            @attrs=($type.'(len='.$pvd->{'TypeTup'}{'Kind'}.')' );
        } else {
            @attrs=($type);
        }
    }
    if (exists $pvd->{'Attributes'}{'Allocatable'}) {
        push @attrs, 'allocatable';
    }
    if (exists $pvd->{'Attributes'}{'Parameter'}) {
        push @attrs, 'parameter';
    }
    if (exists $pvd->{'Attributes'}{'Dim'} 
    and not (scalar @{$pvd->{'Attributes'}{'Dim'}}==1
    and $pvd->{'Attributes'}{'Dim'}[0].'' eq '0')
    ) {
        push @attrs,'dimension('.join(', ',  @{ $pvd->{'Attributes'}{'Dim'} }).')';
    }
    if (exists $pvd->{'Attributes'}{'Intent'} ) {
        push @attrs,'intent('. $pvd->{'Attributes'}{'Intent'} .')' ;
    }

    if (exists $pvd->{'InitExprAST'}) {
        my @init_expr_strs=();
        my $init_expr_ast =$pvd->{'InitExprAST'};
        push @init_expr_strs, emit_expr_from_ast($init_expr_ast);

        my @init_pairs=();
        for my $var (@{  $pvd->{'Vars'} } ){
            my $init_expr_str = shift @init_expr_strs;
            push @init_pairs, $var.' = '.$init_expr_str;
        }
        my $init_pairs_str = join(', ',@init_pairs);
        my $line = join(', ', @attrs) . ' :: ' . $init_pairs_str;
        return $line;
    } elsif (exists $pvd->{'Pars'} and defined $pvd->{'Pars'} and defined $pvd->{'Pars'}{'Var'}) { 
        my $par_val = $pvd->{'Pars'}{'Var'}.' = '.$pvd->{'Pars'}{'Val'};
        my $line = join(', ', @attrs).' :: '.$par_val;
        return $line;
    } elsif (exists $pvd->{'Vars'} and defined $pvd->{'Vars'}) {
        my $vars = join(', ',@{  $pvd->{'Vars'} });
        my $line = join(', ', @attrs).' :: '.$vars;
        return $line;
    }
}

sub emit_f95_parsed_par_decl { (my $pvd) =@_;
    my $type= $pvd->{'TypeTup'}{'Type'} . (exists $pvd->{'TypeTup'}{'Kind'} ?  '( '.$pvd->{'TypeTup'}{'Kind'}.')' : '');
    my  @attrs=($type);

    if (exists $pvd->{'Attributes'} ) {
        push @attrs,join(', ',grep { !ref($_) } values %{$pvd->{'Attributes'}});
        # carp Dumper($pvd->{'Attributes'}) ;
    }

    my $par_val = $pvd->{'Pars'}{'Var'}.' = '.$pvd->{'Pars'}{'Val'};
    my $line = join(', ', @attrs).' :: '.$par_val;
    return $line;
}

sub top_src_is_module {( my $stref, my $s) = @_;
    my $sub_func_incl = sub_func_incl_mod( $s, $stref );
    if ($sub_func_incl eq 'Modules') { return 1};
	my $is_incl = exists $stref->{'IncludeFiles'}{$s} ? 1 : 0;
    my $f = $is_incl ? $s : $stref->{$sub_func_incl}{$s}{'Source'};
    if ( defined $f ) {
		for my $item ( @{ $stref->{'SourceContains'}{$f}{'List'} } ) {
			# If $s is a subroutine, it could be that the source file is a Module, and then we should set that as the entry source type
			if ($stref->{'SourceContains'}{$f}{'Set'}{$item} eq 'Modules') {
				my @subs_in_mod= @{ $stref->{'Modules'}{$item}{'Contains'} };
				if (grep {$_ eq $s} @subs_in_mod) {
					return 1;
				}
			}
		}
    }
	return 0;
}

# This is a wrapper to get the subroutines out of a module and then call other passes on these subroutines
# It does this for all sources but in practice it assumes a single source, so it might be better to pass this source name in as an arg instead
# This does NOT do a recursive descent on the call tree!
sub pass_wrapper_subs_in_module { (my $stref,my $module_name, my $module_pass_sequences, my $sub_pass_sequences, my @rest) = @_;
# say "CALL to pass_wrapper_subs_in_module($module_name)";
# local $V=1;
	if ($module_name eq ''
    or not exists $stref->{'Modules'}{$module_name}
    ) {

		my %is_existing_module = ();
	    my %existing_module_name = ();
		# croak $module_name.Dumper [ $stref->{'SourceContains'},$stref->{'Top'}, $stref->{'Program'}] ;
        say "NOT A MODULE NAME: <$module_name>" if $V;
		for my $src (keys %{ $stref->{'SourceContains'} } ) {

            if ($module_name eq  $stref->{'Top'}) {
                next unless $src eq  $stref->{'Program'};
            }
			if (exists $stref->{'SourceContains'}{$src}{'Path'}
			and  exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'} ) {
			  # External, SKIP!
				say "SKIPPING $src";
			} else {
	    		# Get the unit name from the list
			    for my $sub_or_func_or_mod ( @{  $stref->{'SourceContains'}{$src}{'List'}   } ) {
			    	# Get its type
			        my $sub_func_type= $stref->{'SourceContains'}{$src}{'Set'}{$sub_or_func_or_mod};
			        if ($sub_func_type eq 'Modules') {
			        	$is_existing_module{$src}=1;
			        	$existing_module_name{$src} = $sub_or_func_or_mod;
			        }
			    }
			}
			my $has_contains = ( $is_existing_module{$src} and exists $stref->{'Modules'}{$existing_module_name{$src}}{'Contains'}  ) ? 1 : 0;

			my @subs = $is_existing_module{$src}
                ? $has_contains
                    ? @{ $stref->{'Modules'}{$existing_module_name{$src}}{'Contains'} }
                    : ()
                :  grep {$_ ne 'UNKNOWN_SRC' and (
                $_ eq $module_name or
                exists $stref->{'Subroutines'}{$module_name}{'CalledSubs'}{'Set'}{$_}
                 ) } sort keys %{ $stref->{'Subroutines'} };
# croak Dumper (@subs);
			for my $pass_sequence (@{$sub_pass_sequences}) {
				for my $f ( @subs ) {
                    # my $pass_sub_ctr = 1;
					for my $pass_sub_ref (@{$pass_sequence}) {
                    # warn Dumper sort keys %{$stref->{'Subroutines'}{$f}} if $f=~/_scal/;
                    # warn "NOT IN MODULE: $src $pass_ctr $f $pass_sub_ctr ";
                    say "SUB PASS ".coderef_to_subname($pass_sub_ref)."($f)" if $V;

						$stref=$pass_sub_ref->($stref, $f, @rest);
                    #   ++$pass_sub_ctr;
					}
				}
                # ++$pass_ctr;
			}
		}

	} else {

        # Proper modules
		for my $pass_sequence (@{$module_pass_sequences}) {
            for my $pass_sub_ref (@{$pass_sequence}) {
                say "MODULE PASS ".coderef_to_subname($pass_sub_ref)."($module_name)" if $V;
                $stref=$pass_sub_ref->($stref, $module_name, @rest);
            }
		}
        my $has_contains = exists $stref->{'Modules'}{$module_name}{'Contains'}  ? 1 : 0;
        my @subs =  $has_contains ? @{ $stref->{'Modules'}{$module_name}{'Contains'} } : ()  ;
        # But we must also check any subs that are in a separate module, via use
        my @subs_from_modules=();
        for my $sub (@subs) {

            if (exists $stref->{'Subroutines'}{$sub}{'Uses'}) {
                for my $used_module (sort keys %{$stref->{'Subroutines'}{$sub}{'Uses'}}) {
                    my $subs_from_module=
                        scalar @{$stref->{'Subroutines'}{$sub}{'Uses'}{$used_module}}>0
                        ? $stref->{'Subroutines'}{$sub}{'Uses'}{$used_module}
                        : (exists $stref->{'Modules'}{$used_module}{'Contains'} and
                        scalar @{$stref->{'Modules'}{$used_module}{'Contains'}} > 0)
                        ? $stref->{'Modules'}{$used_module}{'Contains'}
                        : [];
                    for my $sub_from_module (@{$subs_from_module}) {
                        # If this sub is called in the parent module, then we need it
                        if (exists $stref->{'Subroutines'}{$sub}{'CalledSubs'}{'Set'}{$sub_from_module}) {
                            say "ADDED $sub_from_module from module $used_module" if $V;
                            push @subs_from_modules, $sub_from_module;
                        }
                    }
                }
            }
        }

        for my $pass_sequence (@{$sub_pass_sequences}) {
            for my $f ( @subs,  @subs_from_modules) {
                for my $pass_sub_ref (@{$pass_sequence}) {
                    say "SUB PASS ".coderef_to_subname($pass_sub_ref)."($f)" if $V;
                    $stref=$pass_sub_ref->($stref, $f, @rest);
                }
            }
        }
	}
	return $stref;
}

# Emit a new source line based on the variable name in $info and the $decl record in RefactoredArgs
# I might have a flag here to say "use the name from the record"
sub update_arg_var_decl_sourcelines { (my $stref, my $f)=@_;
	my $pass_update_arg_var_decls = sub { (my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};
		(my $stref, my $f) = @{$state};
		if ( exists $info->{'VarDecl'} ) {
			my $var = $info->{'VarDecl'}{'Name'}; # May need OrigName?
			if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$var} ) {
                my $decl = $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$var};
				# We store the var name from $decl in $pvar, then replace it temporarily with $var, in case a var had been renamed in $info (for example for scalarisation)
				# to emit the actual F95 code
				# Then we put $pvar back into the $decl, which will put it back into $stref
                my $pvar =$decl->{'Name'};
                $decl->{'Name'}=$var;
			    $line = emit_f95_var_decl($decl);
                $decl->{'Name'}=$pvar;
			}
		}
		return ([[$line,$info]],$state);
	};

	my $state=[$stref,$f];
 	($stref,$state) = stateful_pass_inplace($stref,$f,$pass_update_arg_var_decls, $state,'pass_update_arg_var_decls() ' . __LINE__  ) ;
    return $stref;
} # END of update_arg_var_decl_sourcelines


sub substitute_placeholders { (my $stref)=@_;
	for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		next if exists $stref->{'Entries'}{$f};
		$stref=_substitute_placeholders_per_source($stref,$f);
	}
	return $stref;
} # END of substitute_placeholders

sub _substitute_placeholders_per_source { (my $stref,my $f) =@_;

	my $pass_action = sub { (my $annline, my $prev_annline)=@_;
		(my $line,my $info)=@{$annline};
		if (exists $info->{'PlaceHolders'}) {
			while ($line =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$line=~s/$ph/$ph_str/;
			}
			$annline = [$line, $info];
		}
		return [$annline];
	};

 	$stref = stateless_pass_inplace($stref,$f,$pass_action, '_substitute_placeholders_per_source() ' . __LINE__  ) ;
	return $stref
} # END of _substitute_placeholders_per_source

sub parsedVarDecl_to_Decl { my ($pvd, $decl) = @_;
# carp 'parsedVarDecl_to_Decl: '.Dumper( $decl);
    my $mdecl = dclone($decl);
    $mdecl->{'ArrayOrScalar'} = 'Scalar';
    $mdecl->{'Name'} = $pvd->{'Vars'}[0];


    if (exists $mdecl->{'Names'} ){
        delete $mdecl->{'Names'}
    }

    $mdecl->{'Type'} = $pvd->{'TypeTup'}{'Type'};
    if ( exists $pvd->{'TypeTup'}{'Kind'}) {
        $mdecl->{'Attr'} = 
            $mdecl->{'Type'} ne 'character'
            ? '(kind='.$pvd->{'TypeTup'}{'Kind'}.')'
            : '(len='.$pvd->{'TypeTup'}{'Kind'}.')';
    }
    if (exists $pvd->{'Attributes'}{'Dim'} ) {
        my @shape = ();
        for my $range ( @{ $pvd->{'Attributes'}{'Dim'} } ) {
            if ( $range =~ /:/ ) {
                push @shape, [ split( /:/, $range ) ];
            } else {
                push @shape, [ '1', $range ];
            }
        }
        $mdecl->{'Dim'}           = \@shape;
        if (scalar @shape>0) {
            $mdecl->{'ArrayOrScalar'} = 'Array';
        }
    }
    if (exists $pvd->{'Attributes'}{'Parameter'} ) {
        $mdecl->{'Parameter'} = 'parameter';
        $mdecl->{'Var'} = $pvd->{'Pars'}{'Var'};
        $mdecl->{'Val'} = $pvd->{'Pars'}{'Val'};
        if (exists $pvd->{'Pars'}{'AST'}) {
            $mdecl->{'AST'} = $pvd->{'Pars'}{'AST'};
        }
    } elsif (exists $pvd->{'Pars'} and exists $pvd->{'Pars'}{'Val'}) {
        # carp Dumper $pvd->{'Pars'};
        $mdecl->{'InitialValue'} =$pvd->{'Pars'}{'Val'}
    } elsif (exists $mdecl->{'InitialValue'}) {
        delete  $mdecl->{'InitialValue'}
    }
    $mdecl->{'IODir'} = defined $pvd->{'Attributes'}{'Intent'} ? $pvd->{'Attributes'}{'Intent'} : 'Unknown';
    if ( exists $pvd->{'Attributes'}{'Allocatable'}) {
        $mdecl->{'Allocatable'}='allocatable';

        my $alloc_dim = exists $pvd->{'Attributes'}{'Dim'}
            ? $pvd->{'Attributes'}{'Dim'}[0]
            : 0;
        if ($alloc_dim==0) {
            if ($pvd->{'TypeTup'}{'Kind'} eq ':'	) {
                error("TODO: allocatable character string");
            }
        } else {
        # So what we do is replace every value with this pair of empty strings.
            my @dims = map { ['',''] } @{$alloc_dim};
            $mdecl->{'Dim'}           = \@dims;
        }
    }
    $mdecl->{'FromParsedVarDecl'} = 1;
# carp Dumper $mdecl if $mdecl->{'Name'} =~/v/;
    return $mdecl;

} # END of parsedVarDecl_to_Decl

1;
