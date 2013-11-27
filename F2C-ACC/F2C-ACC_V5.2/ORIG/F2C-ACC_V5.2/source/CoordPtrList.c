

#include "CoordPtrList.h"
#include "err.h"
#include "obstack.h"

typedef struct {
  Obstack space;
  void *baseptr;
} Dyn, *DynP;

static DynP CoordPtrListSpace = (DynP)0;

#if defined(__STDC__) || defined(__cplusplus)
void FinlCoordPtrList (void)
#else
void FinlCoordPtrList ()
#endif
{
    if (CoordPtrListSpace != (DynP)0)
    {  obstack_free(&(CoordPtrListSpace->space), CoordPtrListSpace->baseptr);
       CoordPtrListSpace->baseptr = obstack_alloc(&(CoordPtrListSpace->space), 0);
    }
}/* FinlCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList ConsCoordPtrList (CoordPtr e, CoordPtrList l)
#else
CoordPtrList ConsCoordPtrList (e, l)
        CoordPtr        e;
        CoordPtrList    l;
#endif
{
    CoordPtrList        h;

    if (CoordPtrListSpace == (DynP)0)
    {   CoordPtrListSpace = (DynP) malloc (sizeof(Dyn));
        if (CoordPtrListSpace == (DynP)0)
        {  message (DEADLY, "no space for CoordPtrList", 0, (POSITION*)0);
           exit (1);
        }
        obstack_init(&(CoordPtrListSpace->space));
        CoordPtrListSpace->baseptr =
                obstack_alloc(&(CoordPtrListSpace->space), 0);
    }

    h = (CoordPtrList)obstack_alloc(&(CoordPtrListSpace->space),
                                  sizeof (struct _CoordPtrLE));
    h->head = e;
    h->tail= l;
    return (h);
}/* ConsCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtr HeadCoordPtrList (CoordPtrList l)
#else
CoordPtr HeadCoordPtrList (l)
        CoordPtrList    l;
#endif
{
    if (l == NULLCoordPtrList)
    {
        message (DEADLY, "HeadCoordPtrList: empty list", 0, (POSITION*)0);
        /* return ((CoordPtr)0); */
    } /* if */
    return (l->head);
}/* HeadCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList TailCoordPtrList (CoordPtrList l)
#else
CoordPtrList TailCoordPtrList (l)
        CoordPtrList    l;
#endif
{
    return ((l==NULLCoordPtrList) ? NULLCoordPtrList : l->tail);
}/* TailCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
int LengthCoordPtrList (CoordPtrList l)
#else
int LengthCoordPtrList (l)
        CoordPtrList    l;
#endif
{
    int res = 0;

    for (; l; l = l->tail)
        res++;
    return (res);
}/* LengthCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtr IthElemCoordPtrList (CoordPtrList l, int i)
#else
CoordPtr IthElemCoordPtrList (l, i)
        CoordPtrList    l;
        int     i;
#endif
{
    while ((i>1) && l)
    {
        i--;
        l = l->tail;
    }

    if ((i<=0) || (l==NULLCoordPtrList))
        message (DEADLY, "IthElemCoordPtrList: no such element",
                 0, (POSITION*)0);
    return (l->head);
}/* IthCoordPtrList */


#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList CopyCoordPtrList (CoordPtrList l, CoordPtrMapFct cp)
#else
CoordPtrList CopyCoordPtrList (l, cp)
        CoordPtrList l;
        CoordPtrMapFct  cp;
#endif
{
    CoordPtrList NewList=NULLCoordPtrList, *addr = &NewList;

    while (l)
    {
        (*addr) = ConsCoordPtrList (cp (l->head), NULLCoordPtrList);
        addr = &((*addr)->tail);
        l = l->tail;
    }
    return (NewList);
}/* CopyCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList AppCoordPtrList (CoordPtrList l1, CoordPtrList l2)
#else
CoordPtrList AppCoordPtrList (l1, l2)
        CoordPtrList    l1, l2;
#endif
{
    CoordPtrList        NewList;
    CoordPtrList        *addr = &NewList;

    if (!l1) return (l2);
    if (!l2) return (l1);

    while (l1) {
        (*addr) = ConsCoordPtrList (l1->head, NULLCoordPtrList);
        addr = &((*addr)->tail);
        l1 = l1->tail;
    }
    (*addr) = l2;

    return (NewList);
}/* AppCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList AppElCoordPtrList (CoordPtrList l, CoordPtr e)
#else
CoordPtrList AppElCoordPtrList (l, e)
        CoordPtrList    l;
        CoordPtr        e;
#endif
{
    CoordPtrList        res = l;
    if (!l)
        return (ConsCoordPtrList (e, NULLCoordPtrList));

    while (l->tail)
        l = l->tail;
    l->tail = ConsCoordPtrList (e, NULLCoordPtrList);

    return (res);
} /* AppElCoordPtrList */


#if defined(__STDC__) || defined(__cplusplus)
void InsertAfterCoordPtrList (CoordPtrList l, CoordPtr e)
#else
void InsertAfterCoordPtrList (l, e)
        CoordPtrList    l;
        CoordPtr        e;
#endif
{
    if (!l)
        message (DEADLY, "InsertAfterCoordPtrList: null list", 0, (POSITION*)0);
    else
        l->tail = ConsCoordPtrList (e, l->tail);
}/* InsertAfterCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList OrderedInsertCoordPtrList (CoordPtrList l, CoordPtr e, CoordPtrCmpFctType fcmp)
#else
CoordPtrList OrderedInsertCoordPtrList (l, e, fcmp)
        CoordPtrList    l;
        CoordPtr        e;
        CoordPtrCmpFctType fcmp;
#endif
{
    CoordPtrList        p;
    if (!l)
        return (ConsCoordPtrList (e, NULLCoordPtrList));
    if (fcmp (e, l->head) <= 0)
        return (ConsCoordPtrList (e, l));
    p = l;
    while (p->tail && (fcmp (e, p->tail->head) > 0))
        p = p->tail;
    p->tail = ConsCoordPtrList (e, p->tail);
    return (l);
}/* OrderedInsertCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrListPtr RefEndConsCoordPtrList (CoordPtrListPtr addr, CoordPtr e)
#else
CoordPtrListPtr RefEndConsCoordPtrList (addr, e)
        CoordPtrListPtr addr;
        CoordPtr                e;
#endif
{
    if (!addr)
    {
        message (DEADLY, "RefEndConsCoordPtrList: no CoordPtrList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    (*addr) = ConsCoordPtrList (e, NULLCoordPtrList);
    return (&((*addr)->tail));
}/* RefEndConsCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrListPtr RefEndAppCoordPtrList (CoordPtrListPtr addr, CoordPtrList l)
#else
CoordPtrListPtr RefEndAppCoordPtrList (addr, l)
        CoordPtrListPtr addr;
        CoordPtrList            l;
#endif
{
    if (!addr) {
        message (DEADLY, "RefEndAppCoordPtrList: no CoordPtrList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    if (!l)
        return addr;

    (*addr) = l;

    while (l->tail)
        l = l->tail;
    return (&(l->tail));
}/* RefEndAppCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
int ElemInCoordPtrList (CoordPtr e, CoordPtrList l, CoordPtrCmpFctType fcmp)
#else
int ElemInCoordPtrList (e, l, fcmp)
        CoordPtr        e;
        CoordPtrList    l;
        CoordPtrCmpFctType      fcmp;
#endif
{
    while (l != NULLCoordPtrList) {
        if (fcmp (e, l->head) == 0)
            return (1);
        l = l->tail;
    }
    return (0);
}/* ElemInCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList AddToSetCoordPtrList (CoordPtr e, CoordPtrList l, CoordPtrCmpFctType fcmp)
#else
CoordPtrList AddToSetCoordPtrList (e, l, fcmp)
        CoordPtr        e;
        CoordPtrList    l;
        CoordPtrCmpFctType      fcmp;
#endif
{
    if (ElemInCoordPtrList (e, l, fcmp))
        return (l);
    else
        return (ConsCoordPtrList (e, l));
}/* AddToSetCoordPtrList */


#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList AddToOrderedSetCoordPtrList (CoordPtr e, CoordPtrList l, CoordPtrCmpFctType fcmp)
#else
CoordPtrList AddToOrderedSetCoordPtrList (e, l, fcmp)
        CoordPtr  e;
        CoordPtrList      l;
        CoordPtrCmpFctType fcmp;
#endif
{   int test;
    CoordPtrList  p;
    if (!l)
        return (ConsCoordPtrList (e, NULLCoordPtrList));
    if ((test = fcmp (e, l->head)) < 0)
        return (ConsCoordPtrList (e, l));
    if (test == 0) return l;
    p = l;
    while (p->tail && ((test = fcmp (e, p->tail->head)) > 0))
        p = p->tail;
    if (test) p->tail = ConsCoordPtrList (e, p->tail);
    return (l);
}/* AddToOrderedSetCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtrList MapCoordPtrList (CoordPtrList l, CoordPtrMapFct f)
#else
CoordPtrList MapCoordPtrList (l, f)
        CoordPtrList    l;
        CoordPtrMapFct f;
#endif
{
    CoordPtrList NewList = NULLCoordPtrList;
    CoordPtrList last = NULLCoordPtrList;

    while (l)
    {
        if (!NewList) {
            NewList = ConsCoordPtrList ((f (l->head)), NULLCoordPtrList);
            last = NewList;
        }
        else
        {
            last->tail = ConsCoordPtrList ((f (l->head)), NULLCoordPtrList);
            last = last->tail;
        }
        l = l->tail;
    }
    return (NewList);
}/* MapCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
int CompCoordPtrList (CoordPtrList l1, CoordPtrList l2, CoordPtrCmpFctType fcmp)
#else
int CompCoordPtrList (l1, l2, fcmp)
        CoordPtrList    l1, l2;
        CoordPtrCmpFctType fcmp;
#endif
{
    int res = 0;
    while (l1 && l2 && (res == 0)) {
        res = (fcmp (l1->head, l2->head));
        l1 = l1->tail;
        l2 = l2->tail;
    }
    if (l1 && !l2)
        return (1);
    if (!l1 && l2)
        return (-1);
    return (res);
}/* CompCoordPtrList */

#if defined(__STDC__) || defined(__cplusplus)
CoordPtr SumCoordPtrList (CoordPtrList l, CoordPtrSumFct f, CoordPtr a)
#else
CoordPtr SumCoordPtrList (l, f, a)
        CoordPtrList    l;
        CoordPtr ((*f) ());
        CoordPtr        a;
#endif
{
    while (l) {
        a = (f (a, l->head));
        l = l->tail;
    }
    return (a);
}/* SumCoordPtrList */
