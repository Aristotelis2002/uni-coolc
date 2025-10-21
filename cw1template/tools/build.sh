#!/usr/bin/env bash
set -euo pipefail

script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
build_dir="${script_dir}/../build"

cmake_args=(
  -S "${script_dir}"
  -B "${build_dir}"
  -DCMAKE_BUILD_TYPE=Debug
  -DANTLR4_RUNTIME_INCLUDE_DIR=/usr/local/include/antlr4-runtime
  -DANTLR4_RUNTIME_LIBRARY=/usr/local/lib/libantlr4-runtime.a
  -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
)

cmake "${cmake_args[@]}"

cmake --build "${build_dir}" "--parallel" "$@"