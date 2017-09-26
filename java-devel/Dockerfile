ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/debian:stretch
MAINTAINER $MAINTAINER

# Install Packages (basic and Java development tools)
RUN apt-get update \
&& apt-get install -y \
  sudo \
  git \
  curl \
  gcc \
  openjdk-8-jdk \
  maven \
  ant \
  ivy \
  gradle \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Add java user and disable sudo password checking
RUN useradd \
  --groups=sudo \
  --create-home \
  --home-dir=/home/java \
  --shell=/bin/bash \
  java \
&& sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Setup environment
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN /bin/echo -e "export JAVA_HOME=${JAVA_HOME}" >> /home/java/.bashrc
USER java
WORKDIR /home/java

# Default shell
CMD ["/bin/bash","--login","-i"]
