package RefactorF4Acc::Refactoring::Casts;
#
#   (c) 2010-now Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;

use vars qw( $VERSION );
$VERSION = "1.2.0";

use Carp;
use Data::Dumper;

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
_cast_annlines
create_cast_annlines
);

# Casting between types
# It might be better to pass the decl instead of just the type 
# FIXME: this does assume essentially kind=4
# returns a list of AnnLines with the code for the cast and an empty $info
sub _cast_annlines {
	my ( $to_type, $to_var, $from_type, $from_var ) = @_;
	if ( $from_type eq $to_type ) {
		return ["$to_var = $from_var"];    #,{"Assignment"=>1,'Indent'=>' ' x 6}]];
	} elsif ( $from_type eq 'integer' ) {
		if ( $to_type eq 'logical' ) {
			return __cast_integer_to_logical_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'real' ) {
			return __cast_integer_to_real_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'complex' ) {
			return __cast_integer_to_complex_annlines( $from_var, $to_var );
		}
	} elsif ( $from_type eq 'real' ) {
		if ( $to_type eq 'logical' ) {
			return __cast_real_to_logical_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'integer' ) {
			return __cast_real_to_integer_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'complex' ) {
			return __cast_real_to_complex_annlines( $from_var, $to_var );
		}
	} elsif ( $from_type eq 'logical' ) {
		if ( $to_type eq 'real' ) {
			return __cast_logical_to_real_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'integer' ) {
			return __cast_logical_to_integer_annlines( $from_var, $to_var );
		}
	} elsif ( $from_type eq 'complex' ) {
		if ( $to_type eq 'logical' ) {
			return __cast_complex_to_logical_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'integer' ) {
			return __cast_complex_to_integer_annlines( $from_var, $to_var );
		} elsif ( $to_type eq 'real' ) {
			return __cast_complex_to_real_annlines( $from_var, $to_var );
		}
	}
} # END of _cast_annlines

sub create_cast_annlines {
	my ( $to_type_decl, $to_var, $from_type_decl, $from_var ) = @_;
	my $to_type=$to_type_decl->{'Type'};
	my $from_type=$from_type_decl->{'Type'};	
	 my $annlines = [ map { ['      '.$_,{}] } @{_cast_annlines( $to_type, $to_var, $from_type, $from_var )} ];
	 return $annlines
} # END of create_cast_annlines

sub __cast_logical_to_integer_annlines {
	( my $v_logical, my $v_integer ) = @_;

	return [
		"if ($v_logical) then",
		"    $v_integer=1",
		'else',                #{'Else'=>1, 'Indent'=>' ' x 6}],
		"    $v_integer=0",    #{'Assignment' => 1, 'Indent'=>' ' x 6}],
		'end if'               #,{'EndIf'=>1, 'Indent'=>' ' x 6}]
	];
} # END of __cast_logical_to_integer_annlines

sub __cast_logical_to_real_annlines {
	( my $v_logical, my $v_real ) = @_;

	return [
		"if ($v_logical) then",    #{'If'=>1, 'Indent'=>' ' x 6 }],
		"    $v_real=1.0",         # {'Assignment' => 1, 'Indent'=>' ' x 6}],
		'else',                    #{'Else'=>1, 'Indent'=>' ' x 6}],
		"    $v_real=0.0",         #{'Assignment' => 1, 'Indent'=>' ' x 6}],
		'end if'                   #,{'EndIf'=>1, 'Indent'=>' ' x 6}]
	];
}

sub __cast_integer_to_logical_annlines {
	( my $v_integer, my $v_logical ) = @_;
	return ["$v_logical = ($v_integer /= 0)"];    #,{"Assignment"=>1,'Indent'=>' ' x 6}]];
}

sub __cast_integer_to_real_annlines {
	( my $v_real, my $v_integer ) = @_;
	return ["$v_real = real($v_integer)"];        #,{'Assignment'=>1,'Indent'=>' ' x 6}]];
}

sub __cast_real_to_logical_annlines {
	( my $v_real, my $v_logical ) = @_;
	return ["$v_logical = ($v_real /= 0.0)"];     #,{"Assignment"=>1,'Indent'=>' ' x 6}]];
}

sub __cast_real_to_integer_annlines {
	( my $v_real, my $v_integer ) = @_;
	return ["$v_integer = int($v_real)"];         #,{'Assignment'=>1,'Indent'=>' ' x 6}]];
}

sub __cast_integer_to_complex_annlines { my ( $from_integer, $to_complex ) = @_;
	return ["$to_complex = cmplx($from_integer)"];
}

sub __cast_real_to_complex_annlines { my ( $from_real, $to_complex ) = @_;
	# This is dodgy because it only works if that real is a 2-element array
	if ($from_real!~/\(/) {
		return ["$to_complex = cmplx($from_real(1),$from_real(2))"];
	} else {
		my $imag_part = $from_real;
		$imag_part =~s/\)$/+1)/;
		return ["$to_complex = cmplx($from_real,$imag_part)"];
	}
}

sub __cast_complex_to_logical_annlines { my ( $from_complex, $to_logical ) = @_;	
	return ["$to_logical = ($from_complex /= (0,0))"];    #,{"Assignment"=>1,'Indent'=>' ' x 6}]];
}
		
sub __cast_complex_to_integer_annlines { my ( $from_complex, $to_integer ) = @_;
	return ["$to_integer = int($from_complex)"];
	
	if ($to_integer!~/\(/) {
		return ["$to_integer(1) = int($from_complex)","$to_integer(2) = int(aimag($from_complex))"];
	} else {
		my $imag_part = $to_integer;
		$imag_part =~s/\)$/+1)/;
		return ["$to_integer = int($from_complex)","$imag_part = int(aimag($from_complex))"];
	}	
	
}
sub __cast_complex_to_real_annlines { my ( $from_complex, $to_real ) = @_;
	if ($to_real!~/\(/) {
		return ["$to_real(1) = real($from_complex)","$to_real(2) = aimag($from_complex)"];
	} else {
		my $imag_part = $to_real;
		$imag_part =~s/\)$/+1)/;		
		return ["$to_real = real($from_complex)","$imag_part = aimag($from_complex)"];
	}
}

1;

