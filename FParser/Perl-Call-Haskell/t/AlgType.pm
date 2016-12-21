package AlgType;
use Exporter 'import';
our @EXPORT=qw( AlgType MkAlgType);

use Types;

sub AlgType { typename }
sub MkAlgType { newtype AlgType, Record(String,Int), @_ }

