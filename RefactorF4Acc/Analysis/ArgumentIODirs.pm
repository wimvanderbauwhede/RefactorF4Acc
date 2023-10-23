package RefactorF4Acc::Analysis::ArgumentIODirs;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw( 
    pp_annlines 
    add_ann_to_info
    get_maybe_args_globs 
    type_via_implicits 
    in_nested_set 
    get_var_record_from_set 
    %F95_intrinsic_functions warning
    );
use RefactorF4Acc::Refactoring::Helpers qw( get_annotated_sourcelines stateful_pass_inplace emit_f95_var_decl get_f95_var_decl );

#use RefactorF4Acc::Refactoring::Subroutines::Signatures qw( refactor_subroutine_signature );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::ArgumentIODirs::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::ArgumentIODirs::EXPORT_OK = qw(
  &determine_argument_io_direction_rec
  &update_argument_io_direction_all_subs
  &type_via_implicits
  &conditional_assignment_fsm
);

# -----------------------------------------------------------------------------
# We do a recusive descent for all called subroutines, and for the leaves we do the analysis
sub determine_argument_io_direction_rec {
    (my $stref, my $f) = @_;

    my $c;
    if ($V) {
        $c = (defined $stref->{Counter}) ? $stref->{Counter} : 0;
        print "\t" x $c, $f, "\n";
    }

    push @{ $stref->{'CallStack'} }, $f;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} }; 

    my $Sf = $stref->{'Subroutines'}{$f};

    if (exists $Sf->{'CalledSubs'}{'List'} and scalar @{$Sf->{'CalledSubs'}{'List'}} > 0) {
        for my $called_sub_or_entry (@{$Sf->{'CalledSubs'}{'List'}}) {
            my $calledsub = $called_sub_or_entry;
            if (exists $stref->{'Entries'}{$called_sub_or_entry}) {
                $calledsub = $stref->{'Entries'}{$called_sub_or_entry};
            }
            next if exists $stref->{'ExternalSubroutines'}{$calledsub};    # Don't descend into external subs
            if (exists $subs{$calledsub}) {
                warning("CALL LOOP for $calledsub in $f. This does not conform to the ANSI X3.9-1978 standard, proceed at your peril!",1);
                warning('<'.join(', ', @{ $stref->{'CallStack'} }).'>',2);
				# say "WARNING: CALL LOOP for $calledsub in $f. This does not conform to the ANSI X3.9-1978 standard, proceed at your peril!" if $W;
				# say join(', ', @{ $stref->{'CallStack'} }) if $WW;
				next;
			}
            $stref->{Counter}++ if $V;
            $stref = determine_argument_io_direction_rec($stref, $calledsub);
            $stref->{Counter}-- if $V;
        }
    }
    print "\t" x $c, "--------\n" if $V;
    $stref = _determine_argument_io_direction_core($stref, $f);
    pop  @{ $stref->{'CallStack'} };
    return $stref;
}    # determine_argument_io_direction_rec()

# -----------------------------------------------------------------------------
sub _determine_argument_io_direction_core {
    (my $stref, my $f) = @_;
    if (exists $stref->{'Subroutines'}{$f}) {
        my $Sf = $stref->{'Subroutines'}{$f};

        print "DETERMINE IO DIR FOR SUB $f\n" if $V;

        # Then for each of these, we go through the args.
        # If an arg has a non-'U' value, we overwrite it.
        # Up to here RefactoredArgs does not contain any parameter decls
        $stref = _analyse_src_for_iodirs($stref, $f);
        
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
# Unknown & Read =>  In
#

#* If a Scalar argument is written to before it is read from, its IO direction is Out.
#
#Unknown & Write =>  Out
#


#* If an Array argument is written to and later read from, its IO direction is InOut.
#
# Out & Read =>  InOut
#


#* If a (Scalar or Array) argument is read from and later written to, its IO direction is InOut.
#
# In & Write =>  InOut
#

#* If an argument was not used in the subroutine body, set the status to Unused:
#
#Unknown =>  Unused

sub _set_iodir_read {
    (my $mvar, my $args_ref) = @_;
    my $is_array = 0;
    if (exists $args_ref->{$mvar}{'ArrayOrScalar'}) {
        $is_array = $args_ref->{$mvar}{'ArrayOrScalar'};
    }
    elsif (exists $args_ref->{$mvar}{'Type'}) {
        if ($args_ref->{$mvar}{'Type'} eq 'Array') {
            $is_array = 1;
        }
    }
    if ($args_ref->{$mvar}{'IODir'} eq 'Out' and $is_array) {
        $args_ref->{$mvar}{'IODir'} = 'InOut';
    }
    elsif (not exists $args_ref->{$mvar}{'IODir'}
        or not defined $args_ref->{$mvar}{'IODir'})
    {
        $args_ref->{$mvar}{'IODir'} = 'Unknown';
    }
    if ($args_ref->{$mvar}{'IODir'} eq 'Unknown') {
        print "FOUND In ARG $mvar\n" if $DBG;
        $args_ref->{$mvar}{'IODir'} = 'In';
    }
    return $args_ref;
}

# -----------------------------------------------------------------------------
sub _set_iodir_write {
    (my $mvar, my $args_ref) = @_;
    if (exists $args_ref->{$mvar}
        and ref($args_ref->{$mvar}) eq 'HASH')
    {
        if (exists $args_ref->{$mvar}{'IODir'}
            and defined $args_ref->{$mvar}{'IODir'})
        {
            if ($args_ref->{$mvar}{'IODir'} eq 'In') {
                print "FOUND InOut ARG $mvar\n" if $DBG;
                $args_ref->{$mvar}{'IODir'} = 'InOut';
            }
            elsif ($args_ref->{$mvar}{'IODir'} eq 'Unknown') {
                print "FOUND In ARG $mvar\n" if $DBG;
                $args_ref->{$mvar}{'IODir'} = 'Out';
            }
        }
        else {
            $args_ref->{$mvar}{'IODir'} = 'Unknown';
        }
    }
    return $args_ref;
}

# -----------------------------------------------------------------------------
sub _set_iodir_read_write {
    (my $mvar, my $args_ref) = @_;
    if (exists $args_ref->{$mvar}
        and ref($args_ref->{$mvar}) eq 'HASH')
    {
        if (exists $args_ref->{$mvar}{'IODir'}) {
            print "FOUND InOut ARG $mvar\n" if $DBG;
            $args_ref->{$mvar}{'IODir'} = 'InOut';
        }
    }
    return $args_ref;
}

# -----------------------------------------------------------------------------

sub _set_iodir_ignore {
    (my $mvar, my $args_ref) = @_;
    if (exists $args_ref->{$mvar}
        and ref($args_ref->{$mvar}) eq 'HASH')
    {
        if (exists $args_ref->{$mvar}{'IODir'}) {
            print "FOUND InOut ARG $mvar\n" if $DBG;
            $args_ref->{$mvar}{'IODir'} = 'Ignore';
        }
    }
    return $args_ref;
}

# -----------------------------------------------------------------------------
sub _set_iodir_vars {
    (my $vars, my $args_ref, my $subref) = @_;

    for my $mvar (@{$vars}) { 
        croak if not defined $mvar;
        if (exists $args_ref->{$mvar} and ref($args_ref->{$mvar}) eq 'HASH') {
            if (exists $args_ref->{$mvar}{'IODir'}) {
                $args_ref = $subref->($mvar, $args_ref);
            }
        }
    }
    return $args_ref;
}    # END of _find_vars_w_iodir()

# -----------------------------------------------------------------------------

sub _find_vars_w_iodir {
    (my $line, my $args_ref, my $subref) = @_;

# So we just split this in chunks, which means we ignore any arrays or function calls!
    my @chunks = split(/\W+/, $line);

    for my $mvar (@chunks) {
        next if $mvar eq '';
        next if $mvar =~ /^\d+$/;
        next if $mvar =~ /^(\-?(?:\d+|\d*\.\d*)(?:e[\-\+]?\d+)?)$/;
        next if $mvar =~ /\b(?:if|then|do|goto|integer|real|call|\d+)\b/;
        if (exists $args_ref->{$mvar} and ref($args_ref->{$mvar}) eq 'HASH') {

            if (exists $args_ref->{$mvar}{'IODir'}) {
                $args_ref = $subref->($mvar, $args_ref);
            }
        }    #else {

        # Just means that this is not an argument!
        #}
    }
    return $args_ref;
}    # END of _find_vars_w_iodir()

# -----------------------------------------------------------------------------
# Purely for clarity, maybe this routine should take the arguments as arguments?
# What we want in this routine is determine IO dirs for leaves and look them up for non-leaves
sub _analyse_src_for_iodirs {
    (my $stref, my $f) = @_;

    #    local $W=1;local $V=1

    print "_analyse_src_for_iodirs() $f\n" if $V;
    my $Sf = $stref->{'Subroutines'}{$f};

    if (not exists $Sf->{'IODirInfo'} or $Sf->{'IODirInfo'} == 0) { # This is to avoid doing this more than once
        if ( $Sf->{'Program'} # because of course a program does not have arguments
            or not exists $Sf->{'RefactoredArgs'}{'List'} or scalar @{$Sf->{'RefactoredArgs'}{'List'}} == 0) {
            say "INFO: SUB $f DOES NOT HAVE RefactoredArgs" if $I;
        }
        else {
            my $args      = dclone($Sf->{'RefactoredArgs'}{'Set'});
            my $args_list = $Sf->{'RefactoredArgs'}{'List'};

            if (exists $Sf->{'HasEntries'}) {
                say "INFO: Setting IODir to Ignore for all args in subroutine $f because of ENTRIES" if $I;
                for my $arg ($args_list) {
                    $args->{$arg}{'IODir'} = 'Ignore';
                }
            }
            elsif (exists $Sf->{'Function'} and $Sf->{'Function'} == 1) {

                # Don't touch
                # Why not? even a Function can have Intents other than In!
                # FIXME!
                say "INFO: SKIPPING IODir analysis for FUNCTION $f" if $I;
            }
            else {

                my $annlines = get_annotated_sourcelines($stref, $f);
                for my $index (0 .. scalar(@{$annlines}) - 1) {

                    (my $line, my $info) = @{$annlines->[$index]};

                    if (exists $info->{'Blank'} or exists $info->{'Comments'} or exists $info->{'Deleted'}) {
                        next;
                    }

                    # Skip format statements
                    if (exists $info->{'Format'}) {
                        next;
                    }

                    # Skip the signature
                    if (exists $info->{'Signature'}) {
                        next;
                    }

                    # Skip any 'use' or 'include' lines
                    if (exists $info->{'Use'} or exists $info->{'Include'}) {
                        next;
                    }

                    # Skip the declarations
                    if (exists $info->{'VarDecl'}) {
                        next;
                    }

                    # -----------------------------------------------------------------------------
                    if (exists $info->{'Do'}) {
                        if (exists $info->{'Do'}{'Iterator'}) {
                            my $mvar = $info->{'Do'}{'Iterator'};
                            if (exists $args->{$mvar}
                                and ref($args->{$mvar}) eq 'HASH')
                            {
                                if (exists $args->{$mvar}{'IODir'}) {
                                    $args = _set_iodir_write($mvar, $args);
                                }
                            }
                            for my $mvar (@{$info->{'Do'}{'Range'}{'Vars'}}) {
                                if (exists $args->{$mvar} and ref($args->{$mvar}) eq 'HASH') {
                                    if (exists $args->{$mvar}{'IODir'}) {
                                        $args = _set_iodir_read($mvar, $args);
                                    }
                                }
                            }
                        }
                        next;
                    }

                    # -----------------------------------------------------------------------------
                    # File open statements
                    if (exists $info->{'OpenCall'}) {
                        for my $var (@{$info->{'Vars'}{'List'}}) {
                            $args = _set_iodir_ignore($var, $args);
                        }
                        next;
                    }

                    # -----------------------------------------------------------------------------
                    if (exists $info->{'WriteCall'} or exists $info->{'PrintCall'}) {

                        # All variables are read from, so IODir is read
                        for my $mvar (@{$info->{'IOCall'}{'Args'}{'List'}}) {
                            next if $mvar eq 'write';
                            next if $mvar eq 'print';
                            if (exists $args->{$mvar}
                                and ref($args->{$mvar}) eq 'HASH')
                            {
                                if (exists $args->{$mvar}{'IODir'}) {
                                    $args = _set_iodir_ignore($mvar, $args);
                                }
                            }
                        }
                        for my $mvar (@{$info->{'ExprVars'}{'List'}}) {
                            next if $mvar eq 'write';
                            next if $mvar eq 'print';

                            if (exists $args->{$mvar}
                                and ref($args->{$mvar}) eq 'HASH')
                            {
                                if (exists $args->{$mvar}{'IODir'}) {
                                    $args = _set_iodir_read($mvar, $args);
                                }
                            }
                        }
                        for my $mvar (@{$info->{'CallAttrs'}{'List'}}) {
                            next if $mvar eq 'write';
                            next if $mvar eq 'print';
                            if (exists $args->{$mvar}
                                and ref($args->{$mvar}) eq 'HASH')
                            {
                                if (exists $args->{$mvar}{'IODir'}) {
                                    $args = _set_iodir_ignore($mvar, $args);
                                }
                            }
                        }
                        next;
                    }

                    # -----------------------------------------------------------------------------
                    if (exists $info->{'ReadCall'} or exists $info->{'InquireCall'}) {

                        # Arguments are written to, so IODir is write; others are read
                        for my $mvar (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
                            if (exists $args->{$mvar} and ref($args->{$mvar}) eq 'HASH') {
                                if (exists $args->{$mvar}{'IODir'}) {
                                    $args = _set_iodir_ignore($mvar, $args);
                                }
                            }
                        }
                        for my $mvar (@{$info->{'ExprVars'}{'List'}}, @{$info->{'CallAttrs'}{'List'}}) {
                            if (exists $args->{$mvar}
                                and ref($args->{$mvar}) eq 'HASH')
                            {
                                if (exists $args->{$mvar}{'IODir'}) {
                                    $args = _set_iodir_ignore($mvar, $args);
                                }
                            }
                        }
                        next;
                    }
                    if (exists $info->{'If'}) {
                        my $cond_vars = $info->{'Cond'}{'Vars'}{'List'};
                        $args = _set_iodir_vars($cond_vars, $args, \&_set_iodir_read);

#						next; # NOT next: maybe it is a subcall or an assignment!
                    }

                    # -----------------------------------------------------------------------------
                    # Subroutine call
                    if (exists $info->{'SubroutineCall'} && exists $info->{'SubroutineCall'}{'Name'}) {
                        my $name = $info->{'SubroutineCall'}{'Name'};

# So we get the IODir for every arg in the call to the subroutine
# We need both the original args from the call and the ex-glob args
# It might be convenient to have both in $info; otoh we can get ExGlobArgs from the main table

                        for my $mvar (@{$info->{'ExprVars'}{'List'}}) {

                            # So these var can be local, global or even intrinsics.
                            # Check if they are global first.
                            if (exists $args->{$mvar} and ref($args->{$mvar}) eq 'HASH') {
                                if (exists $args->{$mvar}{'IODir'}) {
                                    $args = _set_iodir_read($mvar, $args);
                                }
                            }
                        }

                        my $iodirs_from_call = _get_iodirs_from_subcall($stref, $f, $info);
                        
                        for my $var (keys %{$iodirs_from_call}) {

# Damn Perl! exists $args->{$var}{'IODir'} creates the entry for $var if it did not exist!

                            if (exists $args->{$var} and ref($args->{$var}) eq 'HASH') {
                                if (exists $args->{$var}{'IODir'}) {
                                    if (not defined $args->{$var}{'IODir'}) {
                                        $args->{$var}{'IODir'} = 'Unknown';
                                    }                                    
                                    # Call arg IN
                                    my $call_arg_iodir = lc($iodirs_from_call->{$var});
                                    if ($call_arg_iodir eq 'inout') {
                                        $call_arg_iodir = 'InOut'
                                    } else {
                                        $call_arg_iodir = ucfirst($call_arg_iodir);
                                    }
                                    if ($call_arg_iodir eq 'In') {
                                        if (not defined $args->{$var}{'IODir'}
                                            or $args->{$var}{'IODir'} eq 'Unknown')
                                        {
                                            # Sig arg IN if unknown
                                            $args->{$var}{'IODir'} = 'In';
                                        }
                                        elsif ($args->{$var}{'IODir'} eq 'Out') {
                                            # if the parent arg is Out and the child arg is In, parent arg stays Out!
                                            $args->{$var}{'IODir'} = 'Out';
                                        }    # if it's already In or InOut, it stays like it is.
                                    }
                                    # Call arg INOUT
                                    elsif ($call_arg_iodir eq 'InOut') {
                                        if ($args->{$var}{'IODir'} eq 'Unknown') {
                                            $args->{$var}{'IODir'} = 'InOut';
                                        }
                                        elsif ($args->{$var}{'IODir'} eq 'Out') {
                                            $args->{$var}{'IODir'} = 'Out';
                                        }
                                        elsif ($args->{$var}{'IODir'} eq 'In') {
                                            $args->{$var}{'IODir'} = 'InOut';
                                        }    # if it is In, it stays In
                                    }
                                    # Call arg OUT
                                    elsif ($call_arg_iodir eq 'Out') {
                                        if ($args->{$var}{'IODir'} eq 'Unknown') {
                                            $args->{$var}{'IODir'} = 'Out';
                                        }
                                        elsif ($args->{$var}{'IODir'} eq 'In') {
                                            $args->{$var}{'IODir'} = 'InOut';
                                        }    # if it's already InOut or Out, stays like it is.
                                    }
                                    else {                                        
                                        warning("Intent for call arg $var in call to $name in $f is unknown");
                                        # carp Dumper $iodirs_from_call;
                                        # carp "ARG $var RefactoredArgs => ".Dumper $stref->{Subroutines}{$f}{RefactoredArgs}{Set}{$var};
                                        # croak "ARG $var DeclaredOrigArgs => ".Dumper $stref->{Subroutines}{$f}{DeclaredOrigArgs}{Set}{$var};
                                    }
                                }
                                else {
                                    warning("$f: NO IODir info for $var" ,1);
                                }
                            }
                            else {
                                if (exists $iodirs_from_call->{$var} and defined $iodirs_from_call->{$var}) {
                                    say "INFO: $f: $var is not an argument, ignoring IODir " . $iodirs_from_call->{$var}
                                      if $I;
                                }
                                else {
                                    say "INFO: $f: $var is not in \$iodirs_from_call" if $I;
                                }
                            }

                            # So at this point, $args has correct IODir information
                        }
                        next;
                    }    # SubroutineCall

# Encounter Assignment
                    elsif (exists $info->{'Assignment'}) {
                            
                        # say "$f LINE: $line INFO: ".Dumper($info);
                        # First check the RHS
                        my $rhs_vars = $info->{'Rhs'}{'Vars'}{'List'};

                        # say "RHS: ".Dumper($rhs_vars);
                        if (scalar @{$rhs_vars} > 0) {
                            _set_iodir_vars($rhs_vars, $args, \&_set_iodir_read);
                        }
                        my $lhs_var = $info->{'Lhs'}{'VarName'};

                        # say "LHS: $lhs_var ".Dumper($lhs_var);
                        _set_iodir_vars([$lhs_var], $args, \&_set_iodir_write);
                        my $lhs_index_vars = $info->{'Lhs'}{'IndexVars'}{'List'};
                        if (scalar @{$lhs_index_vars} > 0) {
                            _set_iodir_vars($lhs_index_vars, $args, \&_set_iodir_read);
                        }
                        
                        # croak Dumper($args) if  $f eq 'count_sep' and $line=~/count/;
                        next;
                    }
                    else {    # not an assignment, do as before
#say "NON-ASSIGNMENT LINE: $line in $f" if $DBG;
                        _find_vars_w_iodir($line, $args, \&_set_iodir_read);
                    }
                }
            }

            for my $arg (@{$args_list}) {

                # say "$f: $arg => ".$args->{$arg}{'IODir'};
                if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg}) {

                    if (ref($args->{$arg}) eq 'HASH'
                        and exists $args->{$arg}{'Name'})
                    {    # If this is a full declaration record

                        # say Dumper($args->{$arg});
                        $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg} = {%{$args->{$arg}}};
                    }
                    else {    # Otherwise, get the record and update the IODir
                        my $decl = get_f95_var_decl($stref, $f, $arg);
                        if (ref($args->{$arg}) eq 'HASH' and exists $args->{$arg}{'IODir'}) {
                            $decl->{'IODir'} = $args->{$arg}{'IODir'};
                        }

                        # say Dumper($decl);
                        $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$arg} = $decl;
                    }

                }
                if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}) {
                    if (ref($args->{$arg}) eq 'HASH'
                        and exists $args->{$arg}{'Name'})
                    {    # If this is a full declaration record

                        # say Dumper($args->{$arg});
                        $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg} = {%{$args->{$arg}}};
                    }
                    else {    # Otherwise, get the record and update the IODir
                        my $decl = get_f95_var_decl($stref, $f, $arg);
                        if (ref($args->{$arg}) eq 'HASH' and exists $args->{$arg}{'IODir'}) {
                            $decl->{'IODir'} = $args->{$arg}{'IODir'};
                        }

                        
                        $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg} = $decl;
                    }                    
# croak Dumper($args,$stref->{'Subroutines'}{'chcopy'}{DeclaredOrigArgs}) if $f eq 'chcopy';
                }


            }

            # Here for some reason corr has been added as an argument!
            $Sf->{'IODirInfo'} = 1;
        }
    }    # if IODirInfo had not been set to 1
# carp 'ARGIODIRS: '. Dumper($stref->{'Subroutines'}{'chcopy'}{'DeclaredOrigArgs'}{'Set'}{'x'}) if $f eq 'chcopy';
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

sub conditional_assignment_fsm {
    (my $line) = @_;
    my ($do_nothing,    # 0
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

    my @cs         = split('', $line);
    my $ncs        = scalar @cs;
    my $cct        = 0;
    my $st         = $do_nothing;
    my $nest_count = 0;
    for my $c (@cs) {
        next if $c eq ' ';
        $cct++;

#### The transitions are:

        if ($st == $do_nothing) {
            if ($c eq '(') {
                $st = $read_cond;
            }
        }
        elsif ($st == $read_cond) {
            if ($c eq '(') {
                $nest_count++;
            }
            elsif ($c eq ')') {
                if ($nest_count == 0) {

                    # store condition, or enter state
                    $st = $store_cond;
                }
                else {
                    $nest_count--;
                }
            }
        }
        elsif ($st == $store_cond) {
            $st = $read_lhs;
        }
        elsif ($st == $read_lhs) {
            if ($c eq '(') {
                $st = $read_sep;
            }
            elsif ($c eq '=') {
                $st = $store_lhs;
            }
        }
        elsif ($st == $read_sep) {
            if ($c eq '=') {
                $st = $store_sep;
            }
        }
        elsif ($st == $store_sep) {
            $st = $read_rhs;
        }
        elsif ($st == $store_lhs) {
            $st = $read_rhs;
        }
        elsif ($st == $read_rhs) {
            if ($cct == $ncs) {
                $st = $store_rhs;
            }
        }

##### The actions are:
        if    ($st == $read_cond) { $cond .= $c }
        elsif ($st == $read_lhs)  { $lhs  .= $c }
        elsif ($st == $read_sep)  { $sep  .= $c }
        elsif ($st == $read_rhs) {
            $rhs .= $c;
        }
    }

    #    print "if(| $cond  |) [| $lhs |] = [| $rhs |]\n";
    return ($cond, $lhs, $sep, $rhs);
}    # END of conditional_assignment_fsm

# ----------------------------------------------------------------------------------------------------
# So we get the IODir for every arg in the call to the subroutine
# We need both the original args from the call and the ex-glob args
# It might be convenient to have both in $info; otoh we can get ExGlobArgs from the main table
#                my $iodirs_from_call = _get_iodirs_from_subcall( $stref, $f, $info );

# So what we do is:
# 1. get all vars from the ArgMap table.
# Note that some args are expressions, in which case they are used read-only per definition, so their IODir will always be In
# For the non-expression args, we need to use the table and then look up the IODir from the OrigArgs but via get_var_record_from_set($Sf,'OrigArgs')

# 2. If the ArgMap table is empty that means the sub was originally called without arguments.
# In that case, the arguments of the called sub are the same as of its signature.
# So the IODirs are those of the RefactoredArgs of $name
# 3. We can of course have both, the originals followed by the refactored ones.
sub _get_iodirs_from_subcall {
    (my $stref, my $f, my $info) = @_;
    my $called_arg_iodirs = {};
    if (not exists $info->{'ExtractedSubroutine'}) {
        my $name = $info->{'SubroutineCall'}{'Name'};

        if (not(   exists $stref->{'ExternalSubroutines'}{$name}
                or (exists $stref->{'Subroutines'}{$name}{'Entry'} and $stref->{'Subroutines'}{$name}{'Entry'} == 1)
                or exists $stref->{'Subroutines'}{$name}{'HasEntries'})
          )
        {

            # This is the parent
            my $Sf = $stref->{'Subroutines'}{$f};

            # These are the refactored arguments of the parent
            my $args   = $Sf->{'RefactoredArgs'}{'Set'};
            my $argmap = $info->{'SubroutineCall'}{'ArgMap'};
            my $Sname  = $stref->{'Subroutines'}{$name};

            # For every argument of the ORIGINAL signature of the called subroutine
            for my $sig_arg (keys %{$argmap}) {

# See if there is a corresponding argument in the called args of the called subroutine
                my $call_arg = $argmap->{$sig_arg};

                if (defined $call_arg) {

# The $call_arg can be Array, Scalar, Sub, Expr or Const
# Only if it is Array or Scalar  does it need to be considered for writing to by the subroutine
# We need to check the other variables in Array, Sub and Expr but they cannot be anything else than read-only
                    my $call_arg_type = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Type'};
                    # carp Dumper($info->{'SubroutineCall'});
                    if ($call_arg_type eq 'Scalar' or $call_arg_type eq 'Array') {

                        # This means that $call_arg is an argument of the caller $f
                        # That is what interests us as we want the IODir in that case

                        if ($call_arg_type eq 'Array') {
                            $call_arg = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Arg'};
                        }

                        if (    exists $args->{$call_arg}
                            and exists $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg})
                        {    # this caller argument has a record in RefactoredArgs of $f

                            # look up the IO direction for the corresponding $sig_arg
                            my $sig_iodir = $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
                            if (not exists $called_arg_iodirs->{$call_arg}) {
                                $called_arg_iodirs->{$call_arg} = $sig_iodir;
                            }
                            else {
                                if (($called_arg_iodirs->{$call_arg} eq 'In' and $sig_iodir eq 'Out')
                                    or (    $called_arg_iodirs->{$call_arg} eq 'Out'
                                        and $sig_iodir eq 'In')
                                  )
                                {
                                    $called_arg_iodirs->{$call_arg} = 'InOut';
                                }
                            }
                        }
                        else {

                            # Of course called args can be local variables or parameters.
                            # In the case of Parameters, we can set the called sub's sig arg to In

                            # It could be that this call arg is a parameter, let's check
                            # But to do so I should include Parameters in Vars
                            # Basically, they can be LocalParam and InclParam
                            # In that way we can look them up in the nested sets
                            if (in_nested_set($Sf, 'Parameters', $call_arg)) {
                                say "CALLER ARG <$call_arg> for call to $name in $f IS A PARAMETER." if $DBG;
                                say
                                  "WARNING: Setting intent(In) for argument $sig_arg of $name because the called argument is a parameter!"
                                  if $DBG;
                                print
                                  "INFO: $name in $f is called only once; $sig_arg is a parameter, setting IODir to 'In'\n"
                                  if $I;
                                $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} = 'In';
                            }
                            else {

# If it's a var, we don't do anything I guess? But suppose a var is being written to, and then an arg is being assigned to this var
# A var must always be written to anyway or it would be undefined.
                                if (in_nested_set($Sf, 'Vars', $call_arg)) {
                                    say "CALLER ARG <$call_arg> for call to $name in $f IS A LOCAL VAR." if $DBG;
                                }
                                else {
                                     if ($DBG) {
                                    say Dumper($Sf->{'Vars'})
                                      . "\nCALLER ARG <$call_arg> for call to <$name> HAS NO REC in Vars($f) $call_arg_type ";
                                    croak;
                                    }
                                }
                            }
                        }
                    }
                    else {    # If it is a Const or Expr or Sub,  the sig_arg must be In

   # Before 20160513, this had "and there is only a single subroutine call in the code" but that is not correct
   # It leads to Error: Non-variable expression in variable definition context (actual argument to INTENT = OUT/INOUT) at (1)
                        say
                          "WARNING: Setting intent(In) for argument $sig_arg of $name because the called argument is not a variable!"
                          if $DBG;
                        $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} = 'In';

                    }
                }
                else {
#				say "$name in $f: $sig_arg".':'.Dumper($argmap);
                    # WHY?
                    carp "MODIFYING RefactoredArgs ad hoc!" if $DBG;
                    if (not defined $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'}
                        or $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} eq 'Unknown')
                    {
                        $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'} = 'In';
                    }
                }
            }    # for loop

# For the refactored args that were not original args, we just copy the IODir
# So we take all refactored args but exclude the args in the argmap
# Somehow we also get the sig args when we do that, so I should exclude these as well I guess
#		for my $ref_arg ( keys %{ $Sname->{'RefactoredArgs'}{'Set'} } ) {
            for my $ref_arg (@{$Sname->{'RefactoredArgs'}{'List'}}) {
                if (exists $called_arg_iodirs->{$ref_arg}) {
                    say "INFO: SKIPPING $ref_arg in $f, already DONE: " . $called_arg_iodirs->{$ref_arg}
                      if $called_arg_iodirs->{$ref_arg} eq 'Unknown' and $I;
                    next;
                }
                if (exists $argmap->{$ref_arg} ) {
                    if ($I) {
                                if(defined $argmap->{$ref_arg}) {
                                    say "INFO: SKIPPING $ref_arg in $f, is ORIG SIG ARG (call arg: " . $argmap->{$ref_arg} . ')' if $I;    
                                } else {
                                    say "INFO: SKIPPING $ref_arg in $f, is ORIG SIG ARG (call arg: UNDEFINED)" if $I;    
                                }
                    }
                    
                    next;
                }
                if ($DBG and ref($Sname->{'RefactoredArgs'}{'Set'}{$ref_arg}) ne 'HASH'
                    or not exists $Sname->{'RefactoredArgs'}{'Set'}{$ref_arg}{'IODir'})
                {
                    carp "ARG $ref_arg SUB $name called from $f has no IODir "
                      . Dumper($Sname->{'RefactoredArgs'});#{'Set'}{$ref_arg});
                }
                $called_arg_iodirs->{$ref_arg} = $Sname->{'RefactoredArgs'}{'Set'}{$ref_arg}{'IODir'};

#			  say "REF ARG: $ref_arg RECORD: ".Dumper($Sname->{'RefactoredArgs'}{'Set'}{$ref_arg});
                if (exists $called_arg_iodirs->{$ref_arg} and defined $called_arg_iodirs->{$ref_arg}) {

#			  	say '<'.$called_arg_iodirs->{$ref_arg}.'>';
                    say "INFO: IODir is Unknown for $ref_arg in $f" if $called_arg_iodirs->{$ref_arg} eq 'Unknown' and $I;
                }
                else {
                    say "INFO: NO $ref_arg in %called_arg_iodirs in $f" if $I;
                }
            }
        }
        else {

            if ($I) {
                say $name. ' EXTERNAL' if exists $stref->{'ExternalSubroutines'}{$name};
                say $name. ' ENTRY'
                  if exists $stref->{'Subroutines'}{$name}{'Entry'} and $stref->{'Subroutines'}{$name}{'Entry'} == 1;
                say $name. ' HAS ENTRIES' if exists $stref->{'Subroutines'}{$name}{'HasEntries'};
            }
            for my $arg (@{$info->{'SubroutineCall'}{'Args'}{'List'}}) {
                $called_arg_iodirs->{$arg} = 'Ignore';
            }
        }
    }
    else {
        my $name = $info->{'SubroutineCall'}{'Name'};

        # my $called_arg_iodirs = {};
        my $Sname = $stref->{'Subroutines'}{$name};

        for my $sig_arg (@{$Sname->{'RefactoredArgs'}{'List'}}) {
            my $sig_iodir = $Sname->{'RefactoredArgs'}{'Set'}{$sig_arg}{'IODir'};
            $called_arg_iodirs->{$sig_arg} = $sig_iodir;
        }
    }
    return $called_arg_iodirs;
}    # END of _get_iodirs_from_subcall()

sub update_argument_io_direction_all_subs {
    (my $stref) = @_;
    for my $f (keys %{$stref->{'Subroutines'}}) {
        next if $f eq '';
        next if exists $F95_intrinsic_functions{$f};
        next if exists $stref->{'Entries'}{$f};
        next if exists $stref->{'ExternalSubroutines'}{$f};
        next if exists $stref->{'ExternalSubroutines'}{$f};
        next if exists $stref->{'Modules'}{$f};               # HACK! FIXME!
        next if (exists $stref->{'Subroutines'}{$f}{'Program'} and $stref->{'Subroutines'}{$f}{'Program'} == 1);
        say "UPDATE IODIR IN $f" if $DBG;

        $stref = _update_argument_io_direction($stref, $f);
    }
    return $stref;
} # END of update_argument_io_direction_all_subs

sub _update_argument_io_direction {
    (my $stref, my $f) = @_;

    my $Sf = $stref->{'Subroutines'}{$f};

    my $__update_decl = sub {
        (my $annline, my $state) = @_;
        (my $line,    my $info)  = @{$annline};
        (my $stref, my $f, my $rest) = @{$state};
        
        my $Sf = $stref->{'Subroutines'}{$f};
        if (exists $info->{'VarDecl'}) {

#			say Dumper($annline);
            my $varname = $info->{'VarDecl'}{'Name'};

#			carp Dumper($info) ;
            if (in_nested_set($stref->{'Subroutines'}{$f}, 'Args', $varname)) {

                my $decl = get_var_record_from_set($stref->{'Subroutines'}{$f}{'Args'}, $varname);
                # carp Dumper($decl) if $f eq 'mult_chk' and $varname eq 'w4';
                if (exists $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$varname}) {
                    my $rdecl = $stref->{'Subroutines'}{$f}{'RefactoredArgs'}{'Set'}{$varname};

#						say 'RefactoredArgs: '.Dumper($rdecl) if $varname eq 'ivd005' and $f eq 'sn705';
                    if (exists $rdecl->{'Name'}) {                        
                        $decl = $rdecl;
                    }
                    else {
                        if (exists $rdecl->{'IODir'} and $rdecl->{'IODir'} ne 'Unknown') {
                            $decl->{'IODir'} = $rdecl->{'IODir'};
                        }
                    }

						# croak "DECL FROM REFACTOREDARGS: ".Dumper($rdecl) if $f eq 'mult_chk' and $varname eq 'w4';
                }
                if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$varname}) {
                    my $rdecl = $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$varname};

#						say 'RefactoredArgs: '.Dumper($rdecl) if $varname eq 'ivd005' and $f eq 'sn705';
                    # say  "BEFORE:",$decl->{'IODir'} , '<>', $rdecl->{'IODir'} if $varname eq 'x' and $f eq 'chcopy';
                    # if (exists $rdecl->{'Name'}) {
                    #     $decl = $rdecl;
                    # }
                    # else {
                        if (exists $rdecl->{'IODir'} and $rdecl->{'IODir'} ne 'Unknown') {
                            $decl->{'IODir'} = $rdecl->{'IODir'};
                        }
                    # }
                    # say  "AFTER:",$decl->{'IODir'} ,'<>',$rdecl->{'IODir'} if $varname eq 'x' and $f eq 'chcopy';

						# say  "DECL FROM DeclaredOrigArgs: ".Dumper($rdecl) if $f eq 'mult_chk' and $varname eq 'w4';
                }

#					croak Dumper($decl) if $varname eq 'string';
                if (exists $decl->{'Parameter'}) {
                    delete $decl->{'Parameter'};
                    $decl->{'Name'} = $decl->{'Var'};
                    delete $decl->{'Val'};
                    $decl->{'IODir'} = 'In';
                }
                if (exists $stref->{'Subroutines'}{$f}{'BlockData'} and $stref->{'Subroutines'}{$f}{'BlockData'} == 1) {
                    $decl->{'IODir'} = 'InOut';
                }
                # Add INTENT to the generated declaration. I think we should do this elsewhere!
                # $info->{'Intent'} = $decl->{'IODir'};
                
                my $rline = emit_f95_var_decl($decl);
                
                # WV 2021-06-11 ad hoc, because I use it in the inliner
                $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'} = $decl->{'IODir'};
                if (not exists $info->{'ArgDecl'}) {
                    $info->{'ArgDecl'}{$varname}=1;
                }
                add_ann_to_info($info, $f, '_update_argument_io_direction() '.__LINE__);
                if (exists $info->{'Deleted'}) {
                    $rline = '! ' . $rline;
                    add_ann_to_info($info, $f, __LINE__ .' Deleted');
                }
                $annline = [$rline, $info];

#				say Dumper($decl->{'Name'},$decl->{'IODir'}) if $varname eq 'ivd005' and $f eq 'sn705';
            }
            else {
#				say "$line";
            }
        }
        return ([$annline], $state);
    };
    my $state = [$stref, $f, {}];
    ($stref, $state) = stateful_pass_inplace($stref, $f, $__update_decl, $state, '_update_argument_io_direction() ' . __LINE__);

    return $stref;
} # END of _update_argument_io_direction
1;
