package RefactorF4Acc::Analysis::LoopDetect;

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
    &loop_detect
);


=pod
my $start_of_outer_loop_search_idx=0;
my $start_of_mod_var_search_idx=0;
# We should just detect this on the fly and store it!

The general problem is: if we identify a line by its position in the list, this can change later. So what we should do instead is give the line a unique number. For extra lines we just continue numbering from the bottom. 
$stref->{'KernelWrappers'}{$kernelwrapper}={
    'OuterLoopPos'=>[$f1,$idx1],
    'BeginKernelWrapper'=>[$f2,$idx2],
    'EndKernelWrapper'=>[$f3,$idx3],
    'LoopVars' =>[$i,$j],
};
=cut
# For some reason this is called twice??!
sub loop_detect {    
    warn "LOOP DETECT!\n";
    ( my $kernelwrapper, my $stref ) = @_;
    my $f = $stref->{'KernelWrappers'}{$kernelwrapper}{ 'BeginKernelWrapper'}[0];
    my $index =$stref->{'KernelWrappers'}{$kernelwrapper}{ 'BeginKernelWrapper'}[1];
    my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf          = $stref->{$sub_or_func}{$f};
    my $srcref      = $Sf->{'AnnLines'};
    _loop_detect_rec($f,$stref,$index,$kernelwrapper);
}

sub _loop_detect_rec { (my $f,my $stref, my $index,my $kernelwrapper) =@_;
    warn "_loop_detect_rec $f $index $kernelwrapper\n";
   my $sub_or_func = sub_func_incl_mod( $f, $stref );
    my $Sf          = $stref->{$sub_or_func}{$f};
    my $srcref      = $Sf->{'AnnLines'};
    my $subname = $f;
    while ($index !=0) { 
        --$index;
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        next if $line =~ /^\!\s+/;
        if (exists $info->{'Do'}) {
            warn "DO: $line in $f\n";
#            die Dumper($info);
            $stref->{'KernelWrappers'}{$kernelwrapper}{ 'OuterLoopStartPos'} =[$f,$index];
            push @{ $stref->{'KernelWrappers'}{$kernelwrapper}{ 'LoopVars'} }, $info->{'Do'}{'Iterator'};
#TODO: also detect assignments inside loops
        }
        if (exists $info->{'SubroutineSig'}) {
            $subname = $info->{'SubroutineSig'};
            last;
        }
    }
       if( exists $stref->{'Subroutines'}{$f}{'Program'} ) {
# We're done           
           return $stref;
       } else {
# Find the caller
           my $callers = $stref->{'Subroutines'}{$subname}{'Callers'};
            # For each caller, recurse.
           for my $caller (@{$callers}) {
# In the caller we should find the position of the call(s)
# We can see a problem here: if there are multiple calls, we need to flag this up because it means that there are several loops.
# Basically I'll find the lowest call and work my way up. WEAK!               
            my $call_index=_find_call_index($caller, $subname, $stref);
            $stref=_loop_detect_rec($caller,$stref,$call_index,$kernelwrapper);
            return $stref;
           }
       }
} # END of _loop_detect_rec()

# This is now easy because we have the line ids 
sub _find_call_index { (my $caller, my $subname, my $stref)=@_;
    if (@{$stref->{'Subroutines'}{$subname}{'Callers'}{$caller}}) {
    # OK, $subname was called from $caller
        return $stref->{'Subroutines'}{$subname}{'Callers'}{$caller}->[-1];
    } else {
        croak( "TROUBLE in find_call_index(): $subname was NOT called from $caller!" );
    }
} # END of _find_call_index()


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
