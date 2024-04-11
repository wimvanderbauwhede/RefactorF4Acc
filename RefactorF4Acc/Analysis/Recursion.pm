# Analyse loops in terms of map, fold and iterative as well as for stencils and halos
package RefactorF4Acc::Analysis::Recursion;
#
#   (c) 2024 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

=pod
Analyse a subroutine to determine if it is tail recursive or not.

Tail recursive means that the recursive call is the last call in the subroutine. But it seems to me that

subroutine loop(idx,hb,in_array,max)
	if (in_array[idx]>max) then
		max = in_array[idx]
	end if
	if (idx<hb) then
		call loop(idx+1,hb,in_array,max)
	end if
	print *, max ! this is a read to max
end subroutine

is also tail recursive, even though max is read before being written to after the call to loop
I think the read only matters if it is 
- on the RHS of an assignment to an arg or local var
- an in(out) arg of a routine that has out args that are subsequently used
But 

subroutine fib(n,nfib)
	integer, intent(in) :: n
	integer, intent(out) :: nfib
	integer :: nm1, nm2
	if (<1) then 
		nfib = 1
	else
		call fib(n-1,nm1)
		call fib(n-2,nm1)
		nfib = nm1+nm2
	end if
end subroutine

is not tail recursive: the calls to fib write to nm1; then nm1 and nm2 are read and modify nfib

The full analysis is more complicated: we need to check if in the end, an out or inout is modified.
Because if e.g. nm1+nm2 was assigned to a tmp that was never used, then that would not matter.
So in principle we need to check the dependency chain, which I think we have somewhere
_link_writes_to_reads() in Analysis::ArrayAccessPatterns has something like this but for arrays

"The 'Links' table lists all input args on which an output arg depends."

* What I need here is: given the out or inout arguments of a recursive call, does any out or inout argument depend on them via a link *after* the call
* And this should include subroutine calls, not just assignments.
For and assignment, we check:
- if the RHS an inout or out from the recursive call? If so, add it to the links entry for the LHS
- is it a var in the links table? Also add an entry for the LHS
- If the LHS is an (in)out arg, we are done: it's not tail recursive
- if we have a subroutine call, if any of the ins or inouts is an out or inout from a recursive call, then any out or inout needs to be added to the links table; if any of these outs or inouts is an (in)out arg, we are done.
- When we reach the end, if there is any entry in the links table for an (in)out arg, it's not tail recursive
=cut

use vars qw( $VERSION );
$VERSION = "5.1.0";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.20;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::F95SpecWords qw( %F95_assoc_intrinsic_functions );
use RefactorF4Acc::Utils::Functional;
use RefactorF4Acc::Refactoring::FoldConstants qw( fold_constants );
use RefactorF4Acc::Analysis::VarAccessAnalysis qw( analyseAllVarAccesses );
use RefactorF4Acc::Parser::Expressions qw( _traverse_ast_with_stateful_action );
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::Recursion::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Recursion::EXPORT_OK = qw(
    analyse_recursion
);


# -----------------------------------------------------------------------------
sub analyse_recursion { (my $stref, my $f)=@_;

		my @all_args_local_vars =  sort ( keys %{
            get_vars_from_set($stref->{'Subroutines'}{ $f }{'Args'})
        },
        keys %{
            get_vars_from_set($stref->{'Subroutines'}{ $f }{'OrigLocalVars'})
        }
        );

        my $is_non_tail_recursive = 0;
		for my $var (@all_args_local_vars) {
			for my $csub_info (@call_sequence) {
				my $csub = $csub_info->{'Name'};
				my $csub_argmap = $csub_info->{'ArgMap'};
				# I use the ArgMap, which is SigArg => CallArg
				# So for a given CallArg, I must find the corresponding SigArg(s); in principle there can me more than one.
				# my $csub_args = $stref->{'Subroutines'}{ $csub }{'DeclaredOrigArgs'}{'Set'};
				my $sig_args = find_keys_for_value($csub_argmap,$var);
				for my $sig_arg (@{$sig_args}) {
					# See if $sig_arg was written to before it was read.
					# If it was read first, we need to keep it, else we don't need it for this subroutine
					my $written_before_read = __check_written_before_read($sig_arg, $stref, $csub);
					if (not $written_before_read) {
						$vars_to_keep->{$var}=1;
						last;
					}
					# As soon as we need to keep it for one subroutine, we can stop as we can't remove it.
					# However, if the csub arg is inout, and we have a write-before-read, then any subsequent sub call can be ignored
					# This is not the case if the csub arg is just in -- but I think we can't write to an in argument
				}
			}
			my $written_before_read = __check_written_before_read($var, $stref, $f);
			# say "KEEP: $var $written_before_read";
			if (not $written_before_read) {
				$vars_to_keep->{$var}=1;
			}
		}
    return $is_non_tail_recursive;
}

sub _check_written_before_read { my ($in_arg, $stref, $f)=@_;

	my $reads_writes=__check_reads_writes($in_arg, $stref, $f);

	my $written_before_read = 0;
	for my $rw (@{$reads_writes}) {
		if ($rw eq 'w') {
			$written_before_read=1;
		}
		last;
	}
	return $written_before_read;
} # END of __check_written_before_read


sub _check_read_before_written { my ($in_arg, $stref, $f)=@_;

	my $reads_writes=__check_reads_writes($in_arg, $stref, $f);

	my $read_before_written = 0;
	for my $rw (@{$reads_writes}) {
		if ($rw eq 'r') {
			$read_before_written=1;
		}
		last;
	}
	return $read_before_written;
} # END of __check_read_before_written

sub _check_read_only { my ($in_arg, $stref, $f)=@_;

	my $reads_writes=__check_reads_writes($in_arg, $stref, $f);

	my $read_only = 1;
	for my $rw (@{$reads_writes}) {
		if ($rw eq 'w') {
			$read_only=0;
			last;
		}
	}
	return $read_only;
} # END of __check_read_only


sub __check_reads_writes {  my ($arg, $stref, $f)=@_;

# In practice we will not have IO calls in the kernels
# Nor will we have subroutines calls
# Function calls on RHS are OK
# So all we need to check is Assignments, If, Do and Case
# As per the F95 spec, CaseVals are constants
my $pass_check_reads_writes = sub { (my $annline, my $reads_writes)=@_;
		(my $line,my $info)=@{$annline};

		if (exists $info->{'Assignment'} ) {

			if (exists $info->{'Rhs'}{'Vars'}{'Set'}{$arg
				}) {
					 # $arg is Read
					 push @{$reads_writes},'r';
				 }
			if ($info->{'Lhs'}{'VarName'} eq $arg
			) {
					 # $arg is Written
					 push @{$reads_writes},'w';
			}
		}
		elsif (exists $info->{'If'} ) {
			if (exists $info->{'Cond'}{'Vars'}{'Set'}{$arg
		}) {
				# $arg is Read
				push @{$reads_writes},'r';
			}
		}
		elsif (exists $info->{'CaseVar'} ) {
			if ($info->{'CaseVar'} eq $arg) {
				# $arg is Read
				push @{$reads_writes},'r';
			}
		}
		elsif (exists $info->{'Do'} ) {
			if (scalar @{$info->{'Do'}{'Range'}{'Vars'}}>0 ) {
				for my $var (@{$info->{'Do'}{'Range'}{'Vars'}}) {
					if ($arg eq $var) {
						# $arg is Read
						push @{$reads_writes},'r';
					}
				}
			}
		}

		return ([$annline],$reads_writes);
	};

	my $reads_writes=[]; # sequence of 'r' and 'w'. And yes, I could use 0/1
 	($stref,$reads_writes) = stateful_pass_inplace($stref,$f,$pass_check_reads_writes, $reads_writes,'pass_check_reads_writes' . __LINE__  ) ;
	 return $reads_writes;
} # END of __check_reads_writes



1;
