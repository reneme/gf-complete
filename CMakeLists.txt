cmake_minimum_required (VERSION 3.1.0 FATAL_ERROR)
set (PROJECT_NAME "gf_complete")
project (${PROJECT_NAME})

set (GFC_MAJOR_VERSION 1)
set (GFC_MINOR_VERSION 0)
set (GFC_PATCH_VERSION 0)

set (CMAKE_MODULE_PATH  "${CMAKE_SOURCE_DIR}/cmake/modules")

option (BUILD_TESTS "Build the ${PROJECT_NAME} test binaries" OFF)
option (WITH_SSE    "Enables SSEx SIMD extensions"            ON)
option (WITH_AVX    "Enables AVXx SIMD extensions"            OFF)

set (GFC_VERSION_STRING
     "${GFC_MAJOR_VERSION}.${GFC_MINOR_VERSION}.${GFC_PATCH_VERSION}")

message (STATUS "Running CMake version ${CMAKE_VERSION}")
message (STATUS "Running CMake for ${PROJECT_NAME} ${DVAULT_VERSION_STRING}")

# gather information about CPU's SIMD features
include (CheckCPUID)
checkCPUID()

if (WITH_SSE)
  # we assume MMX, SEE and SSE2 support for all target platforms
  message (STATUS "Enabling MMX support")
  set (HAVE_MMX "yes")
  message (STATUS "Enabling SSE support")
  set (HAVE_SSE "yes")
  message (STATUS "Enabling SSE 2 support")
  set (HAVE_SSE2 "yes")

  if (SUPPORT_sse3)
    message (STATUS "Enabling SSE 3 support")
    set (HAVE_SSE3 "yes")
  endif (SUPPORT_sse3)
  if (SUPPORT_ssse3)
    message (STATUS "Enabling SSSE 3 support")
    set (HAVE_SSSE3 "yes")
  endif (SUPPORT_ssse3)
  if (SUPPORT_sse41)
    message (STATUS "Enabling SSE 4.1 support")
    set (HAVE_SSE4_1 "yes")
  endif (SUPPORT_sse41)
  if (SUPPORT_sse42)
    message (STATUS "Enabling SSE 4.2 support")
    set (HAVE_SSE4_2 "yes")
  endif (SUPPORT_sse42)
else (WITH_SSE)
  message (STATUS "Disabling SSE instruction set altogether")
endif (WITH_SSE)

if (WITH_AVX)
  if (SUPPORT_avx1)
    message (STATUS "Enabling AVX 1 support")
    set (HAVE_AVX "yes")
  endif (SUPPORT_avx1)
  if (SUPPORT_avx2)
    message (STATUS "Enabling AVX 2 support")
    set (HAVE_AVX2 "yes")
  endif (SUPPORT_avx2)
else (WITH_AVX)
  message (STATUS "Disabling AVX instruction set altogether")
endif (WITH_AVX)

# gather information about memory alignment functions
include (CheckFunctionExists)
check_function_exists (memalign       HAVE_MEMALIGN)
check_function_exists (posix_memalign HAVE_POSIX_MEMALIGN)

set (GFC_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")

configure_file("${CMAKE_SOURCE_DIR}/include/config.h.cmake.in"
               "${CMAKE_BINARY_DIR}/config.h")

add_subdirectory (src)

if (BUILD_TESTS)
  add_subdirectory (test)
endif (BUILD_TESTS)

# NOTE(rmeusel): we are currently not compiling the 'tools' and 'examples',
#                since we are not interested in using the command line tools

