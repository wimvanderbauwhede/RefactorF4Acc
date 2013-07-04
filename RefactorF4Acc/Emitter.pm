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

sub OLD_emit_all {
    ( my $stref ) = @_;
    _init_emit_all();
    
#    if ( not -e $targetdir ) {
#        mkdir $targetdir;
#        my @incs = glob('include*');
#        map { copy( $_, "$targetdir/$_" ) }
#          @incs;    # Perl::Critic wants a for-loop, drat it
#
#    } elsif ( not -d $targetdir ) {
#        die "ERROR: $targetdir exists but is not a directory!\n";
#    } else {
#        my @oldsrcs = glob("$targetdir/*.f95");
#        
#        map { unlink $_ } @oldsrcs;
#
#        # Check if includes have changed
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
#    }

    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        _emit_refactored_subroutine( $f, $targetdir, $stref, 0 );
    }
    for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {
        _emit_refactored_include( $f, $targetdir, $stref );
    }
    for my $f ( keys %{ $stref->{'Functions'} } ) {
        _emit_refactored_function( $f, $targetdir, $stref );
    }

    # NOOP source
    # Note that we always use the C source
    if ($noop) {
        _gen_noop($targetdir);        
    }

}    # END of OLD_emit_all()

# -----------------------------------------------------------------------------
sub _init_emit_all {
        # if target dir for refactored code does not exist, create it
        # and copy include files into it
    if ( not -e $targetdir ) {
        mkdir $targetdir;
        # FIXME: the includes should be taken from $stref->{'Includes'}
        # But actually, all includes should have been converted to F95 modules!        
#        my @incs = glob('include*');
#        map { copy( $_, "$targetdir/$_" ) }
#          @incs;    # Perl::Critic wants a for-loop, drat it

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

sub _emit_refactored_function {
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
# This must change: we first need to create a list src -> subs
sub _emit_refactored_subroutine {
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

# -----------------------------------------------------------------------------

sub _emit_refactored_function_new {
    ( my $f, my $stref ) = @_;
    my $Ff = $stref->{'Functions'}{$f};
#	local $V=1;
    print "EMITTING source for FUNCTION $f\n" if $V;
    my @lines=();

    my $srcref = $Ff->{'RefactoredCode'};
    my $s      = $Ff->{'Source'};
    if ( defined $srcref ) {
            push @lines, "\n! *** FUNCTION $f ***\n";
        
        my $prevline='C ';
        for my $annline ( @{$srcref} ) {
            my $line = $annline->[0]; 
            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
            push @lines, "$line\n";
            print "$line\n" if $V;
            }
            $prevline=$line;
        }
    }
    return @lines;
    #    else {
    #       warn "NO REFACTORED CODE FOR $f\n";
    #       warn Dumper($Ff->{'Lines'});
    #    }
} # END of emit_refactored_function_new()

# -----------------------------------------------------------------------------
# This must change: we first need to create a list src -> subs
sub _emit_refactored_subroutine_new {
    ( my $f, my $stref ) = @_;
    my $Sf     = $stref->{'Subroutines'}{$f};
    my $srcref = $Sf->{'RefactoredCode'};
#	local $V=1;
    my @lines=();
    if ( defined $srcref ) {
        print "INFO: emitting refactored code for $f\n" if $V;
            push @lines,"\n! *** SUBROUTINE $f ***\n";
        my $prevline='! ';
        for my $annline ( @{$srcref} ) {
            my $line = $annline->[0]; 
            if (not ($prevline =~/^\s*$/ and $line =~/^\s*$/)) {
            push @lines,"$line\n";
            print "$line\n" if $V;
            }
            $prevline=$line;
        }        
    } else {
	print "! SUBROUTINE $f: NO RefactoredCode (most likely sub not used)\n";
	}
    return @lines;
} # END of emit_refactored_subroutine_new()
# -----------------------------------------------------------------------------
sub emit_all {
    (my $stref)=@_;
    _init_emit_all();
    for my $src (keys %{ $stref->{'SourceContains'} } ) {
        
        print "INFO: emitting refactored code for $src\n" if $V;
        
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

#       my @module_contains=@{ $stref->{'RefactoredSources'}{$src} };
       
#	   for my $sub_or_func (keys %{  $stref->{'SourceContains'}{$src}   } ) {
#	
#	   	
## Find all function/subroutine calls in this function/subroutine
#			my $sub_func_type= $stref->{'SourceContains'}{$src}{$sub_or_func};
#			my $Sf = $stref->{$sub_func_type}{$sub_or_func};
##			warn "$sub_func_type: $sub_or_func\n";
#			my $called_sub_or_func = 'Called'. (($sub_func_type eq 'Subroutines') ? 'Subs' : 'Functions');
#			for my $called_sub ( keys %{ $Sf->{$called_sub_or_func} } ) {
#	#			print "\tCALLED SUB/FUNC: $called_sub\n";
#				my $cs_src=$stref->{$sub_func_type}{$called_sub}{'Source'};
#				$stref->{'UsedModules'}{$src}{$cs_src}=1;
#			}
#			if ($sub_func_type eq 'Subroutines') {
#	#			print "! REFACTORING SUBROUTINE $sub_or_func\n";
#			  @module_contains=(@module_contains, _emit_refactored_subroutine_new($sub_or_func,$stref)); 
#			} elsif ($sub_func_type eq 'Functions') {
#	#			print "! REFACTORING FUNCTION $sub_or_func\n";
#			  @module_contains=(@module_contains, _emit_refactored_function_new($sub_or_func,$stref ));
#			} else {
#				die $sub_or_func;
#				@module_contains=(@module_contains, "INCORRECT TYPE FOR $sub_or_func\n");
#			}
#		}		

#            print "\nSOURCE: $src\n\n";
            for my $mod_line (@{ $stref->{'RefactoredSources'}{$src} }) {
#               warn $mod_line if $src=~/timemanager/;
#if (not defined $mod_line->[1]{'Ref'}) {
#	$mod_line->[1]{'Ref'}=-1;
#} elsif ($mod_line->[1]{'Ref'}>1) {
#	print "REF: $mod_line->[1]{'Ref'}\t$mod_line->[0]\n";
#}
#                print "REF: ",$mod_line->[1]{'Ref'},"\t",$mod_line->[0],"\n"; 
            }

			my $nsrc=$src;$nsrc=~s/\.f$/.f95/;
			open my $TGT, '>', "$targetdir/$nsrc" or die $!;
#			my @module_lines=($mod_header, @mod_uses,"contains\n", @module_contains,$mod_footer);
			for my $mod_line (@{ $stref->{'RefactoredSources'}{$src} }) {
#				warn $mod_line if $src=~/timemanager/;
				print $TGT $mod_line->[0],"\n"; 
			}
			close $TGT;
#		}
	} # loop over all source files
#	die;

    for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {
        _emit_refactored_include( $f, $targetdir, $stref );
    }
    # NOOP source
    # Note that we always use the C source
    if ($noop) {
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
