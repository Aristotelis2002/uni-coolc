# This adapts the in-container generated compile_commands.json to the local filesystem of the host; has to be run in the host, not the container
script_dir="$(cd -- "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
project_root="$(cd -- "${script_dir}/.." && pwd)"
bin_dir="${project_root}/build"

cp ${bin_dir}/compile_commands.json ${project_root}
sed "s? /code? ${project_root}?g" -i ../compile_commands.json
sed "s?-I/code?-I${project_root}?g" -i ../compile_commands.json
sed "s?\"/code?\"${project_root}?g" -i ../compile_commands.json
sed "s?/usr/local/include/?/usr/include/?g" -i ../compile_commands.json
