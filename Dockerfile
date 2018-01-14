FROM registry:2

COPY entrypoint.sh /
COPY req.cnf /

ENV OUTPUT=domain.crt
ENV KEY_OUTPUT=domain.key

ENTRYPOINT ["/entrypoint.sh"]
