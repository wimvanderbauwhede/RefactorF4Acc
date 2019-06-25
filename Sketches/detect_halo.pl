# Halo access detection 
# The main purpose is to detect writes to halos, because reads are never a problem
# For the purpose of dividing the domain (e.g. chunking on GPU, or MPI) we need the read accesses to ensure that no read occurs outside the chunk visible to the process.
# So first we must detect if a given access is inside a halo
 
sub _detect_halos {
	(my $accesses, my $stref, my $f) = @_;
	if (not exists $accesses->{'Arrays'}) {
		return $stref;
	}
	
	for my $array_var (keys %{ $accesses->{'Arrays'} } ) {
	
		for my $rw ('Read','Write') {	
			my ($expr_id,$expr_recs ) = each %{ $accesses->{'Arrays'}{$array_var}{$rw}{'Accesses'} };
			my $idx=0;
			for my $expr_rec (@{$expr_recs}) { # i.e. i,j,k
			    my ($loop_iter, $offset_t) = each %{$expr_rec};
			    my $offset=$offset_t->[1];
			    for my $b (0,1) {
			        my $m = $state->{'Subroutines'}{ $f }{$block_id}{'LoopIters'}{$loop_iter}{'Range'}->[$b];
			        my $expr_m = $m+$offset;
			        my $array_bound = $state->{'Subroutines'}{ $f }{ $block_id }{'Arrays'}{$array_var}{'Dims'}[$idx][$b];
			        my $array_halo = $stref->{'Subroutines'}{ $f }{'Vars'}{$array_var}{'Halos'}[$idx][$b];
			        my $in_halo = $b ? 
			        ($expr_m > $array_bound - $array_halo) ? 1 : 0
			        : ($expr_m < $array_bound + $array_halo) ? 1 : 0;
			        say "HALO CHECK: $rw access to $loop_iter in $array_var is ". ($in_halo ? '' : 'not').' a halo access.';
			    }
			    $idx++;
			}
		}
	}
	return $stref;

}