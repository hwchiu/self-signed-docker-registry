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
- CN: the **Common Name** fields of the certificate, default is localhosta
- DIRECTORY: You can get the self-signed certificated files when you set this value, the script will copy those files into this location and you should also mount the volume into the container.

You can use the following command to start a registry with self-signed certificate.
- Use CN with domain name
```sh
$ docker run \
--restart always \
--name registry \
-v `pwd`:/certs \
-e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
-e DIRECTORY=/certs \
-e CN=domainname \
-v /mnt/registry:/var/lib/registry \
-p 443:443 \
hwchiu/self-signed-docker-registry
```
- Use CN with specified IP address
```sh
$ docker run \
--restart always \
--name registry \
-v `pwd`:/certs \
-e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
-e DIRECTORY=/certs \
-e CN=192.168.0.106 \
-v /mnt/registry:/var/lib/registry \
-p 443:443 \
hwchiu/self-signed-docker-registry
```


