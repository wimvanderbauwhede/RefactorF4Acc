package RefactorF4Acc::Translation::UxntalStaging;
use v5.30;

# Because Funktal is too large, we need to stage the execution in Uxn
# We do this by storing the global state and loading it as required
# The aim is to make this fully transparent, 
use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

no warnings qw(experimental::signatures);
use feature qw(signatures);

@RefactorF4Acc::Translation::UxntalStaging::ISA = qw(Exporter);

@RefactorF4Acc::Translation::UxntalStaging::EXPORT_OK = qw(
    &gen_next_funktalState
    &use_previous_funktalState
    &remove_unused_allocations_from_state
);

# Uxntal library handling
our $VV=0;

sub use_previous_funktalState() { 
    my $funktalState =  { 'Set' =>{}, 'List' => [], 'totalMemUsage' => 0 ,'stateCount' => 0};

    if (-e 'funktalState.map')  {
        open my $MAP, '<', 'funktalState.map' or die $!;
        while (my $line = <$MAP>) {
            chomp $line;
            $line=~/stateCount\s+(\d+)/ && do { $funktalState->{'stateCount'}=$1+1 };
            $line=~/totalMemUsage\s+(\d+)/ && do { $funktalState->{'totalMemUsage'}=$1 };
            $line=~/\@funktal\w+/ && do {
                push @{$funktalState->{'List'}}, $line;
                my $fq_name = $line;
                $fq_name=~s/^\@//;
                $fq_name=~s/\s+.+$//;
                $funktalState->{'Set'}{$fq_name}=0;
            };
        }
        close $MAP;

    }
    return $funktalState;
} # END of use_previous_funktalState

# sub gen_next_funktalState($stref->{'Uxntal'}{'Globals'});
sub gen_next_funktalState($funktalState) {
    open my $MAP, '>', 'funktalState.map' or die $!;
    say $MAP 'stateCount '.$funktalState->{'stateCount'};
    say $MAP 'totalMemUsage '.$funktalState->{'totalMemUsage'};
    for my $entry (@{$funktalState->{'List'}}) {
        say $MAP $entry;
    }
    close $MAP;
} # END of gen_next_funktalState

sub remove_unused_allocations_from_state($funktalState) {
    my $reduced_list=[];
    for my $decl (@{$funktalState->{'List'}}) {
        my $fq_name = $decl;
        $fq_name=~s/^\@//;
        $fq_name=~s/\s+.+$//;
        if ($funktalState->{'Set'}{$fq_name}!=0) {
            push @{$reduced_list},$decl;
        } else {
            delete $funktalState->{'Set'}{$fq_name}
        }
    }
    my $reduced_funktalState={ 
        'List' => $reduced_list,
        'Set' => $funktalState->{'Set'},
        'totalMemUsage'=> $funktalState->{'totalMemUsage'}, # FIXME
        'stateCount' => 0 
    };
    return $reduced_funktalState;
}
1;