This project contains all projects' definition.
This has to be separated from projects'code because when destroying, terraform deletes first the project **and** associated services (api access). So all resources cannot be deleted...
The project content has to be deleted first and only then, the project.

# Building

```
TF_VAR_kube_dns_name = "pub.example.com." TF_VAR_kube_priv_dns_name = "priv.example.com." make
```

This activate DNS api and sometimes, api has not enough time to activate before zones are created and thus terraform fails with an error. Re-run and it should work as expected !

To be able to use those domain, you have to register output NS into your registrar.
Beware: when refreshing zone (recreating for example), NS can change !
