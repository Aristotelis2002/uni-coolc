script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"
tests_dir="${project_root}/tests/codegen"
bin_dir="${project_root}/build"
lib_dir="${project_root}/lib"
temp_dir="${project_root}/temp"

input=""
if [ -n "${1:-}" ]; then
    input="$1"
else
    echo "Error: pass name of assembly program to assemble and run" >&2
    echo "Usage: $0 [input]" >&2
    exit 1
fi

if [ ! -f "${lib_dir}/cc-rv-rt.o" ] || [ ! -f "${lib_dir}/cc-rv-rt.ld" ]; then
    echo "Error: Required runtime library (cc-rv-rt) not found; download from https://github.com/smanilov/coolc-riscv-runtime, build it, and put it in code/lib" >&2
    exit 1
fi

run_asm() {
    local s_path="$1"
    local testfile
    local testname

    testfile="$(basename "${s_path}")"
    testname="${testfile%.s}"

    bin_path="${temp_dir}/${testname}"

    riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32imzicsr -nostdlib \
        "${lib_dir}/cc-rv-rt.o" "${s_path}" -T "${lib_dir}/cc-rv-rt.ld" \
        -o "${bin_path}"

    spike --isa=RV32IMZICSR "${bin_path}"
}

if [ -e "$input" ]; then
    run_asm "${input}"
else
    echo "Error: file '${input}' does not exist"
    echo "Usage: $0 [input]"
    exit 1
fi