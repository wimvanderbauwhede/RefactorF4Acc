package TestDynSub::Dynamic::f1;
use Exporter qw( import );
@TestDynSub::Dynamic::f1::EXPORT = qw( f1 );
use Data::MessagePack;
my $mp = Data::MessagePack->new();
#$mp->canonical->utf8->prefer_integer if $needed;
require TestDynSub; 
sub f1 {
    my $in_str=$mp->pack(\@_);
    my $out_str=TestDynSub::f1_export($in_str);
    my $res = $mp->unpack($out_str);
    return $res;
}
1;

