#!/bin/bash -ex

TOMCAT=$1

if [ -z "${TOMCAT+x}" ]; then
  echo build-tomcat.sh '<tomcat9|tomcat10|tomcat11>'
  exit 1
fi
TOMCAT_VERSION=$(git describe --exact-match --tags)
if [ -z "${TOMCAT_VERSION+x}" ]; then
  echo must be on git release tag
  exit 1
fi

ant deploy
# deploy tomcat9
mkdir -p ${CRAFT_PART_INSTALL}/usr/share/tomcat
cp -r output/build/* ${CRAFT_PART_INSTALL}/usr/share/tomcat
# create CATALINA_BASE
${CRAFT_PART_INSTALL}/usr/share/tomcat/bin/makebase.sh \
${CRAFT_PART_INSTALL}/var/lib/tomcat/
chown -R 584792:584792 ${CRAFT_PART_INSTALL}/var/lib/tomcat
# Write dpkg-query statement for "tomcat" package
# ii ,zlib1g:amd64,1:1.3.dfsg-3.1ubuntu2.1,zlib,1:1.3.dfsg-3.1ubuntu2.1
echo ii ,${TOMCAT}:${CRAFT_ARCH_BUILD_FOR},${TOMCAT_VERSION}-0,${TOMCAT},${TOMCAT_VERSION}-0 > ${CRAFT_STAGE}/tomcat.version
