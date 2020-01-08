package RefactorF4Acc::RunCpp;

# 
#   (c) 2018- Wim Vanderbauwhede <wim.vanderbauwhede@glasgow.ac.uk>
#   
	
use vars qw( $VERSION );
$VERSION = "1.2.0";

use v5.10;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Cwd qw( cwd );
use Getopt::Std;

use RefactorF4Acc::MacroFileToCmdLine qw( macro_file_to_cmd_line_str get_macro_defs_from_file);
use Exporter;

@RefactorF4Acc::RunCpp::ISA = qw(Exporter);

@RefactorF4Acc::RunCpp::EXPORT_OK = qw(
    &run_cpp
);

##!/usr/bin/env perl
#use v5.10;
#use warnings;
#use strict;
#use Data::Dumper;
#use Cwd;
#
our $VV=0;
our $wd=undef;
our $strip_comments=1;
our $output_dir = '../PostCPP';
our $srcs_pattern = "*.f* *.F* *.inc";

#run_cpp(@ARGV);
our $usage = <<'ENDH';
	This script expects a file `macros.h` in the current folder
	Without arguments, this script will call `cpp` on all files matching *.f *.F *.inc in the current folder and any subfolders (but only one level)
	If this is too restrictive, provide the patter with the -p flag
	
	The `cpp` arguments are `cpp -Wno-invalid-pp-token -P -Wno-extra-tokens`
	
	With a single filename as argument, this script will call `cpp` on that file
	The processed files are put in `../PostCPP`, you can change this with the -o <path> flag.
	
	By default, the script strips comments, to keep them use the -C option.
	The -v option will produce some debugging output.
	
	If you want to skip blocks of code guarded by #ifdef/#endif macros, you need to put those in a file `macros_to_skip.h` in the current folder.
	This will produce a file `stash.pl` which contains the code that was skipped. To replace that code, you can use the script `restore_stashed_lines.pl`.
ENDH

sub run_cpp { my @args=@_;  
	$wd=cwd();
	
	@args = parse_args(@args);
	
	my $single=0;
	my $single_src='';
	if (@args) {
#		if (@args == 1 && ($args[0] eq '-h' || $args[0] eq '--help')) {
#			die $help; 
#		} 
	    $single=1;
	    $single_src=$args[0];
	}
	
	my @macros_to_skip=();
	my @defined_macros=();
	my @undef_macros=();
	my $no_macros=0;
	my $no_macros_to_skip=0;
	my $macros_str='';
	my $defined_macros_str='';
	 my $undef_macros_str=''; 
	# If a file 'macros.h' exists, the #define'd macros from that file will be used.
	if (-e 'macros.h') { 
		( $defined_macros_str,  $undef_macros_str) = macro_file_to_cmd_line_str( './macros.h');
		$macros_str = "$defined_macros_str  $undef_macros_str";
	
	} else {
	    $no_macros=1;
	}

	# If 'macros_to_skip.h' exists, the code segments guarded by these macros will be removed from the source and written to a file 
	# NOTE: macros with #undef are ignored
	if (-e 'macros_to_skip.h') {
			(my $defined_macros_ref,my $undef_macros_ref)= get_macro_defs_from_file('./macros_to_skip.h');
			@macros_to_skip=@{ $defined_macros_ref };
			my @undef_macros= @{ $undef_macros_ref }; # unused		
	} else {
		$no_macros_to_skip=1;
		if ($no_macros) {
		    die 'Could not find macros.h or macros_to_skip.h'."\n\n".$usage;
		}
	}

	# Processed files go in PostCPP
	if (not -d "$wd/$output_dir") {
	    mkdir "$wd/$output_dir";
	}
	if (not -d "$wd/$output_dir/PrePostCPP") {
	    mkdir "$wd/$output_dir/PrePostCPP";
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
		# Create the current subdirs in ../PostCPP 
	    if (not -d "$wd/$output_dir/$srcdir") {
	        system("mkdir -p $wd/$output_dir/$srcdir");
	    }
	    # Create the current subdirs in ../PostCPP/PrePostCPP
	    if (not -d "$wd/$output_dir/PrePostCPP/$srcdir") {
	        system("mkdir -p $wd/$output_dir/PrePostCPP/$srcdir");
	    }    
	    chdir "$wd/$srcdir";
	
	    my @srcs = $single ? ( $single_src ) : glob($srcs_pattern); # This is too restrictive
	    
	    for my $src (@srcs) {
	        my $src_path = $no_macros_to_skip ? "$wd/$srcdir/$src" : "$wd/$output_dir/PrePostCPP/$srcdir/$src";
	        if (not $no_macros_to_skip) {
	        $stash_ref = stash_lines_to_skip($src,$stash_ref,\@macros_to_skip,$src_path);
	        }
	        if ($src=~/(\.F\d*)$/) {
	        	my $ext = $1;
	        	my $lc_ext = lc($ext);
	        	$src=~s/\.(F\d*)$/$lc_ext/;
	        }
	        
	        my $out_path = $single ? '' : "$wd/$output_dir/$srcdir/$src";
	        
	        
	        run_cpp_and_clean_up( $no_macros, $includestr,  $macros_str, $src_path, $out_path );
	    }
	    chdir $wd;
	}
	if (not $no_macros_to_skip) {	
		say Dumper($stash_ref) if $VV;
		open my $STASH, '>', 'stash.pl';
		print $STASH Dumper($stash_ref);
		close $STASH;
	}

} # END of run_cpp()
#
sub run_cpp_and_clean_up { (my $no_macros, my $includestr, my $definestr, my $src_path, my $out_path) = @_;
    my $cmd_cpp =  $no_macros ? "cat $src_path " : "cpp -Wno-invalid-pp-token -P  $includestr $definestr -Wno-extra-tokens $src_path ";
    my $redir = $out_path eq '' ? '' : '>';
    # The grep removes comment lines  (starting with '!')
    # The perl command removes trailing comments 
    my $cmd_clean_up = $strip_comments ? "| grep -v -E '^(?:\\s*\\!\\s*|[cC]\\s+)[a-z\#]|^\\s*\$' | perl -p -e 's/^([^\\!]+)\\s*\\![^\\N{QUOTATION MARK}\\N{APOSTROPHE}]+\$/\$1\n/' $redir $out_path" : " $redir $out_path";
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

sub parse_args { 
 	# Argument parsing. Factor out!
 	@ARGV=@_;
	my %opts = ();
	getopts( 'hvCo:p:', \%opts );
	
	my $help = ( $opts{'h'} ) ? 1 : 0;
	
    if ($help) {
        die $usage;
    }
    if ($opts{'v'}) {
    	$VV=1;
    }
    if ($opts{'C'}) {
    	$strip_comments=0;
    }
    if ($opts{'o'}) {
         $output_dir= $opts{'o'} ;
    }     
	if ($opts{'p'}) {
         $srcs_pattern = $opts{'p'} ;
    }
	my @args=@ARGV;
	return @args;
}

1;
