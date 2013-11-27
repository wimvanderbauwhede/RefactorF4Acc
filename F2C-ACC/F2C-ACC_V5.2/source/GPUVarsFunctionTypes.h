
#ifndef GPUVarsFUNCTIONTYPES_H
#define GPUVarsFUNCTIONTYPES_H

#include "eliproto.h"

/* include header file defining GPUVars if myDataList is set: */
#define EMPTYmyDataListHDR
#ifndef EMPTYHDR
#include "myDataList.h"
#endif
#undef EMPTYmyDataListHDR

typedef int (*GPUVarsCmpFctType) ELI_ARG((GPUVars, GPUVars));
/* Functions that compare two GPUVars values
 *   If the left argument is less than the right then on exit-
 *     GPUVarsCmpFctType = -1
 *   Else if the arguments are equal then on exit-
 *     GPUVarsCmpFctType = 0
 *   Else on exit-
 *     GPUVarsCmpFctType = 1
 ***/

typedef GPUVars (*GPUVarsMapFct) ELI_ARG((GPUVars));
/* Functions that map one GPUVars value into another
 *   On exit-
 *     GPUVarsMapFct = image of the argument under the map
 ***/

typedef GPUVars (*GPUVarsSumFct) ELI_ARG((GPUVars, GPUVars));
/* Functions that combine two GPUVars values
 *   On exit-
 *     GPUVarsSumFct = combination of the two arguments
 ***/

#endif
