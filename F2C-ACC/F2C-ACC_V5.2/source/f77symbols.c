
#include "err.h"
#include "csm.h"
#include "pdl_gen.h"
#include "f77symbols.h"
#define obstack_strcpy(obs, dat) obstack_copy0(obs, dat, strlen(dat))
#define _obstack_memcpy(To, From, N) memcpy ((To), (From), (N))
#define obstack_strgrow(obs, dat) obstack_grow(obs, dat, strlen(dat))

static char rcsid[] =
  "$Id: F95CodeAnalysis.fw,v 1.1 2006/03/08 23:05:50 govett Exp $";

#include "CoordPtrList.h"

static CoordPtrList ParamCoord[26];


DefTableKey TypeFor[26];
static int IsDone[26];

static void
#if defined(__cplusplus) || defined(__STDC__)
DeclareImplicitType(int index, DefTableKey Type, CoordPtr coord)
#else
DeclareImplicitType(index, Type, coord)
int index; DefTableKey Type; CoordPtr coord;
#endif
{ if (IsDone[index]) {
    obstack_strgrow(Csm_obstk, "Letter ");
    obstack_1grow(Csm_obstk, 'a' + index);
/* MWG:  Bug fix for bug73
    message(
      ERROR,
      (char *)obstack_strcpy(Csm_obstk, " previously set"),
      0,
      coord);
*/
  } else {
    IsDone[index] = 1;
    if (TypeFor[index] != Type) {
      
      while (ParamCoord[index] != NULLCoordPtrList) {
        message(
          ERROR,
          "IMPLICIT setting this type follows",
          0,
          HeadCoordPtrList(ParamCoord[index]));
        ParamCoord[index] = TailCoordPtrList(ParamCoord[index]);
      }
      
    }
  }
  TypeFor[index] = Type;
}


DefTableKey
#if defined(__cplusplus) || defined(__STDC__)
ParameterType(int Sym, CoordPtr coord)
#else
ParameterType(Sym,  coord)
int Sym; CoordPtr coord;
#endif
{ int index = *(StringTable(Sym)) - 'a';
  if (!IsDone[index]) {
    ParamCoord[index] = ConsCoordPtrList(coord, ParamCoord[index]);
  }
  return TypeFor[index];
}


void
#if defined(__cplusplus) || defined(__STDC__)
ImplicitType(DefTableKey Type, int Initial, CoordPtr coord)
#else
ImplicitType(Type, Initial, coord)
DefTableKey Type; int Initial; CoordPtr coord;
#endif
{ char *p = StringTable(Initial);

  do {
    int first = *p++ - 'a', last;
    if (*p != '-') last = first; else { last = p[1] - 'a'; p += 2; }
    if (last < first) message(ERROR, "Improper character range", 0, coord);
    while (first <= last) DeclareImplicitType(first++, Type, coord);
    if (*p == ',') p++;
  } while (*p);
}


void
DefaultImplicitTypes()
{ int i;
  for (i = 0; i < 26; i++) IsDone[i] = 0;
  
  { int i;
    for (i = 0; i < 26; i++) ParamCoord[i] = NULLCoordPtrList;
    FinlCoordPtrList();
  }
  
  
  { int i;
    for (i = 0; i <= 'z'-'a'; i++) TypeFor[i] = RealType;
    for (i = 'i'-'a'; i <= 'n'-'a'; i++) TypeFor[i] = IntegerType;
  }
  
}

