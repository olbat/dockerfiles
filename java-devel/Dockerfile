FROM debian:stable-slim
ARG MAINTAINER_LABEL
ARG SOURCE_URL_LABEL
ARG IMAGE_URL_LABEL
ARG DOCUMENTATION_URL_LABEL
LABEL org.opencontainers.image.authors="$MAINTAINER_LABEL" \
      org.opencontainers.image.source="$SOURCE_URL_LABEL" \
      org.opencontainers.image.documentation="$DOCUMENTATION_URL_LABEL" \
      org.opencontainers.image.url="$IMAGE_URL_LABEL" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.title="Java devel image" \
      org.opencontainers.image.description="Docker image including Java development tools installed from the Debian package."

# Install Packages (basic and Java development tools)
RUN apt-get update \
&& apt-get install -y \
  sudo \
  git \
  curl \
  gcc \
  default-jdk \
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
RUN /bin/echo -e 'export JAVA_HOME=$(readlink -f /etc/alternatives/java | sed "s:/bin/java::")' >> /home/java/.bashrc
USER java
WORKDIR /home/java

# Default shell
CMD ["/bin/bash","--login","-i"]
