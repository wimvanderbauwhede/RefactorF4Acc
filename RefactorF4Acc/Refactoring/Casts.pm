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
use RefactorF4Acc::Utils qw( annotate );

use vars qw( $VERSION );
$VERSION = "2.1.1";

use Carp;
use Data::Dumper;

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
_cast_annlines
create_cast_annlines
cast_call_argument
);

# More utter evil
#   integer fnami (33) ! 33*4
#   character*132 fname 
#   equivalence (fname,fnami)
# create_cast_annlines :: (Decl,VarStr) -> (Decl, VarStr) -> [AnnLine]
sub create_cast_annlines {
	my ( $to_type_decl, $to_var, $from_type_decl, $from_var ) = @_;
	my $to_type = $to_type_decl->{'Type'};
	my $to_kind = $to_type_decl->{'Attr'};
	$to_kind =~s/^\w+\s*=\s*//;
	my $from_type=$from_type_decl->{'Type'};
	my $from_kind = $from_type_decl->{'Attr'};
	$from_kind =~s/^\w+\s*=\s*//;	
	# Indent with a fixed 6 spaces. TODO
	 my $annlines = [ map { [ '      '.$_->[0], $_->[1] ] } @{_cast_annlines( $to_type, $to_var, $from_type, $from_var )} ];
	 return $annlines
} # END of create_cast_annlines

# Casting between types
# It might be better to pass the decl instead of just the type 
# FIXME: this does assume essentially kind=4
# _cast_annlines :: (TypeStr, VarStr) -> (TypeStr, VarStr) -> [AnnLine]
# returns a list of AnnLines with the code for the cast and an empty $info
sub _cast_annlines {	
	my ( $to_type, $to_var, $from_type, $from_var ) = @_;
	if ( $from_type eq $to_type ) {
		return [
			[
				"$to_var = $from_var",
				_assignment_info($to_var,[$from_var])
			]
		];
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

sub cast_call_argument {
	my ( $sig_type, $sig_kind, $call_type, $call_arg ) = @_;
	if ( $call_type eq $sig_type ) {
		return $call_arg;
	} elsif ( $call_type eq 'integer' ) {
		if ( $sig_type eq 'logical' ) {
			return "$call_arg /= 0";
		} elsif ( $sig_type eq 'real' ) {
			return "real($call_arg,$sig_kind)";			
		} elsif ( $sig_type eq 'complex' ) {
			return "cmplx($call_arg)";
		}
	} elsif ( $call_type eq 'real' ) {
		if ( $sig_type eq 'logical' ) {
			croak if $DBG and $call_arg eq '.true.';
			return "$call_arg /= 0.0";
		} elsif ( $sig_type eq 'integer' ) {
			return "int($call_arg, $sig_kind)"
		} elsif ( $sig_type eq 'complex' ) {
			return  "cmplx($call_arg)";
		}
	} elsif ( $call_type eq 'logical' ) {
		if ( $sig_type eq 'real' ) {
			return $call_arg;
		} elsif ( $sig_type eq 'integer' ) {
			return $call_arg;
		}
	} elsif ( $call_type eq 'complex' ) {
		if ( $sig_type eq 'logical' ) {
			return "$call_arg /= (0.0,0.0)"
		} elsif ( $sig_type eq 'integer' ) {
			return "int($call_arg)";
		} elsif ( $sig_type eq 'real' ) {
			return "real($call_arg)";
		}
	} else { # Can't handle, just return
		return $call_arg;
	}
} # END of cast_call_argument




sub _assignment_info { my ($lhs_var, $rhs_vars) = @_; 
	return {
		'Assignment'=>1,
		'HasVars'=>1,
		'Rhs' =>{
			'Vars' => {
				'List'=> $rhs_vars,
				'Set' => {}
			},
		},
		'Lhs' => {
			'VarName'=>$lhs_var,
			'IndexVars'=> {
				'List'=>[]
			}		
		},
		'Indent' => ' ' x 6,
		'ExCommonOrEquivalence'	=> 1,
		'Ann' => [ annotate('', __LINE__ .' caller to local' ) ]
	}
};

sub _ifthen_info { my ($cond_vars) = @_;
	return {
		'IfThen'=>1,
		'HasVars'=>1,		
		'CondVars' => {
				'List'=> $cond_vars,
				'Set' => {}
			},
		'Control' => 1,
		'Indent' => ' ' x 6,
		'ExCommonOrEquivalence'	=> 1
	}
};

our $_endif_info = {	
		'EndIf'=>1,
		'EndControl' => 1,
		'Indent' => ' ' x 6,
		'ExCommonOrEquivalence'	=> 1
};

our $_else_info = {
		'Else'=>1,
		'Control' => 1,
		'Indent' => ' ' x 6,
		'ExCommonOrEquivalence'	=> 1
};




sub __cast_logical_to_integer_annlines {
	( my $v_logical, my $v_integer ) = @_;

	return [
		["if ($v_logical) then",
		_ifthen_info($v_logical)
		],
		["    $v_integer=1",
		_assignment_info($v_integer,[])
		],
		['else', 
		$_else_info  ],
		["    $v_integer=0",
		_assignment_info($v_integer,[])
		],
		['end if', 
		$_endif_info]             
	];
} # END of __cast_logical_to_integer_annlines


sub __cast_logical_to_real_annlines {
	( my $v_logical, my $v_real ) = @_;

	return [
		["if ($v_logical) then",_ifthen_info($v_logical)],
		["    $v_real=1.0",_assignment_info($v_real,[])],
		['else',$_else_info],
		["    $v_real=0.0",_assignment_info($v_real,[])],
		['end if',$_endif_info]
	];
}

sub __cast_integer_to_logical_annlines {
	( my $v_integer, my $v_logical ) = @_;
	return [
		[
			"$v_logical = ($v_integer /= 0)",
			_assignment_info($v_logical,[$v_integer])
		]
	];
}

sub __cast_integer_to_real_annlines {
	( my $v_real, my $v_integer ) = @_;
	return [
		[
			"$v_real = real($v_integer)",
			_assignment_info($v_real,[$v_integer])
		]
	];
}

sub __cast_real_to_logical_annlines {
	( my $v_real, my $v_logical ) = @_;
	return [
		["$v_logical = ($v_real /= 0.0)",_assignment_info($v_logical,[$v_real])]
	]; 
}

sub __cast_real_to_integer_annlines {
	( my $v_real, my $v_integer ) = @_;
	return [
		["$v_integer = int($v_real)",_assignment_info($v_integer,[$v_real])]
	];
}

sub __cast_integer_to_complex_annlines { my ( $from_integer, $to_complex ) = @_;
	return [
		["$to_complex = cmplx($from_integer)",_assignment_info($to_complex,[$from_integer])]
		];
}

sub __cast_real_to_complex_annlines { my ( $from_real, $to_complex ) = @_;
	# This is dodgy because it only works if that real is a 2-element array
	if ($from_real!~/\(/) {
		return [
			["$to_complex = cmplx($from_real(1),$from_real(2))",_assignment_info($to_complex,[$from_real])]
		];
	} else {
		my $imag_part = $from_real;
		$imag_part =~s/\)$/+1)/;
		my $from_real_name=$from_real;
		$from_real_name=~s/\(.+$//;
		return [
			["$to_complex = cmplx($from_real,$imag_part)",_assignment_info($to_complex,[$from_real_name])]
		];
	}
}

sub __cast_complex_to_logical_annlines { my ( $from_complex, $to_logical ) = @_;	
	return [		
		["$to_logical = ($from_complex /= (0,0))",_assignment_info($to_logical,[$from_complex]) ]	
	];
}
		
sub __cast_complex_to_integer_annlines { my ( $from_complex, $to_integer ) = @_;
	return [
			["$to_integer = int($from_complex)",_assignment_info($to_integer,[$from_complex])]
	];
	
	# if ($to_integer!~/\(/) {
	# 	return ["$to_integer(1) = int($from_complex)","$to_integer(2) = int(aimag($from_complex))"];
	# } else {
	# 	my $imag_part = $to_integer;
	# 	$imag_part =~s/\)$/+1)/;
	# 	return ["$to_integer = int($from_complex)","$imag_part = int(aimag($from_complex))"];
	# }	
	
}
sub __cast_complex_to_real_annlines { my ( $from_complex, $to_real ) = @_;
	if ($to_real!~/\(/) {
		return [
			["$to_real(1) = real($from_complex)",_assignment_info($to_real,[$from_complex])],
			["$to_real(2) = aimag($from_complex)",_assignment_info($to_real,[$from_complex])]
		];
	} else {
		my $imag_part = $to_real;
		$imag_part =~s/\)$/+1)/;		
		return [
			["$to_real = real($from_complex)",_assignment_info($to_real,[$from_complex])],
			["$imag_part = aimag($from_complex)",_assignment_info($imag_part,[$from_complex])]
		];
	}
}

1;