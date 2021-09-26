#!/bin/sh

if [ -f /config/settings.json ]
then
    ln -s /config/settings.json /app/settings.json
else
    echo '{}' > /config/settings.json
    ln -s /config/settings.json /app/settings.json
fi

chown -R ${PUID}:${PGID} /app /config

cd /app
su-exec ${PUID}:${PGID} ./api
