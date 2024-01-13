cmake_minimum_required(VERSION 3.21)

project(cpp-project-template
	VERSION 1.0
	LANGUAGES C CXX
)

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)


if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    add_subdirectory(${PROJECT_SOURCE_DIR}/test)
endif()

add_subdirectory(${PROJECT_SOURCE_DIR}/examples)
add_subdirectory(${PROJECT_SOURCE_DIR}/src)
