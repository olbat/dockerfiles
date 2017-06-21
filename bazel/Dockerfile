FROM olbat/debian:stable
MAINTAINER devel@olbat.net

# Install java 8, gpg and bazel package (from upstream repository)
RUN apt-get update \
&& apt-get install -y \
  gpg \
  openjdk-8-jdk \
&& echo "deb http://storage.googleapis.com/bazel-apt stable jdk1.8" \
  > /etc/apt/sources.list.d/bazel.list \
&& apt-key adv --keyserver pool.sks-keyservers.net --recv-key 3D5919B448457EE0 \
&& apt-get update \
&& apt-get install -y bazel \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Setup environment
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64

# Run bazel a first time for it to self-extract
RUN /usr/bin/bazel version

# Entrypoint
ENTRYPOINT ["/usr/bin/bazel"]
