#include <unistd.h>

int mysleep_ (int *seconds)
{
  return sleep ((unsigned int) *seconds);
}
