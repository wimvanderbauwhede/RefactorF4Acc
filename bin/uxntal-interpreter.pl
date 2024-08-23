#!/usr/bin/env perl
use warnings;
use strict;
use v5.30;

use integer;

no warnings qw(experimental::signatures);
use feature qw(signatures);

use Data::Dumper;
use Carp;
use Getopt::Std;

my %opts = ();
getopts( 'vwVd', \%opts );


our $WW = $opts{'w'} ? 1 : 0;
our $V = $opts{'v'} ? 1 : 0;
our $VV = $opts{'V'} ? 1 : 0;
our $DBG = $opts{'d'} ? 1 : 0;

my $programFile=$ARGV[0];

open my $fh, '<', $programFile or die "Can't open file $!";
my $programText = do { local $/; <$fh> };
close $fh;
# my $programText = Path(programFile).read_text();

# programText = "|0100 ;array LDA ;array #01 ADD LDA ADD #18 DEO BRK @array 11 22 33";
my $T = {
    MAIN => 0,
    LIT => 1,
    INSTR => 2,
    LABEL => 3,
    REF => 4,
    RAW => 5,
    ADDR => 6,
    PAD => 7,
    EMPTY => 8,
};
my $Uxn ={
    memory => [([$T->{EMPTY},]) x hex('0x10000') ],
    stacks => [[],[]], # ws, rs
    # Program counter
    pc => 0,
    # Symbol table
    symbolTable=>{},
    # First unused address,
    free => 0,
};

sub stripComments($programText){
    # say 'TEXT:',$programText;
    my @chunks_open = split(/\(\s+/s,$programText,2);
    
    if (scalar @chunks_open==2){
        my $comment = $chunks_open[1];
        my @chunks_close = split(/\s+\)/,$comment,2);
        # print('CLOSE:<',chunks_close[1],'>',len(chunks_close));
        if (scalar @chunks_close==2){
            return stripComments($chunks_open[0] . $chunks_close[1]);
        } else {
            return $chunks_open[0] . $chunks_close[0];
        }
    } else {
        # print('DONE:<',chunks_open[0],'>');
        return $chunks_open[0];
    }
}

sub parseToken($tokenStr){
    say "TOKENSTR: <$tokenStr>";
    if (substr($tokenStr,0,1) eq '#'){
        my $valStr=substr($tokenStr,1);
        my $val = hex($valStr);
        if (length($valStr)==2){
            return [$T->{LIT},$val,1];
        } else {
            return [$T->{LIT},$val,2];
        }
    }
    if (substr($tokenStr,0,1) eq '"'){
        my @chars = split('',substr($tokenStr,1));
        return [map { [$T->{LIT}, ord($_),1] } @chars];
    } elsif  (substr($tokenStr,0,1) eq ';'){
        my $val = substr($tokenStr,1);
        return [$T->{REF},$val,2];
    } elsif (substr($tokenStr,0,1) eq ',' and substr($tokenStr,1,1) eq '&'){
        my $val = substr($tokenStr,2);
        return [$T->{REF},$val,1];
    } elsif  (substr($tokenStr,0,1) eq '@'){
        my $val = substr($tokenStr,1);
        return [$T->{LABEL},$val];
    } elsif  (substr($tokenStr,0,1) eq '&'){
        my $val = substr($tokenStr,1);
        return [$T->{LABEL},$val];
    } elsif ($tokenStr eq '|0100'){
        return [$T->{MAIN},];
    } elsif  (substr($tokenStr,0,1) eq '|'){
        my $val = substr($tokenStr,1);
        return [$T->{ADDR},hex($val)];
    } elsif  (substr($tokenStr,0,1) eq '$'){
        my $val = substr($tokenStr,1);
        return [$T->{PAD},hex($val)];
    } elsif  ($tokenStr=~/^[A-Z]/){
        if (length $tokenStr == 3){
            return [$T->{INSTR},substr($tokenStr,0,3),1,0,0];
        } elsif  (length $tokenStr == 4){
            if ($tokenStr =~ /2$/){
                return [$T->{INSTR},substr($tokenStr,0,length($tokenStr)-1),2,0,0];
            } elsif  ($tokenStr =~/r$/){
                return [$T->{INSTR},substr($tokenStr,0,length($tokenStr)-1),1,1,0];
            } elsif  ($tokenStr=~/k$/){
                return [$T->{INSTR},substr($tokenStr,0,length($tokenStr)-1),1,0,1];
            }
        } elsif  (length $tokenStr == 5){
            # Order must be size:stack:keep;
            if (substr($tokenStr,length($tokenStr)-2,length($tokenStr)) eq '2r'){
                return [$T->{INSTR},substr($tokenStr,0,length($tokenStr)-2),2,1,0];
            } elsif  (substr($tokenStr,length($tokenStr)-2,length($tokenStr)) eq '2k'){
                return [$T->{INSTR},substr($tokenStr,0,length($tokenStr)-2),2,0,1];
            } elsif  (substr($tokenStr,length($tokenStr)-2,length($tokenStr)) eq 'rk'){
                return [$T->{INSTR},substr($tokenStr,0,length($tokenStr)-2),1,1,1];
            }
        } elsif  (length $tokenStr == 6){
            return [$T->{INSTR},substr($tokenStr,0,length($tokenStr)-1),2,1,1];
        }
    } else {
        return [$T->{RAW},hex($tokenStr)];
    }
}
# Actions;

sub store($args,$sz,$uxn){
    $uxn->{memory}[$args->[0]] = ['RAW',$args->[1],0];
    # print('STORED:',$uxn->{memory}[$args->[0]],'at',$args->[0]);
}
sub load($args,$sz,$uxn){
    # print($args,$uxn->{memory}[$args->[0]]);
    return $uxn->{memory}[$args->[0]][1] # memory has tokens, stacks have values with size;
}
sub call($args,$sz,$uxn){
    # print("CALL:",$args->[0],$uxn->{pc});
    push @{$uxn->{stacks}[1]}, [$uxn->{pc},2];
    $uxn->{pc} = $args->[0]-1;
}

sub jump($args,$sz,$uxn){
    $uxn->{pc} = $args->[0];
}

sub condJump($args,$sz,$uxn){
    if ($DBG){
        print('JCN ARGS:',$args,$uxn->{stacks});
    }
    if ($args->[1] == 1 ){
        # $uxn->{pc} =  $uxn->{pc};
    # } else {
        if ($DBG){
            print('SET PC:',$args->[0]);
        }
        # exit();
        $uxn->{pc} = $args->[0]-1;
    }
}

sub stash($rs,$sz,$uxn){
    push @{$uxn->{stacks}[1-$rs]}, pop @{$uxn->{stacks}[$rs]};
}
sub pop_($rs,$sz,$uxn){
    pop @{$uxn->{stacks}[$rs]};
}
sub swap($rs,$sz,$uxn){
        my $b = pop @{$uxn->{stacks}[$rs]};
        my $a = pop @{$uxn->{stacks}[$rs]};
        push @{$uxn->{stacks}[$rs]}, $b;
        push @{$uxn->{stacks}[$rs]}, $a;
}
sub nip($rs,$sz,$uxn){ # a b -> b;
    my $b = pop @{$uxn->{stacks}[$rs]};
    if ($b->[1]==$sz){
        my $a = pop @{$uxn->{stacks}[$rs]};
        if ($a->[1]==$sz){
            push @{$uxn->{stacks}[$rs]}, $b;
        } else {
            die("Error: Args on stack for NIP",$sz,"are of wrong size\n");
        }
    } elsif  ($b->[1]==2 and $sz==1){
        my $bb = $b->[0]&0xFF;
        push @{$uxn->{stacks}[$rs]}, [$bb,1];
    } elsif  ($b->[1]==1 and $sz==2){
        die("Error: Args on stack for my NIP",$sz,"are of wrong size\n");
        # a = pop @{$uxn->{stacks}[$rs]};
        # if ($a[1]==1){
        #     push @{$uxn->{stacks}[$rs]}, $b;
        # } else {
    }
}
sub rot($rs,$sz,$uxn){ # a b c -> b c a;
        my $c = pop @{$uxn->{stacks}[$rs]};
        my $b = pop @{$uxn->{stacks}[$rs]};
        my $a = pop @{$uxn->{stacks}[$rs]};
        push @{$uxn->{stacks}[$rs]}, $b;
        push @{$uxn->{stacks}[$rs]}, $c;
        push @{$uxn->{stacks}[$rs]}, $a;
}
sub dup($rs,$sz,$uxn){
        my $a = $uxn->{stacks}[$rs][-1];
        push @{$uxn->{stacks}[$rs]}, $a;
}
sub over($rs,$sz,$uxn){ # a b -> a b a;
        my $a = $uxn->{stacks}[$rs][-2];
        push @{$uxn->{stacks}[$rs]}, $a;
}
sub add($args,$sz,$uxn){
    return $args->[1] + $args->[0];
}
sub sub_($args,$sz,$uxn){
    return $args->[1] - $args->[0];
}
sub mul($args,$sz,$uxn){
    return $args->[1] * $args->[0];
}
sub div($args,$sz,$uxn){
    return $args->[1] / $args->[0]; # FIXME
}
sub inc($args,$sz,$uxn){
    return $args->[0]+1;
}
sub eq($args,$sz,$uxn){
    return $args->[0] == $args->[1] ? 1: 0;
}
sub ne($args,$sz,$uxn){
    return $args->[0] != $args->[1] ? 1: 0;
}

# action,nArgs,hasRes;
our $callInstr = {
    'INC' => [\&inc,1,1],
    'ADD' => [\&add,2,1],
    'MUL' => [\&mul,2,1],
    'SUB' => [\&sub_,2,1],
    'DIV' => [\&div,2,1],
    'EQU' => [\&eq,2,1],
    'NEQ' => [\&ne,2,1],
    'DEO' => [sub ($args,$sz,$uxn) { print(chr($args->[1]))},2,0],
    'JSR' => [\&call,1,0],
    'JMP' => [\&jump,1,0],
    'JCN' => [\&condJump,2,0],
    'LDA' => [\&load,1,1],
    'STA' => [\&store,2,0],
    'STH' => [\&stash,0,0],
    'DUP' => [\&dup,0,0],
    'SWP' => [\&swap,0,0],
    'ROT' => [\&rot,0,0],
    'OVR' => [\&over,0,0],
    'POP' => [\&pop_,0,0],
    'NIP' => [\&nip,0,0]
};

sub executeInstr($token,$uxn){
    my ($_t,$instr,$sz,$rs,$keep) = @{$token};
    if ($instr eq 'BRK'){
        if ($V){
            print("\n",'*** DONE *** ');
        } else {
            print('');
        }
        if ($VV){
            print('PC:',$uxn->{pc},' (WS,RS){',$uxn->{stacks});
        }
        exit(0);
    }
    my ($action,$nArgs,$hasRes) = @{$callInstr->{$instr}};
    if ($nArgs==0) { # means it is a stack manipulation;
        $action->($rs,$sz,$uxn);
    }
    else {

        my $args=[];
        for my $i ( reverse 0 .. $nArgs-1){
            if ($keep == 0){
                my $arg = pop @{$uxn->{stacks}[$rs]};
                if ($arg->[1]==2 and $sz==1 and ($instr ne 'LDA' and $instr ne 'STA') ){
                    if ($WW){
                        print("Warning: Args on stack for ",$instr,$sz,"are of wrong size (short for byte)");
                    }
                    push @{$uxn->{stacks}[$rs]}, [$arg->[0]>>8,1];
                    push @{$args},[$arg->[0]&0xFF];
                } else { # either 2 2 or 1 1 or 1 2;
                    push @{$args}, $arg->[0]; # works for my $ 1 1 or 2 2;
                    if ($arg->[1]==1 and $sz==2) {
                        my $arg1 = $arg;
                        my $arg2 = pop @{$uxn->{stacks}[$rs]};
                        if ($arg2->[1]==1 and $sz==2){
                            $arg = ($arg2->[0]<<8) + $arg1->[0];
                            push @{$args}, $arg; # a b 
                        } else {
                            die("Error: Args on stack are of wrong size (short after byte)\n");
                        }
                    }
                }
            }
            else {
                my $arg = $uxn->{stacks}[$rs][$i];
                if ($arg->[1]!= $sz and ($instr ne 'LDA' and $instr ne 'STA')){
                    die("Error: Args on stack are of wrong size (keep)\n");
                }   
                else {
                    push @{$args}, $arg->[0];
                }
            }
        }
        if ($VV){
            print('EXEC INSTR:',$instr, 'with args', $args);
        }
        if ($hasRes){
            my $res = $action->($args,$sz,$uxn);
            if ($instr eq 'EQU' or $instr eq 'NEQ' or $instr eq 'LTH' or $instr eq 'GTH'){
                push @{$uxn->{stacks}[$rs]}, [$res,1];
            } else {
                push @{$uxn->{stacks}[$rs]}, [$res,$sz];
            }
        } else {
            $action->($args,$sz,$uxn);
        }
    }
}


sub resolveSymbols($uxn){
    my $i=0;
    for my $token (@{$uxn->{memory}}){
        if ($token->[0] == $T->{REF}){
            my $address = $uxn->{symbolTable}{$token->[1]};
            $uxn->{memory}[$i] = [$T->{LIT},$address,$token->[2]];
        }
        $i++;
    }
}

sub populateMemoryAndBuildSymbolTable($tokens,$uxn){
    my $pc = 0;
    for my $token ( @{$tokens}){
        if ($token=>[0] == $T->{MAIN}){
            $pc = hex( 0x0100);
croak;
            # uxn.labels[pc]='MAIN';
        } elsif ($token->[0] == $T->{ADDR}){
            $pc = $token->[1];
        } elsif ($token->[0] == $T->{PAD}){
            $pc += $token->[1];
        } elsif ($token->[0] == $T->{LABEL}){
            my $labelName = $token->[1];
            $uxn->{symbolTable}{$labelName}=$pc;
            # uxn.labels[pc]=labelName;
        } else {
            $uxn->{memory}[$pc]=$token;
            $pc++;
        }
    }
    $uxn->{free} = $pc;
    
}



sub runProgram($uxn){
    if ($VV){
        print('*** RUNNING ***');
    }
    $uxn->{pc} = hex(0x0100); # all programs must start at 0x100
    while (1) {
        my $token = $uxn->{memory}[$uxn->{pc}];
        if ($DBG){
            say 'PC:',$uxn->{pc},' TOKEN:',$token;
        }
        given ($token->[0]){
            when( $T->{LIT}){
                push @{$uxn->{stacks}[0]}, [$token->[1],$token->[2]];
            }
            when( $T->{INSTR}){
                # if ($token->[1] eq 'BRK'){
                #     print('HALT');
                #     exit(0);
                executeInstr($token,$uxn);
            }
            when( $T->{REF}){
                print('Unresolved REF:',$token);
                exit(0);
            }
        }
        $uxn->{pc} = $uxn->{pc} + 1;
        if ($DBG){
            print('(WS,RS){',$uxn->{stacks});
        }
    }
}

my $uxn = $Uxn;
my $programText_noComments = stripComments($programText);
# die('programText_noComments:<',$programText_noComments,'>');

# Tokenise the program text;
my $tokenStrings = [split(/\s+/,$programText_noComments)];
my $tokensWithStrings = [map {parseToken($_)} @{$tokenStrings}];
# die Dumper $tokensWithStrings;
my $tokens=[];
for my $item (@{$tokensWithStrings} ){
    if (ref($item->[0]) eq 'ARRAY'){
        for my $token (@{$item}){
            push @{$tokens}, $token;
        }
    } else {
        push @{$tokens}, $item;
    }
}
# die Dumper $tokens;

populateMemoryAndBuildSymbolTable($tokens,$uxn);

resolveSymbols($uxn);
# die Dumper @{$uxn->{memory}}[1..$uxn->{free}],$uxn->{free};
if ($DBG){
    for my $pc ( 256 .. $uxn->{free}-1){
        say $pc,':',$uxn->{memory}[$pc];
    }
    say '';
}
if ($VV){
    say $programText_noComments;
}
die;

runProgram($uxn);

