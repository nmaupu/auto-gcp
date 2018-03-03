default: build
.PHONY: build

image_builder=hashicorp/packer:1.1.3
zone=europe-west1-b
INGRESS_CONTROLLER_PORT ?= 30080
INGRESS_RECEIVER_VERSION ?= 1.0

check-params:
ifndef PROJECT_ID
	$(error PROJECT_ID is not defined)
endif
ifndef INGRESS_CONTROLLER_PORT
	$(error INGRESS_CONTROLLER_PORT is not defined)
endif
ifndef IMAGE_NAME_PREFIX
	$(error IMAGE_NAME_PREFIX is not defined)
endif

build: check-params
	# Getting all domains to generate a dedicated certificate
	$(eval certs := $(shell ls -1 $(NGINX_EXTRA_CONFS_DIR) | grep 'ssl-' | sed -e 's/ssl-//' -e 's/.conf$$//'))
	@echo $(certs)
	docker run --rm \
	  -v $(TF_CREDS):/root/.google.json \
	  -e GOOGLE_APPLICATION_CREDENTIALS=/root/.google.json \
	  -e PROJECT_ID=$(PROJECT_ID) \
	  -e ZONE=$(zone) \
	  -e IMAGE_NAME_PREFIX=$(IMAGE_NAME_PREFIX) \
	  -e INGRESS_CONTROLLER_PORT=$(INGRESS_CONTROLLER_PORT) \
	  -e INGRESS_RECEIVER_VERSION="$(INGRESS_RECEIVER_VERSION)" \
	  -e CERT_DOMAINS="$(certs)" \
	  -v `pwd`:`pwd` \
	  -w `pwd` \
	  $(image_builder) \
	  build packer.json
