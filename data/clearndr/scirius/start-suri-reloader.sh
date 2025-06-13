#!/bin/bash

echo ${SURICATA_UNIX_SOCKET}
SURICATA_UNIX_SOCKET=${SURICATA_UNIX_SOCKET} python /code/docker/scirius/suricata/scripts/suri_reloader
if [ $? -ne 0 ]; then
    echo "Failed to start suri_reloader"
    exit 1
fi
