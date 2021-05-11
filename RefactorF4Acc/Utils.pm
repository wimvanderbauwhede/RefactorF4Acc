package RefactorF4Acc::Utils;
use v5.10;
use RefactorF4Acc::Config;
# 
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

use vars qw( $VERSION );
$VERSION = "2.1.1";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;

use Exporter;

@RefactorF4Acc::Utils::ISA = qw(Exporter);

@RefactorF4Acc::Utils::EXPORT = qw(
    %F95_reserved_words    
    %F95_function_like_reserved_words
    %F95_intrinsics
    %F95_intrinsic_functions
    %F95_assoc_intrinsic_functions
    %F95_other_intrinsics
    %F95_types
    %F95_io_keywords
    &sub_func_incl_mod
    &show_annlines
    &pp_annlines
    &write_out
    &get_maybe_args_globs
    &type_via_implicits
    &module_has
    &module_has_only
    &generate_docs    
    &show_status
    &in_nested_set
    &get_vars_from_set
    &get_var_record_from_set
    &add_var_decl_to_set
    &remove_var_decl_from_set
    &get_kv_for_all_elts_in_set
    &append_to_set
    &comment
    &numeric
    $BLANK_LINE
    &annotate
    &alias_ordered_set
    &remove_vars_from_ordered_set
    &get_module_name_from_source
    &get_kernel_and_module_names
    &get_block_id
    &warning
);



our $BLANK_LINE = ['',{'Blank'=>1,'Ref'=>1}];

sub get_kernel_and_module_names {
    my ($kernel_src, $superkernel) = @_;
    
    open my $SRC, '<', $kernel_src or die $!;
    my @src_lines = <$SRC>;
    close $SRC;
    # say 'NAMES:',Dumper grep {/subroutine/} @src_lines;
    my @kernel_sub_names    = map {/^\s*subroutine\s+(\w+)/; $1} grep { /^\s*subroutine\s+\w+/ } @src_lines;
    my $kernel_sub_name='NO_NAME';
    if (defined $superkernel) {
            ($kernel_sub_name) = grep {/superkernel/} @kernel_sub_names;
    } else {
            ($kernel_sub_name) = grep {!/superkernel/} @kernel_sub_names;
    }
    say "KERNEL SUB NAME: <$kernel_sub_name>" if $V;
    my ($kernel_module_name) = map { /^\s*module\s+(\w+)/; $1 } grep {/^\s*module\s+\w+/} @src_lines;
    say "KERNEL MODULE NAME: <$kernel_module_name>" if $V;
    return ($kernel_sub_name, $kernel_module_name);
} # END of get_kernel_and_module_names


sub get_module_name_from_source { (my $stref,my $fp) = @_;
	if (exists $stref->{'SourceFiles'}{$fp}{'SourceType'} and $stref->{'SourceFiles'}{$fp}{'SourceType'} eq 'Modules') {
	   return $stref->{'SourceFiles'}{$fp}{'ModuleName'};
	} else {
		return $fp;
	}
}
# This is a utility function to create references for one set to another. 
# now we can say e.g.  alias_ordered_set($stref,$f, 'RefactoredArgs','DeclaredOrigArgs')
sub alias_ordered_set { (my $stref,my $f,my $alias,my $orig) = @_;
	$stref->{'Subroutines'}{$f}{$alias}{'Set'}=$stref->{'Subroutines'}{$f}{$orig}{'Set'};
	$stref->{'Subroutines'}{$f}{$alias}{'List'}=$stref->{'Subroutines'}{$f}{$orig}{'List'};
    # This is so far only used for RefactoredArgs
    $stref->{'Subroutines'}{$f}{'Has'.$alias} = 1;
	return $stref;
}
# $vars_to_remove is an array ref; $ordered_set a ref to a Set,List combo
sub remove_vars_from_ordered_set { (my $ordered_set, my $vars_to_remove)=@_;

	for my $var (@{$vars_to_remove}) {
        # say "DBG: Deleting $var from ordered set ";# if $DBG;
		delete $ordered_set->{'Set'}{$var};
	}
	$ordered_set->{'List'}  = [ grep {exists $ordered_set->{'Set'}{$_}} @{ $ordered_set->{'List'} } ];
	return $ordered_set;
} # END of remove_var_from_ordered_set

sub annotate { (my $f, my $ann, my $nframes)=@_;	
    my $n = defined $nframes ? $nframes : 1;
    (my $package, my $filename, my $line, my $subroutine, my @rest) = caller($n);
    $subroutine=~s/RefactorF4Acc:://;
    return $subroutine.'('.$f.') '.(defined $nframes? $line.' ' : '').$ann; 
}

sub comment { (my $comment)=@_;
	if  (ref($comment) eq 'ARRAY') {
		(my $line, my $info) = @{$comment};
		return ['! '.$line, {%{$info},'Comments'=>1,'Ref'=>1}];
	} else {
	   return ['! '.$comment, {'Comments'=>1,'Ref'=>1}];
	}
}

sub numeric  ($$) { $_[0] <=> $_[1]; } 

sub sub_func_incl_mod {
    ( my $f, my $stref ) = @_;
    if (not defined $stref) {croak "arg not defined sub_func_incl_mod" }
    croak join(' ; ', caller )  if $DBG and $stref!~/0x/;
    croak if $DBG and not defined $f;        
    if ( exists $stref->{'Subroutines'}{$f} ) {
        if (not  exists $stref->{'Modules'}{$f} ) {
            return 'Subroutines';
        } elsif (exists $stref->{'Subroutines'}{$f}{'Source'}) {
                return 'Subroutines';
        } elsif (exists $stref->{'Modules'}{$f}{'Source'}) {
            return 'Modules';
        }
#    } elsif ( exists $stref->{'Functions'}{$f} ) {
#        return 'Functions';
    } elsif ( exists $stref->{'IncludeFiles'}{$f} ) {
        return 'IncludeFiles';
    } elsif ( exists $stref->{'Modules'}{$f} ) { # So we only say it's a module if it is nothing else.
        return 'Modules';        
    } elsif ( exists $stref->{'SourceFiles'}{$f} ) { # So we only say it's a module if it is nothing else.
        if (exists $stref->{'SourceFiles'}{$f}{'SourceType'} and $stref->{'SourceFiles'}{$f}{'SourceType'} eq 'Modules') {
        	return 'Modules';
        } else {
            return 'SourceFiles';
        }        
    } else {
#        #print Dumper($stref);
#        #croak "No entry for $f in the state\n";
        # Assuming it's a C function
#WV23JUL        
        return 'ExternalSubroutines';
    }
}
# -----------------------------------------------------------------------------
sub write_out { my ($src_str, $out_path)=@_;
    my $out_path_=$out_path;
    if (not defined $out_path ) {
        if ( not exists $Config{'CUSTOM_PASS_OUTPUT_PATH'}) {
            die "Either provide the output path as 2nd arg, or via CUSTOM_PASS_OUTPUT_PATH";
        } else {
            $out_path_= $Config{'CUSTOM_PASS_OUTPUT_PATH'};
        }
    }
    if ($out_path_ eq 'STDOUT') {
        say $src_str;
    } else {
        open my $OUT, '>', $out_path_ or die $!.': '.$out_path_;
        print $OUT $src_str;
        close $OUT; 
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
                print "  ! <";
                for my $k (keys %{ $annline->[1] }) {
                    if ( not ref( $annline->[1]{$k} ) and defined $annline->[1]{$k} ) {
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
sub pp_annlines {
    (my $annlines, my $with_info)=@_;
    my @pp_annlines=();
    for my $annline (@{ $annlines }) {
        if(ref($annline->[0]) eq 'ARRAY') {
            die "NOT A STRING: ".Dumper($annline->[0]);
        } else {
            my $pp_annline = $annline->[0];
            if($with_info) {
#             ? "\t<";#.join(';',keys %{ $annline->[1] }).'>' : '');
                $pp_annline.= "  ! <";
                for my $k (keys %{ $annline->[1] }) {
                    if ( not ref( $annline->[1]{$k} ) ) {
                        $pp_annline.=  $k.'=>'.$annline->[1]{$k}.';';
                    }  else {
                        $pp_annline.= "$k;"
                    }
                }
                $pp_annline.= ">";
                
            } 
            push @pp_annlines,$pp_annline;
        }
    }
    return \@pp_annlines;
}
 # -----------------------------------------------------------------------------
sub get_maybe_args_globs {
    ( my $stref, my $f ) = @_;
    my $Sf         = $stref->{'Subroutines'}{$f};
    my @globs      = ();
    my %maybe_args = ();
    for my $inc ( keys %{ $Sf->{'Globals'} } ) {
        if ( defined $Sf->{'Globals'}{$inc} and defined $Sf->{'Globals'}{$inc}{'List'} and scalar @{defined $Sf->{'Globals'}{$inc}{'List'}} > 0 ) {
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
sub type_via_implicits { (my $stref, my $f, my $var)=@_;
if ($DBG and not defined $var or $var eq '') {croak "VAR not defined!"}
    my $sub_func_incl = sub_func_incl_mod( $f, $stref );
    my $type ='Unknown';      
    my $array_or_scalar ='Unknown';
    
	my $attr='Unknown';
    if (exists $stref->{'Implicits'}{$f}{lc(substr($var,0,1))} ) {
        print "INFO: VAR <", $var, "> typed via Implicits for $f\n" if $I;                            
        my $type_kind_attr = $stref->{'Implicits'}{$f}{lc(substr($var,0,1))};
        ($type, $array_or_scalar, $attr)=@{$type_kind_attr};
    } 
    if ($type eq 'Unknown') {
        print "INFO: Common <", $var, "> has no rule in {'Implicits'}{$f}, typing via Fortran defaults\n" if $I;
        # In the absence of an implicit statement, a program unit is treated as if it had a host with the declaration
        #  implicit integer (i-n), real (a-h, o-z)
        if ($var=~/^[i-nI-N]/) { # 
            return ('integer', 'Scalar',  '');        
        } else {
            return ('real', 'Scalar',  '');
        }
    }
    return ($type, $array_or_scalar, $attr);
} # END of type_via_implicits()

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
#print "\nMODULE $mod_name INLINEABLE?\n";
    
#    print 'MOD_KEYS:'."\n".Dumper(keys %{ $stref->{'Modules'}{$mod_name} });
my %mod_has=();
for my $k ( keys %{ $stref->{'Modules'}{$mod_name} } ) {    
    $mod_has{$k}=$stref->{'Modules'}{$mod_name}{$k};
}

#'TypeDecls' => {},'Uses' => {'params_common_sn' => {}},'Source' => './common_sn.f95'
    for my $k (@{$mod_only},'Status','Source','FStyle','FreeForm','HasBlocks','Inlineable','InlineableSubs','TabFormat', 'ModType' ) {
#        print "INL: ONLY: $k\n";
        if (exists $mod_has{$k}) {
            delete $mod_has{$k};
        }
    }
#    print Dumper($mod_has{ModType});
#print 'INL MOD_HAS:'.Dumper(sort keys %mod_has)."\n";    
#    die $mod_name if $mod_name=~/common/;
    if (scalar(keys( %mod_has )) > 0 ) { 
#    	print 'NOT INLINEABLE MOD: '.$mod_name."\n";
    	return 0; 
    	
    } else {
#        print 'MAYBE INLINEABLE MOD: '.$mod_name."\n";
        return 1; }
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
    my @status_str = ( 'UNREAD', 'INVENTORIED', 'READ', 'PARSED', 'FROM_BLOCK', 'C_SOURCE','FILE_NOT_FOUND' );
    return $status_str[$st];    
}
# Test if a var is an element of a nested set. Returns the innermost set 
sub in_nested_set { (my $set, my $set_key, my $var)=@_;
	croak if $DBG and not defined $var;
    if (exists $set->{$set_key}{'Subsets'} ) {
        for my $subset (keys %{  $set->{$set_key}{'Subsets'} } ) {
            my $retval = in_nested_set($set->{$set_key}{'Subsets'},$subset, $var);
            # As soon as we have found a match we return it.
            if ($retval ne '') {
            	return $retval;
            }
        }
    } elsif (exists $set->{$set_key}{'Set'}) {
    	# There are no Subsets but there is a Set
        if (exists $set->{$set_key}{'Set'}{$var}) {
        	return $set_key; # This returns to the caller, does not end the recursion
        } else {
        	return ''; # This returns to the caller, does not end the recursion
        }
    } else {    	
        return '';
    }
} # END of in_nested_set

# For a set with subsets, this get the var records from all subsets
#our $indent=1;
sub get_vars_from_set { (my $set)=@_;
    my $vars={};
     if (exists $set->{'Subsets'} ) {
        for my $subset (keys %{  $set->{'Subsets'} } ) {
#        	say "  " x $indent,$subset;
#$indent++;
# carp $subset;
            my $vars_ref= get_vars_from_set($set->{'Subsets'}{$subset});
#            $indent--;
#if (defined $vars_ref) {
            $vars = { %{$vars}, %{$vars_ref} };
#}
        }
    } elsif (exists $set->{'Set'}) {
#    	say 'SET!';
        $vars = $set->{'Set'}  ;        
    } 
        return $vars;
}

# set is by name here
sub add_var_decl_to_set { (my $Sf, my $set, my $var, my $decl)=@_;
	if (not exists 	$Sf->{$set}{'Set'}{$var}) {
		push @{$Sf->{$set}{'List'}}, $var;
    	$Sf->{$set}{'Set'}{$var}=$decl;
	}
	return $Sf;
} # END of add_var_decl_to_set

# set is by name here
sub remove_var_decl_from_set { (my $Sf, my $set, my $var)=@_;
	my @var_list=();
	if (exists 	$Sf->{$set}{'Set'}{$var}) {
		delete $Sf->{$set}{'Set'}{$var};
		@var_list = grep {$_ ne $var} @{$Sf->{$set}{'List'}};
		$Sf->{$set}{'List'}=[@var_list];    	
	}
	return $Sf;
} # END of add_var_decl_to_set


sub get_var_record_from_set { (my $set, my $var)=@_;
# carp  "VAR $var => SET: ".Dumper($set);
    my %vars=();
     if (exists $set->{'Subsets'} ) {
        #  say "SUBSET ".Dumper($set->{'Subsets'});
        for my $subset (keys %{  $set->{'Subsets'} } ) {            
            # say "SUBSET $subset";
            my $vars_ref= get_vars_from_set($set->{'Subsets'}{$subset});
#            say '<'.Dumper($vars_ref).'>';
#			if (defined $vars_ref) {
            %vars = ( %vars, %{$vars_ref} );
#			}
        }
    } elsif (exists $set->{'Set'}) {
        
        return $set->{'Set'}{$var} ;        
    } 
        return $vars{$var};
}

# For every key in a hash $set, get the hash that is its value, and in that has kind the kv pair for the key $k
# Typical use is e.g. get_kv_for_all_elts_in_set( $stref->{Subroutines},'IncludeFiles' ) or
# get_kv_for_all_elts_in_set( $stref->{'IncludeFiles'},'Root')

sub get_kv_for_all_elts_in_set {
	(my $set, my $k) =@_;
	my $results={};
	for my $elt (keys %{$set}) {
		if (exists $set->{$elt}{$k} ) {
			my $v = $set->{$elt}{$k};
			$results->{$elt}=$v;
		}
	}
	return $results;
}
# This expects a ref to { 'Set' => ...} for $set1 and either { 'Set' => ...} or { 'Subsets' => ...} for $set2 
sub append_to_set { (my $set1, my $set2) = @_;
	# Flatten the set
	my $all_subsets_set2 = get_vars_from_set($set2);
	$set1->{'Set'} = { %{$set1->{'Set'}}, %{$all_subsets_set2} };
	$set1->{'List'} = [ sort keys %{ $set1->{'Set'} } ]; # WV: this destroys the order, but does it matter? 
	return $set1;
}

# From the gfortran manual
our @F95_intrinsic_functions_list = qw(
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
eoshift
epsilon
erf
erfc
exit
exp
exponent
float
floor
flush
fnum
fraction
fseek
gerror
getarg
getenv
getgid
getlog
getpid
getuid
gmtime
huge
iabs
iachar
iand
iargc
ibclr
ibits
ibset
ichar
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
kind
lbound
len
len_trim
lge
lgt
lle
llt
lnblnk
loc
log
log10
logical
long
lshift
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
repeat
reshape
rrspacing
rshift
scale
scan
selected_int_kind
selected_real_kind
set_exponent
shape
short
sign
sin
sinh
sleep
sngl
spacing
spread
sqrt
srand
sum
system_clock
tan
tanh
time8
tiny
transfer
transpose
trim
ubound
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
our %F95_intrinsic_functions = map { $_=>1 } @F95_intrinsic_functions_list;

my @F95_assoc_intrinsic_functions_list = qw(
max
max0
max1
amax0
amax1
dmax1
qmax1
i2max0
imax0
jmax0
imax1
jmax1
aimax0
ajmax0
min
min0
min1
amin0
amin1
dmin1
qmin1
i2min0
imin0
jmin0
imin1
jmin1
aimin0
ajmin0
);
my %F95_assoc_intrinsic_functions = map {$_ => 1} @F95_assoc_intrinsic_functions_list;

our @F95_other_intrinsics = qw(
idate
time
chdir
chmod
ctime
dtime
etime
fdate
fget
fgetc
fput
fputc
fstat
ftell
getcwd
hostnm
kill
link
lstat
rename
second
signal
stat
symlnk
system
ttynam
umask
unlink
);

our %F95_other_intrinsics = map { $_=>1 } @F95_other_intrinsics;

our @F95_function_like_reserved_words_list = qw(
allocate
backspace
close
deallocate
decode
encode
equivalence
format
inquire
nullify
open
print
read
rewind
rewrite
write
);

our @F95_reserved_words_list = qw( 
assign
backspace
block
data
call
close
common
continue
data
dimension
do
else
elseif
if
end
endfile
endif
entry
equivalence
external
format
function
goto
implicit
inquire
intrinsic
open
parameter
pause
print
program
read
return
rewind
rewrite
save
stop
subroutine
then
write
allocatable
allocate
case
contains
cycle
deallocate
elsewhere
include
interface
intent
module
namelist
nullify
only
operator
optional
pointer
private
procedure
public
recursive
result
select
sequence
target
use
while
where
elemental
forall
pure
lt
gt
ne
le
ge
eq
file
form
status
unit
);

our @F95_io_keywords_list = qw(
access
action
blank
direct
end
err
exist
file
fileopt
fmt
form
formatted
iostat
name
named
nextrec
nml
number
opened
readonly
rec
recl
sequential
status
unformatted
unit
);

our @F95_types_list = qw(
real
integer
double
precision
doubleprecision
logical
character 
complex
doublecomplex
);
our %F95_io_keywords = map { $_=>1 } @F95_io_keywords_list;
our %F95_reserved_words = map { $_=>1 } @F95_reserved_words_list ; 
our %F95_function_like_reserved_words = map { $_=>1 } @F95_function_like_reserved_words_list;

our %F95_types = map { $_=>1 } @F95_types_list;


our %F95_intrinsics = (%F95_intrinsic_functions,%F95_other_intrinsics);

sub warning { my ($msg, $lev) = @_;
    return if $WARNING_LEVEL==0; 
    if (not exists $messages->{WARNING}{$msg}) {
        $messages->{WARNING}{$msg}=1;
        if ($lev<=$WARNING_LEVEL) {
            say "WARNING: $msg"
        } else {
            carp "WARNING: $msg"
        }
    }
}

sub error { (my $str, my $dbg)=@_;
    if (defined $dbg and $dbg>0) {
        croak($str);
    } else {
        die $str;
    }
}

sub get_block_id { my ($block, $block_id) = @_;
    my $line_id = $block->{'LineID'};
    push @{$block_id},$line_id;
    my $in_block = $block->{'InBlock'};
    if (scalar keys %{$in_block} == 0) {
        return $block_id;
    } else {
        get_block_id($in_block,$block_id);
    }
}


1;
