## All tasks can install or upgrade if already installed

## Parameters:
#    - PRIV1_DOMAIN (e.g. f*****.***)

DB_NAMESPACE     = db
DB_SVC_NAME      = mysql
DB_BACKUP_BUCKET = nma-backup
DB_BACKUP_OPTS   = --set mysql.host=$(DB_SVC_NAME).$(DB_NAMESPACE)
DB_BACKUP_OPTS  += --set bucket=$(DB_BACKUP_BUCKET)
DB_BACKUP_OPTS  += --set secret.name=$(DB_SVC_NAME)
DB_BACKUP_OPTS  += --set secret.key=mysql-root-password

.PHONY: default
default: upgrade-all

.PHONY: upgrade-all
upgrade-all:
	make priority
	make gke-storage
	make gke-snapshotclass
	make ingress-watchers
	make ingress-controllers
	#make kube-ops-view
	make mysql
	make dolibarr
	make compte
	make wordpress-bicnic
	make phpmyadmin

.PHONY: ingress-watchers
ingress-watchers: check-param-priv1-domain
	helm upgrade --install --namespace kube-system -f kube-ingwatcher/values-priv.yaml --set target.addr=rproxy-priv.$(PRIV1_DOMAIN) ing-priv kube-ingwatcher
	helm upgrade --install --namespace kube-system -f kube-ingwatcher/values-pub.yaml  --set target.addr=rproxy-pub.$(PRIV1_DOMAIN)  ing-pub  kube-ingwatcher

.PHONY: ingress-controllers
ingress-controllers: check-param-priv1-domain
	helm upgrade --install --namespace kube-system -f traefik/values-priv.yaml traefik-priv traefik
	helm upgrade --install --namespace kube-system -f traefik/values-pub.yaml  traefik-pub  traefik

#.PHONY: kube-ops-view
#kube-ops-view: check-param-priv1-domain
#	helm upgrade --install --namespace kube-system --set ingress.host=kov.$(PRIV1_DOMAIN) romantic-euler kube-ops-view

.PHONY: mysql
mysql: check-vault gke-storage ns-db
	$(eval workload_identity_sa_email_db_backups := $(shell gcloud iam service-accounts list --format=json | jq -r '.[] | select(.name|test("backup")) | .email'))
	helm upgrade --install \
	  --namespace $(DB_NAMESPACE) \
	  -f mysql/values.yaml \
	  --set mysql.serviceAccount.annotations."iam\.gke\.io\/gcp-service-account"=$(workload_identity_sa_email_db_backups) \
	  --set mysql.auth.rootPassword=$(shell vault read -field password secret/gce/mysql) \
	  mysql \
	  mysql
	helm upgrade --install \
	  --namespace $(DB_NAMESPACE) \
	  --set job.schedule="0 3 * * *" \
	  --set mysql.database=mysql \
	  --set serviceAccountName=mysql \
	  $(DB_BACKUP_OPTS) \
	  bak-mysql \
	  mysql-backup

.PHONY: dolibarr
dolibarr: gke-storage check-vault ns-tools ns-db gke-snapshotclass
	helm upgrade --install \
	  --namespace tools \
	  --set image.tag=8.0.2 \
	  --set ingress.hosts="{$(shell vault read -field appurl secret/gce/mysql-dolibarr)}" \
	  --set conf.db_host=$(DB_SVC_NAME).$(DB_NAMESPACE) \
	  --set conf.db_username=$(shell vault read -field username secret/gce/mysql-dolibarr) \
	  --set conf.db_password=$(shell vault read -field password secret/gce/mysql-dolibarr) \
	  --set conf.cookie_key=$(shell vault read -field cookie_key secret/gce/mysql-dolibarr) \
	  dolibarr \
	  dolibarr
	helm upgrade --install \
	  --namespace $(DB_NAMESPACE) \
	  --set job.schedule="0 4 * * *" \
	  --set mysql.database=dolibarr \
		--set serviceAccountName=mysql \
	  $(DB_BACKUP_OPTS) \
	  bak-dolibarr \
	  mysql-backup
	helm upgrade --install \
		--namespace tools \
		--set pvc=dolibarr \
		--set maxKeep="14 days" \
		--set job.schedule="34 4 * * *" \
		pv-snap-dolibarr \
		pv-snapshotter

.PHONY: compte
compte: check-vault ns-tools ns-db
	helm upgrade --install \
	  --namespace tools \
	  --set ingress.hosts="$(shell vault read -field appurl secret/gce/mysql-compte)" \
	  --set db.addr=$(DB_SVC_NAME).$(DB_NAMESPACE) \
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
	  --set serviceAccountName=mysql \
	  $(DB_BACKUP_OPTS) \
	  bak-compte \
	  mysql-backup

.PHONY: wordpress-bicnic
wordpress-bicnic: gke-storage check-vault ns-tools ns-db gke-snapshotclass check-param-priv1-domain
	helm upgrade --install \
	  --namespace tools \
	  -f wordpress-bicnic/values.yaml \
	  --set wordpress.ingress.hostname=bicnic-test.${PRIV1_DOMAIN} \
	  --set mysql.externalDatabase.user=$(shell vault read -field username secret/gce/mysql-wp-blogvoy) \
	  --set mysqlPassword=$(shell vault read -field password secret/gce/mysql-wp-blogvoy) \
	  wp-bicnic \
	  wordpress-bicnic
	helm upgrade --install \
	  --namespace $(DB_NAMESPACE) \
	  --set job.schedule="30 2 * * *" \
	  --set mysql.database=wordpress_bicnic \
	  --set serviceAccountName=mysql \
	  $(DB_BACKUP_OPTS) \
	  bak-wp-bicnic \
	  mysql-backup
	helm upgrade --install \
		--namespace tools \
		--set pvc=wp-bicnic-wordpress \
		--set maxKeep="30 days" \
		--set job.schedule="0 */12 * * *" \
		pv-snap-wordpress-bicnic \
		pv-snapshotter

.PHONY: phpmyadmin
phpmyadmin: check-param-priv1-domain ns-tools
	helm upgrade --install \
	  --namespace tools \
	  -f phpmyadmin/values.yaml \
	  --set ingress.hostname=phpmyadmin.$(PRIV1_DOMAIN) \
	  --set db.host=mysql.$(DB_NAMESPACE) \
	  pma \
	  bitnami/phpmyadmin

.PHONY: priority
priority:
	kubectl apply -f high-priority.yaml

.PHONY: gke-storage
gke-storage:
	# GKE SSD Storage class
	kubectl apply -f gke-storage-ssd.yaml
	kubectl apply -f gke-storage-csi-std.yaml

.PHONY: gke-snapshotclass
gke-snapshotclass:
	# GKE persistent disk CSI snapshotclass
	kubectl apply -f gke-snapshotclass.yaml

.PHONY: ns-tools
ns-tools:
	kubectl create ns tools || true

.PHONY: ns-db
ns-db:
	kubectl create ns $(DB_NAMESPACE) || true

.PHONY: run-mysql-client
run-mysql-client:
	kubectl run --rm --namespace $(DB_NAMESPACE) -i --tty mysql-client --image=docker.io/nmaupu/mysql-client:1.1 --overrides='{"kind":"Pod","apiVersion":"v1","spec":{"containers":[{"name":"mysql-client","image":"docker.io/nmaupu/mysql-client:1.1","args":["-h","mysql.db","-u","root","--password=$$(MYSQL_PASSWORD)"],"stdin":true,"stdinOnce":true,"tty":true,"env":[{"name":"MYSQL_PASSWORD","valueFrom":{"secretKeyRef":{"name":"mysql","key":"mysql-root-password"}}}]}]}}'

.PHONY: check-vault
check-vault:
	@vault list secret >/dev/null 2>&1

.PHONY: check-param-priv1-domain
check-param-priv1-domain:
ifndef PRIV1_DOMAIN
	$(error Provide PRIV1_DOMAIN as parameter)
endif
