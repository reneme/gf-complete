set (PROJECT_UNIT_TEST_NAME "${PROJECT_NAME}_tests")

set (GFC_TESTING_SOURCES gf_unit.c)

add_executable (${PROJECT_UNIT_TEST_NAME} ${GFC_TESTING_SOURCES})
target_link_libraries(${PROJECT_UNIT_TEST_NAME} gf_complete)
target_include_directories(${PROJECT_UNIT_TEST_NAME} PUBLIC ${CMAKE_BINARY_DIR})
target_compile_options(gf_complete PUBLIC ${SIMD_COMPILER_FLAGS})

enable_testing()

add_test(NAME "w:8"
         COMMAND $<TARGET_FILE:${PROJECT_UNIT_TEST_NAME}> "8" "A" "-1" "-")
add_test(NAME "w:16"
         COMMAND $<TARGET_FILE:${PROJECT_UNIT_TEST_NAME}> "16" "A" "-1" "-")
add_test(NAME "w:32"
         COMMAND $<TARGET_FILE:${PROJECT_UNIT_TEST_NAME}> "32" "A" "-1" "-")
add_test(NAME "w:64"
         COMMAND $<TARGET_FILE:${PROJECT_UNIT_TEST_NAME}> "64" "A" "-1" "-")
add_test(NAME "w:128"
         COMMAND $<TARGET_FILE:${PROJECT_UNIT_TEST_NAME}> "128" "A" "-1" "-")

add_custom_target(check
                  COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure --build-config $<CONFIG>
                  DEPENDS ${PROJECT_UNIT_TEST_NAME})
