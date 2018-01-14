FROM registry:2

COPY entrypoint.sh /
COPY req.cnf /

RUN apk add --no-cache openssl

ENV OUTPUT=domain.crt
ENV KEY_OUTPUT=domain.key
ENV CN=localhost

ENTRYPOINT ["/entrypoint.sh"]
CMD ["serve", "/etc/docker/registry/config.yml"]
