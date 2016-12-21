# NAME

Call::Haskell - Call Haskell functions from Perl

# SYNOPSIS

    use Call::Haskell 'My::Haskell::Module( f1, f2, f3, f4 )'

or more explicitly:

    use Call::Haskell functions => 'My::Haskell::Module( f1, f2, f3, f4 )' , path => '..', clean => 0, verbose => 0 ;

    my $res = f1(@args);

Note that the path to `Call/Haskell.pm` must be *absolute* in `@INC`. The easiest way is to add the absolute path to the `PERL5LIB` environment variable.    

# DESCRIPTION

Call::Haskell provides a simple mechanism to call Haskell functions from Perl. The syntax for the import statement is similar to what you would write in Haskell. If the path is not specified, the local directory is assumed.

To use this module you need

    - perl 5.16 or later,
    - ghc 7.8 or more recent,
    - gcc 4.8 or more recent

You also need recent versions of

    - the Inline, Inline::C and Digest::MD5 Perl packages
    - the Parsec Haskell package

Currently the Haskell function arguments and return values must have types that are lists, tuples or maps of primitive types (Int, Bool, String). Haskell's Data.Map becomes a Perl hash and vice versa. Maybe is also supported, Nothing is mapped to undef and vice versa.

The module packs the arguments into a string and unpacks the return value from a string. This will be very slow for large data structures.

Currently, you can only use functions from a single Haskell module.

The module creates two subdirectories in your working directory: `_Call_Haskell` and `_Inline`. You can find all generated code in there. 

# AUTHOR

Wim Vanderbauwhede <Wim.Vanderbauwhede@mail.be>

# COPYRIGHT

Copyright 2015- Wim Vanderbauwhede

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# SEE ALSO

- Inline, Inline::C and Digest::MD5 Perl packages
- The Parsec Haskell package [](http://hackage.haskell.org/package/parsec)

