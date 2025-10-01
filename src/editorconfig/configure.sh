#!/bin/sh

set -ex

FEATURE_ID="editorconfig"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    editorconfig --version
}

stdlib_install "install_callback"
