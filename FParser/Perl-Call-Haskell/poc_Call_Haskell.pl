#!/usr/bin/perl
# NOTE: On Mavericks, it MUST be /usr/bin/perl, NOT the MacPorts Perl!
use warnings;
use strict;
use v5.16;
use Call::Haskell functions => 'ProcessStr( f1, f2, f3 )' , inc => '.', clean => 0, verbose => 0 ;
#use Call::Haskell 'ProcessStr( f2, f3 )';

# Going from Perl to C to Haskell with strings:
my $str= "Test string with newlines\nTest string with newlines\n";
my $gr=f2($str);
#my $gr2=f2($gr);
print $gr;
my $gr2=f2($gr);
print $gr2;
say f3(3.1415);
my $res =  f1($str,"OK!",16);
say $res;
