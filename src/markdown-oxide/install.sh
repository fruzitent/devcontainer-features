#!/bin/sh

set -ex

FEATURE_ID="markdown-oxide"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="markdown-oxide-${VERSION}-aarch64-unknown-linux-gnu.tar.gz" ;;
    x86_64) file="markdown-oxide-${VERSION}-x86_64-unknown-linux-gnu.tar.gz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/Feel-ix-343/markdown-oxide/releases/download/${VERSION}/${file}"
}

build_callback() {
    mkdir --parents "./bin/"
    bsdtar --directory "./bin/" --extract --file "/tmp/${FEATURE_ID}/${file}" --strip-components 1 --verbose
}

stdlib_init "bsdtar" "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
