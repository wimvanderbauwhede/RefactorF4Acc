package RefactorF4Acc::Parser::SrcReader;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::CallGraph qw ( add_to_call_tree );
use RefactorF4Acc::Refactoring::Common
  qw( format_f95_var_decl format_f77_var_decl );

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
$Data::Dumper::Indent=1;

use Exporter;

@RefactorF4Acc::Parser::SrcReader::ISA = qw(Exporter);

@RefactorF4Acc::Parser::SrcReader::EXPORT_OK = qw(
  &read_fortran_src
);
sub read_fortran_src {
	( my $s, my $stref ) = @_;
#	print "\n",'-' x 80,"\nread_fortran_src( $s )\n"; 
#    local $V=1;
#	*DBG = *STDOUT;
    open DBG, '>/dev/null';
	my $is_incl = exists $stref->{'IncludeFiles'}{$s} ? 1 : 0;

	my $sub_func_incl = sub_func_or_incl( $s, $stref );
	if ($sub_func_incl eq 'ExternalSubroutines') {
		$stref->{$sub_func_incl}{$s}{'Status'}=$UNREAD;		
	}
	if (not exists $stref->{$sub_func_incl}{$s}{'HasBlocks'} ){
	$stref->{$sub_func_incl}{$s}{'HasBlocks'} = 0;
	}
	my $f = $is_incl ? $s : $stref->{$sub_func_incl}{$s}{'Source'};

    if (defined $f) {
        my $no_need_to_read=1;
        if (not exists $stref->{'SourceContains'}{$f} ) {
		  $no_need_to_read=0;
        } else {
		for my $item (keys %{ $stref->{'SourceContains'}{$f} } ) {
			my $srctype=$stref->{'SourceContains'}{$f}{$item};
			my $status =$stref->{$srctype}{$item}{'Status'};
			# if one of them is still UNREAD, need to read.
			$no_need_to_read *= ($status != $UNREAD);
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

			my @lines     = @rawlines;
			push @lines,("      \n");
			my $free_form = $stref->{$sub_func_incl}{$s}{'FreeForm'};
			my $srctype   = $sub_func_incl;

			
			if ($free_form) {
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
                my $s=($srctype eq 'IncludeFiles') ? $s : '';
                my $in_cont              = 0;
                my @comments_stack       = ();

				for my $line (@lines) {		
#					print "LINE: $line\n";		
					if ($in_cont==0) {
					    if ( isCont( $line, $free_form ) ) {
						   $in_cont=1;
					       $joinedline .= removeCont( $line, $free_form );	
					    } else {
					        # emit line
					        if ( $line ne '' ) {
#					        	print "PUSH $line\n";

					            ( $stref, $s, $srctype ) =
					            pushAnnLine( $stref, $s, $srctype,$line, $free_form );
					        }	
					    }
					} else {
						if ( isCont( $line, $free_form ) ) {
						   $joinedline .= removeCont( $line, $free_form );
						} elsif ( isCommentOrBlank($line) ) {
					        push @comments_stack, $line;
						} else {
							# In cont but line is not cont => end of cont line => 
							# emit comments;
					        for my $commentline (@comments_stack) {
					        	
					            ( $stref, $s, $srctype ) =
					                                      pushAnnLine( $stref, $s, $srctype,
					                                        $commentline, $free_form );
					        }                                        
					        @comments_stack       = ();
							
							# emit joined line
					        if ( $joinedline ne '' ) {
					        	
					            ( $stref, $s, $srctype ) =
					            pushAnnLine( $stref, $s, $srctype,$joinedline, $free_form );
					        }   
							$joinedline='';
							$in_cont=0;
						}	
					}
				}
# --------------------- # END of free-form parsing # --------------------- 			
				
			} else {
                my $s=($srctype eq 'IncludeFiles') ? $s : '';
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

							#				$joinedline=$line;
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
						if ( isCont( $line, $free_form ) ) {
							if ( isCont( $nextline, $free_form ) ) {
								print DBG "C++\n";
								#+ l
								#+ n
								@comments_stack = ();    # redundant?
								$joinedline .= removeCont( $line, $free_form );
								$joinedline .=
								  removeCont( $nextline, $free_form );
							} elsif ( isCommentOrBlank($nextline) ) {
								print DBG "C+!\n";

								#+ l
								#! n
								$joinedline .= removeCont( $line, $free_form );
								$line                 = $nextline;
								$next2                = 0;
								$in_cont              = 0;
								$line_set_to_nextline = 1;
							} else {    # isPlain
								print DBG "C+ \n";

							 #+ l
							 #  n
							 #=> join l, emit joined, set l=n, set maybe_in_cont
								$joinedline .= removeCont( $line, $free_form );
								
								( $stref, $s, $srctype ) =
								  pushAnnLine( $stref, $s, $srctype,
									$joinedline, $free_form );
								$joinedline           = '';
								$line                 = $nextline;
								$next2                = 0;
								$in_cont              = 0;
								$line_set_to_nextline = 1;
							}
						} elsif ( isCommentOrBlank($line) ) {
							if ( isCont( $nextline, $free_form ) ) {
								print DBG "C!+\n";
								#! l
								#+ n
								#=> ignore the comment, join n
								push @comments_stack, $line;
								$joinedline .=
								  removeCont( $nextline, $free_form );
							} elsif ( isCommentOrBlank($nextline) ) {
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
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }

								# emit the comment
								( $stref, $s, $srctype ) =
								  pushAnnLine( $stref, $s, $srctype, $line,
									$free_form );
								#l=n, maybe_in_cont
								$line                 = $nextline;
								$next2                = 0;
								$in_cont              = 0;
								$line_set_to_nextline = 1;
							}
						} else {    # isPlain
							if ( isCont( $nextline, $free_form ) ) {
								print DBG "C +\n";

								#  l
								#+ n
								#=> emit the joinedline
								if ( $joinedline ne '' ) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$joinedline, $free_form );
									$joinedline = '';
								}

					   #=> push l onto joined; push n onto joined; (set in_cont)
								$joinedline .= removeCont( $line, $free_form );
								$joinedline .=
								  removeCont( $nextline, $free_form );
							} elsif ( isCommentOrBlank($nextline) ) {
								print DBG "C !\n";
  #  l
  #! n
  #=> emit the joined line; set maybe_in_cont; push l on joined; push n on stack
								if ( $joinedline ne '' ) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$joinedline, $free_form );
									$joinedline = '';
								}
								$in_cont = 0;
								$joinedline .= removeCont( $line, $free_form );
								push @comments_stack, $nextline;
							} else {    # isPlain
								print DBG "C  \n";

								#  l
								#  n
								#=> emit the joinedline; emit l
								#=> l=n , set maybe_in_cont
								if ( $joinedline ne '' ) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$joinedline, $free_form );
									$joinedline = '';
								}
								( $stref, $s, $srctype ) =
								  pushAnnLine( $stref, $s, $srctype, $line,
									$free_form );
								$line                 = $nextline;
								$next2                = 0;
								$in_cont              = 0;
								$line_set_to_nextline = 1;
							}
						}
					} else {    # not $in_cont
						if ( isCont( $line, $free_form ) ) {
							if ( isCont( $nextline, $free_form ) ) {
								print DBG "M++\n";

								#+ l
								#+ n
								#=> dump the comments, join both, set in_cont
								@comments_stack = ();
								$joinedline .= removeCont( $line, $free_form );
								$joinedline .=
								  removeCont( $nextline, $free_form );
								$in_cont = 1;
							} elsif ( isCommentOrBlank($nextline) ) {
								print DBG "M+!\n";

							#+ l
							#! n
							#=> dump the comments, join l, set $in_cont, set l=n
								@comments_stack = ();
								$joinedline .= removeCont( $line, $free_form );
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
								$joinedline .= removeCont( $line, $free_form );
								( $stref, $s, $srctype ) =
								  pushAnnLine( $stref, $s, $srctype,
									$joinedline, $free_form );
								$joinedline           = '';
								$line                 = $nextline;
								$next2                = 0;
								$line_set_to_nextline = 1;
							}
						} elsif ( isCommentOrBlank($line) ) {
							if ( isCont( $nextline, $free_form ) ) {
								print DBG "M!+\n";

								#! l
								#+ n
								#=> dump the comments, join n, set in_cont
								@comments_stack = ();
								$joinedline .=
								  removeCont( $nextline, $free_form );
								$in_cont = 1;
							} elsif ( isCommentOrBlank($nextline) ) {
								print DBG "M!!\n";

								#! l
								#! n
								#=> push both comments
								push @comments_stack, $line;
								push @comments_stack, $nextline;
#								print Dumper(@comments_stack);

					 #warn join("\n",("<$line>","<$nextline>","<$joinedline>"));
							} else {    # isPlain
								print DBG "M! \n";

                			   #! l
                			   #  n
                			   #=> emit $joinedline, emit the comments, l=n, (set maybe_in_cont)
								if ( $joinedline ne '' ) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$joinedline, $free_form );
									$joinedline = '';
								}
								for my $commentline (@comments_stack) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$commentline, $free_form );
								}
                                pushAnnLine( $stref, $s, $srctype,
                                        $line, $free_form );								
								@comments_stack       = ();
								$line                 = $nextline;
								$next2                = 0;
								$line_set_to_nextline = 1;

					  #die join("\n",("<$line>","<$nextline>","<$joinedline>"));
							}
						} else {    # isPlain
							if ( isCont( $nextline, $free_form ) ) {
								print DBG "M +\n";

								#  l
								#+ n
								#=> emit $joinedline; emit the comments
								#=> set $in_cont, join l & n
								if ( $joinedline ne '' ) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$joinedline, $free_form );
									$joinedline = '';
								}
								for my $commentline (@comments_stack) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$commentline, $free_form );
								}
								@comments_stack = ();
								$in_cont        = 1;
								$joinedline .= removeCont( $line, $free_form );
								$joinedline .=
								  removeCont( $nextline, $free_form );
							} elsif ( isCommentOrBlank($nextline) ) {
								print DBG "M !\n";

                                #  l
                                #! n
                                #=> emit $joinedline; emit the comments, push l onto joinedline, push comment onto stack (set maybe_in_cont)
								if ( $joinedline ne '' ) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$joinedline, $free_form );
									$joinedline = '';
								}
								for my $commentline (@comments_stack) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$commentline, $free_form );
								}
								@comments_stack = ();
								$joinedline .= removeCont( $line, $free_form );
								$line=''; # TEST
								push @comments_stack, $nextline;
							} else {    # isPlain
								print DBG "M  \n";

								#  l
								#  n
								#=> emit the comments and l
								#=> l=n , (set maybe_in_cont)
								print DBG "--\n";
								if ( $joinedline ne '' ) {
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$joinedline, $free_form );
									$joinedline = '';
									print DBG "---\n";
								}
								# FIXME: comments that come before a function/subroutine signature
								# are ignored because $s is unknown, set to ''
								for my $commentline (@comments_stack) {																	
									( $stref, $s, $srctype ) =
									  pushAnnLine( $stref, $s, $srctype,
										$commentline, $free_form );
								}
								@comments_stack = ();
								print DBG "----\n";
								( $stref, $s, $srctype ) =
								  pushAnnLine( $stref, $s, $srctype, $line,
									$free_form );
								$line                 = $nextline;
								$next2                = 0;
								$line_set_to_nextline = 1;
							}
						}
					}
				}    # loop over source lines

#print "POSTAMBLE\n";
                if ($in_cont) {
                        if ( isCont( $line, $free_form ) ) {
                            if ( isCont( $nextline, $free_form ) ) {
                                print DBG "C++\n";

                                #+ l
                                #+ n
                                $joinedline .= removeCont( $line, $free_form );
                                $joinedline .=
                                  removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                            } elsif ( isCommentOrBlank($nextline) ) {
                                print DBG "C+!\n";

                                #+ l
                                #! n
                                $joinedline .= removeCont( $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                $joinedline           = '';
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $nextline, $free_form );
                            } else {    # isPlain
                                print DBG "C+ \n";

                             #+ l
                             #  n
                             #=> join l, emit joined, set l=n, set maybe_in_cont
                                $joinedline .= removeCont( $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $nextline, $free_form );
                            }
                        } elsif ( isCommentOrBlank($line) ) {
                            if ( isCont( $nextline, $free_form ) ) {
                                print DBG "C!+\n";
                                #! l
                                #+ n
                                #=> ignore the comment, join n
                                $joinedline .=
                                  removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                  
                            } elsif ( isCommentOrBlank($nextline) ) {
                                print DBG "C!!\n";
                                #! l
                                #! n
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $nextline, $free_form );
                                
                            } else {    # isPlain
                                print DBG "C! \n";
                                #! l
                                #  n
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $nextline, $free_form );
                            }
                        } else {    # isPlain
                            if ( isCont( $nextline, $free_form ) ) {
                                print DBG "C +\n";

                                #  l
                                #+ n
                                #=> emit the joinedline
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }

                       #=> push l onto joined; push n onto joined; (set in_cont)
                                $joinedline .= removeCont( $line, $free_form );
                                $joinedline .=
                                  removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                  
                            } elsif ( isCommentOrBlank($nextline) ) {
                                print DBG "C !\n";
  #  l
  #! n
  #=> emit the joined line; set maybe_in_cont; push l on joined; push n on stack
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }                                
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $line, $free_form );
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $nextline, $free_form );
                                
                            } else {    # isPlain
                                print DBG "C  \n";

                                #  l
                                #  n
                                #=> emit the joinedline; emit l
                                #=> l=n , set maybe_in_cont
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                            }
                        }
                    } else {    # not $in_cont
                        if ( isCont( $line, $free_form ) ) {
                            if ( isCont( $nextline, $free_form ) ) {
                                print DBG "M++\n";

                                #+ l
                                #+ n
                                #=> dump the comments, join both, set in_cont

                                $joinedline .= removeCont( $line, $free_form );
                                $joinedline .=
                                  removeCont( $nextline, $free_form );
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );

                            } elsif ( isCommentOrBlank($nextline) ) {
                                print DBG "M+!\n";

                            #+ l
                            #! n
                            #=> dump the comments, join l, set $in_cont, set l=n
                                
                                $joinedline .= removeCont( $line, $free_form );
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $nextline, $free_form );
                            } else {    # isPlain
                                print DBG "M+ \n";

         #+ l
         #  n
         #=> dump the comments, join l, emit joined, set l=n (set maybe_in_cont)
                                
                                $joinedline .= removeCont( $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype,
                                    $joinedline, $free_form );
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $nextline, $free_form );
                            }
                        } elsif ( isCommentOrBlank($line) ) {
                            if ( isCont( $nextline, $free_form ) ) {
                                print DBG "M!+\n";

                                #! l
                                #+ n
                                #=> dump the comments, join n, set in_cont
                                
                                $joinedline .=
                                  removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );

                            } elsif ( isCommentOrBlank($nextline) ) {
                                print DBG "M!!\n";

                                #! l
                                #! n
                                #=> push both comments
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }

                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $nextline, $free_form );
                                
                            } else {    # isPlain
                                print DBG "M! \n";

               #! l
               #  n
               #=> emit $joinedline, emit the comments, l=n, (set maybe_in_cont)
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }
                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $nextline, $free_form );
                            }
                        } else {    # isPlain
                            if ( isCont( $nextline, $free_form ) ) {
                                print DBG "M +\n";

                                #  l
                                #+ n
                                #=> emit $joinedline; emit the comments
                                #=> set $in_cont, join l & n
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }
                                $joinedline .= removeCont( $line, $free_form );
                                $joinedline .=
                                  removeCont( $nextline, $free_form );
                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                  
                            } elsif ( isCommentOrBlank($nextline) ) {
                                print DBG "M !\n";

                                #  l
                                #! n
                                #=> emit $joinedline; emit the comments, push l onto joinedline, push comment onto stack (set maybe_in_cont)
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
#                                    $joinedline = '';
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }                                
                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $line, $free_form );
                                ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $nextline, $free_form );
#                                        print join("\n",("<L:$line>","<N:$nextline>","<J:$joinedline>"));
                            } else {    # isPlain
                                print DBG "M  \n";

                                #  l
                                #  n
                                #=> emit the comments and l
                                #=> l=n , (set maybe_in_cont)
                                print DBG "--\n";
                                if ( $joinedline ne '' ) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $joinedline, $free_form );
                                    $joinedline = '';
                                    print DBG "---\n";
                                }
                                for my $commentline (@comments_stack) {
                                    ( $stref, $s, $srctype ) =
                                      pushAnnLine( $stref, $s, $srctype,
                                        $commentline, $free_form );
                                }
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype, $line,
                                    $free_form );
                                ( $stref, $s, $srctype ) =
                                  pushAnnLine( $stref, $s, $srctype, $nextline,
                                    $free_form );
                                    
                            }
                        }
                    }
####### POSTAMBLE
#
#				if ( $joinedline ne '' ) {
#					( $stref, $s, $srctype ) =
#					  pushAnnLine( $stref, $s, $srctype, $joinedline,
#						$free_form );
#				}
#				if (!$in_cont) {
#					if ($line ne $joinedline) { # FIXME: WEAK! 					
#					( $stref, $s, $srctype ) =
#					  pushAnnLine( $stref, $s, $srctype, $line, $free_form );
#					}
#					if ( not $line_set_to_nextline ) {
#						( $stref, $s, $srctype ) =
#						  pushAnnLine( $stref, $s, $srctype, $nextline,
#							$free_form );
#					}
#				}
#				 # end of postamble
            if (not exists $stref->{$srctype}{$s}{'Status'} ) {print "UNDEF: $s\n"; }
				if ($stref->{$srctype}{$s}{'Status'} == $UNREAD ) {
					$stref->{$srctype}{$s}{'Status'} = $READ;
				}				
			} # free or fixed form
			
			}    #ok
		}    # if $need_to_read
#		die Dumper($stref->{'Subroutines'}{'wrf'}{'AnnLines'});
    } # if $f is defined
		return $stref;
	}    # END of read_fortran_src()

 # -----------------------------------------------------------------------------

 # -----------------------------------------------------------------------------
 # How to skip the funcs/subs that have been read/parsed already?
 # One way is maybe to record for every item which other items occur in the source.
 # If it turns out the source was fully read, skip it
 # So we'd need a field 'AlsoInSource' or 'SourceContains'
 
 
	sub pushAnnLine {
		( my $stref, my $f, my $srctype, my $line, my $free_form ) = @_;		
		my $pline = procLine( $line, $free_form );  
#		print "PLINE: ",Dumper($pline),"\n";  
		if ( exists $pline->[1]{'SubroutineSig'} ) {
#			print "$srctype $f: FOUND Subroutine ". $pline->[1]{'SubroutineSig'}."\n";
			if ($f ne '') {
			if ($stref->{$srctype}{$f}{'Status'}   == $UNREAD ) { # FIXME: bit late, can I catch this earlier?
			$stref->{$srctype}{$f}{'Status'}   = $READ;
#			print "SETTING $srctype $f has Status to READ\n";
			} else {
#				print "WARNING: $srctype $f has Status ".$stref->{$srctype}{$f}{'Status'}."\n";
			}
			}
			$srctype                           = 'Subroutines';
			$f                                 = $pline->[1]{'SubroutineSig'};
			$stref->{$srctype}{$f}{'AnnLines'} = [];
		} elsif ( exists $pline->[1]{'FunctionSig'} ) {
#			print "$srctype $f: FOUND Function ". $pline->[1]{'FunctionSig'}."\n";
			if ($f ne '') {
			if ($stref->{$srctype}{$f}{'Status'}   == $UNREAD ) {
			$stref->{$srctype}{$f}{'Status'}   = $READ;
#			print "SETTING $srctype $f has Status to READ\n";
			} else {
#			print "WARNING: $srctype $f has Status ".$stref->{$srctype}{$f}{'Status'}."\n";
			}
			}
			$srctype                           = 'Functions';
			$f                                 = $pline->[1]{'FunctionSig'};
			$stref->{$srctype}{$f}{'AnnLines'} = [];
		}
		
		push @{ $stref->{$srctype}{$f}{'AnnLines'} }, $pline;
#		print "PUSHED: $pline->[0]\n" if $V;
		return ( $stref, $f, $srctype );
	}    # pushAnnLine()

 # -----------------------------------------------------------------------------
 # -----------------------------------------------------------------------------
	sub isCont {
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
	sub removeCont {
		( my $line, my $free_form ) = @_;
		chomp $line;
		if ( isCommentOrBlank($line) ) {
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
	}

 # -----------------------------------------------------------------------------

=pod
 What we do is:
 - reformat lines with labels
 - replace strings
 - detect and standardise comments
 - add metadata
=cut

	sub procLine {
		( my $line, my $free_form ) = @_;
        
		chomp $line;
		my $info = {};

		# Detect and standardise comments
		if ( $line =~ /^[CD\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
			$line =~ s/^\s*[CcDd\*\!]/! /;
			$info->{'Comments'} = 1;
		} elsif ( $line =~ /.\!.*$/ )
		{    # FIXME: trailing comments are discarded!
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
			$cline =~ s/^.+?\!//;    # FIXME: not quite correct

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
			if ( $line =~ /^\s+include\s+\'(\w+)\'/i ) {
				$info->{'Includes'} = $1;
				$line =~ s/\bINCLUDE\b/include/;
			} elsif ( $line !~ /\'/
			    && $line !~/^\s*end/i 
				&& $line =~ /\b(program|recursive\s+subroutine|subroutine|function)\s+(\w+)/i )
			{
				my $keyword = lc($1);
				my $name    = lc($2);
die "procLine(): No $keyword name " if $name eq '';
				if ( $keyword eq 'function' ) {
					$info->{'FunctionSig'} = $name;
				} else {
					$info->{'SubroutineSig'} = $name;
				}
				$line = lc($line);
			} elsif ($line=~/^\s*$/) {
				$line='';
				$info->{'Blank'}=1;	
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
	}    # procLine()

 # -----------------------------------------------------------------------------
	sub isCommentOrBlank {
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

=pod

	if ( isCont( $nextline, $free_form ) ) {
# +? line
# +  nextline

# If he previous line was a comment:
# ! line
# + nextline
# => If joinedline is not empty, push; else it is an error!

# If the previous line is a plain line:	
#   line
# + nextline		
# => Start of a new joined line, push both		

# If the previous line is a cont line:	
# + line
# + nextline
# => push both

#		If it is not a comment nor a continuation line, it is a new continuation line
# In that case we must first push to joined line
#		If it is a comment, that means we have to keep pushing		
		if ($joinedline ne '' and not isCont($line, $free_form ) and not isCommentOrBlank($line) ) {
			($stref,$s,$srctype) = pushAnnLine($stref,$s,$srctype,$joinedline, $free_form);
			$joinedline='';
		}
		$joinedline .= removeCont( $line, $free_form );
		$joinedline .= removeCont( $nextline, $free_form );
	} elsif ( isCont( $line, $free_form )
			&& !isCont( $nextline, $free_form ) )
	{

# + line
#   nextline -> could be a split line, unless it's a blank or a comment
# If nextline is not a comment (i.e. if it is a plain line)
# => push line onto joinedline; emit joinedline & clear		
		
# If nextline is a comment
# => push line onto joinedline but don't clear or emit; 		

		$joinedline .= removeCont( $line, $free_form );
		($stref,$s,$srctype) = pushAnnLine($stref,$s,$srctype,$joinedline, $free_form);
		$joinedline = '';
		$line  = $nextline;
		$next2 = 0;
	} else {
# line
# nextline -> could be a split line, unless it's a blank or a comment
# What we need to know is if the previous lines was a cont. 
# If so, 

if ($in_cont) {
	if (not isCommentOrBlank($line) ) {
#		emit joined line & clear
		if (not isCommentOrBlank($nextline) {
#		emit line
			$line=$nextline;
		} else {
#		We can't emit line because nextline is a comment so
#		it might be the start of a continuation line
# So what we should do is tentatively push it onto $joinedline and set 
		$joinedline=removeCont( $line, $free_form );
		$maybe_in_cont=1;
# Furthermore, we should push the comments onto @comments_stack
			push @comments_stack,$nextline;		
# Then in the next state, we need to look at line and nextline:




		}
	} else { # line is a comment
		if (not isCommentOrBlank($nextline) ) {
#			emit joinedline & clear
#			emit line	
		} else {
#			Both lines are comments so we should skip them			
		}
	}		
} else {
# => emit line;
if ( isCommentOrBlank($nextline) {
# emit nextline
	} else { # Might be start of a cont line
	$line=$nextline; 
	}
	
}

		if ($joinedline ne '' and not isCommentOrBlank($nextline) ) { # FIXME: still weak: if there are a lot of comments in a broken-up line, 
# it could be that we still get a continuation. 
			($stref,$s,$srctype) = pushAnnLine($stref,$s,$srctype,$joinedline, $free_form);
			$joinedline='';
		}
		($stref,$s,$srctype) = pushAnnLine($stref,$s,$srctype,$line, $free_form);
		if ( not isCommentOrBlank( $nextline, $free_form ) ) {							
			$line  = $nextline;
			$line_set_to_nextline=1;
			$next2 = 0;
		} else {
			($stref,$s,$srctype) = pushAnnLine($stref,$s,$srctype,$nextline, $free_form);
		}
	}
=cut
