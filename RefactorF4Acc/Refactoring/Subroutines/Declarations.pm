package RefactorF4Acc::Refactoring::Subroutines::Declarations;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( format_f95_var_decl format_f95_par_decl );

# 
#   (c) 2010-2012 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "1.0.0";

use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Refactoring::Subroutines::Declarations::ISA = qw(Exporter);

@RefactorF4Acc::Refactoring::Subroutines::Declarations::EXPORT = qw(
    &create_exglob_var_declarations
    &create_refactored_vardecls
);

=pod
Subroutines
        create_exglob_var_declarations() -> Decls 
        create_refactored_vardecls() -> Decls
=cut

# --------------------------------------------------------------------------------
# This routine renames the declarations of local variables that conflict with global variables
sub create_refactored_vardecls {
	
    ( my $stref, my $f, my $annline, my $rlines, my $is_C_target ) = @_; 
#local $V=1;
    print "create_refactored_vardecls( $f )\n" if $V;
#    die "Bug to be fixed: applying context-free refactoring breaks the next stage!";
    my $Sf        = $stref->{'Subroutines'}{$f};
    my $line      = $annline->[0] || '';
    my $tags_lref = $annline->[1];
    my %args      = map { $_ => 1 } @{ $Sf->{'Args'} };
    my $globals = ( get_maybe_args_globs( $stref, $f ) )[1];
    my $skip=0;
    
    my @vars      = @{ $tags_lref->{'VarDecl'} };
    my @nvars = (); 
    my $rline = $line;
    # Loop over all declared variables and check for conflicts with globals
    # Also check if none of them is actually a built-in function, these must be skipped for C translation
    for my $var (@vars) {
        my $skip_var = 0;
        if ( exists $stref->{'Functions'}{$var} ) {
            if ($is_C_target) {
                print "WARNING: $var in $f is a function!\n" if $W;
                $skip_var = 1;
            }
        }
        if ( not $skip_var ) {
            if ( exists $globals->{$var} and not exists $args{$var} ) {
                print
"WARNING: CONFLICT in $f ($Sf->{'Source'}):  renaming local $var to $var\_LOCAL\n"
                  if $W;
                my $nvar = $var . '_LOCAL';
                $rline =~ s/\b$var\b/$nvar/;
                push @nvars, $nvar;
            } else {
                push @nvars, $var;
            }
        }
    } # @vars
    
    $rline =~ s/,\s*$//;
    my $spaces = $line;
    $spaces =~ s/[^\s].*$//;

    if ( $line !~ /\(.*?\)/ ) {   
    # If the line does not contain array decls,
    # remove the spaces from the original line and use them for the new line
#    warn "<$line>\n";
        if ($line=~/\s+\:\:\s+/) { # FIXME: weak test to see if already refactored!
	       $rline=$line;
        } else { # FIXME: use formatting function!!!
            croak "PARAM! $line" if $line=~/parameter/;
            $rline =
            $spaces
          . $Sf->{'Vars'}{ $vars[0] }{'Type'} . ' :: '
          . join( ',', @nvars ) . "\n";
        }       
    } else {    
        # For arrays, we split the declaration over multiple lines
        # And we use the declaration from the include
        for my $tnvar (@nvars) {
#                my $is_par=0;
#                my $val=0;
                if (exists ($Sf->{'Parameters'}{$vars[0]} ) ){
#                    $is_par=1;
#                    $val=$Sf->{'Parameters'}{$vars[0]}{'Val'};                    
                    $rline = format_f95_par_decl( $stref,$f,$tnvar );
                } else {
                	$rline = format_f95_var_decl($Sf,$tnvar);# WV: seems this never happens!                	
                }
#            $rline = format_f95_decl($Sf->{'Vars'}, [$tnvar,$is_par,$val]);
            $tags_lref->{'VarDecl'} = [$tnvar];
            push @{$rlines}, [ $rline, $tags_lref ];
        }
        $skip=1;
    }
    push @{$rlines}, [ $rline, $tags_lref ] unless $skip==1;
    return $rlines;
}    # END of create_refactored_vardecls()

# --------------------------------------------------------------------------------
sub create_exglob_var_declarations {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;
    my $Sf                 = $stref->{'Subroutines'}{$f};
    my $tags_lref          = $annline->[1];
    my %args               = map { $_ => 1 } @{ $Sf->{'Args'} };
#local $V=1;
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        print "INFO: GLOBALS from INC $inc in $f\n" if $V;
#        print Dumper(@{ $Sf->{'Globals'}{$inc} }) if $V;
        for my $var ( @{ $Sf->{'Globals'}{$inc} } ) {
            if ( exists $args{$var} ) {
                my $rline = "*** ARG MASKS GLOB $var in $f!";
                push @{$rlines}, [ $rline, $tags_lref ];
            } else {
                if ( exists $Sf->{'Commons'}{$inc} ) {
                    if ( $f ne $stref->{'IncludeFiles'}{$inc}{'Root'} ) {
                        print "\tGLOBAL $var from $inc in $f\n" if $V;
#                        croak "$f: INC $inc: VAR $var\n" if not exists $stref->{IncludeFiles}{$inc}{'Vars'}{$var};                        
#                        my $rline = format_f95_var_decl( $stref->{'IncludeFiles'}{$inc}{'Commons'},$var);
                        my $rline = format_f95_var_decl( $stref->{'IncludeFiles'}{$inc},$var);
#                        croak "$f: INC $inc: VAR $var\n" if $rline ne $tline;
                        if ( exists $Sf->{'ConflictingParams'}{$var} ) {
                            my $gvar = $Sf->{'ConflictingParams'}{$var};
                            print
"WARNING: CONFLICT in arg decls for $f: renaming $var to ${var}_GLOB\n"
                              if $W;
                            $rline =~ s/\b$var\b/$gvar/;
                        }
                        if ( not defined $rline ) {
                            print "*** NO DECL for $var in $f, taking from INC $inc!\n" if $V;
#                           $rline = "*** NO DECL for $var in $f!";
                            # FIXME: is it OK to just generate the decls here?
#                            my $decl_from_inc = $stref->{IncludeFiles}{$inc}{Vars}{$var}{Decl};
                            # FIXME: make this decl Fortran-95 style!!
                            $rline = format_f95_var_decl($stref->{IncludeFiles}{$inc},$var);
#                            $rline ="$decl_from_inc"." ! from $inc";
                            $rline .= " ! from $inc";   
#                            die $rline,"\n" if $f eq 'interpol_all';         
                        }
                        push @{$rlines}, [ $rline, $tags_lref ];
                    } elsif ($V) {
                        print last;
                    }
                } elsif ($V) {
                    print "*** NO COMMONS for $inc in $f ";
                    if ( $f eq $stref->{'IncludeFiles'}{$inc}{'Root'} ) {
                        print '(Root)' . "\n";
                    } else {
                        print 'BUT NOT ROOT!' . "\n";
                    }
                    last;
                }
            }
        }    # for
    }
#    croak Dumper($rlines);

#    die 'create_exglob_var_declarations()' if $f eq 'interpol_all';
#   die if $f=~/particles_main/;
    return $rlines;
}    # END of create_exglob_var_declarations()
# --------------------------------------------------------------------------------
