FROM olbat/debian:stretch
MAINTAINER devel@olbat.net

# Install Packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
# Install basic tools and packages
RUN apt-get install -y sudo git curl gcc
# Install Java development tools
RUN apt-get install -y openjdk-8-jdk maven ant ivy gradle
ENV DEBIAN_FRONTEND ""

# Add java user
RUN useradd \
  --groups=sudo \
  --create-home \
  --home-dir=/home/java \
  --shell=/bin/bash \
  java
# Disable sudo password checking for users of the sudo group
RUN sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers

# Clean image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial

# Default volume
RUN mkdir /data
VOLUME ["/data","/home/java"]

# Setup environment
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
RUN /bin/echo -e "export JAVA_HOME=${JAVA_HOME}" >> /home/java/.bashrc
USER java
WORKDIR /home/java

# Default shell
CMD ["/bin/bash","--login","-i"]
