package RefactorF4Acc::Refactoring::IncludeFiles;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines create_refactored_source context_free_refactorings );

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

@RefactorF4Acc::Refactoring::IncludeFiles::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::IncludeFiles::EXPORT_OK = qw(
  &refactor_includes
);

=pod
Includes
    refactor_includes()
    refactor_include()      
=cut

# -----------------------------------------------------------------------------
# Refactor the includes into modules
sub refactor_includes {
	( my $stref ) = @_;
#    $stref=resolve_module_deps($stref); FIXME!!!
	for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {

			print "\nREFACTORING INCLUDE FILE $f\n" if $V;
			$stref = _refactor_include( $f, $stref );
#			$stref = create_refactored_source($stref, $f);
	}
	
	return $stref;
}

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
sub _refactor_include {
	( my $f, my $stref ) = @_; 

	print "\n\n", '#' x 80, "\nRefactoring INC $f\n", '#' x 80, "\n" if $V;
	my $If = $stref->{'IncludeFiles'}{$f};
	my $ff=$f;
	$ff=~s/\./_/g;
	$stref->{'IncludeFiles'}{$f}{'Source'}=$ff.'.f95'; # FIXME: ad hoc
	$stref->{'BuildSources'}{'F'}{$f.'.f95'}=1;
    if (   not exists $If->{'RefactoredCode'}
        or $If->{'RefactoredCode'} == []
        or exists $stref->{'BuildSources'}{'C'}{ $If->{'Source'} } ) # FIXME: needed?
    {
        $stref = context_free_refactorings( $stref, $f );
    }

	my $annlines = get_annotated_sourcelines( $stref, $f );
	
#	croak Dumper($annlines);
    my %deps=();
    my $refactored_lines=[];
    push @{ $refactored_lines },
    	[ "module $ff", {'BeginModule'=>$ff, 'Ref'=>1} ];
    	
	for my $annline ( @{$annlines} ) {
		next if not defined $annline; 
		my $line      = $annline->[0];
		      croak "WRONG REF: ".Dumper($annlines) if (not defined $annline->[1] or $annline->[1] eq '');
		my $info = $annline->[1];

		
		my %tags      = ( defined $info ) ? %{$info} : ();
		print '*** ' . join( ',', keys(%tags) ) . "\n" if $V;
		print '*** ' . $line . "\n" if $V;
		my $skip = 0;
		if ( exists $tags{'Common'} ) {
			$skip = 1;
		}
		if ( exists $tags{'VarDecl'} ) {
			$stref=__resolve_module_deps($stref,$f,$line);			
			my @nvars = ();
			for my $var ( @{ $info->{'VarDecl'} } ) {
				# Maybe put check for parameters here
				
				if ( $stref->{'IncludeFiles'}{$f}{'InclType'} ne 'Parameter'
					and
					exists $stref->{'IncludeFiles'}{$f}{'ConflictingGlobals'}
					{$var} )
				{
					my $gvar =
					  $stref->{'IncludeFiles'}{$f}{'ConflictingGlobals'}{$var};
					print
"WARNING: CONFLICT in var decls in $f: renaming $var to $gvar\n"
					  if $W;
					push @nvars, $gvar;
					$line =~ s/\b$var\b/$gvar/;
					$info->{'Ref'}++;
				} else {
					push @nvars, $var;
				}
			}
			$annline->[1]{'VarDecl'} = [@nvars];
		} 
		if ( exists $tags{'Parameter'} ) {
#			print Dumper(%tags);
			for my $var (@{ $tags{'Parameter'} } ) {
#				print "PAR: $var ($line)\n";
                if ( exists $stref->{'IncludeFiles'}{$f}{'ConflictingGlobals'}
                    {$var} )
                {
                	my $gvar=$stref->{'IncludeFiles'}{$f}{'ConflictingGlobals'}{$var};
                	$line=~s/\b$var\b/$gvar/;
                	$info->{'Ref'}++;
                    $info->{'Parameter'}=[$gvar];    
                    print "PAR: renamed $gvar ($line)\n"; die "WEAK";                
                }
#                if ($stref->{'IncludeFiles'}{$f}{'InclType'} eq 'Parameter') {
#                	die $line;
#                }
			}
			
		}
		if ( $skip == 0 ) {
				push @{ $refactored_lines },
				  [ $line, $info ];
		}
	}

        push @{ $refactored_lines },
        [ "end module $ff", {'EndModule'=>$ff, 'Ref'=>1} ];
        
   my $firstline=shift @{ $refactored_lines }; # FIXME This is weak. What we need is the line with "module" 
	for my $dep (keys %{ $stref->{'IncludeFiles'}{$f}{'Deps'} } ) {
            unshift @{ $refactored_lines },
            [ "use $dep ! refactor_include() line 146", {'ModuleDep'=>$dep, 'Ref'=>1} ];
        }
        unshift @{ $refactored_lines },$firstline;
 $stref->{'IncludeFiles'}{$f}{'RefactoredCode'}  = $refactored_lines;                  
	return $stref;

} # END of refactor_include()

# -----------------------------------------------------------------------------
# This routine is misnamed.  What it does is checking for dependencies of variables used in array shapes
# If a var is not found in the include file $f, we go through all include files.
# If we find a match, this include file is added to Deps of $f
sub __resolve_module_deps {
    ( my $stref, my $f, my $line) = @_;
        if ( $line =~/dimension\((.+?)\)/) { # WV: FIXME! BOO!
            my $varlst= $1;
            my @vars = split(/[:,\+\-]/,$varlst);
            for my $var ( @vars ) {
	           if ( not exists $stref->{'IncludeFiles'}{$f}{'Vars'}{$var} ) {
                    for my $inc ( keys %{ $stref->{'IncludeFiles'} } ) {
                        if (   $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
                        	if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$var} ) {
                        		$stref->{'IncludeFiles'}{$f}{'Deps'}{$inc}=1;
                        		last;
                        	}            
            	       }
                    }
	           }
            }
        } 
    return $stref;
}
# --------------------------------------------------------------------------------  
