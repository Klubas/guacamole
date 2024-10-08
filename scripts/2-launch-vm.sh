#!/bin/bash
IGNITION_CONFIG="$HOME/dev/guacamole/scripts/ignition.ign"
IMAGE="$HOME/.local/share/libvirt/images/guacamole/fedora-coreos-40.20240906.3.0-qemu.x86_64.qcow2"
VM_NAME="guacamole-01"
VCPUS="4"
RAM_MB="4096"
STREAM="stable"
DISK_GB="20"
# For x86 / aarch64,
IGNITION_DEVICE_ARG=(--qemu-commandline="-fw_cfg name=opt/com.coreos/config,file=${IGNITION_CONFIG}")

# For s390x / ppc64le,
# IGNITION_DEVICE_ARG=(--disk path="${IGNITION_CONFIG}",format=raw,readonly=on,serial=ignition,startup_policy=optional)

# Setup the correct SELinux label to allow access to the config
sudo chcon --verbose --type svirt_home_t ${IGNITION_CONFIG}

sudo virt-install --connect="qemu:///system" --name="${VM_NAME}" --vcpus="${VCPUS}" --memory="${RAM_MB}" \
        --os-variant="fedora-coreos-$STREAM" --import --graphics=none \
        --disk="size=${DISK_GB},backing_store=${IMAGE}" \
        --network bridge=virbr0 "${IGNITION_DEVICE_ARG[@]}"