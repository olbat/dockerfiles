FROM olbat/debian:stretch
MAINTAINER devel@olbat.net

# Install Packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
RUN apt-get install -y sudo curl \
  openjdk-8-jre \
  libreoffice-l10n-fr \
  libreoffice-l10n-de \
  libreoffice-l10n-es \
  libreoffice-l10n-it \
  hunspell-en-gb \
  hunspell-en-us \
  hunspell-fr \
  hunspell-de-de \
  hunspell-es \
  hunspell-it \
  mythes-en-us \
  mythes-fr \
  mythes-de \
  mythes-es \
  mythes-it \
  hyphen-en-us \
  hyphen-en-gb \
  hyphen-fr \
  hyphen-de \
  hyphen-es \
  hyphen-it \
  libreoffice
ENV DEBIAN_FRONTEND ""

# Add office user
RUN useradd \
  --groups=sudo \
  --create-home \
  --home-dir=/home/office \
  --shell=/bin/bash \
  office
# Disable sudo password checking for users of the sudo group
RUN sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Clean image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial

# Default volume
RUN mkdir /data
VOLUME ["/data","/home/office"]

# Configure Java Env. (see https://wiki.debian.org/LibreOffice#Java_Environment)
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN /bin/echo -e "export JAVA_HOME=${JAVA_HOME}" >> /home/office/.bashrc

# Install LanguageTool extension
# (3.2+ versions does not seems to support the Debian version of LibreOffice)
RUN curl -s https://www.languagetool.org/download/LanguageTool-3.6.oxt \
  > /tmp/LanguageTool.oxt
RUN unopkg add --shared /tmp/LanguageTool.oxt
RUN rm /tmp/LanguageTool.oxt

# Setup environment
USER office
WORKDIR /home/office

# Default command
CMD ["/usr/bin/libreoffice"]
