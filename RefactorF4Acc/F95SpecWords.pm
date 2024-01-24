package RefactorF4Acc::F95SpecWords;
use v5.10;
use POSIX;
use RefactorF4Acc::Config;
#
#   (c) 2010-2017 Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#

use vars qw( $VERSION );
$VERSION = "5.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;
use Carp;
use Data::Dumper;
use Exporter;

@RefactorF4Acc::F95SpecWords::ISA = qw(Exporter);

@RefactorF4Acc::F95SpecWords::EXPORT = qw(
    %F95_reserved_words
    %F95_function_like_reserved_words
    %F95_intrinsics
    %F95_intrinsic_functions
    %F95_intrinsic_functions_for_eval
    %F95_assoc_intrinsic_functions
    %F95_other_intrinsics
    %F95_types
    %F95_io_keywords
    %F95_intrinsic_subroutine_sigs
    %F95_intrinsic_function_sigs
);

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

our %F95_intrinsic_subroutine_sigs = (
	'getarg' => [
		'integer(kind=2)',
		'character(len=128)'
	],
);

our %F95_intrinsic_function_sigs = (
	'iargc' => [[],'integer(kind=2)'],

# Numeric Functions
    'abs' => [['a'],'a'],
    'aimag' => [['complex'],'real'],
    'aint' => [['real'],'real'],
    'anint' => [['real'],'real'],
    'ceiling' => [['real'],'integer'],
    'cmplx' => [['a','a'],'complex'],
    'conjg' => [['complex'],'complex'],
    'dble' => [['a'],'real(kind=8)'],
    'dim' => [['a','a'],'a'],
    'dprod' => [['real(8)','real(8)'],'real(8)'],
    'exponent' => [['real'],'real'],
    'floor' => [['real'],'integer'],
    'fraction' => [['real'],'real'],
    'int' => [['a'],'integer'],
    'max' => [['a','a'],'a'],
    'min' => [['a','a'],'a'],
    'mod' => [['a','a'],'a'],
    'modulo' => [['a','a'],'a'],
    'nearest' => [['real','real'],'real'],
    'nint' => [['real'],'integer'],
    'real' => [['a'],'real'],
    'rrspacing' => [['real'],'real'],
    'scale' => [['real','integer'],'real'],
    'set_exponent' => [['real','integer'],'real'],
    'sign' => [['a','a'],'a'],
    'spacing' => [['real'],'real'],

    # Bit manipulation
    'btest' => [['integer','integer'],'logical'],
    'iand' => [['integer','integer'],'integer'],
    'ibclr' => [['integer','integer'],'integer'],
    'ibits' => [['integer','integer','integer'],'integer'],
    'ibset' => [['integer','integer'],'integer'],
    'ieor' => [['integer','integer'],'integer'],
    'ior' => [['integer','integer'],'integer'],
    'ishft' =>[['integer','integer'],'integer'],
    'ishftc' => [['integer','integer','integer'],'integer'],

    # Character Functions
    'achar'=> [['integer'], 'character'],
    'adjustl' => [['character(*)'], 'character(*)'],
    'adjustr' => [['character(*)'], 'character(*)'],
    'char'=> [['integer'], 'character'],
    'iachar'=> [['character'], 'integer'],
    'ichar'=> [['character'], 'integer'],
    'index' => [['character(*)','character(*)','logical'],'integer'],
    'len' => [['character(*)'],'integer'],
    'len_trim' => sub {my $tstr = $_[0];$tstr=~s/\s+$//;length($tstr)}, # integer
    'lge'  => [['character(*)','character(*)'],'logical'],
    'lgt'  => [['character(*)','character(*)'],'logical'],
    'lle'  => [['character(*)','character(*)'],'logical'],
    'llt'  => [['character(*)','character(*)'],'logical'],
    'repeat' => [['character(*)','integer'],'character(*)'],
    'scan' => [['character(*)','character(*)','logical'],'integer'],
    'trim' => [['character(*)'], 'character(*)'],
    'verify' => [['character(*)','character(*)','logical'],'integer'],

    # Mathematical Functions
    # Most of these actually can take complex args too
    'acos'=> [['real'],'real'],
    'asin' => [['real'],'real'],
    'atan' =>  [['real'],'real'],
    'atan2' =>  [['real','real'],'real'],
    'cos' =>  [['real'],'real'],
    'cosh' => [['real'],'real'],
    'exp' => [['real'],'real'],
    'log' => [['real'],'real'],
    'log10' => [['real'],'real'],
    'sin' =>  [['real'],'real'],
    'sinh' =>  [['real'],'real'],
    'sqrt' =>  [['real'],'real'],
    'tan' =>  [['real'],'real'],
    'tanh' =>  [['real'],'real'],
);

our %F95_intrinsic_functions_for_eval = (
    # Numeric Functions
    'abs' => sub {abs($_[0])}, # integer or real
    'aimag' => sub { die "TODO: aimag is NOT IMPLEMENTED\n" },
    'aint' => sub {int($_[0])}, # integer
    'anint' => sub {int($_[0])}, # integer 
    'ceiling' => sub { POSIX::ceil($_[0])}, # integer 
    'cmplx' => sub { die "TODO: cmplx is NOT IMPLEMENTED\n" },
    'conjg' => sub { die "TODO: conjg is NOT IMPLEMENTED\n" },
    'dble' => sub {$_[0]}, # dummy # double
    'dim' => sub { $_[0] - $_[1] > 0 ? $_[0] - $_[1] : 0; }, # integer
    'dprod' => sub { die "TODO: dprod is NOT IMPLEMENTED\n" },
    'exponent' => sub { die "TODO: exponent is NOT IMPLEMENTED\n" },
    'floor' => sub { POSIX::floor($_[0])}, # integer
    'fraction' => sub { die "TODO: fraction is NOT IMPLEMENTED\n" },
    'int' => sub {int($_[0])},  # integer
    'max' => sub { $_[0] > $_[1] ? $_[0] : $_[1] },# integer or real
    'min' => sub { $_[0] < $_[1] ? $_[0] : $_[1] },# integer or real
    'mod' => sub { $_[0] % $_[1] },# integer 
    'modulo' => sub { $_[0] % $_[1] },# integer 
    'nearest' => sub { die "TODO: nearest is NOT IMPLEMENTED\n" },
    'nint' => sub { die "TODO: nint is NOT IMPLEMENTED\n" },
    'real' => sub {$_[0]}, # dummy # real
    'rrspacing' => sub { die "TODO: rrspacing is NOT IMPLEMENTED\n" },
    'scale' => sub { $_[0]*(2<<$_[1]) },
    'set_exponent' => sub { die "TODO: set_exponent is NOT IMPLEMENTED\n" },
    'sign' => sub { die "TODO: sign is NOT IMPLEMENTED\n" },
    'spacing' => sub { die "TODO: spacing is NOT IMPLEMENTED\n" },

    # Bit manipulation
    'btest' => sub { die "TODO: btest is NOT IMPLEMENTED\n" },
    'iand' => sub { $_[0] & $_[1] }, # integer
    'ibclr' => sub { die "TODO: ibclr is NOT IMPLEMENTED\n" },
    'ibits' => sub { die "TODO: ibits is NOT IMPLEMENTED\n" },
    'ibset' => sub { die "TODO: ibset is NOT IMPLEMENTED\n" },
    'ieor' => sub { $_[0] ^ $_[1] }, # integer
    'ior' => sub { $_[0] | $_[1] }, # integer
    'ishft' => sub {   if ($_[1]<0) {
                            $_[0] >> $_[1]
                        } else {
                            $_[0] << $_[1]
                        }
                    }, # integer
    'ishftc' => sub { die "TODO: ishftc is NOT IMPLEMENTED\n" },

    # Character Functions
    'achar'=> sub {"'".chr($_[0])."'"}, # integer -> character
    'adjustl' => sub { die "TODO: adjustl is NOT IMPLEMENTED\n" },
    'adjustr' => sub { die "TODO: adjustr is NOT IMPLEMENTED\n" },
    'char'=> sub {chr($_[0])}, # dubious; # integer -> character
    'iachar'=> sub { $_[0]=~s/[\'\"]//g; ord($_[0])},# character -> integer
    'ichar'=> sub { $_[0]=~s/[\'\"]//g; ord($_[0])}, # dubious
    'index' => sub {index($_[0],$_[1])}, # integer
    'len' => sub {length($_[0])}, # integer
    'len_trim' => sub {my $tstr = $_[0];$tstr=~s/\s+$//;length($tstr)}, # integer
    'lge'  => sub { ($_[0] eq $_[1]) or ($_[0] gt $_[1]) }, # logical
    'lgt'  => sub { $_[0] gt $_[1] }, # logical
    'lle'  => sub { ($_[0] eq $_[1]) or ($_[0] lt $_[1]) }, # logical
    'llt'  => sub { $_[0] lt $_[1] }, # logical
    'repeat' => sub { $_[0] x $_[1] },
    'scan' => sub { die "TODO: scan is NOT IMPLEMENTED\n" },
    'trim' => sub {$_[0]=~s/\s+$//;return $_[0]}, # character
    'verify' => sub { die "TODO: verify is NOT IMPLEMENTED\n" },

    # Mathematical Functions
    'acos'=> sub { atan2( sqrt(1 - $_[0] * $_[0]), $_[0] ) },
    'asin' => sub { atan2($_[0], sqrt(1 - $_[0] * $_[0])) },
    'atan' => sub { atan2($_[0],1) },
    'atan2' => sub { atan2($_[0],$_[1]) },
    'cos' => sub { cos($_[0])},
    'cosh' => sub { (exp($_[0])+exp(-$_[0]))/2 },
    'exp' => sub { exp($_[0])},
    'log' => sub { log($_[0])},
    'log10' => sub { log($_[0])/log(10)},
    'sin' => sub { sin($_[0])},
    'sinh' => sub { (exp($_[0])-exp(-$_[0]))/2 },
    'sqrt' => sub { sqrt($_[0])},
    'tan' => sub { sin($_[0])/cos($_[0])},
    'tanh' => sub { (exp($_[0])-exp(-$_[0]))/(exp($_[0])+exp(-$_[0])) },
);


1;