#!/bin/sh

set -ex

FEATURE_ID="dockerfile-language-server"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    true
}

stdlib_install "install_callback"
