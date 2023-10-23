package RefactorF4Acc::Refactoring::EvalParamExprs;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw(
	pass_wrapper_subs_in_module
	stateful_pass_inplace
	stateful_pass_reverse_inplace
	stateless_pass_inplace
	emit_f95_var_decl
	splice_additional_lines_cond_inplace
	);

use RefactorF4Acc::Parser::Expressions qw(
	parse_expression
	get_vars_from_expression
	);

#
#   (c) 2019 Wim Vanderbauwhede <wim.vanderbauwede@glasgow.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::EvalParamExprs::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::EvalParamExprs::EXPORT_OK = qw(
	&eval_param_expressions_all
);

sub eval_param_expressions_all { my ($stref) = @_;
	die "eval_param_expressions_all() is BROKEN for module parameters, only works for local parameters. Needs a complete rework. Set EVAL_PARAM_EXPRS=1 in rf4a config file.\n";
	# So I should do this for all modules as well
	# One way is to check if a subroutine 
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        next unless (defined $f and $f ne '' and $f ne 'UNKNOWN_SRC1');
		# say "SUB: $f";
		$stref = _eval_param_expressions($stref, $f);
	}
	return $stref;
} # END of eval_param_expressions_all

# This pass takes the annlines for parameter declarations and evaluates the ones that have expressions
# It returns new annlines in RefactoredCode
# We use stateful_pass_inplace to get the parameter declarations
# Then for each of these we print the value of the parameter
# we collect these values and update the annlines
# I could updated the decl in LocalParameters but I would do that using a new field EvaledVal
# Then I can change the emitter to use this field if it exists
# Then I used another  stateful pass to update the annlines
sub _eval_param_expressions { my ($stref, $f) = @_;

    my $pass_get_param_decls = sub  {
		(my $annline, my $state)=@_;
		(my $line,my $info)=@{$annline};

		if (exists $info->{'ParamDecl'}) {
		    push @{$state},$annline;
		}
		return ([$annline],$state);
    };

    my $param_annlines = [];
    ($stref,$param_annlines) = stateful_pass_inplace( $stref, $f, $pass_get_param_decls, $param_annlines, 'pass_get_param_decls' );
	if ( scalar @{$param_annlines} > 0 ) {
    # Now actually evaluate those
		my $vars_vals = _eval_f77_param_exprs($stref, $f, $param_annlines);

    	my $pass_replace_param_decls = sub  {
			(my $annline, my $vars_vals)=@_;
			(my $line,my $info)=@{$annline};
			my $new_annlines = [$annline];
			if (exists $info->{'ParamDecl'}) {
				my $param_name = ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY'
				? $info->{'ParamDecl'}{'Name'}[0]
				: $info->{'ParamDecl'}{'Name'};
				my $param_decl= $stref->{'Subroutines'}{$f}{'LocalParameters'}{'Set'}{$param_name};
				if ( exists $param_decl->{'Indent'}) {


				# say Dumper( $info) if $param_name eq 'pi';
				my $val = $vars_vals->{$param_name};
				$param_decl->{'Val'}=$val; # This will update the decl record as well!
				$new_annlines =[
					# [$line, $info]
					[emit_f95_var_decl($param_decl), $info]
				];
				} else {
					carp "Could not find the record for $param_name, not evaluated" if $DBG;
				}
			}
			return ($new_annlines,$vars_vals);
		};

	    ($stref,$vars_vals) = stateful_pass_inplace( $stref,  $f, $pass_replace_param_decls, $vars_vals, 'pass_replace_param_decls' );

		# Maybe I need to update LocalParameters here too
	}
    return $stref;
} # END of _eval_param_expressions

# We write this to a file,
# compile it
# run it
sub _eval_f77_param_exprs { my ($stref, $f, $param_decl_lines)=@_;

    my @eval_program_lines = ('program eval');
    for my $param_decl_line (@{$param_decl_lines}) {
		# say Dumper $param_decl_line->[1]{'ParamDecl'};
		my $param_name = ref($param_decl_line->[1]{'ParamDecl'}{'Name'}) eq 'ARRAY'
		? $param_decl_line->[1]{'ParamDecl'}{'Name'}[0]
		: $param_decl_line->[1]{'ParamDecl'}{'Name'} ;
		my $param_decl = $stref->{'Subroutines'}{$f}{'LocalParameters'}{'Set'}{$param_name};
		my $new_param_decl_line = emit_f95_var_decl($param_decl_line->[1]{'ParamDecl'});
        push @eval_program_lines,$new_param_decl_line; #$param_decl_line->[0];
    }
	my @param_names=();
    for my $param_decl_line (@{$param_decl_lines}) {
        my $param_name = ref($param_decl_line->[1]{'ParamDecl'}{'Name'}) eq 'ARRAY'
		? $param_decl_line->[1]{'ParamDecl'}{'Name'}[0]
		: $param_decl_line->[1]{'ParamDecl'}{'Name'};
		push @param_names, $param_name;
    	push @eval_program_lines,"print *, $param_name";
    }
    push @eval_program_lines,'end program';

    open my $EVP, '>', 'eval.f' or dir $!;
    for my $eval_program_line (@eval_program_lines) {
        say $EVP $eval_program_line;
    }
    close $EVP;
# TODO: check if it compiled correctly
    my $compilation_cmd = $ENV{'FC'}.' eval.f -ffree-form -ffree-line-length-0 -o _eval';
	my $res = `$compilation_cmd`;
	# check $res

	my $vars_vals={};
    my @vals = `./_eval`;
	# clean this up
	@vals = map {s/^\s*//;s/\s*$//;chomp $_;$_} @vals;

	for my $param_name (@param_names){
		my $val = shift @vals;
		$vars_vals->{$param_name}=$val;
	}
	# carp Dumper $vars_vals;
    unlink './_eval';
	unlink './eval.f';
	# Should return a hash var => val
    return $vars_vals;
} # END of _eval_f77_param_exprs

1;
