#!/bin/bash

set -euo pipefail

. build.env
buildargs="--build-arg BASE_USER=$BASE_USER"
buildargs+=" --build-arg MAINTAINER=$MAINTAINER"
user=${BUILD_USER:-olbat}

function generate_job() {
	local dir=$1
	local dockerfile=$2
	local image=$3
	local args=$4

	if [[ "$image" =~ /:latest$/ ]]
	then
		args="--destination ${image//latest/$(date +%Y-%m-%d)} $args"
	fi

	cat <<EOF
$image:
  script:
    - >-
      /kaniko/executor
      --context "$dir"
      --dockerfile "$dockerfile"
      --destination "$image"
      $args

EOF
}


cat <<EOF
---
default:
  image:
    name: gcr.io/kaniko-project/executor:debug
    entrypoint: [""]
  before_script:
    - mkdir -p /kaniko/.docker
    - cp $DOCKER_CONFIG_FILE /kaniko/.docker/config.json
  retry: 1
  timeout: 10m

EOF

for dockerfile in */Dockerfile*
do
	[ -e $dockerfile ] || (echo "ERROR: file not found $dockerfile"; exit 1)
	dirname=$(dirname "$dockerfile")
	filename=$(basename "$dockerfile")
	args="$buildargs "

	if [ -f $dirname/tags.env -a $filename == "Dockerfile" ]
	then
		BASE_TAGS=
		. $dirname/tags.env
		for tag in $BASE_TAGS
		do
			args+=" --build-arg BASE_TAG=$tag"
			image=${user}/${dirname}:${tag}

			generate_job "$dirname"/ "$dockerfile" "$image" "$args"
		done
	else
		tag=${filename##*.}
		[ "$filename" == "$tag" ] && tag=latest # no file extension
	        args+=" --build-arg BASE_TAG=$tag"
		image=${user}/${dirname}:${tag}

		generate_job "$dirname"/ "$dockerfile" "$image" "$args"
	fi
done
