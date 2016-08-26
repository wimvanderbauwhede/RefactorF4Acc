package RefactorF4Acc::Refactoring::Modules;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines create_refactored_source splice_additional_lines_cond );

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

@RefactorF4Acc::Refactoring::Modules::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Modules::EXPORT_OK = qw(
    &add_module_decls
);

=pod
This subroutine created the module declarations around the original F77 files
=cut

# -----------------------------------------------------------------------------
sub add_module_decls { (my $stref)=@_;
#    my $no_module=0;    
    my %is_existing_module = ();
    my %existing_module_name = ();
    my $refactored_sources={};      
    # This assumes a source file contains only a single module
	for my $src (keys %{ $stref->{'SourceContains'} } ) {		
		if (exists $stref->{'SourceContains'}{$src}{'Path'}
		and  exists $stref->{'SourceContains'}{$src}{'Path'}{'Ext'} ) {	
		# External, SKIP!
			say "SKIPPING $src";			
		} else {		
		# Get the unit name from the list	    		
		    for my $sub_or_func_or_mod ( @{  $stref->{'SourceContains'}{$src}{'List'}   } ) {
		    	# Get its type
		        my $sub_func_type= $stref->{'SourceContains'}{$src}{'Set'}{$sub_or_func_or_mod};
		        if ($sub_func_type eq 'Modules') {
		        	$is_existing_module{$src}=1;
		        	$existing_module_name{$src} = $sub_or_func_or_mod;
		        }
		        my $Sf = $stref->{$sub_func_type}{$sub_or_func_or_mod};
		        	        
		        for my $called_sub ( keys %{ $Sf->{'CalledSubs'}{'Set'} } ) {	    
		        	next if exists $stref->{'ExternalSubroutines'}{$called_sub}; # Don't descend into external subs   
		            my $cs_src;
		            if (exists $stref->{'Subroutines'}{$called_sub} and exists $stref->{'Subroutines'}{$called_sub}{'Source'}) {
		               	$cs_src=$stref->{'Subroutines'}{$called_sub}{'Source'};
		            } else {
		                croak "PROBLEM: NO $called_sub in $src".Dumper(keys %{$stref->{'Subroutines'}}).$stref->{'Subroutines'}{$called_sub}{'Source'};
		            }
	                next if $cs_src eq $src; # FIXME: ad-hoc!
	                next if $stref->{'SourceFiles'}{$cs_src}{'SourceType'} eq 'Modules';
	                
		            $stref->{'UsedModules'}{$src}{$cs_src}=1;
		        }
		    }	    
		}
	}
	    for my $src (keys %{ $stref->{'SourceContains'} } ) {       	 	
	        my $no_module= $stref->{'Program'} eq $src ? 1 :0;
	        print "INFO: adding module decls to $src\n" if $I;        
	       if ($I) {
	            say '! ','-' x 80;
	            say "! SRC: $src";
	            print "!\tCONTAINS: ";
	            say join(', ',@{ $stref->{'SourceContains'}{$src}{'List'} } );
	       }             
	       if ($is_existing_module{$src}) {
	       	# What we need to do is find $info->{'Contains'} and splice in the subroutines in order there.
	       	# So we create $new_annlines simply by merging the annlines for all subs, then splice.
	       	my $new_annlines=[];
	       	for my $sub (@{ $stref->{'Modules'}{$existing_module_name{$src}}{'Contains'} } ) {
	       		say '=' x 80 if $V;
	       		say 'SUB: '.$sub if $V;
	       		$new_annlines =[ @{$new_annlines}, @{ $stref->{'Subroutines'}{$sub}{'RefactoredCode'}} ];
	       		say '=' x 80 if $V;
	       	}
	       	my $old_annlines = $stref->{'Modules'}{$existing_module_name{$src}}{'AnnLines'};
	       	if (scalar @{$new_annlines}>0) {
	       		
	       		my $merged_annlines = splice_additional_lines_cond( $stref, $existing_module_name{$src}, sub { (my $annline)=@_; (my $line, my $info) = @{$annline};return exists $info->{'Contains'} },$old_annlines, $new_annlines, 0, 0, 1 );
	       		$stref->{'RefactoredCode'}{$src}=$merged_annlines;
	       	} else {
	       		$stref->{'RefactoredCode'}{$src}=$old_annlines;
	       	}
	       } else {
	       	
	       	# This is either a subroutine or the main program
	       	# So I wonder why I have this code when it's a program?
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
	                next if $used_mod_name eq $mod_name; # FIXME: ad-hoc!
	                $used_mod_name="module_$used_mod_name";
	                my $use_mod_line ="      use $used_mod_name";      
	                # NOT OK: must check if the sub is actually used!
	                #my $only_list = join(', ',@{ $stref->{'SourceContains'}{$mod_src}{'List'} } );
	                #$use_mod_line .= ($NO_ONLY ?  '!' : '') .', only : '.$only_list;
	                push @mod_uses, [$use_mod_line,{'Ref'=>1, 'Ann' => [ annotate('', __LINE__) ] } ];
	            }
	            
	            my $mod_contains = ["contains\n",{'Ref'=>1}];
	            my @refactored_source_lines=();
	            # Normally we simply concatenate all lines for every $f in SourceContains
	            # However, if this is a Program that contains subroutines, we need to do this differently
	            # And in principle a source file can contain a combination.
	            # Step 1            
	            if ($no_module) { # This means that $src is a source file with a Program 
	            	# What is the Program?
	            	my $prog_name='PROGRAM_NAME_UNKNOWN';
					for my $f (@{  $stref->{'SourceContains'}{$src}{'List'} }) {            	
		            	if(exists $stref->{'Subroutines'}{$f}{'Program'}
		            	and $stref->{'Subroutines'}{$f}{'Program'}==1
		            	) {
		            		$prog_name=$f;
		            		last;
		            	}
		            }
		             my $annlines = get_annotated_sourcelines( $stref, $prog_name );
		            	my $before=1;
	            	my @prog_p1=();
	            	my @prog_p2=();
	            	my @contained_subs=();
	            	for my $annline (@{$annlines}) {            		
	            		my $info = $annline->[1];
	            		if ($before) {
	            			push @prog_p1, $annline;
	            		} else {
	            			push @prog_p2, $annline;
	            		}
	            		if (exists $info->{'Contains'} ) {            			
	            				$before=0;
	            		}
	            	}
	            	for my $sub (@{$stref->{'Subroutines'}{$prog_name}{'Contains'}}) {
	            		my $annlines = get_annotated_sourcelines( $stref, $sub );
	            		@contained_subs=(@contained_subs,$BLANK_LINE, comment("CONTAINED SUB $sub"),$BLANK_LINE,@{$annlines},$BLANK_LINE);
	            	}  	            
		            @refactored_source_lines=(  @prog_p1,@contained_subs,@prog_p2 );
	
					# If there are subs or functions that are not contained in the program, tag them on after the program
					for my $sub ( @{ $stref->{'SourceContains'}{$src}{'List'} } ) {
	
						if ( not exists $stref->{'Subroutines'}{$sub}{'Program'}
		            		or $stref->{'Subroutines'}{$sub}{'Program'}==0
		            	 ) {						
	#						say "PROC $sub";
							my $annlines = get_annotated_sourcelines( $stref, $sub );
							if (not exists $refactored_sources->{$sub} ){           
							 $annlines = create_refactored_source( $stref,$sub,$annlines );
							 $refactored_sources->{$sub}=1;
							}
							@refactored_source_lines=(@refactored_source_lines,@{$annlines});
						}					
					}            	
	            } else {            	
	            	# It's a module. We just get the refactored sources here, do the rest in the next step 
		            for my $f (@{  $stref->{'SourceContains'}{$src}{'List'} }) {            	
	#	            	croak if $f=~/^\s*$/;
					my $annlines = get_annotated_sourcelines( $stref, $f );
					if (not exists $refactored_sources->{$f} ){            	# This is a HACK because we need to make sure this is caught higher up	                	                
		                $annlines = create_refactored_source( $stref,$f,$annlines );
		                $refactored_sources->{$f}=1;
					}
		                @refactored_source_lines=(@refactored_source_lines,@{$annlines})
		            }
	            }
	            # Step 2
	            if (!$no_module) {
	                $stref->{'RefactoredCode'}{$src}=[$mod_header, @mod_uses,$mod_contains, @refactored_source_lines,$mod_footer];
	            } else { 
	            	
	            	# In case it is a program
	            	# We add the 'use' declarations after the program signature             	            	 
	            	my $before=1;
	            	my @prog_p1=();
	            	my @prog_p2=();
	
	            	for my $annline (@refactored_source_lines) {
	            		
	            		my $info = $annline->[1];
	            		if ($before) {
	            			push @prog_p1, $annline;
	            		} else {
	            			push @prog_p2, $annline;
	            		}
	            		if (exists $info->{'Signature'} and exists $info->{'Signature'}{'Program'}) {
	            			
	            			my $progname = $info->{'Signature'}{'Name'};            			
	            			if ( exists $stref->{'Subroutines'}{$progname}{'Program'}
	            			and $stref->{'Subroutines'}{$progname}{'Program'}==1
	            			) {	
	            				$before=0;
	            			}            		
	            		}
	            	}            	
	            	$stref->{'RefactoredCode'}{$src}=[@prog_p1,@mod_uses,@prog_p2];
	            }     
	       }   
	    } # loop over all source files
#	}
    return $stref;
} # END of add_module_decls()
1;