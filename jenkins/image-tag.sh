#!/bin/sh

GIT_REV=`git rev-parse --short=8 HEAD`
TS=`date +%s`
TAG=lts-${GIT_REV}-${TS}
IMAGE_TAG=kingdonb/jenkins:${TAG}

echo $IMAGE_TAG
