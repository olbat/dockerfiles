ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/debian:testing
MAINTAINER $MAINTAINER

# Install Packages (basic tools, cups, basic drivers, HP drivers)
RUN apt-get update \
&& apt-get install -y \
  sudo \
  whois \
  cups \
  cups-client \
  cups-bsd \
  printer-driver-all \
  hpijs-ppds \
  hp-ppd \
  hplip \
  printer-driver-splix \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Add user and disable sudo password checking
RUN useradd \
  --groups=sudo,lp,lpadmin \
  --create-home \
  --home-dir=/home/print \
  --shell=/bin/bash \
  --password=$(mkpasswd print) \
  print \
&& sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Setup environment
WORKDIR /home/print

# Default shell
CMD ["/usr/sbin/cupsd", "-f"]
