package RefactorF4Acc::Analysis::LoopDetect;
use v5.12;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;

#
#   (c) 2015 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
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

@RefactorF4Acc::Analysis::LoopDetect::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::LoopDetect::EXPORT = qw(
  &outer_loop_start_detect
  &outer_loop_end_detect
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

    ( my $kernelwrapper, my $stref ) = @_;
    say "calling loop_detect($kernelwrapper)\n";    # if $V;
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
}



sub _loop_detect_rec {
    ( my $f, my $stref, my $index, my $kernelwrapper ) = @_;
    say "_loop_detect_rec $f $index $kernelwrapper\n";    # if $V;
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
            $subname = $info->{'SubroutineSig'};
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
        for my $caller ( @{$callers} ) {

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
    ( my $kernelwrapper, my $stref ) = @_;

    ( my $f, my $outer_loop_info ) =
      @{ $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopStartPos'} };

    #            say 'INFO: '.Dumper($outer_loop_info);
    say "OUTER LOOP IN: $f";
    say 'OUTER LOOP START: ' . ' LineID: ' . $outer_loop_info->{'LineID'};
    my $new_annlines = [];

    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func}{$f};
    my $before_in_after
    for my $annline ( @{ $Sf->{'AnnLines'} } ) {
        ( my $line, my $info ) = @{$annline};
        if ( exists $info->{'Assignment'} ) { die 'ASSIGNMENT $line; }
        if ( exists $info->{'Do'} ) {
            if ( $info->{'LineID'} == $outer_loop_info->{'LineID'} ) {
                $info->{'OuterLoopStart'} = $kernelwrapper;
                say $line;
            }
        }
        if ( exists $info->{'EndDo'} ) {
            if ( exists $info->{'EndDo'}{'LineID'}
                and $info->{'EndDo'}{'LineID'} == $outer_loop_info->{'LineID'} )
            {
                $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopEndPos'} =
                  [ $f, $info ];
                $info->{'OuterLoopEnd'} = {};
                say 'OUTER LOOP END (END DO): LineID: ' . $info->{'LineID'};
                say $line;
            } elsif ( exists $info->{'EndDo'}{'Label'}
                and $info->{'EndDo'}{'Label'} ==
                $outer_loop_info->{'Do'}{'Label'} )
            {
                $stref->{'KernelWrappers'}{$kernelwrapper}{'OuterLoopEndPos'} =
                  [ $f, $info ];
                $info->{'OuterLoopEnd'} = $kernelwrapper;
                say 'OUTER LOOP END (CONTINUE): LineID: ' . $info->{'LineID'};
                say $line;
            }

        }
        push @{$new_annlines}, [ $line, $info ];
    }
    $stref->{$sub_or_func}{$f}{'AnnLines'} = $new_annlines;
    return $stref;
}

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
