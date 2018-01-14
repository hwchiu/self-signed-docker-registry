#!/bin/sh
echo $@
set -e

create_certificate()
{
WORKDIR=/
KEYPATH=${WORKDIR}${KEY_OUTPUT}
CERTPATH=${WORKDIR}${OUTPUT}
sed -ie "s/@CN@/$CN/g" req.cnf
openssl req -newkey rsa:4096 -nodes -sha256 -keyout ${KEYPATH} -x509 -days 36500 -out ${CERTPATH} -config req.cnf
export REGISTRY_HTTP_TLS_CERTIFICATE=${CERTPATH}
export REGISTRY_HTTP_TLS_KEY=${KEYPATH}
}


case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@";;
esac

create_certificate
echo $@
exec "$@"
