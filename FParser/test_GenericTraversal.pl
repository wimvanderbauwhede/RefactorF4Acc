use v5.20;
use Data::Dumper;
use GenericTraversal qw( traverse_with_state traverse );

sub pass { (my $where, my $elt, my $state) = @_;
    if ($where eq 'ARRAY_PRE') {
        $elt+=$state->{'n'};
        $state->{'n'}*=2;
    }
    return ($elt, $state);
};

sub pass2 { (my $where, my $elt) = @_;
    if ($where eq 'ARRAY_PRE') {
        $elt++;
    }
    return $elt;
};


my $state={'n' => 1};
my $ds = {'v' => 1, 'w' => [2,3] };

my $nds = traverse_with_state($ds,\&pass, $state); 

say Dumper($nds);

my $nds2 = traverse($ds,\&pass2); 

say Dumper($nds2);


