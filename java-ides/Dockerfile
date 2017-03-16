FROM olbat/java-devel
MAINTAINER devel@olbat.net

USER root
# Install Packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update
# Install Java IDEs
RUN apt-get install -y eclipse eclipse-jdt netbeans
ENV DEBIAN_FRONTEND ""

# Clean image
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial

USER java
WORKDIR /home/java
