# reference: https://github.com/ublue-os/image-template/blob/main/Containerfile
ARG SOURCE_IMAGE="base"
ARG SOURCE_SUFFIX="-main"
ARG SOURCE_TAG="40"

#FROM ghcr.io/ublue-os/${SOURCE_IMAGE}${SOURCE_SUFFIX}:${SOURCE_TAG}
FROM ghcr.io/ublue-os/base-main:40

COPY build.sh /tmp/build.sh
RUN mkdir -p /var/lib/alternatives && \
    /tmp/build.sh && \
    ostree container commit

