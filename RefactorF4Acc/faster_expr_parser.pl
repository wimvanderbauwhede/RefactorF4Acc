#!/usr/bin/env perl
use v5.28;
use Data::Dumper;
use RefactorF4Acc::Parser::Expressions qw( parse_expression_faster interpret emit_expr_from_ast );
#our $nodeId=0;
##               0    1    2    3    4    5    6    7    8     9    10   11   12   13   14
#our @sigils = ('{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//',')('
##                15   16   17  18  19   20    21      22      23     24      25      26      
#               ,'==','!=','<','>','<=','>=','.not.','.and.','.or.','.xor.','.eqv.','.neqv.'
##                27        28     29        30        31
#               ,'integer','real','logical','character', ','
#              );


# States
# 1            2           3                4        5           0           6             7                     8
# read_scalar, read_array, read_paren_expr, read_op, append_ast, do_nothing, handle_comma, handle_closing_paren, handle_not
#

# As we are not using the nodeId I will not waste cycles on it
# Sadly I need a lot more bits than originally so either I do not mask at all or use 0xFF and make sure the shift is <<8
#if (0) {
#sub parse_expression_faster {(my $str)=@_;
#    my $max_lev=11; # levels of precedence
#    my $prev_lev=0;
#    my $lev=0;
#    # Let's try an array first
#    my @ast=();
#    my $op;
#    my $state=0;
#
#    my $expr_ast=[];
#    my $arg_expr_ast=[];
#
#    while (length($str)>0) {
#        if ($str=~/^\s/) {
#            $str=~s/^\s+//;
#        }
#        if ($state==0 or $state==8) {
#            $state+=4; # I guess this is cheaper than doing unless $state==8;
#            # FIXME: handle prefix - 
#            if ($str=~s/^([a-zA-Z_]\w*)\s*\(//) {
#                # array access or function call
#                my $var=$1;
#                if ($str!~/^\s*\)/) {
#                (my $arg_expr_ast,$str, my $err)=parse_expression_faster($str);
#                if( ref($arg_expr_ast) ne 'ARRAY') {
#                    $arg_expr_ast=[$arg_expr_ast];
#                };
#                } else {
#                    $arg_expr_ast=[];
#                }
##                $expr_ast=['&',$var,$arg_expr_ast];
#                $expr_ast=[1,$var,$arg_expr_ast];
#                if ($str=~/^\(/) {
#                    (my $arg_expr_ast2,$str, my $err2)=parse_expression_faster($str);
#                    $expr_ast=[1, $var,[14,$arg_expr_ast,$arg_expr_ast2->[1]]];
#                    #$expr_ast=['&',$var,[')(',$arg_expr_ast,$arg_expr_ast2->[1]]];
#                }
#
#            }
#            elsif ($str=~s/^\(//) {
#                # paren expr, I use '{' as it appears not to be used.      
#                ($expr_ast,$str, my $err)=parse_expression_faster($str);
#                #$expr_ast=['{',$expr_ast];
#                $expr_ast=[0,$expr_ast];
#                if($err) {return ($expr_ast,$str, my $err);}
#            }
#            elsif ($str=~s/^\-\(//) {
#                # paren expr, I use '{' as it appears not to be used.      
#                # FIXME: a prefix - will break this          
#                ($expr_ast,$str, my $err)=parse_expression_faster($str);
#                #$expr_ast=['{',$expr_ast];
#                $expr_ast=[4,[0,$expr_ast]];
#                if($err) {return ($expr_ast,$str, my $err);}
#            }            
#            # Apparently Fortran allows '$' as a charater in a variable name but I think I'll ignore that.
#            # I allow _ as starting character because of the placeholders
#            elsif ( $str=~s/^([a-zA-Z_]\w*)// ) {
#                #variable
#                $expr_ast=[2,$1];
#                #$expr_ast=['$',$1];
#            }
#            # Exec decision: I don't handle prefix +
#            elsif ( $str=~s/^\-([a-zA-Z_]\w*)// ) {
#                #variable
#                $expr_ast=[4,[2,$1]];
#                #$expr_ast=['$',$1];
#            }            
#            elsif ($str=~s/^([\-\+]?(?:\d*\.\d*|\d+)(?:[edq][\-\+]?\d+)?)//) {
##                say "REAL: $1";
#                #reals
#                $expr_ast=[28,$1];
#                #$expr_ast=$1;
#            }
#            elsif ($str=~s/^([\+\-\*]?\d+)//) {
#                #integers
#                # The '*' is for "alternate returns", a bizarre F77 feature. 
#                # I've just added it because it is free
#                $expr_ast=[27,$1];
#                #$expr_ast=$1;#['integer',$1];
#            }
#            elsif ( $str=~s/^\.(true|false)\.// ) {
#                #boolean constant
#                $expr_ast=[29,'.'.$1.'.'];
#                #$expr_ast='.'.$1.'.';
#            }
#            elsif ( $str=~s/^\.not\.\s*// ) {
#                # logical not
#                # This is just to skip everything and have a second round of term matching
#                $state=8;
#            }
#            # Maybe I should handle string constants as well
#            # Although we use placeholders so they should not occur
#            elsif ( $str=~s/^\'(.+?)\'// ) {
#                #boolean constant
#                $expr_ast=[30,"'".$1."'"];
#                #$expr_ast="'".$1."'";
#            }
#            #            say "parsed term $expr_ast, rest: $str";
#            else {          
#                # Here we return with an error value
#                return ($expr_ast, $str, 1);
#            }
#            if ($state==12) {
#                 $expr_ast=[21,$expr_ast];
#                 #$expr_ast=['.not.',$expr_ast];
#                 $state=4;
#            }
#            
#        }
#        if ($str=~/^\s/) {
#            $str=~s/^\s+//;
#        }
#        if (length($str)==0) {
#            last;
#        }
#        if ($state==4) {
#            #say "STATE:4";
#            if ($str=~s/^,//) { # comma
#                # just set a state here
#                $state=6;
#
#            }
#            elsif ($str=~s/^\)//) { # closing paren
#            # Again this is like falling off the end of the string
#            # if  @{$arg_expr_ast} is not empty, then this must become the ast to return
#            # after appending the final value
#                if ( @{$arg_expr_ast} ) {
#                # Just set a state here
#                     $state=7;
#                }
#            # otherwise it is quite the same as the end of the string
#                else {
#                    last;
#                }
#        } 
#        else { 
#=info_operator_precedence
#Level
#    Scalars
#0
#    Arithmetic
#1        right       ** NOTE F ** S ** Z means F ** (S ** Z)
#2        right       unary + and - NOTE X ** -A * Z means X ** (-(A * Z)) => Handled in state=0
#3        left        * / 
#4        left        + - 
#    Character
#5        left         //
#         left         :   NOTE I put this here, main purpose is array dims but it also works for substring ranges
#    Relational
#6        nonassoc    < > <= >= .lt. .gt. .le. .ge.
#7        nonassoc    == != .eq. .ne. 
#    Logical
#8        right       .not.
#9        left        .and. 
#10        left        .or. 
#11        left        .xor. .eqv. .neqv.
#
#So it looks like I need at least 6 bits, so we'll need <<8 and 0xFF
#                 0    1    2    3    4    5    6    7    8     9    10   11   12   13   14 
#our @sigils = ( '{', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//',')('
#                 15   16  17  18  19   20    21      22      23     24      25      26      
#               ,'==','!=',<','>','<=','>=','.not.','.and.','.or.','.xor.','.eqv.','.neqv.'
#                 27        28     29        30 
#               ,'integer','real','logical','character'
#              );
#=cut 
#            
#           $prev_lev=$lev;
#            if ($str=~s/^\+//) {
#                $lev=4;
#                #$op='+';
#                $op=3;
#            }
#            elsif ($str=~s/^\-//) {
#                $lev=4;
#                #$op='-';
#                $op=4;
#            }
#            elsif ($str=~s/^\*\*//) {
#                # We store this incorrectly left-assoc, the emitter can fix it.
#                $lev=2;
#                #$op='**';
#                $op=8;
#            } 
#            elsif ($str=~s/^\*//) {
#                $lev=3;
##                $op='*';
#                 $op=5;
#            }
#            elsif ($str=~s/^\/\///) {
#                $lev=5;
##                $op='//';
#                 $op=13;
#            } 
#            elsif ($str=~s/^://) {
#                $lev=5;
##                $op=':';
#                $op=12;
#            } 
#            elsif ($str=~s/^\///) {
#                $lev=3;
##                $op='/';
#                $op=6;
#            } 
#            elsif ($str=~s/^>=// || $str=~s/^\.ge\.//) {
#                $lev=6;
##                $op='>=';
#                $op=20;
#            } 
#            elsif ($str=~s/^<=// || $str=~s/^\.le\.//) {
#                $lev=6;
##                $op='<=';
#                $op=19;
#            } 
#            elsif ($str=~s/^<// || $str=~s/^\.lt\.//) {
#                $lev=6;
##                $op='<';
#                $op=17;
#            } 
#            elsif ($str=~s/^>// || $str=~s/^\.gt\.//) {
#                $lev=6;
##                $op='>';
#                $op=18;
#            } 
#            elsif ($str=~s/^==// || $str=~s/^\.eq\.//) {
#                $lev=7;
##                $op='==';
#                $op=15;
#            } 
#            elsif ($str=~s/^\!=// || $str=~s/^\.ne\.//) {
#                $lev=7;
##                $op='!=';
#                $op=16;
#            } 
#            elsif ($str=~s/^\.and.//) {
#                $lev=9;
##                $op='.and.';
#                $op=22;
#            } 
#            elsif ($str=~s/^\.or.//) {
#                $lev=10;
##                $op='.or.';
#                $op=23;
#            } 
#            elsif ($str=~s/^\.xor.//) {
#                $lev=11;
##                $op='.xor.';
#                $op=24;
#            } 
#            elsif ($str=~s/^\.eqv.//) {
#                $lev=11;
##                $op='.eqv.';
#                $op=25;
#            } 
#            elsif ($str=~s/^\.neqv.//) {
#                $lev=11;
##                $op='.neqv.';
#                 $op=26;
#            } 
#            $state=5;
#        }
#    }
#
#    if ($state==5 ) {
#        #append
#        if ($prev_lev==0) { # start
#            $ast[$lev]=[$op,$expr_ast];
#        } elsif ($prev_lev<$lev) { # '*' < '+'
#            push @{$ast[$prev_lev]},$expr_ast;
#            if (not defined $ast[$lev]) {
#                $ast[$lev]=$ast[$prev_lev];
#            } else {
#                push @{$ast[$lev]}, $ast[$prev_lev];
#            }
#            undef $ast[$prev_lev];#=[];
#            $ast[$lev] = [$op, $ast[$lev]];
#        } elsif ($prev_lev>$lev) {
#            $ast[$lev]=[$op, $expr_ast];
#        } elsif ($lev==$prev_lev) {
#            push @{$ast[$lev]},$expr_ast;
#            $ast[$lev]=[$op, $ast[$lev]];
#        }
#        $state=0;
#    } elsif ($state == 6 or $state==7) {
#                # This is the same as end of str, except we need to keep parsing afterwards
#                # So we do the same as in that case
#                if ( not defined $ast[$lev]) {
#                    $ast[$lev] = $expr_ast;
#                } else {
#                    push @{$ast[$lev]}, $expr_ast;
#                }
#                # Now determine the highest level; fold the lower levels into it
#                if( scalar @ast == 1) {
#                    push @{$arg_expr_ast},$ast[0];
#                } else {
#                    for my $tlev (1 .. $max_lev) {
#                        if (not defined $ast[$tlev+1]) {
#                            $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
#                        } else {
#                            push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
#                        }
#                    }
#                    push @{$arg_expr_ast},$ast[$max_lev+1];
#                }
#                if ($state==6) {
#                    @ast=();
#                    $state=0;
#                    $prev_lev=0;
#                    $lev=0;
#                } else { # state==7
#                    # Now we should return this as the ast
##                    return ([',',$arg_expr_ast],$str,0);
#                    return ([31,$arg_expr_ast],$str,0);
#                } 
#            }
#    } # while
#
#    # So when we fall off the end of the string we need to clean up
#    # The main thing is that there is a $expr_ast pending
#    # This has to be added to the last ast we were working on, which means
#    if ( not defined $ast[$lev]) {
#        $ast[$lev] = $expr_ast;
#    } else {
#        push @{$ast[$lev]}, $expr_ast;
#     }
#    
#    # Now determine the highest level; fold the lower levels into it
#    if( scalar @ast == 1) {
#        return ($ast[0],$str,0);
#    } else {
#    my $max_lev=11;
#    for my $tlev (1 .. $max_lev) {
#        if (not defined $ast[$tlev+1]) {
#            $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
#        } else {
#            push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
#        }
#    }
#    return ($ast[$max_lev+1],$str,0);
#    }
#} # END of parse_expression_faster
#
#sub interpret { (my $ast)=@_;
#    if (scalar @{$ast}==3) {
#    (my $opcode, my $lexp, my $rexp) =@{$ast};
#    my $lv = (ref($lexp) eq 'ARRAY') ? interpret($lexp) : $lexp;
#    my $rv = (ref($rexp) eq 'ARRAY') ? interpret($rexp) : $rexp;
#    my $op=$sigils[$opcode];
#    return eval("$lv $op $rv");
#} elsif (scalar @{$ast}==2) { 
#    (my $op, my $exp) =@{$ast};
#    if ($op == 0) { # {
#        my $v = (ref($exp) eq 'ARRAY') ? interpret($exp) : $exp;
#        return $v;
#    } elsif ($op == 2 or $op>26) {
#        return $exp; 
#    }
#    
#} 
#} # END of interpret
#
## What to emit?
## binops 3
## unops 2
## arrays and functions 3 
## These can have an )( inside them
## if not, emit each elt in the list and join with ',' and surround by '()'
## if ')(', do the same for each of them and join them together
## parenthesised expressions unop
## atomics: vars and constants unop and scalar, or later unop?
#sub emit_expr_from_ast { (my $ast)=@_;
##   say Dumper($ast);
#    if (ref($ast) eq 'ARRAY') {
#    if (scalar @{$ast}==3) {
#        if ($ast->[0] ==1) { # '&' array access or function call
#            (my $sigil, my $name, my $args) =@{$ast};
#            if ($args->[0] != 14 ) { # ')('
#                my @args_lst=();
#                if($args->[0] == 31) { # ','
#                    for my $arg (@{$args->[1]}) {
#                        push @args_lst, emit_expr_from_ast($arg);
#                    }
#                    return "$name(".join(',',@args_lst).')';
#                } else {
#                    return "$name(".emit_expr_from_ast($args).')';
#                }
#            } else { # f(x)(y)
#                #say Dumper($args);
#                (my $sigil,my $args1, my $args2) = @{$args};
#                my $args_str1='';
#                my $args_str2='';
#                if($args1->[0] == 31) { #eq ','
#                my @args_lst1=();
#                for my $arg (@{$args1->[1]}) {
#                    push @args_lst1, emit_expr_from_ast($arg);
#                }
#                $args_str1=join(',',@args_lst1);
#
#            } else {
#                $args_str1= emit_expr_from_ast($args1);
#            }
#                if($args2->[0] == 31) { #eq ','
#                    #say Dumper($args2);
#                my @args_lst2=();
#                for my $arg (@{$args2->[1]}) {
#                    push @args_lst2, emit_expr_from_ast($arg);
#                }
#                $args_str2=join(',',@args_lst2);
#            } else {
#                $args_str2=emit_expr_from_ast($args2);
#            }
#                return "$name(".$args_str1.')('.$args_str2.')';
#            }
#        } else {
#    (my $opcode, my $lexp, my $rexp) =@{$ast};
#    my $lv = (ref($lexp) eq 'ARRAY') ? emit_expr_from_ast($lexp) : $lexp;
#    my $rv = (ref($rexp) eq 'ARRAY') ? emit_expr_from_ast($rexp) : $rexp;
#    return $lv.$sigils[$opcode].$rv;
#    }
#} elsif (scalar @{$ast}==2) { #  for '{'  and '$'
#    (my $opcode, my $exp) =@{$ast};
#    if ($opcode==0 ) {#eq '{'
#        my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
#        return "($v)";
#    } elsif ($opcode==2 or $opcode>26) {# eq '$'
#            return $exp;
#    } elsif ($opcode == 21 or $opcode == 4) {# eq '.not.' '-'
#        my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
#            return $sigils[$opcode]. $v;
#    } else {
#        die 'BOOM! '.Dumper($ast).$opcode;
#    }
#} 
#} else {return $ast;}
#} # END of emit_expr_from_ast
#
#}

for my $str ('z(j+i,k*km)*p(i+1,j+jm)','i+1','v( i + 1 )','z','z(j,k)','j+k','i-im') {
say "TEST: $str";
(my $ast, my $rest, my $err) = parse_expression_faster($str);#*p(i+1,j+jm)');
if ($err) {say 'ERROR' } else {
    #say "AST: ".Dumper($ast);
say 'EMIT: '.emit_expr_from_ast($ast);

}
}
#die;
for my $str ("5+42+ +6/42/44-45*7", '6*7', '44 - -2', '(1+2*3)+3+4/5','4+(22*(33*44+1)+77)/2') {
    say "\nTEST: $str";
(my $ast, my $rest, my $err) = parse_expression_faster($str);
if ($err) {say 'ERROR' } else {
    #say "AST: ".Dumper($ast);
say 'EMIT: '.emit_expr_from_ast($ast);

}

#say Dumper($ast);
say eval($str);
say interpret($ast);
}


for my $str ('*8','RANK ( N, *8, *9 )','f(x)(y)', 'a**b**3', 'B .and. .not. A .or. C','.not.A .and. B','A(I,J,K)(M+N,1)', 'dimension(0:im,-1:jm)','a(1,1)', 'A(1,J,K)(M:N,1)', 'f(x+2,1)(v,12)','time',
'((-beta-(beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
'((-beta - (beta*beta-2.*alpha)**(0.5))/alpha).lt.dt',
'-beta - beta','range(i,1,im,j,1,jm,k,1,km)',
'print(__PH0__)'
 ) {
say "\nTEST: $str";
(my $ast, my $rest, my $err) = parse_expression_faster($str);#*p(i+1,j+jm)');
if ($err or $rest ne '') {say 'ERROR: <'.$rest.'>' } else {
#say "AST: ".Dumper($ast);
say 'EMIT: '.emit_expr_from_ast($ast);
}
}


