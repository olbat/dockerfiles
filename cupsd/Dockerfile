FROM debian:testing-slim
ARG MAINTAINER_LABEL
ARG SOURCE_URL_LABEL
ARG IMAGE_URL_LABEL
ARG DOCUMENTATION_URL_LABEL
LABEL org.opencontainers.image.authors="$MAINTAINER_LABEL" \
      org.opencontainers.image.source="$SOURCE_URL_LABEL" \
      org.opencontainers.image.documentation="$DOCUMENTATION_URL_LABEL" \
      org.opencontainers.image.url="$IMAGE_URL_LABEL" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.title="CUPS print server image" \
      org.opencontainers.image.description="Docker image including CUPS print server and printing drivers installed from the Debian packages."
ENV LPADMIN_USER="print"
ENV LPADMIN_PASSWORD="print"

# Install Packages (basic tools, cups, basic drivers, HP drivers).
# See https://wiki.debian.org/CUPSDriverlessPrinting,
#     https://wiki.debian.org/CUPSPrintQueues
#     https://wiki.debian.org/CUPSQuickPrintQueues
# Note: printer-driver-all has been removed from Debian testing,
#       therefore printer-driver-* packages are manually added.
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
  smbclient \
  avahi-utils \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# This will use port 631
EXPOSE 631

# 
RUN sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Copy the default configuration file
COPY --chown=root:lp cupsd.conf /etc/cups/cupsd.conf
COPY entrypoint.sh /entrypoint.sh

# Default shell
ENTRYPOINT ["/entrypoint.sh"]
