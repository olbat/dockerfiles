ARG MAINTAINER
FROM debian:stable-slim
MAINTAINER $MAINTAINER

# Install java, gpg and bazel package (from upstream repository)
RUN apt-get update \
&& apt-get install -y \
  gpg \
  curl \
  default-jdk \
&& curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor > /usr/share/keyrings/bazel-archive-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] http://storage.googleapis.com/bazel-apt stable jdk1.8" \
  > /etc/apt/sources.list.d/bazel.list \
&& apt-get update \
&& apt-get install -y bazel \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Run bazel a first time for it to self-extract
RUN /usr/bin/bazel version

# Entrypoint
ENTRYPOINT ["/usr/bin/bazel"]
