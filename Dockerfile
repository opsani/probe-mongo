# minimial apline linux with python 3.5:  ~64 MB
FROM jfloff/alpine-python:latest-slim
MAINTAINER Stephen Quintero <stephen@opsani.com>

WORKDIR /skopos

# Install curl, pymongo
USER root
RUN apk add --update curl
RUN pip install --upgrade pip && \
    pip3 install pymongo

COPY probe-mongo /skopos/
ADD probe_common /skopos/probe_common

ENTRYPOINT [ "python3", "probe-mongo" ]
