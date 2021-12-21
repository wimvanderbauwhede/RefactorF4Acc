package RefactorF4Acc::Utils::Functional;
use v5.10;
use RefactorF4Acc::Config;
# 
#   (c) 2021 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   

# This module provides functions similar to the Haskell Prelude

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Utils::Functional::ISA = qw(Exporter);

@RefactorF4Acc::Utils::Functional::EXPORT = qw(
    &zip 
    &union 
    &ordered_union 
    &ordered_difference 
    &ordered_intersection 
    &intersection 
    &find_duplicates_in_list 
    &make_lookup_table 
    &findWithDefault 
    &appendToMap 
    &listRemoveDuplications 
    &isNothing 
    &just 
    &nothing 
    &isJust 
    &fromJust 
    &case 
    &otherwise 
    &append 
    &concat 
    &null 
    &elem 
    &insert 
    &mapf 
    &foldl 
    &foldr
    &fold 
    &foldAnd 
    &foldOr 
    &unzip 
    &head 
    &tail 
    &init
    &last_
    &fst 
    &snd 
    &filter 
    &max 
    &min 
    &round 
);
@RefactorF4Acc::Utils::Functional::EXPORT_OK = qw(
    &length 
);

# -----------------------------------------------------------------------------
sub zip { ( my $aref, my $bref ) = @_;
    my @zip_ab=();
    my $a_sz = scalar @{$aref};
    my $b_sz = scalar @{$bref};
    my $max_sz = $a_sz > $b_sz ? $a_sz : $b_sz;
    for my $idx (0 .. $max_sz-1) {
        push @zip_ab, [$aref->[$idx],$bref->[$idx]];
    }
    return \@zip_ab;
} # END of zip
# -----------------------------------------------------------------------------
sub union {
    ( my $aref, my $bref ) = @_;
    croak("union()") if $DBG and not (defined $aref and defined $bref);    
    if (not defined $aref) {
        return $bref;
    } elsif (not defined $bref) {
        return $aref;
    } else {    

    my %as = map { $_ => 1 } @{$aref};
    for my $elt ( @{$bref} ) {
        $as{$elt} = 1;
    }
    my @us = sort keys %as;
    return \@us;
    }
}    # END of union()

# -----------------------------------------------------------------------------
# This union is obtained by removing duplicates from @b. It is a bit slower but preserves the order
sub ordered_union {
    ( my $aref, my $bref ) = @_;
    croak("ordered_union(): both args must be defined!") if $DBG and not (defined $aref and defined $bref);   
    if (not defined $aref) {
    	return $bref;
    } elsif (not defined $bref) {
        return $aref;
    } else {    
	    my @us = @{$aref};
	    my %as = map { $_ => 1 } @{$aref};
	    for my $elt ( @{$bref} ) {
	        if ( not exists $as{$elt} ) {
	            push @us, $elt;
	        }
	    }
	    return \@us;
    }
}    # END of ordered_union()
# -----------------------------------------------------------------------------
# This is the set of all members of $bref not in $aref, not the other way round
sub ordered_difference {
    ( my $aref, my $bref ) = @_;
    croak("ordered_difference()") if $DBG and not (defined $aref and defined $bref);   
    if (not defined $aref) { # assume it's empty
    	return $bref;
    } elsif (not defined $bref) {
        return [];
    } else {    
	    my @b_diff_a = ();
	    my %as = map { $_ => 1 } @{$aref}; # all elts of a
	    for my $elt ( @{$bref} ) {
	        if ( not exists $as{$elt} ) { # elt is not in a, so OK
	            push @b_diff_a, $elt;
	        }
	    }
	    return \@b_diff_a;
    }
}    # END of ordered_difference()
# -----------------------------------------------------------------------------
# This is the set of all members of $bref that also occur in $aref (or vice-versa of course)
sub ordered_intersection {
    ( my $aref, my $bref ) = @_;
    croak("ordered_intersection()") if $DBG and not (defined $aref and defined $bref);   
    if (not defined $aref) {
    	return [];
    } elsif (not defined $bref) {
        return [];
    } else {    
	    my @is = [];
	    my %as = map { $_ => 1 } @{$aref};
	    for my $elt ( @{$bref} ) {
	        if ( exists $as{$elt} ) {
	            push @is, $elt;
	        }
	    }
	    return \@is;
    }
}    # END of ordered_intersection()
# -----------------------------------------------------------------------------
# This is the set of all members of $bref that also occur in $aref (or vice-versa of course)
sub intersection {
    ( my $aref, my $bref ) = @_;
    croak("intersection()") if $DBG and not (defined $aref and defined $bref);   
    if (not defined $aref) {
    	return {};
    } elsif (not defined $bref) {
        return {};
    } else {    
	    my $is = {};	    
	    for my $elt (keys %{$bref} ) {
	        if ( exists $aref->{$elt} ) {
	            $is->{$elt}=$aref->{$elt}; # assuming that a and be have the same value for a given key
	        }
	    }
	    return $is;
    }
}    # END of intersection()
# -----------------------------------------------------------------------------
sub find_duplicates_in_list { (my $lst) =@_;
	my %uniques=();
	my $dups={};
	for my $elt (@{$lst}) {
		if (not exists $uniques{$elt}) {
			$uniques{$elt}=$elt;
		} else {
			$dups->{$elt}=$elt
		}
	}
	return $dups;
}
# -----------------------------------------------------------------------------
# A lookup table from one list to another
sub make_lookup_table {
    (my $from, my $to)=@_;
    my $lut={};    
    for my $idx (0 .. scalar @{$from}-1) {
        my $f = $from->[$idx];
        my $t = $to->[$idx];
        $lut->{$f}=$t;
    } 
    return $lut;
}

# -----------------------------------------------------------------------------

sub findWithDefault { my ($default, $key, $table) = @_;
    if (not exists $table->{$key}) {
        if (ref($default) eq 'SUB') {
            $default->();
        } else { 
            return $default;
        }
    } else {
        return $table->{$key};
    }   
}

# -----------------------------------------------------------------------------
# appendToMap :: Ord k => k -> a -> DMap.Map k [a] -> DMap.Map k [a]
sub appendToMap { my ($key, $item, $table) = @_;
    my $ntable = insert( $key, [@{findWithDefault( [], $key, $table)},$item],$table);
    return $ntable;
}

# -----------------------------------------------------------------------------
sub listRemoveDuplications { ordered_union(@_); }

# -----------------------------------------------------------------------------
# Maybe type
sub isNothing { my ($mt) = @_;
   if( $mt->[0] eq 'Nothing') {
        return 1;
   }
   elsif( $mt->[0] eq 'Just') {
       return 0;
   }
   else {
       croak "Not a Maybe type: ".Dumper($mt);
   }
}

sub just { my ($t)=@_;
    return ['Just',$t];
}

sub nothing { 
    return ['Nothing'];
}

sub isJust { my ($mt) = @_;
   if( $mt->[0] eq 'Nothing') {
        return 0;
   }
   elsif( $mt->[0] eq 'Just') {
       return 1;
   }
   else {
       croak "Not a Maybe type: ".Dumper($mt);
   }
}

sub fromJust { my ($mt) = @_;
    
   if( $mt->[0] eq 'Nothing') {
        croak "Nothing not Just ".Dumper($mt);
   }
   elsif( $mt->[0] eq 'Just') {
       return $mt->[1];
   }
   else {
       croak "Not a Maybe type: ".Dumper($mt);
   }    
}

# -----------------------------------------------------------------------------
# Haskell style case
sub case { my ($sum_type_inst, $altCondsActions) = @_;
    for my $altCondsAction (@{$altCondsActions}) {
        my ($cond,$action) = @{$altCondsAction};
        if (ref($cond) eq 'CODE') {
            if ($cond->{$sum_type_inst}) {
                if (ref($action) eq 'CODE') {
                    return $action->{$sum_type_inst};
                } else {
                    return $action;
                }
            }
        } 
        else {
            if ($cond) {
                if (ref($action) eq 'CODE') {
                    return $action->{$sum_type_inst};
                } else {
                    return $action;
                }
            }            
        }
    }
}

# -----------------------------------------------------------------------------
sub otherwise {
    1;
}
sub append { my ($lst,$elt) = @_;
    [@{$lst},$elt];
}

sub concat { my @lsts = @_;
my $concat_lsts = [];
    for my $lst (@lsts) {
        $concat_lsts = [@{$concat_lsts},@{$lst}];
    }
    return $concat_lsts;
}

sub length { my ($lst)=@_;
    return scalar @{$lst};
}

sub null { my ($lst)=@_;
    return scalar @{$lst} == 0;
}

sub elem { my ($elt,$lst) = @_;
    my %hash = map {$_=>1} @{$lst};
    return exists $hash{$elt} ? 1 : 0;
}

sub insert { my ($key, $value, $table) = @_;
        $table->{$key}=$value;
        return dclone($table);
}

sub mapf {
	( my $f, my $ls ) = @_;
    return [
        map {
            $f->($_)
        } @{$ls}
    ];
}

sub foldl {
	( my $f, my $acc, my $ls ) = @_;
	for my $elt ( @{$ls} ) {
		$acc = $f->( $acc, $elt );
	}
	return $acc;
}    

sub foldr {
	( my $f, my $acc, my $ls ) = @_;
	for my $elt ( reverse @{$ls} ) {
		$acc = $f->( $acc, $elt );
	}
	return $acc;
}   

sub fold {
    foldl(@_);
} 

sub foldAnd {
	( my $acc, my $ls ) = @_;
	for my $elt ( @{$ls} ) {
		$acc =  $acc && $elt ;
	}
	return $acc;
}

sub foldOr {
	( my $acc, my $ls ) = @_;
	for my $elt ( @{$ls} ) {
		$acc =  $acc || $elt ;
	}
	return $acc;
}

# sub zip { my ($l1, $l2) = @_;
#     my $len_l1= scalar @{$l1};
#     my $len_l2= scalar @{$l2};
#     my $common_len = $len_l1 < $len_l2 ? $len_l1 : $len_l2;
#     my $l12=[];
#     for my $idx (0..$common_len-1) {
#         my $elt1 = $l1->[$idx];
#         my $elt2 = $l2->[$idx];
#         push @{$l12},[$elt1,$elt2];
#     }
#     return $l12;
# }

sub unzip { (my $l12) = @_;
    my $l1=[];
    my $l2=[];
    for my $pair (@{$l12}) {
        my ($elt1,$elt2)=@{$pair};
        push @{$l1},$elt1;
        push @{$l2},$elt2;
    }
    return ($l1,$l2);
}
sub head { my ($lst)=@_;
    if (scalar @{$lst}>0) {
        return $lst->[0];
    } else {
        croak "head of empty list: ".Dumper($lst);
    }
}

sub tail { my ($lst)=@_;
    my @lst_ = @{$lst};
    if (scalar @lst_>0) {
        shift @lst_;
        return \@lst_;
    } else {
        croak "tail of empty list: ".Dumper($lst);
    }
}

sub init { my ($lst)=@_;
    my @lst_ = @{$lst};
    if (scalar @lst_>0) {
        pop @lst_;
        return \@lst_;
    } else {
        croak "init of empty list: ".Dumper($lst);
    }
}

sub last_ { my ($lst)=@_;
    my @lst_ = @{$lst};
    if (scalar @lst_>0) {
        return $lst_[-1];
    } else {
        croak "last of empty list: ".Dumper($lst);
    }
}

sub fst { (my $tup_ref) = @_; 
    return $tup_ref->[0];
}

sub snd { (my $tup_ref) = @_; 
    return $tup_ref->[1];
}

sub filter { (my $f, my $lst) = @_;
    my $res = grep { $f->{$_} } @{$lst};
    return $res;
}

sub max { (my $v1, my $v2) =@_;
    return $v1 < $v2 ? $v2 : $v1;
}

sub min { (my $v1, my $v2) =@_;
    return $v1 > $v2 ? $v2 : $v1;
}

sub round { my ($v)=@_;
    my $iv=int($v);
    my $rest = $v-$iv;    
    if ($rest<0.5) {
        $iv;
    } else {
        $iv+1;
    }
}

1;
