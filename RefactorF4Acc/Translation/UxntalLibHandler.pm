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
our $VV=0;
# - Read all libraries 

our %uxntal_lib_subroutines = (

'min' => [
	'@min',
	'OVR2 OVR2 LTH2 #00 SWP DUP2 #0001 SWP2 SUB2',
	'ROT2 MUL2 ROT2 ROT2 MUL2 ADD2',
	'JMP2r'
],
'not'	=>['@not #01 SWP SUB JMP2r'],
'modulo' => ['( a:16 b:16 -- m:16 )',
	'@modulo',
	'OVR2 OVR2  ( a b a b )',
	'DIV2  ( a b a/b )',
	'MUL2  ( a b*(a/b) )',
	'SUB2 ( a-b*(a/b) )',
	'JMP2r'],
'iachar' => [
	'@iachar', # HACK: ignoring kind, returns a short
	'#00 SWP JMP2r'
]
);

sub load_uxntal_lib_subroutines(@uxntal_lib_sources) {
    for my $uxntal_lib_source (@uxntal_lib_sources) {
        say "LIB: $uxntal_lib_source" if $VV;
        open my $LIB, '<', $uxntal_lib_source or die "$! $uxntal_lib_source";
        my $in_sub=0;
        my $current_sub='';
        while (my $line=<$LIB>){
            chomp $line;
            if ($line=~/^\s*\@([\w\-]+)(?:\s+|$)/) {
                $in_sub=1;
                $current_sub=$1;
                say "SUB: $current_sub" if $VV;
                $uxntal_lib_subroutines{$current_sub}=[];
            } 
            if ($in_sub==1) {
                push @{$uxntal_lib_subroutines{$current_sub}},$line;
            }
        }
        close $LIB;
    }
    # croak Dumper sort keys %uxntal_lib_subroutines;
}

# - Everytime a call is used, mark the subroutine

our %used_uxntal_lib_subroutines = ();

sub add_to_used_lib_subs($subname) {
    if (not exists $used_uxntal_lib_subroutines{$subname}
    and exists $uxntal_lib_subroutines{$subname}
    ) {
        $used_uxntal_lib_subroutines{$subname}=$uxntal_lib_subroutines{$subname};
        for my $line (@{$used_uxntal_lib_subroutines{$subname}}) {
            my $tline = $line;
            while ($tline=~/\(.+?\)/){$tline=~s/\(.+?\)//;}
            my @tokens = split(/\s+[\;\!]?/,$tline);
            my @called_subs = grep { /^[\w\-]+$/ && !/^[A-Z][A-Z][A-Z][2kr]*$/ } @tokens;
            for my $called_sub (@called_subs) {
                add_to_used_lib_subs($called_sub);
            }
        }

    } elsif (not exists $uxntal_lib_subroutines{$subname}) {
        warn "No such library subroutine: $subname\n";
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