FROM olbat/java-devel
MAINTAINER devel@olbat.net

USER root
# Install Java IDEs
RUN apt-get update \
&& apt-get install -y \
  eclipse \
  eclipse-jdt \
  netbeans \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

USER java
