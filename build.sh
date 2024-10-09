#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install docker
rpm-ostree install docker docker-compose

## Instal cockpit
rpm-ostree install cockpit-system cockpit-ostree \
                    cockpit-podman cockpit-networkmanager \
                    cockpit-files

# Enable services
systemctl enable docker.socket
systemctl enable cockpit.service 

rpm-ostree install make
cd /tmp && \
    wget https://github.com/chabad360/cockpit-docker/releases/download/16/cockpit-docker-16.tar.xz && \
    tar -xvf cockpit-docker-16.tar.xz && \
    cd /tmp/cockpit-docker && \
    make install

# rpm-ostree uninstall unzip gettext nodejs make

