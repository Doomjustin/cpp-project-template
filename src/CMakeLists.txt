set(TEMPLATE_INCLUDE_DIR ${PROJECT_SOURCE_DIR}/include)
set(TEMPLATE_INTERNAL_INCLUDE_DIR ${TEMPLATE_INCLUDE_DIR}/template)

configure_file(StaticInfo.h.in ${TEMPLATE_INTERNAL_INCLUDE_DIR}/StaticInfo.h)

# 这是个demo
add_library(template INTERFACE)

# 提供给用户的include目录
target_include_directories(template INTERFACE
    $<BUILD_INTERFACE:${TEMPLATE_INCLUDE_DIR}>
    $<INSTALL_INTERFACE:include/> # 允许使用相对路径，这里是相对于安装路径的相对路径
)

# 项目里私有的内部使用的include目录
#target_include_directories(template PRIVATE ${TEMPLATE_INTERNAL_INCLUDE_DIR})

# 开启编译器features和options
#target_link_libraries(template PUBLIC cpp-compiler-flags)

# 设置属性
#set_target_properties(template PROPERTIES
#        CXX_STANDARD 20
#        CXX_STANDARD_REQUIRED YES
#        CXX_EXTENSIONS OFF # 仅对实际编译的target有效，禁用compiler的拓展，使用pure C++ std
#        INTERPROCEDURAL_OPTIMIZATION_DEBUG FALSE
#        INTERPROCEDURAL_OPTIMIZATION_RELWITHDEBINFO FALSE
#        INTERPROCEDURAL_OPTIMIZATION_RELEASE TRUE
#        INTERPROCEDURAL_OPTIMIZATION_MINSIZEREL TRUE
#)

# 添加第三方库
#target_link_libraries(template PUBLIC
#    fmt::fmt
#    spdlog::spdlog
#    nlohmann_json::nlohmann_json
#)

# 如果是Debug构建，则添加对应的定义
#target_compile_definitions(template PUBLIC
#    $<$<CONFIG:Debug>:TEMPLATE_DEBUG> # 当有类似于DEBUG宏的东西时，很有用
#)
