#
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

package RefactorF4Acc::Preconditioning;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Parser::Expressions qw( get_vars_from_expression parse_expression emit_expr_from_ast );
use RefactorF4Acc::Refactoring::Helpers qw( splice_additional_lines_cond );
# use RefactorF4Acc::Parser qw( parse_fortran_src );

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Storable qw( dclone );

use Carp;
$Carp::Verbose = 1;
use Data::Dumper;

use Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(
  precondition_includes
  precondition_decls
  split_multiblock_common_lines
  precondition_subroutines_with_includes
);

# -----------------------------------------------------------------------------
# Preconditioning works at source level, so we should go through all source files
# Possible source files are Subroutines, Modules and IncludeFiles

#Modules|Subroutines|IncludeFiles
#SourceContains
#SourceFiles

# Main question is if a Module contains the AnnLines for its subs or not ...

sub precondition_includes {
    (my $stref) = @_;
    if ($I) {
        say '=' x 80;
        say "PRECONDITIONING";
        say '=' x 80;
    }
    # Inlining includes that are inside other includes. 
    for my $inc (keys %{$stref->{'IncludeFiles'}}) {
        next if $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'External';
        next if ( $stref->{'IncludeFiles'}{$inc}{'Status'} == $UNREAD ); # TODO: WARN!

        say "INFO: Check for includes to be inlined in $inc" if $I;
        my $stref = _inline_includes($stref, $inc);
        my $Sincf = $stref->{'IncludeFiles'}{$inc};
    }
    # Splitting out parameters and creating the ONLY list
    for my $inc (keys %{$stref->{'IncludeFiles'}}) {
        next if $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'External';
        next if ( $stref->{'IncludeFiles'}{$inc}{'Status'} == $UNREAD ); # TODO: WARN!

        my $Sincf       = $stref->{'IncludeFiles'}{$inc};
        my $has_commons = $stref->{'IncludeFiles'}{$inc}{'HasCommons'};
        my $has_pars    = $stref->{'IncludeFiles'}{$inc}{'HasParameters'};

        if ($has_commons && $has_pars) {
            print "INFO: The include file $inc contains both parameters and commons, attempting to split out params_$inc.\n"
              if $I;
            $Sincf->{'InclType'} = 'Both';
            $stref    = __split_out_parameters($inc, $stref);
            $stref    = __find_parameter_used_in_inc_and_add_to_Only($inc, $stref);
            $has_pars = 0;
        }
        elsif ($has_commons) {
            $Sincf->{'InclType'} = 'Common'; 
        }
        elsif ($has_pars) {
            $Sincf->{'InclType'} = 'Parameter';
        }
        else {
            say "WARNING: INC $inc does not seem to have either COMMON or PARAM!" if $W;
            $Sincf->{'InclType'} = 'None';
        }
    }

    return $stref;
}    # END of precondition_includes()

# -----------------------------------------------------------------------------
# TODO: check if this works for F95-style parameters too
sub __split_out_parameters {
    (my $f, my $stref) = @_;
    my $Sf          = $stref->{'IncludeFiles'}{$f};
    my $srcref      = $Sf->{'AnnLines'};
    my $param_lines = [];
    my $nsrcref     = [];
    my $nindex      = 0;
    my $nidx_offset = 0;

    push @{$nsrcref},
      [ "      include 'params_$f'",
        {   'Include' => {'Name' => "params_$f", 'InclType' => 'Parameter'},
            'Ann'     => [annotate($f, __LINE__)]
        }
      ];
      
# FIXME: if the parameter was declared before being defined, the declaration should also go into the params file
# So we need two passes: one to find all parameter definitions and get the names from there
    my %params_in_inc=();
    for my $index (0 .. scalar(@{$srcref}) - 1) {
        $nindex = $index + $nidx_offset;
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        if (exists $info->{'ParamDecl'}) {
            # say Dumper($info->{'ParamDecl'});
            for my $par_name (@{$info->{'ParamDecl'}{'Names'}}) {
                $params_in_inc{ $par_name }=1;
            }
        }                
    }
# Another one to get any declarations.
    for my $index (0 .. scalar(@{$srcref}) - 1) {
        $nindex = $index + $nidx_offset;
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        if (exists $info->{'ParamDecl'}) {

# split out parameters from 'Common' include file
            my $n_info = {};
            $n_info->{'ParamDecl'} = {%{$info->{'ParamDecl'}}};
            if (exists $info->{'PlaceHolders'}) {
                $n_info->{'PlaceHolders'} = {%{$info->{'PlaceHolders'}}};
            }
            push @{$param_lines}, [$line, $n_info];

            delete $srcref->[$index][1]{'ParamDecl'};
            $srcref->[$index][1]{'Comments'} = 1;
            $srcref->[$index][0] = '! ' . $srcref->[$index][0];
        }
        elsif (exists $info->{'VarDecl'}) { # Because the assumption is that it can't be a parameter declaration
        my $all_vars_are_pars=1;
        my $non_par_ct=0;
        my @non_par_vars=();
            for my $var (@{$info->{'VarDecl'}{'Names'}}) {
                if (not exists $params_in_inc{$var}) {
                    $all_vars_are_pars=0;                    
                    push @non_par_vars, $var;
                }                
            }
            if (scalar @non_par_vars > 0 and scalar @{$info->{'VarDecl'}{'Names'}}>1
            and scalar @non_par_vars != scalar @{$info->{'VarDecl'}{'Names'}}
            ) {
                warn "Not all vars are params: ".$line."\n<".join(',',@non_par_vars).'>';
            }
            if ($all_vars_are_pars) {
                # OK, move that line
                say "INFO: Moving vardecl line to params: $line" if $I;
                my $n_info = {};
                $n_info->{'VarDecl'} = {%{$info->{'VarDecl'}}};
                push @{$param_lines}, [$line, $n_info];
                delete $srcref->[$index][1]{'VarDecl'};
                $srcref->[$index][1]{'Comments'} = 1;
                $srcref->[$index][0] = '! ' . $srcref->[$index][0];                
            }

        }


        push @{$nsrcref}, $srcref->[$index];
    }
    $stref->{'IncludeFiles'}{$f}{'AnnLines'}          = $nsrcref;
    $stref->{'IncludeFiles'}{$f}{'ParamInclude'}      = "params_$f";
    $stref->{'IncludeFiles'}{"params_$f"}             = {};
    $stref->{'IncludeFiles'}{"params_$f"}{'AnnLines'} = $param_lines;
    $stref->{'IncludeFiles'}{"params_$f"}{'InclType'} = 'Parameter';
    $stref->{'IncludeFiles'}{$f}{'InclType'}          = 'Common';

    $stref->{'IncludeFiles'}{"params_$f"}{'LocalParameters'} =
      dclone($stref->{'IncludeFiles'}{$f}{'LocalParameters'});
    $stref->{'IncludeFiles'}{$f}{'LocalParameters'} =
      {'Set' => {}, 'List' => []};

    $stref->{'IncludeFiles'}{"params_$f"}{'Root'}            = $f;
    $stref->{'IncludeFiles'}{"params_$f"}{'Source'}          = 'Virtual';
    $stref->{'IncludeFiles'}{"params_$f"}{'Status'}          = $PARSED;
    $stref->{'IncludeFiles'}{"params_$f"}{'RefactorGlobals'} = $NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'HasBlocks'}       = $NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'FStyle'} =
      $stref->{'IncludeFiles'}{$f}{'FStyle'};
    $stref->{'IncludeFiles'}{"params_$f"}{'FreeForm'} =
      $stref->{'IncludeFiles'}{$f}{'FreeForm'};

    $stref->{'IncludeFiles'}{$f}{'Includes'}{"params_$f"} = {'Only' => {}};
    $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'} =
      dclone($stref->{'IncludeFiles'}{$f}{'Parameters'});
    $stref->{'IncludeFiles'}{"params_$f"}{'Vars'}{'Subsets'}{'Parameters'} =
      $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'};
    delete $stref->{'IncludeFiles'}{$f}{'Parameters'};
    delete $stref->{'IncludeFiles'}{$f}{'Vars'}{'Subsets'}{'Parameters'};
    return $stref;
}    # END of __split_out_parameters

# -----------------------------------------------------------------------------
# As we split out the parameters, and will turn both the split-out parameter include and the current include into a module, 
# we can have an import list for the parameters used in the non-param include, via ONLY. 
sub __find_parameter_used_in_inc_and_add_to_Only {
    (my $inc, my $stref) = @_;

    my $Sinc = $stref->{'IncludeFiles'}{$inc};

    my $srcref = $Sinc->{'AnnLines'};

    for my $index (0 .. scalar(@{$srcref}) - 1) {
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        next if exists $info->{'Comments'};
        next if exists $info->{'Skip'};
        if (exists $info->{'Include'}
            and $info->{'Include'}{'InclType'} eq 'Parameter')
        {
            my $param_inc = $info->{'Include'}{'Name'};
        }
        elsif (exists $info->{'VarDecl'}) { # Because the assumption is that it can't be a parameter declaration
            for my $var (@{$info->{'VarDecl'}{'Names'}}) {
                my $set = in_nested_set($Sinc,'Vars', $var);
                my $decl = get_var_record_from_set($Sinc->{'Vars'}, $var);
                if ($decl->{'ArrayOrScalar'} eq 'Array') {
                    my %dim_tmpstr    = map  { ($_->[0] => 1, $_->[1] => 1) } @{$decl->{'Dim'}};
                    my @maybe_parstrs = grep { !/^\-?\d+$/ } keys %dim_tmpstr;

                    if (@maybe_parstrs) {
                        my $maybe_pars_str = '(' . join(',', @maybe_parstrs) . ')'; 
                        # So now parse this if it's not empty
                        my $ast  = parse_expression($maybe_pars_str, {}, $stref, $inc);
                        my $pars = get_vars_from_expression($ast,    {});
                        for my $par (keys %{$pars}) {
                            
                            $Sinc->{'Includes'}{"params_$inc"}{'Only'}{$par} = 1;
                        }
                    }
                }
            }
        }
        elsif (exists $info->{'Common'}) {
            for my $var (@{$info->{'Common'}{'Vars'}{'List'}}) {
                my $decl = get_var_record_from_set($Sinc->{'Vars'}, $var);
                if ($decl->{'ArrayOrScalar'} eq 'Array') {
                    my %dim_tmpstr    = map  { ($_->[0] => 1, $_->[1] => 1) } @{$decl->{'Dim'}};
                    my @maybe_parstrs = grep { !/^\-?\d+$/ } keys %dim_tmpstr;
                    if (@maybe_parstrs) {
                        my $maybe_pars_str = '(' . join(',', @maybe_parstrs) . ')';
                        # So now parse this
                        my $ast  = parse_expression($maybe_pars_str, {}, $stref, $inc);
                        my $pars = get_vars_from_expression($ast,    {});
                        for my $par (keys %{$pars}) {
                            # say "params_$inc : ONLY $par";
                            $Sinc->{'Includes'}{"params_$inc"}{'Only'}{$par} = 1;
                        }
                    }
                }
            }
        }
        elsif (exists $info->{'Dimension'}) { # WHY?
            say "DIMENSION $line";
            say Dumper($info);
        }
    }

    return $stref;
}    # __find_parameter_used_in_inc_and_add_to_Only

# This should return an updated entry for $stref->{'IncludeFiles'}{$inc} if there are any includes to be inlined
# It is of course recursive
sub _inline_includes {
    (my $stref, my $inc) = @_;
    #of course, if the status is UNREAD then this does not work, and we must make sure we read it.
    if ( $stref->{'IncludeFiles'}{$inc}{'InclType'} ne 'External') {
        if (exists $stref->{'IncludeFiles'}{$inc}{'HasIncludes'} and
            $stref->{'IncludeFiles'}{$inc}{'HasIncludes'} == 1) {
            my @n_incs = __get_includes($stref, $inc);
            $stref->{'IncludeFiles'}{$inc}{'InlinedIncludes'} = [];
            for my $n_inc (@n_incs) {
                push @{$stref->{'IncludeFiles'}{$inc}{'InlinedIncludes'}}, $n_inc;
                $stref = _inline_includes($stref, $n_inc);
                # Now merge this into $Sincf
                $stref = __merge_include($stref, $inc, $n_inc);
            }
        }
    } else {
        say "WARNING: $inc is EXTERNAL" if $W;
        say "INFO: $inc is EXTERNAL" if $I;
    }
    return $stref;
}    # END of _inline_includes

sub __get_includes {
    (my $stref, my $inc) = @_;
    my $Sincf  = $stref->{'IncludeFiles'}{$inc};
    my @m_incs = ();
    map {
        my $name = $_;
        my $idx  = $Sincf->{'Includes'}{$name}{'LineID'};
        $m_incs[$idx] = $name;
    } keys %{$Sincf->{'Includes'}};
    my @incs = grep { defined $_ } @m_incs;
    return @incs;
}    # __get_includes

#AnnLines
#Vars
#   CommonVars
#       DeclaredCommonVars
#       UndeclaredCommonVars
#   Parameters
#       LocalParameters
#   LocalVars
#       OrigLocalVars
#           DeclaredOrigLocalVars
#           UndeclaredOrigLocalVars

# This is used when deciding to rename ex-COMMON vars
# It is populated in _parse_includes() which is recursive but not specific to include files
# In principle, the toplevel IncludedParameters should be correct

# Commons is a convenience, a set of all COMMON variables in the code unit. We need to update this either during the merge or afterwards
#
# DeclCount is only used to count StmtCount. I will delete it after parsing. Same for DoneInitTables, FreeForm, FStyle
#

=info_keys_not_to_be_changed 
  IncludedParameters
  Root
  Source
  Status
  RefactorGlobals
=cut

=info_irrelevant_keys
CalledEntries 
CalledSubs
Entries
Entry

ReferencedLabels

ParametersFromContainer
UsedGlobalVars
UsedLocalVars
UsedParameters

DeclCount
DoneInitTables
FStyle
FreeForm

HasBlocks
DeclaredOrigLocalArgs
UndeclaredOrigArgs
ExGlobVarDeclHook
=cut

our @ks = qw(
  Commons
  HasCommons
  HasIncludes
  HasParameters
  InclType
  Includes
  MaskedIntrinsics
);

=info_rules_for_merging
Commons: merge the hashes
HasCommons =  OR
HasIncludes = set to 0
HasParameters = OR
InclType = as before, depends on Commons and Parameters
Includes = []
MaskedIntrinsics = merge the hashes

AnnLines = replace include statement with the AnnLines of the include file

For variables, we only need to update the leaf sets
       DeclaredCommonVars
       UndeclaredCommonVars
       LocalParameters
           DeclaredOrigLocalVars
           UndeclaredOrigLocalVars
=cut

# Merge means that we merge the datastructures in $stref as well as the source code lines.
sub __merge_include {
    my ($stref, $inc, $n_inc) = @_;

    #	local $I=1;
    say "INFO: MERGING $n_inc into $inc" if $I;
    my $Sincf  = $stref->{'IncludeFiles'}{$inc};
    my $Snincf = $stref->{'IncludeFiles'}{$n_inc};

    #Commons: merge the hashes
    if (exists $Snincf->{'Commons'}) {
        say "INFO: $n_inc in $inc has COMMON variables" if $I;
        $Sincf->{'HasCommons'} = 1;
        if (exists $Sincf->{'Commons'}) {
            $Sincf->{'Commons'} =
              {%{$Sincf->{'Commons'}}, %{$Snincf->{'Commons'}}};
        }
        else {
            $Sincf->{'Commons'} = {%{$Snincf->{'Commons'}}};
        }
    }
    $Sincf->{'HasIncludes'} = 0;
    $Sincf->{'Includes'}    = {};
    $Sincf->{'HasParameters'} =
      $Snincf->{'HasParameters'} ? 1 : $Sincf->{'HasParameters'};

    #InclType = as before, depends on Commons and Parameters
    my $has_commons = $Sincf->{'HasCommons'};
    my $has_pars    = $Sincf->{'HasParameters'};
    if ($has_commons && $has_pars) {
        say "INFO: $inc has COMMON variables and PARAMETERs" if $I;
        $Sincf->{'InclType'} = 'Both';
    }
    elsif ($has_commons) {
        say "INFO: $inc has COMMON variables" if $I;
        $Sincf->{'InclType'} = 'Common';
    }
    elsif ($has_pars) {
        say "INFO: $inc has PARAMETERs" if $I;
        $Sincf->{'InclType'} = 'Parameter';
    }
    else {
        say "INFO: $inc has neither COMMON variables NOR PARAMETERs" if $I;
        $Sincf->{'InclType'} = 'None';
    }

    #Includes = []
    # MaskedIntrinsics = merge the hashes
    if (exists $Snincf->{'MaskedIntrinsics'}) {
        say "INFO: $inc has masked intrinsics" if $I;
        if (exists $Sincf->{'MaskedIntrinsics'}) {
            $Sincf->{'MaskedIntrinsics'} = {%{$Sincf->{'MaskedIntrinsics'}}, %{$Snincf->{'MaskedIntrinsics'}}};
        }
        else {
            $Sincf->{'MaskedIntrinsics'} =
              {%{$Snincf->{'MaskedIntrinsics'}}};
        }
    }

#Implicits
# Considering the includes are textually nested, there can't really be IMPLICIT statements in includes included in includes
# This is correct unless the parent only contains 'IMPLICIT ...' or nothing before the first INCLUDE
# So in principle the first file could provide the implicit rule for the parent an all others. And of course recursively so
# So I think merging implicit statements should be fine
# I do remove IMPLICIT NONE because I will add it later to the module

    # Implicits = merge the hashes
    if (exists $Snincf->{'Implicits'}) {
        say "INFO: $inc has Implicits" if $I;
        if (exists $Sincf->{'Implicits'}) {
            $Sincf->{'Implicits'} =
              {%{$Sincf->{'Implicits'}}, %{$Snincf->{'Implicits'}}};
        }
        else {
            $Sincf->{'Implicits'} = {%{$Snincf->{'Implicits'}}};
        }
    }

    # Merge the source code lines
    my @n_inc_annlines = grep {
        (my $line, my $info) = @{$_};
        not exists $info->{'ImplicitNone'};
    } @{$Snincf->{'AnnLines'}};

    my $old_annlines       = $Sincf->{'AnnLines'};
    my $insert_cond_subref = sub {
        (my $annline) = @_;
        (my $line, my $info) = @{$annline};
        return (exists $info->{'Include'} and $info->{'Include'}{'Name'} eq $n_inc)
          ? 1
          : 0;
    };
    my $merged_annlines =
      splice_additional_lines_cond($stref, $inc, $insert_cond_subref, $old_annlines, \@n_inc_annlines, 0, 1, 1);
    $stref->{'IncludeFiles'}{$inc}{'AnnLines'} = $merged_annlines;

# For variables, we only need to update the leaf sets
# For include files the order does not really matter because there are no arguments. Also I could recover the ordering in a final separate pass
#
    for my $var_type (
        qw( DeclaredCommonVars UndeclaredCommonVars LocalParameters DeclaredOrigLocalVars UndeclaredOrigLocalVars))
    {
        if (exists $Snincf->{$var_type}{'Set'}) {
            say "INFO: $n_inc contains $var_type variables" if $I;
            if (exists $Sincf->{$var_type}{'Set'}) {
                $Sincf->{$var_type}{'Set'} = {%{$Sincf->{$var_type}{'Set'}}, %{$Snincf->{$var_type}{'Set'}}};
                $Sincf->{$var_type}{'List'} =
                  [sort keys %{$Sincf->{$var_type}{'Set'}}];
            }
            else {
                $Sincf->{$var_type}{'Set'} =
                  dclone($Snincf->{$var_type}{'Set'});
            }
        }
    }

    return $stref;
}    # END of __merge_include


# Merge means that we merge the datastructures in $stref as well as the source code lines.
sub __merge_include_into_subroutine {
    my ($stref, $f, $n_inc) = @_;

    #	local $I=1;
    say "INFO: MERGING $n_inc into $f" if $I;
    my $Sf  = $stref->{'Subroutines'}{$f};
    my $Snincf = $stref->{'IncludeFiles'}{$n_inc};

    #Commons: merge the hashes
    if (exists $Snincf->{'Commons'}) {
        say "INFO: $n_inc in $f has COMMON variables" if $I;
        $Sf->{'HasCommons'} = 1;
        if (exists $Sf->{'Commons'}) {
            $Sf->{'Commons'} =
              {%{$Sf->{'Commons'}}, %{$Snincf->{'Commons'}}};
        }
        else {
            $Sf->{'Commons'} = {%{$Snincf->{'Commons'}}};
        }
    }
    #Includes = []
    # MaskedIntrinsics = merge the hashes
    if (exists $Snincf->{'MaskedIntrinsics'}) {
        say "INFO: $f has masked intrinsics" if $I;
        if (exists $Sf->{'MaskedIntrinsics'}) {
            $Sf->{'MaskedIntrinsics'} = {%{$Sf->{'MaskedIntrinsics'}}, %{$Snincf->{'MaskedIntrinsics'}}};
        }
        else {
            $Sf->{'MaskedIntrinsics'} =
              {%{$Snincf->{'MaskedIntrinsics'}}};
        }
    }

#Implicits
# Considering the includes are textually nested, there can't really be IMPLICIT statements in includes included in includes
# This is correct unless the parent only contains 'IMPLICIT ...' or nothing before the first INCLUDE
# So in principle the first file could provide the implicit rule for the parent an all others. And of course recursively so
# So I think merging implicit statements should be fine
# I do remove IMPLICIT NONE because I will add it later to the module

    # Implicits = merge the hashes
    if (exists $Snincf->{'Implicits'}) {
        say "INFO: $f has Implicits" if $I;
        if (exists $Sf->{'Implicits'}) {
            $Sf->{'Implicits'} =
              {%{$Sf->{'Implicits'}}, %{$Snincf->{'Implicits'}}};
        }
        else {
            $Sf->{'Implicits'} = {%{$Snincf->{'Implicits'}}};
        }
    }

    # Merge the source code lines
    my @n_inc_annlines = grep {
        (my $line, my $info) = @{$_};
        not exists $info->{'ImplicitNone'};
    } @{$Snincf->{'AnnLines'}};

    my $old_annlines       = $Sf->{'AnnLines'};
    my $insert_cond_subref = sub {
        (my $annline) = @_;
        (my $line, my $info) = @{$annline};
        return (exists $info->{'Include'} and $info->{'Include'}{'Name'} eq $n_inc)
          ? 1
          : 0;
    };
    my @n_inc_annlines_ann = map { 
        $_->[1]{'Inlined'} = 1;
        $_;
        # [
        #     $_->[0], 
        #     { %{$_->[1]}, 'Inlined' => 1 }
        # ]
    } @n_inc_annlines;
    my $merged_annlines =
      splice_additional_lines_cond($stref, $f, $insert_cond_subref, $old_annlines, \@n_inc_annlines_ann, 0, 1, 1);
    $Sf->{'AnnLines'} = $merged_annlines;
# croak Dumper(pp_annlines($stref->{'Subroutines'}{$f}{'AnnLines'})) if $f eq 'mpi_reduce_real';
# For variables, we only need to update the leaf sets
# For include files the order does not really matter because there are no arguments. Also I could recover the ordering in a final separate pass
#
    for my $var_type (
        qw( DeclaredCommonVars UndeclaredCommonVars LocalParameters DeclaredOrigLocalVars UndeclaredOrigLocalVars))
    {
        if (exists $Snincf->{$var_type}{'Set'}) {
            say "INFO: $n_inc contains $var_type variables" if $I;
            if (exists $Sf->{$var_type}{'Set'}) {
                $Sf->{$var_type}{'Set'} = {%{$Sf->{$var_type}{'Set'}}, %{$Snincf->{$var_type}{'Set'}}};
                $Sf->{$var_type}{'List'} =
                  [sort keys %{$Sf->{$var_type}{'Set'}}];
            }
            else {
                $Sf->{$var_type}{'Set'} =
                  dclone($Snincf->{$var_type}{'Set'});
            }
        }
    }
    # delete $stref->{'IncludeFiles'}{$n_inc};
    return $stref;
}    # END of __merge_include_into_subroutine

sub precondition_decls {
	# NOTE $f is not the name of the source but of the sub/func/incl/module.
    my ($f, $stref) = @_;    

    for my $inc (keys %{$stref->{'IncludeFiles'}}) {
        next if $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'External';
        $stref = _split_multivar_decls($inc, $stref);

        $stref = _split_multipar_decls_and_set_type($inc, $stref);
        my $Sincf = $stref->{'IncludeFiles'}{$inc};
    }

    for my $f (keys %{$stref->{'Subroutines'}}) {
        next if $f eq 'UNKNOWN_SRC';

        my $Sf = $stref->{'Subroutines'}{$f};
        if (not exists $Sf->{'Entry'} or $Sf->{'Entry'} == 0) {

            # 7. Split variable declarations with multiple vars into single-var lines
            # One could say this is "refactoring" but I say it's "preconditioning"
            $stref = _split_multivar_decls($f, $stref);

            $stref = _split_multipar_decls_and_set_type($f, $stref);
        }
        else {
            say "INFO: SKIPPING ENTRY $f" if $I;
        }
    }

    if (exists $stref->{'Modules'}) {
        for my $f (keys %{$stref->{'Modules'}}) {
            $stref = _split_multivar_decls($f, $stref);

            $stref = _split_multipar_decls_and_set_type($f, $stref);
        }
    }
    say "LEAVING precondition_decls( $f )" if $V;

    return $stref;

}    # END of precondition_decls()

# -----------------------------------------------------------------------------
#
sub _split_multivar_decls {
    (my $f, my $stref) = @_;
    my $sub_incl_or_mod = sub_func_incl_mod($f, $stref);
    my $Sf = $stref->{$sub_incl_or_mod}{$f};
    if (exists $Sf->{'AnnLines'}) {
        my $annlines = $Sf->{'AnnLines'};

        my $nextLineID   = scalar @{$annlines} + 1;
        my $new_annlines = [];
        for my $annline (@{$annlines}) {
            (my $line, my $info) = @{$annline};

            if (    exists $info->{'VarDecl'}
                and exists $info->{'VarDecl'}{'Names'})
            {
                my @nvars = @{$info->{'VarDecl'}{'Names'}};
                push @{$info->{'Ann'}}, annotate($f, __LINE__);
                for my $var (@{$info->{'VarDecl'}{'Names'}}) {

                    my $rinfo_c = dclone($info);
                    $rinfo_c->{'StmtCount'} = {};
                    $rinfo_c->{'StmtCount'}{$var} = $info->{'StmtCount'}{$var};

                    my %rinfo = %{$rinfo_c};
                    $rinfo{'LineID'} = $nextLineID++;
                    my $subset    = in_nested_set($Sf, 'Vars', $var);
                    my $orig_decl = $Sf->{$subset}{'Set'}{$var};
                    $rinfo{'VarDecl'} = {'Name' => $var}, my $rline = $line;
                    $Sf->{$subset}{'Set'}{$var}{'Name'} = $var;
                    if (scalar @{$info->{'VarDecl'}{'Names'}} > 1) {
                        for my $nvar (@nvars) {
                            if ($nvar ne $var) {

                                # FIXME: This should use \b not \W !!!
                                if ($rline =~ /\s*,\s*$nvar\([^\(]+\)\W?/) {
                                    $rline =~ s/\s*,\s*$nvar\([^\(]+\)(\W?)/$1/;
                                }
                                elsif ($rline =~ /(\W)$nvar\([^\(]+\)\s*,\s*/) {
                                    $rline =~ s/(\W)$nvar\([^\(]+\)\s*,\s*/$1/;
                                }
                                elsif ($rline =~ /\s*,\s*$nvar\*\d+\W?/) {
                                    $rline =~ s/\s*,\s*$nvar\*\d+(\W?)/$1/;
                                }
                                elsif ($rline =~ /(\W)$nvar\*\d+\s*,\s*/) {
                                    $rline =~ s/(\W)$nvar\*\d+\s*,\s*/$1/;
                                }
                                elsif ($rline =~ /\W$nvar\s*,\s*/) {
                                    $rline =~ s/(\W)$nvar\s*,\s*/$1/;
                                }
                                elsif ($rline =~ /\s*,\s*$nvar\W?/) {
                                    $rline =~ s/\s*,\s*$nvar(\W?)/$1/;
                                }
                            }
                        }
                    }

                    push @{$new_annlines}, [$rline, {%rinfo}];
                }    # for each $var
            }
            else {
                push @{$new_annlines}, $annline;
            }
        }
        $Sf->{'AnnLines'} = $new_annlines;
    }
    return $stref;
}    # END of _split_multivar_decls

# -----------------------------------------------------------------------------
sub _split_multipar_decls_and_set_type {
    (my $f, my $stref) = @_;

    my $sub_incl_or_mod = sub_func_incl_mod($f, $stref);

    my $Sf = $stref->{$sub_incl_or_mod}{$f};
    if (exists $Sf->{'AnnLines'}) {
        my $annlines     = $Sf->{'AnnLines'};
        my $nextLineID   = scalar @{$annlines} + 1;
        my $new_annlines = [];
        for my $annline (@{$annlines}) {
            (my $line, my $info) = @{$annline};
            if (exists $info->{'ParamDecl'} ) {

                if (
					exists $info->{'ParamDecl'}{'Names'} and
					scalar @{$info->{'ParamDecl'}{'Names'}} => 1) {
                    my @nvars = @{ $info->{'ParamDecl'}{'Names'} };
                    for my $var (@nvars) {
                        #  say "PAR: ".Dumper($var);
                         if (ref($var) eq 'ARRAY') {
                             ($var,my $val) = @{$var};
                         }
                        my $param_decl = $Sf->{'LocalParameters'}{'Set'}{$var};
                        # say "PAR: ".Dumper($param_decl);
                        my %rinfo = %{$info};
                        $rinfo{'LineID'}    = $nextLineID++;
                        $rinfo{'ParamDecl'} = {'Name'=>$var}; # WV20190729 New approach. I don't see why anything but the name is needed
                        $rinfo{'VarDecl'} = {'Name' => $var};                        
                        my $val =  exists $param_decl->{'Ast'} ? emit_expr_from_ast($param_decl->{'Ast'}) : $param_decl->{'Val'};
                        my $rline = $param_decl->{'Indent'}."parameter($var=$val)"; # F77 syntax, this should not be used anyway
                        push @{$new_annlines}, [$rline, \%rinfo];
                    }
                            
            # if (0) {
            #             my @nvars_nvals = @{$info->{'ParamDecl'}{'Names'}};
            #             for my $var_val (@{$info->{'ParamDecl'}{'Names'}}) {

            #                 my $var = $var_val->[0];
            #                 my $val = $var_val->[1];

            #                 my %rinfo = %{$info};
            #                 $rinfo{'LineID'}    = $nextLineID++;
            #                 $rinfo{'ParamDecl'} = {};

            #                 my $param_decl = {
            #                     'Indent'          => $info->{'Indent'},
            #                     'Type'            => $Sf->{'LocalParameters'}{'Set'}{$var}{'Type'},
            #                     'Attr'            => $Sf->{'LocalParameters'}{'Set'}{$var}{'Attr'},
            #                     'Dim'             => [],
            #                     'Parameter'       => 'parameter',
            #                     'Name'            => [$var, $val],
            #                     'Val'             => $val, # backwards comp
            #                     'Var'             => $var, # backwards comp
            #                     'Status'          => 1,
            #                     'InheritedParams' => $Sf->{'LocalParameters'}{'Set'}{$var}{'InheritedParams'},
            #                 };

            #                 $Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;
            #                 $rinfo{'ParamDecl'} = {'Name' => [$var, $val]};
            #                 $rinfo{'VarDecl'} = {'Name' => $var};

            #                 my $rline = $line;
            #                 if (scalar @{$info->{'ParamDecl'}{'Names'}} > 1) {

            #                     # This is a line with multiple param decls, split it.
            #                     for my $nvar_vals (@nvars_nvals) {
            #                         my $nvar = $nvar_vals->[0];
            #                         if ($nvar ne $var) {
            #                             my $nval = $Sf->{'LocalParameters'}{'Set'}{$nvar}{'Val'};
            #                             # TODO: WEAK we only support scalars parnam=parval
            #                             # FIXME: This should use \b not \W !!!
            #                             if ($rline =~ /\s*,\s*$nvar\s*=\s*$nval\W?/) {
            #                                 $rline =~ s/\s*,\s*$nvar\s*=\s*$nval(\W?)/$1/;
            #                             }
            #                             elsif ($rline =~ /(\W)$nvar\s*=\s*$nval\s*,\s*/) {
            #                                 $rline =~ s/(\W)$nvar\s*=\s*$nval\s*,\s*/$1/;
            #                             }
            #                         }
            #                     }
            #                 }
            #                 push @{$new_annlines}, [$rline, \%rinfo];
            #             } #for
            #         } # if 0
                }
                else { # problem: No 'Names'
                    croak "NO Names for parameter in $f: $line";
                }            
        } # if 'ParamDecl'
        else {
            push @{$new_annlines}, $annline;
        }
        } # for AnnLines
        $Sf->{'AnnLines'} = $new_annlines;
    } # if AnnLines
    return $stref;
}    # END of _split_multipar_decls_and_set_type

sub split_multiblock_common_lines {
    my ($stref, $f) = @_;

    # Split lines with multiple common block declarations
    for my $sub_or_func (@{$stref->{'SourceContains'}{$f}{'List'}}) {
        my $sub_func_type = $stref->{'SourceContains'}{$f}{'Set'}{$sub_or_func};

        my $Sf = $stref->{$sub_func_type}{$sub_or_func};
        next if (exists $Sf->{'Entry'} and $Sf->{'Entry'} == 1);

        my @annlines     = @{$Sf->{'AnnLines'}};
        my $new_annlines = [];
        for my $annline (@annlines) {
            (my $line, my $info) = @{$annline};
            if ($line =~ /^\s*\d*\s+common/) {

# 'Normal' is common /name/ x
# But also
# common x//y
# common x/name/y
# common //x
# common ivcn06/blk5/rvcnd1,lvcnd1//ivcn07,ivcn08/blk6/rvcne1
# If we split on '/' we want to know: how many '/' are there? i.e. scalar @chunks -1
# But we need to cater for the bare common as a first occurence, so test /common\s+[a-z]/
                my $tline  = $line;
                my @chunks = split(/\s*\/\s*/, $tline);

                my $multiple_common_blocks = 0;
                my $first_block_bare       = 0;
                if (scalar @chunks > 3) {
                    $multiple_common_blocks = 1;
                    if ($chunks[0] =~ /common\s+[a-z]/) {
                        $first_block_bare = 1;
                    }
                }
                elsif (scalar @chunks == 3 and $chunks[0] =~ /common\s+[a-z]/) {
                    $multiple_common_blocks = 1;
                    $first_block_bare       = 1;
                }
                if ($multiple_common_blocks == 1) {
                    my $fst = shift @chunks;
                    (my $indent, my $rest) = split(/common/, $fst);
                    $rest =~ s/\s*,\s*$//;
                    my $common = $indent . 'common ';
                    if ($first_block_bare == 1) {
                        # so we have 'common l1 ','[n2]',l2,...
                        my $nline = $common . '// ' . $rest;
                        push @{$new_annlines}, [$nline, $info];
                    }
                    else {
                        #                        		say "MULTIPLE COMMON: $line";
                    }
                    for my $i (0 .. (scalar @chunks) / 2 - 1) {
                        my $nline = $common . '/' . $chunks[2 * $i] . '/ ' . $chunks[2 * $i + 1];
                        push @{$new_annlines}, [$nline, $info];
                    }
                    next;
                }
            }
            push @{$new_annlines}, [$line, $info];
        }
        $Sf->{'AnnLines'} = $new_annlines;
    }
    return $stref;
}    # END of split_multiblock_common_lines


sub _remove_var_decls_for_param_decls { my ($stref,$f)=@_;

} # END of _remove_var_decls_for_param_decls 


=pod

A problem specifically with Nek but more general, is that I have always assumed that include files would be
1. self-contained (i.e. they contain or include what they need)
2. Only include other files at the top, so that the declarations in those files are encountered first.

Nek breaks both:

SIZE.inc is included in SIZE at the bottom, an requires definititions from SIZE so it is not self-contained.
Even TOTAL, despite its name, does not include SIZE, but needs it. 

So what to do? First, identify the different cases:

Case A
include F1:
	include F2
	... needs F2
> This is OK: F2 and F1 can become modules
To determine this case:
* The include must come before any other statements except other includes
* If this is the case, proceed as normal (Case A)
* If this is not the case, 
    * Check if F2 uses any of the preceding declarations from F1 or preceding includes. 
        * If not, we can move the F2 include up and proceed as normal
        * If it does, however, we are in Case B (if content from F1) or Case C (if content from preceding include)

Case B
include F1:
	...
	include F2
		... needs content from F1

It is impossible to create a module from F2. 
* So inline F2 into F1. 
* If this merged F1 is self-contained, turn it into a module.
* If not, we are probably in case C


Case C
include F1
include F2: 
	... needs F1
> This means: 
- assuming F1 is case A or B
- go to the parent
- find the include line for F2
- Go up from there
	- find any declarations of variables or parameters used in F2
		- If they are variables:
            - Essentially, we can't use a module in that case. Just inline F2
        - If they are parameters: 
            - To make this work we would need to
                - insert the parameter declarations into F2
                - move the use statement above those parameter declarations as it has to be the first thing
                - so in practice, that is too ugly, just inline the whole thing.
    - find any include that contains the declarations for F2, e.g. F1
        - Assuming this can be modularised, use the module F1 in F2 and modularise the F1 line
        - If not, inline F1 as well

* The only acceptable code before an include statement is 
- another include statement
- a program, function or subroutine declaration

So, when descending into the include F1:
- go through the file, if we meet anything except comments and blanks or program, function or subroutine declaration, then it is Case B unless te include can be moved up
	- continue to find any includes F2
	- inline them
	- test if F1 is now self-contained. 
        If so, turn into a module
        If not, it's case C     
- if we find an include F2, it's maybe case A. Descend into that include F2 and inventory the declarations
- then check if the include F1 is self-contained. 
    If so, it's case A. Turn into a module
    If not, it's case C.

All this should happen in Preconditioning

We already inline includes in other includes. So it would seem the problem arises if the includes are in a non-include source file

Source file F1
include I1
include I2: 
	... needs I1

Because the other cases should do the right thing with inlining, right?

If there is a variable accessed in an include that was not declared, that may be because it was declared elsewhere, but it is also possible that it was not declared anywhere else.
"Elsewhere" could mean in the declarations in the source preceding the include statement, or in an include preceding it.

So, when we encounter an include, we need to check a list of prior_declarations and a list of prior_includes

However, this goes somehow much deeper. For example, the OPCTR include has this:

      integer maxrts
      parameter (maxrts=1000)

      character*6     rname(maxrts)
      common /opctrc/ rname

And this leads to an undefined inherited occurence of maxrts in rname because the parameter is defined locally inside OPCTR 
but rname is used in the mxm() routine that is called almost everywhere. Because rname is a common it becomes an arg and so needs a local decl
and therefore it needs maxrts to be declared locally.

This is somehow a different issue. 
I think the pragmatic way to solve this is to set a flag "INLINE_ALL_INCLS" if we detect an issue like this, and restart the run with this flag.
Then there will be no more includes and everything should work.

So what this means is that I simply call __merge_include_into_subroutine regardless



=cut
sub precondition_subroutines_with_includes {
	# NOTE $f is not the name of the source but of the sub/func/incl/module.
    my ($f, $stref, $is_source_file_path) = @_;    

    for my $f (keys %{$stref->{'Subroutines'}}) {
        next if $f eq 'UNKNOWN_SRC';

        # my $Sf = $stref->{'Subroutines'}{$f};
        # say "precondition_subroutines_with_includes($f)"; 
        $stref = _precondition_subroutine_with_includes($stref, $f);
    }

    say "LEAVING precondition_subroutines_with_includes( $f )" if $V;

    return $stref;

}    # END of precondition_subroutines_with_includes()

sub _precondition_subroutine_with_includes { my ($stref, $f) = @_;
    my $sub_incl_or_mod = sub_func_incl_mod($f, $stref);

    my $Sf = $stref->{$sub_incl_or_mod}{$f};
    my %prior_declarations=();
    my @prior_includes=();
    if (exists $Sf->{'AnnLines'}) {
        my $annlines     = $Sf->{'AnnLines'};
        my $nextLineID   = scalar @{$annlines} + 1;
        my $new_annlines = [];
        for my $annline (@{$annlines}) {
            (my $line, my $info) = @{$annline};
            if (exists $info->{'VarDecl'} ) {
                my $var_name = $info->{'VarDecl'}{'Name'};
                $prior_declarations{$var_name}=1;
            }
            elsif (exists $info->{'ParamDecl'} ) {
                my $par_name = $info->{'ParamDecl'}{'Name'};
                $prior_declarations{$par_name}=1;
            }

            elsif (exists $info->{'Include'} ) {
                my $inc = $info->{'Include'}{'Name'};
                say "Found INCL $inc in $f" if $DBG;
                if ($Config{'INLINE_INCLUDES'} == 0 and
                    include_is_selfcontained($stref,$f,$inc,\%prior_declarations,\@prior_includes)) {
                    say "INCL $inc in $f is self-contained" if $DBG;
                    push @prior_includes, $inc;
                } else {
                    say "INCL $inc in $f is NOT self-contained, MERGE" if $DBG;
                    $stref = __merge_include_into_subroutine($stref, $f, $inc);
                    # We restart the process
                    $stref = _precondition_subroutine_with_includes($stref,$f);
                }
            }
        }
    }
    return $stref;
} # END of _precondition_subroutine_with_includes



# This is only for includes in non-include source files, so no need to make it recursive
sub include_is_selfcontained { my ($stref, $f, $inc, $prior_decls, $prior_incls) =@_;
# So we have to check any UndeclaredOrigLocalVars. UndeclaredCommonVars should by their very nature have been declared previously.
my $Sinc = $stref->{'IncludeFiles'}{$inc};

if ( exists $Sinc->{'UndeclaredOrigLocalVars'}) {
    for my $var ( sort keys %{ $Sinc->{'UndeclaredOrigLocalVars'}{'Set'} } ) {
        # Check if this var was declared in the parent previously
        if (exists $prior_decls->{$var}) {
            say "INCL $inc IN $f: PRIOR DECL $var" if $DBG;
            return 0;            
        }
        # Check if this var was declared in one of the preceding includes.
        # As each of these includes will only be added if it is self-contained, and inlined otherwise, this is fine.
        for my $prior_inc (@{$prior_incls}) {
            if (in_nested_set( $stref->{'IncludeFiles'}{$prior_inc},'Vars',$var)) {
                say "INCL $inc IN $f: PRIOR DECL $var in INCL $prior_inc"  if $DBG;
                return 0;
            }
        }
    }
} 
# This is not good enought because it is possible to have parameter(x=x_ext) so we need to look up x_ext
if ( exists $Sinc->{'LocalParameters'} 
and exists $Sinc->{'LocalParameters'}{'Set'} 
and scalar keys %{$Sinc->{'LocalParameters'}{'Set'}} >0
) {
    for my $par (sort keys %{$Sinc->{'LocalParameters'}{'Set'}}) {
        my $decl = $Sinc->{'LocalParameters'}{'Set'}{$par};
        if (
            exists $decl->{'InheritedParams'} 
        and scalar keys %{$decl->{'InheritedParams'}}>0
        ) {
            for my $inh_param (keys %{$decl->{'InheritedParams'}} ) {
                if (not in_nested_set( $stref->{'IncludeFiles'}{$inc},'Parameters',$inh_param) ) {
                    say "INCL $inc IN $f: PARAM $par INHERITS FROM UNDECLARED $inh_param" if $DBG;
                    return 0;                
                }
            }
        }
    }
#  carp "INC $inc HAS PARAMS";#Dumper(pp_annlines($Sinc->{'AnnLines'})),Dumper($Sinc->{'LocalParameters'});
}
return 1;
} # END of include_is_not_selfcontained

1;
