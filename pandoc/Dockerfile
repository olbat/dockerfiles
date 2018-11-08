ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/debian:testing
MAINTAINER $MAINTAINER

RUN apt-get update \
&& apt-get install -y \
  pandoc \
  texlive-latex-recommended \
  texlive-latex-extra \
  texlive-xetex \
  texlive-luatex \
  librsvg2-bin \
  context \
  wkhtmltopdf \
  groff \
  libjs-mathjax \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/pandoc"]
