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
use RefactorF4Acc::Parser::Expressions qw( get_vars_from_expression _traverse_ast_with_action get_args_vars_from_subcall);
use RefactorF4Acc::Refactoring::Helpers qw( stateless_pass stateful_pass );
use RefactorF4Acc::Analysis::VarAccessAnalysis qw( analyseAllVarAccesses );
use RefactorF4Acc::Analysis::LoopNature qw( resolve_loop_nests );
use RefactorF4Acc::Emitter qw( emit_RefactoredCode );

use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Refactoring::DSM::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::DSM::EXPORT_OK = qw(
    refactor_dsm_all
    refactor_dsm
);
our $WDBG=0;
our $EDBG=0;

sub refactor_dsm_all {
	( my $stref ) = @_;
    local $I=1;
    local $V=0;
    # croak $stref->{'Top'};
    $stref = propagate_dsm_declaration($stref,$stref->{'Top'});
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
        $stref = rewrite_loop_bounds( $stref, $f ); 
		$stref = refactor_dsm( $stref, $f );
       

        # emit_RefactoredCode($stref,$f,$Sf->{'RefactoredCode'}) if $f=~/test_loop/;
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

    my $pass_refactor_dsm = sub { my ($annline) = @_;
        my ($line,$info) = @{$annline};
        
        if (exists $info->{'VarDecl'} ) { 
            my $varname = $info->{'VarDecl'}{'Name'};
            my $subset = in_nested_set( $Sf, 'Vars', $varname );
            my $decl = get_var_record_from_set($Sf->{$subset},$varname);
            if (not exists $decl->{'Parameter'}) {
                # carp Dumper $decl ;
                # say 'MEMSPACE: ',$f,' ', $varname,"\t", $decl->{'MemSpace'};
                if ($decl->{'MemSpace'} eq 'Collective') { 
                    # carp Dumper $decl;
                    my $pvd = $info->{'ParsedVarDecl'};
                    my $refactored_pvd = _refactor_parsed_vardecl_dsm($decl,$pvd);
                    $info->{'ParsedVarDecl'} = $refactored_pvd;
                    # carp Dumper $info->{'ParsedVarDecl'}
                }
            }
        }
        # v(i,j) = w(i,j) becomes
        # call dsmWrite2DRealArray(v,i,j, &
        # dsmRead2DRealArray(w, i, j) &
        # )
        elsif (exists $info->{'Assignment'}) {

            # TODO: handle array assignments v1 = v2
            # This is easy but needs to be detected: if the LHS and RHS are both '$' in the AST but Array in the decls, it is an array access
            # carp Dumper $info->{'Lhs'}{'ExpressionAST'};
            if ($info->{'Lhs'}{'ExpressionAST'}[0] == 2
            and $info->{'Rhs'}{'ExpressionAST'}[0] == 2
            ) {
                if (_is_array($info->{'Lhs'}{'VarName'},$Sf)
                and _is_array($info->{'Rhs'}{'Vars'}{'List'}[0],$Sf)
                ) { #OK, we have an array assignment
                        # Now check if LHS and/or RHS is Collective
                }
                # Are they by any chance both arrays?
                # This is not good enough because it might be an expression but then I can't use memcopy
                # But if it is, then we have a simple memcpy

                croak 'TODO!';
            }

            # So what do I do with v1 = abs(v2)*2+1 ?
            # The fast way is to do the operation on the local version
            # So first we need a good check to detect array operations
            # Then a check to see which one is local
            # if it is the LHS, we mempy first and then do the operation:
            # memcpy(v1,v2)
            # v1 = abs(v1)*2+1
            # if it is the RHS, then maybe we should make a temp var and do the operation locally,
            # then do the memcpy of the temp var. 
            # v2tmp = v2
            # v2tmp = abs(v2tmp)*2+1
            # memcpy(v1,v2tmp)

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
            my $rhs_is_dsm_var=0;
            # carp Dumper $info->{'Rhs'}{'Vars'};
            for my $rhs_varname (@{$info->{'Rhs'}{'Vars'}{'List'}}) {
                ($rhs_is_dsm_var,my $rhs_var_decl) = _is_dsm_var($rhs_varname, $Sf);
                if ($rhs_is_dsm_var) {
                    $rhs_dsm_vars->{$rhs_varname} = $rhs_var_decl;
                }
            }
            # carp Dumper($info),$rhs_is_dsm_var;
            # carp "$line ORIG RHS AST: ".Dumper $info->{'Rhs'}{'ExpressionAST'};
            my $rhs_ast = $rhs_is_dsm_var 
                ? _rewrite_ast_dsm_read_nodes( $info->{'Rhs'}{'ExpressionAST'},$rhs_dsm_vars)
                : $info->{'Rhs'}{'ExpressionAST'};
            if ($lhs_is_dsm_var) {
                # This means the assignment will become a subroutine call
                #== CALL, SUBROUTINE CALL
                #@ SubroutineCall => 
                #@     Name => $name
                #@     ExpressionAST => $ast
                #@     Args => $expr_args
                #@ 	   IsExternal => $bool
                #@ 	   ArgMap => {} # A map from the sig arg to the call arg
                #@ ExprVars => $expr_other_vars
            # carp "$line DMS RHS AST: ".Dumper $rhs_ast;
                my $dsm_write_ast = _rewrite_ast_dsm_write_node(
                    $info->{'Lhs'}{'ExpressionAST'},$lhs_varname,$lhs_var_decl,$rhs_ast
                );
                $info->{'SubroutineCall'}{'ExpressionAST'} = $dsm_write_ast;
                my $name = 'dsmWrite'._dsmType($lhs_var_decl);
                $info->{'SubroutineCall'}{'Name'} = $name;
                # carp Dumper $dsm_write_ast;
                my ($expr_args, $expr_other_vars ) = get_args_vars_from_subcall($dsm_write_ast);
                $info->{'SubroutineCall'}{'Args'} = $expr_args;
                $info->{'ExprVars'} = $expr_other_vars;
                # An external sub
                $info->{'SubroutineCall'}{'IsExternal'} = 1;
                delete  $info->{'Assignment'};

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
                $info->{'Rhs'}{'ExpressionAST'} = $rhs_ast;
                # carp Dumper $rhs_ast;
                my $rhs_vars_set  = get_vars_from_expression($rhs_ast) ;
                #	say 'RHS_ARGS:'.Dumper($rhs_args);
                my $rhs_all_vars = {
                    'Set'  => $rhs_vars_set,
                    'List' => [ sort keys %{ $rhs_vars_set } ]
                };            
                $info->{'Rhs'}{'Vars'} = $rhs_all_vars;
            }
            # Get the ASTs
            # Rewrite the variable accesses using the API                        
        }
        elsif (exists $info->{'If'} or exists $info->{'ElseIf'}) {
            #== IF -- Block, Arithmetic and logical IF statements		
            # st can be any executable statement, except a DO block, IF, ELSE IF, ELSE,
            # END IF, END, or another logical IF statement.
            #@ Cond Expr => $cond
            #@ Cond AST => $ast
            #@ CondVars =>
            #@     Set => {...}
            #@     List => [...]

            # This is read-only so it is like the RHS of an assignment            
            my $cond_dsm_vars={};
            for my $cond_varname (@{$info->{'Cond'}{'Vars'}{'List'}}) {
                my ($cond_is_dsm_var,$cond_var_decl) = _is_dsm_var($cond_varname, $Sf);
                if ($cond_is_dsm_var) {
                    $cond_dsm_vars->{$cond_varname} = $cond_var_decl;
                }
            }
            my $cond_dsm_ast = _rewrite_ast_dsm_read_nodes($info->{'Cond'}{'AST'},$cond_dsm_vars );
            $info->{'Cond'}{'AST'} = $cond_dsm_ast;
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
        #== CALL, SUBROUTINE CALL
        #@ SubroutineCall => 
        #@     Name => $name
        #@     ExpressionAST => $ast
        #@     Args => $expr_args, a Set/List map, see below
        #@ 	   IsExternal => $bool
        #@ 	   ArgMap => {} # A map from the sig arg to the call arg expr string
        #@ ExprVars => $expr_other_vars     
        #@ $expr_args = {
        #@	'Set' => {$expr_str => {
        #@         'Type'=>'Array',
        #@         'Vars'=>$vars, 
        #@         'Expr' => $expr_str, 
        #@         'Arg' => $arg,
        #@         'AST' => $ast
        #@ 			}, ...
        #@ 	'List' => [$expr_str,...];
        #@ };

        elsif (exists $info->{'SubroutineCall'}) {
        # If a variable is an array access, it must per definition be a Read, so use the API call
        # If it is an array but not an access, then the access should happen in the subroutine so we don't have to handle it
        # I guess we can say the same for a scalar Write
        # But what about a scalar read? 
        # I think we want to pass the scalar to the subroutine, this will have been done in a separate pass
            for my $sig_arg (sort keys %{ $info->{'SubroutineCall'}{'ArgMap'} }) {
                my $call_arg_expr_str = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
                my $call_arg_ast = $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Type'} eq 'Scalar'
                ? [2,$info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'Expr'}]
                : $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'AST'};
                # carp $f , Dumper $info->{'SubroutineCall'}{'Args'}{'Set'};
                if ($call_arg_ast->[0] == 10) { # Array access
                    my $call_arg_var_name = $call_arg_ast->[1];
                    my $called_sub_name = $info->{'SubroutineCall'}{'Name'};
                    my ($call_arg_is_dsm_var,$call_arg_decl) = _is_dsm_var($call_arg_var_name, $Sf);
                    if ($call_arg_is_dsm_var) {
                        # This is what we need to do to make the args of called subs use DSM
                        # my $sig_arg_decl =  $stref->{'Subroutines'}{$called_sub_name}{'Args'};


                        # Create the AST for the call arg expression
                        my $dsm_vars = {$call_arg_var_name=>$call_arg_decl};
                        $call_arg_ast = _rewrite_ast_dsm_read_nodes( $call_arg_ast,$dsm_vars);
                        # Maybe I can keep the expression string as key, it is not used anyway
                        $info->{'SubroutineCall'}{'Args'}{'Set'}{$call_arg_expr_str}{'AST'}=$call_arg_ast;
                        # Change the ExpressionAST
                        $info->{'SubroutineCall'}{'ExpressionAST'} = _rewrite_ast_dsm_read_nodes( $info->{'SubroutineCall'}{'ExpressionAST'},$dsm_vars);
                    }
                }
            }
        }

        return [[$line,$info]];
    };
    
    # my $state = {  };
    my $updated_loop_annlines = stateless_pass($annlines,$pass_refactor_dsm,"pass_refactor_dsm($f)");
    
    #  map {say $_} @{pp_annlines($updated_loop_annlines,1)};
    if ($V==1) {
    say "\nRefactored code for $f\n";
    emit_RefactoredCode($stref,$f,$updated_loop_annlines); 
    }
    return  $stref ;
} # END of refactor_dsm


sub propagate_dsm_declaration { my ( $stref, $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'} ;
    say "propagate_dsm_declaration($f)" if $V;
    my $pass_propagate_dsm_declaration = sub { my ($annline) = @_;
        my ($line,$info) = @{$annline};
        

        #== CALL, SUBROUTINE CALL
        #@ SubroutineCall => 
        #@     Name => $name
        #@     ExpressionAST => $ast
        #@     Args => $call_arg_expr_str
        #@ 	   IsExternal => $bool
        #@ 	   ArgMap => {$sig_arg => $expr_args } # A map from the sig arg to the call arg expr string
        #@ ExprVars => $expr_other_vars     
        #@ $expr_args = {
        #@	'Set' => {$call_arg_expr_str => {
        #@         'Type'=>'Array',
        #@         'Vars'=>$vars, 
        #@         'Expr' => $call_arg_expr_str, 
        #@         'Arg' => $arg,
        #@         'AST' => $ast
        #@ 			}, ...
        #@ 	'List' => [$call_arg_expr_str,...];
        #@ };

        if (exists $info->{'SubroutineCall'}) {
            my $csub = $info->{'SubroutineCall'}{'Name'};
            my $Ssub = $stref->{'Subroutines'}{$csub};
            for my $sig_arg (sort keys %{ $info->{'SubroutineCall'}{'ArgMap'} }) {
                my $call_arg_expr_str = $info->{'SubroutineCall'}{'ArgMap'}{$sig_arg};
                # we are only concerned with call args that are not expressions or array accesses,
                # so we can look them up directly in the Vars and see if they are Collective
                my $varname = $call_arg_expr_str;
                my $subset = in_nested_set( $Sf, 'Vars', $varname );
                if ($subset) {
                    my $call_arg_decl = get_var_record_from_set($Sf->{$subset},$varname);
                    if (not exists $call_arg_decl->{'Parameter'}) {
                        # carp Dumper $call_arg_decl ;
                        # say 'MEMSPACE: ',$f,' ', $varname,"\t", $call_arg_decl->{'MemSpace'};
                        if ($call_arg_decl->{'MemSpace'} eq 'Collective') { 
                            # carp "CALL ARG $varname: ", Dumper $call_arg_decl;
                            my $csub_subset = in_nested_set( $Ssub, 'Args', $sig_arg );
                            if ($csub_subset) {
                                my $sig_arg_decl = get_var_record_from_set($Ssub->{$csub_subset},$sig_arg);   
                                # carp "MAKE SIG ARG $sig_arg of $csub Collecive ";#, Dumper $sig_arg_decl;
                                $sig_arg_decl->{'MemSpace'} = 'Collective';
                                if (exists $call_arg_decl->{'Halos'}) {
                                    $sig_arg_decl->{'Halos'} = $call_arg_decl->{'Halos'};
                                }
                                if (exists $call_arg_decl->{'Partitions'}) {
                                    $sig_arg_decl->{'Partitions'} = $call_arg_decl->{'Partitions'};                            
                                }
                                $Ssub->{$csub_subset}{'Set'}{$sig_arg}=$sig_arg_decl;
                            } else {
                                croak "TROUBLE: no declaration for argument $sig_arg of $csub"
                            }                         
                        }
                    }
                }
            }
            # Now do a recursive descent
            $stref = propagate_dsm_declaration($stref,$csub);
        }

        return [[$line,$info]];
    };
    
    # my $state = {  };
    # croak Dumper $stref->{'Subroutines'}{'sub0'}{'Args'};
    my $loop_annlines_ = stateless_pass($annlines,$pass_propagate_dsm_declaration,"pass_propagate_dsm_declaration($f)");
    # die if $f =~/loop/;
    #  map {say $_} @{pp_annlines($updated_loop_annlines,1)};
    # emit_RefactoredCode($stref,$f,$updated_loop_annlines) if $f=~/test_loop/;
    return  $stref ;
} # END of propagate_dsm_declaration




# my $decl = {
# 	'Type'   => $tvar_rec->{'Type'},
# 	'Attr'   => $tvar_rec->{'Attr'},
# 	'Dim'    => $dim, # this is [[$b,$e],] 
#     'Halos'  => 
# 	'Name'   => $tvar,
# 	'ArrayOrScalar' => scalar @{$dim} > 0 ? 'Array' : 'Scalar' ,
# };

sub _refactor_parsed_vardecl_dsm {my ($decl,$pvd) =@_;
    # my $pvd={};
    my $dsm_type = _dsmType($decl);
    $pvd->{'TypeTup'}{'Type'} = 'type(DSM'.$dsm_type.')';
    $pvd->{'Vars'}=[$decl->{'Name'}];
    # $pvd->{'Attributes'} = {};
    if (exists $decl->{'IODir'} and $decl->{'IODir'} ne 'Unknown') {
        $pvd->{'Attributes'}{'Intent'}=$decl->{'IODir'};
    } else {  
    # carp Dumper $pvd->{'Attributes'};
    $pvd->{'InitExprAST'} = _dsmInitExprAST($decl, $pvd,'DSM'.$dsm_type);
    }
    delete $pvd->{'Attributes'}{'Dim'};
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
    my $kind = $decl->{'Kind'} // '';
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

sub _dsmInitExprAST { my ($decl, $pvd, $dms_type) =@_;
    my $args = [];
    if ($decl->{'ArrayOrScalar'} eq 'Array') {
        my $dims = [map { my ($l,$h) = split(/:/,$_); [$l,$h]   } @{$pvd->{'Attributes'}{'Dim'}}] ;#$decl->{'Dim'};
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

sub _is_array {
    my ($varname, $Sf) = @_;
    my $subset = in_nested_set( $Sf, 'Vars', $varname );
    my $decl = get_var_record_from_set($Sf->{$subset},$varname);
    if ($decl->{'ArrayOrScalar'} eq 'Array') {
        return 1;
    } else {
        return 0;
    }
}

sub _is_dsm_var {
    my ($varname, $Sf) = @_;
    my $subset = in_nested_set( $Sf, 'Vars', $varname );
    my $decl = get_var_record_from_set($Sf->{$subset},$varname);
    if (exists $decl->{'Parameter'}) {
        return 0;
    }
    if ($decl->{'MemSpace'} eq 'Collective') {
        return (1,$decl);
    } else {
        return (0,$decl);
    }
}

# Visit every node in the AST. If it is one of the $dsm_vars, rewrite
# $dsm_vars :: {VarName => VarDecl}
sub _rewrite_ast_dsm_read_nodes { my ($ast,$dsm_vars )=@_;
# carp Dumper $dsm_vars;
    my $rhs_dsm_ast = dclone($ast);
    
    # my $acc={}; 
    my $f = sub { my ($ast,$acc)=@_;
    
        if ($ast->[0] == 2 ) { # $ 
        
            my $var_name = $ast->[1];

            if (exists $acc->{$var_name}) {
                my $dsm_type = _dsmType($acc->{$var_name});
                $ast = [ 1, 'dsmRead'.$dsm_type, [2,$var_name]];
            }
        } 
        elsif ($ast->[0] == 10 ) { # @
            my $var_name = $ast->[1];
            # carp "VAR <$var_name>";#.Dumper keys %{$acc};
            if (exists $acc->{$var_name}) { 
                my @idx_expr_lst = @{$ast->[2]}; 
                if ($idx_expr_lst[0] == 27) {
                shift @idx_expr_lst if $idx_expr_lst[0] == 27; # remove the opcode 
                } elsif (scalar @idx_expr_lst == 2) {
                    # This is an array with a single index, wrap it so it does not get flattened
                    @idx_expr_lst = ([@idx_expr_lst]);
                }
                my $dsm_type = _dsmType($acc->{$var_name});
                # A trick: consider the array variable as a constant, not a scalar
                $ast = [ 1, 'dsmRead'.$dsm_type, [27,[32,$var_name],@idx_expr_lst]];
                
            }
            # croak Dumper $ast;
        } 
        # carp Dumper $ast;
        return ($ast,$acc);
    };

    ($rhs_dsm_ast,$dsm_vars) = _traverse_ast_with_action($rhs_dsm_ast, $dsm_vars, $f);
    # croak Dumper $rhs_dsm_ast;
    return $rhs_dsm_ast;
} # END of _rewrite_ast_dsm_read_nodes

# v = expr becomes call dsmWrite${type}${kind}(v,expr)
# w(i,j,...) = expr becomes call dsmWrite${dim}D${type}${kind}Array(a, i,j,..., expr)
sub _rewrite_ast_dsm_write_node { my ($ast,$w_varname,$w_var_decl,$r_dsm_ast) = @_;
    if ($w_var_decl->{'ArrayOrScalar'} eq 'Array') {
        # The AST is [10, $var_name, [27, $idx_expr_1,...]]
        # And it should become
        # [ 1, 'dsmWrite'.$dsm_type, [27, [2,$var_name], $idx_expr_1,..., $r_dsm_ast]]
        # So we get the index expressions:
        my @idx_expr_lst = @{$ast->[2]}; 
        if ($idx_expr_lst[0] == 27) {
        shift @idx_expr_lst if $idx_expr_lst[0] == 27; # remove the opcode 
        } elsif (scalar @idx_expr_lst == 2) {
            # This is an array with a single index, wrap it so it does not get flattened
            @idx_expr_lst = ([@idx_expr_lst]);
        }
        return  [27, [32,$w_varname], @idx_expr_lst, $r_dsm_ast];
    } else {
        # The AST is [2, $w_varname]
        return  [27, [32,$w_varname], $r_dsm_ast];
    }
} # END of _rewrite_ast_dsm_write_node

=pod
Rewrite the loop bounds based on Map/Reduce/Stencil annotations, using the Partition info from the array variables in the loop
∘ We need to find all array accesses in the loop
∘ The complication is accesses with constant indices in between nested loops
∘ Other complication is how to handle nested loops, I guess the best way is to create a set of block_ids and do the analysis for 

∘ Apart from that it's just $info->{'VarAccesses'}  which contains the 
From the accesses we need to do the following:
* Get the iterators and their index pos
* Get the Dim from the array
* Make a list that links the iterator to the dim for every var:

So all we need is 'i' => {'v','w'} etc.

What do we do with conflicts? 
Partition conflicts => Give up
Halo conflicts => That is interesting: 
- suppose the loop bound is -1 .. 102 and at least one array only has a dim smaller than that => BOOM!
- suppose the loop bound is 0 .. 101 and an array has a dim of 104 and a halo of 2, and another has a dim of 102 and a halo of 1
So it looks like what we need to do is figure out the core, and see if all cores are the same, otherwise BOOM!
Then, 
if any dim < the loop range BOOM!
If any dim and the rest == loop range > loop range, we use the the halo of the smaller ones
If the dims == loop range, no problem




Array accesses are stored in $info->...->{'VarAccesses'}{'Arrays'}{$array_var}{$rw}=
{
	'Exprs' => { $expr_str_1 => '0:1',...},
	'Accesses' => { '0:1' =>  {'j:0' => [1,0],'k:1' => [1,1]}}, 
	'Iterators' => ['j:0','k:1']
};
=cut

sub rewrite_loop_bounds { 
my ( $stref, $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'} ;
    # This is to get the LoopNests information
    ($stref,my $accessAnalysis) = analyseAllVarAccesses($stref, $f, [], $annlines);
    # croak $f, Dumper $accessAnalysis->{'LoopNests'};
    # This adds Contains, maybe I should integrate it in analyseAllVarAccesses
    ($accessAnalysis, my $blocks_per_nestlevel_, my $max_lev_) = resolve_loop_nests($stref, $f, $accessAnalysis);
#     die;
# croak Dumper $accessAnalysis;
    my $pass_rewrite_loop_bounds = sub { my ($annline,$state) = @_;
        my ($line,$info) = @{$annline};
        # carp Dumper $state;
        if (exists $info->{'Do'}) {
                $state->{'Loops'}{
                    $info->{'BlockID'}
                } = 1;
        }
        elsif (exists $info->{'EndDo'}) {
                delete $state->{'Loops'}{
                    $info->{'BlockID'}
                } ;            
        }
        elsif (exists $info->{'VarAccesses'} ) { 
            $state = _get_iters_for_vars($info->{'VarAccesses'},'Read',$state);
        }
        
        elsif (exists $info->{'Assignment'} ) { # So we should run this before we rewrite with the dsmAPI
            # carp Dumper $info;
            $state = _get_iters_for_vars($info->{'Rhs'}{'VarAccesses'},'Read',$state);
            $state = _get_iters_for_vars($info->{'Lhs'}{'VarAccesses'},'Write',$state);
        }                
        return ([[$line,$info]],$state);
    };
    my $state = { 'Loops'=>{}, 'VarAccessAnalysis'=>$accessAnalysis};
    (my $loop_annlines_,$state) = stateful_pass($annlines,$pass_rewrite_loop_bounds,$state,"pass_rewrite_loop_bounds($f)");
    my $iters = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'};
    # carp "$f VarAccessAnalysis: ".Dumper $iters;

#     So now we have our IterTable as part of the LoopNests info. 
#     We can now do the checks:
# Partition conflicts: not all arrays for a given iterator have the same partition info 
# i => {p1 => 0, p2 =>0 } then look up Partition[0] for p1 and p2
# This requires linking the iterator with the index in the Partition field
for my $block_id (sort keys %{$state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'} }) {
    next if $block_id eq '0';
    for my $iter (sort keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'} }) {
        if (scalar keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter} }>1) {
            my $partitions_check={};
        for my $varname (sort keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter} }) {
            my $idx = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter}{$varname};
            my $subset = in_nested_set( $Sf, 'Vars', $varname );
            my $decl = get_var_record_from_set($Sf->{$subset},$varname);
            if (exists $decl->{'Partitions'}) {
                my $partition =  $decl->{'Partitions'}[$idx];
                $partitions_check->{$partition}=$varname;
            }
        }
        if (scalar keys %{$partitions_check} != 1) {
            die "Partition conflict in loop $block_id, iter $iter: ".Dumper($partitions_check);
        }
        } # otherwise no need to check
    }
}
# carp $f.': Passed Partitions Check';
# Halo conflicts => That is interesting:
# - suppose the loop bound is -1 .. 102 and at least one array only has a dim smaller than that => BOOM!
# So first of all get the loop range 
for my $block_id (sort keys %{$state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'} }) {
    next if $block_id eq '0';
    my $iter = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Iterator'};
    my $range = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'};
     
    my $loop_extent = $range->[1] - $range->[0] + 1;
    # carp "$block_id $iter Range: $loop_extent: ". Dumper($range);
    my $loop_dim_check={};
    my $collective_arrays={};
    $loop_dim_check->{$iter}{'Extent'} = $loop_extent;
    # for my $iter (sort keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'} }) {
        my $prev_core_dim = 0;
        for my $varname (sort keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter} }) {
            my $subset = in_nested_set( $Sf, 'Vars', $varname );
            if ($subset) {
                my $decl = get_var_record_from_set($Sf->{$subset},$varname);            
                if (not exists $decl->{'Partitions'}) {
                    warning("Array $varname in $f is not a collective array", $WDBG );                    
                } elsif ( exists $decl->{'Halos'}) {                    
                    $collective_arrays->{$varname}=1;
                    $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{'0'}{'Arrays'}{$varname}{'Halos'} = $decl->{'Halos'};
                } else {
                    croak "ERROR: No Halo information for $varname in $f ";
                }
            }
            my $idx = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter}{$varname};
    
            my $dim = $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{'0'}{'Arrays'}{$varname}{'Dims'}[$idx];
            my $dim_size = $dim->[1] - $dim->[0] + 1;
            if (exists $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{'0'}{'Arrays'}{$varname}{'Halos'}) {
                my $halo = $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{'0'}{'Arrays'}{$varname}{'Halos'}[$idx];
                my ($lh, $hh) = @{$halo};
                my $core_dim = $dim_size - $lh - $hh;
                if ($prev_core_dim == 0) {
                    $prev_core_dim =  $core_dim;
                } elsif ($prev_core_dim != $core_dim) {
                    die "Not all core dimensions are identical: ". Dumper()
                }
                $loop_dim_check->{$iter}{'Vars'}{$varname} = [$dim_size, $halo];
            } else {
                warning( "Array $varname in $f does not have halo info",$WDBG);
            }
            # carp "SUB $f ARRAY $varname Dim Size for $iter : $dim_size" ;#.Dumper  %{ $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{'0'}{'Arrays'}{$varname}{'Dims'}{$idx}};
            # So we now had best put 
            
        }
    # }
    # say 'INFO: LOOP DIM CHECK: '. Dumper( $loop_dim_check) if $I;
    
    # First we need to check if all arrays have the same core size

    my $min_dim_size = 0;
    my $var_with_min_dim_size = '';
    for my $varname (sort keys %{$loop_dim_check->{$iter}{'Vars'}}) {
        next unless exists $collective_arrays->{$varname};
        my $dim_size = $loop_dim_check->{$iter}{'Vars'}{$varname}[0];
        my ($lh,$hh) = @{$loop_dim_check->{$iter}{'Vars'}{$varname}[1]};
        if ($dim_size < $loop_extent) {
            error( 'Loop bounds exceed array dimensions', $EDBG);
        } elsif ($dim_size == $loop_extent) {
            say "INFO: Use Dim and Halo info from $varname: $dim_size, ($lh,$hh) " if $I;
            last;
        } else {
            if ($min_dim_size == 0) {
                $min_dim_size = $dim_size;
                $var_with_min_dim_size = $varname;
            } else {
                $min_dim_size = $dim_size < $min_dim_size ? $dim_size : $min_dim_size;
                $var_with_min_dim_size = $dim_size < $min_dim_size ? $varname : $var_with_min_dim_size;
            }
        }
    }
    if ($min_dim_size != 0) {
        my ($lh,$hh) = @{$loop_dim_check->{$iter}{'Vars'}{$var_with_min_dim_size}[1]};
        say "INFO: Use Dim and Halo info from $var_with_min_dim_size: $min_dim_size, ($lh,$hh)" if $I;
    }
}

#and the array dims 
# - suppose the loop bound is 0 .. 101 and an array has a dim of 104 and a halo of 2, and another has a dim of 102 and a halo of 1
# So it looks like what we need to do is figure out the core, and see if all cores are the same, otherwise BOOM!
# Then, 
# if any dim < the loop range BOOM!
# If any dim  == loop range and the rest > loop range, we use the the halo of the smaller ones
# If the dims == loop range, no problem    
# If all dims > loop range, we use the the halo of the smaller ones

# once that is done, we can do the rewrite 

    #  map {say $_} @{pp_annlines($updated_loop_annlines,1)};
    # say "\nRefactored code for $f\n";
    # emit_RefactoredCode($stref,$f,$updated_loop_annlines); 
    return  $stref ;
}

sub _get_iters_for_vars { my ($accesses,$rw,$state) = @_;
    for my $var (sort keys %{$accesses->{'Arrays'}}) {
        $state = _get_iters_for_var($var,$accesses->{'Arrays'}{$var}{$rw},$state);
    }
    return $state;
}

sub _get_iters_for_var { my ($var,$exprs,$state) = @_;
    for my $k (sort keys %{$exprs->{'Accesses'}}){
        # The access for each iterator
        for my $rec (@{$exprs->{'Accesses'}{$k}}) {
            my ($iter_idx_str, $mult_offset) = each %{$rec};
            my ($mult,$offset) = @{$mult_offset};
            my ($iter, $idx) = split(/:/,$iter_idx_str);
            for my $block_id (sort keys %{$state->{'Loops'}}) {
                if ($state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Iterator'} eq $iter) {
                    $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter}{$var}=$idx unless $iter eq '?';
                    # $state->{'IterTable'}{$block_id}{$iter}{$var}=$mult_offset unless $iter eq '?';
                }
            }
        }
    }
    return $state;
}
# conv



1;
