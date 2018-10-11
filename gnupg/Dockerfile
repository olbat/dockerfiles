ARG BASE_USER
ARG BASE_TAG
ARG MAINTAINER
FROM ${BASE_USER}/debian:$BASE_TAG
MAINTAINER $MAINTAINER

RUN apt-get update \
&& apt-get install -y \
  gnupg \
  gnupg-agent \
  pinentry-tty \
  scdaemon \
  openssl \
  hopenpgp-tools \
  git \
  secure-delete \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Copy GnuPG default's configuration file
COPY gpg.conf /etc/gnupg/gpgconf.conf
RUN mkdir -p /root/.gnupg \
&& chmod 700 /root/.gnupg
COPY gpg.conf /root/.gnupg/
RUN chmod 600 /root/.gnupg/gpg.conf

WORKDIR /root
VOLUME "/root/.gnupg/"
RUN chsh -s /bin/bash
CMD ["/bin/bash","--login","-i"]
