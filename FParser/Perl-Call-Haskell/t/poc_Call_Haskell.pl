#!/usr/bin/perl
# NOTE: On Mavericks, it MUST be /usr/bin/perl, NOT the MacPorts Perl!
use warnings;
use strict;
use v5.16;
use Call::Haskell import => 'ProcessStr( f1, f2, f3, f4 )' , path => '..', clean => 1, verbose => 1;
#use Call::Haskell 'ProcessStr( f2, f3 )';

# Going from Perl to C to Haskell with strings:
my $str= "Test string with newlines\nTest string with newlines\n";
say "Calling f2";
my $gr=f2($str);
#my $gr2=f2($gr);
print "[$gr]";
say "Calling f2, again";
my $gr2=f2($gr);
print "<$gr2>";
say "Calling f3";
say f3(3.1415);
say "Calling f1 with <$str>";
my $res =  f1($str,"OK!",16);
say "<$res>";
say "Calling f4";
say f4([1,2,3,4,5]);
