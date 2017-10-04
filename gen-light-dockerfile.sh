#!/bin/bash

set -e

[ $# -ge 1 ] && . $1

BASEIMAGE=${BASEIMAGE:-olbat/debian:stable}
EXECUTABLES=${EXECUTABLES:-"/bin/bash /bin/ls"}
FILES=${FILES:-"/etc/debian_version"}
SHARED_LIBRARIES=${SHARED_LIBRARIES:-}

cat <<EOF
FROM $BASEIMAGE AS base

FROM scratch
ARG MAINTAINER
MAINTAINER \$MAINTAINER

$(echo -n $EXECUTABLES | xargs -d' ' -n1 -I{} echo "COPY --from=base {} {}")

$(echo -n $FILES | xargs -d' ' -n1 -I{} echo "COPY --from=base {} {}")

$(docker run --rm $BASEIMAGE sh -c "ldd $EXECUTABLES $SHARED_LIBRARIES" \
	| grep -v ':\|linux-vdso.so' | cut -d\> -f2 | cut -d\( -f1 \
	| sort -u | xargs -n1 -I{} echo "COPY --from=base {} {}")

CMD ["$(echo $EXECUTABLES | cut -d' ' -f1)"]
EOF
