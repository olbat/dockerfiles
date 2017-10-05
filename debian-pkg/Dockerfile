ARG BASE_USER
ARG BASE_TAG
ARG MAINTAINER
FROM ${BASE_USER}/debian:$BASE_TAG
MAINTAINER $MAINTAINER

# Add debian sources repository and install Debian devel. and packaging tools
RUN sed -i \
  "/$BASE_TAG[[:space:]]\+main[[:space:]]*$/\
  {p; s/^\([[:space:]]*\)deb\([[:space:]]\+.*\)$/\1deb-src\2/}" \
  /etc/apt/sources.list \
&& apt-get update \
&& apt-get install -y \
  sudo \
  build-essential \
  debhelper \
  dh-systemd \
  devscripts \
  fakeroot \
  dpatch \
  equivs \
  lintian \
  quilt \
  nvi \
  git \
  git-buildpackage \
  pristine-tar \
  dh-make \
  dh-make-golang \
  dh-make-perl \
  python3-stdeb \
  pypi2deb \
  gem2deb \
  make \
  cmake \
  automake \
  autoconf \
  rake \
  node-jake \
  help2man \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/*

# Add debian user and disable sudo password checking + display a warning if
# the the DEBFULLNAME or DEBEMAIL variables were not overridden at launch time
RUN useradd \
  --groups=sudo \
  --create-home \
  --home-dir=/home/debian \
  --shell=/bin/bash \
  debian \
&& sed -i '/%sudo[[:space:]]/ s/ALL[[:space:]]*$/NOPASSWD:ALL/' /etc/sudoers \
&& /bin/echo -e \
  '[ "$DEBEMAIL" == "user@domaim.tld" -o "$DEBFULLNAME" == "Debian" ] \\\n'\
  '  && echo "WARNING: please do not forget to customize" \\\n'\
  '    "DEBFULLNAME and DEBEMAIL env vars"' \
  >> /home/debian/.bashrc

# Setup environment
ENV DEBFULLNAME Debian
ENV DEBEMAIL user@domain.tld
USER debian
WORKDIR /home/debian

# Default shell
CMD ["/bin/bash","--login","-i"]
