// cross-platform CPUID wrapper found on StackOverflow:
//    http://stackoverflow.com/a/4823889/4842497

#ifndef CPUID_H
#define CPUID_H

#ifdef _WIN32
#include <limits.h>
#include <intrin.h>
typedef unsigned __int32  uint32_t;
#else
#include <stdint.h>
#endif

#include <stdio.h>

typedef struct _CPUID {
    uint32_t eax;
    uint32_t ebx;
    uint32_t ecx;
    uint32_t edx;
} CPUID;

CPUID get_cpuid(const int eax) {
    uint32_t regs[4];

    #ifdef _WIN32
        __cpuid((int *)regs, eax);
    #else
        asm volatile
          ("cpuid" :
                "=a" (regs[0]),
                "=b" (regs[1]),
                "=c" (regs[2]),
                "=d" (regs[3])
           : "0" (eax));
        // ECX is set to zero for CPUID function 4
    #endif

    CPUID cpuid;
    cpuid.eax = regs[0];
    cpuid.ebx = regs[1];
    cpuid.ecx = regs[2];
    cpuid.edx = regs[3];
    return cpuid;
}

void check(const char *name, const int has_feature) {
    if (has_feature != 0) {
        printf("%s\n", name);
    }
}

int main(void) {
    CPUID eax1 = get_cpuid(0x00000001);
    CPUID eax7 = get_cpuid(0x00000007);

    check("MMX",        eax1.edx & (1 << 23));
    check("SSE",        eax1.edx & (1 << 25));
    check("SSE2",       eax1.edx & (1 << 26));
    check("SSE3",       eax1.ecx & (1 <<  0));
    check("PCLMUL",     eax1.ecx & (1 <<  1));
    check("SSSE3",      eax1.ecx & (1 <<  9));
    check("SSE4",      (eax1.ecx & (1 << 19)) | (eax1.ecx & (1 << 20)));
    check("SSE41",      eax1.ecx & (1 << 19));
    check("SSE42",      eax1.ecx & (1 << 20));
    check("AES",        eax1.ecx & (1 << 25));
    check("XSAVE",    ((eax1.ecx & (1 << 26)) != 0) &&
                      ((eax1.ecx & (1 << 27)) != 0));
    check("AVX",        eax1.ecx & (1 << 28));
    check("AVX2",       eax7.ebx & (1 <<  5));
    check("HYPERVISOR", eax1.ecx & (1 << 31));
}

#endif // CPUID_H
