FROM debian:bullseye-slim
RUN apt update && apt install -y snmptrapd \
    && echo 'disableAuthorization yes' > /etc/snmp/snmptrapd.conf \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
EXPOSE      162/udp
ENTRYPOINT  [ "/usr/sbin/snmptrapd", "-L", "o", "-f" ]
