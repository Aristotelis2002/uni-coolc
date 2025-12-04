script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"
runtime_dir="${project_root}/runtime"
bin_dir="${project_root}/build"
bin_path="${bin_dir}/a.out"

"${script_dir}/compile-runtime.sh"

riscv64-unknown-elf-gcc -mabi=ilp32 -march=rv32imzicsr -nostdlib \
    "${bin_dir}/cc-rv-rt.o" "program.s" \
    -T "${runtime_dir}/cc-rv-rt.ld" \
    -o "${bin_path}"

