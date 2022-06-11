FROM frolvlad/alpine-glibc:alpine-3.14

EXPOSE 5000

VOLUME /config

ENV PUID=1000 \
    PGID=1000

ARG TELERISING_API_URL="https://github.com/sunsettrack4/telerising-api/raw/7cac3ff25d6a1be5ed2f6e0f72f21c9e4aacb94b/telerising-v0.7.6_x86-64_linux.zip"

RUN set -x \
    && apk add --no-cache su-exec \
    && wget -qO- "${TELERISING_API_URL}" | busybox unzip -d / - \
    && mv /telerising /app \
    && chmod +x /app/api

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
