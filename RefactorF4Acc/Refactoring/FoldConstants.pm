# Fold all constants in a code unit
# This is done primarily for analysis, but it is of course a program transformation
package RefactorF4Acc::Refactoring::FoldConstants;
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
use RefactorF4Acc::Refactoring::Helpers qw( get_annotated_sourcelines stateless_pass );
use RefactorF4Acc::Analysis::ArrayAccessPatterns qw( identify_array_accesses_in_exprs );
use RefactorF4Acc::ExpressionAST::Evaluate qw( fold_constants_in_expr eval_expression_with_parameters );
use RefactorF4Acc::Emitter qw( emit_RefactoredCode );
use Carp;
use Data::Dumper;
use Storable qw( dclone );

use Exporter;

@RefactorF4Acc::Refactoring::FoldConstants::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::FoldConstants::EXPORT_OK = qw(
    fold_constants_all
    fold_constants
);

# foldConstants :: ProgUnit Anno -> ProgUnit Anno
# We'll take ProgUnit to mean a subroutine
# To do this right, I need to indentify the nested loops in the subroutine. 
# That will provide a BlockID which is need to work out what is a loop iterator
# So this requires running identify_array_accesses_in_exprs() first to identify any nested loops.
# $ast = (fold_constants_in_expr($stref, $f, $block_id, $ast);
sub fold_constants {
    my ($stref, $f) = @_;
    my $Sf = $stref->{'Subroutines'}{$f};
    $stref = identify_array_accesses_in_exprs($stref,$f);
    # die;
    # croak Dumper $Sf->{'ArrayAccesses'} if $f eq 'sub1';
    my $pass_fold_constants = sub { (my $annline)=@_;
        (my $line,my $info)=@{$annline};
        # From $info, find the lines that contain expressions that might have constants to fold.
        # These would the same types of lines as in identify_array_accesses_in_exprs()
# say "LINE: $f $line";
            # $stref->{'Subroutines'}{ $f }{'ArrayAccesses'} has all block ids as keys, but how is this linked to the actual loop nest?
            my $in_block = exists $info->{'Block'} ? $info->{'Block'}{'LineID'} : '-1';
            my $block_id = exists $info->{'BlockID'} ? $info->{'BlockID'}  : 0;
            
			# The array dimensions have already been folded and are stored in
            # $state->{'Subroutines'}{ $f }{'Blocks'}{ $block_id }{'Arrays'}{$array_var}{'Dims'} 
            # i.e. in $stref->{}
			# if ( exists $info->{'Signature'} ) {
			# }
			# # For every VarDecl, identify dimension if it is an array
			# els
            if (exists $info->{'VarDecl'} and not exists $info->{'ParamDecl'}
             and __is_array_decl($info)
             ) {
                
                my $var_name = $info->{'VarDecl'}{'Name'};
                # croak $f,Dumper $info if $f eq 'sub1' and $var_name eq 'p1';
                my $dims = [ 
                    map {  $_->[0].':'.$_->[1] } 
                    @{$Sf->{'ArrayAccesses'}{$block_id}{'Arrays'}{$var_name}{'Dims'}}
                ]; 
                # push @attrs,'dimension('.join(', ',  map {} @{ $pvd->{'Attributes'}{'Dim'} }).')';
                $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}=$dims;
			}
            if (exists $info->{'ParamDecl'} ) {
                # carp Dumper $info->{'ParsedParDecl'} ;
                my $var_name = $info->{'ParsedParDecl'}{'Pars'}{'Var'};
                # croak $f,Dumper $info if $f eq 'sub1' and $var_name eq 'p1';
                my $val_expr_str = $info->{'ParsedParDecl'}{'Pars'}{'Val'};
                my $evaled_val = eval_expression_with_parameters($val_expr_str,$info, $stref, $f) ;
                $info->{'ParsedParDecl'}{'Pars'}{'Val'} = $evaled_val;
                # warn 'TODO!';
			}            
            # say "LINE: $line";
			if (exists $info->{'Assignment'} ) {
                # We need the AST for LHS and RHS
                if ($info->{'Lhs'}{'ArrayOrScalar'} eq 'Array' ) { 
                    my $lhs_ast = $info->{'Lhs'}{'ExpressionAST'};
                    my $const_fold_lhs_ast = fold_constants_in_expr($stref, $f, $block_id, $lhs_ast);
                    $info->{'Lhs'}{'ExpressionAST'}=$const_fold_lhs_ast;
                }
                
                my $rhs_ast  = $info->{'Rhs'}{'ExpressionAST'};
                my $const_fold_rhs_ast = fold_constants_in_expr($stref, $f, $block_id, $rhs_ast);
                $info->{'Rhs'}{'ExpressionAST'}=$const_fold_rhs_ast;
			}
	 		if (exists $info->{'If'} ) {
                # FIXME: Surely conditions of if-statements can contain array accesses, so FIX THIS!
                #say "IF statement, TODO: ".Dumper($info->{'CondExecExpr'});
                my $cond_expr_ast = $info->{'CondExecExprAST'};
                my $const_fold_cond_expr_ast = fold_constants_in_expr($stref, $f, $block_id, $cond_expr_ast);
                $info->{'CondExecExprAST'} = $const_fold_cond_expr_ast;
            }
            elsif ( exists $info->{'Do'} ) { #  the expressions for the loop bounds have been folded:
                my $block_id = $info->{'BlockID'};
            # say Dumper $state->{'Subroutines'}{ $f }{'Blocks'}
            # local $Data::Dumper::Indent =0;
            # local $Data::Dumper::Terse=1;
                my $iter =  $info->{'Do'}{'Iterator'};
            # say $block_id,"\t$iter\t" ,Dumper $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{$block_id}{'LoopIters'};#=$range_rec;
            # die;
            
                my $evaled_range = $stref->{'Subroutines'}{ $f }{'ArrayAccesses'}{$block_id}{'LoopIters'}{$iter}{'Range'};
            # say Dumper $evaled_range;
                $info->{'Do'}{'Range'}{'Expressions'} = $evaled_range;

            # die;
            
            #         if (exists $info->{'Do'}{'Iterator'} ) {

            #     } else {
            #         die "ERROR: Sorry, a `do` loop without an iterator is not supported\n";
            #     }
            }
            # } elsif ( exists $info->{'EndDo'} ) {

            # }

        return [[$line,$info]];
    };
    my $annlines = $Sf->{'RefactoredCode'};
    my $new_annlines = stateless_pass($annlines,$pass_fold_constants,"pass_fold_constants($f) " . __LINE__  ) ;
    # $stref = identify_var_accesses_in_exprs($stref,$f,$new_annlines);
    #  emit_RefactoredCode($stref,$f,$new_annlines) ;
    return $new_annlines;
} # END of fold_constants

sub fold_constants_all {
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
		my $new_annlines = fold_constants( $stref, $f );

        # warn $f;
        # Dumper($Sf->{'RefactoredCode'});
        # emit_RefactoredCode($stref,$f,$new_annlines) ;
	}
    
	return $stref;
}    # END of fold_constants_all()

sub __is_array_decl { (my $info)=@_;

	return (exists $info->{'ParsedVarDecl'}
	&& exists $info->{'ParsedVarDecl'}{'Attributes'}
	&& exists $info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}
	&& scalar @{$info->{'ParsedVarDecl'}{'Attributes'}{'Dim'}} >0);
}