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
	args="--pull -f $dockerfile $buildargs"

	if [ -f $dirname/tags.env -a $filename == "Dockerfile" ]
	then
		BASE_TAGS=
		. $dirname/tags.env
		for tag in $BASE_TAGS
		do
			args+=" --build-arg BASE_TAG=$tag"
			timeout 300 docker build $args -t $user/$dirname:$tag $dirname/
			[ $PUSH ] && docker push $user/$dirname:$tag
		done
	else
		[ "$filename" == "Dockerfile" ] && tag=latest || tag=${filename##*.}
	        args+=" --build-arg BASE_TAG=$tag"

		timeout 300 docker build $args -t $user/$dirname:$tag $dirname/

		if [ $PUSH ]
		then
			docker push $user/$dirname:$tag

			if [ "$tag" == "latest" ]
			then
				today=$(date +%Y-%m-%d)
				docker tag $user/$dirname:$tag $user/$dirname:$today
				docker push $user/$dirname:$today
			fi
		fi
	fi
done
