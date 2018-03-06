package RefactorF4Acc::Refactoring::IncludeFiles;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines context_free_refactorings );

#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.0.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::IncludeFiles::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::IncludeFiles::EXPORT_OK = qw(
  &refactor_include_files
);


# -----------------------------------------------------------------------------
# Refactor the includes into modules
sub refactor_include_files {
	( my $stref ) = @_;
	for my $inc_f ( keys %{ $stref->{'IncludeFiles'} } ) {
            next if $stref->{'IncludeFiles'}{$inc_f}{'InclType'} eq 'External';
			print "\nREFACTORING INCLUDE FILE $inc_f\n" if $V;
			$stref = _refactor_include_file( $inc_f, $stref );
	}
	
	return $stref;
} # END of refactor_include_files()

# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
sub _refactor_include_file {
	( my $inc_f, my $stref ) = @_; 

	print "\n\n", '#' x 80, "\nRefactoring INC $inc_f\n", '#' x 80, "\n" if $V;
	
	my $If = $stref->{'IncludeFiles'}{$inc_f};
	my $inc_ff=$inc_f;
	$inc_ff=~s/\./_/g;
	$stref->{'IncludeFiles'}{$inc_f}{'Source'}=$inc_ff.$EXT; # FIXME: ad hoc
	if ($stref->{'IncludeFiles'}{$inc_f}{'InclType'} eq 'Parameter') {
		$stref->{'BuildSources'}{'F'}{$inc_ff.$EXT}=1;
	}
    if (   not exists $If->{'RefactoredCode'}
        or $If->{'RefactoredCode'} == []
        or exists $stref->{'BuildSources'}{'C'}{ $If->{'Source'} } ) # FIXME: needed?
    {
        $stref = context_free_refactorings( $stref, $inc_f ); # FIXME: why here? 
    }

	my $annlines = get_annotated_sourcelines( $stref, $inc_f );

    # So at this point the type declarations have not been refactored.
    # I can either do it here ad-hoc or see why they did not get refactored.
    my %deps=();
    my $refactored_lines=[];
    push @{ $refactored_lines },
    	[ "module $inc_ff", {'BeginModule'=>$inc_ff, 'Ref'=>1} ];
    	
	for my $annline ( @{$annlines} ) {
		next if not defined $annline; 
		(my $line, my $info)      =@{ $annline };
				
		print '*** ' . join( ',', keys(%{$info}) ) . "\n" if $DBG;
		print '*** ' . $line . "\n" if $DBG;
		my $skip = 0;
		if ( exists $info->{'Common'} ) {
			$skip = 1;
		}
		if ( exists $info->{'VarDecl'} ) {
			$stref=__resolve_module_deps($stref,$inc_f,$line);
			my $var = $info->{'VarDecl'}{'Name'};			
			my $nvar = $var;
			
				# Maybe put check for parameters here
				
				if ( $stref->{'IncludeFiles'}{$inc_f}{'InclType'} ne 'Parameter'
					and
					exists $stref->{'IncludeFiles'}{$inc_f}{'ConflictingGlobals'}
					{$var} )
				{
					my $gvar =
					  $stref->{'IncludeFiles'}{$inc_f}{'ConflictingGlobals'}{$var}[0];
					print
"WARNING: CONFLICT in var decls in $inc_f: renaming $var to $gvar\n"
					  if $W;
					$nvar = $gvar;
					$line =~ s/\b$var\b/$gvar/;
					$info->{'Ref'}++;
				} 
			
			$annline->[1]{'VarDecl'}{'Name'} = $nvar;
		} 
		if ( exists $info->{'ParamDecl'} ) {
#			print Dumper(%{$info});
            if (exists $info->{'ParamDecl'}{'Name'}) {
			my $var_val = $info->{'ParamDecl'}{'Name'};
			(my $var,my $val)=@{$var_val};
#				print "PAR: $var ($line)\n";
                if ( exists $stref->{'IncludeFiles'}{$inc_f}{'ConflictingGlobals'}
                    {$var} )
                {
                	my $gvar=$stref->{'IncludeFiles'}{$inc_f}{'ConflictingGlobals'}{$var}[0];
                	$line=~s/\b$var\b/$gvar/;
                	$info->{'Ref'}++;
                    $info->{'ParamDecl'}=[$gvar];    
                    print "WARNING: WEAK! renamed $var to $gvar ($line) refactor_include_file() 121\n" if $W;                 
                }			
            } elsif (exists $info->{'ParamDecl'}{'Names'}) { #die $line.Dumper($info);
                for my $var_val (@{ $info->{'ParamDecl'}{'Names'} }) {
			(my $var,my $val)=@{$var_val};
#				print "PAR: $var ($line)\n";
                if ( exists $stref->{'IncludeFiles'}{$inc_f}{'ConflictingGlobals'} {$var} )
                {
                    die 'BOOM!';
                	my $gvar=$stref->{'IncludeFiles'}{$inc_f}{'ConflictingGlobals'}{$var}[0];
                	$line=~s/\b$var\b/$gvar/;
                	$info->{'Ref'}++;
                    $info->{'ParamDecl'}=[$gvar];    
                    print "WARNING: WEAK! renamed $var to $gvar ($line) refactor_include_file() 121\n" if $W;                 
                }			
                }
 
            }


		}
		if ( exists $info->{'Implicit'} ) {
		    print "WARNING: IMPLICIT: removing the implicit type declaration <$line> in $inc_f, please make sure your code does not use them!\n" if $W;		    
		    $line = '!! '.$line;
		    $info->{'Comments'}=1;
		    
		}
		if ( $skip == 0 ) {
				push @{ $refactored_lines },
				  [ $line, $info ];
		}
	}

        push @{ $refactored_lines },
        [ "end module $inc_ff", {'EndModule'=>$inc_ff, 'Ref'=>1} ];
        
   my $inc_firstline=shift @{ $refactored_lines }; # FIXME This is weak. What we need is the line with "module" 
	for my $dep (keys %{ $stref->{'IncludeFiles'}{$inc_f}{'Deps'} } ) {
            unshift @{ $refactored_lines },
            [ "use $dep ! refactor_include() line 146", {'ModuleDep'=>$dep, 'Ref'=>1} ];
        }
        unshift @{ $refactored_lines },$inc_firstline;
     $stref->{'IncludeFiles'}{$inc_f}{'RefactoredCode'}  = $refactored_lines;
# 	if ($inc_f=~/^common/)  {
#	    print Dumper($refactored_lines);
#	    die;
#	}
                   
	return $stref;

} # END of _refactor_include_file()

# -----------------------------------------------------------------------------
# This routine is misnamed.  What it does is checking for dependencies of variables used in array shapes
# If a var is not found in the include file $inc_f, we go through all include files.
# If we find a match, this include file is added to Deps of $inc_f
sub __resolve_module_deps {
    ( my $stref, my $inc_f, my $line) = @_;
        if ( $line =~/dimension\((.+?)\)/) { # WV: FIXME! BOO!
            my $varlst= $1;
            my @vars = split(/[:,\+\-]/,$varlst);
            for my $var ( @vars ) {
	           if ( not exists $stref->{'IncludeFiles'}{$inc_f}{'Vars'}{$var} ) {
                    for my $inc ( keys %{ $stref->{'IncludeFiles'} } ) {
#                    	say $inc;
#                    	say Dumper($stref->{'IncludeFiles'}{$inc});
                        if (exists $stref->{'IncludeFiles'}{$inc}{'InclType'} and $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'Parameter' ) {
                        	if ( exists $stref->{'IncludeFiles'}{$inc}{'Vars'}{$var} ) {
                        		$stref->{'IncludeFiles'}{$inc_f}{'Deps'}{$inc}=1;
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
