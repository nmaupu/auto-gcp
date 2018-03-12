KUBE_INGWATCHER_VERSION=1.0

default: push
.PHONY: default build tag tag-latest check-docker-hub clean

NAME=kube-ingwatcher
VERSION=$(KUBE_INGWATCHER_VERSION)
REMOTE_NAME=$(DOCKER_ID_USER)/$(NAME)

build: check-docker-hub tmp/kube-ingwatcher
	docker build --build-arg KUBE_INGWATCHER_VERSION=$(KUBE_INGWATCHER_VERSION) --no-cache -t $(NAME):$(VERSION) .

tag: build
	docker tag $(NAME):$(VERSION) $(REMOTE_NAME):$(VERSION)

tag-latest: push
	docker tag $(REMOTE_NAME):$(VERSION) $(REMOTE_NAME):latest
	docker push $(REMOTE_NAME):latest

push: tag
	docker push $(REMOTE_NAME):$(VERSION)

tmp:
	mkdir -p tmp

clean:
	rm -rf tmp

tmp/kube-ingwatcher: tmp
	@wget --continue -O tmp/kube-ingwatcher https://github.com/nmaupu/kube-ingwatcher/releases/download/v${KUBE_INGWATCHER_VERSION}/kube-ingwatcher_linux-amd64

check-docker-hub:
ifndef DOCKER_ID_USER
	$(error ERROR! DOCKER_ID_USER environment variable must be defined)
endif
