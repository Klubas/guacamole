#!/bin/bash
STREAM="stable"

mkdir -p $HOME/.local/share/libvirt/images/guacamole
rm -f $HOME/.local/share/libvirt/images/guacamole/*
podman run --pull=always --rm \
    -v $HOME/.local/share/libvirt/images/guacamole/:/data \
    -w /data quay.io/coreos/coreos-installer:release download -s "${STREAM}" \
    -p qemu -f qcow2.xz \
    --decompress
