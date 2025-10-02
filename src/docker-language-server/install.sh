#!/bin/sh

set -ex

FEATURE_ID="docker-language-server"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="docker-language-server-linux-arm64-${VERSION}" ;;
    x86_64) file="docker-language-server-linux-amd64-${VERSION}" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/docker/docker-language-server/releases/download/${VERSION}/${file}"
}

build_callback() {
    install -D "/tmp/${FEATURE_ID}/${file}" "./bin/docker-language-server"
}

stdlib_init "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
