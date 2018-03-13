deploy:
	make ingress-watchers
	make ingress-controllers
	make kube-ops-view
	#make mysql

ingress-watchers: helm-init
	helm install --namespace kube-system --name ing-pub  -f kube-ingwatcher/values-pub.yaml  kube-ingwatcher
	helm install --namespace kube-system --name ing-priv -f kube-ingwatcher/values-priv.yaml kube-ingwatcher

ingress-controllers: helm-init
	helm install --namespace kube-system --name rp-priv -f traefik/values-priv.yaml traefik
	helm install --namespace kube-system --name rp-pub  -f traefik/values-pub.yaml  traefik

kube-ops-view: helm-init
	helm install --namespace kube-system kube-ops-view

mysql: helm-init gke-storage-ssd
	helm install \
	  --namespace db \
	  --name mysql \
	  --set persistence.storageClass=ssd \
	  --set persistence.size=2Gi \
	  --set resources.limits.cpu=200m \
	  --set resources.requests.memory=128Mi \
	  --set resources.limits.memory=256Mi \
	  stable/mysql

helm-init:
	helm init --upgrade
	sleep 5

gke-storage-ssd:
	# SSD Storage class
	kubectl apply -f gke-storage-ssd.yaml
