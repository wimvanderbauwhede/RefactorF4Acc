#
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

package RefactorF4Acc::Preconditioning;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Parser::Expressions qw( get_vars_from_expression parse_expression emit_expr_from_ast );
use RefactorF4Acc::Refactoring::Common qw( splice_additional_lines_cond );
# use RefactorF4Acc::Parser qw( parse_fortran_src );

use vars qw( $VERSION );
$VERSION = "1.2.0";

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
  precondition_all
  split_multiblock_common_lines
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
    for my $inc (keys %{$stref->{'IncludeFiles'}}) {
        next if $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'External';

        next if ( $stref->{'IncludeFiles'}{$inc}{'Status'} == $UNREAD );
        #  {		
    	# 	$stref->{'IncludeFiles'}{$inc}{'Root'}      = 'UNKNOWN';
	    # 	$stref->{'IncludeFiles'}{$inc}{'HasBlocks'} = 0;
		#     $stref = parse_fortran_src( $inc, $stref );
	    # }

        say "Inlining in $inc";
        my $stref = _inline_includes($stref, $inc);
        my $Sincf = $stref->{'IncludeFiles'}{$inc};
    }

    for my $inc (keys %{$stref->{'IncludeFiles'}}) {
        next if $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'External';
        next if ( $stref->{'IncludeFiles'}{$inc}{'Status'} == $UNREAD );
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
            croak 'HOW?';
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
        elsif (exists $info->{'VarDecl'}) {
            for my $var (@{$info->{'VarDecl'}{'Names'}}) {
                my $set = in_nested_set($Sinc,'Vars', $var);
                my $decl = get_var_record_from_set($Sinc->{'Vars'}, $var);
                carp  Dumper($Sinc). "\n$var $inc \n".Dumper($decl)."\n".$line;
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
                            $Sinc->{'Includes'}{"params_$inc"}{'Only'}{$par} = 1;
                        }
                    }
                }
            }
        }
        elsif (exists $info->{'Dimension'}) {
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
    say $inc;
    say Dumper($stref->{'IncludeFiles'}{$inc});
    #of course, if the status is UNREAD then this does not work, and we must make sure we read it.

    if ($stref->{'IncludeFiles'}{$inc}{'HasIncludes'} == 1) {
        my @n_incs = __get_includes($stref, $inc);
        $stref->{'IncludeFiles'}{$inc}{'InlinedIncludes'} = [];
        for my $n_inc (@n_incs) {
            push @{$stref->{'IncludeFiles'}{$inc}{'InlinedIncludes'}}, $n_inc;
            $stref = _inline_includes($stref, $n_inc);
            # Now merge this into $Sincf
            $stref = __merge_include($stref, $inc, $n_inc);
        }
    }
    # croak Dumper($inc, $stref->{'IncludeFiles'}{$inc});
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

#     For variables, we only need to update the leaf sets
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

sub precondition_all {
	# NOTE $f is not the name of the source but of the sub/func/incl/module.
    my ($f, $stref, $is_source_file_path) = @_;    

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
    say "LEAVING precondition_all( $f )" if $V;

    return $stref;

}    # END of precondition_all()

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
                
            
if (0) {
                    my @nvars_nvals = @{$info->{'ParamDecl'}{'Names'}};
                    for my $var_val (@{$info->{'ParamDecl'}{'Names'}}) {

                        my $var = $var_val->[0];
                        my $val = $var_val->[1];

                        my %rinfo = %{$info};
                        $rinfo{'LineID'}    = $nextLineID++;
                        $rinfo{'ParamDecl'} = {};

                        my $param_decl = {
                            'Indent'          => $info->{'Indent'},
                            'Type'            => $Sf->{'LocalParameters'}{'Set'}{$var}{'Type'},
                            'Attr'            => $Sf->{'LocalParameters'}{'Set'}{$var}{'Attr'},
                            'Dim'             => [],
                            'Parameter'       => 'parameter',
                            'Name'            => [$var, $val],
                            'Val'             => $val, # backwards comp
                            'Var'             => $var, # backwards comp
                            'Status'          => 1,
                            'InheritedParams' => $Sf->{'LocalParameters'}{'Set'}{$var}{'InheritedParams'},
                        };

                        $Sf->{'LocalParameters'}{'Set'}{$var} = $param_decl;
                        $rinfo{'ParamDecl'} = {'Name' => [$var, $val]};
                        $rinfo{'VarDecl'} = {'Name' => $var};

                        my $rline = $line;
                        if (scalar @{$info->{'ParamDecl'}{'Names'}} > 1) {

                            # This is a line with multiple param decls, split it.
                            for my $nvar_vals (@nvars_nvals) {
                                my $nvar = $nvar_vals->[0];
                                if ($nvar ne $var) {
                                    my $nval = $Sf->{'LocalParameters'}{'Set'}{$nvar}{'Val'};
                                    # TODO: WEAK we only support scalars parnam=parval
                                    # FIXME: This should use \b not \W !!!
                                    if ($rline =~ /\s*,\s*$nvar\s*=\s*$nval\W?/) {
                                        $rline =~ s/\s*,\s*$nvar\s*=\s*$nval(\W?)/$1/;
                                    }
                                    elsif ($rline =~ /(\W)$nvar\s*=\s*$nval\s*,\s*/) {
                                        $rline =~ s/(\W)$nvar\s*=\s*$nval\s*,\s*/$1/;
                                    }
                                }
                            }
                        }
                        push @{$new_annlines}, [$rline, \%rinfo];
                    } #for
                    } # if 0
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

1;
