ARG BASE_USER
FROM ${BASE_USER}/nodejs
ARG MAINTAINER_LABEL
ARG SOURCE_URL_LABEL
ARG IMAGE_URL_LABEL
ARG DOCUMENTATION_URL_LABEL
LABEL org.opencontainers.image.authors="$MAINTAINER_LABEL" \
      org.opencontainers.image.source="$SOURCE_URL_LABEL" \
      org.opencontainers.image.documentation="$DOCUMENTATION_URL_LABEL" \
      org.opencontainers.image.url="$IMAGE_URL_LABEL" \
      org.opencontainers.image.licenses="GPL-3.0-only" \
      org.opencontainers.image.title="JSON Resume image" \
      org.opencontainers.image.description="Docker image including JSON Resume."

# Install the resume and themes packages (from the website)
RUN sudo npm install -g --unsafe-perm=true \
  resume-cli \
  jsonresume-theme-elegant \
  jsonresume-theme-paper \
  jsonresume-theme-kendall \
  jsonresume-theme-modern \
  jsonresume-theme-classy \
  jsonresume-theme-class \
  jsonresume-theme-short \
  jsonresume-theme-slick \
  jsonresume-theme-kwan \
  jsonresume-theme-onepage \
  jsonresume-theme-spartan \
  jsonresume-theme-stackoverflow
