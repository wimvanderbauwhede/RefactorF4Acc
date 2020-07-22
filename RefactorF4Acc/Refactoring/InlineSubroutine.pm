package RefactorF4Acc::Refactoring::InlineSubroutine;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( stateful_pass pass_wrapper_subs_in_module );
use RefactorF4Acc::Parser qw( analyse_lines );
# 
#   (c) 2010-now Wim Vanderbauwhede <wim.vanderbauwhede@glasgow.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::InlineSubroutine::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::InlineSubroutine::EXPORT_OK = qw(
    &inline_subroutine
    &rename_vars
    &rename_args
    &split_specification_computation_parts    
);


sub inline_subroutine { (my $stref, my $f, my $sub) =@_;

    
        # First rename all variables           
	    
        # Find the call(s) to the subroutine $sub in $f
        # Rename using $info->{'ArgMap'}{$sig_arg}
        $stref = inline_call($stref,$f,$sub);
        my $Sf = $stref->{'Subroutines'}{$f};
        croak Dumper(pp_annlines($Sf->{'RefactoredCode'},0));
        
        
        # Here is where we will add the  $specification_part and $computation_part to the AnnLines of $f
        # Then we will also update the variable declarations in $f
	    
    
    return $stref;
}

sub inline_call { (my $stref, my $f, my $sub) =@_;
	
    
    
    
   $stref = rename_vars($stref,$sub);    
    
    my $pass_rename_args = sub {
            ( my $annline, my $state ) = @_;
            ( my $line,    my $info )  = @{$annline};
            ( my $stref,   my $f , my $sub)     = @{$state};
            my $Sf = $stref->{'Subroutines'}{$f};        

            if ( exists $info->{'SubroutineCall'} and $info->{'SubroutineCall'}{'Name'} eq $sub ) {
            	my $argmap = $info->{'SubroutineCall'}{'ArgMap'};
            	
                $stref = rename_args( $stref,$sub,$argmap);
            } 
            return ( [$annline], [ $stref, $f, $sub ] );
    };

        my $state = [ $stref, $f, $sub];
        ( $stref, $state ) = stateful_pass( $stref, $f, $pass_rename_args, $state, 'pass_rename_args()' . __LINE__ );
        
        
        # Now run the analysis again and check the result
        my $Sf = $stref->{'Subroutines'}{$sub};       

        $stref = analyse_lines( $sub, $stref );
#        say Dumper(pp_annlines($Sf->{'AnnLines'},1));
#        say '========';
#        say Dumper(pp_annlines($Sf->{'RefactoredCode'},1    ));        
#        croak;        
#        croak;
        
        ($stref,my $specification_part,my $computation_part) = split_specification_computation_parts($stref, $sub);

        $stref = merge_specification_computation_parts_into_caller($stref, $f, $sub,$specification_part,$computation_part);  	            
	
    return $stref;
}
=info-inline-subroutine
To inline a subroutine, four steps are required:
0. This is recursive so any call in the subroutine to be inlined must also be inlined. So a first pass is to check CalledSubs, and if this is not empty, to look for subroutine calls and descend until we find one that is empty.
1. Substitute the signature arguments with the call arguments. This info is in $info->{'SubroutineCall'}{'ArgMap'} 
2. Rename the subroutine variables with a unique name. We can use a version of rename_inherited_vars()
3. Split out the specification and computation parts. The computation part replaces the call; the specification needs to be added to the specification part of the caller. I guess we could put if after the first line that is not a SpecificationStatement, Comment or Blank    
=cut

# Not only split, also weed out argument decls and return statements
sub split_specification_computation_parts { (my $stref, my $f) =@_;
	
    if ( exists $stref->{'Subroutines'}{$f} ) {
        my $Sf               = $stref->{'Subroutines'}{$f};
        
    my $pass_split_specification_computation_parts = sub {
            ( my $annline, my $state ) = @_;
            ( my $line,    my $info )  = @{$annline};
            ( my $stref,   my $f , my $specification_part, my $computation_part, my $preceding_comments)     = @{$state};
            my $Sf = $stref->{'Subroutines'}{$f};        

			if ( exists $info->{'Signature'} or exists $info->{'EndSubroutine'} or exists $info->{'ArgDecl'} or exists $info->{'Return'}) {
				# do nothing;
			} elsif ( exists $info->{'Comments'} or exists $info->{'Blank'} ) {
				push @{$preceding_comments}, $annline;
			} elsif ( exists $info->{'SpecificationStatement'} ) {
				$specification_part = [ @{$specification_part}, @{$preceding_comments}, $annline ];
				$preceding_comments = [];
			} else {
				$computation_part = [ @{$computation_part}, @{$preceding_comments}, $annline ];
				$preceding_comments = [];
			}
			return ( [$annline], [ $stref, $f, $specification_part, $computation_part, $preceding_comments ] );
    };

        my $state = [ $stref, $f , [],[],[]];
        ( $stref, $state ) = stateful_pass( $stref, $f, $pass_split_specification_computation_parts, $state, 'pass_split_specification_computation_parts() ' . __LINE__ );
        ( my $stref__,   my $f__ , my $specification_part, my $computation_part, my $preceding_comments__)     = @{$state};        

        return ($stref,$specification_part,$computation_part);
    }
    
    return ($stref,[],[]);
}
=info_merge_specification_computation_parts_into_caller
* The computation part simply replaces the call line, this is very easy.
* The specification part is harder because some specifications must come at the top (implicit, use) 
* For USE I must test against the module name and then merge the Only list

=cut

sub merge_specification_computation_parts_into_caller { (my $stref, my $f, my $sub,my $specification_part,my $computation_part) =@_;
	
    if ( exists $stref->{'Subroutines'}{$f} ) {
        
        
    my $pass_merge_specification_computation_parts_into_caller = sub {
            ( my $annline, my $state ) = @_;
            ( my $line,    my $info )  = @{$annline};
            ( my $stref,   my $f , my $sub, my $specification_part, my $computation_part)     = @{$state};
            my $Sf = $stref->{'Subroutines'}{$f};
            say $f, $line, Dumper(keys %{$info}) if $line=~/use/;        
	        if ( exists $info->{'SubroutineCall'} and $info->{'SubroutineCall'}{'Name'} eq $sub ) {
	        	return ( [comment($annline),comment("BEGIN inlined call to $sub"),@{$computation_part},comment("END inlined call to $sub")], $state );
	        } elsif ( exists $info->{'Use'} ) {
	        	croak Dumper($info);
	        }
            return ( [$annline], $state );
    };

        my $state = [ $stref, $f, $sub, $specification_part, $computation_part];
        ( $stref, $state ) = stateful_pass( $stref, $f, $pass_merge_specification_computation_parts_into_caller, $state, 'pass_merge_specification_computation_parts_into_caller() ' . __LINE__ );      
        
    }
    croak;
    return $stref;
}


# The question is if we need to rename the variables in the $info as well, and I think the answer is 'YES'; and in principle of course also in 'Vars'
# But it is even more complicated in a way: what we need to do is to remove the inlined subroutine from CalledSubs and merge its renamed vars with the existing vars of the caller
# As this is done after refactoring, the vars should all be DeclaredOrigLocalVars. So I should look at LocalVars and LocalParameters of the called subroutine

# Question is: is it better to go through all vars per line or through all lines per var?
# Also, which lines can have vars and what does their $info look like?
# Of course a rather cheap way would be to rename the source before it gets parsed, e.g. in SrcReader. But we need to rename the args anyway so the problem remains.
# Or I could emit the refactored source and parse it but then I have to run all analysis again as well. Although maybe not, because this source should be "complete".
# So basically do the renaming, emit the source and run it through the parser. Or maybe it is enough to only rerun _analyse_lines. OK, let's try that!

sub rename_vars {
	( my $stref, my $f ) = @_;
	
		
		my $Sf               = $stref->{'Subroutines'}{$f};
		
		
		my $rename_vars_pass = sub {
			( my $annline, my $state ) = @_;
			( my $line,    my $info )  = @{$annline};
			( my $stref,   my $f )     = @{$state};
			if (not exists $info->{'Use'} ) {
			my $Sf = $stref->{'Subroutines'}{$f};
			my $vars = get_vars_from_set( $Sf->{'Vars'} );
			for my $var (keys %{$vars} ) {
				my $subset1 = in_nested_set($Sf,'Args', $var);
				my $subset2 = in_nested_set($Sf,'UsedParameters', $var);
				my $subset3 = in_nested_set($Sf,'IncludedParameters', $var);
				if (not $subset1 and not $subset2 and not $subset3) { 
				my $qvar = $var . '_' . $f;
				$line =~ s/\b$var\b/$qvar/g;
				}				
			}
			}
			return ( [[$line,$info]], [ $stref, $f ] );
		};

		my $state = [ $stref, $f ];
		( $stref, $state ) = stateful_pass( $stref, $f, $rename_vars_pass, $state, 'rename_vars_pass() ' . __LINE__ );

	
#	$Sf->{'AnnLines'}=$Sf->{'RefactoredCode'};
	return $stref;

}    #  END of rename_vars

sub rename_args {
    ( my $stref, my $f , my $argmap) = @_;
    if ( exists $stref->{'Subroutines'}{$f} ) {
        my $Sf               = $stref->{'Subroutines'}{$f};
        
        my $rename_vars_pass = sub {
            ( my $annline, my $state ) = @_;
            ( my $line,    my $info )  = @{$annline};            
            ( my $stref,   my $f, my $argmap )     = @{$state};
            my $Sf = $stref->{'Subroutines'}{$f};
            
            for my $var ( keys %{$argmap} ) {
            	if (exists $info->{'VarDecl'}) {            		
            		if ($info->{'VarDecl'}{'Name'} eq $var) { 
                        $info->{'ArgDecl'}=1;
            		}            		
                }            	
                my $qvar = $argmap->{$var};
                $line =~ s/\b$var\b/$qvar/g;               
            }
            
            return ( [[$line,$info]], $state );
        };

        my $state = [ $stref, $f, $argmap ];
        ( $stref, $state ) = stateful_pass( $stref, $f, $rename_vars_pass, $state, 'rename_vars_pass() ' . __LINE__ );
#        croak Dumper(pp_annlines($Sf->{'RefactoredCode'},1));
    }
    
    return $stref;

}    #  END of rename_vars


1;