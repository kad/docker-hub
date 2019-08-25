#!/bin/bash

if [ -z "$1" ]; then
    IMG=clearlinux:latest
else
    IMG="$1"
fi

docker run -it --rm \
    --device /dev/dri/card0 \
    --device /dev/dri/renderD128 \
    --cap-add SYS_PTRACE $IMG
