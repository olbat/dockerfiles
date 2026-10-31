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
      org.opencontainers.image.title="LibreOffice image" \
      org.opencontainers.image.description="Docker image including Libre Office installed from the Debian package."

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
