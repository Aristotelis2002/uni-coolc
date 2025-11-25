cmake_minimum_required(VERSION 3.16)
project(cool-tools LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  set(CMAKE_BUILD_TYPE Debug CACHE STRING "Build type" FORCE)
endif()

set(PROJECT_ROOT "${CMAKE_CURRENT_SOURCE_DIR}/..")
set(SRC_DIR "${PROJECT_ROOT}/src")
set(INCLUDE_DIR "${PROJECT_ROOT}/include")
set(GEN_DIR "${PROJECT_ROOT}/gen")
set(LIB_DIR "${PROJECT_ROOT}/lib")
set(BUILD_DIR "${PROJECT_ROOT}/build")
set(SEMANTICS_DIR "${SRC_DIR}/semantics")
set(DRIVERS_DIR "${SRC_DIR}/drivers")

set(LEXER_LIB "${LIB_DIR}/liblexer_gen_code.a")
set(PARSER_LIB "${LIB_DIR}/libparser_gen_code.a")

# ANTLR4

set(ANTLR4_RUNTIME_INCLUDE_DIR "/usr/local/include/antlr4-runtime" CACHE PATH "Directory containing ANTLR runtime headers")
if(NOT EXISTS "${ANTLR4_RUNTIME_INCLUDE_DIR}/antlr4-runtime.h")
  find_path(ANTLR4_RUNTIME_INCLUDE_DIR
    NAMES antlr4-runtime.h
    PATH_SUFFIXES antlr4-runtime
  )
endif()

if(NOT ANTLR4_RUNTIME_INCLUDE_DIR)
  message(FATAL_ERROR "ANTLR runtime headers not found; set ANTLR4_RUNTIME_INCLUDE_DIR")
endif()

set(ANTLR4_RUNTIME_LIBRARY "/usr/local/lib/libantlr4-runtime.a" CACHE FILEPATH "Path to the ANTLR runtime library")
if(NOT EXISTS "${ANTLR4_RUNTIME_LIBRARY}")
  find_library(ANTLR4_RUNTIME_LIBRARY
    NAMES antlr4-runtime libantlr4-runtime.a
  )
endif()

if(NOT ANTLR4_RUNTIME_LIBRARY)
  message(FATAL_ERROR "ANTLR runtime library not found; set ANTLR4_RUNTIME_LIBRARY")
endif()

# Semantics

file(GLOB_RECURSE SEMANTICS_SOURCES CONFIGURE_DEPENDS
  "${SEMANTICS_DIR}/*.cpp"
)

add_library(semantics_lib STATIC ${SEMANTICS_SOURCES})
target_link_libraries(semantics_lib PUBLIC ${LEXER_LIB} ${PARSER_LIB} ${ANTLR4_RUNTIME_LIBRARY})
target_include_directories(
  semantics_lib
  PUBLIC
  ${SRC_DIR}
  ${INCLUDE_DIR}
  ${INCLUDE_DIR}/semantics
  ${INCLUDE_DIR}/semantics/passes
  ${INCLUDE_DIR}/semantics/typed-ast
  ${ANTLR4_RUNTIME_INCLUDE_DIR}
)
target_compile_options(semantics_lib PRIVATE -g)

add_executable(semantics ${DRIVERS_DIR}/SemanticsDriver.cpp)
target_link_libraries(semantics PRIVATE semantics_lib)
set_target_properties(semantics PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${BUILD_DIR}")
target_compile_options(semantics PRIVATE -g)