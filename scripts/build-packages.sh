#!/usr/bin/env bash

download_packages() {
    echo "Start Downloading Packages..."
    if [ ! -e "fscrypt_0.3.3-1.dsc" ]; then
        curl -O http://archive.ubuntu.com/ubuntu/pool/universe/f/fscrypt/fscrypt_0.3.3-1.dsc
    fi
    if [ ! -e "fscrypt_0.3.3.orig.tar.xz" ]; then
        curl -O http://archive.ubuntu.com/ubuntu/pool/universe/f/fscrypt/fscrypt_0.3.3.orig.tar.xz
    fi
    if [ ! -e "fscrypt_0.3.3-1.debian.tar.xz" ]; then
        curl -O http://archive.ubuntu.com/ubuntu/pool/universe/f/fscrypt/fscrypt_0.3.3-1.debian.tar.xz
    fi
    echo "Packages Downloaded."
}

extract_sources() {
    echo "Start Extracting Sources..."
    if [ -d "fscrypt-0.3.3" ]; then
        rm -rf fscrypt-0.3.3/
    fi
    gpg --no-default-keyring --keyring ~/.gnupg/trustedkeys.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561AD585EED766921BA8DD96D65861883E014DB9
    dpkg-source -x --require-valid-signature fscrypt_0.3.3-1.dsc
    if [ $? -ne 0 ]; then
        echo "Failed to Extract Sources."
        return 1
    fi
    echo "Sources Extracted."
}

apply_patches() {
    echo "Start Applying Patches..."
    patch -p0 < patch/debhelper-compat-12.patch
    if [ $? -ne 0 ]; then
        echo "Failed to Apply Patch."
        return 1
    fi
    echo "Patches Applied."
}

build_packages() {
    echo "Start Building Packages..."
    pushd fscrypt-0.3.3
    go mod vendor
    dpkg-buildpackage -us -uc -b
    if [ $? -ne 0 ]; then
        echo "Failed to Build Packages."
        return 1
    fi
    popd
    echo "Packages Built."
}

main() {
    download_packages      \
        && extract_sources \
        && apply_patches   \
        && build_packages
    return $?
}

main
