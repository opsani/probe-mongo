FROM alpine:latest

LABEL maintainer "Opsani <support@opsani.com>"

WORKDIR /skopos

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add --update --no-cache \
        ca-certificates \
        python3 && \
    python3 -m ensurepip && \
    pip3 install --upgrade pip && \
    pip3 install pymongo && \
    rm -rf /usr/lib/python*/ensurepip && \
    rm -rf /var/cache/apk/*

COPY probe-mongo /skopos/

ADD probe_common /skopos/probe_common

ENTRYPOINT [ "python3", "probe-mongo" ]
