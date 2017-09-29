#!/bin/bash

set -e
set -x

dir=${IMAGE%/}
for envfile in ${dir:-*}/light.env
do
	dockerfile=$(dirname $envfile)/Dockerfile.light
	./gen-light-dockerfile.sh $envfile > $dockerfile
done
