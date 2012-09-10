package RefactorF4Acc::Refactoring::Includes;

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

@RefactorF4Acc::Refactoring::Includes::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Includes::EXPORT_OK = qw(
  &refactor_includes
);

=pod
Includes
    refactor_includes()
    refactor_include()      
=cut

# -----------------------------------------------------------------------------
# In fact, "preconditioning" might be the better term
# I guess I should defer splitting the lines until the end
sub refactor_includes {
	( my $stref ) = @_;
#    $stref=resolve_module_deps($stref); FIXME!!!
	for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {

		if (   $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'Common'
			or $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'Parameter' )
		{
			print "\nREFACTORING INCLUDE $f\n" if $V;
			$stref = refactor_include( $f, $stref );
			$stref = create_refactored_source($stref, $f);
		}
	}
	
	return $stref;
}

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
sub refactor_include {
	( my $f, my $stref ) = @_;

	print "\n\n", '#' x 80, "\nRefactoring INC $f\n", '#' x 80, "\n" if $V;
	my $If = $stref->{'IncludeFiles'}{$f};
#	my $common=0;
#	if ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'Common' ) {
#		$common=1;
		$stref->{'IncludeFiles'}{$f}{'Source'}=$f.'.f95'; # FIXME: ad hoc
		$stref->{'BuildSources'}{'F'}{$f.'.f95'}=1;
#	}
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
#    if ($common) {
    	push @{ $refactored_lines },
    	[ "module $f", {'BeginModule'=>$f} ];
    	
#    }
	for my $annline ( @{$annlines} ) {
		my $line      = $annline->[0];
		my $info = $annline->[1];
		croak "WRONG REF" if ($info eq '');
		
		my %tags      = ( defined $info ) ? %{$info} : ();
		print '*** ' . join( ',', keys(%tags) ) . "\n" if $V;
		print '*** ' . $line . "\n" if $V;
		my $skip = 0;
		if ( exists $tags{'Common'} ) {
			$skip = 1;
		}
		if ( exists $tags{'VarDecl'} ) {
			$stref=resolve_module_deps($stref,$f,$line);			
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
				} else {
					push @nvars, $var;
				}
			}
			$annline->[1]{'VarDecl'} = [@nvars];
		} 
		if ( exists $tags{'Parameter'} ) {
#			print Dumper(%tags);
			for my $var (@{ $tags{'Parameter'} } ) {
#				print "PAR: $var\n";
                if ( exists $stref->{'IncludeFiles'}{$f}{'ConflictingGlobals'}
                    {$var} )
                {
                	my $gvar=$stref->{'IncludeFiles'}{$f}{'ConflictingGlobals'}{$var};
                	$line=~s/\b$var\b/$gvar/;
                    $info->{'Parameter'}=[$gvar];                    
                }
			}
			
		}
		if ( $skip == 0 ) {

				push @{ $refactored_lines },
				  [ $line, $info ];

		}
	}

        push @{ $refactored_lines },
        [ "end module $f", {'EndModule'=>$f} ];
        
   my $firstline=shift @{ $refactored_lines }; # This is weak. What we need is the line with "module" 
	for my $dep (keys %{ $stref->{'IncludeFiles'}{$f}{'Deps'} } ) {
            unshift @{ $refactored_lines },
            [ "use $dep", {'ModuleDep'=>$dep} ];
        }
        unshift @{ $refactored_lines },$firstline;
 $stref->{'IncludeFiles'}{$f}{'RefactoredCode'}  = $refactored_lines;
                  
	return $stref;

} # END of refactor_include()

# -----------------------------------------------------------------------------

sub resolve_module_deps {

    ( my $stref, my $f, my $line) = @_;

#    for my $f ( keys %{ $stref->{'IncludeFiles'} } ) {
#
#        if (   $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'Common' )
#        {            
#    print "MODULE $f:\n";
#    my $annlines = get_annotated_sourcelines( $stref, $f );
#    
#    for my $annline ( @{$annlines} ) {
#        my $line      = $annline->[0];
#        my $info = $annline->[1];
#        
#        my %tags      = ( defined $info ) ? %{$info} : ();
#        next if exists $tags{'Deleted'};
#        if ( exists $tags{'VarDecl'} && $line =~/dimension\((.+?)\)/) {
        if ( $line =~/dimension\((.+?)\)/) {
            my $varlst= $1;
            my @vars = split(/[:,\+\-]/,$varlst);
            for my $var ( @vars ) {
	           if ( not exists $stref->{'IncludeFiles'}{$f}{'Vars'}{$var} ) {
                    for my $inc ( keys %{ $stref->{'IncludeFiles'} } ) {
                        if (   $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
                        	if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$var} ) {
#                        		print "VAR $var in $inc\n";
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
