#include "cpuid.h"

int main(void) {
  CPUID cpuid(0x00000001);
  return cpuid.ECX() & (1<<1);
}
