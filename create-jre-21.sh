#!/bin/sh -ex
chisel cut --release ./ --root ${CRAFT_PART_INSTALL}/ \
    busybox_bins \
    libtcnative-1_libs \
    media-types_data \
    base-files_base \
    base-files_chisel \
    libc6_libs \
    libgcc-s1_libs \
    libstdc++6_libs \
    zlib1g_libs \
    libpcsclite1_libs \
    libnss3_libs \

chroot ${CRAFT_PART_INSTALL}/ /bin/busybox --install

JAVA_HOME=usr/lib/jvm/java-21-openjdk-${CRAFT_ARCH_BUILD_FOR}
rm -rf ${CRAFT_PART_INSTALL}/${JAVA_HOME}
jlink --add-modules java.base,\
    java.compiler,\
    java.instrument,\
    java.logging,\
    java.management,\
    java.management.rmi,\
    java.naming,\
    java.net.http,\
    java.prefs,\
    java.rmi,\
    java.scripting,\
    java.se,\
    java.security.jgss,\
    java.security.sasl,\
    java.smartcardio,\
    java.sql,\
    java.sql.rowset,\
    java.transaction.xa,\
    java.xml,\
    java.xml.crypto,\
    jdk.charsets,\
    jdk.crypto.cryptoki,\
    jdk.crypto.ec,\
    jdk.dynalink,\
    jdk.httpserver,\
    jdk.internal.vm.ci,\
    jdk.internal.vm.compiler,\
    jdk.internal.vm.compiler.management,\
    jdk.jdwp.agent,\
    jdk.jfr,\
    jdk.jsobject,\
    jdk.localedata,\
    jdk.management,\
    jdk.management.agent,\
    jdk.management.jfr,\
    jdk.naming.dns,\
    jdk.naming.rmi,\
    jdk.net,\
    jdk.nio.mapmode,\
    jdk.sctp,\
    jdk.security.auth,\
    jdk.security.jgss,\
    jdk.unsupported,\
    jdk.xml.dom,\
    jdk.zipfs --no-header-files --no-man-pages -G \
    --output ${CRAFT_PART_INSTALL}/${JAVA_HOME}

cd ${CRAFT_PART_INSTALL}
mkdir -p usr/bin
for tool in java jfr jrunscript jwebserver keytool rmiregistry; do
    ln -s --relative ${JAVA_HOME}/bin/${tool} usr/bin/
done
