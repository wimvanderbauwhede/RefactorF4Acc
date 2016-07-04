#!/usr/bin/perl
# NOTE: On Mavericks, it MUST be /usr/bin/perl, NOT the MacPorts Perl!
use warnings;
use strict;
use v5.16;
use Call::Haskell import => 'F95StatementParser( parseF95Statement )' , path => '.', packages => [], clean => 1, verbose => 0;
use Data::Dumper;
# Going from Perl to C to Haskell with strings:
my $str= "var = v(42)+w(2*i+j)\n";
my $context = "[\"v\",1]";
my $res =  parseF95Statement($str,$context);
$res=~s/\{.+?\}//g;
$res=~s/fromList\s\[\]//g;
$res=~s/\(,?\)//g;
$res=~s/\s+/ /g;
$res=~s/\s\)/)/g;
say Dumper($res);
