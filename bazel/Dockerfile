ARG MAINTAINER
FROM debian:stable-slim
MAINTAINER $MAINTAINER

# Install java 8, gpg and bazel package (from upstream repository)
RUN apt-get update \
&& apt-get install -y \
  gpg \
  curl \
  default-jdk \
&& echo "deb http://storage.googleapis.com/bazel-apt stable jdk1.8" \
  > /etc/apt/sources.list.d/bazel.list \
&& curl https://bazel.build/bazel-release.pub.gpg | apt-key add - \
&& apt-get update \
&& apt-get install -y bazel \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Setup environment
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64

# Run bazel a first time for it to self-extract
RUN /usr/bin/bazel version

# Entrypoint
ENTRYPOINT ["/usr/bin/bazel"]
