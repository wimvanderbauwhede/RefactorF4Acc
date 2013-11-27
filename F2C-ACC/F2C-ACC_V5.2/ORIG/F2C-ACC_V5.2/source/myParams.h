
#ifndef MY_PARAMS_H
#define MY_PARAMS_H

#include "BoundsList.h"
#include "ptg_gen.h"
#include "deftbl.h"

typedef struct {
  int sym; 
  int lower;
  int  upper;
  DefTableKey lowerObject,upperObject;
} Bounds;
#endif
