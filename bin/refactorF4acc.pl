#!/usr/bin/env perl
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use 5.010;
use warnings;
use strict;

use vars qw( $VERSION );
$VERSION = "5.1.1";

use RefactorF4Acc::Main qw( main usage );

&main();

sub VERSION_MESSAGE {	
	if (join(' ',@ARGV)=~/--help/) {
		usage();
	}
	die "Version: $VERSION\n";
}