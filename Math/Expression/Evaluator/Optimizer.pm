package Math::Expression::Evaluator::Optimizer;
use strict;
use warnings;

=head1 NAME

Math::Expression::Evaluator::Optimizer - 
Optimize Math::Expression::Evaluator ASTs

=head1 SYNOPSIS

    use Math::Expression::Evaluator;
    my $m = Math::Expression::Evaluator->new("2 + 4*f");
    $m->optimize();
    for (0..100){
        print $m->val({f => $_}), "\n";
    }

=head1 DESCRIPTION

Math::Expression::Evaluator::Optimizer performs simple optimizations on the
abstract syntax tree from Math::Expression::Evaluator.

You should not use this module directly, but interface it via 
L<Math::Expression::Evaluator>.

The following optimizations are implemented:

=over

=item *

Constant sub expressions: C<variable + 3 * 4> is simplfied to 
C<variable + 12>.

=item *

Joining of constants in mixed constant/variable expressions: C<2 + var + 3>
is simplified to C<var + 5>. Works only with sums and products (but internally 
a C<2 - 3 + x> is represented as C<2 + (-3) + x>, so it actually works with 
differences and divisions as well).

=item * 

Flattening of nested sub expression: C<a * (3 * b)> is flattened into 
C<a * 3 * b>. Currently this is done before any other optimization and not 
repeated.

=back

=head1 PERFORMANCE CONSIDERATIONS

C<optimize()> currently takes two full loops through the AST, copying and 
recreating it. If you execute C<val()> only once, calling C<optimize()>
is in fact a performance loss.

If the expression is optimizable, and you execute it C<$n> times, you
usually have a net gain over unoptimized execution if C<< $n > 15 >>.

Of course that value depends on the complexity of the expression, and how
well it can be reduced by the implemented optimizations.

Your best is to always benchmark what you do. Most of the time the compiled 
version returned by C<< ->compiled >> is much faster than the optimized
(and not compiled) form.
=cut

my %is_commutative = (
            '+' => 1,
            '*' => 1,
        );

sub _optimize {
    my ($expr, $ast) = @_;
    return _partial_execute($expr, _flatten($ast));
}

# Note: if you ever want to introduce some kind of scoping that is 
# tied to blocks, remove the '{' here.
my %flattable = map { $_ => 1 } ('{', '+', '*');

sub _flatten {
    my ($ast) = @_;
    return $ast unless ref $ast;

    my $type = shift @$ast;
    my @new_nodes = ($type);
    if ($flattable{$type}){
        # interpolate AST nodes with the same type
        # e.g. ['+', 2, ['+', 3, 4]] into ['+', 2, 3, 4]
        for (map { _flatten($_) } @$ast){
            if (ref $_ and $_->[0] eq $type){
                my @inner_nodes = @$_;
                shift @inner_nodes;
                push @new_nodes, @inner_nodes;
            } else {
                push @new_nodes, $_;
            }
        }
    } else {
        push @new_nodes, map { _flatten($_) } @$ast;
    }
    return \@new_nodes;
}


# _parital_execute reduces constant subexpressions to a minimal form.
sub _partial_execute {
    my ($expr, $ast) = @_;
    if (ref $ast){
        my @nodes = @$ast;
        my $type = shift @nodes;
        if ($type eq '=' || $type eq '$'){
            # XXX what to do about assignments? more thoughts needed
            return $ast;
        }
        my @new_nodes = ($type);
        my $tainted = 0;
        for my $n (@nodes){
            push @new_nodes, _optimize($expr, $n);
            if (ref $new_nodes[-1]){
                $tainted = 1;
            }
        }
        if ($tainted){
            # try to optimize things like '2 + a +3' into 'a + 5'
            # is only allowed for commutative ops
            if ($is_commutative{$type}){
#                print STDERR "Trying commutative optimization\n";
                my @untainted = ($type);
                my @tainted = ($type);
                for (1..$#new_nodes) {
                    if (ref $new_nodes[$_]){
                        push @tainted, $new_nodes[$_];
                    } else {
                        push @untainted, $new_nodes[$_];
                    }
                }

                if (@untainted > 2) {
                    # there is something to optimize
                    push @tainted, $expr->_execute(\@untainted);
                    return \@tainted;
                } else {
                    # 'twas all in vain
                    return \@new_nodes;
                }
            } else {
                return \@new_nodes;
            }
        } else {
            return $expr->_execute(\@new_nodes);
        }
    } else {
        return $ast;
    }

}

1;

# vim: sw=4 ts=4 expandtab
