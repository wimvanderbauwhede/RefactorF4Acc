package RefactorF4Acc::Config;
# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use warnings;
use strict;
use Exporter;

@RefactorF4Acc::Config::ISA = qw(Exporter);
@RefactorF4Acc::Config::EXPORT = qw(
$VER
$V $W $I
$NO $YES $GO
$UNREAD $READ $PARSED $FROM_BLOCK $C_SOURCE
$noop
$call_tree_only
$main_tree
$gen_sub
$translate
$targetdir
%Config
&read_config    
);

our $VER = '0.3';

our $V = 0;    # Verbose
our $W = 0;    # Warnings
our $I = 0;    # Info

# Instead of FORTRAN's 'continue', we insert a call to a subroutine noop() that does nothing
# This is because F2C_ACC handles continue incorrectly
our $noop           = 1;
our $call_tree_only = 0;
our $main_tree      = 0;

# Flag used when generating a subroutine from a marked block of code
our $gen_sub = 0;

# States for translation to C etc
( our $NO, our $YES, our $GO ) = ( 0 .. 2 );
our $translate         = $NO;

# The state of each subroutine, function or include
#   FROM_BLOCK indicates a marked block of code factored out into a subroutine
#   C_SOURCE means that this source code will be translated to C
( our $UNREAD, our $READ, our $PARSED, our $FROM_BLOCK, our $C_SOURCE ) =
  ( 0 .. 4 );
our $targetdir = '../RefactoredSources';

our %Config=();

sub read_config {
	(my $cfgrc)=@_;
open my $CFG, '<', $cfgrc or die $!,': ',$cfgrc;
for my $line (<$CFG>) {
	next if $line=~/^\s*#/;
	next unless $line=~/=/;
	print $line if $V;
	chomp $line;
	$line=~s/\s+$//;
	(my $k, my $v) = split(/\s*\=\s*/,$line);
	if ($v=~/,/) {
		my @vs=split(/\s*,\s*/,$v);
		$Config{$k}=[@vs];
	} else {
		$Config{$k}=[$v];
	}
}
close $CFG;
}


1;