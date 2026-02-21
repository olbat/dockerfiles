ARG MAINTAINER
FROM debian:testing-slim
MAINTAINER $MAINTAINER

# Install Packages (basic tools, cups, basic drivers, HP drivers).
# See https://wiki.debian.org/CUPSDriverlessPrinting,
#     https://wiki.debian.org/CUPSPrintQueues
#     https://wiki.debian.org/CUPSQuickPrintQueues
# Note: printer-driver-all has been removed from Debian testing,
#       therefore printer-driver-* packages are manuall added.
RUN apt-get update \
&& apt-get install -y \
  sudo \
  whois \
  usbutils \
  cups \
  cups-client \
  cups-bsd \
  cups-filters \
  cups-browsed \
  foomatic-db-engine \
  foomatic-db-compressed-ppds \
  openprinting-ppds \
  hp-ppd \
  printer-driver-brlaser \
  printer-driver-c2050 \
  printer-driver-c2esp \
  printer-driver-cjet \
  printer-driver-dymo \
  printer-driver-escpr \
  printer-driver-foo2zjs \
  printer-driver-fujixerox \
  printer-driver-m2300w \
  printer-driver-min12xxw \
  printer-driver-pnm2ppa \
  printer-driver-indexbraille \
  printer-driver-oki \
  printer-driver-ptouch \
  printer-driver-pxljr \
  printer-driver-sag-gdi \
  printer-driver-splix \
  printer-driver-cups-pdf \
  printer-driver-gutenprint \
  smbclient \
  avahi-utils \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# This will use port 631
EXPOSE 631

# Add user and disable sudo password checking
RUN useradd \
  --groups=sudo,lp,lpadmin \
  --create-home \
  --home-dir=/home/print \
  --shell=/bin/bash \
  --password=$(mkpasswd print) \
  print \
&& sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Copy the default configuration file
COPY --chown=root:lp cupsd.conf /etc/cups/cupsd.conf

# Default shell
CMD ["/usr/sbin/cupsd", "-f"]
