
#define SIZE 1
#define LBOUND 2
#define UBOUND 3
#define TRUE 1
#define FALSE 0

#include <stdio.h>
#include "BoundsList.h"
#include "ptg_gen.h"    /* ptg specifications           */
#include "csm.h"        /* string table access          */
#include "clp.h"        /* command line arguments access*/
#include "deftbl.h"     /* definition table access      */
#include "pdl_gen.h"    /* property defn table access   */
#include "MakeName.h"

Bounds bound;
Bounds PkgBounds(int index, int sym, int lower, int upper, DefTableKey lowerObject, DefTableKey upperObject) {

  bound.sym = sym;
  bound.lower = lower;
  bound.upper = upper;
  bound.lowerObject = lowerObject;
  bound.upperObject = upperObject;
  return (bound);
}

        /* return the PTG node of the bound desired     */
PTGNode ArrayBoundsPTG(BoundsList blist, int dim, int type, int mode) {

int length=0;
int lstr,ustr,i;

  length = LengthBoundsList(blist);
  if ((length > 0) && (length >= dim) && (dim > 0)) {
    bound = IthElemBoundsList(blist,dim);
    if (type == LBOUND) { 
      if (bound.lower == 0) {
        return(PTGAsIs("1"));
      } else {
        lstr = generateScalar(bound.lower,mode);
        return(PTGString(StringTable(lstr)));
      }
    }
    if (type == UBOUND) { 
      ustr = generateScalar(bound.upper,mode);
      return(PTGString(StringTable(ustr)));
    }
    if (type == SIZE) {
      PTGNode sizePtg;
      lstr = generateScalar(bound.lower,mode);
      ustr = generateScalar(bound.upper,mode);
      if (strcmp(StringTable(lstr),"1") == 0) { 
        sizePtg = PTGString(StringTable(ustr));
      } else {
        if (lstr > FALSE) {
          sizePtg = 
            PTGFourArgs(
              PTGString(StringTable(ustr)),
              PTGAsIs("-"),
              PTGString(StringTable(lstr)),
              PTGAsIs("+1")
            );
        } else {
          sizePtg = PTGString(StringTable(ustr));
        }
      }
      return(sizePtg);
    }
  } else {
    if ((dim <= 0 || dim > 7)) {
      fprintf(stderr,"FATAL ERROR: array dimension out of range.  Please contact the developers.\n");
      exit(1);
    }
    return(PTGAsIs("1"));
  }
}
