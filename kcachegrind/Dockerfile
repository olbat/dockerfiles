FROM olbat/debian:testing
MAINTAINER devel@olbat.net

# Install kcachegrind
RUN apt-get update \
&& apt-get install -y kcachegrind \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/kcachegrind"]
