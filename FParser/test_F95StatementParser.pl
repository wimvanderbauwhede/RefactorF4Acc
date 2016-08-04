#!/usr/bin/perl
# NOTE: On Mavericks, it MUST be /usr/bin/perl, NOT the MacPorts Perl!
#
BEGIN {
push @INC, $ENV{'HOME'}.'/Git/Perl-Call-Haskell/lib';
}
use warnings;
use strict;
use v5.16;
use Call::Haskell import => 'F95StatementParser( parseF95Statement,parseF95Decl )' , path => '.', packages => [], clean => 0, verbose => 0;
use Data::Dumper;
use GenericTraversal qw( traverse_with_state traverse );

our %f95ops = (
    'Not'  => '.not.',     #       complement, negation
    'And'  => '.and.',     #       logical and
    'Or'   => '.or.',      #       logical or
    'Eqv'  => '.eq.',      #       logical equivalence
    'Neqv' => '.neqv.',    #      logical not equivalence, exclusive or

    'RelEQ' => '==',          #    equality, old
    'RelNE' => '/=',          #    not equal. old
    'RelLT' => '<',           #     less than, old
    'RelGT' => '>',           #     greater than, old
    'RelLE' => '<=',          #    less than or equal, old
    'RelGE' => '>=',          #    greater than or equal, old
    'Plus' => '+',
    'Mul' => '*',
    'Minus' => '-',
    'Div' => '/',
);
my $vars_in_expr={};

#my $str = '"do i=1+j,10*k\n continue \n end do"';
my $str0=42;
my $str= "if (b1 .and. .not. b2 .or. (f(2*x+1,44/y-2) .ge. 1.2)) call f(var , v(42,43)+3*w(2*i+j),zz)";
my $str2=42.0;
my $str3={3 =>[1,2]};

#my $str= "if (b1 .and. .not. b2) call f(var , v(42,43)+3*w(2*i+j))";
my $dstr=Dumper($str);
if ($dstr=~/\'/) {$str = '"'.$str.'"'};
#my $str= '"call f(var , v(42,43)+3/w(2*i+j))"';
#my $context = "[\"v\",1]";
my $res =  parseF95Statement($str);#,$context);
#say Dumper($res->[0]{'TypeArgs'});

#my $nres= transform_ast($res);
#say Dumper($nres);
#
my $nds2 = traverse_with_state($res,\&simplify,$vars_in_expr); 
my $if_statement = $nds2->[0];
#say Dumper($if_statement);
#die;
#say 'GENERIC:'.Dumper($nds2);
my $vars_in_if_cond={};
my $nds3 = traverse_with_state($if_statement,\&find_if_cond,$vars_in_if_cond); 
my $if_cond = $if_statement->{'If'}[0];
#say Dumper($if_cond);
my $emit_state=[];
my $nds4 = traverse($if_statement,\&convert_hash_to_array); 
my @nds5 =%{$nds4};
say Dumper(\@nds5);
my $nds6 = traverse(\@nds5,\&emit); 
say Dumper($nds6);


my $decl_str='"complex,parameter :: v1 = (42*v2+3)"';
my $decl = parseF95Decl($decl_str);
my $ndecl = traverse_with_state($decl,\&simplify,$vars_in_expr);

say Dumper($ndecl);

sub find_if_cond {
        (my $where, my $elt, my $state) = @_;
        if ($where eq 'HASH_PRE') {
            (my $k, my $v) = @{$elt};
            if ($k eq 'If') {
                $state->{'InIf'}=1;
            }
        } elsif ($where eq 'HASH_POST') {
            (my $k, my $v) = @{$elt};
            if ($k eq 'If') {
                delete $state->{'InIf'};
            }
             
        } elsif ($where eq 'ARRAY_PRE') {
           if (exists $state->{'InIf'}) {
              if (exists $state->{'Done'}) {
                return (undef,$state);
            }             
        }
        } elsif ($where eq 'ARRAY_POST') {
           if (exists $state->{'InIf'}) {
               $state->{'Done'}=1;            
            }
        }
 
        return ($elt,$state);
}

sub simplify {
    (my $where, my $elt, my $state) = @_;
    if ($where eq 'ARRAY_PRE') { 
        if (ref($elt) eq 'HASH' and scalar keys %{$elt}==0) {
            $elt = undef;
        } elsif (ref($elt) eq 'ARRAY' and scalar @{$elt}==0) {
            $elt = undef;
        } elsif (ref($elt) eq 'HASH' and exists $elt->{ 'TypeName' } and $elt->{ 'TypeName' } eq 'Bare') {
            $elt = undef;
        } elsif (ref($elt) eq 'HASH' and exists $elt->{ 'TypeName' } ) {
            if (exists $elt->{ 'TypeArgs' }) {
                $elt = {  $elt->{ 'TypeName' } => $elt->{ 'TypeArgs' } }
            } else {                    
               $elt = {$elt->{ 'TypeName' } => 1};
            }
        }
    } elsif ($where eq 'ARRAY_POST') {
        if (ref($elt) eq 'HASH' and scalar keys %{$elt}==0) {
            $elt = undef;
        } elsif (ref($elt) eq 'ARRAY' and scalar @{$elt}==0) {
            $elt = undef;
        }
    } elsif ($where eq 'HASH_POST') {
        (my $k, my $v) = @{$elt};
        if (ref($v) eq 'HASH' and scalar keys %{$v}==0) {
            $elt = undef;
        } elsif ($k eq 'Var' and ref($v) eq 'ARRAY') { 
#            if (0  and scalar @{$v} == 1) {
            $v = $v->[0][0];    
            if (scalar @{$v} == 1) {
            my $vn = $v->[0]{'VarName'}[0];
            $elt = [$k, $vn];
        } else {
            my $vn = [$v->[0]{'VarName'}[0], $v->[1]];
#            $state->{$vn}=1;
            $elt = [$k, $vn];
        }
            #           } else {
                #   die Dumper($v);
                #}
        }
    } 
    return ($elt, $state);
}

# I should write a function to pull e.g. vars out of the condition only
sub transform_ast {
    (my $ast)=@_;
    if (ref($ast) eq 'ARRAY') {
        my $nast=[];
        for my $elt (@{$ast}) {
            if (ref($elt) eq 'HASH' and scalar keys %{$elt}==0) {
                next;
            }
            if (ref($elt) eq 'ARRAY' and scalar @{$elt}==0) {
                next;
            }
            if (ref($elt) eq 'HASH' and exists $elt->{ 'TypeName' } and $elt->{ 'TypeName' } eq 'Bare') {
                next;
            }

            if (ref($elt) eq 'HASH' and exists $elt->{ 'TypeName' } ) {
                if (exists $elt->{ 'TypeArgs' }) {
                    $elt = {  $elt->{ 'TypeName' } => $elt->{ 'TypeArgs' } }
                } else {                    
                    $elt = {$elt->{ 'TypeName' } => 1};
#                    say 'HERE:'.Dumper($elt);
                }
            }
                   
            my $nelt = transform_ast($elt);
            if (ref($nelt) eq 'HASH' and scalar keys %{$nelt}==0) {
                next;
            }
            if (ref($nelt) eq 'ARRAY' and scalar @{$nelt}==0) {
                next;
            }

            push @{$nast},$nelt
        }
        return $nast;
    } elsif (ref($ast) eq 'HASH') {
        my $nast={};
        for my $k (keys %{$ast}) {
            my $v = $ast->{$k};
            my $nv = transform_ast($v);
            if (ref($nv) eq 'HASH' and scalar keys %{$nv}==0) {
                next;
            }
            if ($k eq 'Var' and ref($nv) eq 'ARRAY') {
                $nv = $nv->[0][0];
                my $vn = $nv->[0]{'VarName'}[0];
                $vars_in_expr->{$vn}=1;
            }
#            if (ref($nv) eq 'ARRAY' and scalar @{$nv}==0) {
#                next;
#            }
#            if (ref($nv) eq 'ARRAY' and scalar @{$nv}==0) {
#                next;
#            }

             $nast->{$k}=$nv;
        }
        return $nast;
    } else {
        return $ast;
    }
}

# state contains a string and maybe some kind of stack

sub emit { 
    (my $where, my $elt) = @_;
    if ($where eq 'ARRAY_POST' or $where eq 'TOP_ARRAY_POST' ) {
        if (ref($elt) eq 'ARRAY' and scalar @{$elt} == 2 ) {
            if ($elt->[0] eq 'Var') {
                $elt = $elt->[1];
            } elsif ($elt->[0] eq 'Con') {
                   $elt = $elt->[1][0];
            }  elsif (ref($elt->[1]) eq 'ARRAY' and scalar @{$elt->[1]}==0) {
                $elt = $elt->[0];
            } elsif ($elt->[0] eq 'Bin') {
                $elt = '('.join(' ',$elt->[1][1],$f95ops{$elt->[1][0]},$elt->[1][2]).')';
            } elsif ($elt->[0] eq 'Unary') {
                 $elt = '('.join(' ',$f95ops{$elt->[1][0]},$elt->[1][1]).')';
             } elsif ($elt->[0] eq 'If') {
                 $elt = 'if ('.$elt->[1][0].') '.$elt->[1][1].'';
             } elsif ($elt->[0] eq 'Assg') {
                 $elt = ''.join(' ',$elt->[1][0],' = ',$elt->[1][1]).'';
             } elsif ($elt->[0] eq 'Call') {
                 $elt = 'call '.$elt->[1][0].'( '. $elt->[1][1].' )';
             } elsif ($elt->[0] eq 'ArgList') {
                 $elt = $elt->[1][0];#.'( '. $elt->[1][1].' )';
             } elsif ($elt->[0] eq 'ESeq') {
                 $elt = join(',',@{$elt->[1]});#.'( '. $elt->[1][1].' )';
             } elsif (scalar @{$elt}==2 and ref($elt->[1]) eq 'ARRAY') {
                 $elt = $elt->[0].'('.join(',',@{$elt->[1]}).')';
             }

         }  
    } 
    return $elt;

}


sub convert_hash_to_array {
 (my $where, my $elt) = @_;

    if ($where eq 'ARRAY_PRE') {
        if (ref($elt) eq 'HASH') {
            my @nelts = %{$elt};
             return \@nelts;
        } 
    } 
    return $elt;
}


