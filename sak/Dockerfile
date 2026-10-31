FROM debian:stable-slim
ARG MAINTAINER_LABEL
ARG SOURCE_URL_LABEL
ARG IMAGE_URL_LABEL
ARG DOCUMENTATION_URL_LABEL
LABEL org.opencontainers.image.authors="$MAINTAINER_LABEL" \
      org.opencontainers.image.source="$SOURCE_URL_LABEL" \
      org.opencontainers.image.documentation="$DOCUMENTATION_URL_LABEL" \
      org.opencontainers.image.url="$IMAGE_URL_LABEL" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.title="Swiss Army Knife image" \
      org.opencontainers.image.description="Docker image including a collection of Unix tools."

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
  ca-certificates \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

ENV LANG=C.UTF-8 \
LANGUAGE=C.UTF-8 \
LC_ALL=C.UTF-8

CMD ["/bin/bash"]
