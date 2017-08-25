#!/bin/bash

set -e

DESTFILE=Dockerfile.light
BASEIMAGE=$(grep ^FROM Dockerfile | cut -d' ' -f2)
GPGIMAGE=${BASEIMAGE%%/*}/${PWD##/*/}:$(readlink Dockerfile | cut -d. -f2)
MAINTAINER=$(grep ^MAINTAINER Dockerfile | cut -d' ' -f2)

cat <<EOF >$DESTFILE
FROM $BASEIMAGE
MAINTAINER $MAINTAINER
RUN apt-get update && apt-get install -y gnupg pinentry-tty

FROM scratch
MAINTAINER $MAINTAINER
COPY --from=0 /usr/bin/gpg /usr/bin/gpg
COPY --from=0 /usr/bin/gpg-agent /usr/bin/gpg-agent
COPY --from=0 /usr/bin/pinentry-tty /usr/bin/pinentry
$(docker run --rm $GPGIMAGE ldd /usr/bin/gpg /usr/bin/gpg-agent \
	| grep -v ':\|linux-vdso.so' | cut -d\> -f2 | cut -d\( -f1 \
	| sort -u | xargs -n1 -I{} echo "COPY --from=0 {} {}")
ENTRYPOINT ["/usr/bin/gpg"]
EOF
