package RefactorF4Acc::Translation::UxntalStaging;
use v5.30;

# Because Funktal is too large for Uxn's memory, we need to stage the execution in Uxn
# We do this by storing the global state and loading it as required
# The aim is to make this fully transparent

# The "global state" are all module globals; in Funktal these are all in FunktalState
# The memory map is the ordered list of declarations of module globals

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
    &save_global_memory_map_to_file
    &load_global_memory_map_from_file
    &remove_unwanted_global_allocations_from_memory_map
);

our $mem_map_file = 'funktalState.memMap';

# If a memory map exists, 
# load it and use it for the initial allocation
sub load_global_memory_map_from_file() { 
    my $funktalState =  { 'Set' =>{}, 'List' => [], 'totalMemUsage' => 0 ,'stateCount' => 0};

    if (-e $mem_map_file)  {
        open my $MAP, '<', $mem_map_file or die $!;
        while (my $line = <$MAP>) {
            chomp $line;
            if ($line=~/stateCount\s+(\d+)/) {
                $funktalState->{'stateCount'}=$1+1;
            }
            elsif ($line=~/totalMemUsage\s+(\d+)/) {
                $funktalState->{'totalMemUsage'}=$1;
            }
            elsif ($line=~/\@\w+/ ){
                push @{$funktalState->{'List'}}, $line;
                my $fq_name = $line;
                $fq_name=~s/^\@//;
                $fq_name=~s/\s+.+$//;
                $funktalState->{'Set'}{$fq_name}=0;
            }
        }
        close $MAP;

    }
    return $funktalState;
} # END of load_global_memory_map_from_file

# If saveState is called in the program, 
# store the memory map
# sub save_global_memory_map_to_file($stref->{'Uxntal'}{'Globals'});
sub save_global_memory_map_to_file($funktalState) {
    open my $MAP, '>', $mem_map_file or die $!;
    say $MAP 'stateCount '.$funktalState->{'stateCount'};
    say $MAP 'totalMemUsage '.$funktalState->{'totalMemUsage'};
    for my $entry (@{$funktalState->{'List'}}) {
        say $MAP $entry;
    }
    close $MAP;
} # END of save_global_memory_map_to_file

# If loadState was not called in the program, 
# remove unused allocations from the memory map 
# and clear the memory map file
# The problem is that, if we run this twice, it doubles totalMemUsage
# because nothing gets removed
sub remove_unwanted_global_allocations_from_memory_map($funktalState) { 
    my $reduced_list=[];
    for my $decl (@{$funktalState->{'List'}}) {
        my $fq_name = $decl;
        $fq_name=~s/^\@//;
        $fq_name=~s/\s+.+$//;
        my $alloc_sz = $decl;
        $alloc_sz =~s/^\@\w+?\s+//;
        if ($funktalState->{'Set'}{$fq_name}!=0) {
            push @{$reduced_list},$decl;
        } else {
            say "Removing $fq_name from memory map";
            delete $funktalState->{'Set'}{$fq_name};
            print "totalMemUsage ",$funktalState->{'totalMemUsage'},' reduced by ';
            if ($alloc_sz=~/^[0-9a-z]{2}\s*$/) {
                print '1';
                $funktalState->{'totalMemUsage'}-=1;
            }
            elsif ($alloc_sz=~/^[0-9a-z]{4}\s*$/) {
                print '2';
                $funktalState->{'totalMemUsage'}-=2;
            }
            elsif ($alloc_sz=~/^\$([0-9a-z]+)\s*$/) {
                print hex($1);
                $funktalState->{'totalMemUsage'}-=hex($1);
            }
            say " to ",$funktalState->{'totalMemUsage'};
        }
    }
    my $reduced_funktalState={ 
        'List' => $reduced_list,
        'Set' => $funktalState->{'Set'},
        'totalMemUsage'=> $funktalState->{'totalMemUsage'}, 
        'stateCount' => 0 
    };
    unlink $mem_map_file;
    return $reduced_funktalState;
} # END of remove_unwanted_global_allocations_from_memory_map

1;