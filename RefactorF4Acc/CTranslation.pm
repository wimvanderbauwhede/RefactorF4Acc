package RefactorF4Acc::CTranslation;

use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
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

@RefactorF4Acc::CTranslation::ISA = qw(Exporter);

@RefactorF4Acc::CTranslation::EXPORT_OK = qw(
    &add_to_C_build_sources
    &translate_all_to_C        
);
sub translate_to_C {
	( my $stref ) = @_;
    $translate = $GO;
    for my $subname ( keys %{ $stref->{'SubsToTranslate'} }) {
        print "\nTranslating $subname to C\n" if $V;
        $gen_sub  = 1;
        $stref = parse_fortran_src( $subname, $stref );
        $stref = refactor_C_targets($stref);
        emit_C_targets($stref);
        translate_sub_to_C($stref);
    }
	return $stref;
} # END of translate_to_C()
#  -----------------------------------------------------------------------------
sub refactor_C_targets {
    ( my $stref ) = @_;
    print "\nREFACTORING C TARGETS\n";

    #   print Dumper(keys %{ $stref->{'Subroutines'} });
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        my $Sf = $stref->{'Subroutines'}{$f};
        if ( exists $stref->{'BuildSources'}{'C'}{ $Sf->{'Source'} } ) {
            $stref = refactor_subroutine_main( $f, $stref );
        }
    }
    return $stref;
}    # END of refactor_C_targets()

# -----------------------------------------------------------------------------
sub emit_C_targets {
    ( my $stref ) = @_;
    print "\nEMITTING C TARGETS\n";
    for my $f ( keys %{ $stref->{'Subroutines'} } ) {
        if (
            exists $stref->{'BuildSources'}{'C'}
            { $stref->{'Subroutines'}{$f}{'Source'} } )
        {
            emit_refactored_subroutine( $f, $targetdir, $stref, 1 );
        }
    }
}    # END of emit_C_targets()
# -----------------------------------------------------------------------------
sub translate_sub_to_C { }
# -----------------------------------------------------------------------------
sub translate_all_to_C {
    ( my $stref ) = @_;
    local $V=1;
my $T=1;
# At first, all we do is get the call tree and translate all sources to C with F2C_ACC
# The next step is to fix the bugs in F2C_ACC via post-processing (later maybe actually debug F2C_ACC)
    chdir $targetdir;
    print "\n", "=" x 80, "\n" if $V;
    print "TRANSLATING TO C\n\n" if $V;
    print `pwd`                  if $V;
    foreach my $csrc ( keys %{ $stref->{'BuildSources'}{'C'} } ) {
        if ( -e $csrc ) {
            my $cmd = "f2c $csrc";
            print $cmd, "\n" if $V;
            system($cmd) if $T;
        } else {
            print "WARNING: $csrc does not exist\n" if $W;
        }
    }

# A minor problem is that we need to translate all includes contained in the tree as well
    foreach my $inc ( keys %{ $stref->{'BuildSources'}{'H'} } ) {
        my $cmd = "f2c $inc -H"; # FIXME: includes need -I support! NOTE $inc , not ./$inc, bug in F2C_ACC
        print $cmd, "\n" if $V;
        system($cmd) if $T;
    }
    
    my $i = 0;
    print "\nPOSTPROCESSING C CODE\n\n";
    foreach my $csrc ( keys %{ $stref->{'BuildSources'}{'C'} } ) {
        $csrc =~ s/\.f/\.c/;
         if ($T) {
            postprocess_C( $stref, $csrc, $i );
         } else {
         	print "postprocess_C( \$stref, $csrc, $i );\n";
         }
        $i++;
    }

    # Test the generated code
    print "\nTESTING C CODE\n\n";
    foreach my $ii ( 0 .. $i - 1 ) {
        my $cmd = 'gcc -Wall -c -I$GPU_HOME/include tmp' . $ii . '.c';
        print $cmd, "\n" if $V;
        system $cmd if $T;
    }

}    # END of translate_sub_to_C()

# -----------------------------------------------------------------------------
# We need a separate pass I think to get the C function signatures
# Then we need to change all array accesses used as arguments to pointers:
# a[i] => a+i
# Every arg in C must be a pointer (FORTRAN uses pass-by-ref)
# So any arg in a call that is not a pointer is wrong
# We can assume that if the arg is say v and v__G exists, then
# it should be v__G
# vdepo[FTNREF1D(i,1)] => vdepo+FTNREF1D(i,1)
#
# Next, we need to figure out which arguments can remain non-pointer scalars
# That means:
# - parse the C function signature
# - find corresponding arguments in the FORTRAN signature
# - if they are Input Scalar, don't make them pointers
# - in that case, comment out the corresponding "int v = *v__G;" line

#WV04032012: TODO: this is hideous, need to refactor it into multiple functions and make more logical/robust! 
sub postprocess_C {
    ( my $stref, my $csrc, my $i ) = @_;
    print "POSTPROC $csrc\n";
    my $sub           = '';
    my $argstr        = '';
    my %params        = ();
    my %vars          = ();
    my %argvars       = ();
    my %labels        = ();
    my %input_scalars = ();

    ### Local functions
    
    # We need to check if this particular label is a Break
    # So we need a list of all labels per subroutine.
    my $isBreak = sub {
        ( my $label ) = @_;
        return ( $labels{$label} eq 'BreakTarget'
              || $labels{$label} eq 'NoopBreakTarget' );
    };

    my $isNoop = sub {
        ( my $label ) = @_;
        return ( $labels{$label} eq 'NoopBreakTarget' );
    };

    open my $CSRC,   '<', $csrc; # FIXME: need PATH support
    open my $PPCSRC, '>', 'tmp' . $i . '.c';    # FIXME
    my $skip = 0;
    my $skipline = 0;
    while ( my $line = <$CSRC> ) {
        my $decl = '';
        $line=~/^\#define\ FALSE/ && do {
        	$skipline=1;
        	print $PPCSRC $line;
            next;
        }; 
        if ($line=~/^\#define\s+(\w+)/ ) {
        	my $par=$1;
        	if ( exists $stref->{'Subroutines'}{$sub}{'Parameters'}{$par} ) { # FIXME!i
                $skipline=0;
        	}
        }; 
        if ($line=~/^\s*\/\//) {
        	print $PPCSRC $line;
        	next;
        }
        $line=~/^\s*$/ && next;
        # Rewrite the subroutine signature. Not sure if this is still required, skip for now.
        $line =~ /^\s*void\s+(\w+)_\s+\(\s*(.*?)\s*\)\s+\{/ && do {
        	$skipline=0;
            $sub    = $1;
            $argstr = $2;
            my $Ssub = $stref->{'Subroutines'}{$sub};
            my @args = split( /\s*\,\s*/, $argstr );

            %argvars = map {
                s/^\w+\s+\*?//;
                s/^F2C-ACC.*?\.\s+\*?//;
                $_ => 1;
            } @args;

            for my $i ( keys %{ $Ssub->{'Includes'} } ) {
                if ( $stref->{'IncludeFiles'}{$i}{'InclType'} eq 'Parameter' ) {
                    %params = (
                        %params, %{ $stref->{'IncludeFiles'}{$i}{'Parameters'} }
                    );
                }
            }
            %vars = %{ $Ssub->{'Vars'} };
            for my $arg (@args) {
                $arg =~ s/^\w+\s+\*//;
                $arg =~ s/^F2C-ACC.*?\.\s+\*?//;
                my $var = $arg;
                $var =~ s/__G//;
                if ( exists $vars{$var} and $vars{$var}{'Type'} ) {
                    my $ftype = $vars{$var}{'Type'};
                    my $ctype = toCType($ftype);
#                    print Dumper($Ssub->{'RefactoredArgs'}{'Set'});
                    my $iodir = $Ssub->{'RefactoredArgs'}{'Set'}{$var}{'IODir'};
                    my $kind  = $vars{$var}{'Kind'};

                    if ( $iodir eq 'In' and $kind eq 'Scalar' ) {
                        $arg = "$ctype $var";
                    } else {
                        $arg = "$ctype *$arg";
                    }
                } else {
                    die "No entry for $var in $sub\n" . Dumper(%vars);
                }
            }
            $line = "\t void ${sub}_( " . join( ',', @args ) . " ){\n";

            %labels = ();
            if ( exists $Ssub->{'Gotos'} ) {
                %labels = %{ $Ssub->{'Gotos'} };
            }
            # Create a header file with declarations
            $decl = $line;
            $decl =~ s/\{.*$/;/;
            my $hfile = "$sub.h";            
            open my $INC, '>', $hfile;
            my $shield = $hfile;
            $shield =~ s/\./_/;
            $shield = '_' . uc($shield) . '_';
            print $INC '#ifndef ' . $shield . "\n";
            print $INC '#define ' . $shield . "\n";
            print $INC $decl, "\n";
            print $INC '#endif //' . $shield . "\n";
            close $INC;

            $skip = 1;
        }; # signature
        
        # This too might be obsolete, or at least "TODO"
        $line =~ /(\w+)=\*(\w+)__G;/ && do {
            if ( $1 eq $2 ) {
                my $var = $1;
                my $iodir =
                  $stref->{'Subroutines'}{$sub}{'RefactoredArgs'}{'Set'}{$var}
                  {'IODir'};
                my $kind = $vars{$var}{'Kind'};
                if ( $iodir eq 'In' and $kind eq 'Scalar' ) {
                    $line =~ s|^|\/\/|;
                    $input_scalars{ $var . '__G' } = $var;
                }
            }
        };
        # Fix translation errors
        $line =~ /F2C\-ACC\:\ Type\ not\ recognized\./ && do {
            my @chunks = split( /\,/, $line );
            for my $chunk (@chunks) {
                $chunk =~ /F2C\-ACC\:\ Type\ not\ recognized\.\ \*?(\w+)/
                  && do {
                    my $var = $1;
                    $var =~ s/__G//;
                    if ( exists $vars{$var} and $vars{$var}{'Type'} ) {
                        my $ftype = $vars{$var}{'Type'};
                        my $vtype = toCType($ftype);
                        $chunk =~ s/F2C\-ACC\:\ Type\ not\ recognized\./$vtype/;
                    } else {
                        croak "No entry for $var in $sub\n" . Dumper(%vars);
                    }
                  };
            }
            $line = join( ',', @chunks );
        };

        $line =~ /F2C\-ACC\:\ xUnOp\ not\ supported\./
          && do {    # FIXME: we assume the unitary operation is .not.
            my @chunks = split( /\,/, $line );
            for my $chunk (@chunks) {
                $chunk =~ s/F2C\-ACC\:\ xUnOp\ not\ supported\./\!/;
            }
            $line = join( ',', @chunks );

          };
          # Can't have externs!
        next if $line =~ /^\s*extern\s+void\s+noop/;
        
        if ( $skip == 0 ) {
            if ( $line =~ /^\s*extern\s+\w+\s+(\w+)_\(/ ) {
                my $inc   = $1;
                my $hfile = $inc . '.h';

                if ( not -e $hfile ) {
                    $line =~ s/^\s*extern\s+//;
                }
                print $PPCSRC '#include "' . $hfile . '"' . "\n";
                next;
            }

            $line =~ /^\s+extern\s+\w+\s+\w+[;,]/ && do {
                $line =~ s|^|\/\/|;
            };    # because parameters are macros, not variables

            #*  float float and similar need to be removed
            $line =~ /float\s+(float|sngl|sqrt)/ && do {
                $line =~ s|^|\/\/|;
            };

            $line =~ /int\s+(int|mod)/ && do {
                $line =~ s|^|\/\/|;
            };

            $line =~ /(short|int)\s+(int2|short)/ && do {
                $line =~ s|^|\/\/|;
            };

            $line =~ /(long|int)\s+(int8|long)/ && do {
                $line =~ s|^|\/\/|;
            };
            if ( $line =~ /^\s*(?:\w+\s+)?\w+\s+(\w+);/ )
            { # FIXME: only works for types consisting of single strings, e.g. double precision will NOT match!
                my $mf = $1;
                if (
                    exists $stref->{'Subroutines'}{$sub}{'CalledFunctions'}
                    {$mf} )
                {
                    $line =~ s|^|\/\/|;
                }
            }
            $line =~ s/int\(/(int)(/g
              ;    # int is a FORTRAN primitive converting float to int
            $line =~ s/(int2|short)\(/(int)(/g
              ;    # int is a FORTRAN primitive converting float to int
            $line =~ s/(int8|long)\(/(long)(/g
              ;    # int is a FORTRAN primitive converting float to int
            $line =~ s/float\(/(float)(/g
              ;    # float is a FORTRAN primitive converting int to float
            $line =~ s/(dfloat|dble)\(/(double)(/g
              ;    # dble is a FORTRAN primitive converting int to float
            $line =~ s/sngl\(/(/g
              ;    # sngl is a FORTRAN primitive converting double to float

            $line =~ /goto\ C__(\d+):/ && do {
                my $label = $1;
                if ( $isBreak->($label) ) {
                    $_ = $line;
                    eval("s/goto\\ C__$label:/break/");
                    $line = $_;
                } else {
                    $line =~ s/C__(\d+)\:/C__$1/;
                }
            };

     #    s/goto\ C__37:/break/; # must have a list of all gotos that are breaks
            $line =~ /^\s+C__(\d+)/ && do {
                my $label = $1;
                if ( $isNoop->($label) ) {
                    $line =~ s|^|\/\/|;
                }
            };

            # Subroutine call
            $line !~ /\#define/
              && $line =~ s/\s([\+\-\*\/\%])\s/$1/g;    # FIXME: super ad-hoc!
            $line =~ /(^|^.*?\{\s)\s*(\w+)_\(\s([\+\*\,\w\(\)\[\]]+)\s\);/
              && do {

                # We need to replace the arguments with the correct ones.
                my $maybe_if  = $1;
                my $calledsub = $2;
                my $argstr    = $3;
                my @args      = split( /\s*\,\s*/, $argstr )
                  ; # FIXME: this will split things like v1,indzindicator[FTNREF1D(i,1)],v3
                
                my $called_sub_args =
                  $stref->{'Subroutines'}{$calledsub}{'RefactoredArgs'}{'List'};
                my @nargs = ();

                for my $ii ( 0 .. scalar @{$called_sub_args} - 1 ) {
                    my $arg            = shift @args;
                    my $called_sub_arg = $called_sub_args->[$ii];
                    $ii++;
                    my $is_input_scalar =
                      ( $stref->{'Subroutines'}{$calledsub}{'Vars'}
                          {$called_sub_arg}{'Kind'} eq 'Scalar' )
                      && ( $stref->{'Subroutines'}{$calledsub}{'RefactoredArgs'}
                        {$called_sub_arg}{'IODir'} eq 'In' )
                      ? 1
                      : 0;

                    if ( $arg =~ /^\((\w+)\)$/ ) {
                        $arg = $1;
                    }

                    #               $targ=~s/[\(\)]//g;
                    if ( $arg =~ /(\w+)\[/ ) {
                        my $var = $1;

                        # What is the type of $var?
                        my %calledsubvars =
                          %{ $stref->{'Subroutines'}{$calledsub}{'Vars'} };
                        my $ftype  = $calledsubvars{$called_sub_arg}{'Type'};
                        my $tftype = $vars{$var}{'Type'};
                        if ( $ftype ne $tftype ) {
                            print
"WARNING: $tftype $var ($sub) <> $ftype $called_sub_arg ($calledsub)\n"
                              if $W;
                        }
                        my $ctype  = toCType($ftype);
                        my $cptype = $ctype . '*';

                        while ( $arg !~ /\]/ ) {
                            my $targ = shift @args;

                            #                    print "TARG: $targ\t";
                            $arg .= ',' . $targ;

                            #                    print $arg,"\n";
                        }

                        if ( not $is_input_scalar ) {
                            $arg =~ s/\[/+/g;
                            $arg =~ s/\]//g;
                            $arg = "($cptype)($arg)";
                        }

                        #               die $arg;
                    }

                    #               print $arg,"\n";
                    if ( exists $argvars{ $arg . '__G' } ) {

# this is an argument variable
# if the called function argument type is Input Scalar
# and the argument variable is in %input_scalars
# then don't add __G
# Still not good: the arg for the called sub must be positional! So we must get the signature and count the position ...
# which means we need to parse the source first.

# print " SUBCALL $calledsub: $called_sub_arg: $is_input_scalar:" . $stref->{'Subroutines'}{$calledsub}{'Vars'}{$called_sub_arg}{'Kind'} .','. $stref->{'Subroutines'}{$calledsub}{'RefactoredArgs'}{'IODir'}{$called_sub_arg}."\n";

                        if ( not exists $input_scalars{ $arg . '__G' } ) {

                            # means v__G in enclosing sub signature is a pointer
                            if ( not $is_input_scalar ) {

                                # means the arg of the called sub is a pointer
                                $arg .= '__G';
                            } else {

                                # means the arg of the called sub is a scalar
                                #                           $arg;
                            }
                        } else {

                            # means v in enclosing sub signature is a scalar
                            if ( not $is_input_scalar ) {
                                $arg = '&' . $arg;
                            }
                        }
                    } elsif ( exists $vars{$arg}
                        and $vars{$arg}{'Kind'} ne 'Array' )
                    {

                        # means $arg is a Scalar
                        if ( not $is_input_scalar ) {
                            $arg = '&' . $arg;
                        }
                    }
                    push @nargs, $arg;
                }
                my $nargstr = join( ',', @nargs );
                chomp $line;
                $line =~ /^\s+if/ && do {
                    $line =~ s/^.*?\{//;
                };
                $line =~ s/\(.*//;
                $line .= '(' . $nargstr . ');' . "\n";
                my $close_if = ( $maybe_if =~ /if\s*\(/ ) ? '}' : '';
                $line = $maybe_if . $line . $close_if;

                #           die $line if $calledsub=~/initialize/;
              };

        } else {
            $skip = 0;
        }

        # VERY AD-HOC: get rid of write() statements
        $line =~ /^\s*write\(/ && do {
            $line =~ s|^|\/\/|;
        };

# fix % on float
# This is a pain: need to get the types of the operands and figure out the cases:
# int float, float int, float float
# FIXME: we assume float, float
        $line =~ s/\s+([\w\(\)]+)\s*\%\s*([\w\(\)]+)/ mod($1,$2)/;
        
        print $PPCSRC $line unless $skipline;
    }
    close $CSRC;
    close $PPCSRC;
}    # END of postprocess_C()

# -----------------------------------------------------------------------------
sub toCType {
    ( my $ftype ) = @_;
    my %corr = (
        'logical'          => 'int',
        'integer'          => 'int',
        'real'             => 'float',
        'double precision' => 'double',
        'doubleprecision'  => 'double',
        'character'        => 'char'
    );
    if ( exists( $corr{$ftype} ) ) {
        return $corr{$ftype};
    } else {
        print "WARNING: NO TYPE for $ftype\n" if $W;
        return 'NOTYPE';
    }
}    # END of toCType()
# -----------------------------------------------------------------------------
sub add_to_C_build_sources {
    ( my $f, my $stref ) = @_;
    my $sub_or_func = sub_func_or_incl( $f, $stref );
    my $is_inc = $sub_or_func eq 'IncludeFiles';
    if (not $is_inc ) {
    my $src =  $stref->{$sub_or_func}{$f}{'Source'};        
    if ( not exists $stref->{'BuildSources'}{'C'}{$src} ) {
        print "ADDING $src to C BuildSources\n" if $V;
        $stref->{'BuildSources'}{'C'}{$src} = 1;
#        $stref->{$sub_or_func}{$f}{'Status'} = $C_SOURCE;
    }
    } else {
    	my $inc=$f;
        if ( not exists $stref->{'BuildSources'}{'H'}{$inc} ) {
            print "ADDING $inc to C Header BuildSources\n" if $V;
            $stref->{'BuildSources'}{'H'}{$inc} = 1;
        }
    	
    }

#    for my $inc ( keys %{ $stref->{$sub_or_func}{$f}{'Includes'} } ) {
#        if ( not exists $stref->{'BuildSources'}{'H'}{$inc} ) {
#            print "ADDING $inc to C Header BuildSources\n" if $V;
#            $stref->{'BuildSources'}{'H'}{$inc} = 1;
#        }
#    }
    return $stref;
} # END of add_to_C_build_sources()
