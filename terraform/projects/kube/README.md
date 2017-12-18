# Building

```
TF_VAR_gke_username=$(vault read -field=username secret/gce/gke) TF_VAR_gke_password=$(vault read -field=password secret/gce/gke) make init
TF_VAR_gke_username=$(vault read -field=username secret/gce/gke) TF_VAR_gke_password=$(vault read -field=password secret/gce/gke) make plan
TF_VAR_gke_username=$(vault read -field=username secret/gce/gke) TF_VAR_gke_password=$(vault read -field=password secret/gce/gke) make apply
```

# Configuring local kubectl

```
gcloud container clusters get-credentials nma-kube --zone europe-west1-b --project <project_id>
kubectl config get-contexts
kubectl config use-context <context-name>
```
