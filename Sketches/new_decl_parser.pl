#!/usr/bin/env perl
use v5.28;
use Carp;
use Data::Dumper;
use RefactorF4Acc::Parser::Expressions qw( parse_expression_no_context emit_expr_from_ast 
);

for my $decl_str (
    'INTEGER*4 DP',
    'CHARACTER*4 V0, V1',
    'CHARACTER*(*) V1(2)',
    'CHARACTER*10 B10VK, C10VK, E11VK*11, G10VK',
    'CHARACTER*4 C2N001(0:5,1:6), C2D002(2,1:3), C2N003(-2:1,3:10)',    
    'CHARACTER V*4,W(2)*5',
    'CHARACTER*(*)(3) V, W(8,8)',
    'CHARACTER*16 V(-1:9,0:7),W(2)',
    'CHARACTER A*17, B*17(3,4), V*17(9)',
    'CHARACTER(LEN=5) V5', 
    'CHARACTER(LEN=*) VSTAR',
) {
    say lc($decl_str);
    _parse_F77_decl_NEW( lc($decl_str) );
}

sub _get_var_recs_from_parse_tree { (my $tpt, my $vspt)=@_;
my $type;
my $attr='';
my $dims=[];
my @decls=();
my $var_name;
my $array_or_scalar='Scalar';

my $var_decls={};
my $var_lst=[];

# type part
if ($tpt->[0] == 5) { # '*'
    # set the type 
    if ($tpt->[1][0] == 2 ) { # '$'
    # set the type
        $type = $tpt->[1][1];
    }
    # set the attribute
    if ($tpt->[2][0] == 0) { # ( ... )
        # Emit this and use as attr
        $attr = emit_expr_from_ast($tpt->[2]);
    } 
    elsif  ($tpt->[2][0] == 29) {
        # take the value
        $attr = $tpt->[2][1];
    }

} elsif ($tpt->[0] == 1 ) { # i.e. character(len=...)
    $type = $tpt->[1];
    if ($tpt->[2][0] == 9) {
        $attr =  emit_expr_from_ast($tpt->[2][2]);
    } else {
        $attr =  emit_expr_from_ast($tpt->[2]);
    }
} elsif ($tpt->[0] == 2 ) { # '$', so no attribute. Means attributes are per-var
    # set the type
    $type = $tpt->[1];  
      
}

# vars part
my @vpts=();
## first transform into a plain list
if ($vspt->[0] ==27) { # comma-sep list
    #    say Dumper($vspt);
    shift @{$vspt};
    @vpts=@{ $vspt };#->[1 .. (scalar( @{$vspt}) -1)] };
} else { # single elt
    @vpts = ( $vspt );
}
## then

for my $vpt (@vpts) {
    # it can be either a scalar, an array, or an expression with '*' and a scalar or array
    my $tvpt=$vpt;
    
    if ($vpt->[0] == 5) {
        # means there is a '*', so get both parts
        # one of the parts again can be a scalar or an array
        if ($vpt->[1][0] == 29) {
            $tvpt=$vpt->[2];
            # get the attr
            $attr = $vpt->[1][1];
        } elsif ($vpt->[2][0] == 29) {
            $tvpt=$vpt->[1];
            # get the attr
            $attr = $vpt->[2][1];
        }
    } 
    if ($tvpt->[0] == 2) {
        # get the name and create the decl
        $var_name = $tvpt->[1];
    }
    elsif ($tvpt->[0] == 1) { # The array will be '&' so 1
        # it's an array, get the dim.
        $array_or_scalar='Array';
        # dim part
        my @dpts=();
        # first transform into a plain list
        if ($tvpt->[2][0] ==27) { # comma-sep list
            shift @{ $tvpt->[2] };
            @dpts=@{ $tvpt->[2] } ;#[1.. scalar @{$tvpt->[2][0]} -1]};
        } else { # single elt
            @dpts = ( $tvpt->[2] );
        }
        ## then for each of these, check if it is a ':'
        for my $dpt (@dpts) {
            my $tdim=[];
            if ($dpt->[0] == 12) { #':'
                # take both parts, use directly if integer or variable
                # emit of expression
                $tdim=[emit_expr_from_ast($dpt->[1]), emit_expr_from_ast($dpt->[2])];

            } else {
                # part 1 is a 1, only use part 2
                $tdim=[1, emit_expr_from_ast($dpt)];
            }
            push @{$dims},$tdim;
        }

        # then get the name and create the decl
        $var_name = $tvpt->[1];
    }
    my $decl={
        'Name'=>$var_name,
        'Type'=>$type,
        'Attr'=>$attr,
        'Dim'=>$dims,
        'ArrayOrScalar' => $array_or_scalar
    };
    
    push @{$var_lst}, $var_name;#decls, $decl;
    $var_decls->{$var_name}=$decl;
    $dims=[];
}

#say Dumper(@decls);
return ($var_decls, $var_lst);
} # END of _get_var_recs_from_parse_tree 


sub _parse_F77_decl_NEW { (my $decl_str)=@_;

        my ($parse_tree_type, $rest, $err) = parse_expression_no_context($decl_str);
        #say "ERR $err REST $rest";
        my ($parse_tree_vars, $rest, $err) = parse_expression_no_context($rest);
        #            say "$decl_str => $err $rest \n".Dumper($parse_tree_type)."\n".Dumper($parse_tree_vars);
        
        #say Dumper($parse_tree_type, $parse_tree_vars);
        (my $var_recs, my $var_lst) = _get_var_recs_from_parse_tree($parse_tree_type, $parse_tree_vars);
        #say Dumper($var_recs);
            #    return ($info, $stref);
    

} # END of _parse_F77_decl_NEW
