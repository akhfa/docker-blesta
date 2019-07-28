#!/bin/sh
set -e
DOCKERHUB_USERNAME=$1
DOCKERHUB_PASS=$2
DOCKERHUB_REPO=$3
DIR_LIST=$(find -depth -type d -links 2 | grep -v "git")
docker login --username $DOCKERHUB_USERNAME --password $DOCKERHUB_PASS
for DIR in $DIR_LIST; do
  TAG_LIST=$(cat $DIR/TAG_LIST)
  for TAG in $TAG_LIST; do
    docker build -t $DOCKERHUB_REPO:$TAG $DIR
    docker push $DOCKERHUB_REPO:$TAG
  done
done
