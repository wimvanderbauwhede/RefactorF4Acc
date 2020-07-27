package RefactorF4Acc::Analysis::Arrays;
#
#   (c) 2010-now Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::ExpressionAST::Evaluate qw( eval_expression_with_parameters );
use RefactorF4Acc::Utils qw( in_nested_set add_var_decl_to_set remove_var_decl_from_set pp_annlines );

use RefactorF4Acc::Parser::Expressions qw( parse_expression_no_context );
use RefactorF4Acc::Analysis::Arguments qw( create_RefactoredArgs );

use vars qw( $VERSION );
$VERSION = "2.1.1";

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
calculate_array_size
get_array_rank
calculate_multidim_indices_from_linear
dim_to_str
);


sub calculate_array_size {
	my ( $stref, $f, $dim ) = @_;
	my @sz_strs = ();
	for my $entry ( @{$dim} ) {
		my $sz_str = '((' . $entry->[1] . ') - (' . $entry->[0] . ')+1)';
		push @sz_strs, $sz_str;
	}
	my $tot_sz_str = join( '*', @sz_strs );
	# $tot_sz_str=~s/\-/ - /g;
	# say $tot_sz_str;
	my $size = 0;
	# If there are unresolved vars, we return 0
	if ($tot_sz_str!~/[a-z]/){
		$size = eval_expression_with_parameters( $tot_sz_str, {}, $stref, $f );
	} 
	return $size;
}    # END of calculate_array_size

sub get_array_rank { (my $dim)=@_;
	return scalar @{$dim};
} # END of get_array_rank

# Given the linear index (starting at 1) in an array
# and its dimensions and offsets
# return the n-dim coordinate for that index
sub calculate_multidim_indices_from_linear {
	my ( $stref, $f, $dim_rec, $lin_sz ) = @_;

	#            integer, intent(In) :: lin_sz, n_dims
	#            integer, dimension(n_dims),intent(In) :: dims, offsets
	#            integer, dimension(n_dims), intent(Out) :: coords
	#            integer, dimension(n_dims-1) :: mm
	#            integer :: ii, jj, p_dims, sz
	( my $dims, my $offsets ) = __calc_dims_offsets( $stref, $f, $dim_rec );
	my $coords   = [];
	my $sz       = $lin_sz;
	my @tmp_dims = @{$dims};
	my $n_dims   = scalar @tmp_dims;
	my $p_dims   = 1;
	map { $p_dims *= $_ } @tmp_dims;

	for my $ii ( 1 .. $n_dims - 1 ) {
		my $div_dim = shift @tmp_dims;
		croak $f if $DBG and $div_dim==0 or $p_dims==0; 
		$p_dims /= $div_dim;
		$coords->[ $ii - 1 ] = int( $sz / $p_dims ) + $offsets->[ $ii - 1 ];
		$sz %= $p_dims;
	}
	$coords->[ $n_dims - 1 ] = $sz + $offsets->[ $n_dims - 1 ] - 1;    # The "-1" is because $lin_sz starts at 1 for the first element, not 0
	return $coords;
}    # END of calculate_multidim_indices_from_linear

# $dims is an array of the sizes of each dimension
# $offsets is an array of the offsets each dimension
sub __calc_dims_offsets {
	my ( $stref, $f, $dim_rec ) = @_;
	my $offsets = [];
	my $dims    = [];
	my @sz_strs = ();
	for my $entry ( @{$dim_rec} ) {
		my $offset_val =
		  eval_expression_with_parameters( $entry->[0], {}, $stref, $f );
		push @{$offsets}, $offset_val;
		my $dim_str = '((' . $entry->[1] . ') - (' . $entry->[0] . ')+1)';
		my $dim_val = eval_expression_with_parameters( $dim_str, {}, $stref, $f );
		push @{$dims}, $dim_val;
	}
	return ( $dims, $offsets );
}    # END of __calc_dims_offsets

sub dim_to_str {
	( my $dim ) = @_;
	return join( ',', map { $_->[0] . ':' . $_->[1] } @{$dim} );
} # END of dim_to_str 

1;

