# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Refactoring;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( create_refactored_source get_annotated_sourcelines format_f95_var_decl);
use RefactorF4Acc::Refactoring::Subroutines qw( refactor_all_subroutines refactor_kernel_signatures );
use RefactorF4Acc::Refactoring::Functions qw( refactor_called_functions );
use RefactorF4Acc::Refactoring::IncludeFiles qw( refactor_include_files );
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
        
    $stref = refactor_include_files($stref);
#    die;
    $stref = refactor_called_functions($stref);
    
    # Refactor the source, but don't split long lines and keep annotations
    $stref = refactor_all_subroutines($stref);
# OK here for les.f
#print "\n\n",'=' x 80,"\n";
#print "*** determine_argument_io_direction_rec( $subname, $stref )\n";
#print "*** LES\n",'=' x 80, "\n";
#print Dumper($stref->{'Subroutines'}{'les'}),"\n"; 
#print "\n\n",'=' x 80,"\n*** LES\n",'=' x 80, "\n";
## This prints out the code lines, not yet refactored?
#map {print $_->[0]."\n"} @{ $stref->{'Subroutines'}{'les'}{RefactoredCode} };
#   die;
    # This can't go into refactor_all_subroutines() because it is recursive
    $stref = determine_argument_io_direction_rec( $subname, $stref );
# Now somehow we should use the IO direction, at first simply as annotation
#FIXME: This does not work! refactor_all_subroutines produces the refactored source!!!
    print "DONE determine_argument_io_direction_rec()\n" if $V;
#print "\n\n",'=' x 80,"\n";        
#    map {
#     if (exists($_->[1]{VarDecl})) {
#      my $varname = $_->[1]{VarDecl};
##        my $iodir = $stref->{'Subroutines'}{'les'}{RefactoredArgs}{Set}{$varname}{IODir};
##        print " ! intent($iodir)\n";
#        my $vardecl = format_f95_var_decl($stref->{'Subroutines'}{'les'}, $varname);
#        print "    $vardecl \n";
#     } else {
#     print $_->[0];     
#     print "\n";
#     }
#    } @{ $stref->{'Subroutines'}{'les'}{RefactoredCode} };
#    print '=' x 80, "\n";
#
#print Dumper($stref->{'Subroutines'}{'vel2'}),"\n"; 
#print "\n\n",'=' x 80,"\n\n";
#    
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
     print "NAME: $f\n";
    	if (scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} } ) { # or $stref->{'Subroutines'}{$f}{'Program'} ) {    		
#    		$stref = add_intent_to_subroutine_signature( $stref, $f); # FIXME: rename this!
            # so what I need to do is create the line with intent and replace it in RefactoredCode
            for my $entry (@{ $stref->{'Subroutines'}{$f}{RefactoredCode} } ) {
              if (exists($entry->[1]{VarDecl})) {
                my $varname = $entry->[1]{VarDecl};
                my $vardecl = format_f95_var_decl($stref->{'Subroutines'}{$f}, $varname);
                $entry->[0] = $vardecl;
              }
            }                        
    	} else {
    		print "WARNING: SKIPPING <$f>: " if $V;
			if (defined $f and $f ne '') {
				print 'Callers: ',scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} },'; Program: ',$stref->{'Subroutines'}{$f}{'Program'},"\n" if $V;
			} else {
				print "Undefined\n" if $V;
			}
    	}
#    	# WRONG HERE!!!! for les.f
#    	if ($f eq 'vel2') {
#map {print $_->[0]."\n"} @{ $stref->{'Subroutines'}{$f}{RefactoredCode} };
#
#print '1=' x 80, "\n";
#   die ;
#    	}
    
   
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
##map {print $_->[0]."\n"} @{ $stref->{RefactoredSources}{'./les.f'} };
#print Dumper($stref->{RefactoredSources});
#die;
#}
    }
#    die "HERE";
    $stref=add_module_decls($stref);
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
#	print "\n\nadd_module_decls()\n\n";
    (my $stref)=@_;
    my $no_module=0;
    
	for my $src (keys %{ $stref->{'SourceContains'} } ) {
	    for my $sub_or_func (keys %{  $stref->{'SourceContains'}{$src}   } ) {
	# Find all function/subroutine calls in this function/subroutine
	# I'm afraid at the moment I only have CalledSubs, so function calls might not be there, need to check!
	# Also, need to check if SourceContains distinguishes between subroutines and functions
	# FIXME!!!
	        my $sub_func_type= $stref->{'SourceContains'}{$src}{$sub_or_func};
	        my $Sf = $stref->{$sub_func_type}{$sub_or_func};
	        my $called_sub_or_func = 'Called'. (($sub_func_type eq 'Subroutines') ? 'Subs' : 'Functions');
	        for my $called_sub ( keys %{ $Sf->{$called_sub_or_func} } ) {
	            my $cs_src;
	            if (exists $stref->{'Subroutines'}{$called_sub} and exists $stref->{'Subroutines'}{$called_sub}{'Source'}) {
	               $cs_src=$stref->{'Subroutines'}{$called_sub}{'Source'};
	            } else {
	            	$cs_src=$stref->{'Functions'}{$called_sub}{'Source'};  
	            }
	                    
	            $stref->{'UsedModules'}{$src}{$cs_src}=1;
	        }
	    }
	}
#    die Dumper($stref->{'Program'});
    for my $src (keys %{ $stref->{'SourceContains'} } ) {
#    	print "SRC: $src\n";
        $no_module= $stref->{'Program'} eq $src;
#        print "$src: $no_module\n";
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
#            	print "USES: $src => $mod_src\n";
                my $used_mod_name = $mod_src;
                $used_mod_name =~s/\.\///;
                $used_mod_name =~s/\..*$//;
                $used_mod_name=~s/\./_/g;
                $used_mod_name="module_$used_mod_name";
                my $use_mod_line ="      use $used_mod_name"; $use_mod_line.= " ! add_module_decls() line 214" if $V;
                push @mod_uses, [$use_mod_line,{'Ref'=>1}];
            }
            
            my $mod_contains = ["contains\n",{'Ref'=>1}];
            my @refactored_source_lines=();
            for my $f (keys %{  $stref->{'SourceContains'}{$src} }) {
            	
            	die if $f=~/^\s*$/;
            	
                my $annlines = get_annotated_sourcelines( $stref, $f );
                my $refactored_lines = create_refactored_source( $stref,$annlines );
#                my @ref_lines = map { $_->[0] } @{$annlines};
                @refactored_source_lines=(@refactored_source_lines,@{$refactored_lines})
            }
            if (!$no_module) {
                $stref->{'RefactoredSources'}{$src}=[$mod_header, @mod_uses,$mod_contains, @refactored_source_lines,$mod_footer];
            } else {
            	# Not good. What we must do is find the line with Program and splice the @mod_uses after it.
            	
            	my $before=1;
            	my @prog_p1=();
            	my @prog_p2=();
#            	my $prog_name='';
            	for my $annline (@refactored_source_lines) {
            		my $info = $annline->[1];
#            		if (exists $info->{Signature}
#            		and exists $info->{Signature}{Name} ) {
#            		 $prog_name = $info->{Signature}{Name};
#            		}
            		if ($before) {
            			push @prog_p1, $annline;
            		} else {
            			push @prog_p2, $annline;
            		}
            		if (exists $info->{'SubroutineSig'}) {
            			my $progname = $info->{'SubroutineSig'};
            			
            		if ( exists $stref->{'Subroutines'}{$progname}{'Program'}) {	
            			$before=0;
            		}
            		
            		}
            	}
            	
#            	my $done_fix_end=0;
#            	while (!$done_fix_end) {
#            	  my $line =pop @prog_p2;
#            	  next if ( $line->[0]=~/^\s*$/);
##            	  print $line->[0],"\n";
##            	  print Dumper($line->[1]),"\n";
#            	  if ($line->[0]=~/^\s*end\s*$/) {
#            	   $line->[0]=~s/\s+$//;
#            	   push @prog_p2,[ $line->[0]." program $prog_name",{'Ref' => 0}];
#            	  $done_fix_end=1;
#            	  }
#            	}
            	$stref->{'RefactoredSources'}{$src}=[@prog_p1,@mod_uses,@prog_p2];
            	
            }
        
    } # loop over all source files
#die Dumper($stref->{'RefactoredSources'}{'./main.f'});
    return $stref;

} # END of add_module_decls()
