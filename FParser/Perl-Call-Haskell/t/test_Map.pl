#!/usr/bin/perl
BEGIN {
push @INC, '../../Perl-TypeChecker';
}
# NOTE: On Mavericks, it MUST be /usr/bin/perl, NOT the MacPorts Perl!
use warnings;
use strict;
use v5.16;

use Call::Haskell import => 'TestMap( f1 , f2, f3 )' , path => '.', clean => 0, verbose => 0, perl_types => 1;

use Types;
use Data::Dumper;

say "Type v1";
type my $v1= Map( String,Int);
say "Bind v1";
bind $v1, {"k1" => 11, "k2" => 22 };
say "Calling f1";
my $gr=f1($v1);
say "From f1: ".Dumper($gr);

say "Type v2";
type my $v2= Int;
say "Bind v2";
bind $v2, 7188;
say "Calling f2";
my $gr2=f2($v2);
say "From f2: ".Dumper($gr2);

say "Type v3";
type my $v3= Map( String,Int);
say "Bind v3";
bind $v3, {"k1" => 11, "k2" => 22 };
say "Calling f3";
my $gr3=f3($v3);
say "From f3: ".Dumper($gr3);


