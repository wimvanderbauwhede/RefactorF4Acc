#!/usr/bin/env perl
use v5.28;
use Data::Dumper;


# 1            2           3                4        5           0
# read_scalar, read_array, read_paren_expr, read_op, append_ast, do_nothing
#

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

#                 0    1    2    3    4    5    6    7    8     9   10   11   12   13   14
#our  @sigils = ( '{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//',')(');

our $nodeId=0;
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
        say $state;
                say $str;
                say Dumper(@ast);
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }
        if ($state==0 or $state==5) {
            #            say "parse terms in $str";
            if ($str=~s/^(\w+)\s*\(//) {
                # array access
                my $var=$1;
                ($arg_expr_ast,$str, my $err)=parse_expression($str);
                if($err) {return ($arg_expr_ast,$str, my $err);}
                #die 'BOOM:'.Dumper($arg_expr_ast);
                #$expr_ast=[1+(++$nodeId)<<4,$var,$arg_expr_ast];
                $expr_ast=[$var,$arg_expr_ast];
            }
            elsif ($str=~s/^\(//) {
                # paren expr
                ($expr_ast,$str, my $err)=parse_expression($str);
                if($err) {return ($expr_ast,$str, my $err);}
            }
            elsif ( $str=~s/^(\w+)// ) {
                #variable
                #$expr_ast=[2+(++$nodeId)<<4,$1];
                $expr_ast=$1;
            }
            elsif ($str=~s/^([\+\-]?\d+)//) {
                #integers
                $expr_ast=$1;
            }
            elsif ($str=~s/^([\-\-]?(?:\d+|\d*\.\d*)(?:[edq][\-\+]?\d+)?)$//) {
                #reals
                $expr_ast=$1;
            }
            #            say "parsed term $expr_ast, rest: $str";
            else {          
                # Here we return with an error value
                return ($expr_ast, $str, 1);
            }
            $state=4;
        }
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }
        if (length($str)==0) {
            last;
        }
        if ($state==4) {
            if ($str=~s/^,//) {
                # This is the same as end of str, except we need to keep parsing afterwards
                # So we do the same as in that case
                if ( not defined $ast[$lev]) {
                    $ast[$lev] = $expr_ast;
                } else {
                    push @{$ast[$lev]}, $expr_ast;
                }
                # Now determine the highest level; fold the lower levels into it
                if( scalar @ast == 1) {
                    push @{$arg_expr_ast},$ast[0];
                } else {
                    my $max_lev=11;
                    for my $tlev (1 .. $max_lev) {
                        if (not defined $ast[$tlev+1]) {
                            $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                        } else {
                            push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                        }
                    }
                    push @{$arg_expr_ast},$ast[$max_lev+1];
                }
                @ast=();
                $state=0;
            }
            elsif ($str=~s/^\)//) {
            # Again this is like falling off the end of the string
            # if  @{$arg_expr_ast} is not empty, then this must become the ast to return
                if ( @{$arg_expr_ast} ) {
                    if ( not defined $ast[$lev]) {
                        $ast[$lev] = $expr_ast;
                    } else {
                        push @{$ast[$lev]}, $expr_ast;
                    }
                    # Now determine the highest level; fold the lower levels into it
                    if( scalar @ast == 1) {
                        push @{$arg_expr_ast},$ast[0];
                    } else {
                        my $max_lev=11;
                        for my $tlev (1 .. $max_lev) {
                            if (not defined $ast[$tlev+1]) {
                                $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                            } else {
                                push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                            }
                        }
                        push @{$arg_expr_ast},$ast[$max_lev+1];
                    }
                    # Now we should return this as the ast
                    return ($arg_expr_ast,$str,0);
                }
            # afer appending the final value
            # otherwise it is quite the same as the end of the string
                else {
                    last;
                }
        } 
        else { 

           $prev_lev=$lev;
            if ($str=~s/^\+//) {
                $lev=4;
                $op='+';
                #$op=3+(++$nodeId)<<4;
            }
            elsif ($str=~s/^\-//) {
                $lev=4;
                $op='-';
                #$op=4+(++$nodeId)<<4;
            }
            elsif ($str=~s/^\*//) {
                $lev=3;
                $op='*';
                #$op=5+(++$nodeId)<<4;
            }
            elsif ($str=~s/^\///) {
                $lev=3;
                $op='/';
                #$op=6+(++$nodeId)<<4;
            }
            #            say "parsed $op, rest: $str";
                        
            $state=5;
        }
    }
    #'%', '**', ':' ,'//'
    # < > <= >= == this a lower level than + - 
    # same for && || but do we have this
    # same for << >>
    # What's missing is that we need to append the higher level to the lower level
    # And we need $prev_lev for this
    if ($state==5 ) {
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
    #say Dumper($expr_ast);
    if ( not defined $ast[$lev]) {
        $ast[$lev] = $expr_ast;
    } else {
        push @{$ast[$lev]}, $expr_ast;
     }
     #            say 'ASTs:',Dumper(@ast);
    #    say '=' x 80;
    
    # Now determine the highest level; fold the lower levels into it
    if( scalar @ast == 1) {
        return ($ast[0],$str,0);
    } else {
    my $max_lev=11;
    for my $tlev (1 .. $max_lev) {
        if (not defined $ast[$tlev+1]) {
            $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
        } else {
            push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
        }
    }
    #say 'ASTs:',Dumper(@ast);
    return ($ast[$max_lev+1],$str,0);
    }
} # END of parse_expression

sub interpret { (my $ast)=@_;
    (my $op, my $lexp, my $rexp) =@{$ast};
    my $lv = (ref($lexp) eq 'ARRAY') ? interpret($lexp) : $lexp;
    my $rv = (ref($rexp) eq 'ARRAY') ? interpret($rexp) : $rexp;
    return eval("$lv $op $rv");
} # END of interpret



for my $str ('z(j+i,k*km)*p(i+1,j+jm)','i+1','v( i + 1 )','z','z(j,k)','j+k','i-im') {
say "TEST: $str";
(my $ast, my $rest, my $err) = parse_expression($str);#*p(i+1,j+jm)');
if ($err) {say 'ERROR' } else {
say "AST: ".Dumper($ast);
}
}
#die;
for my $str ("5+42+ +6/42/44-45*7", '6*7', '44 - -2', '(1+2*3)+3+4/5','4+(22*(33*44+1)+77)/2') {
(my $ast, my $rest) = parse_expression($str);
#say Dumper($ast);
say eval($str);
say interpret($ast);
}


for my $str ('*8','RANK ( N, *8, *9 )') {
say "TEST: $str";
(my $ast, my $rest) = parse_expression($str);#*p(i+1,j+jm)');
say "AST: ".Dumper($ast);
}

