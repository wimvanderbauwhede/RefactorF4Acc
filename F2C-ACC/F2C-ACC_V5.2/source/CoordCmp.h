
#ifndef _COORDCMP_H
#define _COORDCMP_H

#include "err.h"

extern CoordPtr FirstCoord;

#if defined(__cplusplus) || defined(__STDC__)
extern int CoordLess (CoordPtr coord1, CoordPtr coord2);
#else
extern int CoordLess ();
#endif

#if defined(__cplusplus) || defined(__STDC__)
extern int CoordLessEqual (CoordPtr coord1, CoordPtr coord2);
#else
extern int CoordLessEqual ();
#endif

#endif
