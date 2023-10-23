package RefactorF4Acc::Parser::SrcReader;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils
  qw( sub_func_incl_mod show_status show_annlines %F95_reserved_words %F95_types pp_annlines);
use RefactorF4Acc::Preconditioning qw( split_multiblock_common_lines );
use RefactorF4Acc::Refactoring::Common;
use Fortran::F95Normaliser qw( normalise_F95_src );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
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
    ( my $code_unit_name, my $stref, my $is_source_file_path ) = @_;

    	#  local $V=1;

    # Determine the type of file (Include or not)
    my $is_incl = exists $stref->{'IncludeFiles'}{$code_unit_name} ? 1 : 0;

    my $sub_func_incl = sub_func_incl_mod( $code_unit_name, $stref );
    if ( $sub_func_incl eq 'ExternalSubroutines' ) {
        $stref->{$sub_func_incl}{$code_unit_name}{'Status'} = $UNREAD;
    }

    # Are there any Blocks?
    if ( not exists $stref->{$sub_func_incl}{$code_unit_name}{'HasBlocks'} ) {
        $stref->{$sub_func_incl}{$code_unit_name}{'HasBlocks'} = 0;
    }

   # If RefactoredCode exists, it means we are re-parsing a refactored code unit
   # So just return RefactoredCode as AnnLines

    my $Sf = $stref->{$sub_func_incl}{$code_unit_name};

    if ( exists $Sf->{'RefactoredCode'} ) {
        $Sf->{'AnnLines'} = $Sf->{'RefactoredCode'};
        return $stref;
    }
    elsif ( exists $Sf->{'AnnLines'} ) {

        # It is not clear how this could ever work without this
        return $stref;
    }

    # We want $f to be the source file name
    my $f =
      ( $is_source_file_path or $is_incl )
      ? $code_unit_name
      : $stref->{$sub_func_incl}{$code_unit_name}{'Source'};

    # And $code_unit_name is the name of the program, subroutine or module
    if ( $sub_func_incl eq 'Modules' and $is_source_file_path ) {
        $code_unit_name = $stref->{'SourceFiles'}{$f}{'ModuleName'};
    }

    if ( defined $f ) {

        my $no_need_to_read         = 1;
        my $sub_contained_in_module = 0;
        my $containing_module       = '';
        my $fpath = $f;

        if ( not exists $stref->{'SourceContains'}{$fpath}) {
          if (exists  $stref->{'IncludeFiles'}{$f}{'SrcPath'}) {
            $fpath = $stref->{'IncludeFiles'}{$f}{'SrcPath'};
          }
        }
        if ( not exists $stref->{'SourceContains'}{$fpath}
            or ( scalar @{ $stref->{'SourceContains'}{$fpath}{'List'} } == 0 ) )
        {
            $no_need_to_read = 0; 
        }
        else {

            for my $item ( @{ $stref->{'SourceContains'}{$fpath}{'List'} } ) {
                my $srctype = $stref->{'SourceContains'}{$fpath}{'Set'}{$item};
                my $status  = $stref->{$srctype}{$item}{'Status'};

                # if one of them is still UNREAD, need to read.

                $no_need_to_read *=
                  ( ( ( $status != $UNREAD ) && ( $status != $INVENTORIED ) )
                    ? 1
                    : 0 );
                say "\t", $no_need_to_read, ' ', $item, ' ',
                  show_status($status)
                  if $V;

# If $code_unit_name is a subroutine, it could be that the source file is a Module, and then we should set that as the entry source type
                if ( $stref->{'SourceContains'}{$fpath}{'Set'}{$item} eq 'Modules' )
                {
                    if ( exists $stref->{'Modules'}{$item}{'Contains'} ) {
                        my @subs_in_mod =
                          @{ $stref->{'Modules'}{$item}{'Contains'} };
                        if ( grep { $_ eq $code_unit_name } @subs_in_mod ) {
                            say
"Subroutine $code_unit_name is contained in module $item in $f"
                              if $I;
                            $sub_contained_in_module = 1;
                            $containing_module       = $item;
                        }
                    }
                }
            }
        }
        my $need_to_read = 1 - $no_need_to_read;

        if ($need_to_read) {
            my $ok    = 1;
            my $fpath = $f;
            if ( $is_incl
                and
                exists $stref->{'IncludeFiles'}{$code_unit_name}{'ExtPath'} )
            {
                $fpath = $stref->{'IncludeFiles'}{$code_unit_name}{'ExtPath'};
            }
            if ( $is_incl
                and
                exists $stref->{'IncludeFiles'}{$code_unit_name}{'SrcPath'} )
            {
                $fpath = $stref->{'IncludeFiles'}{$code_unit_name}{'SrcPath'};
            }
            if ( not -e $fpath ) {
                for my $srcdir ( @{ $stref->{'SourceDirs'} } ) {
                    if ( -e "$srcdir/$fpath" ) {
                        $fpath = "$srcdir/$fpath";
                        $stref->{$sub_func_incl}{$code_unit_name}{'Source'} =
                          $fpath;
                        last;
                    }

                    # # Nested dirs
                    # croak Dumper($stref->{'IncludeFiles'});

                }
            }
            open my $SRC, '<', $fpath or do {
                say "WARNING: Can't find '$fpath' ($code_unit_name)\n" if $W;
                $stref->{$sub_func_incl}{$code_unit_name}{'Status'} =
                  $FILE_NOT_FOUND;
                $ok = 0;
            };

            if ($ok) {    # i.e. found the path
                say
"read_fortran_src($code_unit_name): READING SOURCE for $f ($code_unit_name , $sub_func_incl)"
                  if $V;

                my @rawlines = <$SRC>;
                close $SRC;

                my @lines = @rawlines;

                push @lines, "      \n";

#                croak "$sub_func_incl $code_unit_name".Dumper($stref->{$sub_func_incl}{$code_unit_name});
                my $free_form =
                  $stref->{$sub_func_incl}{$code_unit_name}{'FreeForm'};

#  die "$sub_func_incl $code_unit_name FreeForm=$free_form".Dumper($stref->{$sub_func_incl}{$code_unit_name}).'BOOM!!!' if $code_unit_name =~/mpif.h/;#!$free_form;
                my $srctype = $sub_func_incl;
                if ($sub_contained_in_module) {
                    $srctype        = 'Modules';
                    $code_unit_name = $containing_module;
                }

                my $line       = '';
                my $nextline   = '';
                my $joinedline = '';
                my $next2      = 1;

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
                    my $norm_lines     = normalise_F95_src( [@lines] );

                    #					map { say $_} @{$norm_lines };
                    #					croak ;

                    for my $line ( @{$norm_lines} ) {

                        # emit line
                        if ( $line ne '' ) {
                            ( $stref, $code_unit_name, $srctype ) =
                              _pushAnnLine( $stref, $code_unit_name, $srctype,
                                $f, $line, $free_form, __LINE__ );
                        }
                    }

# So problem here is that in _pushAnnLine() we don't move the sub source to Subroutines

      # --------------------- # END of free-form parsing # ---------------------

                }
                else {

    # --------------------- # BEGIN of F77-style parsing # ---------------------

                    my $code_unit_name =
                      ( $srctype eq 'IncludeFiles' )
                      ? $code_unit_name
                      : 'UNKNOWN_SRC';
                    my $line_set_to_nextline = 0;
                    my $in_cont              = 0;
                    my @comments_stack       = ();
                    my $firstline            = 1;


                  if ( not exists  $stref->{'SourceFiles'}{$f}{'Status'} ) {
                      $stref->{'SourceFiles'}{$f}{'Status'} = 1;

                  } else {
                    $stref->{'SourceFiles'}{$f}{'Status'} = 0;
                  }

# There is an extension to allow 132 characters. But that is a compiler flag so I can't tell
# I can guess based on the max line length.
# Let's say if it is > 72 characters then we have a 132-line program
# But let's say if it is less than 102 we warn
                    my $max_line_length = 0;
                    for my $line (@lines) {
                        my $cline = $line;
                        chomp $cline;
                        my $line_length = length($cline);
                        $max_line_length =
                            $line_length > $max_line_length
                          ? $line_length
                          : $max_line_length;
                    }
                    if ( $max_line_length > 72 && $max_line_length < 102 ) {

#                    	die "WARNING: The file $f is a fixed-form F77 source file but the max line length is $max_line_length characters, using $MAX_LINE_LENGTH-character lines. To use a different max line length, set MAX_LINE_LENGTH in the config file.";
                        say
"WARNING: The file $f is a fixed-form F77 source file but the max line length is $max_line_length characters, using $Config{'MAX_LINE_LENGTH'}-character lines.\nTo use a different max line length, set MAX_LINE_LENGTH in the config file."
                          if $W;
                    }
                    my $ncols = $Config{'MAX_LINE_LENGTH'};   #$max_line_length > 72 ? 132 : 72;

                    for my $line (@lines) {
                        $line = substr( $line, 0, $ncols );

# Here a minor hack: if there is a label in the 6th col and a non-blank in the 7th, I insert a blank
                        if ( length($line) > 6 ) {
                            my $c6 = substr( $line, 5, 1 );
                            my $c7 = substr( $line, 6, 1 );
                            if ( $c6 eq '0' ) {
                                $line = substr( $line, 0, 5 ) . ' '
                                  . substr( $line, 6 );
                            }

#                    	elsif ($c6 ne ' ' and $c6 ne "\t" and $c7 ne ' ' and $c7 ne "\t") {
#                    		$line = substr($line,0,6).' '.substr($line,6);
#                    	}
                        }
                        $line =~ s/\x{d}//;
                    }
                    
                    while (@lines) {

# OK, this is a HACK but I will remove anything after the 72nd character
#                    	say "$code_unit_name LINE: $line";# if $code_unit_name eq './timdata.f';
                        $line_set_to_nextline = 0;
                        if ($next2) {
                            $line = shift @lines;
                            if ($firstline) {
                                $firstline = 0;
                            }
                            $nextline = shift(@lines) // '';    # '/
                        }
                        else {
                            $nextline = shift(@lines) // '';    # '/
                            $next2    = 1;
                        }
                        my $remove_spaces_ok = $joinedline =~ /\w\s*$/ ? 1 : 0;

                        #  say "LINE: $line" ;
                        #  say "NEXTLINE: $nextline";
                        #  die if $line=~/GO TO 0121/;
#######################################################################

                        if ($in_cont) {
                          # say "HERE1";
                            if ( _isCont( $line, $free_form ) ) {
                          # say "HERE2";
                                if ( _isCont( $nextline, $free_form ) ) {
                          # say "HERE3";

                         #                                    print DBG "C++\n";

                                    #+ l
                                    #+ n
# say "JOINEDLINE4 $joinedline";

                                    @comments_stack = ();    # redundant?
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
# say "JOINEDLINE5 $joinedline";
                                    my $remove_spaces_ok2 =
                                      $joinedline =~ /\w\s*$/ ? 1 : 0;

                                    $joinedline .=
                                      _removeCont( $nextline, $free_form,
                                        $remove_spaces_ok2 );
# say "JOINEDLINE6 $joinedline";

                                }
                                elsif ( _isCommentOrBlank($nextline) ) {

                         #                                    print DBG "C+!\n";

                                    #+ l
                                    #! n
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                }
                                else {    # isPlain
                                # say "HERE6";

                         #                                    print DBG "C+ \n";

                             #+ l
                             #  n
                             #=> join l, emit joined, set l=n, set maybe_in_cont
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
# say "JOINEDLINE7 $joinedline";

                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline           = '';
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                            elsif ( _isCommentOrBlank($line) ) {
                                if ( _isCont( $nextline, $free_form ) ) {

                         #                                    print DBG "C!+\n";

                                    #! l
                                    #+ n
                                    #=> ignore the comment, join n
                                    push @comments_stack, $line;
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form,
                                        $remove_spaces_ok );
                                }
                                elsif ( _isCommentOrBlank($nextline) ) {

                         #                                    print DBG "C!!\n";

                                    #! l
                                    #! n
                                    # => skip both comments
                                    push @comments_stack, $line;
                                    push @comments_stack, $nextline;
                                }
                                else {    # isPlain

                         #                                    print DBG "C! \n";

                                    #! l
                                    #  n
                                    #=> emit the joinedline
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';
                                    }

                                    # emit the comment
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f, $line,
                                        $free_form, __LINE__ );

                                    #l=n, maybe_in_cont
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                            else {    # isPlain
                                if ( _isCont( $nextline, $free_form ) ) {

                         #                                    print DBG "C +\n";

                                    #  l
                                    #+ n
                                    #=> emit the joinedline
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';
                                    }

                       #=> push l onto joined; push n onto joined; (set in_cont)
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
                                    my $remove_spaces_ok2 =
                                      $joinedline =~ /\w\s*$/ ? 1 : 0;
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form,
                                        $remove_spaces_ok2 );
                                }
                                elsif ( _isCommentOrBlank($nextline) ) {

                         #                                    print DBG "C !\n";

  #  l
  #! n
  #=> emit the joined line; set maybe_in_cont; push l on joined; push n on stack
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';
                                    }
                                    $in_cont = 0;
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
                                    push @comments_stack, $nextline;
                                }
                                else {    # isPlain

                         #                                    print DBG "C  \n";

                                    #  l
                                    #  n
                                    #=> emit the joinedline; emit l
                                    #=> l=n , set maybe_in_cont
# say "JOINEDLINE8 $joinedline";

                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';
                                    }
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f, $line,
                                        $free_form, __LINE__ );
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                        }
                        else {    # not $in_cont
                            if ( _isCont( $line, $free_form ) ) {
                                if ( _isCont( $nextline, $free_form ) ) {
                         
                         #                                    print DBG "M++\n";

                                   #+ l
                                   #+ n
                                   #=> dump the comments, join both, set in_cont
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
                                    my $remove_spaces_ok2 =
                                      $joinedline =~ /\w\s*$/ ? 1 : 0;
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form,
                                        $remove_spaces_ok2 );
                                    $in_cont = 1;
                                }
                                elsif ( _isCommentOrBlank($nextline) ) {

                         #                                    print DBG "M+!\n";

                            #+ l
                            #! n
                            #=> dump the comments, join l, set $in_cont, set l=n
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $in_cont              = 1;
                                    $line_set_to_nextline = 1;
                                }
                                else {    # isPlain

                         #                                    print DBG "M+ \n";

         #+ l
         #  n
         #=> dump the comments, join l, emit joined, set l=n (set maybe_in_cont)
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline           = '';
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                            elsif ( _isCommentOrBlank($line) ) {
                                if ( _isCont( $nextline, $free_form ) ) {

                         #                                    print DBG "M!+\n";

                                    #! l
                                    #+ n
                                    #=> dump the comments, join n, set in_cont
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form,
                                        $remove_spaces_ok );
                                    $in_cont = 1;
                                }
                                elsif ( _isCommentOrBlank($nextline) ) {

                         #                                    print DBG "M!!\n";

                                    #! l
                                    #! n
                                    #=> push both comments
                                    push @comments_stack, $line;
                                    push @comments_stack, $nextline;
                                }
                                else {    # isPlain

                         #                                    print DBG "M! \n";

               #! l
               #  n
               #=> emit $joinedline, emit the comments, l=n, (set maybe_in_cont)
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';
                                    }
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,       $code_unit_name,
                                            $srctype,     $f,
                                            $commentline, $free_form,
                                            __LINE__
                                          );
                                    }
                                    _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f, $line,
                                        $free_form, __LINE__ );
                                    @comments_stack       = ();
                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                            else {    # isPlain
                                if ( _isCont( $nextline, $free_form ) ) {

                         #                                    print DBG "M +\n";
# say "JOINEDLINE1 $joinedline" ;

                                    #  l
                                    #+ n
                                    #=> emit $joinedline; emit the comments
                                    #=> set $in_cont, join l & n
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';
                                    }
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,       $code_unit_name,
                                            $srctype,     $f,
                                            $commentline, $free_form,
                                            __LINE__
                                          );
                                    }
                                    @comments_stack = ();
                                    $in_cont        = 1;
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
# say "JOINEDLINE2 $joinedline" ;

                                    my $remove_spaces_ok2 =
                                      $joinedline =~ /\w\s*$/ ? 1 : 0;
                                    $joinedline .=
                                      _removeCont( $nextline, $free_form,
                                        $remove_spaces_ok2 );
# say "JOINEDLINE3 $joinedline" ;
                                }
                                elsif ( _isCommentOrBlank($nextline) ) {

                         #                                    print DBG "M !\n";

#  l
#! n
#=> emit $joinedline; emit the comments, push l onto joinedline, push comment onto stack (set maybe_in_cont)
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';
                                    }
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,       $code_unit_name,
                                            $srctype,     $f,
                                            $commentline, $free_form,
                                            __LINE__
                                          );
                                    }
                                    @comments_stack = ();
                                    $joinedline .=
                                      _removeCont( $line, $free_form,
                                        $remove_spaces_ok );
                                    $line = '';    # TEST
                                    push @comments_stack, $nextline;
                                }
                                else {             # isPlain

                         #                                    print DBG "M  \n";

                          #  l
                          #  n
                          #=> emit the comments and l
                          #=> l=n , (set maybe_in_cont)
                          #                                    print DBG "--\n";
                                    if ( $joinedline ne '' ) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,      $code_unit_name,
                                            $srctype,    $f,
                                            $joinedline, $free_form,
                                            __LINE__
                                          );
                                        $joinedline = '';

                     #                                        print DBG "---\n";
                                    }

              # FIXME: comments that come before a function/subroutine signature
              # are ignored because $code_unit_name is unknown, set to ''
                                    for my $commentline (@comments_stack) {
                                        ( $stref, $code_unit_name, $srctype ) =
                                          _pushAnnLine(
                                            $stref,       $code_unit_name,
                                            $srctype,     $f,
                                            $commentline, $free_form,
                                            __LINE__
                                          );
                                    }
                                    @comments_stack = ();

                        #                                    print DBG "----\n";
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f, $line,
                                        $free_form, __LINE__ );

                                    $line                 = $nextline;
                                    $next2                = 0;
                                    $line_set_to_nextline = 1;
                                }
                            }
                        }
                    }    # loop over source lines

                    my $remove_spaces_ok = $joinedline =~ /\w\s*$/ ? 1 : 0;

                    #					say "$f L:<$line>";
                    #					say "$f N:<$nextline>";
                    #					say "$f J:<$joinedline>";

                    # This part is to handle the final line
                    if ($in_cont) {
                        if ( _isCont( $line, $free_form ) ) {
                            if ( _isCont( $nextline, $free_form ) ) {

                             #                                print DBG "C++\n";

                                #+ l
                                #+ n
                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                my $remove_spaces_ok2 =
                                  $joinedline =~ /\w\s*$/ ? 1 : 0;
                                $joinedline .=
                                  _removeCont( $nextline, $free_form,
                                    $remove_spaces_ok2 );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                            }
                            elsif ( _isCommentOrBlank($nextline) ) {

                             #                                print DBG "C+!\n";

                                #+ l
                                #! n
                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                                $joinedline = '';
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                            else {    # isPlain

                             #                                print DBG "C+ \n";

                             #+ l
                             #  n
                             #=> join l, emit joined, set l=n, set maybe_in_cont
                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                        }
                        elsif ( _isCommentOrBlank($line) ) {
                            if ( _isCont( $nextline, $free_form ) ) {

                             #                                print DBG "C!+\n";

                                #! l
                                #+ n
                                #=> ignore the comment, join n
                                $joinedline .=
                                  _removeCont( $nextline, $free_form,
                                    $remove_spaces_ok );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );

                            }
                            elsif ( _isCommentOrBlank($nextline) ) {

                             #                                print DBG "C!!\n";

                                #! l
                                #! n
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $line, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );

                            }
                            else {    # isPlain

                             #                                print DBG "C! \n";

                                #! l
                                #  n
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $line, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                        }
                        else {    # isPlain
                            if ( _isCont( $nextline, $free_form ) ) {

                             #                                print DBG "C +\n";

                                #  l
                                #+ n
                                #=> emit the joinedline
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline = '';
                                }

                       #=> push l onto joined; push n onto joined; (set in_cont)
                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                my $remove_spaces_ok2 =
                                  $joinedline =~ /\w\s*$/ ? 1 : 0;
                                $joinedline .=
                                  _removeCont( $nextline, $free_form,
                                    $remove_spaces_ok2 );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );

                            }
                            elsif ( _isCommentOrBlank($nextline) ) {

                             #                                print DBG "C !\n";

  #  l
  #! n
  #=> emit the joined line; set maybe_in_cont; push l on joined; push n on stack
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline = '';
                                }
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $line, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );

                            }
                            else {    # isPlain

                             #                                print DBG "C  \n";

                                #  l
                                #  n
                                #=> emit the joinedline; emit l
                                #=> l=n , set maybe_in_cont
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline = '';
                                }
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $line, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                        }
                    }
                    else {    # not $in_cont
                        if ( _isCont( $line, $free_form ) ) {
                            if ( _isCont( $nextline, $free_form ) ) {

                             #                                print DBG "M++\n";

                                #+ l
                                #+ n
                                #=> dump the comments, join both, set in_cont

                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                my $remove_spaces_ok2 =
                                  $joinedline =~ /\w\s*$/ ? 1 : 0;
                                $joinedline .=
                                  _removeCont( $nextline, $free_form,
                                    $remove_spaces_ok2 );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );

                            }
                            elsif ( _isCommentOrBlank($nextline) ) {

                             #                                print DBG "M+!\n";

                            #+ l
                            #! n
                            #=> dump the comments, join l, set $in_cont, set l=n

                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                            else {    # isPlain

                             #                                print DBG "M+ \n";

         #+ l
         #  n
         #=> dump the comments, join l, emit joined, set l=n (set maybe_in_cont)

                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                        }
                        elsif ( _isCommentOrBlank($line) ) {
                            if ( _isCont( $nextline, $free_form ) ) {

                             #                                print DBG "M!+\n";

                                #! l
                                #+ n
                                #=> dump the comments, join n, set in_cont

                                $joinedline .=
                                  _removeCont( $nextline, $free_form );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );

                            }
                            elsif ( _isCommentOrBlank($nextline) ) {

                             #                                print DBG "M!!\n";

                                #! l
                                #! n
                                #=> push both comments
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $commentline, $free_form, __LINE__ );
                                }

                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $line, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );

                            }
                            else {    # isPlain

                             #                                print DBG "M! \n";

               #! l
               #  n
               #=> emit $joinedline, emit the comments, l=n, (set maybe_in_cont)
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $commentline, $free_form, __LINE__ );
                                }
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $line, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                        }
                        else {    # isPlain
                            if ( _isCont( $nextline, $free_form ) ) {
                             #                                print DBG "M +\n";
                                #  l
                                #+ n
                                #=> emit $joinedline; emit the comments
                                #=> set $in_cont, join l & n
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $commentline, $free_form, __LINE__ );
                                }
                                $joinedline .= _removeCont( $line, $free_form,
                                    $remove_spaces_ok );
                                my $remove_spaces_ok2 =
                                  $joinedline =~ /\w\s*$/ ? 1 : 0;
                                $joinedline .=
                                  _removeCont( $nextline, $free_form,
                                    $remove_spaces_ok2 );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f,
                                    $joinedline, $free_form, __LINE__ );

                            }
                            elsif ( _isCommentOrBlank($nextline) ) {

                             #                                print DBG "M !\n";

#  l
#! n
# WV20190625 this comment makes no sense
#=> emit $joinedline; emit the comments, push l onto joinedline, push comment onto stack (set maybe_in_cont)
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $commentline, $free_form, __LINE__ );
                                }

# WV20190625 Seems to me this is not right, there should be no need for this
#                                ( $stref, $code_unit_name , $srctype ) =
#                                  _pushAnnLine( $stref, $code_unit_name , $srctype, $f, $line,
#                                    $free_form, __LINE__ );
#                                ( $stref, $code_unit_name , $srctype ) =
#                                  _pushAnnLine( $stref, $code_unit_name , $srctype, $f, $nextline,
#                                    $free_form, __LINE__ );
                            }
                            else {    # isPlain

                             #                                print DBG "M  \n";

                              #  l
                              #  n
                              #=> emit the comments and l
                              #=> l=n , (set maybe_in_cont)
                              #                                print DBG "--\n";
                                if ( $joinedline ne '' ) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $joinedline, $free_form, __LINE__ );
                                    $joinedline = '';

                         #                                    print DBG "---\n";
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $code_unit_name, $srctype ) =
                                      _pushAnnLine( $stref, $code_unit_name,
                                        $srctype, $f,
                                        $commentline, $free_form, __LINE__ );
                                }
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $line, $free_form, __LINE__ );
                                ( $stref, $code_unit_name, $srctype ) =
                                  _pushAnnLine( $stref, $code_unit_name,
                                    $srctype, $f, $nextline,
                                    $free_form, __LINE__ );
                            }
                        }
                    }
####### POSTAMBLE
                    if (
                      $DBG and 
                        not
                        exists $stref->{$srctype}{$code_unit_name}{'Status'} )
                    {
                        carp "UNDEF: $srctype $code_unit_name\n";
                    }
                    elsif ( $stref->{$srctype}{$code_unit_name}{'Status'} ==
                        $UNREAD )
                    {
                        $stref->{$srctype}{$code_unit_name}{'Status'} = $READ;
                    }

                    # say Dumper(pp_annlines($stref->{$srctype}{$code_unit_name}{'AnnLines'}));die;

                # else {
                #                         if ($code_unit_name=~/PMPI_Sizeof/i) {
                #   print "OK: $srctype $code_unit_name\n";croak;
                #   }
                # }
                }    # free or fixed form

                # Split lines with multiple common block declarations
                # TODO this should no longer be necessary with a better parser!
                $stref = split_multiblock_common_lines( $stref, $fpath );

            }    #ok
        }
        else {
            print "NO NEED TO READ $code_unit_name\n" if $I;
        }    # if $need_to_read
    }    # if $f is defined
    return $stref;
}    # END of read_fortran_src()

# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# To skip the funcs/subs that have been read/parsed already?
# I'm assuming that $srctype can only be Subroutines or Modules
sub _pushAnnLine {
    ( my $stref, my $f, my $srctype, my $src, my $line, my $free_form, my $ann )
      = @_;

    if (   $f eq 'UNKNOWN_SRC'
        or not exists $stref->{$srctype}{$f}{'Status'}
        or $stref->{$srctype}{$f}{'Status'} < $PARSED )
    {

        my $pline = _procLine( $line, $free_form );
        if ( exists $stref->{'Macros'} ) {
            $pline->[0] = _restore_case_of_macros( $stref, $pline->[0] );
        }

        if ( exists $pline->[1]{'Module'} and $srctype eq 'Modules' ) {

            if ( $f ne 'UNKNOWN_SRC' ) {
                if ( $stref->{$srctype}{$f}{'Status'} < $READ )
                {    # FIXME: bit late, can I catch this earlier?
                    $stref->{$srctype}{$f}{'Status'} = $READ;
                }
            }
        }

        if (   exists $pline->[1]{'SubroutineSig'}
            or exists $pline->[1]{'FunctionSig'} )
        {
            if ( not defined $stref->{$srctype}{$f}{'Status'} ) {
                $stref->{$srctype}{$f}{'Status'} = $UNREAD;
            }
            if ( $f ne 'UNKNOWN_SRC' ) {
                if ( $stref->{$srctype}{$f}{'Status'} == $UNREAD )
                {    # FIXME: bit late, can I catch this earlier?
                    $stref->{$srctype}{$f}{'Status'} = $READ;
                }
            }
            if ( exists $pline->[1]{'SubroutineSig'} ) {
                $f = $pline->[1]{'SubroutineSig'}[1];
            }
            else {
                $f = $pline->[1]{'FunctionSig'}[1];
                if ( not exists $stref->{'Subroutines'}{$f}{'Function'} ) {
                    $stref->{'Subroutines'}{$f}{'Function'} = 1;
                }
            }
            $srctype = 'Subroutines';
            $stref->{'Subroutines'}{$f}{'AnnLines'} = []
              unless ( exists $stref->{'Subroutines'}{$f}{'Status'}
                and $stref->{'Subroutines'}{$f}{'Status'} == $PARSED );
        }

        if ( exists $pline->[1]{'EndModule'} and $srctype eq 'Subroutines' ) {
            if ( $f ne 'UNKNOWN_SRC' ) {
                if ( $stref->{$srctype}{$f}{'Status'} < $READ ) {
                    $stref->{$srctype}{$f}{'Status'} = $READ;
                }
            }
            my $mod_name = $pline->[1]{'EndModule'};
            push @{ $stref->{'Modules'}{$mod_name}{'AnnLines'} }, $pline
              unless $stref->{'Modules'}{$mod_name}{'Status'} == $PARSED;
        }
        elsif ( exists $pline->[1]{'EndSubroutine'}
            and $srctype eq 'Subroutines' )
        {

            if (
                not( exists $stref->{$srctype}{$f}{'Status'}
                    and $stref->{$srctype}{$f}{'Status'} == $PARSED )
              )
            {
                push @{ $stref->{$srctype}{$f}{'AnnLines'} }, $pline;
                $stref->{$srctype}{$f}{'Status'} = $READ;
            }
        }
        else {
            if ( $f ne 'UNKNOWN_SRC' )
            { # WV: what should happen is that on exit of a subroutine we push the rest onto the Module annlines.
                if (
                    not( exists $stref->{$srctype}{$f}{'Status'}
                        and $stref->{$srctype}{$f}{'Status'} == $PARSED )
                  )
                {
                    push @{ $stref->{$srctype}{$f}{'AnnLines'} }, $pline;
                }
            }
            else {
                chomp $line;
                say
                  "INFO: Adding <$line> to $src because code unit not yet known"
                  if $I;# or $line=~/SPECIES IS NOT FOUND/;

                  # This should only happen on the firs read of the sourcefile
                  if ( $stref->{'SourceFiles'}{$src}{'Status'} == 1) {
                    push @{ $stref->{'SourceFiles'}{$src}{'AnnLines'} }, $pline;
                  }

            }
        }

        #	      say $ann. ' : '.Dumper($pline);
    }

    return ( $stref, $f, $srctype );
}    # END of  _pushAnnLine()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------

sub _hasCont {
    croak 'UNUSED' if $DBG;
    ( my $line ) = @_;
    if ( $line =~ /\&\s*$/ ) {
        return 1;
    }
    else {
        return 0;
    }
}

# -----------------------------------------------------------------------------
sub _isCont {
    ( my $line, my $free_form ) = @_;
    my $is_cont = 0;
    if ( $free_form == 0 ) {
        if ( $line =~ /^\ {5}[^0\s]/ )
        { # continuation line. Continuation character can be anything, except a 0
            $is_cont = 1;
        }
        elsif ( $line =~ /^\&/ ) {
            $is_cont = 1;
        }
        elsif ( $line =~ /^\t[1-9]/ ) {
            $is_cont = 1;
        }

        # carp "<$line> $is_cont" if $line=~/^\s+\$.+nelbox/;
    }
    else {
        if ( $line =~ /^\s*\&/ ) {
            $is_cont = 1;
        }
    }
    return $is_cont;
}

# -----------------------------------------------------------------------------
sub _removeCont {
    ( my $line, my $free_form, my $remove_blanks_ok ) = @_;
    chomp $line;
    if ( _isCommentOrBlank($line) ) {
        return '';
    }

    if ( $free_form == 0 ) {
        if ( $line =~ /^\ {5}[^0\s]/ )
        {    # continuation line. Continuation character can be anything!
             # Can't have a blank here as they can split in the middle of a variable name!
             # However, removing the blanks leads to errors in strings.
             # A crude ad-hoc: if we detect a quote we don't remove the spaces ... WEAK, of course!
             # We can do better: of the first character of the line is a word character, and the last character of the prev line is also a word character, we remove all spaces
             # But for that we need more info in _removeCont:

            if ( $line !~ /[\'\"]/ and $remove_blanks_ok ) {

                $line =~ s/^\s{5}.\s*//;
            }
            else {
                $line =~ s/^\s{5}.//;
            }
        }
        elsif ( $line =~ /^\&/ ) {
            $line =~ s/^\&\t*/ /;
        }
        elsif ( $line =~ /^\t[1-9]/ ) {
            $line =~ s/^\t[0-9]/ /;
        }
        else {
            croak $line. $remove_blanks_ok if $DBG and $line =~ /iatt\,\ attname/;
        }
    }
    else {
        if ( $line =~ /^\s*\&/ ) {
            $line =~ s/^\s*\&\s*/ /;
        }
        if ( $line =~ /\&\s*$/ ) {
            $line =~ s/\&\s*//;
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
        while ( $tline =~ /(\".+?\")/ ) {
            $phs{"__PH${i}__"} = $1;
            $tline =~ s/(\".+?\")/__PH${i}__/;
            $i++;
        }
        if ( $tline =~ /\!.*$/ ) {
            $nline = ( split( /\!/, $tline ) )[0];
            for my $phk ( keys %phs ) {
                $nline =~ s/$phk/$phs{$phk}/;
            }
            $line = $nline;
        }
        else {
            for my $phk ( keys %phs ) {
                $tline =~ s/$phk/$phs{$phk}/;
            }
            $line = $tline;
        }
    }
    return $line;
}    # END of _removeCont()

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

    # First of all, handle pragma lines
    if ( $line =~ /^!\s*\$/ ) {
        $info->{'Pragma'} = 1;
    }

# Detect and standardise comments
# A line with a c, C, *, d, D, or! in column one is a comment line. The d, D, and! are nonstandard.
    elsif ( $free_form == 0 and $line =~ /^[CD\*\!]/i ) {

        #    	croak $free_form;
        $info->{'OrigComments'} = 1;
        $info->{'Comments'} = 1;
        $line = '! ' . substr( $line, 1 );
    }
    elsif ( $line =~ /^\s*\!/ ) {

# If you put an exclamation mark (!) in any column of the statement field, except within character literals, then everything after the ! on that line is a comment.
        $info->{'OrigComments'} = 1;
        $info->{'Comments'} = 1;
    }
    elsif ( $line =~ /^\s*contains\s*$/i ) {
        $info->{'Contains'} = 1;
    }

    # FIXME: trailing comments. I think they are discarded!
    elsif ( $line =~ /.\!.*$/ ) {
        my $tline = $line;
        my $nline = '';
        my $i     = 0;
        my %phs   = ();
        while ( $tline =~ /(\'.+?\')/ ) {
            $phs{"__PH${i}__"} = $1;
            $tline =~ s/(\'.+?\')/__PH${i}__/;
            $i++;
        }
        while ( $tline =~ /(\".+?\")/ ) {
            $phs{"__PH${i}__"} = $1;
            $tline =~ s/(\".+?\")/__PH${i}__/;
            $i++;
        }

        my $cline = $line;
        $cline =~ s/^.+?\!//;    # FIXME: not quite correct

        if ( $tline =~ /\!.*$/ ) {
            $nline = ( split( /\!/, $tline ) )[0];
            for my $phk ( keys %phs ) {
                $nline =~ s/$phk/$phs{$phk}/;
            }
            $line = $nline;
        }
        else {
            for my $phk ( keys %phs ) {
                $tline =~ s/$phk/$phs{$phk}/;
            }
            $line = $tline;
        }
        $info->{'TrailingComment'} = $cline;
    }
    else {
        # Label processing
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

    # If the line is not a normalised comment
    if ( substr( $line, 0, 2 ) ne '! ' and not exists $info->{'Pragma'} ) {

        if (   $line !~ /character\s*\*/i and $line =~ /\d+\s+[Ee]\s*[\+\-]?\d+/
            or $line =~ /\d+\s*[Ee]\s+[\+\-]?\d+/ )
        {

            while ($line =~ /\d+(\s+[Ee]\s*)[\+\-]?\d+/
                or $line =~ /\d+(\s*[Ee]\s+)[\+\-]?\d+/ )
            {
                my $orig = $1;
                my $fix  = $orig;
                $fix  =~ s/\s+//g;
                $line =~ s/$orig/$fix/;
            }

        }

        # Check for CPP macros
        if ( $line =~ /^\s*\#/ ) {

            $info->{'Macro'} = 1;
            if ( $line =~ /^\s*\#include\s+[\'\"]([\w\.]+)[\'\"]/i ) {
                $info->{'Includes'} = $1;
                $line =~ s/\bINCLUDE\b/include/;
            }

# I think I could add #if, #elif, #else and #endif as well
# I think #define could be handled as well
# Question is if this should be done here or in the parser
# But actually we should not parse these: they should simply be kept as-is and emitted in place
# Which means that simply the Macro tag is enough and it should be OK already!
        }
        elsif ( $line =~ /^\s+include\s+[\'\"]([\w\.]+)[\'\"]/i )
        {    # An actual Fortran include
            $info->{'Includes'}               = $1;
            $info->{'SpecificationStatement'} = 1;
            $line =~ s/\bINCLUDE\b/include/;
        }
        elsif (
               $line !~ /[\'\"]/
            && $line !~ /^\s*end/i
            && ( $line =~
/\b(module|program|recursive\s+subroutine|subroutine|entry|[\*\(\)\w]+\s+function|function|block)\s+(\w+)/i
                || $line =~ /\b(blockdata)/i )
          )
        {
            my $keyword = lc($1);
            my $name    = defined $2 ? lc($2) : 'NO_NAME';
            if ( $keyword eq 'block' and $name eq 'data' ) {
                $keyword = 'block data';
                $name    = 'block_data';
                $line =~ /block\s+data\s+(\w+)/i && do {
                    $name = lc($1);
                };
            }
            elsif ( $keyword eq 'blockdata' ) {

                $keyword = 'block data';
                $name    = 'block_data';
                $line =~ /blockdata\s+(\w+)/i && do {
                    $name = lc($1);
                };
            }

            die "_procLine(): No $keyword name " if $name eq '';
            my $spaces = ' ' x 6;
            if ( $keyword =~ /function/ ) {
                $info->{'FunctionSig'} = [ $spaces, $name, [] ];
            }
            elsif ( $keyword eq 'module' ) {
                $info->{'Module'} = $name;
            }
            elsif ( $keyword eq 'entry' ) {
                $info->{'EntrySig'} = $name;
            }
            else {
                $info->{'SubroutineSig'} = [ $spaces, $name, [] ];
            }
            $line = lc($line);
        }
        elsif (
            $line =~ /^\s*end\s+(subroutine|module|function|program)\s+(\w+)/i )
        {
            # This will likely only work for F95 code
            my $unit_type = ucfirst( lc($1) );
            my $unit_name = lc($2);
            $info->{ 'End' . $unit_type } = $unit_name;
            $line = lc($line);
        }
        elsif ( $line =~ /^\s*$/ ) {
            $line = '';
            $info->{'Blank'} = 1;
        }
        else {
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
            while ( $line =~ /(\".*?\")/ ) {
                my $strconst = $1;
                my $ph       = '__PH' . $ct . '__';
                $phs_ref->{$ph} = $strconst;
                $line =~ s/\".*?\"/$ph/;
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
sub _isCommentOrBlank {    # for fixed form
    ( my $line ) = @_;

# Detect comments & blank lines
# A line with a c, C, *, d, D, or! in column one is a comment line. The d, D, and! are nonstandard.
    if ( $line =~ /^[CD\*\!]/i or $line =~ /^\s*\!/ ) {
        return 1;
    }
    elsif ( $line =~ /^\s*$/ ) {
        return 1;
    }
    return 0;
}

# -----------------------------------------------------------------------------
sub _restore_case_of_macros {
    ( my $stref, my $line ) = @_;
    for my $macro ( keys %{ $stref->{'Macros'}{'All'} } ) {
        my $lc_macro = lc($macro);
        $line =~ s/\b$lc_macro\b/$macro/g;
    }
    return $line;
}

# -----------------------------------------------------------------------------
1;
