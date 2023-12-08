package RefactorF4Acc::Refactoring::Blocks;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::State qw( initialise_per_code_unit_tables );
use RefactorF4Acc::Parser qw( parse_fortran_src );
use RefactorF4Acc::Analysis::Variables qw( identify_vars_on_line );
use RefactorF4Acc::Refactoring::Helpers qw( get_f95_var_decl get_f95_par_decl emit_f95_var_decl);
use RefactorF4Acc::Parser::Expressions qw( emit_expr_from_ast parse_expression_no_context get_vars_from_expression);

#
#   (c) 2010-2019 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Blocks::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Blocks::EXPORT_OK = qw(
  &refactor_marked_blocks_into_subroutines
);

=pod

=begin markdown

### Factoring out code blocks into subroutines

The blocks are marked with a pragma

$RF4A Subroutine $sub_name
...
$RF4A End Subroutine

=end markdown

=cut

# -----------------------------------------------------------------------------
sub refactor_marked_blocks_into_subroutines {
    ( my $stref ) = @_;

    #   local $V=1;
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        next if exists $stref->{'Entries'}{$f};
        if ( exists $stref->{'Subroutines'}{$f}{'HasBlocks'}
            and $stref->{'Subroutines'}{$f}{'HasBlocks'} == 1 ) { # TODO: this check should be redundant

            say "refactor_marked_blocks_into_subroutines(): PARSING $f" if $V;

            my $sub_or_incl_or_mod = sub_func_incl_mod( $f, $stref );
            my $is_incl = $sub_or_incl_or_mod eq 'IncludeFiles';
            my $is_external_include = $is_incl ? ( $stref->{'IncludeFiles'}{$f}{'InclType'} eq 'External' ) : 0;

            say "SRC TYPE for $f: $sub_or_incl_or_mod" if $V;

            if ( $sub_or_incl_or_mod ne 'ExternalSubroutines'
                and not $is_external_include ) {
                ## 5. Parse subroutine and function calls
                if ( not $is_incl ) {
                    if ( $stref->{$sub_or_incl_or_mod}{$f}{'HasBlocks'} == 1 ) {
                        $stref = _separate_blocks( $f, $stref );
                    }
                }
            } else {
                say "INFO: $f is EXTERNAL" if $I;
            }
            say "LEAVING refactor_marked_blocks_into_subroutines( $f ) with Status $stref->{$sub_or_incl_or_mod}{$f}{'Status'}" if $V;
        }
    }

    return $stref;

}    # END of refactor_marked_blocks_into_subroutines()
# -----------------------------------------------------------------------------

#WV20150701 This routine is very early here and it is BROKEN: common block variables don't get declarations!
sub _separate_blocks {
    ( my $f, my $stref ) = @_;

    #    local $V = 1;

    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf                 = $stref->{$sub_or_func_or_mod}{$f};
    my $srcref             = $Sf->{'AnnLines'};

    $Data::Dumper::Indent = 2;

    # All variables in the parent subroutine with their declaration records
    my $varsref = get_vars_from_set( $Sf->{'Vars'} );

    # Occurence of variables per block
    my $occsref  = {};
    # Iterators for DO-loops are separate to turn them into locals
    my $itersref = {};

    my $paramsref = {};
    # TODO: Local vars should be separate to declare them locally
    my $localvarsref = {};
    # A map of every block in the parent
    my $blocksref = []; # Just an array


    # 1. Process every line in $f, scan for blocks marked with pragmas.
    # What this does is to separate the code into blocks ($blocksref) and keep track of the line numbers
    # The lines with the pragmas occur both in OUTER and the block

    $blocksref  = __separate_into_blocks( $stref, $blocksref, $f );




    # 2. For all non-OUTER blocks, create an entry for the new subroutine in 'Subroutines'
    # Based on the content of $blocksref

    $stref = __create_new_subroutine_entries( $stref, $blocksref, $f );

    # 3. Identify which vars are used
    #   - in both => these become function arguments
    #   - only in "outer" => do nothing for those
    #   - only in "inner" => can be removed from outer variable declarations
    #
    # Find all vars used in each block, starting with the outer block
    # It is best to loop over all vars per line per block, because we can remove the encountered vars
    # TODO: no need to declare $occsref and $paramsref at this level as they are empty!
    ( $occsref, $itersref, $paramsref ) = @{ __find_vars_in_block( $stref, $f, $blocksref, $varsref, $occsref, $paramsref ) };
    # 4. Construct the subroutine signatures
    # This happens before reparsing so the data structures for the Decls and Args are emtpty! So need to call the init here!
    $stref = __construct_new_subroutine_signatures( $stref, $blocksref, $occsref, $itersref, $paramsref, $varsref, $f );

    $stref = __reparse_extracted_subroutines( $stref, $blocksref );
    $stref = __add_module_declaration( $stref, $f, $blocksref );
    # So at this point, the module has the extracted subroutine but it has not yet been refactored

    $blocksref = __find_called_subs_in_OUTER($blocksref);

    $stref = __update_caller_datastructures( $stref, $f, $blocksref );


    return $stref;
}    # END of _separate_blocks()

# -----------------------------------------------------------------------------

sub __find_called_subs_in_OUTER {
    ( my $blocksref ) = @_;
    for my $block_rec ( @{$blocksref}) {
        my $block = $block_rec->{'Name'};
        if ($block eq 'OUTER') {
            for my $annline ( @{ $block_rec->{'AnnLines'} } ) {
                ( my $line, my $info ) = @{$annline};
                if ( exists $info->{'SubroutineCall'}
                and $info->{'SubroutineCall'}{'Name'}
                ) {
                    push @{ $block_rec->{'CalledSubs'}{'List'} }, $info->{'SubroutineCall'}{'Name'};
                    $block_rec->{'CalledSubs'}{'Set'}{ $info->{'SubroutineCall'}{'Name'} } = [1,1];
                    # Now test if this is maybe an ENTRY -- UGH! TODO!
                }
                if ( exists $info->{'FunctionCalls'} ) {
                    for my $fcall_rec (@{ $info->{'FunctionCalls'} } ) {
                        my $fname =  $fcall_rec->{'Name'};
                    push @{ $block_rec->{'CalledSubs'}{'List'} }, $fname ;
                    $block_rec->{'CalledSubs'}{'Set'}{ $fname  } = [1,1];
                    }
                }
            }
        }
    }

    return $blocksref;
}

# -----------------------------------------------------------------------------
sub __separate_into_blocks {
    ( my $stref, my $blocksref, my $f ) = @_;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );    # This is not a misnomer as it can also be a module.
    my $Sf       = $stref->{$sub_or_func_or_mod}{$f};
    my $srcref   = $Sf->{'AnnLines'};
    my $in_block = 0;

    # Initial settings
    my $block = 'OUTER';
    my $block_rec={};
    $block_rec->{'AnnLines'}=[];
    $block_rec->{'Name'}='OUTER';
    for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];

        if ( exists $info->{'Pragmas'}{'BeginSubroutine'} ) {
            # Push the line with the pragma onto the list of 'OUTER' lines
            push @{ $block_rec->{'AnnLines'} }, [ "! *** Refactored code into $block ***", {} ];
            push @{ $blocksref }, $block_rec;
            $block_rec={};
            $in_block = 1;
            $block = $info->{'Pragmas'}{'BeginSubroutine'}[0];
            print "FOUND BLOCK $block\n" if $V;

            # Enter the name of the block in the metadata for the line
            $info->{'RefactoredSubroutineCall'}{'Name'} = $block;
            $info->{'SubroutineCall'}{'Name'}           = $block;
            delete $info->{'Comments'};
            $info->{'BeginBlock'}{'Name'} = $block;


           # Push the line with the pragma onto the list of lines for the block,
           # to be replaced by function signature
           $block_rec->{'AnnLines'}=[];
           $block_rec->{'Name'}=$block;

           # WV 2021-06-08 Somehow the info gets wiped later on!
           push @{ $block_rec->{'AnnLines'} },
              [
                "! === Original code from $f starts here ===",
                { 'RefactoredSubroutineCall' => { 'Name' => $block },
                'Comments' =>1
                }
              ];
            $block_rec->{'BeginBlockIdx'} = $index;
            next;
        } elsif ( exists $info->{'Pragmas'}{'EndSubroutine'} ) {
            # Push 'end' onto the list of lines for the block
            push @{ $block_rec->{'AnnLines'} },  [ '      end subroutine ' . $block, dclone($info) ];
            $block_rec->{'EndBlockIdx'} = $index;
            push @{ $blocksref }, $block_rec;
            $block_rec={};
            $in_block = 0;
            $block = $info->{'Pragmas'}{'EndSubroutine'}[0];
            $block_rec->{'Name'} = 'OUTER';
            push @{ $block_rec->{'AnnLines'} }, [ $line, {} ];
            $info->{'EndBlock'}{'Name'} = $block;
            next;
        }


        if ($in_block==1) {
            # Push the line onto the list of lines for the block
            push @{ $block_rec->{'AnnLines'} }, [ $line, dclone($info) ];
            $info->{'InBlock'}{'Name'} = $block;
            my $module = 'singleton_module_'.$block;
            $stref->{'Modules'}{$module}{'ExtractedSubroutine'}=$block;
            $stref->{'Subroutines'}{$block}{'InModule'}=$module;
            if (exists $info->{'SubroutineCall'}) {
                my $subname = $info->{'SubroutineCall'}{'Name'};
                my $container = $stref->{'Subroutines'}{$subname}{'Container'};
                $stref->{'Subroutines'}{$block}{'Containers'}{$container}=$subname;
                if (exists $stref->{'Subroutines'}{$subname}{'InModule'}) {
                    my $mod =  $stref->{'Subroutines'}{$subname}{'InModule'};
                    $stref->{'Subroutines'}{$block}{'InModules'}{$mod}=$subname;
                }
            }
            # Now we must make sure this new module inherits the USE statements from the modules of any called subs
            # But it is simpler to create a list of those modules, analogous to the Container/Containers approach

        } else {
            # Other lines go onto 'OUTER'
            push @{ $block_rec->{'AnnLines'} }, [ $line, $info ];
        }

        $srcref->[$index] = [ $line, $info ];
    }    # loop over annlines
    $block_rec->{'EndBlockIdx'} = scalar( @{$srcref} ) ;

    push @{ $blocksref }, $block_rec;
    return $blocksref;

}    # END of __separate_into_blocks()


# -----------------------------------------------------------------------------
sub __create_new_subroutine_entries {
    ( my $stref, my $blocksref, my $f ) = @_;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_mod}{$f};
    # Each extracted subroutine should be put in the same folder as the source of $f
    # A bit ugly, but should be ok:
    my $srcdir = $stref->{'Subroutines'}{$f}{'Source'};
    $srcdir=~s/\w+\.\w+$//;
    $srcdir=~s/\/$//;
    for my $block_rec ( @{$blocksref} ) {

        my $block = $block_rec->{'Name'};
        #        say "\tBLOCK: $block";
        die "EMPTY block name $block" if $block eq '';
        next if $block eq 'OUTER';
        if ( not exists $stref->{'Subroutines'}{$block} ) {
            $stref->{'Subroutines'}{$block} = {};
        }
        $stref->{'Subroutines'}{$block}{'Source'} =
              "$srcdir/$block".$Config{EXT};
            #   carp $block,$stref->{'Subroutines'}{$block}{'Source'} ;
        # } else {
        #     croak Dumper $stref->{'Subroutines'}{$block};
        # }

        my $Sblock = $stref->{'Subroutines'}{$block};
        $Sblock->{'AnnLines'} = [ @{ $block_rec->{'AnnLines'} } ];    # a copy
        my $line_id = 0;
        for my $annline ( @{ $Sblock->{'AnnLines'} } ) {
            $annline->[1]{'LineID'} = $line_id++;
        }

        my $src = "$srcdir/$block".$Config{EXT};
        push @{ $stref->{'SourceContains'}{$src}{'List'} }, $block;
        push @{ $stref->{'SourceContains'}{$src}{'List'} }, 'singleton_module_'.$block;# WV2023-10-09 added

        $stref->{'SourceContains'}{$src}{'Set'}{$block}='Subroutines';
        $stref->{'SourceContains'}{$src}{'Set'}{'singleton_module_'.$block}='Modules'; # WV2023-10-09 added
        $stref->{'SourceContains'}{$src}{'Path'}{'Local'}=$src;


        $stref->{'SourceFiles'}{$src}{'SourceType'}='Modules';# WV2023-10-09 was 'Subroutines'
        $stref->{'Modules'}{ 'singleton_module_'.$block }{'Contains'} = [$block];# WV2023-10-09 added
        $stref->{'Modules'}{ 'singleton_module_'.$block }{'Status'} = $FROM_BLOCK;
        $stref->{'BuildSources'}{'F'}{$src}=1;
        $Sblock->{'RefactorGlobals'} = 1;
        $stref->{'Subroutines'}{$block} = $Sblock;
        if ( $Sf->{'RefactorGlobals'} == 0 ) {
            croak "Should be obsolete" if $DBG;
            $Sf->{'RefactorGlobals'} = 2;
        } else {
            say "INFO: RefactorGlobals==1 for $f while processing BLOCK $block" if $I;
        }

        $Sblock->{'Program'}     = 0;
        $Sblock->{'FStyle'}      = $Sf->{'FStyle'};
        $Sblock->{'FreeForm'}    = $Sf->{'FreeForm'};
        $Sblock->{'Recursive'}   = 0;
        $Sblock->{'Callers'}{$f} = [ $block_rec->{'BeginBlockIdx'} ];
        # WV20230510 This is to ensure Used parameters is OK
        # croak Dumper  $Sf->{'Parameters'};
        $Sblock->{'Parameters'} = $Sf->{'Parameters'};

    }
    return $stref;
}    # END of __create_new_subroutine_entries()
# -----------------------------------------------------------------------------
# TODO: see if this can be separated into shorter subs
# FIXME 20170516: need includes for params in decls. Problem is, if we use COMMON blocks in the original subroutine, then there are no args so no decls.
# So I need to check if vars used in the new sub are commons
# As this belongs with _separate_blocks, I see no reason to keep declarations in $info
sub __construct_new_subroutine_signatures {
    ( my $stref, my $blocksref, my $occsref, my $itersref, my $paramsref, my $varsref, my $f ) = @_;

    #   local $V = 1;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );    # This is not a misnomer as it can also be a module.
    my $Sf     = $stref->{$sub_or_func_or_mod}{$f};

    my $args = {};
    my $localvars = {};

    for my $block_rec ( @{$blocksref} ) {
        my $block =$block_rec->{'Name'};
        next if $block eq 'OUTER';

        my $Sblock = $stref->{'Subroutines'}{$block};

        $Sblock = initialise_per_code_unit_tables( $Sblock, $stref, $block, 0 , 0, 1); # 1 means skip params

        # Collect args for new subroutine
        ($Sblock, $args, $localvars) = __collect_args_for_new_sub($Sf,$Sblock,$block,$occsref,$varsref,$args,$localvars);

        # Create Signature and corresponding Decls
        ($Sblock,my $sigrec, my $sig) = __create_sig_and_decls($stref, $f,$Sblock,$block,$args);

        # Add variable declarations and info to line
        $Sblock = __add_vardecls_and_info_to_AnnLines($stref,$f,$Sf,$Sblock,$block,$itersref,$varsref,$paramsref,$localvars,$args);

        # Now also add include statements and the actual sig to the line
        $Sblock = __add_include_statements_and_sig_to_AnnLine($stref, $Sf,$Sblock, $sig, $sigrec, $block);


        # And finally, in the original source, replace the blocks by calls to the new subs
        $Sf = __replace_blocks_by_calls_to_new_subs($Sf,$f,$Sblock,$block_rec,$sig,$sigrec);

        if ($V) {
            print 'SIG:' . $sig, "\n";
        }
        $Sblock->{'Status'} = $READ;
        # WV20190722 I added this to stop the refactoring of the call line
        $Sblock->{'ExtractedSubroutine'}=1;
        $stref->{'Subroutines'}{$block} = $Sblock ;
    }

    return $stref;
}    # END of __construct_new_subroutine_signatures()



# -----------------------------------------------------------------------------
sub __reparse_extracted_subroutines {
    ( my $stref, my $blocksref ) = @_;
    for my $block_rec (@{$blocksref} ) {
        my $block = $block_rec->{'Name'};
        next if $block eq 'OUTER';
        say "REPARSING $block" if $V;
        $stref = parse_fortran_src( $block, $stref );
    }
    return $stref;
}

# -----------------------------------------------------------------------------
sub __update_caller_datastructures {
    ( my $stref, my $f, my $blocksref ) = @_;

    # Create new CalledSubs for $f

    my @called_subs=();
    for my $block_rec ( @{$blocksref} ) {
        my $block = $block_rec->{'Name'};

         if ($block eq 'OUTER' ) {
            if ( exists $block_rec->{'CalledSubs'} and exists $block_rec->{'CalledSubs'}{'List'}) {
                @called_subs = ( @called_subs, @{ $block_rec->{'CalledSubs'}{'List'} } );
            }
         } else {
            @called_subs = ( @called_subs,$block );


        $stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'}=[@called_subs];
        $stref->{'Subroutines'}{$f}{'CalledSubs'}{'Set'} = { map { $_ => [1,1]} @called_subs };
        my $src = $stref->{'Subroutines'}{$block}{'Source'};
        $stref->{'SourceContains'}{$src}{'List'} =[ @{ $stref->{'SourceContains'}{$src}{'List'} }, @called_subs];
        map { $stref->{'SourceContains'}{$src}{'Set'}{$_}='Subroutines' } @called_subs;
         }
    } # for each block




    $stref->{'CallTree'}{$f}=[@{$stref->{'Subroutines'}{$f}{'CalledSubs'}{'List'}}];
    return $stref;
}    # END of __update_caller_datastructures()
# -----------------------------------------------------------------------------
sub __add_module_declaration { my ( $stref, $f, $blocksref ) = @_;

for my $block_rec ( @{$blocksref} ) {
		my $block = $block_rec->{'Name'};
        next if $block eq 'OUTER';
        $stref->{'Modules'}{ 'singleton_module_'.$block }{'AnnLines'} = [
            ["module singleton_module_$block",{'Module' => 'singleton_module_'.$block}],
            ["contains",{'Contains' => 1}],
            @{ $stref->{'Subroutines'}{$block}{'AnnLines'}},
            ["end module singleton_module_$block",{'EndModule' => 'singleton_module_'.$block}],
        ];
}
return $stref;
}

# -----------------------------------------------------------------------------
#
# So what this does is find occurences of existing variables and also of iterator variables
# The iter variables are declared locally inside the new subroutine, all others are args.
# Of course it should be only the vars that occur outside the block
# The "Iter" approach is incomplete because we should really identify any variable used as a local variable
# If we find a variable in the outer blocks, it could still be a local
#
sub __find_vars_in_block {# warn "This should use the same code as RefactorF4A::Analysis:: _analyse_variables"
	my ( $stref, $f, $blocksref, $varsref, $occsref, $paramsref ) = @_;
    my $sub_or_func_or_mod = sub_func_incl_mod( $f, $stref );
    my $Sf = $stref->{$sub_or_func_or_mod}{$f};

	my $itersref = {};

	for my $block_rec ( @{$blocksref} ) {
		my $block = $block_rec->{'Name'};

		$itersref->{$block} = [];
		my @annlines = @{ $block_rec->{'AnnLines'} };
		my %tvars = %{$varsref};    # Hurray for pass-by-value!

		print "\nVARS in $block:\n\n" if $V;
		for my $annline (@annlines) {
            ( my $tline, my $info ) = @{$annline};
			if ( exists $info->{'Do'} ) {
				my $iter = $info->{'Do'}{'Iterator'};
				push @{ $itersref->{$block} }, $iter;
				delete $tvars{$iter};

				for my $var_in_do ( @{ $info->{'Do'}{'Range'}{'Vars'} } ) {
					if ( exists $tvars{$var_in_do} ) {
						print "FOUND $var_in_do\n" if $V;
                        if (exists $varsref->{$var_in_do}{'Parameter'}
                        and not exists $Sf->{'UsedParameters'}{'Set'}{$var_in_do}
                        ) {
                            $paramsref->{$block}{$var_in_do}=$var_in_do;
                        } else {
                            $occsref->{$block}{$var_in_do}=$var_in_do;
                        }
						delete $tvars{$var_in_do};
					}
				}
            } else {
                my $vars_on_line_ref=identify_vars_on_line($annline);

                for my $var_on_line (@{$vars_on_line_ref}) {
                    if  ( exists $tvars{$var_on_line} ) {
                        if (exists $varsref->{$var_on_line}{'Parameter'}
                        and not exists $Sf->{'UsedParameters'}{'Set'}{$var_on_line}
                        ) {
                            $paramsref->{$block}{$var_on_line}=$var_on_line;
                        } else {
                            $occsref->{$block}{$var_on_line}=$var_on_line;
                            if ($block ne 'OUTER') {
                                my $subset = in_nested_set($Sf,'Vars',$var_on_line);
                                # say "SUBSET: $subset for $var_on_line";
                                my $decl = get_var_record_from_set($Sf->{$subset},$var_on_line);
                                if (exists $decl->{'Dim'} and scalar @{$decl->{'Dim'}}>0 ) { # A non-empty Dim record, so it is an array
                                    # Quick and dirty
                                    my $expr_str = '('.join(',',map {$_->[0].','.$_->[1]} @{$decl->{'Dim'}}).')';

                                    my ($ast,$str,$error,$has_funcs)=parse_expression_no_context($expr_str);
                                    my $pars_in_var_decl=get_vars_from_expression($ast,{});
                                    for my $par_in_decl (keys %{$pars_in_var_decl}) {
                                        my $subset = in_nested_set($Sf,'Vars',$par_in_decl);
                                        if ($subset eq 'LocalParameters') {
                                            $paramsref->{$block}{$par_in_decl}=$par_in_decl;
                                        }
                                # say "SUBSET: $subset for $par_in_decl";
                                # my $decl = get_var_record_from_set($Sf->{$subset},$par_in_decl);
                                    }
                                }
                            }
                        }
                        delete $tvars{$var_on_line};
                        # say "Adding $var_on_line to occsref->{$block} ". __FILE__.' '.__LINE__ ;

                    }
                }
            }
        }
	} # for each block

	return [ $occsref, $itersref, $paramsref ];
}    # END of __find_vars_in_block() keys %{$

sub __emit_param_lines { my ($Sblock, $varsref, $params, $param_decl_generated, $param_annlines, $block, $f)=@_;

    for my $param ( sort keys %{$params} ) {
        # say "PAR $param";
        if (not exists $param_decl_generated->{$param}) {
            my $decl = $varsref->{$param};
            if (exists $decl->{'InheritedParams'} and exists $decl->{'InheritedParams'}{'Set'}) {
                # say "has InheritedParams:";

                for my $ip (sort keys %{$decl->{'InheritedParams'}{'Set'}}) {
                    # say "INHERITED PAR <$ip>" .Dumper($Sblock->{'Source'});
                    # carp "Only do this if the params are not declared via USE!";
                    $param_annlines = __emit_param_lines($Sblock, $varsref, {$ip=>$ip},  $param_decl_generated, $param_annlines, $block, $f);

                #     if (not exists $Sblock->{'LocalParameters'}{'Set'}{$ip}) {
                # $Sblock->{'LocalParameters'}{'Set'}{$param}  = $decl;
                #     }

                }
            } #else {
                # say "EMIT!";
                # say "Added $param decl to ".Dumper($Sblock->{'Source'});
                # carp Dumper($decl);
                $Sblock->{'LocalParameters'}{'Set'}{$param}  = $decl;
                push @{ $Sblock->{'LocalParameters'}{'List'} }, $param;
                if (not exists $decl->{'AST'}
                ) {
                    die __PACKAGE__ . ' ' . __LINE__ ." :  No AST for declaration of $param in block $block of $f";
                }
                my $val = emit_expr_from_ast($decl->{'AST'});

                my $param_annline = [
                        # emit_f95_var_decl($decl),
                        $decl->{'Indent'}."parameter($param=$val) ! FIXME: F95",
                        {
                            'ParamDecl' => {'Name' => $decl->{'Var'}},
                            'Ann'     => ['__construct_new_subroutine_signatures '
                            . __LINE__]
                        }
                ];
                $param_decl_generated->{$param}=1;
                push @{$param_annlines}, $param_annline;
           # }
        }
        # else {
        #     say " already done";

    }
    return $param_annlines;
    carp "Only do this if the params are not declared via USE!" if $DBG;
} # END of __emit_param_lines

sub __collect_args_for_new_sub { my ($Sf,$Sblock,$block,$occsref,$varsref,$args,$localvars) = @_; # return ($Sblock,$args,$localvars);
        say "\nARGS for BLOCK $block:" if $V;
        $args->{$block} = [];
        $localvars->{$block} = [];
    # Collect args for new subroutine
    # At this stage, if a var is COMMON, it should not become an argument.
        my $varset='Vars';
    for my $var ( sort keys %{ $occsref->{$block} } ) {
        say "VAR $var " if $V;
        if ( exists $occsref->{'OUTER'}{$var} ) {
            if ( not exists $Sf->{'UsedParameters'}{'Set'}{$var}
            and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$var}
            and not exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}
            ) {
                say "is ARG" if $V;
                push @{ $args->{$block} }, $var;
#$varset = 'DeclaredOrigArgs';
            }
        } else {
            # WV20190722 We must check if the var is not used by any of the other subs!
            my $var_used_in_other_block=0;
            for my $other_block (sort keys %{ $occsref }) {
                next if $other_block eq 'OUTER';
                next if $other_block eq $block;
                if ( exists $occsref->{$other_block}{$var} ) {
                    $var_used_in_other_block=1;
                    if ( not exists $Sf->{'UsedParameters'}{'Set'}{$var}
                    and not exists $Sf->{'DeclaredCommonVars'}{'Set'}{$var}
                    and not exists $Sf->{'UndeclaredCommonVars'}{'Set'}{$var}
                    ) {
                        say "is ARG" if $V;
                        push @{ $args->{$block} }, $var;
#                       $varset = 'DeclaredOrigArgs';
                        last;
                    }
                }
            }
            if (not $var_used_in_other_block) { # It's a local var
                push @{ $localvars->{$block} }, $var;
#               $varset = 'DeclaredOrigLocalVars';
            }
        }
        $Sblock->{$varset}{$var} = $varsref->{ $var }; # FIXME: this is "inheritance, but in principle a re-parse is better?"
    }

    # We declare them right away
    $Sblock->{'DeclaredOrigArgs'}{'List'} = $args->{$block};
    return ($Sblock,$args,$localvars);
} # END of __collect_args_for_new_sub

# Create Signature and corresponding Decls
sub __create_sig_and_decls { my ($stref, $f,$Sblock,$block,$args) = @_; # return ($Sblock,$sigrec,$sig);

    my $sixspaces = ' ' x 6;
    my $sig       = $sixspaces . 'subroutine ' . $block . '(';
    my $sigrec    = {};

    $sigrec->{'Args'}{'List'} = $args->{$block};
    $sigrec->{'Args'}{'Set'}  = { map { $_ => $Sblock->{'Vars'}{$_} } @{ $args->{$block} } };

    $sigrec->{'Name'}         = $block;
    $sigrec->{'Function'}     = 0;
    for my $argv ( @{ $args->{$block} } ) {
        $sig .= "$argv,";
        my $decl = get_f95_var_decl( $stref, $f, $argv );
        $decl->{'Indent'} .= $sixspaces;

        $Sblock->{'DeclaredOrigArgs'}{'Set'}{$argv} = $decl;
    }
    if ( @{ $args->{$block} } ) {
        $sig =~ s/\,$/)/s;
    } else {
        $sig .= ')';
    }

    return ($Sblock,$sigrec,$sig);

} # END of __create_sig_and_decls

 # Add variable declarations and info to line
sub __add_vardecls_and_info_to_AnnLines { my ($stref,$f,$Sf,$Sblock,$block,$itersref,$varsref,$paramsref,$localvars,$args) = @_; # return $Sblock;

        # Here we know the vardecls have been formatted.
        my $sigline = shift @{ $Sblock->{'AnnLines'} }; # This is the line that says "! === Original code from $f starts here ==="

        for my $iters ( $itersref->{$block} ) {
            for my $iter ( @{$iters} ) {
                my $decl = get_f95_var_decl( $stref, $f, $iter );
                $Sblock->{'LocalVars'}{'Set'}{$iter}             = $decl;    #
                $Sblock->{'DeclaredOrigLocalVars'}{'Set'}{$iter} = $decl;
                push @{ $Sblock->{'DeclaredOrigLocalVars'}{'List'} }, $iter;

                unshift @{ $Sblock->{'AnnLines'} },
                  [
                    emit_f95_var_decl($decl),
                    {
                        'VarDecl' => {'Name' => $decl->{'Name'}},
                        'Ann'     => ['__construct_new_subroutine_signatures '
                          . __LINE__]
                    }
                  ];
            }
        }

        for my $var ( @{ $localvars->{$block} } ) {

            my $set = in_nested_set($Sf,'Vars',$var);
            my $decl = get_var_record_from_set( $Sf->{$set}, $var );
            $Sblock->{'LocalVars'}{'Set'}{$var}             = $decl;    #
            $Sblock->{'DeclaredOrigLocalVars'}{'Set'}{$var} = $decl;
            push @{ $Sblock->{'DeclaredOrigLocalVars'}{'List'} }, $var;

            unshift @{ $Sblock->{'AnnLines'} },
              [
                emit_f95_var_decl($decl),
                {
                    'VarDecl' => {'Name' => $decl->{'Name'}},
                    'Ann' => [ '__construct_new_subroutine_signatures ' . __LINE__ ]
                }
              ];
        }

        for my $argv ( @{ $args->{$block} } ) {
            my $set = in_nested_set($Sblock,'OrigArgs',$argv);
            if (!$set) {croak "$argv is not in OrigArgs: Vars = ".Dumper($Sblock->{'Vars'}) }
            my $decl = get_var_record_from_set( $Sblock->{$set}, $argv );
            unshift @{ $Sblock->{'AnnLines'} },
              [
                emit_f95_var_decl($decl),
                {
                    'VarDecl' => {'Name' => $decl->{'Name'}},
                    'Ann' => [ '__construct_new_subroutine_signatures ' . __LINE__ ]
                }
              ];
        }

        if (exists $paramsref->{$block}) {
        my %params = %{ $paramsref->{$block} };
        my $param_annlines = __emit_param_lines($Sblock, $varsref, \%params, {}, [], $block, $f);
        $Sblock->{'AnnLines'} = [ @{$param_annlines},  @{ $Sblock->{'AnnLines'} }];
        }
        unshift @{ $Sblock->{'AnnLines'} }, $sigline;
        return $Sblock;
} # END of __add_vardecls_and_info_to_AnnLines


# Now also add include statements and the actual sig to the line
sub __add_include_statements_and_sig_to_AnnLine { my ($stref, $Sf,$Sblock, $sig, $sigrec, $block)=@_; # return $Sblock;
        # WRONG!
        # $Sblock->{'AnnLines'}[0][1] = {};
        my $idx=0;
        for my $inc ( keys %{ $Sf->{'Includes'} } ) {
            $Sblock->{'Includes'}{$inc} = { 'LineID' => 2 };
            unshift @{ $Sblock->{'AnnLines'} },
              [ "      include '$inc'", { 'Include' => { 'Name' => $inc } } ];
              ++$idx;
        }

        for my $mod ( keys %{ $Sf->{'Uses'} } ) {

            if (  $stref->{'Modules'}{$mod}{'Inlineable'} == 1 ) {
            $Sblock->{'Uses'}{$mod} = { 'LineID' => 2 };
            my $line = "      use $mod ! sub __add_include_statements_and_sig_to_AnnLine { my ($stref, $Sf,$Sblock, $sig, $sigrec, $block)=@_; # return $Sblock;
";
            my $info = { 'Use' => { 'Name' => $mod, 'Inlineable' => {} }  };
            unshift @{ $Sblock->{'AnnLines'} }, [$line , $info ];
            ++$idx;
        }
        }
        unshift @{ $Sblock->{'AnnLines'} }, [ $sig, { 'Signature' => $sigrec } ];
        $Sblock->{'AnnLines'}[$idx][1]{'LineID'} = $idx;

        return $Sblock;
} # END of __add_include_statements_and_sig_to_AnnLine

# And finally, in the original source, replace the blocks by calls to the new subs
sub __replace_blocks_by_calls_to_new_subs { my ($Sf,$f,$Sblock,$block_rec,$sig,$sigrec) = @_; # return $srcref
    my $srcref = $Sf->{'AnnLines'};
    for my $tindex ( 0 .. scalar( @{$srcref} ) - 1 ) {
        if ( $tindex == $block_rec->{'BeginBlockIdx'} ) {
            my $call_line = $sig;
            $call_line =~ s/subroutine/call/;
            $call_line =~ s/\(\)//;
            $srcref->[$tindex][0] = $call_line;
            my $line = $srcref->[$tindex][0];
            my $info = $srcref->[$tindex][1];
            $info->{'SubroutineCall'} = { %{$sigrec} };
            $info->{'SubroutineCall'}{'ExpressionAST'} = [];
            # croak;
            $info->{'SubroutineCall'}{'Args'}=dclone($sigrec->{'Args'});
            $info->{'LineID'} = $Sblock->{'Callers'}{$f}[0];
            $info->{'ExtractedSubroutine'}=1;
            $info->{'Ann'}= [__FILE__.' '.__LINE__];
            $srcref->[$tindex]=[$line, $info];
        } elsif ( $tindex > $block_rec->{'BeginBlockIdx'}
            and $tindex <= $block_rec->{'EndBlockIdx'} )
        {
            $srcref->[$tindex][0] = '';
            $srcref->[$tindex][1]{'Deleted'} = 1;
        }
    }
    return $Sf;
} # END of __replace_blocks_by_calls_to_new_subs

1;
