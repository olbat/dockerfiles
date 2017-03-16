FROM olbat/debian:testing
MAINTAINER devel@olbat.net

# Install Packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
# Install basic tools and cups
RUN apt-get install -y sudo whois cups cups-client cups-bsd
# Install all drivers
RUN apt-get install -y printer-driver-all
# Install HP drivers
RUN apt-get install -y hpijs-ppds hp-ppd hplip
ENV DEBIAN_FRONTEND ""

# Add user
RUN useradd \
  --groups=sudo,lp,lpadmin \
  --create-home \
  --home-dir=/home/print \
  --shell=/bin/bash \
  --password=$(mkpasswd print) \
  print
# Disable sudo password checking for users of the sudo group
RUN sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Clean image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial

# Setup environment
WORKDIR /home/print

# Default shell
CMD ["/usr/sbin/cupsd", "-f"]
