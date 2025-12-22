script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"
tests_dir="${project_root}/tests/codegen"
bin_dir="${project_root}/build"
lib_dir="${project_root}/lib"
temp_dir="${project_root}/temp"

mkdir -p "${temp_dir}"

# First argument: interact or input
interact=false
input=""
if [ -n "${1:-}" ]; then
    if [ "${1:-}" == "interact" ]; then
        interact=true
    else
        input="$1"
        if [ -n "${2:-}" ]; then
            if [ "${2:-}" == "interact" ]; then
                interact=true
            else
                echo "Error: second argument can only be 'interact'"
                echo "Usage: $0 [input|prefix] [interact]"
                exit 1
            fi
        fi
    fi
fi

if [ ! -f "${lib_dir}/cc-rv-rt.o" ] || [ ! -f "${lib_dir}/cc-rv-rt.ld" ]; then
    echo "Error: Required runtime library (cc-rv-rt) not found; download from https://github.com/smanilov/coolc-riscv-runtime, build it, and put it in code/lib" >&2
    exit 1
fi

if [ ! -f "${bin_dir}/codegen" ]; then
    echo "Error: Code generator not found in ${bin_dir}/codegen; build it first and then test" >&2
    exit 1
fi

run_test() {
    local input="$1"
    local testfile
    local testname
    local in_path out_path sol_path

    testfile="$(basename "${input}")"
    testname="${testfile%.cl}"

    cl_path="${tests_dir}/${testname}.cl"
    s_path="${temp_dir}/${testname}.s"
    bin_path="${temp_dir}/${testname}"
    in_path="${tests_dir}/${testname}.in"
    out_path="${tests_dir}/${testname}.out"
    sol_path="${temp_dir}/${testname}.sol"

    total_tests=$((total_tests + 1))

    "${bin_dir}/codegen" "${cl_path}" > "${s_path}"
    riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32imzicsr -nostdlib \
        "${lib_dir}/cc-rv-rt.o" "${s_path}" -T "${lib_dir}/cc-rv-rt.ld" \
        -o "${bin_path}"

    if $interact; then
        spike --isa=RV32IMZICSR "${bin_path}"
    else
        if [ ! -f "${in_path}" ]; then
            timeout 1s spike --isa=RV32IMZICSR "${bin_path}" < /dev/null > "${sol_path}"
        else
            timeout 1s spike --isa=RV32IMZICSR "${bin_path}" < "${in_path}" > "${sol_path}"
        fi
        exit_code=$?
        if [ $exit_code -eq 124 ]; then
            echo "Test ${testname} TIMED OUT"
        elif ! diff_output=$(diff "${out_path}" "${sol_path}"); then
            echo "Test ${testname} FAILED"
            echo "output is:"
            cat "${sol_path}"
            echo "diff is:"
            echo "${diff_output}"
        else
            echo "Test ${testname} PASSED"
            passed_tests=$((passed_tests + 1))
        fi
    fi
}

# === Test counters ===
total_tests=0
passed_tests=0

if [ -z "$input" ]; then
    for input in "${tests_dir}"/*.cl; do
        run_test "${input}"
    done
else
    if [ -e "$input" ]; then
        run_test "${input}"
    else
        matches=( "${tests_dir}/${input}"*.cl )

        if [ -e "${matches[0]}" ]; then
            for file in "${matches[@]}"; do
                run_test "${file}"
            done
        else
            echo "Error: '${input}' is not a valid file name or prefix"
            echo "Usage: $0 [input|prefix] [interact]"
            exit 1
        fi
    fi
fi

# === Print summary ===
if ! $interact; then
    echo
    echo "Total ${passed_tests} out of ${total_tests} tests PASSED"
fi
