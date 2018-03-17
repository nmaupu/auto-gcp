.PHONY: helm-init ingress-watchers ingress-controllers kube-ops-view mysql gke-storage-ssd check-vault

default: deploy

deploy: helm-init
	make ingress-watchers
	make ingress-controllers
	make kube-ops-view
	make mysql

ingress-watchers:
	helm install --namespace kube-system --name ing-pub  -f kube-ingwatcher/values-pub.yaml  kube-ingwatcher
	helm install --namespace kube-system --name ing-priv -f kube-ingwatcher/values-priv.yaml kube-ingwatcher

ingress-controllers:
	helm install --namespace kube-system --name rp-priv -f traefik/values-priv.yaml traefik
	helm install --namespace kube-system --name rp-pub  -f traefik/values-pub.yaml  traefik

kube-ops-view:
	helm install --namespace kube-system kube-ops-view

mysql: check-vault gke-storage-ssd
	helm install \
	  --namespace db \
	  --name mysql \
	  --set mysqlRootPassword=$(shell vault read -field password secret/gce/mysql) \
	  --set persistence.storageClass=ssd \
	  --set persistence.size=2Gi \
	  --set resources.limits.cpu=200m \
	  --set resources.requests.memory=128Mi \
	  --set resources.limits.memory=256Mi \
	  stable/mysql

dolibarr: gke-storage-ssd
	helm install \
	  --namespace tools \
	  --set ingress.hosts="{$(shell vault read -field appurl secret/gce/mysql-dolibarr)}" \
	  --set conf.db_host=mysql-mysql.db \
	  --set conf.db_username=$(shell vault read -field username secret/gce/mysql-dolibarr) \
	  --set conf.db_password=$(shell vault read -field password secret/gce/mysql-dolibarr) \
	  --set conf.cookie_key=$(shell vault read -field cookie_key secret/gce/mysql-dolibarr) \
	  dolibarr

helm-init:
	kubectl apply -f tiller-rbac.yaml
	helm init --upgrade --service-account=tiller
	sleep 8

gke-storage-ssd:
	# SSD Storage class
	kubectl apply -f gke-storage-ssd.yaml

check-vault:
	@vault list secret >/dev/null 2>&1
