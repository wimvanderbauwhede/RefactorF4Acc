

#include "GPUVarsList.h"
#include "err.h"
#include "obstack.h"

typedef struct {
  Obstack space;
  void *baseptr;
} Dyn, *DynP;

static DynP GPUVarsListSpace = (DynP)0;

#if defined(__STDC__) || defined(__cplusplus)
void FinlGPUVarsList (void)
#else
void FinlGPUVarsList ()
#endif
{
    if (GPUVarsListSpace != (DynP)0)
    {  obstack_free(&(GPUVarsListSpace->space), GPUVarsListSpace->baseptr);
       GPUVarsListSpace->baseptr = obstack_alloc(&(GPUVarsListSpace->space), 0);
    }
}/* FinlGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList ConsGPUVarsList (GPUVars e, GPUVarsList l)
#else
GPUVarsList ConsGPUVarsList (e, l)
        GPUVars e;
        GPUVarsList     l;
#endif
{
    GPUVarsList h;

    if (GPUVarsListSpace == (DynP)0)
    {   GPUVarsListSpace = (DynP) malloc (sizeof(Dyn));
        if (GPUVarsListSpace == (DynP)0)
        {  message (DEADLY, "no space for GPUVarsList", 0, (POSITION*)0);
           exit (1);
        }
        obstack_init(&(GPUVarsListSpace->space));
        GPUVarsListSpace->baseptr =
                obstack_alloc(&(GPUVarsListSpace->space), 0);
    }

    h = (GPUVarsList)obstack_alloc(&(GPUVarsListSpace->space),
                                  sizeof (struct _GPUVarsLE));
    h->head = e;
    h->tail= l;
    return (h);
}/* ConsGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVars HeadGPUVarsList (GPUVarsList l)
#else
GPUVars HeadGPUVarsList (l)
        GPUVarsList     l;
#endif
{
    if (l == NULLGPUVarsList)
    {
        message (DEADLY, "HeadGPUVarsList: empty list", 0, (POSITION*)0);
        /* return ((GPUVars)0); */
    } /* if */
    return (l->head);
}/* HeadGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList TailGPUVarsList (GPUVarsList l)
#else
GPUVarsList TailGPUVarsList (l)
        GPUVarsList     l;
#endif
{
    return ((l==NULLGPUVarsList) ? NULLGPUVarsList : l->tail);
}/* TailGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
int LengthGPUVarsList (GPUVarsList l)
#else
int LengthGPUVarsList (l)
        GPUVarsList     l;
#endif
{
    int res = 0;

    for (; l; l = l->tail)
        res++;
    return (res);
}/* LengthGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVars IthElemGPUVarsList (GPUVarsList l, int i)
#else
GPUVars IthElemGPUVarsList (l, i)
        GPUVarsList     l;
        int     i;
#endif
{
    while ((i>1) && l)
    {
        i--;
        l = l->tail;
    }

    if ((i<=0) || (l==NULLGPUVarsList))
        message (DEADLY, "IthElemGPUVarsList: no such element",
                 0, (POSITION*)0);
    return (l->head);
}/* IthGPUVarsList */


#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList CopyGPUVarsList (GPUVarsList l, GPUVarsMapFct cp)
#else
GPUVarsList CopyGPUVarsList (l, cp)
        GPUVarsList l;
        GPUVarsMapFct   cp;
#endif
{
    GPUVarsList NewList=NULLGPUVarsList, *addr = &NewList;

    while (l)
    {
        (*addr) = ConsGPUVarsList (cp (l->head), NULLGPUVarsList);
        addr = &((*addr)->tail);
        l = l->tail;
    }
    return (NewList);
}/* CopyGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList AppGPUVarsList (GPUVarsList l1, GPUVarsList l2)
#else
GPUVarsList AppGPUVarsList (l1, l2)
        GPUVarsList     l1, l2;
#endif
{
    GPUVarsList NewList;
    GPUVarsList *addr = &NewList;

    if (!l1) return (l2);
    if (!l2) return (l1);

    while (l1) {
        (*addr) = ConsGPUVarsList (l1->head, NULLGPUVarsList);
        addr = &((*addr)->tail);
        l1 = l1->tail;
    }
    (*addr) = l2;

    return (NewList);
}/* AppGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList AppElGPUVarsList (GPUVarsList l, GPUVars e)
#else
GPUVarsList AppElGPUVarsList (l, e)
        GPUVarsList     l;
        GPUVars e;
#endif
{
    GPUVarsList res = l;
    if (!l)
        return (ConsGPUVarsList (e, NULLGPUVarsList));

    while (l->tail)
        l = l->tail;
    l->tail = ConsGPUVarsList (e, NULLGPUVarsList);

    return (res);
} /* AppElGPUVarsList */


#if defined(__STDC__) || defined(__cplusplus)
void InsertAfterGPUVarsList (GPUVarsList l, GPUVars e)
#else
void InsertAfterGPUVarsList (l, e)
        GPUVarsList     l;
        GPUVars e;
#endif
{
    if (!l)
        message (DEADLY, "InsertAfterGPUVarsList: null list", 0, (POSITION*)0);
    else
        l->tail = ConsGPUVarsList (e, l->tail);
}/* InsertAfterGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList OrderedInsertGPUVarsList (GPUVarsList l, GPUVars e, GPUVarsCmpFctType fcmp)
#else
GPUVarsList OrderedInsertGPUVarsList (l, e, fcmp)
        GPUVarsList     l;
        GPUVars e;
        GPUVarsCmpFctType fcmp;
#endif
{
    GPUVarsList p;
    if (!l)
        return (ConsGPUVarsList (e, NULLGPUVarsList));
    if (fcmp (e, l->head) <= 0)
        return (ConsGPUVarsList (e, l));
    p = l;
    while (p->tail && (fcmp (e, p->tail->head) > 0))
        p = p->tail;
    p->tail = ConsGPUVarsList (e, p->tail);
    return (l);
}/* OrderedInsertGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsListPtr RefEndConsGPUVarsList (GPUVarsListPtr addr, GPUVars e)
#else
GPUVarsListPtr RefEndConsGPUVarsList (addr, e)
        GPUVarsListPtr  addr;
        GPUVars         e;
#endif
{
    if (!addr)
    {
        message (DEADLY, "RefEndConsGPUVarsList: no GPUVarsList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    (*addr) = ConsGPUVarsList (e, NULLGPUVarsList);
    return (&((*addr)->tail));
}/* RefEndConsGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsListPtr RefEndAppGPUVarsList (GPUVarsListPtr addr, GPUVarsList l)
#else
GPUVarsListPtr RefEndAppGPUVarsList (addr, l)
        GPUVarsListPtr  addr;
        GPUVarsList             l;
#endif
{
    if (!addr) {
        message (DEADLY, "RefEndAppGPUVarsList: no GPUVarsList ref",
                 0, (POSITION*)0);
        return (addr);
    }
    if (!l)
        return addr;

    (*addr) = l;

    while (l->tail)
        l = l->tail;
    return (&(l->tail));
}/* RefEndAppGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
int ElemInGPUVarsList (GPUVars e, GPUVarsList l, GPUVarsCmpFctType fcmp)
#else
int ElemInGPUVarsList (e, l, fcmp)
        GPUVars e;
        GPUVarsList     l;
        GPUVarsCmpFctType       fcmp;
#endif
{
    while (l != NULLGPUVarsList) {
        if (fcmp (e, l->head) == 0)
            return (1);
        l = l->tail;
    }
    return (0);
}/* ElemInGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList AddToSetGPUVarsList (GPUVars e, GPUVarsList l, GPUVarsCmpFctType fcmp)
#else
GPUVarsList AddToSetGPUVarsList (e, l, fcmp)
        GPUVars e;
        GPUVarsList     l;
        GPUVarsCmpFctType       fcmp;
#endif
{
    if (ElemInGPUVarsList (e, l, fcmp))
        return (l);
    else
        return (ConsGPUVarsList (e, l));
}/* AddToSetGPUVarsList */


#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList AddToOrderedSetGPUVarsList (GPUVars e, GPUVarsList l, GPUVarsCmpFctType fcmp)
#else
GPUVarsList AddToOrderedSetGPUVarsList (e, l, fcmp)
        GPUVars  e;
        GPUVarsList      l;
        GPUVarsCmpFctType fcmp;
#endif
{   int test;
    GPUVarsList  p;
    if (!l)
        return (ConsGPUVarsList (e, NULLGPUVarsList));
    if ((test = fcmp (e, l->head)) < 0)
        return (ConsGPUVarsList (e, l));
    if (test == 0) return l;
    p = l;
    while (p->tail && ((test = fcmp (e, p->tail->head)) > 0))
        p = p->tail;
    if (test) p->tail = ConsGPUVarsList (e, p->tail);
    return (l);
}/* AddToOrderedSetGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVarsList MapGPUVarsList (GPUVarsList l, GPUVarsMapFct f)
#else
GPUVarsList MapGPUVarsList (l, f)
        GPUVarsList     l;
        GPUVarsMapFct f;
#endif
{
    GPUVarsList NewList = NULLGPUVarsList;
    GPUVarsList last = NULLGPUVarsList;

    while (l)
    {
        if (!NewList) {
            NewList = ConsGPUVarsList ((f (l->head)), NULLGPUVarsList);
            last = NewList;
        }
        else
        {
            last->tail = ConsGPUVarsList ((f (l->head)), NULLGPUVarsList);
            last = last->tail;
        }
        l = l->tail;
    }
    return (NewList);
}/* MapGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
int CompGPUVarsList (GPUVarsList l1, GPUVarsList l2, GPUVarsCmpFctType fcmp)
#else
int CompGPUVarsList (l1, l2, fcmp)
        GPUVarsList     l1, l2;
        GPUVarsCmpFctType fcmp;
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
}/* CompGPUVarsList */

#if defined(__STDC__) || defined(__cplusplus)
GPUVars SumGPUVarsList (GPUVarsList l, GPUVarsSumFct f, GPUVars a)
#else
GPUVars SumGPUVarsList (l, f, a)
        GPUVarsList     l;
        GPUVars ((*f) ());
        GPUVars a;
#endif
{
    while (l) {
        a = (f (a, l->head));
        l = l->tail;
    }
    return (a);
}/* SumGPUVarsList */
