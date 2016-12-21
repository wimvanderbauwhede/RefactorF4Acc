#!/usr/bin/perl 
use warnings;
use strict;
use v5.16;
use Data::Dumper;
=pod
typeparser =
    list_parser <|>
    tuple_parser <|>
    record_parser <|>
    algtype_parser <|>
    number <|>
    string <|>
    type_identifier <?> "Error"

list_parser = do
    ls <- brackets commasep typeparser 
    return $ "["++(join ls) ++"]"
tuple_parser = do
    ls <- parens commasep typeparser 
    return $ "("++(join ls) ++")"
    
record_parser = do
    ti <- type_identifier
    ls <- braces commasep kvparser
    return $ join $ [ti]++ls
algtype_parser = do
    ti <- type_identifier 
    ls <- many typeparser
    return $ unwords $ [ti]++ls
kvparser = do
    k <- identifier
    symbol "="
    t <- typeparser
    return $ k++"=>"++t

join = intercalate ","    
=cut
#use AutoLoader qw( AUTOLOAD );
my $vts = "((42,\"42\",True,MkTup 42 False (\"42\",3)),MkVarDecl {vd_vartype = MkVarType {at_numtype = F95Real, at_wordsz = (4,\"42\",5)}, vd_dimension = [MkRange {r_start = Const 1 \"1\", r_stop = Var \"ip\"},MkRange {r_start = Const 1, r_stop = Var \"jp\"},MkRange {r_start = Const 1 , r_stop = Var \"kp\"}], vd_intent = InOut, vd_varlist = [\"u\"], vd_argmode = ReadWrite, vd_is_arg = True, vd_has_const_ranges = False, vd_shape=[]})";
say $vts;

my $ref=readH($vts);

say Dumper($ref);
# I remove any type constructor that has a value. This may be a bit dubious because we can have things like
# MkTup 42 "42" 
# (42,"42")
sub readH {
    (my $vts)=@_;
    my $ref=eval( $vts );
    return $ref;
}


sub AUTOLOAD {
    our $AUTOLOAD;
    if (not @_) {
        my $t=$AUTOLOAD;
        $t=~s/^.+:://;
        $t eq 'True' && do{$t=1};
        $t eq 'False' && do{$t=1};
        $t eq 'Nothing' && do{$t=undef};
        return $t;
    } else {
        if (scalar @_ == 1) {
            return $_[0];
        } else {
            return [@_];
        }
    }
}

