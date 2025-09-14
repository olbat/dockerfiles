ARG MAINTAINER
FROM debian:stable-slim
MAINTAINER $MAINTAINER

# Install Packages
RUN apt-get update \
&& apt-get install -y \
  sudo \
  curl \
  default-jre \
  libreoffice-help-en-us \
  hunspell-en-us \
  mythes-en-us \
  hyphen-en-us \
  libreoffice \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

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
