#include <stdlib.h>

int main(void) {

  // the eax register
  int32_t EAX;
  // contends of the returned register
  int32_t supported;

  // Call cpuid with eax=0x00000001 and get ecx
  EAX = 0x00000001;
  __asm__("cpuid"
        :"=c"(supported)         // %ecx contains large feature flag set
        :"0"(EAX)                // call with 0x1
        :"%eax","%ebx","%edx");  // clobbered

  // check if pclmul is available
  return supported & (1<<1);
}
