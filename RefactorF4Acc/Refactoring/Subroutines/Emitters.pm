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
		my $args_ref = $info->{'Signature'}{'Args'}{'List'};	    	    
	    my $args_str = join( ',', @{$args_ref} );	 
	    my $indent = $info->{'Indent'} // ' ' x 6;   
	    
	    my $code_unit = (exists $info->{'Signature'}{'Function'} and $info->{'Signature'}{'Function'}==1) ? 'function' 
	    : exists $info->{'Signature'}{'Program'} ? 'program'
	    : exists $info->{'Signature'}{'BlockData'} ? 'subroutine' #block data'
	    : exists $info->{'Signature'}{'Entry'} ? 'entry'
	    : 'subroutine';
	    my $maybe_characteristic = exists $info->{'Signature'}{'Characteristic'} ? $info->{'Signature'}{'Characteristic'}.' ' : '';
	     my $maybe_returntype = exists $info->{'Signature'}{'ReturnType'} ? $info->{'Signature'}{'ReturnType'}.' ' : '';
	     my $maybe_returntypeattr = (exists $info->{'Signature'}{'ReturnTypeAttr'} and $info->{'Signature'}{'ReturnTypeAttr'} ne '')  
	     ? '*'.$info->{'Signature'}{'ReturnTypeAttr'}.' ' : '';
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
	    $info->{'Ann'}=[annotate($name, __LINE__ ) ];
		return ( $indent . $rline , $info );
} # END of emit_subroutine_sig

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
	my @call_args = $info->{'SubroutineCall'}{'Args'}{'List'};
    my @call_exprs   = map { $info->{'SubroutineCall'}{'Args'}{'Set'}{$_}{'Expr'} } @call_args;
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
    $info->{'Ann'} = [annotate($f, __LINE__)];
    return ($indent . $maybe_label . $rline, $info);
}    # END of emit_subroutine_call


1;
