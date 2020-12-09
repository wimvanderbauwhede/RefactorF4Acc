package RefactorF4Acc::Refactoring::InlineSubroutine;
use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass pass_wrapper_subs_in_module );
use RefactorF4Acc::Parser qw( analyse_lines );
# 
#   (c) 2010-now Wim Vanderbauwhede <wim.vanderbauwhede@glasgow.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::InlineSubroutine::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::InlineSubroutine::EXPORT_OK = qw(
    &inline_subroutines
);

=pod info-inline-subroutine
To inline a subroutine, four steps are required:
0. This is recursive so any call in the subroutine to be inlined must also be inlined. So a first pass is to check CalledSubs, and if this is not empty, to look for subroutine calls and descend until we find one that is empty.
1. Substitute the signature arguments with the call arguments. This info is in $info->{'SubroutineCall'}{'ArgMap'} 
2. Rename the subroutine variables with a unique name. We can use a version of rename_inherited_vars(). To avoid conflicts we need to check if any name in the caller conflicts with a renamed variable, and if so rename that one as well. 
3. Split out the specification and computation parts. The computation part replaces the call; the specification needs to be added to the specification part of the caller. I guess we could put if after the first line that is not a SpecificationStatement, Comment or Blank    
=cut

sub inline_subroutines {
	( my $stref ) = @_;

	for my $f ( sort keys %{ $stref->{'Subroutines'} } ) {

		next if ( $f eq '' or $f eq 'UNKNOWN_SRC' or not defined $f );
		# next if exists $stref->{'Entries'}{$f};

		my $Sf = $stref->{'Subroutines'}{$f};

		# next if ( exists $Sf->{'Entry'} && $Sf->{'Entry'} == 1 );
		if ( not defined $Sf->{'Status'} ) {
			$Sf->{'Status'} = $UNREAD;
			say "INFO: no Status for $f" if $I;
		}

		next if $Sf->{'Status'} == $UNREAD;
		next if $Sf->{'Status'} == $READ;
		next if $Sf->{'Status'} == $FROM_BLOCK;

		$stref = _inline_subroutines_main( $stref, $f );
	}

	return $stref;
}    # END of inline_subroutines()

# Check if there are any subroutines to be inlined, and inline them one after another.
sub _inline_subroutines_main { my ( $stref, $f ) = @_;
    
    if ( exists $stref->{'Subroutines'}{$f} ) {
        
        # $stref = find_subs_to_inline($stref,$f);
        my $Sf = $stref->{'Subroutines'}{$f};
# die $f,Dumper $Sf->{'SubsToInline'};
        if (exists $Sf->{'SubsToInline'} ) {
            for my $sub ( @{$Sf->{'SubsToInline'}} ) {
                $stref = inline_subroutine($stref,$f,$sub);
            }
        } 
        # else {
        #     die 'BOOM!';
        # }
    }        
    
    return $stref;


}

sub inline_leaf_subroutine { (my $stref, my $f, my $sub) = @_;
    say "INLINE $sub in $f" if $DBG;
    # Find the call(s) to the subroutine $sub in $f
    # Rename using $info->{'ArgMap'}{$sig_arg}
    $stref = inline_call($stref,$f,$sub);
    # my $Sf = $stref->{'Subroutines'}{$f};
    # croak Dumper(pp_annlines($Sf->{'RefactoredCode'},0));
    
    # Here is where we will add the  $specification_part and $computation_part to the AnnLines of $f
    # Then we will also update the variable declarations in $f
	    
    
    return $stref;
} # END of inline_leaf_subroutine

# Inlining a call to $sub in $f
sub inline_call { my ($stref, $f, $sub) = @_;

   # First rename all variables in $sub. This is safe because even with COMMON blocks, the names are not global
   $stref = _rename_vars($stref,$sub);
    
    # Now rename the arguments, i.e. any occurrence of an argument in the body of $sub should get the value of the call arg in $f
    # Maybe this is substitute rather than rename. Also, factor this out.
    # TODO: refactor out
    my $pass__rename_args = sub {
            ( my $annline, my $state ) = @_;
            ( my $line,    my $info )  = @{$annline};
            ( my $stref,   my $f , my $sub)     = @{$state};
            my $Sf = $stref->{'Subroutines'}{$f};        

            if ( exists $info->{'SubroutineCall'} and $info->{'SubroutineCall'}{'Name'} eq $sub ) {
            	my $argmap = $info->{'SubroutineCall'}{'ArgMap'};
            	
                $stref = _rename_args( $stref,$sub,$argmap);
            } 
            return ( [$annline], [ $stref, $f, $sub ] );
    };

    my $state = [ $stref, $f, $sub];
    ( $stref, $state ) = stateful_pass( $stref, $f, $pass__rename_args, $state, 'pass__rename_args()' . __LINE__ );
        
        
    # Now run the analysis again and check the result
    my $Ssub = $stref->{'Subroutines'}{$sub};       

    $stref = analyse_lines( $sub, $stref );
    #    say Dumper(pp_annlines($Sf->{'AnnLines'},1));
    #    say '========';
    #    say Dumper(pp_annlines($Ssub->{'RefactoredCode'},1    ));        
    #    croak;        
       
        
    ($stref, my $use_part, my $specification_part,my $computation_part) = split_specification_computation_parts($stref, $sub);
    # WV20201207 Up to here it seems to be OK
    # croak Dumper(pp_annlines($specification_part))."\n\n".Dumper(pp_annlines($computation_part));
    $stref = merge_specification_computation_parts_into_caller($stref, $f, $sub, $use_part, $specification_part,$computation_part);  	            
    my $Sf = $stref->{'Subroutines'}{$f};       

    # say $Sf->{'AnnLines'} , $Sf->{'RefactoredCode'};
    #    say Dumper(pp_annlines($Sf->{'AnnLines'},1));
    #    say '========';
    #    say Dumper(pp_annlines($Sf->{'RefactoredCode'},0 ));        
    #    croak;       	
    return $stref;
} # END of inline_call


# Not only split, also weed out argument decls and return statements
sub split_specification_computation_parts { (my $stref, my $f) =@_;
	
    if ( exists $stref->{'Subroutines'}{$f} ) {
        my $Sf               = $stref->{'Subroutines'}{$f};
        
    my $pass_split_specification_computation_parts = sub {
            ( my $annline, my $state ) = @_;
            # say Dumper $annline;
            ( my $line,    my $info )  = @{$annline};
            ( my $stref,   my $f, my $use_part, my $specification_part, my $computation_part, my $preceding_comments)     = @{$state};
            my $Sf = $stref->{'Subroutines'}{$f};        

			if ( 
                exists $info->{'Signature'} or 
                exists $info->{'EndSubroutine'} or 
                exists $info->{'ArgDecl'} or 
                exists $info->{'Return'}
                ) {
                    
				# do nothing;
			} elsif ( exists $info->{'Comments'} or exists $info->{'Blank'} ) {
				push @{$preceding_comments}, $annline;
            } elsif ( exists $info->{'Use'} ) {
                # say $use_part;
				$use_part = [ @{$use_part}, @{$preceding_comments}, $annline ];
				$preceding_comments = [];
			} elsif ( exists $info->{'SpecificationStatement'}
            and not exists $info->{'ImplicitNone'}
             ) {
				$specification_part = [ @{$specification_part}, @{$preceding_comments}, $annline ];
				$preceding_comments = [];
			} elsif (not exists $info->{'ImplicitNone'}) {
				$computation_part = [ @{$computation_part}, @{$preceding_comments}, $annline ];
				$preceding_comments = [];
			}
			return ( [$annline], [ $stref, $f, $use_part, $specification_part, $computation_part, $preceding_comments ] );
    };

        my $state = [ $stref, $f, [],[],[],[]];
        ( $stref, $state ) = stateful_pass( $stref, $f, $pass_split_specification_computation_parts, $state, 'pass_split_specification_computation_parts() ' . __LINE__ );
        ( my $stref__,   my $f__ , my $use_part, my $specification_part, my $computation_part, my $preceding_comments__)     = @{$state};        

        return ($stref, $use_part, $specification_part, $computation_part);
    }
    
    return ($stref,[],[],[]);
} # END of split_specification_computation_parts
=pod info_merge_specification_computation_parts_into_caller
* The computation part simply replaces the call line, this is very easy.
* The specification part is harder because some specifications must come at the top (implicit, use) 
* For USE I must test against the module name and then merge the Only list

=cut

sub merge_specification_computation_parts_into_caller { (my $stref, my $f, my $sub,my $use_part, my $specification_part,my $computation_part) =@_;
	
    if ( exists $stref->{'Subroutines'}{$f} ) {        
        my $pass_merge_specification_computation_parts_into_caller = sub {
                ( my $annline, my $state ) = @_;
                ( my $line,    my $info )  = @{$annline};
                ( my $stref, my $f , my $sub, my $use_part, my $specification_part, my $computation_part, my $first_vardecl, my $found_use)     = @{$state};
                my $Sf = $stref->{'Subroutines'}{$f};
                # say $f, $line, "\n",Dumper($info) if $line=~/use/;        
                my $indent = $info->{'Indent'} // '      ';
                if ( exists $info->{'SubroutineCall'} and $info->{'SubroutineCall'}{'Name'} eq $sub ) {
                    return ( [comment($annline),comment("$indent BEGIN inlined call to $sub"),@{$computation_part},comment("$indent END inlined call to $sub")], $state );
                } elsif ( @{$use_part} and exists $info->{'Use'} ) {
                    $found_use=1;
                    # If $line has 'Use' we check if that use exists in $use_part
                    # If so, we merge them. 
                    # We need a state to identify the first line after 'use' so that we can tag on any use lines from $use_part there
                    # 
                    my $remaining_use_part=[];
                    my $updated_use_annline = $annline;
                    for my $use_annline (@{$use_part}) {
                        my ($use_line, $use_info) = @{$use_annline};
                        if ($info->{'Use'}{'Name'} eq $use_info->{'Use'}{'Name'}) {
                            my %orig_only = map {$_=>1}  @{$info->{'Use'}{'Only'}};
                            my %ex_sub_only = map {$_=>1}  @{$use_info->{'Use'}{'Only'}};
                            my %updated_only = (%orig_only,%ex_sub_only);
                            my @updated_only_list = sort keys %updated_only;
                            # say 'TODO: '. $line."\n" . Dumper(@updated_only_list);die;#. "\n".Dumper(%ex_sub_only);die;
                            $info->{'Use'}{'Only'}=[@updated_only_list];
                            my $updated_line = $info->{'Indent'}.'use '.$info->{'Use'}{'Name'}
                            . ($Config{'NO_ONLY'} ?  '!' : '') .
                            ', only: '.join(', ',@updated_only_list);
                            $updated_use_annline = [$updated_line,$info];
                        } else {
                            push @{$remaining_use_part}, $use_annline;
                        }
                    }
                    return ( [comment("$indent BEGIN merged ex-sub use statement"),$updated_use_annline, comment("$indent END merged ex-sub use statement")], [$stref, $f, $sub, $remaining_use_part, $specification_part, $computation_part, $first_vardecl, $found_use] ); 
                } elsif ( @{$use_part} and $found_use and not exists $info->{'Use'} 
                                    and not exists $info->{'Comments'}
                    and not exists $info->{'Blank'}
                    and not exists $info->{'Skip'}
                    and not exists $info->{'Deleted'}
                ) {
                    return ( [comment("$indent BEGIN ex-sub use statement"),@{$use_part},comment("$indent END ex-sub use statement"),$annline], [$stref, $f, $sub, [], $specification_part, $computation_part, $first_vardecl, $found_use] );
                    # return the remaining lines from
# sub _insert_specification_part { my ($info, $first_vardecl, $stref, $f, $rlines) = @_; # return ($rlines,$first_vardecl);
                } elsif (    
                    not exists $info->{'Signature'}
                    and not exists $info->{'VarDecl'}
                    and not exists $info->{'ImplicitNone'}
                    and not exists $info->{'SpecificationStatement'}
                    and not exists $info->{'Comments'}
                    and not exists $info->{'Blank'}
                    and not exists $info->{'Skip'}
                    and not exists $info->{'Deleted'}
                    and $first_vardecl == 1 )
                {
                    $state->[-2] = 0;
                    return ( [comment("$indent BEGIN ex-sub decls"),@{$specification_part},comment("$indent END ex-sub decls"),$annline], $state );
                    
                }
                return ( [$annline], $state );
                
        };

        my $state = [ $stref, $f, $sub, $use_part, $specification_part, $computation_part, 1,0];
        ( $stref, $state ) = stateful_pass( $stref, $f, $pass_merge_specification_computation_parts_into_caller, $state, 'pass_merge_specification_computation_parts_into_caller() ' . __LINE__ );      
    }
    return $stref;
} # END of merge_specification_computation_parts_into_caller


# The question is if we need to rename the variables in the $info as well, and I think the answer is 'YES'; and in principle of course also in 'Vars'
# But it is even more complicated in a way: what we need to do is to remove the inlined subroutine from CalledSubs and merge its renamed vars with the existing vars of the caller
# As this is done after refactoring, the vars should all be DeclaredOrigLocalVars. So I should look at LocalVars and LocalParameters of the called subroutine

# Question is: is it better to go through all vars per line or through all lines per var?
# Also, which lines can have vars and what does their $info look like?
# Of course a rather cheap way would be to rename the source before it gets parsed, e.g. in SrcReader. But we need to rename the args anyway so the problem remains.
# Or I could emit the refactored source and parse it but then I have to run all analysis again as well. Although maybe not, because this source should be "complete".
# So basically
# - do the renaming, 
# - emit the source and 
# - run it through the parser. 
# - Or maybe it is enough to only rerun _analyse_lines. 


# Rename every variable on every line $var to  $var . '_' . $f
sub _rename_vars {
	( my $stref, my $f ) = @_;
		
    my $Sf               = $stref->{'Subroutines'}{$f};
    
    my $rename_vars_pass = sub {
        ( my $annline, my $state ) = @_;
        ( my $line,    my $info )  = @{$annline};
        ( my $stref,   my $f )     = @{$state};
        if (
                not exists $info->{'Use'}
			and not exists $info->{'ImplicitNone'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Skip'}
			and not exists $info->{'Deleted'}            
         ) {
            my $Sf = $stref->{'Subroutines'}{$f};
            my $vars = get_vars_from_set( $Sf->{'Vars'} );
            for my $var (keys %{$vars} ) {
                my $subset1 = in_nested_set($Sf,'Args', $var);
                my $subset2 = in_nested_set($Sf,'UsedParameters', $var);
                my $subset3 = in_nested_set($Sf,'IncludedParameters', $var);
                if (not $subset1 and not $subset2 and not $subset3) { 
                    # The actual renaming
                    my $qvar = $var . '_' . $f;
                    $line =~ s/\b$var\b/$qvar/g;
                }				
            }
        }
        return ( [[$line,$info]], [ $stref, $f ] );
    };

    my $state = [ $stref, $f ];
    ( $stref, $state ) = stateful_pass( $stref, $f, $rename_vars_pass, $state, 'rename_vars_pass() ' . __LINE__ );

	return $stref;

}    #  END of _rename_vars

# Substitute the arguments in the subroutine by their call arg counterpart from $argmap
sub _rename_args {
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
    }
    
    return $stref;

}    #  END of _rename_args


# If the subroutine to be inlined contains calls to other subroutines, these have to be inlined as well
sub inline_subroutine {
	  (my $stref, my $f, my $sub) = @_;
#    local $V=1;
 	push @{ $stref->{'CallStack'} }, $f;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} }; 

    if (exists $stref->{'Subroutines'}{$sub} ) {
    	my $Sf = $stref->{'Subroutines'}{$sub};
    	if ( exists $Sf->{'CalledSubs'}{'List'}
        and scalar @{ $Sf->{'CalledSubs'}{'List'} }>0 )
	    {	    	
	        for my $csub ( @{ $Sf->{'CalledSubs'}{'List'} }) {   
				if (exists $subs{$csub}) {
                    warning( "CALL LOOP for $csub in $sub. Inlining of $sub in $f is impossible" ,1);
                    warning( join(', ', @{ $stref->{'CallStack'} }), 2);
                    die "\n";
                    next;
				}    
	       		say "CALL TO  $csub from $f" if $V;     
	            $stref = inline_subroutine($stref, $sub, $csub );
	            say "RETURN TO $f from CALL to $csub" if $V;
	            my $Scsub = $stref->{'Subroutines'}{$csub};
	            
	        } 
	    } else {
	        # Leaf node, find globals	        
	        say "SUB $f is LEAF, OK to inline" if $V; 
            $stref = inline_leaf_subroutine( $stref, $f, $sub);

	    }    
    }    
    pop @{ $stref->{'CallStack'} };
    # $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$sub}[1]--;
    # if ( $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$sub}[1] == 0 ) {
    #     delete $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$sub};
    #     $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'} = [ 
    #         grep {$_ ne $sub}  @{ $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'} } 
    #     ];
    # }
    return $stref;
} #  END of inline_subroutine()



# This should go in Analysis::Inline
# I think we should allow
# !$ACC Inline
# call
# call
# !$ACC End Inline
# So in that case Inline has no arg and we need to find all calls
sub find_subs_to_inline { (my $stref, my $f)=@_;

	# for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		return $stref unless exists $stref->{'Subroutines'}{$f}{'HasInlineRegion'};
		
		my $in_inline_region=0;
		my $called_subs = [];
		
		my $pass_actions = sub { (my $annline, my $state) = @_;
			(my $line, my $info)=@{$annline};
			
			(my $in_inline_region, my $called_subs)= @{$state};

			if (exists $info->{'AccPragma'}{'BeginInline'}
            and scalar @{ $info->{'AccPragma'}{'BeginInline'} } == 0
            ) {
				$in_inline_region=1;
				$info->{'Removed'}=1;
				$line=~s/\$//g;
				$annline=[$line,$info];
			}
			elsif (exists $info->{'AccPragma'}{'EndInline'}) {
				$in_inline_region=0;
				$info->{'Removed'}=1;
				$line=~s/\$//g;
				$annline=[$line,$info];
			}			
			elsif ( 
                $in_inline_region and 
                exists $info->{'SubroutineCall'}
               ) {
					# if a line is relevant		
					my $sub_name = $info->{'SubroutineCall'}{'Name'};
                    push @{$called_subs},$sub_name; 					
            } 
            return ([ $annline ], [$in_inline_region,  $called_subs] );
			
		};
		
		($stref, my $state) = stateful_pass ($stref,  $f,  $pass_actions,  [$in_inline_region,$called_subs], 'find_subs_to_inline' );
		($in_inline_region,$called_subs)=@{$state};
        $stref->{'Subroutines'}{$f}{'SubsToInline'}=$called_subs;		
	# }	
	return $stref;
} # END of find_subs_to_inline


1;