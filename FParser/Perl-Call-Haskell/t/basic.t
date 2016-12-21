use strict;
use Test::More tests => 4;
use Call::Haskell import => 'ProcessStr( f1, f2, f3, f4 )', path => '..';

system('rm -Rf _Call_Haskell/ _Inline/');
my $str= "Test string with newlines\nTest string with newlines\n";
my $res2='From Haskell: <Test string with newlines
Test string with newlines
>
';
ok( f1($str,"OK!",16) eq 'Test string withOK!', 'String -> String -> Int -> String');
ok( f2($str) eq $res2, 'String -> String');
ok( f3(3.1415) == 1, 'Float -> Int');
ok( f4([1,2,3,4]) == 24, '[Int] -> Int');

done_testing;
