cmake_minimum_required(VERSION 3.28...3.31)

project(Kepler VERSION 0.1.0 LANGUAGES C CXX)

enable_language(OBJC OBJCXX Swift)

# 设置语言标准
set(CMAKE_C_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_C_STANDARD_REQUIRED ON)

# 设置开启显示详细的构建过程
set(CMAKE_VERBOSE_MAKEFILE ON)

# 启用测试
enable_testing()

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

set(LIB_NAME "MTKepler")

file(GLOB_RECURSE KEPLER_SOURCES kepler/*.cpp quark/*.cpp)
add_library(${LIB_NAME} ${KEPLER_SOURCES} module.modulemap)

# 查找并引用日志库
find_package(spdlog CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PRIVATE spdlog::spdlog)

# 查找并引用日志库
find_package(spdlog CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PRIVATE spdlog::spdlog)

# 查找并引用Boost库
find_package(Boost COMPONENTS system thread chrono filesystem url REQUIRED)
target_include_directories(${LIB_NAME} PRIVATE ${Boost_INCLUDE_DIRS})
target_link_libraries(${LIB_NAME} PRIVATE ${Boost_LIBRARIES})

# 查找并引用日志库
find_package(spdlog CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PRIVATE spdlog::spdlog)

# 查找并引用Markdown解析库
find_package(cmark CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PRIVATE cmark::cmark)

# 查找并引用Sqlite解析库
find_package(unofficial-sqlite3 CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PRIVATE unofficial::sqlite3::sqlite3)

# 查找并引用yaml-cpp解析库
find_package(yaml-cpp CONFIG REQUIRED)
target_link_libraries(${LIB_NAME} PRIVATE yaml-cpp::yaml-cpp)
