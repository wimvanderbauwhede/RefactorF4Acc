package CallHaskellWrappers::parseF95Decl;
use Exporter qw( import );
@CallHaskellWrappers::parseF95Decl::EXPORT = qw( parseF95Decl );

use Call::Haskell::ReadShow qw( showH readH );
require Call::Haskell; 
sub parseF95Decl {
    my $hs_type='String';
    my $in_str = Call::Haskell::ReadShow::showH(@_,$hs_type);
    my $out_str=Call::Haskell::parseF95Decl_ser($in_str);
    my $res = Call::Haskell::ReadShow::readH($out_str);
    return $res;
}

