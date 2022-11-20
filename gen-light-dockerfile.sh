#!/bin/bash

set -e

[ $# -ge 1 ] && . $1

BASEIMAGE=${BASEIMAGE:-debian:stable-slim}
EXECUTABLES=${EXECUTABLES:-"/bin/bash /bin/cat"}
FILES=${FILES:-"/etc/debian_version"}
SHARED_LIBRARIES=${SHARED_LIBRARIES:-}
EXECUTABLES_DESTINATION=${EXECUTABLES_DESTINATION:-/bin/}


cat <<EOF
FROM $BASEIMAGE AS base

FROM scratch
ARG MAINTAINER
MAINTAINER \$MAINTAINER

COPY --from=base \\
$(echo -n $EXECUTABLES | xargs -d' ' -n1 -I{} echo -e "\t{} \\")
	$EXECUTABLES_DESTINATION

$(docker run --rm $BASEIMAGE sh -c "ldd $EXECUTABLES $SHARED_LIBRARIES" \
	| grep '^[[:space:]]\+/' \
	| cut -d\> -f2 | cut -d\( -f1 | sort -u \
	| xargs -n1 -I{} echo "COPY --from=base {} {}")

$([ $SHARED_LIBRARIES ] && {
	echo -e "COPY --from=base \\" \
	&& echo -n $SHARED_LIBRARIES | xargs -d' ' -n1 -I{} echo -e "\t{} \\" \
	&& echo -e "\t/lib/"; })

COPY --from=base \\
$(docker run --rm $BASEIMAGE sh -c "ldd $EXECUTABLES $SHARED_LIBRARIES" \
	| grep -v '^[[:space:]]\+/\|:\|linux-vdso.so\|not a dynamic executable'\
	| cut -d\> -f2 | cut -d\( -f1 | sort -u \
	| xargs -n1 -I{} echo -e "\t{} \\")
	/lib/

$(echo -n $FILES | xargs -d' ' -n1 -I{} echo "COPY --from=base {} {}")

CMD ["$(echo $EXECUTABLES | cut -d' ' -f1)"]
EOF
