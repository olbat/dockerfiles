#!/bin/bash

set -euo pipefail

. build.env
buildargs="--build-arg BASE_USER=$BASE_USER"
buildargs+=" --build-arg MAINTAINER=$MAINTAINER"
user=${BUILD_USER:-olbat}

function is_arm64_enabled() {
	local dockerfile=$1
	grep -qxF "$dockerfile" .gitlab-ci/arm64-builds 2>/dev/null
}

function generate_job() {
	local dir=$1
	local dockerfile=$2
	local image=$3
	local args=$4
	local platform=${5:-}

	local job_name="$image"
	local job_image="$image"
	local runner_tag="saas-linux-small-amd64"
	local daily_image

	# also generate a unique daily tag name for the image
	if [[ "$image" =~ :latest$ ]]; then
		daily_image="${image//latest/$(date +%Y-%m-%d)}"
	else
		daily_image="$image-$(date +%Y-%m-%d)"
	fi

	if [ -n "$platform" ]; then
		job_name="$image-$platform"
		job_image="$image-$platform"
		daily_image="$daily_image-$platform"
		runner_tag="saas-linux-small-$platform"
	fi

	args="--destination $daily_image $args"

	cat <<EOF
$job_name:
  stage: build
  tags: [$runner_tag]
  script:
    - >-
      /kaniko/executor
      --context "$dir"
      --dockerfile "$dockerfile"
      --destination "$job_image"
      $args

EOF
}

manifest_script=""
manifest_needs=""

function collect_manifest_image() {
	local image=$1
	local daily_image

	if [[ "$image" =~ :latest$ ]]; then
		daily_image="${image//latest/$(date +%Y-%m-%d)}"
	else
		daily_image="$image-$(date +%Y-%m-%d)"
	fi

	manifest_script+="    - crane index append --flatten -m $image-amd64 -m $image-arm64 -t $image
"
	manifest_script+="    - crane index append --flatten -m $daily_image-amd64 -m $daily_image-arm64 -t $daily_image
"
	manifest_needs+="    - \"$image-amd64\"
    - \"$image-arm64\"
"
}

function generate_manifest_job() {
	[ -z "$manifest_script" ] && return

	cat <<EOF
multiarch-manifests:
  stage: manifests
  image:
    name: gcr.io/go-containerregistry/crane:debug
    entrypoint: [""]
  before_script:
    - mkdir -p ~/.docker
    - cp \$DOCKER_CONFIG_FILE ~/.docker/config.json
  script:
$manifest_script
EOF
}


cat <<EOF
---
stages:
  - build
  - manifests

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
	grep -qxF "$dockerfile" .gitlab-ci/build-ignore 2>/dev/null && continue
	[ -e $dockerfile ] || (echo "ERROR: file not found $dockerfile"; exit 1)

	dirname=$(dirname "$dockerfile")
	filename=$(basename "$dockerfile")
	args="$buildargs "
	arm64_enabled=false
	is_arm64_enabled "$dockerfile" && arm64_enabled=true

	if [ -f $dirname/tags.env -a $filename == "Dockerfile" ]
	then
		BASE_TAGS=
		. $dirname/tags.env
		for tag in $BASE_TAGS
		do
			args+=" --build-arg BASE_TAG=$tag"
			image=${user}/${dirname}:${tag}

			if $arm64_enabled; then
				generate_job "$dirname"/ "$dockerfile" "$image" "$args" "amd64"
				generate_job "$dirname"/ "$dockerfile" "$image" "$args" "arm64"
				collect_manifest_image "$image"
			else
				generate_job "$dirname"/ "$dockerfile" "$image" "$args"
			fi
		done
	else
		tag=${filename##*.}
		[ "$filename" == "$tag" ] && tag=latest # no file extension
	        args+=" --build-arg BASE_TAG=$tag"
		image=${user}/${dirname}:${tag}

		if $arm64_enabled; then
			generate_job "$dirname"/ "$dockerfile" "$image" "$args" "amd64"
			generate_job "$dirname"/ "$dockerfile" "$image" "$args" "arm64"
			collect_manifest_image "$image"
		else
			generate_job "$dirname"/ "$dockerfile" "$image" "$args"
		fi
	fi
done

generate_manifest_job
