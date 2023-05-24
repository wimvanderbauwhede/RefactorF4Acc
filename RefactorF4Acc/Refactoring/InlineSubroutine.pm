package RefactorF4Acc::Refactoring::InlineSubroutine;
#
#   (c) 2010-now Wim Vanderbauwhede <wim.vanderbauwhede@glasgow.ac.uk>
#

use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass_inplace stateless_pass_inplace stateless_pass stateful_pass);
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast parse_expression_no_context _traverse_ast_with_action);
# use RefactorF4Acc::Parser qw( analyse_lines );

use Storable qw( dclone );
use Digest::MD5 qw(md5_base64 md5_hex md5);

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

$Sf->{'SubsToInline'} is either populated in the Parser if the inline pragma names the subroutines:

    !$RF4A Begin Inline f1 f2 ('Begin' is optional; current syntax is like this, FIXME)
    ...
    !$RF4A End Inline

If there is no list

    !$RF4A Begin Inline
    ...
    !$RF4A End Inline

then $Sf->{'HasInlineRegion'}=1 is set and find_subs_to_inline() is used to find the subs to inline and put them in $Sf->{'SubsToInline'}

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

    $stref = find_subs_to_inline($stref,$f);
    my $Sf = $stref->{'Subroutines'}{$f};
    if (exists $Sf->{'SubsToInline'} ) {
        for my $sub ( @{$Sf->{'SubsToInline'}} ) {
            carp "INLINING $sub in $f" if $V;
            $stref = _inline_subroutine($stref,$f,$sub,0);
        }
        $stref = _remove_duplicate_declarations($stref,$f);
        # $stref = _remove_redundant_modules($stref,$f);
    }
    # I definitely need a step to fuse the declarations of all inlined subs

    return $stref;
} # END of _inline_subroutines_main


# If the subroutine to be inlined contains calls to other subroutines, these have to be inlined as well
sub _inline_subroutine { (my $stref, my $f, my $sub, my $is_child) = @_;
#    local $V=1;
 	push @{ $stref->{'CallStack'} }, $f;
    my %subs = map {$_=>1} @{ $stref->{'CallStack'} };


    if (exists $stref->{'Subroutines'}{$sub} ) {
    	my $Ssub = $stref->{'Subroutines'}{$sub};
    	if ( exists $Ssub->{'CalledSubs'}{'List'}
        and scalar @{ $Ssub->{'CalledSubs'}{'List'} }>0 )
	    {
	        for my $csub ( @{ $Ssub->{'CalledSubs'}{'List'} }) {
				if (exists $subs{$csub}) {
                    warning( "CALL LOOP for $csub in $sub. Inlining of $sub in $f is impossible" ,1);
                    warning( join(', ', @{ $stref->{'CallStack'} }), 2);
                    die "\n";
                    next;
				}
	       		say "CALL TO  $csub from $sub" if $V;
	            $stref = _inline_subroutine($stref, $sub, $csub, 1);
	            say "RETURN TO $sub from CALL to $csub" if $V;
	        }
	    } #else {
	        # Leaf node, inline
	        say "SUB $sub in $f is LEAF, OK to inline, is_child=$is_child" if $V;
            $stref = _inline_call( $stref, $f, $sub, $is_child);
            # Update CalledSubs
            # carp Dumper $stref->{'Subroutines'}{$f}{'CalledSubs'};
            $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$sub}[1]--;
            if ( $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$sub}[1] == 0 ) {
                delete $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'}{$sub};
                $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'} = [
                    grep {$_ ne $sub}  @{ $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'} }
                ];
            }

	    #}
    }
    pop @{ $stref->{'CallStack'} };
    return $stref;
} #  END of _inline_subroutine()

# Inlining a call to $sub in $f
sub _inline_call { my ($stref, $f, $sub, $is_child) = @_;
    my $Ssub = $stref->{'Subroutines'}{$sub};
   # First rename all variables in $sub. This is safe because even with COMMON blocks, the names are not global
    ($stref, my $renamed_vars) = __rename_vars($stref, $sub);
    for my $var (sort keys %{$renamed_vars}) {
        my $qvar = $renamed_vars->{$var};
        $Ssub = __update_renamed_vardecl($Ssub,$var,$qvar);
    }
    # my $sub_annlines = dclone($Ssub->{'RefactoredCode'});
    $Ssub->{'AnnLines'} = $Ssub->{'RefactoredCode'};
    # Now substitute the arguments, i.e. any occurrence of an argument in the body of $sub should get the value of the call arg in $f
    # $stref = __substitute_args($stref, $f, $sub);

    # Now run the analysis again and check the result
    # No need as I did not keep the changes
    # $stref = analyse_lines( $sub, $stref );
    ($stref, my $use_part, my $specification_part) = __split_out_specification_parts($stref, $sub);
    $Ssub->{'RefactoredCode'}=$Ssub->{'AnnLines'};

    # WV20201207 Up to here it seems to be OK
    $stref = __merge_specification_computation_parts_into_caller($stref, $f, $sub, $use_part, $specification_part,$is_child);
    my $Sf = $stref->{'Subroutines'}{$f};

    return $stref;
} # END of _inline_call

# Not only split, also weed out argument decls and return statements
sub __split_out_specification_parts { (my $stref, my $f) =@_;

    my $Sf = $stref->{'Subroutines'}{$f};
    # say "__split_out_specification_parts($f)";
    my $pass__split_out_specification_parts = sub {
        ( my $annline, my $state ) = @_;

        my ( $line, $info )  = @{$annline};
        # say "$f LINE $line" if $f eq 'velfg_map_76';
        # say "$f BAD LINE $line" if $line=~/intent/i and not exists $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'} and not exists $info->{'ArgDecl'};
        my ( $use_part, $specification_part, $preceding_comments ) = @{$state};

        if (
            exists $info->{'Signature'} or
            exists $info->{'ArgDecl'} or
            (exists $info->{'ParsedVarDecl'}
            and exists $info->{'ParsedVarDecl'}{'Attributes'}
            and exists $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'}
            ) or
            exists $info->{'EndSubroutine'} or
            exists $info->{'Return'}
        ) {
            # say "SKIP: $line";
            # do nothing;
        } elsif ( exists $info->{'Comments'} or exists $info->{'Blank'} ) {
            push @{$preceding_comments}, $annline;
        } elsif ( exists $info->{'Use'} ) {

            $use_part = [ @{$use_part}, @{$preceding_comments}, $annline ];
            $preceding_comments = [];
        } elsif (
            exists $info->{'SpecificationStatement'} and
            not exists $info->{'ImplicitNone'}
        ) {

            $specification_part = [ @{$specification_part}, @{$preceding_comments}, $annline ];
            $preceding_comments = [];
        }
        return ( [$annline], [ $use_part, $specification_part, $preceding_comments ] );
    };

    my $state = [[],[],[]];
    ( $stref, $state ) = stateful_pass_inplace( $stref, $f, $pass__split_out_specification_parts, $state, 'pass__split_specification_computation_parts() ' . __LINE__ );
    ( my $use_part, my $specification_part, my $preceding_comments__)     = @{$state};

    # croak Dumper(pp_annlines($specification_part))."\n\n".Dumper(pp_annlines($Sf->{'RefactoredCode'})) if $f eq 'velfg_map_76';

    # Here we make sure the lines in $use_part are unique
    my $use_part_unique=[];
    if (scalar @{$use_part}>0) {
        my %use_part_unique_lines=();
        for my $annline (@{$use_part}) {

            my ( $line, $info )  = @{$annline};
            if (not exists $use_part_unique_lines{ $line}) {
                $use_part_unique_lines{ $line}=$info;
                push @{$use_part_unique},$annline;
            }
        }
    } else {
        $use_part_unique=$use_part;
    }

    # say "Specification part for $f:\n". Dumper(pp_annlines($specification_part,1));
    return ($stref, $use_part_unique, $specification_part);
} # END of __split_out_specification_parts

# Not only split, also weed out argument decls and return statements
sub __split_out_computation_part { (my $stref, my $f) =@_;

    my $Sf = $stref->{'Subroutines'}{$f};

    my $pass__split_out_computation_part = sub {
        ( my $annline, my $state ) = @_;
        # say Dumper $annline;
        my ( $line, $info )  = @{$annline};
        my ( $computation_part, $preceding_comments ) = @{$state};
        # say "LINE $line ".Dumper($info) if $line =~/end/;
        if (
            exists $info->{'Signature'} or
            exists $info->{'EndSubroutine'} or
            exists $info->{'ArgDecl'} or
            exists $info->{'Return'}
        ) {
            # do nothing;
        } elsif ( exists $info->{'Comments'} or exists $info->{'Blank'} ) {
            push @{$preceding_comments}, $annline;
        } elsif (  exists $info->{'Use'} or
            ( exists $info->{'SpecificationStatement'} and
            not exists $info->{'ImplicitNone'} )
        ) {
            $preceding_comments = [];
        } elsif (not exists $info->{'ImplicitNone'}) {
            $computation_part = [ @{$computation_part}, @{$preceding_comments}, $annline ];
            $preceding_comments = [];
        }
        return ( [$annline], [ $computation_part, $preceding_comments ] );
    };

    my $state = [[],[]];
    ( $stref, $state ) = stateful_pass_inplace( $stref, $f, $pass__split_out_computation_part, $state, 'pass__split_specification_computation_parts() ' . __LINE__ );
    my $computation_part = $state->[0];
    # say "Computation part for $f:\n". Dumper($computation_part) if $f eq 's1b';
    return ($stref, $computation_part);
} # END of __split_out_computation_part


=pod info__merge_specification_computation_parts_into_caller
* The computation part simply replaces the call line, this is very easy.
* The specification part is harder because some specifications must come at the top (implicit, use)
* For USE I must test against the module name and then merge the Only list

=cut

sub __merge_specification_computation_parts_into_caller { (my $stref, my $f, my $sub, my $use_part, my $specification_part, my $is_child) =@_;

	my $Sf = $stref->{'Subroutines'}{$f};

        my $pass_filter_non_caller_specifications = sub { my ($annline) = @_;
            my ($line, $info) = @{$annline};
            my $rinfo={%{$info}};
            if (exists $info->{'VarDecl'}) {
                my $var_name = $info->{'VarDecl'}{'Name'};
                my $subset = in_nested_set($Sf,'Vars', $var_name);
                if ($subset) {
                    say "__merge_specification_computation_parts_into_caller $f => $sub => $subset => Delete $var_name decl: ".$line if $DBG;
                    # croak if $line=~/[fgh]_1/ and $line!~/dimension/;
                    $rinfo={%{$info},'Deleted'=>1};
                    $line = '! '.$line;
                }
            }
            elsif (exists $info->{'ParamDecl'}) {

                my $par_name = exists $info->{'ParamDecl'}{'Name'} ?
                ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY'
                ? $info->{'ParamDecl'}{'Name'}[0]
                : $info->{'ParamDecl'}{'Name'}
                : exists $info->{'ParamDecl'}{'Var'} ?
                $info->{'ParamDecl'}{'Var'} : undef;
                if (not defined $par_name) {
                    croak Dumper($info);
                }
                my $subset = in_nested_set($Sf,'Vars', $par_name);
                # say "PAR LINE: $line => $par_name => in $subset of $f ";
                if ($subset) {
                     say "__merge_specification_computation_parts_into_caller $f => $sub => $subset => Delete $par_name decl: ".$line if $DBG;
                    $rinfo={%{$info},'Deleted'=>1};
                    $line = '! '.$line;
                }
            }

            return [[$line,$rinfo]]
        };

        my $non_caller_specifications = #$specification_part;
            stateless_pass($specification_part,$pass_filter_non_caller_specifications,"pass_filter_non_caller_specifications($f)");

    my $pass__merge_specification_computation_parts_into_caller = sub {
        my ( $annline, $state ) = @_;
        my ( $line,    $info )  = @{$annline};
        my ( $use_part, $specification_part,
            $in_inline_region,
            $first_vardecl, $found_use
            )     = @{$state};
            my $test = (
            not exists $Sf->{'InlinedCalls'}{'Set'}{$sub}
            and not exists $info->{'Signature'}
            and not exists $info->{'ParamDecl'}
            and not exists $info->{'ImplicitNone'}
            and not exists $info->{'Comments'}
            and not exists $info->{'Blank'}
            and not exists $info->{'Deleted'}
            and exists $info->{'VarDecl'}
            and $first_vardecl == 1 );

        my $indent = $info->{'Indent'} // '      ';
        if (exists $info->{'Pragmas'}{'BeginInline'} ) {
            $line=~s/\$//;
            $in_inline_region=1;
        }
        elsif (exists $info->{'Pragmas'}{'EndInline'}) {
            $line=~s/\$//;
            $in_inline_region=0;
        }
        elsif (exists $info->{'Signature'})	{

        # Use statements should go immediately after the subroutine decl
        # But if there are other use statements, we need to see that they are unique
        # I think the easies way is to have another pass for this.
            return ( [
                $annline, @{$use_part},
                ],
                    [
                    [], $specification_part,
                    $in_inline_region,
                    $first_vardecl, $found_use
                ]
            );
        }
        elsif (
            exists $info->{'SubroutineCall'} and
            $info->{'SubroutineCall'}{'Name'} eq $sub and
            ($in_inline_region or $is_child)
            ) {
                my $line_id = $info->{'LineID'};
                $stref = __substitute_args($stref, $f, $sub, $line_id);
                ($stref, my $computation_part) = __split_out_computation_part($stref, $sub);
                my $Ssub = $stref->{'Subroutines'}{$sub};
                $Ssub->{'RefactoredCode'}=$Ssub->{'AnnLines'};

                $Sf->{'InlinedCalls'}{'Set'}{$sub}++;
                # comment($annline),
                return ( [
                    comment("$indent BEGIN inlined call to $sub"),
                    @{$computation_part}
                    ,comment("$indent END inlined call to $sub")
                    ],
                [
                    $use_part, $specification_part, $computation_part,
                    $in_inline_region,
                    $first_vardecl, $found_use
                ]
                );
        }
        elsif (
            exists $info->{'FunctionCalls'} and
            ($in_inline_region or $is_child)
            ) {
                my $line_id = $info->{'LineID'};

            for my $entry (@{$info->{'FunctionCalls'}}) {
                if ($entry->{'Name'} eq $sub) {
                    $stref = __substitute_args($stref, $f, $sub, $line_id);
                    ($stref, my $computation_part) = __split_out_computation_part($stref, $sub);
                    # croak Dumper $computation_part;
                    my $Ssub = $stref->{'Subroutines'}{$sub};
                    # my $sub_annlines = dclone($Ssub->{'RefactoredCode'});
                    $Ssub->{'RefactoredCode'}=$Ssub->{'AnnLines'};

                    $Sf->{'InlinedCalls'}{'Set'}{$sub}++;
                    # croak Dumper $info;
                    my $ast =  $entry->{'ExpressionAST'};
                    my $call_str = emit_expr_from_ast($ast);
                    # carp Dumper( $info->{'Lhs'},$info->{'Rhs'}{'ExpressionAST'});

                    $call_str=~s/\W/_/g;
                    my $rhs_ast = $info->{'Rhs'}{'ExpressionAST'};
                    $rhs_ast = _replace_call_with_var($rhs_ast,$call_str);
                    my $new_rhs_str = emit_expr_from_ast( $rhs_ast );
                    my $lhs_ast = $info->{'Lhs'}{'ExpressionAST'};
                    my $lhs_str = emit_expr_from_ast( $lhs_ast );

                    my $updated_line = $info->{'Indent'}."$lhs_str = $new_rhs_str";

                    # I need to update the info with the new Rhs AST but also remove the function from the FunctionCalls.
                    my @rest = grep {emit_expr_from_ast($_->{'ExpressionAST'}) eq $call_str} @{$info->{'FunctionCalls'}};
                    $info->{'FunctionCalls'}=[@rest];
                    $info->{'Rhs'}{'ExpressionAST'}=$rhs_ast;
                    my $updated_annline=[$updated_line, $info];
                    # comment($annline),
                    # This will terminate the loop, no need for last
                    # But this is NOT correct: we need to
                    # - create a new var
                    # - replace the call in the expression by it
                    # - replace the assignment to the function name or return arg with this name
                    # - replace the name in the declaration
                    return ( [
                        comment("$indent BEGIN inlined call to $sub"),
                        @{$computation_part},$updated_annline
                        ,comment("$indent END inlined call to $sub")
                        ],
                        [
                            $use_part, $specification_part, $computation_part,
                            $in_inline_region,
                            $first_vardecl, $found_use
                        ]
                    );
                }
            }
        }
        elsif (
            not exists $Sf->{'InlinedCalls'}{'Set'}{$sub} and
            @{$use_part} and exists $info->{'Use'} ) {
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
                    (scalar @updated_only_list > 0
                        ? ', only: '.join(', ',@updated_only_list)
                        : ''
                    );

                    $updated_use_annline = [$updated_line,$info];
                } else {
                    say "USE: $f ". $info->{'Use'}{'Name'} .'<>'. $use_info->{'Use'}{'Name'};
                    push @{$remaining_use_part}, $use_annline;
                }
            }
            return ( [
                comment("$indent BEGIN merged ex-sub use statement $sub"),
                $updated_use_annline
                , comment("$indent END merged ex-sub use statement $sub")
                ],
                [
                    $remaining_use_part, $specification_part,
                    $in_inline_region,
                    $first_vardecl, $found_use
                ]
                );
        } elsif (
            not exists $Sf->{'InlinedCalls'}{'Set'}{$sub}
            and @{$use_part}
            and $found_use and not exists $info->{'Use'}
            and not exists $info->{'Comments'}
            and not exists $info->{'Blank'}
            and not exists $info->{'Deleted'}
        ) {
            return ( [
                # comment("$indent BEGIN ex-sub use statement $sub"),
                @{$use_part},
                # comment("$indent END ex-sub use statement $sub"),
                $annline],
            [
                [], $specification_part,
                $in_inline_region,
                $first_vardecl, $found_use
                ] );
        } elsif (
            $test
            # not exists $Sf->{'InlinedCalls'}{'Set'}{$sub}
            # and not exists $info->{'Signature'}
            # # and not exists $info->{'VarDecl'}
            # and not exists $info->{'ImplicitNone'}
            # and not exists $info->{'SpecificationStatement'}
            # and not exists $info->{'Comments'}
            # and not exists $info->{'Blank'}
            # and not exists $info->{'Deleted'}
            # and $first_vardecl == 1
            )
        {
            # croak Dumper $annline;
            $first_vardecl = 0;
            return ( [
                comment("$indent BEGIN ex-sub decls $sub"),
                @{$specification_part},
                comment("$indent END ex-sub decls $sub"),
                $annline],
                    [
                    $use_part, $specification_part,
                    $in_inline_region,
                    $first_vardecl, $found_use
                ]
            );

        }

        return ( [[$line,$info]],
            [
                $use_part, $specification_part,
                $in_inline_region,
                $first_vardecl, $found_use
            ]
        );

    };

    my $state = [ $use_part, $non_caller_specifications, 0, 1, 0];
    ( $stref, $state ) = stateful_pass_inplace( $stref, $f, $pass__merge_specification_computation_parts_into_caller, $state, 'pass__merge_specification_computation_parts_into_caller() ' . __LINE__ );

        my $pass__remove_duplicate_use_statements = sub { my ($annline,$state) = @_;
            my ($line, $info) = @{$annline};
            if (exists $info->{'Use'}) {
                if (not exists $state->{$line}) {
                        $state->{$line}=$info;
                } else {
                    say "$f: DUPLICATE: $line";
                    $line = '! '.$line;
                    $info={%{$info}, 'Deleted'=>1};
                }
            }
            return ([[$line,$info]],$state)
        };


    $state = {};
    ( $stref, $state ) = stateful_pass_inplace( $stref, $f, $pass__remove_duplicate_use_statements, $state, 'pass__remove_duplicate_use_statements() ' . __LINE__ );
# pp_annlines($Sf->{'RefactoredCode'}
    # carp $f.' : '. Dumper( pp_annlines($specification_part,1) ) if $f eq  'f_pelt_f_1_0';#'f_maps_f_1_1';#
    #  croak $f.' : '. Dumper( pp_annlines($Sf->{'RefactoredCode'}) ) if $f eq 'f_pelt_f_1_0';#'f_comp_f_1_37';# 'f_maps_f_1_1';#'velfg_map_76' ;#'f_pelt_f_1_0';#
	#  "stage_kernel_1", "f_pelt_f_1_38","f_comp_f_1_37", "f_applyt_f_1_36","f_maps_f_1_3",

    $stref = __update_caller_inlined_vardecl_records($stref,$f,$sub,$specification_part);

    return $stref;
} # END of __merge_specification_computation_parts_into_caller


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

# Rename every variable on every line $var to whatever __create_new_name returns
sub __rename_vars {
	( my $stref, my $f ) = @_;

    my $Sf = $stref->{'Subroutines'}{$f};

    my $rename_vars_pass = sub {
        ( my $annline, my $renamed_vars ) = @_;
        ( my $line,    my $info )  = @{$annline};
        if (exists $info->{'VarDecl'}
        and not exists $info->{'ArgDecl'}
        and not exists $info->{'ParsedVarDecl'}{'Attributes'}{'Intent'}
        and $Config{'RENAME_VARS_IN_INLINED_SUBS'}==1
        ) {
            # croak Dumper $info if exists $info->{'ParamDecl'} or exists $info->{'ParsedParDecl'};
            # say "PROBLEM: LINE:$line at ".__LINE__ if $line=~/intent/i;
            my $var = $info->{'VarDecl'}{'Name'};
            # croak Dumper $info->{'VarDecl'};
            my $qvar = __create_new_name($var, $f);
            $line =~ s/\b$var\b/$qvar/g;
            $renamed_vars->{$var}=$qvar;
            $info->{'VarDecl'}{'OrigName'}=$var;
            $info->{'VarDecl'}{'Name'}=$qvar;
            # Renaming the parameters in the array dimension
            if ($Config{'RENAME_PARS_IN_INLINED_SUBS'} == 1 and exists $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}) {
                my $dim_str = join(',',  @{$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}});
                my ($ast,$str,$error,$has_funcs) = parse_expression_no_context($dim_str);
                my $renamed_ast = _traverse_ast_with_action($ast,
                    sub {
                        my ($ast) = @_;
                        if ($ast->[0] == 2) {
                            $ast->[1] = __create_new_name($ast->[1],$f);
                        }
                        return $ast;
                    }
                );
                my $type = $info->{'ParsedVarDecl'}{'TypeTup'}{'Type'};
                my $kind =$info->{'ParsedVarDecl'}{'TypeTup'}{'Kind'}  ;
                if (defined $kind) {
                    $kind = "(kind=$kind)";
                } else {
                    $kind = '';
                }
                my $renamed_dim_str = emit_expr_from_ast( $renamed_ast);
                my $renamed_decl = "$type$kind, dimension($renamed_dim_str) :: $qvar";
                $line = $info->{'Indent'}.$renamed_decl;
                $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}= [split(/\s*,\s*/,$renamed_dim_str)];
                $info->{'ParsedVarDecl'}{'Vars'} = [$qvar];
                # carp $line .Dumper($info->{'ParsedVarDecl'}{'Attributes'});
            }
        }
        # WV 2021-06-08 If I would want to rename parameters.
        # Currently I don't, which means that there could be conflicts.
        # So I think I'll need a flag RENAME_PARS_IN_INLINED_SUBS in case this breaks
        elsif ( exists $info->{'ParamDecl'} and $Config{'RENAME_PARS_IN_INLINED_SUBS'}==1) { # This must be a LocalParameter
            # warn Dumper $info;
            my $info_paramdecl = dclone($info->{'ParamDecl'});
            $info->{'ParamDecl'} = $info_paramdecl;
            # say "__rename_vars $f LINE: $line";
            if (exists  $info->{'ParamDecl'}{'Var'}) {
                my $par = $info->{'ParamDecl'}{'Var'};
                my $qpar = __create_new_name($par,$f);
                $line =~ s/\b$par\b/$qpar/g;
                $renamed_vars->{$par}=$qpar;

                $info->{'ParamDecl'}{'OrigName'}=$par;
                $info->{'ParamDecl'}{'Name'}=$qpar;

            } else {
                my $par = ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY'
                ? $info->{'ParamDecl'}{'Name'}[0]
                : $info->{'ParamDecl'}{'Name'};
                my $qpar = __create_new_name($par,$f);
                $line =~ s/\b$par\b/$qpar/g;
                $renamed_vars->{$par}=$qpar;

                $info->{'ParamDecl'}{'OrigName'}=$par;
                if (ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY') {
                    $info->{'ParamDecl'}{'Name'}[0]=$qpar;
                } else {
                    $info->{'ParamDecl'}{'Name'}=$qpar;
                }

            }
            # say Dumper  $info->{'ParamDecl'};

        }
        elsif (
                not exists $info->{'Use'}
			and not exists $info->{'ImplicitNone'}
			and not exists $info->{'Comments'}
			and not exists $info->{'Blank'}
			and not exists $info->{'Deleted'}
            and not exists $info->{'ArgDecl'}
         ) {
            my $Sf = $stref->{'Subroutines'}{$f};
            my $vars = get_vars_from_set( $Sf->{'Vars'} );
            # croak Dumper get_vars_from_set( $Sf->{'Parameters'} ) if $f eq 'dyn';
            for my $var (keys %{$vars} ) {
                my $subset_dbg = in_nested_set($Sf,'Vars', $var);
                # say "$f [$line] $var: $subset_dbg" if $line=~/do/ and $var eq 'im';
                # croak "$f $line $var ".Dumper($info) if $var eq 'v_inout' and $line=~/InOut/;

                my $subset_args = in_nested_set($Sf,'Args', $var);
                my $subset_par = in_nested_set($Sf,'Parameters', $var);
                my $subset_usedpar = in_nested_set($Sf,'UsedParameters', $var);
                my $subset_inclpar = in_nested_set($Sf,'IncludedParameters', $var);
                if (not $subset_args ) {
                    if (
                        ($Config{'RENAME_VARS_IN_INLINED_SUBS'} == 1 and
                        not $subset_par) or (
                        $Config{'RENAME_PARS_IN_INLINED_SUBS'} == 1 and
                        $subset_par and
                not $subset_usedpar and not $subset_inclpar)
                # or $Config{'RENAME_PARS_IN_INLINED_SUBS'} == 1
                ) {
                    # The actual renaming
                    my $qvar = __create_new_name($var,$f);
                    $line =~ s/\b$var\b/$qvar/g;
                    $renamed_vars->{$var}=$qvar;
                }
                }
            }
        }
        return ([[$line,$info]], $renamed_vars);
    };

    my $renamed_vars = {};
    ($stref,$renamed_vars) = stateful_pass_inplace( $stref, $f, $rename_vars_pass, $renamed_vars, 'rename_vars_pass() ' . __LINE__ );

	return ($stref, $renamed_vars);

} #  END of __rename_vars


# F95 spec
# Section 3: Characters, lexical tokens, and source form
# 3.2 Low-level syntax
# 3.2.1 Names
# Names are used for various entities such as variables, program units, dummy arguments, named constants, and derived types.
#     R304 name is letter [alphanumeric-character]
# Constraint: The maximum length of a name is 31 characters.

# For Fortran 2003 it is 63

sub __create_new_name { my ($var,$f) = @_;
# If the suffix is already the function name, it means we've done this already.
        #  croak "$var,$f" if $var =~/nx/;
    if ($var=~/___/ ) {
        # croak "$var,$f";
        return $var;
    }
    my $MAX_NCHARS = 31;
    my $qvar = $var . '___' . $f;
    # say "VAR: $var F: $f";
    if (length $qvar > $MAX_NCHARS) {

        # my $suffix = substr(md5_base64($qvar),0,12); # 22 characters but we keep 12
        # $suffix=~tr/\+\//__/;
        my $md5hash = md5($qvar); # 22 characters but we keep 12
        my @vals= unpack( 'S' x 8, $md5hash );
        my $suffix='';
        for my $idx (0..  @vals/4-1)  {
            my $xored = ($vals[$idx*4] ^ $vals[$idx*4+1]) ^
            ($vals[$idx*4+2] ^ $vals[$idx*4+3]);
            $suffix.= sprintf("%x",$xored);
        }
# die $suffix;
        # say "SUFFIX: $suffix";
        # we allow 41 chars, ad hoc
        $qvar = substr($qvar,0,$MAX_NCHARS-9).'___'.$suffix;
    }
    # say "QVAR:$qvar";
    return $qvar;
}

sub __substitute_args { my ($stref, $f, $sub, $line_id) = @_;
    # Now substitute the arguments, i.e. any occurrence of an argument in the body of $sub should get the value of the call arg in $f
    # TODO: refactor out
    my $pass__substitute_args = sub {
            my ( $annline, $state ) = @_;
            my ( $line,    $info )  = @{$annline};
            my ( $in_inline_region, $first_call)     = @{$state};
            if (exists $info->{'Pragmas'}{'BeginInline'} ) {
				$in_inline_region=1;
			}
			elsif (exists $info->{'Pragmas'}{'EndInline'}) {
				$in_inline_region=0;
			}
            # If we find a call to sub in an Inline region and it is the first time we encounter this call, we do the substitution
            elsif ( exists $info->{'SubroutineCall'} and $info->{'SubroutineCall'}{'Name'} eq $sub and
            # $first_call==1 and
            $info->{'LineID'} == $line_id
            ) {
                # $first_call=0;
                # warn $info->{LineID};
            	my $argmap = $info->{'SubroutineCall'}{'ArgMap'};

                $stref = __substitute_args_core( $stref,$sub,$argmap);
            }
            elsif ( exists $info->{'FunctionCalls'}) {
                carp 'TODO';
                return ( [$annline], [ $in_inline_region, $first_call ] );
            }
            return ( [$annline], [ $in_inline_region, $first_call ] );
    };

    my $state = [ 0, 1];
    ( $stref, $state ) = stateful_pass_inplace( $stref, $f, $pass__substitute_args, $state, 'pass__substitute_args()' . __LINE__ );
    return $stref;
} # END of __substitute_args

# Substitute the arguments in the subroutine by their call arg counterpart from $argmap
sub __substitute_args_core { ( my $stref, my $f , my $argmap) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};

    my $rename_vars_pass = sub {
        ( my $annline ) = @_;
        ( my $line,    my $info )  = @{$annline};
        # my $argmap = $state;
        # my $Sf = $stref->{'Subroutines'}{$f};
        my $orig_line=$line;
        for my $var ( keys %{$argmap} ) {
            if (exists $info->{'VarDecl'}) {
                if ($info->{'VarDecl'}{'Name'} eq $var) {
                    $info->{'ArgDecl'}=1;
                }
            }
            my $qvar = $argmap->{$var};
            $line =~ s/\b$var\b/$qvar/g;
        }
        # Quick and dirty check for identity assignment
        if (exists $info->{'Assignment'}) {
            my $tline = $line;
            $tline=~s/\s*//g;
            my ($lhs,$rhs) = split(/=/,$tline);
            if ($lhs eq $rhs) {
                $line = '! '.$line;
            }
        }
        if ($line=~/\(([^\)\(]+?)\)\(([^\)\(]+?)\)/) {
            $line = __fix_slice_indexing($line,$info);
        }

        # $line =~s/\s*:\s*\)\(//g;
        # say "LINE2:$line";
        push @{ $info->{'Ann'} }, annotate( $f, __LINE__ . ' __substitute_args_core');
        return [[$line,$info]];
    };

    $stref = stateless_pass_inplace( $stref, $f, $rename_vars_pass, 'rename_vars_pass() ' . __LINE__ );

    return $stref;

} #  END of __substitute_args_core

sub __fix_slice_indexing{my ($line,$info) = @_;
    # say "LINE: $line";
    $line=~s/\)$/) /;
    while ($line=~/\(\(/) {
        $line=~s/\(\(/( (/;
    }
    while ($line=~/\)\)/) {
        $line=~s/\)\)/) )/;
    }

    my @chunks = split(/\)\(/,$line);
    my $new_line='';
    for my $idx (0 .. scalar @chunks -2 ) {
        my $left = $chunks[$idx];
        my $right = $chunks[$idx+1];
        # say "$idx<$left><$right>";
        my @l_chunks = split(/\(/,$left);
        my $l_last = pop @l_chunks;
        my @r_chunks = split(/\)/,$right);
        my $r_first = shift @r_chunks;
        # say "<$l_last><$r_first>";
        my @l_elts = split(/\s*,\s*/,$l_last);
        my @r_elts = split(/\s*,\s*/,$r_first);
        # say @l_elts, ')(',@r_elts;
        if (scalar @l_elts != 1 + scalar @r_elts) {croak $line; } else {
            my @merge = ($l_elts[0],@r_elts);
            my $merged_str = '('.join(',',@merge).')';
            my $prev_chunk = join('(',@l_chunks);
            my @prev_chunks =  split(/\)/,$prev_chunk);
            if ($idx>0) {
                 shift @prev_chunks;
            }
            $new_line.= join(')',@prev_chunks);
            $new_line.= $merged_str;
            if ($idx ==  scalar @chunks -2) {
                $new_line.= join(')',@r_chunks);
            }
        }
    }
    # say "NEW LINE: $new_line";
    # if ($line=~/\s*=\s*/) {
    #     my ($lhs,$rhs) = split(/\s*=\s*/,$line);
    #     $lhs=~/\(([^\)\(]+?)\)\(([^\)\(]+?)\)/ && do {
    #         say "LHS<$1><$2>";
    #     };
    #     $rhs=~/\(([^\)\(]+?)\)\(([^\)\(]+?)\)/ && do {
    #         say "RHS<$1><$2>";
    #     };
    # } else {
    #     $line=~/\(([^\)\(]+?)\)\(([^\)\(]+?)\)/ && do {
    #         say "SUB<$1><$2>";
    #     };
    # }
    return $new_line;
}

# This should go in Analysis::Inline
# I think we should allow
# $RF4A Inline
# call
# call
# $RF4A End Inline
# So in that case Inline has no arg and we need to find all calls
sub find_subs_to_inline { (my $stref, my $f)=@_;

	# for my $f ( keys %{ $stref->{'Subroutines'} } ) {
		return $stref unless exists $stref->{'Subroutines'}{$f}{'HasInlineRegion'};


		my $pass_actions = sub { (my $annline, my $state) = @_;
			(my $line, my $info)=@{$annline};

			(my $in_inline_region, my $called_subs)= @{$state};

			if (exists $info->{'Pragmas'}{'BeginInline'}
            and scalar @{ $info->{'Pragmas'}{'BeginInline'} } == 0
            ) {
				$in_inline_region=1;
				# $info->{'Removed'}=1;
				# $line=~s/\$//g;
				$annline=[$line,$info];
			}
			elsif (exists $info->{'Pragmas'}{'EndInline'}) {
				$in_inline_region=0;
				# $info->{'Removed'}=1;
				# $line=~s/\$//g;
				$annline=[$line,$info];
			}
			elsif (
                $in_inline_region and
                exists $info->{'SubroutineCall'}
               ) {
					# if a line is relevant

					my $sub_name = $info->{'SubroutineCall'}{'Name'};
                    $called_subs->{$sub_name}++;
            }
            elsif ( $in_inline_region and
                exists $info->{'FunctionCalls'} ) {
                    for my $entry (@{$info->{'FunctionCalls'}}) {
                        my $fname = $entry->{'Name'};
                        $called_subs->{$fname}++;
                    }
            }

            return ([ $annline ], [$in_inline_region,  $called_subs] );

		};

		my $in_inline_region=0;
		my $called_subs = {};
        my $state = [$in_inline_region,$called_subs];

		($stref, $state) = stateful_pass_inplace ($stref,  $f,  $pass_actions,  $state, 'find_subs_to_inline' );
		($in_inline_region,$called_subs)=@{$state};
        $stref->{'Subroutines'}{$f}{'SubsToInline'}= [sort keys %{$called_subs}];
	# }
	return $stref;
} # END of find_subs_to_inline

sub __update_renamed_vardecl { my ($Sf, $var, $qvar) = @_;
    my $orig_set = in_nested_set($Sf,'Vars', $var);
    my $decl = get_var_record_from_set($Sf->{$orig_set},$var);
    $decl->{'OrigName'}=$var;
    $decl->{'Name'}=$qvar;
    $Sf->{$orig_set}{'Set'}{$qvar}=$decl;
    $Sf->{$orig_set}{'List'} = [map {$_ eq $var? $qvar : $var } @{$Sf->{$orig_set}{'List'}}];
    return $Sf;
}

# This routine updates the records
sub __update_caller_inlined_vardecl_records { my ($stref,$f,$sub,$specification_part) = @_;
    for my $annline (@{$specification_part}) {
        my ($line,$info) = @{$annline};
        # say "$sub in $f:". Dumper $info if $line=~/rhs/;
        next if exists $info->{'Comments'};
        next if exists $info->{'Blank'};

        my ($qvar, $is_param) = exists $info->{'VarDecl'}
            ? ($info->{'VarDecl'}{'Name'},0)
            : exists $info->{'ParamDecl'}
            ? exists $info->{'ParamDecl'}{'Var'}
                ? ($info->{'ParamDecl'}{'Var'},1)
                : exists $info->{'ParamDecl'}{'Name'}
                    ? ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY'
                        ?($info->{'ParamDecl'}{'Name'}[0],1)
                        : ($info->{'ParamDecl'}{'Name'},1)
                    : croak "Specification line is not a variable declaration: ". Dumper($annline)
            : croak "Specification line is not a variable declaration: ". Dumper($annline);
        my $subset = in_nested_set($stref->{'Subroutines'}{$sub},'Vars',$qvar);
        my $decl = get_var_record_from_set($stref->{'Subroutines'}{$sub}{$subset},$qvar);
        # croak;
        # say "Adding $qvar to DeclaredOrigLocalVars in $f";
        # carp "ARG? $qvar: ". Dumper( $decl ) if exists $decl->{'ConstDim'};
        if (not $is_param) {

            $stref->{'Subroutines'}{$f}{'DeclaredOrigLocalVars'}{'Set'}{$qvar}=dclone($decl);
        } else {
            $stref->{'Subroutines'}{$f}{'LocalParameters'}{'Set'}{$qvar}=dclone($decl);
        }
    }
    return $stref;
}

sub _replace_call_with_var { (my $ast, my $var) = @_;

  if(scalar @{$ast}==0) {
      return $ast;
  }

  if ( ($ast->[0] & 0xFF) == 1 or
       ($ast->[0] & 0xFF) == 10 ) { # array var or function/subroutine call
       if ($ast->[0]== 1) {
            my $call_str = emit_expr_from_ast($ast);

            $call_str=~s/\W/_/g;
            if ($call_str eq $var) {
                $ast = [2,$var];
            }
       } else {
		my $entry = _replace_call_with_var($ast->[2], $var);
		$ast->[2] = $entry;
        }
  } elsif (($ast->[0] & 0xFF) == 2) { # scalar variable
	#
  } elsif (($ast->[0] & 0xFF) > 28) { # constants
	#
  } else { # other operators
	# $acc=$f->($ast,$acc);
	for my $idx (1 .. scalar @{$ast}-1) {
		my $entry = _replace_call_with_var($ast->[$idx], $var);
		$ast->[$idx] = $entry;
	}
  }

  return $ast;

} # END of _replace_call_with_var

sub _remove_duplicate_declarations { my ($stref,$f) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'};

    my $pass_remove_duplicate_declarations = sub { my ($annline,$state) = @_;
        my ($line, $info) = @{$annline};
        # say "LINE: $line";
        if (exists $info->{'Comments'}) {
            $info ={'Deleted'=>1};
        }
        elsif (exists $info->{'VarDecl'}) {
            my $var_name = $info->{'VarDecl'}{'Name'};

            if (exists $state->{'DeclaredVars'}{$var_name}) {
                say "_remove_duplicate_declarations $f: Delete $var_name decl: ".$line;
                $info ={'Deleted'=>1};
                $line = '! '.$line;
            } else {
                # say Dumper($info);
                $state->{'DeclaredVars'}{$var_name}=1;
                # die if $var_name eq 'nou7';
            }
        }
        elsif (exists $info->{'ParamDecl'}) {
            # say "ParamDecl LINE: $line " .Dumper( $info->{'ParamDecl'});
            my $par_name = ref($info->{'ParamDecl'}{'Name'}) eq 'ARRAY'
            ? $info->{'ParamDecl'}{'Name'}[0]
            : $info->{'ParamDecl'}{'Name'};
            if (exists $state->{'DeclaredVars'}{$par_name}) {
                # say 'EXISTS:' .Dumper $state->{'DeclaredVars'}{$par_name};
                say "_remove_duplicate_declarations $f: Delete $par_name decl: ".$line;
                $info ={'Deleted'=>1};
                $line = '! '.$line;
            } else {
                # say 'SETTING DeclaredVars: '.$par_name;
                    $state->{'DeclaredVars'}{$par_name}=111;
            }
        }

        return ([[$line,$info]],$state)
    };

    my $state = {'DeclaredVars'=>{}};

    (my $new_annlines,$state) = stateful_pass($annlines,$pass_remove_duplicate_declarations,$state,"pass_remove_duplicate_declarations($f)");
    $Sf->{'RefactoredCode'} = $new_annlines;
    return $stref;
} # END of _remove_duplicate_declarations

sub _remove_redundant_modules { my ($stref,$f) =@_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'};

    croak Dumper $f;# keys %{$Sf};
}

1;
