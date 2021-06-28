#!/bin/sh

chown -R ${PUID}:${PGID} /app /config
if [ -f /config/settings.json ]
then
    ln -s /config/settings.json /app/settings.json
else
    echo "{}" > /app/settings.json
    ln -s /app/settings.json /config/settings.json
fi

cd /app
su-exec ${PUID}:${PGID} ./api
