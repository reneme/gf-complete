
# NOTE(rmeusel): leaving out 'neon' sub-directory as NEON is an ARM SIMD extension
#                that we do not need for the moment. As soon as this gets deployed
#                to mobile platforms we might think about it again.

set (GFC_LIBRARY_SOURCES
        gf.c
        gf_general.c
        gf_method.c
        gf_rand.c
        gf_w128.c
        gf_w16.c
        gf_w32.c
        gf_w4.c
        gf_w64.c
        gf_w8.c
        gf_wgen.c
)

set (GFC_PUBLIC_HEADERS
        ${GFC_INCLUDE_DIR}/gf_complete.h
        ${GFC_INCLUDE_DIR}/gf_general.h
        ${GFC_INCLUDE_DIR}/gf_method.h
        ${GFC_INCLUDE_DIR}/gf_rand.h)

add_library(gf_complete ${GFC_LIBRARY_SOURCES})
target_include_directories(gf_complete PUBLIC ${GFC_INCLUDE_DIR})
target_compile_options(gf_complete PUBLIC ${SIMD_COMPILER_FLAGS})

install (TARGETS             gf_complete
         ARCHIVE DESTINATION lib)

install (FILES       ${GFC_PUBLIC_HEADERS}
         DESTINATION include)
