Introduction
============
This dockefile is a self-signed certificate docker registry, base image is registry:2
and it only generate the self-signed certificate to the registry.


Usage
=====
All the environment variable is as same as the original docker registry and
only two new environment variables be introduced.

- OUTPUT: the the cert file, default is **domain.crt**
- KEY_OUTPUT: the key filename, default is **domain.key**

You can use the following command to start a registry with self-signed certificate
```sh
docker run REGISTRY_HTTP_ADDR=0.0.0.0:443 -p 443:443 hwchiu/self-signed-docker-registry
```

