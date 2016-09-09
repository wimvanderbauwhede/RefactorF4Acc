package Math::Expression::Evaluator::Lexer;
use warnings;
use strict;
use Carp qw(confess);
use Data::Dumper;

=head1 NAME

Math::Expression::Evaluator::Lexer - Simple Lexer

=head1 SYNOPSIS

    use Math::Expression::Evaluator::Lexer qw(lex);
    # suppose you want to parse simple math expressions
    my @input_tokens = (
        ['Int',             qr/[+-]?\d+/ ],
        ['Op',              qr{[+-/*]}   ],
        ['Brace_Open',      qr/\(/       ],
        ['Brace_Close',     qr/\)/       ],
        ['Whitespace',      qr/\s+/, sub { return; }],
         );
    my $text = "-12 * (3+4)";
    my $out_tokens = lex($text, \@input_tokens);
    for (@$out_tokens){
        my ($name, $text, $pos) = @$_;
        print "Found Token $name: $text (string pos: $pos)\n";
    }

=head1 DESCRIPTION

Math::Expression::Evaluator::Lexer is a simple lexer that breaks up a text 
into tokens, depending on the input tokens you provide

=head1 METHODS

=over 2

=item lex

The only exported routine is lex, which expects input text as its 
first argument and a array ref to list of input tokens.

Each input token consists of a token name (which you can choose freely), 
a regex which matches the desired token, and optionally a reference to 
a functions that takes the matched token text as its argument. The 
token text is replaced by the return value of that function. If the 
function returns undef, that token will not be included in the list 
of output tokens. The regex should either fail or match at least one
character; zero-width matches utterly confuse the lexer, and are disallowed.

lex() returns an array ref to a list of output tokens, each output 
token is a reference to a list which contains the token name, the matched 
text, the string position (in characters, counted from the start of
the input string, zero based) and the line number.

Note that C<lex()> puts parentheses around the entire regex, so if you 
want to use backreferences, the numbering of the capturing group is changed.

=back

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2007 by Moritz Lenz, L<http://moritz.faui2k3.org>, 
L<moritz@faui2k3.org>.

This Program and its Documentation is free software. You may distribute it 
under the same terms as perl itself.

However all code examples are to be public domain, so you can use it in any 
way you want to.

=cut

require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw(lex);

our %EXPORT_TAGS = (":all" => \@EXPORT_OK);

sub lex {
    my ($text, $tokens) = @_;
    confess("passed undefined value to lex()") unless defined $text;
    my $l = length $text;
    return [] unless $l;

    my ($last_line_number, $last_pos) = (0, 0);
    my $pos_and_line_number = sub {
        my $pos = shift;
        $last_line_number +=
            (substr($text, $last_pos, $pos - $last_pos) =~ tr/\n//);
        $last_pos = $pos;
        return ($pos, $last_line_number + 1);
    };

    my @res;

    # avoid 'Use of uninitialized value in numeric lt (<)' warnings:
    pos($text) = 0;

    while (pos($text) < $l){
        my $matched = 0;
REGEXES:
        for (@$tokens){
            my $re = $_->[1];
            # failed regex matches reset pos() unless the /c modifier
            # is present
            if ($text =~ m/\G($re)/gc){
                $matched = 1;
                my $match = $1;
                if (length $match == 0){
                    confess("Each token has to require at least one "
                            . "character; Rule $_->[0] matched Zero!\n");
                }

                # safe information before callbacks can modify $match
                # and thus length($match)
                my $pos = pos($text) - length($match);

                if ($_->[2]){
                    $match = $_->[2]->($match);
                }
                if (defined $match){
                    push @res, [
                        $_->[0],
                        $match,
                        $pos_and_line_number->($pos),
                    ];
                }
                next REGEXES;
            }
        }
        if ($matched == 0){
            confess("No token matched input text <$text> at position " . pos($text));
        }
    }
    return \@res;
}

1;

# vim: sw=4 ts=4 expandtab
