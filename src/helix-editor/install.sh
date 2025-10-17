#!/bin/sh

set -ex

FEATURE_ID="helix-editor"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="helix-${VERSION}-aarch64-linux.tar.xz" ;;
    x86_64) file="helix-${VERSION}-x86_64-linux.tar.xz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/helix-editor/helix/releases/download/${VERSION}/${file}"
}

build_callback() {
    mkdir --parents "./bin/"
    bsdtar --directory "./bin/" --extract --file "/tmp/${FEATURE_ID}/${file}" --strip-components 1 --verbose
}

stdlib_init "bsdtar" "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
