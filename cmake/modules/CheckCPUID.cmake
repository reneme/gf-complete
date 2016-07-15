#
# Copyright (C) 2013 - present by OpenGamma Inc. and the OpenGamma group of companies
#
# Please see distribution for license.
#
# Taken (and adapted) on 15th of July 2016 from here:
#    https://github.com/OpenGamma/OG-Lapack/blob/master/CMAKE/CheckCPUID.cmake
#

# Inclusion of this module sets the targets supported by the machine on which
# CMake is running. SUPPORT_${TARGET} is set to TRUE or FALSE for each target in
# dbg, std, sse41, sse42, avx1 and avx2. std and sbg require no special CPU
# support and are always set.

# this module caches the fact it has run by setting CPUID_CACHED = TRUE

macro( CheckCPUID )
  if(NOT DEFINED CPUID_CACHED)
    try_run(CPUID_FLAG CPUID_COMPILE_RESULT
            ${CMAKE_BINARY_DIR}
            ${CMAKE_SOURCE_DIR}/cmake/cmcpuid.c)

    if(NOT ${CPUID_COMPILE_RESULT})
      message(FATAL_ERROR "Failed to compile CPUID check binary")
    endif()

    set(CPUID_CACHED TRUE CACHE INTERNAL "Whether CPUID has run")

    set(SUPPORT_dbg TRUE CACHE INTERNAL "Support for debug build")
    set(SUPPORT_std TRUE CACHE INTERNAL "Support for standard build")

    # NOTE: These flags must match the numbers in cmcpuid.c
    if(${CPUID_FLAG} GREATER 1)
      set(SUPPORT_sse3 TRUE CACHE INTERNAL "Local CPU support for SSE3")
      message(STATUS "CPU supports SSE3")
    else()
      message(STATUS "CPU does not support SSE3")
    endif()
    if(${CPUID_FLAG} GREATER 2)
      set(SUPPORT_sse41 TRUE CACHE INTERNAL "Local CPU support for SSE4.1")
      message(STATUS "CPU supports SSE4.1")
    else()
      message(STATUS "CPU does not support SSE4.1")
    endif()
    if(${CPUID_FLAG} GREATER 3)
      set(SUPPORT_sse42 TRUE CACHE INTERNAL "Local CPU support for SSE4.2")
      message(STATUS "CPU supports SSE4.2")
    else()
      message(STATUS "CPU does not support SSE4.2")
    endif()
    if(${CPUID_FLAG} GREATER 4)
      set(SUPPORT_avx1 TRUE CACHE INTERNAL "Local CPU support for AVX1")
      message(STATUS "CPU supports AVX1")
    else()
      message(STATUS "CPU does not support AVX1")
    endif()
    if(${CPUID_FLAG} GREATER 5)
      set(SUPPORT_avx2 TRUE CACHE INTERNAL "Local CPU support for AVX2")
      message(STATUS "CPU supports AVX2")
    else()
      message(STATUS "CPU does not support AVX2")
    endif()
  endif()

  set(BITS32 TRUE)
  set(BITS64 FALSE)
  if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(BITS32 FALSE)
    set(BITS64 TRUE)
  endif()
endmacro()