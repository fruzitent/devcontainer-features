#!/bin/sh

set -ex

FEATURE_ID="taplo"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="taplo-linux-aarch64.gz" ;;
    x86_64) file="taplo-linux-x86_64.gz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/tamasfe/taplo/releases/download/${VERSION}/${file}"
}

build_callback() {
    zcat "/tmp/${FEATURE_ID}/${file}" | install -D "/dev/stdin" "./bin/taplo"
}

stdlib_init "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
