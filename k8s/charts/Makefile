## All tasks can install or upgrade if already installed

## Parameters:
#    - PRIV1_DOMAIN (e.g. f*****.***)
#    - PUB1_DOMAIN (e.g. b*****.**)

# Update 2025-10-06: bitnami deprecated their entire docker images for:
# - bitnamisecure: secure docker images (no tag, just latest afaik)
# - bitnamilegacy: legacy docker images (not updated anymore)

DB_NAMESPACE           = db
DB_SVC_NAME            = mysql
DB_BACKUP_BUCKET       = nma-backup
DB_BACKUP_OPTS         = --set mysql.host=$(DB_SVC_NAME).$(DB_NAMESPACE)
DB_BACKUP_OPTS        += --set bucket=$(DB_BACKUP_BUCKET)
DB_BACKUP_OPTS        += --set secret.name=$(DB_SVC_NAME)
DB_BACKUP_OPTS        += --set secret.key=mysql-root-password
TELEGRAM_BOT_NAMESPACE = telegram-bot

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
	make nuki-logger

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

# www will be redirected by wordpress to main domain
.PHONY: wordpress-bicnic
wordpress-bicnic: gke-storage check-vault ns-tools ns-db gke-snapshotclass check-param-pub1-domain
	helm upgrade --install \
	  --namespace tools \
	  -f wordpress-bicnic/values.yaml \
	  --set wordpress.ingress.hostname=${PUB1_DOMAIN} \
	  --set wordpress.ingress.extraHosts[0].name=www.${PUB1_DOMAIN} \
	  --set wordpress.ingress.extraHosts[0].path=/ \
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

# NOTE: standard-csi storage class min size is 1Gi
.PHONY: nuki-logger
nuki-logger: gke-storage check-vault
	helm upgrade --install \
		--namespace tools \
    --set global.security.allowInsecureImages=true \
		--set image.repository=bitnamisecure/memcached \
    --set image.tag=latest \
		--set architecture=high-availability \
		--set replicaCount=1 \
		--set affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].weight=100 \
		--set affinity.podAntiAffinity.preferredDuringSchedulingIgnoredDuringExecution[0].podAffinityTerm.topologyKey=kubernetes.io/hostname \
		--set resources.requests.cpu=10m \
		--set resources.limits.cpu=100m \
		--set resources.requests.memory=50Mi \
		--set resources.limits.cpu=100m \
		--set resources.limits.memory=100Mi \
		--set image.debug=true \
		--set persistence.enabled=true \
		--set persistence.storageClass=csi-standard \
		--set persistence.size=1Gi \
		memcached \
		oci://registry-1.docker.io/bitnamicharts/memcached
	helm upgrade --install \
		--namespace telegram-bot \
		--create-namespace \
		--set image.repository=nmaupu/nuki-logger \
		--set image.tag=0.1.5-new \
		--set extraEnvVars[0].name=GOMAXPROCS \
		--set-string extraEnvVars[0].value=1 \
		--set botConfig.address_id=$(shell vault read -field=nuki-address-id secret/telegram-bot/nuki-logger) \
		--set botConfig.smartlock_id=$(shell vault read -field=nuki-smartlock-id secret/telegram-bot/nuki-logger) \
		--set botConfig.nuki_api_token=$(shell vault read -field=nuki-api-token secret/telegram-bot/nuki-logger) \
		--set botConfig.health_check_port=8080 \
		--set botConfig.memcached_servers[0]=memcached.tools:11211 \
		--set botConfig.telegram_bot.enabled=true \
		--set botConfig.telegram_bot.sender_name=telegram \
		--set botConfig.telegram_bot.default_check_in=15:00 \
		--set botConfig.telegram_bot.default_check_out=11:00 \
		--set botConfig.restrict_private_chat_ids[0]=$(shell vault read -field=telegram-private-chat-ids secret/telegram-bot/nuki-logger | cut -d, -f1) \
		--set botConfig.restrict_private_chat_ids[1]=$(shell vault read -field=telegram-private-chat-ids secret/telegram-bot/nuki-logger | cut -d, -f2) \
		--set botConfig.senders[0].name=telegram \
		--set botConfig.senders[0].telegram.token=$(shell vault read -field=telegram-token secret/telegram-bot/nuki-logger) \
		--set botConfig.senders[0].telegram.chat_id=$(shell vault read -field=telegram-chat-id secret/telegram-bot/nuki-logger) \
		--set botConfig.senders[0].telegram.include_date=true \
		--set botConfig.senders[0].telegram.timezone=Europe/Paris \
		--set botConfig.senders[1].name=console \
		--set botConfig.senders[1].console.include_date=true \
		--set botConfig.senders[1].console.timezone=Europe/Paris \
		--set botArgs[0]="--config=/bot/config.yaml" \
		--set botArgs[1]="--sender=console" \
		--set botArgs[2]="--sender=telegram" \
		--set botArgs[3]="server" \
		--set botArgs[4]="--interval=10s" \
		nuki-logger \
		telegram-bot

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

.PHONY: check-param-pub1-domain
check-param-pub1-domain:
ifndef PUB1_DOMAIN
	$(error Provide PUB1_DOMAIN as parameter)
endif
