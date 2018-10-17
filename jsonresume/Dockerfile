ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/nodejs
MAINTAINER $MAINTAINER

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
