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
  openssl \
  monkeysphere \
  hopenpgp-tools \
  git \
  secure-delete \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Fetch and verify the sks-keyserver.net keyserver CA certificate
RUN mkdir -p /usr/local/share/ca-certificates/
# FIXME: the sks-keyservers.net service cannot be accessed from TravisCI
#        (see https://github.com/olbat/dockerfiles/issues/1)
#ADD https://sks-keyservers.net/sks-keyservers.netCA.pem \
#  /usr/local/share/ca-certificates/
ADD sks-keyservers.netCA.pem /usr/local/share/ca-certificates/
RUN [ $(openssl x509 -fingerprint -noout -in \
    /usr/local/share/ca-certificates/sks-keyservers.netCA.pem | cut -d= -f2) \
  = "79:1B:27:A3:8E:66:7F:80:27:81:4D:4E:68:E7:C4:78:A4:5D:5A:17" ] \
&& update-ca-certificates

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