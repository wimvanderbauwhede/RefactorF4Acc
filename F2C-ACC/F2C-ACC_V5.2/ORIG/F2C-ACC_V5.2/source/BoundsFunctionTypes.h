
#ifndef BoundsFUNCTIONTYPES_H
#define BoundsFUNCTIONTYPES_H

#include "eliproto.h"

/* include header file defining Bounds if myParams is set: */
#define EMPTYmyParamsHDR
#ifndef EMPTYHDR
#include "myParams.h"
#endif
#undef EMPTYmyParamsHDR

typedef int (*BoundsCmpFctType) ELI_ARG((Bounds, Bounds));
/* Functions that compare two Bounds values
 *   If the left argument is less than the right then on exit-
 *     BoundsCmpFctType = -1
 *   Else if the arguments are equal then on exit-
 *     BoundsCmpFctType = 0
 *   Else on exit-
 *     BoundsCmpFctType = 1
 ***/

typedef Bounds (*BoundsMapFct) ELI_ARG((Bounds));
/* Functions that map one Bounds value into another
 *   On exit-
 *     BoundsMapFct = image of the argument under the map
 ***/

typedef Bounds (*BoundsSumFct) ELI_ARG((Bounds, Bounds));
/* Functions that combine two Bounds values
 *   On exit-
 *     BoundsSumFct = combination of the two arguments
 ***/

#endif
