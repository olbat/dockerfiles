#!/bin/bash

set -e
set -x

. build.env
buildargs="--build-arg BASE_USER=$BASE_USER"
buildargs+=" --build-arg MAINTAINER=$MAINTAINER"

dir=${IMAGE%/}
for dockerfile in ${dir:-*}/Dockerfile*
do
	[ -e $dockerfile ] || (echo "ERROR: file not found $dockerfile"; exit 1)
	user=${BUILD_USER:-olbat}
	image=$(dirname "$dockerfile")
	filename=$(basename "$dockerfile")
	tag=${filename##*.}
	[ "$filename" == "$tag" ] && tag=latest # no file extension

	docker build $buildargs -f $dockerfile -t $user/$image:$tag $image/
	[ $PUSH ] && docker push $user/$image:$tag
done
