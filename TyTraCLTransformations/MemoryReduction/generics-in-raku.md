# Generic datastructure traversals with roles and introspection

I am a [lambdacamel](https://andrewshitov.com/2015/05/05/interview-with-audrey-tang/) and therefore I like to adapt concepts and techniques from functional programming, and in particular from the [Haskell](https://www.haskell.org/) language, to Raku. One of the techniques that I use a lot is called _Generics_, also known as "Scrap Your Boilerplate" after the title of [the paper by Simon Peyton Jones and Ralf Lämmel](https://archive.alvb.in/msc/02_infogp/papers/SYB1.pdf) that introduced this approach. In their words: 

> Many programs traverse data structures built from rich mutually-recursive data types. Such programs often have a great deal of “boilerplate” code that simply walks the structure, hiding a small amount of “real” code that constitutes the reason for the traversal. ”Generic programming” is the umbrella term to describe a wide variety of programming technology directed at this problem. 

So to save you having to write your own custom traversal, this approach gives you generic functions that do traversals on arbitrary data strucures. In this article, I will explain how you can easily implement such generics in Raku for arbitrary role-based datastructures. There is no Haskell in this article.

## Roles as datatypes by example

I implemented of these generics for use with role-based datatypes. Raku's [parameterised roles](https://docs.raku.org/language/objects#index-entry-Parameterized_Roles) make creating complex datastructures very easy. I use the roles purely as datatypes, so they have no associated methods. 

For example, here is an example code snippet in a little language that I use in my research. 

```
map (f1 . f2) (map g (zipt (v1,map h v2)))
```

The primitives are `map`, `.` (function composition), `zipt` and the tuple `(...)`, and the names of functions and vectord. The datatype for the abstract syntax of this little language is called `Expr` and looks as follows:

```perl6
# Any expression in the language
role Expr {}
# map f v
role MapV[Expr \f_,Expr \v_] does Expr {
    has Expr $.f = f_;
    has Expr $.v = v_;
}
# function composition f . g
role Comp[Expr \f_, Expr \g_] does Expr {
    has Expr $.f = f_;
    has Expr $.g = g_;
}
# zipt t turns a tuple of vectors into a vector of tuples
role ZipT[Expr \t_] does Expr {
    has Expr $.t = t_
}
# tuples are just arrays of Expr
role Tuple[Array[Expr] \e_] does Expr {
    has Array[Expr] $.e = e_
}
# names of functions and vectors are just string constants
role Name[Str \n_] does Expr {
    has Str $.n = n_
}
```

The `Expr` role is the toplevel datatype. It is empty because it is implemented entirely in terms of the other roles, which thanks to the `does` are all of type `Expr`. And most of the roles have attributes that are also of type `Expr`. So we have a recursive datatype, a tree with the `Name` node as leaves. 

We can now write the abstract syntax tree (AST) of the example code using this `Expr` datatype:

```perl6
my \ast = MapV[ 
    Comp[
        Name['f1'].new,
        Name['f2'].new
    ].new,
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
```

The typical way to work with such a datastructure is using a `given/when`:

```perl6
sub worker(Expr \expr) {
    given expr {
        when MapV {...}
        when Comp {...}
        when ZipT {...}
        ...        
    }
}
```
Alternatively, you can use a multi sub:

```perl6
multi sub worker(Mapv \expr) {...}
multi sub worker(Comp \expr) {...}
multi sub worker(ZipT \expr) {...}
...        
```

In both cases, we use the roles as the types to match against for the actions we want to take.

(For more details about algebraic datatypes see my earlier article [Roles as Algebraic Data Types in Raku](https://wimvanderbauwhede.github.io/articles/roles-as-adts-in-raku/).)

## Generics

If I want to traverse the AST above, what I would normally do is write a worker as above, where for every node except the leaf nodes, I would call the worker recursively, for example:

```perl6
sub worker(Expr \expr) {
    given expr {
        when MapV {
            \my f_ = worker(expr.f);
            \my v_ = worker(expr.v);
            ...
        }
        ...        
    }
}
```

But wouldn't it be nice if I did not have to write that code at all? Enter generics.

I base my naming and function arguments on that of the [Haskell library `Data.Generics`](https://hackage.haskell.org/package/syb-0.7.2.1/docs/Data-Generics.html). It provides many schemes for traversals, but the most important ones are `everything` and `everywhere`. 

* `everything` is a function which takes a datastructure, a matching function, an accumulator and an update function for the accumulator. The matching function defines what you are looking for in the datastructure. The result is put into the accumulator using the update function.

    ```perl6
    sub everything(
        Any \datastructure, 
        Any \accumulator, 
        &joiner, 
        &matcher 
        --> Any){...}
    ```

* `everywhere` is a function which takes a datastructure and a modifier function. The modifier function defines which parts of the datastructure you want to modify. The result of the traversal is a modified version of the datastructure.

    ```perl6
    sub everywhere(
        Any \datastructure, 
        &modifier 
        --> Any){...}
    ```

The most common case for the accumulator is to use a list, so the updated function appends lists to the accumulator:

```perl6
sub append(\acc, \res) {
    return (|acc, |res);
}
```

As an example of a matching function, let's for example find all the function and vector names in our AST above:

```perl6
sub matcher(\expr) {
    given expr {
        when Name {
            return [expr.n]
        } 
    }
    return []
}
```

So if we find a `Name` node, we return its `n` attribute as a single-element list; otherwise we return an empty list.

```perl6
my \names = everything(ast,[],&append,&matcher); 
# => returns (f1 f2 g h v1 v2)
```

Or let's say we want to change the names in this AST:

```perl6
sub modifier(\t) {
    given t {
        when Name {
            Name[t.n~'_updated'].new 
        }
        default {t}
    }
}

my \ast_ = everywhere(ast,&modfier); 
# => returns the AST with all names appended with "_updated"
```

## Implementing Generics

So how do we implement these magic `everything` and `everywhere` functions? The problem to solve is that we want to iterate through the attributes of every role without having to name it. The solution for this is to use Raku's [Metaobject protocol (MOP)](https://docs.raku.org/language/mop) for introspection. In practice, we use the Rakudo-specific [`Metamodel`](https://docs.raku.org/type/Metamodel::ClassHOW). We need only three methods: `attribute`, `get_value` and `set_value`. With these, we can iterate through the attributes and visit them recursively.

Attributes can be `$`, `@` or `%` (and even `&` but I will skip this). What this means in terms of Raku's type system is that they can be scalar, Iterable or Associative, and we need to distinguish these cases. With that, we can write `everything` as follows:

```perl6
sub everything (\t, \acc,&update,&match) {
    # Arguments a immutable, so copy to $acc_
    my $acc_ = acc;
    # Match and update $acc_
    $acc_ =update($acc_,match(t));
    # Test the attribute type
    if t ~~ Associative {
        # Iterate over the values
        for t.values -> \t_elt  {
            $acc_ = everything(t_elt,$acc_,&update,&match)
        }
        return $acc_; 
    }     
    elsif t ~~ Iterable {
        # Iterate
        for |t -> \t_elt  {
            $acc_ = everything(t_elt,$acc_,&update,&match)
        }
        return $acc_; 
    }

    else { 
        # Go through all attributes
        for t.^attributes -> \attr {
            # Not everyting return by ^attributes 
            # is of type Attribute
            if attr ~~ Attribute {
                # Get the attribute value
                my \expr = attr.get_value(t);
                if not expr ~~ Any  { # for ContainerDescriptor::Untyped
                    return $acc_;
                }
                # Descend into this expression
                $acc_ = everything(expr,$acc_,&update, &match);
            }
        }
    }
    return $acc_
}
```

So what we do here essentially is:

- for `@` and `%` we iterate through the values 
- iterate through the attributes using `^attributes`
- for each attribute, get the expression using `get_value`
- call `everything` on that expression
- the first thing `everything` does is update the accumulator

`everywhere` is similar:

```perl6
sub everywhere (\t_,&modifier) {
    # Modify the node
    my \t = modifier(t_);
    # Test the type for Iterable or Associative
    if t ~~ Associative {
        # Build the updated map
        my %t_;
        for t.keys -> \t_k  {
            my \t_v = t{t_k};
            %t_{t_k} = everywhere (t_v,&modifier);
        }
        return %t_; 
    }     
    elsif t ~~ Iterable {
        # Build the updated list
        my @t_=[];
        for |t -> \t_elt  {
            @t_.push( everywhere(t_elt,&modifier) );
        }
        return @t_; 
    }

    else {
        # t is immutable so copyto $t_
        my $t_ = t;
        for t.^attributes -> \attr {            
            if attr ~~ Attribute {
                my \expr = attr.get_value(t);
                if not expr ~~ Any  { # for ContainerDescriptor::Untyped
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
```

So what we do here essentially is:

- for `@` and `%` we iterate through the values
- iterate through the attributes using `^attributes`
- for each attribute, get the expression using `get_value`
- call `everywhere` on that expression
- update the attribute using `set_value` 

## This works without roles too

First of all, the above works for classes too, because the Metamodel methods are not specific to roles. Furthermore, because we test for `@` and `%`, the generics above work just fine for data structures without roles, built from hashes and arrays:

```perl6
my \lst = [1,[2,3,4,[5,6,7]],[8,9,[10,11,[12]]]];

sub matcher (\expr) {
    given expr {
        when List {
            if expr[0] % 2 == 0 {                
                    return [expr]                
            }            
        }
    }
    return []
}

my \res = everything(lst,[],&append,matcher);
say res;
# ([2 3 4 [5 6 7]] [8 9 [10 11 [12]]] [10 11 [12]] [12])
```

Or for hashes:

```perl6
my %hsh = 
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

my \hres = everything(%hsh,[],&append,&hmatcher);
say hres;
# ({b => {a => {b => 1, c => 2}, c => 1}, c => {a => 3}} {b => 1, c => 2} 3)
``` 

## Conclusion

In this article I have explained a way to implement generic traversal functions for arbitrary datastructures. I have shown the implementation for the two main schemes `everything` and `everywhere`. There are many variant traversal schemes which I happily leave to the reader to implement. 
