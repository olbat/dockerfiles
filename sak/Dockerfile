ARG BASE_TAG
ARG MAINTAINER
FROM debian:$BASE_TAG-slim
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

CMD ["/bin/bash"]
