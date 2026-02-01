ARG TOOLCHAIN
ARG CONAN_ARCH
ARG DEBIAN_ARCH

FROM debian:trixie-slim
ENV DEBIAN_FRONTEND=noninteractive
ENV LC_ALL=C.utf8

RUN apt-get update
RUN apt-get install -y --no-install-recommends build-essential cmake 
ARG TOOLCHAIN
ARG DEBIAN_ARCH
RUN apt-get install -y --no-install-recommends gcc-${TOOLCHAIN} g++-${TOOLCHAIN} libc6-dev-${DEBIAN_ARCH}-cross linux-libc-dev-${DEBIAN_ARCH}-cross
RUN apt-get install -y --no-install-recommends python3 python3-dev python3-pip python3-venv pkg-config
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

ENV PATH="$PATH:/root/.local/bin"
RUN pip install conan --break-system-packages
RUN conan profile detect

RUN sed -i 's/^compiler\.cppstd=.*/compiler.cppstd=23/' /root/.conan2/profiles/default

ENV TARGET_PROFILE=/root/.conan2/profiles/target
ARG CONAN_ARCH
RUN sed "s/^arch\=.*/arch=${CONAN_ARCH}/" /root/.conan2/profiles/default > ${TARGET_PROFILE}
RUN echo "[buildenv]" >> ${TARGET_PROFILE}
RUN echo "CC=${TOOLCHAIN}-gcc" >> ${TARGET_PROFILE}
RUN echo "CXX=${TOOLCHAIN}-g++" >> ${TARGET_PROFILE}
RUN echo "LD=${TOOLCHAIN}-ld" >> ${TARGET_PROFILE}
RUN echo "core:default_profile=target" >> /root/.conan2/global.conf
RUN echo "core:default_build_profile=default" >> /root/.conan2/global.conf
