FROM debian:testing-slim
ARG MAINTAINER_LABEL
ARG SOURCE_URL_LABEL
ARG IMAGE_URL_LABEL
ARG DOCUMENTATION_URL_LABEL
LABEL org.opencontainers.image.authors="$MAINTAINER_LABEL" \
      org.opencontainers.image.source="$SOURCE_URL_LABEL" \
      org.opencontainers.image.documentation="$DOCUMENTATION_URL_LABEL" \
      org.opencontainers.image.url="$IMAGE_URL_LABEL" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.title="Pandoc image" \
      org.opencontainers.image.description="Docker image including Pandoc and dependencies to support additional formats installed from the Debian package."

RUN apt-get update \
&& apt-get install -y \
  pandoc \
  texlive-latex-recommended \
  texlive-latex-extra \
  texlive-xetex \
  texlive-luatex \
  librsvg2-bin \
  context \
  groff \
  libjs-mathjax \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/pandoc"]
