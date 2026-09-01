export TF_VAR_region ?= ${GCLOUD_REGION}
export GOOGLE_PROJECT=${TF_ADMIN}

ifeq ($(strip $(TF_ADMIN)),)
$(error specify TF_ADMIN var for terraform tfstate location)
endif
ifeq ($(strip $(TF_CREDS)),)
$(error specify TF_CREDS var pointing to a GCP credentials json file)
endif
ifeq ($(wildcard $(TF_CREDS)),)
$(error TF_CREDS file not found: $(TF_CREDS))
endif

export GOOGLE_CREDENTIALS=$(shell cat $(TF_CREDS))

default: plan
.PHONY: init plan apply destroy

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply -auto-approve

destroy:
	terraform destroy

clean:
	rm -rf .terraform
