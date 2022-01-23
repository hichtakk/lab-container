FROM alpine:3.15.0
RUN apk --no-cache add net-snmp \
    && echo 'disableAuthorization yes' > /etc/snmp/snmptrapd.conf
EXPOSE      162/udp
ENTRYPOINT  [ "/usr/sbin/snmptrapd", "-L", "o", "-f" ]
