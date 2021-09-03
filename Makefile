GIT_REV	:= $(shell git rev-parse --short=8 HEAD)
TS 	:= $(shell date +%s)
TAG	:= lts-$(GIT_REV)-$(TS)
IMAGE_TAG := kingdonb/jenkins:$(TAG)

.PHONY: build
build:
	docker build . -t $(IMAGE_TAG)

.PHONY: bust-cache
bust-cache:
	docker build --no-cache . -t $(IMAGE_TAG)

.PHONY: push
push: build
	docker push $(IMAGE_TAG)
