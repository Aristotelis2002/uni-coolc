script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"
tests_dir="${project_root}/tests/parser"
bin_dir="${project_root}/build"
temp_dir="${project_root}/temp"

mkdir -p "${temp_dir}"

bless=false
input=""
if [ -n "${1:-}" ]; then
    if [ "${1:-}" == "bless" ]; then
        bless=true
    else
        input="$1"
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

    if $bless; then
        "${bin_dir}/parser" "${in_path}" > "${out_path}"
    else
        "${bin_dir}/parser" "${in_path}" > "${sol_path}"

        if ! run_diff "${out_path}" "${sol_path}"; then
            echo "Test ${testname} FAILED"
        else
            echo "Test ${testname} PASSED"
        fi
    fi
}

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
            echo "'${input}' is not a valid file name or prefix"
            echo "Provide a valid filename as the first argument or pass no argument"
        fi
    fi
fi
