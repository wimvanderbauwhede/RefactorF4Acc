#!/usr/bin/perl
# NOTE: On Mavericks, it MUST be /usr/bin/perl, NOT the MacPorts Perl!
use warnings;
use strict;
use v5.16;
use Call::Haskell import => 'GetVarNamesFromExpr( getVarNamesFromExpr )' , path => '.', packages => [], clean => 1, verbose => 1;
use Data::Dumper;
# Going from Perl to C to Haskell with strings:
my $str= "\"var = v(42)+w(2*i+j)\n\"";
my $res =  getVarNamesFromExpr($str);
say Dumper($res);
