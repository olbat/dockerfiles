# KCachegrind image [![Build Status](https://travis-matrix-badges.herokuapp.com/repos/olbat/dockerfiles/branches/master/10)](https://travis-ci.org/olbat/dockerfiles)

## Overview
Docker image including the KCacheGrind tool.

## Run
```bash
docker run --rm -it -v $(pwd):/home/user -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY olbat/kcachegrind
```

## Included packages
* kcachegrind
