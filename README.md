# Docker for COOL Compiler (Student Distribution)

## Installing Docker
Install Docker Desktop (or Docker Engine on Linux) before continuing.

[Download and Install Docker](https://www.docker.com/products/docker-desktop/)

You will be editing your code on the host (i.e. your machine) and storing it in the my-code directory.

## Build the Image
```bash
docker build -t cool-env .
```

## Run the Container

### One-off session (disposable)
```bash
docker run --rm -it \
  -v "$(pwd)/my-code:/home/student/my-code" \
  cool-env
```

### Reusable session (keeps the container around)
```bash
docker run -it --name cool-session \
  -v "$(pwd)/my-code:/home/student/my-code" \
  cool-env
```

After exiting, restart the same container with your shell history and the bind-mounted files intact:
```bash
docker start -ai cool-session
```

When you no longer need it, remove the stopped container:
```bash
docker rm cool-session
```

If the mounted `my-code` folder is empty on first launch, the container seeds it
with the starter files that ship in this repository. Subsequent runs reuse and
preserve your edits.

What you get inside the container:
- Shell opens in `/home/student/my-code` (matching the repo layout).
- Course materials live in `/home/student/class-code`.
- COOL toolchain (`coolc`, `spim`, etc.) is already on `PATH`.
- `sudo` is available without a password for installing extras.

## Notes
This docker image is based on 32-bit Ubuntu.
Tested on:
- Apple M1 with Ventura 13.4.1 (Docker Desktop amd64 emulation).
- Core i7 with Windows 10.

## For Windows 10
If Docker Desktop reports missing components, enable the Windows Subsystem for Linux:
```bash
wsl --install
```
