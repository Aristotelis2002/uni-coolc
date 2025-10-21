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
set(GEN_DIR "${PROJECT_ROOT}/gen")
set(BUILD_DIR "${PROJECT_ROOT}/build")
set(DRIVERS_DIR "${SRC_DIR}/drivers")

set(ANTLR_GENERATED_LEXER_SOURCE
  "${GEN_DIR}/CoolLexer.cpp"
)

set(ANTLR_GENERATED_LEXER_HEADER
  "${GEN_DIR}/CoolLexer.h"
  "${GEN_DIR}/CoolLexer.interp"
  "${GEN_DIR}/CoolLexer.tokens"
)

set(ANTLR4_JAR "/usr/local/lib/antlr-4.13.2-complete.jar" CACHE FILEPATH "Path to the ANTLR 4 complete jar")
if(NOT EXISTS "${ANTLR4_JAR}")
  message(FATAL_ERROR "ANTLR4 jar not found; set ANTLR4_JAR")
endif()

find_package(Java COMPONENTS Runtime REQUIRED)

set(ANTLR4_TOOL_BASE_ARGS
  -Xmx500M
  -cp "${ANTLR4_JAR}"
  org.antlr.v4.Tool
  -Dlanguage=Cpp
)

add_custom_command(
  OUTPUT ${ANTLR_GENERATED_LEXER_SOURCE}
  BYPRODUCTS ${ANTLR_GENERATED_LEXER_HEADER}
  COMMAND ${CMAKE_COMMAND} -E make_directory "${GEN_DIR}"
  COMMAND ${Java_JAVA_EXECUTABLE} ${ANTLR4_TOOL_BASE_ARGS} "${SRC_DIR}/CoolLexer.g4" -o "${GEN_DIR}"
  DEPENDS
    "${SRC_DIR}/CoolLexer.g4"
  COMMENT "Generating Cool lexer sources"
  VERBATIM
)

add_custom_target(gen_lexer DEPENDS ${ANTLR_GENERATED_LEXER_SOURCE})

add_library(generated_lexer STATIC ${ANTLR_GENERATED_LEXER_SOURCE})

add_dependencies(generated_lexer gen_lexer)

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

target_include_directories(generated_lexer
  PUBLIC
    ${GEN_DIR}
    ${ANTLR4_RUNTIME_INCLUDE_DIR}
)

set(ANTLR4_RUNTIME_LIBRARY "/usr/local/lib/libantlr4-runtime.a" CACHE FILEPATH "Path to the ANTLR runtime library")
if(NOT EXISTS "${ANTLR4_RUNTIME_LIBRARY}")
  find_library(ANTLR4_RUNTIME_LIBRARY
    NAMES antlr4-runtime libantlr4-runtime.a
  )
endif()

if(NOT ANTLR4_RUNTIME_LIBRARY)
  message(FATAL_ERROR "ANTLR runtime library not found; set ANTLR4_RUNTIME_LIBRARY")
endif()

target_link_libraries(generated_lexer PUBLIC ${ANTLR4_RUNTIME_LIBRARY})

target_compile_options(generated_lexer PRIVATE -g)

add_executable(lexer ${DRIVERS_DIR}/LexerDriver.cpp)

target_link_libraries(lexer PRIVATE generated_lexer)

set_target_properties(lexer PROPERTIES
  RUNTIME_OUTPUT_DIRECTORY "${BUILD_DIR}"
)

target_compile_options(lexer PRIVATE -g)