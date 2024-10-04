#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
rpm-ostree install docker docker-compose

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

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

git clone git@github.com:Klubas/balena-media-server.git

# echo 'PasswordAuthentication yes' | sudo tee /etc/ssh/sshd_config.d/02-enable-passwords.conf
# sudo systemctl try-restart sshd
# podman container runlabel --name cockpit-ws RUN quay.io/cockpit/ws
# podman container runlabel INSTALL quay.io/cockpit/ws