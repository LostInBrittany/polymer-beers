#!/bin/bash

die() {
    echo "$0: die - $*" >&2
    exit 1
}

IMAGE_TAG=mjbright/polymer
DOCKERFILE=Dockerfile
DOCKERHUB_USER=mjbright

echo; echo "---- build image: ----"
#CMD="docker build -t $IMAGE_TAG ."
CMD="docker build -f $DOCKERFILE -t $IMAGE_TAG ."
echo $CMD
$CMD || die "Build failed"

