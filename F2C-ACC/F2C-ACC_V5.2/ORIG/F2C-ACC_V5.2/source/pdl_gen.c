#include "pdl_gen.h"

#ifdef MONITOR
#include "pdl_dapto.h"
#endif

#define PRESENT find(key, _property, (Entry *)&_Item, 0)
#define VALUE (_Item->PropVal)

#define TYPE int

#define ACCESS find(key, _property, (Entry *)&_Item, sizeof(struct intElt))

typedef struct intElt {
	Entry next;
	int selector;
	TYPE PropVal;
} *intProperty;

#if defined(__STDC__) || defined(__cplusplus)
TYPE
Getint (int _property, DefTableKey key, TYPE deflt)
#else
TYPE
Getint (_property, key, deflt)
int _property;
DefTableKey key;
TYPE deflt;
#endif
{  intProperty _Item;
{ if (key == NoKey) return deflt;
  if (PRESENT) return VALUE;
  else return deflt;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
Setint (int _property, DefTableKey key, TYPE _add, TYPE _replace)
#else
void
Setint (_property, key, _add, _replace)
int _property;
DefTableKey key;
TYPE _add;
TYPE _replace;
#endif
{  intProperty _Item;
{ if (key == NoKey) return;
  if (ACCESS) VALUE = _replace;
  else VALUE = _add;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
Resetint (int _property, DefTableKey key, TYPE _val)
#else
void
Resetint (_property, key, _val)
int _property;
DefTableKey key;
TYPE _val;
#endif
{  intProperty _Item;
{ if (key == NoKey) return;
  ACCESS; VALUE = _val;
}
}

#undef ACCESS
#undef TYPE
#define TYPE Environment

#define ACCESS find(key, _property, (Entry *)&_Item, sizeof(struct EnvironmentElt))

typedef struct EnvironmentElt {
	Entry next;
	int selector;
	TYPE PropVal;
} *EnvironmentProperty;

#if defined(__STDC__) || defined(__cplusplus)
TYPE
GetEnvironment (int _property, DefTableKey key, TYPE deflt)
#else
TYPE
GetEnvironment (_property, key, deflt)
int _property;
DefTableKey key;
TYPE deflt;
#endif
{  EnvironmentProperty _Item;
{ if (key == NoKey) return deflt;
  if (PRESENT) return VALUE;
  else return deflt;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
SetEnvironment (int _property, DefTableKey key, TYPE _add, TYPE _replace)
#else
void
SetEnvironment (_property, key, _add, _replace)
int _property;
DefTableKey key;
TYPE _add;
TYPE _replace;
#endif
{  EnvironmentProperty _Item;
{ if (key == NoKey) return;
  if (ACCESS) VALUE = _replace;
  else VALUE = _add;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
ResetEnvironment (int _property, DefTableKey key, TYPE _val)
#else
void
ResetEnvironment (_property, key, _val)
int _property;
DefTableKey key;
TYPE _val;
#endif
{  EnvironmentProperty _Item;
{ if (key == NoKey) return;
  ACCESS; VALUE = _val;
}
}

#undef ACCESS
#undef TYPE
#define TYPE IntSet

#define ACCESS find(key, _property, (Entry *)&_Item, sizeof(struct IntSetElt))

typedef struct IntSetElt {
	Entry next;
	int selector;
	TYPE PropVal;
} *IntSetProperty;

#if defined(__STDC__) || defined(__cplusplus)
TYPE
GetIntSet (int _property, DefTableKey key, TYPE deflt)
#else
TYPE
GetIntSet (_property, key, deflt)
int _property;
DefTableKey key;
TYPE deflt;
#endif
{  IntSetProperty _Item;
{ if (key == NoKey) return deflt;
  if (PRESENT) return VALUE;
  else return deflt;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
SetIntSet (int _property, DefTableKey key, TYPE _add, TYPE _replace)
#else
void
SetIntSet (_property, key, _add, _replace)
int _property;
DefTableKey key;
TYPE _add;
TYPE _replace;
#endif
{  IntSetProperty _Item;
{ if (key == NoKey) return;
  if (ACCESS) VALUE = _replace;
  else VALUE = _add;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
ResetIntSet (int _property, DefTableKey key, TYPE _val)
#else
void
ResetIntSet (_property, key, _val)
int _property;
DefTableKey key;
TYPE _val;
#endif
{  IntSetProperty _Item;
{ if (key == NoKey) return;
  ACCESS; VALUE = _val;
}
}

#if defined(__STDC__) || defined(__cplusplus)
TYPE
InsertIntSet (int _property, DefTableKey key, int val)
#else
TYPE
InsertIntSet (_property, key, val)
int _property;
DefTableKey key;
int val;
#endif
{  IntSetProperty _Item;
{ if (key == NoKey) return NULLIS;
  if (val < 0 || val > 8*sizeof(TYPE))
     message(DEADLY,"Invalid set element",0,NoPosition);
  if (!ACCESS) VALUE = NULLIS;
  VALUE |= (1<<val);
  return VALUE;
}
}

#if defined(__STDC__) || defined(__cplusplus)
TYPE
UnionIntSet (int _property, DefTableKey key, TYPE val)
#else
TYPE
UnionIntSet (_property, key, val)
int _property;
DefTableKey key;
TYPE val;
#endif
{  IntSetProperty _Item;
{ if (key == NoKey) return NULLIS;
  if (!ACCESS) VALUE = val;
  else VALUE |= val;
  return VALUE;
}
}

#if defined(__STDC__) || defined(__cplusplus)
TYPE
IntersectIntSet (int _property, DefTableKey key, TYPE val)
#else
TYPE
IntersectIntSet (_property, key, val)
int _property;
DefTableKey key;
TYPE val;
#endif
{  IntSetProperty _Item;
{ if (key == NoKey) return NULLIS;
  if (!ACCESS) VALUE = val;
  else VALUE &= val;
  return VALUE;
}
}

#undef ACCESS
#undef TYPE
#define TYPE DefTableKey

#define ACCESS find(key, _property, (Entry *)&_Item, sizeof(struct DefTableKeyElt))

typedef struct DefTableKeyElt {
	Entry next;
	int selector;
	TYPE PropVal;
} *DefTableKeyProperty;

#if defined(__STDC__) || defined(__cplusplus)
TYPE
GetDefTableKey (int _property, DefTableKey key, TYPE deflt)
#else
TYPE
GetDefTableKey (_property, key, deflt)
int _property;
DefTableKey key;
TYPE deflt;
#endif
{  DefTableKeyProperty _Item;
{ if (key == NoKey) return deflt;
  if (PRESENT) return VALUE;
  else return deflt;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
SetDefTableKey (int _property, DefTableKey key, TYPE _add, TYPE _replace)
#else
void
SetDefTableKey (_property, key, _add, _replace)
int _property;
DefTableKey key;
TYPE _add;
TYPE _replace;
#endif
{  DefTableKeyProperty _Item;
{ if (key == NoKey) return;
  if (ACCESS) VALUE = _replace;
  else VALUE = _add;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
ResetDefTableKey (int _property, DefTableKey key, TYPE _val)
#else
void
ResetDefTableKey (_property, key, _val)
int _property;
DefTableKey key;
TYPE _val;
#endif
{  DefTableKeyProperty _Item;
{ if (key == NoKey) return;
  ACCESS; VALUE = _val;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
IsDefTableKey (int _property, DefTableKey key, TYPE _which, TYPE _error)
#else
void
IsDefTableKey (_property, key, _which, _error)
int _property;
DefTableKey key;
TYPE _which;
TYPE _error;
#endif
{  DefTableKeyProperty _Item;
{ if (key == NoKey) return;
  if (!ACCESS) VALUE = _which;
  else if (VALUE != _which) VALUE = _error;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
GuaranteeDefTableKey (int _property, DefTableKey key, TYPE val)
#else
void
GuaranteeDefTableKey (_property, key, val)
int _property;
DefTableKey key;
TYPE val;
#endif
{  DefTableKeyProperty _Item;
{ if (key == NoKey) return;
  if (!ACCESS) VALUE = val;
}
}

#undef ACCESS
#undef TYPE
#define TYPE BoundsList

#define ACCESS find(key, _property, (Entry *)&_Item, sizeof(struct BoundsListElt))

typedef struct BoundsListElt {
	Entry next;
	int selector;
	TYPE PropVal;
} *BoundsListProperty;

#if defined(__STDC__) || defined(__cplusplus)
TYPE
GetBoundsList (int _property, DefTableKey key, TYPE deflt)
#else
TYPE
GetBoundsList (_property, key, deflt)
int _property;
DefTableKey key;
TYPE deflt;
#endif
{  BoundsListProperty _Item;
{ if (key == NoKey) return deflt;
  if (PRESENT) return VALUE;
  else return deflt;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
SetBoundsList (int _property, DefTableKey key, TYPE _add, TYPE _replace)
#else
void
SetBoundsList (_property, key, _add, _replace)
int _property;
DefTableKey key;
TYPE _add;
TYPE _replace;
#endif
{  BoundsListProperty _Item;
{ if (key == NoKey) return;
  if (ACCESS) VALUE = _replace;
  else VALUE = _add;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
ResetBoundsList (int _property, DefTableKey key, TYPE _val)
#else
void
ResetBoundsList (_property, key, _val)
int _property;
DefTableKey key;
TYPE _val;
#endif
{  BoundsListProperty _Item;
{ if (key == NoKey) return;
  ACCESS; VALUE = _val;
}
}

#undef ACCESS
#undef TYPE
#define TYPE PTGNode

#define ACCESS find(key, _property, (Entry *)&_Item, sizeof(struct PTGNodeElt))

typedef struct PTGNodeElt {
	Entry next;
	int selector;
	TYPE PropVal;
} *PTGNodeProperty;

#if defined(__STDC__) || defined(__cplusplus)
TYPE
GetPTGNode (int _property, DefTableKey key, TYPE deflt)
#else
TYPE
GetPTGNode (_property, key, deflt)
int _property;
DefTableKey key;
TYPE deflt;
#endif
{  PTGNodeProperty _Item;
{ if (key == NoKey) return deflt;
  if (PRESENT) return VALUE;
  else return deflt;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
SetPTGNode (int _property, DefTableKey key, TYPE _add, TYPE _replace)
#else
void
SetPTGNode (_property, key, _add, _replace)
int _property;
DefTableKey key;
TYPE _add;
TYPE _replace;
#endif
{  PTGNodeProperty _Item;
{ if (key == NoKey) return;
  if (ACCESS) VALUE = _replace;
  else VALUE = _add;
}
}

#if defined(__STDC__) || defined(__cplusplus)
void
ResetPTGNode (int _property, DefTableKey key, TYPE _val)
#else
void
ResetPTGNode (_property, key, _val)
int _property;
DefTableKey key;
TYPE _val;
#endif
{  PTGNodeProperty _Item;
{ if (key == NoKey) return;
  ACCESS; VALUE = _val;
}
}

#undef ACCESS
#undef TYPE

static struct PropElt PDLe0 = {(Entry)0, 0};
static struct intElt PDLe1 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe86 = {(Entry)&PDLe1, 8,     IntegerType};
static struct intElt PDLe2 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe87 = {(Entry)&PDLe2, 8,    IntegerType};
static struct intElt PDLe3 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe88 = {(Entry)&PDLe3, 8,   IntegerType};
static struct intElt PDLe4 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe89 = {(Entry)&PDLe4, 8,    RealType};
static struct intElt PDLe5 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe90 = {(Entry)&PDLe5, 8,   RealType};
static struct intElt PDLe6 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe91 = {(Entry)&PDLe6, 8,    RealType};
static struct intElt PDLe7 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe92 = {(Entry)&PDLe7, 8,    DoublePrecisionType};
static struct intElt PDLe8 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe93 = {(Entry)&PDLe8, 8,   ComplexType};
static struct intElt PDLe9 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe94 = {(Entry)&PDLe9, 8,   IntegerType};
static struct intElt PDLe10 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe95 = {(Entry)&PDLe10, 8,    CharacterType};
static struct intElt PDLe11 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe96 = {(Entry)&PDLe11, 8,    RealType};
static struct intElt PDLe12 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe97 = {(Entry)&PDLe12, 8,    DoublePrecisionType};
static struct intElt PDLe13 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe98 = {(Entry)&PDLe13, 8,   RealType};
static struct intElt PDLe14 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe99 = {(Entry)&PDLe14, 8,   DoublePrecisionType};
static struct intElt PDLe15 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe100 = {(Entry)&PDLe15, 8,    IntegerType};
static struct intElt PDLe16 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe101 = {(Entry)&PDLe16, 8,  IntegerType};
static struct intElt PDLe17 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe102 = {(Entry)&PDLe17, 8,     RealType};
static struct intElt PDLe18 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe103 = {(Entry)&PDLe18, 8,    IntegerType};
static struct intElt PDLe19 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe104 = {(Entry)&PDLe19, 8,    DoublePrecisionType};
static struct intElt PDLe20 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe105 = {(Entry)&PDLe20, 8,    RealType};
static struct intElt PDLe21 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe106 = {(Entry)&PDLe21, 8,     IntegerType};
static struct intElt PDLe22 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe107 = {(Entry)&PDLe22, 8,    RealType};
static struct intElt PDLe23 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe108 = {(Entry)&PDLe23, 8,    DoublePrecisionType};
static struct intElt PDLe24 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe109 = {(Entry)&PDLe24, 8,    RealType};
static struct intElt PDLe25 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe110 = {(Entry)&PDLe25, 8,   IntegerType};
static struct intElt PDLe26 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe111 = {(Entry)&PDLe26, 8,   DoublePrecisionType};
static struct intElt PDLe27 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe112 = {(Entry)&PDLe27, 8,     RealType};
static struct intElt PDLe28 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe113 = {(Entry)&PDLe28, 8,    IntegerType};
static struct intElt PDLe29 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe114 = {(Entry)&PDLe29, 8,    DoublePrecisionType};
static struct intElt PDLe30 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe115 = {(Entry)&PDLe30, 8,   DoublePrecisionType};
static struct intElt PDLe31 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe116 = {(Entry)&PDLe31, 8,     IntegerType};
static struct intElt PDLe32 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe117 = {(Entry)&PDLe32, 8,    IntegerType};
static struct intElt PDLe33 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe118 = {(Entry)&PDLe33, 8,   RealType};
static struct intElt PDLe34 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe119 = {(Entry)&PDLe34, 8,   DoublePrecisionType};
static struct intElt PDLe35 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe120 = {(Entry)&PDLe35, 8,   RealType};
static struct intElt PDLe36 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe121 = {(Entry)&PDLe36, 8,    IntegerType};
static struct intElt PDLe37 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe122 = {(Entry)&PDLe37, 8,     IntegerType};
static struct intElt PDLe38 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe123 = {(Entry)&PDLe38, 8,    IntegerType};
static struct intElt PDLe39 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe124 = {(Entry)&PDLe39, 8,   RealType};
static struct intElt PDLe40 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe125 = {(Entry)&PDLe40, 8,   DoublePrecisionType};
static struct intElt PDLe41 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe126 = {(Entry)&PDLe41, 8,   RealType};
static struct intElt PDLe42 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe127 = {(Entry)&PDLe42, 8,    IntegerType};
static struct intElt PDLe43 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe128 = {(Entry)&PDLe43, 8,     IntegerType};
static struct intElt PDLe44 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe129 = {(Entry)&PDLe44, 8,   IntegerType};
static struct intElt PDLe45 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe130 = {(Entry)&PDLe45, 8,   RealType};
static struct intElt PDLe46 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe131 = {(Entry)&PDLe46, 8,   ComplexType};
static struct intElt PDLe47 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe132 = {(Entry)&PDLe47, 8,    RealType};
static struct intElt PDLe48 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe133 = {(Entry)&PDLe48, 8,   DoublePrecisionType};
static struct intElt PDLe49 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe134 = {(Entry)&PDLe49, 8,   ComplexType};
static struct intElt PDLe50 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe135 = {(Entry)&PDLe50, 8,     RealType};
static struct intElt PDLe51 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe136 = {(Entry)&PDLe51, 8,    DoublePrecisionType};
static struct intElt PDLe52 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe137 = {(Entry)&PDLe52, 8,    ComplexType};
static struct intElt PDLe53 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe138 = {(Entry)&PDLe53, 8,     RealType};
static struct intElt PDLe54 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe139 = {(Entry)&PDLe54, 8,    RealType};
static struct intElt PDLe55 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe140 = {(Entry)&PDLe55, 8,    DoublePrecisionType};
static struct intElt PDLe56 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe141 = {(Entry)&PDLe56, 8,    ComplexType};
static struct intElt PDLe57 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe142 = {(Entry)&PDLe57, 8,   RealType};
static struct intElt PDLe58 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe143 = {(Entry)&PDLe58, 8,  RealType};
static struct intElt PDLe59 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe144 = {(Entry)&PDLe59, 8,  DoublePrecisionType};
static struct intElt PDLe60 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe145 = {(Entry)&PDLe60, 8,     RealType};
static struct intElt PDLe61 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe146 = {(Entry)&PDLe61, 8,    DoublePrecisionType};
static struct intElt PDLe62 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe147 = {(Entry)&PDLe62, 8,    ComplexType};
static struct intElt PDLe63 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe148 = {(Entry)&PDLe63, 8,     RealType};
static struct intElt PDLe64 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe149 = {(Entry)&PDLe64, 8,    DoublePrecisionType};
static struct intElt PDLe65 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe150 = {(Entry)&PDLe65, 8,    ComplexType};
static struct intElt PDLe66 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe151 = {(Entry)&PDLe66, 8,     RealType};
static struct intElt PDLe67 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe152 = {(Entry)&PDLe67, 8,    DoublePrecisionType};
static struct intElt PDLe68 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe153 = {(Entry)&PDLe68, 8,    RealType};
static struct intElt PDLe69 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe154 = {(Entry)&PDLe69, 8,   DoublePrecisionType};
static struct intElt PDLe70 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe155 = {(Entry)&PDLe70, 8,    RealType};
static struct intElt PDLe71 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe156 = {(Entry)&PDLe71, 8,   DoublePrecisionType};
static struct intElt PDLe72 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe157 = {(Entry)&PDLe72, 8,    RealType};
static struct intElt PDLe73 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe158 = {(Entry)&PDLe73, 8,   DoublePrecisionType};
static struct intElt PDLe74 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe159 = {(Entry)&PDLe74, 8,   RealType};
static struct intElt PDLe75 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe160 = {(Entry)&PDLe75, 8,  DoublePrecisionType};
static struct intElt PDLe76 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe161 = {(Entry)&PDLe76, 8,    RealType};
static struct intElt PDLe77 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe162 = {(Entry)&PDLe77, 8,   DoublePrecisionType};
static struct intElt PDLe78 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe163 = {(Entry)&PDLe78, 8,    RealType};
static struct intElt PDLe79 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe164 = {(Entry)&PDLe79, 8,   DoublePrecisionType};
static struct intElt PDLe80 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe165 = {(Entry)&PDLe80, 8,    RealType};
static struct intElt PDLe81 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe166 = {(Entry)&PDLe81, 8,   DoublePrecisionType};
static struct intElt PDLe82 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe167 = {(Entry)&PDLe82, 8,     LogicalType};
static struct intElt PDLe83 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe168 = {(Entry)&PDLe83, 8,     LogicalType};
static struct intElt PDLe84 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe169 = {(Entry)&PDLe84, 8,     LogicalType};
static struct intElt PDLe85 = {(Entry)&PDLe0, 7, 1};
static struct DefTableKeyElt PDLe170 = {(Entry)&PDLe85, 8,     LogicalType};

struct PropList PDLk[] = {
  {(Entry)&PDLe0},
  {(Entry)&PDLe0},
  {(Entry)&PDLe0},
  {(Entry)&PDLe0},
  {(Entry)&PDLe0},
  {(Entry)&PDLe0},
  {(Entry)&PDLe0},
  {(Entry)&PDLe0},
  {(Entry)&PDLe86},
  {(Entry)&PDLe87},
  {(Entry)&PDLe88},
  {(Entry)&PDLe89},
  {(Entry)&PDLe90},
  {(Entry)&PDLe91},
  {(Entry)&PDLe92},
  {(Entry)&PDLe93},
  {(Entry)&PDLe94},
  {(Entry)&PDLe95},
  {(Entry)&PDLe96},
  {(Entry)&PDLe97},
  {(Entry)&PDLe98},
  {(Entry)&PDLe99},
  {(Entry)&PDLe100},
  {(Entry)&PDLe101},
  {(Entry)&PDLe102},
  {(Entry)&PDLe103},
  {(Entry)&PDLe104},
  {(Entry)&PDLe105},
  {(Entry)&PDLe106},
  {(Entry)&PDLe107},
  {(Entry)&PDLe108},
  {(Entry)&PDLe109},
  {(Entry)&PDLe110},
  {(Entry)&PDLe111},
  {(Entry)&PDLe112},
  {(Entry)&PDLe113},
  {(Entry)&PDLe114},
  {(Entry)&PDLe115},
  {(Entry)&PDLe116},
  {(Entry)&PDLe117},
  {(Entry)&PDLe118},
  {(Entry)&PDLe119},
  {(Entry)&PDLe120},
  {(Entry)&PDLe121},
  {(Entry)&PDLe122},
  {(Entry)&PDLe123},
  {(Entry)&PDLe124},
  {(Entry)&PDLe125},
  {(Entry)&PDLe126},
  {(Entry)&PDLe127},
  {(Entry)&PDLe128},
  {(Entry)&PDLe129},
  {(Entry)&PDLe130},
  {(Entry)&PDLe131},
  {(Entry)&PDLe132},
  {(Entry)&PDLe133},
  {(Entry)&PDLe134},
  {(Entry)&PDLe135},
  {(Entry)&PDLe136},
  {(Entry)&PDLe137},
  {(Entry)&PDLe138},
  {(Entry)&PDLe139},
  {(Entry)&PDLe140},
  {(Entry)&PDLe141},
  {(Entry)&PDLe142},
  {(Entry)&PDLe143},
  {(Entry)&PDLe144},
  {(Entry)&PDLe145},
  {(Entry)&PDLe146},
  {(Entry)&PDLe147},
  {(Entry)&PDLe148},
  {(Entry)&PDLe149},
  {(Entry)&PDLe150},
  {(Entry)&PDLe151},
  {(Entry)&PDLe152},
  {(Entry)&PDLe153},
  {(Entry)&PDLe154},
  {(Entry)&PDLe155},
  {(Entry)&PDLe156},
  {(Entry)&PDLe157},
  {(Entry)&PDLe158},
  {(Entry)&PDLe159},
  {(Entry)&PDLe160},
  {(Entry)&PDLe161},
  {(Entry)&PDLe162},
  {(Entry)&PDLe163},
  {(Entry)&PDLe164},
  {(Entry)&PDLe165},
  {(Entry)&PDLe166},
  {(Entry)&PDLe167},
  {(Entry)&PDLe168},
  {(Entry)&PDLe169},
  {(Entry)&PDLe170}};

DefTableKey
#if defined(__STDC__) || defined(__cplusplus)
CloneKey (DefTableKey key)
#else
CloneKey (key)
    DefTableKey key;
#endif
{
  DefTableKey k;
  Entry e;

  if (key == NoKey) return NoKey;
  k = NewKey ();
  for (e = key->List; (e != (Entry)0) && (e->selector != 0);
       e = e->next) {
    switch (e->selector) {
      case 1:
         ResetClpValue (k, ((intProperty)e)->PropVal);
         break;
      case 2:
         ResetUnitScope (k, ((EnvironmentProperty)e)->PropVal);
         break;
      case 3:
         ResetUnique (k, ((intProperty)e)->PropVal);
         break;
      case 4:
         ResetUnitCnt (k, ((intProperty)e)->PropVal);
         break;
      case 5:
         ResetKindSet (k, ((IntSetProperty)e)->PropVal);
         break;
      case 6:
         ResetValue (k, ((intProperty)e)->PropVal);
         break;
      case 7:
         ResetIntrinsic (k, ((intProperty)e)->PropVal);
         break;
      case 8:
         ResetType (k, ((DefTableKeyProperty)e)->PropVal);
         break;
      case 9:
         ResetNumberOfDims (k, ((intProperty)e)->PropVal);
         break;
      case 10:
         ResetarrayApp (k, ((intProperty)e)->PropVal);
         break;
      case 11:
         ResettypeApp (k, ((intProperty)e)->PropVal);
         break;
      case 12:
         ResetconstantApp (k, ((intProperty)e)->PropVal);
         break;
      case 13:
         ResetexternalApp (k, ((intProperty)e)->PropVal);
         break;
      case 14:
         ResetintrinsicApp (k, ((intProperty)e)->PropVal);
         break;
      case 15:
         ResetArraySizeList (k, ((BoundsListProperty)e)->PropVal);
         break;
      case 16:
         ResetCPUDecl (k, ((intProperty)e)->PropVal);
         break;
      case 17:
         ResetGPUDecl (k, ((intProperty)e)->PropVal);
         break;
      case 18:
         ResetVariableConstant (k, ((intProperty)e)->PropVal);
         break;
      case 19:
         ResetVariableConstantValue (k, ((PTGNodeProperty)e)->PropVal);
         break;
      case 20:
         ResetConstantDeclared (k, ((intProperty)e)->PropVal);
         break;
      case 21:
         ResetTypeLength (k, ((intProperty)e)->PropVal);
         break;
      case 22:
         ResetVariableDefined (k, ((intProperty)e)->PropVal);
         break;
      case 23:
         ResetVariableCPU (k, ((intProperty)e)->PropVal);
         break;
      case 24:
         ResetVariableGPU (k, ((intProperty)e)->PropVal);
         break;
      case 25:
         ResetIntent (k, ((intProperty)e)->PropVal);
         break;
      case 26:
         ResetRoutineDefined (k, ((intProperty)e)->PropVal);
         break;
      case 27:
         ResetVariableAllocated (k, ((intProperty)e)->PropVal);
         break;
      case 28:
         ResetVariableRoutine (k, ((intProperty)e)->PropVal);
         break;
      case 29:
         ResetVariableStmt (k, ((intProperty)e)->PropVal);
         break;
      case 30:
         ResetVariableScopeGPU (k, ((intProperty)e)->PropVal);
         break;
      case 31:
         ResetVariableIntentGPU (k, ((intProperty)e)->PropVal);
         break;
      case 32:
         ResetDoLabelCount (k, ((intProperty)e)->PropVal);
         break;
      case 33:
         ResetThreadDim (k, ((intProperty)e)->PropVal);
         break;
      case 34:
         ResetRegionNumber (k, ((intProperty)e)->PropVal);
         break;
      case 35:
         ResetComputedSize (k, ((PTGNodeProperty)e)->PropVal);
         break;
      case 36:
         ResetVariableDeclaredGPU (k, ((intProperty)e)->PropVal);
         break;
      case 37:
         ResetVariableSharedGPU (k, ((intProperty)e)->PropVal);
         break;
      case 38:
         ResetVariablePromotedGPU (k, ((intProperty)e)->PropVal);
         break;
      case 39:
         ResetVariableListedGPU (k, ((intProperty)e)->PropVal);
         break;
      case 40:
         ResetSharedDim1 (k, ((intProperty)e)->PropVal);
         break;
      case 41:
         ResetSharedDim2 (k, ((intProperty)e)->PropVal);
         break;
      }
  }
  return k;
}

#ifdef MONITOR
static CONST char *pdl_names[] = {
    (char *)0,
    "ClpValue",
    "UnitScope",
    "Unique",
    "UnitCnt",
    "KindSet",
    "Value",
    "Intrinsic",
    "Type",
    "NumberOfDims",
    "arrayApp",
    "typeApp",
    "constantApp",
    "externalApp",
    "intrinsicApp",
    "ArraySizeList",
    "CPUDecl",
    "GPUDecl",
    "VariableConstant",
    "VariableConstantValue",
    "ConstantDeclared",
    "TypeLength",
    "VariableDefined",
    "VariableCPU",
    "VariableGPU",
    "Intent",
    "RoutineDefined",
    "VariableAllocated",
    "VariableRoutine",
    "VariableStmt",
    "VariableScopeGPU",
    "VariableIntentGPU",
    "DoLabelCount",
    "ThreadDim",
    "RegionNumber",
    "ComputedSize",
    "VariableDeclaredGPU",
    "VariableSharedGPU",
    "VariablePromotedGPU",
    "VariableListedGPU",
    "SharedDim1",
    "SharedDim2",
};
static CONST char *pdl_types[] = {
    (char *)0,
    "int",
    "Environment",
    "int",
    "int",
    "IntSet",
    "int",
    "int",
    "DefTableKey",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "BoundsList",
    "int",
    "int",
    "int",
    "PTGNode",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
    "PTGNode",
    "int",
    "int",
    "int",
    "int",
    "int",
    "int",
};

void
#if defined(__STDC__) || defined(__cplusplus)
pdl_mon_properties(DefTableKey k)
#else
pdl_mon_properties(k) DefTableKey k;
#endif
{
    Entry e;
    if (k == NoKey) return;
    for (e = k->List; (e != (Entry)0) && (e->selector != 0);
         e = e->next) {
        DAPTO_RESULT_STR (pdl_names[e->selector]);
        DAPTO_RESULT_STR (pdl_types[e->selector]);
        switch (e->selector) {
            case 1:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 2:
#ifdef DAPTO_RESULTEnvironment
                DAPTO_RESULTEnvironment (((EnvironmentProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((EnvironmentProperty)e)->PropVal);
#endif
                break;
            case 3:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 4:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 5:
#ifdef DAPTO_RESULTIntSet
                DAPTO_RESULTIntSet (((IntSetProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((IntSetProperty)e)->PropVal);
#endif
                break;
            case 6:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 7:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 8:
#ifdef DAPTO_RESULTDefTableKey
                DAPTO_RESULTDefTableKey (((DefTableKeyProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((DefTableKeyProperty)e)->PropVal);
#endif
                break;
            case 9:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 10:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 11:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 12:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 13:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 14:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 15:
#ifdef DAPTO_RESULTBoundsList
                DAPTO_RESULTBoundsList (((BoundsListProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((BoundsListProperty)e)->PropVal);
#endif
                break;
            case 16:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 17:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 18:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 19:
#ifdef DAPTO_RESULTPTGNode
                DAPTO_RESULTPTGNode (((PTGNodeProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((PTGNodeProperty)e)->PropVal);
#endif
                break;
            case 20:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 21:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 22:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 23:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 24:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 25:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 26:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 27:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 28:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 29:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 30:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 31:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 32:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 33:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 34:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 35:
#ifdef DAPTO_RESULTPTGNode
                DAPTO_RESULTPTGNode (((PTGNodeProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((PTGNodeProperty)e)->PropVal);
#endif
                break;
            case 36:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 37:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 38:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 39:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 40:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            case 41:
#ifdef DAPTO_RESULTint
                DAPTO_RESULTint (((intProperty)e)->PropVal);
#else
                DAPTO_RESULT_OTHER (((intProperty)e)->PropVal);
#endif
                break;
            default: DAPTO_RESULT_STR ("unknown property");
        }
    }
}
#endif
