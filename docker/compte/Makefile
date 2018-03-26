GIT_REPO=https://github.com/nmaupu/compte.git

default: push
.PHONY: default build tag tag-latest check-docker-hub clean

NAME=compte
VERSION=1.6
REMOTE_NAME=$(DOCKER_ID_USER)/$(NAME)

build: check-docker-hub
	docker build --build-arg GIT_REPO=$(GIT_REPO) --no-cache -t $(NAME):$(VERSION) .

tag: build
	docker tag $(NAME):$(VERSION) $(REMOTE_NAME):$(VERSION)

push: tag
	docker push $(REMOTE_NAME):$(VERSION)

check-docker-hub:
ifndef DOCKER_ID_USER
	$(error ERROR! DOCKER_ID_USER environment variable must be defined)
endif
