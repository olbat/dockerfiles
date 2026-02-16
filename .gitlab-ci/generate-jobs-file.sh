#!/bin/bash

set -euo pipefail

. build.env
multi_platform_images=()
buildargs="--build-arg BASE_USER=$BASE_USER"
buildargs+=" --build-arg MAINTAINER=$MAINTAINER"
user=${BUILD_USER:-olbat}


function get_daily_image_name() {
	local image=$1
	if [[ "$image" =~ :latest$ ]]; then
		echo "${image//latest/$(date +%Y-%m-%d)}"
	else
		echo "$image-$(date +%Y-%m-%d)"
	fi
}

function generate_job() {
	local dir=$1
	local dockerfile=$2
	local image=$3
	local args=$4
	local platform=${5:-}

	local daily_image=$(get_daily_image_name "$image")

	if [ -n "$platform" ]; then
		image="$image-$platform"
		daily_image="$daily_image-$platform"
		runner_tag="saas-linux-small-$platform"
	else
	    runner_tag="saas-linux-small-amd64"
	fi

	cat <<EOF
$image:
  stage: build
  tags: [$runner_tag]
  script:
    - >-
      docker build
      --file "$dockerfile"
      --tag "$image"
      --tag "$daily_image"
      $args
      "$dir"
    - docker push "$image"
    - docker push "$daily_image"

EOF
}


# Base configuration
cat <<EOF
---
stages:
  - build
  - manifests

variables
  DOCKER_TLS_CERTDIR: "/certs"

default:
  image: docker:29-cli
  services:
    - docker:29-dind
  before_script:
    - mkdir -p ~/.docker
    - cp $DOCKER_CONFIG_FILE ~/.docker/config.json
  retry: 1
  timeout: 10m

EOF


# Image creation jobs
for dockerfile in */Dockerfile*
do
	grep -qxF "$dockerfile" .gitlab-ci/build-ignore 2>/dev/null && continue
	grep -qxF "$dockerfile" .gitlab-ci/multi-platform-builds 2>/dev/null && multi_platform=true || multi_platform=false

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

			if $multi_platform; then
				generate_job "$dirname"/ "$dockerfile" "$image" "$args" "amd64"
				generate_job "$dirname"/ "$dockerfile" "$image" "$args" "arm64"
				multi_platform_images+=("$image" $(get_daily_image_name "$image"))
			else
				generate_job "$dirname"/ "$dockerfile" "$image" "$args"
			fi
		done
	else
		tag=${filename##*.}
		[ "$filename" == "$tag" ] && tag=latest # no file extension
	        args+=" --build-arg BASE_TAG=$tag"
		image=${user}/${dirname}:${tag}

		if $multi_platform; then
			generate_job "$dirname"/ "$dockerfile" "$image" "$args" "amd64"
			generate_job "$dirname"/ "$dockerfile" "$image" "$args" "arm64"
			multi_platform_images+=("$image" $(get_daily_image_name "$image"))
		else
			generate_job "$dirname"/ "$dockerfile" "$image" "$args"
		fi
	fi
done


# Manifests generation job, for multi-platform images support
# (see https://docs.docker.com/build/building/multi-platform/)
[ ${#multi_platform_images[@]} -eq 0 ] && return

cat <<-EOF
build-and-push-multiplatform-manifests:
  stage: manifests
  script:
EOF
for img in "${multi_platform_images[@]}"; do
    cat <<-EOF
	    - docker manifest create $img ${img}-amd64 ${img}-arm64
	    - docker manifest push $img
	EOF
done
