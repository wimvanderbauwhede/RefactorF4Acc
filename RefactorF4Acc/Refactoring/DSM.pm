# Rename array accesses and declarations to use the DSM API
package RefactorF4Acc::Refactoring::DSM;
use v5.10;
# 
#   (c) 2021 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Refactoring::DSM::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::DSM::EXPORT_OK = qw(
    refactor_dsm_all
    refactor_dsm
);


sub refactor_dsm_all {
	( my $stref ) = @_;

	for my $f ( sort keys %{ $stref->{'Subroutines'} } ) {

		next if ( $f eq '' or $f eq 'UNKNOWN_SRC' or not defined $f );
		# next if exists $stref->{'Entries'}{$f};

		my $Sf = $stref->{'Subroutines'}{$f};

		if ( not defined $Sf->{'Status'} ) {
			$Sf->{'Status'} = $UNREAD;
			say "INFO: no Status for $f" if $I;
		}

		next if $Sf->{'Status'} == $UNREAD;
		next if $Sf->{'Status'} == $READ;
		next if $Sf->{'Status'} == $FROM_BLOCK;
        #   map {say 'TEST'.$_} @{pp_annlines($Sf->{'RefactoredCode'})} if $f=~/test_loop/;
		$stref = refactor_dsm( $stref, $f );

        emit_RefactoredCode($stref,$f,$Sf->{'RefactoredCode'}) ;
	}
    
	return $stref;
}    # END of refactor_dsm_all()


# The lines to refactor are
# * Var declarations that have a Collective array or scalar
# * any accesses to any Collective array or scalar, so:
# - Assignments
# - If/ElseIf/While conditions 
# - Subroutine call arguments
sub refactor_dsm { my ( $stref, $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'} ;


    my $pass_refactor_dsm = sub { my ($annline,$state) = @_;
        my ($line,$info) = @_;
        if (exists $info->{'VarDecl'}) {
            my $varname = $info->{'VarDecl'}{'Name'};
            my $subset = in_nested_set( $Sf, 'Vars', $varname );
            my $decl = get_var_record_from_set($Sf->{$subset},$varname);
            croak Dumper $decl if not exists $decl->{'MemSpace'};
            if ($decl->{'MemSpace'} eq 'Collective') {
                my $pvd = _refactor_parsed_vardecl_dsm($decl);
                $info->{'ParseVarDecl'} = $pvd;
            }
        }
        # v(i,j) = w(i,j) becomes
        # call dsmWrite2DRealArray(v,i,j, &
        # dsmRead2DRealArray(w, i, j) &
        # )
        elsif (exists $info->{'Assignment'}) {

            # TODO: handle array assignments v1 = v2
            # This is easy but needs to be detected: if the LHS and RHS are both '$' in the AST but Array in the decls, it is an array access

            # TODO: handle array slice assignments v1(5:15) = v2(300:310)
            # Array slices make sense if we want to copy a chunk into or out of a collective array, we need to convert them into start index and buffer size.
            # That is OK of they are static, otherwise just give up
            # I guess we need to look for the ':' opcode
            # It is complicated if the array is slices in more than one dimension, I guess I'll just give up on that too.

            # Make a list of all variables that are collective
            # LHS
            my $lhs_varname = $info->{'Lhs'}{'VarName'};
            my ($lhs_is_dsm_var,$lhs_var_decl) = _is_dsm_var($lhs_varname, $Sf);
            # RHS 
            # For simplicity I create a hash of var => decl for the dsm vars, so that I can simply match in the AST
            my $rhs_dsm_vars={};
            for my $rhs_varname (@{$info->{'Rhs'}{'VarList'}}) {
                my ($rhs_is_dsm_var,$rhs_var_decl) = _is_dsm_var($rhs_varname, $Sf);
                if ($rhs_is_dsm_var) {
                    $rhs_dsm_vars->{$rhs_varname} = $rhs_var_decl;
                }
            }
            my $rhs_dsm_ast = _rewrite_ast_dsm_read_nodes($info->{'Rhs'}{'ExpressionAST'},$rhs_dsm_vars );
            if ($lhs_is_dsm_var) {
                # This means the assignment will become a subroutine call
                #== CALL, SUBROUTINE CALL
                #@ SubroutineCall => 
                #@     Name => $name
                #@     ExpressionAST => $ast
                #@     Args => $expr_args
                #@ 	   IsExternal => $bool
                #@ ExprVars => $expr_other_vars
            
                my $dsm_write_ast = _rewrite_ast_dsm_write_node(
                    $info->{'Lhs'}{'ExpressionAST'},$lhs_varname,$lhs_var_decl,$rhs_dsm_ast
                );
                $info->{'SubroutineCall'}{'ExpressionAST'} = $dsm_write_ast;
                my $name = 'dsmWrite'._dsmType($lhs_var_decl);
                $info->{'SubroutineCall'}{'Name'} = $name;
                my ($expr_args, $expr_other_vars ) = get_args_vars_from_subcall($dsm_write_ast);
                $info->{'SubroutineCall'}{'Args'} = $expr_args;
                $info->{'ExprVars'} = $expr_other_vars;
                # An external sub
                $info->{'SubroutineCall'}{'IsExternal'} = 1;
                # I should add these to CalledSubs I think
                # TODO!
                # if ( $sub_or_func_or_mod eq 'Subroutines' ) { # The current code unit is a subroutine 
                    $Sf->{'CalledSubs'}{'Set'}{$name} = 1; # mark $name a called sub in $f
                    push @{ $Sf->{'CalledSubs'}{'List'} }, $name;
                # } else { # The current code unit is NOT a subroutine, which means it is a Module I guess
                # # mark $name as a called sub in $current_sub_name 
                #     $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'Set'}{$name} = 1;
                #     push @{ $Sf->{'Subroutines'}{$current_sub_name}{'CalledSubs'}{'List'} }, $name;
                # }	                
            } else {
                # The assignment remains and all we have to do is substitute the RHS:
                $info->{'Rhs'}{'ExpressionAST'} = $rhs_dsm_ast;
                    my $rhs_vars_set  = get_vars_from_expression($rhs_dsm_ast) ;
                #	say 'RHS_ARGS:'.Dumper($rhs_args);
                my $rhs_all_vars = {
                    'Set'  => $rhs_vars_set,
                    'List' => [ sort keys %{ $rhs_vars_set } ]
                };            
                $info->{'Rhs'}{'VarList'} = $rhs_all_vars;
            }
            # Get the ASTs
            # Rewrite the variable accesses using the API                        
        }
        elsif (exists $info->{'If'} or exists $info->{'ElseIf'}) {
            #== IF -- Block, Arithmetic and logical IF statements		
            # st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
            # END IF, END, or another logical IF statement.
            #@ CondExecExpr => $cond
            #@ CondExecExprAST => $ast
            #@ CondVars =>
            #@     Set => {...}
            #@     List => [...]

            # This is read-only so it is like the RHS of an assignment            
            my $cond_dsm_vars={};
            for my $cond_varname (@{$info->{'CondVars'}{'List'}}) {
                my ($cond_is_dsm_var,$cond_var_decl) = _is_dsm_var($cond_varname, $Sf);
                if ($cond_is_dsm_var) {
                    $cond_dsm_vars->{$cond_varname} = $cond_var_decl;
                }
            }
            my $cond_dsm_ast = _rewrite_ast_dsm_read_nodes($info->{'CondExecExprAST'},$cond_dsm_vars );
            $info->{'CondExecExprAST'} = $cond_dsm_ast;
            # Because this is a Read, the CondVars do not change
        }
        elsif (exists $info->{'Do'}) {
            if (exists $info->{'Do'}{'While'} ) {
                my $cond_dsm_vars={};
                for my $cond_varname (@{$info->{'Do'}{'Range'}{'Vars'}}) {
                    my ($cond_is_dsm_var,$cond_var_decl) = _is_dsm_var($cond_varname, $Sf);
                    if ($cond_is_dsm_var) {
                        $cond_dsm_vars->{$cond_varname} = $cond_var_decl;
                    }
                }
                my $cond_dsm_ast = _rewrite_ast_dsm_read_nodes($info->{'Do'}{'ExpressionsAST'},$cond_dsm_vars );
                $info->{'Do'}{'ExpressionsAST'} = $cond_dsm_ast;                
            }
        }
        # elsif (exists $info->{'SubroutineCall'}) {
        #     # Maybe I can leave this as I assume that we inline subs in loops and the Collective access should only happen in loops
        # If a variable is an array access, it must per definition be a Read
        # If it is an array but not an access, then the access should happen in the subroutine so we don't have to handle it
        # I guess we can say the same for a scalar Write 
        
        # }

        return [[$line,$info],$state];
    };
    
    my $state = {  };
    (my $updated_loop_annlines,$state) = stateful_pass($annlines,$pass_refactor_dsm,"pass_refactor_dsm($f)");

    return  $stref ;
}

# my $decl = {
# 	'Type'   => $tvar_rec->{'Type'},
# 	'Attr'   => $tvar_rec->{'Attr'},
# 	'Dim'    => $dim, # this is [[$b,$e],] 
#     'Halos'  => 
# 	'Name'   => $tvar,
# 	'ArrayOrScalar' => scalar @{$dim} > 0 ? 'Array' : 'Scalar' ,
# };

sub _refactor_parsed_vardecl_dsm {my ($decl) =@_;
    my $pvd={};
    my $dsm_type = _dsmType($decl);
    $pvd->{'TypeTup'}{'Type'} = 'type(DSM'.$dsm_type.')';
    $pvd->{'Vars'}=[$decl->{'Name'}];
    $pvd->{'Attributes'} = {};
    if (exists $decl->{'IODir'}) {
        $pvd->{'Attributes'}{'Intent'}=$decl->{'IODir'};
    }    
    $pvd->{'InitExprAST'} = _dsmInitExprAST($decl, 'DSM'.$dsm_type);

    return $pvd;
}

# returns DSM...
sub _dsmType {my ($decl) =@_;
    my $dsm_type = '';
    if ($decl->{'ArrayOrScalar'} eq 'Array') {
        my $dim = scalar @{$decl->{'Dim'}};
        $dsm_type.=$dim.'D';
    }
    my $type = $decl->{'Type'};
    my $kind = $decl->{'Kind'};
    if ($kind=~/kind\s*=\s*(\d+)/ ) {
        $kind=$1;
    } elsif ($kind=~/^(\d+)/ ) {
        $kind=$1;
    } else {
        $kind = 4;
    }
    if ($type eq 'real' ) {
        if ($kind == 8) {
        $dsm_type .= 'DoublePrecision';
        } else {
            $dsm_type .= 'Real';
        }
    } elsif ($type eq 'integer' ) {
        $dsm_type.= 'Integer'.$kind;
    } else  {
        croak "No DSM type for ".Dumper($decl);
    }
    if ($decl->{'ArrayOrScalar'} eq 'Array') {        
        $dsm_type.='Array';
    }
    return $dsm_type;
} # END of _dsmType

sub _dsmInitExprAST { my ($decl, $dms_type) =@_;
    my $args = [];
    if ($decl->{'ArrayOrScalar'} eq 'Array') {
        my $dims = $decl->{'Dim'};
        my @sizes=();
        my @offsets=();
        my @lhalos=();
        my @hhalos=();
        for my $dim_pair (@{$dims}) {
            my ($l,$h) = @{$dim_pair};
            my $size = $h-$l+1; # total size of the array
            push @sizes, $size;
            my $offset = $l-1; # offset = lower index - 1, so 0 means array starts at 1
            push @offsets, $offset;
        }
        if (exists $decl->{'Halos'}) {
            my $halos = $decl->{'Halos'};
            for my $halo_pair (@{$halos}) {
                my ($lh,$hh) = @{$halo_pair};
                push @lhalos, $lh;
                push @hhalos, $hh;
            }        
        }

        $args = [@sizes,@offsets,@lhalos,@hhalos];
    }
    my $dsm_init_expr_ast = [10, $dms_type, [27, map {[29,$_]} @{$args}]]; 

    return $dsm_init_expr_ast;
} # END of _dsmInitExprAST

sub _is_dsm_var {
    my ($varname, $Sf) = @_;
    my $subset = in_nested_set( $Sf, 'Vars', $varname );
    my $decl = get_var_record_from_set($Sf->{$subset},$varname);
    if ($decl->{'MemSpace'} eq 'Collective') {
        return (1,$decl);
    } else {
        return (0,$decl);
    }
}

sub _rewrite_ast_dsm_read_nodes { my ($ast,$dsm_vars );
    my $rhs_dsm_ast = dclone($ast);
    return $rhs_dsm_ast;
}



# v = expr becomes call dsmWrite${type}${kind}(v,expr)
# w(i,j,...) = expr becomes call dsmWrite${dim}D${type}${kind}Array(a, i,j,..., expr)
sub _rewrite_ast_dsm_write_node { my ($ast,$w_varname,$w_var_decl,$r_dsm_ast) = @_;
    my $dsm_type = _dsmType($w_var_decl);
    if ($w_var_decl->{'ArrayOrScalar'} eq 'Array') {
        # The AST is [10, $var_name, [27, $idx_expr_1,...]]
        # And it should become
        # [ 1, 'dsmWrite'.$dsm_type, [27, [2,$var_name], $idx_expr_1,..., $r_dsm_ast]]
        # So we get the index expressions:
        my @idx_expr_lst = @{$ast->[2]}; 
        shift @idx_expr_lst; # remove the opcode
        return [10, 'dsmWrite'.$dsm_type, [27, [2,$w_varname], @idx_expr_lst, $r_dsm_ast]];
    } else {
        # The AST is [2, $w_varname]
        return [ 1, 'dsmWrite'.$dsm_type, [27, [2,$w_varname], $r_dsm_ast]];
    }
} 
              

1;
