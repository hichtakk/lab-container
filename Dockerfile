FROM golang:1.16.3-buster as build-stage
RUN git clone -b dev https://github.com/hichtakk/whisperer.git && \
    cd whisperer && \
    go build && \
    go get github.com/pjperez/httping

FROM debian:buster-slim
COPY --from=build-stage /go/whisperer/whisperer /usr/local/bin/whisperer    
COPY --from=build-stage /go/bin/httping /usr/local/bin/httping
RUN apt update && apt install -y iputils-ping fping iproute2 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
