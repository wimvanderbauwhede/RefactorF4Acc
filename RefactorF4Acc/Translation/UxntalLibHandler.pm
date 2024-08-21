package RefactorF4Acc::Translation::UxntalLibHandler;

use v5.30;

use RefactorF4Acc::Utils;

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
'max' => [ # UNTESTED!
	'@min',
	'OVR2 OVR2 GTH2 #00 SWP DUP2 #0001 SWP2 SUB2',
	'ROT2 MUL2 ROT2 ROT2 MUL2 ADD2',
	'JMP2r'
],
'not'	=>['@not #01 SWP SUB JMP2r'],
'mod' => [
    '( a:16 b:16 -- m:16 )',
	'@mod',
	'OVR2 OVR2  ( a b a b )',
	'DIV2  ( a b a/b )',
	'MUL2  ( a b*(a/b) )',
	'SUB2 ( a-b*(a/b) )',
	'JMP2r'
],
'pow' => [
    '( mantissa: short; exponent: short>0 )',
    '( m* e* -- r* )',
    '@pow',
    '#0000 NEQ2 ,&one JCN',
    'POP2 #0001 JMP2r',
    '&one',
    '#0001 NEQ2 ,&calc JCN',
    'JMP2r',
    '&calc',
    'STH2 STH2 DUP2r',
    '#0001 ( 1 | e m acc=m )',
    '&l',
    'INC2',
    'OVR2r MUL2r ( 2 | e m acc )',
    'ROT2r DUP2r STH2r ROT2r ROT2r ( 2 e | e m acc )',
    'OVR2 ( 2 e 2 )',
    'NEQ2 ,&l JCN',
    'POP2 STH2r POP2r POP2r',
    'JMP2r' 
],
'iachar' => [
	'@iachar', # HACK: ignoring kind, returns a short
	'#00 SWP JMP2r'
],
# 'lte2' => [
#     '@lte2', 
#     'GTH2 #01 SWP SUB JMP2r'
# ],
# 'lte' => [
#     '@lte', 
#     'GTH #01 SWP SUB JMP2r'
# ],
# 'gte2' => [
#     '@gte2', 
#     'LTH2 #01 SWP SUB JMP2r'
# ],
# 'gte' => [
#     '@gte', 
#     'GTH #01 SWP SUB JMP2r'
# ],
'iand' => [
    '@iand','AND2 JMP2r'
],
'ishft' => [ # ishft() 
    '@ishft',
    'DUP #07 SFT ?&right',
    '#40 SFT ,&done JMP',
    '&right',
    '#00 SWP SUB',
    '&done',
    'SFT2 JMP2r'
],
'exit' => [
    '@exit', 'POP2','#80 .System/state DEO', 'BRK'
],
# 'trim' => [
#     '@trim', '( a NOOP, TODO! )','JMP2r'
# ],
# 'adjustl' => [
#     '@adjustl', '( a NOOP, TODO! )','JMP2r'
# ],

'wst' =>[ '','( show number of bytes on the WST. Takes an arbitrary char to print as info )',
    '@wst', '#5718 DEO #18 DEO #2018 DEO .System/wst DEI #01 SUB #00 SWP print-int nl','JMP2r'
]

);

sub load_uxntal_lib_subroutines(@uxntal_lib_sources) {
    for my $uxntal_lib_source (@uxntal_lib_sources) {
        say "LIB: $uxntal_lib_source" if $VV;
        open my $LIB, '<', $uxntal_lib_source or die "$! $uxntal_lib_source";
        my $in_sub=0;
        my $current_sub='';
        my $src_single_line='';
        while (my $line=<$LIB>){
            chomp $line;
            $src_single_line.=" $line ";
        }
        close $LIB;
        my $src_single_line_no_comments = _remove_comments($src_single_line);
        my @lines = split(/\s+/,$src_single_line_no_comments);

        for my $line (@lines) {
            if ($line=~/^\@([\w\-]+)$/) {
                $in_sub=1;
                $current_sub=$1;
                say "SUB: $current_sub" if $VV;
                $uxntal_lib_subroutines{$current_sub}=[];
                $line = "\n$line";
            }
            if ($in_sub==1) {
                push @{$uxntal_lib_subroutines{$current_sub}},$line;
            }
        }
    }
    # croak Dumper sort keys %uxntal_lib_subroutines;
}

# - Everytime a call is used, mark the subroutine

our %used_uxntal_lib_subroutines = ();
our %not_library_subroutines = ();
sub add_to_used_lib_subs($subname) {
    if (not exists $used_uxntal_lib_subroutines{$subname}
    and exists $uxntal_lib_subroutines{$subname}
    ) {
        $used_uxntal_lib_subroutines{$subname}=$uxntal_lib_subroutines{$subname};
        for my $line (@{$used_uxntal_lib_subroutines{$subname}}) {
            my $tline = $line;
            while ($tline=~/\(.+?\)/){$tline=~s/\(.+?\)//;}
            my @tokens = split(/(?:^|\s+)[\;\!]?/,$tline);
            # croak "<$tline>",@tokens if $tline=~/\!proc\-n/;
            my @called_subs = grep { /^[\w\-]+$/ && !/^[A-Z][A-Z][A-Z][2kr]*$/ } @tokens;
            for my $called_sub (@called_subs) {
                add_to_used_lib_subs($called_sub);
            }
        }

    } elsif (not exists $uxntal_lib_subroutines{$subname}) {
        $not_library_subroutines{$subname}=1;
        # warn "No such library subroutine: $subname\n";
    }
}

sub emit_used_uxntal_lib_subroutine_sources(){
    my @sources = ();
    for my $subname (sort keys %used_uxntal_lib_subroutines) {
        @sources = (@sources,@{$used_uxntal_lib_subroutines{$subname}});
    }
    for my $subname (sort keys %not_library_subroutines ) {
        next if $subname=~/^(:?main|buf|totalMemUsage|call\-stack)$/;
        warning("No such library subroutine: $subname",0);
    }
    return @sources;
}

sub _remove_comments($str_with_comments) {
    my @chars=split('',$str_with_comments);
    my $str_no_comments='';
    my $parct=0;
    for my $char (@chars) {
        if ($char eq '(') {
            $parct++;
        }
        elsif ($char eq ')') {
            $parct--;
        } 
        elsif ($parct==0) {
            $str_no_comments .= $char;
        }
    }
    return $str_no_comments;

}

 # ISHFT returns a value corresponding to I with all of the bits shifted SHIFT places. 
 # A value of SHIFT greater than zero corresponds to a left shift, 
 # A value of zero corresponds to no shift, 
 # A value less than zero corresponds to a right shift
 

1;