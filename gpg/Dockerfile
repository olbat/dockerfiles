ARG BASE_TAG
ARG MAINTAINER
FROM debian:$BASE_TAG-slim
MAINTAINER $MAINTAINER
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
