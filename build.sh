#!/usr/bin/env bash
set -e
image="$1"
tag="$2"

if [ -z "$FORCE_BUILD" ] && docker manifest inspect "$image:$tag" > /dev/null 2>&1; then
    echo "Skipping $image:$tag, already exists."
    exit 0
fi

docker build --build-arg "ACTIVEMQ_VERSION=$tag" \
    --tag "$image:$tag" .
docker push "$image:$tag"
