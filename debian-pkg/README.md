# Debian packaging image [![Build Status](https://secure.travis-ci.org/olbat/dockerfiles.png?branch=master)](https://travis-ci.org/olbat/dockerfiles)

## Overview
Docker image including Debian development and packaging tools.

## Configuration
The _sudo_ package is installed by default, password checking has been disabled.

_Note:_ don't forget to customize `DEBFULLNAME` and `DEBEMAIL` environment variables.

## Run examples
Run dch (in the current directory)
```bash
docker run -it --rm -v $(pwd):/src -w /src \
  -e DEBFULLNAME='Name' -e DEBEMAIL='name@domain.tld' \
  olbat/debian-pkg dch -i
```

Run debuild (testing)
```bash
docker run -it --rm -v ${PWD}:/home/debian -w /home/debian/$(basename $PWD) \
  -e DEBFULLNAME='Name' -e DEBEMAIL='name@domain.tld' \
  olbat/debian-pkg:testing debuild -us -uc
```

Open a shell (stable)
```bash
docker run -it --rm -v $(pwd):/src -w /src \
  -e DEBFULLNAME='Name' -e DEBEMAIL='name@domain.tld' \
  olbat/debian-pkg:stable /bin/bash
```

### Included packages

Debian packaging tools:
* build-essential
* debhelper
* dh-systemd
* devscripts
* fakeroot
* dpatch
* equivs
* lintian
* quilt
* nvi

Debian automatic packaging tools:
* dh-make
* dh-make-golang
* dh-make-perl
* python3-stdeb
* pypi2deb
* gem2deb
* npm2deb

Build automation tools:
* make
* cmake
* automake
* autoconf
* rake
* node-jake
* help2man

Source code management tools:
* git
* git-buildpackage
* pristine-tar
* subversion
