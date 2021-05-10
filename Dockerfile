FROM golang:1.16.3-buster as build-stage
RUN git clone -b dev https://github.com/hichtakk/whisperer.git && \
    cd whisperer && \
    go build && \
    go get github.com/pjperez/httping && \
    go get github.com/rakyll/hey && \
    go get github.com/hichtakk/testing-http-server && \
    curl -sL "https://github.com/mr-karan/doggo/releases/download/v0.3.7/doggo_0.3.7_linux_amd64.tar.gz" | tar xz && \
    mv doggo /go/bin

FROM debian:buster-slim
COPY --from=build-stage /go/whisperer/whisperer /usr/local/bin/whisperer    
COPY --from=build-stage /go/bin/httping /usr/local/bin/httping
COPY --from=build-stage /go/bin/hey /usr/local/bin/hey
COPY --from=build-stage /go/bin/doggo /usr/local/bin/doggo
COPY --from=build-stage /go/bin/testing-http-server /usr/local/bin/testing-http-server
RUN apt update && apt install -y iputils-ping fping iproute2 tcpdump dnsutils curl \
    && ln -s /usr/local/bin/doggo /usr/local/bin/dog \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
EXPOSE      8888
#USER        nobody
ENTRYPOINT  [ "/usr/local/bin/testing-http-server" ]