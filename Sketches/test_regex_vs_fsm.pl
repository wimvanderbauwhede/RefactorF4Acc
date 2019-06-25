#!/usr/bin/env perl
use v5.28;
use Data::Dumper;

=info
We have vars and arrays, which are vars with comma-sep args.
read_var
store_var
read_args
store_args
read_store_op
read_paren_group

We need a memory: a paren group is only args if it was preceded by a var.

So, we start with two possibilities:
 
'(' or [a-z]

if '(' then eventually ')' else either '(' for arg list or $op 
if arg_list then expr_parser, ','
if $op then we need to have the binding strenght. In this parser we'll only have * or / and + or -

So what is the difference
5+a*b+c*d/e

5
+ => prev is 0, i.e. no prev => [+ 5]
if ($prev_lev==0) {
    $ast[$lev]=[$op,$ast_expr];
}
a => keep going
*3 => prev is +4, so create [* a]
b => keep going
+4 => [* a b] => prev was *3; but this is now + ast, so 
add *3 ast to +4 ast
[+ 5 [* a b]]; 
if ($prev_lev<$lev) {
    push @{$ast[$prev_lev]},$expr_ast;
    push @{$ast[$lev]}, $ast[$prev_lev];
    $ast[$prev_lev]=[];

#then put the + at the front [+ [+ 5 [* a b]]] 
    $ast[$lev] = [$op, $ast[$lev]];
}
c=> keep going
*3 => prev is +4 so create [* c]
if ($prev_lev>$lev) {
    $ast[$lev]=[$op, $ast_expr];
}
d => keep going
/ => same level so [/ [* c d]]
if ($lev==$prev_lev) {
    push @{$ast[$lev]},$expr_ast;
    $ast[$lev]=[$op, $ast[$lev]];
}
e => keep going
==> falling off the end so check lev to append to
[/ [* c d] e]
=> this is l2, add to l1
[+ [+ 5 [* a b]] [/ [* c d] e]]

 

a*b+c/d => (+ (* a b) (£ c d))
a*b/c+d => (+ (/ (* a b) c) d)
a*b/c£d => (£ (/ (* a b) c) d) = ((a*b)/c)/d) 
a+b*c-d => (- (+ a (* b c)) d)

so, same level -> combine outwards, i.e. every op goes to front, every rhs goes to the back
- get a var, store it, e.g. as $ast = [ var1 ]
- test. If it's a l2op or an l1op, [op1 var1] 
- get next var,  [op1 var1 var2]
- get next op. if same level as op1 => [op2 [op1 var1 var2]]
- get next var [op2 [op1 var1 var2] var3]
- get next op. if same leve as op2 or higher -> front, else -> before var3 [op2 [op1 var1 var2] [op3 var3 var3]]

so we need $prev_op_level and $op_level


a*b/c£d
[a]
*b/c£d
[* a]
b/c£d
[ * a b]
/c£d
[/ [* a b] c]
£d
[£ [/ [* a b] c] d]

higher level -> any lower-level is nested, but also combine outwards.

a+b*c-d => (- (+ a (* b c) d)

Which means we need a stack per type of op and run until the end of the expression:

find * -> push *;push prev, push next; . find +; push; push all prev; 

What are the states?

If there are only vars and l1 and l2 ops

read_var
read_l{1,2}op


=cut
=info_exp
#my $str='Which means we need a stack per type of op and run until the end of the expression';
my $str ='Which*means*we + need + a *stack / per - type - of * op * and +run + until';# the end of the expression:

my @chrs = split('',$str);

my @words=();
# The regex version is 5.5s, the other version 8.5s. 
# Not having the if/then saves 0.3s
# 8.6/11.4 on battery
# Testing !~/^\s/ and =~/^\w/ are about the same speed
my $ver=0;
for (1..100000000) {
    if ($ver==1) {
        my $word='';
        while (@chrs) {
            my $chr=  shift @chrs;
            if ($chr ne ' ') {
                $word.=$chr;
            } else {
                push @words, $word;
                $word='';
            }
        }
    } else {
        my $ast=[];
        while(length( $str ) > 0) {
            if ($str=~/^\w/) {
                $str=~s/^(\w+)//;
                push @words, $1;
            } elsif ($str=~/^\*/ || $str=~/^\//) {
                my $w = pop @words;
                $ast = [$1,$w]
            } elsif ($str=~/^\+/ || $str=~/\-/) {

            } elsif ($str=~/^\s/) {
                $str=~s/^\s+//;    
            } else {
                say "Unknown character: $str";
                last;
            }
        }
    }
}

=cut
# state is not quite right
# either we are reading a term or we have to read an operator
# so the states could be read_term, read_op, append 
# but there could also be some additional state to handle the comma and closing paren?
# I guess this would be that we have 
#
# 1            2           3                4        5           0
# read_scalar, read_array, read_paren_expr, read_op, append_ast, do_nothing
#
#
# need to do the lev to prev_lev comparison
# The levels are precedence levels.
# Maybe it makes sense to set this to 0 for the terms
# precedence levels
# 0 scalars
# 1 **
# 2 UNARY + -
# 3 * /
# 4 + -
# 5 

=info_operator_precedence
Level
    Scalars
0
    Arithmetic
1        right       ** NOTE F ** S ** Z means F ** (S ** Z)
2        right       unary + and - NOTE X ** -A * Z means X ** (-(A * Z))
3        left        * / 
4        left        + - 
    Character
5        left         //
    Relational
6        nonassoc    < > <= >= .lt. .gt. .le. .ge.
7        nonassoc    == != .eq. .ne. 
    Logical
8        right       .not.
9        left        .and. 
10        left        .or. 
11        left        .xor. .eqv. .neqv.
=cut 

sub parse_expression {(my $str)=@_;
    my $max_lev=0;
    my $prev_lev=0;
    my $lev=0;
    # Let's try an array first
    my @ast=();
    my $op;
    my $state=0;

    my $expr_ast=[];
    my $arg_expr_ast=[];

    while (length($str)>0) {

        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }
        if ($state==0 or $state==5) {
            #            say "parse terms in $str";
            if ($str=~s/^(\w+)\(//) {
                # array access
                $expr_ast=[$1,[]];
                say $str;
                ($arg_expr_ast,$str)=parse_expression($str);
                #   say Dumper($arg_expr_ast);die;
                $state=2;
            }
            elsif ($str=~s/^\(//) {
                # paren expr
                ($expr_ast,$str)=parse_expression($str);
                $state=3;
            }
            elsif ( $str=~s/^(\w+)// ) {
                #variable
                $expr_ast=$1;
                $state=4;
            }
            elsif ($str=~s/^(\-?\d+)//) {
                #integers
                $expr_ast=$1;
                $state=4;
            }
            #elsif ($str=~s/^(...)//) {
            #    #reals
            #$expr_ast=$1;
            #    $state=1;
            #}
            #            say "parsed term $expr_ast, rest: $str";
            else {          
                return ($expr_ast, $str);
            }
        } 
        if ($state==2 and $str=~s/^,//) {
            push @{$expr_ast->[1]},$arg_expr_ast;
            die $str;
            $state=2;
        }
        elsif (($state==2 or $state==3) and $str=~s/^\)//) {
            #close paren
            push @{$expr_ast->[1]},$arg_expr_ast;
            #say Dumper($expr_ast, $lev);
            $state=4;
        } 
        
        if (length($str)==0) {last;}

        if ($state==4) {
           $prev_lev=$lev;
            if ($str=~s/^\+//) {
                $lev=4;
                $op='+';
            }
            elsif ($str=~s/^\-//) {
                $lev=4;
                $op='-';
            }
            elsif ($str=~s/^\*//) {
                $lev=3;
                $op='*';
            }
            elsif ($str=~s/^\///) {
                $lev=3;
                $op='/';
            }
            #            say "parsed $op, rest: $str";
            $state=5;
        }
        #'%', '**', ':' ,'//'
        # < > <= >= == this a lower level than + - 
        # same for && || but do we have this
        # same for << >>
        # What's missing is that we need to append the higher level to the lower level
        # And we need $prev_lev for this
        if ($state==5) {
            #            say "append '$expr_ast' to ast level $lev ";
            #append
            #            say "$prev_lev <> $lev";
            if ($prev_lev==0) { # start
                $ast[$lev]=[$op,$expr_ast];
            } elsif ($prev_lev<$lev) { # '*' < '+'
                push @{$ast[$prev_lev]},$expr_ast;
                if (not defined $ast[$lev]) {
                    $ast[$lev]=$ast[$prev_lev];
                } else {
                    push @{$ast[$lev]}, $ast[$prev_lev];
                }
                $ast[$prev_lev]=[];
                $ast[$lev] = [$op, $ast[$lev]];
            } elsif ($prev_lev>$lev) {
                $ast[$lev]=[$op, $expr_ast];
            } elsif ($lev==$prev_lev) {
                push @{$ast[$lev]},$expr_ast;
                $ast[$lev]=[$op, $ast[$lev]];
            }
            $state=0;
            #            say "\n next iter \n";
        }
    } # while

    # So when we fall off the end of the string we need to clean up
    # The main thing is that there is a $expr_ast pending
    # This has to be added to the last ast we were working on, which means
    push @{$ast[$lev]}, $expr_ast;
        say 'ASTs:',Dumper(@ast);
    #    say '=' x 80;
    
    # Now determine the highest level; fold the lower levels into it
    my $max_lev=3;
    for my $tlev (1 .. $max_lev) {
        if (not defined $ast[$tlev+1]) {
            $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
        } else {
            push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
        }
    }
    
    return ($ast[$max_lev+1],$str);
}

(my $ast, my $rest) = parse_expression('z(j,k)+1');#*p(i+1,j+jm)');
say Dumper($ast);
die;
for my $str ("5+42+6/42/44-45*7", '6*7', '44-2', '1+2+3+4/5','22*33*44+1') {
(my $ast, my $rest) = parse_expression($str);
#say Dumper($ast);
say eval($str);
say interpret($ast);
}
sub interpret { (my $ast)=@_;
    (my $op, my $lexp, my $rexp) =@{$ast};
    my $lv = (ref($lexp) eq 'ARRAY') ? interpret($lexp) : $lexp;
    my $rv = (ref($rexp) eq 'ARRAY') ? interpret($rexp) : $rexp;
    return eval("$lv $op $rv");
}
