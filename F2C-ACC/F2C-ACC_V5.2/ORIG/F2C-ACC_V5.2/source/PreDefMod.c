static char rcsid[] = "$Id: PreDefMod.c,v 1.1 1999/10/15 08:47:34 uwe Exp $";

#include <string.h>
#include "idn.h"
#include "PreDefMod.h"

void
#if PROTO_OK
PreDefine(const char *name, int code, int *sym, Environment env,
          DefTableKey key, Binding *bind)
#else
PreDefine (name, code, sym, env, key, bind)
char *name; int code, *sym; Environment env; DefTableKey key; Binding *bind;
#endif
{ int idtoken = code;
  mkidn(name, strlen (name), &idtoken, sym);
  *bind = BindKey(env, *sym, key);
}

void
#if PROTO_OK
PreDefineSym(const char *name, int code, int *sym)
#else
PreDefineSym (name, code, sym) char *name; int code, *sym;
#endif
{ int idtoken = code;
  mkidn(name, strlen (name), &idtoken, sym);
}
