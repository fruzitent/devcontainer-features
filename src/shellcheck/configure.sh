#!/bin/sh

set -ex

FEATURE_ID="shellcheck"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    shellcheck --version
}

stdlib_install "install_callback"
