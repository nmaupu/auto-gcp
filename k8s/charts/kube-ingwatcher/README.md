# Installation

```
helm install --namespace kube-system --name ing-pub  -f values-pub.yaml  .
helm install --namespace kube-system --name ing-priv -f values-priv.yaml .
```
