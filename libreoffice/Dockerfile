ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/debian:stretch
MAINTAINER $MAINTAINER

# Install Packages
RUN apt-get update \
&& apt-get install -y \
  sudo \
  curl \
  openjdk-8-jre \
  libreoffice-l10n-fr \
  libreoffice-l10n-de \
  libreoffice-l10n-es \
  libreoffice-l10n-it \
  hunspell-en-gb \
  hunspell-en-us \
  hunspell-fr \
  hunspell-de-de \
  hunspell-es \
  hunspell-it \
  mythes-en-us \
  mythes-fr \
  mythes-de \
  mythes-es \
  mythes-it \
  hyphen-en-us \
  hyphen-en-gb \
  hyphen-fr \
  hyphen-de \
  hyphen-es \
  hyphen-it \
  libreoffice \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Configure Java Env. (see https://wiki.debian.org/LibreOffice#Java_Environment)
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install LanguageTool extension
# (3.2+ versions does not seems to support the Debian version of LibreOffice)
RUN curl -s https://www.languagetool.org/download/LanguageTool-3.6.oxt \
  > /tmp/LanguageTool.oxt \
&& unopkg add --shared /tmp/LanguageTool.oxt \
&& rm /tmp/LanguageTool.oxt

# Default volume
RUN mkdir /data
WORKDIR /data
VOLUME ["/data"]

# Default command
CMD ["/usr/bin/libreoffice"]
