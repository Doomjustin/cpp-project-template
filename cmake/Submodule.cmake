find_package(Git REQUIRED)
include(CMakePrintHelpers)

cmake_print_variables(GIT_VERSION_STRING)

function(remove_submodule NAME)
    message(STATUS "Executing: git rm -f extern/${NAME}")
    execute_process(
        COMMAND ${GIT_EXECUTABLE} rm -f extern/${NAME}
        WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
        ERROR_QUIET
    )

    message(STATUS "Executing: rm -rf .git/modules/extern/${NAME}")
    execute_process(
        COMMAND rm -rf ./git/modules/extern/${NAME}
        WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
        ERROR_QUIET
    )

    message(STATUS "Executing: git config --remove-section submodule.extern/${NAME}")
    execute_process(
        COMMAND git config --remove-section submodule.extern/${NAME}
        WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
        ERROR_QUIET
    )
endfunction()

function(add_submodule NAME REP_URL)
    if (NOT EXISTS "${${PROJECT_NAME}_SOURCE_DIR}/extern/${NAME}/.git")
        message(STATUS "Executing: git submodule add ${REP_URL} extern/${NAME}")
        execute_process(
            COMMAND ${GIT_EXECUTABLE} submodule add ${REP_URL} extern/${NAME}
            WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
            RESULT_VARIABLE RESULT
        )

        if (NOT RESULT EQUAL "0")
            message(FATAL_ERROR "git submodule add ${REP_URL} extern/${NAME} failed with ${RESULT}")
            remove_submodule(${NAME})
        endif()
    endif ()

    if (ARGV2)
        message(STATUS "${NAME}: git checkout ${TAG}")
        # TODO: 支持切换tag，但是对submodule来说似乎不是很友好，还是指定branch可能会更好
#        execute_process(
#            COMMAND git checkout ${ARGV2}
#            WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}/extern/${NAME}
#            RESULT_VARIABLE RESULT
#        )
#
#        if (NOT RESULT EQUAL "0")
#            message(FATAL_ERROR "git checkout ${TAG} failed with ${RESULT}")
#        endif()
    endif ()

    add_subdirectory("${${PROJECT_NAME}_SOURCE_DIR}/extern/${NAME}")
endfunction()

function(update_submodule)
    message(STATUS "Executing: git submodule update --init --recursive")
    execute_process(COMMAND ${GIT_EXECUTABLE} submodule update --init --recursive
            WORKING_DIRECTORY ${${PROJECT_NAME}_SOURCE_DIR}
            RESULT_VARIABLE RESULT)
    if(NOT RESULT EQUAL "0")
        message(FATAL_ERROR "git submodule update --init --recursive failed with ${RESULT}")
    endif()
endfunction()
