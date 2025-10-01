#!/bin/sh

set -ex

FEATURE_ID="dockerfmt"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="dockerfmt-${VERSION}-linux-arm64.tar.gz" ;;
    x86_64) file="dockerfmt-${VERSION}-linux-amd64.tar.gz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/reteps/dockerfmt/releases/download/${VERSION}/${file}.md5"
    curl --location --remote-name "https://github.com/reteps/dockerfmt/releases/download/${VERSION}/${file}"

    echo "$(cat "./${file}.md5")  ./${file}" | md5sum --check
}

build_callback() {
    mkdir --parents "./bin/"
    bsdtar --directory "./bin/" --extract --file "/tmp/${FEATURE_ID}/${file}" --verbose
}

stdlib_init "bsdtar" "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
