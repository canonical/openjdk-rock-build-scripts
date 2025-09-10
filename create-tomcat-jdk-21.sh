#!/bin/sh -ex
chisel cut --release ./ --root ${CRAFT_PART_INSTALL}/ \
  busybox_bins \
  libtcnative-1_libs \
  openjdk-21-jdk-headless_standard \
  media-types_data \
  base-files_bin \
  base-files_chisel

mkdir -p ${CRAFT_PART_INSTALL}/etc/ssl/certs/java
cp /etc/ssl/certs/java/cacerts ${CRAFT_PART_INSTALL}/etc/ssl/certs/java/cacerts
cd ${CRAFT_PART_INSTALL} && \
  ln -sf --relative \
  usr/lib/jvm/java-21-openjdk-${CRAFT_ARCH_BUILD_FOR}/bin/java \
  usr/bin/
chroot ${CRAFT_PART_INSTALL}/ /bin/busybox --install
