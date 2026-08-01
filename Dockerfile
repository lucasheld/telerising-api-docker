ARG TAG=1784973341-v0.16.5-12f81ee

FROM --platform=linux/amd64 ghcr.io/devmib/telerising-builds:${TAG}-alpine320-amd64 AS build-amd64
FROM --platform=linux/arm64 ghcr.io/devmib/telerising-builds:${TAG}-alpine320-aarch64 AS build-arm64

FROM build-$BUILDARCH

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
