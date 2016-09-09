package Math::Expression::Evaluator::Util;

=head1 NAME

Math::Expression::Evaluator::Util - Common functions for 
Math::Expression::Evaluator

=head1 SYNPOSIS

    use Math::Expression::Evaluator::Util qw(is_lvalue);

    # ...
    if (is_lvalue($ast)){
        # $ast represents an lvalue, at the moment just a variable
    }

=head1 DESCRIPTION

This is package with common functions used in the different modules in 
the Math::Expression::Evaluator distribution.

=over

=item is_lvalue

C<is_lvalue($ast)> checks if (a simplified version of) C<$ast> represents 
something that can be assigned to, i.e. is a variable.

=back

=cut

use strict;
use warnings;

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(is_lvalue);

# checks if the given AST represents a lvalue of an _assignment
sub is_lvalue {
    my $ast = shift;
    if (ref($ast) && $ast->[0] eq '$'){
        # simple variable name
        return 1;
    } else {
        return 0;
    }
}

1;
# vim: sw=4 ts=4 expandtab
