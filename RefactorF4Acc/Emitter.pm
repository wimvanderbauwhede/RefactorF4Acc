package RefactorF4Acc::Emitter;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( create_refactored_source );
# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Digest::MD5;
use File::Copy;

use Exporter;
@RefactorF4Acc::Emitter::ISA = qw(Exporter);
@RefactorF4Acc::Emitter::EXPORT_OK = qw(
    &emit_all
);

# -----------------------------------------------------------------------------
# This routine does not generate or manipulate files, it only does copying etc. 
sub _init_emit_all {
        # if target dir for refactored code does not exist, create it
        # and copy include files into it
    if ( not -e $targetdir ) {
        mkdir $targetdir;
        # FIXME: the includes should be taken from $stref->{'Includes'}
        # But actually, all includes should have been converted to F95 modules!        
    } elsif ( not -d $targetdir ) {
        die "ERROR: $targetdir exists but is not a directory!\n";
    } else {
    	# Remove existing Fortran-95 sources
        my @oldsrcs = glob("$targetdir/*.f95");        
        map { unlink $_ } @oldsrcs;

        # Check if includes have changed
        my @incs = glob('include*');
        for my $inc (@incs) {
            open( my $OLD, $inc );
            binmode($OLD);
            open( my $NEW, $inc );
            binmode($NEW);
            if ( Digest::MD5->new->addfile($OLD)->hexdigest ne
                Digest::MD5->new->addfile($NEW)->hexdigest )
            {
                copy( $inc, "$targetdir/$inc" );
            }
            close $OLD;
            close $NEW;
        }
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
        $srcref = create_refactored_source($stref,$srcref);
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
#
#sub UNUSED_emit_refactored_function {
#    ( my $f, my $dir, my $stref ) = @_;
#    my $Ff = $stref->{'Functions'}{$f};
#    print "EMITTING source for FUNCTION $f\n" if $V;
#
#    #    die Dumper($Ff->) if $f =~/ran3/;
#    my $overwrite = 0;
#
#    my $srcref = $Ff->{'RefactoredCode'};
#    my $s      = $Ff->{'Source'};
#    if ( defined $srcref ) {
#        print "INFO: emitting refactored code for function $f\n" if $V;
#        $s=~s/\.f$/.f95/;
#
#        #    } else {
#        #       $srcref=$Ff->{'Lines'};
#        #    }
#        my $mode = '>';
#        if ( -e "$dir/$s" and not $overwrite ) {
#            $mode = '>>';
#        } else {
#            if (    not exists $stref->{'BuildSources'}{'C'}{$s}
#                and not exists $stref->{'BuildSources'}{'F'}{$s} )
#            {
#                $stref->{'BuildSources'}{'F'}{$s} = 1;
#            }
#        }
#        open my $SRC, $mode, "$dir/$s" or die $!;
#        if ( $mode eq '>>' ) {
#            print $SRC "\n! *** FUNCTION $f ***\n";
#        }
#        my $prevline='C ';
#        for my $annline ( @{$srcref} ) {
#        	my $line = $annline->[0]; 
#            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
#            print $SRC "$line\n";
#            print "$line\n" if $V;
#            }
#            $prevline=$line;
#        }
#        close $SRC;
#
#    }
#
#    #    else {
#    #       warn "NO REFACTORED CODE FOR $f\n";
#    #       warn Dumper($Ff->{'Lines'});
#    #    }
#} # END of emit_refactored_function()

## -----------------------------------------------------------------------------
## This must change: we first need to create a list src -> subs
#sub UNUSED_emit_refactored_subroutine {
#    ( my $f, my $dir, my $stref, my $overwrite ) = @_;
#    my $Sf     = $stref->{'Subroutines'}{$f};
#    my $srcref = $Sf->{'RefactoredCode'};
#    if ( defined $srcref ) {
#        my $s = $Sf->{'Source'};
#        $s=~s/\.f$/.f95/;
#        print "INFO: emitting refactored code for $f in $s\n" if $V;
#        if ( $s =~ /\w\/\w/ ) {
#
#            # Source resides in subdirectory, create it if required
#            my @dirs = split( /\//, $s );
#            pop @dirs;
#            map {
#                my $targetdir = $_;
#                if ( not -e $targetdir ) {
#                    mkdir $targetdir;
#                }
#            } @dirs;
#        }
#        
#        my $mode = '>';
#        if ( -e "$dir/$s" and not $overwrite ) {
#            $mode = '>>';
#        } else {
#            if (    not exists $stref->{'BuildSources'}{'C'}{$s}
#                and not exists $stref->{'BuildSources'}{'F'}{$s} )
#            {
#                $stref->{'BuildSources'}{'F'}{$s} = 1;
#            }
#        }
#        open my $SRC, $mode, "$dir/$s" or die $!;
#        if ( $mode eq '>>' ) {
#            print $SRC "\n! *** SUBROUTINE $f ***\n";
#        }
#        my $prevline='! ';
#        for my $annline ( @{$srcref} ) {
#        	my $line = $annline->[0]; 
#            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
#            print $SRC "$line\n";
#            print "$line\n" if $V;
#            }
#            $prevline=$line;
#        }
#        close $SRC;
#    }
#} # END of emit_refactored_subroutine()

# -----------------------------------------------------------------------------

#sub UNUSED_emit_refactored_function_new {
#    ( my $f, my $stref ) = @_;
#    my $Ff = $stref->{'Functions'}{$f};
##	local $V=1;
#    print "EMITTING source for FUNCTION $f\n" if $V;
#    my @lines=();
#
#    my $srcref = $Ff->{'RefactoredCode'};
#    my $s      = $Ff->{'Source'};
#    if ( defined $srcref ) {
#            push @lines, "\n! *** FUNCTION $f ***\n";
#        
#        my $prevline='C ';
#        for my $annline ( @{$srcref} ) {
#            my $line = $annline->[0]; 
#            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
#            push @lines, "$line\n";
#            print "$line\n" if $V;
#            }
#            $prevline=$line;
#        }
#    }
#    return @lines;
#    #    else {
#    #       warn "NO REFACTORED CODE FOR $f\n";
#    #       warn Dumper($Ff->{'Lines'});
#    #    }
#} # END of emit_refactored_function_new()

## -----------------------------------------------------------------------------
## This must change: we first need to create a list src -> subs
#sub UNUSED_emit_refactored_subroutine_new {
#    ( my $f, my $stref ) = @_;
#    my $Sf     = $stref->{'Subroutines'}{$f};
#    my $srcref = $Sf->{'RefactoredCode'};
##	local $V=1;
#    my @lines=();
#    if ( defined $srcref ) {
#        print "INFO: emitting refactored code for $f\n" if $V;
#            push @lines,"\n! *** SUBROUTINE $f ***\n";
#        my $prevline='! ';
#        for my $annline ( @{$srcref} ) {
#            my $line = $annline->[0]; 
#            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
#            push @lines,"$line\n";
#            print "$line\n" if $V;
#            }
#            $prevline=$line;
#        }        
#    } else {
#	print "! SUBROUTINE $f: NO RefactoredCode (most likely sub not used)\n";
#	}
#    return @lines;
#} # END of emit_refactored_subroutine_new()
# -----------------------------------------------------------------------------
sub emit_all {
    (my $stref)=@_;
    if ($I) {
        print "=" x 80,"\n";
        print "ENTERING EMIT_ALL\n";
        print "=" x 80,"\n";
    }
    
          

    _init_emit_all() unless $DUMMY;
    for my $src (keys %{ $stref->{'SourceContains'} } ) {
        
        print "INFO: emitting refactored code for $src\n" if $V;
        if (not $DUMMY) {
        if ( $src =~ /\w\/\w/ ) {    
            # Source resides in subdirectory, create it if required
            my @dirs = split( /\//, $src );
            pop @dirs;
            map {
                my $targetdir = $_;
                if ( not -e $targetdir ) {
                    mkdir $targetdir;
                }
            } @dirs;
        }
        }
	   if ($I) {
            print '! ','-' x 80,"\n";
            print "! SRC: $src\n";
            print "!\tCONTAINS: ";
            print join(', ',keys %{  $stref->{'SourceContains'}{$src}   } ),"\n";
	   }
	   
        if (    not exists $stref->{'BuildSources'}{'C'}{$src}
                and not exists $stref->{'BuildSources'}{'F'}{$src} ) {
            $stref->{'BuildSources'}{'F'}{$src} = 1;
        }        

		my $nsrc=$src;$nsrc=~s/\.f$/.f95/;
		if ($DUMMY) {
			say '! '.('=' x 80);
            say "! FILE: $targetdir/$nsrc";
            say '! '.('=' x 80);
        	show_annlines($stref->{'RefactoredCode'}{$src},0);
        } else {
			open my $TGT, '>', "$targetdir/$nsrc" or die $!;
			
			my $mod_lines = $stref->{'RefactoredCode'}{$src};
#			my $mod_lines = create_refactored_source($stref,$stref->{'RefactoredCode'}{$src}); # BROKEN!
			for my $mod_line (@{ $mod_lines }) {
				
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
