FROM debian:testing-slim
ARG MAINTAINER_LABEL
ARG SOURCE_URL_LABEL
ARG IMAGE_URL_LABEL
ARG DOCUMENTATION_URL_LABEL
LABEL org.opencontainers.image.authors="$MAINTAINER_LABEL" \
      org.opencontainers.image.source="$SOURCE_URL_LABEL" \
      org.opencontainers.image.documentation="$DOCUMENTATION_URL_LABEL" \
      org.opencontainers.image.url="$IMAGE_URL_LABEL" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.title="KCachegrind image" \
      org.opencontainers.image.description="Docker image including the KCacheGrind tool."

# Install kcachegrind
RUN apt-get update \
&& apt-get install -y kcachegrind \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

CMD ["/usr/bin/kcachegrind"]
