#!/bin/sh

set -ex

FEATURE_ID="shellcheck"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="shellcheck-${VERSION}.linux.aarch64.tar.xz" ;;
    x86_64) file="shellcheck-${VERSION}.linux.x86_64.tar.xz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/koalaman/shellcheck/releases/download/${VERSION}/${file}"
}

build_callback() {
    mkdir --parents "./bin/"
    bsdtar --directory "./bin/" --extract --file "/tmp/${FEATURE_ID}/${file}" --strip-components 1 --verbose
}

stdlib_init "bsdtar" "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
