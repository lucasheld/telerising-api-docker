FROM frolvlad/alpine-glibc

EXPOSE 5000

VOLUME /config

ENV PUID=1000 \
    PGID=1000

ARG TELERISING_API_URL="https://github.com/sunsettrack4/telerising-api/raw/main/telerising-v0.6.1_x86-64_linux.zip"

RUN set -x \
    && apk add --no-cache su-exec \
    && wget -qO- "${TELERISING_API_URL}" | busybox unzip -d / - \
    && mv /telerising /app \
    && chmod +x /app/api \
    && ln -s /app/settings.json /config/settings.json

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
