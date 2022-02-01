FROM alpine:3.15.0
RUN apk --no-cache add rsyslog
COPY ./rsyslog.conf /etc/rsyslog.conf
EXPOSE      514/tcp
EXPOSE      514/udp
ENTRYPOINT  ["/usr/sbin/rsyslogd", "-n"]
