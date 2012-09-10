package RefactorF4Acc::Utils;

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

use Exporter;

@RefactorF4Acc::Utils::ISA = qw(Exporter);

@RefactorF4Acc::Utils::EXPORT = qw(
    &sub_func_or_incl
    &show_annlines
    &get_maybe_args_globs
    &union
    &ordered_union
    &generate_docs
);

sub sub_func_or_incl {
    ( my $f, my $stref ) = @_;
    die join(' ; ', caller ) if $stref!~/0x/;        
    if ( exists $stref->{'Subroutines'}{$f} ) {
        return 'Subroutines';
    } elsif ( exists $stref->{'Functions'}{$f} ) {
        return 'Functions';
    } elsif ( exists $stref->{'IncludeFiles'}{$f} ) {
        return 'IncludeFiles';
    } else {
#        #print Dumper($stref);
#        #croak "No entry for $f in the state\n";
        # Assuming it's a C function
#WV23JUL        
        return 'ExternalSubroutines';
    }
}

# -----------------------------------------------------------------------------
sub show_annlines {
    (my $annlines)=@_;
    for my $annline (@{ $annlines }) {
        print $annline->[0],"\t<",join(';',keys %{ $annline->[1] }),">\n";
    }
}
 # -----------------------------------------------------------------------------
 # Quick and dirty way to get the Kinds of all arguments

sub get_maybe_args_globs {
    ( my $stref, my $f ) = @_;
    my $Sf         = $stref->{'Subroutines'}{$f};
    my @globs      = ();
    my %maybe_args = ();
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        if ( defined $Sf->{'Globals'}{$inc} ) {
            @globs = ( @globs, @{ $Sf->{'Globals'}{$inc} } );
        }
        if ( defined $stref->{'IncludeFiles'}{$inc}{'Vars'} ) {
            %maybe_args =
              ( %maybe_args, %{ $stref->{'IncludeFiles'}{$inc}{'Vars'} } );
        }
    }
    %maybe_args = ( %{ $Sf->{'Vars'} }, %maybe_args );
    my %globals = map { $_ => 1 } @globs;
    return ( \%maybe_args, \%globals );
}

# -----------------------------------------------------------------------------
sub union {
    ( my $aref, my $bref ) = @_;
    croak("union()") unless (defined $aref and defined $bref);    
    if (not defined $aref) {
        return $bref;
    } elsif (not defined $bref) {
        return $aref;
    } else {    

    my %as = map { $_ => 1 } @{$aref};
    for my $elt ( @{$bref} ) {
        $as{$elt} = 1;
    }
    my @us = sort keys %as;
    return \@us;
    }
}    # END of union()

# -----------------------------------------------------------------------------
# This union is obtained by removing duplicates from @b. It is a bit slower but preserves the order
sub ordered_union {
    ( my $aref, my $bref ) = @_;
    croak("ordered_union()") unless (defined $aref and defined $bref);   
    if (not defined $aref) {
    	return $bref;
    } elsif (not defined $bref) {
        return $aref;
    } else {    
	    my @us = @{$aref};
	    my %as = map { $_ => 1 } @{$aref};
	    for my $elt ( @{$bref} ) {
	        if ( not exists $as{$elt} ) {
	            push @us, $elt;
	        }
	    }
	    return \@us;
    }
}    # END of ordered_union()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# FIXME: this routine is now broken as it relied on all docs being in the main script
sub generate_docs {
    my $scriptsrc = $0;
    my $src       = $scriptsrc;
    $src =~ s/\.pl//;
    $src =~ s/^.*\///;
    my $markdownsrc = $src . '.markdown';
    open my $PL, '<', $scriptsrc;
    open my $MD, '>', $markdownsrc;
    my $md = 0;

    while (<$PL>) {
        /^=begin\s+markdown/ && do {
            $md = 1;
            next;
        };
        /^=end\s+markdown/ && do {
            $md = 0;
            next;
        };

        if ( $md == 1 ) {
            my $el = $_;
            $el =~ s/#TODO.*$//;
            while ( $el =~ /\|(\$\w+)\|/ ) {
                my $var  = $1;    # so this is a '$' and then some \w's
                my $evar = '';
                eval("\$evar= $var");

                #               warn $var, '=', $evar;
                my $svar = "\\|\\$var\\|";
                $el =~ s/$svar/$evar/;
            }
            print $MD $el;
        }
    }
    close $PL;
    close $MD;
    my $tex_src_in = $src . '_in.tex';
    system("pandoc -f markdown -t latex $markdownsrc > $tex_src_in ");

    my $tex_src_out = $src . '.tex';

    open my $TEXIN,  '<', $tex_src_in;
    open my $TEXOUT, '>', $tex_src_out;
    print $TEXOUT <<'ENDH';
\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage{textcomp}

%%  Latex generated from POD in document /Users/wim/SoC_Research/FLEXPART/flx_wrf2/OpenCL-port/tools/refactor_block_subroutine.pod
%%  Using the perl module Pod::LaTeX
%%  Converted on Sun Nov 13 23:38:44 2011


\usepackage{makeidx}
\makeindex


\begin{document}

\tableofcontents

ENDH

    my $code = 0;
    while (<$TEXIN>) {
        /verbatim/ && do {
            $code = 1 - $code;
        };
        print $TEXOUT $_;
        if ($code) {

            #           print $TEXOUT "\n";
        }
    }
    close $TEXIN;
    print $TEXOUT '\printindex' . "\n";
    print $TEXOUT '\end{document}' . "\n";
    close $TEXOUT;

    #   system("pdflatex $tex_src_out");
    #   my @exts = qw(
    #     _in.tex
    #     .toc
    #     .log
    #     .idx
    #     .aux
    #   );
    #   map { unlink $src . $_ } @exts;

}

