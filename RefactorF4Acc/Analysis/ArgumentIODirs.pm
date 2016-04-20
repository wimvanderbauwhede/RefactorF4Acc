package RefactorF4Acc::Analysis::ArgumentIODirs;
use v5.16;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw( get_maybe_args_globs type_via_implicits );
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines stateful_pass emit_f95_var_decl );
use RefactorF4Acc::Refactoring::Subroutines::Signatures
  qw( refactor_subroutine_signature );
use RefactorF4Acc::Refactoring::Subroutines::Calls
  qw( refactor_subroutine_call_args);

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

use Exporter;

@RefactorF4Acc::Analysis::ArgumentIODirs::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::ArgumentIODirs::EXPORT_OK = qw(
  &determine_argument_io_direction_rec
  &update_argument_io_direction_all_subs
  &parse_assignment
  &type_via_implicits
);

# -----------------------------------------------------------------------------
# We do a recusive descent for all called subroutines, and for the leaves we do the analysis
sub determine_argument_io_direction_rec {
    ( my $f, my $stref ) = @_;
    my $c;
    if ($V) {
        $c = ( defined $stref->{Counter} ) ? $stref->{Counter} : 0;
        print "\t" x $c, $f, "\n";
    }


    my $Sf = $stref->{'Subroutines'}{$f};
    
    if ( exists $Sf->{'CalledSubs'} and scalar keys %{$Sf->{'CalledSubs'}} >0 ) {
        for my $calledsub ( keys %{ $Sf->{'CalledSubs'} } ) {
            $stref->{Counter}++ if $V;
            $stref = determine_argument_io_direction_rec( $calledsub, $stref );            
            $stref->{Counter}-- if $V;
        }

        #   die "Resolved IO for called subs, now use it!\n" if $f =~ /advance/;
        print "\t" x $c, "--------\n" if $V;
        $stref = _determine_argument_io_direction_core( $stref, $f );
        # We come here for LES and all is well?
        
    } else {
#	say  "\t" x $c; print "LEAF $f";
# For a leaf, this should resolve all
# For a non-leaf, we should merge the declarations from the calls
# This is more tricky than it seems because a sub can be called multiple times with different arguments.
# So first we need to determine the argument of the call, then map them to the arguments of the sub
        $stref = _determine_argument_io_direction_core( $stref, $f );
    }
    
    return $stref;
}    # determine_argument_io_direction_rec()

# -----------------------------------------------------------------------------
sub _determine_argument_io_direction_core { 
    ( my $stref, my $f ) = @_;
    if ( exists $stref->{'Subroutines'}{$f} ) {
        my $Sf = $stref->{'Subroutines'}{$f};

            
        print "DETERMINE IO DIR FOR SUB $f\n" if $V;

        # Then for each of these, we go through the args.
        # If an arg has a non-'U' value, we overwrite it.
        # Up to here RefactoredArgs does not contain any parameter decls
        $stref = _analyse_src_for_iodirs( $stref, $f );
        
if (0) {        
        $Sf = $stref->{'Subroutines'}{$f};
        my $args = $Sf->{'RefactoredArgs'}{'Set'};       
        
        my $maybe_args = ( get_maybe_args_globs( $stref, $f ) )[0]; # returns a hash ref
        
        if ( scalar keys %{$args} > 0 ) {
            for my $arg ( keys %{$args} ) {
                
                next if $arg eq '';    # FIXME: WHY?!

                my $array_or_scalar  = 'Unknown';
                my $type  = 'Unknown';
                my $shape = [];
                my $attr  = '';
                my $decl; 
                
                my $indent='      ';
                if ( exists $maybe_args->{$arg} ) {
                    $decl= $maybe_args->{$arg};
                    $array_or_scalar  = $maybe_args->{$arg}{'ArrayOrScalar'};
                    $type  = $maybe_args->{$arg}{'Type'};
                    $shape = $maybe_args->{$arg}{'Dim'};
                    $attr  = $maybe_args->{$arg}{'Attr'};
                    $indent = $maybe_args->{$arg}{'Indent'};
                } else {
                    say "WARNING: _determine_argument_io_direction_core ". __LINE__ ." : No Decl for $arg in $f, using IMPLICIT ".Dumper($maybe_args->{$arg}) ;
                    # FIXME: Implicit rules can include a kind!
                    # Problem is that we can't tell if this is an array or not. 
                    ( $type, $array_or_scalar, $attr ) =
                      type_via_implicits( $stref, $f, $arg );
                       
                    if ( $type eq 'Unknown' ) {
                        print
                          "WARNING: No type/kind/shape info for $arg in $f\n"
                          if $W;
                    }
                }
                $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg}
                  {'ArrayOrScalar'} = $array_or_scalar;
                $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg}
                  {'Type'} = $type;
                $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg}
                  {'Dim'} = $shape;
                $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg}
                  {'Attr'} = $attr;
                  $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg}
                  {'Indent'} = $indent;                  
            }
        }
} # if (0)
        # FIXME: I don't think this should be done here
        #TODO   $stref = remap_args( $stref, $f );
        #TODO   $stref = reshape_args( $stref, $f );
        #    $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}=$args;
    }
    return $stref;
}    # _determine_argument_io_direction_core()

# -----------------------------------------------------------------------------
# To determine if a subroutine argument is I, O or IO:
# if it appears only on the LHS of an '=' => O
# if does not appear on the LHS of an '=' => I
# otherwise => IO
# So start by setting them all to 'I'
# so, look for '=' and split in LHS/RHS

# -----------------------------------------------------------------------------
# This function works on RHS variables, i.e. variables being read
# The rules are
# Read =>
#   Unknown => In
#   Out => InOut
# Write =>
#   Out

#Access mode of the pointer-type subroutine arguments
#
#* Describe every argument with a tuple (IODir,AccessState) where
#
#IODir = Unknown | In | Out | InOut | Unused
#
#AccessState = Unaccessed | Read | Written
#
#* The initial argument state is set to (Unknown,Unaccessed).
#
#* If an argument is read from and never written to, its IO direction is In:
#
#Unknown & Read =>  In
#

#* If an argument is written to before it is read from, its IO direction is Out.
#
#Unknown & Write =>  Out
#

#* If an argument is read from and later written to, its IO direction is InOut.
#
#In & Write =>  InOut
#

#* If an argument was not used in the subroutine body, set the status to Unused:
#
#Unknown =>  Unused

sub _set_iodir_read {
    ( my $mvar, my $args_ref ) = @_;
    #    if ( $args_ref->{$mvar}{'IODir'} eq 'Out' ) {
    #        print "FOUND InOut ARG $mvar\n" if $V;
    #        $args_ref->{$mvar}{'IODir'} = 'InOut';
    #    } els
#    say Dumper($args_ref->{$mvar});
    if (not exists $args_ref->{$mvar}{'IODir'}
    or not defined $args_ref->{$mvar}{'IODir'}) {
$args_ref->{$mvar}{'IODir'} = 'Unknown';
        }
    if ( $args_ref->{$mvar}{'IODir'} eq 'Unknown' ) {
        print "FOUND In ARG $mvar\n" if $V;
        $args_ref->{$mvar}{'IODir'} = 'In';
    }
    return $args_ref;
}

sub _set_iodir_write {
    ( my $mvar, my $args_ref ) = @_;    
    if (    exists $args_ref->{$mvar} 
    	and ref($args_ref->{$mvar}) eq 'HASH'  ) {
        if (exists $args_ref->{$mvar}{'IODir'}
        and defined $args_ref->{$mvar}{'IODir'} 
        ) {
        if ( $args_ref->{$mvar}{'IODir'} eq 'In' ) {
            print "FOUND InOut ARG $mvar\n" if $V;
            $args_ref->{$mvar}{'IODir'} = 'InOut';
        } elsif ( $args_ref->{$mvar}{'IODir'} eq 'Unknown' ) {
            print "FOUND In ARG $mvar\n" if $V;
            $args_ref->{$mvar}{'IODir'} = 'Out';
        }
    } else {
        $args_ref->{$mvar}{'IODir'} = 'Unknown';
    }
    	}
    return $args_ref;
}

sub _set_iodir_read_write {
    ( my $mvar, my $args_ref ) = @_;
    if (    exists $args_ref->{$mvar}
    	and ref($args_ref->{$mvar}) eq 'HASH'
    	) {
        if( exists $args_ref->{$mvar}{'IODir'} )
    {
        print "FOUND InOut ARG $mvar\n" if $V;
        $args_ref->{$mvar}{'IODir'} = 'InOut';
    }
    	}
    return $args_ref;
}

# -----------------------------------------------------------------------------
sub _find_vars_w_iodir {
    ( my $line, my $args_ref, my $subref ) = @_;
    # So we just split this in chunks, which means we ignore any arrays or function calls!
    my @chunks = split( /\W+/, $line );
    
    for my $mvar (@chunks) {
    	next if $mvar eq '';    
    	next if $mvar =~ /^\d+$/;
    	next if $mvar =~/^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;	
    	next if $mvar =~/\b(?:if|then|do|goto|integer|real|call|\d+)\b/;
        if ( exists $args_ref->{$mvar} and ref($args_ref->{$mvar}) eq 'HASH') {
        	
        	if( exists $args_ref->{$mvar}{'IODir'} ) {
            	$args_ref = $subref->( $mvar, $args_ref );
        	}
        } #else {
        # Just means that this is not an argument!          
        #}
    }
    return $args_ref;
}    # END of _find_vars_w_iodir()

# -----------------------------------------------------------------------------
sub _find_vars {
    ( my $line ) = @_;
    my $args_ref = {};
    
    my @chunks = split( /\W+/, $line );
    for my $mvar (@chunks) {
    	next if $mvar eq '';    
        next if $mvar =~ /^\d+$/;
        next if $mvar =~/^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
        next if $mvar =~/\b(?:if|then|do|goto|integer|real|call|\d+)\b/;
        $args_ref->{$mvar} = $mvar;
    }
    return $args_ref;
}    # END of _find_vars()

# -----------------------------------------------------------------------------
# The code needs to be reworked:
# The main issue is that the names of the args a sub is called with is not the same as the name in the signature.
# So we need to establish the mapping. This is what _get_iodirs_from_subcall() should do -- and nothing else.
# Obviously this is only the case for the original arguments, because the ex-globs and ex-incls have the same name everywhere.


sub _get_iodirs_from_subcall_OLD {
    ( my $stref, my $f, my $index, my $annlines ) = @_;

    my $Sf = $stref->{'Subroutines'}{$f};

    #	my $line = $annlines->[$index][0];
    my $info = $annlines->[$index][1];

    my $name  = $info->{'SubroutineCall'}{'Name'};
    my $Sname = $stref->{'Subroutines'}{$name};
    if (   not exists $info->{'SubroutineCall'}
        or not exists $info->{'SubroutineCall'}{'RefactoredArgs'} )
    {
#        die Dumper($info) if $name eq 'map_set';
        $stref = refactor_subroutine_call_args( $stref, $f, $index );
    }
    my $args              = $Sf->{'RefactoredArgs'}{'Set'};
    my $called_arg_iodirs = {};

    # Now get the RefactoredArgs
#    say Dumper($info);
    my $ref_call_args = $info->{'SubroutineCall'}{'RefactoredArgs'};
say uc('ref_call_args:').Dumper($ref_call_args);
    # Get the RefactoredArgs List for the signature
    my $ref_sig_args = $Sname->{'RefactoredArgs'}{'List'};
#    say Dumper($Sname->{'Vars'});
say $name.uc('ref_sig_args:').Dumper($ref_sig_args);
    my $ca           = scalar( @{$ref_call_args} );
    my $sa           = scalar( @{$ref_sig_args} );
    if ( $ca != $sa ) {
        print "WARNING ($f): NOT SAME LENGTH! ($ca<>$sa)\n" if $W;
        say Dumper $info;
#        print Dumper( $stref->{'Subroutines'}{$f}{'AnnLines'} ), "\n";
        print "\n$f" . '->' 
          . $name;
        print  ":\nCALL:"
          . Dumper($ref_call_args)
          . "\nSIG:"
          . Dumper($ref_sig_args) . "\n";
        croak;
    } else {
        my $i = 0;
        for my $call_arg ( @{$ref_call_args} ) {
            my $sig_arg = $ref_sig_args->[$i];

            # int is a FORTRAN primitive converting float to int
            # int2|short is a FORTRAN primitive converting float to int
            # int8|long is a FORTRAN primitive converting float to int
            # float is a FORTRAN primitive converting int to float
            # dfloat|dble is a FORTRAN primitive converting int to float
            # sngl is a FORTRAN primitive converting double to float
            $call_arg =~
              s/\b(?:int|int2|int8|short|long|sngl|dfloat|dble|float)\(//
              && $call_arg =~ s/\)$//;    # FIXME: was (^|\W), OK?

            # Clean up call args for comparison
            $call_arg =~ s/(\w+)\(.*?\)/$1/g;
            $i++;
            if ( exists $args->{$call_arg} ) {

                # This means that $call_arg is an argument of the caller $f
                # look up the IO direction for the corresponding $sig_arg
                $called_arg_iodirs->{$call_arg} =
                  $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
            } else {
                if ( $call_arg =~ /\W/ ) {
                    print
"INFO: ARG $call_arg in call to $name in $f is an expression\n"
                      if $V;
                    my @maybe_args = split( /\W+/, $call_arg );
                    for my $maybe_arg (@maybe_args) {
                    	next if $maybe_arg eq '';
                    	next if $maybe_arg =~/^\d+$/;
						next if $maybe_arg =~/^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
                    	next if $maybe_arg =~/\b(?:if|then|do|goto|integer|real|call|\d+)\b/;
                        if ( exists $args->{$maybe_arg}
                            and not exists $called_arg_iodirs->{$maybe_arg} )
                        {
                            print
"INFO: Setting IO dir for $maybe_arg in call to $name in $f to In\n"
                              if $V;
                            $called_arg_iodirs->{$maybe_arg} = 'In';
                            if (    scalar keys %{ $Sname->{'Callers'} } == 1
                                and $Sname->{'Callers'}{$f} == 1
                                and $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}
                                {'IODir'} ne 'In' )
                            {
                                print
"INFO: $name in $f is called only once; $sig_arg is an expression, setting IODir to 'In'\n"
                                  if $I;
                                $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}
                                  {'IODir'} = 'In';
                            }
                        }
                    }
                } elsif ( $call_arg =~ /^\s*[\d\.]+\s*$/ ) {
                    if (    scalar keys %{ $Sname->{'Callers'} } == 1
                        and $Sname->{'Callers'}{$f} == 1
                        and $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'}
                        ne 'In' )
                    {
                        print
"INFO: $name in $f is called only once; $sig_arg is a numeric constant, setting IODir to 'In'\n"
                          if $I;
                        $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} =
                          'In';
                    }
                } else {

                   # This means the call argument must be a local variable of $f
                   #					print "LOCAL $call_arg for call to $name in $f\n";
                    if ( exists $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg} ) {
                        $called_arg_iodirs->{$call_arg} =
                          $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};

                 #		      			if ( $called_arg_iodirs->{$call_arg} eq 'InOut' ) {
                 #				    		$called_arg_iodirs->{$call_arg} = 'InMaybeOut';
                 #					   }
                    } else {
                        say
"WARNING: Could not determine IODir for $call_arg in $name because there is no RefactoredArgs{".$sig_arg.'} in  parse_assignment() -> _analyse_src_for_iodirs() -> _get_iodirs_from_subcall() '. __LINE__;
                    }
                }
            }
        }
    }
    return ( $called_arg_iodirs, $stref );
}    # END of _get_iodirs_from_subcall_OLD()

# -----------------------------------------------------------------------------
# Purely for clarity, maybe this routine should take the arguments as arguments?
# What we want in this routine is determine IO dirs for leaves and look them up for non-leaves
sub _analyse_src_for_iodirs {
    ( my $stref, my $f ) = @_;

#    local $W=1;local $V=1;

    print "_analyse_src_for_iodirs() $f\n" if $V;
    my $Sf = $stref->{'Subroutines'}{$f};
    if ( not exists $Sf->{'IODirInfo'} or $Sf->{'IODirInfo'} == 0 ) {
        
        if ( not exists $Sf->{'HasRefactoredArgs'}
            or $Sf->{'HasRefactoredArgs'} == 0 )
        {
              say "SUB $f DOES NOT HAVE RefactoredArgs";
            croak 'BOOM! ' . __LINE__ . ' '.$f . ' : '. Dumper($Sf);
#            $stref = refactor_subroutine_signature( $stref, $f );
        }
        my $args = $Sf->{'RefactoredArgs'}{'Set'};

        my $annlines = get_annotated_sourcelines( $stref, $f );
        
        for my $index ( 0 .. scalar( @{$annlines} ) - 1 ) {
            my $line = $annlines->[$index][0];
            my $info = $annlines->[$index][1];
            if ( $line =~ /^\s*\!/ ) {
                next;
            }

            # Skip format statements
            if (   $line =~ /^\s+format/
                or $line =~ /^\d+\s+format/ )
            {
                next;
            }

            # Skip the signature
            if ( exists $info->{'Signature'} ) {
                next;
            }
			# Skip any 'use' or 'include' lines
			if (exists $info->{'Use'} or exists $info->{'Include'} ) { 
				next;
			}
            # Skip the declarations
            if ( exists $info->{'VarDecl'} ) { next; }

            # Write & File open statements
            if (   $line =~ /^\s+(?:write|print|open)\s*\(\s*(.+)$/
                or $line =~ /^\d+\s+(?:write|print|open)\s*\(\s*(.+)$/
                or $line =~ /^\s+print.+?,(.+)$/
                or $line =~ /^\d+\s+print.+?,(.+)$/ )
            {
                my $str = $1;
                die $line unless defined $str;
                $args = _find_vars_w_iodir( $str, $args, \&_set_iodir_read ); 
                next;
            }

            if (   $line =~ /^\s+(?:read)\s*\(\s*(.+)$/
                or $line =~ /^\d+\s+(?:read)\s*\(\s*(.+)$/ )
            {
                my $read_str = $1; 
                (my $fh,my @rest) = split(/,/,$read_str);                 
                $args = _find_vars_w_iodir( $fh, $args, \&_set_iodir_read );
                for my $str (@rest) {
                $args = _find_vars_w_iodir( $str, $args, \&_set_iodir_read_write );
                }
                next;
            }
# Subroutine call
            if (   exists $info->{'SubroutineCall'}
                && exists $info->{'SubroutineCall'}{'Name'} )
            {
                my $name = $info->{'SubroutineCall'}{'Name'};
                # So we get the IODir for every arg in the call to the subroutine
                # We need both the original args from the call and the ex-glob args
                # It might be convenient to have both in $info; otoh we can get ExGlobArgs from the main table
                
                my $iodirs_from_call = _get_iodirs_from_subcall( $stref, $f, $info) ;
#                croak Dumper($iodirs_from_call) if $name =~/random/;
                for my $var ( keys %{$iodirs_from_call} ) {

# Damn Perl! exists $args->{$var}{'IODir'} creates the entry for $var if it did not exist!
#say "VAR: $var;".Dumper($args);
                    if ( exists $args->{$var}
                    and ref( $args->{$var} ) eq 'HASH'
                    ) {
                        if ( exists $args->{$var}{'IODir'} ) {
                            if ( $iodirs_from_call->{$var} eq 'In' ) {
                            	
                                if ( not defined $args->{$var}{'IODir'} or $args->{$var}{'IODir'} eq 'Unknown' ) {
                                    $args->{$var}{'IODir'} = 'In';
                                } elsif ( $args->{$var}{'IODir'} eq 'Out' ) {
       # if the parent arg is Out and the child arg is In, parent arg stays Out!
                                    $args->{$var}{'IODir'} = 'Out';
                                } # if it's already In or InOut, it stays like it is.
                            } elsif ( $iodirs_from_call->{$var} eq 'InOut' ) {
                                if ( $args->{$var}{'IODir'} eq 'Unknown' ) {
                                    $args->{$var}{'IODir'} = 'InOut';
                                } elsif ( $args->{$var}{'IODir'} eq 'Out' ) {
                                    $args->{$var}{'IODir'} = 'Out';
                                } elsif ( $args->{$var}{'IODir'} eq 'In' ) {
                                    $args->{$var}{'IODir'} = 'InOut';
                                } # if it is In, it stays In
                            } elsif ( $iodirs_from_call->{$var} eq 'Out' ) {
                                if ( $args->{$var}{'IODir'} eq 'Unknown' ) {
                                    $args->{$var}{'IODir'} = 'Out';
                                } elsif ( $args->{$var}{'IODir'} eq 'In' ) {
                                    $args->{$var}{'IODir'} = 'InOut';
                                } # if it's already InOut or Out, stays like it is.
                            } else {
                                print
"WARNING: IO direction for $var in call to $name in $f is Unknown\n"
                                  if $V;
                            }
                        } else {
                            print "WARNING: $f: NO IODir info for $var\n" if $W;
                        }
                    } else {
                        print "INFO: $f: $var is not an argument, ignoring IODir "
                          . $iodirs_from_call->{$var} . "\n"
                          if $I;
                    }

     #                    else {
     #                               print "$var is LOCAL".$iodirs->{$var}."\n";
     #                    }

                    # So at this point, $args has correct IODir information
                }
                if ( $line =~ /^\s*if\s*\((.+)\)\s+call\s+/ ) {
                    my $cond = $1;
                    $cond =~ s/[\(\)]+//g;
                    $cond =~ s/\.(eq|ne|gt|ge|lt|le|and|or|not|eqv|neqv)\./ /;
                    die $line unless defined $cond;
                    $args =
                      _find_vars_w_iodir( $cond, $args, \&_set_iodir_read );
                }                
                next;
            }    # SubroutineCall

# Encounter Assignment
# WV20150304 TODO: factor this out and export it so we can use it as a parser for assignments
            if (    $line =~ /[\w\s\)]=[\w\s\(\+\-\.]/
                and $line !~ /^\s*do\s+.+\s*=/
                and $line !~ /\bparameter\b/ )
            {

                # FIXME: if (...) open|write is not covered
                my $tline = $line;
                $tline =~ s/^\s*\d+//;         # Labels
                $tline =~ s/^\s+//;
                $tline =~ s/\s+$//;
                $tline =~ s/[<=>][<=>]/<>/g;

                # FIXME: This is still weak!
                my $var = '';
                my $rhs = '';

                # First check if this is a single-line if statement
                if ( $tline =~ /^if\b/ ) {

# split on
# space or closing paren
# word
# 0 or 1 occurences of parentheses without '=' inside them
# the '=' sign
#*so in other words, if it's an array assignment
# FIXME: If the LHS is an array assignment we are not checking the index for its IO dir
                    if ( $tline !~ /(open|write|read|print|close)\s*\(/ ) {
                        ( my $cond, $var, my $sep, $rhs ) =
                          _conditional_assignment_fsm($tline);
                        $args =
                          _find_vars_w_iodir( $cond, $args, \&_set_iodir_read );
                        if ( $sep ne '' ) {
                            die $line unless defined $sep;
                            $args = _find_vars_w_iodir( $sep, $args,
                                \&_set_iodir_read );
                        }
                    } elsif ( $tline =~ /read\s*\(/ ) {
                        print
                          "WARNING: IGNORING conditional read call <$tline>\n"
                          if $W;
                        next;
                    } elsif ( $tline =~ /print.+?,/ ) {
                        print
                          "WARNING: IGNORING conditional print call <$tline>\n"
                          if $W;
                        next;
                    } else {
                        ( my $cond, my $call, $rhs ) =
                          split( /(open|write)/, $tline );

                        #                      print $tline,"\n";
                        #                      print "$cond ? $call $expr\n";
                        die $line unless defined $cond;
                        $args =
                          _find_vars_w_iodir( $cond, $args, \&_set_iodir_read );
                    }
                } else {
                    if ( $tline =~ /(open|write|read|print|close)\s*\(/ ) {
                        my $call = $1;
                        print
"WARNING: IGNORING conditional $call <$tline> (_analyse_src_for_iodirs)\n"
                          if $W;

                        #            	 		warn "IGNORING $call call <$tline>\n";
                        next;
                    } else {
                          
                        ( $var, $rhs ) = split( /\s*=\s*/, $tline );
                        if ( $var =~ /\(/ ) {

                            # Must be an array assignment
                            $var =~ s/\s*\((.+)\)$//;
                            my $str = $1;
                            if ( not defined $str ) {
                                print
"WARNING: IGNORING <$tline>, CAN'T HANDLE IT (_analyse_src_for_iodirs)\n"
                                  if $W;
                            } else {
                                $args = _find_vars_w_iodir( $str, $args,
                                    \&_set_iodir_read );
                            }
                        }
                    }
                }

                # First check the RHS for In
                die "_analyse_src_for_iodirs(): RHS not defined inf $f: $line\n"
                  unless defined $rhs;
                # So anything on the RHS is "In", this is OK
                $args = _find_vars_w_iodir( $rhs, $args, \&_set_iodir_read );
                if (exists $args->{$var}) {
                $args = _set_iodir_write( $var, $args );
                }
            
            } else {    # not an assignment, do as before                        
#                say "NON-ASSIGNMENT LINE: $line in $f" if $V;
                
                _find_vars_w_iodir( $line, $args, \&_set_iodir_read );
            }
        }
        for my $arg ( keys %{$args} ) {

            if (
                exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}
                {$arg} )
            {
                $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg} =
                  $args->{$arg};
            }
        }

        # Here for some reason corr has been added as an argument!
        $Sf->{'IODirInfo'} = 1;
    }    # if IODirInfo had not been set to 1
    
     # So, at this point, $stref->{'Subroutines'}{$f}{'RefactoredArgs'} has full IODir info
#     die if scalar keys %{$Sf} ==0; 
#die Dumper($stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}) if $f eq 'bondv1';
    return $stref;
}    # END of _analyse_src_for_iodirs()

# -----------------------------------------------------------------------------

#stronger:
#- we replaced <=> by <>
#- so split on \s*=\s* => RHS
#- remove if\s*
#( ... )\s*...
#
#This we should parse with an FSM, counting the parens,
#so we get
#
#COND=(...)
#
#\s*LHS

sub _conditional_assignment_fsm {
    ( my $line ) = @_;
    my (
        $do_nothing,    # 0
        $read_cond,     # 1
        $store_cond,    # 2
        $read_lhs,      # 3
        $store_lhs,     # 4
        $read_sep,
        $store_sep,
        $read_rhs,      # 5
        $store_rhs,     # 6
    ) = 0 .. 8;

    my $cond = '';
    my $lhs  = '';
    my $sep  = '';
    my $rhs  = '';

    my @cs         = split( '', $line );
    my $ncs        = scalar @cs;
    my $cct        = 0;
    my $st         = $do_nothing;
    my $nest_count = 0;
    for my $c (@cs) {
        next if $c eq ' ';
        $cct++;

#### The transitions are:

        if ( $st == $do_nothing ) {
            if ( $c eq '(' ) {
                $st = $read_cond;
            }
        } elsif ( $st == $read_cond ) {
            if ( $c eq '(' ) {
                $nest_count++;
            } elsif ( $c eq ')' ) {
                if ( $nest_count == 0 ) {

                    # store condition, or enter state
                    $st = $store_cond;
                } else {
                    $nest_count--;
                }
            }
        } elsif ( $st == $store_cond ) {
            $st = $read_lhs;
        } elsif ( $st == $read_lhs ) {
            if ( $c eq '(' ) {
                $st = $read_sep;
            } elsif ( $c eq '=' ) {
                $st = $store_lhs;
            }
        } elsif ( $st == $read_sep ) {
            if ( $c eq '=' ) {
                $st = $store_sep;
            }
        } elsif ( $st == $store_sep ) {
            $st = $read_rhs;
        } elsif ( $st == $store_lhs ) {
            $st = $read_rhs;
        } elsif ( $st == $read_rhs ) {
            if ( $cct == $ncs ) {
                $st = $store_rhs;
            }
        }

##### The actions are:
        if    ( $st == $read_cond ) { $cond .= $c }
        elsif ( $st == $read_lhs )  { $lhs  .= $c }
        elsif ( $st == $read_sep )  { $sep  .= $c }
        elsif ( $st == $read_rhs ) {
            $rhs .= $c;
        }
    }

    #    print "if(| $cond  |) [| $lhs |] = [| $rhs |]\n";
    return ( $cond, $lhs, $sep, $rhs );
}    # END of _conditional_assignment_fsm

# ----------------------------------------------------------------------------------------------------
sub parse_assignment {
    ( my $line ) = @_;

    # FIXME: if (...) open|write is not covered
    my $tline = $line;
    $tline =~ s/^\s*\d+//;         # remove labels
    $tline =~ s/^\s+//;
    $tline =~ s/\s+$//;
    $tline =~ s/[<=>][<=>]/<>/g;

    # FIXME: This is still weak!
    my $var = '';
    my $rhs = '';

    # First check if this is a single-line if statement
    my $args     = {};
    my $array_or_scalar     = 'Scalar';
    my $idx_expr = '';
    if ( $tline =~ /^if\b/ ) {

# split on:
# space or closing paren
# word
# 0 or 1 occurences of parentheses without '=' inside them
# the '=' sign
# FIXME: If the LHS is an array assignment we are not checking the index for its IO dir
        if ( $tline !~ /(open|write|read|print|close)\s*\(/ ) {
            ( my $cond, $var, my $sep, $rhs ) =
              _conditional_assignment_fsm($tline);
            $args = _find_vars($cond);
            if ( $sep ne '' ) {
                die $line unless defined $sep;
                my $args_sep = _find_vars($sep);
                $args = { %{$args}, %{$args_sep} };
            }
        } elsif ( $tline =~ /read\s*\(/ ) {
            print "WARNING: IGNORING conditional read call <$tline>\n" if $W;
            next;
        } elsif ( $tline =~ /print.+?,/ ) {
            print "WARNING: IGNORING conditional print call <$tline>\n" if $W;
            next;
        } else {
            ( my $cond, my $call, $rhs ) =
              split( /(open|write)/, $tline );
            die $line unless defined $cond;
            my $cond_args = _find_vars($cond);
            $args = { %{$args}, %{$cond_args} };
        }
    } else {
        if ( $tline =~ /(open|write|read|print|close)\s*\(/ ) {
            my $call = $1;
            print
"WARNING: IGNORING conditional $call <$tline> (_analyse_src_for_iodirs)\n"
              if $W;

            #            next;
            return [ {}, [], $call ];
        } elsif ( $tline !~ /::/ and $tline) {    # proper assignments ( so ignore <> )
#        say '<'.$tline.'>';
            ( $var, $rhs ) = split( /\s*=\s*/, $tline );
            
            if ( $var =~ /\(/ ) {

                # Must be an array assignment
                $var =~ s/\s*\((.+)\)$//;
                my $str = $1;
                die $line if not defined $str;
                $idx_expr =
                  [ split( /\s*\,\s*/, $str ) ]
                  ;    # FIXME: WEAK: assumes no nested arrays used as index
                $array_or_scalar = 'Array';
                if ( not defined $str ) {
                    print
"WARNING: IGNORING <$tline>, CAN'T HANDLE IT (_analyse_src_for_iodirs)\n"
                      if $W;
                } else {

                    #                    $args=_find_vars( $str);
                }
            }
            my $rhs_args = _find_vars($rhs);
            $args = { %{$args}, %{$rhs_args} };
        }
    }
    return [
        { 'VarName' => $var, 'ArrayOrScalar' => $array_or_scalar, 'IndexExpr' => $idx_expr },
        [ keys %{$args} ], $rhs
    ];
} # END of parse_assignment()

# ----------------------------------------------------------------------------------------------------
                # So we get the IODir for every arg in the call to the subroutine
                # We need both the original args from the call and the ex-glob args
                # It might be convenient to have both in $info; otoh we can get ExGlobArgs from the main table
#                my $iodirs_from_call = _get_iodirs_from_subcall( $stref, $f, $info );

# So what we do is: 
# 1. get all vars from the ArgMap table. 
# Note that some args are expressions, in which case they are used read-only per definition, so their IODir will always be In
# For the non-expression args, we need to use the table and then look up the IODir from the OrigArgs but via get_var_record_from_set($Sf,'OrigArgs')

sub _get_iodirs_from_subcall {
    ( my $stref, my $f, my $info) = @_;
	my $called_arg_iodirs={};
	my $name  = $info->{'SubroutineCall'}{'Name'};
	if (not exists $stref->{'ExternalSubroutines'}{$name}) {
    my $Sf = $stref->{'Subroutines'}{$f};
	my $args = $Sf->{'RefactoredArgs'}{'Set'};
#	say Dumper($info);
    
    my $argmap = $info->{'SubroutineCall'}{'ArgMap'};
    my $Sname = $stref->{'Subroutines'}{$name};
#    for my $expr (keys %{$argmap}) {
#    	if ($expr=~/[a-z_]\w*/) {
#    		# It's a variable
#    		my $sig_arg = $argmap->{$expr};
#    		my $var_rec = get_var_record_from_set($Sname,'OrigArgs');
#    		my $iodir = $var_rec->{'IODir'}; 
#    		$called_arg_iodirs->{$expr}=$iodir;
#    	} else { # it's an expression, so I need to split this into chunks and remove any constants
#    		# Of course the only really good way is to do this in the parser and not just have Args as a list of strings,
#    		# but as a 'Type/Expr' pair, Type being 'Const' | 'Expr' | 'Var' | 'Par' and Expr being the parsed expression 
#    		# Or maybe we want the original expression and the parsed expression
#    		# But for now we reparse this line here.
#    		my @chunks = split( /\W+/, $expr );
#   			for my $mvar (@chunks) {
#   					 
#    		}
#		}	
#    }
    
        my $i = 0;
        for my $call_arg (keys %{$argmap}) {
            my $sig_arg = $argmap->{$call_arg};

            # int is a FORTRAN primitive converting float to int
            # int2|short is a FORTRAN primitive converting float to int
            # int8|long is a FORTRAN primitive converting float to int
            # float is a FORTRAN primitive converting int to float
            # dfloat|dble is a FORTRAN primitive converting int to float
            # sngl is a FORTRAN primitive converting double to float
            $call_arg =~
              s/\b(?:int|int2|int8|short|long|sngl|dfloat|dble|float)\(//
              && $call_arg =~ s/\)$//;    # FIXME: was (^|\W), OK?

            # Clean up call args for comparison
            $call_arg =~ s/(\w+)\(.*?\)/$1/g;
            $i++;
            if ( exists $args->{$call_arg} ) {

                # This means that $call_arg is an argument of the caller $f
                if (ref($args->{$call_arg}) eq 'HASH'
                and ref($Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}) eq 'HASH'
                ) { # this caller argument has a record 
                # look up the IO direction for the corresponding $sig_arg
                
                $called_arg_iodirs->{$call_arg} =
                  $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
                } else {
                	say "CALLER ARG <$call_arg> for call to $name OR SIG ARG <$sig_arg> for $name in $f HAS NO REC: ".Dumper($Sname->{'Args'}).'<>'.Dumper($Sname->{'RefactoredArgs'}{'Set'}{$sig_arg});
                	say Dumper($Sname->{'Args'});
                	die; 
                }
            } else {
                if ( $call_arg =~ /\W/ ) {
                    print
"INFO: ARG $call_arg in call to $name in $f is an expression\n"
                      if $V;
                    my @maybe_args = split( /\W+/, $call_arg );                    
                    for my $maybe_arg (@maybe_args) {
                    	next if $maybe_arg eq '';
                    	next if $maybe_arg =~/^\d+$/; # quicker than the next line
                    	next if $maybe_arg =~/^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
                        if ( exists $args->{$maybe_arg}
                            and not exists $called_arg_iodirs->{$maybe_arg} )
                        {
                            print
"INFO: Setting IO dir for $maybe_arg in call to $name in $f to In\n"
                              if $V;
                            $called_arg_iodirs->{$maybe_arg} = 'In';
                            if (    scalar keys %{ $Sname->{'Callers'} } == 1
                                and $Sname->{'Callers'}{$f} == 1
                                and $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}
                                {'IODir'} ne 'In' )
                            {
                                print
"INFO: $name in $f is called only once; $sig_arg is an expression, setting IODir to 'In'\n"
                                  if $I;
                                $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}
                                  {'IODir'} = 'In';
                            }
                        }
                    }
                } elsif ( $call_arg =~ /^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/ ) { # TODO: use this in Parser instead
                    if (    scalar keys %{ $Sname->{'Callers'} } == 1
                        and $Sname->{'Callers'}{$f} == 1
                        and $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'}
                        ne 'In' )
                    {
                        print
"INFO: $name in $f is called only once; $sig_arg is a numeric constant, setting IODir to 'In'\n"
                          if $I;
                        $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} =
                          'In';
                    }
                } else {
                    if ( exists $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg} ) {
                        $called_arg_iodirs->{$call_arg} =
                          $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
                    } else {
                        say
"WARNING: Could not determine IODir for $call_arg in $name because there is no RefactoredArgs{".$sig_arg.'} in  parse_assignment() -> _analyse_src_for_iodirs() -> _get_iodirs_from_subcall() '. __LINE__;
                    }
                }
            }
        }    
} else { 
#	croak "HERE".Dumper($info);
	for my $arg (@{ $info->{'SubroutineCall'}{'Args'}{'List'} }) {
		$called_arg_iodirs->{$arg}='InOut';
	}
}
	return $called_arg_iodirs;
} # END of _get_iodirs_from_subcall()

sub update_argument_io_direction_all_subs {
	(my $stref)=@_;
	  for my $f ( keys %{ $stref->{'Subroutines'} } ) {
	  	next if $f eq '';
	  	next if exists $stref->{'ExternalSubroutines'}{$f};
	  	next if $stref->{'Subroutines'}{$f}{'Program'}==1;
	  	say "UPDATE IODIR IN $f" if $V;
	  	$stref = _update_argument_io_direction($stref, $f); 
	  }
	return $stref;
}

sub _update_argument_io_direction {
	(my $stref, my $f)=@_;
	
	my $__update_decl = sub { (my $annline, my $state)=@_;		
		( my $line,    my $info )  = @{$annline};
		(my $stref, my $f, my $rest) = @{$state};
		if (exists $info->{'VarDecl'}) {
			my $varname = $info->{'VarDecl'}{'Name'};
			if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$varname}) {
							say $line if $f eq 'vertical';
#			say "INFO:".Dumper($info->{'VarDecl'});
				
#			say $varname;
#			say Dumper($stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$varname});
			$info->{'VarDecl'}{'IODir'}=$stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$varname}{'IODir'};
			my $rline = emit_f95_var_decl($info->{'VarDecl'});
			$annline =[ $rline, $info];
			} else {
#				say $line;
			}
		}
		return ( $annline, $state );	
	};
	my $state = [ $stref, $f, {} ];
	 ($stref, $state) = stateful_pass($stref,$f,  $__update_decl,  $state,'_update_argument_io_direction() '. __LINE__);
	

	
	return $stref;
}
1;
