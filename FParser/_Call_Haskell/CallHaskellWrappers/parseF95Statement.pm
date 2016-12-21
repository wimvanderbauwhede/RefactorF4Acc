package CallHaskellWrappers::parseF95Statement;
use Exporter qw( import );
@CallHaskellWrappers::parseF95Statement::EXPORT = qw( parseF95Statement );

use Call::Haskell::ReadShow qw( showH readH );
require Call::Haskell; 
sub parseF95Statement {
    my $hs_type='String';
    my $in_str = Call::Haskell::ReadShow::showH(@_,$hs_type);
    my $out_str=Call::Haskell::parseF95Statement_ser($in_str);
    my $res = Call::Haskell::ReadShow::readH($out_str);
    return $res;
}

