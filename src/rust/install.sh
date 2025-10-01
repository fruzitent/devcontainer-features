#!/bin/sh

set -ex

FEATURE_ID="taplo"
VERSION="${VERSION:?}"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

configure_callback() {
    curl --location --remote-name "https://raw.githubusercontent.com/rust-lang/rustup/refs/tags/${VERSION}/rustup-init.sh"
}

build_callback() {
    sh "/tmp/${FEATURE_ID}/rustup-init.sh" -y --no-modify-path --no-update-default-toolchain
}

stdlib_init "curl"
stdlib_configure "configure_callback"
stdlib_build "build_callback"
