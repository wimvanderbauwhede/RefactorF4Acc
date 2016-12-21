package TestDynSub; # to be renamed Call::Haskell; also use a custom sub import, that's the whole point.
use warnings;
use strict;
use v5.16;

our $VERSION = '0.01';
@TestDynSub::ISA = qw(Exporter);


sub import {
    my ($hs, @import_list) = @_;
     
   my %config=(
      'import' => '',
      'path' => '.',
      'clean' => 0,
      'verbose' => 0
      );
     if (scalar @import_list == 1) {
      $config{'import'} =$import_list[0];
     } else {
        my %import_config = @import_list;     
        map { $config{lc($_)}=$import_config{$_} } keys(%import_config);
     }
    my $func_import_str=$config{'import'};              

    $func_import_str=~s/\s+//g;
    $func_import_str=~s/\)$//;

    my @func_imports =($func_import_str=~/\),/) ? split(/\),/,$func_import_str) : ($func_import_str);
    if (scalar @func_imports>1) {die "Sorry, at the moment you can only call functions from a single Haskell module\n"; }
    my $fq_func = shift @func_imports;
    (my $module, my $funclst)=split(/\(/,$fq_func);
    my @mfuncs = split(/,/,$funclst);
    
    for my $fn (@mfuncs) {
#die "FN:$fn"; 

# Now load the wrappers or create them if they don't exists

    if (not -e "$wd/_Call_Haskell/Wrappers/$fn.pm")  {
# create the sub
        my $code = <<"ENDW";
package CallHaskellWrappers::$fn;
use Exporter qw( import );
\@CallHaskellWrappers::${fn}::EXPORT = qw( $fn );
use Call::Haskell::ShowRead qw( showH readH );
 
sub $fn {
    my \$hs_type='$hs_arg_type';
    my $in_str = showH(\@_,$hs_type);
    my \$out_str=${fn}_ser(\$in_str);
    my \$res = readH(\$out_str);
    return \$res;
}
1;

ENDW

open my $SUB,'>',"$wd/_Call_Haskell/CallHaskellWrappers/$fn.pm";
print $SUB $code;
close $SUB;
    }   
        require "$wd/_Call_Haskell/CallHaskellWrappers/$fn.pm";
        eval("CallHaskellWrappers::$fn->import()");
     push @Call::Haskell::EXPORT, $fn;
    }
    Call::Haskell->export_to_level(1, 'Call::Haskell',@Call::Haskell::EXPORT );
}

sub f1_ser {
    print "f1_export CALLED!\n";
}

1;
