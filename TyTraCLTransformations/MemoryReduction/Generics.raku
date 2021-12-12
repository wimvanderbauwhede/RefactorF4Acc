use v6;
our $DBG=False;


role Expr {}
role MapV[Expr \f_,Expr \v_] does Expr {
    has Expr $.f = f_;
    has Expr $.v = v_;
}
role Comp[Expr \f_, Expr \g_] does Expr {
    has Expr $.f = f_;
    has Expr $.g = g_;
}
role Fold[Expr \f_,Expr \acc_,Expr \v_] does Expr {
    has Expr $.f = f_;
    has Expr $.acc = acc_;
    has Expr $.v = v_;
}
role FComp[\f_,\g_] does Expr {
    has $.f = f_;
    has $.g = g_;
}
role Stencil[\s_,\v_] does Expr {
    has $.s=s_;
    has $.v=v_;
}
role MapS[\s_,\f_] does Expr {
    has $.f = f_;
    has $.s = s_;
}
role UnzipT[\v_]  does Expr {
    has $.v = v_;
}
role ZipT[\t_] does Expr {
    has $.t = t_
}
role Elt[\i_,\t_] does Expr {
    has $.i=i_;
    has $.t=t_
}
role PElt[\i_] does Expr {
    has $.i=i_
}
role Name[Str \n_] does Expr {
    has Str $.n = n_
}
role Tuple[Array[Expr] \exprs_] does Expr {
    has Array[Expr] $.exprs = exprs_
}

# for example: map (f1 . f2) (map g (zipt (v1,map h v2)))
my \ast = MapV[ 
    Comp[Name['f1'].new,Name['f2'].new].new,
    MapV[
        Name['g'].new,
        ZipT[
            Tuple[
                Array[Expr].new(
                    Name['v1'].new,
                    MapV[
                        Name['h'].new,
                        Name['v2'].new
                    ].new
                )
            ].new
        ].new
    ].new
].new;

sub modifier(\t) {
    given (t) {
        when Name {
            Name[t.n~'_updated'].new 
        }
        default {t}
    }
}
sub joiner(\acc, \res) {
    return (|acc ,|res);
}

multi sub matcher (Expr \expr) {
    given (expr) {
        when MapV {
            given (expr.f) {
                when Name {
                    return [expr.f.n]
                } 
                when Comp {
                    return [expr.f.f.n,expr.f.g.n]
                } 
                default {[]}
            }
        }
    }
    return []
}
multi sub matcher (Array \expr) {[]}
multi sub matcher (Str \expr) {[]}

sub everything (\t, \acc,&joiner,&matcher) {
    my $acc_ = acc;
    $acc_ =joiner($acc_,matcher(t));
    if t ~~ List {
        say "LIST "~ t.raku if $DBG;
        for |t -> \t_elt  {
            say "LIST ELT "~ t_elt.raku if $DBG;
            $acc_ = everything(t_elt,$acc_,&joiner,&matcher)
        }
        return $acc_; 
    }
    elsif t ~~ Map {
        for t.values -> \t_elt  {
            say 'ELT EXPR:'~ t_elt.raku if $DBG;
            $acc_ = everything(t_elt,$acc_,&joiner,&matcher)
        }
        return $acc_; 
    } 
    else {
        for t.^attributes -> \attr {
            
            if attr ~~ Attribute {
                # say 'ATTR:'~attr.raku if $DBG;
                # say 'ATTR:'~attr;
                my \expr = attr.get_value(t);
                say 'ATTR EXPR:'~ expr.raku if $DBG;
                if not expr ~~ Any  { # ContainerDescriptor::Untyped
                    return $acc_;
                }

                # $acc_ =joiner($acc_,matcher($expr));
                $acc_ = everything(expr,$acc_,&joiner, &matcher);
            }
        }
    }
    return $acc_
}

sub everywhere (\t_,&modifier) {
    
    my \t = modifier(t_);
    if t ~~ List {
        say "LIST "~ t.raku if $DBG;
        my @t_=[];
        for |t -> \t_elt  {
            say "LIST ELT "~ t_elt.raku if $DBG;
            @t_.push( everywhere(t_elt,&modifier) );
        }
        return @t_; 
    }
    elsif t ~~ Map {
        my %t_;
        for t.keys -> \t_k  {
            my \t_v = t{t_k};
            %t_{t_k} = everywhere (t_v,&modifier);
        }
        return %t_; 
    } 
    else {
        my $t_ = t;
        for t.^attributes -> \attr {            
            if attr ~~ Attribute {
                my \expr = attr.get_value(t);
                say 'ATTR EXPR:'~ expr.raku if $DBG;
                if not expr ~~ Any  { # ContainerDescriptor::Untyped
                    return $t_;
                }
                my \expr_ = everywhere(expr,&modifier);
                attr.set_value($t_,expr_);
            }
        }
        return $t_;
    }
    return t;
}

my $res = everything(ast,[],&joiner,&matcher);
say $res;

my $ast_ = everywhere(ast,&modifier);
say $ast_;

my $testje = [1,[2,3,4,[5,6,7]],[8,9,[10,11,[12]]]];

sub tmatcher (\expr) {
    given (expr) {
        when List {
            if (expr[0] % 2 == 0) {                
                    return [expr]                
            }            
        }
    }
    return []
}

my $tres = everything($testje,[],&joiner,&tmatcher);
say $tres;


my %htestje = 
    a => {
        b => {
            c => 1,
            a => {
                b =>1,c=>2
            } 
        },
        c => {
            a =>3
        }
    },
    b => 4,
    c => {d=>5,e=>6}
;

sub hmatcher (\expr) {
    given (expr) {
        when Map {
            my $acc=[];
            for expr.keys -> \k {                
                if k eq 'a' {
                    $acc.push(expr{k})
                }
            }
            return $acc;
        }
    }
    return []
}

my $hres = everything(%htestje,[],&joiner,&hmatcher);
say $hres;