#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install packages
rpm-ostree install docker docker-compose

systemctl enable podman.socket
systemctl enable docker.socket

## Instal cockpit
rpm-ostree install cockpit-system cockpit-ostree \
                    cockpit-podman cockpit-networkmanager \
                    cockpit-files


curl -O https://codeload.github.com/chabad360/cockpit-docker/zip/refs/heads/main && \
    unzip main && \
    cd cockpit-docker && \
    make && \
    make install

systemctl enable cockpit.service 
