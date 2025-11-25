script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"

# First argument: tool name
tool_name="semantics"

tests_dir="${project_root}/tests/${tool_name}"
bin_dir="${project_root}/build"
temp_dir="${project_root}/temp"

mkdir -p "${temp_dir}"

# Second argument: bless or input
bless=false
input=""
if [ -n "${1:-}" ]; then
    if [ "${1:-}" == "bless" ]; then
        bless=true
    else
        input="$1"
        if [ -n "${2:-}" ]; then
            if [ "${2:-}" == "bless" ]; then
                bless=true
            else
                echo "Error: third argument can only be 'bless'"
                echo "Usage: $0 [input|prefix] [bless]"
                exit 1
            fi
        fi
    fi
fi

run_diff() {
    local out_path="$1"
    local sol_path="$2"

    if head -1 "${out_path}" | grep -q "syntax error"; then
        diff <(head -1 "${out_path}") <(head -1 "${sol_path}")
    else
        diff "${out_path}" "${sol_path}"
    fi
}

run_test() {
    local input="$1"
    local testfile
    local testname
    local in_path out_path sol_path

    testfile="$(basename "${input}")"
    testname="${testfile%.in}"

    in_path="${tests_dir}/${testname}.in"
    out_path="${tests_dir}/${testname}.out"
    sol_path="${temp_dir}/${testname}.sol"

    total_tests=$((total_tests + 1))

    if $bless; then
        "${bin_dir}/${tool_name}" "${in_path}" > "${out_path}"
    else
        "${bin_dir}/${tool_name}" "${in_path}" > "${sol_path}"

        if ! run_diff "${out_path}" "${sol_path}"; then
            echo "Test ${testname} FAILED"
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
    for input in "${tests_dir}"/*.in; do
        run_test "${input}"
    done
else
    if [ -e "$input" ]; then
        run_test "${input}"
    else
        matches=( "${tests_dir}/${input}"*.in )

        if [ -e "${matches[0]}" ]; then
            for file in "${matches[@]}"; do
                run_test "${file}"
            done
        else
            echo "Error: '${input}' is not a valid file name or prefix"
            echo "Usage: $0 [input|prefix] [bless]"
            exit 1
        fi
    fi
fi

# === Print summary ===
if ! $bless; then
    echo
    echo "Total ${passed_tests} out of ${total_tests} tests PASSED"
else
    echo
    echo "Total ${total_tests} tests BLESSED"
fi