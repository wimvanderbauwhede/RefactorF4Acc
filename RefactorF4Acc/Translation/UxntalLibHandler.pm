package RefactorF4Acc::Translation::UxntalLibHandler;
use v5.30;

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

@RefactorF4Acc::Translation::UxntalLibHandler::ISA = qw(Exporter);

@RefactorF4Acc::Translation::UxntalLibHandler::EXPORT_OK = qw(
    &load_uxntal_lib_subroutines
    &add_to_used_lib_subs
	&emit_used_uxntal_lib_subroutine_sources
);

# Uxntal library handling

# - Read all libraries 

our %uxntal_lib_subroutines = ();

sub load_uxntal_lib_subroutines(@uxntal_lib_sources) {
    for my $uxntal_lib_source (@uxntal_lib_sources) {
        open my $LIB, '<', $uxntal_lib_source or die "$! $uxntal_lib_source";
        my $in_sub=0;
        my $current_sub='';
        while (my $line=<$LIB>){
            chomp $line;
            if ($line=~/^\s*\@([\w-]+)\s+/) {
                $in_sub=1;
                $current_sub=$1;
                $uxntal_lib_subroutines{$current_sub}=[];
            } elsif ($in_sub==1) {
                push @{$uxntal_lib_subroutines{$current_sub}},$line;
            }
        }
        close $LIB;
    }
}

# - Everytime a call is used, mark the subroutine

our %used_uxntal_lib_subroutines = ();

sub add_to_used_lib_subs($subname) {
    if (not exists $used_uxntal_lib_subroutines{$subname}
    and exists $uxntal_lib_subroutines{$subname}
    ) {
        $used_uxntal_lib_subroutines{$subname}=$uxntal_lib_subroutines{$subname};
    } elsif (not exists $uxntal_lib_subroutines{$subname}) {
        die "No such library subroutine: $subname\n";
    }
}

sub emit_used_uxntal_lib_subroutine_sources(){
    my @sources = ();
    for my $subname (sort keys %used_uxntal_lib_subroutines) {
        @sources = (@sources,@{$used_uxntal_lib_subroutines{$subname}});
    }
    return @sources;
}
1;