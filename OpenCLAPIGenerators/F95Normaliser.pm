package F95Normaliser;
use strict;
use warnings; 
use 5.012;

use Exporter 'import';

@F95Normaliser::EXPORT    = qw(
		normalise_F95_src
);

#--------------------------------------------------------------------------------

sub normalise_F95_src {(my $orig_lines)=@_;

                my $in_cont              = 0;
                my $joinedline='';
                my @comments_stack       = ();
                my $joined_lines=[];
				for my $line (@{$orig_lines}) {		
                    chomp $line;
                    if (not isCommentOrBlank($line) && $line=~/;/) {

                        my $tline = $line;
                        my $nline = '';
                        my $i     = 0;
                        my %phs   = ();
                        while ( $tline =~ /(\'.+?\')/ ) {
                            $phs{"__PH${i}__"} = $1;
                            $tline =~ s/(\'.+?\')/__PH${i}__/;
                            $i++;
                        }
                        if ( $tline =~ /;/ ) {
                            my @tlines = split( /\s*;\s*/, $tline ) ;
                            my @nlines=();
                            for my $nline (@tlines) {                
                                for my $phk ( keys %phs ) {
                                    $nline =~ s/$phk/$phs{$phk}/;
                                }
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
                            $line = $tline;
                        }
                    }
					if ($in_cont==0) {
					    if ( isCont( $line ) ) {
#                            die "CONT:$line";
						   $in_cont=1;
					       $joinedline .= removeCont( $line );	
					    } else {
					        # emit line
					        if ( $line ne '' ) {
					            push @{$joined_lines}, $line;
					        }	
					    }
					} else { # inside continuation line
						if ( isCont( $line ) ) {
						   $joinedline .= removeCont( $line );
						} elsif ( isCommentOrBlank($line) ) {
					        push @comments_stack, $line;
						} else {
							# In cont but line is not cont => end of cont line => 
                            # I still call removeCont to clean up the line
						   $joinedline .= removeCont( $line );
#                           my $ws = $joinedline; $ws=~s/\S+$//;
                           $joinedline=~s/\s*,\s*/,/g;
							# emit comments;
					        for my $commentline (@comments_stack) {
                                push @{$joined_lines}, $commentline;
					        }                                        
					        @comments_stack       = ();
							# emit joined line
					        if ( $joinedline ne '' ) {
					            push @{$joined_lines}, $joinedline;
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
	sub isCommentOrBlank {
		( my $line ) = @_;

		# Detect comments & blank lines
		if ( $line =~ /^[CD\*\!]/i or $line =~ /^\ {6}\s*\!/i ) {
			return 1;
		} elsif ( $line =~ /^\s*$/ ) {
			return 1;
		}
		return 0;
	} # END of isCommentOrBlank
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
1;
