
#ifndef BOUNDS_H
#define BOUNDS_H
#include "BoundsList.h"
#include "ptg_gen.h"
#include "deftbl.h"

Bounds PkgBounds(int index, int sym, int lower, int upper, 
  DefTableKey lowerObject, DefTableKey upperObject); 
PTGNode ArrayBoundsPTG(BoundsList blist, int dim, int type,int arrayType);

#endif
