#!/bin/sh

set -ex

FEATURE_ID="prettier"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    prettier --version
}

stdlib_install "install_callback"
