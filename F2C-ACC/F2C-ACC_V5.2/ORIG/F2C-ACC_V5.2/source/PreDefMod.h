#ifndef PREDEFMOD_H
#define PREDEFMOD_H

#include "eliproto.h"
#include "envmod.h"

extern void PreDefine
  ELI_ARG((const char *name, int code, int *sym, Environment env,
           DefTableKey key, Binding *bind));
/* On exit:
        The string name is encoded with the given syntax code which is bound
        to key in the environment env.
        *sym is set to the symbol index.
	*bind is set to the created binding, if successful,
          otherwise to NoBinding
*/
extern void PreDefineSym ELI_ARG((const char *name, int code, int *sym));
/* On exit:
        The string name is encoded with the given syntax code.
        *sym is set to the symbol index.
*/

#endif
