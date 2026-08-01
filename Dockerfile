ARG TAG=1784973341-v0.16.5-12f81ee-alpine320-amd64

FROM ghcr.io/devmib/telerising-builds:${TAG}

EXPOSE 5000

VOLUME /config

ENV PUID=1000 \
    PGID=1000

ARG VERSION
LABEL VERSION="${VERSION}"

RUN set -x \
    && apk add --no-cache su-exec

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
