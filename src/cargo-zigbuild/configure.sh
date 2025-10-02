#!/bin/sh

set -ex

FEATURE_ID="cargo-zigbuild"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    cargo-zigbuild --version

    mkdir --parents "/opt/rust/cargo/bin/"
    ln --symbolic "$PWD/bin/cargo-zigbuild" "/opt/rust/cargo/bin/cargo-zigbuild"
}

stdlib_install "install_callback"
