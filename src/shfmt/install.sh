#!/bin/sh

set -ex

FEATURE_ID="shfmt"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="shfmt_${VERSION}_linux_arm64" ;;
    x86_64) file="shfmt_${VERSION}_linux_amd64" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/mvdan/sh/releases/download/${VERSION}/${file}"
}

build_callback() {
    install -D "/tmp/${FEATURE_ID}/${file}" "./bin/shfmt"
}

stdlib_init "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
