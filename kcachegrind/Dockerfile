ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/debian:testing
MAINTAINER $MAINTAINER

# Install kcachegrind
RUN apt-get update \
&& apt-get install -y kcachegrind \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/kcachegrind"]
