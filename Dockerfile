FROM --platform=linux/amd64 i686/ubuntu

RUN apt-get update
RUN apt-get install -y \
  flex \
  bison \
  build-essential \
  csh \
  openjdk-6-jdk \
  libxaw7-dev \
  nano \
  vim \
  sudo \
  wget

RUN mkdir -p /usr/class/bin

WORKDIR /usr/class

RUN useradd -ms /bin/bash student
RUN usermod -aG sudo student

RUN wget -cO - https://courses.edx.org/asset-v1:StanfordOnline+SOE.YCSCS1+1T2020+type@asset+block@student-dist.tar.gz > student-dist.tar.gz

RUN tar -xzf student-dist.tar.gz

RUN rm student-dist.tar.gz

RUN chown -R student:student /usr/class
RUN find /usr/class -mindepth 1 -maxdepth 1 ! -name bin ! -name lib -exec rm -rf {} +
RUN mkdir -p /etc/sudoers.d
RUN echo 'student ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/student
RUN chmod 0440 /etc/sudoers.d/student

COPY class-code /home/student/class-code
COPY my-code /opt/my-code-template

RUN cp -r /opt/my-code-template /home/student/my-code

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

USER student
WORKDIR /home/student/my-code

RUN ln -s /usr/class /home/student/cool

ENV PATH="/usr/class/bin:/home/student/class-code/cs143/bin:$PATH"

ENTRYPOINT ["/usr/local/bin/container-entrypoint.sh"]
CMD ["/bin/bash"]
