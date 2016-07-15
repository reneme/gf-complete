set (PROJECT_UNIT_TEST_NAME "${PROJECT_NAME}_tests")

set (GFC_TESTING_SOURCES gf_unit.c)

add_executable (${PROJECT_UNIT_TEST_NAME} ${GFC_TESTING_SOURCES})
target_link_libraries(${PROJECT_UNIT_TEST_NAME} gf_complete)
target_include_directories(${PROJECT_UNIT_TEST_NAME} PUBLIC ${CMAKE_BINARY_DIR})

