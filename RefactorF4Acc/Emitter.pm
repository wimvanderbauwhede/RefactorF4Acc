package RefactorF4Acc::Emitter;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( create_refactored_source );
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
#use Digest::MD5;
#use File::Copy;
use Cwd;

use Exporter;
@RefactorF4Acc::Emitter::ISA = qw(Exporter);
@RefactorF4Acc::Emitter::EXPORT_OK = qw(
    &emit_all
);

# -----------------------------------------------------------------------------
# This routine does not generate or manipulate files, it only does copying etc. 
sub _init_emit_all { (my $stref) = @_;
        # if target dir for refactored code does not exist, create it
        # and copy include files into it
    if ( not -e $targetdir ) {
    	
        mkdir $targetdir;
        # FIXME: the includes should be taken from $stref->{'Includes'}
        # But actually, all includes should have been converted to F95 modules!        
    } elsif ( not -d $targetdir ) {
        die "ERROR: $targetdir exists but is not a directory!\n";        
    } else {
    	# target dir exists. check if subdirs exists
    	my $wd=cwd();
        for my $srcdir (@{ $stref->{'SourceDirs'} }) {
        	if (not -d "$wd/$targetdir/$srcdir") {
				system("mkdir -p $wd/$targetdir/$srcdir"); # FIXME: WEAK! only one level!
        	}
        }        
    	
    	
    	
    	# Remove existing Fortran-95 sources
#        my @oldsrcs = glob("$targetdir/*".$EXT);        
#        map { unlink $_ } @oldsrcs;
		__remove_previously_generated_f95_sources($stref);
        # Check if includes have changed
        # WV: This is rididiculous because it only works for include files of pattern "include*"
        # I should instead test all include files in the tree, FIXME!
#        my @incs = glob('include*');
#        for my $inc (@incs) {
#            open( my $OLD, $inc );
#            binmode($OLD);
#            open( my $NEW, $inc );
#            binmode($NEW);
#            if ( Digest::MD5->new->addfile($OLD)->hexdigest ne
#                Digest::MD5->new->addfile($NEW)->hexdigest )
#            {
#                copy( $inc, "$targetdir/$inc" );
#            }
#            close $OLD;
#            close $NEW;
#        }
    }    
}
# -----------------------------------------------------------------------------
sub _emit_refactored_include {
    ( my $f, my $dir, my $stref ) = @_;    
    my $srcref = $stref->{'IncludeFiles'}{$f}{'RefactoredCode'};
    my $incsrc=$stref->{'IncludeFiles'}{$f}{'Source'};
    
    if ( defined $srcref ) {
        if ($DUMMY) {
            say '! '.('=' x 80);
            say "! FILE: $dir/$incsrc";
            say '! '.('=' x 80);
        show_annlines($srcref,0);
        } else {
        print "INFO: emitting refactored code for include $f\n" if $V;
        
        open my $SRC, '>', "$dir/$incsrc" or die "$!: $dir/$incsrc";
        my $prevline='C ';
        $srcref = create_refactored_source($stref,$f,$srcref);
        for my $annline ( @{$srcref} ) {
        	my $line = $annline->[0];  
            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
            print $SRC "$line\n";
            print "$line\n" if $V;
            }
            $prevline=$line;
        }
        close $SRC;
        }
    }
} # END of emit_refactored_include

# -----------------------------------------------------------------------------

sub emit_all {
    (my $stref)=@_;
    if ($I) {
        print "=" x 80,"\n";
        print "ENTERING EMIT_ALL\n";
        print "=" x 80,"\n";
    }

    _init_emit_all($stref) unless $DUMMY;
    for my $src (keys %{ $stref->{'SourceContains'} } ) {
        if (exists $stref->{'SourceContains'}{$src}{'Path'} and  exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'}) {
        	say "SKIPPING $src";
        	next ;
        }
        print "INFO: emitting refactored code for $src\n" if $V;
        if (not $DUMMY) {
	        if ( $src =~ /\w\/\w/ ) {
#	        	say "SRC in SUBDIR: $src";    
	            # Source resides in subdirectory, create it if required
	            my @dirs = split( /\//, $src );
	            say Dumper(@dirs);
	            my @subdirs = grep {$_!~/\./} @dirs;
	            my $dirpath=join('/',@subdirs);
#	            say "MKDIR $targetdir/$dirpath";
#	            die `pwd`;
	            system("mkdir -p $targetdir/$dirpath");
#	            map {
#	                my $targetdir = $_;
#	                if ( not -e $targetdir ) {
#	                    mkdir $targetdir;													                    
#	                }
#	            } @dirs;
	        }
        }
	   if ($I) {
            print '! ','-' x 80,"\n";
            print "! SRC: $src\n";
            print "!\tCONTAINS: ";
            print join(', ',@{ $stref->{'SourceContains'}{$src}{'List'}   } ),"\n";
	   }
	   
        if (    not exists $stref->{'BuildSources'}{'C'}{$src}
                and not exists $stref->{'BuildSources'}{'F'}{$src} ) {                	
#                	say "Emitter: ADD $src to BuildSources";
            $stref->{'BuildSources'}{'F'}{$src} = 1;
        }        

		my $nsrc=$src;$nsrc=~s/\.f$/$EXT/;
		
		if ($DUMMY) {
			say '! '.('=' x 80);
            say "! FILE: $targetdir/$nsrc ($src)";
            say '! '.('=' x 80);
#            croak Dumper($stref->{Subroutines}{press}{RefactoredCode}) if $src=~/press/;
        	show_annlines($stref->{'RefactoredCode'}{$src},0);
        } else {
			open my $TGT, '>', "$targetdir/$nsrc" or die $!.": $targetdir/$nsrc";
			
			my $mod_lines = $stref->{'RefactoredCode'}{$src};
			
			for my $mod_line (@{ $mod_lines }) {
				my $info = $mod_line->[1];
				if (exists $info->{'Blank'}
				or exists $info->{'Skip'}
				or exists $info->{'Deleted'}
				) {
					next;
				}
				print $TGT	$mod_line->[0];
				if ($ANN and exists $mod_line->[1]->{'Ann'}) {
					say $TGT ' ! '.join('; ',@{ $mod_line->[1]{'Ann'} });
				} else {
					print $TGT "\n";
				} 
			}
			close $TGT;
        }
	} # loop over all source files
    
    for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {
        if ($I) {
        print "! "."=" x 80,"\n";
        print "! INCLUDE FILE: $f\n";
        print "! "."=" x 80,"\n";
        }
        _emit_refactored_include( $f, $targetdir, $stref );
    }
    if ($DUMMY) {
        say '! '. '=' x 80;
        say '! DUMMY GENERATION DONE';
        say '! '.'=' x 80;
    }
    # NOOP source
    # Note that we always use the C source
    if ($noop and not $DUMMY) {
        _gen_noop($targetdir);        
    }

	return $stref;

} # END of emit_all()
# -----------------------------------------------------------------------------
sub _gen_noop {
    (my $tgtdir)=@_;
    open my $NOOP,'>',"$tgtdir/noop.c";
    print $NOOP '// Instead of continue, use a subroutine to do nothing. 
//Purely for translation, to get around a bug in F2C_ACC: in the C code we drop them!
void noop_ () {
    return;
}
';
    close $NOOP;

}

sub UNUSED_gen_break {
    open my $BREAK,'>','/tmp/break.c';
    print $BREAK,'
void break(int l) {
        break;
}
';
close $BREAK;
}

sub __remove_previously_generated_f95_sources { (my $stref)=@_;
	my $wd=cwd();
	for my $srcdir (@{ $stref->{'SourceDirs'} }) {
		chdir "$wd/$targetdir/$srcdir";
		my @srcs = glob('*'.$EXT);
		for my $src (@srcs) {
			unlink $src;
		}
		chdir $wd;
	}
}