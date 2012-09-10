package RefactorF4Acc::Analysis::Common;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Analysis::Globals qw( lift_includes );
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

@RefactorF4Acc::Analysis::Common::ISA = qw(Exporter);

@RefactorF4Acc::Analysis::Common::EXPORT = qw(
    &analyse_sources
);

# -----------------------------------------------------------------------------
# Maybe I need an additional Status here
sub analyse_sources {
    ( my $stref ) = @_;

    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        my $Sf = $stref->{'Subroutines'}{$f};
        if (
            ( exists $Sf->{'Called'} && $Sf->{'Called'} == 1 )
            or ( exists $Sf->{'Program'}
                && $Sf->{'Program'} == 1 )
          )
        {
            $stref = identify_loops_breaks( $f, $stref );
        } else {
            print "INFO: Subroutine $f is never called, skipping analysis\n"
              if $I;
        }
        if (defined $Sf->{'RefactorGlobals'} && $Sf->{'RefactorGlobals'}==2) {
        	$stref=lift_includes($stref,$f);
        }
    }
    for my $f ( keys %{ $stref->{'Functions'} } ) {
        my $Ff = $stref->{'Functions'}{$f};
        if ( exists $Ff->{'Called'} && $Ff->{'Called'} == 1 ) {     
            $stref = identify_loops_breaks( $f, $stref );
        } else {
            print "INFO: Function $f is never called, skipping analysis\n" if $I;             
        }
    }
    return $stref;
}    # END of analyse_sources
# -----------------------------------------------------------------------------
# FIXME: "error: break statement not within loop or switch"
sub identify_loops_breaks {
    ( my $f, my $stref ) = @_;
    my $sub_or_func = sub_func_or_incl( $f, $stref );
    my $Sf          = $stref->{$sub_or_func}{$f};
    my $srcref      = $Sf->{'AnnLines'};
    if ( defined $srcref ) {
        my %do_loops = ();
        my %gotos    = ();

        #   my %labels=();
        my $nest = 0;
        for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
            my $line = $srcref->[$index][0];
            my $info = $srcref->[$index][1];
            next if $line =~ /^\!\s+/;

            # BeginDo:
            $line =~ /^\d*\s+do\s+(\d+)\s+\w/ && do {
                my $label = $1;
                $info->{'BeginDo'}{'Label'} = $label;
                if ( not exists $do_loops{$label} ) {
                    @{ $do_loops{$label} } = ( [$index], $nest );
                    $nest++;
                } else {
                    push @{ $do_loops{$label}[0] }, $index;

#               print STDERR "WARNING: $f: Found duplicate label $label at: ".join(',',@{ $do_loops{$label}[0] })."\n";
                }
                next;
            };

            # Goto
            $line =~ /^\d*\s+.*?[\)\ ]\s*go\s?to\s+(\d+)\s*$/ && do {
                my $label = $1;
                $info->{'Goto'}{'Label'} =
                  $label;
                $Sf->{'Gotos'}{$label} = 1;
                push @{ $gotos{$label} }, [ $index, $nest ];
                next;
            };

            # continue can be end of do loop or break target (amongs others?)
            $line =~ /^\s*(\d+)\s+(continue|\w)/ && do { 
                my $label = $1;
                my $is_cont = $2 eq 'continue' ? 1 : 0;
                if ($is_cont) {
                	$info->{'Continue'}{'Label'} = $label;
                }                
                if ( exists $do_loops{$label} ) {
                    if ( $nest == $do_loops{$label}[1] + 1 ) {
                       $info->{'EndDo'}{'Label'} = $label;
                        $info->{'EndDo'}{'Count'} =
                          scalar @{ $do_loops{$label}[0] };
                        delete $do_loops{$label};
                        $nest--;
                    } else {
                        print
"WARNING: $f: Found continue for label $label but nesting level is wrong: $nest<>$do_loops{$label}[1]\n"
                          if $W;
                    }
                } elsif ( exists $gotos{$label} ) {
                    my $target = 'GotoTarget';
                    for my $pair ( @{ $gotos{$label} } ) {
                        ( my $tindex, my $tnest ) = @{$pair};
                        $target = 'GotoTarget';
                        if ( $nest <= $tnest )
                        {  # What if there are several gotos point to one label?
                            if ( $tnest > 0 ) {
                                if ($is_cont) {
                                    $target = 'NoopBreakTarget';
                                    $srcref->[$tindex][1]{'Break'}{'Label'} = $label;
                                } else {
                                    $target = 'BreakTarget';
                                    $srcref->[$tindex][1]{'Break'}{'Label'} = $label;

#                       print STDERR "WARNING: $f: Found BREAK target not NOOP for label $label\n";
                                }
                            } else {
                                if ($is_cont) {
                                    $target = 'NoopTarget';
                                }

#                           print "WARNING: goto $label ($tindex) is not in loop ($f)\n" if $translate==$GO;
                            }
                        } else {
                            print
"WARNING: $f: Found GOTO target not BREAK for label $label: wrong nesting $nest<>$gotos{$label}[1]\n"
                              if $W;
                        }
                    }
                    $info->{$target}{'Label'} = $label;
                    $Sf->{'Gotos'}{$label} = $target;
                    delete $gotos{$label};

                }
                next;
            };

   # When an open() fails, you can pass a label to some place for error handling
   # Some evil code combines this end-of-do-block labels
            $line =~ /^\s+open.*?\,\s*err\s*=\s*(\d+)\s*\)/ && do {
                my $label = $1;
                $Sf->{'Gotos'}{$label} = 1;
                next;
            };
            $srcref->[$index]=[$line,$info];
        }
    } else {
        print "NO SOURCE for $f\n";
    }
    return $stref;
}    # END of identify_loops_breaks()
