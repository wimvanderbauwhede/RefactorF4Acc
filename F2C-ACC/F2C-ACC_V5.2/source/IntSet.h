
#ifndef _INTSET
#define _INTSET

typedef unsigned int IntSet;

#define NullIS()        ((IntSet)0)
#define NULLIS          ((IntSet)0)
#define MaxElemIS       (8*sizeof(IntSet)-1)

#define ConsIS(el,s)    ((IntSet)((0x1 << (el)) | (s)))
#define UniteIS(s1,s2)  ((IntSet)((s1) | (s2)))
#define InterIS(s1,s2)  ((IntSet)((s1) & (s2)))
#define SubIS(s1,s2)    ((IntSet)((s1) & ~(s2)))
#define DisjIS(s1,s2)   (InterIS (s1, s2) == NULLIS)
#define EmptyIS(s)      ((s) == NULLIS)
#define EqualIS(s1,s2)  ((s1) == (s2))

#if defined(__STDC__) || defined(__cplusplus)
extern IntSet   SingleIS        (int el);
extern IntSet   AddElIS (int el, IntSet s);
extern int              InIS    (int el, IntSet s);
extern int              InclIS  (IntSet s1, IntSet s2);
extern int              CardIS  (IntSet s);
#else
extern IntSet   SingleIS        ();
extern IntSet   AddElIS ();
extern int              InIS    ();
extern int              InclIS  ();
extern int              CardIS  ();
#endif

#endif
