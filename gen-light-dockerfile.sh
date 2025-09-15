#!/bin/bash

set -e

[ $# -ge 1 ] && . $1

BASEIMAGE=${BASEIMAGE:-debian:stable-slim}
EXECUTABLES=${EXECUTABLES:-"/bin/bash /bin/cat"}
FILES=${FILES:-"/etc/debian_version"}
SHARED_LIBRARIES=${SHARED_LIBRARIES:-}
EXECUTABLES_DESTINATION=${EXECUTABLES_DESTINATION:-/bin/}
LIBRARIES_DESTINATION=${LIBRARIES_DESTINATION:-/lib/}
ROOT_DIR=${ROOT_DIR:-/tmp/rootdir}


cat <<EOF
FROM $BASEIMAGE AS base

RUN mkdir -p $ROOT_DIR$EXECUTABLES_DESTINATION
RUN cp -L \\
$(echo -n $EXECUTABLES | sed -e 's:/\(.*\)\[:/\1[[]:g' | xargs -d' ' -n1 -I{} echo -e "\t{} \\")
	$ROOT_DIR$EXECUTABLES_DESTINATION

RUN mkdir -p $ROOT_DIR$LIBRARIES_DESTINATION
$([ $SHARED_LIBRARIES ] && {
	echo -e "RUN cp -L \\" \
	&& echo -n $SHARED_LIBRARIES | xargs -d' ' -n1 -I{} echo -e "\t{} \\" \
	&& echo -e "\t$ROOT_DIR$LIBRARIES_DESTINATION"; })
RUN cp -L \\
$(docker run --rm $BASEIMAGE sh -c "ldd $EXECUTABLES $SHARED_LIBRARIES" \
	| grep -v '^[[:space:]]\+/\|:\|linux-vdso.so\|not a dynamic executable' \
	| cut -d\> -f2 | cut -d\( -f1 | sort -u \
	| xargs -n1 -I{} echo -e "\t{} \\")
	$ROOT_DIR$LIBRARIES_DESTINATION

$(docker run --rm $BASEIMAGE sh -c "ldd $EXECUTABLES $SHARED_LIBRARIES" \
	| grep '^[[:space:]]\+/' \
	| cut -d\> -f2 | cut -d\( -f1 | sort -u \
	| xargs -n1 -I{} echo "RUN install -D {} $ROOT_DIR{}")

$(echo -n $FILES \
	| xargs -d' ' -n1 -I{} echo "RUN mkdir -p "'`dirname '"$ROOT_DIR{}"'`'" \\
	&& cp -rL {} $ROOT_DIR{}")


FROM scratch
ARG MAINTAINER
MAINTAINER \$MAINTAINER

COPY --from=0 $ROOT_DIR/ /

CMD ["$(echo $EXECUTABLES | cut -d' ' -f1 | xargs basename | xargs -I{} echo $EXECUTABLES_DESTINATION{})"]
EOF
