package RefactorF4Acc::Refactoring::Subroutines::Emitters;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw( annotate );

use vars qw( $VERSION );
$VERSION = "1.2.0";

use Carp;
use Data::Dumper;

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
    emit_subroutine_sig
	emit_end_subroutine
	emit_subroutine_call
);

# TODO move more emitters to this package

#@ Signature =>
#@    Args =>
#@        List => [...]
#@        Set => {}
#@    Name => $name;
#@    Function  => $bool
#@    Program  => $bool
#@    Entry  => $bool
#@    BlockData  => $bool
#@    ReturnType => integer | real | ...
#@    ResultVar => $result_var
#@    Characteristic => pure | elemental | recursive

sub emit_subroutine_sig { #(my $stref, my $f,
        (my $annline)=@_;
	    (my $line, my $info) = @{ $annline };

        #my $Sf        = $stref->{'Subroutines'}{$f};

	    my $name = $info->{'Signature'}{'Name'};
		if ($Config{'SUB_SUFFIX'} ne '' ) {
			$name.=$Config{'SUB_SUFFIX'};
		}
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};
		# croak Dumper($args_ref) if $name eq 'fs303';
	    my $args_str = join( ',', @{$args_ref} );
	    my $indent = $info->{'Indent'} // ' ' x 6;

	    my $code_unit = (exists $info->{'Signature'}{'Function'} and $info->{'Signature'}{'Function'}==1) ? 'function'
	    : exists $info->{'Signature'}{'Program'} ? 'program'
	    : exists $info->{'Signature'}{'BlockData'} ? 'subroutine' #block data'
	    : exists $info->{'Signature'}{'Entry'} ? 'entry'
	    : 'subroutine';
	    my $maybe_characteristic = exists $info->{'Signature'}{'Characteristic'}
			? join(' ',sort keys %{$info->{'Signature'}{'Characteristic'}}).' '
			: '';
	     my $maybe_returntype = exists $info->{'Signature'}{'ReturnType'} ?
		 (
			 exists $info->{'Signature'}{'ReturnTypeAttr'} and
			 $info->{'Signature'}{'ReturnTypeAttr'} ne ''
			 )
	     ? $info->{'Signature'}{'ReturnType'}
		 : $info->{'Signature'}{'ReturnType'}.' '
		 : '';
	     my $maybe_returntypeattr = (
			 exists $info->{'Signature'}{'ReturnTypeAttr'} and
			 $info->{'Signature'}{'ReturnTypeAttr'} ne ''
			 )
	     ? $info->{'Signature'}{'ReturnTypeAttr'} =~/=/
		 	?'('.$info->{'Signature'}{'ReturnTypeAttr'}.') '
		 	:'*'.$info->{'Signature'}{'ReturnTypeAttr'}.' '
		 : '';
	     my $maybe_resultvar = exists $info->{'Signature'}{'ResultVar'} ? ' result '.$info->{'Signature'}{'ResultVar'} : '';

	    my $rline =   exists $info->{'Signature'}{'Program'}  ? "$code_unit $name"
	    : exists $info->{'Signature'}{'BlockData'} ? "$code_unit $name($args_str)"
	    : "$maybe_characteristic$maybe_returntype$maybe_returntypeattr$code_unit $name($args_str)$maybe_resultvar";

		if ( exists $info->{'PlaceHolders'} ) {
			while ($rline =~ /(__PH\d+__)/) {
				my $ph=$1;
				my $ph_str = $info->{'PlaceHolders'}{$ph};
				$rline=~s/$ph/$ph_str/;
			}
            $info->{'Ref'}++;
        }
	    push @{$info->{'Ann'}},annotate($name, __LINE__ ) ;

		return ( $indent . $rline , $info );
} # END of emit_subroutine_sig

# If there is a SUB_SUFFIX, change the $annline to match it
sub emit_end_subroutine { my ( $annline) = @_;
	my ($line, $info) = @{$annline};
	my $name = $info->{'EndSubroutine'}{'Name'};
	if ($Config{'SUB_SUFFIX'} ne '' ) {
		$name.=$Config{'SUB_SUFFIX'};
		$line.=$Config{'SUB_SUFFIX'};
	}
    $info->{'EndSubroutine'}{'Name'} = $name;
    $info->{'Block'}{'Name'} = $name;
	$info->{'Block'}{'InBlock'}{'Name'} = $name;
	$annline = [$line,$info];
	return $annline;
} #END of emit_end_subroutine
# ================================================================================================================================================
# This is fairly generic and assumes the updated call args are DeclaredOrigArgs
# But an Emitter should really only turn an AST into source code, so what is happening here?

sub emit_subroutine_call {
    (my $stref, my $f, my $annline) = @_;
	# We need $Sf to know if a Label was referenced
	my $Sf   = $stref->{'Subroutines'}{$f};

    (my $line, my $info) = @{$annline};

    my $name = $info->{'SubroutineCall'}{'Name'};

    my $indent = $info->{'Indent'} // '      ';
    my $maybe_label =
      (exists $info->{'Label'} and exists $Sf->{'ReferencedLabels'}{$info->{'Label'}}) ? $info->{'Label'} . ' ' : '';
	my @call_args = @{$info->{'SubroutineCall'}{'Args'}{'List'}};
    my @call_exprs   = map {
		# WV 2021-06-09 This is a HACK, an element in List MUST be in Set, FIXME!
			if (exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$_}
			and exists $info->{'SubroutineCall'}{'Args'}{'Set'}{$_}{'Expr'}
			) {
				$info->{'SubroutineCall'}{'Args'}{'Set'}{$_}{'Expr'}
			} else {
				$_
			}
		} @call_args;
    my $args_str         = join(',', @call_exprs);
    my $rline            = "call $name($args_str)\n";

    if (exists $info->{'PlaceHolders'}) {
        while ($rline =~ /(__PH\d+__)/) {
            my $ph     = $1;
            my $ph_str = $info->{'PlaceHolders'}{$ph};
            $rline =~ s/$ph/$ph_str/;
        }
        $info->{'Ref'}++;
    }
    push @{$info->{'Ann'}},annotate($name, __LINE__ ) ;
    return ($indent . $maybe_label . $rline, $info);
}    # END of emit_subroutine_call


1;
