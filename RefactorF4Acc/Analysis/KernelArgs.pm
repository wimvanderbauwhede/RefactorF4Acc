package RefactorF4Acc::Analysis::KernelArgs;

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

@RefactorF4Acc::Analysis::KernelArgs::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::KernelArgs::EXPORT = qw(
    &determine_kernel_args
    &determine_kernel_wrapper_args    
);
 
croak 'UNUSED!'; 

=pod
What I call KernelArgs are those arguments of a kernel that have to be written or read, so they must be an argument of the kernel stub
What I call KernelWrapperArgs are those arguments of any kernel that are needed outside the kernel wrapper, so they must be an argument of the wrapper

for every KernelSub in the KernelWrapper region
  for every argument of the KernelSub
	for every Other Call in the KernelWrapper region 
		- with a LineID > the KernelSub LineID: 
			for every arg of the Other Call
				if it is In or InOut, and the kernel arg is Out or InOut, we need to keep the arg as (In)Out
		- with a LineID < the KernelSub LineID: 
			for every arg of the Other Call
				if it is Out or InOut, and the kernel arg is In or InOut, we need to keep the arg as In(Out)
for every other call below the KernelWrapper region 
			for every arg of the Other Call
				if it is In or InOut, and the kernel arg is Out or InOut, it has to become an arg for the wrapper
for every assignemnt below the KernelWrapper region 			
	for every var on the RHS
		if it is a kernel arg marked as Out or InOut, it has to become an arg for the wrapper
=cut
sub determine_kernel_args { (my $stref)=@_;
    for my $kw (keys %{$stref->{'KernelWrappers'}}) {
        for my $ks (keys %{$stref->{'KernelWrappers'}{'KernelSubs'}}) {# in the KernelWrapper region
#            for every argument of the KernelSub
            for my $karg (keys %{ $stref->{'Subroutines'}{$ks}{'Set'} }) {
#	for every Other Call in the KernelWrapper region 
                for my $oc (keys %{$stref->{'KernelWrappers'}{'OtherCalls'}}) {
                    if($stref->{'KernelWrappers'}{'OtherCalls'}{$oc}{'LineID'} >$stref->{'KernelWrappers'}{'KernelSubs'}{$ks}{'LineID'}) {
#		- with a LineID > the KernelSub LineID: 
#			for every arg of the Other Call
                        for my $arg (keys %{ $stref->{'Subroutines'}{$oc}{'Set'} }) {
#				if it is In or InOut, and the kernel arg is Out or InOut, 
                    if ( $stref->{'Subroutines'}{$oc}{'Set'}{$arg}{'IODir'} =~/In(Out)?/
                            and
                            $stref->{'Subroutines'}{$ks}{'Set'}{$karg}{'IODir'} =~/(In)?Out/
                       ) {
#                         we need to keep the arg as (In)Out
                              $stref->{'Subroutines'}{$ks}{'Set'}{$karg}{'KernelArg'}='Read';
                    }
                        }
                    } elsif ($stref->{'KernelWrappers'}{'OtherCalls'}{$oc}{'LineID'} < $stref->{'KernelWrappers'}{'KernelSubs'}{$ks}{'LineID'}) {
#		- with a LineID < the KernelSub LineID: 
#			for every arg of the Other Call
                        for my $arg (keys %{ $stref->{'Subroutines'}{$oc}{'Set'} }) {
#				if it is Out or InOut, and the kernel arg is In or InOut, 
                     if ( $stref->{'Subroutines'}{$oc}{'Set'}{$arg}{'IODir'} =~/(In)?Out/
                            and
                            $stref->{'Subroutines'}{$ks}{'Set'}{$karg}{'IODir'} =~/In(Out)?/
                       ) {
#we need to keep the arg as In(Out)
                                  $stref->{'Subroutines'}{$ks}{'Set'}{$karg}{'KernelArg'}='Write';

                        }
                    }
                }
            }
        }
    }
    return $stref;
} # END of determine_kernel_args()

sub determine_kernel_wrapper_args { (my $stref)=@_;
    for my $kw (keys %{$stref->{'KernelWrappers'}}) {
        for my $ks (keys %{$stref->{'KernelWrappers'}{'KernelSubs'}}) {# in the KernelWrapper region
#            for every argument of the KernelSub
            for my $karg (keys %{ $stref->{'Subroutines'}{$ks}{'Set'} }) {
=pod                
for every other call below the KernelWrapper region 
			for every arg of the Other Call
				if it is In or InOut, and the kernel arg is Out or InOut, it has to become an arg for the wrapper
for every assignemnt below the KernelWrapper region 			
	for every var on the RHS
		if it is a kernel arg marked as Out or InOut, it has to become an arg for the wrapper
I think there is a third case: if the argument is Out or InOut for the caller of the KernelWrapper, then we also need to bring it out?
I am actually not sure about any of this, because in practice there is no point in doing anything with the results after the time loop has finished.
Of course one could argue that it is not the !$ACC KernelWrapper pragma that decides the region, but the loop around it. If so we need to detect the OuterLoopEndPos, not only the OuterLoop(Start)Pos. To do that it would help if the EndDo has a label corresponding to the BeginDo. 
Now, this is the case for labeled loops (of course) in F77 but it means that I would have to line up the do's and end do's otherwise.

OTOH, that is definitely not essential. We can assume that for now, the ACC region covers the body of the loop.
If this really is to work across subroutine calls and with nested loops, we need to find all loop iterators and check them as well, because obviously the loop iterators are needed in almost all kernels. So I must build a list of loop iterators. 
To make things worse, there can of course be assignments inside nested loops, and these assigned variables can also be used inside the kernel subs.
So in principle when I go up, I need to track all the LHS of assignments as well as all loop iters, call this "LoopVars"
=cut
            }
        }
    }
    return $stref;
} # END of determine_kernel_wrapper_args()

1;


