package MacroFileToCmdLine;

# 
#   (c) 2018- Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   
	
use vars qw( $VERSION );
$VERSION = "1.0.0";

use v5.10;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Cwd qw( cwd );

use Exporter;

@MacroFileToCmdLine::ISA = qw(Exporter);

@MacroFileToCmdLine::EXPORT_OK = qw(
    &macro_file_to_cmd_line_str
    &get_macro_defs_from_file
);

# returns the strings for defined and undefined macros
sub macro_file_to_cmd_line_str { (my $macros_src, my $flag)=@_;
	# If flag is defined it is a single flag with space-sep macros, else it is a space-sep list of the flag followed by the macro
	# if $flag is not defined '-D' is used for defined and '-U' for undefined
	# e.g. 
	# #define VERBOSE
	# #undefine TEST
	# #define NTH 8
	# e.g. -X: -X VERVBOSE NTH=8 (undefineds are skipped)
	# e.g. else: -DVERVBOSE -UTEST -DNTH=8			
	# 
	if (not defined $flag) {$flag='';}
	elsif ($flag!~/^\-/) {$flag='-'.$flag;}
			
	
	
	(my $defined_macros_ref,my $undef_macros_ref)= get_macro_defs_from_file($macros_src);
	my @defined_macros=@{ $defined_macros_ref };
	my @undef_macros= @{ $undef_macros_ref };
	warn "No #define macros found!\n" unless @defined_macros;
	warn "No #undef macros found!\n" unless @undef_macros;
		
	my $defined_macros_str ='';
	my $undef_macros_str='';
	if ($flag eq '') {
		$defined_macros_str = join(' ',map { "-D$_" } @defined_macros);
		$undef_macros_str = join(' ',map { "-U$_" } @undef_macros);	
	} else {
		$defined_macros_str = $flag.' '.join(' ',@defined_macros);
	}
		 	
	return ($defined_macros_str, $undef_macros_str);
}

sub get_macro_defs_from_file { (my $macros_src)=@_; 
	open my $MK, '<', $macros_src or die cwd().": $! $macros_src"; 
	my @defined_macros=();
	my @undef_macros=();
	
	while (my $line=<$MK>) {
	    chomp $line;	
	    next if $line=~/^\s*$/;
	    $line=~s/^\s*//;
	    $line=~s/\s*$//;
        $line=~s/^\s*#(\w+)\s+//;
        my $cmd = $1;
        $line=~s/\s+//;
        if ($cmd eq 'define') {
        	$line=~s/\#define\s*//;
        	$line=~s/\s+(\d+)/=$1/;
            push @defined_macros, $line;
        } elsif ($cmd eq 'undef') {
        	$line=~s/\#undef\s*//;
        	$line=~s/\s+\d+$//;
            push @undef_macros, $line;
        }
    }	
	close $MK;
	
	return (\@defined_macros,\@undef_macros);
}

1;

