package RunCpp;

# 
#   (c) 2018- Wim Vanderbauwhede <wim.vanderbauwhede@glasgow.ac.uk>
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
use MacroFileToCmdLine qw( macro_file_to_cmd_line_str get_macro_defs_from_file);
use Exporter;

@RunCpp::ISA = qw(Exporter);

@RunCpp::EXPORT_OK = qw(
    &run_cpp
);

##!/usr/bin/env perl
#use v5.10;
#use warnings;
#use strict;
#use Data::Dumper;
#use Cwd;
#
our $VV=1;
our $wd=undef;
#
#run_cpp(@ARGV);

sub run_cpp { my @args=@_;  
	$wd=cwd();

	my $single=0;
	my $single_src='';
	if (@args) {
	    $single=1;
	    $single_src=$args[0];
	}

    my $macros_file = './macros.h';
    if (@args==2) {
        $macros_file=$args[1];
    }
	
    my $macros_to_skip_file = './macros_to_skip.h';
    if (@args==3) {
        $macros_file=$args[2];
    }
	
	my @macros_to_skip=();
	my @defined_macros=();
	my @undef_macros=();
	my $no_macros=0;
	my $macros_str='';
	my $defined_macros_str='';
	 my $undef_macros_str=''; 
	# If a file 'macros.h' exists, the #define'd macros from that file will be used.
	if (-e $macros_file) { 
		( $defined_macros_str,  $undef_macros_str) = macro_file_to_cmd_line_str( $macros_file);
		$macros_str = "$defined_macros_str  $undef_macros_str";
	
	} else {
	    $no_macros=1;
	}

	# If 'macros_to_skip.h' exists, the code segments guarded by these macros will be removed from the source and written to a file 
	# NOTE: macros with #undef are ignored
	if (-e $macros_to_skip_file) {
			(my $defined_macros_ref,my $undef_macros_ref)= get_macro_defs_from_file($macros_to_skip_file);
			@macros_to_skip=@{ $defined_macros_ref };
			my @undef_macros= @{ $undef_macros_ref }; # unused		
	} elsif ($no_macros) {
	    die "Could not find $macros_file or $macros_to_skip_file";
	}

	# Processed files go in PostCPP
	if (not -d "$wd/../PostCPP") {
	    mkdir "$wd/../PostCPP";
	}
	if (not -d "$wd/../PostCPP/PrePostCPP") {
	    mkdir "$wd/../PostCPP/PrePostCPP";
	}
	
	my $stash_ref = {};
	
	my @srcdirs=qw(.);
	# FIXME: this only supports one level of subdirectories
	my @includes = map {"-I$wd/".$_}  @srcdirs;
	my $includestr = join(' ',@includes);
	
	my @includes_l1 = map {"-I$wd/../".$_}  @srcdirs;
	my $includestr_l1 = join(' ',@includes);
	
	my @defines = map {"-D".$_}  @defined_macros;
	my $definestr = join(' ',@defines);
	my @undefs = map {"-U".$_} @undef_macros;
	my $undefstr = join(' ',@undefs);


	for my $srcdir (@srcdirs) {
	    if (not -d "$wd/../PostCPP/$srcdir") {
	        system("mkdir -p $wd/../PostCPP/$srcdir");
	    }
	    if (not -d "$wd/../PostCPP/PrePostCPP/$srcdir") {
	        system("mkdir -p $wd/../PostCPP/PrePostCPP/$srcdir");
	    }    
	    chdir "$wd/$srcdir";
	
	    my @srcs = $single ? ( $single_src ) : glob("*.f95");
	    for my $src (@srcs) {
	        my $src_path = "$wd/../PostCPP/PrePostCPP/$srcdir/$src";
	        $stash_ref = stash_lines_to_skip($src,$stash_ref,\@macros_to_skip,$src_path);
	        my $out_path = $single ? '' : "$wd/../PostCPP/$srcdir/$src";
	        run_cpp_and_clean_up( $no_macros, $includestr,  $macros_str, $src_path, $out_path );
	    }
	    chdir $wd;
	}
	say Dumper($stash_ref) if $VV;
	open my $STASH, '>', 'stash.pl';
	print $STASH Dumper($stash_ref);
	close $STASH;

} # END of run_cpp()
#
sub run_cpp_and_clean_up { (my $no_macros, my $includestr, my $definestr, my $src_path, my $out_path) = @_;
    my $cmd_cpp =  $no_macros ? "cat $src_path " : "cpp -Wno-invalid-pp-token -P  $includestr $definestr -Wno-extra-tokens $src_path ";
    my $redir = $out_path eq '' ? '' : '>';
    my $cmd_clean_up = "| grep -v -E '^\\s*\\!\\s*[a-z\#]|^\\s*\$' | perl -p -e 's/^([^\\!]+)\\s*\\!.+\$/\$1/' $redir $out_path";#$wd/../PostCPP/$src_path";
	my $cmd = $cmd_cpp.$cmd_clean_up;
    say $cmd if $VV;
    system( $cmd );  
}

# I need to keep a stack for the #if/#endif blocks
# Then go through all lines, if we find a line with a matching macro, no matter if it is #if, #ifdef or #ifndef, we push all lines in the block onto @stored_lines
# We replace them by a "7188 continue" as in the other code
sub stash_lines_to_skip { (my $srcfile, my $stash_ref, my $macros_list, my $output_path) =@_;
    my %macros_to_skip = map {$_ => 1} @{ $macros_list };
    my @blocks_stack=();
    my @stored_lines=();
    my $placeholder = 7188;
    my @out_lines=();
    my $in_block='';
    my $in_decls=0;
    
    $stash_ref->{$srcfile}={};
    open my $IN, '<', $srcfile or die $!;
    while (my $line = <$IN>) {
        chomp $line;
        if ($line=~/^\s*\#if\w*\s+(.+)\s*$/) {
            # put on the stack
            my $macro = $1;
            # for simple MACRO == ... and similar we attempt to detect them
            # FIXME: we should actually detect all macros on the line and test if any of them is in the skip list
            $macro=~s/\s*[\!\=\>\<]+.+//;
            push @blocks_stack, $macro;
            if (exists $macros_to_skip{$macro}) { 
                # put the placeholder line
                $in_block=$macro;
                $in_decls=0;
                $stash_ref->{$srcfile}{$placeholder}=[];
                # push the line onto the list of lines for this placeholder
                push @{ $stash_ref->{$srcfile}{$placeholder}}, $line;
            } else {
	            if ($in_block ne '') {
    	            push @{ $stash_ref->{$srcfile}{$placeholder}}, $line;
        	    } else {
                # do nothing
                	push @out_lines, $line;
           		}
            }
        } elsif ($line=~/^\s*\#endif/) { 
            # pop off the stack
            my $macro = pop @blocks_stack;
            # if this line is the end of a block, resume normal operation
            if (scalar @blocks_stack == 0 and $in_block eq $macro and $macro ne '') {
                push @{ $stash_ref->{$srcfile}{$placeholder}}, $line;
                my $maybe_comment = $in_decls ? '!' : '';
                push @out_lines, $maybe_comment.'  '.$placeholder.' continue';
                $in_block='';
                $placeholder++;
            } else {
                if ($in_block ne '') {
                    push @{ $stash_ref->{$srcfile}{$placeholder}}, $line;
                } else {
                    # do nothing
                    push @out_lines, $line;
                }
            }
        } else {
            if ($in_block ne '') {
	            # if we're in a block, stash
             	push @{ $stash_ref->{$srcfile}{$placeholder}}, $line;
             	if ($line=~/^\s*use\s+|::/) {
             		$in_decls=1;
             	} 
            } else {
            # otherwise, do nothing
             push @out_lines, $line;

            }
        }
    }
    close $IN;
    open my $OUT, '>', $output_path or die $!;
    map {say $OUT $_} @out_lines;
    close $OUT;
    if (not exists  $stash_ref->{$srcfile}{--$placeholder}) {
        delete $stash_ref->{$srcfile};
    }
    return $stash_ref;
}

1;
