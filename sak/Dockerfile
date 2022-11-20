ARG MAINTAINER
FROM debian:stable-slim
MAINTAINER $MAINTAINER

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
  coreutils \
  binutils \
  findutils \
  diffutils \
  grep \
  patch \
  gawk \
  bash \
  levee \
  xxd \
  tar \
  cpio \
  zutils \
  bzip2 \
  lzip \
  xz-utils \
  file \
  secure-delete \
  inetutils-traceroute \
  inetutils-ping \
  netcat-openbsd \
  ldnsutils \
  openssl \
  curl \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8 \
LANGUAGE=C.UTF-8 \
LC_ALL=C.UTF-8

CMD ["/bin/bash"]
