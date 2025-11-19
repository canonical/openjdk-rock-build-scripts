#!/bin/bash -ex
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

JAVA_HOME=usr/lib/jvm/java-17-openjdk-${CRAFT_ARCH_BUILD_FOR}
rm -rf ${CRAFT_PART_INSTALL}/${JAVA_HOME}
jlink --no-header-files --no-man-pages --strip-debug \
    --add-modules \
java.base,java.datatransfer,java.desktop,java.instrument,\
java.logging,java.management,java.management.rmi,java.naming,\
java.prefs,java.rmi,java.security.sasl,java.xml,jdk.incubator.foreign,\
jdk.incubator.vector,jdk.internal.vm.ci,jdk.jfr,jdk.management,\
jdk.management.jfr,jdk.management.agent,jdk.net,jdk.nio.mapmode,\
jdk.sctp,jdk.unsupported,jdk.naming.rmi,java.se,java.net.http,\
java.scripting,java.security.jgss,java.smartcardio,java.sql,\
java.sql.rowset,java.transaction.xa,java.xml.crypto,jdk.accessibility,\
jdk.charsets,jdk.crypto.cryptoki,jdk.crypto.ec,jdk.dynalink,jdk.httpserver,\
jdk.jsobject,jdk.localedata,jdk.naming.dns,jdk.security.auth,\
jdk.security.jgss,jdk.xml.dom,jdk.zipfs,java.compiler,\
jdk.internal.vm.compiler,jdk.internal.vm.compiler.management,\
jdk.jdwp.agent \
    --output ${CRAFT_PART_INSTALL}/${JAVA_HOME}


cd ${CRAFT_PART_INSTALL}
mkdir -p usr/bin
for tool in java jfr jrunscript jwebserver keytool rmiregistry; do
    /usr/bin/ln -s --relative ${JAVA_HOME}/bin/${tool} usr/bin/
done

chroot ${CRAFT_PART_INSTALL}/ /bin/busybox --install
