# Based on https://cloud.google.com/community/tutorials/managing-gcp-projects-with-terraform
# Create env variables as such :
# export GCLOUD_REGION=europe-west1
# export TF_VAR_main_user_account=xxx@xxx.xxx
# export TF_VAR_org_id=xxxxx
# export TF_VAR_billing_account=xxxxx
# export TF_ADMIN=${USER}-terraform-admin
# export TF_CREDS=~/.config/gcloud/xxxxx.json
# 
# To get these information, use :
# gcloud organizations list
# gcloud beta billing accounts list
#
# First login is to be done with :
# gcloud auth login

bootstrap: backend.tf
	# Create the Terraform Admin Project
	gcloud projects create ${TF_ADMIN} \
	  --organization ${TF_VAR_org_id} \
	  --set-as-default
	
	gcloud beta billing projects link ${TF_ADMIN} \
	  --billing-account ${TF_VAR_billing_account}
	
	# Create the Terraform service account
	gcloud iam service-accounts create terraform \
	  --display-name "Terraform admin account"
	
	gcloud iam service-accounts keys create ${TF_CREDS} \
	  --iam-account terraform@${TF_ADMIN}.iam.gserviceaccount.com
	
	# Enable api
	gcloud services enable cloudresourcemanager.googleapis.com
	gcloud services enable cloudbilling.googleapis.com
	gcloud services enable iam.googleapis.com
	gcloud services enable compute.googleapis.com
	
	# Set up remote state in Cloud Storage
	gsutil mb -l ${GCLOUD_REGION} -c regional -p ${TF_ADMIN} gs://${TF_ADMIN}
	gsutil versioning set on gs://${TF_ADMIN}

	@make roles

roles:
	# Roles management
	gcloud projects add-iam-policy-binding ${TF_ADMIN} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/viewer
	gcloud projects add-iam-policy-binding ${TF_ADMIN} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/storage.admin
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/resourcemanager.projectCreator
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/resourcemanager.projectIamAdmin
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/iam.serviceAccountActor
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/billing.user
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/resourcemanager.organizationAdmin
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/compute.admin
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/dns.admin
	gcloud organizations add-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/container.clusterAdmin

roles-destroy:
	# Not all roles are destroyed !
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/resourcemanager.projectCreator
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/resourcemanager.projectIamAdmin
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/iam.serviceAccountActor
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/billing.user
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/resourcemanager.organizationAdmin
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/compute.admin
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/dns.admin
	gcloud organizations remove-iam-policy-binding ${TF_VAR_org_id} \
	  --member serviceAccount:terraform@${TF_ADMIN}.iam.gserviceaccount.com \
	  --role roles/container.clusterAdmin

backend.tf:
	@echo "terraform {" > $@
	@echo "  backend \"gcs\" {" >> $@
	@echo "    bucket  = \"${TF_ADMIN}\"" >> $@
	@echo "    prefix  = \"/terraform.tfstate\"" >> $@
	@echo "    project = \"${TF_ADMIN}\"" >> $@
	@echo "  }" >> $@
	@echo "}" >> $@

destroy-I-know-what-I-am-doing:
	# Very dangerous! be sure to have destroyed all
	# resources created via terraform before using that
	gcloud projects delete ${TF_ADMIN}
	@make roles-destroy

.PHONY: bootstrap destroy-I-know-what-I-am-doing backend.tf roles
