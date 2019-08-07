package RefactorF4Acc::Translation::TyTra::Common;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Carp;
use Data::Dumper;


use Exporter;

@RefactorF4Acc::Translation::TyTra::Common::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::Common::EXPORT_OK = qw(
&pp_links  
&__isMainInArg 
&__isMainOutArg  
&F1D2C 
&F2D2C 
&F3D2C 
&F4D2C
);

# What we need is the in and out tuples
# i.e. keys %{$links} = OUT
# union of vals is IN
sub pp_links { (my $links)=@_;
	my $in_tup_table={};
	for my $lhs_var (sort keys %{$links}) {
#		print "$lhs_var => ";
		my @rhs_vars=();
		for my $lvar (sort keys %{$links->{$lhs_var}} ){
			push @rhs_vars,$lvar;
			$in_tup_table->{$lvar}=1;
		}
#		say join(', ',@rhs_vars);
	}
	my $out_tup = [ sort keys  %{$links} ];
	my $in_tup = [ sort keys  %{$in_tup_table} ];
	return ($out_tup, $in_tup);
} # END of pp_links()




sub __isMainInArg { (my $var_rec, my $stref) = @_;
    (my $var_name, my $ctr, my $ext) = @{$var_rec};
    my $orig_args = $stref->{$stref->{'EmitAST'}}{'OrigArgs'};

    #   say "TEST IN: $var_name $ctr <> 0 <$ext> <".(exists $orig_args->{$var_name} ) .">";
    return (
        $ctr == 0
        && $ext eq ''
        && ( exists $orig_args->{$var_name} )
        && (( $orig_args->{$var_name} eq 'in')
            || ( $orig_args->{$var_name} eq 'inout'))

    ) ? 1 : 0;
} # END of __isMainInArg()

sub __isMainOutArg { (my $var_rec, my $stref) = @_;
    (my $var_name, my $ctr, my $ext) = @{$var_rec};
    my $tytracl_ast = $stref->{$stref->{'EmitAST'}};
    my $orig_args = $tytracl_ast->{'OrigArgs'};


# say "TEST OUT: $var_name $ctr ";# <> ".$tytracl_ast->{'UniqueVarCounters'}{$var_name}." <$ext> <".(exists $orig_args->{$var_name} ) .">";
    return (
        $ctr ==  $tytracl_ast->{'UniqueVarCounters'}{$var_name}
        && $ext eq ''
        && ( exists $orig_args->{$var_name} )
        && (( $orig_args->{$var_name} eq 'inout')
            || ( $orig_args->{$var_name} eq 'out'))
    ) ? 1 : 0;
} # END of __isMainOutArg()



sub F3D2C { (
         my $i_rng, my $j_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, # lower bounds
        my $ix, my $jx, my $kx
        ) =@_;
    return ($i_rng*$j_rng*($kx-$k_lb)+$i_rng*($jx-$j_lb)+$ix-$i_lb);
}

sub F2D2C { (
         my $i_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, # lower bounds
        my $ix, my $jx
        ) =@_;
    return ($i_rng*($jx-$j_lb)+$ix-$i_lb);
}


sub F1D2C { (
        my $i_lb, #// lower bounds
        my $ix
        ) = @_;
    return $ix-$i_lb;
}

sub F4D2C { (
         my $i_rng, my $j_rng,  my $k_rng, # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, my $l_lb, # lower bounds
        my $ix, my $jx, my $kx, my $lx
        ) = @_;
    return ($i_rng*$j_rng*$k_rng*($lx-$l_lb)+
            $i_rng*$j_rng*($kx-$k_lb)+
            $i_rng*($jx-$j_lb)+
            $ix-$i_lb
            );
}

1;
