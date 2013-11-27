

#include "BoundsList.h"
#include "err.h"
#include "obstack.h"

typedef struct {
  Obstack space;
  void *baseptr;
} Dyn, *DynP;

static DynP BoundsListSpace = (DynP)0;

#if defined(__STDC__) || defined(__cplusplus)
void FinlBoundsList (void)
#else
void FinlBoundsList ()
#endif
{
    if (BoundsListSpace != (DynP)0)
    {  obstack_free(&(BoundsListSpace->space), BoundsListSpace->baseptr);
       BoundsListSpace->baseptr = obstack_alloc(&(BoundsListSpace->space), 0);
    }
}/* FinlBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsList ConsBoundsList (Bounds e, BoundsList l)
#else
BoundsList ConsBoundsList (e, l)
        Bounds  e;
        BoundsList      l;
#endif
{
    BoundsList  h;

    if (BoundsListSpace == (DynP)0)
    {   BoundsListSpace = (DynP) malloc (sizeof(Dyn));
        if (BoundsListSpace == (DynP)0)
        {  message (DEADLY, "no space for BoundsList", 0, (POSITION*)0);
           exit (1);
        }
        obstack_init(&(BoundsListSpace->space));
        BoundsListSpace->baseptr =
                obstack_alloc(&(BoundsListSpace->space), 0);
    }

    h = (BoundsList)obstack_alloc(&(BoundsListSpace->space),
                                  sizeof (struct _BoundsLE));
    h->head = e;
    h->tail= l;
    return (h);
}/* ConsBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
Bounds HeadBoundsList (BoundsList l)
#else
Bounds HeadBoundsList (l)
        BoundsList      l;
#endif
{
    if (l == NULLBoundsList)
    {
        message (DEADLY, "HeadBoundsList: empty list", 0, (POSITION*)0);
        /* return ((Bounds)0); */
    } /* if */
    return (l->head);
}/* HeadBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsList TailBoundsList (BoundsList l)
#else
BoundsList TailBoundsList (l)
        BoundsList      l;
#endif
{
    return ((l==NULLBoundsList) ? NULLBoundsList : l->tail);
}/* TailBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
int LengthBoundsList (BoundsList l)
#else
int LengthBoundsList (l)
        BoundsList      l;
#endif
{
    int res = 0;

    for (; l; l = l->tail)
        res++;
    return (res);
}/* LengthBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
Bounds IthElemBoundsList (BoundsList l, int i)
#else
Bounds IthElemBoundsList (l, i)
        BoundsList      l;
        int     i;
#endif
{
    while ((i>1) && l)
    {
        i--;
        l = l->tail;
    }

    if ((i<=0) || (l==NULLBoundsList))
        message (DEADLY, "IthElemBoundsList: no such element",
                 0, (POSITION*)0);
    return (l->head);
}/* IthBoundsList */


#if defined(__STDC__) || defined(__cplusplus)
BoundsList CopyBoundsList (BoundsList l, BoundsMapFct cp)
#else
BoundsList CopyBoundsList (l, cp)
        BoundsList l;
        BoundsMapFct    cp;
#endif
{
    BoundsList NewList=NULLBoundsList, *addr = &NewList;

    while (l)
    {
        (*addr) = ConsBoundsList (cp (l->head), NULLBoundsList);
        addr = &((*addr)->tail);
        l = l->tail;
    }
    return (NewList);
}/* CopyBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsList AppBoundsList (BoundsList l1, BoundsList l2)
#else
BoundsList AppBoundsList (l1, l2)
        BoundsList      l1, l2;
#endif
{
    BoundsList  NewList;
    BoundsList  *addr = &NewList;

    if (!l1) return (l2);
    if (!l2) return (l1);

    while (l1) {
        (*addr) = ConsBoundsList (l1->head, NULLBoundsList);
        addr = &((*addr)->tail);
        l1 = l1->tail;
    }
    (*addr) = l2;

    return (NewList);
}/* AppBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsList AppElBoundsList (BoundsList l, Bounds e)
#else
BoundsList AppElBoundsList (l, e)
        BoundsList      l;
        Bounds  e;
#endif
{
    BoundsList  res = l;
    if (!l)
        return (ConsBoundsList (e, NULLBoundsList));

    while (l->tail)
        l = l->tail;
    l->tail = ConsBoundsList (e, NULLBoundsList);

    return (res);
} /* AppElBoundsList */


#if defined(__STDC__) || defined(__cplusplus)
void InsertAfterBoundsList (BoundsList l, Bounds e)
#else
void InsertAfterBoundsList (l, e)
        BoundsList      l;
        Bounds  e;
#endif
{
    if (!l)
        message (DEADLY, "InsertAfterBoundsList: null list", 0, (POSITION*)0);
    else
        l->tail = ConsBoundsList (e, l->tail);
}/* InsertAfterBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsList OrderedInsertBoundsList (BoundsList l, Bounds e, BoundsCmpFctType fcmp)
#else
BoundsList OrderedInsertBoundsList (l, e, fcmp)
        BoundsList      l;
        Bounds  e;
        BoundsCmpFctType fcmp;
#endif
{
    BoundsList  p;
    if (!l)
        return (ConsBoundsList (e, NULLBoundsList));
    if (fcmp (e, l->head) <= 0)
        return (ConsBoundsList (e, l));
    p = l;
    while (p->tail && (fcmp (e, p->tail->head) > 0))
        p = p->tail;
    p->tail = ConsBoundsList (e, p->tail);
    return (l);
}/* OrderedInsertBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsListPtr RefEndConsBoundsList (BoundsListPtr addr, Bounds e)
#else
BoundsListPtr RefEndConsBoundsList (addr, e)
        BoundsListPtr   addr;
        Bounds          e;
#endif
{
    if (!addr)
    {
        message (DEADLY, "RefEndConsBoundsList: no BoundsList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    (*addr) = ConsBoundsList (e, NULLBoundsList);
    return (&((*addr)->tail));
}/* RefEndConsBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsListPtr RefEndAppBoundsList (BoundsListPtr addr, BoundsList l)
#else
BoundsListPtr RefEndAppBoundsList (addr, l)
        BoundsListPtr   addr;
        BoundsList              l;
#endif
{
    if (!addr) {
        message (DEADLY, "RefEndAppBoundsList: no BoundsList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    if (!l)
        return addr;

    (*addr) = l;

    while (l->tail)
        l = l->tail;
    return (&(l->tail));
}/* RefEndAppBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
int ElemInBoundsList (Bounds e, BoundsList l, BoundsCmpFctType fcmp)
#else
int ElemInBoundsList (e, l, fcmp)
        Bounds  e;
        BoundsList      l;
        BoundsCmpFctType        fcmp;
#endif
{
    while (l != NULLBoundsList) {
        if (fcmp (e, l->head) == 0)
            return (1);
        l = l->tail;
    }
    return (0);
}/* ElemInBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsList AddToSetBoundsList (Bounds e, BoundsList l, BoundsCmpFctType fcmp)
#else
BoundsList AddToSetBoundsList (e, l, fcmp)
        Bounds  e;
        BoundsList      l;
        BoundsCmpFctType        fcmp;
#endif
{
    if (ElemInBoundsList (e, l, fcmp))
        return (l);
    else
        return (ConsBoundsList (e, l));
}/* AddToSetBoundsList */


#if defined(__STDC__) || defined(__cplusplus)
BoundsList AddToOrderedSetBoundsList (Bounds e, BoundsList l, BoundsCmpFctType fcmp)
#else
BoundsList AddToOrderedSetBoundsList (e, l, fcmp)
        Bounds  e;
        BoundsList      l;
        BoundsCmpFctType fcmp;
#endif
{   int test;
    BoundsList  p;
    if (!l)
        return (ConsBoundsList (e, NULLBoundsList));
    if ((test = fcmp (e, l->head)) < 0)
        return (ConsBoundsList (e, l));
    if (test == 0) return l;
    p = l;
    while (p->tail && ((test = fcmp (e, p->tail->head)) > 0))
        p = p->tail;
    if (test) p->tail = ConsBoundsList (e, p->tail);
    return (l);
}/* AddToOrderedSetBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
BoundsList MapBoundsList (BoundsList l, BoundsMapFct f)
#else
BoundsList MapBoundsList (l, f)
        BoundsList      l;
        BoundsMapFct f;
#endif
{
    BoundsList NewList = NULLBoundsList;
    BoundsList last = NULLBoundsList;

    while (l)
    {
        if (!NewList) {
            NewList = ConsBoundsList ((f (l->head)), NULLBoundsList);
            last = NewList;
        }
        else
        {
            last->tail = ConsBoundsList ((f (l->head)), NULLBoundsList);
            last = last->tail;
        }
        l = l->tail;
    }
    return (NewList);
}/* MapBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
int CompBoundsList (BoundsList l1, BoundsList l2, BoundsCmpFctType fcmp)
#else
int CompBoundsList (l1, l2, fcmp)
        BoundsList      l1, l2;
        BoundsCmpFctType fcmp;
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
}/* CompBoundsList */

#if defined(__STDC__) || defined(__cplusplus)
Bounds SumBoundsList (BoundsList l, BoundsSumFct f, Bounds a)
#else
Bounds SumBoundsList (l, f, a)
        BoundsList      l;
        Bounds ((*f) ());
        Bounds  a;
#endif
{
    while (l) {
        a = (f (a, l->head));
        l = l->tail;
    }
    return (a);
}/* SumBoundsList */
