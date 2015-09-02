package RefactorF4Acc::Parser::SrcReader;
use v5.16;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils qw( sub_func_incl_mod );
use RefactorF4Acc::Refactoring::Common
  qw( format_f95_var_decl format_f77_var_decl );
use F95Normaliser qw( normalise_F95_src );

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
$Data::Dumper::Indent = 1;

use Exporter;

@RefactorF4Acc::Parser::SrcReader::ISA = qw(Exporter);

@RefactorF4Acc::Parser::SrcReader::EXPORT_OK = qw(
  &read_fortran_src
);

sub read_fortran_src {
    ( my $s, my $stref ) = @_;

    #    local $V=1;
    #	*DBG = *STDOUT;
    open DBG, '>/dev/null';

    # Determine the type of file (Include or not)
    my $is_incl = exists $stref->{'IncludeFiles'}{$s} ? 1 : 0;

    my $sub_func_incl = sub_func_incl_mod( $s, $stref );
    if ( $sub_func_incl eq 'ExternalSubroutines' ) {
        $stref->{$sub_func_incl}{$s}{'Status'} = $UNREAD;
    }

    # Are there any Blocks?
    if ( not exists $stref->{$sub_func_incl}{$s}{'HasBlocks'} ) {
        $stref->{$sub_func_incl}{$s}{'HasBlocks'} = 0;
    }

    my $f = $is_incl ? $s : $stref->{$sub_func_incl}{$s}{'Source'};

    if ( defined $f ) {
        my $no_need_to_read = 1;
        if ( not exists $stref->{'SourceContains'}{$f} ) {
            $no_need_to_read = 0;
        } else {
            for my $item ( keys %{ $stref->{'SourceContains'}{$f} } ) {
                my $srctype = $stref->{'SourceContains'}{$f}{$item};
                my $status  = $stref->{$srctype}{$item}{'Status'};

                # if one of them is still UNREAD, need to read.
                $no_need_to_read *= ( $status != $UNREAD );
            }
        }
        my $need_to_read = 1 - $no_need_to_read;

        if ($need_to_read) {
            my $ok = 1;

            open my $SRC, '<', $f or do {
                print DBG "WARNING: Can't find '$f' ($s)\n";
                $ok = 0;
            };

            if ($ok) {

               #	print DBG "READING SOURCE for $f ($s, $sub_func_incl)\n" if $V;
                my $line       = '';
                my $nextline   = '';
                my $joinedline = '';
                my $next2      = 1;

                my @rawlines = <$SRC>;
                close $SRC;
                my @lines = @rawlines;
                
                push @lines, ("      \n");
                my $free_form = $stref->{$sub_func_incl}{$s}{'FreeForm'};
                my $srctype   = $sub_func_incl;

                if ($free_form) {    # I take this to mean F95, FIXME!

=info_free_form_parsing
The main difference is in the continuation lines:
For free form, they are

line_p1 &
(&) line_p2 &
(&) line_p3

so, as soon as we detect an & at the end of a line, we are in multi-line parsing mode
-If we find a non-blank, non-comment line without & at the end, that's the end of the multi-line 
-If we find a comment, we push it on the stack, and we emit all comments before the multi-line
-Blanks are simply skipped
-Comments at the end of a line are discarded                                                                         

So, in this case, is there any reason to look ahead?
Suppose we don't:
=cut

                    my $in_cont        = 0;
                    my @comments_stack = ();                    
                    my $norm_lines = normalise_F95_src( [@lines]); 

                    for my $line ( @{$norm_lines} ) {

                        # emit line
                        if ( $line ne '' ) {
                            ( $stref, $s, $srctype ) =
                              _pushAnnLine( $stref, $s, $srctype, $line,
                                $free_form );

                        }
                    }


      # --------------------- # END of free-form parsing # ---------------------

                } else {
                    my $s = ( $srctype eq 'IncludeFiles' ) ? $s : '';
                    my $line_set_to_nextline = 0;
                    my $in_cont              = 0;
                    my @comments_stack       = ();
                    my $firstline            = 1;
                    while (@lines) {
                        $line_set_to_nextline = 0;
                        if ($next2) {
                            $line = shift @lines;
                            if ($firstline) {
                                $firstline = 0;
                            }
                            $nextline = shift(@lines) // '';    # '/
                        } else {
                            $nextline = shift(@lines) // '';    # '/
                            $next2 = 1;
                        }
                        print DBG "LINE: $line";
                        print DBG "NEXTLINE: $nextline";
#######################################################################
                        if ($in_cont) {
                            if ( _isCont( $line, $free_form ) ) {
                                if ( _isCont( $nextline, $free_form ) ) {
                                    print DBG "C++\n";

                                    #+ l
                                    #+ n
                                    @comments_stack = ();    # redundant?
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form );
                                } elsif ( _isCommentOrBlank($nextline) ) {
                                    print DBG "C+!\n";

                                    #+ l
                                    #! n
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                } else {    # isPlain
                                    print DBG "C+ \n";

                             #+ l
                             #  n
                             #=> join l, emit joined, set l=n, set maybe_in_cont
                                    $joinedline .=
                                      _removeCont( $line, $free_form );

                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline           = '';
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                }
                            } elsif ( _isCommentOrBlank($line) ) {
                                if ( _isCont( $nextline, $free_form ) ) {
                                    print DBG "C!+\n";

                                    #! l
                                    #+ n
                                    #=> ignore the comment, join n
                                    push @comments_stack, $line;
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form );
                                } elsif ( _isCommentOrBlank($nextline) ) {
                                    print DBG "C!!\n";

                                    #! l
                                    #! n
                                    # => skip both comments
                                    push @comments_stack, $line;
                                    push @comments_stack, $nextline;
                                } else {    # isPlain
                                    print DBG "C! \n";

                                    #! l
                                    #  n
                                    #=> emit the joinedline
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                    }

                                    # emit the comment
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype, $line,
                                        $free_form );

                                    #l=n, maybe_in_cont
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                }
                            } else {    # isPlain
                                if ( _isCont( $nextline, $free_form ) ) {
                                    print DBG "C +\n";

                                    #  l
                                    #+ n
                                    #=> emit the joinedline
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                    }

                       #=> push l onto joined; push n onto joined; (set in_cont)
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form );
                                } elsif ( _isCommentOrBlank($nextline) ) {
                                    print DBG "C !\n";

  #  l
  #! n
  #=> emit the joined line; set maybe_in_cont; push l on joined; push n on stack
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                    }
                                    $in_cont = 0;
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    push @comments_stack, $nextline;
                                } else {    # isPlain
                                    print DBG "C  \n";

                                    #  l
                                    #  n
                                    #=> emit the joinedline; emit l
                                    #=> l=n , set maybe_in_cont
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                    }
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype, $line,
                                        $free_form );
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                        } else {    # not $in_cont
                            if ( _isCont( $line, $free_form ) ) {
                                if ( _isCont( $nextline, $free_form ) ) {
                                    print DBG "M++\n";

                                   #+ l
                                   #+ n
                                   #=> dump the comments, join both, set in_cont
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form );
                                    $in_cont = 1;
                                } elsif ( _isCommentOrBlank($nextline) ) {
                                    print DBG "M+!\n";

                            #+ l
                            #! n
                            #=> dump the comments, join l, set $in_cont, set l=n
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 1;
                                    $line_set_to_nextline = 1;
                                } else {    # isPlain
                                    print DBG "M+ \n";

         #+ l
         #  n
         #=> dump the comments, join l, emit joined, set l=n (set maybe_in_cont)
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline           = '';
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $line_set_to_nextline = 1;
                                }
                            } elsif ( _isCommentOrBlank($line) ) {
                                if ( _isCont( $nextline, $free_form ) ) {
                                    print DBG "M!+\n";

                                    #! l
                                    #+ n
                                    #=> dump the comments, join n, set in_cont
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form );
                                    $in_cont = 1;
                                } elsif ( _isCommentOrBlank($nextline) ) {
                                    print DBG "M!!\n";

                                    #! l
                                    #! n
                                    #=> push both comments
                                    push @comments_stack, $line;
                                    push @comments_stack, $nextline;
                                } else {    # isPlain
                                    print DBG "M! \n";

               #! l
               #  n
               #=> emit $joinedline, emit the comments, l=n, (set maybe_in_cont)
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                    }
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $commentline, $free_form );
                                    }
                                    _pushAnnLine( $stref, $s, $srctype, $line,
                                        $free_form );
                                    @comments_stack       = ();
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $line_set_to_nextline = 1;
                                }
                            } else {    # isPlain
                                if ( _isCont( $nextline, $free_form ) ) {
                                    print DBG "M +\n";

                                    #  l
                                    #+ n
                                    #=> emit $joinedline; emit the comments
                                    #=> set $in_cont, join l & n
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                    }
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $commentline, $free_form );
                                    }
                                    @comments_stack = ();
                                    $in_cont        = 1;
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form );
                                } elsif ( _isCommentOrBlank($nextline) ) {
                                    print DBG "M !\n";

#  l
#! n
#=> emit $joinedline; emit the comments, push l onto joinedline, push comment onto stack (set maybe_in_cont)
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                    }
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $commentline, $free_form );
                                    }
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form );
                                    $line = '';    # TEST
                                    push @comments_stack, $nextline;
                                } else {           # isPlain
                                    print DBG "M  \n";

                                    #  l
                                    #  n
                                    #=> emit the comments and l
                                    #=> l=n , (set maybe_in_cont)
                                    print DBG "--\n";
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $joinedline, $free_form );
                                        $joinedline = '';
                                        print DBG "---\n";
                                    }

              # FIXME: comments that come before a function/subroutine signature
              # are ignored because $s is unknown, set to ''
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $s, $srctype ) =
                                          _pushAnnLine( $stref, $s, $srctype,
                                            $commentline, $free_form );
                                    }
                                    @comments_stack = ();
                                    print DBG "----\n";
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype, $line,
                                        $free_form );
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                        }
                    }    # loop over source lines

                    if ($in_cont) {
                        if ( _isCont( $line, $free_form ) ) {
                            if ( _isCont( $nextline, $free_form ) ) {
                                print DBG "C++\n";

                                #+ l
                                #+ n
                                $joinedline .= _removeCont( $line, $free_form );
                                $joinedline .=
                                  _removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                            } elsif ( _isCommentOrBlank($nextline) ) {
                                print DBG "C+!\n";

                                #+ l
                                #! n
                                $joinedline .= _removeCont( $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                $joinedline = '';
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            } else {    # isPlain
                                print DBG "C+ \n";

                             #+ l
                             #  n
                             #=> join l, emit joined, set l=n, set maybe_in_cont
                                $joinedline .= _removeCont( $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            }
                        } elsif ( _isCommentOrBlank($line) ) {
                            if ( _isCont( $nextline, $free_form ) ) {
                                print DBG "C!+\n";

                                #! l
                                #+ n
                                #=> ignore the comment, join n
                                $joinedline .=
                                  _removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );

                            } elsif ( _isCommentOrBlank($nextline) ) {
                                print DBG "C!!\n";

                                #! l
                                #! n
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );

                            } else {    # isPlain
                                print DBG "C! \n";

                                #! l
                                #  n
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            }
                        } else {    # isPlain
                            if ( _isCont( $nextline, $free_form ) ) {
                                print DBG "C +\n";

                                #  l
                                #+ n
                                #=> emit the joinedline
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }

                       #=> push l onto joined; push n onto joined; (set in_cont)
                                $joinedline .= _removeCont( $line, $free_form );
                                $joinedline .=
                                  _removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );

                            } elsif ( _isCommentOrBlank($nextline) ) {
                                print DBG "C !\n";

  #  l
  #! n
  #=> emit the joined line; set maybe_in_cont; push l on joined; push n on stack
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );

                            } else {    # isPlain
                                print DBG "C  \n";

                                #  l
                                #  n
                                #=> emit the joinedline; emit l
                                #=> l=n , set maybe_in_cont
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            }
                        }
                    } else {    # not $in_cont
                        if ( _isCont( $line, $free_form ) ) {
                            if ( _isCont( $nextline, $free_form ) ) {
                                print DBG "M++\n";

                                #+ l
                                #+ n
                                #=> dump the comments, join both, set in_cont

                                $joinedline .= _removeCont( $line, $free_form );
                                $joinedline .=
                                  _removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );

                            } elsif ( _isCommentOrBlank($nextline) ) {
                                print DBG "M+!\n";

                            #+ l
                            #! n
                            #=> dump the comments, join l, set $in_cont, set l=n

                                $joinedline .= _removeCont( $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            } else {    # isPlain
                                print DBG "M+ \n";

         #+ l
         #  n
         #=> dump the comments, join l, emit joined, set l=n (set maybe_in_cont)

                                $joinedline .= _removeCont( $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            }
                        } elsif ( _isCommentOrBlank($line) ) {
                            if ( _isCont( $nextline, $free_form ) ) {
                                print DBG "M!+\n";

                                #! l
                                #+ n
                                #=> dump the comments, join n, set in_cont

                                $joinedline .=
                                  _removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );

                            } elsif ( _isCommentOrBlank($nextline) ) {
                                print DBG "M!!\n";

                                #! l
                                #! n
                                #=> push both comments
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }

                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );

                            } else {    # isPlain
                                print DBG "M! \n";

               #! l
               #  n
               #=> emit $joinedline, emit the comments, l=n, (set maybe_in_cont)
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            }
                        } else {    # isPlain
                            if ( _isCont( $nextline, $free_form ) ) {
                                print DBG "M +\n";

                                #  l
                                #+ n
                                #=> emit $joinedline; emit the comments
                                #=> set $in_cont, join l & n
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }
                                $joinedline .= _removeCont( $line, $free_form );
                                $joinedline .=
                                  _removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );

                            } elsif ( _isCommentOrBlank($nextline) ) {
                                print DBG "M !\n";

#  l
#! n
#=> emit $joinedline; emit the comments, push l onto joinedline, push comment onto stack (set maybe_in_cont)
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );

                          #                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            } else {    # isPlain
                                print DBG "M  \n";

                                #  l
                                #  n
                                #=> emit the comments and l
                                #=> l=n , (set maybe_in_cont)
                                print DBG "--\n";
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                    print DBG "---\n";
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      _pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  _pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            }
                        }
                    }
####### POSTAMBLE
                    if ( not exists $stref->{$srctype}{$s}{'Status'} ) {
                        print "UNDEF: $s\n";
                    }
                    if ( $stref->{$srctype}{$s}{'Status'} == $UNREAD ) {
                        $stref->{$srctype}{$s}{'Status'} = $READ;
                    }
                }    # free or fixed form
            }    #ok
        } else {
            print "NO NEED TO READ $s\n" if $I;
        }   # if $need_to_read
    }    # if $f is defined
    return $stref;
}    # END of read_fortran_src()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# To skip the funcs/subs that have been read/parsed already?
# I'm assuming that $srctype can only be Subroutines or Modules
sub _pushAnnLine {
    ( my $stref, my $f, my $srctype, my $line, my $free_form ) = @_;

    #		print "HERE: $line\n";
    my $pline = _procLine( $line, $free_form );
    
    if (exists $stref->{'Macros'} ) {
        $pline->[0] = restore_case_of_macros($stref,$pline->[0]);        
    }
    if ( exists $pline->[1]{'Module'} and $srctype eq 'Modules' ) {
        if ( $f ne '' ) {
            if ( $stref->{$srctype}{$f}{'Status'} < $READ )
            {    # FIXME: bit late, can I catch this earlier?
                $stref->{$srctype}{$f}{'Status'} = $READ;
            }
        }
    }
    if ( $srctype ne 'Modules' ) {
        if ( exists $pline->[1]{'SubroutineSig'} ) {
            if ( $f ne '' ) {
                if ( $stref->{$srctype}{$f}{'Status'} == $UNREAD )
                {    # FIXME: bit late, can I catch this earlier?
                    $stref->{$srctype}{$f}{'Status'} = $READ;
                }
            }

            $f =
              $pline->[1]{'SubroutineSig'}[1];   #[$spaces, $subname,[@subargs]]
            $stref->{$srctype}{$f}{'AnnLines'} = [];
            
        } elsif ( exists $pline->[1]{'FunctionSig'} ) {
            if ( $f ne '' ) {
                if (not exists $stref->{'Subroutines'}{$f}{'Function'}) {
                    $stref->{'Subroutines'}{$f}{'Function'}=1;
                }
                
                if (not exists $stref->{'Subroutines'}{$f}{'Status'} ) { 
                    die "No Status for $srctype $f".$pline->[0];
                } else {
                if ( $stref->{'Subroutines'}{$f}{'Status'} == $UNREAD ) {
                    $stref->{'Subroutines'}{$f}{'Status'} = $READ;
                }
                }
            }

            $f = $pline->[1]{'FunctionSig'}[1];    #[$spaces, $fname,[@fargs]]
            $stref->{'Subroutines'}{$f}{'AnnLines'} = [];
        }
    }
    push @{ $stref->{$srctype}{$f}{'AnnLines'} }, $pline;            
    return ( $stref, $f, $srctype );
}    # END of  _pushAnnLine()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

sub _hasCont {
    ( my $line ) = @_;
    if ( $line =~ /\&\s*$/ ) {
        return 1;
    } else {
        return 0;
    }
}

# -----------------------------------------------------------------------------
sub _isCont {
    ( my $line, my $free_form ) = @_;
    my $is_cont = 0;
    if ( $free_form == 0 ) {
        if ( $line =~ /^\ {5}[^0\s]/ )
        {    # continuation line. Continuation character can be anything!
            $is_cont = 1;
        } elsif ( $line =~ /^\&/ ) {
            $is_cont = 1;
        } elsif ( $line =~ /^\t[1-9]/ ) {
            $is_cont = 1;
        }
    } else {
        if ( $line =~ /^\s*\&/ ) {
            $is_cont = 1;
        }
    }
    return $is_cont;
}

# -----------------------------------------------------------------------------
sub _removeCont {
    ( my $line, my $free_form ) = @_;
    chomp $line;
    if ( _isCommentOrBlank($line) ) {
        return '';
    }
    if ( $free_form == 0 ) {
        if ( $line =~ /^\ {5}[^0\s]/ )
        {    # continuation line. Continuation character can be anything!
            $line =~ s/^\s{5}.\s*/ /;
        } elsif ( $line =~ /^\&/ ) {
            $line =~ s/^\&\t*/ /;
        } elsif ( $line =~ /^\t[1-9]/ ) {
            $line =~ s/^\t[0-9]/ /;
        }
    } else {
        if ( $line =~ /^\s*\&/ ) {
            $line =~ s/^\s*\&\s*/ /;
        }
        if ( $line =~ /\&\s*$/ ) {
            $line =~ s/\&\s*//;

            #				$line=~s/^\s+//;
        }

    }
    if ( $line =~ /.\!.*$/ ) {    # FIXME: trailing comments are discarded!
        my $tline = $line;
        my $nline = '';
        my $i     = 0;
        my %phs   = ();
        while ( $tline =~ /(\'.+?\')/ ) {
            $phs{"__PH${i}__"} = $1;
            $tline =~ s/(\'.+?\')/__PH${i}__/;
            $i++;
        }
        if ( $tline =~ /\!.*$/ ) {
            $nline = ( split( /\!/, $tline ) )[0];
            for my $phk ( keys %phs ) {
                $nline =~ s/$phk/$phs{$phk}/;
            }
            $line = $nline;
        } else {
            for my $phk ( keys %phs ) {
                $tline =~ s/$phk/$phs{$phk}/;
            }
            $line = $tline;
        }
    }
    return $line;
} # END of _removeCont() 

# -----------------------------------------------------------------------------

=pod
 What we do is:
 - reformat lines with labels
 - replace strings
 - detect and standardise comments
 - add metadata
=cut

sub _procLine {
    ( my $line, my $free_form ) = @_;

    chomp $line;
    my $info = { 'Ref' => 0 };    # means 0 refactorings

    # Detect and standardise comments
    if ( $line =~ /^[CD\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
        $line =~ s/^\s*[CcDd\*\!]/! /;
        $info->{'Comments'} = 1;
    } elsif ( $line =~ /.\!.*$/ ) {    # FIXME: trailing comments are discarded!
        my $tline = $line;
        my $nline = '';
        my $i     = 0;
        my %phs   = ();
        while ( $tline =~ /(\'.+?\')/ ) {
            $phs{"__PH${i}__"} = $1;
            $tline =~ s/(\'.+?\')/__PH${i}__/;
            $i++;
        }
        my $cline = $line;
        $cline =~ s/^.+?\!//;          # FIXME: not quite correct

        if ( $tline =~ /\!.*$/ ) {
            $nline = ( split( /\!/, $tline ) )[0];
            for my $phk ( keys %phs ) {
                $nline =~ s/$phk/$phs{$phk}/;
            }
            $line = $nline;
        } else {
            for my $phk ( keys %phs ) {
                $tline =~ s/$phk/$phs{$phk}/;
            }
            $line = $tline;
        }
        $info->{'TrailingComment'} = $cline;
    } else {
        my $sixspaces = ' ' x 6;
        $line =~ s/^\t/$sixspaces/;
        $line =~ /^(\d+)\t/ && do {
            my $label  = $1;
            my $ndig   = length($label);
            my $indent = ' ' x ( 6 - $ndig );
            my $str    = $label . $indent;
            $line =~ s/^(\d+)\t/$str/;
            $info->{'Label'} = $label;
        };
        $line =~ /^(\d+)\s+/ && do {
            my $label = $1;
            $info->{'Label'} = $label;
            my $ndig   = length($label);
            my $indent = ' ' x ( 6 - $ndig );
            my $str    = $label . $indent;
            $line =~ s/^(\d+)\s+/$str/;
        };
    }
    if ( substr( $line, 0, 2 ) ne '! ' ) {
        if ( $line =~ /^\s+include\s+\'([\w\.]+)\'/i ) {
            $info->{'Includes'} = $1;
            $line =~ s/\bINCLUDE\b/include/;
        } elsif ( $line !~ /\'/
            && $line !~ /^\s*end/i
            && $line =~ 
/\b(module|program|recursive\s+subroutine|subroutine|function)\s+(\w+)/i
          )
        {
            
            my $keyword = lc($1);
            my $name    = lc($2);

            die "_procLine(): No $keyword name " if $name eq '';
            my $spaces = ' ' x 6;
# This is  only used inside _procLine!             
            if ( $keyword eq 'function') {
                $info->{'FunctionSig'} = [ $spaces, $name, [] ];
            } elsif ( $keyword eq 'module' ) {
                $info->{'Module'} = $name;
            } else {
                $info->{'SubroutineSig'} = [ $spaces, $name, [] ];
            }
            $line = lc($line);
        } elsif ( $line =~ /^\s*$/ ) {
            $line = '';
            $info->{'Blank'} = 1;
        } else {

            # replace string constants by placeholders
            my $phs_ref = {};
            my $ct      = 0;
            while ( $line =~ /(\'.*?\')/ ) {
                my $strconst = $1;
                my $ph       = '__PH' . $ct . '__';
                $phs_ref->{$ph} = $strconst;
                $line =~ s/\'.*?\'/$ph/;
                $ct++;
            }
            my $lcline =
              ( substr( $line, 0, 2 ) eq '! ' )
              ? $line
              : lc($line);                            
              
            $lcline =~ s/__ph(\d+)__/__PH$1__/g;
            $line = $lcline;
            $info->{'PlaceHolders'} = $phs_ref
              unless ( keys %{$phs_ref} == 0 );
        }
    }
    return [ $line, $info ];
}    # END of _procLine()

# -----------------------------------------------------------------------------
sub _isCommentOrBlank {
    ( my $line ) = @_;

    # Detect comments & blank lines
    if ( $line =~ /^[CD\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
        return 1;
    } elsif ( $line =~ /^\s*$/ ) {
        return 1;
    }
    return 0;
}

# -----------------------------------------------------------------------------
sub restore_case_of_macros { (my $stref,my $line) = @_;
    for my $macro (keys %{ $stref->{'Macros'} }) {
        my $lc_macro=lc($macro);
        $line=~s/\b$lc_macro\b/$macro/g;
    }    
    return $line;
}

# -----------------------------------------------------------------------------
1;
