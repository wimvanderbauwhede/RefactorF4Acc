
#include <stdio.h>
#include <fcntl.h>

#include "err.h"
#include "SrcFileStack.h"
#include "CoordMap.h"
#include "Include.h"

int
#if defined(__cplusplus) || defined(__STDC__)
ReadingFrom(char *name)
#else
ReadingFrom(char) char *name;
#endif
{ int f;
  SrcFile temp;

  if ((f = open(name, O_RDONLY)) < 0) return 0;

  temp.buffer = SrcBuffer;
  temp.name = MapFile(LineNum);
  temp.line = MapLine(LineNum);
  SrcFileStackPush(temp);

  initBuf(name, f);
  AddBreak(name, 1);

  return 1;
}

char *
#if defined(__cplusplus) || defined(__STDC__)
ContinuationText(void)
#else
ContinuationText()
#endif
{ SrcFile temp;

  if (!SrcFileStackEmpty) {
    do {
      (void)close(finlBuf());
      temp = SrcFileStackPop;
      SrcBuffer = temp.buffer;
      AddBreak((char *) temp.name, temp.line);
      if (!*TEXTSTART) refillBuf(TEXTSTART);
    } while (!SrcFileStackEmpty && !*TEXTSTART);
  }
  return TEXTSTART;
}
