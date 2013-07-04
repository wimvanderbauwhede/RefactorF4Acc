# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Refactoring;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( create_refactored_source get_annotated_sourcelines );
use RefactorF4Acc::Refactoring::Subroutines qw( refactor_all_subroutines refactor_kernel_signatures );
use RefactorF4Acc::Refactoring::Functions qw( refactor_called_functions );
use RefactorF4Acc::Refactoring::IncludeFiles qw( refactor_includes );
use RefactorF4Acc::Analysis::ArgumentIODirs qw( determine_argument_io_direction_rec );

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
$Carp::Verbose = 1;
use Data::Dumper;

use Exporter;
@RefactorF4Acc::Refactoring::ISA = qw(Exporter);
@RefactorF4Acc::Refactoring::EXPORT_OK = qw(
    &refactor_all
);

# -----------------------------------------------------------------------------

# The problem is that we collect the IODir information _after_ we do the refactoring
# As a result the refactored lines are already created. 
# A cheap solution would be to put an INTENT placeholder in each argument line
# then use substitution. Will work but ugly. Also, it means I need to know if a var is an arg
# A cleaner way would be to create a datastructure for the declaration line and only to generate the actual line at the very end
# In fact, that is of course the cleanest way for *everything*!

sub refactor_all {
	( my $stref, my $subname ) = @_;
        
    $stref = refactor_includes($stref);
    $stref = refactor_called_functions($stref);
    # Refactor the source, but don't split long lines and keep annotations
    $stref = refactor_all_subroutines($stref);
# OK here for les.f

#map {print $_->[0]."\n"} @{ $stref->{'Subroutines'}{'les'}{RefactoredCode} };
#   die;
    # This can't go into refactor_all_subroutines() because it is recursive
    $stref = determine_argument_io_direction_rec( $subname, $stref );
# Now somehow we should use the IO direction, at first simply as annotation
#FIXME: This does not work! refactor_all_subroutines produces the refactored source!!!
#    print "DONE determine_argument_io_direction_rec()\n" if $V;    
#    map {print $_->[0]."\n"} @{ $stref->{'Subroutines'}{'les'}{RefactoredCode} };
#    print '=' x 80, "\n";
#    die;
# OK here for les.f


#    croak();
    # What I need to do here is use the IODir information
    # Initially this is just adding some comments to the refactored source;
    # Later it means rewriting the kernel signatures
    # Basically need this for every factored-out kernel candidate
    # But it doesn't hurt to annotate every subroutine of course 
#    $stref = refactor_kernel_signatures( $stref, $subname); # It would be better if I could do this in determine_argument_io_direction_rec() 
#    $stref = create_all_refactored_subroutine_sources($stref);

    # When all this is done, we can finally create the refactored sources for the subroutines
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
    	if (scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} } or $stref->{'Subroutines'}{$f}{'Program'} ) {    		
    		$stref = refactor_kernel_signatures( $stref, $f); # FIXME: rename this!
    		#FIXME: for Functions and Includes, this has already been done
    		# This should be done as the final step!
#            $stref=create_refactored_source(  $stref, $f );
    	} else {
    		print "WARNING: SKIPPING <$f>: " if $V;
			if (defined $f and $f ne '') {
				print 'Callers: ',scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} },'; Program: ',$stref->{'Subroutines'}{$f}{'Program'},"\n" if $V;
			} else {
				print "Undefined\n" if $V;
			}
    	}
    	# WRONG HERE!!!! for les.f
#    	if ($f eq 'les') {
#map {print $_->[0]."\n"} @{ $stref->{'Subroutines'}{$f}{RefactoredCode} };
#
#print '1=' x 80, "\n";
#   die ;
#    	}

   $stref=add_module_decls($stref);
#   print '=' x 80, "\n"; 	
#map {print $_->[0]."\n"} @{ $stref->{'Subroutines'}{'les'}{RefactoredCode} };
#   die;
# OK here for les.f RefactoredSources as well as RefactoredCode
#  if ( $f eq 'timemanager' ) {
#       print "REFACTORED LINES ($f):\n";
#        my $Sf = $stref->{'Subroutines'}{$f};
#       for my $tmpline ( @{ $Sf->{'RefactoredCode'} } ) {
#           print $tmpline->[0], "\n";#"\t", join( ';', keys %{ $tmpline->[1] } ),"\n";
#       }
#       print "=================\n";
#       die;
#   }

#if ($f eq 'les') {
#       print '=' x 80, "\n";
#map {print $_->[0]."\n"} @{ $stref->{RefactoredSources}{'./les.f'} };
#die;
#}
    }
#    # WRONG HERE!
#       print '=' x 80, "\n";
#map {print $_->[0]."\n"} @{ $stref->{RefactoredSources}{'./les.f'} };
#print '=' x 80, "\n";
#print " END OF REFACTOR_ALL\n";
#print '=' x 80, "\n";
    
    return $stref;	
} # END of refactor_all()  

## FIXME: this should go in Refactoring::Modules

sub add_module_decls {
    (my $stref)=@_;
    
    for my $src (keys %{ $stref->{'SourceContains'} } ) {
        
        print "INFO: adding module decls to $src\n" if $V;
        
       if ($I) {
            print '! ','-' x 80,"\n";
            print "! SRC: $src\n";
            print "!\tCONTAINS: ";
            print join(', ',keys %{  $stref->{'SourceContains'}{$src}   } ),"\n";
       }
             
            my $mod_name=$src;
            $mod_name=~s/\.\///;
            $mod_name=~s/\..*$//;
            $mod_name=~s/\./_/g;
            $mod_name="module_$mod_name";
            my $mod_header=["module $mod_name\n",{'Ref'=>1}];
            my $mod_footer=["\nend module $mod_name\n",{'Ref'=>1}];
            my @mod_uses=();
            for my $mod_src (keys %{ $stref->{'UsedModules'}{$src} }) {
                my $used_mod_name = $mod_src;
                $used_mod_name =~s/\.\///;
                $used_mod_name =~s/\..*$//;
                $used_mod_name=~s/\./_/g;
                $used_mod_name="module_$used_mod_name";
                push @mod_uses, ["use $used_mod_name\n",{'Ref'=>1}];
            }
            my $mod_contains = ["contains\n",{'Ref'=>1}];
            my @refactored_source_lines=();
            for my $f (keys %{  $stref->{'SourceContains'}{$src} }) {
            	die if $f=~/^\s*$/;
            	
                my $annlines = get_annotated_sourcelines( $stref, $f );
                my $refacored_lines = create_refactored_source( $stref,$annlines );
#                my @ref_lines = map { $_->[0] } @{$annlines};
                @refactored_source_lines=(@refactored_source_lines,@{$refacored_lines})
            }
            $stref->{'RefactoredSources'}{$src}=[$mod_header, @mod_uses,$mod_contains, @refactored_source_lines,$mod_footer];
    } # loop over all source files

    return $stref;

} # END of add_module_decls()
