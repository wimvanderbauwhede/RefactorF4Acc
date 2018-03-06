package RefactorF4Acc::Analysis::LoopDetect;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;

#
#   (c) 2015 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Analysis::LoopDetect::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::LoopDetect::EXPORT = qw(
  &outer_loop_start_detect
  &outer_loop_end_detect
  &outer_loop_variable_analysis
);

=pod
This algorithm detects the outer enclosing loop around a potential OpenCL kernel.
The purpose is to identify the variables that belong to the loops.
This routine is called from Parser::_analyse_lines()

The way it works is:
- give the $kernelwrapper (which _analyse_lines() determined from the !$ACC line)
- get the subroutine name and startindex:
$stref->{'KernelWrappers'}{$kernelwrapper}={
    'OuterLoopStartPos'=>[$f1,$idx1],
    'BeginKernelWrapper'=>[$f2,$idx2],
    'EndKernelWrapper'=>[$f3,$idx3],
    'LoopVars' =>[$i,$j],
};
- call _loop_detect_rec()
- This routine goes up in the $annlines list until it finds a subroutine signature, in which case it goes through all callers. 
- It keeps track of all DO blocks encountered along the way (OuterLoopStartPos) and their loop variables (LoopVars).
- It does that until it finds the toplevel program signature.
=cut

# For some reason this is called twice??!
sub outer_loop_start_detect {
croak 'NOT UP TO DATE!';
    ( my $kernelwrapper, my $stref ) = @_;
    say "calling loop_detect($kernelwrapper)\n" if $V;
    my $f = $stref->{'KernelWrappers'}{$kernelwrapper}{'BeginKernelWrapper'}[0];
    my $index =
      $stref->{'KernelWrappers'}{$kernelwrapper}{'BeginKernelWrapper'}[1];
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf          = $stref->{$sub_or_func}{$f};
    my $srcref      = $Sf->{'AnnLines'};
    _loop_detect_rec( $f, $stref, $index, $kernelwrapper );

#    say 'OUTER LOOP START: '.$stref->{'KernelWrappers'}{$kernelwrapper}{ 'OuterLoopStartPos'}[0]
#    .' LineID:'
#    .$stref->{'KernelWrappers'}{$kernelwrapper}{ 'OuterLoopStartPos'}[1]->{'LineID'};

    return $stref;
}    # END of outer_loop_start_detect()

sub _loop_detect_rec {
    ( my $f, my $stref, my $index, my $kernelwrapper ) = @_;
    say "INFO: _loop_detect_rec $f $index $kernelwrapper\n" if $I;
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf          = $stref->{$sub_or_func}{$f};
    my $srcref      = $Sf->{'AnnLines'};
    my $subname     = $f;
    while ( $index != 0 ) {
        --$index;
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        next if $line =~ /^\!\s+/;
        if ( exists $info->{'Do'} ) {

            #            say "DO: $line in $f, $index, ".$info->{'LineID'}."\n";
            #            die Dumper($info);
            $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopStartPos'} =
              [ $f, $info ];
            push @{ $stref->{'KernelWrappers'}{$kernelwrapper}{'LoopVars'} },
              $info->{'Do'}{'Iterator'};

            #TODO: also detect assignments inside loops
        }
        if ( exists $info->{'SubroutineSig'} ) {
            $subname = $info->{'SubroutineSig'}[1]; #[$spaces, $subname,[@subargs]] 
            last;
        }
    }
    if ( exists $stref->{'Subroutines'}{$f}{'Program'} ) {

        #  We're done
        return $stref;
    } else {

        # Find the caller
        my $callers = $stref->{'Subroutines'}{$subname}{'Callers'};

        # For each caller, recurse.
        for my $caller (keys  %{$callers} ) {

# In the caller we should find the position of the call(s)
# FIXME: We can see a problem here: if there are multiple calls, we need to flag this up because it means that there are several loops.
# Basically I'll find the lowest call and work my way up. WEAK!
            my $call_index = _find_call_index( $caller, $subname, $stref );
            $stref =
              _loop_detect_rec( $caller, $stref, $call_index, $kernelwrapper );
            die "_loop_detect_rec(): WHY HERE?";
            return $stref;
        }
    }
}    # END of _loop_detect_rec()

# This is now easy because we have the line ids
sub _find_call_index {
    ( my $caller, my $subname, my $stref ) = @_;
    if ( @{ $stref->{'Subroutines'}{$subname}{'Callers'}{$caller} } ) {

        # OK, $subname was called from $caller
        return $stref->{'Subroutines'}{$subname}{'Callers'}{$caller}->[-1];
    } else {
        croak(
"TROUBLE in find_call_index(): $subname was NOT called from $caller!"
        );
    }
}    # END of _find_call_index()

sub outer_loop_end_detect {
croak 'NOT UP TO DATE!';
    ( my $kernelwrapper, my $stref ) = @_;

    ( my $f, my $outer_loop_info ) =
      @{ $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopStartPos'} };

    #            say 'INFO: '.Dumper($outer_loop_info);
    
    say 'INFO: OUTER LOOP IN $f START: ' . ' LineID: ' . $outer_loop_info->{'LineID'} if $I;
    my $new_annlines = [];

    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func}{$f};

    for my $annline ( @{ $Sf->{'AnnLines'} } ) {
        ( my $line, my $info ) = @{$annline};
        if ( exists $info->{'Do'} ) {
            if ( $info->{'LineID'} == $outer_loop_info->{'LineID'} ) {
                $info->{'OuterLoopStart'} = $kernelwrapper;
#                say $line;
            }
        }
        if ( exists $info->{'EndDo'} ) {
            if ( exists $info->{'EndDo'}{'LineID'}
                and $info->{'EndDo'}{'LineID'} == $outer_loop_info->{'LineID'} )
            {
                $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopEndPos'} =
                  [ $f, $info ];
                $info->{'OuterLoopEnd'} = {};
                if ($I) {
                say 'INFO: OUTER LOOP END (END DO): LineID: ' . $info->{'LineID'};
                say $line;
                }

            } elsif ( exists $info->{'EndDo'}{'Label'}
                and $info->{'EndDo'}{'Label'} ==
                $outer_loop_info->{'Do'}{'Label'} )
            {
                $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopEndPos'} =
                  [ $f, $info ];
                $info->{'OuterLoopEnd'} = $kernelwrapper;
                if ($I) {
                say 'OUTER LOOP END (CONTINUE): LineID: ' . $info->{'LineID'};
                say $line;
                }
            }

        }
        push @{$new_annlines}, [ $line, $info ];
    }
    $stref->{$sub_or_func}{$f}{'AnnLines'} = $new_annlines;
    return $stref;
}    # END of outer_loop_end_detect()

=pod
Deciding which variables go in init() and which in run()
- If a variable is not updated inside the outer loop, it goes in init(). Otherwise it goes in run()
- So we have to look for variables that are on the LHS of an assignment or possibly the argument of a subroutine call outside the wrapper
- And of course these variables must be argument of one of the subroutine calls inside the wrapper.

So: 
- if the line is an assignment and it appears inside the loop and outside the wrapper block, we store the var name in loop_updated_vars

HOWEVER: the above is only correct for values that are going to be copied to the OpenCL device!
Additionally, any variables that are used read-only in init() and run() but not copied to the device 
are required as arguments to run() as well as init().
One way to do this is use the additional !$ACC KernelSub but the question is, what's the point of marking a set of subroutines 
to go inside the kernel wrapper and then not use them as kernels?
TODO: We can try a simple different approach: just allow the user to specify additional arguments to the kernel wrapper in the !$ACC:

!$ACC KernelWrapper $kernelwrapper, extra_args(data20,nmax)

With the current state we can take the subroutine and split it into an init() and run() part with the right arguments for both. 
So the next point is the content of these subroutines. The init() routine is relatively easy because we already generate it. 

The run() routine is more complicated, but we can move in small steps:
1. First pass, just generate basic host-side code for single-threaded OpenCL kernels
We will generate the kernels using the separate tool. I am at this point not concerned with creating a superkernel. 
This is easy enough to do by generating a kernel from a kernelwrapper routine with the correct case statement.
 For every subroutine in the wrapper
 - remove all non-loop-updated arguments;
 - every routine has its own local and global range
 - the remaining arguments and the state pointer need to be written to the device
 - create a  loop over a case statement to run all kernels in order.
2. Second pass will be to identify the subroutines that perform embarrassingly parallel computations, then we auto-parallelise and create the correct ranges
3. Third pass will be to identify the subroutines that perform reductions, 
- these have to read back data and compute the final value on the host
- and subsequent use of the computed value by the kernel requires it to be written to the device  
4. Finally we could try and detect iterations as well, these must definitely be done on the host
=cut

# This routine is called after refactor_all()
# It should be called after all subroutines have their explicit arguments
sub outer_loop_variable_analysis {
croak 'NOT UP TO DATE!';

    ( my $kernelwrapper, my $stref ) = @_;

    ( my $f, my $outer_loop_info ) =
      @{ $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopStartPos'} };

    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func}{$f};

    my ( $BEFORE, $LOOP, $WRAPPER, $AFTER ) = ( 0 .. 3 );
    my $code_region       = $BEFORE;
    my $loop_updated_vars = {};
    my $wrapper_run_vars  = {};
    for my $pass ( 0, 1 )
    {    # two passes in case updates are done after the kernel wrapper block
        for my $annline ( @{ $Sf->{'AnnLines'} } ) {
            next unless defined $annline;
            ( my $line, my $info ) = @{$annline};

            if ( exists $info->{'OuterLoopStart'}
                and $info->{'OuterLoopStart'} eq $kernelwrapper )
            {
                $code_region = $LOOP;
            }
            if (    $code_region == $LOOP
                and exists $info->{'AccPragma'}
                and exists $info->{'AccPragma'}{'BeginKernelWrapper'}
                and $info->{'AccPragma'}{'BeginKernelWrapper'}[0] eq
                $kernelwrapper )
            {
                $code_region = $WRAPPER;
            }
            if (    $code_region == $WRAPPER
                and exists $info->{'AccPragma'}
                and exists $info->{'AccPragma'}{'EndKernelWrapper'}
                and $info->{'AccPragma'}{'EndKernelWrapper'}[0] eq
                $kernelwrapper )
            {
                $code_region = $LOOP;
            }
            if ( $pass == 0 ) {
                if ( $code_region == $LOOP and exists $info->{'Do'} ) {
                    my $iter = $info->{'Do'}{'Iterator'};
                    $loop_updated_vars->{$iter} = $iter;
                }

                if ( $code_region == $LOOP and exists $info->{'Assignment'} ) {

                    say "INFO: ASSIGNMENT in loop: $line:\t"
                      . join( ';', keys %{$info} ) if $I;
                    my $varname = $info->{'Assignment'}{'Lhs'}{'VarName'};
                    $loop_updated_vars->{$varname} = $varname;
                }
                if ( $code_region == $LOOP
                    and exists $info->{'SubroutineCall'} )
                {
                    say "INFO: SUBROUTINE CALL in loop: $line:\t"
                      . join( ';', keys %{$info} ) if $I;    #die Dumper($info);
                      # So here I need to find all arguments of the sub with Intent Out or InOut
                    my $sub_name = $info->{'SubroutineCall'}{'Name'};
                    my $sub_args =
                      $stref->{'Subroutines'}{$sub_name}{RefactoredArgs}{Set};
                    my $updated_args = {};
                    for my $arg ( keys %{$sub_args} ) {
                        if (   $sub_args->{$arg}{'IODir'} eq 'Out'
                            or $sub_args->{$arg}{'IODir'} eq 'InOut' )
                        {
                            $updated_args->{$arg} = $arg;
                        }
                    }

# So now I need to match the args in $updated_args with the actual input variables via List
                    my $sub_sig_arg_list =
                      $stref->{'Subroutines'}
                      { $info->{'SubroutineCall'}{'Name'} }{RefactoredArgs}
                      {List};
                    my $sub_call_arg_list =
                      $info->{'SubroutineCall'}{'RefactoredArgs'};
                    my $lut = make_lookup_table( $sub_sig_arg_list,
                        $sub_call_arg_list );

#                    say "SUB $sub_name: ";    #.Dumper($lut);
                    if ( %{$updated_args} ) {
                        for my $updated_arg ( keys %{$updated_args} ) {
                            if (exists $lut->{$updated_arg}) {
                            my $varname = $lut->{$updated_arg};
                            $loop_updated_vars->{$varname} = $varname;
                            }
                        }
                    }
                }
            }

# The condition below should never happen, because we have already factored out the kernel wrapper routine
# Otherwise any of these vars would need to be added to the list of wrapper_run_vars
            if ( $code_region == $WRAPPER and exists $info->{'Assignment'} ) {
                if ( not exists $info->{Deleted} ) {
#                    say "ASSIGNMENT in wrapper: $line:\t". join( ';', keys $info );
                    my $varname = $info->{'Assignment'}{'Lhs'}{'VarName'};
                    $loop_updated_vars->{$varname} = $varname;
#                    say "VARIABLE $varname IS ASSIGNED IN WRAPPER $kernelwrapper";
                    $wrapper_run_vars->{$kernelwrapper}{$varname} = $varname;
                }
            }
            if ( $code_region == $WRAPPER and exists $info->{'SubroutineCall'} )
            {
                if ( not exists $info->{Deleted} ) {
#                    say "SUBROUTINE CALL in wrapper: $line:\t". join( ';', keys $info );
                    my $sub_name = $info->{'SubroutineCall'}{'Name'};
                    my $wrapper_sub_args =
                      $stref->{'Subroutines'}{$sub_name}{RefactoredArgs}{Set};

                    for my $loop_updated_var ( keys %{$loop_updated_vars} ) {
                        if ( exists $wrapper_sub_args->{$loop_updated_var} ) {
#                            say "VARIABLE $loop_updated_var IS UPDATED IN LOOP AND ARG FOR $sub_name";
                            $wrapper_run_vars->{$kernelwrapper}
                              {$loop_updated_var} = $loop_updated_var;
                        }
                    }
                }
            }

            if ( exists $info->{'OuterLoopEnd'}
                and $info->{'OuterLoopEnd'} eq $kernelwrapper )
            {
                $code_region = $AFTER;
            }
        }
    }
    return $stref;
}    # END of outer_loop_variable_analysis()

=pod
    (my $srcref, my $src, ... ) = @_;

for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
    my $info = 
    if (exists($info->{AccPragma}) and exists($info->{AccPragma}{BeginKernelWrapper})) {
        my $start_of_search_idx=$index;
    }
if (exists($info->{AccPragma}) and exists($info->{AccPragma}{EndKernelWrapper})) {
my $start_of_mod_var_search_idx=$index;
}
if ($start_of_mod_var_search_idx!=0) {
# Look for variables in calls and assignments
if (exists($info->{SubroutineCall}) {
# Subcall, get arguments
	my $name  = $info->{'SubroutineCall'}{'Name'};			 	
	my $Sname = $stref->{'Subroutines'}{$name};
	my $args = $Sf->{'RefactoredArgs'}{'Set'};
}
if (exists($info->{Assignment}) and $info->{Assignment}==1) {
# Assignment, parse to get arguments. This is what we do in IODirs
}
}
}
=> Go up for the loops (and for init)
for idx = start_of_search_idx to 0
	if line contains loop => set outer_loop_idx to idx
	if line contains subroutine decl => look up where it is called, start process again
	if line contains toplevel program decl => stop

    }
=cut    

1;
