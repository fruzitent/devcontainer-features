#!/bin/sh

set -ex

FEATURE_ID="node"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    node --version
}

stdlib_install "install_callback"
