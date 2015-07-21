# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Refactoring;
use v5.016;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( 
    create_refactored_source 
    get_annotated_sourcelines 
    format_f95_var_decl 
    format_f95_par_decl 
    emit_f95_var_decl
    splice_additional_lines
    );
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

# All routines in refactoring work on AnnLines, but these are $Sf->{'RefactoredCode'} rather than $Sf->{'AnnLines'}
# There is no particular reason to keep AnnLines as-is, but just go with this for now.

# WV20150303: I think the note below is obsolete: we actually use a datastructure for the declarations! 
# The problem is that we collect the IODir information _after_ we do the refactoring
# As a result the refactored lines are already created. 
# A cheap solution would be to put an INTENT placeholder in each argument line
# then use substitution. Will work but ugly. Also, it means I need to know if a var is an arg
# A cleaner way would be to create a datastructure for the declaration line and only to generate the actual line at the very end
# In fact, that is of course the cleanest way for *everything*!

sub refactor_all {
	( my $stref, my $subname ) = @_;
        
    $stref = refactor_include_files($stref);
    $stref = refactor_called_functions($stref);
    
    # Refactor the source, but don't split long lines and keep annotations
    $stref = refactor_all_subroutines($stref);    
    # This can't go into refactor_all_subroutines() because it is recursive
    # This is where somehow the parameters get added to RefactoredArgs, but in the wrong way.
    $stref = determine_argument_io_direction_rec( $subname, $stref );
    
    print "DONE determine_argument_io_direction_rec()\n" if $V;
# So at this point we know everything there is to know about the argument declarations, we can now update them
=info
BUT WE MUST ADD THEM IF THEY ARE NOT PRESENT YET!
So we must get the  
=cut
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        next unless (defined $f and $f ne '');
        my $undeclared_vars=[];
#     print "NAME: <$f>\n";
        my %refactored_args =  %{ $stref->{'Subroutines'}{$f}{RefactoredArgs}{Set} };
    	if (scalar keys %{$stref->{'Subroutines'}{$f}{'Callers'} } ) { # or $stref->{'Subroutines'}{$f}{'Program'} )     		
            # so what I need to do is create the line with intent and replace it in RefactoredCode
            for my $entry (@{ $stref->{'Subroutines'}{$f}{RefactoredCode} } ) {
                if (not exists $entry->[1]{'Deleted'} and not exists $entry->[1]{'Comments'}) { 
              if (exists($entry->[1]{'VarDecl'})) {
                my $varname = $entry->[1]{'VarDecl'}[2][0];
                my $vardecl = format_f95_var_decl($stref->{'Subroutines'}{$f}, $varname);
                $entry->[0] = emit_f95_var_decl($vardecl);
                delete $refactored_args{$varname};
#                say "DELETED $varname from RefactoredArgs in $f";
              } elsif (exists($entry->[1]{'ParamDecl'})) {                
                my $parname = $entry->[1]{'ParamDecl'}[2][0][0];
                my $pardecl = format_f95_par_decl($stref,$f, $parname);
                $entry->[0] = emit_f95_var_decl($pardecl); # FIXME: Somehow this is emitted TWICE, I guess because it re-emits the commmented line?
                delete $refactored_args{$parname};
#                say "DELETED PARAMETER $parname from RefactoredArgs in $f";
              } elsif ($entry->[0] =~/::/) {
                  say "VAR DECL NOT MARKED PROPERLY: ".$entry->[0]. ' => '.Dumper($entry->[1]);
              }
            } else {
#                say 'SKIPPED: '.$entry->[0];
            }
            }
            for my $maybe_var (keys %refactored_args ) {
               if ($maybe_var  =~/::/) {
                  say "PARAM DECL! ".$maybe_var
              } else {
                  push @{$undeclared_vars}, $maybe_var; 
              }
            }
              
            if ($V) {                        
            if (keys %refactored_args) {
                say "REMAINING in RefactoredArgs in $f:";
                map {say} (keys %refactored_args);
                say '';
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
        # At this point we have identified the missing variable declarations, now we should add them in.
        # So we need to find the last var decl and add them after that, I guess.
        # For all these remaining variables we need to type them via implicits
        $stref=add_missing_var_decls($stref,$f,$undeclared_vars);
#        die  if $f=~/press/;
#        die Dumper($stref->{'Subroutines'}{$f}{'RefactoredCode'}) if $f=~/press/;
    }
#    die 'refactor_all()';
#say 'add_module_decls()';
    $stref=add_module_decls($stref);
#    show_annlines($stref->{'RefactoredCode'}{'./press.f'},0);
#    die ;
    return $stref;	
} # END of refactor_all()  

## FIXME: this should go in Refactoring::Modules
## RefactorF4Acc::Refactoring::Modules
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
#	        die "$src => $sub_or_func".Dumper($Sf->{AnnLines}) if $src =~ /LES/;
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

# We can assume that these variables are not subroutine arguments, so the Intent should be blank
# This should probably go in RefactorF4Acc::Refactoring::Subroutines::Declarations
sub add_missing_var_decls { (my $stref,my $f,my $undeclared_vars)=@_;
    my $extra_annlines=[];
    for my $var (@{$undeclared_vars}) {
           
        say "\tADDING MISSING VAR DECL for <$var> " if $V;# T:$type, K:$kind, S:@{$shape}, A:$attr";
#        my $code_unit = sub_func_incl_mod($f,$stref);
#        my $Sf = $stref->{$code_unit}{$f};
        
        my $vd = format_f95_var_decl($stref,$f,$var);
        my $info = {'VarDecl'=>$vd}; # TODO: need some extra $info here
        my $line = emit_f95_var_decl($vd).' ! missing';
        my $annline = [ $line, $info];
        push @{$extra_annlines}, $annline;
    }
    # So here we spice these into the original code.
    # First find where to splice. As far as I can see we can splice anywhere inside the existing var decls.
    my $annlines = get_annotated_sourcelines( $stref, $f );  
    my $insert_pos_lineID = 0;
    for my $annline (@{$annlines}) {
        (my $line, my $info) = @{$annline};
#        say $line."\t".Dumper($info);
       if (exists $info->{'VarDecl'}) {
           $insert_pos_lineID = $info->{'LineID'};
#           say "VAR DECL LINE ID: $insert_pos_lineID";
           last;
       } 
    }
    $stref = splice_additional_lines($stref,$f,$insert_pos_lineID, $extra_annlines, 1, 0);
    return $stref;
} # END of add_missing_var_decls() 
1;