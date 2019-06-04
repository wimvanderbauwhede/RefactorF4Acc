package RefactorF4Acc::Analysis::CommonBlocks;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( eval_expression_with_parameters );
use RefactorF4Acc::Utils qw( in_nested_set );
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.2.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Analysis::CommonBlocks::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::CommonBlocks::EXPORT_OK = qw(
	&collect_common_vars_per_block
	&identify_common_var_mismatch
	&create_common_var_size_tuples
	&match_up_common_vars
);


# This is for Parser, so the result should a list of var names
#
sub collect_common_vars_per_block { my ($stref, $f, $common_decl_str_) = @_;	
#	say  "LINE2 $f: $common_decl_str_" if $f eq 'fm302';
#	die if $common_decl_str_=~/ivcn06/ and $f eq 'fm302';
    my %common_blocks = %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} };
    my $common_decl_str = $common_decl_str_;
    $common_decl_str=~s/common\s*//;
    $common_decl_str=~s/\s+$//;
    
    if ($common_decl_str!~/^\//) {
        $common_decl_str='BLANK/'.$common_decl_str;
    } else {
        $common_decl_str=~s/^\/\s*//;
        if($common_decl_str=~/^\s*\//) {
        	$common_decl_str='BLANK'.$common_decl_str;
        }
    }
    
    my  @common_chunks = split(/\s*\/\s*/,$common_decl_str);
#say  "\t => ".join(',',@common_chunks) if $f eq 'fm302';
    while (@common_chunks) {

        my $common_block_name = shift @common_chunks;
#        if ( $common_block_name eq '' or $common_block_name=~/^\s+$/) {  $common_block_name = 'BLANK';}

        if (not exists $common_blocks{$common_block_name}) {
            $common_blocks{$common_block_name}=[];
        }
        my $common_vars_str = shift @common_chunks;

        $common_vars_str=~s/,\s*$//;
        my @common_vars_strs = split(/\s*,\s*/,$common_vars_str);
        
        my @common_vars = grep {!/\)$/ } map { s/\(.+$// ;$_} @common_vars_strs ;
		$common_blocks{$common_block_name} =[ @{$common_blocks{$common_block_name}} ,@common_vars ];
    }
#    say Dumper(  %common_blocks  ) if $f eq 'fm302';
#    die if $common_decl_str_=~/ivcn06/ and $f eq 'fm302';
    $stref->{'Subroutines'}{$f}{'CommonBlocks'}={  %common_blocks };
    return $stref;
} # END of collect_common_vars_per_block

=pod
We need to identify if there is CommonVarMismatch or not

Given the two lists of common vars, one (the CalledSub one) needs to be a strict subset of the other (CallerSub). And all vars must be the same type and dimension, just the names is not good enough.

If it's the other way round, CallerSub strict subset of CalledSub, then we need to declare the extra vars in the Caller.
=cut

# For every subroutine, see if there is a mismatch with any of the callers.
sub identify_common_var_mismatch {
    my ($stref, $f) = @_;
#    say "CALLED SUB $f";
    if (exists  $stref->{'Subroutines'}{$f}{'Callers'}) {
		my $callers = $stref->{'Subroutines'}{$f}{'Callers'};
		# If there is more than one caller, we must do this for every caller
		for my $caller (sort keys %{ $stref->{'Subroutines'}{$f}{'Callers'} } ) {
#			say "CALLER $caller";	
		    for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} }) {
#		    	say "BLOCK $block";
		    	if (exists $stref->{'Subroutines'}{$caller}{'CommonBlocks'}{$block} ) {
		        my $called_sub_common_vars = $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block};
		        my $caller_sub_common_vars = $stref->{'Subroutines'}{$caller}{'CommonBlocks'}{$block};
		        if (scalar @{$called_sub_common_vars} <= scalar @{$caller_sub_common_vars}) {
		            for my $idx (0 .. scalar @{$called_sub_common_vars} - 1) {
		                my $called_sub_common_var = $called_sub_common_vars->[$idx];
		                my $caller_sub_common_var = $caller_sub_common_vars->[$idx];
#		                say "VARS: $called_sub_common_var $caller_sub_common_var"; 
		                if ($called_sub_common_var eq $caller_sub_common_var) {
		                    my $called_set = in_nested_set($stref->{'Subroutines'}{$f},'CommonVars',$called_sub_common_var);
		                    my $caller_set = in_nested_set($stref->{'Subroutines'}{$caller},'CommonVars',$caller_sub_common_var);
		                    my $called_sub_common_var_decl = $stref->{'Subroutines'}{$f}{$called_set}{'Set'}{$called_sub_common_var};
		                    my $caller_sub_common_var_decl = $stref->{'Subroutines'}{$caller}{$caller_set}{'Set'}{$caller_sub_common_var};
							if (not _compare_decls($stref, $f, $caller, $called_sub_common_var_decl,$caller_sub_common_var_decl) ) {
								$stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller}{$block}=1;
								last;
							}
		                } else {
		                    $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller}{$block}=1;
		                    last;
		                }
		            }
		        } else {
		            $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller}{$block}=1;
		        }
		    	}
		    	if (exists $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller}
			    	 and exists $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller}{$block}) {
			    		say "BLOCK $block in $f has CommonVarMismatch with $caller";
			    } else { 
			    		say "BLOCK $block in $f is matched with $caller: ".join(',',@{ $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block} });
			    }
		    	
		    } # block
		    if (scalar keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller} } == 0) { 
		    		say "All blocks in $f match with $caller, OK to use old approach";		    		
		    }
		} # caller
    }
#    for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} }) {
#    	
#    	if (defined $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}) {
#    	if (scalar keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block} } > 1 ) {
#    		croak "The subroutine $f is called from two different callers with mismatched COMMON blocks. Sorry, we're not handling this at the moment.";
#    	} else {    	
#    		my ( $caller, $one) = each( %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block} });
#    		$stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block} = $caller;
#    	}
#    	}
#    }
    return $stref;
} # END of identify_common_var_mismatch

sub _compare_decls { my ($stref, $f1, $f2, $decl1,$decl2,$report) = @_;
#	say Dumper($decl1, $decl2);
	my $names_match = $decl1->{'Name'} eq $decl2->{'Name'};
	return 0 unless $names_match;
	my $types_match = $decl1->{'Type'} eq $decl2->{'Type'};
	return 0 unless $types_match; 
	if (	$decl1->{'Attr'} =~/=/ and  $decl2->{'Attr'}!~/=/ or $decl1->{'Attr'} !~/=/ and  $decl2->{'Attr'}=~/=/) {
		carp "Attributes have different structure:".$decl1->{'Attr'} .'<>'. $decl2->{'Attr'};
	}
	my $attrs_match = $decl1->{'Attr'} eq $decl2->{'Attr'};
	return 0 unless $attrs_match; 
	my $a_or_s_match = $decl1->{'ArrayOrScalar'} eq $decl2->{'ArrayOrScalar'};
	return 0 unless $a_or_s_match;
	if ($decl1->{'ArrayOrScalar'} eq 'Array') {
		my $dim1= $decl1->{'Dim'}; 
		my $dim2= $decl2->{'Dim'}; 
#		say Dumper($dim1,$dim2);
		my $size1 = __calc_sz($stref,$f1, $dim1);
		my $size2 = __calc_sz($stref,$f2, $dim2);
		my $dims_match = $size1 == $size2;
		return 0 unless $dims_match;
	}		
	return 1;
} # END of _compare_decls

sub __calc_sz {my ($stref, $f, $dim) = @_;
	my @sz_strs=();
	for my $entry ( @{$dim} ) {
		 my $sz_str = '('.$entry->[1].'-'.$entry->[0].'+1)';
		push @sz_strs,$sz_str;		
	}
	my $tot_sz_str = join('*',@sz_strs);
#	say $tot_sz_str ;
	my $size = eval_expression_with_parameters($tot_sz_str,{},$stref,$f);
#	say $size;
	return $size;
} # END of __calc_sz

# Annotate the var with most of the declaration, mostly for type checking while lining up
sub create_common_var_size_tuples {

    my ($stref, $f) = @_;

	for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonBlocks'} } ) {
#		if (exists $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block}) {
#			say "MISMATCHED BLOCK $block in $f";
			my @called_sub_common_vars =  @{ $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block} };
			my @common_var_size_tuples = map {
			# This means we will have to match them up, so create the tuples
				my $called_sub_common_var=$_;
				my $called_set = in_nested_set($stref->{'Subroutines'}{$f},'CommonVars',$called_sub_common_var);
				my $called_sub_common_var_decl = $stref->{'Subroutines'}{$f}{$called_set}{'Set'}{$called_sub_common_var};
				my $dim_sz=0;
				my $dim=[];
				if ($called_sub_common_var_decl->{'ArrayOrScalar'} eq 'Array') {
					$dim = dclone($called_sub_common_var_decl->{'Dim'});
					$dim_sz=__calc_sz($stref,$f,$dim), 
				}
				my $type = $called_sub_common_var_decl->{'Type'};
				my $kind_or_len= $type eq 'character' ? 1 : 4; # default
				if ($called_sub_common_var_decl->{'Attr'} =~/\*/) { croak "MUST HAVE ACTUAL SIZE!"; }				 
				if ($called_sub_common_var_decl->{'Attr'} ne '') {
					$kind_or_len = $called_sub_common_var_decl->{'Attr'};
					$kind_or_len =~s/\w+\s*=\s*//;
				}  
				# I need a field to indicate the first time an element is accessed. 
				# I can either make this 0|1 or put the $dim_sz in it
				# Let's start with 0|1
				# I think it might be better to just put the entire Decl in here, with a separate Dim which gets updated
				[
					$called_sub_common_var,  # :: VarName 
					$called_sub_common_var_decl, # VarDeclRec
					$kind_or_len, # :: AttrVal
					$dim, # :: Dim
					$dim_sz, # FIXME I should really compare each individual dimension
                    0 # :: UsedBefore
				];
			} @called_sub_common_vars;
			$stref->{'Subroutines'}{$f}{'CommonBlockSequences'}{$block} = [@common_var_size_tuples];
#		}		
	}

	return $stref;
} # END of create_common_var_size_tuples

sub match_up_common_vars { my ($stref,$f) = @_;
#	$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}={'Set'=>{},'List'=>[]};
	say "\nMATCHING UP vars in $f";
	for my $caller (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'} }) {
	for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller } }) {
		my $caller = $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$block};
		say "\nMATCHING UP vars in $f and $caller for COMMON block $block"; 
#		$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'List'} =[ @{$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'List'}},
#		  _determine_ex_common_args($stref,  $f, $caller, $block)  ];
		  _match_up_common_var_sequences ($stref,  $f, $caller, $block);
	}
	say "ExMismatchedCommonArgs for $f called from $caller: ".join(',',
		map { 
			join('_',(@{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'Set'}{$_} }, $_ ) ) 				
		} 
		@{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'List'} }
	);
	}	
	return $stref;
} # END of match_up_common_vars
# This is no good. Use the _match_up_common_var_sequences(), by extending the caller record in @equivalence_pairs 
# $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'List'} should get the original names
# $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'Set'} should get the prefix per name
# And in the equivalence pairs I'll add the prefixes as well
#sub _determine_ex_common_args { my ($stref,  $f, $caller, $block) = @_;
#	
#	my @ex_common_args=();
#	my @common_local_seq = @{ $stref->{'Subroutines'}{$f}{'CommonBlockSequences'}{$block} };
#	my @common_caller_seq = @{ $stref->{'Subroutines'}{$caller}{'CommonBlockSequences'}{$block} };
#	# We have to consider this from the view of the called sub, which I call "local"
#	# We iterate until that is consumed, and if the caller seq is consumed earlier, it means the additional local vars
#	# need to be added to the ex-common arguments list
#	
#	# First we get the total sizes
#	my $local_total_sz=__get_total_size(@common_local_seq);
#	my $caller_total_sz=__get_total_size(@common_caller_seq);
#	
#	# Now build the ex-common argument list
#	my $blockn = $block eq 'BLANK' ? '' : $block;
#	my $caller_running_sz = 0;
#	for my $elt (@common_caller_seq) {
#		if ($caller_running_sz < $local_total_sz) {
#			push @ex_common_args, $caller.'_'.$blockn.'_'.$elt->[0]; 
#			$caller_running_sz +=$elt->[2]*$elt->[5];
#		} else {
#			last;
#		}
#	}
#	# If the local list is longer than the caller list, we need to add the remaining local args
#	if ($caller_running_sz < $local_total_sz) {
#		my $local_running_sz=0;
#		for my $elt (@common_local_seq) {
#			$local_running_sz +=$elt->[2]*$elt->[5];
#			if ($local_running_sz > $caller_running_sz) {			
#				push @ex_common_args, $f.'_'.$blockn.'_'.$elt->[0]; 			
#			}
#		}		
#	}
##	say "$f $block: ",join(',',@ex_common_args);
#	# Now for each block we should join these together and use them as ExGlobArgs, which I will call ExMismatchedCommonArgs
#	return @ex_common_args;
#} 	# END of _determine_ex_common_args


# I want all pairs to be of the form ([localvar,0|1,maybe_offset],[callervar,maybe_offset]];
#  


# This does NOT work as such. Instead of the equivalence pairs, what I need is assignments local_var = caller_var
# and if the intent is also Out, also caller_var = local_var before exiting the subroutine.
# This means before either a return or falling off the end 
# For arrays, it means we need to provide an array slice of the size of the smalles one to make it work, e.g. ral1 = ra1(2:4)

sub _match_up_common_var_sequences { my ($stref,  $f, $caller, $block) = @_;	
#	say "MATCHING UP BLOCK $block for $f and $caller";
	my @common_local_seq = @{ $stref->{'Subroutines'}{$f}{'CommonBlockSequences'}{$block} };
	my @common_caller_seq = @{ $stref->{'Subroutines'}{$caller}{'CommonBlockSequences'}{$block} };
	
 # @equivalence_pairs ::  [(VarName,ArrayOrScalar,Dim,PrefixStr, TypeDeclRec)]	
	my @equivalence_pairs=();	
	while (scalar @common_local_seq > 0 ) { # keep going until the local sequence is consumed
		my $elt_local = shift  @common_local_seq;
		my ($name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $used_local) = @{$elt_local};
		if (@common_caller_seq) {
			
			my $elt_caller = shift  @common_caller_seq;
			my ($name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $used_caller) = @{$elt_caller};
            # add this caller to ExMismatchedCommonArgs
            my $prefix = $block eq 'BLANK' ? [$caller] : [$caller,$block];
            if ($used_caller==0) {
                $used_caller=1;
                push @{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'List'} }, $name_caller;
                $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'Set'}{$caller}{ $name_caller } = [];
            }
			if ( 
			
			not _compare_decls($stref, $f, $caller, $decl_local,$decl_caller) 
#			$decl_local ne $decl_caller 
#			 or $kind_local ne $elt_caller->[2]
			) { # Type / Attr mismatch 
				say "Type mismatch: \n".
				$name_local  . ' :: '. $decl_local->{'Type'}   . ($decl_local->{'Attr'} ? '('. $decl_local->{'Attr'}  .')' : '' )."\n". 
				$name_caller . ' :: '. $decl_caller->{'Type'}  . ( $decl_caller->{'Attr'} ? '('. $decl_caller->{'Attr'} .')' : '' )."\n";
			}
			# FIXME: if the attribute, i.e. the kind or length, is mismatched, we MUST take this into account
			# The way to do this is by multiplying the length of each variable in the sequence with KIND or LEN
			# And also use this when calculating the mismatch below
				if ($decl_local->{'ArrayOrScalar'} eq 'Scalar' and $decl_caller->{'ArrayOrScalar'} eq 'Scalar')  { # both scalar
					if ($dim_local == $elt_caller->[3]) {
						if ($name_local  eq $name_caller) {
							# No need to create an equivalence pair, just use the orginal arg name in the subroutine.														
						} else {
							push @equivalence_pairs, [[$name_local,0,[],[]],[$name_caller,0,[],[]]];
						}
					} else {
						croak "Can't match scalars with different kinds!";
					}
					# otherwise I guess it is just plain impossible, how can I possibly  
				}
				elsif ($decl_local->{'ArrayOrScalar'} eq 'Array' and $decl_caller->{'ArrayOrScalar'} eq 'Array')  { # both arrays
					if ($kind_local*$dimsz_local == $kind_caller*$dimsz_caller) { # arrays of identical size
						my $dim_local_copy = dclone($dim_local);
						my $dim_caller_copy = dclone($dim_caller); 
						
						if ($name_local  eq $name_caller) {
							# No need to create an equivalence pair, just use the orginal arg name in the subroutine.
							$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'Set'}{ $name_caller} =[];
						} else {
							push @equivalence_pairs, [[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]];
						}
					} else { # arrays of different size
						# which one is the shortest?
						if ($kind_local*$dimsz_local > $kind_caller*$dimsz_caller) { 
							# let's say we have (0:7) and (1:4) so 8 and 4
							# then local becomes 4, should be 4:7, in other words we simply add 4 to 0
#							$dimsz_local[-1][0]+=$elt_caller->[5];
							# and I suppose I need to reduce the actual size as well
#							$used_local -= $elt_caller->[5];
							# now let's say we have (1:5) * 8 and (0:7) * 4 and 5*8 and 8*4 
							# So I should add 8*4 bytes to the first array, i.e. 8*4/8 = 4 words, i.e. we go from 1:5 to 5:5  
							# 1:4 should become 4:4, so 1+3 where 3 = 
							$dimsz_local->[-1][0]+=$kind_caller*$dimsz_caller/$kind_local;
							# then local becomes 1, i.e.  (40-32)/8 							
							$used_local = $used_local - $kind_caller*$dimsz_caller/$kind_local;
							# So what happens if we have (1:10) * 4 and (0:3) * 8 so 40 and 32
							# Again the size is just (40 - 32)/4 = 2 
							# The start index should become 9, so 1+ (4*8)/4
							
							# means we need to modify $elt_local and unshift it, and create the equivalence
							my $dim_local_copy = dclone($dim_local);
							my $dim_caller_copy = dclone($dim_caller); 
							push @equivalence_pairs, [[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]];
							 	
							unshift @common_caller_seq,$elt_caller;
														
						} else {
							# means we need to modify $elt_local and unshift it, and create the equivalence
							$dim_caller->[-1][0]+=$kind_local*$used_local/$kind_caller;
							# then local becomes 1, i.e.  (40-32)/8 							
							$dimsz_caller = $dimsz_caller - $kind_local*$dimsz_local/$kind_caller;
							
							# means we need to modify $elt_local and unshift it, and create the equivalence
							my $dim_local_copy = dclone($dim_local);
							my $dim_caller_copy = dclone($dim_caller); 
							push @equivalence_pairs, [[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]];
							
							unshift @common_local_seq,$elt_local;
						}
						
					}
				} 
				elsif ($decl_local->{'ArrayOrScalar'} eq 'Scalar' and $decl_caller->{'ArrayOrScalar'} eq 'Array') { # local is scalar, caller is array				
					if ($kind_local ==  $kind_caller) {				
						my $dim_caller_copy = dclone($dim_caller); 
						push @equivalence_pairs, [[$name_local,0,[],[]],[$name_caller,1,$dim_caller_copy,$prefix]];
						# increment dim
						++$dim_caller->[-1][0]; # FIXME: weak: this only works as long as the first dimension is not exceeded
						if ($dim_caller->[-1][0]>$dim_caller->[-1][1]) {
							# first dimension is exceeded
							# must reset the first dimension and increment the second dime
							
							# e.g. remainin 531, and it was 1600, and that was (5,20,16)
							# So what is the coordinate ? I guess it is really 1600-531 = 1069 
							# So, 1069/(16*20)=3 full planes used; then in the 4th plan, how many rows used?
							#  1069 % (16*20) = 109/20 = 5; in the 6th col, how many elts?
							# 109 % 20 = 9
							#so we have 9 + 20*5 + 16*20*3
							# (tot_sz-current_sz)/prod(1 .. -1)
							
						}
						unshift @common_caller_seq,$elt_caller; 
					} else {
						croak "Can't match a scalar to an array with different kinds!";
					}
				}
				elsif ($decl_local->{'ArrayOrScalar'} eq 'Array' and $decl_caller->{'ArrayOrScalar'} eq 'Scalar') { # local is array, caller is scalar
					if ($kind_local ==  $kind_caller) {		
					my $dim_local_copy = dclone($dim_local); 
					push @equivalence_pairs, [[$name_local,1,$dim_local_copy,[]],[$name_caller,0,[],$prefix]];
					# increment dim
					++$dim_local->[-1][0]; # FIXME: weak: this only works as long as the first dimension is not exceeded
					unshift @common_local_seq,$elt_local;
										} else {
						croak "Can't match a scalar to an array with different kinds!";
					}
					 
				}						
		} else { # The local seq is longer than the caller seq
		# It can be that the local seq contains an elt that was already partially matched to the last caller elt. But I guess this will work out just fine.
				my $dim_local_copy = dclone($dim_local);							
				my $t_prefix = $block eq 'BLANK' ? [$f] :  [$f,$block];
				push @equivalence_pairs, [[$name_local,scalar @{$dim_local} ? 1 : 0,$dim_local,[]],[$name_local,scalar @{$dim_local} ? 1 : 0,$dim_local_copy,$t_prefix]];			
		}
		
	}
	if( scalar @equivalence_pairs > 0) {
#		say Dumper(	@equivalence_pairs );
		map { say _emit_equivalence_statement($_) } @equivalence_pairs;
	}
	return $stref;
} # END of _match_up_common_var_sequences

sub __get_total_size { my @common_seq = @_;
	my $total_sz=0;
	for my $elt (@common_seq) {
		$total_sz+=$elt->[2]*$elt->[5];
	}
	return $total_sz;
}
# annotate with prefix
sub _emit_equivalence_statement { (my $equiv_pair) = @_; 
#	say '<'.Dumper($equiv_pair).'>';
	my $l=$equiv_pair->[0];
	my $l_str = __emit_equiv_var_str($l);
	my $r=$equiv_pair->[1];
	my $r_str = __emit_equiv_var_str($r);
	return "equivalence ($l_str,$r_str)";
}

sub __emit_equiv_var_str {  (my $tup) = @_;
#	say Dumper($tup);
	(my $var, my $s_or_a, my $m_dim, my $m_prefix)=@{$tup};
	my $prefix_str = scalar @{$m_prefix} ? join('_',@{$m_prefix}).'_' : '';
	if ($s_or_a) { # 0 means scalar, 1 means array
		return $prefix_str.$var.'('.join(',', map { $_->[0] } @{$m_dim}).')';	
	} else {
		return $prefix_str.$var;
	}
}

sub _caller_to_local_assignment_annlines { (my $equiv_pair) = @_; 

	my $l=$equiv_pair->[0];
	my $l_str = __emit_equiv_var_str($l);
	my $r=$equiv_pair->[1];
	my $r_str = __emit_equiv_var_str($r);
	return [$l_str,$r_str];
}




# Casting between types but this does assume essentially kind=4
sub _cast_annlines { my ($from_type, $from_var, $to_type, $to_var) = @_;
	if ($from_type eq $to_type) {
		return [ ["$to_var = $from_var",{"Assignment"=>1,'Indent'=>6}]];
	}
	elsif ($from_type eq 'integer') {
		if ($to_type eq 'logical') {
			return __cast_integer_to_logical_annlines($from_var,$to_var);
		}
		elsif ($to_type eq 'real') {
			return __cast_integer_to_real_annlines($from_var,$to_var);
		}
	}
	elsif ($from_type eq 'real') {
		if ($to_type eq 'logical') {
			return __cast_real_to_logical_annlines($from_var,$to_var);
		}
		elsif ($to_type eq 'integer') {
			return __cast_real_to_integer_annlines($from_var,$to_var);
		}		
	}
	elsif ($from_type eq 'logical') {
		if ($to_type eq 'real') {
			return __cast_logical_to_real_annlines($from_var,$to_var);
		}
		elsif ($to_type eq 'integer') {
			return __cast_logical_to_integer_annlines($from_var,$to_var);			
		}		
	}	
}


sub __cast_logical_to_integer_annlines { (my $v_logical, my $v_integer) = @_;

    return [
        [  "if ($v_logical) then",{'If'=>1}, 'Indent'=>6 ],
        [  "    $v_integer=1", {'Assignment' => 1}, 'Indent'=>6],
        [  'else',{'Else'=>1}, 'Indent'=>6],
        [  "    $v_integer=0",{'Assignment' => 1}, 'Indent'=>6],
        [  'end if',{'EndIf'=>1}, 'Indent'=>6]
    ];
}

sub __cast_logical_to_real_annlines { (my $v_logical, my $v_real) = @_;

    return [
        [  "if ($v_logical) then",{'If'=>1}, 'Indent'=>6 ],
        [  "    $v_real=1.0", {'Assignment' => 1}, 'Indent'=>6],
        [  'else',{'Else'=>1}, 'Indent'=>6],
        [  "    $v_real=0.0",{'Assignment' => 1}, 'Indent'=>6],
        [  'end if',{'EndIf'=>1}, 'Indent'=>6]
    ];
}

sub __cast_integer_to_logical_annlines { ( my $v_integer,my $v_logical) = @_;
	return [[ "$v_logical = ($v_integer /= 0)",{"Assignment"=>1,'Indent'=>6}]];
}

sub __cast_integer_to_real_annlines { (my $v_real, my $v_integer) = @_;
	return [["$v_real = real($v_integer)",{'Assignment'=>1,'Indent'=>6}]];
}

sub __cast_real_to_logical_annlines { ( my $v_real,my $v_logical) = @_;
	return [[ "$v_logical = ($v_real /= 0.0)",{"Assignment"=>1,'Indent'=>6}]];
}

sub __cast_real_to_integer_annlines { (my $v_real, my $v_integer) = @_;
	return [["$v_integer = int($v_real)",{'Assignment'=>1,'Indent'=>6}]];
}


sub calc_coords { my ($lin_sz,$n_dims,$dims,$offsets) = @_;
#            integer, intent(In) :: lin_sz, n_dims
#            integer, dimension(n_dims),intent(In) :: dims, offsets
#            integer, dimension(n_dims), intent(Out) :: coords
#            integer, dimension(n_dims-1) :: mm
#            integer :: ii, jj, p_dims, sz
	my $coords=[];            
    my $sz = $lin_sz;
    my @tmp_dims = @{$dims}; 
    my $p_dims = 1;
    map { $p_dims*=$_} @tmp_dims ;
    for my $ii (1 .. $n_dims-1) {
    	my $div_dim = shift @tmp_dims;
		$p_dims/= $div_dim;
		$coords->[$ii-1] = int($sz/$p_dims)+$offsets->[$ii-1];
		$sz %=  $p_dims;
	}              
    $coords->[$n_dims-1] = $sz + $offsets->[$n_dims-1]-1; # The "-1" is because $lin_sz starts at 1 for the first element, not 0 
	return $coords;
} # end subroutine calc_coords




1;


