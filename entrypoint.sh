#!/bin/bash
set -e

function create_certificate()
{
WORKDIR=/
KEYPATH=${WORKDIR}${KEY_OUTPUT}
CERTPATH=${WORKDIR}${OUTPUT}
openssl req -newkey rsa:4096 -nodes -sha256 -keyout ${KEYPATH} -x509 -days 36500 -out ${CERTPATH} -config req.cnf
export REGISTRY_HTTP_TLS_CERTIFICATE=${KEYPATH}
export REGISTRY_HTTP_TLS_KEY=${CERTPATH}
}


case "$!" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@";;
esac


create_certificate

exec "$@"
