#!/bin/bash

set -e
set -x

dir=${IMAGE%/}
for envfile in ${dir:-*}/gen-*.env
do
	type=$(basename $envfile .env)
	type=${type##*-}
	script="./gen-${type}-dockerfile.sh"
	dockerfile=$(dirname $envfile)/Dockerfile.$type
	[ -x $script ] && $script $envfile > $dockerfile
done
