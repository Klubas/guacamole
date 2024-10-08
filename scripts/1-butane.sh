#!/bin/bash
podman run \
       --interactive --rm --security-opt label=disable \
       --volume ${PWD}:/pwd \
       --volume ${HOME}/dev/guacamole/guacamole-scripts:/guacamole-scripts \
       --workdir /pwd quay.io/coreos/butane:release \
       --files-dir /guacamole-scripts \
       --pretty --strict \
       config.bu > ignition.ign