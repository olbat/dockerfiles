ARG MAINTAINER
FROM debian:stable-slim
MAINTAINER $MAINTAINER

RUN apt-get update \
&& apt-get install -y imagemagick \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/identify"]
