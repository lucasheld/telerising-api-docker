FROM frolvlad/alpine-glibc:alpine-3.14

EXPOSE 5000

VOLUME /config

ENV PUID=1000 \
    PGID=1000

ARG VERSION
LABEL VERSION="${VERSION}"

ARG TELERISING_API_URL

RUN set -x \
    && apk add --no-cache su-exec \
    && apk add --no-cache --virtual build-dependencies jq \
    && if [ -z ${TELERISING_API_URL} ]; then \
        TELERISING_API_URL=$(wget -qO- https://api.github.com/repos/sunsettrack4/telerising-api/contents | jq -r '[.[]|select(.name|match("^telerising-v.+_x86-64_linux.zip$"))][0].download_url'); \
    fi \
    && wget -qO- "${TELERISING_API_URL}" | busybox unzip -d / - \
    && mv /telerising /app \
    && chmod +x /app/api \
    && apk del build-dependencies

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
