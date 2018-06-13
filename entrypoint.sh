#!/bin/sh
echo $@
set -e

check_ip()
{
    IP=$1
    VALID_CHECK=$(echo $IP|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}')
    if echo $IP|grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$">/dev/null; then
        if [ ${VALID_CHECK:-no} == "yes" ]; then
            echo "IP $IP available."
            return 0
        else
            echo "IP $IP not available!"
            return 1
        fi
    else
        echo "IP format error!"
        return 1
    fi
}

create_certificate()
{
WORKDIR=/
KEYPATH=${WORKDIR}${KEY_OUTPUT}
CERTPATH=${WORKDIR}${OUTPUT}
sed -ie "s/@CN@/$CN/g" req.cnf
check_ip $CN
if [ $? -eq 0 ]; then
    openssl req -newkey rsa:4096 -nodes -sha256 -keyout ${KEYPATH} -x509 -days 36500 -out ${CERTPATH} -config req.cnf -extensions v3_ca
else
    openssl req -newkey rsa:4096 -nodes -sha256 -keyout ${KEYPATH} -x509 -days 36500 -out ${CERTPATH} -config req.cnf
fi
export REGISTRY_HTTP_TLS_CERTIFICATE=${CERTPATH}
export REGISTRY_HTTP_TLS_KEY=${KEYPATH}

if [ -d $DIRECTORY ]; then
    cp -f $KEYPATH $DIRECTORY/$KEY_OUTPUT
    cp -f $CERTPATH $DIRECTORY/$OUTPUT
fi
}


case "$1" in
    *.yaml|*.yml) set -- registry serve "$@" ;;
    serve|garbage-collect|help|-*) set -- registry "$@";;
esac

create_certificate
echo $@
exec "$@"
