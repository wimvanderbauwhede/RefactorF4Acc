
#ifndef F77SYMBOLS_H
#define F77SYMBOLS_H

#include "deftbl.h"
#include "err.h"


typedef enum {
  CommonBlock,
  ExternalFunction,
  Subroutine,
  MainProgram,
  BlockDataSubprogram,
  Array,
  Variable,
  Constant,
  StatementFunction,
  IntrinsicFunction,
  DummyProcedure,
  Module,

  InExternalStmt,
  DummyArgument,
} KindSetElement;


extern DefTableKey TypeFor[];

#if defined(__cplusplus) || defined(__STDC__)
extern DefTableKey ParameterType(int Sym, CoordPtr coord);
extern void ImplicitType(DefTableKey Type, int Initial, CoordPtr coord);
extern void DefaultImplicitTypes(void);
#else
extern DefTableKey ParameterType();
extern void ImplicitType();
extern void DefaultImplicitTypes();
#endif

#endif
