package Fortran::F95Normaliser;
use strict;
use warnings;
use v5.10;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#
use Carp;
use Exporter 'import';

@Fortran::F95Normaliser::EXPORT    = qw(
		normalise_F95_src
);

#--------------------------------------------------------------------------------

sub normalise_F95_src {(my $orig_lines)=@_;

                my $in_cont              = 0;
                my $joinedline='';
                my @comments_stack       = ();
                my $joined_lines=[];
                my $idx=0;
				for my $line (@{$orig_lines}) {
                    chomp $line;
					my $info={};
					if (hasTrailingComment($line)) {
						($line,$info)=_move_trailing_comment_to_info($line);
					}
                    my $next_line=$orig_lines->[$idx+1];
                    $idx++;
#                    while(isCommentOrBlank($next_line)) {
#                    	push @comments_stack,$next_line;
#                    	$next_line=$orig_lines->[$idx+1];
#                    	$idx++;
#                    }
#                    $line=~s/\t/  /g; # AD-HOC replace tab by 2 spaces
                    # Split lines with multiple statements with semicolons
                    if (not isCommentOrBlank($line) and $line=~/;/) {
                        my $tline = $line;
                        my $nline = '';
                        # Placeholders for strings
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
                        if ( $tline =~ /;/ ) {
                        	# Multiple statements on one line
                            my @tlines = split( /\s*;\s*/, $tline ) ;
                            my @nlines=();
                            for my $nline (@tlines) {
                                for my $phk ( keys %phs ) {
                                    $nline =~ s/$phk/$phs{$phk}/;
                                }
								_restore_trailing_comment($nline,$info);
                                push @nlines, $nline;
                            }
                            $line = pop @nlines;
                            for my $tline (@nlines) {
                                push @{$joined_lines}, $tline;
                            }
                        } else {
                            for my $phk ( keys %phs ) {
                                $tline =~ s/$phk/$phs{$phk}/;
                            }
                            $line = _restore_trailing_comment($tline,$info);
                        }
                    }

					if ($in_cont==0) {
						# This is not a continuation line.
					    if ( isCont( $line ) ) {
#                            say "CONT:$line <> $joinedline ";
						   $in_cont=1;
					       $joinedline .= removeCont( $line );
					    } elsif (defined $next_line and isPrefixCont( $next_line ) ) {
					    	if(isCommentOrBlank($line)) {
					    		$in_cont=3;
                    			push @comments_stack,$line ;
                    			$joined_lines->[-1].= removeCont( $next_line );
                    			$joinedline='!!!';
					    	} else {
					    		$in_cont=2;
					    		$joinedline=_restore_trailing_comment($line,$info);
					    	}
					    } else {
					        # emit line
					        if ( $line ne '' ) {
					            push @{$joined_lines}, _restore_trailing_comment($line,$info);
					        }
					        #WV: should I not clear $joinedline?
#					        carp 'CHECK THIS!';
					        $joinedline='';
					    }
					} else { # inside continuation line
#					say "IN CONT: $line";
						if ( isCont( $line ) and $in_cont!=3 ) {
						   $joinedline .=removeCont( $line );
						   # WV20170201 I added this because otherwise the next line for a continuation line of type & ... will be tagged onto it, should only be for type ... &

						   if ( isPrefixCont($line) ) {
#						   	say "LINE: $line => $joinedline";
						   	if (defined $next_line and not isPrefixCont( $next_line ) ) {
								if(isCommentOrBlank($next_line)) {
                    				push @comments_stack,$next_line ;
								} else {
						   			push @{$joined_lines}, _restore_trailing_comment($joinedline,$info);
						   			$joinedline='';
								}
#						   	carp 'CHECK THIS!';
						   	$in_cont=0;
							}
						   }
						} elsif ( isCommentOrBlank($line) ) {
					        push @comments_stack, $line;
						} else {
							# In cont but line is not cont => end of cont line =>
                            # I still call removeCont to clean up the line
						   $joinedline .= removeCont( $line ) unless $in_cont==2;
#                           my $ws = $joinedline; $ws=~s/\S+$//;
                           $joinedline=~s/\s*,\s*/,/g;
							# emit comments;
					        for my $commentline (@comments_stack) {
                                push @{$joined_lines}, $commentline;
					        }
					        @comments_stack       = ();
							# emit joined line
					        if ( $joinedline ne '') {
					        	if( $in_cont!=3) {
					            push @{$joined_lines}, _restore_trailing_comment($joinedline,$info);
					        	} else {
					        		$joinedline='';
					        	}
					        }
					        if ($in_cont==2) {
					        	push @{$joined_lines}, _restore_trailing_comment($line,$info);
					        }
							$joinedline='';
							$in_cont=0;
						}
					}
				}
                return $joined_lines;
} # END of normalise_F90_src()
 # -----------------------------------------------------------------------------
	sub isCont {
		( my $line ) = @_;
		my $is_cont = 0;
			if ( $line =~ /^\s*\&/ or $line=~/&\s*$/) {
				$is_cont = 1;
			}
		return $is_cont;
	} # END of isCont


 # -----------------------------------------------------------------------------

 	sub isPrefixCont {
		( my $line ) = @_;
		my $is_cont = 0;
			if ( $line =~ /^\s*\&/) {
				$is_cont = 1;
			}
		return $is_cont;
	} # END of isPrefixCont

 # -----------------------------------------------------------------------------
	sub isSuffixCont {
		( my $line ) = @_;
		my $is_cont = 0;
			if ( $line=~/&\s*$/) {
				$is_cont = 1;
			}
		return $is_cont;
	} # END of isSuffixCont

 # -----------------------------------------------------------------------------

	sub isCommentOrBlank {
		( my $line ) = @_;

		# Detect comments & blank lines
		if ( $line =~ /^[CD]\s+/i or $line =~ /^[CD]$/i or $line =~ /^[\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
			return 1;
		} elsif ( $line =~ /^\s*$/ ) {
			return 1;
		}
		return 0;
	} # END of isCommentOrBlank

	sub hasTrailingComment {
		( my $line ) = @_;
		if (not isCommentOrBlank($line)) {
			if ($line=~/\!.+$/) {
				# In principle this could be a bang in a string but I don't need perfection
				return 1;
			} 
		} 
		return 0;
		
	} # END of hasTrailingComment

 # -----------------------------------------------------------------------------
	sub removeCont {
		( my $line ) = @_;
		chomp $line;
		if ( isCommentOrBlank($line) ) {
			return '';
		}
        if ( $line =~ /^\s*\&/ ) {
            $line =~ s/^\s*\&\s*/ /;
        }
        if ( $line =~ /\&\s*$/ ) {
            $line =~ s/\&\s*$//;
        }
# I think I should remove the whitespace at the start of the line ->NO! Messes up indentation!
#		$line=~s/^\s+//;
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
	} # END of removeCont()
#--------------------------------------------------------------------------------

sub _move_trailing_comment_to_info { my ($line) = @_;
		my $info={};
# This line has a trailing comment
        my $tline = $line;
        my $nline = '';
        my $i     = 0;
        my %phs   = ();
        # replace Z'...' hex notation with decimal
        while ($tline =~ /[zZ]\'([A-Fa-f0-9]+?)\'/) {
          my $hex = hex($1);
          if ($hex<256) {
            $hex.='_1';
          }
          elsif ($hex<256*256) {
            $hex.='_2';
          }
          $tline =~ s/[zZ](\'.+?\')/$hex/;
        }
        # replace Z"..." hex notation with decimal
        while ($tline =~ /[zZ]\"([A-Fa-f0-9]+?)\"/) {
          my $hex = hex($1);
          if ($hex<256) {
            $hex.='_1';
          }
          elsif ($hex<256*256) {
            $hex.='_2';
          }
          $tline =~ s/[zZ](\".+?\")/$hex/;
        }
        # Find single-quoted strings and replace by placeholders
        while ( $tline =~ /(\'.+?\')/ ) {
            $phs{"__PH${i}__"} = $1;
            $tline =~ s/(\'.+?\')/__PH${i}__/;
            $i++;
        }
        # Find double-quoted strings and replace by placeholders
        while ( $tline =~ /(\".+?\")/ ) {
            $phs{"__PH${i}__"} = $1;
            $tline =~ s/(\".+?\")/__PH${i}__/;
            $i++;
        }
        # Identify the traisingling comment
        my $cline = $line;
        $cline =~ s/^.+?\!//;    # FIXME: not quite correct

        if ( $tline =~ /\!.*$/ ) {
            # remove the trailing comment
            $nline = ( split( /\!/, $tline ) )[0];
            # put the strings back
            for my $phk ( keys %phs ) {
                $nline =~ s/$phk/$phs{$phk}/;
            }
            $line = $nline;
        }
        else {
          # put the strings back
            for my $phk ( keys %phs ) {
                $tline =~ s/$phk/$phs{$phk}/;
            }
            $line = $tline;
        }
        $info->{'TrailingComment'} = $cline;
	return ($line,$info);
} # END of _move_trailing_comment_to_info

sub _restore_trailing_comment {my ($line,$info) = @_;
	if (exists $info->{'TrailingComment'}) {
		return $line. ' ! '.$info->{'TrailingComment'};
	} else {
		return $line;
	}
}
1;
