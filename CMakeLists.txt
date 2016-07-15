cmake_minimum_required (VERSION 3.1.0 FATAL_ERROR)
set (PROJECT_NAME "gf_complete")
project (${PROJECT_NAME})

set (GFC_MAJOR_VERSION 1)
set (GFC_MINOR_VERSION 0)
set (GFC_PATCH_VERSION 0)

option (BUILD_TESTS "Build the ${PROJECT_NAME} test binaries" OFF)

set (GFC_VERSION_STRING
     "${GFC_MAJOR_VERSION}.${GFC_MINOR_VERSION}.${GFC_PATCH_VERSION}")

message (STATUS "Running CMake version ${CMAKE_VERSION}")
message (STATUS "Running CMake for ${PROJECT_NAME} ${DVAULT_VERSION_STRING}")

set (GFC_INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")

add_subdirectory (src)

if (BUILD_TESTS)
  add_subdirectory (test)
endif (BUILD_TESTS)

# NOTE(rmeusel): we are currently not compiling the 'tools' and 'examples',
#                since we are not interested in using the command line tools

configure_file("${CMAKE_SOURCE_DIR}/include/config.h.in"
               "${CMAKE_BINARY_DIR}/config.h")
