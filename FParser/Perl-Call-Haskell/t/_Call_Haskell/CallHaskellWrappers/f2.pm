package CallHaskellWrappers::f2;
use Exporter qw( import );
@CallHaskellWrappers::f2::EXPORT = qw( f2 );

use Call::Haskell::ReadShow qw( showH readH );       
use Types;
use AlgType;
require Call::Haskell; 
sub f2 {
    my $hs_type='Int';
#    my $in_str = '';
    my @in_arg_strs=();
    for my $arg (@_) {
        if (ref($arg) eq 'Types') {    
            push @in_arg_strs, Types::show($arg);
        } else {
           push @in_arg_strs,  Call::Haskell::ReadShow::showH($arg,$hs_type);
        }
    }
    my $in_str = (@_>1) ? '('.join(', ',@in_arg_strs).')' : $in_arg_strs[0];     
    my $out_str=Call::Haskell::f2_ser($in_str);    
    my $res = eval($out_str);
    return $res;
}

1;
