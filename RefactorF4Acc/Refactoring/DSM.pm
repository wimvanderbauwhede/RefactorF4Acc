# Rename array accesses and declarations to use the DSM API
package RefactorF4Acc::Refactoring::DSM;
use v5.10;
# 
#   (c) 2021 Wim Vanderbauwhede <Wim.Vanderbauwhede@Glasgow.ac.uk>
#   


=pod
Status 2021-05-10

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

TODO:
- Implement the full SOR loop from LES　#OK
- Add loop annotations : Map, Iter, Fold; I think we might already have the stencil analysis so no need    
- Check the reach for every array in a loop nest, to see if it does not exceed the halos!
    do j
    do k
    p(0,j,k)=p(im,j,k)
    p(im+1,j,k) = p(1,j,k)
    end do
    end do

    This will give a reach of [0,im+1] on the LHS and [1,im] on the RHS
    So we modulo the core, because what we want is to make sure acccesses are not in the core
    [0 % im,im+1 % im] on the LHS and [1 % im,im % im] on the RHS
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
- Insert barriers, at first after every loop nest, later based on proper analysis
    How do we say "this is the end of a loop"?
    Via the IterVar table and a recursion: 
    - we look at the iters used 
    - work out the loops involved
    - determine which is the outer one    
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
    local $I=0;
    local $V=1;
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
            # carp  $line . Dumper $info->{'Lhs'}{'ExpressionAST'} , $info->{'Rhs'}{'ExpressionAST'};
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
    my $pass_link_iters_vars = sub { my ($annline,$state) = @_;
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
    (my $loop_annlines_,$state) = stateful_pass($annlines,$pass_link_iters_vars,$state,"pass_link_iters_vars($f)");
    my $iters = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'};
    # carp "$f VarAccessAnalysis: ".Dumper $iters;

    #     So now we have our IterTable as part of the LoopNests info. 
    #     We can now do the checks:
    # Partition conflicts: not all arrays for a given iterator have the same partition info 
    # i => {p1 => 0, p2 =>0 } then look up Partition[0] for p1 and p2
    # This requires linking the iterator with the index in the Partition field
    my $dims_halos_partitions ={};
    for my $block_id (sort keys %{$state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'} }) {
        next if $block_id eq '0';
        # say "Trying to add partition info: $f $block_id ".Dumper($state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'}); 
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
        my $range = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'};
        
        my $loop_extent = $range->[1] - $range->[0] + 1;
        # carp "$block_id $iter Range: $loop_extent: ". Dumper($range);
        my $loop_dim_check={};
        my $collective_arrays={};
        $loop_dim_check->{$iter}{'Extent'} = $loop_extent;
        # for my $iter (sort keys %{ $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'IterVarTable'} }) {
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
        # carp "$f $block_id: ".Dumper $dims_halos_partitions->{$block_id};
        my $iter = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Iterator'};
        my $range = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'};
        my ($lbound, $ubound) = @{$range};
        
        my ($partition,$dim_sz_halos, $var_, $idx) = @{$dims_halos_partitions->{$block_id}};
        my ($dim_sz,$halos) = @{$dim_sz_halos};
        my ($lh, $uh) = @{$halos};        
        my $chunk = ($dim_sz - $lh - $uh)/$partition;
        # say "$f $block_id: $iter: CHUNK $chunk = ($dim_sz - $lh - $uh)/$partition";
        # Suppose I have an array which starts at 3 and goes to 102, with a halo of 5 on each side
        # Chunking it in two would be: 102-3+1 = 100/2 = 50; 3->3+50-1; 3-5 to 52+5 : -2 to 57 = 60
        # Suppose the array is 1 to w and the halos are (2,2) 
        my $chunk_lb = $lbound; # say 0;1 and upper bound is 99;100 and chunk is 25 and partition is 4
        my $extra = $ubound - $lbound - $chunk*$partition; # extra = 99-0;100-1 - 25*4 = -1
        my $chunk_ub = $chunk + $lbound + $extra; # 25+0;1-1 = 24,25
        # Let's assume we have dsmNX and dsmNY either as functions or as module globals
        # for my $np (0 .. $partition-1) {            
        #     my $np=0;
        # carp "CHUNK $np: $f $block_id: $iter: $chunk_lb+($np*$chunk) .. $chunk_ub+($np*$chunk) = ".($chunk_lb+($np*$chunk)).' .. '.($chunk_ub+($np*$chunk));

            $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[0] = $chunk_lb.'+'.$chunk.'*'._gen_chunk_coord($idx);
            $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[1] = $chunk_ub.'+'.$chunk.'*'._gen_chunk_coord($idx);            
        # }
        # say Dumper $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'};
    }

    # So now we have for every BlockID the rewritten Range in 
    # We need to get this into $info->{'Do'}{'Range'}{'Expressions'}
    # A simple stateless pass on 'Do' should do this
    my $pass_rewrite_loop_bounds = sub { my ($annline) = @_;
        my ($line,$info) = @{$annline};
        # carp Dumper $state;
        if (exists $info->{'Do'}) {
            my $block_id = $info->{'BlockID'};
            $info->{'Do'}{'Range'}{'Expressions'}[0] = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[0];
            $info->{'Do'}{'Range'}{'Expressions'}[1] = $state->{'VarAccessAnalysis'}{'LoopNests'}{'Set'}{$block_id}{'Range'}[1];
        }
        return [[$line,$info]];
    };
    my $rewritten_loop_annlines = stateless_pass($annlines,$pass_rewrite_loop_bounds,"pass_rewrite_loop_bounds($f)");    
    

    #  map {say $_} @{pp_annlines($updated_loop_annlines,1)};
    # say "\nRefactored code for $f\n";
    # emit_RefactoredCode($stref,$f,$rewritten_loop_annlines); 
    return  $stref ;
}

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
