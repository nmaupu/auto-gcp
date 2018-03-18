.PHONY: helm-init ingress-watchers ingress-controllers kube-ops-view mysql dolibarr gke-storage-ssd check-vault
default: upgrade-all

## All tasks can install or upgrade if already installed

DB_NAMESPACE     = db
DB_BACKUP_BUCKET = nma-backup
DB_BACKUP_OPTS   = --set mysql.host=mysql.mysql.$(DB_NAMESPACE)
DB_BACKUP_OPTS  += --set bucket=$(DB_BACKUP_BUCKET)
DB_BACKUP_OPTS  += --set secret.name=mysql-mysql
DB_BACKUP_OPTS  += --set secret.key=mysql-root-password

upgrade-all: helm-init
	make ingress-watchers
	make ingress-controllers
	make kube-ops-view
	make mysql
	make dolibarr

ingress-watchers:
	helm upgrade --install --namespace kube-system -f kube-ingwatcher/values-priv.yaml ing-priv kube-ingwatcher
	helm upgrade --install --namespace kube-system -f kube-ingwatcher/values-pub.yaml  ing-pub  kube-ingwatcher

ingress-controllers:
	helm upgrade --install --namespace kube-system -f traefik/values-priv.yaml rp-priv traefik
	helm upgrade --install --namespace kube-system -f traefik/values-pub.yaml  rp-pub  traefik

kube-ops-view:
	helm upgrade --install --namespace kube-system romantic-euler kube-ops-view

mysql: check-vault gke-storage-ssd
	helm upgrade --install \
	  --namespace $(DB_NAMESPACE) \
	  --set mysqlRootPassword=$(shell vault read -field password secret/gce/mysql) \
	  --set persistence.storageClass=ssd \
	  --set persistence.size=2Gi \
	  --set resources.limits.cpu=200m \
	  --set resources.requests.memory=128Mi \
	  --set resources.limits.memory=256Mi \
		mysql \
	  stable/mysql
	helm upgrade --install \
		--namespace $(DB_NAMESPACE) \
		--set job.schedule="0 3 * * *" \
		--set mysql.database=mysql \
		$(DB_BACKUP_OPTS) \
		bak-mysql \
		mysql-backup

dolibarr: gke-storage-ssd
	helm upgrade --install \
	  --namespace tools \
	  --set ingress.hosts="{$(shell vault read -field appurl secret/gce/mysql-dolibarr)}" \
	  --set conf.db_host=mysql-mysql.$(DB_NAMESPACE) \
	  --set conf.db_username=$(shell vault read -field username secret/gce/mysql-dolibarr) \
	  --set conf.db_password=$(shell vault read -field password secret/gce/mysql-dolibarr) \
	  --set conf.cookie_key=$(shell vault read -field cookie_key secret/gce/mysql-dolibarr) \
		quiet-ragdoll \
	  dolibarr
	helm upgrade --install \
	  --namespace tools \
		--set job.schedule="0 3 * * *" \
		--set mysql.database=dolibarr \
		$(DB_BACKUP_OPTS) \
		bak-dolibarr \
		mysql-backup

helm-init:
	kubectl apply -f tiller-rbac.yaml
	helm init --upgrade --service-account=tiller
	sleep 8

gke-storage-ssd:
	# GKE SSD Storage class
	kubectl apply -f gke-storage-ssd.yaml

check-vault:
	@vault list secret >/dev/null 2>&1
