# Analyse loops in terms of map, fold and iterative as well as for stencils and halos
package RefactorF4Acc::Analysis::Recursion;
#
#   (c) 2024 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.20;
use feature qw(signatures);
no warnings qw(experimental::signatures);

use RefactorF4Acc::Config;
# use RefactorF4Acc::Utils;
# use RefactorF4Acc::F95SpecWords qw( %F95_assoc_intrinsic_functions );
# use RefactorF4Acc::Utils::Functional;
# use RefactorF4Acc::Refactoring::FoldConstants qw( fold_constants );
# use RefactorF4Acc::Analysis::VarAccessAnalysis qw( analyseAllVarAccesses );
use RefactorF4Acc::Parser::Expressions qw( get_vars_from_expression );
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass_inplace stateless_pass_inplace );

use Carp;
use Data::Dumper;
# use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::Recursion::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Recursion::EXPORT_OK = qw(
    analyse_recursion
);

=pod
Analyse a subroutine to determine if it is tail recursive or not.

This is currently not strong enough because a mutual recursion is not detected, only direct recursion
TODO!
To handle this, what we need is build a call chain and detect a loop. We do this somewhere. In fact, we do this in three modules:

Analysis::Globals::_identify_inherited_exglobs_to_rename()
Analysis::Globals::_rename_inherited_exglobs()
Analysis::Arguments::determine_ExGlobArgs()
Analysis::ArgumentIODirs::determine_argument_io_direction_rec()



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

recursive subroutine fib(n,nfib)
	integer, intent(in) :: n
	integer, intent(out) :: nfib
	integer :: nm1, nm2, m
	if (n<1) then 
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
* But is this also not the case for variables that are not used as args? Yes, this is for any local variable and presumably any inout arg as these can also be used for rw. But it only matters if they are used, i.e. an out or inout depends on them or they are used as in or inout to an IO call; or in fact maybe any other call, because the call could modify a global variable.

* And this should include subroutine calls, not just assignments.



For and assignment, we check:
- Add any var to the links entry for the LHS UNLESS it had been written to already
- is it a var in the links table? Also add an entry for the LHS
- If the LHS is an (in)out arg, we are done: it's not tail recursive
For subroutine calls: call f(in1, inout2, inout3, out4,in5, out6) is equivalent to
out6 = f6(in1,inout2, inout3, in5)
out4 = f4(in1,inout2, inout3, in5)
inout3 = f3(in1,inout2, inout3, in5)
inout2 = f2(in1,inout2, inout3, in5)
In other words, all outs and inouts are assumed to depend on all ins and inout

So I go trough all AnnLines and for each Assignment or SubroutineCall I check for the vars used as (in)out args of the recursive call. If there is more than one recursive call, it starts from the first and the others are treated as ordinary calls.
=cut 
# preliminary: create a set of all local vars and args in the subroutine
sub analyse_recursion($stref,$f){
	say '=' x 80 if $DBG;
	say  "analyse_recursion($f)" if $DBG;

	$stref->{'CallStack'}=[];
	$stref = check_recursive_call_chain( $stref, $f);
	if (not exists $stref->{'Subroutines'}{$f}{'Recursion'} or $stref->{'Subroutines'}{$f}{'Recursion'} ne 'Call-chain') {

		my $all_args_local_vars = { %{ $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'} },
						%{ $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'} } };

	# Crucially, we need a "written before read test". The rhs value must be a global or constant, otherwise it is a dependency.
	# Now, this is a little more complicated: suppose we have a variable that is not a constant, but it is set to a constant anywhere upstream.
	# Then we should mark that var as const until it is set to a non-constant. I think it means we put it in $dependency_free, and remove it if needed.

	# But if we encounter this, then the lhs can be removed from the vars to check. So I need a set $dependency_free.

		my $pass_analyse_recursion = sub($annline,$state) {
			(my $line,my $info)=@{$annline};
			if ($state->{'AfterRecursiveCall'} == -1) {
				say "After a recursive call" if $DBG;
				$state->{'AfterRecursiveCall'} = 1;
			}

			if (exists $info->{'Assignment'}) {
				# find RHS vars that are local or args
				my $lhs_var = $info->{'Lhs'}{'VarName'} ;
				for my $rhs_var (@{ $info->{'Rhs'}{'Vars'}{'List'} } ) {
					if (exists $all_args_local_vars->{$rhs_var} and not exists $state->{'DependencyFree'}{$rhs_var}) {
						$state->{'Links'}{$lhs_var}{$rhs_var}=1; # TODO different categories
					}
				}
				# If the RHS has no local vars or args, or they are dependency-free, the LHS is also dependency-free
				if (not exists $state->{'Links'}{$lhs_var}) {
					$state->{'DependencyFree'}{$lhs_var} = 1;
				} else {
					# If there are links
					if ($state->{'AfterRecursiveCall'} == 1) {
						# If the LHS is an out arg, and there are links, then we're done
						if (_isOutArg($stref,$f,$lhs_var)) {
							$state->{'Used'}{$lhs_var}=1;
							$state->{'TailCall'}=0;
							say "$f: LINE $line: LHS $lhs_var is used after recursive call, so not a tail call" if $DBG;
						}
					} else {
						# Only links after the recursive call make sense
						delete $state->{'Links'}{$lhs_var};
					}
				}

				# Now see if there is a recursion via a function call in the RHS expression
				if (exists $info->{'FunctionCalls'} and scalar @{$info->{'FunctionCalls'}} > 0 ){
					for my $call_info ( @{$info->{'FunctionCalls'}} ) {
						$state = _check_call_for_recursion($stref,$f,$line,$call_info,$state,$all_args_local_vars);
						if ($state->{'AfterRecursiveCall'} == -1) {
							say "After a recursive call in expression" if $DBG;
							$state->{'AfterRecursiveCall'} = 1;
						}
					}
				}
			}
			elsif (exists $info->{'If'} and $state->{'AfterRecursiveCall'} == 1) {
				for my $var (@{$info->{'Cond'}{'Vars'}{'List'}}) {
					if (exists $all_args_local_vars->{$var} and not exists $state->{'DependencyFree'}{$var}) {
						# This means the variable is used after a recursive call
						$state->{'Used'}{$var}=1;
						$state->{'TailCall'}=0;
						say "$f: LINE $line: $var in IF is used after recursive call, so not a tail call" if $DBG;
					}
				}
			}
			elsif (exists $info->{'Do'} and $state->{'AfterRecursiveCall'} == 1) {
				if (scalar @{$info->{'Do'}{'Range'}{'Vars'}}>0 ) {
					for my $var (@{$info->{'Do'}{'Range'}{'Vars'}}) {
						if (exists $all_args_local_vars->{$var} and not exists $state->{'DependencyFree'}{$var}) {
							# This means the variable is used after a recursive call
							$state->{'Used'}{$var}=1;
							$state->{'TailCall'}=0;
							say "$f: LINE $line: $var in DO is used after recursive call, so not a tail call" if $DBG;
						}
					}
				}
			}
			elsif (exists $info->{'SubroutineCall'}) {
				my $csubname =  $info->{'SubroutineCall'}{'Name'};
				if ($csubname eq $f) {
					if ($state->{'AfterRecursiveCall'} == 0) {
						say "$f: LINE $line: Found a recursive call" if $DBG;
						$state->{'AfterRecursiveCall'} = -1;
					}
				}
				if ($state->{'AfterRecursiveCall'} == 1) {
					my @in_args = (); # contains the inouts as well
					my @out_args = (); # contains the inouts as well
					for my $sig_arg (sort keys %{ $info->{'SubroutineCall'}{'ArgMap'} }) {
						my $call_arg = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};

						if ($info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'Type'} eq 'Expr') {
							my $ast = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg}{'AST'};
							my $vars = get_vars_from_expression( $ast, {} );
							for my $expr_var (sort keys %{$vars}) {
								if( _isOutArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$expr_var} ) {
									push @out_args,$expr_var;
								}
								if( _isInArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$expr_var} ) {
									push @in_args,$expr_var;
								}
							}
						} else {
							if( _isOutArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$call_arg} ) {
								push @out_args,$call_arg;
							}
							if( _isInArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$call_arg} ) {
								push @in_args,$call_arg;
							}
						}

					}
					# Any input arg to a subroutine call is Used
					for my $in_arg (@in_args) {
						$state->{'Used'}{$in_arg}=1;
						$state->{'TailCall'}=0;
						say "$f: LINE $line: $in_arg is used in call to $csubname after recursive call, so not a tail call" if $DBG;
					}
					for my $out_arg( @out_args) {
						# Any output arg of the caller is Used.
						if (_isOutArg($stref,$f,$out_arg) ) {
							$state->{'Used'}{$out_arg}=1;
							$state->{'TailCall'}=0;
							say "$f: LINE $line: $out_arg is an Out arg of $f used in call to $csubname after recursive call, so not a tail call" if $DBG;
						} else {
							# Other vars go in the Links table.
							for my $in_arg (@in_args) {
								$state->{'Links'}{$out_arg}{$in_arg}=1;
							}
						}
					}
				}
			}

			return ([$annline],$state);
		};

		my $state={'Links'=>{},'DependencyFree'=>{},'AfterRecursiveCall'=>0,'Used'=>{},'TailCall'=>1}; 
		($stref,$state) = stateful_pass_inplace($stref,$f,$pass_analyse_recursion, $state,'pass_analyse_recursion' . __LINE__  ) ;

		# We check here. If TailCall is still 1, we need to look at Links
		if ($state->{'TailCall'}==0) {
			$stref->{'Subroutines'}{$f}{'Recursion'}='General';
		} else {
			if (not keys %{$state->{'Links'}} ) {
				$stref->{'Subroutines'}{$f}{'Recursion'}='Tail';
			} else {
				say Dumper($state->{'Links'}) if $DBG;
			}
		}
		if ($state->{'AfterRecursiveCall'} == 0) {
			$stref->{'Subroutines'}{$f}{'Recursion'}='No';
		}
	}
	if ($V) {
		say "$f: ".$stref->{'Subroutines'}{$f}{'Recursion'}." recursion";
		say '-' x 8;
	}
	return $stref;
} # END of analyse_recursion

=pod 
The result should be a table with, for any var use as a key, a set of vars on which it depends.

What about vars that depend on themselves? 
v = v+x 
this is still a read before write and we can skip v on the RHS

=cut

sub _isOutArg($stref,$f,$arg){
	if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}) {
		return $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'} =~/(?:in)?out/i ? 1 : 0
	} else {
		return 0
	}
}

sub _isInArg($stref,$f,$arg){
	if (exists $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}) {
		return $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$arg}{'IODir'} =~/in(?:out)?/i ? 1 : 0
	} else {
		return 0
	}
}

# We do a recusive descent for all called subroutines, and for the leaves we do the analysis
sub check_recursive_call_chain( $stref, $f) {
	# local $V=1;
    my $c;
    if ($V) {
        $c = (defined $stref->{'Counter'}) ? $stref->{'Counter'} : 0;
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
                # if (not exists $stref->{'Subroutines'}{$calledsub}{'Recursive'}) {
				if ($calledsub ne $f) {
					say "$f: Recursive call chain ($calledsub)\n".Dumper($stref->{'CallStack'}) if $DBG;
					$stref->{'Subroutines'}{$calledsub}{'Recursion'} = 'Call-chain';
					return $stref;
                }
				next;
			}
            $stref->{'Counter'}++ if $V;
            $stref = check_recursive_call_chain($stref, $calledsub);
            $stref->{'Counter'}-- if $V;
        }
    }
    print "\t" x $c, "--------\n" if $V;

    pop  @{ $stref->{'CallStack'} };
    return $stref;
} # END of check_recursive_call_chain()

sub _check_call_for_recursion($stref,$f,$line,$call_info,$state,$all_args_local_vars) {
	my $csubname = $call_info->{'Name'};
	if ($csubname eq $f) {
		if ($state->{'AfterRecursiveCall'} == 0) {
			say "$f: LINE $line: Found a recursive call";
			$state->{'AfterRecursiveCall'} = -1;
		}
	}
	if ($state->{'AfterRecursiveCall'} == 1) {
		my @in_args = (); # contains the inouts as well
		my @out_args = (); # contains the inouts as well
		for my $sig_arg (sort keys %{ $call_info->{'ArgMap'} }) {
			my $call_arg = $call_info->{'ArgMap'}{$sig_arg};

			if ($call_info->{'Args'}{'Set'}{$call_arg}{'Type'} eq 'Expr') {
				my $ast = $call_info->{'Args'}{'Set'}{$call_arg}{'AST'};
				my $vars = get_vars_from_expression( $ast, {} );
				for my $expr_var (sort keys %{$vars}) {
					if( _isOutArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$expr_var} ) {
						push @out_args,$expr_var;
					}
					if( _isInArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$expr_var} ) {
						push @in_args,$expr_var;
					}
				}
			} else {
				if( _isOutArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$call_arg} ) {
					push @out_args,$call_arg;
				}
				if( _isInArg($stref,$f,$sig_arg) and exists $all_args_local_vars->{$call_arg} ) {
					push @in_args,$call_arg;
				}
			}

		}
		# Any input arg to a subroutine call is Used
		for my $in_arg (@in_args) {
			$state->{'Used'}{$in_arg}=1;
			$state->{'TailCall'}=0;
			say "$f: LINE $line: $in_arg is used in call to $csubname after recursive call, so not a tail call";
		}
		for my $out_arg( @out_args) {
			# Any output arg of the caller is Used.
			if (_isOutArg($stref,$f,$out_arg) ) {
				$state->{'Used'}{$out_arg}=1;
				$state->{'TailCall'}=0;
				say "$f: LINE $line: $out_arg is an Out arg of $f used in call to $csubname after recursive call, so not a tail call";
			} else {
				# Other vars go in the Links table.
				for my $in_arg (@in_args) {
					$state->{'Links'}{$out_arg}{$in_arg}=1;
				}
			}
		}
	}
	return $state;
}

1;
