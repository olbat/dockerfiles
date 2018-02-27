ARG BASE_USER
ARG MAINTAINER
FROM ${BASE_USER}/nodejs
MAINTAINER $MAINTAINER

# Install wkhtmltopdf to be able to generate PDF resumes
RUN sudo apt-get update && sudo apt-get install -y wkhtmltopdf

# Install hackmyresume and jsonresume themes packages
RUN sudo npm install -g \
  hackmyresume \
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
