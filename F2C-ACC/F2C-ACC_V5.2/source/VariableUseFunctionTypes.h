
#ifndef VariableUseFUNCTIONTYPES_H
#define VariableUseFUNCTIONTYPES_H

#include "eliproto.h"

/* include header file defining VariableUse if myDataList is set: */
#define EMPTYmyDataListHDR
#ifndef EMPTYHDR
#include "myDataList.h"
#endif
#undef EMPTYmyDataListHDR

typedef int (*VariableUseCmpFctType) ELI_ARG((VariableUse, VariableUse));
/* Functions that compare two VariableUse values
 *   If the left argument is less than the right then on exit-
 *     VariableUseCmpFctType = -1
 *   Else if the arguments are equal then on exit-
 *     VariableUseCmpFctType = 0
 *   Else on exit-
 *     VariableUseCmpFctType = 1
 ***/

typedef VariableUse (*VariableUseMapFct) ELI_ARG((VariableUse));
/* Functions that map one VariableUse value into another
 *   On exit-
 *     VariableUseMapFct = image of the argument under the map
 ***/

typedef VariableUse (*VariableUseSumFct) ELI_ARG((VariableUse, VariableUse));
/* Functions that combine two VariableUse values
 *   On exit-
 *     VariableUseSumFct = combination of the two arguments
 ***/

#endif
