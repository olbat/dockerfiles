#!/bin/bash

set -euo pipefail
set -x

# important: images are automatically built from a different script,
#            see .gitlab-ci/generate-jobs-file.sh

. build.env

basebuildargs="--build-arg BASE_USER=$BASE_USER"
basebuildargs+=" --build-arg MAINTAINER_LABEL=$MAINTAINER_LABEL"
basebuildargs+=" --build-arg SOURCE_URL_LABEL=$SOURCE_URL_LABEL"
basebuildargs+=" --build-arg REPO_URL_LABEL=$REPO_URL_LABEL"
user=${BUILD_USER:-olbat}
dir=${IMAGE:-*}
dir=${dir%/}

function build_and_push_docker_image {
	local imagename=$1
	local tag=$2
	local dirname=$3
	local buildargs=$4

	buildargs+=" --build-arg BASE_TAG=$tag"
	buildargs+=" --build-arg IMAGE_URL_LABEL=https://hub.docker.com/r/$imagename"
	buildargs+=" --build-arg DOCUMENTATION_URL_LABEL=$REPO_URL_LABEL/blob/master/$dirname/README.md"

	timeout 300 docker build $buildargs -t $imagename:$tag $dirname/

	if [ ${PUSH_IMAGES:-} ]
	then
		docker push $imagename:$tag

		today=$(date +%Y-%m-%d)

		if [ "$tag" == "latest" ]
		then
			docker tag $imagename:$tag $imagename:$today
			docker push $imagename:$today
		else
			docker tag $imagename:$tag $imagename:$tag-$today
			docker push $imagename:$tag-$today
		fi
	fi

}

for dockerfile in $dir/Dockerfile*
do
	[ -e $dockerfile ] || (echo "ERROR: file not found $dockerfile"; exit 1)

	dirname=$(dirname "$dockerfile")
	filename=$(basename "$dockerfile")
	args="--pull -f $dockerfile $basebuildargs"

	if [ -f $dirname/tags.env -a $filename == "Dockerfile" ]
	then
		BASE_TAGS=
		. $dirname/tags.env
		for tag in $BASE_TAGS
		do
			build_and_push_docker_image $user/$dirname $tag $dirname "$args"
		done
	else
		[ "$filename" == "Dockerfile" ] && tag=latest || tag=${filename##*.}
		build_and_push_docker_image $user/$dirname $tag $dirname "$args"
	fi

done
