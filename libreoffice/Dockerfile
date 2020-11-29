ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/debian:stretch
MAINTAINER $MAINTAINER

# Install Packages
RUN apt-get update \
&& apt-get install -y \
  sudo \
  curl \
  openjdk-11-jre \
  libreoffice-help-en-us \
  hunspell-en-us \
  mythes-en-us \
  hyphen-en-us \
  libreoffice \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Configure Java Env. (see https://wiki.debian.org/LibreOffice#Java_Environment)
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Install LanguageTool extension

# FIXME: temporary disabled because of an error similar to this one:
#         https://github.com/hanya/MRI/issues/11

#RUN curl -s https://www.languagetool.org/download/LanguageTool-stable.oxt \
#  > /tmp/LanguageTool.oxt \
#&& unopkg add --shared /tmp/LanguageTool.oxt \
#&& rm /tmp/LanguageTool.oxt

# Default volume
RUN mkdir /data
WORKDIR /data
VOLUME ["/data"]

# Default command
CMD ["/usr/bin/libreoffice"]
