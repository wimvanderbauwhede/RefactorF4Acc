
#include "err.h"
#include "IntSet.h"

#define noelem(el) ((el)<0 || (el>MaxElemIS))

static POSITION coord = {0, 0};

#if defined(__STDC__) || defined(__cplusplus)
IntSet SingleIS (int el)
#else
IntSet SingleIS (el) int el;
#endif
{
if (noelem(el)) 
        message (DEADLY,"IntSet: SingleIS got wrong elem", el, &coord);
return ((IntSet)(0x1 << el));
}/*SingleIS*/

#if defined(__STDC__) || defined(__cplusplus)
IntSet AddElIS (int el, IntSet s)
#else
IntSet AddElIS (el, s) int el; IntSet s;
#endif
{
if (noelem(el)) 
        message (DEADLY,"IntSet: AddElIS got wrong elem", el, &coord);
return (UniteIS (SingleIS (el), s));
}/*AddElIS*/

#if defined(__STDC__) || defined(__cplusplus)
int InIS (int el, IntSet s)
#else
int InIS (el, s) int el; IntSet s;
#endif
{
if (noelem(el)) 
        message (DEADLY,"IntSet: InIS got wrong elem", el, &coord);
return ( ( ((IntSet)(0x1 << el)) & s) != NULLIS);
}/*InIS*/

#if defined(__STDC__) || defined(__cplusplus)
int InclIS (IntSet s1, IntSet s2)
#else
int InclIS (s1, s2) IntSet s1, s2;
#endif
{
return (InterIS (s1,s2) == s1);
}/*InclIS*/

#if defined(__STDC__) || defined(__cplusplus)
int CardIS (IntSet s)
#else
int CardIS (s) IntSet s;
#endif
{       int     card = 0;
while (s != NULLIS) {
        card += (s & (IntSet)0x1);
        s = (IntSet)s >> 1;
}
return (card);
}/*CardIS*/
