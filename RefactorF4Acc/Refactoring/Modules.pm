package RefactorF4Acc::Refactoring::Modules;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( get_annotated_sourcelines create_refactored_source );

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
    my $no_module=0;    
	for my $src (keys %{ $stref->{'SourceContains'} } ) {	    
	    for my $sub_or_func (keys %{  $stref->{'SourceContains'}{$src}   } ) {
	        my $sub_func_type= $stref->{'SourceContains'}{$src}{$sub_or_func};
	        my $Sf = $stref->{$sub_func_type}{$sub_or_func};	        
	        for my $called_sub ( keys %{ $Sf->{'CalledSubs'}{'Set'} } ) {	    
	            my $cs_src;
	            if (exists $stref->{'Subroutines'}{$called_sub} and exists $stref->{'Subroutines'}{$called_sub}{'Source'}) {
	               $cs_src=$stref->{'Subroutines'}{$called_sub}{'Source'};
	            } else {
	                die "PROBLEM: NO $called_sub in $src";
	            }
                next if $cs_src eq $src; # FIXME: ad-hoc!
	            $stref->{'UsedModules'}{$src}{$cs_src}=1;
	        }
	    }	    
	}
	
    for my $src (keys %{ $stref->{'SourceContains'} } ) {    	
        $no_module= $stref->{'Program'} eq $src;
        print "INFO: adding module decls to $src\n" if $I;        
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
                next if $used_mod_name eq $mod_name; # FIXME: ad-hoc!
                $used_mod_name="module_$used_mod_name";
                my $use_mod_line ="      use $used_mod_name";                 
                push @mod_uses, [$use_mod_line,{'Ref'=>1, 'Ann' => [ annotate('', __LINE__) ] } ];
            }
            
            my $mod_contains = ["contains\n",{'Ref'=>1}];
            my @refactored_source_lines=();
            # Normally we simply concatenate all lines for every $f in SourceContains
            # However, if this is a Program that contains subroutines, we need to do this differently
            # And in principle a source file can contain a combination.
            if ($no_module) { # This means that $src is a source file with a Program 
            	# What is the Program?
#            	say "PROGRAM:".Dumper($stref->{'Program'});
#            	say "PROGRAM CONTAINS:".Dumper($stref->{'SourceContains'}{$stref->{'Program'}});
            	my $prog_name='PROGRAM_NAME_UNKNOWN';
				for my $f (keys %{  $stref->{'SourceContains'}{$src} }) {            	
	            	if(exists $stref->{'Subroutines'}{$f}{'Program'}
	            	and $stref->{'Subroutines'}{$f}{'Program'}==1
	            	) {
	            		$prog_name=$f;
	            		last;
	            	}
	            }
#	            say $prog_name;
#	            say Dumper($stref->{'Subroutines'}{$prog_name}{'Program'});
	             my $annlines = get_annotated_sourcelines( $stref, $prog_name );
#	             say Dumper($annlines);
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
#            		say "SUB: $sub";
            		my $annlines = get_annotated_sourcelines( $stref, $sub );
            		@contained_subs=(@contained_subs,$BLANK_LINE, comment("CONTAINED SUB $sub"),$BLANK_LINE,@{$annlines},$BLANK_LINE);
            	}  	            
#	            $stref->{'RefactoredCode'}{$src}=[@prog_p1,@contained_subs,@prog_p2];
	            @refactored_source_lines=(  @prog_p1,@contained_subs,@prog_p2 );
#	            show_annlines($stref->{'RefactoredCode'}{$src},0);
            	
            } else {
	            for my $f (keys %{  $stref->{'SourceContains'}{$src} }) {            	
	            	die if $f=~/^\s*$/;            	
	                my $annlines = get_annotated_sourcelines( $stref, $f );
	                
	                my $refactored_lines = create_refactored_source( $stref,$annlines );
	                @refactored_source_lines=(@refactored_source_lines,@{$refactored_lines})
	            }
            }
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
#            		if (exists $info->{Signature}
#            		and exists $info->{Signature}{Name} ) {
#            		 $prog_name = $info->{Signature}{Name};
#            		}
#say $annline->[0];
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
#            	die;  
#            	show_annlines($stref->{'RefactoredCode'}{$src},0);die;	 	
            }        
            
    } # loop over all source files

    return $stref;
} # END of add_module_decls()
1;