
#ifndef CoordPtrFUNCTIONTYPES_H
#define CoordPtrFUNCTIONTYPES_H

#include "eliproto.h"

/* include header file defining CoordPtr if err is set: */
#define EMPTYerrHDR
#ifndef EMPTYHDR
#include "err.h"
#endif
#undef EMPTYerrHDR

typedef int (*CoordPtrCmpFctType) ELI_ARG((CoordPtr, CoordPtr));
/* Functions that compare two CoordPtr values
 *   If the left argument is less than the right then on exit-
 *     CoordPtrCmpFctType = -1
 *   Else if the arguments are equal then on exit-
 *     CoordPtrCmpFctType = 0
 *   Else on exit-
 *     CoordPtrCmpFctType = 1
 ***/

typedef CoordPtr (*CoordPtrMapFct) ELI_ARG((CoordPtr));
/* Functions that map one CoordPtr value into another
 *   On exit-
 *     CoordPtrMapFct = image of the argument under the map
 ***/

typedef CoordPtr (*CoordPtrSumFct) ELI_ARG((CoordPtr, CoordPtr));
/* Functions that combine two CoordPtr values
 *   On exit-
 *     CoordPtrSumFct = combination of the two arguments
 ***/

#endif
