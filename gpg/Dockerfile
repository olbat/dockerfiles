ARG BASE_TAG=stable
FROM debian:$BASE_TAG-slim
ARG MAINTAINER_LABEL
ARG SOURCE_URL_LABEL
ARG IMAGE_URL_LABEL
ARG DOCUMENTATION_URL_LABEL
LABEL org.opencontainers.image.authors="$MAINTAINER_LABEL" \
      org.opencontainers.image.source="$SOURCE_URL_LABEL" \
      org.opencontainers.image.documentation="$DOCUMENTATION_URL_LABEL" \
      org.opencontainers.image.url="$IMAGE_URL_LABEL" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.title="GnuPG image" \
      org.opencontainers.image.description="Docker image including GnuPG and some tools installed from the Debian package."
ARG GPG_USER=gpguser

RUN apt-get update \
&& apt-get install -y --no-install-recommends \
  gnupg \
  gnupg-agent \
  ca-certificates \
  pinentry-tty \
  scdaemon \
  openssl \
  curl \
  vim \
  secure-delete \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# create dedicated user
RUN useradd \
  --user-group \
  --create-home \
  --home-dir=/home/$GPG_USER \
  --shell=/bin/bash \
  $GPG_USER

# create GnuPG home dir and copy default config file
RUN mkdir -p /home/$GPG_USER/.gnupg/ \
    && chmod 700 /home/$GPG_USER/.gnupg/
COPY gpg.conf /home/$GPG_USER/.gnupg/
RUN chmod 600 /home/$GPG_USER/.gnupg/gpg.conf
RUN chown -R $GPG_USER:$GPG_USER /home/$GPG_USER/.gnupg/

USER $GPG_USER
WORKDIR /home/$GPG_USER

CMD ["/bin/bash","--login","-i"]
