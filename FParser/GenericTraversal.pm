package GenericTraversal;
use warnings;
use strict;
use v5.16;
use Data::Dumper;
use version; our $VERSION = version->declare('v0.2.1');

use Exporter 'import';

@GenericTraversal::EXPORT = qw(
  traverse  
  traverse_with_state
);

sub traverse_with_state { (my $ds, my $worker, my $state_in )=@_; 
    my $state=$state_in;
   
    my $traversal = sub {
        (my $ast, my $f, my $worker)=@_;
        if (ref($ast) eq 'ARRAY') {
            my $nast=[];
            for my $elt (@{$ast}) {
                (my $eltp, $state) = $worker->('ARRAY_PRE',$elt, $state);                  
                next if not defined $eltp;
#                return $eltp if ...
                my $nelt=&{$f}($eltp,$f, $worker);
                (my $neltp,$state) = $worker->('ARRAY_POST',$nelt, $state);                  
                next if not defined $neltp;
                push @{$nast},$neltp;
            }
            return $nast;
        } elsif (ref($ast) eq 'HASH' or ref($ast) =~/[A-Z]\w+/) {
            my $nast={};
            for my $k (keys %{$ast}) {
                my $v = $ast->{$k};
                (my $kv, $state) = $worker->('HASH_PRE',[$k,$v], $state);
                (my $nk, my $vp)=@{$kv};
                next if not defined $vp;
                my $nv=&{$f}($vp,$f, $worker);
                (my $nkv, $state) = $worker->('HASH_POST',[$nk,$nv], $state);
                (my $nkp, my $nvp)=@{$nkv};
                next if not defined $nvp;
                $nast->{$nkp}=$nvp;
            }
            return $nast;
        } else {
            (my $nast, $state) = $worker->('SCALAR',$ast, $state);
            return $nast;
        }
    };

 my $fixpoint_combinator = sub {
        (my $n,my $f,my $worker)=@_; 
        &{$f}($n,$f,$worker);
    };

  my $res = $fixpoint_combinator->($ds,$traversal, $worker) ;
    return $res;
};

sub traverse { (my $ds, my $worker)=@_;     
    my $traversal_nostate = sub {
        (my $ast, my $f, my $worker)=@_;
        if (ref($ast) eq 'ARRAY') {
            my $nnast = $worker->('TOP_ARRAY_PRE',$ast); 
            my $nast=[];
            for my $elt (@{$nnast}) {
                my $eltp = $worker->('ARRAY_PRE',$elt);                  
                next if not defined $eltp;
                my $nelt=&{$f}($eltp,$f, $worker);
                my $neltp = $worker->('ARRAY_POST',$nelt);                  
                next if not defined $neltp;
                push @{$nast},$neltp;
            }
            my $nnnast = $worker->('TOP_ARRAY_POST',$nast);             
            return $nnnast;
        } elsif (ref($ast) eq 'HASH' or ref($ast) =~/[A-Z]\w+/) {
            my $nnast = $worker->('TOP_HASH_PRE',$ast);

            my $nast={};
            for my $k (keys %{$nnast}) {
                my $v = $ast->{$k};
                my $kvp = $worker->('HASH_PRE',[$k,$v]);
                (my $nk, my $vp)=@{$kvp};
                next if not defined $vp;
                my $nv=&{$f}($vp,$f, $worker);
                my $nkvp = $worker->('HASH_POST',[$nk,$nv]);
                (my $nkp,my $nvp)=@{$nkvp};
                next if not defined $nvp;
                $nast->{$nkp}=$nvp;
            }
             my $nnnast = $worker->('TOP_HASH_POST',$nast);
            return $nnnast;
        } else {
            my $nast = $worker->('SCALAR',$ast);
            return $nast;
        }
    };

    my $fixpoint_combinator_nostate = sub {
        (my $n,my $f, my $worker)=@_; 
        &{$f}($n,$f,$worker);
    };

    $fixpoint_combinator_nostate->($ds,$traversal_nostate, $worker) ;
};





=pod
sub pass { (my $where, my $elt, my $state) = @_;
    if ($where eq 'ARRAY_PRE') {
        $elt+=$state->{'n'};
        $state->{'n'}*=2;
    }
    return ($elt, $state);
};

my $ds = {'v' => 1, 'w' => [2,3] };
my $state={'n' => 1};

my $nds = traverse_with_state($ds,\&pass, $state); 

say Dumper($nds);



sub pass { (my $where, my $elt) = @_;
    if ($where eq 'ARRAY_PRE') {
        $elt++;
    }
    return $elt;
};

my $ds = {'v' => 1, 'w' => [2,3] };

my $nds = traverse($ds,\&pass); 

say Dumper($nds);
=cut
