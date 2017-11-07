#!/bin/bash

set -e

[ $# -ge 1 ] && . $1

BASEIMAGE=${BASEIMAGE:-olbat/debian:stable}
EXECUTABLES=${EXECUTABLES:-"/bin/bash /bin/cat"}
FILES=${FILES:-"/etc/debian_version"}
SHARED_LIBRARIES=${SHARED_LIBRARIES:-}

cat <<EOF
FROM $BASEIMAGE AS base

FROM scratch
ARG MAINTAINER
MAINTAINER \$MAINTAINER

COPY --from=base \\
$(echo -n $EXECUTABLES | xargs -d' ' -n1 -I{} echo -e "\t{} \\")
	/bin/

$(docker run --rm $BASEIMAGE sh -c "ldd $EXECUTABLES $SHARED_LIBRARIES" \
	| grep '^[[:space:]]\+/' \
	| cut -d\> -f2 | cut -d\( -f1 | sort -u \
	| xargs -n1 -I{} echo "COPY --from=base {} {}")

COPY --from=base \\
$(docker run --rm $BASEIMAGE sh -c "ldd $EXECUTABLES $SHARED_LIBRARIES" \
	| grep -v '^[[:space:]]\+/\|:\|linux-vdso.so\|not a dynamic executable'\
	| cut -d\> -f2 | cut -d\( -f1 | sort -u \
	| xargs -n1 -I{} echo -e "\t{} \\")
	/lib/

$(echo -n $FILES | xargs -d' ' -n1 -I{} echo "COPY --from=base {} {}")

CMD ["$(echo $EXECUTABLES | cut -d' ' -f1)"]
EOF
