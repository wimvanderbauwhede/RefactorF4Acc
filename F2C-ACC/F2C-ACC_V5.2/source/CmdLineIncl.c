  
#include <sys/stat.h>
#include <string.h>
#include "csm.h"
#include "obstack.h"
#include "clp.h"
#include "CmdLineIncl.h"
#define obstack_strcpy(obs, dat) obstack_copy0(obs, dat, strlen(dat))
#define _obstack_memcpy(To, From, N) memcpy ((To), (From), (N))
#define obstack_strgrow(obs, dat) obstack_grow(obs, dat, strlen(dat))

char *
#if defined(__cplusplus) || defined(__STDC__)
FindFile(char *name)
#else
FindFile(name) char *name;
#endif
{ int result;
  int length;
  int i=1;
  DefTableKeyList dirs;
  struct stat file_info;

  if (name[0] == '/') return name;

  CsmStrPtr = obstack_strcpy(Csm_obstk, name);
  dirs = IncludeDirs;

  while ((result = stat(CsmStrPtr, &file_info)) && 
        (i <= LengthDefTableKeyList(IncludeDirs)) ) {
    char *dir = 
        StringTable(GetClpValue(IthElemDefTableKeyList(IncludeDirs,i), 0));

    obstack_free(Csm_obstk, CsmStrPtr);
    obstack_strgrow(Csm_obstk, dir);
    if (dir[strlen(dir)-1] != '/') obstack_1grow(Csm_obstk, '/');
    CsmStrPtr = obstack_strcpy(Csm_obstk, name);
    i++;
  }

  if (result == 0) return CsmStrPtr;
  obstack_free(Csm_obstk, CsmStrPtr);
  return name;
}
