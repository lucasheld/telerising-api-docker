FROM frolvlad/alpine-glibc

EXPOSE 5000

VOLUME /config

ENV PUID=1000 \
    PGID=1000

ARG TELERISING_API_URL="https://github.com/sunsettrack4/telerising-api/raw/b37f4584e85ec5df9147b7f7b26c32bfdcd422b5/telerising-v0.7.1_x86-64_linux.zip"

RUN set -x \
    && apk add --no-cache su-exec \
    && wget -qO- "${TELERISING_API_URL}" | busybox unzip -d / - \
    && mv /telerising /app \
    && chmod +x /app/api

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
