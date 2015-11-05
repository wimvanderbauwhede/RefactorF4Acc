package RefactorF4Acc::Utils;
use v5.16;
use RefactorF4Acc::Config;
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

@RefactorF4Acc::Utils::ISA = qw(Exporter);

@RefactorF4Acc::Utils::EXPORT = qw(
    %F95_reserved_words
    &sub_func_incl_mod
    &show_annlines
    &get_maybe_args_globs
    &type_via_implicits
    &union
    &ordered_union
    &module_has
    &module_has_only
    &make_lookup_table    
    &generate_docs    
    &show_status
    &in_set
    &get_vars_from_set
);

sub sub_func_incl_mod {
    ( my $f, my $stref ) = @_;
    if (not defined $stref) {croak "arg not defined sub_func_incl_mod" }
    die join(' ; ', caller ) if $stref!~/0x/;        
    if ( exists $stref->{'Subroutines'}{$f} ) {
        return 'Subroutines';
#    } elsif ( exists $stref->{'Functions'}{$f} ) {
#        return 'Functions';
    } elsif ( exists $stref->{'IncludeFiles'}{$f} ) {
        return 'IncludeFiles';
    } elsif ( exists $stref->{'Modules'}{$f} ) { # So we only say it's a module if it is nothing else.
        return 'Modules';        
    } else {
#        #print Dumper($stref);
#        #croak "No entry for $f in the state\n";
        # Assuming it's a C function
#WV23JUL        
        return 'ExternalSubroutines';
    }
}

# -----------------------------------------------------------------------------
sub show_annlines {
    (my $annlines, my $with_info)=@_;
    for my $annline (@{ $annlines }) {
        if(ref($annline->[0]) eq 'ARRAY') {
            die "NOT A STRING: ".Dumper($annline->[0]);
        } else {
            print $annline->[0];
            if($with_info) {
#             ? "\t<";#.join(';',keys %{ $annline->[1] }).'>' : '');
                print "\t! <";
                for my $k (keys %{ $annline->[1] }) {
                    if ( not ref( $annline->[1]{$k} ) ) {
                        print  $k.'=>'.$annline->[1]{$k}.';';
                    }  else {
                        print "$k;"
                    }
                }
                print ">\n";
            } else { print "\n";
                
            }
        }
    }
}
 # -----------------------------------------------------------------------------

sub get_maybe_args_globs {
    ( my $stref, my $f ) = @_;
    my $Sf         = $stref->{'Subroutines'}{$f};
    my @globs      = ();
    my %maybe_args = ();
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        if ( defined $Sf->{'Globals'}{$inc} ) {
            @globs = ( @globs, @{ $Sf->{'Globals'}{$inc}{'List'} } );
        }
        if ( defined $stref->{'IncludeFiles'}{$inc}{'Vars'} ) {
            %maybe_args =
              ( %maybe_args, %{ $stref->{'IncludeFiles'}{$inc}{'Vars'} } );
        }
    }
    %maybe_args = ( %{ $Sf->{'Vars'} }, %maybe_args );
    my %globals = map { $_ => 1 } @globs;
    return ( \%maybe_args, \%globals );
}
# -----------------------------------------------------------------------------
sub type_via_implicits {
    
(my $stref, my $f, my $var)=@_;
if (not defined $var or $var eq '') {croak "VAR not defined!"}
#say 'type_via_implicits'.scalar(@_).$var;
    my $sub_func_incl = sub_func_incl_mod( $f, $stref );
    my $type ='Unknown';      
    my $array_or_scalar ='Unknown';
    
	my $attr='Unknown';
    if (exists $stref->{'Implicits'}{$f}{lc(substr($var,0,1))} ) {
        print "INFO: VAR <", $var, "> typed via Implicits for $f\n" if $I;                            
        my $type_kind_attr = $stref->{'Implicits'}{$f}{lc(substr($var,0,1))};
        ($type, $array_or_scalar, $attr)=@{$type_kind_attr};
=info        
        my $var_rec = {
            'Decl' => ['       ', [$type], [$var],$formatted],
            'Shape' => 'UNKNOWN', # if Array, get the shape
            'Type' => $type,
            'Attr' => '', # This is currently a string, WEAK!
            'Indent' => '      ', #OBSOLETE
            'ArrayOrScalar' => 'UNKNOWN', # Scalar|Array
        };          
        $stref->{$sub_func_incl}{$f}{'Vars'}{$var} = $var_rec;                                  
=cut                                    
    } else {
        print "WARNING: common <", $var, "> has no rule in {'Implicits'}{$f}, typing via Fortran defaults\n" if $W;
        if ($var=~/^[i-nI-N]/) {
    return ('integer', 'Scalar',  '');        
        } else {
    return ('real', 'Scalar',  '');
        } 
    }
    return ($type, $array_or_scalar, $attr);
} # END of type_via_implicits()

# -----------------------------------------------------------------------------
sub union {
    ( my $aref, my $bref ) = @_;
    croak("union()") unless (defined $aref and defined $bref);    
    if (not defined $aref) {
        return $bref;
    } elsif (not defined $bref) {
        return $aref;
    } else {    

    my %as = map { $_ => 1 } @{$aref};
    for my $elt ( @{$bref} ) {
        $as{$elt} = 1;
    }
    my @us = sort keys %as;
    return \@us;
    }
}    # END of union()

# -----------------------------------------------------------------------------
# This union is obtained by removing duplicates from @b. It is a bit slower but preserves the order
sub ordered_union {
    ( my $aref, my $bref ) = @_;
    croak("ordered_union()") unless (defined $aref and defined $bref);   
    if (not defined $aref) {
    	return $bref;
    } elsif (not defined $bref) {
        return $aref;
    } else {    
	    my @us = @{$aref};
	    my %as = map { $_ => 1 } @{$aref};
	    for my $elt ( @{$bref} ) {
	        if ( not exists $as{$elt} ) {
	            push @us, $elt;
	        }
	    }
	    return \@us;
    }
}    # END of ordered_union()
# -----------------------------------------------------------------------------
# Returns true if the module contains all items in the  $mod_has_lst
sub module_has { (my $stref, my $mod_name, my $mod_has_lst) = @_;

    my @mod_keys = keys %{ $stref->{'Modules'}{$mod_name} };
    my %mod_has = map { {$_ => 1 } } @mod_keys;
    for my $k (@{$mod_has_lst} ) {
        if (not exists $mod_has{$k}) {
            return 0;
        }
    }
    return 1;
}
# -----------------------------------------------------------------------------
# Returns true if the module contains only items in the $mod_only list, at least one of them
sub module_has_only { (my $stref, my $mod_name, my $mod_only) = @_;
#print "MODULE $mod_name INLINEABLE?\n";
    
#    print 'MOD_KEYS:'."\n".Dumper(@mod_keys);
my %mod_has=();
for my $k ( keys %{ $stref->{'Modules'}{$mod_name} } ) {    
    $mod_has{$k}=1;
}
#print 'INL MOD_HAS:'.Dumper(%mod_has)."\n";
#'TypeDecls' => {},'Uses' => {'params_common_sn' => {}},'Source' => './common_sn.f95'
    for my $k (@{$mod_only},'Status','Source','FStyle','FreeForm','HasBlocks','Inlineable','InlineableSubs' ) {
#        print "INL: ONLY: $k\n";
        if (exists $mod_has{$k}) {
            delete $mod_has{$k};
        }
    }
#    print Dumper(keys %mod_has);
#    die $mod_name if $mod_name=~/common/;
    if (scalar(keys( %mod_has )) > 0 ) { return 0; } else {
#        print 'MAYBE INLINEABLE MOD: '.$mod_name."\n";
        return 1; }
}
# -----------------------------------------------------------------------------
# A lookup table from one list to another
sub make_lookup_table {
    (my $from, my $to)=@_;
    my $lut={};    
    for my $idx (0 .. scalar @{$from}-1) {
        my $f = $from->[$idx];
        my $t = $to->[$idx];
        $lut->{$f}=$t;
    } 
    return $lut;
}


# -----------------------------------------------------------------------------

# FIXME: this routine is now broken as it relied on all docs being in the main script
sub generate_docs {
    my $scriptsrc = $0;
    my $src       = $scriptsrc;
    $src =~ s/\.pl//;
    $src =~ s/^.*\///;
    my $markdownsrc = $src . '.markdown';
    open my $PL, '<', $scriptsrc;
    open my $MD, '>', $markdownsrc;
    my $md = 0;

    while (<$PL>) {
        /^=begin\s+markdown/ && do {
            $md = 1;
            next;
        };
        /^=end\s+markdown/ && do {
            $md = 0;
            next;
        };

        if ( $md == 1 ) {
            my $el = $_;
            $el =~ s/#TODO.*$//;
            while ( $el =~ /\|(\$\w+)\|/ ) {
                my $var  = $1;    # so this is a '$' and then some \w's
                my $evar = '';
                eval("\$evar= $var");

                #               warn $var, '=', $evar;
                my $svar = "\\|\\$var\\|";
                $el =~ s/$svar/$evar/;
            }
            print $MD $el;
        }
    }
    close $PL;
    close $MD;
    my $tex_src_in = $src . '_in.tex';
    system("pandoc -f markdown -t latex $markdownsrc > $tex_src_in ");

    my $tex_src_out = $src . '.tex';

    open my $TEXIN,  '<', $tex_src_in;
    open my $TEXOUT, '>', $tex_src_out;
    print $TEXOUT <<'ENDH';
\documentclass{article}
\usepackage[T1]{fontenc}
\usepackage{textcomp}

%%  Latex generated from POD in document /Users/wim/SoC_Research/FLEXPART/flx_wrf2/OpenCL-port/tools/refactor_block_subroutine.pod
%%  Using the perl module Pod::LaTeX
%%  Converted on Sun Nov 13 23:38:44 2011


\usepackage{makeidx}
\makeindex


\begin{document}

\tableofcontents

ENDH

    my $code = 0;
    while (<$TEXIN>) {
        /verbatim/ && do {
            $code = 1 - $code;
        };
        print $TEXOUT $_;
        if ($code) {

            #           print $TEXOUT "\n";
        }
    }
    close $TEXIN;
    print $TEXOUT '\printindex' . "\n";
    print $TEXOUT '\end{document}' . "\n";
    close $TEXOUT;

    #   system("pdflatex $tex_src_out");
    #   my @exts = qw(
    #     _in.tex
    #     .toc
    #     .log
    #     .idx
    #     .aux
    #   );
    #   map { unlink $src . $_ } @exts;

}
sub show_status {
    (my $st)=@_;
    my @status_str = ( 'UNREAD', 'INVENTORIED', 'READ', 'PARSED', 'FROM_BLOCK', 'C_SOURCE' );
    return $status_str[$st];    
}

sub in_set { (my $set, my $var)=@_;

    if (exists $set->{'Subsets'} ) {
        for my $subset (keys %{  $set->{'Subsets'} } ) {
            in_set($set->{'Subsets'}{$subset}, $var);
        }
    } elsif (exists $set->{'Set'}) {
        return (exists $set->{'Set'}{$var});
    } else {
        return 0;
    }
}

sub get_vars_from_set { (my $set)=@_;
    my %vars=();
     if (exists $set->{'Subsets'} ) {
        for my $subset (keys %{  $set->{'Subsets'} } ) {
            my $vars_ref= get_vars($set->{'Subsets'}{$subset});
            %vars = ( %vars, ${$vars_ref} );
        }
    } elsif (exists $set->{'Set'}) {
        return ${$set->{'Set'}} ;
        
    } 
        return \%vars;
}

our @F95_reserved_words_list = qw( 
assign backspace block data call close common continue data dimension do else else if end endfile endif entry equivalence external 
format function goto implicit inquire intrinsic open parameter pause print program read return rewind rewrite save stop subroutine 
then write allocatable allocate case contains cycle deallocate elsewhere exit include interface intent module namelist nullify only 
operator optional pointer private procedure public recursive result select sequence target use while where elemental forall pure
and or lt gt ne le ge eq
    abort
    abs
    access
    achar
    acos
    adjustl
    adjustr
    aimag
    aint
    alarm
    all
    allocated
    alog
    alog10
    amax0
    amax1
    amin0
    amin1
    amod
    and
    anint
    any
    asin
    associated
    atan
    atan2
    besj0
    besj1
    besjn
    besy0
    besy1
    besyn
    bit_size
    btest
    cabs
    ccos
    ceiling
    cexp
    char
    chdir
    chmod
    clog
    cmplx
    complex
    conjg
    cos
    cosh
    count
    cpu_time
    cshift
    csin
    csqrt
    ctime
    ctime
    dabs
    dacos
    dasin
    datan
    datan2
    date_and_time
    dbesj0
    dbesj1
    dbesjn
    dbesy0
    dbesy1
    dbesyn
    dble
    dcos
    dcosh
    ddim
    derf
    derfc
    dexp
    digits
    dim
    dint
    dlog
    dlog10
    dmax1
    dmin1
    dmod
    dnint
    dot_product
    dprod
    dsign
    dsin
    dsinh
    dsqrt
    dtan
    dtanh
    dtime
    eoshift
    epsilon
    erf
    erfc
    etime
    etime
    exit
    exp
    exponent
    fdate
    fdate
    fget
    fgetc
    float
    floor
    flush
    fnum
    fput
    fputc
    fraction
    fseek
    fstat
    fstat
    ftell
    ftell
    gerror
    getarg
    getcwd
    getcwd
    getenv
    getgid
    getlog
    getpid
    getuid
    gmtime
    hostnm
    hostnm
    huge
    iabs
    iachar
    iand
    iargc
    ibclr
    ibits
    ibset
    ichar
    idate
    idim
    idint
    idnint
    ieor
    ierrno
    ifix
    imag
    imagpart
    index
    int
    int2
    int8
    ior
    irand
    isatty
    ishft
    ishftc
    isign
    itime
    kill
    kind
    lbound
    len
    len_trim
    lge
    lgt
    link
    lle
    llt
    lnblnk
    loc
    log
    log10
    logical
    long
    lshift
    lstat
    lstat
    ltime
    matmul
    max
    max0
    max1
    maxexponent
    maxloc
    maxval
    mclock
    mclock8
    merge
    min
    min0
    min1
    minexponent
    minloc
    minval
    mod
    modulo
    mvbits
    nearest
    nint
    not
    or
    pack
    perror
    precision
    present
    product
    radix
    rand
    random_number
    random_seed
    range
    real
    realpart
    rename
    repeat
    reshape
    rrspacing
    rshift
    scale
    scan
    second
    second
    selected_int_kind
    selected_real_kind
    set_exponent
    shape
    short
    sign
    signal
    sin
    sinh
    sleep
    sngl
    spacing
    spread
    sqrt
    srand
    stat
    stat
    sum
    symlnk
    system
    system_clock
    tan
    tanh
    time
    time8
    tiny
    transfer
    transpose
    trim
    ttynam
    ttynam
    ubound
    umask
    unlink
    unpack
    verify
    xor
    zabs
    zcos
    zexp
    zlog
    zsin
    zsqrt 
);
our %F95_reserved_words = map { $_=>1 } @F95_reserved_words_list ; 


1;