FROM frolvlad/alpine-glibc:glibc-2.41

EXPOSE 5000

VOLUME /config

ENV PUID=1000 \
    PGID=1000

ARG VERSION
LABEL VERSION="${VERSION}"

ARG TELERISING_API_URL

RUN set -x \
    && apk add --no-cache su-exec libstdc++ tzdata \
    && apk add --no-cache --virtual build-dependencies jq libarchive-tools \
    && if [ -z ${TELERISING_API_URL} ]; then \
        TELERISING_API_URL=$(wget -qO- https://api.github.com/repos/sunsettrack4/telerising-api/releases/latest | jq -r '.assets[] | select(.name | match("^telerising-v.+_x86-64_linux.zip$")).browser_download_url'); \
    fi \
    && wget -qO- "${TELERISING_API_URL}" | bsdtar -xvf - -C / \
    && mv /telerising /app \
    && chmod +x /app/api \
    && apk del build-dependencies

ADD --chmod=644 https://data.iana.org/time-zones/tzdb/tzdata.zi /usr/share/zoneinfo/tzdata.zi

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
