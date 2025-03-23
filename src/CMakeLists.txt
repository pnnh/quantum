cmake_minimum_required(VERSION 3.28...3.31)

project(Quantum VERSION 0.1.0 LANGUAGES C CXX)

if (APPLE)
    enable_language(OBJCXX Swift)
endif ()

# 设置语言标准
if (WIN32)
    set(CMAKE_C_STANDARD 17)
else ()
    set(CMAKE_C_STANDARD 23)
endif ()
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 23)

# 设置开启显示详细的构建过程
set(CMAKE_VERBOSE_MAKEFILE ON)

include_directories(${CMAKE_CURRENT_SOURCE_DIR})
include_directories(${PROJECT_BINARY_DIR})

# 避免警告
if (POLICY CMP0012)
    cmake_policy(SET CMP0012 NEW)
endif ()
# 针对CMake 3.30版本Boost查找相关警告
if (POLICY CMP0167)
    cmake_policy(SET CMP0167 NEW)
endif ()
set(Boost_USE_STATIC_LIBS ON)
set(Boost_USE_MULTITHREADED ON)

set(LIB_NAME "MTQuantum")

file(GLOB_RECURSE QUANTUM_SOURCES
        quantum/*.c
        quantum/*.cpp
        quark/*.c
        quark/*.cpp)

if (APPLE)
    list(APPEND QUANTUM_SOURCES module.modulemap)
endif ()
add_library(${LIB_NAME} SHARED ${QUANTUM_SOURCES})

# 查找并引用日志库
find_package(spdlog CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PUBLIC spdlog::spdlog)

# 查找并引用Boost库
find_package(Boost COMPONENTS system thread chrono filesystem url REQUIRED)
target_include_directories(${LIB_NAME} PUBLIC ${Boost_INCLUDE_DIRS})
target_link_libraries(${LIB_NAME} PUBLIC ${Boost_LIBRARIES})

# 查找并引用Markdown解析库
find_package(cmark CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PUBLIC cmark::cmark)

# 查找并引用Sqlite解析库
find_package(unofficial-sqlite3 CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PUBLIC unofficial::sqlite3::sqlite3)

# 查找并引用yaml-cpp解析库
find_package(yaml-cpp CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PUBLIC yaml-cpp::yaml-cpp)

if (APPLE)
    set_target_properties(${LIB_NAME} PROPERTIES
            FRAMEWORK TRUE
            FRAMEWORK_VERSION A
            MACOSX_FRAMEWORK_IDENTIFIER xyz.huable.MTQuantum
            VERSION 0.0.1
            SOVERSION 0.0.1
            PUBLIC_HEADER "src/quantum/quantum.h"
            MACOSX_BUNDLE TRUE
    )
endif ()

# 添加测试代码
add_subdirectory(tests)

install(TARGETS ${LIB_NAME}
        RUNTIME_DEPENDENCY_SET ${LIB_NAME}-dependencies
        DESTINATION .
)
install(RUNTIME_DEPENDENCY_SET ${LIB_NAME}-dependencies)