#!/bin/sh

set -ex

FEATURE_ID="cargo-zigbuild"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="cargo-zigbuild-${VERSION}.aarch64-unknown-linux-musl.tar.gz" ;;
    x86_64) file="cargo-zigbuild-${VERSION}.x86_64-unknown-linux-musl.tar.gz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/rust-cross/cargo-zigbuild/releases/download/${VERSION}/${file}"
    curl --location --remote-name "https://github.com/rust-cross/cargo-zigbuild/releases/download/${VERSION}/${file}.sha256"
    sha256sum --check "./${file}.sha256"
}

build_callback() {
    mkdir --parents "./bin/"
    bsdtar --directory "./bin/" --extract --file "/tmp/${FEATURE_ID}/${file}" --verbose
}

stdlib_init "bsdtar" "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
