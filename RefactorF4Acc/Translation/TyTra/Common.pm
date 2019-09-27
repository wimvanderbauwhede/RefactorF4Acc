package RefactorF4Acc::Translation::TyTra::Common;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
#
#   (c) 2016 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "1.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Carp;
use Data::Dumper;


use Exporter;

@RefactorF4Acc::Translation::TyTra::Common::ISA = qw(Exporter);

@RefactorF4Acc::Translation::TyTra::Common::EXPORT_OK = qw(
  &pp_links
  &__isMainInArg
  &__isMainOutArg
  &_mkVarName
  &_mkSigArgName
  &mkMap
  &mkFold
  &mkStencilDef
  &mkStencilAppl
  &mkComment
  &mkAST
  &addTypeDecl
  &F1D2C
  &F2D2C
  &F3D2C
  &F4D2C
);

# What we need is the in and out tuples
# i.e. keys %{$links} = OUT
# union of vals is IN
sub pp_links {
    (my $links) = @_;
    my $in_tup_table = {};
    for my $lhs_var (sort keys %{$links}) {

#		print "$lhs_var => ";
        my @rhs_vars = ();
        for my $lvar (sort keys %{$links->{$lhs_var}}) {
            push @rhs_vars, $lvar;
            $in_tup_table->{$lvar} = 1;
        }

#		say join(', ',@rhs_vars);
    }
    my $out_tup = [sort keys %{$links}];
    my $in_tup  = [sort keys %{$in_tup_table}];
    return ($out_tup, $in_tup);
}    # END of pp_links()

# The variable record is a tuple of
# - original var name
# - counter for uniqueness
# - an additional suffix, in particular used for the stencil tuples
sub _mkVarName {
    (my $rec) = @_;

    # carp(Dumper($rec));
    (my $v, my $c, my $e, my $ve) = @{$rec};
    if ($v eq '') {
        return $c;
    }
    else {
        if ($e eq '') {
            return "${v}_${c}";
        }
        else {
            return "${v}_${e}_${c}";
        }
    }
}    # END of _mkVarName()

# The only difference with _mkVarName() is that we don't use the counter info
sub _mkSigArgName {
    (my $rec) = @_;
    (my $v, my $c, my $e, my $ve) = @{$rec};
    if ($v eq '') {
        croak 'Function signature arguments must be named!';
    }
    else {
        if ($e eq '') {
            return $v;
        }
        else {
            return "${v}_${e}";
        }
    }
}    # END of _mkSigArgName()

sub __isMainInArg {
    (my $var_rec, my $stref) = @_;
    (my $var_name, my $ctr, my $ext) = @{$var_rec};

    # my $orig_args = $stref->{$stref->{'EmitAST'}}{'OrigArgs'};
    my $tytracl_ast = $stref->{$stref->{'EmitAST'}};
    my $orig_args   = $tytracl_ast->{'OrigArgs'};

    #   say "TEST IN: $var_name $ctr <> 0 <$ext> <".(exists $orig_args->{$var_name} ) .">";
    return (
             $ctr == 0
          && $ext eq ''
          && (exists $orig_args->{$var_name})
          && ( ($orig_args->{$var_name} eq 'in')
            || ($orig_args->{$var_name} eq 'inout'))

    ) ? 1 : 0;
}    # END of __isMainInArg()

sub __isMainOutArg {
    (my $var_rec, my $stref) = @_;
    (my $var_name, my $ctr, my $ext) = @{$var_rec};
    my $tytracl_ast = $stref->{$stref->{'EmitAST'}};
    my $orig_args   = $tytracl_ast->{'OrigArgs'};


# say "TEST OUT: $var_name $ctr ";# <> ".$tytracl_ast->{'UniqueVarCounters'}{$var_name}." <$ext> <".(exists
# say $orig_args->{$var_name};# ) .">";
    return (
             $ctr == $tytracl_ast->{'UniqueVarCounters'}{$var_name}
          && $ext eq ''
          && (exists $orig_args->{$var_name})
          && ( ($orig_args->{$var_name} eq 'inout')
            || ($orig_args->{$var_name} eq 'out'))
    ) ? 1 : 0;
}    # END of __isMainOutArg()


sub F3D2C {
    (   my $i_rng, my $j_rng,            # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb,    # lower bounds
        my $ix, my $jx, my $kx
    ) = @_;
    return ($i_rng * $j_rng * ($kx - $k_lb) + $i_rng * ($jx - $j_lb) + $ix - $i_lb);
}

sub F2D2C {
    (   my $i_rng,                       # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb,              # lower bounds
        my $ix,   my $jx
    ) = @_;
    return ($i_rng * ($jx - $j_lb) + $ix - $i_lb);
}


sub F1D2C {
    (   my $i_lb,                        #// lower bounds
        my $ix
    ) = @_;
    return $ix - $i_lb;
}

sub F4D2C {
    (   my $i_rng, my $j_rng, my $k_rng,           # ranges, i.e. (hb-lb)+1
        my $i_lb, my $j_lb, my $k_lb, my $l_lb,    # lower bounds
        my $ix, my $jx, my $kx, my $lx
    ) = @_;
    return (
        $i_rng * $j_rng * $k_rng * ($lx - $l_lb) + $i_rng * $j_rng * ($kx - $k_lb) + $i_rng * ($jx - $j_lb) + $ix - $i_lb);
}

# ===================================================================================================


# mkFold(shapiro_reduce_18 => [] , [['etan_avg',0,'']] => [['etan',0,'']] => [['etan_avg',1,'']]);
sub mkFold {
    my ($fname, $non_fold_args, $acc_args, $fold_args, $ret_vars) = @_;
    return {
        'Rhs' => {
            'FoldArgs'    => {'Vars' => $fold_args},
            'NonFoldArgs' => {'Vars' => $non_fold_args},
            'Function'    => $fname,
            'AccArgs'     => {'Vars' => $acc_args}
        },
        'FunctionName' => $fname,
        'NodeType'     => 'Fold',
        'Lhs'          => {'Vars' => $ret_vars}
    };
}

# mkMap( shapiro_map_23 => [['eps',0,''],['etan_avg',1,'']] => [['wet',0,'s'],['etan',0,'s'],['eta',0,'']] => [['eta',1,'']] );
sub mkMap {
    my ($fname, $non_map_args, $map_args, $ret_vars) = @_;
    return {
        'Rhs' => {
            'MapArgs'    => {'Vars' => $map_args},
            'NonMapArgs' => {'Vars' => $non_map_args},
            'Function'   => $fname,
        },
        'FunctionName' => $fname,
        'NodeType'     => 'Map',
        'Lhs'          => {'Vars' => $ret_vars}
    };
}

# mkStencilAppl( 1 => 3 => ['wet',0,''] => ['wet',0,'s']);
sub mkStencilAppl {
    my ($ctr, $sz, $arg, $ret_var) = @_;
    return {
        'NodeType' => 'StencilAppl',
        'Lhs'      => {'Var' => $ret_var},
        'Rhs'      => {
            'Var'        => $arg,
            'StencilCtr' => $ctr,
            'StencilSz'  => $sz
        },
        'FunctionName' => "sa$ctr"
    };
}

# mkStencilDef(2, [-1,-502,0,502,1]);
sub mkStencilDef {
    my ($ctr, $pattern) = @_;
    return {
        'NodeType'     => 'StencilDef',
        'Lhs'          => {'Ctr' => $ctr},
        'FunctionName' => "s$ctr",
        'Rhs'          => {'StencilPattern' => {'Pattern' => $pattern,}}
    };
}

sub mkComment {
    (my $comment) = @_;
    return {
        'NodeType'   => 'Comment',
        'CommentStr' => $comment
    };
}

sub addTypeDecl {
    my ($stref, $f, $var_name, $var_type, $dim) = @_;

    $stref->{'Subroutines'}{$f}{'ArrayAccesses'}{0}{'Arrays'}{$var_name} = {'Dims' => $dim};
    $stref->{'Subroutines'}{$f}{'DeclaredOrigArgs'}{'Set'}{$var_name} = {'Type' => $var_type};
    return $stref;
}

=pod_mkAST
$stref = mkAST(
    [
            mkMap('f1'=>[]=>[['v',0,'']],[['v',1,'']]),
            mkStencilDef(1,[-1,0,1]),
            mkStencilAppl(1,3,['v',1,'']=>['v',1,'s']),
            mkMap('f2'=>[]=>[['v',1,'s']],[['v',2,'']]),
            mkStencilDef(2,[-1,0,1]),
            mkStencilAppl(2,3,['v',2,'']=>['v',2,'s']),
            mkMap('f3'=>[]=>[['v',2,'s']]=>[['v',3,'']]),            
    ],
    
    {'v' => ['integer',[1,500],'inout']    }

);


        for my $f (qw(f1 f2 f3 sa1 sa2)) {
            $stref = addTypeDecl( $stref, $f, 'v', 'integer', [[1,500]]);
            # $stref = addTypeDecl( $stref, $f, 'acc', 'integer', []);
        }
        
       $stref->{'TyTraCL_AST'} = {
        'OrigArgs' => {'v' => 'inout'},
        'UniqueVarCounters'=>{'v' => 3},
        'Lines' => $lines
        };    

    say Dumper $stref->{'TyTraCL_AST'}{'Lines'};    
=cut    

sub mkAST {
    (my $lines, my $decls) = @_;
    my $stref = {};
    $stref->{'EmitAST'}     = 'TyTraCL_AST';
    $stref->{'TyTraCL_AST'} = {
        'Lines'        => [],
        'Selects'      => [],
        'Inserts'      => [],
        'Stencils'     => {},
        'Portions'     => {},
        'Main'         => {},
        'MainFunction' => 'main',
    };
    my @funcs = ();
    my %vecs  = ();
    my %accs  = ();
    for my $node (@{$lines}) {
        push @funcs, $node->{'FunctionName'};
        if (   $node->{'NodeType'} eq 'Map'
            or $node->{'NodeType'} eq 'Fold')
        {
            my $vs = $node->{'Rhs'}{'MapArgs'}{'Vars'};
            if ($node->{'NodeType'} eq 'Map') {
                $vs = [@{$vs}, @{$node->{'Lhs'}{'Vars'}}]
            }
            for my $v_rec (@{$vs}) {
                (my $v, my $ct, my $s, my $ve) = @{$v_rec};
                if (not exists $vecs{$v}) {
                    $vecs{$v} = $ct;
                }
                elsif ($ct > $vecs{$v}) {
                    $vecs{$v} = $ct;
                }
            }
        }
        if ($node->{'NodeType'} eq 'Fold') {
            my $as = $node->{'Rhs'}{'AccArgs'}{'Vars'};
            for my $a_rec (@{$as}) {
                (my $a, my $ct, my $s, my $ve) = @{$a_rec};
                if (not exists $accs{$a}) {
                    $accs{$a} = $ct;
                }
                elsif ($ct > $accs{$a}) {
                    $accs{$a} = $ct;
                }
            }
        }
    }

    for my $f (@funcs) {
        for my $v (sort keys %vecs) {
            $stref = addTypeDecl($stref, $f, $v, $decls->{$v}[0], [$decls->{$v}[1]]);
        }
        for my $a (sort keys %accs) {
            $stref = addTypeDecl($stref, $f, $a, $decls->{$a}[0], []);
        }
    }
    my $args = {};
    for my $v (sort keys %vecs) {
        $args->{$v} = $decls->{$v}[2];
    }
    for my $a (sort keys %accs) {
        $args->{$a} = $decls->{$a}[1];
    }
    $stref->{'TyTraCL_AST'}             = {};
    $stref->{'TyTraCL_AST'}{'Lines'}    = $lines;
    $stref->{'TyTraCL_AST'}{'OrigArgs'} = $args;
    $stref->{'TyTraCL_AST'}{'UniqueVarCounters'} = {%vecs, %accs};

    return $stref;
} # END of mkAST


1;
