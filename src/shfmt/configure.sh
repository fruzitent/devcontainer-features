#!/bin/sh

set -ex

FEATURE_ID="shfmt"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    shfmt --version
}

stdlib_install "install_callback"
