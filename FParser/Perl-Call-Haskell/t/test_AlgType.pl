#!/usr/bin/perl -w
use strict;
use v5.16;

use Call::Haskell import => 'TestAlgType( f1 , f2, f3 )', 
                    path => '.', 
                    clean => $ENV{CLEAN}, 
                    verbose => $ENV{VERBOSE}, 
                    perl_types => 'AlgType';

use Types;
use AlgType;

say "Type v1";
type my $v1= AlgType;
say "Bind v1";
bind $v1, MkAlgType("五",7188);
say 'Typed value $v1: '.show $v1;
say "Calling f1";
my $gr=f1($v1);
say "Untyped prim value from f1: ".show($gr);

say "\nType v2";
type my $v2= Int;
say "Bind v2";
bind $v2, 7188;
say 'Typed value $v2: '.show $v2;
say "Calling f2";
my $gr2=f2($v2);
say "Typed value from f2: ".show($gr2);

say "\nType v3";
type my $v3= AlgType;
say "Bind v3";
bind $v3,  MkAlgType("五！",599);
say 'Typed value $v3: '.show $v3;
say "Calling f3";
my $gr3=f3($v3);
say 'Typed value from f3: '.show($gr3);


