package RefactorF4Acc::Refactoring::Subroutines::Declarations;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Common qw( format_f95_var_decl format_f95_par_decl emit_f95_var_decl);

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
    my $info = $annline->[1];
    my %args      = %{ $Sf->{'Args'}{'Set'} };
    my $globals = ( get_maybe_args_globs( $stref, $f ) )[1];
    my $skip=0;
    
    my @vars      = @{ $info->{'VarDecl'}[2] };
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
            my $rdecl=[];
                if (exists ($Sf->{'Parameters'}{'Set'}{$vars[0]} ) ){
                    $rdecl = format_f95_par_decl( $stref,$f,$tnvar );
                } else {
                	$rdecl = format_f95_var_decl($Sf,$tnvar);# WV: seems this never happens!                	
                }
            $info->{'VarDecl'} = $rdecl;#[$tnvar];
            push @{$rlines}, [ emit_f95_var_decl($rdecl), $info ];
        }
        $skip=1;
    }
    $info->{'Ref'}++;
    push @{$rlines}, [ $rline, $info ] unless $skip==1;
    return $rlines;
}    # END of create_refactored_vardecls()

# --------------------------------------------------------------------------------
# We need to check if these variables are not still present in any includes of $f!
sub create_exglob_var_declarations {
    ( my $stref, my $f, my $annline, my $rlines ) = @_;	
#    if ($f=~/LES_/) {die 'BOOM!';
#        local $I=1;local $V=1; local $W=1;
#    }
    my $Sf                 = $stref->{'Subroutines'}{$f};
    my %args               = %{ $Sf->{'Args'}{'Set'} };
    my $nextLineID=scalar @{$rlines}+1;        
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        print "INFO: GLOBALS from INC $inc in $f\n" if $I;

        for my $var ( sort @{ $Sf->{'Globals'}{$inc} } ) {
            if ( exists $args{$var} ) {
                my $rline = "*** ARG MASKS GLOB $var in $f!";
                push @{$rlines}, [ $rline, {'Error' =>1} ];
            } else {
                if ( exists $Sf->{'Commons'}{$inc} ) {
# FIXME: we need to remove these declarations from the include file!

                        croak "$f: INC $inc: VAR $var\n" if not exists $stref->{IncludeFiles}{$inc}{'Vars'}{$var};                        
                        my $rdecl = format_f95_var_decl( $stref->{'IncludeFiles'}{$inc},$var);
                        if ( exists $Sf->{'ConflictingParams'}{$var} ) {
                            my $gvar = $Sf->{'ConflictingParams'}{$var};
                            print
"WARNING: CONFLICT in arg decls for $f: renaming $var to ${var}_GLOB\n"
                              if $W;
                            $rdecl->[2][0] =~ s/\b$var\b/$gvar/; #FIXME: only works for a single var!
                        }
                        my $rline = emit_f95_var_decl($rdecl);
                        $rline .= " ! from $inc";   
                        
#                        my $rdecl = ['',[],[$var],0];
#                        if ( not defined $rline ) {
#                            print "*** NO DECL for $var in $f, taking from INC $inc!\n" if $V;
#                            # FIXME: is it OK to just generate the decls here?
#                            $rdecl = format_f95_var_decl($stref->{IncludeFiles}{$inc},$var);
#                            $rline = emit_f95_var_decl($rdecl);
#                            $rline .= " ! from $inc";   
#                        }
                        my $info={};
                        $info->{'LineID'}= $nextLineID++;
                        $info->{'Ref'}=1;
                        $info->{'VarDecl'}=$rdecl;
                        push @{$rlines}, [ $rline, $info ];
                    } else {
                        #nothing
                    }
            }
        }    # for
    }
    return $rlines;
}    # END of create_exglob_var_declarations()
# --------------------------------------------------------------------------------
