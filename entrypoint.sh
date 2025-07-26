#!/bin/sh

if [ ! -f /config/settings.json ]
then
    echo '{}' > /config/settings.json
fi

src_base="/config"
dst_base="/app"
find "$src_base" -type f | while read -r src_file; do
    rel_path="${src_file#$src_base/}"
    target_path="$dst_base/$rel_path"
    target_dir=$(dirname "$target_path")
    mkdir -p "$target_dir"
    rm -f "$target_path"
    ln -s "$src_file" "$target_path"
done

chown -R ${PUID}:${PGID} /app /config

cd /app
su-exec ${PUID}:${PGID} ./api
