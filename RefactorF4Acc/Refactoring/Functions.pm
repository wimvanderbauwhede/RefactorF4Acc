package RefactorF4Acc::Refactoring::Functions;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( context_free_refactorings stateful_pass );

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

@RefactorF4Acc::Refactoring::Functions::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Functions::EXPORT_OK = qw(
    &refactor_called_functions
    &remove_vars_masking_functions
);

=pod
Functions
    remove_vars_masking_functions()
    refactor_called_functions()
    _refactor_function()
=cut


sub remove_vars_masking_functions { ( my $stref ) = @_;
	
    my $pass_actions = sub {
        (my $annline,  my $state) = @_;
        (my $stref, my $f) =@{$state};
        (my $line, my $info) = @{$annline};
        if (exists $info->{'VarDecl'}) {
            my $var = $info->{'VarDecl'}{'Name'};
            if (exists $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$var}) {
                say "INFO: VAR $var is masking a function/sub in $f, LINE: $line" if $I;
                my $Sf = $stref->{'Subroutines'}{$f};                                
				my $src = $Sf->{'Source'};
#				croak 'FIXME!'.$src;  
				if (exists $stref->{'Subroutines'}{$var}{'Source'}) { # otherwise $var must be external
	           		my $cs_src = $stref->{'Subroutines'}{$var}{'Source'};
	           		# We comment the line out unless it's a program 
                 	if (
                 		($cs_src eq $src) and                  		
                 		(
                 		(exists $stref->{'Subroutines'}{$var}{'Program'} and $stref->{'Subroutines'}{$var}{'Program'}==1)
                 		or ($stref->{'Program'} eq $src)
                 		)
#	                	or ($stref->{'SourceFiles'}{$cs_src}{'SourceType'} eq 'Modules')
    	        	) {
    	        		$line.= '! decl of func/sub in program';
    	        	} else {
						delete $Sf->{'Vars'}{$var};
    	        	    delete $Sf->{'OrigArgs'}{$var};
        	        	delete $Sf->{'RefactoredArgs'}{$var};
            	    	$info->{'Deleted'}=1;
            		 	$line = '! '.$line. "$cs_src <> $src;".$stref->{'Subroutines'}{$var}{'Program'}.';'.$stref->{'Program'};
         	   		}                
				} else {
					# $var is an external subroutine, for now just mark it
					$line = '! '.$line. '! EXTERNAL SUB';
				}     
               
                push @{$info->{'Ann'}}, annotate($f, __LINE__  );             
                return ([ [$line, $info] ], [$stref, $f]);
            }
        }
        return ([$annline], $state)        
    };
    
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {   
    	     
        next unless (defined $f and $f ne '');
        next if exists $stref->{'Entries'}{$f};
        next if exists $stref->{'ExternalSubroutines'}{$f};
        next if exists $stref->{'Modules'}{$f}; # HACK! FIXME!
        my $state = [$stref,$f];
        ($stref, $state) = stateful_pass($stref,$f, $pass_actions, $state, '');
    }
    return $stref;    
}
# -----------------------------------------------------------------------------
# The test for called functions is the status:
# if the function was not parsed, it's not used, because we parse via recursive descent
sub refactor_called_functions {
    ( my $stref ) = @_;

    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
    	next if exists $stref->{'Entries'}{$f};
        if (exists $stref->{'Subroutines'}{$f}{'Function'}) {
        	my $Ff = $stref->{'Subroutines'}{$f};
        	if ( defined $Ff->{'Called'} ) { # FIXME: This test is weak because the caller might not be called itself!
        		if ($Ff->{'Status'} == $READ) { 
        		warn "refactor_called_functions(): Function $f was never parsed";
        		} else {        
            		$stref = _refactor_function( $f, $stref );
        		}
        	}
        } 
    }
    return $stref;
}    # END of refactor_called_functions()

# -----------------------------------------------------------------------------
sub _refactor_function {
    ( my $f, my $stref ) = @_;
    if ($V) {
        print "\n\n";
        print "#" x 80, "\n";
        print "Refactoring $f\n";
        print "#" x 80, "\n";
    }
    my $Ff = $stref->{'Subroutines'}{$f};
    print "CONTEXT-FREE REFACTORING FUNCTION $f\n" if $V;    
	
    if (   not exists $Ff->{'RefactoredCode'}
        or $Ff->{'RefactoredCode'} == []
#        or exists $stref->{'BuildSources'}{'C'}{ $Ff->{'Source'} } 
        ) {
        $stref = context_free_refactorings( $stref, $f );
    }

    return $stref;

}    # END of _refactor_function()
# -----------------------------------------------------------------------------
