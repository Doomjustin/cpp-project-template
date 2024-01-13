cmake_minimum_required(VERSION 3.21)

project(cpp-project-template
	VERSION 1.0
	LANGUAGES C CXX
)

if (NOT CMAKE_BUILD_TYPE)
	set(CMAKE_BUILD_TYPE Debug)
	# Release
endif ()

list(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/cmake)
include(Submodule)
include(CppStandard)

# 更新所有的第三方库: git submodule update
update_submodule()

# 只在没有添加到submodule时才会执行git submodule add命令
add_subdirectory(extern/fmt)
add_subdirectory(extern/spdlog)
add_subdirectory(extern/nlohmann_json)

# 当且仅当这是主项目时，构建测试
if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
	add_subdirectory(extern/Catch2)
    add_subdirectory(test)
endif()

add_subdirectory(examples)
add_subdirectory(src)
