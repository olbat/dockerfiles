FROM olbat/debian:testing
MAINTAINER devel@olbat.net

# Install kcachegrind
RUN apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y kcachegrind \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial

# Add user
RUN useradd --create-home --home-dir=/home/user --shell=/bin/bash user

# Setup environment
USER user
WORKDIR /home/user

# Default shell
CMD ["/usr/bin/kcachegrind"]
