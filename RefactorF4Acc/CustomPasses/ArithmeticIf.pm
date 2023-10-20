# 
#   (c) 2010-now Wim Vanderbauwhede <wim@dcs.gla.ac.uk>
#   

package RefactorF4Acc::CustomPasses::ArithmeticIf;
use v5.10;
use RefactorF4Acc::Config;
use RefactorF4Acc::Utils;
use RefactorF4Acc::Refactoring::Helpers qw( stateful_pass_inplace get_annotated_sourcelines );

use vars qw( $VERSION );
$VERSION = "6.1.0";

#use warnings::unused;
use warnings;
use warnings FATAL => qw(uninitialized);
use strict;

use Carp;
$Carp::Verbose = 1;
use Data::Dumper; 

use Exporter;
@RefactorF4Acc::CustomPasses::ArithmeticIf::ISA = qw(Exporter);
@RefactorF4Acc::CustomPasses::ArithmeticIf::EXPORT_OK = qw(
    &refactor_arithmetic_if
);



=info_arithmetic_IF
IF ( e ) s1, s2, s3
e Arithmetic expression: integer, real, double precision, or quadruple precision
s1, s2, s3 Labels of executable statements

The IF statement transfers control to the first, second, or third label if the value
of the arithmetic expression is less than zero, equal to zero, or greater than
zero, respectively.

The labels can be in any order, and also equal, and of course the blocks can have GOTOs.

if (e < 0) then
 	GOTO s1	
else if (e == 0) then
	GOTO s2	
else 
	GOTO s3
end if	

If the labeled blocks are in order s1, s2, s3, we can do this:

if (e < 0) then
    ! code from 	s1 up to but not including s2	
end if
if (e <= 0) then
	! code from s2 up to but not including s3	
end if 
	! code from s3 onwards
	
We can generalise this a bit: if the order in the code is s1, s2, s3 but the order in the IF is e.g.

s3, s2, s1 it means that we should only execute s3 if e>0; we should execute s2 and s3 if e==0; s1, s2 and s3 if e<0

So we need to find the blocks starting with each label and ending with the next or end of the subroutine



=cut

sub refactor_arithmetic_if {
	
	
}
1;
