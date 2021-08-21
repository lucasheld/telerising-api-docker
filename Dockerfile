FROM frolvlad/alpine-glibc

EXPOSE 5000

VOLUME /config

ENV PUID=1000 \
    PGID=1000

ARG TELERISING_API_URL="https://github.com/sunsettrack4/telerising-api/raw/a8463d8250f75e1194f8fb1c9731dc88cc1d3905/telerising-v0.6.5_x86-64_linux.zip"

RUN set -x \
    && apk add --no-cache su-exec \
    && wget -qO- "${TELERISING_API_URL}" | busybox unzip -d / - \
    && mv /telerising /app \
    && chmod +x /app/api

COPY entrypoint.sh /

ENTRYPOINT [ "/entrypoint.sh" ]
