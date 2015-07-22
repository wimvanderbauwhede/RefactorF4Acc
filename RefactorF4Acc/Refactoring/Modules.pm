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
## FIXME: this should go in Refactoring::Modules
## RefactorF4Acc::Refactoring::Modules
sub add_module_decls {
#	print "\n\nadd_module_decls()\n\n";
    (my $stref)=@_;
    my $no_module=0;
    
	for my $src (keys %{ $stref->{'SourceContains'} } ) {
	    for my $sub_or_func (keys %{  $stref->{'SourceContains'}{$src}   } ) {
	        
	        my $sub_func_type= $stref->{'SourceContains'}{$src}{$sub_or_func};
	        my $Sf = $stref->{$sub_func_type}{$sub_or_func};
#	        die "$src => $sub_or_func".Dumper($Sf->{AnnLines}) if $src =~ /LES/;
	        my $called_sub_or_func = (exists $stref->{'Subroutines'}{$sub_or_func}{'Function'}) ? 'CalledFunctions' : 'CalledSubs' ;
	        for my $called_sub ( keys %{ $Sf->{$called_sub_or_func} } ) {
	            my $cs_src;
	            if (exists $stref->{'Subroutines'}{$called_sub} and exists $stref->{'Subroutines'}{$called_sub}{'Source'}) {
	               $cs_src=$stref->{'Subroutines'}{$called_sub}{'Source'};
	            } else {
	                die "PROBLEM: NO $called_sub in $src";
	            }
	                    
	            $stref->{'UsedModules'}{$src}{$cs_src}=1;
	        }
	    }
	}
    for my $src (keys %{ $stref->{'SourceContains'} } ) {
        $no_module= $stref->{'Program'} eq $src;
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
                my $use_mod_line ="      use $used_mod_name"; $use_mod_line.= " ! add_module_decls() line 214" if $V;
                push @mod_uses, [$use_mod_line,{'Ref'=>1}];
            }
            
            my $mod_contains = ["contains\n",{'Ref'=>1}];
            my @refactored_source_lines=();
            for my $f (keys %{  $stref->{'SourceContains'}{$src} }) {            	
            	die if $f=~/^\s*$/;            	
                my $annlines = get_annotated_sourcelines( $stref, $f );
                my $refactored_lines = create_refactored_source( $stref,$annlines );
                @refactored_source_lines=(@refactored_source_lines,@{$refactored_lines})
            }
            if (!$no_module) {
                $stref->{'RefactoredCode'}{$src}=[$mod_header, @mod_uses,$mod_contains, @refactored_source_lines,$mod_footer];
            } else {
            	my $before=1;
            	my @prog_p1=();
            	my @prog_p2=();

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
            			my $progname = $info->{'SubroutineSig'}[1];
            			
            		if ( exists $stref->{'Subroutines'}{$progname}{'Program'}) {	
            			$before=0;
            		}
            		
            		}
            	}            	
            	$stref->{'RefactoredCode'}{$src}=[@prog_p1,@mod_uses,@prog_p2];            	
            }        
    } # loop over all source files

    return $stref;
} # END of add_module_decls()
1;