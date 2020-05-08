package RefactorF4Acc::Emitter;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( create_refactored_source );
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.2.0";

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

sub emit_all {
    (my $stref)=@_;
    if ($I) {
        print "=" x 80,"\n";
        print "ENTERING EMIT_ALL\n";
        print "=" x 80,"\n";
    }
    my $EXT = $Config{EXT};
    # I build a fresh list here. I should just delete 'F' at the end
    $stref->{'BuildSources'}{$EXT}={};

    _init_emit_all($stref) unless $DUMMY;
    for my $src (keys %{ $stref->{'SourceContains'} } ) {
        if (exists $stref->{'SourceContains'}{$src}{'Path'} and  exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'}) {
        	say "SKIPPING $src";
        	next ;
        }
        print '! ','-' x 80,"\n" if $I;
        print "INFO: emitting refactored code for $src\n" if  $I;
        
            my ($has_subdirs, $subdir_path) = __get_src_subdirs($src);
	        # if ( $src =~ /\w\/\w/ ) {
	        #     # Source resides in subdirectory, create it if required
	        #     my @dirs = split( /\//, $src );
            #     if (! -d $src) {
            #         pop @dirs;
            #     }

            #     my @subdirs = @dirs ;
            #     if ($subdirs[0] eq '.') {
            #         shift @subdirs;
            #     }
	        #     # my @subdirs = @dirs; grep {$_!~/\./} @dirs; # A bit weak, right? 
            #     # for my $srcdir (@{$Config{'SRCDIRS'}}) {
            #     #     @subdirs = grep {$_!~/$srcdir/} @subdirs;
            #     # }
            #     # my $fullpath = join('/',@dirs);
	        #     my $dirpath=join('/',@subdirs);
            if (not $DUMMY) {
                if ($has_subdirs) {
                    say "CREATING SUBDIR $targetdir/$subdir_path" if $V;
	                system("mkdir -p $targetdir/$subdir_path");                    
                }
            }
                # } else {
                #     pop @subdirs;
                #     my $dirpath=join('/',@subdirs);
                #     if (not -d "$targetdir/$dirpath") {
                #         say "CREATING SUBDIR $targetdir/$dirpath" if $V;
                #         system("mkdir -p $targetdir/$dirpath");                        
                #     }
                # }
	        # }
        
	   if ($I) {            
            print "INFO:\tSRC: $src\n";
            print "INFO:\tCONTAINS: ";
            print join(', ',@{ $stref->{'SourceContains'}{$src}{'List'}   } ),"\n";
            say "";
	   }
	   
        if (    not exists $stref->{'BuildSources'}{'C'}{$src}
                and not exists $stref->{'BuildSources'}{'F'}{$src} ) {                	
                	say "INFO: Emitter: ADD $src to BuildSources" if $I;
            $stref->{'BuildSources'}{'F'}{$src} = 1;
        } elsif ( exists $stref->{'BuildSources'}{'F'}{$src} and $stref->{'BuildSources'}{'F'}{$src}==0) {
        	say "INFO: Emitter: REMOVE $src from BuildSources" if $I;
        	delete $stref->{'BuildSources'}{'F'}{$src};
        }               

		my $nsrc=$src;
		if (exists $stref->{'BuildSources'}{'F'}{$src} ) {
			$nsrc=~s/\.\w+$/$EXT/;
		}
        if (exists $stref->{'IncludeFiles'}{$src} ) {
                for my $srcdir (@{$Config{'SRCDIRS'}}) {
                    if (-e "$srcdir/$src") {
                        $nsrc = "$srcdir/$src";
                        last;
                    }
                }            
        }
        if ($nsrc=~/$EXT$/) {
		    $stref->{'BuildSources'}{$EXT}{$nsrc}=1 ;
        }
		if ($DUMMY) {
			say '! '.('=' x 80);
            say "! FILE: $targetdir/$nsrc ($src)";
            say '! '.('=' x 80);
        	show_annlines($stref->{'RefactoredCode'}{$src},0);
        } else {
            say "! FILE: $targetdir/$nsrc ($src)";

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
#				say $mod_line->[0];
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
        say "! WRITE TO $targetdir";
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
    delete $stref->{'BuildSources'}{'F'};
	return $stref;

} # END of emit_all()
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# This routine does not generate or manipulate files, it only does copying etc. 
sub _init_emit_all { (my $stref) = @_;
        # if target dir for refactored code does not exist, create it
        # and copy include files into it
    if ( not -e $targetdir ) {
    	say "Creating NEWSRCPATH $targetdir" if $V;
        mkdir $targetdir;
        # FIXME: the includes should be taken from $stref->{'IncludeFiles'}
        # But actually, all includes should have been converted to F95 modules!        
    } elsif ( not -d $targetdir ) {
        die "ERROR: $targetdir exists but is not a directory!\n";        
    } else {
    	# target dir exists. check if subdirs exists
    	my $wd=cwd();
        for my $srcdir (@{ $stref->{'SourceDirs'} }) {
            
        	if (not -d "$wd/$targetdir/$srcdir") {
                say "Creating SRCDIR $srcdir inside $targetdir" if $V;    
				system("mkdir -p $wd/$targetdir/$srcdir"); # FIXME: WEAK! only one level!
        	}
        }        
    	
    	# Remove existing Fortran-95 sources
		__remove_previously_generated_f95_sources($stref);
    }    
}
# -----------------------------------------------------------------------------
sub _emit_refactored_include {
    ( my $f, my $dir, my $stref ) = @_;    
    # local $I=1;
    # local $V=1;
    
    say "INCLUDE: $f" if $I;
    my $srcref = $stref->{'IncludeFiles'}{$f}{'RefactoredCode'};
    my $incsrc=$stref->{'IncludeFiles'}{$f}{'Source'};

    if ( defined $srcref ) {
        if ($DUMMY) {
            say '! '.('=' x 80);
            say "! FILE: $dir/$incsrc";
            say '! '.('=' x 80);
            show_annlines($srcref,0);
        } else {

        my $nsrc=$incsrc;

   
    if (exists $stref->{'IncludeFiles'}{$f}{'SrcPath'}){
        my ($has_subdirs, $subdir_path) = __get_src_subdirs($stref->{'IncludeFiles'}{$f}{'SrcPath'});
        $nsrc="$subdir_path/$incsrc";
        if (not -d "$dir/$subdir_path") {
            system("mkdir -p $dir/$subdir_path");
        }
    }

        for my $srcdir (@{$Config{'SRCDIRS'}}) {
            if (-e "$srcdir/$f") {
                $nsrc = "$srcdir/$incsrc";
                last;
            } else {
#   'Source' => 'params_PARALLEL.f90',
#   'InclType' => 'Parameter',
#   'Root' => 'PARALLEL',
                if ($stref->{'IncludeFiles'}{$f}{'InclType'} eq 'Parameter'
                and exists $stref->{'IncludeFiles'}{$f}{'Root'}
                ) {
                    my $orig_f=$stref->{'IncludeFiles'}{$f}{'Root'};
                    if (-e "$srcdir/$orig_f") {
                        $nsrc = "$srcdir/$incsrc";
                    }
                }                
            }
        }            
        
        my $EXT = $Config{EXT};
        $stref->{'BuildSources'}{$EXT}{$nsrc}=1;
        print "INFO: emitting refactored code for include $f in $dir/$nsrc\n" if $I;
#        say "! FILE: $dir/$incsrc";
        open my $SRC, '>', "$dir/$nsrc" or die "$!: $dir/$nsrc";
        
        my $prevline='C ';
        $srcref = create_refactored_source($stref,$f,$srcref);
        for my $annline ( @{$srcref} ) {
        	my $line = $annline->[0];  
            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
            print $SRC "$line\n";
            print "$line\n" if $DBG;
            }
            $prevline=$line;
        }
        close $SRC;
        }
    } else {
#    	say "Not writing $f";
    }
} # END of emit_refactored_include

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
		my @srcs = glob('*'.$Config{EXT});
		for my $src (@srcs) {
			unlink $src;
		}
		chdir $wd;
	}
}

sub __get_src_subdirs { my ($src_path) = @_;
    if ( $src_path =~ /\w\/\w/ ) {
        my @dirs = split( /\//, $src_path );
        if (! -d $src_path) {
            pop @dirs;
        }

        my @subdirs = @dirs ;
        if ($subdirs[0] eq '.') {
            shift @subdirs;
        }
        my $subdirpath=join('/',@subdirs);
        return (1,$subdirpath);
    } else {
        return (0,'');
    }
} # END of __get_src_subdirs