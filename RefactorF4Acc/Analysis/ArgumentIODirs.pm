package RefactorF4Acc::Analysis::ArgumentIODirs;


use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines );
use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( refactor_subroutine_signature );
use RefactorF4Acc::Refactoring::Subroutines::Calls qw( refactor_subroutine_call_args);
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
);

# -----------------------------------------------------------------------------
# We do a recusive descent for all called subroutines, and for the leaves we do the analysis
sub determine_argument_io_direction_rec {
    ( my $f, my $stref ) = @_;
    my $c;
    if ($V) {
    $c = (defined $stref->{Counter}) ? $stref->{Counter} : 0;
    print "\t" x $c, $f,"\n";
    }
    
    my $Sf = $stref->{'Subroutines'}{$f};
    if ( exists $Sf->{'CalledSubs'} ) {
        for my $calledsub ( keys %{ $Sf->{'CalledSubs'} } ) {
            $stref->{Counter}++ if $V;
            $stref = determine_argument_io_direction_rec( $calledsub, $stref );
            $stref->{Counter}-- if $V;
        }
#   die "Resolved IO for called subs, now use it!\n" if $f =~ /advance/;
        print "\t" x $c, "--------\n" if $V;
        $stref = determine_argument_io_direction_core( $stref, $f );
    } else {
#    	print "\t" x $c; print "LEAF\n";
# For a leaf, this should resolve all
# For a non-leaf, we should merge the declarations from the calls
# This is more tricky than it seems because a sub can be called multiple times with different arguments.
# So first we need to determine the argument of the call, then map them to the arguments of the sub
#        $stref = refactor_subroutine_signature( $stref, $f );
        $stref = determine_argument_io_direction_core( $stref, $f );
    }
    return $stref;
}    # determine_argument_io_direction_rec()

# -----------------------------------------------------------------------------
sub determine_argument_io_direction_core {
    ( my $stref, my $f ) = @_;
    my $Sf      = $stref->{'Subroutines'}{$f};

    #   local $V=1 if $f=~/advance/;
    print "DETERMINE IO DIR FOR SUB $f\n" if $V;

    # Then for each of these, we go through the args.
    # If an arg has a non-'U' value, we overwrite it.
    $stref = analyse_src_for_iodirs($stref,$f);
    $Sf=$stref->{'Subroutines'}{$f};
    my $args = $Sf->{'RefactoredArgs'}{'Set'};

    my $maybe_args = ( get_maybe_args_globs( $stref, $f ) )[0];
    for my $arg ( keys %{ $args} ) {
        my $kind  = 'Unknown';
        my $type  = 'Unknown';
        my $shape = [];
        if ( exists $maybe_args->{$arg}{'Type'} ) {
            $kind  = $maybe_args->{$arg}{'Kind'};
            $type  = $maybe_args->{$arg}{'Type'};
            $shape = $maybe_args->{$arg}{'Shape'};
        } else {
            print "WARNING: No kind/type info for $arg in $f\n" if $W;
        }

        $args->{$arg}{'Kind'}  = $kind;
        $args->{$arg}{'Type'}  = $type;
        $args->{$arg}{'Shape'} = $shape;
    }
    
     # FIXME: I don't think this should be done here
#TODO   $stref = remap_args( $stref, $f );   
#TODO   $stref = reshape_args( $stref, $f );    
    $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}=$args;
    return $stref;
}    # determine_argument_io_direction_core()

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
#¥ Describe every argument with a tuple (IODir,AccessState) where
#
#IODir = Unknown | In | Out | InOut | Unused
#
#AccessState = Unaccessed | Read | Written 
#
#¥ The initial argument state is set to (Unknown,Unaccessed).
#
#¥ If an argument is read from and never written to, its IO direction is In: 
#
#Unknown & Read =>  In
#

#¥ If an argument is written to before it is read from, its IO direction is Out. 
#
#Unknown & Write =>  Out
#

#¥ If an argument is read from and later written to, its IO direction is InOut. 
#
#In & Write =>  InOut
#

#¥ If an argument was not used in the subroutine body, set the status to Unused: 
#
#Unknown =>  Unused

sub set_iodir_read {
    ( my $mvar, my $args_ref ) = @_;
    
#    if ( $args_ref->{$mvar}{'IODir'} eq 'Out' ) {    	
#        print "FOUND InOut ARG $mvar\n" if $V;
#        $args_ref->{$mvar}{'IODir'} = 'InOut';
#    } els
    if ( $args_ref->{$mvar}{'IODir'} eq 'Unknown' ) {
        print "FOUND In ARG $mvar\n" if $V;
        $args_ref->{$mvar}{'IODir'} = 'In';
    }
    return $args_ref;
}

sub set_iodir_write {
    ( my $mvar, my $args_ref ) = @_;
    if (exists $args_ref->{$mvar} and
    exists $args_ref->{$mvar}{'IODir'}
    ) {
    if ( $args_ref->{$mvar}{'IODir'} eq 'In' ) {      
        print "FOUND InOut ARG $mvar\n" if $V;
        $args_ref->{$mvar}{'IODir'} = 'InOut';
    } elsif ( $args_ref->{$mvar}{'IODir'} eq 'Unknown' ) {
        print "FOUND In ARG $mvar\n" if $V;
        $args_ref->{$mvar}{'IODir'} = 'Out';
    }
    } else {
    	$args_ref->{$mvar}{'IODir'}= 'Unknown';
    }
    return $args_ref;
}
# -----------------------------------------------------------------------------
sub find_vars {
    ( my $line, my $args_ref, my $subref ) = @_;
#    warn "find_vars()\n".Dumper($args_ref);  
#    my %args = %{$args_ref};
    my @chunks = split( /\W+/, $line );
    for my $mvar (@chunks) {    
#    	warn "MVAR:$mvar\n";	
        if ( exists $args_ref->{$mvar} && exists $args_ref->{$mvar}{'IODir'} ) {
#        	warn "MVAR OK!:$mvar\n";      	
            $args_ref = $subref->( $mvar, $args_ref );
        }
    }
#    print "find_vars() RETURN:\n".Dumper($args_ref);
    return $args_ref;
}    # END of find_vars()
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# The code needs to be reworked:
# The main issue is that the names of the args a sub is called with is not the same as the name in the signature.
# So we need to establish the mapping. This is what get_iodirs_from_subcall() should do -- and nothing else.

sub get_iodirs_from_subcall {
	( my $stref, my $f, my $index, my $annlines ) = @_;
	
	my $Sf    = $stref->{'Subroutines'}{$f};

#	my $line = $annlines->[$index][0];
	my $tags = $annlines->[$index][1];

	my $name  = $tags->{'SubroutineCall'}{'Name'};			 	
	my $Sname = $stref->{'Subroutines'}{$name};
    if (not exists $tags->{'SubroutineCall'} or not exists $tags->{'SubroutineCall'}{'RefactoredArgs'}) {
       $stref = refactor_subroutine_call_args( $stref, $f, $index );
    } 
	my $args = $Sf->{'RefactoredArgs'}{'Set'};
	my $called_arg_iodirs = {};

	# Now get the RefactoredArgs
	my $ref_call_args =
	  $tags->{'SubroutineCall'}{'RefactoredArgs'};
    # Get the RefactoredArgs List for the signature
	my $ref_sig_args = $Sname->{'RefactoredArgs'}{'List'};
##FIXME: experimental!
##    croak "FIXME: need to make sure all calls & sigs are refactored before doing IO analysis!!!";
#    if ( not defined $ref_sig_args or scalar( @{$ref_sig_args} ) == 0) {
#    	warn "NO RefactoredArgs for $name, using Args instead\n";    	
#        $ref_sig_args = $Sname->{'Args'};
#	    $Sname->{'RefactoredArgs'}={};
#	    $Sname->{'RefactoredArgs'}{'List'}=$Sname->{'Args'};
#    }
	my $ca = scalar( @{$ref_call_args} );
	my $sa = scalar( @{$ref_sig_args} );
	if ( $ca != $sa ) {
        print "WARNING ($f): NOT SAME LENGTH! ($ca<>$sa)\n" if $W;
        print Dumper( $stref->{'Subroutines'}{$name}{'AnnLines'}),"\n";
		print "\n$f".'->'.$name.":\nCALL:".Dumper( $ref_call_args )."\nSIG:". Dumper( $ref_sig_args )."\n";
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
			  && $call_arg =~ s/\)$//; # FIXME: was (^|\W), OK? 

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
						if ( exists $args->{$maybe_arg}
							and not exists $called_arg_iodirs->{$maybe_arg} )
						{
							print
"INFO: Setting IO dir for $maybe_arg in call to $name in $f to In\n"
							  if $V;
							$called_arg_iodirs->{$maybe_arg} = 'In';
							if (    scalar keys %{ $Sname->{'Callers'} } == 1
								and $Sname->{'Callers'}{$f} == 1
								and
								$Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} ne
								'In' )
							{
								print
"INFO: $name in $f is called only once; $sig_arg is an expression, setting IODir to 'In'\n"
								  if $I;
								$Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} =
								  'In';
							}
						}
					}
				} elsif ( $call_arg =~ /^\s*[\d\.]+\s*$/ ) {
					if (    scalar keys %{ $Sname->{'Callers'} } == 1
						and $Sname->{'Callers'}{$f} == 1
						and $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} ne
						'In' )
					{
						print
"INFO: $name in $f is called only once; $sig_arg is a numeric constant, setting IODir to 'In'\n"
						  if $I;
						$Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} = 'In';
					}
				} else {

				   # This means the call argument must be a local variable of $f
				   #					print "LOCAL $call_arg for call to $name in $f\n";
                    if (exists $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}) {
    					$called_arg_iodirs->{$call_arg} =
	   				  $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
#		      			if ( $called_arg_iodirs->{$call_arg} eq 'InOut' ) {
#				    		$called_arg_iodirs->{$call_arg} = 'InMaybeOut';
#					   }
                    } else {
                        print "WARNING:Could not determine IODir for $call_arg in $name because there is no RefactoredArgs{$sig_arg}\n";
                    }
				}
			}
		}
	}
	return ( $called_arg_iodirs, $stref );
}    # END of get_iodirs_from_subcall()

# -----------------------------------------------------------------------------
# Purely for clarity, maybe this routine should take the arguments as arguments?
# What we want in this routine is determine IO dirs for leaves and look them up for non-leaves
sub analyse_src_for_iodirs {
    (my $stref,my $f)=@_;
#    local $V=1;
#    print "analyse_src_for_iodirs() $f\n";
    
    my $Sf=$stref->{'Subroutines'}{$f};
    
    if (not exists $Sf->{'IODirInfo'} or $Sf->{'IODirInfo'}==0) { 
    
        if (not exists $Sf->{'HasRefactoredArgs'} or $Sf->{'HasRefactoredArgs'}==0) {
        $stref = refactor_subroutine_signature( $stref, $f );
    }
    my $args            = $Sf->{'RefactoredArgs'}{'Set'} ;    
    
    my $annlines=get_annotated_sourcelines($stref,$f);
        for my $index ( 0 .. scalar( @{$annlines} ) - 1 ) {
            my $line = $annlines->[$index][0];
            my $tags = $annlines->[$index][1];
            if ( $line =~ /^\s*\!/ ) {
                next;
            }
            if ( $line =~ /^\s+format/
            or $line =~ /^\d+\s+format/
            ) {
                next;
            }
            # Skip the signature            
            if ( exists $tags->{'Signature'} ) {
            	 next; }
            # Skip the declarations
            if ( exists $tags->{'VarDecl'} ) { next; }

            # Write & File open statements
            if ( $line =~ /^\s+(?:write|print|open)\s*\(\s*(.+)$/ or
                 $line =~ /^\d+\s+(?:write|print|open)\s*\(\s*(.+)$/ or
                 $line =~ /^\s+print.+?,(.+)$/ or 
                 $line =~ /^\d+\s+print.+?,(.+)$/
            ) {            	
                $args=find_vars( $1, $args, \&set_iodir_read );    
                next;            
            }
            
            if ( $line =~ /^\s+(?:read)\s*\(\s*(.+)$/ or
                 $line =~ /^\d+\s+(?:read)\s*\(\s*(.+)$/
            ) {             
                print "WARNING: IGNORING read call <$line>\n" if $W;    
                next;            
            }
            
            
            if ( exists $tags->{'SubroutineCall'} && exists $tags->{'SubroutineCall'}{'Name'}) {
                my $name  = $tags->{'SubroutineCall'}{'Name'};
                ( my $iodirs, $stref ) =
                  get_iodirs_from_subcall( $stref, $f, $index, $annlines );
                for my $var ( keys %{$iodirs} ) {
                	# Damn Perl! exists $args->{$var}{'IODir'} creates the entry for $var if it did not exist!
                    if ( exists $args->{$var} && exists $args->{$var}{'IODir'}) {
                        if ( $iodirs->{$var} eq 'In' ) {
                            if ( $args->{$var}{'IODir'} eq 'Unknown' ) {
                                $args->{$var}{'IODir'} = 'In';
                            } elsif ( $args->{$var}{'IODir'} eq 'Out' ) {
       # if the parent arg is Out and the child arg is In, parent arg stays Out!
                                $args->{$var}{'IODir'} = 'Out';
                            }
                        } elsif ( $iodirs->{$var} eq 'InOut' ) {
                            if ( $args->{$var}{'IODir'} eq 'Unknown' ) {
                                $args->{$var}{'IODir'} = 'InOut';
                            } elsif ( $args->{$var}{'IODir'} eq 'Out' ) {
                                $args->{$var}{'IODir'} = 'Out';
                            }
                        } elsif ( $iodirs->{$var} eq 'Out' ) {
                            if ( $args->{$var}{'IODir'} eq 'Unknown' ) {
                                $args->{$var}{'IODir'} = 'Out';
                            } elsif ( $args->{$var}{'IODir'} eq 'In' ) {
                                $args->{$var}{'IODir'} = 'InOut';
                            }
                        } else {
                            print
"WARNING: IO direction for $var in call to $name in $f is Unknown\n"
                              if $V;
                        }
                    } 
#                    else {
#                               print "$var is LOCAL".$iodirs->{$var}."\n";
#                    }
                }
                if ( $line =~ /^\s*if\s*\((.+)\)\s+call\s+/ ) {
                    my $cond = $1;
                    $cond =~ s/[\(\)]+//g;
                    $cond =~ s/\.(eq|ne|gt|ge|lt|le|and|or|not|eqv|neqv)\./ /;
                    $args=find_vars( $cond, $args, \&set_iodir_read );
                }
                next;
            } # SubroutineCall

            # Encounter Assignment
            if ($line=~/[\w\s\)]=[\w\s\(\+\-\.]/ and $line !~ /^\s*do\s+.+\s*=/ ) { # FIXME: if (...) open|write is not covered
            	my $tline=$line;
            	$tline=~s/^\s*\d+//; # Labels
            	$tline=~s/^\s+//;
            	$tline=~s/\s+$//;
            	$tline=~s/[<=>][<=>]/<>/g;
            	# FIXME: This is still weak! 
            	my $var='';my $rhs='';
            	# First check if this is a single-line if statement
            	 if ( $tline =~ /^if\b/ ) {
            	 	
            	 	# split on 
            	 	# space or closing paren
            	 	# word
                    # 0 or 1 occurences of parentheses without '=' inside them
                    # the '=' sign                    
                    #Êso in other words, if it's an array assignment
                    # FIXME: If the LHS is an array assignment we are not checking the index for its IO dir
                    if ($tline!~/(open|write|read|print)\s*\(/) {
                    	
                    	(my $cond, $var,my $sep,$rhs)=conditional_assignment_fsm($tline);                    	
#                    (my $cond,$var,my $sep,$rhs) =                    
#                       split( /(?:\)|\s+)(\w+)((?:\([^=]*\))?\s*=\s*)/, $tline ) ;
#                       $cond=~s/if\s*//;
#                       $cond=~s/\s+//g;
#                       $var=~s/\s+//g;
#                       $rhs=~s/\s+//g;
#                       $cond=~s/\)$//;
#                       $sep=~s/\s*=\s*//;
#                       if ($cond ne $cond_fsm) {
#                       	print "\nLINE:",$tline,"\n";
#                       print "COND:<$cond><$cond_fsm>\n" if $cond ne $cond_fsm;
#                       }
#                      print "VAR:<$var><$lhs_fsm>\n" if $var ne $lhs_fsm;
#                      if ($sep ne '') {
#                        print "SEP:<$sep><$sep_fsm>\n" if $sep ne $sep_fsm;
#                      }
#                        print "RHS:<$rhs><$rhs_fsm>\n" if $rhs ne $rhs_fsm;
##                    $sep=~s/\s*=\s*//;
##                    if ($sep ne '' and $cond!~/\)\s*$/) {                    
##                      print "LINE:",$tline,"\n";
##                      print "$cond ??? $var [[[$sep]]] $rhs\n";
##                    }                      
                      $args=find_vars( $cond, $args, \&set_iodir_read );
                      if ($sep ne '') {
#                      	print "SEP:<$sep>\n";
                        $args=find_vars( $sep, $args, \&set_iodir_read );
                      }     
                    } elsif ($tline=~/read\s*\(/) {
                        print "WARNING: IGNORING conditional read call <$tline>\n" if $W;    
                        next;
                    } elsif ($tline=~/print.+?,/) {
                        print "WARNING: IGNORING conditional print call <$tline>\n" if $W;    
                        next;
                    } else {
                    	(my $cond,my $call,$rhs) =                    
                       split( /(open|write)/, $tline ) ;
#                      print $tline,"\n";                      
#                      print "$cond ? $call $expr\n";
                      $args=find_vars( $cond, $args, \&set_iodir_read );
                    }                 
            	 } else {            	 	
            	   ($var, $rhs)=split(/\s*=\s*/,$tline);
            		if ($var=~/\(/) {
            		# Must be an array assignment
            		$var=~s/\s*\((.+)\)$//;
            		$args=find_vars( $1, $args, \&set_iodir_read );
            	   }
            	}            	

# First check the RHS for In
                $args=find_vars( $rhs, $args, \&set_iodir_read );
#                  if ( exists $args->{'fluxu'} &&
#                         exists $args->{'fluxu'}{'IODir'} && $f eq 'calcfluxes' ) {
#                         	if ($line=~/fluxu/) {
#                         	print "$line\n" ;
#                         	print "Checking RHS\n";
#                         	print 'fluxu: '.$args->{'fluxu'}{'IODir'}."\n";
#                         	print "Checking LHS\n";
#                         	}
#                         }
# Then check the LHS for Out/InOut                    
#	                if ( exists $args->{$var} &&
#	                	 exists $args->{$var}{'IODir'} ) {                	
#	                    if ( $args->{$var}{'IODir'} eq 'Unknown' ) {
#	                        print "ALINE: $line\n"     if $V;
#	                        print "ARG $var: 'Out'\n" if $V;
#	                        $args->{$var}{'IODir'} = 'Out';
#	                    } elsif ( $args->{$var}{'IODir'} eq 'In' ) {
#	                        print "ALINE: $line\n"       if $V;
#	                        print "ARG $var: 'InOut'\n" if $V;
#	                        $args->{$var}{'IODir'} = 'InOut';
#	                    }
#	                }      
	                $args=set_iodir_write($var,$args);
#	                 if ( exists $args->{'fluxu'} &&
#                         exists $args->{'fluxu'}{'IODir'} 
#                         && $f eq 'calcfluxes') {
#                         	if ($line=~/fluxu/) {
#                         	print "AFTER Checking LHS\n";
#                            print 'fluxu: '.$args->{'fluxu'}{'IODir'}."\n";
#                         	}
#                         }           
            } else {    # not an assignment, do as before
                print "NON-ASSIGNMENT LINE: $line\n" if $V;
                find_vars( $line, $args, \&set_iodir_read );                
            }
        }
        
        for my $arg (keys %{ $args } ) {
        	if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg}) {
                $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg} = $args->{$arg};                
        	} 
        }
        $Sf->{'IODirInfo'}=1;
    }
        return $stref;
} # END of analyse_src_for_iodirs()
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

sub conditional_assignment_fsm {
    (my $line)=@_;
    my (
        $do_nothing,     # 0
        $read_cond,       # 1
        $store_cond,      # 2
        $read_lhs,      # 3
        $store_lhs,       # 4
        $read_sep,
        $store_sep,
        $read_rhs,    # 5
        $store_rhs,     # 6
    ) = 0 .. 8;


my $cond='';
my $lhs='';
my $sep='';
my $rhs='';

    my @cs=split( '', $line );
    my $ncs=scalar @cs;
    my $cct=0;
    my $st=$do_nothing;
    my $nest_count=0;
    for my $c ( @cs ) {
    	next if $c eq ' ';
        $cct++;


#### The transitions are:

    if ( $st == $do_nothing ) {
            if ( $c eq '(' ) {
            $st=$read_cond;
            }
    } elsif ($st == $read_cond) {
        if ($c eq '(') {
            $nest_count++;
        } elsif ($c eq ')' ) {
            if ($nest_count==0) {
                # store condition, or enter state
                $st=$store_cond;    
            } else {
                $nest_count--;
            }   
        }
    } elsif ($st == $store_cond) {
        $st=$read_lhs;
    } elsif ($st == $read_lhs) {
    	if ($c eq '(') {
    		$st=$read_sep;
    	} elsif ($c eq '=') {
            $st= $store_lhs;
        }
    } elsif ($st == $read_sep) {
    	 if ($c eq '=') {
            $st= $store_sep;
        }   
    } elsif ($st == $store_sep) {
    	$st = $read_rhs;    
    } elsif ($st == $store_lhs) {
        $st = $read_rhs;
    } elsif ($st == $read_rhs) {
        if ($cct==$ncs) {
            $st=$store_rhs;
        }
    }

##### The actions are:
        if    ( $st == $read_cond ) { $cond .= $c }
        elsif ( $st == $read_lhs ) { $lhs .= $c }
        elsif ( $st == $read_sep ) { $sep .= $c }
        elsif ( $st == $read_rhs ) {
            $rhs .= $c;
        } 
}
#    print "if(| $cond  |) [| $lhs |] = [| $rhs |]\n";
    return ( $cond, $lhs,$sep,$rhs);
} # END of conditional_assignment_fsm 

