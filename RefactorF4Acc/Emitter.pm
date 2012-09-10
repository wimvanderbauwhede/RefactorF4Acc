package RefactorF4Acc::Emitter;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
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
sub emit_all {
    ( my $stref ) = @_;

    if ( not -e $targetdir ) {
        mkdir $targetdir;
        my @incs = glob('include*');
        map { copy( $_, "$targetdir/$_" ) }
          @incs;    # Perl::Critic wants a for-loop, drat it

    } elsif ( not -d $targetdir ) {
        die "ERROR: $targetdir exists but is not a directory!\n";
    } else {
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
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        emit_refactored_subroutine( $f, $targetdir, $stref, 0 );
    }
    for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {
        emit_refactored_include( $f, $targetdir, $stref );
    }
    for my $f ( keys %{ $stref->{'Functions'} } ) {
        emit_refactored_function( $f, $targetdir, $stref );
    }

    # NOOP source
    # Note that we always use the C source
    if ($noop) {
        gen_noop();
        copy( '/tmp/noop.c', "$targetdir/noop.c" );
    }

}    # END of emit_all()

# -----------------------------------------------------------------------------
sub emit_refactored_include {
    ( my $f, my $dir, my $stref ) = @_;
    my $srcref = $stref->{'IncludeFiles'}{$f}{'RefactoredCode'};
    my $incsrc=$stref->{'IncludeFiles'}{$f}{'Source'};
    if ( defined $srcref ) {
        print "INFO: emitting refactored code for include $f\n" if $V;
        my $mode = '>';
        open my $SRC, $mode, "$dir/$incsrc" or die $!;
        my $prevline='C ';
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
} # END of emit_refactored_include

# -----------------------------------------------------------------------------

sub emit_refactored_function {
    ( my $f, my $dir, my $stref ) = @_;
    my $Ff = $stref->{'Functions'}{$f};
    print "EMITTING source for FUNCTION $f\n" if $V;

    #    die Dumper($Ff->) if $f =~/ran3/;
    my $overwrite = 0;

    my $srcref = $Ff->{'RefactoredCode'};
    my $s      = $Ff->{'Source'};
    if ( defined $srcref ) {
        print "INFO: emitting refactored code for function $f\n" if $V;
        $s=~s/\.f$/.f95/;

        #    } else {
        #       $srcref=$Ff->{'Lines'};
        #    }
        my $mode = '>';
        if ( -e "$dir/$s" and not $overwrite ) {
            $mode = '>>';
        } else {
            if (    not exists $stref->{'BuildSources'}{'C'}{$s}
                and not exists $stref->{'BuildSources'}{'F'}{$s} )
            {
                $stref->{'BuildSources'}{'F'}{$s} = 1;
            }
        }
        open my $SRC, $mode, "$dir/$s" or die $!;
        if ( $mode eq '>>' ) {
            print $SRC "\n! *** FUNCTION $f ***\n";
        }
        my $prevline='C ';
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

    #    else {
    #       warn "NO REFACTORED CODE FOR $f\n";
    #       warn Dumper($Ff->{'Lines'});
    #    }
} # END of emit_refactored_function()

# -----------------------------------------------------------------------------
sub emit_refactored_subroutine {
    ( my $f, my $dir, my $stref, my $overwrite ) = @_;
    my $Sf     = $stref->{'Subroutines'}{$f};
    my $srcref = $Sf->{'RefactoredCode'};
    if ( defined $srcref ) {
        my $s = $Sf->{'Source'};
        $s=~s/\.f$/.f95/;
        print "INFO: emitting refactored code for $f in $s\n" if $V;
        if ( $s =~ /\w\/\w/ ) {

            # Source resides in subdirectory, create it if required
            my @dirs = split( /\//, $s );
            pop @dirs;
            map {
                my $targetdir = $_;
                if ( not -e $targetdir ) {
                    mkdir $targetdir;
                }
            } @dirs;
        }
        
        my $mode = '>';
        if ( -e "$dir/$s" and not $overwrite ) {
            $mode = '>>';
        } else {
            if (    not exists $stref->{'BuildSources'}{'C'}{$s}
                and not exists $stref->{'BuildSources'}{'F'}{$s} )
            {
                $stref->{'BuildSources'}{'F'}{$s} = 1;
            }
        }
        open my $SRC, $mode, "$dir/$s" or die $!;
        if ( $mode eq '>>' ) {
            print $SRC "\n! *** SUBROUTINE $f ***\n";
        }
        my $prevline='! ';
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
} # END of emit_refactored_subroutine()

sub gen_noop {


    open $NOOP,'>','/tmp/noop.c';
    print $NOOP '// Instead of continue, use a subroutine to do nothing. 
//Purely for translation, to get around a bug in F2C_ACC: in the C code we drop them!
void noop_ () {
    return;
}
';
    close $NOOP;

}

sub gen_break {
    open $BREAK,'>','/tmp/break.c';
    print $BREAK,'
void break(int l) {
        break;
}
';
close $BREAK;
}
