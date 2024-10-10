FROM quay.io/fedora/fedora-coreos:stable

### Install cockpit
RUN rpm-ostree install \
        podman-compose \
        cockpit \
        cockpit-system \
        cockpit-ostree \
        cockpit-podman \
        cockpit-networkmanager \
        cockpit-files && \
    ostree container commit

RUN echo 'PasswordAuthentication yes' | tee /etc/ssh/sshd_config.d/02-enable-passwords.conf && \
    ostree container commit

RUN systemctl enable cockpit.socket && \
    ostree container commit

# Enable autoupdate
WORKDIR /
ADD data/usr usr
RUN systemctl mask zincati && ostree container commit
