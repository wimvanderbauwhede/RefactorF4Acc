
#ifndef SrcFileSTACK_H
#define SrcFileSTACK_H
#include "obstack.h"

extern Obstack SrcFileStack;

#define SrcFileStackEmpty \
  (obstack_next_free(&SrcFileStack) == obstack_base(&SrcFileStack))

#define SrcFileStackSize \
  ((SrcFile *)obstack_next_free(&SrcFileStack)-(SrcFile *)obstack_base(&SrcFileStack))

#define SrcFileStackTop \
  (((SrcFile *)obstack_next_free(&SrcFileStack))[-1])

#define SrcFileStackPush(v) {\
  SrcFile SrcFileStackTemp; SrcFileStackTemp = v; \
  obstack_grow(&SrcFileStack, &SrcFileStackTemp, sizeof(SrcFile)); \
}

#define SrcFileStackPop \
  (*((SrcFile *)(obstack_next_free(&SrcFileStack) -= sizeof(SrcFile))))

#define ForEachSrcFileStackElementUp(i) \
  for ((i) = (SrcFile *)obstack_base(&SrcFileStack); \
       (i) < (SrcFile *)obstack_next_free(&SrcFileStack); \
       (i)++)

#define ForEachSrcFileStackElementDown(i) \
  for ((i) = ((SrcFile *)obstack_next_free(&SrcFileStack)) - 1; \
       (i) >= (SrcFile *)obstack_base(&SrcFileStack); \
       (i)--)

#define SrcFileStackArray(i) \
  (((SrcFile *)obstack_base(&SrcFileStack))[i])

#define SrcFileStackElement(i) \
  (((SrcFile *)obstack_next_free(&SrcFileStack))[-1-(i)])
#endif
