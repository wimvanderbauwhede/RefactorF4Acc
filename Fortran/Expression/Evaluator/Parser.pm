package Fortran::Expression::Evaluator::Parser;

=head1 NAME

Fortran::Expression::Evaluator::Parser - Parse mathematical expressions

=head1 SYNOPSIS

    use Fortran::Expression::Evaluator::Parser;
    my $exp = '2 + a * 4';
    my $ast = Fortran::Expression::Evaluator::Parser::parse($exp, {});
    # $ast is now something like this:
    # $ast = ['+',
    #          2,
    #         ['*',
    #          ['$', 'a'],
    #          4
    #         ]
    #        ];

=head1 DESCRIPTION

This module parses a mathematical expression in usual notation, and
turns it into an Abstract Syntax Tree (AST).

If you want to have a simple interface and want to evaluate these
ASTs, use L<Fortran::Expression::Evaluator>.

The following description of the AST structure matches the current
implementation, but really is an implementation detail that's subject to
change without further notice. In particular a possible addition of meta
information (like file and line numbers) might require a change of structure.

The AST is a tree that consists of nested array refs. The first item
is a string (until now always a single character), and denotes the type
of the node. The rest of the items in the array is a list of its arguments.

For the mathematical symbols C<+>, C<->, C<*>, C</>, C<^> (exponentation)
this is straight forward, but C</> and C<-> are always treated as prefix ops,
so the string '2 - 3' is actually turned into C<['+', 2, ['-', 3]]>.

Other AST nodes are

=over 4

=item '$'

C<['$', $var_name]> represents a variable.

=item '{'

C<['{', $expr1, $expr2, ... ]> represents a block, i.e. a list of expressions.

=item '='

C<['=', $var, $expr]> represents an assignment, where C<$expr> is assigned
to C<$var>.

=item '&'

C<['&', $name, @args]> is a function toll to the function called C<$name>.

=back

=head1 METHODS

=over

=item parse

C<parse> takes a string and a hash ref, where the hash ref takes
configuration parameters. Currently the only allowed option is
C<force_semicolon>. If set to a true value, it forces statements to
be forced by semicolons (so C<2 3> will be forbidden, C<2; 3> is still
allowed).

C<parse> throws an exception on parse errors.

=back

=cut

use strict;
use warnings;

use Fortran::Expression::Evaluator::Lexer qw(lex);
use Fortran::Expression::Evaluator::Util qw(is_lvalue);
use Carp qw(confess);
use Data::Dumper;


my @input_tokens = (
        ['ExpOp'            => '\^|\*\*'],
        ['MulOp'            =>  qr{[*/%]}],
        ['AddOp'            => '\+|-'],
# This regex is 'stolen' from Regexp::Common, and a bit simplified
# Copyright by Damian Conway and Abigail, 2001-2005
        ['Float'            => "[+-]?(?=[0-9]|[.])[0-9]*(?:[.][0-9]*)?(?:[eEdDqQ](?:[+-]?[0-9]+)|)"],
        ['OpenParen'        => '\('],
        ['ClosingParen'     => '\)'],
        ['Colon'            => ';'],
        ['Comma'            => ','],
        ['AssignmentOp'     => '='],
        ['Name'             => '[a-zA-Z_][a-zA-Z_0-9]*'],
        ['Whitespace'       => '\s+', sub {return undef}],
        ['Comment'          => qr/\#.*?$/, sub {return undef}],
);

my %token_description = (
        ExpOp           => 'Operator',
        MulOp           => 'Operator',
        AddOp           => 'Operator',
        AssignmentOp    => 'Operator',
        Float           => 'Term',
        Name            => 'Term',
);

sub parse {

    my ($text, $parse_opts) = @_;

    # note that this object is only used internally, to the
    # world outside we hide it.
    my $self = bless {};
    $self->{config}         = $parse_opts;
    $self->{tokens}         = lex($text, \@input_tokens);
    $self->{token_pointer}  = 0;
    return $self->_program();

}

# checks if the next token is what you expected, for example
# _is_next_token("AddOp") checks if the next token is a '+' or '-'
sub _is_next_token {
    my $self = shift;
    my $cmp = shift;
    my $next = $self->{tokens}[$self->{token_pointer}];
    if (defined $next && $next->[0] eq $cmp){
        return $next->[1];
    }
}

# basically the same _is_next_token, but does an arbitrary number of lookahead
# steps.
sub _lookahead {
    my $self = shift;
    my $i = 0;
    while (my $v = shift){
        return undef unless($self->{tokens}[$self->{token_pointer}+$i]);
        my $ref = $self->{tokens}[$self->{token_pointer} + $i]->[0];
        return undef unless($ref eq $v);
        $i++;
    }
    return 1;
}

# move the token pointer one step further.
sub _proceed {
    my $self = shift;
    $self->{token_pointer}++;
}

# returns the next not-yet-parsed token
sub _next_token {
    return $_[0]->{tokens}[$_[0]->{token_pointer}];
}

# program -> statement*
# parse a program, e.g. a collection of statements.
# The corrsponding AST looks like this: ['{', $s1, $s2, $s3, ... ]
sub _program {
    my $self = shift;
    my @res = ('{');
    while (defined $self->_next_token()){
        push @res, $self->_statement();
    }
    return _return_simplify(@res);
}

# generates an error message that something was expected but not found,
# for example 'a + +' would warn that a value was expected, but an AddOp
# was found.
sub _expected {
    my $self = shift;
    if (scalar @_ > 1){
        confess("Parse error: Expected $_[0]; got: '$_[1]'\n"
                . "near character " . $self->_next_token->[2] . "\n");
    } else {
        confess("Parse error: Expected $_[0]\n"
                . "near character " . $self->_next_token->[2] . "\n");
    }
}

# matches a specific token, and returns its text if successfull. Dies if
# unsuccessfull.
sub _match {
    my $self = shift;
    my $m = shift;
    my $val;
    my $next = $self->_next_token();
    confess("Expected $m, got EOF") unless ref $next;
    if ($next->[0] eq $m){
        $val = $self->_next_token()->[1];
        $self->_proceed();
        return $val;
    } else {
        $self->_expected($m, $self->_next_token()->[0]);
    }
}

# <value> -> <float> | <name> | <function_call>
# parses a single value: a float, a function call or a variable name
# returns the corresponding AST.
sub _value {
    my $self = shift;
    if ($self->_lookahead("Name", "OpenParen")){
        return $self->_function_call();
    } elsif ($self->_is_next_token("Name")){
        return $self->_get_variable();
    } elsif ($self->_lookahead(qw/AddOp Float/)) {
        my $sign = $self->_match('AddOp');
        return ("$sign".1) * $self->_match('Float');
    } else {
        return $self->_match("Float");
    }
}

# <function_call> -> <name> '(' [<expression> [',' <expression>]* ]? ')'
# parses a function call, the AST looks like this: ['&', $name, @args]
sub _function_call {
    my $self = shift;
    my @res = ('&', $self->_match("Name"));
    $self->_match("OpenParen");
    if ($self->_is_next_token("ClosingParen")){
        $self->_proceed();
        return \@res;
    }
    push @res, $self->_expression();
    while ($self->_is_next_token("Comma")){
        $self->_proceed();
        last if $self->_is_next_token('ClosingParen');
        push @res, $self->_expression();
    }
    $self->_match("ClosingParen");
    return \@res;
}

# <name> -> m/[a-zA-Z_]\w*/
# parses a variable name, and returns it
sub _get_variable {
    my $self = shift;
    my $var_name = $self->_match("Name");
    return ['$', $var_name];
}

# <statement> -> <_assignment> | <expression>
# parses a statement, eg an _assignment or an expression.
sub _statement {
    my $self = shift;
    my $e = $self->_expression();
    if ($self->_is_next_token("AssignmentOp")){
        $e = $self->_assignment($e);
    }

    if ($self->{config}->{force_semicolon}){
# forced semicolon between two statements (but the last statement
# isn't forced to have one):
        if ($self->_next_token()){
            $self->_match("Colon");
        }
    } else {
# optional semicolon at end of statement
        if ($self->_is_next_token("Colon")){
            $self->_proceed();
        }
    }
    return $e;
}

# <_assignment> ::= <lvalue> '=' <expression>
# expects the lvalue as first argument
sub _assignment {
    my $self = shift;
    my $e = shift;
    $self->_match("AssignmentOp");
    my $val = $self->_expression();
    if (is_lvalue($e)){
        return ['=', $e, $val];
    } else {
        confess("Not an lvalue in _assignment");
    }
}


# <term> ::= <exponential> [('*'|'/') <exponential>]*
# the AST is a bit weird, a simple product is expressed as
# ['*', $v1, $v2, ... ]
# a division is a bit more complex:
# a / b / c becomes ['*', a, ['/', b], ['/', c]]
sub _term {
    my $self = shift;
    my $val = $self->_exponential();
    my @res = ('*', $val);
    while (my $op = $self->_is_next_token("MulOp")){
        if ($op eq '*'){
            $self->_proceed();
            push @res, $self->_exponential();
        } elsif ($op eq '/'){
            $self->_proceed();
            push @res, ['/',  $self->_exponential()];
        } elsif ($op eq '%') {
            $self->_proceed();
            # XXX not very efficient
            @res = ('*', ['%', [@res], $self->_exponential()]);
        } else {
            die "Don't know how to handle MulOp $op\n";
        }
    }
    return _return_simplify(@res);
}

# <expression> ::= ['+'|'-']? <term> [('+'|'-') term]*
sub _expression {
    my $self = shift;
#   print STDERR "expression...\n";
    my @res = ('+');
    if (my $op = $self->_is_next_token("AddOp")){
        # unary +/-
        $self->_proceed();
        if ($op eq '+'){
            push @res, $self->_term();
        } else {
            push @res, ['-', $self->_term()];
        }
    } else {
        push @res, $self->_term();
    }
    while (my $op = $self->_is_next_token("AddOp")){
        if ($op eq '+'){
            $self->_proceed();
            push @res, $self->_term();
        } else {
            # a '-'
            $self->_proceed();
            push @res, ['-', $self->_term()];
        }
    }
    return _return_simplify(@res);
}

# <factor> ::= <value> | '(' <expression> ')'
sub _factor {
    my $self = shift;
    my $val;
    if ($self->_is_next_token("OpenParen")){
        $self->_match("OpenParen");
        $val = $self->_expression();
        $self->_match("ClosingParen");
    } else {
        $val = $self->_value();
    }
    return $val;
}

# <exponential> ::= <factor> [ '^' <factor>]?
# note that 2^3^4 is not defined, ie ^ is not associative
sub _exponential {
    my $self = shift;
    my $val = $self->_factor();
    if ($self->_is_next_token("ExpOp")){
        $self->_match("ExpOp");
        return ['^', $val, $self->_factor()];
    } else {
        return $val;
    }
}

sub _return_simplify {
    return $_[1] if @_ == 2;
    return \@_;
}


1;
# vim: sw=4 ts=4 expandtab
