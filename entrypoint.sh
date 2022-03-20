#!/bin/sh

if [ ! -f /config/settings.json ]
then
    echo '{}' > /config/settings.json
fi
ln -s /config/settings.json /app/settings.json

chown -R ${PUID}:${PGID} /app /config

cd /app
su-exec ${PUID}:${PGID} ./api
