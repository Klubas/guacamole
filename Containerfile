# generate ignition file
#FROM quay.io/coreos/butane AS butane
#ADD data/ /data
#ADD config.bu /
#RUN butane --pretty --strict --files-dir /data \
#    config.bu > ignition.ign


FROM quay.io/fedora/fedora-coreos:stable

### Install docker
RUN rpm-ostree install \
        docker \
        docker-compose \
        cockpit \
        cockpit-system \
        cockpit-ostree \
        cockpit-podman \
        cockpit-networkmanager \
        cockpit-files && \
    ostree container commit

# Enable services
RUN systemctl enable docker.socket  && ostree container commit
RUN systemctl enable cockpit.socket && ostree container commit

### Install cockpit-docker
WORKDIR /usr/local/share/cockpit/docker/
WORKDIR /usr/local/share/metainfo/
WORKDIR /tmp
RUN rpm-ostree install wget gettext && \
        wget https://github.com/chabad360/cockpit-docker/releases/download/16/cockpit-docker-16.tar.xz && \
        tar -xvf cockpit-docker-16.tar.xz && \
        rm cockpit-docker-16.tar.xz && \
        cd /tmp/cockpit-docker && \
        cp -r dist/* /usr/local/share/cockpit/docker && \
        msgfmt --xml -d po \
            --template me.chabad360.docker.metainfo.xml \
            -o /usr/local/share/metainfo/me.chabad360.docker.metainfo.xml && \
    ostree container commit

WORKDIR /
# enable autoupdate
ADD data/usr usr
RUN systemctl mask zincati && ostree container commit

# inject ignition file
#COPY --from=butane /ignition.ign ignition.ign
#RUN /usr/libexec/ignition-apply ignition.ign && rm -f ignition.ign && ostree container commit