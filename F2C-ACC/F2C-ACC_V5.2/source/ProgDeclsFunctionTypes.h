
#ifndef ProgDeclsFUNCTIONTYPES_H
#define ProgDeclsFUNCTIONTYPES_H

#include "eliproto.h"

/* include header file defining ProgDecls if myDataList is set: */
#define EMPTYmyDataListHDR
#ifndef EMPTYHDR
#include "myDataList.h"
#endif
#undef EMPTYmyDataListHDR

typedef int (*ProgDeclsCmpFctType) ELI_ARG((ProgDecls, ProgDecls));
/* Functions that compare two ProgDecls values
 *   If the left argument is less than the right then on exit-
 *     ProgDeclsCmpFctType = -1
 *   Else if the arguments are equal then on exit-
 *     ProgDeclsCmpFctType = 0
 *   Else on exit-
 *     ProgDeclsCmpFctType = 1
 ***/

typedef ProgDecls (*ProgDeclsMapFct) ELI_ARG((ProgDecls));
/* Functions that map one ProgDecls value into another
 *   On exit-
 *     ProgDeclsMapFct = image of the argument under the map
 ***/

typedef ProgDecls (*ProgDeclsSumFct) ELI_ARG((ProgDecls, ProgDecls));
/* Functions that combine two ProgDecls values
 *   On exit-
 *     ProgDeclsSumFct = combination of the two arguments
 ***/

#endif
