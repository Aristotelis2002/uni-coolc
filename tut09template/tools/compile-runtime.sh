script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"
runtime_dir="${project_root}/runtime"
bin_dir="${project_root}/build"

mkdir -p ${bin_dir}
riscv64-unknown-elf-gcc -c -march=rv32imzicsr -mabi=ilp32 -nostdlib ${runtime_dir}/cc-rv-rt.s -o ${bin_dir}/cc-rv-rt.o
