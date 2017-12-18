export TF_VAR_region ?= ${GCLOUD_REGION}
export GOOGLE_PROJECT=${TF_ADMIN}
export GOOGLE_CREDENTIALS=$(cat ${TF_CREDS})

ifndef GOOGLE_PROJECT
	$(error specify GOOGLE_PROJECT var for terraform tfstate location)
endif

default: plan
.PHONY: init plan apply destroy

init:
	terraform init

plan:
	terraform plan

apply:
	terraform apply

destroy:
	terraform destroy

clean:
	rm -rf .terraform
