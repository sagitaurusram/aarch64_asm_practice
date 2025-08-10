FROM ubuntu:22.04
RUN apt-get update && apt-get install -y \
    gcc-aarch64-linux-gnu \
    binutils-aarch64-linux-gnu \
    qemu-user \
    gdb-multiarch \
    make \
    vim \
    build-essential \
    && apt-get clean
