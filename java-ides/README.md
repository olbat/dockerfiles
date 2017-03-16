# Java IDEs image [![Build Status](https://travis-matrix-badges.herokuapp.com/repos/olbat/dockerfiles/branches/master/6)](https://travis-ci.org/olbat/dockerfiles)

## Overview
Docker image including Java IDEs (installed from the Debian package).

## Run Eclipse
```bash
docker run --rm -it -v $(pwd):/home/java -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY olbat/java-ides eclipse
```

## Run Netbeans
```bash
docker run --rm -it -v $(pwd):/home/java -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY olbat/java-ides netbeans
```

### Included package
* eclipse, eclipse-jdt
* netbeans

### Included package (from olbat/java-devel)
* openjdk-8-jdk
* maven
* ant
* ivy
* gradle
