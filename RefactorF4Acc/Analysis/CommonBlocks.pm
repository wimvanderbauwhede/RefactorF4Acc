package RefactorF4Acc::Analysis::CommonBlocks;
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
use RefactorF4Acc::Utils qw( in_nested_set pp_annlines );

use vars qw( $DBGERSION );
$DBGERSION = "1.2.0";


use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

our @ISA = qw(Exporter);

our @EXPORT_OK = qw(
	collect_common_vars_per_block
	identify_common_var_mismatch
	create_common_var_size_tuples
	match_up_common_vars
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
        
        my @common_vars = grep {!/\)$/ } map { my $str=$_;$str=~s/\(.+$// ;$str } @common_vars_strs ;
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
    say "CALLED SUB $f" if $DBG;
    if (exists  $stref->{'Subroutines'}{$f}{'Callers'}) {
		my $callers = $stref->{'Subroutines'}{$f}{'Callers'};
		# If there is more than one caller, we must do this for every caller
		$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}={'SigArgs'=>[],'CallArgs'=>{}};			
		for my $caller (sort keys %{ $stref->{'Subroutines'}{$f}{'Callers'} } ) {
			say "CALLER $caller" if $DBG;
			$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}={};	
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
								if (not _compare_decls($stref, $f, $caller, $called_sub_common_var_decl,$caller_sub_common_var_decl,1) ) {
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
			    		say "BLOCK $block in $f has CommonVarMismatch with $caller" if $DBG;
			    		$stref->{'Subroutines'}{$f}{'HasCommonVarMismatch'}=1;
			    } else { 
			    		say "BLOCK $block in $f is matched with $caller: ".join(',',@{ $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block} }) if $DBG;
			    		$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'SigArgs'} = [@{$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'SigArgs'}},@{$stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block}}];
			    		map { 
			    			$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{$_}=[$_,$caller,$block]; 
			    		} @{ $stref->{'Subroutines'}{$f}{'CommonBlocks'}{$block} };			    		
			    }
		    	
		    } # block
		    if (scalar keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller} } == 0) { 
		    		say "All blocks in $f match with $caller, OK to use old approach";		    		
		    }		    
		} # caller
#		say Dumper($stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'});
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

sub _compare_decls { my ($stref, $f1, $f2, $decl1,$decl2,$compare_names) = @_;

	my $names_match = $decl1->{'Name'} eq $decl2->{'Name'};
	return 0 unless (!$compare_names or $names_match);
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
		 my $sz_str = '(('.$entry->[1].') - ('.$entry->[0].')+1)';
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
				my $dimsz=0;
				my $dim=[];
				if ($called_sub_common_var_decl->{'ArrayOrScalar'} eq 'Array') {
					$dim = dclone($called_sub_common_var_decl->{'Dim'});
					$dimsz=__calc_sz($stref,$f,$dim), 
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
					$dimsz, # linear size
					1,	# linear index, starting at 1			
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
#	say "\nMATCHING UP vars in $f";
	$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}={'SigArgs'=>[],'CallArgs'=>{}};
	for my $caller (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'} }) {
		$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}={};
#		say "\nMATCHING UP vars in $f with $caller";
		for my $block (sort keys %{ $stref->{'Subroutines'}{$f}{'CommonVarMismatch'}{$caller } }) {
			say "\nMATCHING UP vars in $f and caller $caller for COMMON block $block" if $DBG; 
		  _match_up_common_var_sequences ($stref,  $f, $caller, $block);
		}
#		say "ExMismatchedCommonArgs for $f called from $caller: ";
#		say Dumper( $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller} );
#	say join(',',
#		map { 
#			join('_',(@{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'Set'}{$caller}{$_} }, $_ ) ) 				
#		} 
#		@{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'List'} }
#	);
	}	
#	say "SigArgs for $f: ".join(',',@{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'SigArgs'} });
	
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
		
		my ($name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $lin_idx_local, $used_local) = @{$elt_local};
		my $type_local = $decl_local->{'Type'};
#		say "LOCAL: $name_local";
		if (@common_caller_seq) {
			
			my $elt_caller = shift  @common_caller_seq;
			my ($name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $lin_idx_caller, $used_caller) = @{$elt_caller};
			my $type_caller = $decl_caller->{'Type'};
#			say "CALLER: $name_caller"; 
            # add this caller to ExMismatchedCommonArgs
            my $prefix = $block eq 'BLANK' ? [$caller] : [$caller,$block];
            if ($used_caller==0) {
                $used_caller=1;
                push @{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'SigArgs'} }, $name_caller;
                $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{ $name_caller } = [$name_caller, $caller,$block];
            }
            my $htype_local =  $decl_local->{'Type'};
            my $htype_caller =  $decl_caller->{'Type'};
#			if (not _compare_decls($stref, $f, $caller, $decl_local,$decl_caller,0) ) { # Type / Attr mismatch
				if (not ($htype_local eq $htype_caller and $kind_local eq $kind_caller)) {# Type / Attr mismatch
					if ( $decl_local->{'ArrayOrScalar'} eq 'Array') {
						 $htype_local .= ', dimension('.__dim_to_str($decl_local->{'Dim'}).')';
					}
				
					if ($decl_caller->{'ArrayOrScalar'} eq 'Array') {					
						 $htype_caller .= ', dimension('.__dim_to_str($decl_caller->{'Dim'}).')';
					}  
					if ($DBG) {
					say "Type mismatch:";
					say $name_local  . ' :: '. $htype_local . ($decl_local->{'Attr'} ? '('. $decl_local->{'Attr'}  .')' : '' );
					say $name_caller . ' :: '. $htype_caller  . ( $decl_caller->{'Attr'} ? '('. $decl_caller->{'Attr'} .')' : '' );
					}
			}
			# FIXME: if the attribute, i.e. the kind or length, is mismatched, we MUST take this into account
			# The way to do this is by multiplying the length of each variable in the sequence with KIND or LEN
			# And also use this when calculating the mismatch below
				if ($decl_local->{'ArrayOrScalar'} eq 'Scalar' and $decl_caller->{'ArrayOrScalar'} eq 'Scalar')  { # both scalar
					if ($kind_local == $kind_caller) {
						if ($name_local  ne $name_caller) {
							# Else no need to create an equivalence pair, just use the orginal arg name in the subroutine.			
#							say "S S ".Dumper([[$name_local,0,[],[]],[$name_caller,0,[],[]]]);							
							push @equivalence_pairs, [[$name_local,$type_local,0,[],[]],[$name_caller,$type_caller,0,[],[]]];
						}
					} else {
						croak "Can't match scalars with different kinds: ";
					}
					# otherwise I guess it is just plain impossible, how can I possibly  
				}
				elsif ($decl_local->{'ArrayOrScalar'} eq 'Array' and $decl_caller->{'ArrayOrScalar'} eq 'Array')  { # both arrays
						# which one is the shortest? This refers the overlapping portions
						# one of them will have a lin_idx of 1, the other can be >=1
						# We compare the total remaining linear size, e.g. if 
						# local: lin_idx = 3, dim_sz = 8 then the total remaining linear size is (8-3+1)*kind 			
						# For the assignment, we must use the coords corresponding to lin_idx for start indices 
					if ($kind_local*($dimsz_local - $lin_idx_local+1) == $kind_caller*($dimsz_caller-$lin_idx_caller+1)) { # arrays of identical size
						
						if ($name_local eq $name_caller) {
							if ($lin_idx_local != $lin_idx_caller) { 
							# If the indices don't match, but same names, so caller needs a prefix, and we need an equiv pair
							my $dim_local_copy = dclone($dim_local);
							my $dim_caller_copy = dclone($dim_caller);
							if ($lin_idx_local!=1) {
								my $coords_local = _calc_coords($stref, $f, $dim_local, $lin_idx_local);
								for my $idx (0 .. scalar @{$coords_local} - 1) {
									$dim_local_copy->[$idx][0]=$coords_local->[$idx];
								}
							} 
							if ($lin_idx_caller != 1) {
								my $coords_caller = _calc_coords($stref, $caller, $dim_caller, $lin_idx_caller);
								for my $idx (0 .. scalar @{$coords_caller} - 1) {
									$dim_caller_copy->[$idx][0]=$coords_caller->[$idx];
								}																
							}			
#							say "A A eq ".Dumper([[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]]);								
							push @equivalence_pairs, [[$name_local,$type_local,1,$dim_local_copy,[]],[$name_caller,$type_caller,1,$dim_caller_copy,$prefix]];
							}
							# else {
							# same names, same size and same indices which therefore must be 1, so we can assign by name 							
						} else {
							my $dim_local_copy = dclone($dim_local);
							my $dim_caller_copy = dclone($dim_caller);
							if ($lin_idx_local!=1) {
								my $coords_local = _calc_coords($stref, $f, $dim_local, $lin_idx_local);
								for my $idx (0 .. scalar @{$coords_local} - 1) {
									$dim_local_copy->[$idx][0]=$coords_local->[$idx];
								}
							} 
							if ($lin_idx_caller != 1) {
								my $coords_caller = _calc_coords($stref, $caller, $dim_caller, $lin_idx_caller);
								for my $idx (0 .. scalar @{$coords_caller} - 1) {
									$dim_caller_copy->[$idx][0]=$coords_caller->[$idx];
								}																
							}			
#							say "A A eq ".Dumper([[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]]);								
							push @equivalence_pairs, [[$name_local,$type_local,1,$dim_local_copy,[]],[$name_caller,$type_caller,1,$dim_caller_copy,[]]];
						}
					} else { # arrays of different size
					# if they have the same name I need to prefix the caller name
						if ($kind_local*($dimsz_local - $lin_idx_local+1) > $kind_caller*($dimsz_caller-$lin_idx_caller+1)) { # local is larger
						# so caller will be shifted entirely, local will have to be put back
							 # say caller is size 4 and has local idx 1, so 4
							 # local is size 10 and has local idx 3, so 8
							 # then I need the points 3,4,5,6 to overlap with 1,2,3,4
							 # 3+4-1
							 # This is regardless of the kind differences
							my $lin_idx_local_end = $lin_idx_local + $kind_caller*($dimsz_caller-$lin_idx_caller+1)/$kind_local - 1;							
							my $lin_idx_local_start = $lin_idx_local;
							# Now increment the index   							

							my $dim_local_copy = dclone($dim_local);
							my $dim_caller_copy = dclone($dim_caller);
							
							my $coords_local_end = _calc_coords($stref, $f, $dim_local_copy, $lin_idx_local_end);
							for my $idx (0 .. scalar @{$coords_local_end} - 1) {
								$dim_local_copy->[$idx][1]=$coords_local_end->[$idx];
							}

							if ($lin_idx_local_start!=1) {
								my $coords_local = _calc_coords($stref, $f, $dim_local_copy, $lin_idx_local_start);
								for my $idx (0 .. scalar @{$coords_local} - 1) {
									$dim_local_copy->[$idx][0]=$coords_local->[$idx];
								}
							} 
							if ($lin_idx_caller != 1) {
								my $coords_caller = _calc_coords($stref, $caller, $dim_caller_copy, $lin_idx_caller);
								for my $idx (0 .. scalar @{$coords_caller} - 1) {
									$dim_caller_copy->[$idx][0]=$coords_caller->[$idx];
								}																
							}							
#							say "A A ne ".Dumper( [[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]]);
							if ($name_local eq $name_caller ) { 
							
							# In that case the SigArg should get the prefix as well
							my $prefixed_name_caller = join('_',(@{$prefix},$name_caller));
								$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'SigArgs'}[-1]=$prefixed_name_caller ;
								$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{ $prefixed_name_caller  } = [$name_caller,$caller,$block];
							} else {
								$prefix = [];
							}
							push @equivalence_pairs, [[$name_local,$type_local,1,$dim_local_copy,[]],[$name_caller,$type_caller,1,$dim_caller_copy,$prefix]];
							# if the local lin index has not entirely consumed the array, we need to unshift
							$lin_idx_local += $kind_caller*($dimsz_caller-$lin_idx_caller+1)/$kind_local;
							if ($dimsz_local - $lin_idx_local >= 0) { 							
								$elt_local = [$name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $lin_idx_local, $used_local];
								unshift @common_local_seq,$elt_local;
							}

						} else {

							my $lin_idx_caller_end = $lin_idx_caller + $kind_local*($dimsz_local-$lin_idx_local+1)/$kind_caller - 1;
							my $lin_idx_caller_start = $lin_idx_caller;
							# Now increment the index


							my $dim_local_copy = dclone($dim_local);
							my $dim_caller_copy = dclone($dim_caller);

							my $coords_caller_end = _calc_coords($stref, $f, $dim_caller_copy, $lin_idx_caller_end);
							for my $idx (0 .. scalar @{$coords_caller_end} - 1) {
								$dim_caller_copy->[$idx][1]=$coords_caller_end->[$idx];
							}

							if ($lin_idx_local!=1) {
								my $coords_local = _calc_coords($stref, $f, $dim_local_copy, $lin_idx_local);
								for my $idx (0 .. scalar @{$coords_local} - 1) {
									$dim_local_copy->[$idx][0]=$coords_local->[$idx];
								}
							}
							if ($lin_idx_caller_start != 1) {
								my $coords_caller = _calc_coords($stref, $caller, $dim_caller_copy, $lin_idx_caller_start);
								for my $idx (0 .. scalar @{$coords_caller} - 1) {
									$dim_caller_copy->[$idx][0]=$coords_caller->[$idx];
								}
							}
#							say "A A ne 2 ".Dumper([[$name_local,1,$dim_local_copy,[]],[$name_caller,1,$dim_caller_copy,$prefix]] );
							$prefix = $name_local eq $name_caller ? $prefix : [];
							push @equivalence_pairs, [[$name_local,$type_local,1,$dim_local_copy,[]],[$name_caller,$type_caller,1,$dim_caller_copy,$prefix]];
							# e.g. local was 4, caller idx was 3 -> new caller idx is 7 unless the caller array is only 6 long
							# if the caller was 6 long, we get 6-7 >= 1-1 => -1 >= 0 ? FALSE!
							# if the caller was 7 long, we get 7-7 >= 1-1 => 0 >= 0 ? TRUE!
							# if the caller was 8 long, we get 7-7 >= 1-1 => 1 >= 0 ? TRUE!
							$lin_idx_caller += $kind_local*($dimsz_local-$lin_idx_local+1)/$kind_caller;
							if ($dimsz_caller - $lin_idx_caller >= 0) {
								$elt_caller=[$name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller, $lin_idx_caller, $used_caller];
								unshift @common_caller_seq,$elt_caller;
							}
						}
					}
				}
				elsif ($decl_local->{'ArrayOrScalar'} eq 'Scalar' and $decl_caller->{'ArrayOrScalar'} eq 'Array') { # local is scalar, caller is array
					if ($kind_local ==  $kind_caller) {
						# increment dim
						# We support a scalar with a larger kind, simply by having
						my $lin_idx_caller_start = $lin_idx_caller;
						my $lin_idx_caller_end = $lin_idx_caller_start +  $kind_caller/$kind_local - 1; # so, usually this is 0
						my $coords_start = _calc_coords($stref, $caller, $dim_caller, $lin_idx_caller_start);
						my $coords_end = _calc_coords($stref, $caller, $dim_caller, $lin_idx_caller_end);
						my $dim_caller_copy = dclone($dim_caller);
						for my $idx (0 .. scalar @{$coords_start} - 1) {
							$dim_caller_copy->[$idx][0]=$coords_start->[0];
							$dim_caller_copy->[$idx][1]=$coords_end->[0];
						}
#						say "S A ".Dumper([[$name_local,0,[],[]],[$name_caller,1,$dim_caller_copy,$prefix]] );
						$prefix = $name_local eq $name_caller ? $prefix : [];
						push @equivalence_pairs, [[$name_local,$type_local,0,[],[]],[$name_caller,$type_caller,1,$dim_caller_copy,$prefix]];
						# increment lin idx. But if the lin idx is already the dimsz, we should not do this, as it means we're at the last element.
						# e.g. if the caller idx is 3 and the caller array is 4, then 4-3 = 1 > 0
						$lin_idx_caller += $kind_local/$kind_caller; # currently this of course just means +=1
						if ($dimsz_caller - $lin_idx_caller >= 0) {						
							$elt_caller=[$name_caller, $decl_caller, $kind_caller, $dim_caller, $dimsz_caller,$lin_idx_caller, $used_caller];
							unshift @common_caller_seq,$elt_caller;
						}
					} else {
						croak "Can't match a scalar to an array with different kinds!";
					}
				}
				elsif ($decl_local->{'ArrayOrScalar'} eq 'Array' and $decl_caller->{'ArrayOrScalar'} eq 'Scalar') { # local is array, caller is scalar
					if ($kind_local ==  $kind_caller) {
#						say "IDX: $lin_idx_local";
						my $lin_idx_local_start = $lin_idx_local;
						my $lin_idx_local_end = $lin_idx_local_start +  $kind_local/$kind_caller - 1; # so, usually this is 0
						my $coords_start = _calc_coords($stref, $f, $dim_local, $lin_idx_local_start);
						my $coords_end = _calc_coords($stref, $f, $dim_local, $lin_idx_local_end);
						my $dim_local_copy = dclone($dim_local);
						for my $idx (0 .. scalar @{$coords_start} - 1) {
							$dim_local_copy->[$idx][0]=$coords_start->[0];
							$dim_local_copy->[$idx][1]=$coords_end->[0];
						}						
#						say "A S ".Dumper([[$name_local,1,$dim_local_copy,[]],[$name_caller,0,[],$prefix]] );
						$prefix = $name_local eq $name_caller ? $prefix : [];
						push @equivalence_pairs, [[$name_local,$type_local,1,$dim_local_copy,[]],[$name_caller,$type_caller,0,[],$prefix]];
						# increment lin idx. But if the lin idx is already the dimsz, we should not do this, as it means we're at the last element.
						$lin_idx_local += $kind_caller/$kind_local; # works if the are dividable  
						if ( $dimsz_local - $lin_idx_local >= 0) {	# 15-14>0 => unshift it													
							$elt_local = [$name_local, $decl_local, $kind_local, $dim_local, $dimsz_local, $lin_idx_local, $used_local];
							
							unshift @common_local_seq,$elt_local;
						}
					} else {
						croak "Can't match a scalar to an array with different kinds!";
					}					 
				}
		} else { # The local seq is longer than the caller seq
		
				# It can be that the local seq contains an elt that was already partially matched to the last caller elt.
				# this means that $name_local is already matched;  but we still need to add it to call args 				
				if ($used_local==0) {
                	$used_local=1;
#                	say "USING LOCAL AS CALLER";
                	push @{ $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'SigArgs'} }, $name_local;
				}
				# but in any case, the name must be added to the call args
                $stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'CallArgs'}{$caller}{ $name_local } = [$name_local,$f,$block];
                # Either way, the local will have been consumed and there is no caller, so no unshifting
		}

	}
	
	if( scalar @equivalence_pairs > 0) {
#		say Dumper(	@equivalence_pairs );
		my @arg_assignment_lines = map { 
			 my $pair = $_;
			 @{ _caller_to_local_assignment_annlines($pair) }; 
		} @equivalence_pairs;
#		say Dumper(	pp_annlines(	\@arg_assignment_lines,0)  );
		$stref->{'Subroutines'}{$f}{'ExMismatchedCommonArgs'}{'ArgAssignmentLines'}=\@arg_assignment_lines;
	}
	
	
	return $stref;
} # END of _match_up_common_var_sequences

#sub __get_total_size { my @common_seq = @_;
#	my $total_sz=0;
#	for my $elt (@common_seq) {
#		$total_sz+=$elt->[2]*$elt->[5];
#	}
#	return $total_sz;
#}
# annotate with prefix
sub _emit_equivalence_statement { (my $equiv_pair) = @_; 
#	say '<'.Dumper($equiv_pair).'>';
	my $l=$equiv_pair->[0];
	my $l_str = __emit_equiv_var_str($l);
	my $r=$equiv_pair->[1];
	my $r_str = __emit_equiv_var_str($r);	
	return "$l_str = $r_str";
}

sub __emit_equiv_var_str {  (my $tup) = @_;
	(my $var, my $type, my $is_array, my $m_dim, my $m_prefix)=@{$tup};
	my $prefix_str = scalar @{$m_prefix} ? join('_',@{$m_prefix}).'_' : '';
	if ($is_array) { 
		return $prefix_str.$var.'('.join(',', map {
			$_->[0] ne $_->[1]  
			? $_->[0].':'. $_->[1] 
			: $_->[0]
		} @{$m_dim}).')';	
	} else {		
		return $prefix_str.$var;
	}
}

sub _caller_to_local_assignment_annlines { (my $equiv_pair) = @_; 

	my $l=$equiv_pair->[0];
	my $l_str = __emit_equiv_var_str($l);
	my $r=$equiv_pair->[1];
	my $r_str = __emit_equiv_var_str($r);
	my $annlines =  _cast_annlines($l->[1],$l_str,$r->[1],$r_str);
	# Adding the Indent
	my $indent = ' 'x 6;
	$annlines = [ map { [$indent.$_,{}] } @{ $annlines } ] ; 
	return $annlines;
#	return ["$l_str = $r_str",{}];
}




# Casting between types but this does assume essentially kind=4
sub _cast_annlines { my ( $to_type, $to_var, $from_type, $from_var) = @_;
	if ($from_type eq $to_type) {
		return ["$to_var = $from_var"];#,{"Assignment"=>1,'Indent'=>' ' x 6}]];
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
          "if ($v_logical) then",
          "    $v_integer=1",
          'else',#{'Else'=>1, 'Indent'=>' ' x 6}],
          "    $v_integer=0",#{'Assignment' => 1, 'Indent'=>' ' x 6}],
          'end if'#,{'EndIf'=>1, 'Indent'=>' ' x 6}]
    ];
}

sub __cast_logical_to_real_annlines { (my $v_logical, my $v_real) = @_;

    return [
          "if ($v_logical) then",#{'If'=>1, 'Indent'=>' ' x 6 }],
          "    $v_real=1.0",# {'Assignment' => 1, 'Indent'=>' ' x 6}],
          'else',#{'Else'=>1, 'Indent'=>' ' x 6}],
          "    $v_real=0.0",#{'Assignment' => 1, 'Indent'=>' ' x 6}],
          'end if'#,{'EndIf'=>1, 'Indent'=>' ' x 6}]
    ];
}

sub __cast_integer_to_logical_annlines { ( my $v_integer,my $v_logical) = @_;
	return [ "$v_logical = ($v_integer /= 0)"];#,{"Assignment"=>1,'Indent'=>' ' x 6}]];
}

sub __cast_integer_to_real_annlines { (my $v_real, my $v_integer) = @_;
	return ["$v_real = real($v_integer)"];#,{'Assignment'=>1,'Indent'=>' ' x 6}]];
}

sub __cast_real_to_logical_annlines { ( my $v_real,my $v_logical) = @_;
	return [ "$v_logical = ($v_real /= 0.0)"];#,{"Assignment"=>1,'Indent'=>' ' x 6}]];
}

sub __cast_real_to_integer_annlines { (my $v_real, my $v_integer) = @_;
	return ["$v_integer = int($v_real)"];#,{'Assignment'=>1,'Indent'=>' ' x 6}]];
}

# Given the linear index (starting at 1) in an array
# and its dimensions and offsets
# return the n-dim coordinate for that index
sub _calc_coords { my ($stref, $f, $dim_rec, $lin_sz) = @_;
#            integer, intent(In) :: lin_sz, n_dims
#            integer, dimension(n_dims),intent(In) :: dims, offsets
#            integer, dimension(n_dims), intent(Out) :: coords
#            integer, dimension(n_dims-1) :: mm
#            integer :: ii, jj, p_dims, sz
 (my $dims,my $offsets) = __calc_dims_offsets($stref, $f, $dim_rec) ;
	my $coords=[];            
    my $sz = $lin_sz;
    my @tmp_dims = @{$dims};
    my $n_dims = scalar @tmp_dims;  
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


# $dims is an array of the sizes of each dimension
# $offsets is an array of the offsets each dimension
sub __calc_dims_offsets {my ($stref, $f, $dim_rec) = @_;
	my $offsets=[];
	my $dims=[];
	my @sz_strs=();
	for my $entry ( @{$dim_rec} ) {
		my $offset_val = eval_expression_with_parameters($entry->[0],{},$stref,$f);
		push @{$offsets}, $offset_val;
		my $dim_str = '(('.$entry->[1].') - ('.$entry->[0].')+1)';
		my $dim_val = eval_expression_with_parameters($dim_str,{},$stref,$f);
		push @{$dims}, $dim_val;				
	}
	return ($dims,$offsets);
} # END of __calc_dims_offsets

sub __dim_to_str {(my $dim) = @_;
	return join(',',map {$_->[0].':'.$_->[1]} @{$dim}); 
}




1;


