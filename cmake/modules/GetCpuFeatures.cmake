# This module detects the supported CPU features by the machine on which
# CMake is running. SUPPORTS_${FEATURE} is set to TRUE for the
# following features MMX, SSE, SSE2, SSE3, PCLMUL, SSSE3, SSE4,
# SSE41, SSE42, AES, XSAVE, AVX and AVX2. The variables stay undefined
# if the feature is not available
#
# Also it sets RUNS_ON_HYPERVISOR to TRUE if a hypervisor is detected.
#
#   Written by René Meusel in 2016
#

# TODO(rmeusel): find a dynamic way to find cpuid.c
try_run(CPUID_RETURN_CODE CPUID_COMPILED
        ${CMAKE_BINARY_DIR}
        ${CMAKE_SOURCE_DIR}/cmake/modules/cpuid.c
        RUN_OUTPUT_VARIABLE CPUID_OUTPUT_STRING)

if(NOT ${CPUID_COMPILED})
  message(FATAL_ERROR "compilation of CPUID helper binary failed")
endif(NOT ${CPUID_COMPILED})

#set(CPUID_CACHED TRUE CACHE INTERNAL "Whether CPUID has run")

STRING(REGEX REPLACE "\r" ""
       CPUID_FEATURES "${CPUID_FEATURES}")
STRING(REGEX REPLACE "\n" ";"
       CPUID_FEATURES "${CPUID_OUTPUT_STRING}")

foreach(CPUID_FEATURE ${CPUID_FEATURES})
    if(CPUID_FEATURE STREQUAL "HYPERVISOR")
        set(RUNS_ON_HYPERVISOR TRUE)
    else(CPUID_FEATURE STREQUAL "HYPERVISOR")
        set (SUPPORTS_${CPUID_FEATURE} TRUE)
    endif(CPUID_FEATURE STREQUAL "HYPERVISOR")
endforeach(CPUID_FEATURE ${CPUID_FEATURES})
