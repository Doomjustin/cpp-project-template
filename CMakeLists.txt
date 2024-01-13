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

# 只在没有添加到submodule时才会执行git submodule add命令
add_submodule(fmt git@github.com:fmtlib/fmt.git)
add_submodule(spdlog git@github.com:gabime/spdlog.git)
add_submodule(nlohmann_json git@github.com:nlohmann/json.git)

# 当且仅当这是主项目时，构建测试
if (CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
	add_submodule(Catch2 git@github.com:catchorg/Catch2.git)

	# 开启CMake的测试框架
	# include(CTest)
	# enable_testing()
    add_subdirectory(test)
endif()

# 更新所有的第三方库: git submodule update
update_submodule()

add_subdirectory(examples)
add_subdirectory(src)
