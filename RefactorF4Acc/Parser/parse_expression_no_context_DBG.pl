#!/usr/bin/perl
use v5.30;
use warnings;
use strict;
use Carp qw(carp croak);
use Data::Dumper;
our $DBG=0;
our $V=0;
our $defaultToArrays = 0;

 
#               0    1    2    3    4    5    6    7    8    9    10   11   12   13    14
our @sigils = ('(', '&', '$', '+', '-', '*', '/', '%', '**', '=', '@', '#', ':' ,'//', ')('
#                15    16    17  18   19    20     21       22       23      24       25       26      
               ,'==', '/=', '<', '>', '<=', '>=', '.not.', '.and.', '.or.', '.xor.', '.eqv.', '.neqv.'
#                27   28 
               ,',', '(/',
# Constants               
#                29        30      31         32           33             34       35 
               ,'integer', 'real', 'logical', 'character', 'PlaceHolder', 'Label', 'BLANK'
              );
my $opcode=0;
our %sigil_codes = map { $_ => $opcode++  } @sigils;

my %F95_ops =(
	'==' => '.eq.',  
    '/=' => '.ne.',  
    '<=' => '.le.',  
    '>=' => '.ge.',
	'eq' => '==',
	'ne' => '/=',
	'le' => '<=',
	'ge' => '>=',     			
);
# I think the reason for the bug might be that lev/prev_lev is not enough and that we need a stack of levels.


my $str = 'k<km+1 .and. k>0';
my  ($ast,$rest,$error) = parse_expression_no_context($str);
# say Dumper $ast, $rest;
say emit_expr_from_ast($ast);

my $str2 = 'km+1>k .and. k>0';
my  ($ast2,$rest2,$error2) = parse_expression_no_context($str2);
# say Dumper $ast2, $rest2;
say emit_expr_from_ast($ast2);


my $str3 = 'km1+1>k-4 .and. k+3>km2+2';
my  ($ast3,$rest3,$error3) = parse_expression_no_context($str3);
# say Dumper $ast3, $rest3;
say emit_expr_from_ast($ast3);

sub parse_expression_no_context { (my $str)=@_;	
say "START $str";
    my $max_lev=11; # levels of precedence
    my $prev_lev=0;
    my $pp_lev=0;
    my $lev=0;
    # Let's try an array first
    my @ast=();
    my $op;
    my $state=0; # I will use state=8/9/10 as "has prefix .not. - + "
    my $error=0;
    # I will not treat * as a proper prefix


    my $expr_ast=[];
    my $arg_expr_ast=[];
    my $has_funcs=0;
    my $empty_arg_list=0;
    # carp "ORIG STR: $str";
    croak if $DBG and not defined $str;
    while (length($str)>0) {
        $error=0;
		# say "STR before prefix: $str";
        # Remove whitespace
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }
        # Handle prefix -,+,.not.
        if ($str=~s/^\-//) {
            $state=4;
        }    
        elsif ($str=~s/^\+//) {
            $state=3;
        }    
        elsif ($str=~s/^\.not\.//) {
            $state=21;
        }    
        # Remove whitespace after prefix
        if ($state and $str=~/^\s/) {
            $str=~s/^\s+//;
        }
        #say "STR before term: $str";
        if ($str=~s/^([a-zA-Z_]\w*)\s*\(//) {
            # array access or function call
            
            # the name of the array or called function
            my $var=$1;
            $has_funcs=1;
            my $arg_expr_ast;
            if ($str!~/^\s*\)/) { # non-empty arg list
                ($arg_expr_ast,$str, my $err, my $has_funcs2)=parse_expression_no_context($str);
                if( ref($arg_expr_ast) ne 'ARRAY') {
                    $arg_expr_ast=[$arg_expr_ast];
                };
                $has_funcs||=$has_funcs2;
                # warn Dumper($arg_expr_ast,$str, $err, $has_funcs2);
            } else { # empty arg list                       
                # warn "EMPTY ARG LIST: str <$str>";
                $empty_arg_list=1;
                $str=~s/^\)\s*//; # A hack but I'm lazy
                $arg_expr_ast=[];
                # warn Dumper($arg_expr_ast,$str);
            }
                $expr_ast=[1,$var,$arg_expr_ast];
            # f(x)(y)
            if ($str=~/^\(/) {
                (my $arg_expr_ast2,$str, my $err2,my $has_funcs2)=parse_expression_no_context($str);
                $expr_ast=[1, $var,[14,$arg_expr_ast,$arg_expr_ast2->[1]]];
                #$expr_ast=['&',$var,[')(',$arg_expr_ast,$arg_expr_ast2->[1]]];
                $has_funcs||=$has_funcs2;
            }
        }
        elsif ($str=~s/^\(\s*\/// or $str=~s/^\[//) {
            # constant array constructor expr
            ($expr_ast,$str, my $err,my $has_funcs2)=parse_expression_no_context($str);
            $has_funcs||=$has_funcs2;
            #$expr_ast=['(/',$expr_ast];
            $expr_ast=[28,$expr_ast];
            if($err) {
            	#say "ERR 1";
            	return ($expr_ast,$str, $err,0);
            }
        }
        elsif ($str=~s/^\(//) {
            # paren expr, I use '(' 
            ($expr_ast,$str, my $err,my $has_funcs2)=parse_expression_no_context($str);
            $has_funcs||=$has_funcs2;
            #$expr_ast=['(',$expr_ast];
            $expr_ast=[0,$expr_ast];
            if($err) {#say "ERR 2";
            return ($expr_ast,$str, $err,0);
            }
        }
        # Apparently Fortran allows '$' as a character in a variable name but I think I'll ignore that.
        # I allow _ as starting character because of the placeholders
        elsif ( $str=~s/^([a-zA-Z]\w*)// ) {
            say "VAR $1 '$str'";
            #variable
            $expr_ast=[2,$1];
            #$expr_ast=['$',$1];
        }
        elsif ( $str=~s/^((?:__PH\d+__)+)// ) {
            #variable
            $expr_ast=[33,$1];
            #$expr_ast=['$',$1];
            # Now it is possible that there are several of these in a row!
        }
        elsif ( $str=~s/^\.(true|false)\.// ) {
            # boolean constants
            $expr_ast=[31,'.'.$1.'.'];
            #$expr_ast='.'.$1.'.';
        }
        elsif (
            
            # eq 
            # 
        	(
                # and or xor lt gt le ge ne
                (
        		($str!~/^\d+\.[aoxlgn]/ and  $str!~/^\d+\.eq/) and
        		$str=~s/^((?:\d*\.\d*)(?:[edqEDQ][\-\+]?\d+)?)//        
                ) 
        	)
            or 
            $str=~s/^(\d*(?:[edqEDQ][\-\+]?\d+))//
        ) { 
            say "REAL $1 '$str'";
            # reals
            $expr_ast=[30,$1];
            #$expr_ast=$1;
        }
        # elsif ($str=~s/^\*(\d+)//) { 
        elsif ($str=~s/^\*(\d+)//) {
            # The '*' is for "alternate returns", a bizarre F77 feature.
            # The integer following the * is a label 
            $expr_ast=[34,$1];
            #$expr_ast=$1;#['Label',$1];
        }        
        elsif ( $str=~s/^(\d+)//) {            
            # integers           
            say "INT $1 '$str'"; 
            # warn 'INTEGER, ALLOW_SPACES_IN_NUMBERS==0';
            $expr_ast=[29,$1];
            #$expr_ast=$1;#['integer',$1];
        }
        elsif ($str=~s/^\*//) {
            # '*' format for write/print
            $expr_ast=[32,'*'];
        }
        # Maybe I should handle string constants as well
        # Although we use placeholders so they should not occur
        elsif ( $str=~s/^\'(.+?)\'// ) {
            $expr_ast=[32,"'".$1."'"];
            #$expr_ast="'".$1."'";
        }
        else {          
            # Here we return with an error value
            # What I could do is say:
            # if the next token is ':' or the pending op is ':' (12)
            carp "STR:<$str>" if not defined $op;
            if($str=~/^\s*:/ or $op == 12) {
                # Return a blank
                $expr_ast=[35,'']
            } else { # error
            #say "ERR 3";
                $error=1;
                return ($expr_ast, $str, $error,0);
            }
        }

        # If state is not 0 there is a prefix
        if ($state) { croak;
            $expr_ast=[$state,$expr_ast];
        }
        #say "STR before operator: $str";

        # Strip whitespace
        if ($str=~/^\s/) {
            $str=~s/^\s+//;
        }

        if (length($str)==0) { 
            last;
        }
       
        if ($str=~s/^,//) { # comma
            # just set a state here
            $state=6;
        }
        elsif ($str=~s/^\/\s*\)// or $str=~s/^\]//) { # closing paren for constant array constructor
            # Again this is like falling off the end of the string
            # if  @{$arg_expr_ast} is not empty, then this must become the ast to return
            # after appending the final value
            if ( @{$arg_expr_ast} ) {
                # Just set a state here
                $state=7; # because the operator has already been set
            }
            # otherwise it is quite the same as the end of the string
            else {
            	#say "LEAVE WHILE: closing paren";
                last;
            }
        }        
        elsif ($str=~s/^\)//) { # closing paren
        
            # Again this is like falling off the end of the string
            # if  @{$arg_expr_ast} is not empty, then this must become the ast to return
            # after appending the final value
            # warn "HERE empty arg list: $empty_arg_list; $str ". Dumper($arg_expr_ast);
            # if ($empty_arg_list) {
            #         # warn "HERE empty arg list: $str";
            #         $state=6;
            #         $empty_arg_list=0;
            # }                
            # els
            if ( @{$arg_expr_ast}  ) {
                # Just set a state here
                $state=7;                
            }
            # otherwise it is quite the same as the end of the string
            else {
            	# say "LEAVE WHILE: closing paren";
                last;
            }
        } 
        else { 
            warn "OPS '$str'";
            # Operators
=info_operator_precedence
Level
    Scalars
0
    Arithmetic
1        right       ** NOTE F ** S ** Z means F ** (S ** Z)
2        right       unary + and - NOTE X ** -A * Z means X ** (-(A * Z)) => Handled in state=0
3        left        * / 
4        left        + - 
    Character
5        left         //
         left         :   NOTE I put this here, main purpose is array dims but it also works for substring ranges
         left         =   NOTE I put this here, main purpose is implicit do. Actually this should be a separate level between Relational and Logical
    Relational
6        nonassoc    < > <= >= .lt. .gt. .le. .ge.
7        nonassoc    == != .eq. .ne. 
    Logical
8        right       .not.
9        left        .and. 
10        left        .or. 
11        left        .xor. .eqv. .neqv.

So it looks like I need at least 6 bits, so we'll need <<8 and 0xFF

=cut 
            $pp_lev=$prev_lev;
            $prev_lev=$lev;
            if ($str=~s/^\+//) {
                $lev=4;
                #$op='+';
                $op=3;
                say "OP 3 + lev 4 '$str'";
            }
            elsif ($str=~s/^\-//) {
                $lev=4;
                #$op='-';
                $op=4;
            }
            elsif ($str=~s/^\*\*//) {
                # We store this incorrectly left-assoc, the emitter can fix it.
                $lev=2;
                #$op='**';
                $op=8;
            } 
            elsif ($str=~s/^\*//) {
                $lev=3;
                #$op='*';
                $op=5;
            }
            elsif ($str=~s/^\/\///) {
                $lev=5;
                #$op='//';
                $op=13;
            } 
            elsif ($str=~s/^://) {
                $lev=5;
                #$op=':';
                $op=12;
            } 
            elsif ($str=~s/^\///) {
                $lev=3;
                #$op='/';
                $op=6;
            } 
            elsif ($str=~s/^>=// || $str=~s/^\.ge\.// || $str=~s/^\.\s*ge\s*\.//) {
                $lev=6;
                #$op='>=';
                $op=20;
            } 
            elsif ($str=~s/^<=// || $str=~s/^\.le\.// || $str=~s/^\.\s*le\s*\.//) {
                $lev=6;
                #$op='<=';
                $op=19;
            } 
            elsif ($str=~s/^<// || $str=~s/^\.lt\.// || $str=~s/^\.\s*lt\s*\.//) {
                $lev=6;
                #$op='<';
                $op=17;
                say "OP 17 < lev 6 '$str'";
            } 
            elsif ($str=~s/^>// || $str=~s/^\.gt\.// || $str=~s/^\.\s*gt\s*\.//) {
                $lev=6;
                #$op='>';
                $op=18;
            } 
            elsif ($str=~s/^==// || $str=~s/^\.eq\.// || $str=~s/^\.\s*eq\s*\.//) {
                $lev=7;
                #$op='==';
                $op=15;
            } 
            elsif ($str=~s/^\!=// || $str=~s/^\.ne\.// || $str=~s/^\.\s*ne\s*\.//) {
                $lev=7;
                #$op='/=';
                $op=16;
            } 
            elsif ($str=~s/^\.and.// || $str=~s/^\.\s*and\s*\.//) {
                $lev=9;
                #$op='.and.';
                $op=22;
                say "OP 22 .and. lev 9 '$str'";
            } 
            elsif ($str=~s/^\.or.// || $str=~s/^\.\s*or\s*\.//) {
                $lev=10;
                #$op='.or.';
                $op=23;
            } 
            elsif ($str=~s/^\.xor.// || $str=~s/^\.\s*xor\s*\.//) {
                $lev=11;
                #$op='.xor.';
                $op=24;
            } 
            elsif ($str=~s/^\.eqv.// || $str=~s/^\.\s*eqv\s*\.//) {
                $lev=11;
                #$op='.eqv.';
                $op=25;
            } 
            elsif ($str=~s/^\.neqv.// || $str=~s/^\.\s*neqv\s*\.//) {
                $lev=11;
                #$op='.neqv.';
                $op=26;
            } 
            elsif ($str=~s/^\=//) {
                $lev=5;
                #$op='=';
                $op=9;
            } else {
                #                carp 'NO OP, ERROR '.$str;
                #say "LEAVE WHILE: ERROR, str $str does not match any op";
                $error=1;
                last;
                #return ($expr_ast, $str, 1,0);
            }

            $state=5;
        }
        if ($state==5 and not defined $op) {
        	#say "ERR 5";
            $error=1;
        	return ($expr_ast, $str, $error,0);
        }
        # Append to the AST
        if ($state==5 ) {
            if ($prev_lev==0) { # start
                $ast[$lev]=[$op,$expr_ast];
            } elsif ($prev_lev<$lev) { # '*' < '+'
                push @{$ast[$prev_lev]},$expr_ast;
                # WV 2021-06-17 TODO: use a stack of previous levels and recursion
                if ($pp_lev>$prev_lev) { 
                    say 'PP1:'.Dumper $ast[$pp_lev];
                    say 'PP2:'.Dumper $ast[$prev_lev];
                    my $tmp_ast= [@{$ast[$pp_lev]},$ast[$prev_lev]];
                    say 'PP3:'.Dumper $tmp_ast;
                    $ast[$prev_lev]= $tmp_ast;
                    undef $ast[$pp_lev];
                }
                say 'PP:'.Dumper $ast[$prev_lev];

                if (not defined $ast[$lev]) {
                    $ast[$lev]=$ast[$prev_lev];
                } else {
                    push @{$ast[$lev]}, $ast[$prev_lev];
                }
                undef $ast[$prev_lev];
                $ast[$lev] = [$op, $ast[$lev]];
            } elsif ($prev_lev>$lev) {
                $ast[$lev]=[$op, $expr_ast];
            } elsif ($lev==$prev_lev) {
                push @{$ast[$lev]},$expr_ast;
                $ast[$lev]=[$op, $ast[$lev]];
            }
            warn "prev $prev_lev lev $lev str $str ". Dumper $ast[$lev];
            my $tlev=0;
            for my $tast (@ast) {
                say "lev $tlev ". Dumper($tast) if defined $tast;
                ++$tlev;
            }
            
            $state=0;
        } elsif ($state == 6 or $state==7) { croak;
            # warn "$state $str";
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
                for my $tlev (1 .. $max_lev) {
                    if (not defined $ast[$tlev+1]) {
                        $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                    } else {
                        push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                    }
                }
                push @{$arg_expr_ast},$ast[$max_lev+1];
            }
            if ($state==6) {
                @ast=();
                $state=0;
                $prev_lev=0;
                $lev=0;
            } else { # state==7
                # Now we return this as the ast
                #say "ERR 6 $error";
                # warn Dumper([27,@{$arg_expr_ast}],$str,$error,$has_funcs);
                return ([27,@{$arg_expr_ast}],$str,$error,$has_funcs);
            } 
        }
    } # while

    # So when we fall off the end of the string we need to clean up
    # There is an $expr_ast pending
    if ( not defined $ast[$lev]) {
        $ast[$lev] = $expr_ast;
    } else { 
        warn "prev $prev_lev lev $lev: ".Dumper($expr_ast); 
        push @{$ast[$lev]}, $expr_ast;
    }
    if(@{$arg_expr_ast}) { 
        if( scalar @ast == 1) {
            push @{$arg_expr_ast},$ast[0];
        } else {
            for my $tlev (1 .. $max_lev) {
                if (not defined $ast[$tlev+1]) {
                    $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                } else {
                    push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                }
            }
            push @{$arg_expr_ast},$ast[$max_lev+1];
        }
        #say "ERR 7 $error";
        return([27,@{$arg_expr_ast}],$str,$error,$has_funcs);
    } else {
        # Now determine the highest level; fold the lower levels into it
        if( scalar @ast == 1) {
            
            return ($ast[0],$str,$error,$has_funcs);
        } else {
            say 'HERE';
            for my $tlev (1 .. $max_lev) {
                if (not defined $ast[$tlev+1]) {
                    $ast[$tlev+1] = $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                } else {
                    push @{$ast[$tlev+1]}, $ast[$tlev] if defined $ast[$tlev] and scalar @{$ast[$tlev]};
                }
            }
            #say "ERR 8 $error";
            return ($ast[$max_lev+1],$str,$error,$has_funcs);
        }
    }
} # END of parse_expression_no_context


sub emit_expr_from_ast { (my $ast)=@_;

#	say Dumper($ast);
    if (ref($ast) eq 'ARRAY') {
        if (scalar @{$ast}==3) {
            if ($ast->[0] == 1 or $ast->[0] == 10) { # '&' or '@', array access or function call
                (my $sigil, my $name, my $args) =@{$ast}; # [10,'v',[...]]
                if (@{$args}) {
					if ($args->[0] != 14 ) { # ')('
						my @args_lst=();
						if($args->[0] == 27) { # ','
							for my $idx (1 .. scalar @{$args}-1) {
								my $arg = $args->[$idx];
								push @args_lst, emit_expr_from_ast($arg);
							}

							#                    for my $arg (@{$args->[1]}) {
							#       push @args_lst, emit_expr_from_ast($arg);
							#    }
                            # if (grep {(not defined $_)} @args_lst){
							#     carp Dumper($ast,@args_lst);
                            # }
							return "$name(".join(',',@args_lst).')';
						} else {
							return "$name(".emit_expr_from_ast($args).')';
						}
					} else { # f(x)(y)
						#say Dumper($args);
						(my $sigil,my $args1, my $args2) = @{$args};
						my $args_str1='';
						my $args_str2='';
						if($args1->[0] == 27) { #eq ',' 
							my @args_lst1=();
							for my $idx (1 .. scalar @{$args1}-1) {
								my $arg = $args1->[$idx];
								push @args_lst1, emit_expr_from_ast($arg);
							}
							$args_str1=join(', ',@args_lst1);

						} else {
							$args_str1= emit_expr_from_ast($args1);
						}
						if($args2->[0] == 27) { #eq ','
							#say Dumper($args2);
							my @args_lst2=();
							for my $idx (1 .. scalar @{$args2}-1) {
								my $arg = $args2->[$idx];
								push @args_lst2, emit_expr_from_ast($arg);
							}

							#                for my $arg (@{$args2->[1]}) {
							#    push @args_lst2, emit_expr_from_ast($arg);
							#}
							$args_str2=join(', ',@args_lst2);
						} else {
							$args_str2=emit_expr_from_ast($args2);
						}
						return "$name(".$args_str1.')('.$args_str2.')';
					}
				} else {
					return "$name()";
				}
            } else {
                (my $opcode, my $lexp, my $rexp) =@{$ast};
                my $lv = (ref($lexp) eq 'ARRAY') ? emit_expr_from_ast($lexp) : $lexp;
                my $rv = (ref($rexp) eq 'ARRAY') ? emit_expr_from_ast($rexp) : $rexp;
                return $lv.' '.$sigils[$opcode].' '.$rv;
            }
        } elsif (scalar @{$ast}==2) { #  for '('  and '$'
            (my $opcode, my $exp) =@{$ast};
            if ($opcode == 0 ) {#eq '('
            # warn Dumper($exp);
                my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
                if (not defined $v) {
                    croak Dumper($ast) if $DBG;
                }
                return "($v)";
            } elsif ($opcode == 28 ) {#eq '(/'
                my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
                return "(/ $v /)";
            } elsif ($opcode == 2 or $opcode>28) {# eq '$' or constants    
                return ($opcode == 34) ?  "*$exp" : $exp;            
            } elsif ($opcode == 21 or $opcode == 4 or $opcode == 3) {# eq '.not.' '-'
                my $v = (ref($exp) eq 'ARRAY') ? emit_expr_from_ast($exp) : $exp;
                return $sigils[$opcode]. $v;
            } elsif ($opcode == 27) { # ',' 
                croak  Dumper($ast) if $DBG ;
                my @args_lst=();
                for my $arg (@{$exp}) {
                    push @args_lst, emit_expr_from_ast($arg);
                }
                return join(', ',@args_lst);        
            } else {
                croak 'BOOM! '.Dumper($ast).$opcode if $DBG;
            }
        } elsif (scalar @{$ast} > 3) {

            if($ast->[0] == 27) { # ','
                my @args_lst=();
                for my $idx (1 .. scalar @{$ast}-1) {
                    my $arg = $ast->[$idx];
                    push @args_lst, emit_expr_from_ast($arg);
                }
                return join(', ',@args_lst); 
            } else {
                croak Dumper($ast) if $DBG;
            }
        }
    } else {return $ast;}
} # END of emit_expr_from_ast