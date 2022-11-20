ARG MAINTAINER
FROM debian:testing-slim
MAINTAINER $MAINTAINER

# Install kcachegrind
RUN apt-get update \
&& apt-get install -y kcachegrind \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/kcachegrind"]
