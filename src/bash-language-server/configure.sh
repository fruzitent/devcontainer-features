#!/bin/sh

set -ex

FEATURE_ID="bash-language-server"

# shellcheck source=./_stdlib.sh
. "$(dirname "$(realpath "${0}")")/_stdlib.sh"

install_callback() {
    bash-language-server --version
}

stdlib_install "install_callback"
