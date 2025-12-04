script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"
bin_dir="${project_root}/build"
bin_path="${bin_dir}/a.out"

spike --isa=RV32IMZICSR "${bin_path}"
