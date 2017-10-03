ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/debian:stable
MAINTAINER $MAINTAINER

RUN apt-get update \
&& apt-get install -y imagemagick \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/identify"]
