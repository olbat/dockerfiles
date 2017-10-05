#!/bin/bash

set -e
set -x

. build.env
buildargs="--build-arg BASE_USER=$BASE_USER"
buildargs+=" --build-arg MAINTAINER=$MAINTAINER"
user=${BUILD_USER:-olbat}
dir=${IMAGE%/}

for dockerfile in ${dir:-*}/Dockerfile*
do
	[ -e $dockerfile ] || (echo "ERROR: file not found $dockerfile"; exit 1)
	dirname=$(dirname "$dockerfile")
	filename=$(basename "$dockerfile")
	args="-f $dockerfile $buildargs"

	if [ -f $dirname/tags.env -a $filename == "Dockerfile" ]
	then
		BASE_TAGS=
		. $dirname/tags.env
		for tag in $BASE_TAGS
		do
			args="$args --build-arg BASE_TAG=$tag"
			docker build $args -t $user/$dirname:$tag $dirname/
			[ $PUSH ] && docker push $user/$dirname:$tag
		done
	else
		tag=${filename##*.}
		[ "$filename" == "$tag" ] && tag=latest # no file extension

		docker build $args -t $user/$dirname:$tag $dirname/
		[ $PUSH ] && docker push $user/$dirname:$tag
	fi
done
