#!/bin/sh

set -ex

FEATURE_ID="node"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    arch="$(uname --machine)"
    case "${arch}" in
    aarch64) file="node-${VERSION}-linux-arm64.tar.xz" ;;
    x86_64) file="node-${VERSION}-linux-x64.tar.xz" ;;
    *)
        >&2 echo "unknown arch=${arch}"
        exit 1
        ;;
    esac

    curl --location --remote-name "https://github.com/nodejs/release-keys/raw/HEAD/gpg/pubring.kbx"
    curl --location --remote-name "https://nodejs.org/dist/${VERSION}/SHASUMS256.txt.asc"
    gpgv --keyring "./pubring.kbx" --output "./SHASUMS256.txt" <"./SHASUMS256.txt.asc"

    curl --location --remote-name "https://nodejs.org/dist/${VERSION}/${file}"

    sha256sum --check "./SHASUMS256.txt" --ignore-missing
}

build_callback() {
    bsdtar --directory "./" --extract --file "/tmp/${FEATURE_ID}/${file}" --strip-components 1 --verbose
}

stdlib_init "bsdtar" "curl" "gpgv"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
