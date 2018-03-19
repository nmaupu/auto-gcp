default: build
.PHONY: build

image_builder=hashicorp/packer:1.1.3
zone=europe-west1-b
INGRESS_RECEIVER_VERSION ?= 1.3
LEGO_VERSION ?= 0.4.1
# TF_VAR_main_user_account should have been defined when configuring terraform
LE_EMAIL_ADDRESS ?= $(TF_VAR_main_user_account)

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
ifndef LE_EMAIL_ADDRESS
	$(error LE_EMAIL_ADDRESS is not defined)
endif
ifndef INGRESS_RECEIVER_PORT
	$(error INGRESS_RECEIVER_PORT is not defined)
endif

build: check-params
	docker run --rm \
	  -v $(TF_CREDS):/root/.google.json \
	  -e GOOGLE_APPLICATION_CREDENTIALS=/root/.google.json \
	  -e PROJECT_ID=$(PROJECT_ID) \
	  -e ZONE=$(zone) \
	  -e IMAGE_NAME_PREFIX=$(IMAGE_NAME_PREFIX) \
	  -e INGRESS_CONTROLLER_PORT=$(INGRESS_CONTROLLER_PORT) \
	  -e INGRESS_RECEIVER_VERSION="$(INGRESS_RECEIVER_VERSION)" \
	  -e LE_EMAIL_ADDRESS="$(LE_EMAIL_ADDRESS)" \
	  -e LEGO_VERSION="$(LEGO_VERSION)" \
	  -e INGRESS_RECEIVER_PORT="$(INGRESS_RECEIVER_PORT)" \
	  -v `pwd`:`pwd` \
	  -w `pwd` \
	  $(image_builder) \
	  build packer.json

# When reinstalling rproxy machines, sometimes, they switch their IPs...
# Waiting for the DNS to propagate, ing-watchers pods send ingress to wrong rproxy.
# Using a different port fixes that.
pub:
	make build INGRESS_CONTROLLER_PORT=30080 IMAGE_NAME_PREFIX=rproxy-pub  INGRESS_RECEIVER_PORT=6565

priv:
	make build INGRESS_CONTROLLER_PORT=30081 IMAGE_NAME_PREFIX=rproxy-priv INGRESS_RECEIVER_PORT=6566
