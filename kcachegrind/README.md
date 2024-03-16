# KCachegrind image

## Overview
Docker image including the KCacheGrind tool.

## Run
```bash
docker run --rm -it -v $(pwd):/home/user -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY olbat/kcachegrind
```

## Included packages
* kcachegrind
