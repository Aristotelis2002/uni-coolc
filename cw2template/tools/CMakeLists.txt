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
set(CODEGEN_DIR "${SRC_DIR}/codegen")
set(DRIVERS_DIR "${SRC_DIR}/drivers")

set(LEXER_LIB "${LIB_DIR}/liblexer_gen_code.a")

set(ANTLR4_JAR "/usr/local/lib/antlr-4.13.2-complete.jar" CACHE FILEPATH "Path to the ANTLR 4 complete jar")

if(NOT EXISTS "${ANTLR4_JAR}")
  message(FATAL_ERROR "ANTLR4 jar not found; set ANTLR4_JAR")
endif()

find_package(Java COMPONENTS Runtime REQUIRED)

set(_antlr_classpath "${ANTLR4_JAR}")
if(DEFINED ENV{CLASSPATH} AND NOT "$ENV{CLASSPATH}" STREQUAL "")
  set(_antlr_classpath "${_antlr_classpath}:$ENV{CLASSPATH}")
endif()

set(ANTLR4_TOOL_BASE_ARGS -Xmx500M -cp "${_antlr_classpath}" org.antlr.v4.Tool -Dlanguage=Cpp)

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

# Parser

set(GENERATED_PARSER_CODE
  "${GEN_DIR}/CoolParser.cpp"
  "${GEN_DIR}/CoolParserBaseVisitor.cpp"
  "${GEN_DIR}/CoolParserVisitor.cpp"
)

set(GENERATED_PARSER_HEADERS
  "${GEN_DIR}/CoolParser.h"
  "${GEN_DIR}/CoolParser.interp"
  "${GEN_DIR}/CoolParser.tokens"
  "${GEN_DIR}/CoolParserBaseVisitor.h"
  "${GEN_DIR}/CoolParserVisitor.h"
)

add_custom_command(
  OUTPUT ${GENERATED_PARSER_CODE}
  BYPRODUCTS ${GENERATED_PARSER_HEADERS}
  COMMAND ${CMAKE_COMMAND} -E make_directory "${GEN_DIR}"
  COMMAND ${Java_JAVA_EXECUTABLE} ${ANTLR4_TOOL_BASE_ARGS} -visitor -no-listener "${SRC_DIR}/CoolParser.g4" -o "${GEN_DIR}"
  DEPENDS
    "${SRC_DIR}/CoolParser.g4"
    "${SRC_DIR}/CoolLexer.tokens"
  COMMENT "Generating COOL parser code"
  VERBATIM
)

add_custom_target(gen_parser DEPENDS ${GENERATED_PARSER_CODE})

add_library(parser_gen_code STATIC ${GENERATED_PARSER_CODE})
add_dependencies(parser_gen_code gen_parser)
target_include_directories(parser_gen_code PUBLIC ${GEN_DIR} ${ANTLR4_RUNTIME_INCLUDE_DIR})
target_link_libraries(parser_gen_code PUBLIC ${ANTLR4_RUNTIME_LIBRARY})
target_compile_options(parser_gen_code PRIVATE -g)

add_executable(parser ${DRIVERS_DIR}/ParserDriver.cpp)
target_include_directories(parser PUBLIC ${INCLUDE_DIR})
target_link_libraries(parser PRIVATE ${LEXER_LIB} parser_gen_code)
set_target_properties(parser PROPERTIES RUNTIME_OUTPUT_DIRECTORY "${BUILD_DIR}")
target_compile_options(parser PRIVATE -g)
