FROM ubuntu:24.04

# Docker automatically sets TARGETPLATFORM (e.g., linux/amd64 or linux/arm64)
ARG TARGETPLATFORM

RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        dpkg --add-architecture armhf; \
    else \
        dpkg --add-architecture i386; \
    fi

RUN apt-get update
RUN apt-get install -y \
  flex \
  bison \
  build-essential \
  csh \
  openjdk-17-jdk-headless \
  libxaw7-dev \
  nano \
  vim \
  sudo \
  curl \
  unzip \
  wget

RUN if [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        apt-get install -y libc6:armhf libstdc++6:armhf zlib1g:armhf; \
    else \
        apt-get install -y libc6:i386 libstdc++6:i386 zlib1g:i386; \
    fi

RUN mkdir -p /usr/class/bin

WORKDIR /usr/class

RUN useradd -ms /bin/bash student
RUN usermod -aG sudo student
RUN usermod -aG ubuntu student

RUN wget -cO - https://courses.edx.org/asset-v1:StanfordOnline+SOE.YCSCS1+1T2020+type@asset+block@student-dist.tar.gz > student-dist.tar.gz

RUN tar -xzf student-dist.tar.gz

RUN rm student-dist.tar.gz

RUN chown -R student:student /usr/class
RUN find /usr/class -mindepth 1 -maxdepth 1 ! -name bin ! -name lib -exec rm -rf {} +
RUN mkdir -p /etc/sudoers.d
RUN echo 'student ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/student
RUN chmod 0440 /etc/sudoers.d/student

# --- ANTLR 4 toolchain (append-only, fixed heredocs) ---
ENV ANTLR_VERSION=4.13.2

# Download the ANTLR jar
RUN mkdir -p /usr/local/lib \
 && wget -qO /usr/local/lib/antlr-${ANTLR_VERSION}-complete.jar \
      https://www.antlr.org/download/antlr-${ANTLR_VERSION}-complete.jar

# antlr4 launcher
RUN cat >/usr/local/bin/antlr4 <<EOF \
 && chmod +x /usr/local/bin/antlr4
#!/usr/bin/env bash
java -Xmx500M -cp "/usr/local/lib/antlr-${ANTLR_VERSION}-complete.jar:\$CLASSPATH" org.antlr.v4.Tool "\$@"
EOF

# grun (TestRig) launcher
RUN cat >/usr/local/bin/grun <<EOF \
 && chmod +x /usr/local/bin/grun
#!/usr/bin/env bash
java -Xmx500M -cp "/usr/local/lib/antlr-${ANTLR_VERSION}-complete.jar:\$CLASSPATH" org.antlr.v4.gui.TestRig "\$@"
EOF

# Make ANTLR available to javac/java by default (append-only)
ENV CLASSPATH="/usr/local/lib/antlr-${ANTLR_VERSION}-complete.jar:${CLASSPATH}"

COPY class-code /home/student/class-code
COPY my-code /opt/my-code-template

RUN cp -r /opt/my-code-template /home/student/my-code
RUN chmod 0775 /home/student/my-code

RUN chown -R student:student /home/student/class-code /home/student/my-code \
    && chmod -R a+rX /opt/my-code-template

RUN chmod +x /home/student/class-code/cs143/bin/coolc \
    && chmod +x /home/student/class-code/cs143/bin/spim

RUN cat <<'EOF' > /usr/local/bin/container-entrypoint.sh
#!/bin/bash
set -e

TEMPLATE="/opt/my-code-template"
TARGET="/home/student/my-code"

mkdir -p "$TARGET"

if [ -z "$(find "$TARGET" -mindepth 1 -maxdepth 1 -print -quit)" ]; then
  cp -r "$TEMPLATE"/. "$TARGET"/
fi

exec "$@"
EOF
RUN chmod +x /usr/local/bin/container-entrypoint.sh

# Download, build, and install ANTLR4 C++ runtime
RUN apt-get install -y python3 cmake
RUN mkdir -p /tmp/antlr-build
WORKDIR /tmp/antlr-build
RUN wget -cO - https://www.antlr.org/download/antlr4-cpp-runtime-${ANTLR_VERSION}-source.zip > antlr.zip
RUN unzip antlr.zip
RUN cmake . && cmake --build . --target install

COPY cw1template /cw1template

USER student
WORKDIR /home/student/my-code

RUN ln -s /usr/class /home/student/cool

ENV PATH="/usr/class/bin:/home/student/class-code/cs143/bin:$PATH"

ENTRYPOINT ["/usr/local/bin/container-entrypoint.sh"]
CMD ["/bin/bash"]
