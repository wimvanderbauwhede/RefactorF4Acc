# Rename array accesses and declarations to use the DSM API
package RefactorF4Acc::Refactoring::DSM;
use v5.10;
# 
#   (c) 2021 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   


=pod
Status 2021-05-11 I think we have several days more work to debug this

Novelty:

- type annotation based approach rather than conventional pragmas
- use of DSM instead of straigth MPI
- analysis and refactoring: stencils and map/fold

Done: 
- definition and parsing of annotations
- definition of DSM types
- rewrite of declarations, including inheritance of annotations
- rewrite of DSM access expressions except array expressions
- rewrite of loop bounds assuming they are Map or StencilMap
- Implement the full SOR loop from LES　#OK
- Add loop annotations : Map, Iter, Fold; I think we might already have the stencil analysis so no need #OK see Parser::__handle_trailing_pragmas
- Check the reach for every array in a loop nest, to see if it does not exceed the halos, See DSM::__check_reach; TODO: better errors
- Insert barriers, at first after every loop nest based on the info in the LoopNature pragma. This uses a new algorithm to find the "full" loop nest for an array. Currently it inserts a dsmBarrier() call for Map, we can now easily add he code for Fold as well. 
- Insert init, allocate and deallocate statements. TODO: with proper Info, currently it is Textual

TODO:


- Rewrite of Fold and Stencil Fold
    *** The main things to do is that the $acc.'_chunks' variable must be declared and added to the $Sf->{'Vars'}, OK now
    *** I guess the Textual hack won't survive for long! Need the ASTs!

    *** An issue with the $acc.'_chunks' is that if they are in a routine (e.g. sor) and the routine is called in a loop, we do alloc/dealloc of DSM repeatedly and that is expensive. So these alloc/dealloc should be lifted to outside that loop
    

    Reductions are done with a global array of nprocesses but the final reduced value is local, so no need for locks but we do need a barrier before reducing that array. See the Haskell code.

    Suppose we have

    acc = 0
    do i = 1 , ip
    do j= 1, jp
        acc = f_assoc0(acc,p(i,j))
    end do
    end do

    and we chunk the bounds:

    acc_chunks is a collective array of size dsmNX, dsmNY starting at (0,0)
    - So declare it and allocate it

    - Find the original AnnLine where acc is initialised and rewrite it:
    This is really textual: $acc_var.'_chunks(nodeXCoord, nodeYCoord)'
    But we do this using the AST: 
    (Maybe start by calling then nodeXCoord and nodeYCoord)
    [10, $acc_var.'_chunks', [27,[2,'dsmNX'],[2,'dsmNY']]],
    
    NOTE: of the accumulator is already an array, we need to add the extra args and have an appropriate declaration

    This will then be rewritten in the next pass
    
    acc_chunks(nodeXCoord, nodeYCoord) = 0 

    do i = dsmLB(dsmNX, 1, ip) , dsmUB(dsmNX, 1, ip)
    do j= dsmLB(dsmNY, 1, jp) , dsmUB(dsmNY, 1, p)
    ! Rewrite the acc expression, this is again is textual and will be rewritten in the next pass
    So we go trough the RHS AST and find the occurence of acc and rewrite it as an array 
        acc_chunks(nodeXCoord, nodeYCoord) = f_assoc0(acc_chunks(nodeXCoord, nodeYCoord),p(i,j))
    end do
    end do

    We need the acc over the full domain so we need to accumulate over f_assoc0
    We do this immediately after the EndDo of the accumulation loop 
    I expect we need a barrier here
    call dsmBarrier()
    acc = 0
    do nx = 0, dsmNX-1
    do ny = 0, dmsNY-1
    ! This will be rewritten in the next pass
    acc = f_assoc0(acc,acc_chunks(nx,ny))
    end do
    end do
- Finish the LoopNature analysis and use it to annotate the loops with their nature
- Rewrite of array expressions
    ∘ v1 is collective; v2 is not; they have the same size (useless of course but nevermind)
    ∘ So we can write v1=v2. That is OK, we can use dsmMemCopy1D
    ∘ v1=v2 can also work : in principle this is can become a loop with reads, or I can do another memcopy
    ∘ Accesses are not a problem
- In principle we should be able to handle the red-black condition
     do l=1,nmaxp
        sor = 0.0
        do nrd=0,1
        do k=1,km 
        do j=1,jm
        do i=1+mod(k+j+nrd,2),im,2

        *** Simple approach for the modulo: if the RHS is constant we ignore the LHS and just consider the bound, i.e. 
        expr % m => [0,m-1] 
        If the modulo is used for the lower bound, we use the 0; for the higher bound we use the m-1

        In fact, I think technically the code above is incorrect:

        i = 1+0 , 10, 2 => 1,3,5,7,9 
        i = 1+1, 10, 2 => 2,4,6,8,10

        so the correct upper bound expression is im-1+mod(k+j+nrd,2)

        i = 1+0 , 10-1+0, 2 => 1,3,5,7,9 
        i = 1+1, 10-1+1, 2 => 2,4,6,8,10

        In practice this means we have to retain the expression because it does not evaluate to a constant. This would actually be the case for any expression that is a linear combination of iterators, like
        do i=1,im
        do j=1,i

        I think we will just refer to polyhaedral analysis for future work.
- And of course I must make sure that loops work in any order
- And check what happens with indices like l and nrd, in terms of the IterTable
- Maybe insertion of MemCopy statements
- Better annotations
        We can either have a declaration at code unit level, inherited by any routine called:

        !$RF4A halos((2,2),(2,2),(2,2)), partitions(NPX, NPY, NPZ) :: p, u,v,w, f,g,h

        Or we have them on a per-var level

        real, dimension(-1:ip+2,-1,jp+2,-1,kp+2) :: p !$RF4A halos((2,2),(2,2),(2,2)), partitions(NPX, NPY, NPZ)

        Also, we can have shorter notations such has 
        halo((2,1)) ! all dims have (2,1)
        halo(2) ! all dims have (2,2)
        halo(2,1,0) ! dims have (2,2),(1,1),(0,0)


=cut

use vars qw( $VERSION );
$VERSION = "6.1.0";

use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use v5.10;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Utils::Functional qw( elem );
use RefactorF4Acc::Parser::Expressions qw( get_vars_from_expression _traverse_ast_with_stateful_action get_args_vars_from_subcall);
use RefactorF4Acc::Refactoring::Helpers qw( stateless_pass stateful_pass splice_additional_lines_cond);
use RefactorF4Acc::Analysis::VarAccessAnalysis qw( analyseAllVarAccesses );
use RefactorF4Acc::Analysis::LoopNature qw( resolve_loop_nests );
use RefactorF4Acc::Emitter qw( emit_AnnLines );

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
    local $I=0;
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
        $stref = insert_init_alloc_dealloc_statements($stref,$f);

        emit_AnnLines($stref,$f,$Sf->{'RefactoredCode'}) if $f=~/sor/;
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
    my $annlines = $Sf->{'RefactoredCode'};

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
                    push @{$Sf->{'CollectiveVars'}},$varname;
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
            # carp  $line . Dumper $info;#->{'Lhs'}{'ExpressionAST'} , $info->{'Rhs'}{'ExpressionAST'};
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
            # carp $line.Dumper $info->{'Rhs'}{'Vars'} if $lhs_varname eq 'rhsav' ;
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
                    $Sf->{'CalledSubs'}{'Set'}{$name} = [1,1]; # mark $name a called sub in $f
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
    emit_AnnLines($stref,$f,$updated_loop_annlines); 
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
    # emit_AnnLines($stref,$f,$updated_loop_annlines) if $f=~/test_loop/;
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

    ($rhs_dsm_ast,$dsm_vars) = _traverse_ast_with_stateful_action($rhs_dsm_ast, $dsm_vars, $f);
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
        # carp Dumper $ast;
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

sub rewrite_loop_bounds { my ( $stref, $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'} ;
    # This is to get the LoopNests information
    ($stref,my $accessAnalysis) = analyseAllVarAccesses($stref, $f, [], $annlines);
    # croak $f, Dumper $accessAnalysis->{'LoopNests'};
    # This adds Contains, maybe I should integrate it in analyseAllVarAccesses
    ($accessAnalysis, my $blocks_per_nestlevel_, my $max_lev_) = resolve_loop_nests($stref, $f, $accessAnalysis);
    # say 'HERE0';
    __check_reach( $stref, $f);
    # say 'HERE1';
    my $state = {'VarAccessAnalysis' =>$accessAnalysis};
    # say 'HERE2';
    $state = __link_iters_vars($f, $annlines, $state);
    # say 'HERE3';
    $state = __determine_full_nests($f, $annlines, $state);
    # say 'HERE4';


    my $iters = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'};


    # FACTOR OUT!
    #     So now we have our IterTable as part of the LoopNests info. 
    #     We can now do the checks:
    # Partition conflicts: not all arrays for a given iterator have the same partition info 
    # i => {p1 => 0, p2 =>0 } then look up Partition[0] for p1 and p2
    # This requires linking the iterator with the index in the Partition field
    my $dims_halos_partitions ={};
    for my $block_id (sort keys %{$state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'} }) {
        next if $block_id eq '0';
        for my $iter (sort keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'} }) {
            if (scalar keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter} }>=1) {
                my $partitions_check={};
            for my $varname (sort keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter} }) {
                # say "Trying to add partition info: $f $block_id $iter $varname";
                my $idx = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter}{$varname};
                my $subset = in_nested_set( $Sf, 'Vars', $varname );
                my $decl = get_var_record_from_set($Sf->{$subset},$varname);
                if (exists $decl->{'Partitions'}) {
                    my $partition =  $decl->{'Partitions'}[$idx];
                    $partitions_check->{$partition}=$varname;
                    $dims_halos_partitions->{$block_id}[0] = $partition;
                    say "INFO: $f $block_id $iter: Add partition info: $partition" if $I;
                }
            }
            if (scalar keys %{$partitions_check} > 1) {
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
        next if $iter eq ''; # Because that means it's an If block
        my $range = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'};
        
        my $loop_extent = $range->[1] - $range->[0] + 1;
        # carp "$block_id $iter Range: $loop_extent: ". Dumper($range);
        my $loop_dim_check={};
        my $collective_arrays={};
        $loop_dim_check->{$iter}{'Extent'} = $loop_extent;
        my $prev_core_dim = 0;
        my $prev_lh=0;
        my $prev_hh=0;
        my $prev_idx=-1;
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
                    $prev_lh = $lh;
                    $prev_hh = $hh;
                    $prev_idx = $idx;
                } elsif ($prev_core_dim != $core_dim) {
                    die "Not all core dimensions are identical" . Dumper($state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter});
                } elsif ($prev_lh != $lh or $prev_hh != $hh ) {
                    die "Not all halos dimensions are identical" . Dumper($state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter});
                } elsif ($prev_idx != $idx ) {
                    die "Not all iterator indices are identical" . Dumper($state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter});
                }
                $loop_dim_check->{$iter}{'Vars'}{$varname} = [$dim_size, $halo, $idx];
            } else {
                warning("Array $varname in $f does not have halo info",$WDBG);
            }
        }
        # say 'INFO: LOOP DIM CHECK: '. Dumper( $loop_dim_check) if $I;
        
        # First we need to check if all arrays have the same core size

        my $min_dim_size = 0;
        my $var_with_min_dim_size = '';
        for my $varname (sort keys %{$loop_dim_check->{$iter}{'Vars'}}) {
            next unless exists $collective_arrays->{$varname};
            my $dim_size = $loop_dim_check->{$iter}{'Vars'}{$varname}[0];
            my ($lh,$hh) = @{$loop_dim_check->{$iter}{'Vars'}{$varname}[1]};
            my $idx = $loop_dim_check->{$iter}{'Vars'}{$varname}[2];
            
            if ($dim_size < $loop_extent) {
                error( 'Loop bounds exceed array dimensions', $EDBG);
            } elsif ($dim_size == $loop_extent) {
                say "INFO: $f $block_id $iter: Use Dim and Halo info from $varname: $dim_size, ($lh,$hh) (exact)" if $I;
                $dims_halos_partitions->{$block_id}[1] = $loop_dim_check->{$iter}{'Vars'}{$varname};
                $dims_halos_partitions->{$block_id}[2] = $varname;
                $dims_halos_partitions->{$block_id}[3] = $idx;
                
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
            $dims_halos_partitions->{$block_id}[3] = $idx;
        }
        if ($min_dim_size != 0) {
            my ($lh,$hh) = @{$loop_dim_check->{$iter}{'Vars'}{$var_with_min_dim_size}[1]};
            say "INFO: $f $block_id $iter: Use Dim and Halo info from smallest: $var_with_min_dim_size: $min_dim_size, ($lh,$hh)" if $I;
            $dims_halos_partitions->{$block_id}[1] = $loop_dim_check->{$iter}{'Vars'}{$var_with_min_dim_size};
                $dims_halos_partitions->{$block_id}[2] = $var_with_min_dim_size;
                
        }
    }

#and the array dims 
# - suppose the loop bound is 0 .. 101 and an array has a dim of 104 and a halo of 2, and another has a dim of 102 and a halo of 1

# So it looks like what we need to do is figure out the core, and see if all cores are the same, otherwise BOOM!

# Then, 
# if any dim < the loop range BOOM!
# If any dim  == loop range and the rest > loop range, we use the the halo of the smaller ones
# If the dims == loop range, no problem    
# If all dims > loop range, we use the the halo of the smallest one. This is rather ad-hoc because halos could be asymmetrical
# Maybe we should simply say that the halos must be the same or we don't proceed?

# now that this is done, we can do the rewrite the loops:
# Get the loop bounds from Range
    for my $block_id (sort keys %{$state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'} }) {
        next if $block_id eq '0';
        # If there is no partitionable array here we should not rewrite the loop bounds
        next unless exists $dims_halos_partitions->{$block_id};
        my $iter = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Iterator'};
        my $range = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'};
        my ($lbound, $ubound) = @{$range};
        
        my ($partition,$dim_sz_halos, $var_, $idx) = @{$dims_halos_partitions->{$block_id}};
        my ($dim_sz,$halos) = @{$dim_sz_halos};
        my ($lh, $uh) = @{$halos};        
        my $chunk = ($dim_sz - $lh - $uh)/$partition;
        # Suppose I have an array which starts at 3 and goes to 102, with a halo of 5 on each side
        # Chunking it in two would be: 102-3+1 = 100/2 = 50; 3->3+50-1; 3-5 to 52+5 : -2 to 57 = 60
        # Suppose the array is 1 to w and the halos are (2,2) 
        my $chunk_lb = $lbound; # say 0;1 and upper bound is 99;100 and chunk is 25 and partition is 4
        my $extra = $ubound - $lbound - $chunk*$partition; # extra = 99-0;100-1 - 25*4 = -1
        my $chunk_ub = $chunk + $lbound + $extra; # 25+0;1-1 = 24,25
        # Let's assume we have dsmNX and dsmNY either as functions or as module globals
        $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[0] = $chunk_lb.'+'.$chunk.'*'._gen_chunk_coord($idx);
        $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[1] = $chunk_ub.'+'.$chunk.'*'._gen_chunk_coord($idx);            
    }

    # So now we have for every BlockID the rewritten Range in 
    # We need to get this into $info->{'Do'}{'Range'}{'Expressions'}
    # A simple stateless pass on 'Do' should do this
    my $pass_rewrite_loop_bounds = sub { my ($annline) = @_;
        my ($line,$info) = @{$annline};
        if (exists $info->{'Do'}) {
            my $block_id = $info->{'BlockID'};
            $info->{'Do'}{'Range'}{'Expressions'}[0] = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[0];
            $info->{'Do'}{'Range'}{'Expressions'}[1] = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[1];
        }
        return [[$line,$info]];
    };
    my $rewritten_loop_annlines = stateless_pass($annlines,$pass_rewrite_loop_bounds,"pass_rewrite_loop_bounds($f)");    
    
    my $new_annlines = __insert_barriers_after_map($f, $rewritten_loop_annlines, $state);
    $Sf->{'RefactoredCode'} = $new_annlines;
    $stref = rewrite_fold_loops($stref,$f,$state);
    #  map {say $_} @{pp_annlines($updated_loop_annlines,1)};
    # say "\nRefactored code for $f\n";
    # emit_AnnLines($stref,$f,$rewritten_loop_annlines); 
    return  $stref ;
} # END of rewrite_loop_bounds

sub _gen_chunk_coord { my ($idx) = @_;
    return $idx==0 
        ? 'dsmNX' 
        : $idx==1  
            ? 'dsmNY' 
            : 1; #croak "Index must be 0 or 1: $idx";
}

sub _get_iters_for_vars { my ($accesses,$rw,$state) = @_;
    for my $var (sort keys %{$accesses->{'Arrays'}}) {
        $state = _get_iters_for_var($var,$accesses->{'Arrays'}{$var}{$rw},$state);
    }
    return $state;
}

sub _get_iters_for_var { my ($var,$exprs,$state) = @_;
# 	'Accesses' => { '0:1' =>  {'j:0' => [1,0],'k:1' => [1,1]}}, 
# 'Iterators' => ['i:0',...]
    my $iters=$exprs->{'Iterators'};    
    for my $k (sort keys %{$exprs->{'Accesses'}}){
        # The access for each iterator    
        
        for my $rec (@{$exprs->{'Accesses'}{$k}}) {
            my ($iter_idx_str, $mult_offset) = %{$rec};
            my ($mult,$offset) = @{$mult_offset};
            my ($iter, $idx) = split(/:/,$iter_idx_str);
            
            for my $block_id (sort keys %{$state->{'Loops'}}) {
                if ($state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Iterator'} eq $iter) {
                    $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$iter}{$var}=$idx unless $iter eq '?';
                    # # As there can be no conflicts, and having e.g. v(i,j) and v(j,i) in the same expression does not make much sense, this is OK
                    # $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}{$var}[$idx]=$iter;
                    # $state->{'IterTable'}{$block_id}{$iter}{$var}=$mult_offset unless $iter eq '?';
                }
            }
        }
    }
    return $state;
}


# - Check the reach for every array in a loop nest, to see if it does not exceed the halos!
#     do j
#     do k
#     p(0,j,k)=p(im,j,k)
#     p(im+1,j,k) = p(1,j,k)
#     end do
#     end do

#     This will give a reach of [0,im+1] on the LHS and [1,im] on the RHS
#     So we modulo the core, because what we want is to make sure acccesses are not in the core
#     [0 % im,im+1 % im] on the LHS and [1 % im,im % im] on the RHS

# Array accesses are stored in $info->...->{'VarAccesses'}{'Arrays'}{$array_var}{$rw}=
# {
# 	'Exprs' => { $expr_str_1 => '0:1',...},
# 	'Accesses' => { '0:1' =>  {'j:0' => [1,0],'k:1' => [1,1]}}, 
# 	'Iterators' => ['j:0','k:1']
# };

sub __check_reach { my ( $stref, $f ) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'} ;

my $pass__check_reach = sub { my ($annline) = @_;
    my ($line,$info) = @{$annline};
    # say "$f LINE $line" if not exists $info->{'BlockID'};
    if (exists $info->{'BlockID'} and $info->{'BlockID'} ne '0') {
        if (exists $info->{'VarAccesses'} ) {             
            # carp Dumper  $info->{'VarAccesses'};
            __check_var_reach($stref,$f, $info->{'VarAccesses'},'Read');            
        }        
        elsif (exists $info->{'Assignment'} ) { # So we should run this before we rewrite with the dsmAPI
            # carp Dumper $info;
            # carp Dumper  $info->{'Rhs'}{'VarAccesses'};
            # carp Dumper  $info->{'Lhs'}{'VarAccesses'};
            __check_var_reach($stref,$f, $info->{'Rhs'}{'VarAccesses'},'Read');
            __check_var_reach($stref,$f, $info->{'Lhs'}{'VarAccesses'},'Write');
        }   
    }
    return [$annline];
};

my $annlines_ = stateless_pass($annlines,$pass__check_reach,"pass__check_reach($f)");

} # END of __check_reach

sub __check_var_reach { my ($stref,$f, $accesses,$rw) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    # my %reach=();
    
    for my $varname (sort keys %{$accesses->{'Arrays'}}) {
        # carp Dumper $accesses->{'Arrays'}{$varname}{$rw}{'Accesses'};
        # say "ARRAY VAR $varname";

        my $subset = in_nested_set( $Sf, 'Vars', $varname );
        my $decl = get_var_record_from_set($Sf->{$subset},$varname);
        my $dims = $decl->{'ConstDim'};    
        if (not exists $decl->{'Parameter'}) {
            if ($decl->{'MemSpace'} eq 'Collective') { 
                if (exists $decl->{'Halos'} and exists $decl->{'Partitions'}) {
                    my $halos = $decl->{'Halos'};
                    my $partitions = $decl->{'Partitions'};
                    my @core_szs = ();
                    my $idx=0;
                    # carp Dumper $decl;
                    for my $dim (@{$dims}) {
                        push @core_szs , ($dim->[1] - $dim->[0] +1 - $halos->[$idx][0]- $halos->[$idx][1])/$partitions->[$idx];
                        ++$idx;
                    }
                    # carp Dumper @core_szs;
                    my $reach = dclone($halos);
                    for my $k  (sort keys %{$accesses->{'Arrays'}{$varname}{$rw}{'Accesses'}} ) {
                        # {'j:0' => [1,0],'k:1' => [1,1]}}
                        my $mult_offset_list = $accesses->{'Arrays'}{$varname}{$rw}{'Accesses'}{$k};
                        for my $rec (@{$mult_offset_list}) {
                            
                            my ($iter_pos,$mult_offset) =  %{$rec};
                            # carp Dumper $iter_pos,$mult_offset;
                            # my $mult_offset = $rec->{$iter_pos};
                            my ($iter,$pos) = split(/:/,$iter_pos);
                            my ($mult,$offset) = @{$mult_offset};
                            if ($mult>1) {
                                croak "$f Only array indices of the form $iter+offset are supported";
                            }
                            # The halo tells us how many points pos and neg we can go
                            # So offset = -1 and -2 is compatible with halo==2, assuming the array starts at 1
                            # Offset +1 and +2 are fine 
                            if ($offset<0 and -$offset % $core_szs[$pos] > $reach->[$pos][0] ) {
                                say $offset % $core_szs[$pos] ,'<>', $reach->[$pos][0];
                                croak "Access not allowed (too low): $f $varname $iter+$offset"
                            }
                            if ($offset > 0 and $offset % $core_szs[$pos] > $reach->[$pos][1] ) {
                                # say $offset ,';', $core_szs[$pos],';', $offset % $core_szs[$pos] ,'<>', $reach->[$pos][1];
                                croak "Access not allowed (too high): $f $varname $iter+$offset"
                            }
                        }
                    }
                } else {
                    warning("Collective array $varname in $f has no halos so reach must be 0 to be valid");
                }
            }
        }
        # carp $f . Dumper %reach;

    } # loop over all vars on line
    
} # END of __check_var_reach 


sub __link_iters_vars { my ($f, $annlines, $state) = @_;
    my $pass_link_iters_vars = sub { my ($annline,$state) = @_;
        my ($line,$info) = @{$annline};
        # carp Dumper $state;
        if (exists $info->{'Do'}) {
                $state->{'Loops'}{
                    $info->{'BlockID'}
                } = 1;
        }
        elsif (exists $info->{'EndDo'}) {
            my $block_id = $info->{'BlockID'};
            delete $state->{'Loops'}{$block_id} ;  
            # if (exists $state->{'FullNest'}{$block_id} )  {
            #     say "rewrite_loop_bounds($f): full nest for variables ".join(', ',sort keys %{$state->{'FullNest'}{$block_id}}).' at loop end '. $block_id;
            #     # my $loop_vars = sort keys %{$state->{'FullNest'}{$block_id}};
            #     my $loop_nature =  $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'LoopNature'};
            #     if (defined $loop_nature and
            #     $loop_nature->[0] eq 'Map') {
            #         say "$f: Adding a BARRIER";
            #     my $n_info = {
            #         'SubroutineCall' => {
            #             'Name' => 'dsmBarrier',
            #             'Args' => {
            #                 'List' => [],
            #                 'Set' => {}
            #             },
            #         },
            #         'Indent' => $info->{'Indent'},
            #         'LineID' => $info->{'LineID'}+0.1,
            #         'Ann' => [annotate($f, __LINE__)]
            #     };

            #     return ([
            #         [$line,$info],
            #         [ $info->{'Indent'} . "call dsmBarrier()",$n_info]
            #         ],$state);
            #     }
            # }
        }
        elsif (exists $info->{'VarAccesses'} ) { 
            $state = _get_iters_for_vars($info->{'VarAccesses'},'Read',$state);
            # $state = _find_enclosing_outer_loop($f, $annline, $info->{'VarAccesses'},'Read', $state);
        }
        
        elsif (exists $info->{'Assignment'} ) { # So we should run this before we rewrite with the dsmAPI
            # carp Dumper $info;
            $state = _get_iters_for_vars($info->{'Rhs'}{'VarAccesses'},'Read',$state);
            $state = _get_iters_for_vars($info->{'Lhs'}{'VarAccesses'},'Write',$state);
            # $state = _find_enclosing_outer_loop($f, $annline, $info->{'Rhs'}{'VarAccesses'},'Read', $state);
            # $state = _find_enclosing_outer_loop($f, $annline, $info->{'Lhs'}{'VarAccesses'},'Write', $state);
            # To handle Fold, we need to know here what the enclosing FullNest block id is.
            # Maybe best do that in an additional pass where we use the FullNest state and link it with an Acc
        }                
        return ([[$line,$info]],$state);
    };
    $state->{'Loops'}={};
    (my $loop_annlines,$state) = stateful_pass($annlines,$pass_link_iters_vars,$state,"pass_link_iters_vars($f)");
    return $state;
} # END of __link_iters_vars



sub __determine_full_nests { my ($f, $annlines, $state) = @_;
   
    my $pass_determine_full_nests = sub { my ($annline,$state) = @_;
        my ($line,$info) = @{$annline};
        if (exists $info->{'EndDo'}) {
            my $block_id = $info->{'BlockID'};
            if (exists $state->{'FullNest'}{$block_id} )  {
                # say "rewrite_loop_bounds($f): full nest for variables ".join(', ',sort keys %{$state->{'FullNest'}{$block_id}}).' at loop end '. $block_id;
                # my $loop_vars = sort keys %{$state->{'FullNest'}{$block_id}};
                # carp Dumper $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id};
                my $loop_nature =  $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'LoopNature'};
                # carp Dumper $loop_nature;
                if (defined $loop_nature and
                $loop_nature->[0] eq 'Map') {
                    say "$f: Adding a BARRIER";
                my $n_info = {
                    'SubroutineCall' => {
                        'Name' => 'dsmBarrier',
                        'Args' => {
                            'List' => [],
                            'Set' => {}
                        },
                    },
                    'Indent' => $info->{'Indent'},
                    'LineID' => $info->{'LineID'}+0.1,
                    'Ann' => [annotate($f, __LINE__)]
                };

                return ([
                    [$line,$info],
                    [ $info->{'Indent'} . "call dsmBarrier()",$n_info]
                    ],$state);
                }
            }
        }
        elsif (exists $info->{'VarAccesses'} ) { 
            $state = _find_enclosing_outer_loop($f, $annline, $info->{'VarAccesses'},'Read', $state);
        }
        
        elsif (exists $info->{'Assignment'} ) { # So we should run this before we rewrite with the dsmAPI
            $state = _find_enclosing_outer_loop($f, $annline, $info->{'Rhs'}{'VarAccesses'},'Read', $state);
            $state = _find_enclosing_outer_loop($f, $annline, $info->{'Lhs'}{'VarAccesses'},'Write', $state);
            # To handle Fold, we need to know here what the enclosing FullNest block id is.
            # Maybe best do that in an additional pass where we use the FullNest state and link it with an Acc
        }              
        return ([[$line,$info]],$state);
    };
    $state->{ 'FullNest'} = {};
    (my $loop_annlines,$state) = stateful_pass($annlines,$pass_determine_full_nests,$state,"pass_determine_full_nests($f)");
    return $state;
} # END of __determine_full_nests



sub __insert_barriers_after_map { my ($f, $annlines, $state) = @_;
   
    my $pass_insert_barriers = sub { my ($annline) = @_;
        my ($line,$info) = @{$annline};
        if (exists $info->{'EndDo'}) {
            my $block_id = $info->{'BlockID'};
            if (exists $state->{'FullNest'}{$block_id} )  {
                # say "rewrite_loop_bounds($f): full nest for variables ".join(', ',sort keys %{$state->{'FullNest'}{$block_id}}).' at loop end '. $block_id;
                # my $loop_vars = sort keys %{$state->{'FullNest'}{$block_id}};
                my $loop_nature =  $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'LoopNature'};
                if (defined $loop_nature and
                $loop_nature->[0] eq 'Map') {
                    say "$f: Adding a BARRIER";
                my $n_info = {
                    'SubroutineCall' => {
                        'Name' => 'dsmBarrier',
                        'Args' => {
                            'List' => [],
                            'Set' => {}
                        },
                    },
                    'Indent' => $info->{'Indent'},
                    'LineID' => $info->{'LineID'}+0.1,
                    'Ann' => [annotate($f, __LINE__)]
                };

                return [
                    [$line,$info],
                    [ $info->{'Indent'} . "call dsmBarrier()",$n_info]
                    ];
                }
            }
        }
        return [[$line,$info]];
    };
    my $loop_annlines = stateless_pass($annlines,$pass_insert_barriers,"pass_insert_barriers($f)");
    return $loop_annlines;
} # END of __insert_barriers_after_map



=pod
I think a cleaner way is as follows:

- for every line with 
$info->...->{'VarAccesses'}{'Arrays'}{$array_var}{$rw}=
{
	'Exprs' => { $expr_str_1 => '0:1',...},
	'Accesses' => { '0:1' =>  {'j:0' => [1,0],'k:1' => [1,1]}}, 
	'Iterators' => ['j:0','k:1']
};

- For every iterator
- Check if that iterator is the one of the block id; remove it from the set and repeat
- look at the enclosing block via InBlock
- Check if that iterator is the one of the block id; remove it from the set and repeat
=cut
sub _find_enclosing_outer_loop { my ($f, $annline, $accesses, $rw, $state) =@_;
    my ($line,$info) = @{$annline};
    my $block_id = $info->{'BlockID'};
    return $state if $block_id eq '0';
    for my $array_var (sort keys %{$accesses->{'Arrays'}}) {
        my %iters = map { my ($iter,$idx) = split(/:/,$_) ; $iter => $idx } @{ $accesses->{'Arrays'}{$array_var}{$rw}{'Iterators'} };
        my $n = scalar keys %{iters};
        my $block_id = $info->{'BlockID'};

        if (exists $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}) {
            # carp Dumper $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id};
            my $iter = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Iterator'};
            # my $sanity_counter  = 10; # Stop after 10 tries. FIXME: stop
            while (scalar keys %iters > 0 and $block_id ne '0') {
                if (exists $iters{$iter}) {
                    # say "Found $iter for $array_var in $block_id";
                    delete $iters{$iter};        
                    last if scalar keys %iters == 0;
                }

                $block_id = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'InBlock'};
                $iter = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Iterator'};
            }
            if (scalar keys %iters == 0) {
                # say "$f: FullNest for $array_var is $block_id"; 
                $state->{'FullNest'}{$block_id}{$array_var}=1;
            } else {
                croak "Problem: $array_var on <$line> in block $block_id is not fully enclosed by a loop nest";
            }      
        } else {
            say "_find_enclosing_outer_loop PROBLEM: no record in LoopNests for $block_id, $array_var";
        }
    }
    return $state;
} # END of _find_enclosing_outer_loop

=pod
- Insert init, allocate and deallocate statements
    - init and allocate can go after the last declaration
    - Ideally, init will allocate memory based on the size of the arrays tagged as DSM
        - get their sizes (or in Case 3, their halo size, big difference)
        - add them all up
        - multiply by 2, ad hoc
        - I guess I should create some parameters for this 
        - But initially just use DSM_MEMSZ and DSM_CACHESZ macros
        call dsmInit(DSM_MEMSZ,DSM_CACHESZ)        
        - Use DSM_NX and DSM_NY macros instead of dsmNX and dsmNY parameters 
        nNodes = dsmGetNNodes() 
        !put an assertion here to test that it is the same as dsmNX*dsmNY, else bail out

        nodeID = dsmGetNId()
        nodeXCoord = nodeId % dsmNX
        nodeYCoord = nodeId / dsmNX
    - deallocate just before the end of the program
    - This carries the assumption that we only have DSM at top level
    - But we can tag code units with hasDSMVars and then each of them can get this treatment
    - Just make this a map instead of a bool so we know which ones
=cut

# FIXME: Provide proper $info!
sub insert_init_alloc_dealloc_statements { my ($stref,$f) = @_;

    my $Sf = $stref->{'Subroutines'}{$f};
    if (exists $Sf->{'CollectiveVars'} and scalar @{$Sf->{'CollectiveVars'}}>0) {
        # We also need this after implicit none, do this via a simple stateless pass
        my $indent = '      ';
    my $dsm_preamble_annlines = [
        [$indent.'use dsmTypes',{'Textual'=>1}],
        [$indent.'use dsmAPI',{'Textual'=>1}],
        [$indent.'integer :: dsmNodeId',{'Textual'=>1}],
        [$indent.'integer :: dsmNNodes',{'Textual'=>1}],
        [$indent.'integer :: dsmXCoord, dsmYcoord',{'Textual'=>1}],
    ];

    my $init_annlines = [
        [$indent.'call dsmInit(dsmMemSize,dsmCacheSize)',{'Textual'=>1}],
        [$indent.'dsmNNodes = dsmGetNNodes()',{'Textual'=>1}],
        [$indent.'dsmNodeId = dsmGetNId()',{'Textual'=>1}],
        [$indent.'if (dsmNNodes /= dsmNX*dsmNY) then',{'Textual'=>1}],
        [$indent.'print *, "ERROR: total number of nodes", dsmNNodes, "does not match dsmNX*dsmNY:",dsmNX,"*",dsmNY,"=", dsmNX*dsmNY',{'Textual'=>1}],
        [$indent.'call exit',{'Textual'=>1}],
        [$indent.'else',{'Textual'=>1}],
        [$indent.'dsmXCoord = modulo(dsmNodeId, dsmNX)',{'Textual'=>1}],
        [$indent.'dsmYCoord = dsmNodeId / dsmNX',{'Textual'=>1}],
        [$indent.'end if',{'Textual'=>1}],
    ];

    # First we need to create all those allocation statements.
    # We use $Sf->{'CollectiveVars'}=[]     
    my ($allocation_annlines,$deallocation_annlines) = _gen_alloc_dealloc_annlines($Sf);
    # Deallocation and finish can also be done this via a simple stateless pass

    my $init_and_allocate_annlines = [@{$init_annlines},@{$allocation_annlines}];

    my $finish_annlines = [
        [$indent.'call dsmFinalise()',{'Textual'=>1}],
    ];

    my $deallocate_and_finish_annlines =[@{$deallocation_annlines},@{$finish_annlines}];

    my $annlines = $Sf->{'RefactoredCode'};
# First the easy part: put the preamble after implicit none and the dealloc/finish before the end of the program
    my $pass_add_preamble_dealloc_and_finish = sub { my ($annline) = @_;
        my ($line, $info) = @{$annline};
        if (exists $info->{'ImplicitNone'} ) {
            return [$annline,@{$dsm_preamble_annlines}]
        }
        if (exists $info->{'EndProgram'} ) {
            return [@{$deallocate_and_finish_annlines},$annline]
        }
        return [$annline];
    };

    my $annlines_with_pre_post = stateless_pass($annlines,$pass_add_preamble_dealloc_and_finish,"pass_add_preamble_dealloc_and_finish($f)");


    my $merged_annlines = splice_additional_lines_cond(
            sub {
                ( my $annline ) = @_;
                (my $line,my $info)=@{$annline};

                my $cond = (
                    (exists $info->{'HasVars'}
                    and not (exists $info->{'VarDecl'} or  
                    exists $info->{'ParsedVarDecl'} ))
                or exists $info->{'Control'}			
                
                ) ? 1 : 0;
                # if ($cond and $f=~/loop/) {croak $line.Dumper $info;}
                return $cond;
            },
            $annlines_with_pre_post,
            $init_and_allocate_annlines,
            1, # insert before
            0, # skip insertion condition line
            1 # do this only once
    );
    #  croak '???'.Dumper $annlines if $f=~/test_loop_nature/;
    # map {say $_} @{pp_annlines($merged_annlines)} and die if $f=~/test_loop_nature/;
        $Sf->{'RefactoredCode'} = $merged_annlines;
    } else {
        say "INFO: No Collective variables in $f" if $I;
    }
    return $stref;
} # End of insert_init_alloc_dealloc_statements

sub _gen_alloc_dealloc_annlines { my ($Sf) = @_;
    my @alloc_annlines=();
    my @dealloc_annlines=();
    my $indent = '      ';
    for my $varname (@{$Sf->{'CollectiveVars'}}) {
        my ($is_dsm_var,$var_decl) = _is_dsm_var($varname, $Sf);
        if ($is_dsm_var) {
            my $alloc_str = $indent.'call dsmAllocate'._dsmType($var_decl)."($varname)";
            my $dealloc_str = $indent.'call dsmDeallocate'._dsmType($var_decl)."($varname)";
            push @alloc_annlines,[$alloc_str,{'Textual'=>1}];
            push @dealloc_annlines,[$dealloc_str,{'Textual'=>1}];
        }
    }
    return (\@alloc_annlines,\@dealloc_annlines);
}

=pod
- Rewrite of Fold and Stencil Fold

    Reductions are done with a global array of nprocesses but the final reduced value is local, so no need for locks but we do need a barrier before reducing that array. See the Haskell code.

    Suppose we have

    acc = 0
    do i = 1 , ip
    do j= 1, jp
        acc = f_assoc0(acc,p(i,j))
    end do
    end do

    and we chunk the bounds:

    acc_chunks is a collective array of size dsmNX, dsmNY starting at (0,0)
    - So declare it and allocate it

    - Find the original AnnLine where acc is initialised and rewrite it:
    This is really textual: $acc_var.'_chunks(nodeXCoord, nodeYCoord)'
    But we do this using the AST: 
    (Maybe start by calling then nodeXCoord and nodeYCoord)
    [10, $acc_var.'_chunks', [27,[2,'dsmNX'],[2,'dsmNY']]],
    
    NOTE: of the accumulator is already an array, we need to add the extra args and have an appropriate declaration

    This will then be rewritten in the next pass
    
    acc_chunks(nodeXCoord, nodeYCoord) = 0 

    do i = dsmLB(dsmNX, 1, ip) , dsmUB(dsmNX, 1, ip)
    do j= dsmLB(dsmNY, 1, jp) , dsmUB(dsmNY, 1, p)
    ! Rewrite the acc expression, this is again is textual and will be rewritten in the next pass
    So we go trough the RHS AST and find the occurence of acc and rewrite it as an array 
        acc_chunks(nodeXCoord, nodeYCoord) = f_assoc0(acc_chunks(nodeXCoord, nodeYCoord),p(i,j))
    end do
    end do

    We need the acc over the full domain so we need to accumulate over f_assoc0
    We do this immediately after the EndDo of the accumulation loop 
    I expect we need a barrier here
    call dsmBarrier()
    acc = 0
    do nx = 0, dsmNX-1
    do ny = 0, dmsNY-1
    ! This will be rewritten in the next pass
    acc = f_assoc0(acc,acc_chunks(nx,ny))
    end do
    end do

So remaining issues:
1. How to find the initialisation of the accumulator. The right way to do this is as follows:
We do pass where we use the FullNest state of a Do and link it with an Acc:
when we find an Acc Assignment line, we look for the vars from FullNest block id
Do a stateful pass and accumulate the annlines, then do a reverse traversal


=cut    

sub rewrite_fold_loops { my ($stref,$f,$state) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    my $annlines = $Sf->{'RefactoredCode'};
    my $accessAnalysis = $state->{'VarAccessAnalysis'};

    my $pass_rewrite_folds = sub { my ($annline) = @_;
        my ($line, $info) = @{$annline};
        if (exists $info->{'Assignment'} and $info->{'BlockID'} ne '0') {
            my $lhs_var = $info->{'Lhs'}{'VarName'};
            my $rhs_var_list = $info->{'Rhs'}{'Vars'}{'List'};
            my $block_id = $info->{'BlockID'}; # FIXME:Maybe this is not OK: instead, I should annotate the lines with {'FullNestBlockID'}
            my $full_nest_block_id = __find_full_nest_block_id($block_id,$state);
            # carp "$f $line $block_id => $full_nest_block_id " . Dumper $accessAnalysis->{'LoopNests'}{'Set'}{$full_nest_block_id};
            if ( defined $accessAnalysis->{'LoopNests'}{'Set'}{$full_nest_block_id}{'LoopNature'} and
                $accessAnalysis->{'LoopNests'}{'Set'}{$full_nest_block_id}{'LoopNature'}[0] eq 'Fold') {
                my $acc_tuples = $accessAnalysis->{'LoopNests'}{'Set'}{$full_nest_block_id}{'LoopNature'}[1];
                my $accs = [ map {$_->[0]} @{$acc_tuples}  ];
                if ( elem($lhs_var,$accs)) {
                    # Found an Assignment line with an accumulator, rewrite it
                    # $lhs_var.'_chunks' (nodeXCoord, nodeYCoord) = f_assoc0(acc_chunks(nodeXCoord, nodeYCoord),p(i,j))
#@ Lhs => 
#@        VarName       => $lhs_varname
#@        IndexVars     => $lhs_vars
#@        ArrayOrScalar => Array | Scalar
#@        ExpressionAST => $lhs_ast
#@ Rhs => 
#@        Vars       => $rhs_all_vars
#@        ExpressionAST => $rhs_ast	   

                    # Update the LHS AST

                    my $n_lhs_ast = [10,$lhs_var.'_chunks',[27,[2,'nodeXCoord'], [2,'nodeYCoord'] ] ] ;
                    my $acc_decl = _get_var_decl($Sf,$lhs_var);
                    my $acc_type = $acc_decl->{'Type'};
                    my $acc_kind = $acc_decl->{'Attr'};
                    my $acc_indent = $acc_decl->{'Indent'};
                    $Sf = _add_local_decl($Sf,$lhs_var.'_chunks',$acc_type,$acc_kind,[[1,'dsmNX'], [1,'dsmNY']],{'MemSpace'=>'Collective'},$acc_indent);
                    # Update the Vars
                    my $n_rhs_vars_set = dclone($info->{'Rhs'}{'Vars'}{'Set'});
                    delete $n_rhs_vars_set->{$lhs_var};
                    $n_rhs_vars_set->{$lhs_var.'_chunks'} = {'Type' => 'Array'};
                    $n_rhs_vars_set->{'dsmNXCoord'} = {'Type' => 'Scalar'};
                    $n_rhs_vars_set->{'nodeYCoord'} = {'Type' => 'Scalar'};
                    # Update the RHS AST 
                    my $rhs_ast = dclone($info->{'Rhs'}{'ExpressionAST'});
                    my $dsm_vars = {
                        $lhs_var => $n_lhs_ast
                    };
                    $rhs_ast = _rewrite_ast_dsm_acc_rhs($rhs_ast,$dsm_vars );
                    my $n_info = dclone($info);
                    $n_info->{'Lhs'} = {
                                'VarName' => $lhs_var.'_chunks', # TODO: make sure it is unique
                                'IndexVars' => {
                                    'List' => ['nodeXCoord', 'nodeYCoord'],
                                    'Set' => {
                                        'nodeXCoord' => {'Type' => 'Scalar'},
                                        'nodeYCoord' => {'Type' => 'Scalar'}
                                    }
                                },
                                'ArrayOrScalar' => 'Array',
                                'ExpressionAST' => $n_lhs_ast
                            };
                    $n_info->{'Rhs'} = {
                                'Vars' => {
                                    'List' => [ grep {$_ ne $lhs_var} @{$rhs_var_list}, $lhs_var.'_chunks', 'nodeXCoord', 'nodeYCoord'],
                                    'Set' => $n_rhs_vars_set
                                },
                                'ExpressionAST' => $rhs_ast
                            };
                    } # Is an Acc
                } # In a Fold
            }      
            # elsif (exists $info->{'If'} ) {   
            #     # TODO check if acc is used in Cond an rewite if required
            # }
        elsif (exists $info->{'Do'}) {
            my $block_id = $info->{'BlockID'};
            if (exists $state->{'FullNest'}{$block_id} )  {
                # croak Dumper $info;
                # say "rewrite_loop_bounds($f): full nest for variables ".join(', ',sort keys %{$state->{'FullNest'}{$block_id}}).' at loop end '. $block_id;
                # my $loop_vars = sort keys %{$state->{'FullNest'}{$block_id}};
                my $loop_nature =  $info->{'Pragmas'}{'LoopNature'};
                if (defined $loop_nature and
                $loop_nature->[0] eq 'Fold') {
                my $acc_tuples = $loop_nature->[1];
                my @extra_annlines=();
                for my $acc_tuple (@{$acc_tuples}) {
                    my ($acc, $op, $arrays) = @{$acc_tuple};
                    my $init_chunked_fold_annline =  _generate_init_chunked_fold_annline($acc,$op);
                    push @extra_annlines, $init_chunked_fold_annline
                }
                
                return [
                    @extra_annlines,
                    [$line,$info]                    
                    ];
                }
            }
        }            
        elsif (exists $info->{'EndDo'}) {
            my $block_id = $info->{'BlockID'};
            if (exists $state->{'FullNest'}{$block_id} )  {
                my $loop_nature =  $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'LoopNature'};
                if (defined $loop_nature and
                $loop_nature->[0] eq 'Fold') {

                my $n_info = {
                    'SubroutineCall' => {
                        'Name' => 'dsmBarrier',
                        'Args' => {
                            'List' => [],
                            'Set' => {}
                        },
                    },
                    'Indent' => $info->{'Indent'},
                    'LineID' => $info->{'LineID'}+0.1,
                    'Ann' => [annotate($f, __LINE__)]
                };

                my $barrier_annline = [ $info->{'Indent'} . "call dsmBarrier()",$n_info];
                my $acc_tuples = $loop_nature->[1];
                my @extra_annlines=();
                for my $acc_tuple (@{$acc_tuples}) {
                    my ($acc, $op, $arrays) = @{$acc_tuple};
                    my $fold_chunks_annlines = _generate_fold_chunks_annlines($acc,$op);
                    @extra_annlines = (@extra_annlines,@{$fold_chunks_annlines});
                }                    
                
                return [
                    [$line,$info],
                    $barrier_annline,
                    @extra_annlines
                    ];
                }
            }
        }            
            # We could do the postamble in the same pass     
            return [[$line,$info]]
        };
    
        my $new_annlines = stateless_pass($annlines,$pass_rewrite_folds,"pass_rewrite_folds($f)");
        $Sf->{'RefactoredCode'} = $new_annlines;

    return $stref;
} # END of rewrite_fold_loops

# $dsm_vars = {$acc_var => [10,$acc_var.'_chunks',[27,[2,...]...]}
sub _rewrite_ast_dsm_acc_rhs { my ($ast,$dsm_vars )=@_;
# carp Dumper $dsm_vars;
    my $rhs_dsm_ast = dclone($ast);
    
    # my $acc={}; 
    my $f = sub { my ($ast,$acc)=@_;
    
        if ($ast->[0] == 2 ) { # $ 
        
            my $var_name = $ast->[1];

            if (exists $acc->{$var_name}) {
                $ast = $acc->{$var_name};
            }
        } 
        # carp Dumper $ast;
        return ($ast,$acc);
    };

    ($rhs_dsm_ast,$dsm_vars) = _traverse_ast_with_stateful_action($rhs_dsm_ast, $dsm_vars, $f);
    # croak Dumper $rhs_dsm_ast;
    return $rhs_dsm_ast;
} # END of _rewrite_ast_dsm_acc_rhs

# - Find the original AnnLine where acc is initialised and rewrite it:
# This is really textual: $acc_var.'_chunks(nodeXCoord, nodeYCoord)'
# But we do this using the AST: 
# (Maybe start by calling then nodeXCoord and nodeYCoord)
# [10, $acc_var.'_chunks', [27,[2,'dsmNX'],[2,'dsmNY']]],
sub _generate_init_chunked_fold_annline { my ($acc,$op) = @_;
    my $indent='      ';
    my $line = $indent.$acc.'_chunks(nodeXCoord, nodeYCoord) = '.$acc;
    my $lhs_ast = [10, $acc.'_chunks', [27,[2,'nodeXCoord'],[2,'nodeYCoord']]];
    my $rhs_ast = [2,$acc];
    my $info = {'Assignment' => 1,
            'Lhs' => {
                'VarName' => $acc.'_chunks', # TODO: make sure it is unique
                'IndexVars' => {
                    'List' => ['nodeXCoord', 'nodeYCoord'],
                    'Set' => {
                        'nodeXCoord' => {'Type' => 'Scalar'},
                        'nodeYCoord' => {'Type' => 'Scalar'}
                    }
                },
                'ArrayOrScalar' => 'Array',
                'ExpressionAST' => $lhs_ast
            },
            'Rhs' => {
                'Vars' => {
                    'List' => [ $acc],
                    'Set' => { $acc => {'Type' => 'Scalar'}}
                },
                'ExpressionAST' => $rhs_ast
            }        
        };
    return [$line,$info];
} # END of _generate_init_chunked_fold_annline

# To generate this code on exiting a block, we need to know the Acc for that block, we get that from the LoopNature of the $block_id of the EndDo
# We also need the operation used for the fold. For now that is part of the LoopNature analysis.
# For every Acc we have an Op: Accs((acc1,+),(acc2,*),(acc3,max))

sub _generate_fold_chunks_annlines { my ($acc,$op) = @_;
my $indent='      ';
my $acc_line = $op =~/\w+/
    ? "$acc = $op($acc,$acc".'_chunks(nx,ny))'
    : "$acc = $acc $op $acc".'_chunks(nx,ny)';

my $annlines = [
    [$indent."$acc = $acc".'_chunks(dsmXCoord,dsmYCoord)',{'Textual' => 1}],
    [$indent.'do nx = 0, dsmNX-1',{'Textual' => 1}],
    [$indent.'do ny = 0, dmsNY-1',{'Textual' => 1}],
    [$indent.'if (nx/=dsmXCoord .or. ny/=dsmYCoord) then',{'Textual' => 1}],
    [$indent. $acc_line,{'Textual' => 1}],
    [$indent.'end if',{'Textual' => 1}],
    [$indent.'end do',{'Textual' => 1}],
    [$indent.'end do',{'Textual' => 1}]
];
return $annlines;

} # END of _generate_fold_chunks_annline

sub __find_full_nest_block_id { my ($block_id,$state) = @_;
# say $block_id;
    die "This block is not in a full nest " if $block_id eq '0';
    # carp Dumper $state->{'FullNest'};
    if (not exists $state->{'FullNest'}{$block_id}) {
        my $n_block_id = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'InBlock'};
        __find_full_nest_block_id($n_block_id,$state);
    } else {
        return $block_id;
    }
}

# _add_local_decl($Sf,'v','real')
# _add_local_decl($Sf,'acc_chunks','real',4,[[1,'dsmNX'],[1,'dsmNY']],{'MemSpace'=>'Collective'});
sub _add_local_decl { my ($Sf,$var_name,$type,$kind, $dim,$pragmas,$indent,$alloc) = @_;
    my $decl = {};
    $decl->{'Name'}        = $var_name;
    $decl->{'Type'}          = $type;
    if (defined $kind and $kind ne '') {
        $decl->{'Attr'} = '(kind=' . $kind . ')';
    }
    
    my $a_or_s = (defined $dim and scalar @{$dim} > 0 )
    ? 'Array'
    : 'Scalar';
    $decl->{'ArrayOrScalar'} = $a_or_s;
    if($a_or_s eq 'Array') {
            $decl->{'Dim'} = $dim;
    }

    if (defined $pragmas) {
        for my $k (keys %{$pragmas}) {
            $decl->{$k}		 = $pragmas->{$k};
        }
    }
    if (not defined $indent) {
        $indent = '      ';
    }
    $decl->{'Indent'}        = $indent;
    if (defined $alloc) {
        $decl->{'Allocatable'}='allocatable';
    }
    $Sf->{'DeclaredOrigLocalVars'}{'Set'}{$var_name} = $decl;
    push @{ $Sf->{'DeclaredOrigLocalVars'}{'List'} }, $var_name;
    return $Sf;
}
sub _get_var_decl { my ($Sf,$var_name) = @_;
    my $subset = in_nested_set( $Sf, 'Vars', $var_name );
    my $decl = get_var_record_from_set($Sf->{$subset},$var_name);
    return $decl;
}


1;
