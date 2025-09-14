# LibreOffice image

## Overview
Docker image including Libre Office (installed from the Debian package).

## Run Libre Office
```bash
docker run --rm -it -v $(pwd):/home/office -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY olbat/libreoffice
```

## Run Libre Office - Writer
```bash
docker run --rm -it -v $(pwd):/home/office -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY olbat/libreoffice lowriter
```

### Included package
* libreoffice
* libreoffice-l10n-fr
* libreoffice-l10n-de
* libreoffice-l10n-es
* libreoffice-l10n-it
* hunspell-en-gb
* hunspell-en-us
* hunspell-fr
* hunspell-de-de
* hunspell-es
* hunspell-it
* mythes-en-us
* mythes-fr
* mythes-de
* mythes-es
* mythes-it
* hyphen-en-us
* hyphen-en-gb
* hyphen-fr
* hyphen-de
* hyphen-es
* hyphen-it
* default-jre
* sudo

### Included extensions
* LanguageTool
