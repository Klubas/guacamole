#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"

### Install docker
rpm-ostree install docker docker-compose

## Instal cockpit
rpm-ostree install cockpit-system cockpit-ostree \
                    cockpit-podman cockpit-networkmanager \
                    cockpit-files

rpm-ostree install unzip gettext nodejs make

git clone https://github.com/chabad360/cockpit-docker /tmp/cockpit-docker && \
    cd /tmp/cockpit-docker && \
    make && make install

# Enable services
systemctl enable docker.socket
systemctl enable cockpit.service 

# rpm-ostree uninstall unzip gettext nodejs make

