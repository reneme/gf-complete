/**
 * Copyright (C) 2013 - present by OpenGamma Inc. and the OpenGamma group of companies
 *
 * Taken (and adapted) on 15th of July 2016 from here:
 *    https://github.com/OpenGamma/OG-Lapack/blob/master/CMAKE/cmcpuid.c
 *
 * Please see distribution for license.
 */

#include <stdlib.h>
#include <stdio.h>

#include "cpuid.h"

/**
 * The supported instruction set on this machine for use in other functions.
 *
 * These must match up with the numbers used in MultiLib.cmake.
 */
typedef enum instructions_available_e
{
  supports_STANDARD = 1,
  supports_SSE3     = 2,
  supports_SSSE3    = 3,
  supports_SSE41    = 4,
  supports_SSE42    = 5,
  supports_AVX1     = 6,
  supports_AVX2     = 7
} instructions_available;


instructions_available getSupportedInstructionSet() {

  // probes of cpuid with %eax=0000_0001h
  enum instructions_available_eax0000_0001h_e
  {
    probe01_SSE_3   = 1<<0,
    probe01_SSSE_3  = 1<<9,
    probe01_SSE_4_1 = 1<<19,
    probe01_SSE_4_2 = 1<<20,
    probe01_AVX1    = 1<<28
  };

  // probes of cpuid with %eax=0000_0007h
  enum instructions_available_eax0000_0007h_e
  {
    probe07_AVX2     = 1<<5
  };

  CPUID cpuid_EAX1(0x00000001);
  CPUID cpuid_EAX7(0x00000007);

  if(cpuid_EAX1.ECX() & probe01_AVX1) // we have at least AVX1
  {
    if(cpuid_EAX7.EBX() & probe07_AVX2) // we have at least AVX2
    {
      printf("AVX2 SUPPORTED\n");
      return supports_AVX2;
    }

    printf("AVX1 SUPPORTED\n");
    return supports_AVX1;
  }
  else if(cpuid_EAX1.ECX() & probe01_SSE_4_2) // we have at least SSE4.2
  {
    printf("SSE4.2 SUPPORTED\n");
    return supports_SSE42;
  }
  else if(cpuid_EAX1.ECX() & probe01_SSE_4_1) // we have at least SSE4.1
  {
    printf("SSE4.1 SUPPORTED\n");
    return supports_SSE41;
  }
  else if(cpuid_EAX1.ECX() & probe01_SSSE_3)
  {
    printf("SSSE3 SUPPORTED");
    return supports_SSSE3;
  }
  else if(cpuid_EAX1.ECX() & probe01_SSE_3)
  {
    printf("SSE3 SUPPORTED");
    return supports_SSE3;
  }
  else // we have nothing specifically useful!
  {
    printf("STANDARD SUPPORTED\n");
    return supports_STANDARD;
  }
}


int main(void)
{
  instructions_available ia;
  ia = getSupportedInstructionSet();

  switch(ia)
  {
    case supports_AVX2:
      printf("AVX2\n");
      break;
    case supports_AVX1:
      printf("AVX1\n");
      break;
    case supports_SSE42:
      printf("SSE42\n");
      break;
    case supports_SSE41:
      printf("SSE41\n");
      break;
    case supports_SSSE3:
      printf("SSSE3\n");
      break;
    case supports_SSE3:
      printf("SSE3\n");
      break;
    case supports_STANDARD:
      printf("STANDARD\n");
      break;
    default:
      printf("Failed to find supported instruction set, this is an error!\n");
      exit(-1);
  }
  return ia;
}
