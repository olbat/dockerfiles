FROM olbat/debian:testing
MAINTAINER devel@olbat.net

# Install java 8 and gpg
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update \
  && apt-get install -y gpg \
  && apt-get clean

# Install the bazel package
RUN echo "deb http://storage.googleapis.com/bazel-apt stable jdk1.8" \
  > /etc/apt/sources.list.d/bazel.list
RUN apt-key adv --keyserver pool.sks-keyservers.net --recv-key 3D5919B448457EE0
RUN apt-get update \
  && apt-get install -y openjdk-8-jdk bazel \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* && mkdir /var/lib/apt/lists/partial
ENV DEBIAN_FRONTEND ""

# Setup environment
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Run bazel a first time for it to self-extract
RUN /usr/bin/bazel version

# Entrypoint
ENTRYPOINT ["/usr/bin/bazel"]
