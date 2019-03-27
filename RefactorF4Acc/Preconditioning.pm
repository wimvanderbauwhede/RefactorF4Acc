# 
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::Preconditioning;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;

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
@RefactorF4Acc::Preconditioning::ISA = qw(Exporter);
@RefactorF4Acc::Preconditioning::EXPORT_OK = qw(
    &precondition_all
);

# -----------------------------------------------------------------------------
# Preconditioning works at source level, so we should go through all source files
# Possible source files are Subroutines, Modules and IncludeFiles

#Modules|Subroutines|IncludeFiles
#SourceContains
#SourceFiles

# Main question is if a Module contains the AnnLines for its subs or not ...
 
sub precondition_all {
	(my $stref)=@_;
#	( my $stref, my $code_unit_name, my $is_source_file_path) = @_;
#	my $sub_or_func_or_mod = sub_func_incl_mod( $code_unit_name, $stref );
#    if ($sub_or_func_or_mod eq 'Modules' and $is_source_file_path) {
#       $code_unit_name = get_module_name_from_source($stref,$code_unit_name);
#    }
#
#    my $sub_incl_or_mod = sub_func_incl_mod( $f, $stref );
#    
#    my $is_incl = $sub_incl_or_mod eq 'IncludeFiles' ? 1 : 0;
#    
#
#    my $Sf = $stref->{$sub_incl_or_mod}{$f};
#    
#    my $srcref = $Sf->{'AnnLines'};
#
#        
##       show_annlines($srcref);croak;
#
#        if ( $is_incl ) {
#            my $inc = $f;
    for my $inc ( keys %{ $stref->{'IncludeFiles'} } ) {
    	next if $stref->{'IncludeFiles'}{$inc}{'InclType'} eq 'External';            
            my $Sincf = $stref->{'IncludeFiles'}{$inc};
            my $has_commons = $stref->{'IncludeFiles'}{$inc}{'HasCommons'};
            my $has_pars = $stref->{'IncludeFiles'}{$inc}{'HasParameters'};
            
            if($has_commons && $has_pars ) {
                print "INFO: The include file $inc contains both parameters and commons, attempting to split out params_$inc.\n"
                  if $I;
                $Sincf->{'InclType'} = 'Both';
                $stref = __split_out_parameters( $inc, $stref );
                $stref = __find_parameter_used_in_inc_and_add_to_Only( $inc, $stref );
                $has_pars = 0;
    
            } elsif ($has_commons) {
                $Sincf->{'InclType'} = 'Common';
            } elsif ($has_pars) {
                $Sincf->{'InclType'} = 'Parameter';
            } else {
                $Sincf->{'InclType'} = 'None';
            }
    }
    
    return $stref;	
} # END of refactor_all()  

# -----------------------------------------------------------------------------
# TODO: check if this works for F95-style parameters too
sub __split_out_parameters {
    ( my $f, my $stref ) = @_;
    my $Sf = $stref->{'IncludeFiles'}{$f};
    my $srcref      = $Sf->{'AnnLines'};    
    my $param_lines = [];
    my $nsrcref     = [];
    my $nindex      = 0;
    my $nidx_offset = 0;
    push @{$nsrcref},
      [
        "      include 'params_$f'",
        { 'Include' => { 'Name' => "params_$f", 'InclType' => 'Parameter' } }
      ];

    for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {
        $nindex = $index + $nidx_offset;
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        if ( exists $info->{'ParamDecl'} ) { 
        # split out parameters from 'Common' include file           
            push @{$param_lines}, [ $line, { 'ParamDecl' => { %{ $info->{'ParamDecl'} } } } ];
            delete $srcref->[$index][1] {'ParamDecl'};  
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
      dclone( $stref->{'IncludeFiles'}{$f}{'LocalParameters'} );
    $stref->{'IncludeFiles'}{$f}{'LocalParameters'} =
      { 'Set' => {}, 'List' => [] };

    #    die Dumper( $stref->{'IncludeFiles'}{"$f"}{'RefactorGlobals'} );
    $stref->{'IncludeFiles'}{"params_$f"}{'Root'}   = $f;
    $stref->{'IncludeFiles'}{"params_$f"}{'Source'} = 'Virtual';   #"params_$f";
    $stref->{'IncludeFiles'}{"params_$f"}{'Status'} = $PARSED;
    $stref->{'IncludeFiles'}{"params_$f"}{'RefactorGlobals'} = $NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'HasBlocks'}       = $NO;
    $stref->{'IncludeFiles'}{"params_$f"}{'FStyle'} =
      $stref->{'IncludeFiles'}{$f}{'FStyle'};
    $stref->{'IncludeFiles'}{"params_$f"}{'FreeForm'} =
      $stref->{'IncludeFiles'}{$f}{'FreeForm'};

    $stref->{'IncludeFiles'}{$f}{'Includes'}{"params_$f"} = { 'Only' => {} };
    $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'} = dclone( $stref->{'IncludeFiles'}{$f}{'Parameters'} );
    $stref->{'IncludeFiles'}{"params_$f"}{'Vars'}{'Subsets'}{'Parameters'} = $stref->{'IncludeFiles'}{"params_$f"}{'Parameters'};
    delete $stref->{'IncludeFiles'}{$f}{'Parameters'};
    delete $stref->{'IncludeFiles'}{$f}{'Vars'}{'Subsets'}{'Parameters'};
    return $stref;
}    # END of __split_out_parameters

# -----------------------------------------------------------------------------
sub __find_parameter_used_in_inc_and_add_to_Only { (my $inc, my $stref ) = @_;
    
    my $Sinc = $stref->{'IncludeFiles'}{$inc};

    my $srcref      = $Sinc->{'AnnLines'};  
    
    for my $index ( 0 .. scalar( @{$srcref} ) - 1 ) {       
        my $line = $srcref->[$index][0];
        my $info = $srcref->[$index][1];
        if (exists $info->{'Include'} and $info->{'Include'}{'InclType'} eq 'Parameter' ) {
            my $param_inc =     $info->{'Include'}{'Name'};
        }
        elsif ( exists $info->{'VarDecl'}  ) {
            for my $var ( @{ $info->{'VarDecl'}{'Names'} } ) {
                my $decl=get_var_record_from_set($Sinc->{'Vars'},$var);
                if ($decl->{'ArrayOrScalar'} eq 'Array') {
                    my %dim_tmpstr = map { ($_->[0] => 1,$_->[1] => 1) } @{$decl->{'Dim'}};
                    my @maybe_parstrs = grep { !/^\-?\d+$/ } keys %dim_tmpstr;
                    my $maybe_pars_str = '('.join(',',@maybe_parstrs).')';#Dumper($decl->{'Dim'});#     
                    # So now parse this 
                    my $ast=parse_expression($maybe_pars_str, {}, $stref, $inc);
                    my $pars = get_vars_from_expression($ast,{});
                    delete $pars->{'_OPEN_PAR_'};
                    for my $par (keys %{$pars}) {
                        $Sinc->{'Includes'}{"params_$inc"}{'Only'}{$par}=1;
                    }           
                }
            }

        }
        elsif ( exists $info->{'Common'} ) {
            for my $var ( @{ $info->{'Common'}{'Vars'}{'List'} } ) {
                
                my $decl=get_var_record_from_set($Sinc->{'Vars'},$var);
                if ($decl->{'ArrayOrScalar'} eq 'Array') {
                    my %dim_tmpstr = map { ($_->[0] => 1,$_->[1] => 1) } @{$decl->{'Dim'}};
                    my @maybe_parstrs = grep { !/^\-?\d+$/ } keys %dim_tmpstr;
                    my $maybe_pars_str = '('.join(',',@maybe_parstrs).')';#Dumper($decl->{'Dim'});#     
                    # So now parse this 
                    my $ast=parse_expression($maybe_pars_str, {}, $stref, $inc);
                    my $pars = get_vars_from_expression($ast,{});
                    delete $pars->{'_OPEN_PAR_'};
                    for my $par (keys %{$pars}) {
                        $Sinc->{'Includes'}{"params_$inc"}{'Only'}{$par}=1;
                    }           
                }                       
            }           
        }
        elsif ( exists $info->{'Dimension'} ) {
            say "DIMENSION $line"; say Dumper($info);
        }
    }
    
    
    return $stref;
} # __find_parameter_used_in_inc_and_add_to_Only

1;
