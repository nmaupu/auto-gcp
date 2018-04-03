.PHONY: helm-init ingress-watchers ingress-controllers kube-ops-view mysql dolibarr compte phpmyadmin wp-blogvoy run-mysql-client gke-storage-ssd check-vault check-param-priv1-domain
default: upgrade-all

## All tasks can install or upgrade if already installed

## Parameters:
#    - PRIV1_DOMAIN

DB_NAMESPACE     = db
DB_BACKUP_BUCKET = nma-backup
DB_BACKUP_OPTS   = --set mysql.host=mysql-mysql.$(DB_NAMESPACE)
DB_BACKUP_OPTS  += --set bucket=$(DB_BACKUP_BUCKET)
DB_BACKUP_OPTS  += --set secret.name=mysql-mysql
DB_BACKUP_OPTS  += --set secret.key=mysql-root-password

upgrade-all: helm-init
	make ingress-watchers
	make ingress-controllers
	make kube-ops-view
	make mysql
	make dolibarr
	make compte
	make phpmyadmin
	make wp-blogvoy

ingress-watchers: check-param-priv1-domain
	helm upgrade --install --namespace kube-system -f kube-ingwatcher/values-priv.yaml --set target.addr=rproxy-priv.$(PRIV1_DOMAIN) ing-priv kube-ingwatcher
	helm upgrade --install --namespace kube-system -f kube-ingwatcher/values-pub.yaml  --set target.addr=rproxy-pub.$(PRIV1_DOMAIN)  ing-pub  kube-ingwatcher

ingress-controllers: check-param-priv1-domain
	helm upgrade --install --namespace kube-system -f traefik/values-priv.yaml --set ingress.host=traefik-priv.$(PRIV1_DOMAIN) rp-priv traefik
	helm upgrade --install --namespace kube-system -f traefik/values-pub.yaml  --set ingress.host=traefik-pub.$(PRIV1_DOMAIN)  rp-pub  traefik

kube-ops-view: check-param-priv1-domain
	helm upgrade --install --namespace kube-system --set ingress.host=kov.$(PRIV1_DOMAIN) romantic-euler kube-ops-view

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
	  --namespace $(DB_NAMESPACE) \
	  --set job.schedule="0 4 * * *" \
	  --set mysql.database=dolibarr \
	  $(DB_BACKUP_OPTS) \
	  bak-dolibarr \
	  mysql-backup

compte: check-vault
	helm upgrade --install \
	  --namespace tools \
	  --set ingress.hosts="$(shell vault read -field appurl secret/gce/mysql-compte)" \
	  --set db.addr=mysql-mysql.$(DB_NAMESPACE) \
	  --set db.name=compte \
	  --set db.user=$(shell vault read -field username secret/gce/mysql-compte) \
	  --set db.password=$(shell vault read -field password secret/gce/mysql-compte) \
	  --set ingress.host=$(shell vault read -field appurl secret/gce/mysql-compte) \
	  serene-kepler \
	  compte
	helm upgrade --install \
	  --namespace $(DB_NAMESPACE) \
	  --set job.schedule="0 1 * * *" \
	  --set mysql.database=compte \
	  $(DB_BACKUP_OPTS) \
	  bak-compte \
	  mysql-backup

phpmyadmin: check-param-priv1-domain
	helm upgrade --install \
	  --namespace tools \
	  --set ingress.host=phpmyadmin.$(PRIV1_DOMAIN) \
	  --set pma.host=mysql-mysql.$(DB_NAMESPACE) \
	  cocky-cori \
	  phpmyadmin

wp-blogvoy: check-vault
	$(eval sm_key    := $(shell vault read -field sm_key    secret/gce/wp-plugins/wp-stateless | base64))
	$(eval sm_bucket := $(shell vault read -field sm_bucket secret/gce/wp-plugins/wp-stateless))
	$(eval sm_sa     := $(shell gcloud iam service-accounts list --format=json | jq -r '.[].email | match("^wp-stateless.*").string'))
	helm upgrade --install \
	  --namespace blog \
	  --set db.addr=mysql-mysql.$(DB_NAMESPACE) \
	  --set db.name=wp_blogvoy \
	  --set db.user=$(shell vault read -field username secret/gce/mysql-wp-blogvoy) \
	  --set db.password=$(shell vault read -field password secret/gce/mysql-wp-blogvoy) \
	  --set ingress.hosts={"blog.fossar.net"} \
		--set wp_plugins.wp_stateless.sm_service_account=$(sm_sa) \
		--set wp_plugins.wp_stateless.sm_key=$(sm_key) \
		--set wp_plugins.wp_stateless.sm_bucket=$(sm_bucket) \
	  boring-elion \
	  wp-blogvoy
	helm upgrade --install \
	  --namespace $(DB_NAMESPACE) \
	  --set job.schedule="0 4 * * *" \
	  --set mysql.database=wp_blogvoy \
	  $(DB_BACKUP_OPTS) \
	  bak-wp-blogvoy \
	  mysql-backup

helm-init:
	kubectl apply -f tiller-rbac.yaml
	helm init --upgrade --service-account=tiller
	sleep 8

gke-storage-ssd:
	# GKE SSD Storage class
	kubectl apply -f gke-storage-ssd.yaml

run-mysql-client:
	kubectl run --rm --namespace $(DB_NAMESPACE) -i --tty mysql-client --image=docker.io/nmaupu/mysql-client:1.1 --overrides=' \
{ \
  "apiVersion": "extensions/v1beta1", \
  "spec": { \
    "template": { \
      "spec": { \
        "containers": [ \
          { \
            "name": "mysql-client", \
            "image": "docker.io/nmaupu/mysql-client:1.1", \
            "args": [ \
              "-h", "mysql-mysql.$(DB_NAMESPACE)", "-u", "root", "--password=$$(MYSQL_PASSWORD)" \
            ], \
            "stdin": true, \
            "stdinOnce": true, \
            "tty": true, \
            "env": [ \
              { \
                "name": "MYSQL_PASSWORD", \
                "valueFrom": { \
                  "secretKeyRef": { \
                    "name": "mysql-mysql", \
                    "key": "mysql-root-password" \
                  } \
                } \
              } \
            ] \
          } \
        ] \
      } \
    } \
  } \
} \
'

check-vault:
	@vault list secret >/dev/null 2>&1

check-param-priv1-domain:
ifndef PRIV1_DOMAIN
	$(error Provide PRIV1_DOMAIN as parameter)
endif
