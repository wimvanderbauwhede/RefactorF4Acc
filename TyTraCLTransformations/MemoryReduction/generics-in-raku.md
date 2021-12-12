# Generic datastructure traversals with roles and introspection

I am a [lambdacamel]() and therefore I like to adapt techniques from functional programming, and in particular from the [Haskell]() language, to Raku. One of the techniques that I use a lot is called _Generics_, also known as "Scrap Your Boilerplate" after the title of [the paper by Simon Peyton Jones and Ralf Lämmel](https://archive.alvb.in/msc/02_infogp/papers/SYB1.pdf) that introduced this approach. In their words: 

> Many programs traverse data structures built from rich mutually-recursive data types. Such programs often have a great deal of “boilerplate” code that simply walks the structure, hiding a small amount of “real” code that constitutes the reason for the traversal. ”Generic programming” is the umbrella term to describe a wide variety of programming technology directed at this problem. 

So to save you having to write your own custom traversal, this approach gives you generic functions that do the traversal on arbitrary data strucures. In this article, I will explain how you can easily implement such generics in Raku for arbitrary role-based datastructures.

## Roles as datatypes

I developed the implementation of the generics which I will present later for use with role-based datatypes. Raku's [parameterised roles](https://docs.raku.org/language/objects#index-entry-Parameterized_Roles) make creating complex datastructures very easy. I use the roles purely as datatypes, so they have no associated methods. 

For example, here is an example program in a little language that I use in my research. 

```
map (f1 . f2) (map g (zipt (v1,map h v2)))
```

The primitives are `map`, `.` (function composition), `zipt` and the tuple `(...)`. The datatype for the abstract syntax of this little language is called `Expr` and looks as follows:

```perl6
# Any expression in the language
role Expr {}
# map
role MapV[Expr \f_,Expr \v_] does Expr {
    has Expr $.f = f_;
    has Expr $.v = v_;
}
# function composition
role Comp[Expr \f_, Expr \g_] does Expr {
    has Expr $.f = f_;
    has Expr $.g = g_;
}
# zipt turns a tuple of vectors into a vector of tuples
role ZipT[Expr \t_] does Expr {
    has Expr $.t = t_
}
# tuples
role Tuple[Array[Expr] \e_] does Expr {
    has Array[Expr] $.e = e_
}
# names of functions and vectors
role Name[Str \n_] does Expr {
    has Str $.n = n_
}
```

The `Expr` role is the toplevel datatype. It is empty because it is implemented entirely in terms of the other roles, which thanks to the `does` are all of type `Expr`. And most of the roles have attributes that are also of type `Expr`. So we have a recursive datatype, a tree with the `Name` node as leaves. 

We can now write the abstract syntax tree of the example code using this `Expr` datatype:

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
    given (expr) {
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
multi sub worker(Comp expr) {...}
multi sub worker(ZipT expr) {...}
...        
```

For more details about algebraic datatypes see my earlier article [Roles as Algebraic Data Types in Raku](https://wimvanderbauwhede.github.io/articles/roles-as-adts-in-raku/).

## Generics

If I want to traverse the abstract syntax tree, what I would normally do is write a worker as above, where for every node except the leaf nodes,I would call the worker recursively. But would it not be nice if I did not have to write that code at all? Enter generics.

The [Haskell library `Data.Generics`](https://hackage.haskell.org/package/syb-0.7.2.1/docs/Data-Generics.html) provides many schemes for traversals, but the most important ones are `everything` and `everywhere`. 

`everything` is a function which takes a datastructure, a matching function, an accumulator and an update function for the accumulator. The matching function defines what you are looking for in the datastructure. The result is put into the accumulator using the update function.

```perl6
sub everything(\datastructure, \accumulator, &joiner, &matcher){...}
```

`everywhere` is a function which takes a datastructure and a modifier function. The modifier function defines which parts of the datastructure you want to modify. The result of the traversal is a modified version of the datastructure.

```perl6
sub everywhere(\datastructure, &modifier){...}
```

The most common case for the accumulator is to use a list, so the updated function appends lists to the accumulator:

```perl6
sub append(\acc, \res) {
    return (|acc ,|res);
}
```

As an example of a matching function, let's for example find all the function and vector names in our AST above:

```perl6
multi sub matcher (Expr \expr) {
    given (expr) {
        when Name {
            return [expr.n]
        } 
    }
    return []
}
```

So if we find a `Name` node, we return its `n` attribute as a single-element list; otherwise we return an empty list.

```perl6
my \names = everything(ast,[],&append,&matcher); # => returns (f1 f2 g h v1 v2)
```

Or let's say we want to change the names in this AST:

```perl6
sub modifier(\t) {
    given (t) {
        when Name {
            Name[t.n~'_updated'].new 
        }
        default {t}
    }
}

my \ast_ = everywhere(ast,&modfier); => returns the AST with all names appended with "_updated"
```

## Implementing Generics

So how do we implement these magic `everything` and `everywhere` functions? The problem to solve is that we want to iterate through the attributes of every role without having to name it. The solution for this is to use Raku's [Metaobject protocol (MOP)](https://docs.raku.org/language/mop) for introspection. In practice, we use the Rakudo-specific [`Metamodel`](https://docs.raku.org/type/Metamodel::ClassHOW). We need only three methods: `attribute`, `get_value` and `set_value`.
 
