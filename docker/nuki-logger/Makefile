NUKI_LOGGER_VERSION=0.1.2

default: push
.PHONY: default build tag tag-latest check-docker-hub clean

NAME=nuki-logger
VERSION=$(NUKI_LOGGER_VERSION)
REMOTE_NAME=$(DOCKER_ID_USER)/$(NAME)

build: check-docker-hub tmp/nuki-logger-${NUKI_LOGGER_VERSION}
	docker build -t $(NAME):$(VERSION) \
		--build-arg NUKI_LOGGER_VERSION=$(NUKI_LOGGER_VERSION) .

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

tmp/nuki-logger-${NUKI_LOGGER_VERSION}: tmp
	@wget --continue -O tmp/nuki-logger-${NUKI_LOGGER_VERSION} https://github.com/nmaupu/nuki-logger/releases/download/v${NUKI_LOGGER_VERSION}/nuki-logger-v${NUKI_LOGGER_VERSION}-linux_x64

check-docker-hub:
ifndef DOCKER_ID_USER
	$(error ERROR! DOCKER_ID_USER environment variable must be defined)
endif
