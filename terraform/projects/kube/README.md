# Building

`rproxy_priv_sources` are ip from which to allow traffic from.

```
make init
TF_VAR_rproxy_priv_sources='["1.1.1.1/32", "2.2.2.2/32", "3.3.3.3/32"]' make plan
TF_VAR_rproxy_priv_sources='["1.1.1.1/32", "2.2.2.2/32", "3.3.3.3/32"]' make apply
```

# Configuring local kubectl

```
gcloud container clusters get-credentials nma-kube --zone europe-west1-b --project <project_id>
kubectl config get-contexts
kubectl config use-context <context-name>
```
